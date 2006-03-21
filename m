Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWCUQgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWCUQgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCUQfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:55 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932418AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 09/46] kbuild: run depmod when installing external modules
In-Reply-To: <11429580552387-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580552392-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch enables depmod support when installing external modules.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

a67dc21a38055ec2d8d85b2f64d98091748569b3
diff --git a/Makefile b/Makefile
index fdb3dac..c55d0f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1147,9 +1147,28 @@ modules: $(module-dirs)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 .PHONY: modules_install
-modules_install:
+modules_install: _emodinst_ _emodinst_post
+	
+install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
+.PHONY: _emodinst_
+_emodinst_:
+	$(Q)rm -rf $(MODLIB)/$(install-dir)
+	$(Q)mkdir -p $(MODLIB)/$(install-dir)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
+# Run depmod only is we have System.map and depmod is executable
+quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
+      cmd_depmod = if [ -r System.map -a -x $(DEPMOD) ]; then \
+                      $(DEPMOD) -ae -F System.map             \
+                      $(if $(strip $(INSTALL_MOD_PATH)),      \
+		      -b $(INSTALL_MOD_PATH) -r)              \
+		      $(KERNELRELEASE);                       \
+                   fi
+
+.PHONY: _emodinst_post
+_emodinst_post: _emodinst_
+	$(call cmd,depmod)
+
 clean-dirs := $(addprefix _clean_,$(KBUILD_EXTMOD))
 
 .PHONY: $(clean-dirs) clean
-- 
1.0.GIT


