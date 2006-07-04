Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWGDV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWGDV5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGDV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:57:52 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:18444 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S932301AbWGDV5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:57:51 -0400
Date: Tue, 4 Jul 2006 16:57:47 -0500 (CDT)
Message-Id: <200607042157.k64LvlDd016859@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al wanted to see why Kbuild wanted to build files, to help debug
Makefiles or dependency chains.

Here is a first draft.   It always does if_changed_dep $^ processing,
and it has a few whitepace issues, but the paths other than not in
targets passes a basic test.

export KBUILLD_PRINTDEPS=1 and you wil get lines beginning with DEPS:

Signed-off-by: Milton Miller <miltonm@bga.com>

--- linux-2.6.17/scripts/Kbuild.include.orig	2006-07-04 16:02:55.000000000 -0400
+++ linux-2.6.17/scripts/Kbuild.include	2006-07-04 17:40:31.000000000 -0400
@@ -112,6 +112,18 @@ ifneq ($(KBUILD_NOCMDDEP),1)
 arg-check = $(strip $(filter-out $(1), $(2)) $(filter-out $(2), $(1)) )
 endif
 
+ifeq ($(KBUILD_PRINTDEPS),1)
+deps-cmd = $(if 1,echo 'DEPS: $@ built because' 			\
+	'$(call escsq,$(if $(wildcard $@),				\
+		$(if $(filter $@, $(targets)),				\
+			$(if $(call arg-check, $(cmd_$(1)), $(cmd_$@)),	\
+				command $(if $(cmd_$@),changed,was missing) \
+				,of $(sort $(filter-out $(PHONY),$?) 	\
+				$(filter-out FORCE $(wildcard $^),$^)))	\
+		,it was not a target)					\
+	,it was missing))';)
+endif
+
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
@@ -125,7 +137,7 @@ make-cmd = $(subst \#,\\\#,$(subst $$,$$
 if_changed = $(if $(strip $(filter-out $(PHONY),$?)          \
 		$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
+	$(deps-cmd) $(echo-cmd) $(cmd_$(1)); \
 	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
 
 # execute the command and also postprocess generated .d dependencies
@@ -134,7 +146,7 @@ if_changed_dep = $(if $(strip $(filter-o
 		$(filter-out FORCE $(wildcard $^),$^)    \
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
 	@set -e; \
-	$(echo-cmd) $(cmd_$(1)); \
+	$(deps-cmd) $(echo-cmd) $(cmd_$(1)); \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
@@ -145,4 +157,4 @@ if_changed_dep = $(if $(strip $(filter-o
 if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)            \
 			$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
 			@set -e; \
-			$(rule_$(1)))
+			$(deps-cmd) $(rule_$(1)))
