Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTLQV4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbTLQV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:56:30 -0500
Received: from 64.221.211.203.ptr.us.xo.net ([64.221.211.203]:36502 "EHLO
	mail.pathscale.com") by vger.kernel.org with ESMTP id S264575AbTLQV42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:56:28 -0500
Subject: [PATCH] Get modpost to work properly with vmlinux in a different
	directory
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071698186.10795.56.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 13:56:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pretty trivial.  The current version of modpost breaks if
invoked from outside the build tree.  This patch fixes that, and
simplifies the code a bit while it's at it.

Since it's not critical, I'd call it a contender for -mm and 2.6.1.

	<b


 scripts/modpost.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1509  -> 1.1510 
#	   scripts/modpost.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/17	bos@serpentine.pathscale.com	1.1510
# Make detection of whether a module is really vmlinux work regardless of its location.
# --------------------------------------------
#
diff -Nru a/scripts/modpost.c b/scripts/modpost.c
--- a/scripts/modpost.c	Wed Dec 17 13:51:25 2003
+++ b/scripts/modpost.c	Wed Dec 17 13:51:25 2003
@@ -324,6 +324,19 @@
 	}
 }
 
+int
+is_vmlinux(const char *modname)
+{
+	const char *myname;
+	
+	if ((myname = strrchr(modname, '/')))
+		myname++;
+	else
+		myname = modname;
+
+	return strcmp(myname, "vmlinux") == 0;
+}
+
 void
 read_symbols(char *modname)
 {
@@ -335,8 +348,7 @@
 
 	/* When there's no vmlinux, don't print warnings about
 	 * unresolved symbols (since there'll be too many ;) */
-	if (strcmp(modname, "vmlinux") == 0)
-		have_vmlinux = 1;
+	have_vmlinux = is_vmlinux(modname);
 
 	parse_elf(&info, modname);
 
@@ -460,10 +472,7 @@
 	int first = 1;
 
 	for (m = modules; m; m = m->next) {
-		if (strcmp(m->name, "vmlinux") == 0)
-			m->seen = 1;
-		else 
-			m->seen = 0;
+		m->seen = is_vmlinux(m->name);
 	}
 
 	buf_printf(b, "\n");
@@ -543,7 +552,7 @@
 	}
 
 	for (mod = modules; mod; mod = mod->next) {
-		if (strcmp(mod->name, "vmlinux") == 0)
+		if (is_vmlinux(mod->name))
 			continue;
 
 		buf.pos = 0;


