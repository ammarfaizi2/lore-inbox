Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUIALkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUIALkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUIALkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:40:14 -0400
Received: from [195.23.16.24] ([195.23.16.24]:20365 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266136AbUIALjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:39:09 -0400
Message-ID: <4135B4D3.9080105@grupopie.com>
Date: Wed, 01 Sep 2004 12:38:59 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com>
In-Reply-To: <4134DEF4.8090001@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------030800090007080506080403"
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.40; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800090007080506080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


My email client added spaces in the beggining of some of the lines
of the patch, so that it doesn't apply.

I'm sending it attached this time to make sure it gets through.

Sorry about this mess,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978

--------------030800090007080506080403
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -uprN -X ../dontdiff linux-2.6.9-rc1-mm2/kernel/kallsyms.c linux-2.6.9-rc1-mm2-kall/kernel/kallsyms.c
--- linux-2.6.9-rc1-mm2/kernel/kallsyms.c	2004-08-31 11:53:34.000000000 +0100
+++ linux-2.6.9-rc1-mm2-kall/kernel/kallsyms.c	2004-08-31 21:18:10.000000000 +0100
@@ -4,13 +4,12 @@
  * Rewritten and vastly simplified by Rusty Russell for in-kernel
  * module loader:
  *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
- * Stem compression by Andi Kleen.
  *
  * ChangeLog:
  *
- * (25/Aug/2004) Paulo Marques
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
  *      Changed the compression method from stem compression to "table lookup"
- *      compression
+ *      compression (see scripts/kallsyms.c for a more complete description)
  */
 #include <linux/kallsyms.h>
 #include <linux/module.h>
@@ -48,40 +47,61 @@ static inline int is_kernel_text(unsigne
 	return 0;
 }
 
+/* expand a compressed symbol data into the resulting uncompressed string,
+   given the offset to where the symbol is in the compressed stream */
 static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
 {
-	int len, tlen;
+	int len;
 	u8 *tptr, *data;
 
+	/* get the compressed symbol length from the first symbol byte,
+	 * masking out the "is_exported" bit */
 	data = &kallsyms_names[off];
+	len = (*data) & 0x7F;
+	data++;
 
-	len=*data++;
+	/* update the offset to return the offset for the next symbol on
+	   the compressed stream */
 	off += len + 1;
+
+	/* for every byte on the compressed symbol data, copy the table
+	   entry for that byte */
 	while(len) {
-		tptr=&kallsyms_token_table[kallsyms_token_index[*data]];
+		tptr = &kallsyms_token_table[ kallsyms_token_index[*data] ];
 		data++;
 		len--;
 
-		tlen=*tptr++;
-		while(tlen) {
-			*result++=*tptr++;
-			tlen--;
+		while (*tptr) {
+			*result = *tptr;
+			result++;
+			tptr++;
 		}
 	}
 
-	*result = 0;
+	*result = '\0';
 
+	/* return to offset to the next symbol */
 	return off;
 }
 
+/* find the offset on the compressed stream given and index in the
+   kallsyms array */
 static unsigned int get_symbol_offset(unsigned long pos)
 {
 	u8 *name;
 	int i;
 
+        /* use the closest marker we have. We have markers every
+           256 positions, so that should be close enough */
 	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
+
+        /* sequentially scan all the symbols up to the point we're
+           searching for. Every symbol is stored in a
+	   [bit 7: is_exported | bits 6..0: <len>][<len> bytes of data]
+	   format, so we just need to add the len to the current
+	   pointer for every symbol we wish to skip */
 	for(i = 0; i < (pos&0xFF); i++)
-		name = name + (*name) + 1;
+		name = name + ((*name) & 0x7F) + 1;
 
 	return name - kallsyms_names;
 }
@@ -122,12 +142,16 @@ const char *kallsyms_lookup(unsigned lon
 		/* do a binary search on the sorted kallsyms_addresses array */
 		low = 0;
 		high = kallsyms_num_syms;
+
 		while (high-low > 1) {
 			mid = (low + high) / 2;
 			if (kallsyms_addresses[mid] <= addr) low = mid;
 			else high = mid;
 		}
-		while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low])
+
+		/* search for the first aliased symbol. Aliased symbols are
+		   symbols with the same address */
+		while (low && kallsyms_addresses[low - 1] == kallsyms_addresses[low])
 			--low;
 
 		/* Grab name */
@@ -141,8 +165,8 @@ const char *kallsyms_lookup(unsigned lon
 			}
 		}
 
