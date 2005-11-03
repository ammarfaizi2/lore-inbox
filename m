Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVKCPLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVKCPLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVKCPLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:11:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30665 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030266AbVKCPLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:11:49 -0500
Date: Thu, 3 Nov 2005 16:11:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] kconfig: improve error handling in the parser
Message-ID: <Pine.LNX.4.61.0511031611220.2540@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a few error tokens to the parser to catch common errors and print more 
descriptive error messages.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/lex.zconf.c_shipped |   57 +--
 scripts/kconfig/lkc.h               |    2 
 scripts/kconfig/menu.c              |    5 
 scripts/kconfig/zconf.l             |   42 +-
 scripts/kconfig/zconf.tab.c_shipped |  657 +++++++++++++++++++-----------------
 scripts/kconfig/zconf.y             |  173 +++++----
 6 files changed, 515 insertions(+), 421 deletions(-)

Index: linux-2.6/scripts/kconfig/lex.zconf.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/lex.zconf.c_shipped	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/lex.zconf.c_shipped	2005-11-03 13:31:04.000000000 +0100
@@ -323,7 +323,7 @@ void zconffree (void *  );
 
 /* Begin user sect3 */
 
-#define zconfwrap(n) 1
+#define zconfwrap() 1
 #define YY_SKIP_YYWRAP
 
 typedef unsigned char YY_CHAR;
@@ -686,10 +686,10 @@ struct yy_trans_info
 static yyconst flex_int16_t yy_accept[61] =
     {   0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-       34,    5,    4,    3,    2,    7,    8,    6,   32,   29,
+       34,    5,    4,    2,    3,    7,    8,    6,   32,   29,
        31,   24,   28,   27,   26,   22,   17,   13,   16,   20,
-       22,   11,   12,   19,   19,   14,   22,   22,    4,    3,
-        2,    2,    1,    6,   32,   29,   31,   30,   24,   23,
+       22,   11,   12,   19,   19,   14,   22,   22,    4,    2,
+        3,    3,    1,    6,   32,   29,   31,   30,   24,   23,
        26,   25,   15,   20,    9,   19,   19,   21,   10,   18
     } ;
 
@@ -753,6 +753,11 @@ char *zconftext;
 
 #define START_STRSIZE	16
 
+static struct {
+	struct file *file;
+	int lineno;
+} current_pos;
+
 static char *text;
 static int text_size, text_asize;
 
@@ -766,7 +771,7 @@ struct buffer *current_buf;
 static int last_ts, first_ts;
 
 static void zconf_endhelp(void);
