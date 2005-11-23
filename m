Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVKWSqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVKWSqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVKWSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:46:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:61664 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932164AbVKWSqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:46:07 -0500
Date: Wed, 23 Nov 2005 12:43:15 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add support for building uImages
Message-ID: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc: Add support for building uImages

Add support to build a kernel image bootable by u-boot.
Most of the makefile foo is taken from arch/ppc/boot/images/Makefile

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 74dc65dbfa00bb69929c34da2ae788868aaae399
tree 2344f27b9a84a2c3212c4dcc070f6b0cebb906ef
parent 8573cff663f4df7af110c9781ccefd6b12522a2f
author Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 12:44:01 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 12:44:01 -0600

 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a13eb57..5f80e58 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -151,7 +151,7 @@ CPPFLAGS_vmlinux.lds	:= -Upowerpc
 # All the instructions talk about "make bzImage".
 bzImage: zImage
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage
 
 .PHONY: $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9770f58..dfc7eac 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -143,6 +143,36 @@ $(obj)/zImage.initrd: $(obj)/zImage.init
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
+#-----------------------------------------------------------
+# build u-boot images
+#-----------------------------------------------------------
+quiet_cmd_mygzip = GZIP $@
+cmd_mygzip = gzip -f -9 < $< > $@.$$$$ && mv $@.$$$$ $@
+
+quiet_cmd_objbin = OBJCOPY $@
+      cmd_objbin = $(OBJCOPY) -O binary $< $@
+
+quiet_cmd_uimage = UIMAGE $@
+      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T kernel \
+               -C gzip -a 00000000 -e 00000000 -n 'Linux-$(KERNELRELEASE)' \
+               -d $< $@
+
+MKIMAGE		:= $(srctree)/scripts/mkuboot.sh
+targets		+= uImage
+extra-y		+= vmlinux.bin vmlinux.gz
+
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objbin)
+
+$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,mygzip)
+
+$(obj)/uImage: $(obj)/vmlinux.gz
+	$(Q)rm -f $@
+	$(call if_changed,uimage)
+	@echo -n '  Image: $@ '
+	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
+
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 

