Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUICDIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUICDIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269115AbUICDDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:03:40 -0400
Received: from [195.23.16.24] ([195.23.16.24]:53989 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269308AbUICDAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:00:12 -0400
Message-ID: <4137DE2C.9020208@grupopie.com>
Date: Fri, 03 Sep 2004 03:59:56 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: sam@ravnborg.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: [PATCH] kallsyms: correct type char in /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com>	<1094016277.17828.53.camel@bach>	<4135AFBE.1000707@grupopie.com>	<20040901192755.GC7219@mars.ravnborg.org>	<41362694.9070101@grupopie.com>	<20040901195132.GA15432@mars.ravnborg.org>	<41370C7E.4020304@grupopie.com>	<20040902221733.GA8868@mars.ravnborg.org>	<1094175114.4137c98a2b4ae@webmail.grupopie.com> <20040902183156.14c066ec.akpm@osdl.org>
In-Reply-To: <20040902183156.14c066ec.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050407030008030607010200"
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.44; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407030008030607010200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ...
> 
> In that case please prepare diffs against -mm.  I've dropped a
> snapshot patch against 2.6.9-rc1 at
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2

Thanks!

This patch removes the is-exported bit from the last patch and
implements a complete type char, so that /proc/kallsyms
resembles better the System.map file.

In fact, if compiled with KALLSYMS_ALL the only differences
between /proc/kallsyms and System.map are the symbols that are
left out on purpose: types 'A' and 'U', and kallsyms_xxx.

I removed these symbols from System.map and diff'ed against
/proc/kallsyms and the files where completely identical :)

The System.map file occupied about 980Kb whereas the kallsyms data
needed to generate the same output occupied about 440Kb.

The patch should apply over the last one, in case someone wants
to test it, without needing the -mm snapshot.

I'm sending it attached this time to avoid the problems we had the
last time.

Comments, suggestions, flames are always welcome :)

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978

