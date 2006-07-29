Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWG2HUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWG2HUg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWG2HUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:20:03 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:53171 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422687AbWG2HTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:55 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: consistently decide when to rebuild a target
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:41 +0200
Message-Id: <11541575823471-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575811222-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org> <1154157581409-git-send-email-sam@ravnborg.org> <11541575813138-git-send-email-sam@ravnborg.org> <11541575811787-git-send-email-sam@ravnborg.org> <11541575811046-git-send-email-sam@ravnborg.org> <11541575811222-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Consistently decide when to rebuild a target across all of
if_changed, if_changed_dep, if_changed_rule.
PHONY targets are now treated alike (ignored) for all targets

While add it make Kbuild.include almost readable by factoring out a few
bits to some common variables and reuse this in Makefile.build.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Kbuild.include |   52 ++++++++++++++++++++++++++++--------------------
 scripts/Makefile.build |    5 +++--
 usr/Makefile           |    2 ++
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2180c88..7a18353 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -8,9 +8,13 @@ empty   :=
 space   := $(empty) $(empty)
 
 ###
+# Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
+dot-target = $(dir $@).$(notdir $@)
+
+###
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
-depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
+depfile = $(subst $(comma),_,$(dot-target).d)
 
 ###
 # filename of target with directory and extension stripped
@@ -113,40 +117,44 @@ # See Documentation/kbuild/makefiles.txt
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both arguments has same arguments. Result in empty string if equal
 # User may override this check using make KBUILD_NOCMDDEP=1
-arg-check = $(strip $(filter-out $(1), $(2)) $(filter-out $(2), $(1)) )
+arg-check = $(strip $(filter-out $(cmd_$(1)), $(cmd_$@)) \
+                    $(filter-out $(cmd_$@),   $(cmd_$(1))) )
 endif
 
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
 
+# >'< substitution is for echo to work,
+# >$< substitution to preserve $ when reloading .cmd file
+# note: when using inline perl scripts [perl -e '...$$t=1;...']
+# in $(cmd_xxx) double $$ your perl vars
 make-cmd = $(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1)))))
 
-# function to only execute the passed command if necessary
-# >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
-# note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
+# Find any prerequisites that is newer than target or that does not exist.
+# PHONY targets skipped in both cases.
+any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
+
+# Execute command if command has changed or prerequisitei(s) are updated
 #
-if_changed = $(if $(strip $(filter-out $(PHONY),$?)          \
-		$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
-	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
-	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
+if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
+	@set -e;                                                             \
+	$(echo-cmd) $(cmd_$(1));                                             \
+	echo 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd)
 
 # execute the command and also postprocess generated .d dependencies
 # file
-if_changed_dep = $(if $(strip $(filter-out $(PHONY),$?)  \
-		$(filter-out FORCE $(wildcard $^),$^)    \
-	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
-	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
-	rm -f $(depfile); \
-	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
+if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
+	@set -e;                                                             \
+	$(echo-cmd) $(cmd_$(1));                                             \
+	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
+	rm -f $(depfile);                                                    \
+	mv -f $(dot-target).tmp $(dot-target).cmd)
 
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
-if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)            \
-			$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
-			@set -e; \
-			$(rule_$(1)))
+if_changed_rule = $(if $(strip $(any-prereq) $(arg-check) ),                 \
+	@set -e;                                                             \
+	$(rule_$(1)))
+
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3cb445c..e2ad2dc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -191,9 +191,10 @@ define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
 	$(call echo-cmd,cc_o_c) $(cmd_cc_o_c);				  \
 	$(cmd_modversions)						  \
-	scripts/basic/fixdep $(depfile) $@ '$(call make-cmd,cc_o_c)' > $(@D)/.$(@F).tmp;  \
+	scripts/basic/fixdep $(depfile) $@ '$(call make-cmd,cc_o_c)' >    \
+	                                              $(dot-target).tmp;  \
 	rm -f $(depfile);						  \
-	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
+	mv -f $(dot-target).tmp $(dot-target).cmd
 endef
 
 # Built-in and composite module parts
diff --git a/usr/Makefile b/usr/Makefile
index e938242..2c8f362 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -3,6 +3,8 @@ # kbuild file for usr/ - including initr
 #
 
 klibcdirs:;
+PHONY += klibcdirs
+
 
 # Generate builtin.o based on initramfs_data.o
 obj-y := initramfs_data.o
-- 
1.4.1.rc2.gfc04

