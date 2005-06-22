Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVFVRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVFVRvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFVRtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:49:03 -0400
Received: from [85.8.12.41] ([85.8.12.41]:36024 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261587AbVFVRqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:46:36 -0400
Message-ID: <42B9A3F8.80302@drzeus.cx>
Date: Wed, 22 Jun 2005 19:46:32 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-25579-1119462393-0001-2"
To: Roman Zippel <zippel@linux-m68k.org>
CC: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Fix signed char problem in scripts/basic
References: <42B92923.6080100@drzeus.cx> <Pine.LNX.4.61.0506221640290.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506221640290.3728@scrub.home>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-25579-1119462393-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

The signed characters in scripts are causing warnings with GCC 4 on systems with proper string functions (with char*, not signed char* as parameters). All signed strings were removed because they were all directly or indirectly used in string functions.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>


--=_hermes.drzeus.cx-25579-1119462393-0001-2
Content-Type: text/x-patch; name="signed-char-basic.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signed-char-basic.patch"

Index: linux-wbsd/scripts/basic/fixdep.c
===================================================================
--- linux-wbsd/scripts/basic/fixdep.c	(revision 134)
+++ linux-wbsd/scripts/basic/fixdep.c	(working copy)
@@ -217,18 +217,18 @@
 	printf("    $(wildcard include/config/%s.h) \\\n", s);
 }
 
-void parse_config_file(signed char *map, size_t len)
+void parse_config_file(char *map, size_t len)
 {
 	int *end = (int *) (map + len);
 	/* start at +1, so that p can never be < map */
 	int *m   = (int *) map + 1;
-	signed char *p, *q;
+	char *p, *q;
 
 	for (; m < end; m++) {
-		if (*m == INT_CONF) { p = (signed char *) m  ; goto conf; }
-		if (*m == INT_ONFI) { p = (signed char *) m-1; goto conf; }
-		if (*m == INT_NFIG) { p = (signed char *) m-2; goto conf; }
-		if (*m == INT_FIG_) { p = (signed char *) m-3; goto conf; }
+		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
+		if (*m == INT_ONFI) { p = (char *) m-1; goto conf; }
+		if (*m == INT_NFIG) { p = (char *) m-2; goto conf; }
+		if (*m == INT_FIG_) { p = (char *) m-3; goto conf; }
 		continue;
 	conf:
 		if (p > map + len - 7)
@@ -291,9 +291,9 @@
 
 void parse_dep_file(void *map, size_t len)
 {
-	signed char *m = map;
-	signed char *end = m + len;
-	signed char *p;
+	char *m = map;
+	char *end = m + len;
+	char *p;
 	char s[PATH_MAX];
 
 	p = strchr(m, ':');
Index: linux-wbsd/scripts/basic/docproc.c
===================================================================
--- linux-wbsd/scripts/basic/docproc.c	(revision 134)
+++ linux-wbsd/scripts/basic/docproc.c	(working copy)
@@ -52,7 +52,7 @@
 FILEONLY *externalfunctions;
 FILEONLY *symbolsonly;
 
-typedef void FILELINE(char * file, signed char * line);
+typedef void FILELINE(char * file, char * line);
 FILELINE * singlefunctions;
 FILELINE * entity_system;
 
@@ -148,9 +148,9 @@
  * Files are separated by tabs.
  */
 void adddep(char * file)		   { printf("\t%s", file); }
-void adddep2(char * file, signed char * line)     { line = line; adddep(file); }
+void adddep2(char * file, char * line)     { line = line; adddep(file); }
 void noaction(char * line)		   { line = line; }
-void noaction2(char * file, signed char * line)   { file = file; line = line; }
+void noaction2(char * file, char * line)   { file = file; line = line; }
 
 /* Echo the line without further action */
 void printline(char * line)               { printf("%s", line); }
@@ -179,8 +179,8 @@
 			perror(real_filename);
 		}
 		while(fgets(line, MAXLINESZ, fp)) {
-			signed char *p;
-			signed char *e;
+			char *p;
+			char *e;
 			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
                             ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
 				/* Skip EXPORT_SYMBOL{_GPL} */
@@ -253,7 +253,7 @@
  * Call kernel-doc with the following parameters:
  * kernel-doc -docbook -function function1 [-function function2]
  */
-void singfunc(char * filename, signed char * line)
+void singfunc(char * filename, char * line)
 {
 	char *vec[200]; /* Enough for specific functions */
         int i, idx = 0;
@@ -290,7 +290,7 @@
 void parse_file(FILE *infile)
 {
 	char line[MAXLINESZ];
-	signed char * s;
+	char * s;
 	while(fgets(line, MAXLINESZ, infile)) {
 		if (line[0] == '!') {
 			s = line + 2;
Index: linux-wbsd/scripts/basic/split-include.c
===================================================================
--- linux-wbsd/scripts/basic/split-include.c	(revision 134)
+++ linux-wbsd/scripts/basic/split-include.c	(working copy)
@@ -104,7 +104,7 @@
     /* Read config lines. */
     while (fgets(line, buffer_size, fp_config))
     {
-	const signed char * str_config;
+	const char * str_config;
 	int is_same;
 	int itarget;
 

--=_hermes.drzeus.cx-25579-1119462393-0001-2--
