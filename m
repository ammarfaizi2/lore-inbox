Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSKWWBG>; Sat, 23 Nov 2002 17:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267108AbSKWWBG>; Sat, 23 Nov 2002 17:01:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36612 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267107AbSKWWBB>;
	Sat, 23 Nov 2002 17:01:01 -0500
Date: Sat, 23 Nov 2002 23:07:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: kconfig: Locate files relative to $srctree
Message-ID: <20021123220747.GA10411@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman

This patch to kconfig teach it to try locating inputfiles
relative to $srctree as a second choice.
The purpose of this patch is to make support for separate
src/obj dir simpler, in other words to avoid symlinking Kconfig
and defconfig files.

With the current implementation I decided to try normal path
first, and second the path with $srctree prefixed.

Some codepaths could be simpler if we decide always to
prefix with $srctree.

I considered adding a command line option, but then changes
were required in all frontends.
Therefore I decided to build-in knowledge of $srctree instead.

When/if we you acknowledge this I would like you to push to Linus.

Comments appreciated.

	Sam

The cset includes _shipped files, which I deleted on purpose.
It includes the following changes:

 Makefile   |    5 ++++-
 confdata.c |   13 ++++++++++---
 expr.h     |    2 ++
 symbol.c   |    7 +++++++
 zconf.l    |   27 +++++++++++++++++++++++++--
 5 files changed, 48 insertions(+), 6 deletions(-)

To try it out uncomment LKC_GENPARSER in Makefile.

Complete bk cset will shortly be available for pulling at:
http://linux-sam.bkbits.net/sepobjdir

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.858  
#	scripts/kconfig/symbol.c	1.2     -> 1.3    
#	scripts/kconfig/zconf.tab.c_shipped	1.2     -> 1.3    
#	scripts/kconfig/expr.h	1.2     -> 1.3    
#	scripts/kconfig/zconf.l	1.3     -> 1.4    
#	scripts/kconfig/lex.zconf.c_shipped	1.3     -> 1.4    
#	scripts/kconfig/zconf.tab.h_shipped	1.2     -> 1.3    
#	scripts/kconfig/confdata.c	1.3     -> 1.4    
#	scripts/kconfig/Makefile	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/23	sam@mars.ravnborg.org	1.858
# kconfig: Try to locate files in $srctree
# 
# In order to support separate src/obj dir, try locating
# files in tree pointed out by $srctree as second alternative
# --------------------------------------------
#
diff -Nru a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
--- a/scripts/kconfig/symbol.c	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/symbol.c	Sat Nov 23 22:53:43 2002
@@ -75,6 +75,13 @@
 	if (p)
 		sym_add_default(sym, p);
 
+	sym = sym_lookup(SRCTREE, 0);
+	sym->type = S_STRING;
+	sym->flags |= SYMBOL_AUTO;
+	p = getenv(SRCTREE);
+	if (p)
+		sym_add_default(sym, p);
+	
 	sym = sym_lookup("UNAME_RELEASE", 0);
 	sym->type = S_STRING;
 	sym->flags |= SYMBOL_AUTO;
diff -Nru a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
--- a/scripts/kconfig/zconf.l	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/zconf.l	Sat Nov 23 22:53:43 2002
@@ -249,9 +249,32 @@
 	BEGIN(INITIAL); 
 }
 
+/* 
+   Try to open specified file with following names:
+   ./name
+   $(srctree)/name
+   The latter is used when srctree is separate from objtree
+   when compiling the kernel.
+   Return NULL if file is not found.
+*/
+static FILE *zconf_fopen(const char *name)
+{
+	static char fullname[SYMBOL_MAXLENGTH];
+	static char *p;
+	FILE *f = fopen(name, "r");
+	if (f)
+		return f;
+	p = getenv(SRCTREE);
+	if (p) {
+		sprintf(fullname, "%s/%s", p, name);
+		return fopen(fullname, "r");
+	}
+	return NULL;
+}
+
 void zconf_initscan(const char *name)
 {
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("can't find file %s\n", name);
 		exit(1);
@@ -272,7 +295,7 @@
 	memset(buf, 0, sizeof(*buf));
 
 	current_buf->state = YY_CURRENT_BUFFER;
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
 		exit(1);
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/Makefile	Sat Nov 23 22:53:43 2002
@@ -77,12 +77,15 @@
 ifdef LKC_GENPARSER
 
 $(obj)/zconf.tab.c: $(obj)/zconf.y 
-$(obj)/zconf.tab.h: $(obj)/zconf.tab.c
+$(obj)/zconf.tab.h: $(obj)/zconf.y
 
 %.tab.c: %.y
 	bison -t -d -v -b $* -p $(notdir $*) $<
+	cp $@ $@_shipped
+	cp $(@:.c=.h) $(@:.c=.h)_shipped
 
 lex.%.c: %.l
 	flex -P$(notdir $*) -o$@ $<
+	cp $@ $@_shipped
 
 endif
diff -Nru a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
--- a/scripts/kconfig/confdata.c	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/confdata.c	Sat Nov 23 22:53:43 2002
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
 #define LKC_DIRECT_LINK
@@ -14,14 +15,16 @@
 
 const char conf_def_filename[] = ".config";
 
-const char conf_defname[] = "arch/$ARCH/defconfig";
+#define DEFNAME    4
+#define DEFALTNAME 5
 
 const char *conf_confnames[] = {
 	".config",
 	"/lib/modules/$UNAME_RELEASE/.config",
 	"/etc/kernel-config",
 	"/boot/config-$UNAME_RELEASE",
-	conf_defname,
+	"arch/$ARCH/defconfig",			/* index DEFNAME */
+	"$" SRCTREE "/arch/$ARCH/defconfig",	/* index DEFALTNAME */
 	NULL,
 };
 
@@ -53,7 +56,11 @@
 
 char *conf_get_default_confname(void)
 {
-	return conf_expand_value(conf_defname);
+	struct stat buf;
+	char * name = conf_expand_value(conf_confnames[DEFNAME]);
+	if (!stat(name, &buf))
+		return name;
+	return conf_expand_value(conf_confnames[DEFALTNAME]);
 }
 
 int conf_read(const char *name)
diff -Nru a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
--- a/scripts/kconfig/expr.h	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/expr.h	Sat Nov 23 22:53:43 2002
@@ -127,6 +127,8 @@
 #define SYMBOL_HASHSIZE		257
 #define SYMBOL_HASHMASK		0xff
 
+#define SRCTREE "srctree"
+
 enum prop_type {
 	P_UNKNOWN, P_PROMPT, P_COMMENT, P_MENU, P_ROOTMENU, P_DEFAULT, P_CHOICE
 };

