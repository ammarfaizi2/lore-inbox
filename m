Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCVR57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCVR57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCVR57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:57:59 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:3462 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261493AbVCVR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:36 -0500
Subject: [patch 08/12] uml: factor out common code in user-obj handling
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       vadim_abrossimov@yahoo.com
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:36 +0100
Message-Id: <20050322162136.B82619766F@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Vadim Abrossimov <vadim_abrossimov@yahoo.com>

*) Handle USER_OBJS through the general Kbuild infrastructure; the trick we
use is to change c_flags only for USER_OBJS.

This ain't at all worse than the previous kludgy solution, enables us to use a
better dependency handling and to support MODVERSIONS.

And it is UML-specific, as a bonus.

So, no "it ain't clean enough" reasoning is allowed to hold this patch until
you find a better solution. Leaving there the current broken code is not
accepted.

*) Move similar definitions from Makefiles to the newly created
arch/um/scripts/Makefile.rules and include it everywhere needed.

Please test on x86_64 subarch, I've tested it on i386.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/Makefile             |    9 ++-------
 linux-2.6.11-paolo/arch/um/kernel/Makefile              |   14 +++++++-------
 linux-2.6.11-paolo/arch/um/kernel/skas/Makefile         |    8 +++-----
 linux-2.6.11-paolo/arch/um/kernel/tt/Makefile           |   12 +++++-------
 linux-2.6.11-paolo/arch/um/kernel/tt/ptproxy/Makefile   |    5 ++---
 linux-2.6.11-paolo/arch/um/os-Linux/Makefile            |    6 ++----
 linux-2.6.11-paolo/arch/um/os-Linux/drivers/Makefile    |    8 +-------
 linux-2.6.11-paolo/arch/um/os-Linux/sys-i386/Makefile   |    5 ++---
 linux-2.6.11-paolo/arch/um/os-Linux/sys-x86_64/Makefile |    5 ++---
 linux-2.6.11-paolo/arch/um/scripts/Makefile.rules       |   10 ++++++++++
 linux-2.6.11-paolo/arch/um/sys-i386/Makefile            |    6 ++----
 linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile          |    8 +++-----
 linux-2.6.11-paolo/fs/hostfs/Makefile                   |   10 ++--------
 13 files changed, 43 insertions(+), 63 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-user-obj-cleanup arch/um/drivers/Makefile
--- linux-2.6.11/arch/um/drivers/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:50.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -41,11 +41,6 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 
-USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o
 
-USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS)) fd.o \
-	null.o pty.o tty.o xterm.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/kernel/Makefile~uml-user-obj-cleanup arch/um/kernel/Makefile
--- linux-2.6.11/arch/um/kernel/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:50.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -23,16 +23,16 @@ obj-$(CONFIG_SYSCALL_DEBUG) += syscall_u
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
 
-user-objs-$(CONFIG_TTY_LOG) += tty_log.o
+# This needs be compiled with frame pointers regardless of how the rest of the
+# kernel is built.
+CFLAGS_frame.o := -fno-omit-frame-pointer
 
-USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o frame.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-CFLAGS_frame.o := -fno-omit-frame-pointer
+USER_OBJS := $(user-objs-y) config.o helper.o main.o process.o tempfile.o \
+	time.o tty_log.o umid.o user_util.o frame.o
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
 
 targets += config.c
 
diff -puN arch/um/kernel/skas/Makefile~uml-user-obj-cleanup arch/um/kernel/skas/Makefile
--- linux-2.6.11/arch/um/kernel/skas/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:50.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -6,10 +6,8 @@
 obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \
 
-USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+subdir- := util
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+USER_OBJS := process.o time.o
 
-subdir- := util
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/kernel/tt/Makefile~uml-user-obj-cleanup arch/um/kernel/tt/Makefile
--- linux-2.6.11/arch/um/kernel/tt/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -12,17 +12,15 @@ obj-y = exec_kern.o exec_user.o gdb.o ks
 
 obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptproxy/
 
-USER_OBJS := $(filter %_user.o,$(obj-y)) gdb.o time.o tracer.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+USER_OBJS := gdb.o time.o tracer.o
+
+include arch/um/scripts/Makefile.rules
 
 UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
 UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,$(UNMAP_CFLAGS))
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
-$(obj)/unmap.o: $(src)/unmap.c
-	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
+#XXX: partially copied from arch/um/scripts/Makefile.rules
+$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)
 
 $(obj)/unmap_fin.o : $(obj)/unmap.o
 	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
