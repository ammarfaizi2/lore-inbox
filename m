Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDIP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDIP3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDIP3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:29:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34474 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750782AbWDIP31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:29:27 -0400
Date: Sun, 9 Apr 2006 17:29:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/19] kconfig: add symbol option config syntax
Message-ID: <Pine.LNX.4.64.0604091729180.23152@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds the general framework to the parser to define options for
config symbols with a syntax like:

config FOO
	option bar[="arg"]

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/lex.zconf.c_shipped  |   91 ++-
 scripts/kconfig/lkc.h                |    5 
 scripts/kconfig/menu.c               |    4 
 scripts/kconfig/zconf.gperf          |    3 
 scripts/kconfig/zconf.hash.c_shipped |  185 +++----
 scripts/kconfig/zconf.tab.c_shipped  |  920 ++++++++++++++++++++---------------
 scripts/kconfig/zconf.y              |   23 
 7 files changed, 737 insertions(+), 494 deletions(-)

Index: linux-2.6-git/scripts/kconfig/lex.zconf.c_shipped
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lex.zconf.c_shipped
+++ linux-2.6-git/scripts/kconfig/lex.zconf.c_shipped
@@ -8,7 +8,7 @@
 #define FLEX_SCANNER
 #define YY_FLEX_MAJOR_VERSION 2
 #define YY_FLEX_MINOR_VERSION 5
-#define YY_FLEX_SUBMINOR_VERSION 31
+#define YY_FLEX_SUBMINOR_VERSION 33
 #if YY_FLEX_SUBMINOR_VERSION > 0
 #define FLEX_BETA
 #endif
@@ -30,7 +30,15 @@
 
 /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
 
-#if defined __STDC_VERSION__ && __STDC_VERSION__ >= 199901L
+#if __STDC_VERSION__ >= 199901L
+
+/* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
+ * if you want the limit (max/min) macros for int types.
+ */
+#ifndef __STDC_LIMIT_MACROS
+#define __STDC_LIMIT_MACROS 1
+#endif
+
 #include <inttypes.h>
 typedef int8_t flex_int8_t;
 typedef uint8_t flex_uint8_t;
@@ -134,6 +142,10 @@ typedef unsigned int flex_uint32_t;
 #define YY_BUF_SIZE 16384
 #endif
 
+/* The state buf must be large enough to hold one state per character in the main buffer.
+ */
+#define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))
+
 #ifndef YY_TYPEDEF_YY_BUFFER_STATE
 #define YY_TYPEDEF_YY_BUFFER_STATE
 typedef struct yy_buffer_state *YY_BUFFER_STATE;
@@ -267,7 +279,7 @@ int zconfleng;
 
 /* Points to current character in buffer. */
 static char *yy_c_buf_p = (char *) 0;
-static int yy_init = 1;		/* whether we need to initialize */
+static int yy_init = 0;		/* whether we need to initialize */
 static int yy_start = 0;	/* start state number */
 
 /* Flag which is used to allow zconfwrap()'s to do buffer switches
@@ -820,6 +832,8 @@ void alloc_string(const char *str, int s
 #define YY_EXTRA_TYPE void *
 #endif
 
+static int yy_init_globals (void );
+
 /* Macros after this point can all be overridden by user definitions in
  * section 1.
  */
@@ -942,9 +956,9 @@ YY_DECL
 	int str = 0;
 	int ts, i;
 
