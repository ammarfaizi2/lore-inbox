Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUFNUfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUFNUfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFNUfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:35:43 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:55933 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263975AbUFNUfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:35:18 -0400
Date: Mon, 14 Jun 2004 22:44:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040614204405.GB15243@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/07 22:56:31+02:00 sam@mars.ravnborg.org 
#   kbuild: Default kernel image defined in .config
#   
#   During kernel configuration the default kernel image is now being selected.
#   When compiling the kernel the user no longer needs to look up the
#   selected kernel imgae in either the $(ARCH) makefile or in 'make help'.
#   The more natural choice is to select the kernel image during kernel
#   the configuration.
#   The menu is located at the very top, since the other logical place
#   "general setup" did not have an opening for architecture specific
#   options.
#   The added benefit is that packaging tools now have access to the selected
#   kernel imgae, and do not have to do wild guessing based on architectures.
#   
#   This patch only converts i386, but other architectures should be easy to convert.
#   The patch is backward compatible, other architecture will not break due to this change.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/i386/Makefile
#   2004/06/07 22:56:16+02:00 sam@mars.ravnborg.org +10 -8
#   Teach i386 makefile to use full path to kernel image, along the well known short versions of the names
# 
# arch/i386/Kconfig
#   2004/06/07 22:56:16+02:00 sam@mars.ravnborg.org +36 -0
#   Add i386 config options to select kernel image
# 
# Makefile
#   2004/06/07 22:56:16+02:00 sam@mars.ravnborg.org +10 -7
#   Use the new default target selected during kernel configuration.
#   When no kernel image is selected during configuaration vmlinux is assumed default.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-14 22:26:01 +02:00
+++ b/Makefile	2004-06-14 22:26:01 +02:00
@@ -409,13 +409,6 @@
 
 scripts_basic: include/linux/autoconf.h
 
-
-# That's our default target when none is given on the command line
-# Note that 'modules' will be added as a prerequisite as well, 
-# in the CONFIG_MODULES part below
-
-all:	vmlinux
-
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/
@@ -448,6 +441,16 @@
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
+
+# Selected kernel image to build in .config, assuming vmlinux
+# if CONFIG_KERNEL_IMAGE is empty (not defined)
+KERNEL_IMAGE := $(if $(CONFIG_KERNEL_IMAGE), \
+                     $(subst ",,$(CONFIG_KERNEL_IMAGE)), vmlinux)
+
+# The all: target has the kernel selected in .config as prerequisite.
+# Hereby user only have to issue 'make' to build the kernel, including
+# selected kernel
+all: $(KERNEL_IMAGE)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-06-14 22:26:01 +02:00
+++ b/arch/i386/Kconfig	2004-06-14 22:26:01 +02:00
@@ -29,6 +29,42 @@
 	bool
 	default y
 
+choice
+	prompt "Default kernel image"
+	default KERNEL_IMAGE_BZIMAGE
+	help
+	  Specify which kernel image to be build when executing 'make' with
+	  no arguments.
+
+config KERNEL_IMAGE_BZIMAGE
+	bool "bzImage - Compressed kernel image"
+	help
+	  bzImage - located at arch/i386/boot/bzImage.
+	  bzImage can accept larger kernels than zImage
+	
+config KERNEL_IMAGE_ZIMAGE
+	bool "zImage - Compressed kernel image"
+	help
+	  zImage - located at arch/i386/boot/zImage.
+	  zImage is seldom used. zImage supports smaller kernels than bzImage,
+	  and is only used in special situations.
+
+config KERNEL_IMAGE_VMLINUX
+	bool "vmlinux - the bare kernel"
+	help
+	  vmlinux - located at the root of the kernel tree
+	  vmlinux contains the kernel image with no additional bootloader.
+	  vmlinux is seldom used as target for i386.
+
+endchoice
+
+config KERNEL_IMAGE
+	string 
+	default arch/i386/boot/bzImage if KERNEL_IMAGE_BZIMAGE
+	default arch/i386/boot/zImage  if KERNEL_IMAGE_ZIMAGE
+	default vmlinux                if KERNEL_IMAGE_VMLINUX
+
+
 source "init/Kconfig"
 
 
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2004-06-14 22:26:01 +02:00
+++ b/arch/i386/Makefile	2004-06-14 22:26:01 +02:00
@@ -116,18 +116,20 @@
 
 boot := arch/i386/boot
 
-.PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+# Shortcut targets to different i386 targets.
+.PHONY: bzImage zImage compressed
+bzImage:    $(boot)/bzImage
+zImage:     $(boot)/zImage
+compressed: $(boot)/zImage	# Deprecated, will be deleted later
 
-all: bzImage
+# Target's that install the kernel
+.PHONY: zlilo bzlilo zdisk bzdisk fdimage fdimage144 fdimage288 install
 
 BOOTIMAGE=arch/i386/boot/bzImage
-zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
+zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
 
-zImage bzImage: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
-
-compressed: zImage
+$(boot)/zImage $(boot)/bzImage: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
 zlilo bzlilo: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zlilo
