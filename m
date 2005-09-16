Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbVIPR3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbVIPR3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVIPR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:29:08 -0400
Received: from [195.23.16.24] ([195.23.16.24]:56485 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S1030590AbVIPR3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:29:06 -0400
Message-ID: <432B009B.2090304@grupopie.com>
Date: Fri, 16 Sep 2005 18:27:55 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kallsyms error when compiling 2.6.13 + patch
References: <432AFF0E.8090904@candelatech.com>
In-Reply-To: <432AFF0E.8090904@candelatech.com>
Content-Type: multipart/mixed;
 boundary="------------030906090108090302000903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906090108090302000903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ben Greear wrote:
> After applying this patch:
> 
> http://www.candelatech.com/oss/candela_2.6.13.patch
> 
> and using this config:
> 
> http://www.candelatech.com/oss/kernel26_p2.cfg
> 
> I had to set the CONFIG_KALLSYMS_EXTRA_PASS option
> to get the compile to work.
> 
> Compile machine is up-to-date FC2 system (dual Xeon).
> 
> Is this a known issue?

Most likely.

Please try the attached patch.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain

--------------030906090108090302000903
Content-Type: text/plain;
 name="kallsyms_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallsyms_patch"

--- ./scripts/kallsyms.c.orig	2005-06-23 19:20:20.000000000 +0100
+++ ./scripts/kallsyms.c	2005-06-23 19:20:34.000000000 +0100
@@ -24,75 +24,37 @@
  *
  */
 
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
 
-/* maximum token length used. It doesn't pay to increase it a lot, because
- * very long substrings probably don't repeat themselves too often. */
-#define MAX_TOK_SIZE		11
 #define KSYM_NAME_LEN		127
 
-/* we use only a subset of the complete symbol table to gather the token count,
- * to speed up compression, at the expense of a little compression ratio */
-#define WORKING_SET		1024
-
-/* first find the best token only on the list of tokens that would profit more
- * than GOOD_BAD_THRESHOLD. Only if this list is empty go to the "bad" list.
- * Increasing this value will put less tokens on the "good" list, so the search
- * is faster. However, if the good list runs out of tokens, we must painfully
- * search the bad list. */
-#define GOOD_BAD_THRESHOLD	10
-
-/* token hash parameters */
-#define HASH_BITS		18
-#define HASH_TABLE_SIZE		(1 << HASH_BITS)
-#define HASH_MASK		(HASH_TABLE_SIZE - 1)
-#define HASH_BASE_OFFSET	2166136261U
-#define HASH_FOLD(a)		((a)&(HASH_MASK))
-
-/* flags to mark symbols */
-#define SYM_FLAG_VALID		1
-#define SYM_FLAG_SAMPLED	2
 
 struct sym_entry {
 	unsigned long long addr;
-	char type;
-	unsigned char flags;
-	unsigned char len;
+	unsigned int len;
 	unsigned char *sym;
 };
 
 
 static struct sym_entry *table;
-static int size, cnt;
+static unsigned int table_size, table_cnt;
 static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
 static int all_symbols = 0;
 static char symbol_prefix_char = '\0';
 
-struct token {
-	unsigned char data[MAX_TOK_SIZE];
-	unsigned char len;
-	/* profit: the number of bytes that could be saved by inserting this
-	 * token into the table */
-	int profit;
-	struct token *next;	/* next token on the hash list */
-	struct token *right;	/* next token on the good/bad list */
-	struct token *left;    /* previous token on the good/bad list */
-	struct token *smaller; /* token that is less one letter than this one */
-	};
-
-struct token bad_head, good_head;
-struct token *hash_table[HASH_TABLE_SIZE];
+int token_profit[0x10000];
 
 /* the table that holds the result of the compression */
-unsigned char best_table[256][MAX_TOK_SIZE+1];
+unsigned char best_table[256][2];
 unsigned char best_table_len[256];
 
 
-static void
-usage(void)
+static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--symbol-prefix=<prefix char>] < in.map > out.S\n");
 	exit(1);
@@ -102,21 +64,19 @@ usage(void)
  * This ignores the intensely annoying "mapping symbols" found
  * in ARM ELF files: $a, $t and $d.
  */
-static inline int
-is_arm_mapping_symbol(const char *str)
+static inline int is_arm_mapping_symbol(const char *str)
 {
 	return str[0] == '$' && strchr("atd", str[1])
 	       && (str[2] == '\0' || str[2] == '.');
 }
 