-	if ( (yy_init) )
+	if ( !(yy_init) )
 		{
-		(yy_init) = 0;
+		(yy_init) = 1;
 
 #ifdef YY_USER_INIT
 		YY_USER_INIT;
@@ -1452,7 +1466,7 @@ static int yy_get_next_buffer (void)
 
 	else
 		{
-			size_t num_to_read =
+			int num_to_read =
 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
 
 		while ( num_to_read <= 0 )
@@ -1969,16 +1983,16 @@ YY_BUFFER_STATE zconf_scan_buffer  (char
 
 /** Setup the input buffer state to scan a string. The next call to zconflex() will
  * scan from a @e copy of @a str.
- * @param yy_str a NUL-terminated string to scan
+ * @param yystr a NUL-terminated string to scan
  * 
  * @return the newly allocated buffer state object.
  * @note If you want to scan bytes that may contain NUL values, then use
  *       zconf_scan_bytes() instead.
  */
-YY_BUFFER_STATE zconf_scan_string (yyconst char * yy_str )
+YY_BUFFER_STATE zconf_scan_string (yyconst char * yystr )
 {
     
-	return zconf_scan_bytes(yy_str,strlen(yy_str) );
+	return zconf_scan_bytes(yystr,strlen(yystr) );
 }
 
 /** Setup the input buffer state to scan the given bytes. The next call to zconflex() will
@@ -1988,7 +2002,7 @@ YY_BUFFER_STATE zconf_scan_string (yycon
  * 
  * @return the newly allocated buffer state object.
  */
-YY_BUFFER_STATE zconf_scan_bytes  (yyconst char * bytes, int  len )
+YY_BUFFER_STATE zconf_scan_bytes  (yyconst char * yybytes, int  _yybytes_len )
 {
 	YY_BUFFER_STATE b;
 	char *buf;
@@ -1996,15 +2010,15 @@ YY_BUFFER_STATE zconf_scan_bytes  (yycon
 	int i;
     
 	/* Get memory for full buffer, including space for trailing EOB's. */
-	n = len + 2;
+	n = _yybytes_len + 2;
 	buf = (char *) zconfalloc(n  );
 	if ( ! buf )
 		YY_FATAL_ERROR( "out of dynamic memory in zconf_scan_bytes()" );
 
-	for ( i = 0; i < len; ++i )
-		buf[i] = bytes[i];
+	for ( i = 0; i < _yybytes_len; ++i )
+		buf[i] = yybytes[i];
 
-	buf[len] = buf[len+1] = YY_END_OF_BUFFER_CHAR;
+	buf[_yybytes_len] = buf[_yybytes_len+1] = YY_END_OF_BUFFER_CHAR;
 
 	b = zconf_scan_buffer(buf,n );
 	if ( ! b )
@@ -2125,6 +2139,34 @@ void zconfset_debug (int  bdebug )
         zconf_flex_debug = bdebug ;
 }
 
+static int yy_init_globals (void)
+{
+        /* Initialization is the same as for the non-reentrant scanner.
+     * This function is called from zconflex_destroy(), so don't allocate here.
+     */
+
+    (yy_buffer_stack) = 0;
+    (yy_buffer_stack_top) = 0;
+    (yy_buffer_stack_max) = 0;
+    (yy_c_buf_p) = (char *) 0;
+    (yy_init) = 0;
+    (yy_start) = 0;
+
+/* Defined in main.c */
+#ifdef YY_STDINIT
+    zconfin = stdin;
+    zconfout = stdout;
+#else
+    zconfin = (FILE *) 0;
+    zconfout = (FILE *) 0;
+#endif
+
+    /* For future reference: Set errno on error, since we are called by
+     * zconflex_init()
+     */
+    return 0;
+}
+
 /* zconflex_destroy is for both reentrant and non-reentrant scanners. */
 int zconflex_destroy  (void)
 {
@@ -2140,6 +2182,10 @@ int zconflex_destroy  (void)
 	zconffree((yy_buffer_stack) );
 	(yy_buffer_stack) = NULL;
 
+    /* Reset the globals. This is important in a non-reentrant scanner so the next time
+     * zconflex() is called, initialization will occur. */
+    yy_init_globals( );
+
     return 0;
 }
 
@@ -2151,7 +2197,7 @@ int zconflex_destroy  (void)
 static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
 {
 	register int i;
-    	for ( i = 0; i < n; ++i )
+	for ( i = 0; i < n; ++i )
 		s1[i] = s2[i];
 }
 #endif
@@ -2160,7 +2206,7 @@ static void yy_flex_strncpy (char* s1, y
 static int yy_flex_strlen (yyconst char * s )
 {
 	register int n;
-    	for ( n = 0; s[n]; ++n )
+	for ( n = 0; s[n]; ++n )
 		;
 
 	return n;
@@ -2191,19 +2237,6 @@ void zconffree (void * ptr )
 
 #define YYTABLES_NAME "yytables"
 
-#undef YY_NEW_FILE
-#undef YY_FLUSH_BUFFER
-#undef yy_set_bol
-#undef yy_new_buffer
-#undef yy_set_interactive
-#undef yytext_ptr
-#undef YY_DO_BEFORE_ACTION
-
-#ifdef YY_DECL_IS_OURS
-#undef YY_DECL_IS_OURS
-#undef YY_DECL
-#endif
-
 void zconf_starthelp(void)
 {
 	new_string();
Index: linux-2.6-git/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc.h
+++ linux-2.6-git/scripts/kconfig/lkc.h
@@ -40,6 +40,10 @@ extern "C" {
 
 #define TF_COMMAND	0x0001
 #define TF_PARAM	0x0002
+#define TF_OPTION	0x0004
+
+#define T_OPT_MODULES		1
+#define T_OPT_DEFCONFIG_LIST	2
 
 struct kconf_id {
 	int name;
@@ -78,6 +82,7 @@ struct property *menu_add_prop(enum prop
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
 void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
+void menu_add_option(int token, char *arg);
 void menu_finalize(struct menu *parent);
 void menu_set_type(int type);
 
Index: linux-2.6-git/scripts/kconfig/menu.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/menu.c
+++ linux-2.6-git/scripts/kconfig/menu.c
@@ -152,6 +152,10 @@ void menu_add_symbol(enum prop_type type
 	menu_add_prop(type, NULL, expr_alloc_symbol(sym), dep);
 }
 
+void menu_add_option(int token, char *arg)
+{
+}
+
 static int menu_range_valid_sym(struct symbol *sym, struct symbol *sym2)
 {
 	return sym2->type == S_INT || sym2->type == S_HEX ||
Index: linux-2.6-git/scripts/kconfig/zconf.gperf
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.gperf
+++ linux-2.6-git/scripts/kconfig/zconf.gperf
@@ -39,5 +39,8 @@ string,		T_TYPE,		TF_COMMAND, S_STRING
 select,		T_SELECT,	TF_COMMAND
 enable,		T_SELECT,	TF_COMMAND
 range,		T_RANGE,	TF_COMMAND
+option,		T_OPTION,	TF_COMMAND
 on,		T_ON,		TF_PARAM
+modules,	T_OPT_MODULES,	TF_OPTION
+defconfig_list,	T_OPT_DEFCONFIG_LIST,TF_OPTION
 %%
Index: linux-2.6-git/scripts/kconfig/zconf.hash.c_shipped
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.hash.c_shipped
+++ linux-2.6-git/scripts/kconfig/zconf.hash.c_shipped
@@ -53,10 +53,10 @@ kconf_id_hash (register const char *str,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 25, 10, 15,
-       0,  0,  5, 47,  0,  0, 47, 47,  0, 10,
-       0, 20, 20, 20,  5,  0,  0, 20, 47, 47,
-      20, 47, 47, 47, 47, 47, 47, 47, 47, 47,
+      47, 47, 47, 47, 47, 47, 47, 25, 30, 15,
+       0, 15,  0, 47,  5, 15, 47, 47, 30, 20,
+       5,  0, 25, 15,  0,  0, 10, 35, 47, 47,
+       5, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
       47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
@@ -88,69 +88,75 @@ kconf_id_hash (register const char *str,
 
 struct kconf_id_strings_t
   {
-    char kconf_id_strings_str2[sizeof("if")];
-    char kconf_id_strings_str3[sizeof("int")];
-    char kconf_id_strings_str4[sizeof("help")];
-    char kconf_id_strings_str5[sizeof("endif")];
-    char kconf_id_strings_str6[sizeof("select")];
-    char kconf_id_strings_str7[sizeof("endmenu")];
-    char kconf_id_strings_str8[sizeof("tristate")];
-    char kconf_id_strings_str9[sizeof("endchoice")];
+    char kconf_id_strings_str2[sizeof("on")];
+    char kconf_id_strings_str6[sizeof("string")];
+    char kconf_id_strings_str7[sizeof("default")];
+    char kconf_id_strings_str8[sizeof("def_bool")];
     char kconf_id_strings_str10[sizeof("range")];
-    char kconf_id_strings_str11[sizeof("string")];
-    char kconf_id_strings_str12[sizeof("default")];
-    char kconf_id_strings_str13[sizeof("def_bool")];
-    char kconf_id_strings_str14[sizeof("menu")];
-    char kconf_id_strings_str16[sizeof("def_boolean")];
-    char kconf_id_strings_str17[sizeof("def_tristate")];
-    char kconf_id_strings_str18[sizeof("mainmenu")];
-    char kconf_id_strings_str20[sizeof("menuconfig")];
-    char kconf_id_strings_str21[sizeof("config")];
-    char kconf_id_strings_str22[sizeof("on")];
-    char kconf_id_strings_str23[sizeof("hex")];
-    char kconf_id_strings_str26[sizeof("source")];
-    char kconf_id_strings_str27[sizeof("depends")];
-    char kconf_id_strings_str28[sizeof("optional")];
-    char kconf_id_strings_str31[sizeof("enable")];
-    char kconf_id_strings_str32[sizeof("comment")];
-    char kconf_id_strings_str33[sizeof("requires")];
+    char kconf_id_strings_str11[sizeof("def_boolean")];
+    char kconf_id_strings_str12[sizeof("def_tristate")];
+    char kconf_id_strings_str13[sizeof("hex")];
+    char kconf_id_strings_str14[sizeof("defconfig_list")];
+    char kconf_id_strings_str16[sizeof("option")];
+    char kconf_id_strings_str17[sizeof("if")];
+    char kconf_id_strings_str18[sizeof("optional")];
+    char kconf_id_strings_str20[sizeof("endif")];
+    char kconf_id_strings_str21[sizeof("choice")];
+    char kconf_id_strings_str22[sizeof("endmenu")];
+    char kconf_id_strings_str23[sizeof("requires")];
+    char kconf_id_strings_str24[sizeof("endchoice")];
+    char kconf_id_strings_str26[sizeof("config")];
+    char kconf_id_strings_str27[sizeof("modules")];
+    char kconf_id_strings_str28[sizeof("int")];
+    char kconf_id_strings_str29[sizeof("menu")];
+    char kconf_id_strings_str31[sizeof("prompt")];
+    char kconf_id_strings_str32[sizeof("depends")];
+    char kconf_id_strings_str33[sizeof("tristate")];
     char kconf_id_strings_str34[sizeof("bool")];
+    char kconf_id_strings_str35[sizeof("menuconfig")];
+    char kconf_id_strings_str36[sizeof("select")];
     char kconf_id_strings_str37[sizeof("boolean")];
-    char kconf_id_strings_str41[sizeof("choice")];
-    char kconf_id_strings_str46[sizeof("prompt")];
+    char kconf_id_strings_str39[sizeof("help")];
+    char kconf_id_strings_str41[sizeof("source")];
+    char kconf_id_strings_str42[sizeof("comment")];
+    char kconf_id_strings_str43[sizeof("mainmenu")];
+    char kconf_id_strings_str46[sizeof("enable")];
   };
 static struct kconf_id_strings_t kconf_id_strings_contents =
   {
-    "if",
-    "int",
-    "help",
-    "endif",
-    "select",
-    "endmenu",
-    "tristate",
-    "endchoice",
-    "range",
+    "on",
     "string",
     "default",
     "def_bool",
-    "menu",
+    "range",
     "def_boolean",
     "def_tristate",
-    "mainmenu",
-    "menuconfig",
-    "config",
-    "on",
     "hex",
-    "source",
-    "depends",
+    "defconfig_list",
+    "option",
+    "if",
     "optional",
-    "enable",
-    "comment",
+    "endif",
+    "choice",
+    "endmenu",
     "requires",
+    "endchoice",
+    "config",
+    "modules",
+    "int",
+    "menu",
+    "prompt",
+    "depends",
+    "tristate",
     "bool",
+    "menuconfig",
+    "select",
     "boolean",
-    "choice",
-    "prompt"
+    "help",
+    "source",
+    "comment",
+    "mainmenu",
+    "enable"
   };
 #define kconf_id_strings ((const char *) &kconf_id_strings_contents)
 #ifdef __GNUC__
@@ -161,9 +167,9 @@ kconf_id_lookup (register const char *st
 {
   enum
     {
-      TOTAL_KEYWORDS = 30,
+      TOTAL_KEYWORDS = 33,
       MIN_WORD_LENGTH = 2,
-      MAX_WORD_LENGTH = 12,
+      MAX_WORD_LENGTH = 14,
       MIN_HASH_VALUE = 2,
       MAX_HASH_VALUE = 46
     };
@@ -171,43 +177,48 @@ kconf_id_lookup (register const char *st
   static struct kconf_id wordlist[] =
     {
       {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str2,		T_IF,		TF_COMMAND|TF_PARAM},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str3,		T_TYPE,		TF_COMMAND, S_INT},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str4,		T_HELP,		TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str5,		T_ENDIF,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str6,		T_SELECT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str7,	T_ENDMENU,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_TYPE,		TF_COMMAND, S_TRISTATE},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str9,	T_ENDCHOICE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str2,		T_ON,		TF_PARAM},
+      {-1}, {-1}, {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str6,		T_TYPE,		TF_COMMAND, S_STRING},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str7,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
+      {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str10,		T_RANGE,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str11,		T_TYPE,		TF_COMMAND, S_STRING},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str12,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str13,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str14,		T_MENU,		TF_COMMAND},
-      {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str16,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,	T_DEFAULT,	TF_COMMAND, S_TRISTATE},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str18,	T_MAINMENU,	TF_COMMAND},
-      {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str20,	T_MENUCONFIG,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_CONFIG,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,		T_ON,		TF_PARAM},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,		T_TYPE,		TF_COMMAND, S_HEX},
-      {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str26,		T_SOURCE,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str27,	T_DEPENDS,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str28,	T_OPTIONAL,	TF_COMMAND},
-      {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_SELECT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_COMMENT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str33,	T_REQUIRES,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str11,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str12,	T_DEFAULT,	TF_COMMAND, S_TRISTATE},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str13,		T_TYPE,		TF_COMMAND, S_HEX},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str14,	T_OPT_DEFCONFIG_LIST,TF_OPTION},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str16,		T_OPTION,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,		T_IF,		TF_COMMAND|TF_PARAM},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str18,	T_OPTIONAL,	TF_COMMAND},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str20,		T_ENDIF,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_CHOICE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,	T_ENDMENU,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,	T_REQUIRES,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str24,	T_ENDCHOICE,	TF_COMMAND},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str26,		T_CONFIG,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str27,	T_OPT_MODULES,	TF_OPTION},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str28,		T_TYPE,		TF_COMMAND, S_INT},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str29,		T_MENU,		TF_COMMAND},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_PROMPT,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_DEPENDS,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str33,	T_TYPE,		TF_COMMAND, S_TRISTATE},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str34,		T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {-1}, {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str35,	T_MENUCONFIG,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str36,		T_SELECT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str37,	T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {-1}, {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_CHOICE,	TF_COMMAND},
-      {-1}, {-1}, {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str46,		T_PROMPT,	TF_COMMAND}
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str39,		T_HELP,		TF_COMMAND},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_SOURCE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str42,	T_COMMENT,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str43,	T_MAINMENU,	TF_COMMAND},
+      {-1}, {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str46,		T_SELECT,	TF_COMMAND}
     };
 
   if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
Index: linux-2.6-git/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.tab.c_shipped
+++ linux-2.6-git/scripts/kconfig/zconf.tab.c_shipped
@@ -1,7 +1,7 @@
-/* A Bison parser, made by GNU Bison 2.0.  */
+/* A Bison parser, made by GNU Bison 2.1.  */
 
 /* Skeleton parser for Yacc-like parsing with Bison,
-   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004 Free Software Foundation, Inc.
+   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005 Free Software Foundation, Inc.
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -15,8 +15,8 @@
 
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
-   Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
+   Foundation, Inc., 51 Franklin Street, Fifth Floor,
+   Boston, MA 02110-1301, USA.  */
 
 /* As a special exception, when this file is copied by Bison into a
    Bison output file, you may use that output file without restriction.
@@ -36,6 +36,9 @@
 /* Identify Bison output.  */
 #define YYBISON 1
 
+/* Bison version.  */
+#define YYBISON_VERSION "2.1"
+
 /* Skeleton name.  */
 #define YYSKELETON_NAME "yacc.c"
 