+		/* if we found no next symbol, we use the end of the section */
 		if (!symbol_end) {
-			/* At worst, symbol ends at end of section. */
 			if (is_kernel_inittext(addr))
 				symbol_end = (unsigned long)_einittext;
 			else
@@ -182,7 +206,7 @@ void __print_symbol(const char *fmt, uns
 	printk(fmt, buffer);
 }
 
-/* To avoid O(n^2) iteration, we carry prefix along. */
+/* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter
 {
 	loff_t pos;
@@ -217,16 +241,20 @@ static unsigned long get_ksymbol_core(st
 {
 	unsigned off = iter->nameoff;
 
-	off = kallsyms_expand_symbol(off, iter->name);
-
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
+
 	if (is_kernel_text(iter->value) || is_kernel_inittext(iter->value))
 		iter->type = 't';
 	else
 		iter->type = 'd';
 
-	upcase_if_global(iter);
+	/* check the "is_exported" bit on the compressed stream */
+	if (kallsyms_names[off] & 0x80)
+		iter->type += 'A' - 'a';
+
+	off = kallsyms_expand_symbol(off, iter->name);
+
 	return off - iter->nameoff;
 }
 
@@ -306,7 +334,8 @@ struct seq_operations kallsyms_op = {
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/* We keep iterator in m->private, since normal case is to
-	 * s_start from where we left off, so we avoid O(N^2). */
+	 * s_start from where we left off, so we avoid doing
+	 * using get_symbol_offset for every symbol */
 	struct kallsym_iter *iter;
 	int ret;
 
diff -uprN -X ../dontdiff linux-2.6.9-rc1-mm2/scripts/kallsyms.c linux-2.6.9-rc1-mm2-kall/scripts/kallsyms.c
--- linux-2.6.9-rc1-mm2/scripts/kallsyms.c	2004-08-31 11:53:34.000000000 +0100
+++ linux-2.6.9-rc1-mm2-kall/scripts/kallsyms.c	2004-08-31 21:09:50.000000000 +0100
@@ -9,10 +9,19 @@
  *
  * ChangeLog:
  *
- * (25/Aug/2004) Paulo Marques
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
  *      Changed the compression method from stem compression to "table lookup"
  *      compression
  *
+ *      Table compression uses all the unused char codes on the symbols and
+ *  maps these to the most used substrings (tokens). For instance, it might
+ *  map char code 0xF7 to represent "write_" and then in every symbol where
+ *  "write_" appears it can be replaced by 0xF7, saving 5 bytes.
+ *      The used codes themselves are also placed in the table so that the
+ *  decompresion can work without "special cases".
+ *      Applied to kernel symbols, this usually produces a compression ratio
+ *  of about 50%.
+ *
  */
 
 #include <stdio.h>
@@ -20,28 +29,38 @@
 #include <string.h>
 #include <ctype.h>
 
-/* compression tunning settings */
+/* maximum token length used. It doesn't pay to increase it a lot, because
+ * very long substrings probably don't repeat themselves too often. */
 #define MAX_TOK_SIZE		11
 #define KSYM_NAME_LEN		127
 
 /* we use only a subset of the complete symbol table to gather the token count,
-   to speed up compression, at the expense of a little compression ratio
-*/
+ * to speed up compression, at the expense of a little compression ratio */
 #define WORKING_SET		1024
+
+/* first find the best token only on the list of tokens that would profit more
+ * than GOOD_BAD_THRESHOLD. Only if this list is empty go to the "bad" list.
+ * Increasing this value will put less tokens on the "good" list, so the search
+ * is faster. However, if the good list runs out of tokens, we must painfully
+ * search the bad list. */
 #define GOOD_BAD_THRESHOLD	10
 
+/* token hash parameters */
 #define HASH_BITS		18
 #define HASH_TABLE_SIZE		(1 << HASH_BITS)
 #define HASH_MASK		(HASH_TABLE_SIZE - 1)
 #define HASH_BASE_OFFSET	2166136261U
 #define HASH_FOLD(a)		((a)&(HASH_MASK))
 
+/* flags to mark symbols */
+#define SYM_FLAG_VALID		1
+#define SYM_FLAG_SAMPLED	2
+#define SYM_FLAG_EXPORTED	4
 
 struct sym_entry {
 	unsigned long long addr;
 	char type;
-	char sample;
-	char valid;
+	unsigned char flags;
 	unsigned char len;
 	unsigned char *sym;
 };
@@ -49,23 +68,28 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext;
+static unsigned long long _stext, _etext, _sinittext, _einittext, _start_ksymtab, _stop_ksymtab;
 static int all_symbols = 0;
 
+/* aray of pointers into the symbol table sorted by name */
+static struct sym_entry **sorted_table;
 
 struct token {
 	unsigned char data[MAX_TOK_SIZE];
 	unsigned char len;
+	/* profit: the number of bytes that could be saved by inserting this
+	 * token into the table */
 	int profit;
-	struct token *next;
-	struct token *right;
-	struct token *left;
-	struct token *smaller;
+	struct token *next;	/* next token on the hash list */
+	struct token *right;	/* next token on the good/bad list */
+	struct token *left;    /* previous token on the good/bad list */
+	struct token *smaller; /* token that is less one letter than this one */
 	};
 
 struct token bad_head, good_head;
 struct token *hash_table[HASH_TABLE_SIZE];
 
+/* the table that holds the result of the compression */
 unsigned char best_table[256][MAX_TOK_SIZE+1];
 unsigned char best_table_len[256];
 
@@ -101,6 +125,10 @@ read_symbol(FILE *in, struct sym_entry *
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
+	else if (strcmp(str, "__start___ksymtab") == 0)
+		_start_ksymtab = s->addr;
+	else if (strcmp(str, "__stop___ksymtab") == 0)
+		_stop_ksymtab = s->addr;
 	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
 		return -1;
 
@@ -126,7 +154,10 @@ symbol_valid(struct sym_entry *s)
 	if (strstr(s->sym, "_compiled.") ||
 	    strcmp(s->sym, "kallsyms_addresses") == 0 ||
 	    strcmp(s->sym, "kallsyms_num_syms") == 0 ||
-	    strcmp(s->sym, "kallsyms_names") == 0)
+	    strcmp(s->sym, "kallsyms_names") == 0 ||
+	    strcmp(s->sym, "kallsyms_markers") == 0 ||
+	    strcmp(s->sym, "kallsyms_token_table") == 0 ||
+	    strcmp(s->sym, "kallsyms_token_index") == 0)
 		return 0;
 
 	/* Exclude linker generated symbols which vary between passes */
@@ -161,16 +192,21 @@ static void output_label(char *label)
 	printf("%s:\n",label);
 }
 
