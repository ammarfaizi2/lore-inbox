Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVFVJHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVFVJHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVFVJEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:04:48 -0400
Received: from [85.8.12.41] ([85.8.12.41]:28600 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262871AbVFVJDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:03:34 -0400
Message-ID: <42B92946.3010207@drzeus.cx>
Date: Wed, 22 Jun 2005 11:03:02 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-23611-1119431013-0001-2"
To: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Fix signed char problem in scripts/kconfig
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-23611-1119431013-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

The signed characters in scripts are causing warnings with GCC 4 on
systems with proper string functions (with char*, not signed char* as
parameters). Some could be kept signed but most had to be reverted to
normal chars.

Detailed changelog:

mconf.c:
	- buf/bufptr was used in vsprintf() so it couldn't be signed.
confdata.c:
	- conf_expand_value() used strchr() and strncat() forcing
	  "normal" strings.
conf.c:
	- line was used with several string functions so it couldn't be
	  signed.
	- strip() uses strlen() so same thing there.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-23611-1119431013-0001-2
Content-Type: text/x-patch; name="signed-char-kconfig.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signed-char-kconfig.patch"

Index: linux-wbsd/scripts/kconfig/mconf.c
===================================================================
--- linux-wbsd/scripts/kconfig/mconf.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/mconf.c	(working copy)
@@ -254,8 +254,8 @@
 	"          USB$ => find all CONFIG_ symbols ending with USB\n"
 	"\n");
 
-static signed char buf[4096], *bufptr = buf;
-static signed char input_buf[4096];
+static char buf[4096], *bufptr = buf;
+static char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
 static char *args[1024], **argptr = args;
 static int indent;
Index: linux-wbsd/scripts/kconfig/confdata.c
===================================================================
--- linux-wbsd/scripts/kconfig/confdata.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/confdata.c	(working copy)
@@ -27,10 +27,10 @@
 	NULL,
 };
 
-static char *conf_expand_value(const signed char *in)
+static char *conf_expand_value(const char *in)
 {
 	struct symbol *sym;
-	const signed char *src;
+	const char *src;
 	static char res_value[SYMBOL_MAXLENGTH];
 	char *dst, name[SYMBOL_MAXLENGTH];
 
Index: linux-wbsd/scripts/kconfig/conf.c
===================================================================
--- linux-wbsd/scripts/kconfig/conf.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/conf.c	(working copy)
@@ -31,14 +31,14 @@
 static int indent = 1;
 static int valid_stdin = 1;
 static int conf_cnt;
-static signed char line[128];
+static char line[128];
 static struct menu *rootEntry;
 
 static char nohelp_text[] = N_("Sorry, no help available for this option yet.\n");
 
-static void strip(signed char *str)
+static void strip(char *str)
 {
-	signed char *p = str;
+	char *p = str;
 	int l;
 
 	while ((isspace(*p)))

--=_hermes.drzeus.cx-23611-1119431013-0001-2--