@@ -82,19 +85,21 @@
      T_DEFAULT = 276,
      T_SELECT = 277,
      T_RANGE = 278,
-     T_ON = 279,
-     T_WORD = 280,
-     T_WORD_QUOTE = 281,
-     T_UNEQUAL = 282,
-     T_CLOSE_PAREN = 283,
-     T_OPEN_PAREN = 284,
-     T_EOL = 285,
-     T_OR = 286,
-     T_AND = 287,
-     T_EQUAL = 288,
-     T_NOT = 289
+     T_OPTION = 279,
+     T_ON = 280,
+     T_WORD = 281,
+     T_WORD_QUOTE = 282,
+     T_UNEQUAL = 283,
+     T_CLOSE_PAREN = 284,
+     T_OPEN_PAREN = 285,
+     T_EOL = 286,
+     T_OR = 287,
+     T_AND = 288,
+     T_EQUAL = 289,
+     T_NOT = 290
    };
 #endif
+/* Tokens.  */
 #define T_MAINMENU 258
 #define T_MENU 259
 #define T_ENDMENU 260
@@ -116,17 +121,18 @@
 #define T_DEFAULT 276
 #define T_SELECT 277
 #define T_RANGE 278
-#define T_ON 279
-#define T_WORD 280
-#define T_WORD_QUOTE 281
-#define T_UNEQUAL 282
-#define T_CLOSE_PAREN 283
-#define T_OPEN_PAREN 284
-#define T_EOL 285
-#define T_OR 286
-#define T_AND 287
-#define T_EQUAL 288
-#define T_NOT 289
+#define T_OPTION 279
+#define T_ON 280
+#define T_WORD 281
+#define T_WORD_QUOTE 282
+#define T_UNEQUAL 283
+#define T_CLOSE_PAREN 284
+#define T_OPEN_PAREN 285
+#define T_EOL 286
+#define T_OR 287
+#define T_AND 288
+#define T_EQUAL 289
+#define T_NOT 290
 
 
 
@@ -187,6 +193,11 @@ static struct menu *current_menu, *curre
 # define YYERROR_VERBOSE 0
 #endif
 
