Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUAYVzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUAYVyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:54:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50927 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265271AbUAYVwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:52:19 -0500
Date: Sun, 25 Jan 2004 22:52:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [1/3] Pentium M: fix brown paperbag bug
Message-ID: <20040125215211.GQ513@fs.tum.de>
References: <20040125214530.GN513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125214530.GN513@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I said in the description that MPENTIUMM gets a bigger 
X86_L1_CACHE_SHIFT, but I only gave it X86_L1_CACHE_SHIFT=5 .

Where's a brown paperbag?


add Pentium M and Pentium-4 M options:

- add MPENTIUMM (equivalent to PENTIUMIII except for a bigger
  X86_L1_CACHE_SHIFT)

- document that MPENTIUM4 is the right choice for a Pentium-4 M


diffstat output:

 arch/i386/Kconfig         |   28 +++++++++++++++++-----------
 arch/i386/Makefile        |    1 +
 include/asm-i386/module.h |    2 ++
 3 files changed, 20 insertions(+), 11 deletions(-)



diff -puN arch/i386/Makefile~pentium-m-support arch/i386/Makefile
--- 25/arch/i386/Makefile~pentium-m-support	Mon Jan 12 15:52:42 2004
+++ 25-akpm/arch/i386/Makefile	Mon Jan 12 15:52:42 2004
@@ -34,6 +34,7 @@ cflags-$(CONFIG_M586MMX)	+= $(call check
 cflags-$(CONFIG_M686)		+= -march=i686
 cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
diff -puN include/asm-i386/module.h~pentium-m-support include/asm-i386/module.h
--- 25/include/asm-i386/module.h~pentium-m-support	Mon Jan 12 15:52:42 2004
+++ 25-akpm/include/asm-i386/module.h	Mon Jan 12 15:52:42 2004
@@ -26,6 +26,8 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "PENTIUMII "
 #elif defined CONFIG_MPENTIUMIII
 #define MODULE_PROC_FAMILY "PENTIUMIII "
+#elif defined CONFIG_MPENTIUMM
+#define MODULE_PROC_FAMILY "PENTIUMM "
 #elif defined CONFIG_MPENTIUM4
 #define MODULE_PROC_FAMILY "PENTIUM4 "
 #elif defined CONFIG_MK6
--- linux-2.6.2-rc1-mm3/arch/i386/Kconfig.old	2004-01-25 17:49:55.000000000 +0100
+++ linux-2.6.2-rc1-mm3/arch/i386/Kconfig	2004-01-25 17:57:05.000000000 +0100
@@ -222,14 +222,20 @@
 	  extended prefetch instructions in addition to the Pentium II
 	  extensions.
 
+config MPENTIUMM
+	bool "Pentium M"
+	help
+	  Select this for Intel Pentium M (not Pentium-4 M)
+	  notebook chips.
+
 config MPENTIUM4
-	bool "Pentium-4/Celeron(P4-based)/Xeon"
+	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
 	help
-	  Select this for Intel Pentium 4 chips.  This includes both
-	  the Pentium 4 and P4-based Celeron chips.  This option
-	  enables compile flags optimized for the chip, uses the
-	  correct cache shift, and applies any applicable Pentium III
-	  optimizations.
+	  Select this for Intel Pentium 4 chips.  This includes the
+	  Pentium 4, P4-based Celeron and Xeon, and Pentium-4 M
+	  (not Pentium M) chips.  This option enables compile flags
+	  optimized for the chip, uses the correct cache shift, and
+	  applies any applicable Pentium III optimizations.
 
 config MK6
 	bool "K6/K6-II/K6-III"
@@ -330,7 +336,7 @@
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8
+	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
@@ -379,17 +385,17 @@
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
 	default y
 
 config X86_USE_3DNOW
@@ -571,7 +577,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE
