Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUIPOUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUIPOUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUIPOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:20:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:37865 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268088AbUIPOTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:19:54 -0400
Subject: [FIX] Replace hard-coded MODVERDIR in modpost
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-/RA3aXVJqjbkjUCmIyOg"
Organization: SUSE Labs
Message-Id: <1095344125.5552.28.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 16:15:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/RA3aXVJqjbkjUCmIyOg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

when building external modules, MODVERDIR is relative to the
external module instead of in the kernel source tree. Use the
MODVERDIR environment variable instead of the hard-coded path
in modpost.


Index: linux-2.6.8/scripts/mod/sumversion.c
===================================================================
--- linux-2.6.8.orig/scripts/mod/sumversion.c
+++ linux-2.6.8/scripts/mod/sumversion.c
@@ -416,7 +416,8 @@ static int get_version(const char *modna
 	struct md4_ctx md;
 	char *sources, *end, *fname;
 	const char *basename;
-	char filelist[sizeof(".tmp_versions/%s.mod") + strlen(modname)];
+	char filelist[strlen(getenv("MODVERDIR")) + strlen("/") +
+		      strlen(modname) - strlen(".o") + strlen(".mod") + 1 ];
 
 	/* Source files for module are in .tmp_versions/modname.mod,
 	   after the first line. */
@@ -424,9 +425,8 @@ static int get_version(const char *modna
 		basename = strrchr(modname, '/') + 1;
 	else
 		basename = modname;
-	sprintf(filelist, ".tmp_versions/%s", basename);
-	/* Truncate .o, add .mod */
-	strcpy(filelist + strlen(filelist)-2, ".mod");
+	sprintf(filelist, "%s/%.*s.mod", getenv("MODVERDIR"),
+		(int) strlen(basename) - 2, basename);
 
 	file = grab_file(filelist, &len);
 	if (!file) {


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


--=-/RA3aXVJqjbkjUCmIyOg
Content-Disposition: attachment; filename=sumversion.diff
Content-Type: text/x-patch; name=sumversion.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Date: Thu, 16 Sep 2004 16:08:38 +0200
From: Andreas Gruenbacher <agruen@suse.de>
Subject: Fix .tmp_versions for external modules

When building external modules, MODVERDIR is relative to the
external module instead of in the kernel source tree. Use the
MODVERDIR environment variable instead of the hard-coded path
in modpost.

Index: linux-2.6.8/scripts/mod/sumversion.c
===================================================================
--- linux-2.6.8.orig/scripts/mod/sumversion.c
+++ linux-2.6.8/scripts/mod/sumversion.c
@@ -416,7 +416,8 @@ static int get_version(const char *modna
 	struct md4_ctx md;
 	char *sources, *end, *fname;
 	const char *basename;
-	char filelist[sizeof(".tmp_versions/%s.mod") + strlen(modname)];
+	char filelist[strlen(getenv("MODVERDIR")) + strlen("/") +
+		      strlen(modname) - strlen(".o") + strlen(".mod") + 1 ];
 
 	/* Source files for module are in .tmp_versions/modname.mod,
 	   after the first line. */
@@ -424,9 +425,8 @@ static int get_version(const char *modna
 		basename = strrchr(modname, '/') + 1;
 	else
 		basename = modname;
-	sprintf(filelist, ".tmp_versions/%s", basename);
-	/* Truncate .o, add .mod */
-	strcpy(filelist + strlen(filelist)-2, ".mod");
+	sprintf(filelist, "%s/%.*s.mod", getenv("MODVERDIR"),
+		(int) strlen(basename) - 2, basename);
 
 	file = grab_file(filelist, &len);
 	if (!file) {

--=-/RA3aXVJqjbkjUCmIyOg--

