Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUJZCz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUJZCz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUJZCzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:55:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37874 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261916AbUJZBvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:51:41 -0400
Date: Mon, 25 Oct 2004 15:49:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Jean-Christophe Dubois <jdubois@mc.com>, kai@germaschewski.name,
       sam@ravnborg.org
Subject: [PATCH 2.6.9] kbuild warning fixes on Solaris 9
Message-ID: <20041025224907.GL25154@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches is based loosely on the patches that
Jean-Christophe Dubois came up with for 2.6.7.  Where as the original
patches added a number of casts to unsigned char, I went the route of
making the chars be explicitly signed.  I honestly don't know which
route is better to go down.  Doing this is the bulk of the patch.  Out
of the rest of the odds 'n ends is that on Solaris, Elf32_Word is a
ulong, which means all of the printf's are unhappy (uint format, ulong
arg) for most of the typedefs.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Comments?  Beatings?  Thanks.

--- linux-2.6.9.orig/arch/ppc/boot/utils/mkbugboot.c
+++ linux-2.6.9/arch/ppc/boot/utils/mkbugboot.c
@@ -96,7 +96,7 @@
   uint8_t header_block[HEADER_SIZE];
   bug_boot_header_t *bbh = (bug_boot_header_t *)&header_block[0];
 
-  bzero(header_block, HEADER_SIZE);
+  memset(header_block, 0, HEADER_SIZE);
 
   /* Fill in the PPCBUG ROM boot header */
   strncpy(bbh->magic_word, "BOOT", 4);		/* PPCBUG magic word */
--- linux-2.6.9.orig/scripts/kconfig/conf.c
+++ linux-2.6.9/scripts/kconfig/conf.c
@@ -32,14 +32,14 @@
 static int mvl_default_new = 0;
 static int valid_stdin = 1;
 static int conf_cnt;
-static char line[128];
+static signed char line[128];
 static struct menu *rootEntry;
 
 static char nohelp_text[] = "Sorry, no help available for this option yet.\n";
 
