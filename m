Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWGEHBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWGEHBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGEHBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:01:30 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:28932 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1751151AbWGEHB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:01:29 -0400
Date: Wed, 5 Jul 2006 02:01:26 -0500 (CDT)
Message-Id: <200607050701.k6571Q4o018076@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [KBUILD] optionally print cause of rebuild (#2)
References: <200607042157.k64LvlDd016859@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al wanted to see why Kbuild wanted to build files, to help debug
Makefiles or dependency chains.

Here is my second draft, with with whitespace handled by strip.  It
also now considers cmd_$@ before the targets variable because its
both what the rules do and because the toplevel doesn't use targets.
It still always prints the non-existing $^ stuff that only
if_changed_dep uses.

Set KBUILLD_PRINTDEPS=1 and you will get lines like
DEPS: building bar/foo.o because command changed
DEPS: building bar/foo.o because command was missing
DEPS: building bar/foo.o because it was not a target
DEPS: building bar/foo.o because it was missing
DEPS: building bar/foo.o because of bar/foo.c include/linux/baz.h

Signed-off-by: Milton Miller <miltonm@bga.com>

--- linux-2.6.17/scripts/Kbuild.include.orig	2006-07-04 16:02:55.000000000 -0400
+++ linux-2.6.17/scripts/Kbuild.include	2006-07-05 01:12:36.000000000 -0400
@@ -112,6 +112,19 @@ ifneq ($(KBUILD_NOCMDDEP),1)
 arg-check = $(strip $(filter-out $(1), $(2)) $(filter-out $(2), $(1)) )
 endif
 
+ifeq ($(KBUILD_PRINTDEPS),1)
+deps-cmd = $(if 1,echo 'DEPS: building $@ because' 			\
+	'$(call escsq,$(strip $(if $(wildcard $@),			\
+		$(if $(call arg-check, $(cmd_$(1)), $(cmd_$@)),		\
+			$(if $(cmd_$@),command changed			\
+				,$(if $(filter $@, $(targets)),		\
+					cmd was missing			\
+					,it was not a target))		\
+			,of $(sort $(filter-out $(PHONY),$?) 		\
+				$(filter-out FORCE $(wildcard $^),$^)))	\
+	,it was missing)))';)
+endif
+
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
@@ -125,7 +138,7 @@ make-cmd = $(subst \#,\\\#,$(subst $$,$$
 if_changed = $(if $(strip $(filter-out $(PHONY),$?)          \
 		$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
+	$(deps-cmd) $(echo-cmd) $(cmd_$(1)); \
 	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
 
 # execute the command and also postprocess generated .d dependencies
@@ -134,7 +147,7 @@ if_changed_dep = $(if $(strip $(filter-o
 		$(filter-out FORCE $(wildcard $^),$^)    \
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
 	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
+	$(deps-cmd) $(echo-cmd) $(cmd_$(1)); \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
@@ -145,4 +158,4 @@ if_changed_dep = $(if $(strip $(filter-o
 if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)            \
 			$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
 			@set -e; \
-			$(rule_$(1)))
+			$(deps-cmd) $(rule_$(1)))
