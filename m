Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUHYTR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUHYTR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUHYTR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:17:27 -0400
Received: from [195.23.16.24] ([195.23.16.24]:436 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268308AbUHYTJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:09:41 -0400
Message-ID: <412CE3ED.5000803@grupopie.com>
Date: Wed, 25 Aug 2004 20:09:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org>
In-Reply-To: <20040825185854.GP31237@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.29; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> ...
> 
> FYI, killing the seq_file stuff will likely prove unpopular. So you'll
> want to do that in a separate patch. If it doesn't affect the way
> you're handling compression, please repost your compression patch. I
> have a few comments, but otherwise I think we should move forward with it.

I'm still not sure that the seq_file is the culprit, but doing
a 10000 symbol decompression in a user space application takes
about 340us, whereas doing a "time cat /proc/kallsyms > /dev/null"
gives approx. 0.2s! (this is all on a Pentium4 2.8GHz)

*If* the seq_file is the culprit, then I don't think removing
it (or improving it) will be unpopular.

Anyway, it doesn't affect the compression at all, so here is an
inline version of the patch for your reading/patching pleasure :)

-- 
Paulo Marques - www.grupopie.com


Signed-off-by: Paulo Marques <pmarques@grupopie.com>

  kernel/kallsyms.c  |  143 +++++++++++------
  scripts/kallsyms.c |  432 ++++++++++++++++++++++++++++++++++++++++++++++++++---
  2 files changed, 499 insertions(+), 76 deletions(-)

diff -uprN -X dontdiff linux-2.6.9-rc1/kernel/kallsyms.c linux-2.6.9-rc1-kall/kernel/kallsyms.c
--- linux-2.6.9-rc1/kernel/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
+++ linux-2.6.9-rc1-kall/kernel/kallsyms.c	2004-08-25 03:59:27.000000000 +0100
@@ -5,6 +5,12 @@
   * module loader:
   *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
   * Stem compression by Andi Kleen.
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression
   */
  #include <linux/kallsyms.h>
  #include <linux/module.h>
@@ -17,7 +23,12 @@
  /* These will be re-linked against their real values during the second link stage */
  extern unsigned long kallsyms_addresses[] __attribute__((weak));
  extern unsigned long kallsyms_num_syms __attribute__((weak));
-extern char kallsyms_names[] __attribute__((weak));
+extern u8 kallsyms_names[] __attribute__((weak));
+
+extern u8 kallsyms_token_table[] __attribute__((weak));
+extern u16 kallsyms_token_index[] __attribute__((weak));
+
+extern unsigned long kallsyms_markers[] __attribute__((weak));

  /* Defined by the linker script. */
  extern char _stext[], _etext[], _sinittext[], _einittext[];
@@ -37,21 +48,56 @@ static inline int is_kernel_text(unsigne
  	return 0;
  }

+static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
+{
+	int len, tlen;
+	u8 *tptr, *data;
+
+	data = &kallsyms_names[off];
+	
+	len=*data++;
+	off += len + 1;
+	while(len) {
+		tptr=&kallsyms_token_table[kallsyms_token_index[*data]];
+		data++;
+		len--;
+
+		tlen=*tptr++;
+		while(tlen) {
+			*result++=*tptr++;
+			tlen--;
+		}
+	}
+
+	*result = 0;
+
+	return off;
+}
+
+static unsigned int get_symbol_offset(unsigned long pos)
+{
+	u8 *name;
+	int i;
+
+	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
+	for(i = 0; i < (pos&0xFF); i++)
+		name = name + (*name) + 1;
+
+	return name - kallsyms_names;
+}
+
  /* Lookup the address for this symbol. Returns 0 if not found. */
  unsigned long kallsyms_lookup_name(const char *name)
  {
  	char namebuf[KSYM_NAME_LEN+1];
  	unsigned long i;
-	char *knames;
+	unsigned int off;

-	for (i = 0, knames = kallsyms_names; i < kallsyms_num_syms; i++) {
-		unsigned prefix = *knames++;
+	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
+		off = kallsyms_expand_symbol(off, namebuf);

-		strlcpy(namebuf + prefix, knames, KSYM_NAME_LEN - prefix);
  		if (strcmp(namebuf, name) == 0)
  			return kallsyms_addresses[i];
-
-		knames += strlen(knames) + 1;
  	}
  	return module_kallsyms_lookup_name(name);
  }