-static void strip(char *str)
+static void strip(signed char *str)
 {
-	char *p = str;
+	signed char *p = str;
 	int l;
 
 	while ((isspace(*p)))
--- linux-2.6.9.orig/scripts/conmakehash.c
+++ linux-2.6.9/scripts/conmakehash.c
@@ -33,7 +33,7 @@
 
 int getunicode(char **p0)
 {
-  char *p = *p0;
+  unsigned char *p = *p0;
 
   while (*p == ' ' || *p == '\t')
     p++;
--- linux-2.6.9.orig/scripts/basic/split-include.c
+++ linux-2.6.9/scripts/basic/split-include.c
@@ -104,7 +104,7 @@
     /* Read config lines. */
     while (fgets(line, buffer_size, fp_config))
     {
-	const char * str_config;
+	const signed char * str_config;
 	int is_same;
 	int itarget;
 
--- linux-2.6.9.orig/scripts/basic/docproc.c
+++ linux-2.6.9/scripts/basic/docproc.c
@@ -52,7 +52,7 @@
 FILEONLY *externalfunctions;
 FILEONLY *symbolsonly;
 
-typedef void FILELINE(char * file, char * line);
+typedef void FILELINE(char * file, signed char * line);
 FILELINE * singlefunctions;
 FILELINE * entity_system;
 
@@ -148,9 +148,9 @@
  * Files are separated by tabs.
  */
 void adddep(char * file)		   { printf("\t%s", file); }
-void adddep2(char * file, char * line)     { line = line; adddep(file); }
+void adddep2(char * file, signed char * line)     { line = line; adddep(file); }
 void noaction(char * line)		   { line = line; }
-void noaction2(char * file, char * line)   { file = file; line = line; }
+void noaction2(char * file, signed char * line)   { file = file; line = line; }
 
 /* Echo the line without further action */
 void printline(char * line)               { printf("%s", line); }
@@ -179,8 +179,8 @@
 			perror(real_filename);
 		}
 		while(fgets(line, MAXLINESZ, fp)) {
-			char *p;
-			char *e;
+			signed char *p;
+			signed char *e;
 			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
                             ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
 				/* Skip EXPORT_SYMBOL{_GPL} */
@@ -253,7 +253,7 @@
  * Call kernel-doc with the following parameters:
  * kernel-doc -docbook -function function1 [-function function2]
  */
-void singfunc(char * filename, char * line)
+void singfunc(char * filename, signed char * line)
 {
 	char *vec[200]; /* Enough for specific functions */
         int i, idx = 0;
@@ -290,7 +290,7 @@
 void parse_file(FILE *infile)
 {
 	char line[MAXLINESZ];
-	char * s;
+	signed char * s;
 	while(fgets(line, MAXLINESZ, infile)) {
 		if (line[0] == '!') {
 			s = line + 2;
--- linux-2.6.9.orig/scripts/kconfig/symbol.c
+++ linux-2.6.9/scripts/kconfig/symbol.c
@@ -421,7 +421,7 @@
 
 bool sym_string_valid(struct symbol *sym, const char *str)
 {
-	char ch;
+	signed char ch;
 
 	switch (sym->type) {
 	case S_STRING:
--- linux-2.6.9.orig/scripts/basic/fixdep.c
+++ linux-2.6.9/scripts/basic/fixdep.c
@@ -217,12 +217,12 @@
 	printf("    $(wildcard include/config/%s.h) \\\n", s);
 }
 
-void parse_config_file(char *map, size_t len)
+void parse_config_file(signed char *map, size_t len)
 {
 	int *end = (int *) (map + len);
 	/* start at +1, so that p can never be < map */
 	int *m   = (int *) map + 1;
-	char *p, *q;
+	signed char *p, *q;
 
 	for (; m < end; m++) {
 		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
@@ -291,9 +291,9 @@
 
 void parse_dep_file(void *map, size_t len)
 {
-	char *m = map;
-	char *end = m + len;
-	char *p;
+	signed char *m = map;
+	signed char *end = m + len;
+	signed char *p;
 	char s[PATH_MAX];
 
 	p = strchr(m, ':');
--- linux-2.6.9.orig/scripts/kconfig/mconf.c
+++ linux-2.6.9/scripts/kconfig/mconf.c
@@ -82,8 +82,8 @@
 	"leave this blank.\n"
 ;
 
-static char buf[4096], *bufptr = buf;
-static char input_buf[4096];
+static signed char buf[4096], *bufptr = buf;
+static signed char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
 static char *args[1024], **argptr = args;
 static int indent;
--- linux-2.6.9.orig/scripts/kconfig/confdata.c
+++ linux-2.6.9/scripts/kconfig/confdata.c
@@ -27,10 +27,10 @@
 	NULL,
 };
 
-static char *conf_expand_value(const char *in)
+static char *conf_expand_value(const signed char *in)
 {
 	struct symbol *sym;
-	const char *src;
+	const signed char *src;
 	static char res_value[SYMBOL_MAXLENGTH];
 	char *dst, name[SYMBOL_MAXLENGTH];
 
@@ -293,7 +293,7 @@
 	} else
 		basename = conf_def_filename;
 
-	sprintf(newname, "%s.tmpconfig.%d", dirname, getpid());
+	sprintf(newname, "%s.tmpconfig.%d", dirname, (int)getpid());
 	out = fopen(newname, "w");
 	if (!out)
 		return 1;
--- linux-2.6.9.orig/scripts/mod/sumversion.c
+++ linux-2.6.9/scripts/mod/sumversion.c
@@ -285,9 +285,9 @@
 }
 
 /* FIXME: Handle .s files differently (eg. # starts comments) --RR */
-static int parse_file(const char *fname, struct md4_ctx *md)
+static int parse_file(const signed char *fname, struct md4_ctx *md)
 {
-	char *file;
+	signed char *file;
 	unsigned long i, len;
 
 	file = grab_file(fname, &len);
@@ -365,7 +365,7 @@
 	   Sum all files in the same dir or subdirs.
 	*/
 	while ((line = get_next_line(&pos, file, flen)) != NULL) {
-		char* p = line;
+		signed char* p = line;
 		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
 			check_files = 1;
 			continue;
@@ -492,7 +492,7 @@
 	close(fd);
 }
 
-void strip_rcs_crap(char *version)
+void strip_rcs_crap(signed char *version)
 {
 	unsigned int len, full_len;
 
--- linux-2.6.9.orig/scripts/mod/file2alias.c
+++ linux-2.6.9/scripts/mod/file2alias.c
@@ -12,17 +12,22 @@
 
 #include "modpost.h"
 
-/* We use the ELF typedefs, since we can't rely on stdint.h being present. */
-
+/* We use the ELF typedefs for kernel_ulong_t but bite the bullet and
+ * use either stdint.h or inttypes.h for the rest. */
 #if KERNEL_ELFCLASS == ELFCLASS32
-typedef Elf32_Addr     kernel_ulong_t;
+typedef Elf32_Addr	kernel_ulong_t;
+#else
+typedef Elf64_Addr	kernel_ulong_t;
+#endif
+#ifdef __sun__
+#include <inttypes.h>
 #else
-typedef Elf64_Addr     kernel_ulong_t;
+#include <stdint.h>
 #endif
 
-typedef Elf32_Word     __u32;
-typedef Elf32_Half     __u16;
-typedef unsigned char  __u8;
+typedef uint32_t	__u32;
+typedef uint16_t	__u16;
+typedef unsigned char	__u8;
 
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since 
--- linux-2.6.9.orig/scripts/mod/modpost.c
+++ linux-2.6.9/scripts/mod/modpost.c
@@ -215,7 +215,7 @@
 	static char line[4096];
 	int skip = 1;
 	size_t len = 0;
-	char *p = (char *)file + *pos;
+	signed char *p = (char *)file + *pos;
 	char *s = line;
 
 	for (; *pos < size ; (*pos)++)

-- 
Tom Rini
http://gate.crashing.org/~trini/