+/* Enabling the token table.  */
+#ifndef YYTOKEN_TABLE
+# define YYTOKEN_TABLE 0
+#endif
+
 #if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
 
 typedef union YYSTYPE {
@@ -197,7 +208,7 @@ typedef union YYSTYPE {
 	struct menu *menu;
 	struct kconf_id *id;
 } YYSTYPE;
-/* Line 190 of yacc.c.  */
+/* Line 196 of yacc.c.  */
 
 # define yystype YYSTYPE /* obsolescent; will be withdrawn */
 # define YYSTYPE_IS_DECLARED 1
@@ -209,17 +220,36 @@ typedef union YYSTYPE {
 /* Copy the second part of user declarations.  */
 
 
-/* Line 213 of yacc.c.  */
+/* Line 219 of yacc.c.  */
 
 
-#if ! defined (yyoverflow) || YYERROR_VERBOSE
+#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
+# define YYSIZE_T __SIZE_TYPE__
+#endif
+#if ! defined (YYSIZE_T) && defined (size_t)
+# define YYSIZE_T size_t
+#endif
+#if ! defined (YYSIZE_T) && (defined (__STDC__) || defined (__cplusplus))
+# include <stddef.h> /* INFRINGES ON USER NAME SPACE */
+# define YYSIZE_T size_t
+#endif
+#if ! defined (YYSIZE_T)
+# define YYSIZE_T unsigned int
+#endif
 
-# ifndef YYFREE
-#  define YYFREE free
+#ifndef YY_
+# if YYENABLE_NLS
+#  if ENABLE_NLS
+#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
+#   define YY_(msgid) dgettext ("bison-runtime", msgid)
+#  endif
 # endif
-# ifndef YYMALLOC
-#  define YYMALLOC malloc
+# ifndef YY_
+#  define YY_(msgid) msgid
 # endif
+#endif
+
+#if ! defined (yyoverflow) || YYERROR_VERBOSE
 
 /* The parser invokes alloca or malloc; define the necessary symbols.  */
 
@@ -229,6 +259,10 @@ typedef union YYSTYPE {
 #    define YYSTACK_ALLOC __builtin_alloca
 #   else
 #    define YYSTACK_ALLOC alloca
+#    if defined (__STDC__) || defined (__cplusplus)
+#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
+#     define YYINCLUDED_STDLIB_H
+#    endif
 #   endif
 #  endif
 # endif
@@ -236,13 +270,39 @@ typedef union YYSTYPE {
 # ifdef YYSTACK_ALLOC
    /* Pacify GCC's `empty if-body' warning. */
 #  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
-# else
-#  if defined (__STDC__) || defined (__cplusplus)
-#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-#   define YYSIZE_T size_t
+#  ifndef YYSTACK_ALLOC_MAXIMUM
+    /* The OS might guarantee only one guard page at the bottom of the stack,
+       and a page size can be as small as 4096 bytes.  So we cannot safely
+       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
+       to allow for a few compiler-allocated temporary stack slots.  */
+#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2005 */
 #  endif
+# else
 #  define YYSTACK_ALLOC YYMALLOC
 #  define YYSTACK_FREE YYFREE
+#  ifndef YYSTACK_ALLOC_MAXIMUM
+#   define YYSTACK_ALLOC_MAXIMUM ((YYSIZE_T) -1)
+#  endif
+#  ifdef __cplusplus
+extern "C" {
+#  endif
+#  ifndef YYMALLOC
+#   define YYMALLOC malloc
+#   if (! defined (malloc) && ! defined (YYINCLUDED_STDLIB_H) \
+	&& (defined (__STDC__) || defined (__cplusplus)))
+void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
+#   endif
+#  endif
+#  ifndef YYFREE
+#   define YYFREE free
+#   if (! defined (free) && ! defined (YYINCLUDED_STDLIB_H) \
+	&& (defined (__STDC__) || defined (__cplusplus)))
+void free (void *); /* INFRINGES ON USER NAME SPACE */
+#   endif
+#  endif
+#  ifdef __cplusplus
+}
+#  endif
 # endif
 #endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */
 
@@ -277,7 +337,7 @@ union yyalloc
 #   define YYCOPY(To, From, Count)		\
       do					\
 	{					\
-	  register YYSIZE_T yyi;		\
+	  YYSIZE_T yyi;				\
 	  for (yyi = 0; yyi < (Count); yyi++)	\
 	    (To)[yyi] = (From)[yyi];		\
 	}					\
@@ -312,22 +372,22 @@ union yyalloc
 /* YYFINAL -- State number of the termination state. */
 #define YYFINAL  3
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   264
+#define YYLAST   275
 
 /* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  35
+#define YYNTOKENS  36
 /* YYNNTS -- Number of nonterminals. */
-#define YYNNTS  42
+#define YYNNTS  45
 /* YYNRULES -- Number of rules. */
-#define YYNRULES  104
+#define YYNRULES  110
 /* YYNRULES -- Number of states. */
-#define YYNSTATES  175
+#define YYNSTATES  183
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   289
+#define YYMAXUTOK   290
 
-#define YYTRANSLATE(YYX) 						\
+#define YYTRANSLATE(YYX)						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
 
 /* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
@@ -361,7 +421,8 @@ static const unsigned char yytranslate[]
        2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
-      25,    26,    27,    28,    29,    30,    31,    32,    33,    34
+      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
+      35
 };
 
 #if YYDEBUG
@@ -372,72 +433,75 @@ static const unsigned short int yyprhs[]
        0,     0,     3,     5,     6,     9,    12,    15,    20,    23,
       28,    33,    37,    39,    41,    43,    45,    47,    49,    51,
       53,    55,    57,    59,    61,    63,    67,    70,    74,    77,
-      81,    84,    85,    88,    91,    94,    97,   100,   104,   109,
-     114,   119,   125,   128,   131,   133,   137,   138,   141,   144,
-     147,   150,   153,   158,   162,   165,   170,   171,   174,   178,
-     180,   184,   185,   188,   191,   194,   198,   201,   203,   207,
-     208,   211,   214,   217,   221,   225,   228,   231,   234,   235,
-     238,   241,   244,   249,   253,   257,   258,   261,   263,   265,
-     268,   271,   274,   276,   279,   280,   283,   285,   289,   293,
-     297,   300,   304,   308,   310
+      81,    84,    85,    88,    91,    94,    97,   100,   103,   107,
+     112,   117,   122,   128,   132,   133,   137,   138,   141,   144,
+     147,   149,   153,   154,   157,   160,   163,   166,   169,   174,
+     178,   181,   186,   187,   190,   194,   196,   200,   201,   204,
+     207,   210,   214,   217,   219,   223,   224,   227,   230,   233,
+     237,   241,   244,   247,   250,   251,   254,   257,   260,   265,
+     269,   273,   274,   277,   279,   281,   284,   287,   290,   292,
+     295,   296,   299,   301,   305,   309,   313,   316,   320,   324,
+     326
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS. */
 static const yysigned_char yyrhs[] =
 {
-      36,     0,    -1,    37,    -1,    -1,    37,    39,    -1,    37,
-      50,    -1,    37,    61,    -1,    37,     3,    71,    73,    -1,
-      37,    72,    -1,    37,    25,     1,    30,    -1,    37,    38,
-       1,    30,    -1,    37,     1,    30,    -1,    16,    -1,    19,
+      37,     0,    -1,    38,    -1,    -1,    38,    40,    -1,    38,
+      54,    -1,    38,    65,    -1,    38,     3,    75,    77,    -1,
+      38,    76,    -1,    38,    26,     1,    31,    -1,    38,    39,
+       1,    31,    -1,    38,     1,    31,    -1,    16,    -1,    19,
       -1,    20,    -1,    22,    -1,    18,    -1,    23,    -1,    21,
-      -1,    30,    -1,    56,    -1,    65,    -1,    42,    -1,    44,
-      -1,    63,    -1,    25,     1,    30,    -1,     1,    30,    -1,
-      10,    25,    30,    -1,    41,    45,    -1,    11,    25,    30,
-      -1,    43,    45,    -1,    -1,    45,    46,    -1,    45,    69,
-      -1,    45,    67,    -1,    45,    40,    -1,    45,    30,    -1,
-      20,    70,    30,    -1,    19,    71,    74,    30,    -1,    21,
-      75,    74,    30,    -1,    22,    25,    74,    30,    -1,    23,
-      76,    76,    74,    30,    -1,     7,    30,    -1,    47,    51,
-      -1,    72,    -1,    48,    53,    49,    -1,    -1,    51,    52,
-      -1,    51,    69,    -1,    51,    67,    -1,    51,    30,    -1,
-      51,    40,    -1,    19,    71,    74,    30,    -1,    20,    70,
-      30,    -1,    18,    30,    -1,    21,    25,    74,    30,    -1,
-      -1,    53,    39,    -1,    14,    75,    73,    -1,    72,    -1,
-      54,    57,    55,    -1,    -1,    57,    39,    -1,    57,    61,
-      -1,    57,    50,    -1,     4,    71,    30,    -1,    58,    68,
-      -1,    72,    -1,    59,    62,    60,    -1,    -1,    62,    39,
-      -1,    62,    61,    -1,    62,    50,    -1,     6,    71,    30,
-      -1,     9,    71,    30,    -1,    64,    68,    -1,    12,    30,
-      -1,    66,    13,    -1,    -1,    68,    69,    -1,    68,    30,
-      -1,    68,    40,    -1,    16,    24,    75,    30,    -1,    16,
-      75,    30,    -1,    17,    75,    30,    -1,    -1,    71,    74,
-      -1,    25,    -1,    26,    -1,     5,    30,    -1,     8,    30,
-      -1,    15,    30,    -1,    30,    -1,    73,    30,    -1,    -1,
-      14,    75,    -1,    76,    -1,    76,    33,    76,    -1,    76,
-      27,    76,    -1,    29,    75,    28,    -1,    34,    75,    -1,
-      75,    31,    75,    -1,    75,    32,    75,    -1,    25,    -1,
-      26,    -1
+      -1,    31,    -1,    60,    -1,    69,    -1,    43,    -1,    45,
+      -1,    67,    -1,    26,     1,    31,    -1,     1,    31,    -1,
+      10,    26,    31,    -1,    42,    46,    -1,    11,    26,    31,
+      -1,    44,    46,    -1,    -1,    46,    47,    -1,    46,    48,
+      -1,    46,    73,    -1,    46,    71,    -1,    46,    41,    -1,
+      46,    31,    -1,    20,    74,    31,    -1,    19,    75,    78,
+      31,    -1,    21,    79,    78,    31,    -1,    22,    26,    78,
+      31,    -1,    23,    80,    80,    78,    31,    -1,    24,    49,
+      31,    -1,    -1,    49,    26,    50,    -1,    -1,    34,    75,
+      -1,     7,    31,    -1,    51,    55,    -1,    76,    -1,    52,
+      57,    53,    -1,    -1,    55,    56,    -1,    55,    73,    -1,
+      55,    71,    -1,    55,    31,    -1,    55,    41,    -1,    19,
+      75,    78,    31,    -1,    20,    74,    31,    -1,    18,    31,
+      -1,    21,    26,    78,    31,    -1,    -1,    57,    40,    -1,
+      14,    79,    77,    -1,    76,    -1,    58,    61,    59,    -1,
+      -1,    61,    40,    -1,    61,    65,    -1,    61,    54,    -1,
+       4,    75,    31,    -1,    62,    72,    -1,    76,    -1,    63,
+      66,    64,    -1,    -1,    66,    40,    -1,    66,    65,    -1,
+      66,    54,    -1,     6,    75,    31,    -1,     9,    75,    31,
+      -1,    68,    72,    -1,    12,    31,    -1,    70,    13,    -1,
+      -1,    72,    73,    -1,    72,    31,    -1,    72,    41,    -1,
+      16,    25,    79,    31,    -1,    16,    79,    31,    -1,    17,
+      79,    31,    -1,    -1,    75,    78,    -1,    26,    -1,    27,
+      -1,     5,    31,    -1,     8,    31,    -1,    15,    31,    -1,
+      31,    -1,    77,    31,    -1,    -1,    14,    79,    -1,    80,
+      -1,    80,    34,    80,    -1,    80,    28,    80,    -1,    30,
+      79,    29,    -1,    35,    79,    -1,    79,    32,    79,    -1,
+      79,    33,    79,    -1,    26,    -1,    27,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const unsigned short int yyrline[] =
 {
-       0,   103,   103,   105,   107,   108,   109,   110,   111,   112,
-     113,   117,   121,   121,   121,   121,   121,   121,   121,   125,
-     126,   127,   128,   129,   130,   134,   135,   141,   149,   155,
-     163,   173,   175,   176,   177,   178,   179,   182,   190,   196,
-     206,   212,   220,   229,   234,   242,   245,   247,   248,   249,
-     250,   251,   254,   260,   271,   277,   287,   289,   294,   302,
-     310,   313,   315,   316,   317,   322,   329,   334,   342,   345,
-     347,   348,   349,   352,   360,   367,   374,   380,   387,   389,
-     390,   391,   394,   399,   404,   412,   414,   419,   420,   423,
-     424,   425,   429,   430,   433,   434,   437,   438,   439,   440,
-     441,   442,   443,   446,   447
+       0,   105,   105,   107,   109,   110,   111,   112,   113,   114,
+     115,   119,   123,   123,   123,   123,   123,   123,   123,   127,
+     128,   129,   130,   131,   132,   136,   137,   143,   151,   157,
+     165,   175,   177,   178,   179,   180,   181,   182,   185,   193,
+     199,   209,   215,   221,   224,   226,   237,   238,   243,   252,
+     257,   265,   268,   270,   271,   272,   273,   274,   277,   283,
+     294,   300,   310,   312,   317,   325,   333,   336,   338,   339,
+     340,   345,   352,   357,   365,   368,   370,   371,   372,   375,
+     383,   390,   397,   403,   410,   412,   413,   414,   417,   422,
+     427,   435,   437,   442,   443,   446,   447,   448,   452,   453,
+     456,   457,   460,   461,   462,   463,   464,   465,   466,   469,
+     470
 };
 #endif
 
-#if YYDEBUG || YYERROR_VERBOSE
-/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
+#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
+/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
    First, the terminals, then, starting at YYNTOKENS, nonterminals. */
 static const char *const yytname[] =
 {
@@ -445,17 +509,18 @@ static const char *const yytname[] =
   "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
   "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT",
-  "T_SELECT", "T_RANGE", "T_ON", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
-  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND", "T_EQUAL",
-  "T_NOT", "$accept", "input", "stmt_list", "option_name", "common_stmt",
-  "option_error", "config_entry_start", "config_stmt",
+  "T_SELECT", "T_RANGE", "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE",
+  "T_UNEQUAL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND",
+  "T_EQUAL", "T_NOT", "$accept", "input", "stmt_list", "option_name",
+  "common_stmt", "option_error", "config_entry_start", "config_stmt",
   "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
-  "config_option", "choice", "choice_entry", "choice_end", "choice_stmt",
-  "choice_option_list", "choice_option", "choice_block", "if_entry",
-  "if_end", "if_stmt", "if_block", "menu", "menu_entry", "menu_end",
-  "menu_stmt", "menu_block", "source_stmt", "comment", "comment_stmt",
-  "help_start", "help", "depends_list", "depends", "prompt_stmt_opt",
-  "prompt", "end", "nl", "if_expr", "expr", "symbol", 0
+  "config_option", "symbol_option", "symbol_option_list",
+  "symbol_option_arg", "choice", "choice_entry", "choice_end",
+  "choice_stmt", "choice_option_list", "choice_option", "choice_block",
+  "if_entry", "if_end", "if_stmt", "if_block", "menu", "menu_entry",
+  "menu_end", "menu_stmt", "menu_block", "source_stmt", "comment",
+  "comment_stmt", "help_start", "help", "depends_list", "depends",
+  "prompt_stmt_opt", "prompt", "end", "nl", "if_expr", "expr", "symbol", 0
 };
 #endif
 
@@ -467,24 +532,25 @@ static const unsigned short int yytoknum
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289
+     285,   286,   287,   288,   289,   290
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const unsigned char yyr1[] =
 {
-       0,    35,    36,    37,    37,    37,    37,    37,    37,    37,
-      37,    37,    38,    38,    38,    38,    38,    38,    38,    39,
-      39,    39,    39,    39,    39,    40,    40,    41,    42,    43,
-      44,    45,    45,    45,    45,    45,    45,    46,    46,    46,
-      46,    46,    47,    48,    49,    50,    51,    51,    51,    51,
-      51,    51,    52,    52,    52,    52,    53,    53,    54,    55,
-      56,    57,    57,    57,    57,    58,    59,    60,    61,    62,
-      62,    62,    62,    63,    64,    65,    66,    67,    68,    68,
-      68,    68,    69,    69,    69,    70,    70,    71,    71,    72,
-      72,    72,    73,    73,    74,    74,    75,    75,    75,    75,
-      75,    75,    75,    76,    76
+       0,    36,    37,    38,    38,    38,    38,    38,    38,    38,
+      38,    38,    39,    39,    39,    39,    39,    39,    39,    40,
+      40,    40,    40,    40,    40,    41,    41,    42,    43,    44,
+      45,    46,    46,    46,    46,    46,    46,    46,    47,    47,
+      47,    47,    47,    48,    49,    49,    50,    50,    51,    52,
+      53,    54,    55,    55,    55,    55,    55,    55,    56,    56,
+      56,    56,    57,    57,    58,    59,    60,    61,    61,    61,
+      61,    62,    63,    64,    65,    66,    66,    66,    66,    67,
+      68,    69,    70,    71,    72,    72,    72,    72,    73,    73,
+      73,    74,    74,    75,    75,    76,    76,    76,    77,    77,
+      78,    78,    79,    79,    79,    79,    79,    79,    79,    80,
+      80
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
@@ -493,14 +559,15 @@ static const unsigned char yyr2[] =
        0,     2,     1,     0,     2,     2,     2,     4,     2,     4,
        4,     3,     1,     1,     1,     1,     1,     1,     1,     1,
        1,     1,     1,     1,     1,     3,     2,     3,     2,     3,
-       2,     0,     2,     2,     2,     2,     2,     3,     4,     4,
-       4,     5,     2,     2,     1,     3,     0,     2,     2,     2,
-       2,     2,     4,     3,     2,     4,     0,     2,     3,     1,
-       3,     0,     2,     2,     2,     3,     2,     1,     3,     0,
-       2,     2,     2,     3,     3,     2,     2,     2,     0,     2,
-       2,     2,     4,     3,     3,     0,     2,     1,     1,     2,
-       2,     2,     1,     2,     0,     2,     1,     3,     3,     3,
-       2,     3,     3,     1,     1
+       2,     0,     2,     2,     2,     2,     2,     2,     3,     4,
+       4,     4,     5,     3,     0,     3,     0,     2,     2,     2,
+       1,     3,     0,     2,     2,     2,     2,     2,     4,     3,
+       2,     4,     0,     2,     3,     1,     3,     0,     2,     2,
+       2,     3,     2,     1,     3,     0,     2,     2,     2,     3,
+       3,     2,     2,     2,     0,     2,     2,     2,     4,     3,
+       3,     0,     2,     1,     1,     2,     2,     2,     1,     2,
+       0,     2,     1,     3,     3,     3,     2,     3,     3,     1,
+       1
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -511,175 +578,164 @@ static const unsigned char yydefact[] =
        3,     0,     0,     1,     0,     0,     0,     0,     0,     0,
        0,     0,     0,     0,     0,     0,    12,    16,    13,    14,
       18,    15,    17,     0,    19,     0,     4,    31,    22,    31,
-      23,    46,    56,     5,    61,    20,    78,    69,     6,    24,
-      78,    21,     8,    11,    87,    88,     0,     0,    89,     0,
-      42,    90,     0,     0,     0,   103,   104,     0,     0,     0,
-      96,    91,     0,     0,     0,     0,     0,     0,     0,     0,
-       0,     0,    92,     7,    65,    73,    74,    27,    29,     0,
-     100,     0,     0,    58,     0,     0,     9,    10,     0,     0,
-       0,     0,     0,    85,     0,     0,     0,     0,    36,    35,
-      32,     0,    34,    33,     0,     0,    85,     0,    50,    51,
-      47,    49,    48,    57,    45,    44,    62,    64,    60,    63,
-      59,    80,    81,    79,    70,    72,    68,    71,    67,    93,
-      99,   101,   102,    98,    97,    26,    76,     0,     0,     0,
-      94,     0,    94,    94,    94,     0,     0,    77,    54,    94,
-       0,    94,     0,    83,    84,     0,     0,    37,    86,     0,
-       0,    94,    25,     0,    53,     0,    82,    95,    38,    39,
-      40,     0,    52,    55,    41
+      23,    52,    62,     5,    67,    20,    84,    75,     6,    24,
+      84,    21,     8,    11,    93,    94,     0,     0,    95,     0,
+      48,    96,     0,     0,     0,   109,   110,     0,     0,     0,
+     102,    97,     0,     0,     0,     0,     0,     0,     0,     0,
+       0,     0,    98,     7,    71,    79,    80,    27,    29,     0,
+     106,     0,     0,    64,     0,     0,     9,    10,     0,     0,
+       0,     0,     0,    91,     0,     0,     0,    44,     0,    37,
+      36,    32,    33,     0,    35,    34,     0,     0,    91,     0,
+      56,    57,    53,    55,    54,    63,    51,    50,    68,    70,
+      66,    69,    65,    86,    87,    85,    76,    78,    74,    77,
+      73,    99,   105,   107,   108,   104,   103,    26,    82,     0,
+       0,     0,   100,     0,   100,   100,   100,     0,     0,     0,
+      83,    60,   100,     0,   100,     0,    89,    90,     0,     0,
+      38,    92,     0,     0,   100,    46,    43,    25,     0,    59,
+       0,    88,   101,    39,    40,    41,     0,     0,    45,    58,
+      61,    42,    47
 };
 
 /* YYDEFGOTO[NTERM-NUM]. */
 static const short int yydefgoto[] =
 {
-      -1,     1,     2,    25,    26,    99,    27,    28,    29,    30,
-      64,   100,    31,    32,   114,    33,    66,   110,    67,    34,
-     118,    35,    68,    36,    37,   126,    38,    70,    39,    40,
-      41,   101,   102,    69,   103,   141,   142,    42,    73,   156,
-      59,    60
+      -1,     1,     2,    25,    26,   100,    27,    28,    29,    30,
+      64,   101,   102,   148,   178,    31,    32,   116,    33,    66,
+     112,    67,    34,   120,    35,    68,    36,    37,   128,    38,
+      70,    39,    40,    41,   103,   104,    69,   105,   143,   144,
+      42,    73,   159,    59,    60
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -78
+#define YYPACT_NINF -135
 static const short int yypact[] =
 {
-     -78,     2,   159,   -78,   -21,     0,     0,   -12,     0,     1,
-       4,     0,    27,    38,    60,    58,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   100,   -78,   104,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   -78,   -78,   -78,    86,   113,   -78,   114,
-     -78,   -78,   125,   127,   128,   -78,   -78,    60,    60,   210,
-      65,   -78,   141,   142,    39,   103,   182,   200,     6,    66,
-       6,   131,   -78,   146,   -78,   -78,   -78,   -78,   -78,   196,
-     -78,    60,    60,   146,    40,    40,   -78,   -78,   155,   156,
-      -2,    60,     0,     0,    60,   105,    40,   194,   -78,   -78,
-     -78,   206,   -78,   -78,   183,     0,     0,   195,   -78,   -78,
-     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
-     -78,   197,   -78,   -78,   -78,   -78,   -78,    60,   213,   216,
-     212,   203,   212,   190,   212,    40,   208,   -78,   -78,   212,
-     222,   212,   219,   -78,   -78,    60,   223,   -78,   -78,   224,
-     225,   212,   -78,   226,   -78,   227,   -78,    47,   -78,   -78,
-     -78,   228,   -78,   -78,   -78
+    -135,     2,   170,  -135,   -14,    56,    56,    -8,    56,    24,
+      67,    56,     7,    14,    62,    97,  -135,  -135,  -135,  -135,
+    -135,  -135,  -135,   156,  -135,   166,  -135,  -135,  -135,  -135,
+    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
+    -135,  -135,  -135,  -135,  -135,  -135,   138,   151,  -135,   152,
+    -135,  -135,   163,   167,   176,  -135,  -135,    62,    62,   185,
+     -19,  -135,   188,   190,    42,   103,   194,    85,    70,   222,
+      70,   132,  -135,   191,  -135,  -135,  -135,  -135,  -135,   127,
+    -135,    62,    62,   191,   104,   104,  -135,  -135,   193,   203,
+       9,    62,    56,    56,    62,   161,   104,  -135,   196,  -135,
+    -135,  -135,  -135,   233,  -135,  -135,   204,    56,    56,   221,
+    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
+    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
+    -135,  -135,  -135,   219,  -135,  -135,  -135,  -135,  -135,    62,
+     209,   212,   240,   224,   240,    -1,   240,   104,    41,   225,
+    -135,  -135,   240,   226,   240,   218,  -135,  -135,    62,   227,
+    -135,  -135,   228,   229,   240,   230,  -135,  -135,   231,  -135,
+     232,  -135,   112,  -135,  -135,  -135,   234,    56,  -135,  -135,
+    -135,  -135,  -135
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const short int yypgoto[] =
 {
-     -78,   -78,   -78,   -78,   164,   -36,   -78,   -78,   -78,   -78,
-     230,   -78,   -78,   -78,   -78,    29,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   -78,   -78,   -78,    59,   -78,   -78,   -78,
-     -78,   -78,   198,   220,    24,   157,    -5,   169,   202,    74,
-     -53,   -77
+    -135,  -135,  -135,  -135,    94,   -45,  -135,  -135,  -135,  -135,
+     237,  -135,  -135,  -135,  -135,  -135,  -135,  -135,   -54,  -135,
+    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,     1,
+    -135,  -135,  -135,  -135,  -135,   195,   235,   -44,   159,    -5,
+      98,   210,  -134,   -53,   -77
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
-#define YYTABLE_NINF -76
+#define YYTABLE_NINF -82
 static const short int yytable[] =
 {
-      46,    47,     3,    49,    79,    80,    52,   133,   134,    43,
-       6,     7,     8,     9,    10,    11,    12,    13,    48,   145,
-      14,    15,   137,    55,    56,    44,    45,    57,   131,   132,
-     109,    50,    58,   122,    51,   122,    24,   138,   139,   -28,
-      88,   143,   -28,   -28,   -28,   -28,   -28,   -28,   -28,   -28,
-     -28,    89,    53,   -28,   -28,    90,    91,   -28,    92,    93,
-      94,    95,    96,    54,    97,    55,    56,    88,   161,    98,
-     -66,   -66,   -66,   -66,   -66,   -66,   -66,   -66,    81,    82,
-     -66,   -66,    90,    91,   152,    55,    56,   140,    61,    57,
-     112,    97,    84,   123,    58,   123,   121,   117,    85,   125,
-     149,    62,   167,   -30,    88,    63,   -30,   -30,   -30,   -30,
-     -30,   -30,   -30,   -30,   -30,    89,    72,   -30,   -30,    90,
-      91,   -30,    92,    93,    94,    95,    96,   119,    97,   127,
-     144,   -75,    88,    98,   -75,   -75,   -75,   -75,   -75,   -75,
-     -75,   -75,   -75,    74,    75,   -75,   -75,    90,    91,   -75,
-     -75,   -75,   -75,   -75,   -75,    76,    97,    77,    78,    -2,
-       4,   121,     5,     6,     7,     8,     9,    10,    11,    12,
-      13,    86,    87,    14,    15,    16,   129,    17,    18,    19,
-      20,    21,    22,    88,    23,   135,   136,   -43,   -43,    24,
-     -43,   -43,   -43,   -43,    89,   146,   -43,   -43,    90,    91,
-     104,   105,   106,   107,   155,     7,     8,    97,    10,    11,
-      12,    13,   108,   148,    14,    15,   158,   159,   160,   147,
-     151,    81,    82,   163,   130,   165,   155,    81,    82,    82,
-      24,   113,   116,   157,   124,   171,   115,   120,   162,   128,
-      72,    81,    82,   153,    81,    82,   154,    81,    82,   166,
-      81,    82,   164,   168,   169,   170,   172,   173,   174,    65,
-      71,    83,     0,   150,   111
+      46,    47,     3,    49,    79,    80,    52,   135,   136,    84,
+     161,   162,   163,   158,   119,    85,   127,    43,   168,   147,
+     170,   111,   114,    48,   124,   125,   124,   125,   133,   134,
+     176,    81,    82,    53,   139,    55,    56,   140,   141,    57,
+      54,   145,   -28,    88,    58,   -28,   -28,   -28,   -28,   -28,
+     -28,   -28,   -28,   -28,    89,    50,   -28,   -28,    90,    91,
+     -28,    92,    93,    94,    95,    96,    97,   165,    98,   121,
+     164,   129,   166,    99,     6,     7,     8,     9,    10,    11,
+      12,    13,    44,    45,    14,    15,   155,   142,    55,    56,
+       7,     8,    57,    10,    11,    12,    13,    58,    51,    14,
+      15,    24,   152,   -30,    88,   172,   -30,   -30,   -30,   -30,
+     -30,   -30,   -30,   -30,   -30,    89,    24,   -30,   -30,    90,
+      91,   -30,    92,    93,    94,    95,    96,    97,    61,    98,
+      55,    56,   -81,    88,    99,   -81,   -81,   -81,   -81,   -81,
+     -81,   -81,   -81,   -81,    81,    82,   -81,   -81,    90,    91,
+     -81,   -81,   -81,   -81,   -81,   -81,   132,    62,    98,    81,
+      82,   115,   118,   123,   126,   117,   122,    63,   130,    72,
+      -2,     4,   182,     5,     6,     7,     8,     9,    10,    11,
+      12,    13,    74,    75,    14,    15,    16,   146,    17,    18,
+      19,    20,    21,    22,    76,    88,    23,   149,    77,   -49,
+     -49,    24,   -49,   -49,   -49,   -49,    89,    78,   -49,   -49,
+      90,    91,   106,   107,   108,   109,    72,    81,    82,    86,
+      98,    87,   131,    88,   137,   110,   -72,   -72,   -72,   -72,
+     -72,   -72,   -72,   -72,   138,   151,   -72,   -72,    90,    91,
+     156,    81,    82,   157,    81,    82,   150,   154,    98,   171,
+      81,    82,    82,   123,   158,   160,   167,   169,   173,   174,
+     175,   113,   179,   180,   177,   181,    65,   153,     0,    83,
+       0,     0,     0,     0,     0,    71
 };
 
 static const short int yycheck[] =
 {
-       5,     6,     0,     8,    57,    58,    11,    84,    85,    30,
-       4,     5,     6,     7,     8,     9,    10,    11,    30,    96,
-      14,    15,    24,    25,    26,    25,    26,    29,    81,    82,
-      66,    30,    34,    69,    30,    71,    30,    90,    91,     0,
-       1,    94,     3,     4,     5,     6,     7,     8,     9,    10,
-      11,    12,    25,    14,    15,    16,    17,    18,    19,    20,
-      21,    22,    23,    25,    25,    25,    26,     1,   145,    30,
-       4,     5,     6,     7,     8,     9,    10,    11,    31,    32,
-      14,    15,    16,    17,   137,    25,    26,    92,    30,    29,
-      66,    25,    27,    69,    34,    71,    30,    68,    33,    70,
-     105,     1,   155,     0,     1,     1,     3,     4,     5,     6,
-       7,     8,     9,    10,    11,    12,    30,    14,    15,    16,
-      17,    18,    19,    20,    21,    22,    23,    68,    25,    70,
-      25,     0,     1,    30,     3,     4,     5,     6,     7,     8,
-       9,    10,    11,    30,    30,    14,    15,    16,    17,    18,
-      19,    20,    21,    22,    23,    30,    25,    30,    30,     0,
-       1,    30,     3,     4,     5,     6,     7,     8,     9,    10,
-      11,    30,    30,    14,    15,    16,    30,    18,    19,    20,
-      21,    22,    23,     1,    25,    30,    30,     5,     6,    30,
-       8,     9,    10,    11,    12,     1,    14,    15,    16,    17,
-      18,    19,    20,    21,    14,     5,     6,    25,     8,     9,
-      10,    11,    30,    30,    14,    15,   142,   143,   144,    13,
-      25,    31,    32,   149,    28,   151,    14,    31,    32,    32,
-      30,    67,    68,    30,    70,   161,    67,    68,    30,    70,
-      30,    31,    32,    30,    31,    32,    30,    31,    32,    30,
-      31,    32,    30,    30,    30,    30,    30,    30,    30,    29,
-      40,    59,    -1,   106,    66
+       5,     6,     0,     8,    57,    58,    11,    84,    85,    28,
+     144,   145,   146,    14,    68,    34,    70,    31,   152,    96,
+     154,    66,    66,    31,    69,    69,    71,    71,    81,    82,
+     164,    32,    33,    26,    25,    26,    27,    90,    91,    30,
+      26,    94,     0,     1,    35,     3,     4,     5,     6,     7,
+       8,     9,    10,    11,    12,    31,    14,    15,    16,    17,
+      18,    19,    20,    21,    22,    23,    24,    26,    26,    68,
+     147,    70,    31,    31,     4,     5,     6,     7,     8,     9,
+      10,    11,    26,    27,    14,    15,   139,    92,    26,    27,
+       5,     6,    30,     8,     9,    10,    11,    35,    31,    14,
+      15,    31,   107,     0,     1,   158,     3,     4,     5,     6,
+       7,     8,     9,    10,    11,    12,    31,    14,    15,    16,
+      17,    18,    19,    20,    21,    22,    23,    24,    31,    26,
+      26,    27,     0,     1,    31,     3,     4,     5,     6,     7,
+       8,     9,    10,    11,    32,    33,    14,    15,    16,    17,
+      18,    19,    20,    21,    22,    23,    29,     1,    26,    32,
+      33,    67,    68,    31,    70,    67,    68,     1,    70,    31,
+       0,     1,   177,     3,     4,     5,     6,     7,     8,     9,
+      10,    11,    31,    31,    14,    15,    16,    26,    18,    19,
+      20,    21,    22,    23,    31,     1,    26,     1,    31,     5,
+       6,    31,     8,     9,    10,    11,    12,    31,    14,    15,
+      16,    17,    18,    19,    20,    21,    31,    32,    33,    31,
+      26,    31,    31,     1,    31,    31,     4,     5,     6,     7,
+       8,     9,    10,    11,    31,    31,    14,    15,    16,    17,
+      31,    32,    33,    31,    32,    33,    13,    26,    26,    31,
+      32,    33,    33,    31,    14,    31,    31,    31,    31,    31,
+      31,    66,    31,    31,    34,    31,    29,   108,    -1,    59,
+      -1,    -1,    -1,    -1,    -1,    40
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const unsigned char yystos[] =
 {
-       0,    36,    37,     0,     1,     3,     4,     5,     6,     7,
+       0,    37,    38,     0,     1,     3,     4,     5,     6,     7,
        8,     9,    10,    11,    14,    15,    16,    18,    19,    20,
-      21,    22,    23,    25,    30,    38,    39,    41,    42,    43,
-      44,    47,    48,    50,    54,    56,    58,    59,    61,    63,
-      64,    65,    72,    30,    25,    26,    71,    71,    30,    71,
-      30,    30,    71,    25,    25,    25,    26,    29,    34,    75,
-      76,    30,     1,     1,    45,    45,    51,    53,    57,    68,
-      62,    68,    30,    73,    30,    30,    30,    30,    30,    75,
-      75,    31,    32,    73,    27,    33,    30,    30,     1,    12,
-      16,    17,    19,    20,    21,    22,    23,    25,    30,    40,
-      46,    66,    67,    69,    18,    19,    20,    21,    30,    40,
-      52,    67,    69,    39,    49,    72,    39,    50,    55,    61,
-      72,    30,    40,    69,    39,    50,    60,    61,    72,    30,
-      28,    75,    75,    76,    76,    30,    30,    24,    75,    75,
-      71,    70,    71,    75,    25,    76,     1,    13,    30,    71,
-      70,    25,    75,    30,    30,    14,    74,    30,    74,    74,
-      74,    76,    30,    74,    30,    74,    30,    75,    30,    30,
-      30,    74,    30,    30,    30
+      21,    22,    23,    26,    31,    39,    40,    42,    43,    44,
+      45,    51,    52,    54,    58,    60,    62,    63,    65,    67,
+      68,    69,    76,    31,    26,    27,    75,    75,    31,    75,
+      31,    31,    75,    26,    26,    26,    27,    30,    35,    79,
+      80,    31,     1,     1,    46,    46,    55,    57,    61,    72,
+      66,    72,    31,    77,    31,    31,    31,    31,    31,    79,
+      79,    32,    33,    77,    28,    34,    31,    31,     1,    12,
+      16,    17,    19,    20,    21,    22,    23,    24,    26,    31,
+      41,    47,    48,    70,    71,    73,    18,    19,    20,    21,
+      31,    41,    56,    71,    73,    40,    53,    76,    40,    54,
+      59,    65,    76,    31,    41,    73,    40,    54,    64,    65,
+      76,    31,    29,    79,    79,    80,    80,    31,    31,    25,
+      79,    79,    75,    74,    75,    79,    26,    80,    49,     1,
+      13,    31,    75,    74,    26,    79,    31,    31,    14,    78,
+      31,    78,    78,    78,    80,    26,    31,    31,    78,    31,
+      78,    31,    79,    31,    31,    31,    78,    34,    50,    31,
+      31,    31,    75
 };
 
-#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
-# define YYSIZE_T __SIZE_TYPE__
-#endif
-#if ! defined (YYSIZE_T) && defined (size_t)
-# define YYSIZE_T size_t
-#endif
-#if ! defined (YYSIZE_T)
-# if defined (__STDC__) || defined (__cplusplus)
-#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
-#  define YYSIZE_T size_t
-# endif
-#endif
-#if ! defined (YYSIZE_T)
-# define YYSIZE_T unsigned int
-#endif
-
 #define yyerrok		(yyerrstatus = 0)
 #define yyclearin	(yychar = YYEMPTY)
 #define YYEMPTY		(-2)
@@ -709,8 +765,8 @@ do								\
       goto yybackup;						\
     }								\
   else								\
-    { 								\
-      yyerror ("syntax error: cannot back up");\
+    {								\
+      yyerror (YY_("syntax error: cannot back up")); \
       YYERROR;							\
     }								\
 while (0)
@@ -789,7 +845,7 @@ do {								\
   if (yydebug)							\
     {								\
       YYFPRINTF (stderr, "%s ", Title);				\
-      yysymprint (stderr, 					\
+      yysymprint (stderr,					\
                   Type, Value);	\
       YYFPRINTF (stderr, "\n");					\
     }								\
@@ -837,13 +893,13 @@ yy_reduce_print (yyrule)
 #endif
 {
   int yyi;
-  unsigned int yylno = yyrline[yyrule];
-  YYFPRINTF (stderr, "Reducing stack by rule %d (line %u), ",
+  unsigned long int yylno = yyrline[yyrule];
+  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu), ",
              yyrule - 1, yylno);
   /* Print the symbols being reduced, and their result.  */
   for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
-    YYFPRINTF (stderr, "%s ", yytname [yyrhs[yyi]]);
-  YYFPRINTF (stderr, "-> %s\n", yytname [yyr1[yyrule]]);
+    YYFPRINTF (stderr, "%s ", yytname[yyrhs[yyi]]);
+  YYFPRINTF (stderr, "-> %s\n", yytname[yyr1[yyrule]]);
 }
 
 # define YY_REDUCE_PRINT(Rule)		\
@@ -872,7 +928,7 @@ int yydebug;
    if the built-in stack extension method is used).
 
    Do not make this value too large; the results are undefined if
-   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
+   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
    evaluated with infinite-precision integer arithmetic.  */
 
 #ifndef YYMAXDEPTH
@@ -896,7 +952,7 @@ yystrlen (yystr)
      const char *yystr;
 #   endif
 {
-  register const char *yys = yystr;
+  const char *yys = yystr;
 
   while (*yys++ != '\0')
     continue;
@@ -921,8 +977,8 @@ yystpcpy (yydest, yysrc)
      const char *yysrc;
 #   endif
 {
-  register char *yyd = yydest;
-  register const char *yys = yysrc;
+  char *yyd = yydest;
+  const char *yys = yysrc;
 
   while ((*yyd++ = *yys++) != '\0')
     continue;
@@ -932,7 +988,55 @@ yystpcpy (yydest, yysrc)
 #  endif
 # endif
 
-#endif /* !YYERROR_VERBOSE */
+# ifndef yytnamerr
+/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
+   quotes and backslashes, so that it's suitable for yyerror.  The
+   heuristic is that double-quoting is unnecessary unless the string
+   contains an apostrophe, a comma, or backslash (other than
+   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
+   null, do not copy; instead, return the length of what the result
+   would have been.  */
+static YYSIZE_T
+yytnamerr (char *yyres, const char *yystr)
+{
+  if (*yystr == '"')
+    {
+      size_t yyn = 0;
+      char const *yyp = yystr;
+
+      for (;;)
+	switch (*++yyp)
+	  {
+	  case '\'':
+	  case ',':
+	    goto do_not_strip_quotes;
+
+	  case '\\':
+	    if (*++yyp != '\\')
+	      goto do_not_strip_quotes;
+	    /* Fall through.  */
+	  default:
+	    if (yyres)
+	      yyres[yyn] = *yyp;
+	    yyn++;
+	    break;
+
+	  case '"':
+	    if (yyres)
+	      yyres[yyn] = '\0';
+	    return yyn;
+	  }
+    do_not_strip_quotes: ;
+    }
+
+  if (! yyres)
+    return yystrlen (yystr);
+
+  return yystpcpy (yyres, yystr) - yyres;
+}
+# endif
+
+#endif /* YYERROR_VERBOSE */
 
 
 
@@ -998,7 +1102,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 
   switch (yytype)
     {
-      case 48: /* choice_entry */
+      case 52: /* "choice_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1008,7 +1112,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
         break;
-      case 54: /* if_entry */
+      case 58: /* "if_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1018,7 +1122,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
         break;
-      case 59: /* menu_entry */
+      case 63: /* "menu_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1082,13 +1186,13 @@ yyparse (void)
 #else
 int
 yyparse ()
-
+    ;
 #endif
 #endif
 {
   
-  register int yystate;
-  register int yyn;
+  int yystate;
+  int yyn;
   int yyresult;
   /* Number of tokens to shift before error messages enabled.  */
   int yyerrstatus;
@@ -1106,12 +1210,12 @@ yyparse ()
   /* The state stack.  */
   short int yyssa[YYINITDEPTH];
   short int *yyss = yyssa;
-  register short int *yyssp;
+  short int *yyssp;
 
   /* The semantic value stack.  */
   YYSTYPE yyvsa[YYINITDEPTH];
   YYSTYPE *yyvs = yyvsa;
-  register YYSTYPE *yyvsp;
+  YYSTYPE *yyvsp;
 
 
 
@@ -1143,9 +1247,6 @@ yyparse ()
   yyssp = yyss;
   yyvsp = yyvs;
 
-
-  yyvsp[0] = yylval;
-
   goto yysetstate;
 
 /*------------------------------------------------------------.
@@ -1178,7 +1279,7 @@ yyparse ()
 	   data in use in that stack, in bytes.  This used to be a
 	   conditional around just the two extra args, but that might
 	   be undefined if yyoverflow is a macro.  */
-	yyoverflow ("parser stack overflow",
+	yyoverflow (YY_("memory exhausted"),
 		    &yyss1, yysize * sizeof (*yyssp),
 		    &yyvs1, yysize * sizeof (*yyvsp),
 
@@ -1189,11 +1290,11 @@ yyparse ()
       }
 #else /* no yyoverflow */
 # ifndef YYSTACK_RELOCATE
-      goto yyoverflowlab;
+      goto yyexhaustedlab;
 # else
       /* Extend the stack our own way.  */
       if (YYMAXDEPTH <= yystacksize)
-	goto yyoverflowlab;
+	goto yyexhaustedlab;
       yystacksize *= 2;
       if (YYMAXDEPTH < yystacksize)
 	yystacksize = YYMAXDEPTH;
@@ -1203,7 +1304,7 @@ yyparse ()
 	union yyalloc *yyptr =
 	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
 	if (! yyptr)
-	  goto yyoverflowlab;
+	  goto yyexhaustedlab;
 	YYSTACK_RELOCATE (yyss);
 	YYSTACK_RELOCATE (yyvs);
 
@@ -1403,7 +1504,7 @@ yyreduce:
 ;}
     break;
 
-  case 37:
+  case 38:
 
     {
 	menu_set_type((yyvsp[-2].id)->stype);
@@ -1413,7 +1514,7 @@ yyreduce:
 ;}
     break;
 
-  case 38:
+  case 39:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1421,7 +1522,7 @@ yyreduce:
 ;}
     break;
 
-  case 39:
+  case 40:
 
     {
 	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
@@ -1433,7 +1534,7 @@ yyreduce:
 ;}
     break;
 
-  case 40:
+  case 41:
 
     {
 	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
@@ -1441,7 +1542,7 @@ yyreduce:
 ;}
     break;
 
-  case 41:
+  case 42:
 
     {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
@@ -1449,7 +1550,29 @@ yyreduce:
 ;}
     break;
 
-  case 42:
+  case 45:
+
+    {
+	struct kconf_id *id = kconf_id_lookup((yyvsp[-1].string), strlen((yyvsp[-1].string)));
+	if (id && id->flags & TF_OPTION)
+		menu_add_option(id->token, (yyvsp[0].string));
+	else
+		zconfprint("warning: ignoring unknown option %s", (yyvsp[-1].string));
+	free((yyvsp[-1].string));
+;}
+    break;
+
+  case 46:
+
+    { (yyval.string) = NULL; ;}
+    break;
+
+  case 47:
+
+    { (yyval.string) = (yyvsp[0].string); ;}
+    break;
+
+  case 48:
 
     {
 	struct symbol *sym = sym_lookup(NULL, 0);
@@ -1460,14 +1583,14 @@ yyreduce:
 ;}
     break;
 
-  case 43:
+  case 49:
 
     {
 	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 44:
+  case 50:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_CHOICE, T_ENDCHOICE)) {
@@ -1477,7 +1600,7 @@ yyreduce:
 ;}
     break;
 
-  case 52:
+  case 58:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1485,7 +1608,7 @@ yyreduce:
 ;}
     break;
 
-  case 53:
+  case 59:
 
     {
 	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
@@ -1498,7 +1621,7 @@ yyreduce:
 ;}
     break;
 
-  case 54:
+  case 60:
 
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
@@ -1506,7 +1629,7 @@ yyreduce:
 ;}
     break;
 
-  case 55:
+  case 61:
 
     {
 	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
@@ -1518,7 +1641,7 @@ yyreduce:
 ;}
     break;
 
-  case 58:
+  case 64:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
@@ -1528,7 +1651,7 @@ yyreduce:
 ;}
     break;
 
-  case 59:
+  case 65:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_IF, T_ENDIF)) {
@@ -1538,7 +1661,7 @@ yyreduce:
 ;}
     break;
 
-  case 65:
+  case 71:
 
     {
 	menu_add_entry(NULL);
@@ -1547,14 +1670,14 @@ yyreduce:
 ;}
     break;
 
-  case 66:
+  case 72:
 
     {
 	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 67:
+  case 73:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_MENU, T_ENDMENU)) {
@@ -1564,7 +1687,7 @@ yyreduce:
 ;}
     break;
 
-  case 73:
+  case 79:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
@@ -1572,7 +1695,7 @@ yyreduce:
 ;}
     break;
 
-  case 74:
+  case 80:
 
     {
 	menu_add_entry(NULL);
@@ -1581,14 +1704,14 @@ yyreduce:
 ;}
     break;
 
-  case 75:
+  case 81:
 
     {
 	menu_end_entry();
 ;}
     break;
 
-  case 76:
+  case 82:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
@@ -1596,14 +1719,14 @@ yyreduce:
 ;}
     break;
 
-  case 77:
+  case 83:
 
     {
 	current_entry->sym->help = (yyvsp[0].string);
 ;}
     break;
 
-  case 82:
+  case 88:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1611,7 +1734,7 @@ yyreduce:
 ;}
     break;
 
