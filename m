Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934303AbWKZEbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934303AbWKZEbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 23:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935229AbWKZEbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 23:31:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2064 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S934303AbWKZEbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 23:31:21 -0500
Date: Sun, 26 Nov 2006 05:31:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] i386: always enable regparm
Message-ID: <20061126043125.GI15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mregparm=3 has been enabled by default for some time on i386, and AFAIK 
there aren't any problems with it left.

This patch removes the REGPARM config option and sets -mregparm=3 
unconditionally.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/stable_api_nonsense.txt |    3 ---
 arch/i386/Kconfig                     |   14 --------------
 arch/i386/Makefile                    |    4 +---
 include/asm-i386/module.h             |    8 +-------
 4 files changed, 2 insertions(+), 27 deletions(-)

--- linux-2.6.19-rc6-mm1/arch/i386/Kconfig.old	2006-11-26 02:32:46.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/i386/Kconfig	2006-11-26 02:32:55.000000000 +0100
@@ -740,20 +740,6 @@
 	depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA) || (X86 && EFI))
 	default y
 
-config REGPARM
-	bool "Use register arguments"
-	default y
-	help
-	Compile the kernel with -mregparm=3. This instructs gcc to use
-	a more efficient function call ABI which passes the first three
-	arguments of a function call via registers, which results in denser
-	and faster code.
-
-	If this option is disabled, then the default ABI of passing
-	arguments via the stack is used.
-
-	If unsure, say Y.
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
--- linux-2.6.19-rc6-mm1/arch/i386/Makefile.old	2006-11-26 02:33:02.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/i386/Makefile	2006-11-26 02:33:23.000000000 +0100
@@ -31,7 +31,7 @@
 endif
 CHECKFLAGS	+= -D__i386__
 
-CFLAGS += -pipe -msoft-float
+CFLAGS += -pipe -msoft-float -mregparm=3
 
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
@@ -39,8 +39,6 @@
 # CPU-specific tuning. Anything which can be shared with UML should go here.
 include $(srctree)/arch/i386/Makefile.cpu
 
-cflags-$(CONFIG_REGPARM) += -mregparm=3
-
 # temporary until string.h is fixed
 cflags-y += -ffreestanding
 
--- linux-2.6.19-rc6-mm1/include/asm-i386/module.h.old	2006-11-26 02:34:00.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/asm-i386/module.h	2006-11-26 02:34:12.000000000 +0100
@@ -60,18 +60,12 @@
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
--- linux-2.6.19-rc6-mm1/Documentation/stable_api_nonsense.txt.old	2006-11-26 02:34:38.000000000 +0100
+++ linux-2.6.19-rc6-mm1/Documentation/stable_api_nonsense.txt	2006-11-26 02:34:45.000000000 +0100
@@ -62,9 +62,6 @@
       - different structures can contain different fields
       - Some functions may not be implemented at all, (i.e. some locks
 	compile away to nothing for non-SMP builds.)
-      - Parameter passing of variables from function to function can be
-	done in different ways (the CONFIG_REGPARM option controls
-	this.)
       - Memory within the kernel can be aligned in different ways,
 	depending on the build options.
   - Linux runs on a wide range of different processor architectures.