+/* uncompress a compressed symbol. When this function is called, the best table
+ * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(unsigned char *data, int len, char *result)
 {
 	int c, rlen, total=0;
 
 	while (len) {
 		c = *data;
+		/* if the table holds a single char that is the same as the one
+		 * we are looking for, then end the search */
 		if (best_table[c][0]==c && best_table_len[c]==1) {
 			*result++ = c;
 			total++;
 		} else {
+			/* if not, recurse and expand */
 			rlen = expand_symbol(best_table[c], best_table_len[c], result);
 			total += rlen;
 			result += rlen;
@@ -205,7 +241,7 @@ write_src(void)
 	output_label("kallsyms_addresses");
 	valid = 0;
 	for (i = 0; i < cnt; i++) {
-		if (table[i].valid) {
+		if (table[i].flags & SYM_FLAG_VALID) {
 			printf("\tPTR\t%#llx\n", table[i].addr);
 			valid++;
 		}
@@ -216,6 +252,8 @@ write_src(void)
 	printf("\tPTR\t%d\n", valid);
 	printf("\n");
 
+	/* table of offset markers, that give the offset in the compressed stream
+	 * every 256 symbols */
 	markers = (unsigned int *) malloc(sizeof(unsigned int)*((valid + 255) / 256));
 
 	output_label("kallsyms_names");
@@ -223,13 +261,15 @@ write_src(void)
 	off = 0;
 	for (i = 0; i < cnt; i++) {
 
-		if (!table[i].valid)
+		if (!table[i].flags & SYM_FLAG_VALID)
 			continue;
 
 		if ((valid & 0xFF) == 0)
 			markers[valid >> 8] = off;
 
-		printf("\t.byte 0x%02x", table[i].len);
+		k = table[i].len;
+		if (table[i].flags & SYM_FLAG_EXPORTED) k |= 0x80;
+		printf("\t.byte 0x%02x", k);
 		for (k = 0; k < table[i].len; k++)
 			printf(", 0x%02x", table[i].sym[k]);
 		printf("\n");
@@ -244,14 +284,15 @@ write_src(void)
 		printf("\tPTR\t%d\n", markers[i]);
 	printf("\n");
 
+	free(markers);
+
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
 		expand_symbol(best_table[i],best_table_len[i],buf);
-		k = strlen(buf);
-		printf("\t.byte 0x%02x\n\t.ascii\t\"%s\"\n", k, buf);
-		off += k + 1;
+		printf("\t.asciz\t\"%s\"\n", buf);
+		off += strlen(buf) + 1;
 	}
 	printf("\n");
 
@@ -280,6 +321,7 @@ static unsigned int hash_token(unsigned 
 	return HASH_FOLD(hash);
 }
 
+/* find a token given its data and hash value */
 static struct token *find_token_hash(unsigned char *data, int len, unsigned int hash)
 {
 	struct token *ptr;
@@ -309,6 +351,9 @@ static inline void remove_token_from_gro
 	ptr->right->left = ptr->left;
 }
 
+
+/* build the counts for all the tokens that start with "data", and have lenghts
+ * from 2 to "len" */
 static void learn_token(unsigned char *data, int len)
 {
 	struct token *ptr,*last_ptr;
@@ -319,6 +364,7 @@ static void learn_token(unsigned char *d
 	if (len > MAX_TOK_SIZE)
 		len = MAX_TOK_SIZE;
 
+	/* calculate and store the hash values for all the sub-tokens */
 	hash = rehash_token(hash, data[0]);
 	for (i = 2; i <= len; i++) {
 		hash = rehash_token(hash, data[i-1]);
@@ -334,10 +380,19 @@ static void learn_token(unsigned char *d
 		if (!ptr) ptr = find_token_hash(data, i, hash);
 
 		if (!ptr) {
+			/* create a new token entry */
 			ptr = (struct token *) malloc(sizeof(*ptr));
+
 			memcpy(ptr->data, data, i);
 			ptr->len = i;
+
+			/* when we create an entry, it's profit is 0 because
+			 * we also take into account the size of the token on
+			 * the compressed table. We then subtract GOOD_BAD_THRESHOLD
+			 * so that the test to see if this token belongs to
+			 * the good or bad list, is a comparison to zero */
 			ptr->profit = -GOOD_BAD_THRESHOLD;
+
 			ptr->next = hash_table[hash];
 			hash_table[hash] = ptr;
 
@@ -346,11 +401,13 @@ static void learn_token(unsigned char *d
 			ptr->smaller = NULL;
 		} else {
 			newprofit = ptr->profit + (ptr->len - 1);
+			/* check to see if this token needs to be moved to a
+			 * different list */
 			if((ptr->profit < 0) && (newprofit >= 0)) {
 				remove_token_from_group(ptr);
 				insert_token_in_group(&good_head,ptr);
 			}
-		ptr->profit = newprofit;
+			ptr->profit = newprofit;
 		}
 
 		if (last_ptr) last_ptr->smaller = ptr;
@@ -360,6 +417,10 @@ static void learn_token(unsigned char *d
 	}
 }
 
+/* decrease the counts for all the tokens that start with "data", and have lenghts
+ * from 2 to "len". This function is much simpler than learn_token because we have
+ * more guarantees (tho tokens exist, the ->smaller pointer is set, etc.)
+ * The two separate functions exist only because of compression performance */
 static void forget_token(unsigned char *data, int len)
 {
 	struct token *ptr;
@@ -384,6 +445,7 @@ static void forget_token(unsigned char *
 	}
 }
 
+/* count all the possible tokens in a symbol */
 static void learn_symbol(unsigned char *symbol, int len)
 {
 	int i;
@@ -392,6 +454,7 @@ static void learn_symbol(unsigned char *
 		learn_token(symbol + i, len - i);
 }
 
+/* decrease the count for all the possible tokens in a symbol */
 static void forget_symbol(unsigned char *symbol, int len)
 {
 	int i;
@@ -400,49 +463,98 @@ static void forget_symbol(unsigned char 
 		forget_token(symbol + i, len - i);
 }
 
+static int symbol_sort(const void *a, const void *b)
+{
+	return strcmp( (*((struct sym_entry **) a))->sym,
+				(*((struct sym_entry **) b))->sym );
+}
+
+
+/* find out if a symbol is exported. Exported symbols have a corresponding
+ * __ksymtab_<symbol> entry and their addresses are between __start___ksymtab
+ * and __stop___ksymtab */
+static int is_exported(char *name)
+{
+	struct sym_entry key, *ksym, **result;
+	char buf[KSYM_NAME_LEN+32];
+
+	sprintf(buf, "__ksymtab_%s", name);
+	key.sym = buf;
+
+	ksym = &key;
+	result = bsearch(&ksym, sorted_table, cnt,
+				sizeof(struct sym_entry *), symbol_sort);
+
+	if(!result) return 0;
+
+	ksym = *result;
+
+	return ((ksym->addr >= _start_ksymtab) && (ksym->addr < _stop_ksymtab));
+}
+
+/* set all the symbol flags and do the initial token count */
 static void build_initial_tok_table(void)
 {
 	int i, use_it, valid;
 
+	/* build a sorted symbol pointer array so that searching a particular
+	 * symbol is faster */
+	sorted_table = (struct sym_entry **) malloc(sizeof(struct sym_entry *) * cnt);
+	for (i = 0; i < cnt; i++)
+		sorted_table[i] = &table[i];
+	qsort(sorted_table, cnt, sizeof(struct sym_entry *), symbol_sort);
+
 	valid = 0;
 	for (i = 0; i < cnt; i++) {
-		table[i].valid = symbol_valid(&table[i]);
-		if (table[i].valid) valid++;
+		table[i].flags = 0;
+		if ( symbol_valid(&table[i]) ) {
+			table[i].flags |= SYM_FLAG_VALID;
+			valid++;
+		}
 	}
 
 	use_it = 0;
 	for (i = 0; i < cnt; i++) {
-		table[i].sample = 0;
-		if (table[i].valid) {
+		if (table[i].flags & SYM_FLAG_VALID) {
+
 			use_it += WORKING_SET;
+
 			if (use_it >= valid) {
-				table[i].sample = 1;
+				table[i].flags |= SYM_FLAG_SAMPLED;
 				use_it -= valid;
 			}
+
+			if( is_exported(table[i].sym) )
+				table[i].flags |= SYM_FLAG_EXPORTED;
 		}
-		if (table[i].sample)
+		if (table[i].flags & SYM_FLAG_SAMPLED)
 			learn_symbol(table[i].sym, table[i].len);
 	}
 }
 
+/* replace a given token in all the valid symbols. Use the sampled symbols
+ * to update the counts */
 static void compress_symbols(unsigned char *str, int tlen, int idx)
 {
 	int i, len, learn, size;
 	unsigned char *p;
 
 	for (i = 0; i < cnt; i++) {
-		if (!table[i].valid) continue;
+
+		if (!(table[i].flags & SYM_FLAG_VALID)) continue;
 
 		len = table[i].len;
 		learn = 0;
 		p = table[i].sym;
 
 		do {
+			/* find the token on the symbol */
 			p = (unsigned char *) strstr((char *) p, (char *) str);
 			if (!p) break;
 
 			if (!learn) {
-				if (table[i].sample)
+				/* if this symbol was used to count, decrease it */
+				if (table[i].flags & SYM_FLAG_SAMPLED)
 					forget_symbol(table[i].sym, len);
 				learn = 1;
 			}
@@ -457,11 +569,14 @@ static void compress_symbols(unsigned ch
 
 		if(learn) {
 			table[i].len = len;
-			if(table[i].sample) learn_symbol(table[i].sym, len);
+			/* if this symbol was used to count, learn it again */
+			if(table[i].flags & SYM_FLAG_SAMPLED)
+				learn_symbol(table[i].sym, len);
 		}
 	}
 }
 
+/* search the token with the maximum profit */
 static struct token *find_best_token(void)
 {
 	struct token *ptr,*best,*head;
@@ -486,29 +601,37 @@ static struct token *find_best_token(voi
 	return best;
 }
 
+/* this is the core of the algorithm: calculate the "best" table */
 static void optimize_result(void)
 {
 	struct token *best;
 	int i;
 
 	/* using the '\0' symbol last allows compress_symbols to use standard
-	   fast string functions
-	*/
+	 * fast string functions */
 	for (i = 255; i >= 0; i--) {
+
+		/* if this table slot is empty (it is not used by an actual
+		 * original char code */
 		if (!best_table_len[i]) {
+
+			/* find the token with the breates profit value */
 			best = find_best_token();
 
+			/* place it in the "best" table */
 			best_table_len[i] = best->len;
 			memcpy(best_table[i], best->data, best_table_len[i]);
 			/* zero terminate the token so that we can use strstr
 			   in compress_symbols */
 			best_table[i][best_table_len[i]]='\0';
 
+			/* replace this token in all the valid symbols */
 			compress_symbols(best_table[i], best_table_len[i], i);
 		}
 	}
 }
 
+/* start by placing the symbols that are actually used on the table */
 static void insert_real_symbols_in_table(void)
 {
 	int i, j, c;
@@ -517,7 +640,7 @@ static void insert_real_symbols_in_table
 	memset(best_table_len, 0, sizeof(best_table_len));
 
 	for (i = 0; i < cnt; i++) {
-		if (table[i].valid) {
+		if (table[i].flags & SYM_FLAG_VALID) {
 			for (j = 0; j < table[i].len; j++) {
 				c = table[i].sym[j];
 				best_table[c][0]=c;

--------------030800090007080506080403--