-  case 83:
+  case 89:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1619,7 +1742,7 @@ yyreduce:
 ;}
     break;
 
-  case 84:
+  case 90:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1627,87 +1750,88 @@ yyreduce:
 ;}
     break;
 
-  case 86:
+  case 92:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
 ;}
     break;
 
-  case 89:
+  case 95:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 90:
+  case 96:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 91:
+  case 97:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 94:
+  case 100:
 
     { (yyval.expr) = NULL; ;}
     break;
 
-  case 95:
+  case 101:
 
     { (yyval.expr) = (yyvsp[0].expr); ;}
     break;
 
-  case 96:
+  case 102:
 
     { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); ;}
     break;
 
-  case 97:
+  case 103:
 
     { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 98:
+  case 104:
 
     { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 99:
+  case 105:
 
     { (yyval.expr) = (yyvsp[-1].expr); ;}
     break;
 
-  case 100:
+  case 106:
 
     { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); ;}
     break;
 
-  case 101:
+  case 107:
 
     { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 102:
+  case 108:
 
     { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 103:
+  case 109:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); ;}
     break;
 
-  case 104:
+  case 110:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 1); free((yyvsp[0].string)); ;}
     break;
 
 
+      default: break;
     }
 
-/* Line 1037 of yacc.c.  */
+/* Line 1126 of yacc.c.  */
 
 
   yyvsp -= yylen;
