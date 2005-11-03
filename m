Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVKCPLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVKCPLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKCPLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:11:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30153 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030318AbVKCPLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:11:32 -0500
Date: Thu, 3 Nov 2005 16:11:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] kconfig: simplify symbol type parsing
Message-ID: <Pine.LNX.4.61.0511031610550.2536@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This simplifies the parser a bit by merging the various symbol types into 
a single token and adds the type to the keyword hash.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/lex.zconf.c_shipped  |    5 
 scripts/kconfig/lkc.h                |    1 
 scripts/kconfig/zconf.gperf          |   20 -
 scripts/kconfig/zconf.hash.c_shipped |   20 -
 scripts/kconfig/zconf.l              |    5 
 scripts/kconfig/zconf.tab.c_shipped  |  608 +++++++++++++++--------------------
 scripts/kconfig/zconf.y              |  130 ++-----
 7 files changed, 342 insertions(+), 447 deletions(-)

Index: linux-2.6/scripts/kconfig/lex.zconf.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/lex.zconf.c_shipped	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/lex.zconf.c_shipped	2005-11-03 13:10:34.000000000 +0100
@@ -1025,6 +1025,7 @@ YY_RULE_SETUP
 		struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
 		if (id && id->flags & TF_COMMAND) {
 			BEGIN(PARAM);
+			zconflval.id = id;
 			return id->token;
 		}
 		alloc_string(zconftext, zconfleng);
@@ -1091,8 +1092,10 @@ case 19:
 YY_RULE_SETUP
 {
 		struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
-		if (id && id->flags & TF_PARAM)
+		if (id && id->flags & TF_PARAM) {
+			zconflval.id = id;
 			return id->token;
+		}
 		alloc_string(zconftext, zconfleng);
 		zconflval.string = text;
 		return T_WORD;
Index: linux-2.6/scripts/kconfig/lkc.h
===================================================================
--- linux-2.6.orig/scripts/kconfig/lkc.h	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/lkc.h	2005-11-03 13:10:34.000000000 +0100
@@ -39,6 +39,7 @@ struct kconf_id {
 	int name;
 	int token;
 	unsigned int flags;
+	enum symbol_type stype;
 };
 
 int zconfparse(void);
Index: linux-2.6/scripts/kconfig/zconf.gperf
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.gperf	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.gperf	2005-11-03 13:10:34.000000000 +0100
@@ -25,17 +25,17 @@ endif,		T_ENDIF,	TF_COMMAND
 depends,	T_DEPENDS,	TF_COMMAND
 requires,	T_REQUIRES,	TF_COMMAND
 optional,	T_OPTIONAL,	TF_COMMAND
-default,	T_DEFAULT,	TF_COMMAND
+default,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN
 prompt,		T_PROMPT,	TF_COMMAND
-tristate,	T_TRISTATE,	TF_COMMAND
-def_tristate,	T_DEF_TRISTATE,	TF_COMMAND
-bool,		T_BOOLEAN,	TF_COMMAND
-boolean,	T_BOOLEAN,	TF_COMMAND
-def_bool,	T_DEF_BOOLEAN,	TF_COMMAND
-def_boolean,	T_DEF_BOOLEAN,	TF_COMMAND
-int,		T_INT,		TF_COMMAND
-hex,		T_HEX,		TF_COMMAND
-string,		T_STRING,	TF_COMMAND
+tristate,	T_TYPE,		TF_COMMAND, S_TRISTATE
+def_tristate,	T_DEFAULT,	TF_COMMAND, S_TRISTATE
+bool,		T_TYPE,		TF_COMMAND, S_BOOLEAN
+boolean,	T_TYPE,		TF_COMMAND, S_BOOLEAN
+def_bool,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN
+def_boolean,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN
+int,		T_TYPE,		TF_COMMAND, S_INT
+hex,		T_TYPE,		TF_COMMAND, S_HEX
+string,		T_TYPE,		TF_COMMAND, S_STRING
 select,		T_SELECT,	TF_COMMAND
 enable,		T_SELECT,	TF_COMMAND
 range,		T_RANGE,	TF_COMMAND
Index: linux-2.6/scripts/kconfig/zconf.hash.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.hash.c_shipped	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.hash.c_shipped	2005-11-03 13:10:34.000000000 +0100
@@ -172,27 +172,27 @@ kconf_id_lookup (register const char *st
     {
       {-1}, {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str2,		T_IF,		TF_COMMAND|TF_PARAM},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str3,		T_INT,		TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str3,		T_TYPE,		TF_COMMAND, S_INT},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str4,		T_HELP,		TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str5,		T_ENDIF,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str6,		T_SELECT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str7,	T_ENDMENU,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_TRISTATE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_TYPE,		TF_COMMAND, S_TRISTATE},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str9,	T_ENDCHOICE,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str10,		T_RANGE,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str11,		T_STRING,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str12,	T_DEFAULT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str13,	T_DEF_BOOLEAN,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str11,		T_TYPE,		TF_COMMAND, S_STRING},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str12,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str13,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str14,		T_MENU,		TF_COMMAND},
       {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str16,	T_DEF_BOOLEAN,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,	T_DEF_TRISTATE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str16,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,	T_DEFAULT,	TF_COMMAND, S_TRISTATE},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str18,	T_MAINMENU,	TF_COMMAND},
       {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str20,	T_MENUCONFIG,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_CONFIG,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,		T_ON,		TF_PARAM},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,		T_HEX,		TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,		T_TYPE,		TF_COMMAND, S_HEX},
       {-1}, {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str26,		T_SOURCE,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str27,	T_DEPENDS,	TF_COMMAND},
@@ -201,9 +201,9 @@ kconf_id_lookup (register const char *st
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_SELECT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_COMMENT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str33,	T_REQUIRES,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str34,		T_BOOLEAN,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str34,		T_TYPE,		TF_COMMAND, S_BOOLEAN},
       {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str37,	T_BOOLEAN,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str37,	T_TYPE,		TF_COMMAND, S_BOOLEAN},
       {-1}, {-1}, {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_CHOICE,	TF_COMMAND},
       {-1}, {-1}, {-1}, {-1},
Index: linux-2.6/scripts/kconfig/zconf.l
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.l	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.l	2005-11-03 13:10:34.000000000 +0100
@@ -90,6 +90,7 @@ n	[A-Za-z0-9_]
 		struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
 		if (id && id->flags & TF_COMMAND) {
 			BEGIN(PARAM);
+			zconflval.id = id;
 			return id->token;
 		}
 		alloc_string(yytext, yyleng);
