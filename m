Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWCUQZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWCUQZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWCUQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932431AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 17/46] kbuild: do not segfault in modpost if MODVERDIR is not defined
In-Reply-To: <11429580552866-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580552016-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A combination of calling modpost with option -a and MODVERDIR undefined
caused segmentation fault. So provide a default value and accept the
error messages it generates instead.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/sumversion.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

41370d3b5ec6401c5cf0df82297ed989c03a64bd
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 5c07545..8a28756 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -381,8 +381,11 @@ void get_src_version(const char *modname
 	struct md4_ctx md;
 	char *sources, *end, *fname;
 	const char *basename;
-	char filelist[strlen(getenv("MODVERDIR")) + strlen("/") +
-		      strlen(modname) - strlen(".o") + strlen(".mod") + 1 ];
+	char filelist[PATH_MAX + 1];
+	char *modverdir = getenv("MODVERDIR");
+
+	if (!modverdir)
+		modverdir = ".";
 
 	/* Source files for module are in .tmp_versions/modname.mod,
 	   after the first line. */
@@ -390,7 +393,7 @@ void get_src_version(const char *modname
 		basename = strrchr(modname, '/') + 1;
 	else
 		basename = modname;
-	sprintf(filelist, "%s/%.*s.mod", getenv("MODVERDIR"),
+	sprintf(filelist, "%s/%.*s.mod", modverdir,
 		(int) strlen(basename) - 2, basename);
 
 	file = grab_file(filelist, &len);
-- 
1.0.GIT


