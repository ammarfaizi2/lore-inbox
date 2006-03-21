Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWCUQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWCUQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCUQaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29452 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030349AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 41/46] kbuild: clean-up genksyms
In-Reply-To: <11429580571837-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <1142958057424-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o remove all inlines
o declare everything static which is only used by genksyms.c
o delete unused functions
o delete unused variables
o delete unused stuff in genksyms.h
o properly ident genksyms.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/genksyms/genksyms.c |   80 ++++++++++++++-----------------------------
 scripts/genksyms/genksyms.h |   57 +++++++++----------------------
 2 files changed, 43 insertions(+), 94 deletions(-)

ce560686947fd50b30eaf42045554797f53949dd
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index b798e28..5b0344e 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -37,14 +37,14 @@
 #define HASH_BUCKETS  4096
 
 static struct symbol *symtab[HASH_BUCKETS];
-FILE *debugfile;
+static FILE *debugfile;
 
 int cur_line = 1;
-char *cur_filename, *output_directory;
+char *cur_filename;
 
-int flag_debug, flag_dump_defs, flag_warnings;
-const char *arch = "";
-const char *mod_prefix = "";
+static int flag_debug, flag_dump_defs, flag_warnings;
+static const char *arch = "";
+static const char *mod_prefix = "";
 
 static int errors;
 static int nsyms;
@@ -55,6 +55,9 @@ static const char *const symbol_type_nam
 	"normal", "typedef", "enum", "struct", "union"
 };
 