@@ -1747,12 +1871,36 @@ yyerrlab:
 
       if (YYPACT_NINF < yyn && yyn < YYLAST)
 	{
-	  YYSIZE_T yysize = 0;
 	  int yytype = YYTRANSLATE (yychar);
-	  const char* yyprefix;
-	  char *yymsg;
+	  YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
+	  YYSIZE_T yysize = yysize0;
+	  YYSIZE_T yysize1;
+	  int yysize_overflow = 0;
+	  char *yymsg = 0;
+#	  define YYERROR_VERBOSE_ARGS_MAXIMUM 5
+	  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
 	  int yyx;
 
+#if 0
+	  /* This is so xgettext sees the translatable formats that are
+	     constructed on the fly.  */
+	  YY_("syntax error, unexpected %s");
+	  YY_("syntax error, unexpected %s, expecting %s");
+	  YY_("syntax error, unexpected %s, expecting %s or %s");
+	  YY_("syntax error, unexpected %s, expecting %s or %s or %s");
+	  YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
+#endif
+	  char *yyfmt;
+	  char const *yyf;
+	  static char const yyunexpected[] = "syntax error, unexpected %s";
+	  static char const yyexpecting[] = ", expecting %s";
+	  static char const yyor[] = " or %s";
+	  char yyformat[sizeof yyunexpected
+			+ sizeof yyexpecting - 1
+			+ ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
+			   * (sizeof yyor - 1))];
+	  char const *yyprefix = yyexpecting;
+
 	  /* Start YYX at -YYN if negative to avoid negative indexes in
 	     YYCHECK.  */
 	  int yyxbegin = yyn < 0 ? -yyn : 0;
