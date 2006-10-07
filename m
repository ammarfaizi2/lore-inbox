Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWJGLfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWJGLfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWJGLfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:35:34 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:13493 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750935AbWJGLfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:35:33 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Distinguish between errors and warnings in modpost
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Sat, 07 Oct 2006 05:35:32 -0600
Message-Id: <11602209321133-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of modpost's warnings are fatal, and some are not.  Adopt the
compiler distinction between errors and warnings by calling error()
for fatal diagnostics and warn() for non-fatal ones.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4127796..5530294 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -55,6 +55,17 @@ void warn(const char *fmt, ...)
 	va_end(arglist);
 }
 
+void error(const char *fmt, ...)
+{
+	va_list arglist;
+
+	fprintf(stderr, "ERROR: ");
+
+	va_start(arglist, fmt);
+	vfprintf(stderr, fmt, arglist);
+	va_end(arglist);
+}
+
 static int is_vmlinux(const char *modname)
 {
 	const char *myname;
@@ -1207,9 +1218,14 @@ static int add_versions(struct buffer *b
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
 			if (have_vmlinux && !s->weak) {
-				warn("\"%s\" [%s.ko] undefined!\n",
-				     s->name, mod->name);
-				err = warn_unresolved ? 0 : 1;
+				if (warn_unresolved) {
+					warn("\"%s\" [%s.ko] undefined!\n",
+					     s->name, mod->name);
+				} else {
+					error("\"%s\" [%s.ko] undefined!\n",
+					      s->name, mod->name);
+					err = 1;
+				}
 			}
 			continue;
 		}
