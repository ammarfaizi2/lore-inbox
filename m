Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262844AbTCUC2P>; Thu, 20 Mar 2003 21:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbTCUC2P>; Thu, 20 Mar 2003 21:28:15 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:51328 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262844AbTCUC2M>; Thu, 20 Mar 2003 21:28:12 -0500
Date: Fri, 21 Mar 2003 11:38:24 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (1/14) boot98 update
Message-ID: <20030321023824.GA1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (1/14)

Update arch/i386/Makefile and arch/i386/boot98/* to syncronize with 2.5.65.

Regards,
Osamu Tomita

diff -Nru linux-2.5.65-ac1/arch/i386/Makefile linux98-2.5.65/arch/i386/Makefile
--- linux-2.5.65-ac1/arch/i386/Makefile	2003-03-20 09:09:40.000000000 +0900
+++ linux98-2.5.65/arch/i386/Makefile	2003-03-18 10:51:26.000000000 +0900
@@ -65,10 +65,6 @@
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
 mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
-# PC-9800 subarch support
-mflags-$(CONFIG_X86_PC9800)	:= -Iinclude/asm-i386/mach-pc9800
-mcore-$(CONFIG_X86_PC9800)	:= mach-pc9800
-
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
 mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
@@ -77,6 +73,10 @@
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
 mcore-$(CONFIG_X86_SUMMIT)  := mach-default
 
+# PC-9800 subarch support
+mflags-$(CONFIG_X86_PC9800)	:= -Iinclude/asm-i386/mach-pc9800
+mcore-$(CONFIG_X86_PC9800)	:= mach-pc9800
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
diff -Nru linux-2.5.65-ac1/arch/i386/boot98/Makefile linux98-2.5.65/arch/i386/boot98/Makefile
--- linux-2.5.65-ac1/arch/i386/boot98/Makefile	2003-03-20 09:09:40.000000000 +0900
+++ linux98-2.5.65/arch/i386/boot98/Makefile	2003-03-18 08:52:00.000000000 +0900
@@ -25,9 +25,8 @@
 
 #RAMDISK := -DRAMDISK=512
 
-EXTRA_TARGETS	:= vmlinux.bin bootsect bootsect.o \
-		   setup setup.o zImage bzImage
-
+targets		:= vmlinux.bin bootsect bootsect.o setup setup.o \
+		   zImage bzImage
 subdir- 	:= compressed
 
 host-progs	:= tools/build
@@ -62,8 +61,36 @@
 	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
 					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
-zdisk: $(BOOTIMAGE)
-	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
+# Set this if you want to pass append arguments to the zdisk/fdimage kernel
+FDARGS = 
+
+$(obj)/mtools.conf: $(src)/mtools.conf.in
+	sed -e 's|@OBJ@|$(obj)|g' < $< > $@
+
+# This requires write access to /dev/fd0
+zdisk: $(BOOTIMAGE) $(obj)/mtools.conf
+	MTOOLSRC=$(obj)/mtools.conf mformat a:			; sync
+	syslinux /dev/fd0					; sync
+	echo 'default linux $(FDARGS)' | \
+		MTOOLSRC=$(src)/mtools.conf mcopy - a:syslinux.cfg
+	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) a:linux	; sync
+
+# These require being root or having syslinux 2.02 or higher installed
+fdimage fdimage144: $(BOOTIMAGE) $(obj)/mtools.conf
+	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=1440
+	MTOOLSRC=$(obj)/mtools.conf mformat v:			; sync
+	syslinux $(obj)/fdimage					; sync
+	echo 'default linux $(FDARGS)' | \
+		MTOOLSRC=$(obj)/mtools.conf mcopy - v:syslinux.cfg
+	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) v:linux	; sync
+
+fdimage288: $(BOOTIMAGE) $(obj)/mtools.conf
+	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=2880
+	MTOOLSRC=$(obj)/mtools.conf mformat w:			; sync
+	syslinux $(obj)/fdimage					; sync
+	echo 'default linux $(FDARGS)' | \
+		MTOOLSRC=$(obj)/mtools.conf mcopy - w:syslinux.cfg
+	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) w:linux	; sync
 
 zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
diff -Nru linux-2.5.65-ac1/arch/i386/boot98/compressed/Makefile linux98-2.5.65/arch/i386/boot98/compressed/Makefile
--- linux-2.5.65-ac1/arch/i386/boot98/compressed/Makefile	2003-03-20 09:09:40.000000000 +0900
+++ linux98-2.5.65/arch/i386/boot98/compressed/Makefile	2003-03-18 08:52:00.000000000 +0900
@@ -4,7 +4,7 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
diff -Nru linux-2.5.65/arch/i386/boot98/mtools.conf.in linux98-2.5.65/arch/i386/boot98/mtools.conf.in
--- linux-2.5.65/arch/i386/boot98/mtools.conf.in	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.65/arch/i386/boot98/mtools.conf.in	2003-03-18 08:52:00.000000000 +0900
@@ -0,0 +1,17 @@
+#
+# mtools configuration file for "make (b)zdisk"
+#
+
+# Actual floppy drive
+drive a:
+  file="/dev/fd0"
+
+# 1.44 MB floppy disk image
+drive v:
+  file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=18 filter
+
+# 2.88 MB floppy disk image (mostly for virtual uses)
+drive w:
+  file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=36 filter
+
+
diff -Nru linux-2.5.65-ac1/arch/i386/boot98/tools/build.c linux98-2.5.65/arch/i386/boot98/tools/build.c
--- linux-2.5.65-ac1/arch/i386/boot98/tools/build.c	2003-03-20 09:09:40.000000000 +0900
+++ linux98-2.5.65/arch/i386/boot98/tools/build.c	2003-03-18 10:39:05.000000000 +0900
@@ -149,13 +149,10 @@
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
+	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
+	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
 		die("System is too big. Try using %smodules.",
 			is_big_kernel ? "" : "bzImage or ");
-	if (sys_size > 0xefff)
-		fprintf(stderr,"warning: kernel is too big for standalone boot "
-		    "from floppy\n");
 	while (sz > 0) {
 		int l, n;
 