@@ -62,7 +108,7 @@ const char *kallsyms_lookup(unsigned lon
  			    unsigned long *offset,
  			    char **modname, char *namebuf)
  {
-	unsigned long i, best = 0;
+	unsigned long i, low, high, mid;

  	/* This kernel should never had been booted. */
  	BUG_ON(!kallsyms_addresses);
@@ -71,40 +117,41 @@ const char *kallsyms_lookup(unsigned lon
  	namebuf[0] = 0;

  	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
-		unsigned long symbol_end;
-		char *name = kallsyms_names;
+		unsigned long symbol_end=0;

-		/* They're sorted, we could be clever here, but who cares? */
-		for (i = 0; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
-			    kallsyms_addresses[i] <= addr)
-				best = i;
+		/* do a binary search on the sorted kallsyms_addresses array */
+		low = 0;
+		high = kallsyms_num_syms;
+		while (high-low > 1) {
+			mid = (low + high) / 2;
+			if (kallsyms_addresses[mid] <= addr) low = mid;
+			else high = mid;
  		}
+		while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low])
+			--low;

  		/* Grab name */
-		for (i = 0; i <= best; i++) {
-			unsigned prefix = *name++;
-			strncpy(namebuf + prefix, name, KSYM_NAME_LEN - prefix);
-			name += strlen(name) + 1;
-		}
-
-		/* At worst, symbol ends at end of section. */
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else
-			symbol_end = (unsigned long)_etext;
+		kallsyms_expand_symbol(get_symbol_offset(low), namebuf);

  		/* Search for next non-aliased symbol */
-		for (i = best+1; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best]) {
+		for (i = low + 1; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] > kallsyms_addresses[low]) {
  				symbol_end = kallsyms_addresses[i];
  				break;
  			}
  		}

-		*symbolsize = symbol_end - kallsyms_addresses[best];
+		if (!symbol_end) {
+			/* At worst, symbol ends at end of section. */
+			if (is_kernel_inittext(addr))
+				symbol_end = (unsigned long)_einittext;
+			else
+				symbol_end = (unsigned long)_etext;
+		}
+
+		*symbolsize = symbol_end - kallsyms_addresses[low];
  		*modname = NULL;
-		*offset = addr - kallsyms_addresses[best];
+		*offset = addr - kallsyms_addresses[low];
  		return namebuf;
  	}

