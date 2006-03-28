Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWC1XAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWC1XAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWC1W7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:12 -0500
Received: from [198.99.130.12] ([198.99.130.12]:19651 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964785AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SN06sL022972@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 3/10] UML - Eliminate symlinks to host arch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

uml: kills symlinks in arch/um/sys-*

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Makefile-x86_64        |    2 +-
 arch/um/scripts/Makefile.rules |   26 ++++----------------------
 arch/um/sys-i386/Makefile      |   17 +++++------------
 arch/um/sys-x86_64/Makefile    |   28 +++++++++-------------------
 4 files changed, 19 insertions(+), 54 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 38df311..dfd88b6 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-libs-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index 2e41cab..b696b45 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -20,25 +20,7 @@ define unprofile
 	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
 endef
 
-
-# cmd_make_link checks to see if the $(foo-dir) variable starts with a /.  If
-# so, it's considered to be a path relative to $(srcdir) rather than
-# $(srcdir)/arch/$(SUBARCH).  This is because x86_64 wants to get ldt.c from
-# arch/um/sys-i386 rather than arch/i386 like the other borrowed files.  So,
-# it sets $(ldt.c-dir) to /arch/um/sys-i386.
-quiet_cmd_make_link = SYMLINK $@
-cmd_make_link       = rm -f $@; ln -sf $(srctree)$(if $(filter-out /%,$($(notdir $@)-dir)),/arch/$(SUBARCH))/$($(notdir $@)-dir)/$(notdir $@) $@
-
-# this needs to be before the foreach, because targets does not accept
-# complete paths like $(obj)/$(f). To make sure this works, use a := assignment
-# or we will get $(obj)/$(f) in the "targets" value.
-# Also, this forces you to use the := syntax when assigning to targets.
-# Otherwise the line below will cause an infinite loop (if you don't know why,
-# just do it).
-
-targets := $(targets) $(SYMLINKS)
-
-SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$(f))
-
-$(SYMLINKS): FORCE
-	$(call if_changed,make_link)
+ifdef subarch-obj-y
+obj-y += subarch.o
+subarch-y = $(addprefix ../../$(SUBARCH)/,$(subarch-obj-y))
+endif
diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index f5fd5b0..1c89f43 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -1,23 +1,16 @@
-obj-y := bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
-	sys_call_table.o
+obj-y = bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o signal.o sigcontext.o syscalls.o sysrq.o sys_call_table.o
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
-obj-$(CONFIG_HIGHMEM) += highmem.o
-obj-$(CONFIG_MODULES) += module.o
+subarch-obj-y = lib/bitops.o kernel/semaphore.o
+subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
+subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
-SYMLINKS = bitops.c semaphore.c highmem.c module.c
-
 include arch/um/scripts/Makefile.rules
 
-bitops.c-dir = lib
-semaphore.c-dir = kernel
-highmem.c-dir = mm
-module.c-dir = kernel
-
 $(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
 include arch/um/scripts/Makefile.unmap
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index a351091..fd19211 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -4,30 +4,20 @@
 # Licensed under the GPL
 #
 
-#XXX: why into lib-y?
-lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o ldt.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o sigcontext.o signal.o syscalls.o \
-	syscall_table.o sysrq.o thunk.o
-lib-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
+obj-y = bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
+	sigcontext.o signal.o syscalls.o syscall_table.o sysrq.o ksyms.o
 
-obj-y := ksyms.o
-obj-$(CONFIG_MODULES) += module.o um_module.o
+obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
+obj-$(CONFIG_MODULES) += um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
+subarch-obj-y = lib/bitops.o lib/csum-partial.o lib/memcpy.o lib/thunk.o
+subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
-SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c memcpy.S \
-	thunk.S module.c
+ldt-y = ../sys-i386/ldt.o
 
-include arch/um/scripts/Makefile.rules
+USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
-bitops.c-dir = lib
-csum-copy.S-dir = lib
-csum-partial.c-dir = lib
-csum-wrappers.c-dir = lib
-ldt.c-dir = /arch/um/sys-i386
-memcpy.S-dir = lib
-thunk.S-dir = lib
-module.c-dir = kernel
+include arch/um/scripts/Makefile.rules
 
 $(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
 