-static int
-read_symbol(FILE *in, struct sym_entry *s)
+static int read_symbol(FILE *in, struct sym_entry *s)
 {
 	char str[500];
-	char *sym;
+	char *sym, stype;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &s->type, str);
+	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, str);
 	if (rc != 3) {
 		if (rc != EOF) {
 			/* skip line */
@@ -143,7 +103,7 @@ read_symbol(FILE *in, struct sym_entry *
 		_sextratext = s->addr;
 	else if (strcmp(sym, "_eextratext") == 0)
 		_eextratext = s->addr;
-	else if (toupper(s->type) == 'A')
+	else if (toupper(stype) == 'A')
 	{
 		/* Keep these useful absolute symbols */
 		if (strcmp(sym, "__kernel_syscall_via_break") &&
@@ -153,22 +113,21 @@ read_symbol(FILE *in, struct sym_entry *
 			return -1;
 
 	}
-	else if (toupper(s->type) == 'U' ||
+	else if (toupper(stype) == 'U' ||
 		 is_arm_mapping_symbol(sym))
 		return -1;
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
 	s->len = strlen(str) + 1;
-	s->sym = (char *) malloc(s->len + 1);
-	strcpy(s->sym + 1, str);
-	s->sym[0] = s->type;
+	s->sym = malloc(s->len + 1);
+	strcpy((char *)s->sym + 1, str);
+	s->sym[0] = stype;
 
 	return 0;
 }
 
-static int
-symbol_valid(struct sym_entry *s)
+static int symbol_valid(struct sym_entry *s)
 {
 	/* Symbols which vary between passes.  Passes 1 and 2 must have
 	 * identical symbol lists.  The kallsyms_* symbols below are only added
@@ -214,30 +173,29 @@ symbol_valid(struct sym_entry *s)
 	}
 
 	/* Exclude symbols which vary between passes. */
-	if (strstr(s->sym + offset, "_compiled."))
+	if (strstr((char *)s->sym + offset, "_compiled."))
 		return 0;
 
 	for (i = 0; special_symbols[i]; i++)
-		if( strcmp(s->sym + offset, special_symbols[i]) == 0 )
+		if( strcmp((char *)s->sym + offset, special_symbols[i]) == 0 )
 			return 0;
 
 	return 1;
 }
 
-static void
-read_map(FILE *in)
+static void read_map(FILE *in)
 {
 	while (!feof(in)) {
-		if (cnt >= size) {
-			size += 10000;
-			table = realloc(table, sizeof(*table) * size);
+		if (table_cnt >= table_size) {
+			table_size += 10000;
+			table = realloc(table, sizeof(*table) * table_size);
 			if (!table) {
 				fprintf(stderr, "out of memory\n");
 				exit (1);
 			}
 		}
-		if (read_symbol(in, &table[cnt]) == 0)
-			cnt++;
+		if (read_symbol(in, &table[table_cnt]) == 0)
+			table_cnt++;
 	}
 }
 
@@ -281,10 +239,9 @@ static int expand_symbol(unsigned char *
 	return total;
 }
 
-static void
-write_src(void)
+static void write_src(void)
 {
-	int i, k, off, valid;
+	unsigned int i, k, off;
 	unsigned int best_idx[256];
 	unsigned int *markers;
 	char buf[KSYM_NAME_LEN+1];
@@ -301,33 +258,24 @@ write_src(void)
 	printf(".data\n");
 
 	output_label("kallsyms_addresses");
-	valid = 0;
-	for (i = 0; i < cnt; i++) {
-		if (table[i].flags & SYM_FLAG_VALID) {
-			printf("\tPTR\t%#llx\n", table[i].addr);
-			valid++;
-		}
+	for (i = 0; i < table_cnt; i++) {
+		printf("\tPTR\t%#llx\n", table[i].addr);
 	}
 	printf("\n");
 
 	output_label("kallsyms_num_syms");
-	printf("\tPTR\t%d\n", valid);
+	printf("\tPTR\t%d\n", table_cnt);
 	printf("\n");
 
 	/* table of offset markers, that give the offset in the compressed stream
 	 * every 256 symbols */
-	markers = (unsigned int *) malloc(sizeof(unsigned int)*((valid + 255) / 256));
+	markers = (unsigned int *) malloc(sizeof(unsigned int) * ((table_cnt + 255) / 256));
 
 	output_label("kallsyms_names");
-	valid = 0;
 	off = 0;
-	for (i = 0; i < cnt; i++) {
-
-		if (!table[i].flags & SYM_FLAG_VALID)
-			continue;
-
-		if ((valid & 0xFF) == 0)
-			markers[valid >> 8] = off;
+	for (i = 0; i < table_cnt; i++) {
+		if ((i & 0xFF) == 0)
+			markers[i >> 8] = off;
 
 		printf("\t.byte 0x%02x", table[i].len);
 		for (k = 0; k < table[i].len; k++)
@@ -335,12 +283,11 @@ write_src(void)
 		printf("\n");
 
 		off += table[i].len + 1;
-		valid++;
 	}
 	printf("\n");
 
 	output_label("kallsyms_markers");
-	for (i = 0; i < ((valid + 255) >> 8); i++)
+	for (i = 0; i < ((table_cnt + 255) >> 8); i++)
 		printf("\tPTR\t%d\n", markers[i]);
 	printf("\n");
 
@@ -350,7 +297,7 @@ write_src(void)
 	off = 0;
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
-		expand_symbol(best_table[i],best_table_len[i],buf);
+		expand_symbol(best_table[i], best_table_len[i], buf);
 		printf("\t.asciz\t\"%s\"\n", buf);
 		off += strlen(buf) + 1;
 	}
@@ -365,153 +312,13 @@ write_src(void)
 
 /* table lookup compression functions */
 
-static inline unsigned int rehash_token(unsigned int hash, unsigned char data)
-{
-	return ((hash * 16777619) ^ data);
-}
-
-static unsigned int hash_token(unsigned char *data, int len)
-{
-	unsigned int hash=HASH_BASE_OFFSET;
-	int i;
-
-	for (i = 0; i < len; i++)
-		hash = rehash_token(hash, data[i]);
-
-	return HASH_FOLD(hash);
-}
-
-/* find a token given its data and hash value */
-static struct token *find_token_hash(unsigned char *data, int len, unsigned int hash)
-{
-	struct token *ptr;
-
-	ptr = hash_table[hash];
-
-	while (ptr) {
-		if ((ptr->len == len) && (memcmp(ptr->data, data, len) == 0))
-			return ptr;
-		ptr=ptr->next;
-	}
-
-	return NULL;
-}
-
-static inline void insert_token_in_group(struct token *head, struct token *ptr)
-{
-	ptr->right = head->right;
-	ptr->right->left = ptr;
-	head->right = ptr;
-	ptr->left = head;
-}
-
-static inline void remove_token_from_group(struct token *ptr)
-{
-	ptr->left->right = ptr->right;
-	ptr->right->left = ptr->left;
-}
-
-
-/* build the counts for all the tokens that start with "data", and have lenghts
- * from 2 to "len" */
-static void learn_token(unsigned char *data, int len)
-{
-	struct token *ptr,*last_ptr;
-	int i, newprofit;
-	unsigned int hash = HASH_BASE_OFFSET;
-	unsigned int hashes[MAX_TOK_SIZE + 1];
-
-	if (len > MAX_TOK_SIZE)
-		len = MAX_TOK_SIZE;
-
-	/* calculate and store the hash values for all the sub-tokens */
-	hash = rehash_token(hash, data[0]);
-	for (i = 2; i <= len; i++) {
-		hash = rehash_token(hash, data[i-1]);
-		hashes[i] = HASH_FOLD(hash);
-	}
-
-	last_ptr = NULL;
-	ptr = NULL;
-
-	for (i = len; i >= 2; i--) {
-		hash = hashes[i];
-
-		if (!ptr) ptr = find_token_hash(data, i, hash);
-
-		if (!ptr) {
-			/* create a new token entry */
-			ptr = (struct token *) malloc(sizeof(*ptr));
-
-			memcpy(ptr->data, data, i);
-			ptr->len = i;
-
-			/* when we create an entry, it's profit is 0 because
-			 * we also take into account the size of the token on
-			 * the compressed table. We then subtract GOOD_BAD_THRESHOLD
-			 * so that the test to see if this token belongs to
-			 * the good or bad list, is a comparison to zero */
-			ptr->profit = -GOOD_BAD_THRESHOLD;
-
-			ptr->next = hash_table[hash];
-			hash_table[hash] = ptr;
-
-			insert_token_in_group(&bad_head, ptr);
-
-			ptr->smaller = NULL;
-		} else {
-			newprofit = ptr->profit + (ptr->len - 1);
-			/* check to see if this token needs to be moved to a
-			 * different list */
-			if((ptr->profit < 0) && (newprofit >= 0)) {
-				remove_token_from_group(ptr);
-				insert_token_in_group(&good_head,ptr);
-			}
-			ptr->profit = newprofit;
-		}
-
-		if (last_ptr) last_ptr->smaller = ptr;
-		last_ptr = ptr;
-
-		ptr = ptr->smaller;
-	}
-}
-
-/* decrease the counts for all the tokens that start with "data", and have lenghts
- * from 2 to "len". This function is much simpler than learn_token because we have
- * more guarantees (tho tokens exist, the ->smaller pointer is set, etc.)
- * The two separate functions exist only because of compression performance */
-static void forget_token(unsigned char *data, int len)
-{
-	struct token *ptr;
-	int i, newprofit;
-	unsigned int hash=0;
-
-	if (len > MAX_TOK_SIZE) len = MAX_TOK_SIZE;
-
-	hash = hash_token(data, len);
-	ptr = find_token_hash(data, len, hash);
-
-	for (i = len; i >= 2; i--) {
-
-		newprofit = ptr->profit - (ptr->len - 1);
-		if ((ptr->profit >= 0) && (newprofit < 0)) {
-			remove_token_from_group(ptr);
-			insert_token_in_group(&bad_head, ptr);
-		}
-		ptr->profit=newprofit;
-
-		ptr=ptr->smaller;
-	}
-}
-
 /* count all the possible tokens in a symbol */
 static void learn_symbol(unsigned char *symbol, int len)
 {
 	int i;
 
 	for (i = 0; i < len - 1; i++)
-		learn_token(symbol + i, len - i);
+		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]++;
 }
 
 /* decrease the count for all the possible tokens in a symbol */
@@ -520,117 +327,90 @@ static void forget_symbol(unsigned char 
 	int i;
 
 	for (i = 0; i < len - 1; i++)
-		forget_token(symbol + i, len - i);
+		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]--;
 }
 
-/* set all the symbol flags and do the initial token count */
+/* remove all the invalid symbols from the table and do the initial token count */
 static void build_initial_tok_table(void)
 {
-	int i, use_it, valid;
+	unsigned int i, pos;
 
-	valid = 0;
-	for (i = 0; i < cnt; i++) {
-		table[i].flags = 0;
+	pos = 0;
+	for (i = 0; i < table_cnt; i++) {
 		if ( symbol_valid(&table[i]) ) {
-			table[i].flags |= SYM_FLAG_VALID;
-			valid++;
+			if (pos != i)
+				table[pos] = table[i];
+			learn_symbol(table[pos].sym, table[pos].len);
+			pos++;
 		}
 	}
-
-	use_it = 0;
-	for (i = 0; i < cnt; i++) {
-
-		/* subsample the available symbols. This method is almost like
-		 * a Bresenham's algorithm to get uniformly distributed samples
-		 * across the symbol table */
-		if (table[i].flags & SYM_FLAG_VALID) {
-
-			use_it += WORKING_SET;
-
-			if (use_it >= valid) {
-				table[i].flags |= SYM_FLAG_SAMPLED;
-				use_it -= valid;
-			}
-		}
-		if (table[i].flags & SYM_FLAG_SAMPLED)
-			learn_symbol(table[i].sym, table[i].len);
-	}
+	table_cnt = pos;
 }
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
  * to update the counts */
-static void compress_symbols(unsigned char *str, int tlen, int idx)
+static void compress_symbols(unsigned char *str, int idx)
 {
-	int i, len, learn, size;
-	unsigned char *p;
-
-	for (i = 0; i < cnt; i++) {
+	unsigned int i, len, size;
+	unsigned char *p1, *p2;
 
-		if (!(table[i].flags & SYM_FLAG_VALID)) continue;
+	for (i = 0; i < table_cnt; i++) {
 
 		len = table[i].len;
-		learn = 0;
-		p = table[i].sym;
+		p1 = table[i].sym;
+
+		/* find the token on the symbol */
+		p2 = memmem(p1, len, str, 2);
+		if (!p2) continue;
+
+		/* decrease the counts for this symbol's tokens */
+		forget_symbol(table[i].sym, len);
+
+		size = len;
 
 		do {
+			*p2 = idx;
+			p2++;
+			size -= (p2 - p1);
+			memmove(p2, p2 + 1, size);
+			p1 = p2;
+			len--;
+
+			if (size < 2) break;
+
 			/* find the token on the symbol */
-			p = (unsigned char *) strstr((char *) p, (char *) str);
-			if (!p) break;
+			p2 = memmem(p1, size, str, 2);
 
-			if (!learn) {
-				/* if this symbol was used to count, decrease it */
-				if (table[i].flags & SYM_FLAG_SAMPLED)
-					forget_symbol(table[i].sym, len);
-				learn = 1;
-			}
+		} while (p2);
 
-			*p = idx;
-			size = (len - (p - table[i].sym)) - tlen + 1;
-			memmove(p + 1, p + tlen, size);
-			p++;
-			len -= tlen - 1;
-
-		} while (size >= tlen);
-
-		if(learn) {
-			table[i].len = len;
-			/* if this symbol was used to count, learn it again */
-			if(table[i].flags & SYM_FLAG_SAMPLED)
-				learn_symbol(table[i].sym, len);
-		}
+		table[i].len = len;
+
+		/* increase the counts for this symbol's new tokens */
+		learn_symbol(table[i].sym, len);
 	}
 }
 
 /* search the token with the maximum profit */
-static struct token *find_best_token(void)
+static int find_best_token(void)
 {
-	struct token *ptr,*best,*head;
-	int bestprofit;
+	int i, best, bestprofit;
 
 	bestprofit=-10000;
+	best = 0;
 
-	/* failsafe: if the "good" list is empty search from the "bad" list */
-	if(good_head.right == &good_head) head = &bad_head;
-	else head = &good_head;
-
-	ptr = head->right;
-	best = NULL;
-	while (ptr != head) {
-		if (ptr->profit > bestprofit) {
-			bestprofit = ptr->profit;
-			best = ptr;
+	for (i = 0; i < 0x10000; i++) {
+		if (token_profit[i] > bestprofit) {
+			best = i;
+			bestprofit = token_profit[i];
 		}
-		ptr = ptr->right;
 	}
-
 	return best;
 }
 
 /* this is the core of the algorithm: calculate the "best" table */
 static void optimize_result(void)
 {
-	struct token *best;
-	int i;
+	int i, best;
 
 	/* using the '\0' symbol last allows compress_symbols to use standard
 	 * fast string functions */
@@ -644,14 +424,12 @@ static void optimize_result(void)
 			best = find_best_token();
 
 			/* place it in the "best" table */
-			best_table_len[i] = best->len;
-			memcpy(best_table[i], best->data, best_table_len[i]);
-			/* zero terminate the token so that we can use strstr
-			   in compress_symbols */
-			best_table[i][best_table_len[i]]='\0';
+			best_table_len[i] = 2;
+			best_table[i][0] = best & 0xFF;
+			best_table[i][1] = (best >> 8) & 0xFF;
 
 			/* replace this token in all the valid symbols */
-			compress_symbols(best_table[i], best_table_len[i], i);
+			compress_symbols(best_table[i], i);
 		}
 	}
 }
@@ -659,39 +437,28 @@ static void optimize_result(void)
 /* start by placing the symbols that are actually used on the table */
 static void insert_real_symbols_in_table(void)
 {
-	int i, j, c;
+	unsigned int i, j, c;
 
 	memset(best_table, 0, sizeof(best_table));
 	memset(best_table_len, 0, sizeof(best_table_len));
 
-	for (i = 0; i < cnt; i++) {
-		if (table[i].flags & SYM_FLAG_VALID) {
-			for (j = 0; j < table[i].len; j++) {
-				c = table[i].sym[j];
-				best_table[c][0]=c;
-				best_table_len[c]=1;
-			}
+	for (i = 0; i < table_cnt; i++) {
+		for (j = 0; j < table[i].len; j++) {
+			c = table[i].sym[j];
+			best_table[c][0]=c;
+			best_table_len[c]=1;
 		}
 	}
 }
 
 static void optimize_token_table(void)
 {
-	memset(hash_table, 0, sizeof(hash_table));
-
-	good_head.left = &good_head;
-	good_head.right = &good_head;
-
-	bad_head.left = &bad_head;
-	bad_head.right = &bad_head;
-
 	build_initial_tok_table();
 
 	insert_real_symbols_in_table();
 
 	/* When valid symbol is not registered, exit to error */
-	if (good_head.left == good_head.right &&
-	    bad_head.left == bad_head.right) {
+	if (!table_cnt) {
 		fprintf(stderr, "No valid symbol.\n");
 		exit(1);
 	}
@@ -700,8 +467,7 @@ static void optimize_token_table(void)
 }
 
 
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	if (argc >= 2) {
 		int i;

--------------030906090108090302000903--
