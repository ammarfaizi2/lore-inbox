Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWGRJX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWGRJX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWGRJVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1667 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932110AbWGRJVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:09 -0400
Message-Id: <20060718091950.550154000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 08/33] Add vmlinuz build target.
Content-Disposition: inline; filename=boot-xen
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vmlinuz image is a stripped and compressed kernel image, it is
smaller than the vmlinux image and the Xen domain builder supports
loading compressed images directly.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Makefile      |    5 +++--
 arch/i386/boot/Makefile |   10 +++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff -r 61d7f9ade4e3 arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Mar 29 17:18:24 2006 +0100
+++ b/arch/i386/Makefile	Wed Mar 29 17:20:20 2006 +0100
@@ -108,15 +108,16 @@ boot := arch/i386/boot
 boot := arch/i386/boot
 
 PHONY += zImage bzImage compressed zlilo bzlilo \
-         zdisk bzdisk fdimage fdimage144 fdimage288 isoimage install
+         zdisk bzdisk fdimage fdimage144 fdimage288 isoimage install vmlinuz
 
 all: bzImage
 
 # KBUILD_IMAGE specify target image being built
                     KBUILD_IMAGE := $(boot)/bzImage
 zImage zlilo zdisk: KBUILD_IMAGE := arch/i386/boot/zImage
+vmlinuz:            KBUILD_IMAGE := $(boot)/vmlinuz
 
-zImage bzImage: vmlinux
+zImage bzImage vmlinuz: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(KBUILD_IMAGE)
 
 compressed: zImage
diff -r 61d7f9ade4e3 arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	Wed Mar 29 17:18:24 2006 +0100
+++ b/arch/i386/boot/Makefile	Wed Mar 29 17:20:20 2006 +0100
@@ -26,7 +26,7 @@ SVGA_MODE := -DSVGA_MODE=NORMAL_VGA
 #RAMDISK := -DRAMDISK=512
 
 targets		:= vmlinux.bin bootsect bootsect.o \
-		   setup setup.o zImage bzImage
+		   setup setup.o zImage bzImage vmlinuz
 subdir- 	:= compressed
 
 hostprogs-y	:= tools/build
@@ -128,5 +128,13 @@ zlilo: $(BOOTIMAGE)
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
+$(obj)/vmlinuz: $(obj)/vmlinux-stripped FORCE
+	$(call if_changed,gzip)
+	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+
+$(obj)/vmlinux-stripped: OBJCOPYFLAGS := -g --strip-unneeded
+$(obj)/vmlinux-stripped: vmlinux FORCE
+	$(call if_changed,objcopy)
+
 install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"

--
