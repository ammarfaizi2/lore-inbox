Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUJYHYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUJYHYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUJYHYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:24:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27659 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261669AbUJYHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:20:42 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce top(1) CPU usage by an order of magnitude
Date: Mon, 25 Oct 2004 10:20:01 +0300
User-Agent: KMail/1.5.4
Cc: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hkKfBYaSngKSqLX"
Message-Id: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hkKfBYaSngKSqLX
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch is not mine, Paulo Marques <pmarques@grupopie.com>
wrote it.

I tested in on 2.6.9-rc2. top(1) CPU usage went from ~40% to ~4%
(yes, test box is a rather old piece of junk).

The patch applies cleanly to 2.6.9.
--
vda

--Boundary-00=_hkKfBYaSngKSqLX
Content-Type: text/x-diff;
  charset="koi8-r";
  name="kallsyms.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kallsyms.diff"

diff -urpN old/kernel/kallsyms.c new/kernel/kallsyms.c
--- old/kernel/kallsyms.c	Sat Aug 14 13:56:23 2004
+++ new/kernel/kallsyms.c	Thu Sep 16 15:52:56 2004
@@ -4,7 +4,12 @@
  * Rewritten and vastly simplified by Rusty Russell for in-kernel
  * module loader:
  *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
- * Stem compression by Andi Kleen.
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression (see scripts/kallsyms.c for a more complete description)
  */
 #include <linux/kallsyms.h>
 #include <linux/module.h>
@@ -17,7 +22,12 @@
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
@@ -37,21 +47,88 @@ static inline int is_kernel_text(unsigne
 	return 0;
 }
 
