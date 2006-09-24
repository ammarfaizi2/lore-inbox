Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWIXVOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWIXVOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWIXVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:21 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:2962 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932120AbWIXVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:09 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 11/28] kbuild: modpost on vmlinux regardless of CONFIG_MODULES
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:07 +0200
Message-Id: <11591327054119-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327051381-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Based on patch from: Magnus Damm <magnus@valinux.co.jp>
This has the advantage that all section mismatch checks are run regardless
of modules being enabled or not.

When running modpost on vmlinux output:
MODPOST vmlinux

When running modpost on modules output count of modules like this:
MODPOST 5 modules

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                 |    1 +
 scripts/Makefile         |    2 +-
 scripts/Makefile.modpost |   12 +++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b06b1ea..22451c2 100644
--- a/Makefile
+++ b/Makefile
@@ -736,6 +736,7 @@ endif # ifdef CONFIG_KALLSYMS
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost $@
 	$(Q)rm -f .old_version
 
 # The actual objects are generated when descending, 
diff --git a/scripts/Makefile b/scripts/Makefile
index d531a1f..ea41de8 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -19,7 +19,7 @@ # The following hostprogs-y programs are
 hostprogs-y += unifdef
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
-subdir-$(CONFIG_MODULES)     += mod
+subdir-y                     += mod
 
 # Let clean descend into subdirs
 subdir-	+= basic kconfig package
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0a64688..9137df2 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -51,19 +51,25 @@ _modpost: $(modules)
 
 # Step 2), invoke modpost
 #  Includes step 3,4
-quiet_cmd_modpost = MODPOST
+quiet_cmd_modpost = MODPOST $(words $(filter-out vmlinux FORCE, $^)) modules
       cmd_modpost = scripts/mod/modpost            \
         $(if $(CONFIG_MODVERSIONS),-m)             \
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)  \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
 	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
-	$(filter-out FORCE,$^)
+	$(wildcard vmlinux) $(filter-out FORCE,$^)
 
 PHONY += __modpost
-__modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
+__modpost: $(modules:.ko=.o) FORCE
 	$(call cmd,modpost)
 
+quiet_cmd_kernel-mod = MODPOST $@
+      cmd_kernel-mod = $(cmd_modpost)
+
+vmlinux: FORCE
+	$(call cmd,kernel-mod)
+
 # Declare generated files as targets for modpost
 $(symverfile):         __modpost ;
 $(modules:.ko=.mod.c): __modpost ;
-- 
1.4.1