diff -puN arch/um/kernel/tt/ptproxy/Makefile~uml-user-obj-cleanup arch/um/kernel/tt/ptproxy/Makefile
--- linux-2.6.11/arch/um/kernel/tt/ptproxy/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/ptproxy/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -5,7 +5,6 @@
 
 obj-y = proxy.o ptrace.o sysdep.o wait.o
 
-USER_OBJS := $(foreach file,$(obj-y),$(src)/$(file))
+USER_OBJS := $(obj-y)
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/os-Linux/drivers/Makefile~uml-user-obj-cleanup arch/um/os-Linux/drivers/Makefile
--- linux-2.6.11/arch/um/os-Linux/drivers/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/drivers/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -10,10 +10,4 @@ obj-y = 
 obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
 obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
 
-USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y)),$($(f)-objs))
-
-USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/os-Linux/Makefile~uml-user-obj-cleanup arch/um/os-Linux/Makefile
--- linux-2.6.11/arch/um/os-Linux/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -7,9 +7,7 @@ obj-y = elf_aux.o file.o process.o signa
 	sys-$(SUBARCH)/
 
 USER_OBJS := elf_aux.o file.o process.o signal.o time.o tty.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
 
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
+
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/os-Linux/sys-i386/Makefile~uml-user-obj-cleanup arch/um/os-Linux/sys-i386/Makefile
--- linux-2.6.11/arch/um/os-Linux/sys-i386/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/sys-i386/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_MODE_SKAS) = registers.o
 
-USER_OBJS := $(foreach file,$(obj-y),$(obj)/$(file))
+USER_OBJS := $(obj-y)
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
diff -puN arch/um/os-Linux/sys-x86_64/Makefile~uml-user-obj-cleanup arch/um/os-Linux/sys-x86_64/Makefile
--- linux-2.6.11/arch/um/os-Linux/sys-x86_64/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/sys-x86_64/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_MODE_SKAS) = registers.o
 
-USER_OBJS := $(foreach file,$(obj-y),$(obj)/$(file))
+USER_OBJS := $(obj-y)
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
diff -puN /dev/null arch/um/scripts/Makefile.rules
--- /dev/null	2005-03-21 16:13:45.157956824 +0100
+++ linux-2.6.11-paolo/arch/um/scripts/Makefile.rules	2005-03-21 15:25:51.000000000 +0100
@@ -0,0 +1,10 @@
+# ===========================================================================
+# arch/um: Generic definitions
+# ===========================================================================
+
+USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
+USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))
+
+USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+
+$(USER_OBJS): c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
diff -puN arch/um/sys-i386/Makefile~uml-user-obj-cleanup arch/um/sys-i386/Makefile
--- linux-2.6.11/arch/um/sys-i386/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-i386/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -5,7 +5,8 @@ obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+
+include arch/um/scripts/Makefile.rules
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
@@ -25,9 +26,6 @@ define make_link
 	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
 endef
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
 $(SYMLINKS): 
 	$(call make_link,$@)
 
diff -puN arch/um/sys-x86_64/Makefile~uml-user-obj-cleanup arch/um/sys-x86_64/Makefile
--- linux-2.6.11/arch/um/sys-x86_64/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -9,7 +9,8 @@ lib-y = bitops.o bugs.o csum-partial.o d
 	syscalls.o sysrq.o thunk.o
 
 USER_OBJS := ptrace_user.o sigcontext.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+
+include arch/um/scripts/Makefile.rules
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
 	semaphore.c thunk.S
@@ -27,13 +28,10 @@ thunk.S-dir = lib
 
 define make_link
        -rm -f $1
-       ln -sf $(TOPDIR)/arch/x86_64/$($(notdir $1)-dir)/$(notdir $1) $1
+       ln -sf $(srctree)/arch/x86_64/$($(notdir $1)-dir)/$(notdir $1) $1
 endef
 
 $(SYMLINKS):
 	$(call make_link,$@)
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
diff -puN fs/hostfs/Makefile~uml-user-obj-cleanup fs/hostfs/Makefile
--- linux-2.6.11/fs/hostfs/Makefile~uml-user-obj-cleanup	2005-03-21 15:25:51.000000000 +0100
+++ linux-2.6.11-paolo/fs/hostfs/Makefile	2005-03-21 15:25:51.000000000 +0100
@@ -5,13 +5,7 @@
 
 hostfs-objs := hostfs_kern.o hostfs_user.o
 
-obj-y =
+obj-y :=
 obj-$(CONFIG_HOSTFS) += hostfs.o
 
-SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
-
-USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(SINGLE_OBJS))
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+include arch/um/scripts/Makefile.rules
_
