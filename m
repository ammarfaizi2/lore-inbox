Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWIXVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIXVOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIXVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:25 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:17116 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932128AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Subject: [PATCH 10/28] kbuild: ignore references from ".pci_fixup" to ".init.text"
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:06 +0200
Message-Id: <11591327051381-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327053770-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <magnus@valinux.co.jp>

The modpost code is extended to ignore references
from ".pci_fixup" to ".init.text".

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---
 scripts/mod/modpost.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dfde0e8..5028d46 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -581,8 +581,8 @@ static int strrcmp(const char *s, const 
  *   fromsec = .data
  *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
-static int secref_whitelist(const char *tosec, const char *fromsec,
-			    const char *atsym)
+static int secref_whitelist(const char *modname, const char *tosec,
+			    const char *fromsec, const char *atsym)
 {
 	int f1 = 1, f2 = 1;
 	const char **s;
@@ -618,8 +618,15 @@ static int secref_whitelist(const char *
 	for (s = pat2sym; *s; s++)
 		if (strrcmp(atsym, *s) == 0)
 			f1 = 1;
+	if (f1 && f2)
+		return 1;
 
-	return f1 && f2;
+	/* Whitelist all references from .pci_fixup section if vmlinux */
+	if (is_vmlinux(modname)) {
+		if ((strcmp(fromsec, ".pci_fixup") == 0) &&
+		    (strcmp(tosec, ".init.text") == 0))
+		return 1;
+	}
 }
 
 /**
@@ -726,7 +733,8 @@ static void warn_sec_mismatch(const char
 
 	/* check whitelist - we may ignore it */
 	if (before &&
-	    secref_whitelist(secname, fromsec, elf->strtab + before->st_name))
+	    secref_whitelist(modname, secname, fromsec,
+			     elf->strtab + before->st_name))
 		return;
 
 	if (before && after) {
-- 
1.4.1

