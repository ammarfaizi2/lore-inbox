Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVGMSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVGMSDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVGMSC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:02:59 -0400
Received: from [151.97.230.9] ([151.97.230.9]:20716 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262198AbVGMSAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:37 -0400
Subject: [patch 7/9] uml: allow building as 32-bit binary on 64bit host
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:35 +0200
Message-Id: <20050713180235.CF8A021E746@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes the command:

make ARCH=um SUBARCH=i386

work on x86_64 hosts (with support for building 32-bit binaries). This is
especially needed since 64-bit UMLs don't support 32-bit emulation for guest
binaries, currently. This has been tested in all possible cases and works.

Only exception is that I've built but not tested a 64-bit binary, because I
hadn't a 64-bit filesystem available.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Makefile               |   11 +----
 linux-2.6.git-broken-paolo/arch/um/Makefile-i386          |   30 +++++++++-----
 linux-2.6.git-broken-paolo/arch/um/Makefile-x86_64        |    6 +-
 linux-2.6.git-broken-paolo/arch/um/scripts/Makefile.unmap |    4 -
 4 files changed, 31 insertions(+), 20 deletions(-)

diff -puN arch/um/Makefile-i386~uml-build-on-64bit-host arch/um/Makefile-i386
--- linux-2.6.git-broken/arch/um/Makefile-i386~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile-i386	2005-07-13 19:46:33.000000000 +0200
@@ -1,4 +1,4 @@
-SUBARCH_CORE := arch/um/sys-i386/ arch/i386/crypto/
+core-y += arch/um/sys-i386/ arch/i386/crypto/
 
 TOP_ADDR := $(CONFIG_TOP_ADDR)
 
@@ -8,21 +8,33 @@ ifeq ($(CONFIG_MODE_SKAS),y)
   endif
 endif
 
+LDFLAGS			+= -m elf_i386
+ELF_ARCH		:= $(SUBARCH)
+ELF_FORMAT 		:= elf32-$(SUBARCH)
+OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
+
+ifeq ("$(origin SUBARCH)", "command line")
+ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
+CFLAGS			+= $(call cc-option,-m32)
+USER_CFLAGS		+= $(call cc-option,-m32)
+HOSTCFLAGS		+= $(call cc-option,-m32)
+HOSTLDFLAGS		+= $(call cc-option,-m32)
+AFLAGS			+= $(call cc-option,-m32)
+LINK-y			+= $(call cc-option,-m32)
+UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
+
+export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UML_OBJCOPYFLAGS
+endif
+endif
+
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
-ARCH_USER_CFLAGS :=
 
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
-ELF_ARCH := $(SUBARCH)
-ELF_FORMAT := elf32-$(SUBARCH)
-
-OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
-
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
-
-SYS_HEADERS := $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
+SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)
 
diff -puN arch/um/Makefile~uml-build-on-64bit-host arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:46:33.000000000 +0200
@@ -51,11 +51,6 @@ MRPROPER_DIRS	+= $(ARCH_DIR)/include2
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
-
-core-y += $(SUBARCH_CORE)
-libs-y += $(SUBARCH_LIBS)
-
 # -Dvmap=kernel_vmap affects everything, and prevents anything from
 # referencing the libpcap.o symbol so named.
 
@@ -64,7 +59,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+	$(MODE_INCLUDE)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
@@ -74,6 +69,8 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
@@ -132,7 +129,7 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-CFLAGS_vmlinux = $(LINK-y) $(LINK_WRAPS)
+CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
diff -puN arch/um/Makefile-x86_64~uml-build-on-64bit-host arch/um/Makefile-x86_64
--- linux-2.6.git-broken/arch/um/Makefile-x86_64~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile-x86_64	2005-07-13 19:46:33.000000000 +0200
@@ -1,11 +1,13 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-SUBARCH_LIBS := arch/um/sys-x86_64/
+libs-y += arch/um/sys-x86_64/
 START := 0x60000000
 
+#We #undef __x86_64__ for kernelspace, not for userspace where
+#it's needed for headers to work!
 CFLAGS += -U__$(SUBARCH)__ -fno-builtin
-ARCH_USER_CFLAGS := -D__x86_64__
+USER_CFLAGS += -fno-builtin
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
diff -puN arch/um/scripts/Makefile.unmap~uml-build-on-64bit-host arch/um/scripts/Makefile.unmap
--- linux-2.6.git-broken/arch/um/scripts/Makefile.unmap~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/scripts/Makefile.unmap	2005-07-13 19:46:33.000000000 +0200
@@ -12,8 +12,8 @@ $(obj)/unmap.o: _c_flags = $(call unprof
 
 quiet_cmd_wrapld = LD      $@
 define cmd_wrapld
-	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a); \
-	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
+	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) $(CFLAGS) -print-file-name=libc.a); \
+	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
 endef
 
 $(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
_
