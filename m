Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbUKQEjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUKQEjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUKQEhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:37:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54539 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262212AbUKQEeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:34:50 -0500
Date: Wed, 17 Nov 2004 05:32:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] i386: always enable REGPARM
Message-ID: <20041117043223.GF4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there still a known reason to disable CONFIG_REGPARM on i386 with
gcc 3?

If not, I'd suggest the patch below for -mm to find all remaining bugs 
(if there are any).


diffstat output:
 arch/i386/Kconfig          |   13 -------------
 arch/i386/Makefile         |    2 +-
 include/asm-i386/linkage.h |    5 +----
 include/asm-i386/module.h  |    8 +-------
 4 files changed, 3 insertions(+), 25 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm1-full/arch/i386/Kconfig.old	2004-11-17 00:32:26.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/arch/i386/Kconfig	2004-11-17 00:32:50.000000000 +0100
@@ -876,19 +876,6 @@
 	depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA) || (X86 && EFI))
 	default y
 
-config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	default n
-	help
-	Compile the kernel with -mregparm=3. This uses an different ABI
-	and passes the first three arguments of a function call in registers.
-	This will probably break binary only modules.
-
-	This feature is only enabled for gcc-3.0 and later - earlier compilers
-	generate incorrect output with certain kernel constructs when
-	-mregparm=3 is used.
-
 source "drivers/perfctr/Kconfig"
 
 config KERN_PHYS_OFFSET
--- linux-2.6.10-rc2-mm1-full/arch/i386/Makefile.old	2004-11-17 00:33:00.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/arch/i386/Makefile	2004-11-17 00:33:39.000000000 +0100
@@ -55,7 +55,7 @@
 # -mregparm=3 works ok on gcc-3.0 and later
 #
 GCC_VERSION			:= $(call cc-version)
-cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
+cflags-y		 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
 # Disable unit-at-a-time mode, it makes gcc use a lot more stack
 # due to the lack of sharing of stacklots.
--- linux-2.6.10-rc2-mm1-full/include/asm-i386/linkage.h.old	2004-11-17 00:33:53.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/include/asm-i386/linkage.h	2004-11-17 00:34:09.000000000 +0100
@@ -4,10 +4,7 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #define fastcall	__attribute__((regparm(3)))
-
-#ifdef CONFIG_REGPARM
-# define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
-#endif
+#define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
--- linux-2.6.10-rc2-mm1-full/include/asm-i386/module.h.old	2004-11-17 00:34:17.000000000 +0100
+++ linux-2.6.10-rc2-mm1-full/include/asm-i386/module.h	2004-11-17 00:34:30.000000000 +0100
@@ -56,18 +56,12 @@
 #error unknown processor family
 #endif
 
-#ifdef CONFIG_REGPARM
-#define MODULE_REGPARM "REGPARM "
-#else
-#define MODULE_REGPARM ""
-#endif
-
 #ifdef CONFIG_4KSTACKS
 #define MODULE_STACKSIZE "4KSTACKS "
 #else
 #define MODULE_STACKSIZE ""
 #endif
 
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_STACKSIZE
 
 #endif /* _ASM_I386_MODULE_H */

