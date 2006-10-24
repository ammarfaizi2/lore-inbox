Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWJXPZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWJXPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWJXPZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:25:26 -0400
Received: from main.gmane.org ([80.91.229.2]:37344 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965148AbWJXPZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:25:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [patch, rfc] kbuild: implement checksrc without building Cources
	 (was Re: CHECK without C compile?)
Followup-To: gmane.linux.kernel
Date: Tue, 24 Oct 2006 15:24:08 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejscd5.93p.olecom@flower.upol.cz>
References: <20061023153540.4d467a88.rdunlap@xenotime.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Randy Dunlap <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: kbuild-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-23, Randy Dunlap wrote:
> Hi Sam,

It seem he on vocation, let me get it, since i've started my develife
from makefiles.

> Is there an option/variant of CHECKSRC that does something like
> 	make checkall
> i.e., runs CHECK=sparse on all source files, without also building them
> with the C compiler?

As far as i can see, no, there isn't.
I have thing to propose, but something with generated header files
will not work yet (e.g kernel/config_data.h). Patch is rfc, of course.

---
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [patch, rfc] kbuild: implement checksrc without building Cources

  Implementation of configured source chacking without actual building.

Cc: Randy Dunlap <rdunlap@xenotime.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Oleg Verych <olecom@flower.upol.cz>
---

  Configured sources means, some config target must be run already.
  After that
  ,-<shell>
  | make prepare
  | make C=something_not_0,1,2 _target_
  `--
  should run _target_ with checking and without building.

-o--=O`C  /. .\
 #oo'L O      o
<___=E M    ^--

 scripts/Kbuild.include |    6 +++---
 scripts/Makefile.build |   21 +++++++++++++--------
 2 files changed, 16 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc3/scripts/Kbuild.include
===================================================================
--- linux-2.6.19-rc3.orig/scripts/Kbuild.include	2006-10-24 12:47:09.670676021 +0000
+++ linux-2.6.19-rc3/scripts/Kbuild.include	2006-10-24 12:54:25.823530955 +0000
@@ -153,7 +153,7 @@
 if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
 	@set -e;                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	echo 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd)
+	echo 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # execute the command and also postprocess generated .d dependencies
 # file
@@ -162,14 +162,14 @@
 	$(echo-cmd) $(cmd_$(1));                                             \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
 	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd)
+	mv -f $(dot-target).tmp $(dot-target).cmd, @:)
 
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
 if_changed_rule = $(if $(strip $(any-prereq) $(arg-check) ),                 \
 	@set -e;                                                             \
-	$(rule_$(1)))
+	$(rule_$(1)), @:)
 
 ###
 # why - tell why a a target got build
Index: linux-2.6.19-rc3/scripts/Makefile.build
===================================================================
--- linux-2.6.19-rc3.orig/scripts/Makefile.build	2006-10-24 12:46:45.161279310 +0000
+++ linux-2.6.19-rc3/scripts/Makefile.build	2006-10-24 13:14:11.947124287 +0000
@@ -87,12 +87,17 @@
 
 # Linus' kernel sanity checking tool
 ifneq ($(KBUILD_CHECKSRC),0)
-  ifeq ($(KBUILD_CHECKSRC),2)
-    quiet_cmd_force_checksrc = CHECK   $<
-          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
-  else
+  ifeq ($(KBUILD_CHECKSRC),1)
       quiet_cmd_checksrc     = CHECK   $<
             cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+  else
+    quiet_cmd_force_checksrc = CHECK   $<
+          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+    ifneq ($(KBUILD_CHECKSRC),2)
+      if_changed      = @:
+      if_changed_dep  = @:
+      if_changed_rule = @:
+    endif
   endif
 endif
 
@@ -207,8 +212,8 @@
 
 $(single-used-m): %.o: %.c FORCE
 	$(call cmd,force_checksrc)
-	$(call if_changed_rule,cc_o_c)
-	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
+	$(call if_changed_rule,cc_o_c) || \
+	{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -310,8 +315,8 @@
 	$(call if_changed,link_multi-y)
 
 $(multi-used-m) : %.o: $(multi-objs-m) FORCE
-	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
+	$(call if_changed,link_multi-m) || \
+	{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
 
 targets += $(multi-used-y) $(multi-used-m)
 