@@ -168,15 +215,10 @@ static int get_ksymbol_mod(struct kallsy
  /* Returns space to next name. */
  static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
  {
-	unsigned stemlen, off = iter->nameoff;
+	unsigned off = iter->nameoff;
+
+	off = kallsyms_expand_symbol(off, iter->name);

-	/* First char of each symbol name indicates prefix length
-	   shared with previous name (stem compression). */
-	stemlen = kallsyms_names[off++];
-
-	strlcpy(iter->name+stemlen, kallsyms_names + off,
-		KSYM_NAME_LEN+1-stemlen);
-	off += strlen(kallsyms_names + off) + 1;
  	iter->owner = NULL;
  	iter->value = kallsyms_addresses[iter->pos];
  	if (is_kernel_text(iter->value) || is_kernel_inittext(iter->value))
@@ -188,11 +230,11 @@ static unsigned long get_ksymbol_core(st
  	return off - iter->nameoff;
  }

-static void reset_iter(struct kallsym_iter *iter)
+static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
  {
  	iter->name[0] = '\0';
-	iter->nameoff = 0;
-	iter->pos = 0;
+	iter->nameoff = get_symbol_offset(new_pos);
+	iter->pos = new_pos;
  }

  /* Returns false if pos at or past end of file. */
@@ -204,16 +246,13 @@ static int update_iter(struct kallsym_it
  		return get_ksymbol_mod(iter);
  	}
  	
-	/* If we're past the desired position, reset to start. */
-	if (pos < iter->pos)
-		reset_iter(iter);
-
-	/* We need to iterate through the previous symbols: can be slow */
-	for (; iter->pos != pos; iter->pos++) {
-		iter->nameoff += get_ksymbol_core(iter);
-		cond_resched();
-	}
-	get_ksymbol_core(iter);
+	/* If we're not on the desired position, reset to new position. */
+	if (pos != iter->pos)
+		reset_iter(iter, pos);
+
+	iter->nameoff += get_ksymbol_core(iter);
+	iter->pos++;
+
  	return 1;
  }

@@ -274,7 +313,7 @@ static int kallsyms_open(struct inode *i
  	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
  	if (!iter)
  		return -ENOMEM;
-	reset_iter(iter);
+	reset_iter(iter, 0);

  	ret = seq_open(file, &kallsyms_op);
  	if (ret == 0)
diff -uprN -X dontdiff linux-2.6.9-rc1/scripts/kallsyms.c linux-2.6.9-rc1-kall/scripts/kallsyms.c
--- linux-2.6.9-rc1/scripts/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
+++ linux-2.6.9-rc1-kall/scripts/kallsyms.c	2004-08-25 03:30:30.000000000 +0100
@@ -6,6 +6,13 @@
   * of the GNU General Public License, incorporated herein by reference.
   *
   * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression
+ *
   */

  #include <stdio.h>
@@ -13,10 +20,30 @@
  #include <string.h>
  #include <ctype.h>

+/* compression tunning settings */
+#define MAX_TOK_SIZE		11
+#define KSYM_NAME_LEN		127
+
+/* we use only a subset of the complete symbol table to gather the token count,
+   to speed up compression, at the expense of a little compression ratio
+*/
+#define WORKING_SET		1024
+#define GOOD_BAD_THRESHOLD	10
+
+#define HASH_BITS		18
+#define HASH_TABLE_SIZE		(1 << HASH_BITS)
+#define HASH_MASK		(HASH_TABLE_SIZE - 1)
+#define HASH_BASE_OFFSET	2166136261U
+#define HASH_FOLD(a)		((a)&(HASH_MASK))
+
+
  struct sym_entry {
  	unsigned long long addr;
  	char type;
-	char *sym;
+	char sample;
+	char valid;
+	unsigned char len;
+	unsigned char *sym;
  };


@@ -25,6 +52,24 @@ static int size, cnt;
  static unsigned long long _stext, _etext, _sinittext, _einittext;
  static int all_symbols = 0;

+
+struct token {
+	unsigned char data[MAX_TOK_SIZE];
+	unsigned char len;
+	int profit;
+	struct token *next;
+	struct token *right;
+	struct token *left;
+	struct token *smaller;
+	};
+
+struct token bad_head, good_head;
+struct token *hash_table[HASH_TABLE_SIZE];
+
+unsigned char best_table[256][MAX_TOK_SIZE+1];
+unsigned char best_table_len[256];
+
+
  static void
  usage(void)
  {
@@ -60,6 +105,7 @@ read_symbol(FILE *in, struct sym_entry *
  		return -1;

  	s->sym = strdup(str);
+	s->len = strlen(str);
  	return 0;
  }

@@ -108,11 +154,42 @@ read_map(FILE *in)
  	}
  }

+static void output_label(char *label)
+{
+	printf(".globl %s\n",label);
+	printf("\tALGN\n");
+	printf("%s:\n",label);
+}
+
+static int expand_symbol(unsigned char *data, int len, char *result)
+{
+	int c, rlen, total=0;
+
+	while (len) {
+		c = *data;
+		if (best_table[c][0]==c && best_table_len[c]==1) {
+			*result++ = c;
+			total++;
+		} else {
+			rlen = expand_symbol(best_table[c], best_table_len[c], result);
+			total += rlen;
+			result += rlen;
+		}
+		data++;
+		len--;
+	}
+	*result=0;
+
+	return total;
+}
+
  static void
  write_src(void)
  {
-	int i, valid = 0;
-	char *prev;
+	int i, k, off, valid;
+	unsigned int best_idx[256];
+	unsigned int *markers;
+	char buf[KSYM_NAME_LEN+1];

  	printf("#include <asm/types.h>\n");
  	printf("#if BITS_PER_LONG == 64\n");
@@ -125,43 +202,349 @@ write_src(void)

  	printf(".data\n");

-	printf(".globl kallsyms_addresses\n");
-	printf("\tALGN\n");
-	printf("kallsyms_addresses:\n");
+	output_label("kallsyms_addresses");
+	valid = 0;
  	for (i = 0; i < cnt; i++) {
-		if (!symbol_valid(&table[i]))
-			continue;
-
-		printf("\tPTR\t%#llx\n", table[i].addr);
-		valid++;
+		if (table[i].valid) {
+			printf("\tPTR\t%#llx\n", table[i].addr);
+			valid++;
+		}
  	}
  	printf("\n");

-	printf(".globl kallsyms_num_syms\n");
-	printf("\tALGN\n");
-	printf("kallsyms_num_syms:\n");
+	output_label("kallsyms_num_syms");
  	printf("\tPTR\t%d\n", valid);
  	printf("\n");

-	printf(".globl kallsyms_names\n");
-	printf("\tALGN\n");
-	printf("kallsyms_names:\n");
-	prev = "";
+	markers = (unsigned int *) malloc(sizeof(unsigned int)*((valid + 255) / 256));
+	
+	output_label("kallsyms_names");
+	valid = 0;
+	off = 0;
  	for (i = 0; i < cnt; i++) {
-		int k;

-		if (!symbol_valid(&table[i]))
+		if (!table[i].valid)
  			continue;

-		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
-			;
+		if ((valid & 0xFF) == 0)
+			markers[valid >> 8] = off;
+
+		printf("\t.byte 0x%02x", table[i].len);
+		for (k = 0; k < table[i].len; k++)
+			printf(", 0x%02x", table[i].sym[k]);
+		printf("\n");

-		printf("\t.byte 0x%02x\n\t.asciz\t\"%s\"\n", k, table[i].sym + k);
-		prev = table[i].sym;
+		off += table[i].len + 1;
+		valid++;
  	}
  	printf("\n");
+
+	output_label("kallsyms_markers");
+	for (i = 0; i < ((valid + 255) >> 8); i++)
+		printf("\tPTR\t%d\n", markers[i]);
+	printf("\n");
+
+	output_label("kallsyms_token_table");
+	off = 0;
+	for (i = 0; i < 256; i++) {
+		best_idx[i] = off;
+		expand_symbol(best_table[i],best_table_len[i],buf);
+		k = strlen(buf);
+		printf("\t.byte 0x%02x\n\t.ascii\t\"%s\"\n", k, buf);
+		off += k + 1;
+	}
+	printf("\n");
+
+	output_label("kallsyms_token_index");
+	for (i = 0; i < 256; i++)
+		printf("\t.word\t%d\n", best_idx[i]);
+	printf("\n");
+}
+
+
+/* table lookup compression functions */
+
+static inline unsigned int rehash_token(unsigned int hash, unsigned char data)
+{
+	return ((hash * 16777619) ^ data);
+}
+
+static unsigned int hash_token(unsigned char *data, int len)
+{
+	unsigned int hash=HASH_BASE_OFFSET;
+	int i;
+
+	for (i = 0; i < len; i++)
+		hash = rehash_token(hash, data[i]);
+
+	return HASH_FOLD(hash);
+}
+
+static struct token *find_token_hash(unsigned char *data, int len, unsigned int hash)
+{
+	struct token *ptr;
+
+	ptr = hash_table[hash];
+
+	while (ptr) {
+		if ((ptr->len == len) && (memcmp(ptr->data, data, len) == 0))
+			return ptr;
+		ptr=ptr->next;
+	}
+
+	return NULL;
  }

+static inline void insert_token_in_group(struct token *head, struct token *ptr)
+{
+	ptr->right = head->right;
+	ptr->right->left = ptr;
+	head->right = ptr;
+	ptr->left = head;
+}
+
+static inline void remove_token_from_group(struct token *ptr)
+{
+	ptr->left->right = ptr->right;
+	ptr->right->left = ptr->left;
+}
+
+static void learn_token(unsigned char *data, int len)
+{
+	struct token *ptr,*last_ptr;
+	int i, newprofit;
+	unsigned int hash = HASH_BASE_OFFSET;
+	unsigned int hashes[MAX_TOK_SIZE + 1];
+
+	if (len > MAX_TOK_SIZE)
+		len = MAX_TOK_SIZE;
+
+	hash = rehash_token(hash, data[0]);
+	for (i = 2; i <= len; i++) {
+		hash = rehash_token(hash, data[i-1]);
+		hashes[i] = HASH_FOLD(hash);
+	}
+
+	last_ptr = NULL;
+	ptr = NULL;
+
+	for (i = len; i >= 2; i--) {
+		hash = hashes[i];
+
+		if (!ptr) ptr = find_token_hash(data, i, hash);
+
+		if (!ptr) {
+			ptr = (struct token *) malloc(sizeof(*ptr));
+			memcpy(ptr->data, data, i);
+			ptr->len = i;
+			ptr->profit = -GOOD_BAD_THRESHOLD;
+			ptr->next = hash_table[hash];
+			hash_table[hash] = ptr;
+
+			insert_token_in_group(&bad_head, ptr);
+
+			ptr->smaller = NULL;
+		} else {
+			newprofit = ptr->profit + (ptr->len - 1);
+			if((ptr->profit < 0) && (newprofit >= 0)) {
+				remove_token_from_group(ptr);
+				insert_token_in_group(&good_head,ptr);
+			}
+		ptr->profit = newprofit;
+		}
+
+		if (last_ptr) last_ptr->smaller = ptr;
+		last_ptr = ptr;
+
+		ptr = ptr->smaller;
+	}
+}
+
+static void forget_token(unsigned char *data, int len)
+{
+	struct token *ptr;
+	int i, newprofit;
+	unsigned int hash=0;
+
+	if (len > MAX_TOK_SIZE) len = MAX_TOK_SIZE;
+
+	hash = hash_token(data, len);
+	ptr = find_token_hash(data, len, hash);
+
+	for (i = len; i >= 2; i--) {
+
+		newprofit = ptr->profit - (ptr->len - 1);
+		if ((ptr->profit >= 0) && (newprofit < 0)) {
+			remove_token_from_group(ptr);
+			insert_token_in_group(&bad_head, ptr);
+		}
+		ptr->profit=newprofit;
+
+		ptr=ptr->smaller;
+	}
+}
+
+static void learn_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		learn_token(symbol + i, len - i);
+}
+
+static void forget_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		forget_token(symbol + i, len - i);
+}
+
+static void build_initial_tok_table(void)
+{
+	int i, use_it, valid;
+
+	valid = 0;
+	for (i = 0; i < cnt; i++) {
+		table[i].valid = symbol_valid(&table[i]);
+		if (table[i].valid) valid++;
+	}
+
+	use_it = 0;
+	for (i = 0; i < cnt; i++) {
+		table[i].sample = 0;
+		if (table[i].valid) {
+			use_it += WORKING_SET;
+			if (use_it >= valid) {
+				table[i].sample = 1;
+				use_it -= valid;
+			}
+		}
+		if (table[i].sample)
+			learn_symbol(table[i].sym, table[i].len);
+	}
+}
+
+static void compress_symbols(unsigned char *str, int tlen, int idx)
+{
+	int i, len, learn, size;
+	unsigned char *p;
+
+	for (i = 0; i < cnt; i++) {
+		if (!table[i].valid) continue;
+		
+		len = table[i].len;
+		learn = 0;
+		p = table[i].sym;
+
+		do {
+			p = (unsigned char *) strstr((char *) p, (char *) str);
+			if (!p) break;
+
+			if (!learn) {
+				if (table[i].sample)
+					forget_symbol(table[i].sym, len);
+				learn = 1;
+			}
+
+			*p = idx;
+			size = (len - (p - table[i].sym)) - tlen + 1;
+			memmove(p + 1, p + tlen, size);
+			p++;
+			len -= tlen - 1;
+			
+		} while (size >= tlen);
+
+		if(learn) {
+			table[i].len = len;
+			if(table[i].sample) learn_symbol(table[i].sym, len);
+		}
+	}
+}
+
+static struct token *find_best_token(void)
+{
+	struct token *ptr,*best,*head;
+	int bestprofit;
+
+	bestprofit=-10000;
+
+	/* failsafe: if the "good" list is empty search from the "bad" list */
+	if(good_head.right == &good_head) head = &bad_head;
+	else head = &good_head;
+
+	ptr = head->right;
+	best = NULL;
+	while (ptr != head) {
+		if (ptr->profit > bestprofit) {
+			bestprofit = ptr->profit;
+			best = ptr;
+		}
+		ptr = ptr->right;
+	}
+
+	return best;
+}
+
+static void optimize_result(void)
+{
+	struct token *best;
+	int i;
+
+	/* using the '\0' symbol last allows compress_symbols to use standard
+	   fast string functions
+	*/
+	for (i = 255; i >= 0; i--) {
+		if (!best_table_len[i]) {
+			best = find_best_token();
+
+			best_table_len[i] = best->len;
+			memcpy(best_table[i], best->data, best_table_len[i]);
+			/* zero terminate the token so that we can use strstr
+			   in compress_symbols */
+			best_table[i][best_table_len[i]]='\0';
+
+			compress_symbols(best_table[i], best_table_len[i], i);
+		}
+	}
+}
+
+static void insert_real_symbols_in_table(void)
+{
+	int i, j, c;
+
+	memset(best_table, 0, sizeof(best_table));
+	memset(best_table_len, 0, sizeof(best_table_len));
+
+	for (i = 0; i < cnt; i++) {
+		if (table[i].valid) {
+			for (j = 0; j < table[i].len; j++) {
+				c = table[i].sym[j];
+				best_table[c][0]=c;
+				best_table_len[c]=1;
+			}
+		}
+	}
+}
+
+static void optimize_token_table(void)
+{
+	memset(hash_table, 0, sizeof(hash_table));
+
+	good_head.left = &good_head;
+	good_head.right = &good_head;
+
+	bad_head.left = &bad_head;
+	bad_head.right = &bad_head;
+
+	build_initial_tok_table();
+
+	insert_real_symbols_in_table();
+
+	optimize_result();
+}
+
+
  int
  main(int argc, char **argv)
  {
@@ -171,6 +554,7 @@ main(int argc, char **argv)
  		usage();

  	read_map(stdin);
+	optimize_token_table();
  	write_src();

  	return 0;
