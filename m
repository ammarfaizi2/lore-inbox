Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTBLNcq>; Wed, 12 Feb 2003 08:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTBLNcq>; Wed, 12 Feb 2003 08:32:46 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:30336 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267135AbTBLNcn>; Wed, 12 Feb 2003 08:32:43 -0500
Date: Wed, 12 Feb 2003 22:41:25 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (11/34) boot98-update
Message-ID: <20030212134125.GL1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (11/34).

Updates files under arch/i386/boot98 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/arch/i386/boot98/Makefile linux-2.5.54/arch/i386/boot98/Makefile
--- linux-2.5.50-ac1/arch/i386/boot98/Makefile	2002-12-16 09:15:54.000000000 +0900
+++ linux-2.5.54/arch/i386/boot98/Makefile	2003-01-02 12:21:49.000000000 +0900
@@ -32,12 +32,6 @@
 
 host-progs	:= tools/build
 
-# 	Default
-
-boot: bzImage
-
-include $(TOPDIR)/Rules.make
-
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
@@ -53,6 +47,7 @@
 $(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
+	@echo 'Kernel: $@ is ready'
 
 $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -64,9 +59,8 @@
 	$(call if_changed,ld)
 
 $(obj)/compressed/vmlinux: FORCE
-	+@$(call descend,$(obj)/compressed,IMAGE_OFFSET=$(IMAGE_OFFSET) \
-		$(obj)/compressed/vmlinux)
-
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
+					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
 zdisk: $(BOOTIMAGE)
 	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
@@ -80,11 +74,3 @@
 
 install: $(BOOTIMAGE)
 	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
-
-archhelp:
-	@echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
-	@echo  '  install	- Install kernel using'
-	@echo  '                  (your) ~/bin/installkernel or'
-	@echo  '                  (distribution) /sbin/installkernel or'
-	@echo  '        	  install to $$(INSTALL_PATH) and run lilo'
-
diff -Nru linux-2.5.50-ac1/arch/i386/boot98/compressed/Makefile linux-2.5.52/arch/i386/boot98/compressed/Makefile
--- linux-2.5.50-ac1/arch/i386/boot98/compressed/Makefile	2002-12-16 09:15:54.000000000 +0900
+++ linux-2.5.52/arch/i386/boot98/compressed/Makefile	2002-12-16 11:08:13.000000000 +0900
@@ -7,12 +7,11 @@
 EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
+	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
