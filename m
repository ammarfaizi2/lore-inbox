Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbSKXBtT>; Sat, 23 Nov 2002 20:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSKXBtT>; Sat, 23 Nov 2002 20:49:19 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:24839 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267121AbSKXBtR>; Sat, 23 Nov 2002 20:49:17 -0500
Date: Sun, 24 Nov 2002 02:56:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig: Locate files relative to $srctree
In-Reply-To: <20021123220747.GA10411@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211240250490.2113-100000@serv>
References: <20021123220747.GA10411@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Nov 2002, Sam Ravnborg wrote:

>  const char *conf_confnames[] = {
>  	".config",
>  	"/lib/modules/$UNAME_RELEASE/.config",
>  	"/etc/kernel-config",
>  	"/boot/config-$UNAME_RELEASE",
> -	conf_defname,
> +	"arch/$ARCH/defconfig",			/* index DEFNAME */
> +	"$" SRCTREE "/arch/$ARCH/defconfig",	/* index DEFALTNAME */
>  	NULL,
>  };

This is not good. At some point I maybe want to make these configurable.
I changed the patch to always use zconf_fopen(), which will try the 
alternative prefix for relative paths.
I couldn't test this very much as you forgot the kbuild script. :)
Anyway, below is an alternative version.

bye, Roman

Index: scripts/kconfig/confdata.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/scripts/kconfig/confdata.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 confdata.c
--- scripts/kconfig/confdata.c	11 Nov 2002 19:06:27 -0000	1.1.1.2
+++ scripts/kconfig/confdata.c	24 Nov 2002 00:31:28 -0000
@@ -3,6 +3,7 @@
  * Released under the terms of the GNU GPL v2.0.
  */
 
+#include <sys/stat.h>
 #include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -53,7 +54,18 @@ static char *conf_expand_value(const cha
 
 char *conf_get_default_confname(void)
 {
-	return conf_expand_value(conf_defname);
+	struct stat buf;
+	static char fullname[PATH_MAX+1];
+	char *env, *name;
+
+	name = conf_expand_value(conf_defname);
+	env = getenv(SRCTREE);
+	if (env) {
+		sprintf(fullname, "%s/%s", env, name);
+		if (!stat(fullname, &buf))
+			return fullname;
+	}
+	return name;
 }
 
 int conf_read(const char *name)
@@ -68,12 +80,12 @@ int conf_read(const char *name)
 	int i;
 
 	if (name) {
-		in = fopen(name, "r");
+		in = zconf_fopen(name);
 	} else {
 		const char **names = conf_confnames;
 		while ((name = *names++)) {
 			name = conf_expand_value(name);
-			in = fopen(name, "r");
+			in = zconf_fopen(name);
 			if (in) {
 				printf("#\n"
 				       "# using defaults found in %s\n"
Index: scripts/kconfig/lkc.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/scripts/kconfig/lkc.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 lkc.h
--- scripts/kconfig/lkc.h	31 Oct 2002 13:29:12 -0000	1.1.1.1
+++ scripts/kconfig/lkc.h	24 Nov 2002 00:31:28 -0000
@@ -21,12 +21,14 @@ extern "C" {
 #include "lkc_proto.h"
 #undef P
 
-void symbol_end(char *help);
+#define SRCTREE "srctree"
+
 int zconfparse(void);
 void zconfdump(FILE *out);
 
 extern int zconfdebug;
 void zconf_starthelp(void);
+FILE *zconf_fopen(const char *name);
 void zconf_initscan(const char *name);
 void zconf_nextfile(const char *name);
 int zconf_lineno(void);
Index: scripts/kconfig/zconf.l
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/scripts/kconfig/zconf.l,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 zconf.l
--- scripts/kconfig/zconf.l	11 Nov 2002 19:06:28 -0000	1.1.1.2
+++ scripts/kconfig/zconf.l	24 Nov 2002 00:31:28 -0000
@@ -7,6 +7,7 @@
  * Released under the terms of the GNU GPL v2.0.
  */
 
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -249,9 +251,34 @@ static void zconf_endhelp(void)
 	BEGIN(INITIAL); 
 }
 
+
+/* 
+ * Try to open specified file with following names:
+ * ./name
+ * $(srctree)/name
+ * The latter is used when srctree is separate from objtree
+ * when compiling the kernel.
+ * Return NULL if file is not found.
+ */
+FILE *zconf_fopen(const char *name)
+{
+	char *env, fullname[PATH_MAX+1];
+	FILE *f;
+
+	f = fopen(name, "r");
+	if (!f && name[0] != '/') {
+		env = getenv(SRCTREE);
+		if (env) {
+			sprintf(fullname, "%s/%s", env, name);
+			f = fopen(fullname, "r");
+		}
+	}
+	return f;
+}
+
 void zconf_initscan(const char *name)
 {
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("can't find file %s\n", name);
 		exit(1);
@@ -272,7 +299,7 @@ void zconf_nextfile(const char *name)
 	memset(buf, 0, sizeof(*buf));
 
 	current_buf->state = YY_CURRENT_BUFFER;
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
 		exit(1);