@@ -117,8 +118,10 @@ n	[A-Za-z0-9_]
 	---	/* ignore */
 	({n}|[-/.])+	{
 		struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
-		if (id && id->flags & TF_PARAM)
+		if (id && id->flags & TF_PARAM) {
+			zconflval.id = id;
 			return id->token;
+		}
 		alloc_string(yytext, yyleng);
 		zconflval.string = text;
 		return T_WORD;
Index: linux-2.6/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.tab.c_shipped	2005-11-03 13:10:34.000000000 +0100
@@ -78,28 +78,22 @@
      T_REQUIRES = 272,
      T_OPTIONAL = 273,
      T_PROMPT = 274,
-     T_DEFAULT = 275,
-     T_TRISTATE = 276,
-     T_DEF_TRISTATE = 277,
-     T_BOOLEAN = 278,
-     T_DEF_BOOLEAN = 279,
-     T_STRING = 280,
-     T_INT = 281,
-     T_HEX = 282,
-     T_WORD = 283,
-     T_WORD_QUOTE = 284,
-     T_UNEQUAL = 285,
+     T_TYPE = 275,
+     T_DEFAULT = 276,
+     T_SELECT = 277,
+     T_RANGE = 278,
+     T_ON = 279,
+     T_WORD = 280,
+     T_WORD_QUOTE = 281,
+     T_UNEQUAL = 282,
+     T_CLOSE_PAREN = 283,
+     T_OPEN_PAREN = 284,
+     T_EOL = 285,
      T_EOF = 286,
-     T_EOL = 287,
-     T_CLOSE_PAREN = 288,
-     T_OPEN_PAREN = 289,
-     T_ON = 290,
-     T_SELECT = 291,
-     T_RANGE = 292,
-     T_OR = 293,
-     T_AND = 294,
-     T_EQUAL = 295,
-     T_NOT = 296
+     T_OR = 287,
+     T_AND = 288,
+     T_EQUAL = 289,
+     T_NOT = 290
    };
 #endif
 #define T_MAINMENU 258
@@ -119,28 +113,22 @@
 #define T_REQUIRES 272
 #define T_OPTIONAL 273
 #define T_PROMPT 274
-#define T_DEFAULT 275
-#define T_TRISTATE 276
-#define T_DEF_TRISTATE 277
-#define T_BOOLEAN 278
-#define T_DEF_BOOLEAN 279
-#define T_STRING 280
-#define T_INT 281
-#define T_HEX 282
-#define T_WORD 283
-#define T_WORD_QUOTE 284
-#define T_UNEQUAL 285
+#define T_TYPE 275
+#define T_DEFAULT 276
+#define T_SELECT 277
+#define T_RANGE 278
+#define T_ON 279
+#define T_WORD 280
+#define T_WORD_QUOTE 281
+#define T_UNEQUAL 282
+#define T_CLOSE_PAREN 283
+#define T_OPEN_PAREN 284
+#define T_EOL 285
 #define T_EOF 286
-#define T_EOL 287
-#define T_CLOSE_PAREN 288
-#define T_OPEN_PAREN 289
-#define T_ON 290
-#define T_SELECT 291
-#define T_RANGE 292
-#define T_OR 293
-#define T_AND 294
-#define T_EQUAL 295
-#define T_NOT 296
+#define T_OR 287
+#define T_AND 288
+#define T_EQUAL 289
+#define T_NOT 290
 
 
 
@@ -205,6 +193,7 @@ typedef union YYSTYPE {
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
+	struct kconf_id *id;
 } YYSTYPE;
 /* Line 190 of yacc.c.  */
 
@@ -321,20 +310,20 @@ union yyalloc
 /* YYFINAL -- State number of the termination state. */
 #define YYFINAL  2
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   201
+#define YYLAST   179
 
 /* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  42
+#define YYNTOKENS  36
 /* YYNNTS -- Number of nonterminals. */
 #define YYNNTS  41
 /* YYNRULES -- Number of rules. */
-#define YYNRULES  104
+#define YYNRULES  97
 /* YYNRULES -- Number of states. */
-#define YYNSTATES  182
+#define YYNSTATES  159
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   296
+#define YYMAXUTOK   290
 
 #define YYTRANSLATE(YYX) 						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
@@ -371,7 +360,7 @@ static const unsigned char yytranslate[]
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
       25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35,    36,    37,    38,    39,    40,    41
+      35
 };
 
 #if YYDEBUG
@@ -382,67 +371,62 @@ static const unsigned short int yyprhs[]
        0,     0,     3,     4,     7,     9,    11,    13,    17,    19,
       21,    23,    26,    28,    30,    32,    34,    36,    38,    42,
       45,    49,    52,    53,    56,    59,    62,    65,    69,    74,
