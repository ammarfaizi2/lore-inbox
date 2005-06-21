Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVFUWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVFUWkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVFUWil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:38:41 -0400
Received: from smtp05.auna.com ([62.81.186.15]:16794 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262410AbVFUWJO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:09:14 -0400
Date: Tue, 21 Jun 2005 22:09:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] more signed char cleanups in scripts
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org> (from akpm@osdl.org on
	Mon Jun 20 08:30:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119391748l.25237l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Wed, 22 Jun 2005 00:09:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.20, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 

This cleans the last signedness problems I have seen in scripts, at least
what I can see with make oldconfig, make config, make menuconfig, 
make gconfig and make.

I would like you to take a special look at the kallsyms.c changes.
I have not seen anything related to arithmetic where signedness could matter,
except probably this:

-static inline unsigned int rehash_token(unsigned int hash, unsigned char data)
+static inline unsigned int rehash_token(unsigned int hash, char data)
 {  
-   return ((hash * 16777619) ^ data);
+   return ((hash * 16777619) ^ (unsigned char)data);
 }

so I casted it explicitely to 'unsigned'.

Patch follows:

--- linux-2.6.12-jam1/scripts/mod/sumversion.c.orig	2005-06-21 23:44:30.000000000 +0200
+++ linux-2.6.12-jam1/scripts/mod/sumversion.c	2005-06-21 23:47:09.000000000 +0200
@@ -252,9 +252,9 @@
 }
 
 /* FIXME: Handle .s files differently (eg. # starts comments) --RR */
-static int parse_file(const signed char *fname, struct md4_ctx *md)
+static int parse_file(const char *fname, struct md4_ctx *md)
 {
-	signed char *file;
+	char *file;
 	unsigned long i, len;
 
 	file = grab_file(fname, &len);
@@ -332,7 +332,7 @@
 	   Sum all files in the same dir or subdirs.
 	*/
 	while ((line = get_next_line(&pos, file, flen)) != NULL) {
-		signed char* p = line;
+		char* p = line;
 		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
 			check_files = 1;
 			continue;
@@ -458,7 +458,7 @@
 	close(fd);
 }
 
-static int strip_rcs_crap(signed char *version)
+static int strip_rcs_crap(char *version)
 {
 	unsigned int len, full_len;
 
--- linux-2.6.12-jam1/scripts/lxdialog/inputbox.c.orig	2005-06-21 23:40:27.000000000 +0200
+++ linux-2.6.12-jam1/scripts/lxdialog/inputbox.c	2005-06-21 23:42:39.000000000 +0200
@@ -21,7 +21,7 @@
 
 #include "dialog.h"
 
-unsigned char dialog_input_result[MAX_LEN + 1];
+char dialog_input_result[MAX_LEN + 1];
 
 /*
  *  Print the termination buttons
@@ -48,7 +48,7 @@
 {
     int i, x, y, box_y, box_x, box_width;
     int input_x = 0, scroll = 0, key = 0, button = -1;
-    unsigned char *instr = dialog_input_result;
+    char *instr = dialog_input_result;
     WINDOW *dialog;
 
     /* center dialog box on screen */
--- linux-2.6.12-jam1/scripts/lxdialog/dialog.h.orig	2005-06-21 23:42:55.000000000 +0200
+++ linux-2.6.12-jam1/scripts/lxdialog/dialog.h	2005-06-21 23:43:19.000000000 +0200
@@ -163,7 +163,7 @@
 int dialog_checklist (const char *title, const char *prompt, int height,
 		int width, int list_height, int item_no,
 		const char * const * items, int flag);
-extern unsigned char dialog_input_result[];
+extern char dialog_input_result[];
 int dialog_inputbox (const char *title, const char *prompt, int height,
 		int width, const char *init);
 
--- linux-2.6.12-jam1/scripts/kallsyms.c.orig	2005-06-21 23:47:43.000000000 +0200
+++ linux-2.6.12-jam1/scripts/kallsyms.c	2005-06-21 23:52:37.000000000 +0200
@@ -61,7 +61,7 @@
 	char type;
 	unsigned char flags;
 	unsigned char len;
-	unsigned char *sym;
+	char *sym;
 };
 
 
@@ -87,7 +87,7 @@
 struct token *hash_table[HASH_TABLE_SIZE];
 
 /* the table that holds the result of the compression */
-unsigned char best_table[256][MAX_TOK_SIZE+1];
+char best_table[256][MAX_TOK_SIZE+1];
 unsigned char best_table_len[256];
 
 
@@ -160,7 +160,7 @@
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
 	s->len = strlen(str) + 1;
-	s->sym = (char *) malloc(s->len + 1);
+	s->sym = malloc(s->len + 1);
 	strcpy(s->sym + 1, str);
 	s->sym[0] = s->type;
 
@@ -256,7 +256,7 @@
 
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
-static int expand_symbol(unsigned char *data, int len, char *result)
+static int expand_symbol(char *data, int len, char *result)
 {
 	int c, rlen, total=0;
 
@@ -365,12 +365,12 @@
 
 /* table lookup compression functions */
 
-static inline unsigned int rehash_token(unsigned int hash, unsigned char data)
+static inline unsigned int rehash_token(unsigned int hash, char data)
 {
-	return ((hash * 16777619) ^ data);
+	return ((hash * 16777619) ^ (unsigned char)data);
 }
 
-static unsigned int hash_token(unsigned char *data, int len)
+static unsigned int hash_token(char *data, int len)
 {
 	unsigned int hash=HASH_BASE_OFFSET;
 	int i;
@@ -382,7 +382,7 @@
 }
 
 /* find a token given its data and hash value */
-static struct token *find_token_hash(unsigned char *data, int len, unsigned int hash)
+static struct token *find_token_hash(char *data, int len, unsigned int hash)
 {
 	struct token *ptr;
 
@@ -414,7 +414,7 @@
 
 /* build the counts for all the tokens that start with "data", and have lenghts
  * from 2 to "len" */
-static void learn_token(unsigned char *data, int len)
+static void learn_token(char *data, int len)
 {
 	struct token *ptr,*last_ptr;
 	int i, newprofit;
@@ -481,7 +481,7 @@
  * from 2 to "len". This function is much simpler than learn_token because we have
  * more guarantees (tho tokens exist, the ->smaller pointer is set, etc.)
  * The two separate functions exist only because of compression performance */
-static void forget_token(unsigned char *data, int len)
+static void forget_token(char *data, int len)
 {
 	struct token *ptr;
 	int i, newprofit;
@@ -506,7 +506,7 @@
 }
 
 /* count all the possible tokens in a symbol */
-static void learn_symbol(unsigned char *symbol, int len)
+static void learn_symbol(char *symbol, int len)
 {
 	int i;
 
@@ -515,7 +515,7 @@
 }
 
 /* decrease the count for all the possible tokens in a symbol */
-static void forget_symbol(unsigned char *symbol, int len)
+static void forget_symbol(char *symbol, int len)
 {
 	int i;
 
@@ -559,10 +559,10 @@
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
  * to update the counts */
-static void compress_symbols(unsigned char *str, int tlen, int idx)
+static void compress_symbols(char *str, int tlen, int idx)
 {
 	int i, len, learn, size;
-	unsigned char *p;
+	char *p;
 
 	for (i = 0; i < cnt; i++) {
 
@@ -574,7 +574,7 @@
 
 		do {
 			/* find the token on the symbol */
-			p = (unsigned char *) strstr((char *) p, (char *) str);
+			p = strstr(p, str);
 			if (!p) break;
 
 			if (!learn) {


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


