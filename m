Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVFUXMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVFUXMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFUXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:05:05 -0400
Received: from smtp05.auna.com ([62.81.186.15]:16299 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262443AbVFUW7l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:59:41 -0400
Date: Tue, 21 Jun 2005 22:59:40 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] more signed char cleanups in scripts
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<1119391748l.25237l.3l@werewolf.able.es>
	<20050621151806.07ef0f78.akpm@osdl.org>
In-Reply-To: <20050621151806.07ef0f78.akpm@osdl.org> (from akpm@osdl.org on
	Wed Jun 22 00:18:06 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119394780l.25237l.4l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Wed, 22 Jun 2005 00:59:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.22, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > This cleans the last signedness problems I have seen in scripts, at least
> >  what I can see with make oldconfig, make config, make menuconfig, 
> >  make gconfig and make.
> 
> Remind me: what's the point in these changes?
> 
> I see no particular problem using uchar in the kallsyms code - I often
> prefer it, because you can just look at the code and not have to worry
> about nasty sign-extension problems.
> 

Forget the part for kallsyms. After my change, it just coredumps.
The original gcc warnings are below. The problem is using str---
on data that are not strictly strings, but arrays of bytes...
Each symbol struct has a field. 'sym', that stores a 'type'
in sym[0] and a name from sym[1] to the end. A strange hacky mix.

At the end there is one another patch, this time at least kallsyms
works. Dump my previous try and get this. If you don't like the casts,
some strcmp's could be changed to memcmp (a,"b", sizeof("b"));

werewolf:/usr/src/linux# rm -f scripts/kallsyms; make scripts/kallsyms
  HOSTCC  scripts/kallsyms
scripts/kallsyms.c: In function 'read_symbol':
scripts/kallsyms.c:163: warning: pointer targets in assignment differ in signedness
scripts/kallsyms.c:164: warning: pointer targets in passing argument 1 of 'strcpy' differ in signedness
scripts/kallsyms.c: In function 'symbol_valid':
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:210: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:211: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:212: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:217: warning: pointer targets in passing argument 1 of 'strstr' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
scripts/kallsyms.c:221: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness

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
 
--- linux-2.6.12-jam1/scripts/conmakehash.c.orig	2005-06-22 00:16:58.000000000 +0200
+++ linux-2.6.12-jam1/scripts/conmakehash.c	2005-06-22 00:17:21.000000000 +0200
@@ -33,7 +33,7 @@
 
 int getunicode(char **p0)
 {
-  unsigned char *p = *p0;
+  char *p = *p0;
 
   while (*p == ' ' || *p == '\t')
     p++;
--- linux-2.6.12-jam1/scripts/kallsyms.c.orig	2005-06-22 00:29:29.000000000 +0200
+++ linux-2.6.12-jam1/scripts/kallsyms.c	2005-06-22 00:47:56.000000000 +0200
@@ -160,8 +160,8 @@
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
 	s->len = strlen(str) + 1;
-	s->sym = (char *) malloc(s->len + 1);
-	strcpy(s->sym + 1, str);
+	s->sym = malloc(s->len + 1);
+	memcpy(s->sym + 1, str, s->len);
 	s->sym[0] = s->type;
 
 	return 0;
@@ -207,18 +207,18 @@
 		 * move then they may get dropped in pass 2, which breaks the
 		 * kallsyms rules.
 		 */
-		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
-		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")) ||
-		    (s->addr == _eextratext && strcmp(s->sym + offset, "_eextratext")))
+		if ((s->addr == _etext && strcmp((char*)s->sym + offset, "_etext")) ||
+		    (s->addr == _einittext && strcmp((char*)s->sym + offset, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp((char*)s->sym + offset, "_eextratext")))
 			return 0;
 	}
 
 	/* Exclude symbols which vary between passes. */
-	if (strstr(s->sym + offset, "_compiled."))
+	if (strstr((char*)s->sym + offset, "_compiled."))
 		return 0;
 
 	for (i = 0; special_symbols[i]; i++)
-		if( strcmp(s->sym + offset, special_symbols[i]) == 0 )
+		if( strcmp((char*)s->sym + offset, special_symbols[i]) == 0 )
 			return 0;
 
 	return 1;

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


