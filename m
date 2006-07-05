Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWGEJbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGEJbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGEJbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:31:07 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:23990 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932152AbWGEJbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:31:06 -0400
Date: Wed, 5 Jul 2006 11:30:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [KBUILD] optionally print cause of rebuild (#2)
Message-ID: <20060705093056.GA9906@mars.ravnborg.org>
References: <200607042157.k64LvlDd016859@sullivan.realtime.net> <200607050701.k6571Q4o018076@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607050701.k6571Q4o018076@sullivan.realtime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milton.

On Wed, Jul 05, 2006 at 02:01:26AM -0500, Milton Miller wrote:
> Al wanted to see why Kbuild wanted to build files, to help debug
> Makefiles or dependency chains.
> 
> Here is my second draft, with with whitespace handled by strip.  It
> also now considers cmd_$@ before the targets variable because its
> both what the rules do and because the toplevel doesn't use targets.
> It still always prints the non-existing $^ stuff that only
> if_changed_dep uses.
I like the idea and I have played around with it a bit before.
To keep noise level down the "why got it rebuild" info should be on same
line as the CC command and to trigger it increasing verbose level to 2
seems more natural.

Following patch does this.
The patch contains a few clean-ups to make the "why" part slimmer.

Comments?

	Sam


diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2180c88..4e5f0aa 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -113,30 +113,33 @@ # See Documentation/kbuild/makefiles.txt
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both arguments has same arguments. Result in empty string if equal
 # User may override this check using make KBUILD_NOCMDDEP=1
-arg-check = $(strip $(filter-out $(1), $(2)) $(filter-out $(2), $(1)) )
+arg-check = $(strip $(filter-out $(cmd_$(1)), $(cmd_$@)) \
+                    $(filter-out $(cmd_$@),   $(cmd_$(1))) )
 endif
 
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
 echo-cmd = $(if $($(quiet)cmd_$(1)), \
-	echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
+	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
 
 make-cmd = $(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1)))))
 
+# Any prerequisites that require target to be built - phony prereq's skipped
+get-prereq = $(filter-out $(PHONY),$?)
+
 # function to only execute the passed command if necessary
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
 #
-if_changed = $(if $(strip $(filter-out $(PHONY),$?)          \
-		$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
+if_changed = $(if $(strip $(get-prereq) $(arg-check) ), \
 	@set -e; \
 	$(echo-cmd) $(cmd_$(1)); \
 	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
 
 # execute the command and also postprocess generated .d dependencies
 # file
-if_changed_dep = $(if $(strip $(filter-out $(PHONY),$?)  \
+if_changed_dep = $(if $(strip $(get-prereq)              \
 		$(filter-out FORCE $(wildcard $^),$^)    \
-	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
+	$(arg-check) ), \
 	@set -e; \
 	$(echo-cmd) $(cmd_$(1)); \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
@@ -146,7 +149,41 @@ if_changed_dep = $(if $(strip $(filter-o
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
-if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)            \
-			$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
-			@set -e; \
+if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)        \
+			$(arg-check) ), @set -e; \
 			$(rule_$(1)))
+
+###
+# why - tell why a a target got build
+#       enabled by make V=2
+#       Output:
+#          (1) due to: command line change
+#          (2) due to: file1.h file2.h
+#          (3) due to: no .cmd file
+#          (4) due to: target not in $(targets)
+#          (5) due to: target missing
+# (1) The command line stored in the file named dir/.target.cmd
+#     differed from actual command line. This happens when compiler
+#     options changes
+# (2) Prerequisite is newer than target
+# (3) No dir/.target.cmd file (used to store command line)
+# (4) No dir/.target.cmd file and target not listed in $(targets)
+#     This is a good hint that there is a bug in the kbuild file
+# (5) No target, so we better build it
+ifeq ($(KBUILD_VERBOSE),2)
+why =                                                            \
+    $(if $(wildcard $@),                                         \
+        $(if $(strip $(get-prereq)),- due to: $(get-prereq),     \
+            $(if $(arg-check),                                   \
+	        $(if $(cmd_$@),- due to: command line change,    \
+		    $(if $(filter $@, $(targets)),               \
+		        - due to: no .cmd file,                  \
+			-due to: $(notdir $@) not in $$(targets) \
+                     )                                           \
+                 )                                               \
+	     )                                                   \
+	 ),                                                      \
+    - due to: target missing                                     \
+     )
+echo-why = $(call escsq, $(strip $(why)))
+endif
