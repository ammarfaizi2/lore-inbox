Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCAVqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUCAVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:46:08 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:43088 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261451AbUCAVpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:45:41 -0500
Date: Mon, 1 Mar 2004 22:46:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC] kbuild: Add a binary only .o file to a module
Message-ID: <20040301214617.GA7777@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchs enables the following syntax in kbuild makefiles:

module-addobj	:= binary-only.o

module-y	:= a.o b.o c.o

This allows for a clean inclusion of binary only .o files in a module.
This is relevant in the rare cases where there is a glue layer between
some proprietary code and the kernel. Nvidia and the RTL8180 is some
recent examples.

This can be done in several other ways as already suggested in on lkml.
But none of them were what I consider 'good enough' - introducing
some spooky rules etc.


Any objections from having this in the kernel?
[Please, please, this is only for 'legal' binary modules - so do not
start the usual 'binary modules should be GPL discussion'].

This is a small step towards better support for external modules.

For RTL8180 my Makefile looks like this now:

EXTRA_CFLAGS = -DRTL_IO_MAP

obj-m		:= rtl8180.o
rtl8180-y	+= r8180_if.o r8180_pci_init.o usercopy.o

# Include proprietary binary module
rtl8180-addobj := priv_part.o


	Sam

===== scripts/Makefile.build 1.42 vs edited =====
--- 1.42/scripts/Makefile.build	Fri Feb 27 06:33:07 2004
+++ edited/scripts/Makefile.build	Mon Mar  1 22:35:47 2004
@@ -255,21 +255,29 @@
 $(filter $(addprefix $(obj)/,         \
 $($(subst $(obj)/,,$(@:.o=-objs)))    \
 $($(subst $(obj)/,,$(@:.o=-y)))), $^)
+
+# Additional binary images may be linked in without any corresponding src.
+# <composite-object>-addobj := <list of .o files>
+# kbuild will check timestamp, and update <composite object>
+# when the binary changes
+link_multi_add = $(addprefix $(src)/,$($(subst $(obj)/,,$(@:.o=-addobj))))
  
 quiet_cmd_link_multi-y = LD      $@
-cmd_link_multi-y = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps)
+cmd_link_multi-y = $(LD) $(ld_flags) -r -o $@ \
+                         $(link_multi_deps) $(link_multi_add)
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) $(LDFLAGS_MODULE) -o $@ $(link_multi_deps)
+cmd_link_multi-m = $(LD) $(ld_flags) $(LDFLAGS_MODULE) -o $@ \
+                         $(link_multi_deps) $(link_multi_add)
 
 # We would rather have a list of rules like
 # 	foo.o: $(foo-objs)
 # but that's not so easy, so we rather make all composite objects depend
 # on the set of all their parts
-$(multi-used-y) : %.o: $(multi-objs-y) FORCE
+$(multi-used-y) : %.o: $(multi-objs-y) $(multi-add-y) FORCE
 	$(call if_changed,link_multi-y)
 
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
+$(multi-used-m) : %.o: $(multi-objs-m) $(multi-add-m) FORCE
 	$(call if_changed,link_multi-m)
 	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
 
===== scripts/Makefile.lib 1.23 vs edited =====
--- 1.23/scripts/Makefile.lib	Wed Feb  4 06:29:13 2004
+++ edited/scripts/Makefile.lib	Mon Mar  1 22:25:48 2004
@@ -54,6 +54,11 @@
 multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)))
 multi-objs   := $(multi-objs-y) $(multi-objs-m)
 
+# Build a list of all additional object to add to our composite objects
+# The composite objects depends on these
+multi-add-y := $(foreach m, $(multi-used-y), $($(m:.o=-addobj)))
+multi-add-m := $(foreach m, $(multi-used-m), $($(m:.o=-addobj)))
+
 # $(subdir-obj-y) is the list of objects in $(obj-y) which do not live
 # in the local directory
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
@@ -111,6 +116,8 @@
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
 multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
 multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
+multi-add-y	:= $(addprefix $(obj)/,$(multi-add-y))
+multi-add-m	:= $(addprefix $(obj)/,$(multi-add-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
 host-progs      := $(addprefix $(obj)/,$(host-progs))