@@ -1760,48 +1908,68 @@ yyerrlab:
 	  /* Stay within bounds of both yycheck and yytname.  */
 	  int yychecklim = YYLAST - yyn;
 	  int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
-	  int yycount = 0;
+	  int yycount = 1;
+
+	  yyarg[0] = yytname[yytype];
+	  yyfmt = yystpcpy (yyformat, yyunexpected);
 
-	  yyprefix = ", expecting ";
 	  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
 	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
 	      {
-		yysize += yystrlen (yyprefix) + yystrlen (yytname [yyx]);
-		yycount += 1;
-		if (yycount == 5)
+		if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
 		  {
-		    yysize = 0;
+		    yycount = 1;
+		    yysize = yysize0;
+		    yyformat[sizeof yyunexpected - 1] = '\0';
 		    break;
 		  }
+		yyarg[yycount++] = yytname[yyx];
+		yysize1 = yysize + yytnamerr (0, yytname[yyx]);
+		yysize_overflow |= yysize1 < yysize;
+		yysize = yysize1;
+		yyfmt = yystpcpy (yyfmt, yyprefix);
+		yyprefix = yyor;
 	      }
-	  yysize += (sizeof ("syntax error, unexpected ")
-		     + yystrlen (yytname[yytype]));
-	  yymsg = (char *) YYSTACK_ALLOC (yysize);
-	  if (yymsg != 0)
-	    {
-	      char *yyp = yystpcpy (yymsg, "syntax error, unexpected ");
-	      yyp = yystpcpy (yyp, yytname[yytype]);
 
-	      if (yycount < 5)
+	  yyf = YY_(yyformat);
+	  yysize1 = yysize + yystrlen (yyf);
+	  yysize_overflow |= yysize1 < yysize;
+	  yysize = yysize1;
+
+	  if (!yysize_overflow && yysize <= YYSTACK_ALLOC_MAXIMUM)
+	    yymsg = (char *) YYSTACK_ALLOC (yysize);
+	  if (yymsg)
+	    {
+	      /* Avoid sprintf, as that infringes on the user's name space.
+		 Don't have undefined behavior even if the translation
+		 produced a string with the wrong number of "%s"s.  */
+	      char *yyp = yymsg;
+	      int yyi = 0;
+	      while ((*yyp = *yyf))
 		{
-		  yyprefix = ", expecting ";
-		  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
-		    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
-		      {
-			yyp = yystpcpy (yyp, yyprefix);
-			yyp = yystpcpy (yyp, yytname[yyx]);
-			yyprefix = " or ";
-		      }
+		  if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
+		    {
+		      yyp += yytnamerr (yyp, yyarg[yyi++]);
+		      yyf += 2;
+		    }
+		  else
+		    {
+		      yyp++;
+		      yyf++;
+		    }
 		}
 	      yyerror (yymsg);
 	      YYSTACK_FREE (yymsg);
 	    }
 	  else
-	    yyerror ("syntax error; also virtual memory exhausted");
+	    {
+	      yyerror (YY_("syntax error"));
+	      goto yyexhaustedlab;
+	    }
 	}
       else
 #endif /* YYERROR_VERBOSE */
