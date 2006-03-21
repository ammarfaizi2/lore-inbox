Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWCUQaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWCUQaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCUQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25612 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932407AbWCUQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:10 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 05/46] kbuild: warn about duplicate exported symbols
In-Reply-To: <11429580542480-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <1142958054501-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In modpost introduce a check for symbols exported twice.
This check caught only one victim (inet_bind_bucket_create) for
which a patch is already sent to netdev.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

8e70c45887a6bbe40393342ea5b426b0dd836dff
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 976adf1..d901095 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -117,6 +117,7 @@ struct symbol {
 	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
 	unsigned int kernel:1;     /* 1 if symbol is from kernel
 				    *  (only for external modules) **/
+	unsigned int preloaded:1;  /* 1 if symbol from Module.symvers */
 	char name[0];
 };
 
@@ -186,9 +187,17 @@ static struct symbol *sym_add_exported(c
 {
 	struct symbol *s = find_symbol(name);
 
-	if (!s)
+	if (!s) {
 		s = new_symbol(name, mod);
-
+	} else {
+		if (!s->preloaded) {
+			warn("%s: duplicate symbol '%s' previous definition "
+			     "was in %s%s\n", mod->name, name,
+			     s->module->name,
+			     is_vmlinux(s->module->name) ?"":".ko");
+		}
+	}
+	s->preloaded = 0;
 	s->vmlinux   = is_vmlinux(mod->name);
 	s->kernel    = 0;
 	return s;
@@ -706,7 +715,8 @@ static void read_dump(const char *fname,
 			mod->skip = 1;
 		}
 		s = sym_add_exported(symname, mod);
-		s->kernel = kernel;
+		s->kernel    = kernel;
+		s->preloaded = 1;
 		sym_update_crc(symname, mod, crc);
 	}
 	return;
-- 
1.0.GIT


