Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVIFAso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVIFAso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVIFAso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:48:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54922 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965014AbVIFAsn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:48:43 -0400
Date: Tue, 6 Sep 2005 01:48:42 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
Message-ID: <20050906004842.GP5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sanitized and fixed floppy dependencies: split the messy dependencies for
BLK_DEV_FD by introducing a new symbol (ARCH_MAY_HAVE_PC_FDC), making
BLK_DEV_FD depend on that one and taking declarations of ARCH_MAY_HAVE_PC_FDC
to arch/*/Kconfig.  While we are at it, fixed several obvious cases when
BLK_DEV_FD should have been excluded (architectures lacking asm/floppy.h
are *not* going to have floppy.c compile, let alone work).

If you can come up with better name for that ("this architecture might
have working PC-compatible floppy disk controller"), you are more than
welcome - just s/ARCH_MAY_HAVE_PC_FDC/your_prefered_name/g in the patch
below...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-rio/arch/alpha/Kconfig RC13-git5-floppy/arch/alpha/Kconfig
--- RC13-git5-rio/arch/alpha/Kconfig	2005-08-28 23:09:39.000000000 -0400
+++ RC13-git5-floppy/arch/alpha/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -479,6 +479,9 @@
 	depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	def_bool y
+
 config SMP
 	bool "Symmetric multi-processing support"
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
diff -urN RC13-git5-rio/arch/arm/Kconfig RC13-git5-floppy/arch/arm/Kconfig
--- RC13-git5-rio/arch/arm/Kconfig	2005-09-05 07:05:13.000000000 -0400
+++ RC13-git5-floppy/arch/arm/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -64,6 +64,9 @@
 config GENERIC_BUST_SPINLOCK
 	bool
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+
 config GENERIC_ISA_DMA
 	bool
 
@@ -150,6 +153,7 @@
 	select ARCH_ACORN
 	select FIQ
 	select TIMER_ACORN
+	select ARCH_MAY_HAVE_PC_FDC
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
diff -urN RC13-git5-rio/arch/arm/mach-footbridge/Kconfig RC13-git5-floppy/arch/arm/mach-footbridge/Kconfig
--- RC13-git5-rio/arch/arm/mach-footbridge/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-git5-floppy/arch/arm/mach-footbridge/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -87,6 +87,7 @@
 
 # EBSA285 board in either host or addin mode
 config ARCH_EBSA285
+	select ARCH_MAY_HAVE_PC_FDC
 	bool
 
 endif
diff -urN RC13-git5-rio/arch/arm26/Kconfig RC13-git5-floppy/arch/arm26/Kconfig
--- RC13-git5-rio/arch/arm26/Kconfig	2005-08-28 23:09:39.000000000 -0400
+++ RC13-git5-floppy/arch/arm26/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -55,6 +55,10 @@
 config GENERIC_ISA_DMA
 	bool
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -urN RC13-git5-rio/arch/i386/Kconfig RC13-git5-floppy/arch/i386/Kconfig
--- RC13-git5-rio/arch/i386/Kconfig	2005-09-05 07:05:13.000000000 -0400
+++ RC13-git5-floppy/arch/i386/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -37,6 +37,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
diff -urN RC13-git5-rio/arch/m68k/Kconfig RC13-git5-floppy/arch/m68k/Kconfig
--- RC13-git5-rio/arch/m68k/Kconfig	2005-09-05 16:40:38.000000000 -0400
+++ RC13-git5-floppy/arch/m68k/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -25,6 +25,11 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	depends on Q40 || (BROKEN && SUN3X)
+	default y
+
 mainmenu "Linux/68k Kernel Configuration"
 
 source "init/Kconfig"
diff -urN RC13-git5-rio/arch/mips/Kconfig RC13-git5-floppy/arch/mips/Kconfig
--- RC13-git5-rio/arch/mips/Kconfig	2005-09-05 07:05:13.000000000 -0400
+++ RC13-git5-floppy/arch/mips/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -4,6 +4,11 @@
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 
+# shouldn't it be per-subarchitecture?
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 mainmenu "Linux/MIPS Kernel Configuration"
 
 source "init/Kconfig"
diff -urN RC13-git5-rio/arch/parisc/Kconfig RC13-git5-floppy/arch/parisc/Kconfig
--- RC13-git5-rio/arch/parisc/Kconfig	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-floppy/arch/parisc/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -49,6 +49,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -urN RC13-git5-rio/arch/ppc/Kconfig RC13-git5-floppy/arch/ppc/Kconfig
--- RC13-git5-rio/arch/ppc/Kconfig	2005-09-05 07:05:13.000000000 -0400
+++ RC13-git5-floppy/arch/ppc/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -47,6 +47,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor"
diff -urN RC13-git5-rio/arch/ppc64/Kconfig RC13-git5-floppy/arch/ppc64/Kconfig
--- RC13-git5-rio/arch/ppc64/Kconfig	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git5-floppy/arch/ppc64/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -44,6 +44,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 # We optimistically allocate largepages from the VM, so make the limit
 # large enough (16MB). This badly named config option is actually
 # max order + 1
diff -urN RC13-git5-rio/arch/sh/Kconfig RC13-git5-floppy/arch/sh/Kconfig
--- RC13-git5-rio/arch/sh/Kconfig	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-floppy/arch/sh/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -37,6 +37,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "System type"
diff -urN RC13-git5-rio/arch/sparc/Kconfig RC13-git5-floppy/arch/sparc/Kconfig
--- RC13-git5-rio/arch/sparc/Kconfig	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-floppy/arch/sparc/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -211,6 +211,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 config SUN_PM
 	bool
 	default y
diff -urN RC13-git5-rio/arch/sparc64/Kconfig RC13-git5-floppy/arch/sparc64/Kconfig
--- RC13-git5-rio/arch/sparc64/Kconfig	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git5-floppy/arch/sparc64/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -26,6 +26,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 choice
 	prompt "Kernel page size"
 	default SPARC64_PAGE_SIZE_8KB
diff -urN RC13-git5-rio/arch/x86_64/Kconfig RC13-git5-floppy/arch/x86_64/Kconfig
--- RC13-git5-rio/arch/x86_64/Kconfig	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git5-floppy/arch/x86_64/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -65,6 +65,10 @@
 	bool
 	default y
 
+config ARCH_MAY_HAVE_PC_FDC
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -urN RC13-git5-rio/drivers/block/Kconfig RC13-git5-floppy/drivers/block/Kconfig
--- RC13-git5-rio/drivers/block/Kconfig	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git5-floppy/drivers/block/Kconfig	2005-09-05 16:40:49.000000000 -0400
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64 && !UML && !ARM) || Q40 || (SUN3X && BROKEN) || ARCH_RPC || ARCH_EBSA285
+	depends on ARCH_MAY_HAVE_PC_FDC
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