-	yyerror ("syntax error");
+	yyerror (YY_("syntax error"));
     }
 
 
@@ -1813,18 +1981,9 @@ yyerrlab:
 
       if (yychar <= YYEOF)
         {
-          /* If at end of input, pop the error token,
-	     then the rest of the stack, then return failure.  */
+	  /* Return failure if at end of input.  */
 	  if (yychar == YYEOF)
-	     for (;;)
-	       {
-
-		 YYPOPSTACK;
-		 if (yyssp == yyss)
-		   YYABORT;
-		 yydestruct ("Error: popping",
-                             yystos[*yyssp], yyvsp);
-	       }
+	    YYABORT;
         }
       else
 	{
@@ -1843,12 +2002,11 @@ yyerrlab:
 `---------------------------------------------------*/
 yyerrorlab:
 
-#ifdef __GNUC__
-  /* Pacify GCC when the user code never invokes YYERROR and the label
-     yyerrorlab therefore never appears in user code.  */
+  /* Pacify compilers like GCC when the user code never invokes
+     YYERROR and the label yyerrorlab therefore never appears in user
+     code.  */
   if (0)
      goto yyerrorlab;
-#endif
 
 yyvsp -= yylen;
   yyssp -= yylen;
@@ -1911,23 +2069,29 @@ yyacceptlab:
 | yyabortlab -- YYABORT comes here.  |
 `-----------------------------------*/
 yyabortlab:
-  yydestruct ("Error: discarding lookahead",
-              yytoken, &yylval);
-  yychar = YYEMPTY;
   yyresult = 1;
   goto yyreturn;
 
 #ifndef yyoverflow
-/*----------------------------------------------.
-| yyoverflowlab -- parser overflow comes here.  |
-`----------------------------------------------*/
-yyoverflowlab:
-  yyerror ("parser stack overflow");
+/*-------------------------------------------------.
+| yyexhaustedlab -- memory exhaustion comes here.  |
+`-------------------------------------------------*/
+yyexhaustedlab:
+  yyerror (YY_("memory exhausted"));
   yyresult = 2;
   /* Fall through.  */
 #endif
 
 yyreturn:
+  if (yychar != YYEOF && yychar != YYEMPTY)
+     yydestruct ("Cleanup: discarding lookahead",
+		 yytoken, &yylval);
+  while (yyssp != yyss)
+    {
+      yydestruct ("Cleanup: popping",
+		  yystos[*yyssp], yyvsp);
+      YYPOPSTACK;
+    }
 #ifndef yyoverflow
   if (yyss != yyssa)
     YYSTACK_FREE (yyss);
Index: linux-2.6-git/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/zconf.y
+++ linux-2.6-git/scripts/kconfig/zconf.y
@@ -71,6 +71,7 @@ static struct menu *current_menu, *curre
 %token <id>T_DEFAULT
 %token <id>T_SELECT
 %token <id>T_RANGE
+%token <id>T_OPTION
 %token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
@@ -91,6 +92,7 @@ static struct menu *current_menu, *curre
 %type <id> end
 %type <id> option_name
 %type <menu> if_entry menu_entry choice_entry
+%type <string> symbol_option_arg
 
 %destructor {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -173,6 +175,7 @@ menuconfig_stmt: menuconfig_entry_start 
 config_option_list:
 	  /* empty */
 	| config_option_list config_option
+	| config_option_list symbol_option
 	| config_option_list depends
 	| config_option_list help
 	| config_option_list option_error
@@ -215,6 +218,26 @@ config_option: T_RANGE symbol symbol if_
 	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
 };
 
+symbol_option: T_OPTION symbol_option_list T_EOL
+;
+
+symbol_option_list:
+	  /* empty */
+	| symbol_option_list T_WORD symbol_option_arg
+{
+	struct kconf_id *id = kconf_id_lookup($2, strlen($2));
+	if (id && id->flags & TF_OPTION)
+		menu_add_option(id->token, $3);
+	else
+		zconfprint("warning: ignoring unknown option %s", $2);
+	free($2);
+};
+
+symbol_option_arg:
+	  /* empty */		{ $$ = NULL; }
+	| T_EQUAL prompt	{ $$ = $2; }
+;
+
 /* choice entry */
 
 choice: T_CHOICE T_EOL
