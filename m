Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVDXSUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVDXSUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVDXSUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:20:51 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:9373 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262365AbVDXSUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:20:10 -0400
Subject: [patch 4/6] uml kbuild: avoid useless rebuilds [for 2.6.13]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:10:05 +0200
Message-Id: <20050424181005.0246655CFF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*) Fix some problems with usage of $(targets) (sometimes missing, sometimes
used badly) that trigger partial rebuilds when doing a rebuild.

*) At that purpose, also factor out some common code for symlinks creation.

*) Fix a x86-64 build warning, caused by -L/usr/lib, which is anyway useless,
and invalid in the x86-64 case.

Tested on x86_64 and x86.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/Makefile               |    2 +-
 linux-2.6.12-paolo/arch/um/kernel/Makefile        |    4 ++--
 linux-2.6.12-paolo/arch/um/kernel/tt/Makefile     |    1 +
 linux-2.6.12-paolo/arch/um/scripts/Makefile.rules |   16 +++++++++++++++-
 linux-2.6.12-paolo/arch/um/sys-i386/Makefile      |   15 ++-------------
 linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile    |   15 ++-------------
 6 files changed, 23 insertions(+), 30 deletions(-)

diff -puN arch/um/kernel/Makefile~uml-Makefile-avoid-rebuild arch/um/kernel/Makefile
--- linux-2.6.12/arch/um/kernel/Makefile~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/Makefile	2005-04-24 19:32:17.000000000 +0200
@@ -4,7 +4,7 @@
 #
 
 extra-y := vmlinux.lds
-clean-files := vmlinux.lds.S config.tmp
+clean-files := vmlinux.lds.S
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
@@ -34,7 +34,7 @@ USER_OBJS := $(user-objs-y) config.o hel
 
 include arch/um/scripts/Makefile.rules
 
-targets += config.c
+targets := config.c config.tmp
 
 # Be careful with the below Sed code - sed is pitfall-rich!
 # We use sed to lower build requirements, for "embedded" builders for instance.
diff -puN arch/um/kernel/tt/Makefile~uml-Makefile-avoid-rebuild arch/um/kernel/tt/Makefile
--- linux-2.6.12/arch/um/kernel/tt/Makefile~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/tt/Makefile	2005-04-24 19:32:17.000000000 +0200
@@ -4,6 +4,7 @@
 #
 
 extra-y := unmap_fin.o
+targets := unmap.o
 clean-files := unmap_tmp.o
 
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
diff -puN arch/um/scripts/Makefile.rules~uml-Makefile-avoid-rebuild arch/um/scripts/Makefile.rules
--- linux-2.6.12/arch/um/scripts/Makefile.rules~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/scripts/Makefile.rules	2005-04-24 19:32:17.000000000 +0200
@@ -10,4 +10,18 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 $(USER_OBJS): c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
 
 quiet_cmd_make_link = SYMLINK $@
-cmd_make_link       = rm -f $@; ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
+cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
+
+# this needs to be before the foreach, because targets does not accept
+# complete paths like $(obj)/$(f). To make sure this works, use a := assignment,
+# or we will get $(obj)/$(f) in the "targets" value.
+# Also, this forces you to use the := syntax when assigning to targets.
+# Otherwise the line below will cause an infinite loop (if you don't know why,
+# just do it).
+
+targets := $(targets) $(SYMLINKS)
+
+SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$(f))
+
+$(SYMLINKS): FORCE
+	$(call if_changed,make_link)
diff -puN arch/um/sys-x86_64/Makefile~uml-Makefile-avoid-rebuild arch/um/sys-x86_64/Makefile
--- linux-2.6.12/arch/um/sys-x86_64/Makefile~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile	2005-04-24 19:32:17.000000000 +0200
@@ -10,19 +10,9 @@ lib-y = bitops.o bugs.o csum-partial.o d
 
 USER_OBJS := ptrace_user.o sigcontext.o
 
-include arch/um/scripts/Makefile.rules
-
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
 	semaphore.c thunk.S
 
-# this needs to be before the foreach, because clean-files does not accept
-# complete paths like $(src)/$f.
-clean-files := $(SYMLINKS)
-
-targets += $(SYMLINKS)
-
-SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
-
 bitops.c-dir = lib
 csum-copy.S-dir = lib
 csum-partial.c-dir = lib
@@ -31,7 +21,6 @@ memcpy.S-dir = lib
 semaphore.c-dir = kernel
 thunk.S-dir = lib
 
-$(SYMLINKS): FORCE
-	$(call if_changed,make_link)
-
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
+
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/sys-i386/Makefile~uml-Makefile-avoid-rebuild arch/um/sys-i386/Makefile
--- linux-2.6.12/arch/um/sys-i386/Makefile~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-i386/Makefile	2005-04-24 19:32:17.000000000 +0200
@@ -6,24 +6,13 @@ obj-$(CONFIG_MODULES) += module.o
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 
-include arch/um/scripts/Makefile.rules
-
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
-# this needs to be before the foreach, because clean-files does not accept
-# complete paths like $(src)/$f.
-clean-files := $(SYMLINKS)
-
-targets += $(SYMLINKS)
-
-SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
-
 bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
-$(SYMLINKS): FORCE
-	$(call if_changed,make_link)
-
 subdir- := util
+
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/Makefile~uml-Makefile-avoid-rebuild arch/um/Makefile
--- linux-2.6.12/arch/um/Makefile~uml-Makefile-avoid-rebuild	2005-04-24 19:32:17.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/Makefile	2005-04-24 19:32:17.000000000 +0200
@@ -126,7 +126,7 @@ define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
 	-Wl,--start-group $(vmlinux-main) -Wl,--end-group \
-	-L/usr/lib -lutil \
+	-lutil \
 	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) \
 	FORCE ,$^) ; rm -f linux
 endef
_
