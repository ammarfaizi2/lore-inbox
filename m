Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUE3Tf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUE3Tf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUE3Tfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 15:35:55 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:61964 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264308AbUE3Tfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 15:35:46 -0400
Date: Sun, 30 May 2004 21:38:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] kbuild: Specify default target during configuration
Message-ID: <20040530193800.GA5426@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patchs allows one to specify default target when
doing make *config.
This has the advantage that kbuild knows the final target, a knowledge
that is required when building rpm's or deb's.

The following patch introduce selecting default target for i386,
and is mainly a RFC. If there is no big complains I will update it
to cover a few more architectures before submitting.

Comments to the suggested help texts is also appreciated.

	Sam

===== arch/i386/Kconfig 1.121 vs edited =====
--- 1.121/arch/i386/Kconfig	2004-05-10 13:25:50 +02:00
+++ edited/arch/i386/Kconfig	2004-05-30 21:25:41 +02:00
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
 
 
===== Makefile 1.492 vs edited =====
--- 1.492/Makefile	2004-05-30 08:24:06 +02:00
+++ edited/Makefile	2004-05-30 21:35:32 +02:00
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
@@ -448,6 +441,11 @@
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
+
+# Let all: depend on target selected in .config
+# Hereby user only have to issue 'make' to build the kernel, including
+# selected kernel
+all: $(subst ",,$(CONFIG_KERNEL_IMAGE))
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
===== arch/i386/Makefile 1.67 vs edited =====
--- 1.67/arch/i386/Makefile	2004-05-15 08:11:50 +02:00
+++ edited/arch/i386/Makefile	2004-05-30 21:27:17 +02:00
@@ -115,18 +115,20 @@
 
 boot := arch/i386/boot
 
-.PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+# Lot's of documentation refer to these, so keep the short versions for now
+.PHONY: bzImage zImage compressed
+bzImage:    $(boot)/bzImage
+zImage:     $(boot)/zImage
+compressed: $(boot)/zImage
 
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
