Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVCVSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVCVSGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCVSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:05:47 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:35512 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261544AbVCVR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:50 -0500
Subject: [patch 07/12] Uml: little build fixes
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       viro@parcelfarce.linux.theplanet.co.uk, vadim_abrossimov@yahoo.com
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:33 +0100
Message-Id: <20050322162133.F35149766D@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>

Easier parts from "cross-build" (or "UML-kbuild") patch from Al Viro:

*) abuses of host cc/ld/objcopy/paths are gone
*) some #include path fixes
*) other little abuses fixed
*) remove LIBC_DIR var, ask gcc where libc.a is placed.

This creates no problem so can be merged very likely. Note: only tested on
i386, give a run on x86-64.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile-x86_64                    |    4 ----
 linux-2.6.11-paolo/arch/um/include/sysdep-i386/sigcontext.h   |    2 +-
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/sigcontext.h |    2 +-
 linux-2.6.11-paolo/arch/um/kernel/tt/Makefile                 |    6 ++----
 linux-2.6.11-paolo/arch/um/sys-i386/Makefile                  |    2 +-
 linux-2.6.11-paolo/fs/hppfs/Makefile                          |   10 ----------
 linux-2.6.11-paolo/include/asm-um/archparam-i386.h            |    2 +-
 7 files changed, 6 insertions(+), 22 deletions(-)

diff -puN arch/um/include/sysdep-x86_64/sigcontext.h~uml-cross-build-little-fixes arch/um/include/sysdep-x86_64/sigcontext.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/sigcontext.h~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/sigcontext.h	2005-03-21 15:25:47.000000000 +0100
@@ -7,7 +7,7 @@
 #ifndef __SYSDEP_X86_64_SIGCONTEXT_H
 #define __SYSDEP_X86_64_SIGCONTEXT_H
 
-#include "sc.h"
+#include <sysdep/sc.h>
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
diff -puN include/asm-um/archparam-i386.h~uml-cross-build-little-fixes include/asm-um/archparam-i386.h
--- linux-2.6.11/include/asm-um/archparam-i386.h~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/archparam-i386.h	2005-03-21 15:25:47.000000000 +0100
@@ -8,7 +8,7 @@
 
 /********* Bits for asm-um/elf.h ************/
 
-#include "user.h"
+#include <asm/user.h>
 
 extern char * elf_aux_platform;
 #define ELF_PLATFORM (elf_aux_platform)
diff -puN arch/um/include/sysdep-i386/sigcontext.h~uml-cross-build-little-fixes arch/um/include/sysdep-i386/sigcontext.h
--- linux-2.6.11/arch/um/include/sysdep-i386/sigcontext.h~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/sysdep-i386/sigcontext.h	2005-03-21 15:25:47.000000000 +0100
@@ -6,7 +6,7 @@
 #ifndef __SYS_SIGCONTEXT_I386_H
 #define __SYS_SIGCONTEXT_I386_H
 
-#include "sc.h"
+#include <sysdep/sc.h>
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
diff -puN arch/um/sys-i386/Makefile~uml-cross-build-little-fixes arch/um/sys-i386/Makefile
--- linux-2.6.11/arch/um/sys-i386/Makefile~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-i386/Makefile	2005-03-21 19:52:49.000000000 +0100
@@ -22,7 +22,7 @@ module.c-dir = kernel
 
 define make_link
 	-rm -f $1
-	ln -sf $(TOPDIR)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
+	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
 endef
 
 $(USER_OBJS) : %.o: %.c
diff -puN arch/um/kernel/tt/Makefile~uml-cross-build-little-fixes arch/um/kernel/tt/Makefile
--- linux-2.6.11/arch/um/kernel/tt/Makefile~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/Makefile	2005-03-21 19:52:49.000000000 +0100
@@ -24,9 +24,7 @@ $(USER_OBJS) : %.o: %.c
 $(obj)/unmap.o: $(src)/unmap.c
 	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
 
-LIBC_DIR ?= /usr/lib
-
 $(obj)/unmap_fin.o : $(obj)/unmap.o
-	ld -r -o $(obj)/unmap_tmp.o  $< -lc -L$(LIBC_DIR)
-	objcopy $(obj)/unmap_tmp.o $@ -G switcheroo
+	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
+	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
 
diff -puN arch/um/Makefile-x86_64~uml-cross-build-little-fixes arch/um/Makefile-x86_64
--- linux-2.6.11/arch/um/Makefile-x86_64~uml-cross-build-little-fixes	2005-03-21 15:25:47.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-x86_64	2005-03-21 15:25:47.000000000 +0100
@@ -30,7 +30,3 @@ $(SYS_UTIL_DIR)/mk_thread: scripts_basic
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 CLEAN_FILES += $(SYS_HEADERS)
-
-LIBC_DIR := /usr/lib64
-
-export LIBC_DIR
diff -puN fs/hppfs/Makefile~uml-cross-build-little-fixes fs/hppfs/Makefile
--- linux-2.6.11/fs/hppfs/Makefile~uml-cross-build-little-fixes	2005-03-21 19:52:56.000000000 +0100
+++ linux-2.6.11-paolo/fs/hppfs/Makefile	2005-03-21 19:53:17.000000000 +0100
@@ -7,13 +7,3 @@ hppfs-objs := hppfs_kern.o
 
 obj-y =
 obj-$(CONFIG_HPPFS) += hppfs.o
-
-clean:
-
-modules:
-
-fastdep:
-
-dep:
-
-archmrproper: clean
_