-      78,    83,    87,    91,    95,   100,   105,   110,   116,   119,
-     122,   124,   128,   131,   132,   135,   138,   141,   144,   149,
-     153,   157,   160,   165,   166,   169,   173,   175,   179,   182,
-     183,   186,   189,   192,   196,   199,   201,   205,   208,   209,
-     212,   215,   218,   222,   226,   228,   232,   235,   238,   241,
-     242,   245,   248,   253,   257,   261,   262,   265,   267,   269,
-     272,   275,   278,   280,   282,   283,   286,   288,   292,   296,
-     300,   303,   307,   311,   313
+      79,    84,    90,    93,    96,    98,   102,   105,   106,   109,
+     112,   115,   118,   123,   127,   130,   135,   136,   139,   143,
+     145,   149,   152,   153,   156,   159,   162,   166,   169,   171,
+     175,   178,   179,   182,   185,   188,   192,   196,   198,   202,
+     205,   208,   211,   212,   215,   218,   223,   227,   231,   232,
+     235,   237,   239,   242,   245,   248,   250,   252,   253,   256,
+     258,   262,   266,   270,   273,   277,   281,   283
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS. */
 static const yysigned_char yyrhs[] =
 {
-      43,     0,    -1,    -1,    43,    44,    -1,    45,    -1,    55,
-      -1,    66,    -1,     3,    77,    79,    -1,     5,    -1,    15,
-      -1,     8,    -1,     1,    79,    -1,    61,    -1,    71,    -1,
-      47,    -1,    49,    -1,    69,    -1,    79,    -1,    10,    28,
-      32,    -1,    46,    50,    -1,    11,    28,    32,    -1,    48,
-      50,    -1,    -1,    50,    51,    -1,    50,    75,    -1,    50,
-      73,    -1,    50,    32,    -1,    21,    76,    32,    -1,    22,
-      81,    80,    32,    -1,    23,    76,    32,    -1,    24,    81,
-      80,    32,    -1,    26,    76,    32,    -1,    27,    76,    32,
-      -1,    25,    76,    32,    -1,    19,    77,    80,    32,    -1,
-      20,    81,    80,    32,    -1,    36,    28,    80,    32,    -1,
-      37,    82,    82,    80,    32,    -1,     7,    32,    -1,    52,
-      56,    -1,    78,    -1,    53,    58,    54,    -1,    53,    58,
-      -1,    -1,    56,    57,    -1,    56,    75,    -1,    56,    73,
-      -1,    56,    32,    -1,    19,    77,    80,    32,    -1,    21,
-      76,    32,    -1,    23,    76,    32,    -1,    18,    32,    -1,
-      20,    28,    80,    32,    -1,    -1,    58,    45,    -1,    14,
-      81,    32,    -1,    78,    -1,    59,    62,    60,    -1,    59,
-      62,    -1,    -1,    62,    45,    -1,    62,    66,    -1,    62,
-      55,    -1,     4,    77,    32,    -1,    63,    74,    -1,    78,
-      -1,    64,    67,    65,    -1,    64,    67,    -1,    -1,    67,
-      45,    -1,    67,    66,    -1,    67,    55,    -1,    67,     1,
-      32,    -1,     6,    77,    32,    -1,    68,    -1,     9,    77,
-      32,    -1,    70,    74,    -1,    12,    32,    -1,    72,    13,
-      -1,    -1,    74,    75,    -1,    74,    32,    -1,    16,    35,
-      81,    32,    -1,    16,    81,    32,    -1,    17,    81,    32,
-      -1,    -1,    77,    80,    -1,    28,    -1,    29,    -1,     5,
-      79,    -1,     8,    79,    -1,    15,    79,    -1,    32,    -1,
-      31,    -1,    -1,    14,    81,    -1,    82,    -1,    82,    40,
-      82,    -1,    82,    30,    82,    -1,    34,    81,    33,    -1,
-      41,    81,    -1,    81,    38,    81,    -1,    81,    39,    81,
-      -1,    28,    -1,    29,    -1
+      37,     0,    -1,    -1,    37,    38,    -1,    39,    -1,    49,
+      -1,    60,    -1,     3,    71,    73,    -1,     5,    -1,    15,
+      -1,     8,    -1,     1,    73,    -1,    55,    -1,    65,    -1,
+      41,    -1,    43,    -1,    63,    -1,    73,    -1,    10,    25,
+      30,    -1,    40,    44,    -1,    11,    25,    30,    -1,    42,
+      44,    -1,    -1,    44,    45,    -1,    44,    69,    -1,    44,
+      67,    -1,    44,    30,    -1,    20,    70,    30,    -1,    19,
+      71,    74,    30,    -1,    21,    75,    74,    30,    -1,    22,
+      25,    74,    30,    -1,    23,    76,    76,    74,    30,    -1,
+       7,    30,    -1,    46,    50,    -1,    72,    -1,    47,    52,
+      48,    -1,    47,    52,    -1,    -1,    50,    51,    -1,    50,
+      69,    -1,    50,    67,    -1,    50,    30,    -1,    19,    71,
+      74,    30,    -1,    20,    70,    30,    -1,    18,    30,    -1,
+      21,    25,    74,    30,    -1,    -1,    52,    39,    -1,    14,
+      75,    30,    -1,    72,    -1,    53,    56,    54,    -1,    53,
+      56,    -1,    -1,    56,    39,    -1,    56,    60,    -1,    56,
+      49,    -1,     4,    71,    30,    -1,    57,    68,    -1,    72,
+      -1,    58,    61,    59,    -1,    58,    61,    -1,    -1,    61,
+      39,    -1,    61,    60,    -1,    61,    49,    -1,    61,     1,
+      30,    -1,     6,    71,    30,    -1,    62,    -1,     9,    71,
+      30,    -1,    64,    68,    -1,    12,    30,    -1,    66,    13,
+      -1,    -1,    68,    69,    -1,    68,    30,    -1,    16,    24,
+      75,    30,    -1,    16,    75,    30,    -1,    17,    75,    30,
+      -1,    -1,    71,    74,    -1,    25,    -1,    26,    -1,     5,
+      73,    -1,     8,    73,    -1,    15,    73,    -1,    30,    -1,
+      31,    -1,    -1,    14,    75,    -1,    76,    -1,    76,    34,
+      76,    -1,    76,    27,    76,    -1,    29,    75,    28,    -1,
+      35,    75,    -1,    75,    32,    75,    -1,    75,    33,    75,
+      -1,    25,    -1,    26,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const unsigned short int yyrline[] =
 {
-       0,    97,    97,    98,   101,   102,   103,   104,   105,   106,
-     107,   108,   112,   113,   114,   115,   116,   117,   123,   131,
-     137,   145,   155,   157,   158,   159,   160,   163,   169,   176,
-     182,   189,   195,   201,   207,   213,   219,   225,   233,   242,
-     248,   257,   258,   264,   266,   267,   268,   269,   272,   278,
-     284,   290,   296,   302,   304,   309,   318,   327,   328,   334,
-     336,   337,   338,   343,   350,   356,   365,   366,   372,   374,
-     375,   376,   377,   380,   386,   393,   400,   407,   413,   420,
-     421,   422,   425,   430,   435,   443,   445,   450,   451,   454,
-     455,   456,   460,   460,   462,   463,   466,   467,   468,   469,
-     470,   471,   472,   475,   476
+       0,    92,    92,    93,    96,    97,    98,    99,   100,   101,
+     102,   103,   107,   108,   109,   110,   111,   112,   118,   126,
+     132,   140,   150,   152,   153,   154,   155,   158,   166,   172,
+     182,   188,   196,   205,   211,   220,   221,   227,   229,   230,
+     231,   232,   235,   241,   252,   258,   268,   270,   275,   284,
+     293,   294,   300,   302,   303,   304,   309,   316,   322,   331,
+     332,   338,   340,   341,   342,   343,   346,   352,   359,   366,
+     373,   379,   386,   387,   388,   391,   396,   401,   409,   411,
+     416,   417,   420,   421,   422,   426,   426,   428,   429,   432,
+     433,   434,   435,   436,   437,   438,   441,   442
 };
 #endif
 
@@ -454,11 +438,10 @@ static const char *const yytname[] =
   "$end", "error", "$undefined", "T_MAINMENU", "T_MENU", "T_ENDMENU",
   "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
-  "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_DEFAULT", "T_TRISTATE",
-  "T_DEF_TRISTATE", "T_BOOLEAN", "T_DEF_BOOLEAN", "T_STRING", "T_INT",
-  "T_HEX", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL", "T_EOF", "T_EOL",
-  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_ON", "T_SELECT", "T_RANGE", "T_OR",
-  "T_AND", "T_EQUAL", "T_NOT", "$accept", "input", "block", "common_block",
+  "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT",
+  "T_SELECT", "T_RANGE", "T_ON", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
+  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_EOF", "T_OR", "T_AND",
+  "T_EQUAL", "T_NOT", "$accept", "input", "block", "common_block",
   "config_entry_start", "config_stmt", "menuconfig_entry_start",
   "menuconfig_stmt", "config_option_list", "config_option", "choice",
   "choice_entry", "choice_end", "choice_stmt", "choice_option_list",
@@ -478,25 +461,23 @@ static const unsigned short int yytoknum
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
-     295,   296
+     285,   286,   287,   288,   289,   290
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const unsigned char yyr1[] =
 {
-       0,    42,    43,    43,    44,    44,    44,    44,    44,    44,
-      44,    44,    45,    45,    45,    45,    45,    45,    46,    47,
-      48,    49,    50,    50,    50,    50,    50,    51,    51,    51,
-      51,    51,    51,    51,    51,    51,    51,    51,    52,    53,
-      54,    55,    55,    56,    56,    56,    56,    56,    57,    57,
-      57,    57,    57,    58,    58,    59,    60,    61,    61,    62,
-      62,    62,    62,    63,    64,    65,    66,    66,    67,    67,
-      67,    67,    67,    68,    69,    70,    71,    72,    73,    74,
-      74,    74,    75,    75,    75,    76,    76,    77,    77,    78,
-      78,    78,    79,    79,    80,    80,    81,    81,    81,    81,
-      81,    81,    81,    82,    82
+       0,    36,    37,    37,    38,    38,    38,    38,    38,    38,
+      38,    38,    39,    39,    39,    39,    39,    39,    40,    41,
+      42,    43,    44,    44,    44,    44,    44,    45,    45,    45,
+      45,    45,    46,    47,    48,    49,    49,    50,    50,    50,
+      50,    50,    51,    51,    51,    51,    52,    52,    53,    54,
+      55,    55,    56,    56,    56,    56,    57,    58,    59,    60,
+      60,    61,    61,    61,    61,    61,    62,    63,    64,    65,
+      66,    67,    68,    68,    68,    69,    69,    69,    70,    70,
+      71,    71,    72,    72,    72,    73,    73,    74,    74,    75,
+      75,    75,    75,    75,    75,    75,    76,    76
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
@@ -504,15 +485,14 @@ static const unsigned char yyr2[] =
 {
        0,     2,     0,     2,     1,     1,     1,     3,     1,     1,
        1,     2,     1,     1,     1,     1,     1,     1,     3,     2,
-       3,     2,     0,     2,     2,     2,     2,     3,     4,     3,
-       4,     3,     3,     3,     4,     4,     4,     5,     2,     2,
-       1,     3,     2,     0,     2,     2,     2,     2,     4,     3,
-       3,     2,     4,     0,     2,     3,     1,     3,     2,     0,
-       2,     2,     2,     3,     2,     1,     3,     2,     0,     2,
-       2,     2,     3,     3,     1,     3,     2,     2,     2,     0,
-       2,     2,     4,     3,     3,     0,     2,     1,     1,     2,
-       2,     2,     1,     1,     0,     2,     1,     3,     3,     3,
-       2,     3,     3,     1,     1
+       3,     2,     0,     2,     2,     2,     2,     3,     4,     4,
+       4,     5,     2,     2,     1,     3,     2,     0,     2,     2,
+       2,     2,     4,     3,     2,     4,     0,     2,     3,     1,
+       3,     2,     0,     2,     2,     2,     3,     2,     1,     3,
+       2,     0,     2,     2,     2,     3,     3,     1,     3,     2,
+       2,     2,     0,     2,     2,     4,     3,     3,     0,     2,
+       1,     1,     2,     2,     2,     1,     1,     0,     2,     1,
+       3,     3,     3,     2,     3,     3,     1,     1
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -521,69 +501,63 @@ static const unsigned char yyr2[] =
 static const unsigned char yydefact[] =
 {
        2,     0,     1,     0,     0,     0,     8,     0,     0,    10,
-       0,     0,     0,     0,     9,    93,    92,     3,     4,    22,
-      14,    22,    15,    43,    53,     5,    59,    12,    79,    68,
-       6,    74,    16,    79,    13,    17,    11,    87,    88,     0,
-       0,     0,    38,     0,     0,     0,   103,   104,     0,     0,
-       0,    96,    19,    21,    39,    42,    58,    64,     0,    76,
-       7,    63,    73,    75,    18,    20,     0,   100,    55,     0,
-       0,     0,     0,     0,     0,     0,     0,     0,    85,     0,
-      85,     0,    85,    85,    85,    26,     0,     0,    23,     0,
-      25,    24,     0,     0,     0,    85,    85,    47,    44,    46,
-      45,     0,     0,     0,    54,    41,    40,    60,    62,    57,
-      61,    56,    81,    80,     0,    69,    71,    66,    70,    65,
-      99,   101,   102,    98,    97,    77,     0,     0,     0,    94,
-      94,     0,    94,    94,     0,    94,     0,     0,     0,    94,
-       0,    78,    51,    94,    94,     0,     0,    89,    90,    91,
-      72,     0,    83,    84,     0,     0,     0,    27,    86,     0,
-      29,     0,    33,    31,    32,     0,    94,     0,     0,    49,
-      50,    82,    95,    34,    35,    28,    30,    36,     0,    48,
-      52,    37
+       0,     0,     0,     0,     9,    85,    86,     3,     4,    22,
+      14,    22,    15,    37,    46,     5,    52,    12,    72,    61,
+       6,    67,    16,    72,    13,    17,    11,    80,    81,     0,
+       0,     0,    32,     0,     0,     0,    96,    97,     0,     0,
+       0,    89,    19,    21,    33,    36,    51,    57,     0,    69,
+       7,    56,    66,    68,    18,    20,     0,    93,    48,     0,
+       0,     0,     0,     0,     0,     0,     0,    78,     0,     0,
+       0,    26,    23,     0,    25,    24,     0,     0,    78,     0,
+      41,    38,    40,    39,     0,     0,     0,    47,    35,    34,
+      53,    55,    50,    54,    49,    74,    73,     0,    62,    64,
+      59,    63,    58,    92,    94,    95,    91,    90,    70,     0,
+       0,     0,    87,     0,    87,    87,    87,     0,    71,    44,
+      87,     0,    87,    82,    83,    84,    65,     0,    76,    77,
+       0,     0,    27,    79,     0,     0,    87,     0,    43,     0,
+      75,    88,    28,    29,    30,     0,    42,    45,    31
 };
 
 /* YYDEFGOTO[NTERM-NUM]. */
 static const short int yydefgoto[] =
 {
-      -1,     1,    17,    18,    19,    20,    21,    22,    52,    88,
-      23,    24,   105,    25,    54,    98,    55,    26,   109,    27,
-      56,    28,    29,   117,    30,    58,    31,    32,    33,    34,
-      89,    90,    57,    91,   131,   132,   106,    35,   155,    50,
+      -1,     1,    17,    18,    19,    20,    21,    22,    52,    82,
+      23,    24,    98,    25,    54,    91,    55,    26,   102,    27,
+      56,    28,    29,   110,    30,    58,    31,    32,    33,    34,
+      83,    84,    57,    85,   123,   124,    99,    35,   141,    50,
       51
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -99
+#define YYPACT_NINF -113
 static const short int yypact[] =
 {
-     -99,    48,   -99,    38,    46,    46,   -99,    46,   -29,   -99,
-      46,   -17,    -3,   -11,   -99,   -99,   -99,   -99,   -99,   -99,
-     -99,   -99,   -99,   -99,   -99,   -99,   -99,   -99,   -99,   -99,
-     -99,   -99,   -99,   -99,   -99,   -99,   -99,   -99,   -99,    38,
-      12,    15,   -99,    18,    51,    62,   -99,   -99,   -11,   -11,
-       4,   -24,   138,   138,   160,   121,   110,    -4,    81,    -4,
-     -99,   -99,   -99,   -99,   -99,   -99,   -19,   -99,   -99,   -11,
-     -11,    70,    70,    73,    32,   -11,    46,   -11,    46,   -11,
-      46,   -11,    46,    46,    46,   -99,    36,    70,   -99,    95,
-     -99,   -99,    96,    46,   106,    46,    46,   -99,   -99,   -99,
-     -99,    38,    38,    38,   -99,   -99,   -99,   -99,   -99,   -99,
-     -99,   -99,   -99,   -99,   112,   -99,   -99,   -99,   -99,   -99,
-     -99,   117,   -99,   -99,   -99,   -99,   -11,    33,    65,   131,
-       1,   119,   131,     1,   136,     1,   153,   154,   155,   131,
-      70,   -99,   -99,   131,   131,   156,   157,   -99,   -99,   -99,
-     -99,   101,   -99,   -99,   -11,   158,   159,   -99,   -99,   161,
-     -99,   162,   -99,   -99,   -99,   163,   131,   164,   165,   -99,
-     -99,   -99,    99,   -99,   -99,   -99,   -99,   -99,   166,   -99,
-     -99,   -99
+    -113,    37,  -113,   114,   136,   136,  -113,   136,   -29,  -113,
+     136,   -19,   -14,   -10,  -113,  -113,  -113,  -113,  -113,  -113,
+    -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,
+    -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,  -113,   114,
+       9,    25,  -113,    56,    60,    65,  -113,  -113,   -10,   -10,
+      33,    -1,   108,   108,    41,   103,    92,     5,    74,     5,
+    -113,  -113,  -113,  -113,  -113,  -113,   115,  -113,  -113,   -10,
+     -10,   138,   138,    80,   111,   -10,   136,   136,   -10,     2,
+     138,  -113,  -113,   113,  -113,  -113,    85,   136,   136,   107,
+    -113,  -113,  -113,  -113,   114,   114,   114,  -113,  -113,  -113,
+    -113,  -113,  -113,  -113,  -113,  -113,  -113,   120,  -113,  -113,
+    -113,  -113,  -113,  -113,   121,  -113,  -113,  -113,  -113,   -10,
+     109,   119,    16,   137,    16,    17,    16,   138,  -113,  -113,
+      16,   139,    16,  -113,  -113,  -113,  -113,   123,  -113,  -113,
+     -10,   140,  -113,  -113,   141,   142,    16,   143,  -113,   144,
+    -113,   133,  -113,  -113,  -113,   145,  -113,  -113,  -113
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const short int yypgoto[] =
 {
-     -99,   -99,   -99,   111,   -99,   -99,   -99,   -99,   178,   -99,
-     -99,   -99,   -99,    91,   -99,   -99,   -99,   -99,   -99,   -99,
-     -99,   -99,   -99,   -99,   115,   -99,   -99,   -99,   -99,   -99,
-     -99,   146,   168,    89,    27,     0,   126,    -1,   -98,   -48,
+    -113,  -113,  -113,    14,  -113,  -113,  -113,  -113,   147,  -113,
+    -113,  -113,  -113,    -2,  -113,  -113,  -113,  -113,  -113,  -113,
+    -113,  -113,  -113,  -113,   101,  -113,  -113,  -113,  -113,  -113,
+    -113,   122,   146,    62,    89,     0,   102,    -3,  -112,   -46,
      -63
 };
 
@@ -591,80 +565,71 @@ static const short int yypgoto[] =
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
-#define YYTABLE_NINF -68
+#define YYTABLE_NINF -61
 static const short int yytable[] =
 {
-      66,    67,    36,    42,    39,    40,    71,    41,   123,   124,
-      43,    44,    74,    75,   120,   154,    72,    46,    47,    69,
-      70,   121,   122,    48,   140,    45,   127,   128,   112,   130,
-      49,   133,   156,   135,   158,   159,    68,   161,    60,    69,
-      70,   165,    69,    70,    61,   167,   168,    62,     2,     3,
-      63,     4,     5,     6,     7,     8,     9,    10,    11,    12,
-      46,    47,    13,    14,   139,   152,    48,   126,   178,    15,
-      16,    69,    70,    49,    37,    38,   129,   166,   151,    15,
-      16,   -67,   114,    64,   -67,     5,   101,     7,     8,   102,
-      10,    11,    12,   143,    65,    13,   103,   153,    46,    47,
-     147,   148,   149,    69,    70,   125,   172,   134,   141,   136,
-     137,   138,    15,    16,     5,   101,     7,     8,   102,    10,
-      11,    12,   145,   146,    13,   103,   101,     7,   142,   102,
-      10,    11,    12,   171,   144,    13,   103,    69,    70,    69,
-      70,    15,    16,   100,   150,   154,   113,   108,   113,   116,
-      73,   157,    15,    16,    74,    75,    70,    76,    77,    78,
-      79,    80,    81,    82,    83,    84,   104,   107,   160,   115,
-      85,   110,    73,   118,    86,    87,    74,    75,    92,    93,
-      94,    95,   111,    96,   119,   162,   163,   164,   169,   170,
-     173,   174,    97,   175,   176,   177,   179,   180,   181,    53,
-      99,    59
+      36,    42,    66,    67,    39,    40,    44,    41,   116,   117,
+      43,    45,   143,   144,   145,    46,    47,   127,   147,    48,
+     149,    74,    75,   114,   115,    49,    71,   126,   120,   121,
+     140,   140,   125,    72,   155,   105,    60,     2,     3,    61,
+       4,     5,     6,     7,     8,     9,    10,    11,    12,    69,
+      70,    13,    14,    73,   101,    62,   109,    74,    75,    86,
+      87,    88,    89,    68,   146,    69,    70,    15,    16,    97,
+     100,    90,   108,   137,   -60,   107,   122,   -60,     5,    94,
+       7,     8,    95,    10,    11,    12,    63,   130,    13,    96,
+      64,   133,   134,   135,   151,    65,     5,    94,     7,     8,
+      95,    10,    11,    12,    15,    16,    13,    96,    94,     7,
+     118,    95,    10,    11,    12,   129,    93,    13,    96,   106,
+      73,   106,    15,    16,    74,    75,   128,    76,    77,    78,
+      79,    80,   132,    15,    16,   119,    46,    47,    81,   138,
+      48,    69,    70,   113,    15,    16,    49,    69,    70,   139,
+     136,    69,    70,   150,    70,    69,    70,   103,   104,   111,
+     112,    37,    38,    46,    47,    69,    70,   142,    53,   148,
+     152,   153,   154,   156,   157,   158,    92,   131,     0,    59
 };
 
-static const unsigned char yycheck[] =
+static const short int yycheck[] =
 {
-      48,    49,     3,    32,     4,     5,    30,     7,    71,    72,
-      10,    28,    16,    17,    33,    14,    40,    28,    29,    38,
-      39,    69,    70,    34,    87,    28,    74,    75,    32,    77,
-      41,    79,   130,    81,   132,   133,    32,   135,    39,    38,
-      39,   139,    38,    39,    32,   143,   144,    32,     0,     1,
-      32,     3,     4,     5,     6,     7,     8,     9,    10,    11,
-      28,    29,    14,    15,    28,    32,    34,    35,   166,    31,
-      32,    38,    39,    41,    28,    29,    76,   140,   126,    31,
-      32,     0,     1,    32,     3,     4,     5,     6,     7,     8,
-       9,    10,    11,    93,    32,    14,    15,    32,    28,    29,
-     101,   102,   103,    38,    39,    32,   154,    80,    13,    82,
-      83,    84,    31,    32,     4,     5,     6,     7,     8,     9,
-      10,    11,    95,    96,    14,    15,     5,     6,    32,     8,
-       9,    10,    11,    32,    28,    14,    15,    38,    39,    38,
-      39,    31,    32,    54,    32,    14,    57,    56,    59,    58,
-      12,    32,    31,    32,    16,    17,    39,    19,    20,    21,
-      22,    23,    24,    25,    26,    27,    55,    56,    32,    58,
-      32,    56,    12,    58,    36,    37,    16,    17,    18,    19,
-      20,    21,    56,    23,    58,    32,    32,    32,    32,    32,
-      32,    32,    32,    32,    32,    32,    32,    32,    32,    21,
-      54,    33
+       3,    30,    48,    49,     4,     5,    25,     7,    71,    72,
+      10,    25,   124,   125,   126,    25,    26,    80,   130,    29,
+     132,    16,    17,    69,    70,    35,    27,    25,    74,    75,
+      14,    14,    78,    34,   146,    30,    39,     0,     1,    30,
+       3,     4,     5,     6,     7,     8,     9,    10,    11,    32,
+      33,    14,    15,    12,    56,    30,    58,    16,    17,    18,
+      19,    20,    21,    30,   127,    32,    33,    30,    31,    55,
+      56,    30,    58,   119,     0,     1,    76,     3,     4,     5,
+       6,     7,     8,     9,    10,    11,    30,    87,    14,    15,
+      30,    94,    95,    96,   140,    30,     4,     5,     6,     7,
+       8,     9,    10,    11,    30,    31,    14,    15,     5,     6,
+      30,     8,     9,    10,    11,    30,    54,    14,    15,    57,
+      12,    59,    30,    31,    16,    17,    13,    19,    20,    21,
+      22,    23,    25,    30,    31,    24,    25,    26,    30,    30,
+      29,    32,    33,    28,    30,    31,    35,    32,    33,    30,
+      30,    32,    33,    30,    33,    32,    33,    56,    56,    58,
+      58,    25,    26,    25,    26,    32,    33,    30,    21,    30,
+      30,    30,    30,    30,    30,    30,    54,    88,    -1,    33
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const unsigned char yystos[] =
 {
-       0,    43,     0,     1,     3,     4,     5,     6,     7,     8,
-       9,    10,    11,    14,    15,    31,    32,    44,    45,    46,
-      47,    48,    49,    52,    53,    55,    59,    61,    63,    64,
-      66,    68,    69,    70,    71,    79,    79,    28,    29,    77,
-      77,    77,    32,    77,    28,    28,    28,    29,    34,    41,
-      81,    82,    50,    50,    56,    58,    62,    74,    67,    74,
-      79,    32,    32,    32,    32,    32,    81,    81,    32,    38,
-      39,    30,    40,    12,    16,    17,    19,    20,    21,    22,
-      23,    24,    25,    26,    27,    32,    36,    37,    51,    72,
-      73,    75,    18,    19,    20,    21,    23,    32,    57,    73,
-      75,     5,     8,    15,    45,    54,    78,    45,    55,    60,
-      66,    78,    32,    75,     1,    45,    55,    65,    66,    78,
-      33,    81,    81,    82,    82,    32,    35,    81,    81,    77,
-      81,    76,    77,    81,    76,    81,    76,    76,    76,    28,
-      82,    13,    32,    77,    28,    76,    76,    79,    79,    79,
-      32,    81,    32,    32,    14,    80,    80,    32,    80,    80,
-      32,    80,    32,    32,    32,    80,    82,    80,    80,    32,
-      32,    32,    81,    32,    32,    32,    32,    32,    80,    32,
-      32,    32
+       0,    37,     0,     1,     3,     4,     5,     6,     7,     8,
+       9,    10,    11,    14,    15,    30,    31,    38,    39,    40,
+      41,    42,    43,    46,    47,    49,    53,    55,    57,    58,
+      60,    62,    63,    64,    65,    73,    73,    25,    26,    71,
+      71,    71,    30,    71,    25,    25,    25,    26,    29,    35,
+      75,    76,    44,    44,    50,    52,    56,    68,    61,    68,
+      73,    30,    30,    30,    30,    30,    75,    75,    30,    32,
+      33,    27,    34,    12,    16,    17,    19,    20,    21,    22,
+      23,    30,    45,    66,    67,    69,    18,    19,    20,    21,
+      30,    51,    67,    69,     5,     8,    15,    39,    48,    72,
+      39,    49,    54,    60,    72,    30,    69,     1,    39,    49,
+      59,    60,    72,    28,    75,    75,    76,    76,    30,    24,
+      75,    75,    71,    70,    71,    75,    25,    76,    13,    30,
+      71,    70,    25,    73,    73,    73,    30,    75,    30,    30,
+      14,    74,    30,    74,    74,    74,    76,    74,    30,    74,
+      30,    75,    30,    30,    30,    74,    30,    30,    30
 };
 
 #if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
@@ -1367,78 +1332,34 @@ yyreduce:
   case 27:
 
     {
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:tristate\n", zconf_curname(), zconf_lineno());
+	menu_set_type((yyvsp[-2].id)->stype);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		(yyvsp[-2].id)->stype);
 ;}
     break;
 
   case 28:
 
     {
-	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:def_boolean\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 29:
-
-    {
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:boolean\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 30:
-
-    {
-	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:def_boolean\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 31:
-
-    {
-	menu_set_type(S_INT);
-	printd(DEBUG_PARSE, "%s:%d:int\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 32:
-
-    {
-	menu_set_type(S_HEX);
-	printd(DEBUG_PARSE, "%s:%d:hex\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 33:
-
-    {
-	menu_set_type(S_STRING);
-	printd(DEBUG_PARSE, "%s:%d:string\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 34:
-
-    {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 ;}
     break;
 
-  case 35:
+  case 29:
 
     {
 	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
+	if ((yyvsp[-3].id)->stype != S_UNKNOWN)
+		menu_set_type((yyvsp[-3].id)->stype);
+	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		(yyvsp[-3].id)->stype);
 ;}
     break;
 
-  case 36:
+  case 30:
 
     {
 	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
@@ -1446,7 +1367,7 @@ yyreduce:
 ;}
     break;
 
-  case 37:
+  case 31:
 
     {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
@@ -1454,7 +1375,7 @@ yyreduce:
 ;}
     break;
 
-  case 38:
+  case 32:
 
     {
 	struct symbol *sym = sym_lookup(NULL, 0);
@@ -1465,7 +1386,7 @@ yyreduce:
 ;}
     break;
 
-  case 39:
+  case 33:
 
     {
 	menu_end_entry();
@@ -1473,7 +1394,7 @@ yyreduce:
 ;}
     break;
 
-  case 40:
+  case 34:
 
     {
 	if (zconf_endtoken((yyvsp[0].token), T_CHOICE, T_ENDCHOICE)) {
@@ -1483,7 +1404,7 @@ yyreduce:
 ;}
     break;
 
-  case 42:
+  case 36:
 
     {
 	printf("%s:%d: missing 'endchoice' for this 'choice' statement\n", current_menu->file->name, current_menu->lineno);
@@ -1491,7 +1412,7 @@ yyreduce:
 ;}
     break;
 
-  case 48:
+  case 42:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1499,23 +1420,20 @@ yyreduce:
 ;}
     break;
 
-  case 49:
-
-    {
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:tristate\n", zconf_curname(), zconf_lineno());
-;}
-    break;
-
-  case 50:
+  case 43:
 
     {
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:boolean\n", zconf_curname(), zconf_lineno());
+	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
+		menu_set_type((yyvsp[-2].id)->stype);
+		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+			zconf_curname(), zconf_lineno(),
+			(yyvsp[-2].id)->stype);
+	} else
+		YYERROR;
 ;}
     break;
 
-  case 51:
+  case 44:
 
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
@@ -1523,15 +1441,19 @@ yyreduce:
 ;}
     break;
 
-  case 52:
+  case 45:
 
     {
-	menu_add_symbol(P_DEFAULT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
+	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
+		menu_add_symbol(P_DEFAULT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
+		printd(DEBUG_PARSE, "%s:%d:default\n",
+			zconf_curname(), zconf_lineno());
+	} else
+		YYERROR;
 ;}
     break;
 
-  case 55:
+  case 48:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
@@ -1542,7 +1464,7 @@ yyreduce:
 ;}
     break;
 
-  case 56:
+  case 49:
 
     {
 	if (zconf_endtoken((yyvsp[0].token), T_IF, T_ENDIF)) {
@@ -1552,7 +1474,7 @@ yyreduce:
 ;}
     break;
 
-  case 58:
+  case 51:
 
     {
 	printf("%s:%d: missing 'endif' for this 'if' statement\n", current_menu->file->name, current_menu->lineno);
@@ -1560,7 +1482,7 @@ yyreduce:
 ;}
     break;
 
-  case 63:
+  case 56:
 
     {
 	menu_add_entry(NULL);
@@ -1569,7 +1491,7 @@ yyreduce:
 ;}
     break;
 
-  case 64:
+  case 57:
 
     {
 	menu_end_entry();
@@ -1577,7 +1499,7 @@ yyreduce:
 ;}
     break;
 
-  case 65:
+  case 58:
 
     {
 	if (zconf_endtoken((yyvsp[0].token), T_MENU, T_ENDMENU)) {
@@ -1587,7 +1509,7 @@ yyreduce:
 ;}
     break;
 
-  case 67:
+  case 60:
 
     {
 	printf("%s:%d: missing 'endmenu' for this 'menu' statement\n", current_menu->file->name, current_menu->lineno);
@@ -1595,12 +1517,12 @@ yyreduce:
 ;}
     break;
 
-  case 72:
+  case 65:
 
     { zconfprint("invalid menu option"); yyerrok; ;}
     break;
 
-  case 73:
+  case 66:
 
     {
 	(yyval.string) = (yyvsp[-1].string);
@@ -1608,14 +1530,14 @@ yyreduce:
 ;}
     break;
 
-  case 74:
+  case 67:
 
     {
 	zconf_nextfile((yyvsp[0].string));
 ;}
     break;
 
-  case 75:
+  case 68:
 
     {
 	menu_add_entry(NULL);
@@ -1624,14 +1546,14 @@ yyreduce:
 ;}
     break;
 
-  case 76:
+  case 69:
 
     {
 	menu_end_entry();
 ;}
     break;
 
-  case 77:
+  case 70:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
@@ -1639,14 +1561,14 @@ yyreduce:
 ;}
     break;
 
-  case 78:
+  case 71:
 
     {
 	current_entry->sym->help = (yyvsp[0].string);
 ;}
     break;
 
-  case 82:
+  case 75:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1654,7 +1576,7 @@ yyreduce:
 ;}
     break;
 
-  case 83:
+  case 76:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1662,7 +1584,7 @@ yyreduce:
 ;}
     break;
 
-  case 84:
+  case 77:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1670,79 +1592,79 @@ yyreduce:
 ;}
     break;
 
-  case 86:
+  case 79:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
 ;}
     break;
 
-  case 89:
+  case 82:
 
     { (yyval.token) = T_ENDMENU; ;}
     break;
 
-  case 90:
+  case 83:
 
     { (yyval.token) = T_ENDCHOICE; ;}
     break;
 
-  case 91:
+  case 84:
 
     { (yyval.token) = T_ENDIF; ;}
     break;
 
-  case 94:
+  case 87:
 
     { (yyval.expr) = NULL; ;}
     break;
 
-  case 95:
+  case 88:
 
     { (yyval.expr) = (yyvsp[0].expr); ;}
     break;
 
-  case 96:
+  case 89:
 
     { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); ;}
     break;
 
-  case 97:
+  case 90:
 
     { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 98:
+  case 91:
 
     { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 99:
+  case 92:
 
     { (yyval.expr) = (yyvsp[-1].expr); ;}
     break;
 
-  case 100:
+  case 93:
 
     { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); ;}
     break;
 
-  case 101:
+  case 94:
 
     { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 102:
+  case 95:
 
     { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 103:
+  case 96:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); ;}
     break;
 
-  case 104:
+  case 97:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 1); free((yyvsp[0].string)); ;}
     break;
Index: linux-2.6/scripts/kconfig/zconf.y
===================================================================
--- linux-2.6.orig/scripts/kconfig/zconf.y	2005-11-03 13:10:32.000000000 +0100
+++ linux-2.6/scripts/kconfig/zconf.y	2005-11-03 13:10:34.000000000 +0100
@@ -43,43 +43,38 @@ static struct menu *current_menu, *curre
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
+	struct kconf_id *id;
 }
 
-%token T_MAINMENU
-%token T_MENU
-%token T_ENDMENU
-%token T_SOURCE
-%token T_CHOICE
-%token T_ENDCHOICE
-%token T_COMMENT
-%token T_CONFIG
-%token T_MENUCONFIG
-%token T_HELP
+%token <id>T_MAINMENU
+%token <id>T_MENU
+%token <id>T_ENDMENU
+%token <id>T_SOURCE
+%token <id>T_CHOICE
+%token <id>T_ENDCHOICE
+%token <id>T_COMMENT
+%token <id>T_CONFIG
+%token <id>T_MENUCONFIG
+%token <id>T_HELP
 %token <string> T_HELPTEXT
-%token T_IF
-%token T_ENDIF
-%token T_DEPENDS
-%token T_REQUIRES
-%token T_OPTIONAL
-%token T_PROMPT
-%token T_DEFAULT
-%token T_TRISTATE
-%token T_DEF_TRISTATE
-%token T_BOOLEAN
-%token T_DEF_BOOLEAN
-%token T_STRING
-%token T_INT
-%token T_HEX
+%token <id>T_IF
+%token <id>T_ENDIF
+%token <id>T_DEPENDS
+%token <id>T_REQUIRES
+%token <id>T_OPTIONAL
+%token <id>T_PROMPT
+%token <id>T_TYPE
+%token <id>T_DEFAULT
+%token <id>T_SELECT
+%token <id>T_RANGE
+%token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
 %token T_UNEQUAL
-%token T_EOF
-%token T_EOL
 %token T_CLOSE_PAREN
 %token T_OPEN_PAREN
-%token T_ON
-%token T_SELECT
-%token T_RANGE
+%token T_EOL
+%token T_EOF
 
 %left T_OR
 %left T_AND
@@ -160,48 +155,12 @@ config_option_list:
 	| config_option_list T_EOL
 ;
 
-config_option: T_TRISTATE prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:tristate\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_DEF_TRISTATE expr if_expr T_EOL
+config_option: T_TYPE prompt_stmt_opt T_EOL
 {
-	menu_add_expr(P_DEFAULT, $2, $3);
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:def_boolean\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_BOOLEAN prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:boolean\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_DEF_BOOLEAN expr if_expr T_EOL
-{
-	menu_add_expr(P_DEFAULT, $2, $3);
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:def_boolean\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_INT prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_INT);
-	printd(DEBUG_PARSE, "%s:%d:int\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_HEX prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_HEX);
-	printd(DEBUG_PARSE, "%s:%d:hex\n", zconf_curname(), zconf_lineno());
-};
-
-config_option: T_STRING prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_STRING);
-	printd(DEBUG_PARSE, "%s:%d:string\n", zconf_curname(), zconf_lineno());
+	menu_set_type($1->stype);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1->stype);
 };
 
 config_option: T_PROMPT prompt if_expr T_EOL
@@ -213,7 +172,11 @@ config_option: T_PROMPT prompt if_expr T
 config_option: T_DEFAULT expr if_expr T_EOL
 {
 	menu_add_expr(P_DEFAULT, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
+	if ($1->stype != S_UNKNOWN)
+		menu_set_type($1->stype);
+	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1->stype);
 };
 
 config_option: T_SELECT T_WORD if_expr T_EOL
@@ -275,16 +238,15 @@ choice_option: T_PROMPT prompt if_expr T
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 };
 
-choice_option: T_TRISTATE prompt_stmt_opt T_EOL
-{
-	menu_set_type(S_TRISTATE);
-	printd(DEBUG_PARSE, "%s:%d:tristate\n", zconf_curname(), zconf_lineno());
-};
-
-choice_option: T_BOOLEAN prompt_stmt_opt T_EOL
+choice_option: T_TYPE prompt_stmt_opt T_EOL
 {
-	menu_set_type(S_BOOLEAN);
-	printd(DEBUG_PARSE, "%s:%d:boolean\n", zconf_curname(), zconf_lineno());
+	if ($1->stype == S_BOOLEAN || $1->stype == S_TRISTATE) {
+		menu_set_type($1->stype);
+		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+			zconf_curname(), zconf_lineno(),
+			$1->stype);
+	} else
+		YYERROR;
 };
 
 choice_option: T_OPTIONAL T_EOL
@@ -295,8 +257,12 @@ choice_option: T_OPTIONAL T_EOL
 
 choice_option: T_DEFAULT T_WORD if_expr T_EOL
 {
-	menu_add_symbol(P_DEFAULT, sym_lookup($2, 0), $3);
-	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
+	if ($1->stype == S_UNKNOWN) {
+		menu_add_symbol(P_DEFAULT, sym_lookup($2, 0), $3);
+		printd(DEBUG_PARSE, "%s:%d:default\n",
+			zconf_curname(), zconf_lineno());
+	} else
+		YYERROR;
 };
 
 choice_block:
