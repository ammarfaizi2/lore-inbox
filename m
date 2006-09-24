Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWIXVOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWIXVOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWIXVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:23 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:16348 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932124AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 12/28] kbuild: make V=2 tell why a target is rebuild
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:08 +0200
Message-Id: <11591327051998-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327054119-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

tell why a a target got build
   enabled by make V=2
      Output (listed in the order they are checked):
         (1) - due to target is PHONY
         (2) - due to target missing
         (3) - due to: file1.h file2.h
         (4) - due to command line change
         (5) - due to missing .cmd file
         (6) - due to target not in $(targets)
(1) We always build PHONY targets
(2) No target, so we better build it
(3) Prerequisite is newer than target
(4) The command line stored in the file named dir/.target.cmd
    differed from actual command line. This happens when compiler
    options changes
(5) No dir/.target.cmd file (used to store command line)
(6) No dir/.target.cmd file and target not listed in $(targets)
    This is a good hint that there is a bug in the kbuild file

This patch is inspired by a patch from: Milton Miller <miltonm@bga.com>

Cc: Milton Miller <miltonm@bga.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile               |    1 +
 scripts/Kbuild.include |   41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 22451c2..440a133 100644
--- a/Makefile
+++ b/Makefile
@@ -1101,6 +1101,7 @@ help:
 		echo '')
 
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo  '  make V=2   [targets] 2 => give reason for rebuild of target'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
 	@echo  '  make C=1   [targets] Check all c source with $$CHECK (sparse by default)'
 	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1d6ffb2..3d52389 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -129,7 +129,7 @@ endif
 
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
-	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
+	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
 
 # >'< substitution is for echo to work,
 # >$< substitution to preserve $ when reloading .cmd file
@@ -164,3 +164,42 @@ if_changed_rule = $(if $(strip $(any-pre
 	@set -e;                                                             \
 	$(rule_$(1)))
 
+###
+# why - tell why a a target got build
+#       enabled by make V=2
+#       Output (listed in the order they are checked):
+#          (1) - due to target is PHONY
+#          (2) - due to target missing
+#          (3) - due to: file1.h file2.h
+#          (4) - due to command line change
+#          (5) - due to missing .cmd file
+#          (6) - due to target not in $(targets)
+# (1) PHONY targets are always build
+# (2) No target, so we better build it
+# (3) Prerequisite is newer than target
+# (4) The command line stored in the file named dir/.target.cmd
+#     differed from actual command line. This happens when compiler
+#     options changes
+# (5) No dir/.target.cmd file (used to store command line)
+# (6) No dir/.target.cmd file and target not listed in $(targets)
+#     This is a good hint that there is a bug in the kbuild file
+ifeq ($(KBUILD_VERBOSE),2)
+why =                                                                        \
+    $(if $(filter $@, $(PHONY)),- due to target is PHONY,                    \
+        $(if $(wildcard $@),                                                 \
+            $(if $(strip $(any-prereq)),- due to: $(any-prereq),             \
+                $(if $(arg-check),                                           \
+                    $(if $(cmd_$@),- due to command line change,             \
+                        $(if $(filter $@, $(targets)),                       \
+                            - due to missing .cmd file,                      \
+                            - due to $(notdir $@) not in $$(targets)         \
+                         )                                                   \
+                     )                                                       \
+                 )                                                           \
+             ),                                                              \
+             - due to target missing                                         \
+         )                                                                   \
+     )
+
+echo-why = $(call escsq, $(strip $(why)))
+endif
-- 
1.4.1