--------------050407030008030607010200
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- linux-2.6.9-rc1-mmsnap/kernel/kallsyms.c	2004-09-03 02:59:57.000000000 +0100
+++ linux-2.6.9-rc1-kall/kernel/kallsyms.c	2004-09-03 02:28:01.000000000 +0100
@@ -51,17 +51,16 @@ static inline int is_kernel_text(unsigne
    given the offset to where the symbol is in the compressed stream */
 static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
 {
-	int len;
+	int len, skipped_first = 0;
 	u8 *tptr, *data;

-	/* get the compressed symbol length from the first symbol byte,
-	 * masking out the "is_exported" bit */
+	/* get the compressed symbol length from the first symbol byte */
 	data = &kallsyms_names[off];
-	len = (*data) & 0x7F;
+	len = *data;
 	data++;
 
 	/* update the offset to return the offset for the next symbol on
-	   the compressed stream */
+	 * the compressed stream */
 	off += len + 1;
 
 	/* for every byte on the compressed symbol data, copy the table
@@ -72,8 +71,11 @@ static unsigned int kallsyms_expand_symb
 		len--;
 
 		while (*tptr) {
-			*result = *tptr;
-			result++;
+			if(skipped_first) {
+				*result = *tptr;
+				result++;
+			} else
+				skipped_first = 1;
 			tptr++;
 		}
 	}
@@ -84,24 +86,33 @@ static unsigned int kallsyms_expand_symb
 	return off;
 }
 
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
 /* find the offset on the compressed stream given and index in the
-   kallsyms array */
+ * kallsyms array */
 static unsigned int get_symbol_offset(unsigned long pos)
 {
 	u8 *name;
 	int i;
 
-        /* use the closest marker we have. We have markers every
-           256 positions, so that should be close enough */
+	/* use the closest marker we have. We have markers every 256 positions,
+	 * so that should be close enough */
 	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
 
-        /* sequentially scan all the symbols up to the point we're
-           searching for. Every symbol is stored in a
-	   [bit 7: is_exported | bits 6..0: <len>][<len> bytes of data]
-	   format, so we just need to add the len to the current
-	   pointer for every symbol we wish to skip */
+	/* sequentially scan all the symbols up to the point we're searching for.
+	 * Every symbol is stored in a [<len>][<len> bytes of data] format, so we
+	 * just need to add the len to the current pointer for every symbol we
+	 * wish to skip */
 	for(i = 0; i < (pos&0xFF); i++)
-		name = name + ((*name) & 0x7F) + 1;
+		name = name + (*name) + 1;
 
 	return name - kallsyms_names;
 }
@@ -243,15 +254,8 @@ static unsigned long get_ksymbol_core(st
 
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
-
-	if (is_kernel_text(iter->value) || is_kernel_inittext(iter->value))
-		iter->type = 't';
-	else
-		iter->type = 'd';
-
-	/* check the "is_exported" bit on the compressed stream */
-	if (kallsyms_names[off] & 0x80)
-		iter->type += 'A' - 'a';
+
+	iter->type = kallsyms_get_symbol_type(off);

 	off = kallsyms_expand_symbol(off, iter->name);

--- linux-2.6.9-rc1-mmsnap/scripts/kallsyms.c	2004-09-03 02:59:57.000000000 +0100
+++ linux-2.6.9-rc1-kall/scripts/kallsyms.c	2004-09-03 02:35:25.000000000 +0100
@@ -55,7 +55,6 @@
 /* flags to mark symbols */
 #define SYM_FLAG_VALID		1
 #define SYM_FLAG_SAMPLED	2
-#define SYM_FLAG_EXPORTED	4

 struct sym_entry {
 	unsigned long long addr;
@@ -68,12 +67,9 @@ struct sym_entry {

 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext, _start_ksymtab, _stop_ksymtab;
+static unsigned long long _stext, _etext, _sinittext, _einittext;
 static int all_symbols = 0;

-/* aray of pointers into the symbol table sorted by name */
-static struct sym_entry **sorted_table;
-
 struct token {
 	unsigned char data[MAX_TOK_SIZE];
 	unsigned char len;
@@ -125,45 +121,56 @@ read_symbol(FILE *in, struct sym_entry *
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
-	else if (strcmp(str, "__start___ksymtab") == 0)
-		_start_ksymtab = s->addr;
-	else if (strcmp(str, "__stop___ksymtab") == 0)
-		_stop_ksymtab = s->addr;
 	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
 		return -1;
 
-	s->sym = strdup(str);
-	s->len = strlen(str);
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
-	    strcmp(s->sym, "kallsyms_names") == 0 ||
-	    strcmp(s->sym, "kallsyms_markers") == 0 ||
-	    strcmp(s->sym, "kallsyms_token_table") == 0 ||
-	    strcmp(s->sym, "kallsyms_token_index") == 0)
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
@@ -267,9 +274,7 @@ write_src(void)
 		if ((valid & 0xFF) == 0)
 			markers[valid >> 8] = off;
 
-		k = table[i].len;
-		if (table[i].flags & SYM_FLAG_EXPORTED) k |= 0x80;
-		printf("\t.byte 0x%02x", k);
+		printf("\t.byte 0x%02x", table[i].len);
 		for (k = 0; k < table[i].len; k++)
 			printf(", 0x%02x", table[i].sym[k]);
 		printf("\n");
@@ -463,47 +468,11 @@ static void forget_symbol(unsigned char 
 		forget_token(symbol + i, len - i);
 }
 
-static int symbol_sort(const void *a, const void *b)
-{
-	return strcmp( (*((struct sym_entry **) a))->sym,
-				(*((struct sym_entry **) b))->sym );
-}
-
-
-/* find out if a symbol is exported. Exported symbols have a corresponding
- * __ksymtab_<symbol> entry and their addresses are between __start___ksymtab
- * and __stop___ksymtab */
-static int is_exported(char *name)
-{
-	struct sym_entry key, *ksym, **result;
-	char buf[KSYM_NAME_LEN+32];
-
-	sprintf(buf, "__ksymtab_%s", name);
-	key.sym = buf;
-
-	ksym = &key;
-	result = bsearch(&ksym, sorted_table, cnt,
-				sizeof(struct sym_entry *), symbol_sort);
-
-	if(!result) return 0;
-
-	ksym = *result;
-
-	return ((ksym->addr >= _start_ksymtab) && (ksym->addr < _stop_ksymtab));
-}
-
 /* set all the symbol flags and do the initial token count */
 static void build_initial_tok_table(void)
 {
 	int i, use_it, valid;
 
-	/* build a sorted symbol pointer array so that searching a particular
-	 * symbol is faster */
-	sorted_table = (struct sym_entry **) malloc(sizeof(struct sym_entry *) * cnt);
-	for (i = 0; i < cnt; i++)
-		sorted_table[i] = &table[i];
-	qsort(sorted_table, cnt, sizeof(struct sym_entry *), symbol_sort);
-
 	valid = 0;
 	for (i = 0; i < cnt; i++) {
 		table[i].flags = 0;
@@ -515,6 +484,10 @@ static void build_initial_tok_table(void
 
 	use_it = 0;
 	for (i = 0; i < cnt; i++) {
+
+		/* subsample the available symbols. This method is almost like
+		 * a Bresenham's algorithm to get uniformly distributed samples
+		 * across the symbol table */
 		if (table[i].flags & SYM_FLAG_VALID) {
 
 			use_it += WORKING_SET;
@@ -523,9 +496,6 @@ static void build_initial_tok_table(void
 				table[i].flags |= SYM_FLAG_SAMPLED;
 				use_it -= valid;
 			}
-
-			if( is_exported(table[i].sym) )
-				table[i].flags |= SYM_FLAG_EXPORTED;
 		}
 		if (table[i].flags & SYM_FLAG_SAMPLED)
 			learn_symbol(table[i].sym, table[i].len);

--------------050407030008030607010200--