-static struct buffer *zconf_endfile(void);
+static void zconf_endfile(void);
 
 void new_string(void)
 {
@@ -993,17 +998,17 @@ do_action:	/* This label is used only to
 	{ /* beginning of action switch */
 case 1:
 /* rule 1 can match eol */
-YY_RULE_SETUP
-current_file->lineno++;
-	YY_BREAK
 case 2:
+/* rule 2 can match eol */
 YY_RULE_SETUP
-
+{
+	current_file->lineno++;
+	return T_EOL;
+}
 	YY_BREAK
 case 3:
-/* rule 3 can match eol */
 YY_RULE_SETUP
-current_file->lineno++; return T_EOL;
+
 	YY_BREAK
 case 4:
 YY_RULE_SETUP
@@ -1023,8 +1028,10 @@ case 6:
 YY_RULE_SETUP
 {
 		struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
+		BEGIN(PARAM);
+		current_pos.file = current_file;
+		current_pos.lineno = current_file->lineno;
 		if (id && id->flags & TF_COMMAND) {
-			BEGIN(PARAM);
 			zconflval.id = id;
 			return id->token;
 		}
@@ -1040,7 +1047,11 @@ YY_RULE_SETUP
 case 8:
 /* rule 8 can match eol */
 YY_RULE_SETUP
-current_file->lineno++; BEGIN(INITIAL);
+{
+		BEGIN(INITIAL);
+		current_file->lineno++;
+		return T_EOL;
+	}
 	YY_BREAK
 
 case 9:
@@ -1246,9 +1257,9 @@ case YY_STATE_EOF(HELP):
 case YY_STATE_EOF(INITIAL):
 case YY_STATE_EOF(COMMAND):
 {
-	if (current_buf) {
+	if (current_file) {
 		zconf_endfile();
-		return T_EOF;
+		return T_EOL;
 	}
 	fclose(zconfin);
 	yyterminate();
@@ -1958,7 +1969,7 @@ YY_BUFFER_STATE zconf_scan_buffer  (char
 
 /** Setup the input buffer state to scan a string. The next call to zconflex() will
  * scan from a @e copy of @a str.
- * @param str a NUL-terminated string to scan
+ * @param yy_str a NUL-terminated string to scan
  * 
  * @return the newly allocated buffer state object.
  * @note If you want to scan bytes that may contain NUL values, then use
@@ -2276,7 +2287,7 @@ void zconf_nextfile(const char *name)
 	current_file = file;
 }
 
-static struct buffer *zconf_endfile(void)
+static void zconf_endfile(void)
 {
 	struct buffer *parent;
 
@@ -2292,23 +2303,15 @@ static struct buffer *zconf_endfile(void
 	}
 	free(current_buf);
 	current_buf = parent;
-
-	return parent;
 }
 
 int zconf_lineno(void)
 {
-	if (current_buf)
-		return current_file->lineno - 1;
-	else
-		return 0;
+	return current_pos.lineno;
 }
 
 char *zconf_curname(void)
 {
-	if (current_buf)
-		return current_file->name;
-	else
-		return "<none>";
+	return current_pos.file ? current_pos.file->name : "<none>";
 }
 
Index: linux-2.6/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6.orig/scripts/kconfig/lkc.h	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/lkc.h	2005-11-03 13:30:43.000000000 +0100
@@ -64,7 +64,7 @@ void kconfig_load(void);
 
 /* menu.c */
 void menu_init(void);
-void menu_add_menu(void);
+struct menu *menu_add_menu(void);
 void menu_end_menu(void);
 void menu_add_entry(struct symbol *sym);
 void menu_end_entry(void);
Index: linux-2.6/scripts/kconfig/menu.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/menu.c	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/menu.c	2005-11-03 13:30:43.000000000 +0100
@@ -61,10 +61,11 @@ void menu_end_entry(void)
 {
 }
 
-void menu_add_menu(void)
+struct menu *menu_add_menu(void)
 {
-	current_menu = current_entry;
+	menu_end_entry();
 	last_entry_ptr = &current_entry->list;
+	return current_menu = current_entry;
 }
 
 void menu_end_menu(void)
Index: linux-2.6/scripts/kconfig/zconf.l
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.l	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.l	2005-11-03 13:30:43.000000000 +0100
@@ -18,6 +18,11 @@
 
 #define START_STRSIZE	16
 
+static struct {
+	struct file *file;
+	int lineno;
+} current_pos;
+
 static char *text;
 static int text_size, text_asize;
 
@@ -31,7 +36,7 @@ struct buffer *current_buf;
 static int last_ts, first_ts;
 
 static void zconf_endhelp(void);
-static struct buffer *zconf_endfile(void);
+static void zconf_endfile(void);
 
 void new_string(void)
 {
@@ -70,10 +75,13 @@ n	[A-Za-z0-9_]
 	int str = 0;
 	int ts, i;
 
-[ \t]*#.*\n	current_file->lineno++;
+[ \t]*#.*\n	|
+[ \t]*\n	{
+	current_file->lineno++;
+	return T_EOL;
+}
 [ \t]*#.*
 
-[ \t]*\n	current_file->lineno++; return T_EOL;
 
 [ \t]+	{
 	BEGIN(COMMAND);
@@ -88,8 +96,10 @@ n	[A-Za-z0-9_]
 <COMMAND>{
 	{n}+	{
 		struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
+		BEGIN(PARAM);
+		current_pos.file = current_file;
+		current_pos.lineno = current_file->lineno;
 		if (id && id->flags & TF_COMMAND) {
-			BEGIN(PARAM);
 			zconflval.id = id;
 			return id->token;
 		}
@@ -98,7 +108,11 @@ n	[A-Za-z0-9_]
 		return T_WORD;
 	}
 	.
-	\n	current_file->lineno++; BEGIN(INITIAL);
+	\n	{
+		BEGIN(INITIAL);
+		current_file->lineno++;
+		return T_EOL;
+	}
 }
 
 <PARAM>{
@@ -214,9 +228,9 @@ n	[A-Za-z0-9_]
 }
 
 <<EOF>>	{
-	if (current_buf) {
+	if (current_file) {
 		zconf_endfile();
-		return T_EOF;
+		return T_EOL;
 	}
 	fclose(yyin);
 	yyterminate();
@@ -307,7 +321,7 @@ void zconf_nextfile(const char *name)
 	current_file = file;
 }
 
-static struct buffer *zconf_endfile(void)
+static void zconf_endfile(void)
 {
 	struct buffer *parent;
 
@@ -323,22 +337,14 @@ static struct buffer *zconf_endfile(void
 	}
 	free(current_buf);
 	current_buf = parent;
-
-	return parent;
 }
 
 int zconf_lineno(void)
 {
-	if (current_buf)
-		return current_file->lineno - 1;
-	else
-		return 0;
+	return current_pos.lineno;
 }
 
 char *zconf_curname(void)
 {
-	if (current_buf)
-		return current_file->name;
-	else
-		return "<none>";
+	return current_pos.file ? current_pos.file->name : "<none>";
 }
Index: linux-2.6/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:31:04.000000000 +0100
@@ -89,11 +89,10 @@
      T_CLOSE_PAREN = 283,
      T_OPEN_PAREN = 284,
      T_EOL = 285,
-     T_EOF = 286,
-     T_OR = 287,
-     T_AND = 288,
-     T_EQUAL = 289,
-     T_NOT = 290
+     T_OR = 286,
+     T_AND = 287,
+     T_EQUAL = 288,
+     T_NOT = 289
    };
 #endif
 #define T_MAINMENU 258
@@ -124,11 +123,10 @@
 #define T_CLOSE_PAREN 283
 #define T_OPEN_PAREN 284
 #define T_EOL 285
-#define T_EOF 286
-#define T_OR 287
-#define T_AND 288
-#define T_EQUAL 289
-#define T_NOT 290
+#define T_OR 286
+#define T_AND 287
+#define T_EQUAL 288
+#define T_NOT 289
 
 
 
@@ -162,14 +160,18 @@ int cdebug = PRINTD;
 
 extern int zconflex(void);
 static void zconfprint(const char *err, ...);
+static void zconf_error(const char *err, ...);
 static void zconferror(const char *err);
-static bool zconf_endtoken(int token, int starttoken, int endtoken);
+static bool zconf_endtoken(struct kconf_id *id, int starttoken, int endtoken);
 
 struct symbol *symbol_hash[257];
 
 static struct menu *current_menu, *current_entry;
 
+#define YYDEBUG 0
+#if YYDEBUG
 #define YYERROR_VERBOSE
+#endif
 
 
 /* Enabling traces.  */
@@ -188,8 +190,8 @@ static struct menu *current_menu, *curre
 #if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
 
 typedef union YYSTYPE {
-	int token;
 	char *string;
+	struct file *file;
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
@@ -308,22 +310,22 @@ union yyalloc
 #endif
 
 /* YYFINAL -- State number of the termination state. */
-#define YYFINAL  2
+#define YYFINAL  3
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   179
+#define YYLAST   264
 
 /* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  36
+#define YYNTOKENS  35
 /* YYNNTS -- Number of nonterminals. */
-#define YYNNTS  41
+#define YYNNTS  42
 /* YYNRULES -- Number of rules. */
-#define YYNRULES  97
+#define YYNRULES  104
 /* YYNRULES -- Number of states. */
-#define YYNSTATES  159
+#define YYNSTATES  175
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   290
+#define YYMAXUTOK   289
 
 #define YYTRANSLATE(YYX) 						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
@@ -359,8 +361,7 @@ static const unsigned char yytranslate[]
        2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
-      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35
+      25,    26,    27,    28,    29,    30,    31,    32,    33,    34
 };
 
 #if YYDEBUG
@@ -368,65 +369,70 @@ static const unsigned char yytranslate[]
    YYRHS.  */
 static const unsigned short int yyprhs[] =
 {
-       0,     0,     3,     4,     7,     9,    11,    13,    17,    19,
-      21,    23,    26,    28,    30,    32,    34,    36,    38,    42,
-      45,    49,    52,    53,    56,    59,    62,    65,    69,    74,
-      79,    84,    90,    93,    96,    98,   102,   105,   106,   109,
-     112,   115,   118,   123,   127,   130,   135,   136,   139,   143,
-     145,   149,   152,   153,   156,   159,   162,   166,   169,   171,
-     175,   178,   179,   182,   185,   188,   192,   196,   198,   202,
-     205,   208,   211,   212,   215,   218,   223,   227,   231,   232,
-     235,   237,   239,   242,   245,   248,   250,   252,   253,   256,
-     258,   262,   266,   270,   273,   277,   281,   283
+       0,     0,     3,     5,     6,     9,    12,    15,    20,    23,
+      28,    33,    37,    39,    41,    43,    45,    47,    49,    51,
+      53,    55,    57,    59,    61,    63,    67,    70,    74,    77,
+      81,    84,    85,    88,    91,    94,    97,   100,   104,   109,
+     114,   119,   125,   128,   131,   133,   137,   138,   141,   144,
+     147,   150,   153,   158,   162,   165,   170,   171,   174,   178,
+     180,   184,   185,   188,   191,   194,   198,   201,   203,   207,
+     208,   211,   214,   217,   221,   225,   228,   231,   234,   235,
+     238,   241,   244,   249,   253,   257,   258,   261,   263,   265,
+     268,   271,   274,   276,   279,   280,   283,   285,   289,   293,
+     297,   300,   304,   308,   310
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS. */
 static const yysigned_char yyrhs[] =
 {
-      37,     0,    -1,    -1,    37,    38,    -1,    39,    -1,    49,
-      -1,    60,    -1,     3,    71,    73,    -1,     5,    -1,    15,
-      -1,     8,    -1,     1,    73,    -1,    55,    -1,    65,    -1,
-      41,    -1,    43,    -1,    63,    -1,    73,    -1,    10,    25,
-      30,    -1,    40,    44,    -1,    11,    25,    30,    -1,    42,
-      44,    -1,    -1,    44,    45,    -1,    44,    69,    -1,    44,
-      67,    -1,    44,    30,    -1,    20,    70,    30,    -1,    19,
-      71,    74,    30,    -1,    21,    75,    74,    30,    -1,    22,
-      25,    74,    30,    -1,    23,    76,    76,    74,    30,    -1,
-       7,    30,    -1,    46,    50,    -1,    72,    -1,    47,    52,
-      48,    -1,    47,    52,    -1,    -1,    50,    51,    -1,    50,
-      69,    -1,    50,    67,    -1,    50,    30,    -1,    19,    71,
-      74,    30,    -1,    20,    70,    30,    -1,    18,    30,    -1,
-      21,    25,    74,    30,    -1,    -1,    52,    39,    -1,    14,
-      75,    30,    -1,    72,    -1,    53,    56,    54,    -1,    53,
-      56,    -1,    -1,    56,    39,    -1,    56,    60,    -1,    56,
-      49,    -1,     4,    71,    30,    -1,    57,    68,    -1,    72,
-      -1,    58,    61,    59,    -1,    58,    61,    -1,    -1,    61,
-      39,    -1,    61,    60,    -1,    61,    49,    -1,    61,     1,
-      30,    -1,     6,    71,    30,    -1,    62,    -1,     9,    71,
-      30,    -1,    64,    68,    -1,    12,    30,    -1,    66,    13,
-      -1,    -1,    68,    69,    -1,    68,    30,    -1,    16,    24,
-      75,    30,    -1,    16,    75,    30,    -1,    17,    75,    30,
-      -1,    -1,    71,    74,    -1,    25,    -1,    26,    -1,     5,
-      73,    -1,     8,    73,    -1,    15,    73,    -1,    30,    -1,
-      31,    -1,    -1,    14,    75,    -1,    76,    -1,    76,    34,
-      76,    -1,    76,    27,    76,    -1,    29,    75,    28,    -1,
-      35,    75,    -1,    75,    32,    75,    -1,    75,    33,    75,
-      -1,    25,    -1,    26,    -1
+      36,     0,    -1,    37,    -1,    -1,    37,    39,    -1,    37,
+      50,    -1,    37,    61,    -1,    37,     3,    71,    73,    -1,
+      37,    72,    -1,    37,    25,     1,    30,    -1,    37,    38,
+       1,    30,    -1,    37,     1,    30,    -1,    16,    -1,    19,
+      -1,    20,    -1,    22,    -1,    18,    -1,    23,    -1,    21,
+      -1,    30,    -1,    56,    -1,    65,    -1,    42,    -1,    44,
+      -1,    63,    -1,    25,     1,    30,    -1,     1,    30,    -1,
+      10,    25,    30,    -1,    41,    45,    -1,    11,    25,    30,
+      -1,    43,    45,    -1,    -1,    45,    46,    -1,    45,    69,
+      -1,    45,    67,    -1,    45,    40,    -1,    45,    30,    -1,
+      20,    70,    30,    -1,    19,    71,    74,    30,    -1,    21,
+      75,    74,    30,    -1,    22,    25,    74,    30,    -1,    23,
+      76,    76,    74,    30,    -1,     7,    30,    -1,    47,    51,
+      -1,    72,    -1,    48,    53,    49,    -1,    -1,    51,    52,
+      -1,    51,    69,    -1,    51,    67,    -1,    51,    30,    -1,
+      51,    40,    -1,    19,    71,    74,    30,    -1,    20,    70,
+      30,    -1,    18,    30,    -1,    21,    25,    74,    30,    -1,
+      -1,    53,    39,    -1,    14,    75,    73,    -1,    72,    -1,
+      54,    57,    55,    -1,    -1,    57,    39,    -1,    57,    61,
+      -1,    57,    50,    -1,     4,    71,    30,    -1,    58,    68,
+      -1,    72,    -1,    59,    62,    60,    -1,    -1,    62,    39,
+      -1,    62,    61,    -1,    62,    50,    -1,     6,    71,    30,
+      -1,     9,    71,    30,    -1,    64,    68,    -1,    12,    30,
+      -1,    66,    13,    -1,    -1,    68,    69,    -1,    68,    30,
+      -1,    68,    40,    -1,    16,    24,    75,    30,    -1,    16,
+      75,    30,    -1,    17,    75,    30,    -1,    -1,    71,    74,
+      -1,    25,    -1,    26,    -1,     5,    30,    -1,     8,    30,
+      -1,    15,    30,    -1,    30,    -1,    73,    30,    -1,    -1,
+      14,    75,    -1,    76,    -1,    76,    33,    76,    -1,    76,
+      27,    76,    -1,    29,    75,    28,    -1,    34,    75,    -1,
+      75,    31,    75,    -1,    75,    32,    75,    -1,    25,    -1,
+      26,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const unsigned short int yyrline[] =
 {
-       0,    92,    92,    93,    96,    97,    98,    99,   100,   101,
-     102,   103,   107,   108,   109,   110,   111,   112,   118,   126,
-     132,   140,   150,   152,   153,   154,   155,   158,   166,   172,
-     182,   188,   196,   205,   211,   220,   221,   227,   229,   230,
-     231,   232,   235,   241,   252,   258,   268,   270,   275,   284,
-     293,   294,   300,   302,   303,   304,   309,   316,   322,   331,
-     332,   338,   340,   341,   342,   343,   346,   352,   359,   366,
-     373,   379,   386,   387,   388,   391,   396,   401,   409,   411,
-     416,   417,   420,   421,   422,   426,   426,   428,   429,   432,
-     433,   434,   435,   436,   437,   438,   441,   442
+       0,   103,   103,   105,   107,   108,   109,   110,   111,   112,
+     113,   117,   121,   121,   121,   121,   121,   121,   121,   125,
+     126,   127,   128,   129,   130,   134,   135,   141,   149,   155,
+     163,   173,   175,   176,   177,   178,   179,   182,   190,   196,
+     206,   212,   220,   229,   234,   242,   245,   247,   248,   249,
+     250,   251,   254,   260,   271,   277,   287,   289,   294,   302,
+     310,   313,   315,   316,   317,   322,   329,   334,   342,   345,
+     347,   348,   349,   352,   360,   367,   374,   380,   387,   389,
+     390,   391,   394,   399,   404,   412,   414,   419,   420,   423,
+     424,   425,   429,   430,   433,   434,   437,   438,   439,   440,
+     441,   442,   443,   446,   447
 };
 #endif
 
@@ -440,16 +446,16 @@ static const char *const yytname[] =
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
   "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT",
   "T_SELECT", "T_RANGE", "T_ON", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
-  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_EOF", "T_OR", "T_AND",
-  "T_EQUAL", "T_NOT", "$accept", "input", "block", "common_block",
-  "config_entry_start", "config_stmt", "menuconfig_entry_start",
-  "menuconfig_stmt", "config_option_list", "config_option", "choice",
-  "choice_entry", "choice_end", "choice_stmt", "choice_option_list",
-  "choice_option", "choice_block", "if", "if_end", "if_stmt", "if_block",
-  "menu", "menu_entry", "menu_end", "menu_stmt", "menu_block", "source",
-  "source_stmt", "comment", "comment_stmt", "help_start", "help",
-  "depends_list", "depends", "prompt_stmt_opt", "prompt", "end",
-  "nl_or_eof", "if_expr", "expr", "symbol", 0
+  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND", "T_EQUAL",
+  "T_NOT", "$accept", "input", "stmt_list", "option_name", "common_stmt",
+  "option_error", "config_entry_start", "config_stmt",
+  "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
+  "config_option", "choice", "choice_entry", "choice_end", "choice_stmt",
+  "choice_option_list", "choice_option", "choice_block", "if_entry",
+  "if_end", "if_stmt", "if_block", "menu", "menu_entry", "menu_end",
+  "menu_stmt", "menu_block", "source_stmt", "comment", "comment_stmt",
+  "help_start", "help", "depends_list", "depends", "prompt_stmt_opt",
+  "prompt", "end", "nl", "if_expr", "expr", "symbol", 0
 };
 #endif
 
@@ -461,38 +467,40 @@ static const unsigned short int yytoknum
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290
+     285,   286,   287,   288,   289
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const unsigned char yyr1[] =
 {
-       0,    36,    37,    37,    38,    38,    38,    38,    38,    38,
-      38,    38,    39,    39,    39,    39,    39,    39,    40,    41,
-      42,    43,    44,    44,    44,    44,    44,    45,    45,    45,
-      45,    45,    46,    47,    48,    49,    49,    50,    50,    50,
-      50,    50,    51,    51,    51,    51,    52,    52,    53,    54,
-      55,    55,    56,    56,    56,    56,    57,    58,    59,    60,
-      60,    61,    61,    61,    61,    61,    62,    63,    64,    65,
-      66,    67,    68,    68,    68,    69,    69,    69,    70,    70,
-      71,    71,    72,    72,    72,    73,    73,    74,    74,    75,
-      75,    75,    75,    75,    75,    75,    76,    76
+       0,    35,    36,    37,    37,    37,    37,    37,    37,    37,
+      37,    37,    38,    38,    38,    38,    38,    38,    38,    39,
+      39,    39,    39,    39,    39,    40,    40,    41,    42,    43,
+      44,    45,    45,    45,    45,    45,    45,    46,    46,    46,
+      46,    46,    47,    48,    49,    50,    51,    51,    51,    51,
+      51,    51,    52,    52,    52,    52,    53,    53,    54,    55,
+      56,    57,    57,    57,    57,    58,    59,    60,    61,    62,
+      62,    62,    62,    63,    64,    65,    66,    67,    68,    68,
+      68,    68,    69,    69,    69,    70,    70,    71,    71,    72,
+      72,    72,    73,    73,    74,    74,    75,    75,    75,    75,
+      75,    75,    75,    76,    76
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
 static const unsigned char yyr2[] =
 {
-       0,     2,     0,     2,     1,     1,     1,     3,     1,     1,
-       1,     2,     1,     1,     1,     1,     1,     1,     3,     2,
-       3,     2,     0,     2,     2,     2,     2,     3,     4,     4,
-       4,     5,     2,     2,     1,     3,     2,     0,     2,     2,
+       0,     2,     1,     0,     2,     2,     2,     4,     2,     4,
+       4,     3,     1,     1,     1,     1,     1,     1,     1,     1,
+       1,     1,     1,     1,     1,     3,     2,     3,     2,     3,
+       2,     0,     2,     2,     2,     2,     2,     3,     4,     4,
+       4,     5,     2,     2,     1,     3,     0,     2,     2,     2,
        2,     2,     4,     3,     2,     4,     0,     2,     3,     1,
-       3,     2,     0,     2,     2,     2,     3,     2,     1,     3,
-       2,     0,     2,     2,     2,     3,     3,     1,     3,     2,
-       2,     2,     0,     2,     2,     4,     3,     3,     0,     2,
-       1,     1,     2,     2,     2,     1,     1,     0,     2,     1,
-       3,     3,     3,     2,     3,     3,     1,     1
+       3,     0,     2,     2,     2,     3,     2,     1,     3,     0,
+       2,     2,     2,     3,     3,     2,     2,     2,     0,     2,
+       2,     2,     4,     3,     3,     0,     2,     1,     1,     2,
+       2,     2,     1,     2,     0,     2,     1,     3,     3,     3,
+       2,     3,     3,     1,     1
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -500,136 +508,160 @@ static const unsigned char yyr2[] =
    means the default is an error.  */
 static const unsigned char yydefact[] =
 {
-       2,     0,     1,     0,     0,     0,     8,     0,     0,    10,
-       0,     0,     0,     0,     9,    85,    86,     3,     4,    22,
-      14,    22,    15,    37,    46,     5,    52,    12,    72,    61,
-       6,    67,    16,    72,    13,    17,    11,    80,    81,     0,
-       0,     0,    32,     0,     0,     0,    96,    97,     0,     0,
-       0,    89,    19,    21,    33,    36,    51,    57,     0,    69,
-       7,    56,    66,    68,    18,    20,     0,    93,    48,     0,
-       0,     0,     0,     0,     0,     0,     0,    78,     0,     0,
-       0,    26,    23,     0,    25,    24,     0,     0,    78,     0,
-      41,    38,    40,    39,     0,     0,     0,    47,    35,    34,
-      53,    55,    50,    54,    49,    74,    73,     0,    62,    64,
-      59,    63,    58,    92,    94,    95,    91,    90,    70,     0,
-       0,     0,    87,     0,    87,    87,    87,     0,    71,    44,
-      87,     0,    87,    82,    83,    84,    65,     0,    76,    77,
-       0,     0,    27,    79,     0,     0,    87,     0,    43,     0,
-      75,    88,    28,    29,    30,     0,    42,    45,    31
+       3,     0,     0,     1,     0,     0,     0,     0,     0,     0,
+       0,     0,     0,     0,     0,     0,    12,    16,    13,    14,
+      18,    15,    17,     0,    19,     0,     4,    31,    22,    31,
+      23,    46,    56,     5,    61,    20,    78,    69,     6,    24,
+      78,    21,     8,    11,    87,    88,     0,     0,    89,     0,
+      42,    90,     0,     0,     0,   103,   104,     0,     0,     0,
+      96,    91,     0,     0,     0,     0,     0,     0,     0,     0,
+       0,     0,    92,     7,    65,    73,    74,    27,    29,     0,
+     100,     0,     0,    58,     0,     0,     9,    10,     0,     0,
+       0,     0,     0,    85,     0,     0,     0,     0,    36,    35,
+      32,     0,    34,    33,     0,     0,    85,     0,    50,    51,
+      47,    49,    48,    57,    45,    44,    62,    64,    60,    63,
+      59,    80,    81,    79,    70,    72,    68,    71,    67,    93,
+      99,   101,   102,    98,    97,    26,    76,     0,     0,     0,
+      94,     0,    94,    94,    94,     0,     0,    77,    54,    94,
+       0,    94,     0,    83,    84,     0,     0,    37,    86,     0,
+       0,    94,    25,     0,    53,     0,    82,    95,    38,    39,
+      40,     0,    52,    55,    41
 };
 
 /* YYDEFGOTO[NTERM-NUM]. */
 static const short int yydefgoto[] =
 {
-      -1,     1,    17,    18,    19,    20,    21,    22,    52,    82,
-      23,    24,    98,    25,    54,    91,    55,    26,   102,    27,
-      56,    28,    29,   110,    30,    58,    31,    32,    33,    34,
-      83,    84,    57,    85,   123,   124,    99,    35,   141,    50,
-      51
+      -1,     1,     2,    25,    26,    99,    27,    28,    29,    30,
+      64,   100,    31,    32,   114,    33,    66,   110,    67,    34,
+     118,    35,    68,    36,    37,   126,    38,    70,    39,    40,
+      41,   101,   102,    69,   103,   141,   142,    42,    73,   156,
+      59,    60
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -113
+#define YYPACT_NINF -78
 static const short int yypact[] =
 {
-    -113,    37,  -113,   114,   136,   136,  -113,   136,   -29,  -113,
-     136,   -19,   -14,   -10,  -113,  -113,  -113,  -113,  -113,  -113,
-    -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,
-    -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,   114,
-       9,    25,  -113,    56,    60,    65,  -113,  -113,   -10,   -10,
-      33,    -1,   108,   108,    41,   103,    92,     5,    74,     5,
-    -113,  -113,  -113,  -113,  -113,  -113,   115,  -113,  -113,   -10,
-     -10,   138,   138,    80,   111,   -10,   136,   136,   -10,     2,
-     138,  -113,  -113,   113,  -113,  -113,    85,   136,   136,   107,
-    -113,  -113,  -113,  -113,   114,   114,   114,  -113,  -113,  -113,
-    -113,  -113,  -113,  -113,  -113,  -113,  -113,   120,  -113,  -113,
-    -113,  -113,  -113,  -113,   121,  -113,  -113,  -113,  -113,   -10,
-     109,   119,    16,   137,    16,    17,    16,   138,  -113,  -113,
-      16,   139,    16,  -113,  -113,  -113,  -113,   123,  -113,  -113,
-     -10,   140,  -113,  -113,   141,   142,    16,   143,  -113,   144,
-    -113,   133,  -113,  -113,  -113,   145,  -113,  -113,  -113
+     -78,     2,   159,   -78,   -21,     0,     0,   -12,     0,     1,
+       4,     0,    27,    38,    60,    58,   -78,   -78,   -78,   -78,
+     -78,   -78,   -78,   100,   -78,   104,   -78,   -78,   -78,   -78,
+     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
+     -78,   -78,   -78,   -78,   -78,   -78,    86,   113,   -78,   114,
+     -78,   -78,   125,   127,   128,   -78,   -78,    60,    60,   210,
+      65,   -78,   141,   142,    39,   103,   182,   200,     6,    66,
+       6,   131,   -78,   146,   -78,   -78,   -78,   -78,   -78,   196,
+     -78,    60,    60,   146,    40,    40,   -78,   -78,   155,   156,
+      -2,    60,     0,     0,    60,   105,    40,   194,   -78,   -78,
+     -78,   206,   -78,   -78,   183,     0,     0,   195,   -78,   -78,
+     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
+     -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,   -78,
+     -78,   197,   -78,   -78,   -78,   -78,   -78,    60,   213,   216,
+     212,   203,   212,   190,   212,    40,   208,   -78,   -78,   212,
+     222,   212,   219,   -78,   -78,    60,   223,   -78,   -78,   224,
+     225,   212,   -78,   226,   -78,   227,   -78,    47,   -78,   -78,
+     -78,   228,   -78,   -78,   -78
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const short int yypgoto[] =
 {
-    -113,  -113,  -113,    14,  -113,  -113,  -113,  -113,   147,  -113,
-    -113,  -113,  -113,    -2,  -113,  -113,  -113,  -113,  -113,  -113,
-    -113,  -113,  -113,  -113,   101,  -113,  -113,  -113,  -113,  -113,
-    -113,   122,   146,    62,    89,     0,   102,    -3,  -112,   -46,
-     -63
+     -78,   -78,   -78,   -78,   164,   -36,   -78,   -78,   -78,   -78,
+     230,   -78,   -78,   -78,   -78,    29,   -78,   -78,   -78,   -78,
+     -78,   -78,   -78,   -78,   -78,   -78,    59,   -78,   -78,   -78,
+     -78,   -78,   198,   220,    24,   157,    -5,   169,   202,    74,
+     -53,   -77
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
-#define YYTABLE_NINF -61
+#define YYTABLE_NINF -76
 static const short int yytable[] =
 {
-      36,    42,    66,    67,    39,    40,    44,    41,   116,   117,
-      43,    45,   143,   144,   145,    46,    47,   127,   147,    48,
-     149,    74,    75,   114,   115,    49,    71,   126,   120,   121,
-     140,   140,   125,    72,   155,   105,    60,     2,     3,    61,
-       4,     5,     6,     7,     8,     9,    10,    11,    12,    69,
-      70,    13,    14,    73,   101,    62,   109,    74,    75,    86,
-      87,    88,    89,    68,   146,    69,    70,    15,    16,    97,
-     100,    90,   108,   137,   -60,   107,   122,   -60,     5,    94,
-       7,     8,    95,    10,    11,    12,    63,   130,    13,    96,
-      64,   133,   134,   135,   151,    65,     5,    94,     7,     8,
-      95,    10,    11,    12,    15,    16,    13,    96,    94,     7,
-     118,    95,    10,    11,    12,   129,    93,    13,    96,   106,
-      73,   106,    15,    16,    74,    75,   128,    76,    77,    78,
-      79,    80,   132,    15,    16,   119,    46,    47,    81,   138,
-      48,    69,    70,   113,    15,    16,    49,    69,    70,   139,
-     136,    69,    70,   150,    70,    69,    70,   103,   104,   111,
-     112,    37,    38,    46,    47,    69,    70,   142,    53,   148,
-     152,   153,   154,   156,   157,   158,    92,   131,     0,    59
+      46,    47,     3,    49,    79,    80,    52,   133,   134,    43,
+       6,     7,     8,     9,    10,    11,    12,    13,    48,   145,
+      14,    15,   137,    55,    56,    44,    45,    57,   131,   132,
+     109,    50,    58,   122,    51,   122,    24,   138,   139,   -28,
+      88,   143,   -28,   -28,   -28,   -28,   -28,   -28,   -28,   -28,
+     -28,    89,    53,   -28,   -28,    90,    91,   -28,    92,    93,
+      94,    95,    96,    54,    97,    55,    56,    88,   161,    98,
+     -66,   -66,   -66,   -66,   -66,   -66,   -66,   -66,    81,    82,
+     -66,   -66,    90,    91,   152,    55,    56,   140,    61,    57,
+     112,    97,    84,   123,    58,   123,   121,   117,    85,   125,
+     149,    62,   167,   -30,    88,    63,   -30,   -30,   -30,   -30,
+     -30,   -30,   -30,   -30,   -30,    89,    72,   -30,   -30,    90,
+      91,   -30,    92,    93,    94,    95,    96,   119,    97,   127,
+     144,   -75,    88,    98,   -75,   -75,   -75,   -75,   -75,   -75,
+     -75,   -75,   -75,    74,    75,   -75,   -75,    90,    91,   -75,
+     -75,   -75,   -75,   -75,   -75,    76,    97,    77,    78,    -2,
+       4,   121,     5,     6,     7,     8,     9,    10,    11,    12,
+      13,    86,    87,    14,    15,    16,   129,    17,    18,    19,
+      20,    21,    22,    88,    23,   135,   136,   -43,   -43,    24,
+     -43,   -43,   -43,   -43,    89,   146,   -43,   -43,    90,    91,
+     104,   105,   106,   107,   155,     7,     8,    97,    10,    11,
+      12,    13,   108,   148,    14,    15,   158,   159,   160,   147,
+     151,    81,    82,   163,   130,   165,   155,    81,    82,    82,
+      24,   113,   116,   157,   124,   171,   115,   120,   162,   128,
+      72,    81,    82,   153,    81,    82,   154,    81,    82,   166,
+      81,    82,   164,   168,   169,   170,   172,   173,   174,    65,
+      71,    83,     0,   150,   111
 };
 
 static const short int yycheck[] =
 {
-       3,    30,    48,    49,     4,     5,    25,     7,    71,    72,
-      10,    25,   124,   125,   126,    25,    26,    80,   130,    29,
-     132,    16,    17,    69,    70,    35,    27,    25,    74,    75,
-      14,    14,    78,    34,   146,    30,    39,     0,     1,    30,
-       3,     4,     5,     6,     7,     8,     9,    10,    11,    32,
-      33,    14,    15,    12,    56,    30,    58,    16,    17,    18,
-      19,    20,    21,    30,   127,    32,    33,    30,    31,    55,
-      56,    30,    58,   119,     0,     1,    76,     3,     4,     5,
-       6,     7,     8,     9,    10,    11,    30,    87,    14,    15,
-      30,    94,    95,    96,   140,    30,     4,     5,     6,     7,
-       8,     9,    10,    11,    30,    31,    14,    15,     5,     6,
-      30,     8,     9,    10,    11,    30,    54,    14,    15,    57,
-      12,    59,    30,    31,    16,    17,    13,    19,    20,    21,
-      22,    23,    25,    30,    31,    24,    25,    26,    30,    30,
-      29,    32,    33,    28,    30,    31,    35,    32,    33,    30,
-      30,    32,    33,    30,    33,    32,    33,    56,    56,    58,
-      58,    25,    26,    25,    26,    32,    33,    30,    21,    30,
-      30,    30,    30,    30,    30,    30,    54,    88,    -1,    33
+       5,     6,     0,     8,    57,    58,    11,    84,    85,    30,
+       4,     5,     6,     7,     8,     9,    10,    11,    30,    96,
+      14,    15,    24,    25,    26,    25,    26,    29,    81,    82,
+      66,    30,    34,    69,    30,    71,    30,    90,    91,     0,
+       1,    94,     3,     4,     5,     6,     7,     8,     9,    10,
+      11,    12,    25,    14,    15,    16,    17,    18,    19,    20,
+      21,    22,    23,    25,    25,    25,    26,     1,   145,    30,
+       4,     5,     6,     7,     8,     9,    10,    11,    31,    32,
+      14,    15,    16,    17,   137,    25,    26,    92,    30,    29,
+      66,    25,    27,    69,    34,    71,    30,    68,    33,    70,
+     105,     1,   155,     0,     1,     1,     3,     4,     5,     6,
+       7,     8,     9,    10,    11,    12,    30,    14,    15,    16,
+      17,    18,    19,    20,    21,    22,    23,    68,    25,    70,
+      25,     0,     1,    30,     3,     4,     5,     6,     7,     8,
+       9,    10,    11,    30,    30,    14,    15,    16,    17,    18,
+      19,    20,    21,    22,    23,    30,    25,    30,    30,     0,
+       1,    30,     3,     4,     5,     6,     7,     8,     9,    10,
+      11,    30,    30,    14,    15,    16,    30,    18,    19,    20,
+      21,    22,    23,     1,    25,    30,    30,     5,     6,    30,
+       8,     9,    10,    11,    12,     1,    14,    15,    16,    17,
+      18,    19,    20,    21,    14,     5,     6,    25,     8,     9,
+      10,    11,    30,    30,    14,    15,   142,   143,   144,    13,
+      25,    31,    32,   149,    28,   151,    14,    31,    32,    32,
+      30,    67,    68,    30,    70,   161,    67,    68,    30,    70,
+      30,    31,    32,    30,    31,    32,    30,    31,    32,    30,
+      31,    32,    30,    30,    30,    30,    30,    30,    30,    29,
+      40,    59,    -1,   106,    66
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const unsigned char yystos[] =
 {
-       0,    37,     0,     1,     3,     4,     5,     6,     7,     8,
-       9,    10,    11,    14,    15,    30,    31,    38,    39,    40,
-      41,    42,    43,    46,    47,    49,    53,    55,    57,    58,
-      60,    62,    63,    64,    65,    73,    73,    25,    26,    71,
-      71,    71,    30,    71,    25,    25,    25,    26,    29,    35,
-      75,    76,    44,    44,    50,    52,    56,    68,    61,    68,
-      73,    30,    30,    30,    30,    30,    75,    75,    30,    32,
-      33,    27,    34,    12,    16,    17,    19,    20,    21,    22,
-      23,    30,    45,    66,    67,    69,    18,    19,    20,    21,
-      30,    51,    67,    69,     5,     8,    15,    39,    48,    72,
-      39,    49,    54,    60,    72,    30,    69,     1,    39,    49,
-      59,    60,    72,    28,    75,    75,    76,    76,    30,    24,
-      75,    75,    71,    70,    71,    75,    25,    76,    13,    30,
-      71,    70,    25,    73,    73,    73,    30,    75,    30,    30,
-      14,    74,    30,    74,    74,    74,    76,    74,    30,    74,
-      30,    75,    30,    30,    30,    74,    30,    30,    30
+       0,    36,    37,     0,     1,     3,     4,     5,     6,     7,
+       8,     9,    10,    11,    14,    15,    16,    18,    19,    20,
+      21,    22,    23,    25,    30,    38,    39,    41,    42,    43,
+      44,    47,    48,    50,    54,    56,    58,    59,    61,    63,
+      64,    65,    72,    30,    25,    26,    71,    71,    30,    71,
+      30,    30,    71,    25,    25,    25,    26,    29,    34,    75,
+      76,    30,     1,     1,    45,    45,    51,    53,    57,    68,
+      62,    68,    30,    73,    30,    30,    30,    30,    30,    75,
+      75,    31,    32,    73,    27,    33,    30,    30,     1,    12,
+      16,    17,    19,    20,    21,    22,    23,    25,    30,    40,
+      46,    66,    67,    69,    18,    19,    20,    21,    30,    40,
+      52,    67,    69,    39,    49,    72,    39,    50,    55,    61,
+      72,    30,    40,    69,    39,    50,    60,    61,    72,    30,
+      28,    75,    75,    76,    76,    30,    30,    24,    75,    75,
+      71,    70,    71,    75,    25,    76,     1,    13,    30,    71,
+      70,    25,    75,    30,    30,    14,    74,    30,    74,    74,
+      74,    76,    30,    74,    30,    74,    30,    75,    30,    30,
+      30,    74,    30,    30,    30
 };
 
 #if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
@@ -966,6 +998,36 @@ yydestruct (yymsg, yytype, yyvaluep)
 
   switch (yytype)
     {
+      case 48: /* choice_entry */
+
+        {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
+	if (current_menu == (yyvaluep->menu))
+		menu_end_menu();
+};
+
+        break;
+      case 54: /* if_entry */
+
+        {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
+	if (current_menu == (yyvaluep->menu))
+		menu_end_menu();
+};
+
+        break;
+      case 59: /* menu_entry */
+
+        {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		(yyvaluep->menu)->file->name, (yyvaluep->menu)->lineno);
+	if (current_menu == (yyvaluep->menu))
+		menu_end_menu();
+};
+
+        break;
 
       default:
         break;
@@ -1271,25 +1333,37 @@ yyreduce:
     {
         case 8:
 
-    { zconfprint("unexpected 'endmenu' statement"); ;}
+    { zconf_error("unexpected end statement"); ;}
     break;
 
   case 9:
 
-    { zconfprint("unexpected 'endif' statement"); ;}
+    { zconf_error("unknown statement \"%s\"", (yyvsp[-2].string)); ;}
     break;
 
   case 10:
 
-    { zconfprint("unexpected 'endchoice' statement"); ;}
+    {
+	zconf_error("unexpected option \"%s\"", kconf_id_strings + (yyvsp[-2].id)->name);
+;}
     break;
 
   case 11:
 
-    { zconfprint("syntax error"); yyerrok; ;}
+    { zconf_error("invalid statement"); ;}
     break;
 
-  case 18:
+  case 25:
+
+    { zconf_error("unknown option \"%s\"", (yyvsp[-2].string)); ;}
+    break;
+
+  case 26:
+
+    { zconf_error("invalid option"); ;}
+    break;
+
+  case 27:
 
     {
 	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
@@ -1299,7 +1373,7 @@ yyreduce:
 ;}
     break;
 
-  case 19:
+  case 28:
 
     {
 	menu_end_entry();
@@ -1307,7 +1381,7 @@ yyreduce:
 ;}
     break;
 
-  case 20:
+  case 29:
 
     {
 	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
@@ -1317,7 +1391,7 @@ yyreduce:
 ;}
     break;
 
-  case 21:
+  case 30:
 
     {
 	if (current_entry->prompt)
@@ -1329,7 +1403,7 @@ yyreduce:
 ;}
     break;
 
-  case 27:
+  case 37:
 
     {
 	menu_set_type((yyvsp[-2].id)->stype);
@@ -1339,7 +1413,7 @@ yyreduce:
 ;}
     break;
 
-  case 28:
+  case 38:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1347,7 +1421,7 @@ yyreduce:
 ;}
     break;
 
-  case 29:
+  case 39:
 
     {
 	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
@@ -1359,7 +1433,7 @@ yyreduce:
 ;}
     break;
 
-  case 30:
+  case 40:
 
     {
 	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
@@ -1367,7 +1441,7 @@ yyreduce:
 ;}
     break;
 
-  case 31:
+  case 41:
 
     {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
@@ -1375,7 +1449,7 @@ yyreduce:
 ;}
     break;
 
-  case 32:
+  case 42:
 
     {
 	struct symbol *sym = sym_lookup(NULL, 0);
@@ -1386,33 +1460,24 @@ yyreduce:
 ;}
     break;
 
-  case 33:
+  case 43:
 
     {
-	menu_end_entry();
-	menu_add_menu();
+	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 34:
+  case 44:
 
     {
-	if (zconf_endtoken((yyvsp[0].token), T_CHOICE, T_ENDCHOICE)) {
+	if (zconf_endtoken((yyvsp[0].id), T_CHOICE, T_ENDCHOICE)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
 	}
 ;}
     break;
 
-  case 36:
-
-    {
-	printf("%s:%d: missing 'endchoice' for this 'choice' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-;}
-    break;
-
-  case 42:
+  case 52:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1420,7 +1485,7 @@ yyreduce:
 ;}
     break;
 
-  case 43:
+  case 53:
 
     {
 	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
@@ -1433,7 +1498,7 @@ yyreduce:
 ;}
     break;
 
-  case 44:
+  case 54:
 
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
@@ -1441,7 +1506,7 @@ yyreduce:
 ;}
     break;
 
-  case 45:
+  case 55:
 
     {
 	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
@@ -1453,36 +1518,27 @@ yyreduce:
 ;}
     break;
 
-  case 48:
+  case 58:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
 	menu_add_entry(NULL);
 	menu_add_dep((yyvsp[-1].expr));
-	menu_end_entry();
-	menu_add_menu();
+	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 49:
+  case 59:
 
     {
-	if (zconf_endtoken((yyvsp[0].token), T_IF, T_ENDIF)) {
+	if (zconf_endtoken((yyvsp[0].id), T_IF, T_ENDIF)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
 	}
 ;}
     break;
 
-  case 51:
-
-    {
-	printf("%s:%d: missing 'endif' for this 'if' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-;}
-    break;
-
-  case 56:
+  case 65:
 
     {
 	menu_add_entry(NULL);
@@ -1491,53 +1547,32 @@ yyreduce:
 ;}
     break;
 
-  case 57:
+  case 66:
 
     {
-	menu_end_entry();
-	menu_add_menu();
+	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 58:
+  case 67:
 
     {
-	if (zconf_endtoken((yyvsp[0].token), T_MENU, T_ENDMENU)) {
+	if (zconf_endtoken((yyvsp[0].id), T_MENU, T_ENDMENU)) {
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
 	}
 ;}
     break;
 
-  case 60:
+  case 73:
 
     {
-	printf("%s:%d: missing 'endmenu' for this 'menu' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-;}
-    break;
-
-  case 65:
-
-    { zconfprint("invalid menu option"); yyerrok; ;}
-    break;
-
-  case 66:
-
-    {
-	(yyval.string) = (yyvsp[-1].string);
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
+	zconf_nextfile((yyvsp[-1].string));
 ;}
     break;
 
-  case 67:
-
-    {
-	zconf_nextfile((yyvsp[0].string));
-;}
-    break;
-
-  case 68:
+  case 74:
 
     {
 	menu_add_entry(NULL);
@@ -1546,14 +1581,14 @@ yyreduce:
 ;}
     break;
 
-  case 69:
+  case 75:
 
     {
 	menu_end_entry();
 ;}
     break;
 
-  case 70:
+  case 76:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
@@ -1561,14 +1596,14 @@ yyreduce:
 ;}
     break;
 
-  case 71:
+  case 77:
 
     {
 	current_entry->sym->help = (yyvsp[0].string);
 ;}
     break;
 
-  case 75:
+  case 82:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1576,7 +1611,7 @@ yyreduce:
 ;}
     break;
 
-  case 76:
+  case 83:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1584,7 +1619,7 @@ yyreduce:
 ;}
     break;
 
-  case 77:
+  case 84:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1592,79 +1627,79 @@ yyreduce:
 ;}
     break;
 
-  case 79:
+  case 86:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
 ;}
     break;
 
-  case 82:
+  case 89:
 
-    { (yyval.token) = T_ENDMENU; ;}
+    { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 83:
+  case 90:
 
-    { (yyval.token) = T_ENDCHOICE; ;}
+    { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 84:
+  case 91:
 
-    { (yyval.token) = T_ENDIF; ;}
+    { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 87:
+  case 94:
 
     { (yyval.expr) = NULL; ;}
     break;
 
-  case 88:
+  case 95:
 
     { (yyval.expr) = (yyvsp[0].expr); ;}
     break;
 
-  case 89:
+  case 96:
 
     { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); ;}
     break;
 
-  case 90:
+  case 97:
 
     { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 91:
+  case 98:
 
     { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 92:
+  case 99:
 
     { (yyval.expr) = (yyvsp[-1].expr); ;}
     break;
 
-  case 93:
+  case 100:
 
     { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); ;}
     break;
 
-  case 94:
+  case 101:
 
     { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 95:
+  case 102:
 
     { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 96:
+  case 103:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); ;}
     break;
 
-  case 97:
+  case 104:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 1); free((yyvsp[0].string)); ;}
     break;
@@ -1916,7 +1951,10 @@ void conf_parse(const char *name)
 	modules_sym = sym_lookup("MODULES", 0);
 	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
-	//zconfdebug = 1;
+#if YYDEBUG
+	if (getenv("ZCONF_DEBUG"))
+		zconfdebug = 1;
+#endif
 	zconfparse();
 	if (zconfnerrs)
 		exit(1);
@@ -1937,20 +1975,25 @@ const char *zconf_tokenname(int token)
 	case T_ENDCHOICE:	return "endchoice";
 	case T_IF:		return "if";
 	case T_ENDIF:		return "endif";
+	case T_DEPENDS:		return "depends";
 	}
 	return "<token>";
 }
 
-static bool zconf_endtoken(int token, int starttoken, int endtoken)
+static bool zconf_endtoken(struct kconf_id *id, int starttoken, int endtoken)
 {
-	if (token != endtoken) {
-		zconfprint("unexpected '%s' within %s block", zconf_tokenname(token), zconf_tokenname(starttoken));
+	if (id->token != endtoken) {
+		zconf_error("unexpected '%s' within %s block",
+			kconf_id_strings + id->name, zconf_tokenname(starttoken));
 		zconfnerrs++;
 		return false;
 	}
 	if (current_menu->file != current_file) {
-		zconfprint("'%s' in different file than '%s'", zconf_tokenname(token), zconf_tokenname(starttoken));
-		zconfprint("location of the '%s'", zconf_tokenname(starttoken));
+		zconf_error("'%s' in different file than '%s'",
+			kconf_id_strings + id->name, zconf_tokenname(starttoken));
+		fprintf(stderr, "%s:%d: location of the '%s'\n",
+			current_menu->file->name, current_menu->lineno,
+			zconf_tokenname(starttoken));
 		zconfnerrs++;
 		return false;
 	}
@@ -1961,7 +2004,19 @@ static void zconfprint(const char *err, 
 {
 	va_list ap;
 
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno() + 1);
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void zconf_error(const char *err, ...)
+{
+	va_list ap;
+
+	zconfnerrs++;
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
 	va_start(ap, err);
 	vfprintf(stderr, err, ap);
 	va_end(ap);
@@ -1970,7 +2025,9 @@ static void zconfprint(const char *err, 
 
 static void zconferror(const char *err)
 {
+#if YYDEBUG
 	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
+#endif
 }
 
 void print_quoted_string(FILE *out, const char *str)
Index: linux-2.6/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.y	2005-11-03 13:30:38.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.y	2005-11-03 13:30:43.000000000 +0100
@@ -25,21 +25,25 @@ int cdebug = PRINTD;
 
 extern int zconflex(void);
 static void zconfprint(const char *err, ...);
+static void zconf_error(const char *err, ...);
 static void zconferror(const char *err);
-static bool zconf_endtoken(int token, int starttoken, int endtoken);
+static bool zconf_endtoken(struct kconf_id *id, int starttoken, int endtoken);
 
 struct symbol *symbol_hash[257];
 
 static struct menu *current_menu, *current_entry;
 
+#define YYDEBUG 0
+#if YYDEBUG
 #define YYERROR_VERBOSE
+#endif
 %}
-%expect 40
+%expect 26
 
 %union
 {
-	int token;
 	char *string;
+	struct file *file;
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
@@ -74,7 +78,6 @@ static struct menu *current_menu, *curre
 %token T_CLOSE_PAREN
 %token T_OPEN_PAREN
 %token T_EOL
-%token T_EOF
 
 %left T_OR
 %left T_AND
@@ -82,34 +85,54 @@ static struct menu *current_menu, *curre
 %nonassoc T_NOT
 
 %type <string> prompt
-%type <string> source
 %type <symbol> symbol
 %type <expr> expr
 %type <expr> if_expr
-%type <token> end
+%type <id> end
+%type <id> option_name
+%type <menu> if_entry menu_entry choice_entry
+
+%destructor {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		$$->file->name, $$->lineno);
+	if (current_menu == $$)
+		menu_end_menu();
+} if_entry menu_entry choice_entry
 
 %%
-input:	  /* empty */
-	| input block
+input: stmt_list;
+
+stmt_list:
+	  /* empty */
+	| stmt_list common_stmt
+	| stmt_list choice_stmt
+	| stmt_list menu_stmt
+	| stmt_list T_MAINMENU prompt nl
+	| stmt_list end			{ zconf_error("unexpected end statement"); }
+	| stmt_list T_WORD error T_EOL	{ zconf_error("unknown statement \"%s\"", $2); }
+	| stmt_list option_name error T_EOL
+{
+	zconf_error("unexpected option \"%s\"", kconf_id_strings + $2->name);
+}
+	| stmt_list error T_EOL		{ zconf_error("invalid statement"); }
 ;
 
-block:	  common_block
-	| choice_stmt
-	| menu_stmt
-	| T_MAINMENU prompt nl_or_eof
-	| T_ENDMENU		{ zconfprint("unexpected 'endmenu' statement"); }
-	| T_ENDIF		{ zconfprint("unexpected 'endif' statement"); }
-	| T_ENDCHOICE		{ zconfprint("unexpected 'endchoice' statement"); }
-	| error nl_or_eof	{ zconfprint("syntax error"); yyerrok; }
+option_name:
+	T_DEPENDS | T_PROMPT | T_TYPE | T_SELECT | T_OPTIONAL | T_RANGE | T_DEFAULT
 ;
 
-common_block:
-	  if_stmt
+common_stmt:
+	  T_EOL
+	| if_stmt
 	| comment_stmt
 	| config_stmt
 	| menuconfig_stmt
 	| source_stmt
-	| nl_or_eof
+;
+
+option_error:
+	  T_WORD error T_EOL		{ zconf_error("unknown option \"%s\"", $1); }
+	| error T_EOL			{ zconf_error("invalid option"); }
 ;
 
 
@@ -152,6 +175,7 @@ config_option_list:
 	| config_option_list config_option
 	| config_option_list depends
 	| config_option_list help
+	| config_option_list option_error
 	| config_option_list T_EOL
 ;
 
@@ -204,8 +228,7 @@ choice: T_CHOICE T_EOL
 
 choice_entry: choice choice_option_list
 {
-	menu_end_entry();
-	menu_add_menu();
+	$$ = menu_add_menu();
 };
 
 choice_end: end
@@ -216,13 +239,8 @@ choice_end: end
 	}
 };
 
-choice_stmt:
-	  choice_entry choice_block choice_end
-	| choice_entry choice_block
-{
-	printf("%s:%d: missing 'endchoice' for this 'choice' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-};
+choice_stmt: choice_entry choice_block choice_end
+;
 
 choice_option_list:
 	  /* empty */
@@ -230,6 +248,7 @@ choice_option_list:
 	| choice_option_list depends
 	| choice_option_list help
 	| choice_option_list T_EOL
+	| choice_option_list option_error
 ;
 
 choice_option: T_PROMPT prompt if_expr T_EOL
@@ -267,18 +286,17 @@ choice_option: T_DEFAULT T_WORD if_expr 
 
 choice_block:
 	  /* empty */
-	| choice_block common_block
+	| choice_block common_stmt
 ;
 
 /* if entry */
 
-if: T_IF expr T_EOL
+if_entry: T_IF expr nl
 {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
 	menu_add_entry(NULL);
 	menu_add_dep($2);
-	menu_end_entry();
-	menu_add_menu();
+	$$ = menu_add_menu();
 };
 
 if_end: end
@@ -289,17 +307,12 @@ if_end: end
 	}
 };
 
-if_stmt:
-	  if if_block if_end
-	| if if_block
-{
-	printf("%s:%d: missing 'endif' for this 'if' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-};
+if_stmt: if_entry if_block if_end
+;
 
 if_block:
 	  /* empty */
-	| if_block common_block
+	| if_block common_stmt
 	| if_block menu_stmt
 	| if_block choice_stmt
 ;
@@ -315,8 +328,7 @@ menu: T_MENU prompt T_EOL
 
 menu_entry: menu depends_list
 {
-	menu_end_entry();
-	menu_add_menu();
+	$$ = menu_add_menu();
 };
 
 menu_end: end
@@ -327,31 +339,20 @@ menu_end: end
 	}
 };
 
-menu_stmt:
-	  menu_entry menu_block menu_end
-	| menu_entry menu_block
-{
-	printf("%s:%d: missing 'endmenu' for this 'menu' statement\n", current_menu->file->name, current_menu->lineno);
-	zconfnerrs++;
-};
+menu_stmt: menu_entry menu_block menu_end
+;
 
 menu_block:
 	  /* empty */
-	| menu_block common_block
+	| menu_block common_stmt
 	| menu_block menu_stmt
 	| menu_block choice_stmt
-	| menu_block error T_EOL		{ zconfprint("invalid menu option"); yyerrok; }
 ;
 
-source: T_SOURCE prompt T_EOL
+source_stmt: T_SOURCE prompt T_EOL
 {
-	$$ = $2;
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
-};
-
-source_stmt: source
-{
-	zconf_nextfile($1);
+	zconf_nextfile($2);
 };
 
 /* comment entry */
@@ -383,9 +384,11 @@ help: help_start T_HELPTEXT
 
 /* depends option */
 
-depends_list:	  /* empty */
-		| depends_list depends
-		| depends_list T_EOL
+depends_list:
+	  /* empty */
+	| depends_list depends
+	| depends_list T_EOL
+	| depends_list option_error
 ;
 
 depends: T_DEPENDS T_ON expr T_EOL
@@ -417,13 +420,15 @@ prompt:	  T_WORD
 	| T_WORD_QUOTE
 ;
 
-end:	  T_ENDMENU nl_or_eof	{ $$ = T_ENDMENU; }
-	| T_ENDCHOICE nl_or_eof	{ $$ = T_ENDCHOICE; }
-	| T_ENDIF nl_or_eof	{ $$ = T_ENDIF; }
+end:	  T_ENDMENU T_EOL	{ $$ = $1; }
+	| T_ENDCHOICE T_EOL	{ $$ = $1; }
+	| T_ENDIF T_EOL		{ $$ = $1; }
 ;
 
-nl_or_eof:
-	T_EOL | T_EOF;
+nl:
+	  T_EOL
+	| nl T_EOL
+;
 
 if_expr:  /* empty */			{ $$ = NULL; }
 	| T_IF expr			{ $$ = $2; }
@@ -456,7 +461,10 @@ void conf_parse(const char *name)
 	modules_sym = sym_lookup("MODULES", 0);
 	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
-	//zconfdebug = 1;
+#if YYDEBUG
+	if (getenv("ZCONF_DEBUG"))
+		zconfdebug = 1;
+#endif
 	zconfparse();
 	if (zconfnerrs)
 		exit(1);
@@ -477,20 +485,25 @@ const char *zconf_tokenname(int token)
 	case T_ENDCHOICE:	return "endchoice";
 	case T_IF:		return "if";
 	case T_ENDIF:		return "endif";
+	case T_DEPENDS:		return "depends";
 	}
 	return "<token>";
 }
 
-static bool zconf_endtoken(int token, int starttoken, int endtoken)
+static bool zconf_endtoken(struct kconf_id *id, int starttoken, int endtoken)
 {
-	if (token != endtoken) {
-		zconfprint("unexpected '%s' within %s block", zconf_tokenname(token), zconf_tokenname(starttoken));
+	if (id->token != endtoken) {
+		zconf_error("unexpected '%s' within %s block",
+			kconf_id_strings + id->name, zconf_tokenname(starttoken));
 		zconfnerrs++;
 		return false;
 	}
 	if (current_menu->file != current_file) {
-		zconfprint("'%s' in different file than '%s'", zconf_tokenname(token), zconf_tokenname(starttoken));
-		zconfprint("location of the '%s'", zconf_tokenname(starttoken));
+		zconf_error("'%s' in different file than '%s'",
+			kconf_id_strings + id->name, zconf_tokenname(starttoken));
+		fprintf(stderr, "%s:%d: location of the '%s'\n",
+			current_menu->file->name, current_menu->lineno,
+			zconf_tokenname(starttoken));
 		zconfnerrs++;
 		return false;
 	}
@@ -501,7 +514,19 @@ static void zconfprint(const char *err, 
 {
 	va_list ap;
 
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno() + 1);
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void zconf_error(const char *err, ...)
+{
+	va_list ap;
+
+	zconfnerrs++;
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
 	va_start(ap, err);
 	vfprintf(stderr, err, ap);
 	va_end(ap);
@@ -510,7 +535,9 @@ static void zconfprint(const char *err, 
 
 static void zconferror(const char *err)
 {
+#if YYDEBUG
 	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
+#endif
 }
 
 void print_quoted_string(FILE *out, const char *str)
