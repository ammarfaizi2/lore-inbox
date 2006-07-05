Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWGEPMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWGEPMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWGEPMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:12:21 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:37578 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964905AbWGEPMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:12:20 -0400
Date: Wed, 5 Jul 2006 17:12:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KBUILD] allow any PHONY in if_changed_dep
Message-ID: <20060705151210.GB401@mars.ravnborg.org>
References: <200607051502.k65F28bO019554@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607051502.k65F28bO019554@sullivan.realtime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 10:02:08AM -0500, Milton Miller wrote:
> While all the if_changed family filter $(PHONY) from the list of newer
> files, if_changed_dep was only filtering FORCE from the list of all
> dependents.  This resulted in forced recompile every time.

I have just committed following change to kbuild.git.
It should address your input while making parts of Kbuild.include almost
readable too.


Working on the "why did we build this target path" at the moment.
Will have it finished tonight I hope.

Thanks for your kbuild work!
Even if I do not apply them verbatim it triggers me to do some long needed
improvements.

	Sam

commit f9361616df9f8fc80a5bbe8c0a67cf964a10cbf8
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Wed Jul 5 16:46:02 2006 +0200

    kbuild: clean up scripts/Kbuild.include
    
    Makes part of Kbuild.include remotely readable by
    refactoring some functionality to independent variables.
    The different if_xxx are now consistent in their way of determining
    if a target needs to be rebuild.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2180c88..e36f916 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -8,9 +8,13 @@ empty   :=
 space   := $(empty) $(empty)
 
 ###
+# Name of target with a '.' added in front. foo/bar.o => foo/.bar.o
+dot-target = $(dir $@).$(notdir $@)
+
+###
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
-depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
+depfile = $(subst $(comma),_,$(dot-target).d)
 
 ###
 # filename of target with directory and extension stripped
@@ -113,7 +117,8 @@ # See Documentation/kbuild/makefiles.txt
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both arguments has same arguments. Result in empty string if equal
 # User may override this check using make KBUILD_NOCMDDEP=1
-arg-check = $(strip $(filter-out $(1), $(2)) $(filter-out $(2), $(1)) )
+arg-check = $(strip $(filter-out $(cmd_$(1)), $(cmd_$@)) \
+                    $(filter-out $(cmd_$@),   $(cmd_$(1))) )
 endif
 
 # echo command. Short version is $(quiet) equals quiet, otherwise full command
@@ -122,31 +127,34 @@ echo-cmd = $(if $($(quiet)cmd_$(1)), \
 
 make-cmd = $(subst \#,\\\#,$(subst $$,$$$$,$(call escsq,$(cmd_$(1)))))
 
+# Any prerequisites that require target to be built - phony prereq's skipped
+# Any prerequisites that does not exist
+any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
+
 # function to only execute the passed command if necessary
-# >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
-# note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
+# >'< substitution is for echo to work,
+# >$< substitution to preserve $ when reloading .cmd file
+# note: when using inline perl scripts [perl -e '...$$t=1;...']
+# in $(cmd_xxx) double $$ your perl vars
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