+static int equal_list(struct string_list *a, struct string_list *b);
+static void print_list(FILE * f, struct string_list *list);
+
 /*----------------------------------------------------------------------*/
 
 static const unsigned int crctab32[] = {
@@ -112,27 +115,26 @@ static const unsigned int crctab32[] = {
 	0x2d02ef8dU
 };
 
-static inline unsigned long
-partial_crc32_one(unsigned char c, unsigned long crc)
+static unsigned long partial_crc32_one(unsigned char c, unsigned long crc)
 {
 	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
 }
 
-static inline unsigned long partial_crc32(const char *s, unsigned long crc)
+static unsigned long partial_crc32(const char *s, unsigned long crc)
 {
 	while (*s)
 		crc = partial_crc32_one(*s++, crc);
 	return crc;
 }
 
-static inline unsigned long crc32(const char *s)
+static unsigned long crc32(const char *s)
 {
 	return partial_crc32(s, 0xffffffff) ^ 0xffffffff;
 }
 
 /*----------------------------------------------------------------------*/
 
-static inline enum symbol_type map_to_ns(enum symbol_type t)
+static enum symbol_type map_to_ns(enum symbol_type t)
 {
 	if (t == SYM_TYPEDEF)
 		t = SYM_NORMAL;
@@ -147,8 +149,8 @@ struct symbol *find_symbol(const char *n
 	struct symbol *sym;
 
 	for (sym = symtab[h]; sym; sym = sym->hash_next)
-		if (map_to_ns(sym->type) == map_to_ns(ns)
-		    && strcmp(name, sym->name) == 0)
+		if (map_to_ns(sym->type) == map_to_ns(ns) &&
+		    strcmp(name, sym->name) == 0)
 			break;
 
 	return sym;
@@ -160,13 +162,14 @@ struct symbol *add_symbol(const char *na
 	unsigned long h = crc32(name) % HASH_BUCKETS;
 	struct symbol *sym;
 
-	for (sym = symtab[h]; sym; sym = sym->hash_next)
+	for (sym = symtab[h]; sym; sym = sym->hash_next) {
 		if (map_to_ns(sym->type) == map_to_ns(type)
 		    && strcmp(name, sym->name) == 0) {
 			if (!equal_list(sym->defn, defn))
 				error_with_pos("redefinition of %s", name);
 			return sym;
 		}
+	}
 
 	sym = xmalloc(sizeof(*sym));
 	sym->name = name;
@@ -193,7 +196,7 @@ struct symbol *add_symbol(const char *na
 
 /*----------------------------------------------------------------------*/
 
-inline void free_node(struct string_list *node)
+void free_node(struct string_list *node)
 {
 	free(node->string);
 	free(node);
@@ -208,7 +211,7 @@ void free_list(struct string_list *s, st
 	}
 }
 
-inline struct string_list *copy_node(struct string_list *node)
+struct string_list *copy_node(struct string_list *node)
 {
 	struct string_list *newnode;
 
@@ -219,22 +222,7 @@ inline struct string_list *copy_node(str
 	return newnode;
 }
 
-struct string_list *copy_list(struct string_list *s, struct string_list *e)
-{
-	struct string_list *h, *p;
-
-	if (s == e)
-		return NULL;
-
-	p = h = copy_node(s);
-	while ((s = s->next) != e)
-		p = p->next = copy_node(s);
-	p->next = NULL;
-
-	return h;
-}
-
-int equal_list(struct string_list *a, struct string_list *b)
+static int equal_list(struct string_list *a, struct string_list *b)
 {
 	while (a && b) {
 		if (a->tag != b->tag || strcmp(a->string, b->string))
@@ -246,7 +234,7 @@ int equal_list(struct string_list *a, st
 	return !a && !b;
 }
 
-static inline void print_node(FILE * f, struct string_list *list)
+static void print_node(FILE * f, struct string_list *list)
 {
 	switch (list->tag) {
 	case SYM_STRUCT:
@@ -270,7 +258,7 @@ static inline void print_node(FILE * f, 
 	}
 }
 
-void print_list(FILE * f, struct string_list *list)
+static void print_list(FILE * f, struct string_list *list)
 {
 	struct string_list **e, **b;
 	struct string_list *tmp, **tmp2;
@@ -299,8 +287,8 @@ void print_list(FILE * f, struct string_
 	}
 }
 
-static unsigned long
-expand_and_crc_list(struct string_list *list, unsigned long crc)
+static unsigned long expand_and_crc_list(struct string_list *list,
+					 unsigned long crc)
 {
 	struct string_list **e, **b;
 	struct string_list *tmp, **tmp2;
@@ -386,9 +374,8 @@ expand_and_crc_list(struct string_list *
 						cur->string);
 				}
 
-				crc =
-				    partial_crc32(symbol_type_name[cur->tag],
-						  crc);
+				crc = partial_crc32(symbol_type_name[cur->tag],
+						    crc);
 				crc = partial_crc32_one(' ', crc);
 				crc = partial_crc32(cur->string, crc);
 				crc = partial_crc32_one(' ', crc);
@@ -437,21 +424,6 @@ void export_symbol(const char *name)
 }
 
 /*----------------------------------------------------------------------*/
-
-void error(const char *fmt, ...)
-{
-	va_list args;
-
-	if (flag_warnings) {
-		va_start(args, fmt);
-		vfprintf(stderr, fmt, args);
-		va_end(args);
-		putc('\n', stderr);
-
-		errors++;
-	}
-}
-
 void error_with_pos(const char *fmt, ...)
 {
 	va_list args;
@@ -469,7 +441,7 @@ void error_with_pos(const char *fmt, ...
 	}
 }
 
-void genksyms_usage(void)
+static void genksyms_usage(void)
 {
 	fputs("Usage:\n" "genksyms [-dDwqhV] > /path/to/.tmp_obj.ver\n" "\n"
 #ifdef __GNU_LIBRARY__
diff --git a/scripts/genksyms/genksyms.h b/scripts/genksyms/genksyms.h
index f09af47..ab6f34f 100644
--- a/scripts/genksyms/genksyms.h
+++ b/scripts/genksyms/genksyms.h
@@ -20,74 +20,51 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-
 #ifndef MODUTILS_GENKSYMS_H
 #define MODUTILS_GENKSYMS_H 1
 
 #include <stdio.h>
 
-
-enum symbol_type
-{
-  SYM_NORMAL, SYM_TYPEDEF, SYM_ENUM, SYM_STRUCT, SYM_UNION
+enum symbol_type {
+	SYM_NORMAL, SYM_TYPEDEF, SYM_ENUM, SYM_STRUCT, SYM_UNION
 };
 
-struct string_list
-{
-  struct string_list *next;
-  enum symbol_type tag;
-  char *string;
+struct string_list {
+	struct string_list *next;
+	enum symbol_type tag;
+	char *string;
 };
 
-struct symbol
-{
-  struct symbol *hash_next;
-  const char *name;
-  enum symbol_type type;
-  struct string_list *defn;
-  struct symbol *expansion_trail;
-  int is_extern;
+struct symbol {
+	struct symbol *hash_next;
+	const char *name;
+	enum symbol_type type;
+	struct string_list *defn;
+	struct symbol *expansion_trail;
+	int is_extern;
 };
 
 typedef struct string_list **yystype;
 #define YYSTYPE yystype
 
-extern FILE *outfile, *debugfile;
-
 extern int cur_line;
-extern char *cur_filename, *output_directory;
-
-extern int flag_debug, flag_dump_defs, flag_warnings;
-extern int checksum_version, kernel_version;
-
-extern int want_brace_phrase, want_exp_phrase, discard_phrase_contents;
-extern struct string_list *current_list, *next_list;
-
+extern char *cur_filename;
 
 struct symbol *find_symbol(const char *name, enum symbol_type ns);
 struct symbol *add_symbol(const char *name, enum symbol_type type,
-			   struct string_list *defn, int is_extern);
+			  struct string_list *defn, int is_extern);
 void export_symbol(const char *);
 
-struct string_list *reset_list(void);
-void free_list(struct string_list *s, struct string_list *e);
 void free_node(struct string_list *list);
+void free_list(struct string_list *s, struct string_list *e);
 struct string_list *copy_node(struct string_list *);
-struct string_list *copy_list(struct string_list *s, struct string_list *e);
-int equal_list(struct string_list *a, struct string_list *b);
-void print_list(FILE *, struct string_list *list);
 
 int yylex(void);
 int yyparse(void);
 
 void error_with_pos(const char *, ...);
 
-#define version(a,b,c)  ((a << 16) | (b << 8) | (c))
-
 /*----------------------------------------------------------------------*/
-
-#define MODUTILS_VERSION "<in-kernel>"
-
 #define xmalloc(size) ({ void *__ptr = malloc(size);		\
 	if(!__ptr && size != 0) {				\
 		fprintf(stderr, "out of memory\n");		\
@@ -101,4 +78,4 @@ void error_with_pos(const char *, ...);
 	}							\
 	__str; })
 
-#endif /* genksyms.h */
+#endif				/* genksyms.h */
-- 
1.0.GIT