+/* expand a compressed symbol data into the resulting uncompressed string,
+   given the offset to where the symbol is in the compressed stream */
+static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
+{
+	int len, skipped_first = 0;
+	u8 *tptr, *data;
+
+	/* get the compressed symbol length from the first symbol byte */
+	data = &kallsyms_names[off];
+	len = *data;
+	data++;
+
+	/* update the offset to return the offset for the next symbol on
+	 * the compressed stream */
+	off += len + 1;
+
+	/* for every byte on the compressed symbol data, copy the table
+	   entry for that byte */
+	while(len) {
+		tptr = &kallsyms_token_table[ kallsyms_token_index[*data] ];
+		data++;
+		len--;
+
+		while (*tptr) {
+			if(skipped_first) {
+				*result = *tptr;
+				result++;
+			} else
+				skipped_first = 1;
+			tptr++;
+		}
+	}
+
+	*result = '\0';
+
+	/* return to offset to the next symbol */
+	return off;
+}
+
+/* get symbol type information. This is encoded as a single char at the
+ * begining of the symbol name */
+static char kallsyms_get_symbol_type(unsigned int off)
+{
+	/* get just the first code, look it up in the token table, and return the
+	 * first char from this token */
+	return kallsyms_token_table[ kallsyms_token_index[ kallsyms_names[off+1] ] ];
+}
+
+
+/* find the offset on the compressed stream given and index in the
+ * kallsyms array */
+static unsigned int get_symbol_offset(unsigned long pos)
+{
+	u8 *name;
+	int i;
+
+	/* use the closest marker we have. We have markers every 256 positions,
+	 * so that should be close enough */
+	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
+
+	/* sequentially scan all the symbols up to the point we're searching for.
+	 * Every symbol is stored in a [<len>][<len> bytes of data] format, so we
+	 * just need to add the len to the current pointer for every symbol we
+	 * wish to skip */
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
@@ -62,7 +139,7 @@ const char *kallsyms_lookup(unsigned lon
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	unsigned long i, best = 0;
+	unsigned long i, low, high, mid;
 
 	/* This kernel should never had been booted. */
 	BUG_ON(!kallsyms_addresses);
@@ -71,40 +148,45 @@ const char *kallsyms_lookup(unsigned lon
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
+
+		while (high-low > 1) {
+			mid = (low + high) / 2;
+			if (kallsyms_addresses[mid] <= addr) low = mid;
+			else high = mid;
 		}
 
-		/* Grab name */
-		for (i = 0; i <= best; i++) { 
-			unsigned prefix = *name++;
-			strncpy(namebuf + prefix, name, KSYM_NAME_LEN - prefix);
-			name += strlen(name) + 1;
-		}
+		/* search for the first aliased symbol. Aliased symbols are
+		   symbols with the same address */
+		while (low && kallsyms_addresses[low - 1] == kallsyms_addresses[low])
+			--low;
 
-		/* At worst, symbol ends at end of section. */
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else
-			symbol_end = (unsigned long)_etext;
+		/* Grab name */
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
+		/* if we found no next symbol, we use the end of the section */
+		if (!symbol_end) {
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
 
@@ -135,7 +217,7 @@ void __print_symbol(const char *fmt, uns
 	printk(fmt, buffer);
 }
 
-/* To avoid O(n^2) iteration, we carry prefix along. */
+/* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter
 {
 	loff_t pos;
@@ -168,31 +250,23 @@ static int get_ksymbol_mod(struct kallsy
 /* Returns space to next name. */
 static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 {
-	unsigned stemlen, off = iter->nameoff;
+	unsigned off = iter->nameoff;
 
-	/* First char of each symbol name indicates prefix length
-	   shared with previous name (stem compression). */
-	stemlen = kallsyms_names[off++];
-
-	strlcpy(iter->name+stemlen, kallsyms_names + off,
-		KSYM_NAME_LEN+1-stemlen);
-	off += strlen(kallsyms_names + off) + 1;
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
-	if (is_kernel_text(iter->value) || is_kernel_inittext(iter->value))
-		iter->type = 't';
-	else
-		iter->type = 'd';
 
-	upcase_if_global(iter);
+	iter->type = kallsyms_get_symbol_type(off);
+
+	off = kallsyms_expand_symbol(off, iter->name);
+
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
@@ -204,16 +278,13 @@ static int update_iter(struct kallsym_it
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
 
@@ -267,14 +338,15 @@ struct seq_operations kallsyms_op = {
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/* We keep iterator in m->private, since normal case is to
-	 * s_start from where we left off, so we avoid O(N^2). */
+	 * s_start from where we left off, so we avoid doing
+	 * using get_symbol_offset for every symbol */
 	struct kallsym_iter *iter;
 	int ret;
 
 	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
 		return -ENOMEM;
-	reset_iter(iter);
+	reset_iter(iter, 0);
 
 	ret = seq_open(file, &kallsyms_op);
 	if (ret == 0)
@@ -310,3 +382,4 @@ int __init kallsyms_init(void)
 __initcall(kallsyms_init);
 
 EXPORT_SYMBOL(__print_symbol);
+EXPORT_SYMBOL(kallsyms_lookup_name);
diff -urpN old/scripts/kallsyms.c new/scripts/kallsyms.c
--- old/scripts/kallsyms.c	Sat Aug 14 13:56:23 2004
+++ new/scripts/kallsyms.c	Thu Sep 16 15:53:02 2004
@@ -6,6 +6,22 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ *
+ * ChangeLog:
+ *
+ * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
+ *      Changed the compression method from stem compression to "table lookup"
+ *      compression
+ *
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
@@ -13,10 +29,39 @@
 #include <string.h>
 #include <ctype.h>
 
+/* maximum token length used. It doesn't pay to increase it a lot, because
+ * very long substrings probably don't repeat themselves too often. */
+#define MAX_TOK_SIZE		11
+#define KSYM_NAME_LEN		127
+
+/* we use only a subset of the complete symbol table to gather the token count,
+ * to speed up compression, at the expense of a little compression ratio */
+#define WORKING_SET		1024
+
+/* first find the best token only on the list of tokens that would profit more
+ * than GOOD_BAD_THRESHOLD. Only if this list is empty go to the "bad" list.
+ * Increasing this value will put less tokens on the "good" list, so the search
+ * is faster. However, if the good list runs out of tokens, we must painfully
+ * search the bad list. */
+#define GOOD_BAD_THRESHOLD	10
+
+/* token hash parameters */
+#define HASH_BITS		18
+#define HASH_TABLE_SIZE		(1 << HASH_BITS)
+#define HASH_MASK		(HASH_TABLE_SIZE - 1)
+#define HASH_BASE_OFFSET	2166136261U
+#define HASH_FOLD(a)		((a)&(HASH_MASK))
+
+/* flags to mark symbols */
+#define SYM_FLAG_VALID		1
+#define SYM_FLAG_SAMPLED	2
+
 struct sym_entry {
 	unsigned long long addr;
 	char type;
-	char *sym;
+	unsigned char flags;
+	unsigned char len;
+	unsigned char *sym;
 };
 
 
@@ -25,6 +70,26 @@ static int size, cnt;
 static unsigned long long _stext, _etext, _sinittext, _einittext;
 static int all_symbols = 0;
 
+struct token {
+	unsigned char data[MAX_TOK_SIZE];
+	unsigned char len;
+	/* profit: the number of bytes that could be saved by inserting this
+	 * token into the table */
+	int profit;
+	struct token *next;	/* next token on the hash list */
+	struct token *right;	/* next token on the good/bad list */
+	struct token *left;    /* previous token on the good/bad list */
+	struct token *smaller; /* token that is less one letter than this one */
+	};
+
+struct token bad_head, good_head;
+struct token *hash_table[HASH_TABLE_SIZE];
+
+/* the table that holds the result of the compression */
+unsigned char best_table[256][MAX_TOK_SIZE+1];
+unsigned char best_table_len[256];
+
+
 static void
 usage(void)
 {
@@ -59,34 +124,53 @@ read_symbol(FILE *in, struct sym_entry *
 	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
 		return -1;
 
-	s->sym = strdup(str);
+	/* include the type field in the symbol name, so that it gets
+	 * compressed together */
+	s->len = strlen(str) + 1;
+	s->sym = (char *) malloc(s->len + 1);
+	strcpy(s->sym + 1, str);
+	s->sym[0] = s->type;
+
 	return 0;
 }
 
 static int
 symbol_valid(struct sym_entry *s)
 {
+	/* Symbols which vary between passes.  Passes 1 and 2 must have
+	 * identical symbol lists.  The kallsyms_* symbols below are only added
+	 * after pass 1, they would be included in pass 2 when --all-symbols is
+	 * specified so exclude them to get a stable symbol list.
+	 */
+	static char *special_symbols[] = {
+		"kallsyms_addresses",
+		"kallsyms_num_syms",
+		"kallsyms_names",
+		"kallsyms_markers",
+		"kallsyms_token_table",
+		"kallsyms_token_index",
+
+	/* Exclude linker generated symbols which vary between passes */
+		"_SDA_BASE_",		/* ppc */
+		"_SDA2_BASE_",		/* ppc */
+		NULL };
+	int i;
+
+	/* if --all-symbols is not specified, then symbols outside the text
+	 * and inittext sections are discarded */
 	if (!all_symbols) {
 		if ((s->addr < _stext || s->addr > _etext)
 		    && (s->addr < _sinittext || s->addr > _einittext))
 			return 0;
 	}
 
-	/* Exclude symbols which vary between passes.  Passes 1 and 2 must have
-	 * identical symbol lists.  The kallsyms_* symbols below are only added
-	 * after pass 1, they would be included in pass 2 when --all-symbols is
-	 * specified so exclude them to get a stable symbol list.
-	 */
-	if (strstr(s->sym, "_compiled.") ||
-	    strcmp(s->sym, "kallsyms_addresses") == 0 ||
-	    strcmp(s->sym, "kallsyms_num_syms") == 0 ||
-	    strcmp(s->sym, "kallsyms_names") == 0)
+	/* Exclude symbols which vary between passes. */
+	if (strstr(s->sym + 1, "_compiled."))
 		return 0;
 
-	/* Exclude linker generated symbols which vary between passes */
-	if (strcmp(s->sym, "_SDA_BASE_") == 0 ||	/* ppc */
-	    strcmp(s->sym, "_SDA2_BASE_") == 0)		/* ppc */
-		return 0;
+	for (i = 0; special_symbols[i]; i++)
+		if( strcmp(s->sym + 1, special_symbols[i]) == 0 )
+			return 0;
 
 	return 1;
 }
@@ -108,11 +192,47 @@ read_map(FILE *in)
 	}
 }
 
+static void output_label(char *label)
+{
+	printf(".globl %s\n",label);
+	printf("\tALGN\n");
+	printf("%s:\n",label);
+}
+
+/* uncompress a compressed symbol. When this function is called, the best table
+ * might still be compressed itself, so the function needs to be recursive */
+static int expand_symbol(unsigned char *data, int len, char *result)
+{
+	int c, rlen, total=0;
+
+	while (len) {
+		c = *data;
+		/* if the table holds a single char that is the same as the one
+		 * we are looking for, then end the search */
+		if (best_table[c][0]==c && best_table_len[c]==1) {
+			*result++ = c;
+			total++;
+		} else {
+			/* if not, recurse and expand */
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
@@ -125,43 +245,399 @@ write_src(void)
 
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
+		if (table[i].flags & SYM_FLAG_VALID) {
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
+	/* table of offset markers, that give the offset in the compressed stream
+	 * every 256 symbols */
+	markers = (unsigned int *) malloc(sizeof(unsigned int)*((valid + 255) / 256));
+
+	output_label("kallsyms_names");
+	valid = 0;
+	off = 0;
 	for (i = 0; i < cnt; i++) {
-		int k;
 
-		if (!symbol_valid(&table[i]))
+		if (!table[i].flags & SYM_FLAG_VALID)
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
+	free(markers);
+
+	output_label("kallsyms_token_table");
+	off = 0;
+	for (i = 0; i < 256; i++) {
+		best_idx[i] = off;
+		expand_symbol(best_table[i],best_table_len[i],buf);
+		printf("\t.asciz\t\"%s\"\n", buf);
+		off += strlen(buf) + 1;
+	}
+	printf("\n");
+
+	output_label("kallsyms_token_index");
+	for (i = 0; i < 256; i++)
+		printf("\t.short\t%d\n", best_idx[i]);
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
+/* find a token given its data and hash value */
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
+}
+
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
+
+/* build the counts for all the tokens that start with "data", and have lenghts
+ * from 2 to "len" */
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
+	/* calculate and store the hash values for all the sub-tokens */
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
+			/* create a new token entry */
+			ptr = (struct token *) malloc(sizeof(*ptr));
+
+			memcpy(ptr->data, data, i);
+			ptr->len = i;
+
+			/* when we create an entry, it's profit is 0 because
+			 * we also take into account the size of the token on
+			 * the compressed table. We then subtract GOOD_BAD_THRESHOLD
+			 * so that the test to see if this token belongs to
+			 * the good or bad list, is a comparison to zero */
+			ptr->profit = -GOOD_BAD_THRESHOLD;
+
+			ptr->next = hash_table[hash];
+			hash_table[hash] = ptr;
+
+			insert_token_in_group(&bad_head, ptr);
+
+			ptr->smaller = NULL;
+		} else {
+			newprofit = ptr->profit + (ptr->len - 1);
+			/* check to see if this token needs to be moved to a
+			 * different list */
+			if((ptr->profit < 0) && (newprofit >= 0)) {
+				remove_token_from_group(ptr);
+				insert_token_in_group(&good_head,ptr);
+			}
+			ptr->profit = newprofit;
+		}
+
+		if (last_ptr) last_ptr->smaller = ptr;
+		last_ptr = ptr;
+
+		ptr = ptr->smaller;
+	}
+}
+
+/* decrease the counts for all the tokens that start with "data", and have lenghts
+ * from 2 to "len". This function is much simpler than learn_token because we have
+ * more guarantees (tho tokens exist, the ->smaller pointer is set, etc.)
+ * The two separate functions exist only because of compression performance */
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
+/* count all the possible tokens in a symbol */
+static void learn_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		learn_token(symbol + i, len - i);
+}
+
+/* decrease the count for all the possible tokens in a symbol */
+static void forget_symbol(unsigned char *symbol, int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++)
+		forget_token(symbol + i, len - i);
+}
+
+/* set all the symbol flags and do the initial token count */
+static void build_initial_tok_table(void)
+{
+	int i, use_it, valid;
+
+	valid = 0;
+	for (i = 0; i < cnt; i++) {
+		table[i].flags = 0;
+		if ( symbol_valid(&table[i]) ) {
+			table[i].flags |= SYM_FLAG_VALID;
+			valid++;
+		}
+	}
+
+	use_it = 0;
+	for (i = 0; i < cnt; i++) {
+
+		/* subsample the available symbols. This method is almost like
+		 * a Bresenham's algorithm to get uniformly distributed samples
+		 * across the symbol table */
+		if (table[i].flags & SYM_FLAG_VALID) {
+
+			use_it += WORKING_SET;
+
+			if (use_it >= valid) {
+				table[i].flags |= SYM_FLAG_SAMPLED;
+				use_it -= valid;
+			}
+		}
+		if (table[i].flags & SYM_FLAG_SAMPLED)
+			learn_symbol(table[i].sym, table[i].len);
+	}
 }
 
+/* replace a given token in all the valid symbols. Use the sampled symbols
+ * to update the counts */
+static void compress_symbols(unsigned char *str, int tlen, int idx)
+{
+	int i, len, learn, size;
+	unsigned char *p;
+
+	for (i = 0; i < cnt; i++) {
+
+		if (!(table[i].flags & SYM_FLAG_VALID)) continue;
+
+		len = table[i].len;
+		learn = 0;
+		p = table[i].sym;
+
+		do {
+			/* find the token on the symbol */
+			p = (unsigned char *) strstr((char *) p, (char *) str);
+			if (!p) break;
+
+			if (!learn) {
+				/* if this symbol was used to count, decrease it */
+				if (table[i].flags & SYM_FLAG_SAMPLED)
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
+			/* if this symbol was used to count, learn it again */
+			if(table[i].flags & SYM_FLAG_SAMPLED)
+				learn_symbol(table[i].sym, len);
+		}
+	}
+}
+
+/* search the token with the maximum profit */
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
+/* this is the core of the algorithm: calculate the "best" table */
+static void optimize_result(void)
+{
+	struct token *best;
+	int i;
+
+	/* using the '\0' symbol last allows compress_symbols to use standard
+	 * fast string functions */
+	for (i = 255; i >= 0; i--) {
+
+		/* if this table slot is empty (it is not used by an actual
+		 * original char code */
+		if (!best_table_len[i]) {
+
+			/* find the token with the breates profit value */
+			best = find_best_token();
+
+			/* place it in the "best" table */
+			best_table_len[i] = best->len;
+			memcpy(best_table[i], best->data, best_table_len[i]);
+			/* zero terminate the token so that we can use strstr
+			   in compress_symbols */
+			best_table[i][best_table_len[i]]='\0';
+
+			/* replace this token in all the valid symbols */
+			compress_symbols(best_table[i], best_table_len[i], i);
+		}
+	}
+}
+
+/* start by placing the symbols that are actually used on the table */
+static void insert_real_symbols_in_table(void)
+{
+	int i, j, c;
+
+	memset(best_table, 0, sizeof(best_table));
+	memset(best_table_len, 0, sizeof(best_table_len));
+
+	for (i = 0; i < cnt; i++) {
+		if (table[i].flags & SYM_FLAG_VALID) {
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
@@ -171,6 +647,7 @@ main(int argc, char **argv)
 		usage();
 
 	read_map(stdin);
+	optimize_token_table();
 	write_src();
 
 	return 0;

--Boundary-00=_hkKfBYaSngKSqLX--

