Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTALSyn>; Sun, 12 Jan 2003 13:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267397AbTALSym>; Sun, 12 Jan 2003 13:54:42 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18951
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267396AbTALSyl>; Sun, 12 Jan 2003 13:54:41 -0500
Subject: [PATCH] add explicit Pentium II support
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: L.A.van.der.Duim@student.rug.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1042398209.834.59.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Jan 2003 14:03:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch breaks the "PPro/Celeron/Pentium-II" compile option into
separate "PPro" and "Pentium-II/Celeron" options.

This allows us to explicitly support the Pentium II and Celeron,
specifically adding the `-march' option for the chip and enabling the
unaligned copy optimizations.  PPro support remains unchanged.

This patch is by Luuk van der Duim with some changes by me (primarily to
also support the pre-Coppermine Celeron chips, since those use Pentium
II cores).  This patch has been in 2.5-mm for awhile and Andrew ack'ed
this submission.

Patch is against current BK.  Please, apply.

	Robert Love

 arch/i386/Kconfig  |   34 ++++++++++++++++++++++------------
 arch/i386/Makefile |    1 +
 2 files changed, 23 insertions(+), 12 deletions(-)


diff -urN linux-2.5.56/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2.5.56/arch/i386/Kconfig	2003-01-10 15:11:26.000000000 -0500
+++ linux/arch/i386/Kconfig	2003-01-12 13:55:01.000000000 -0500
@@ -117,9 +117,9 @@
 	  (time stamp counter) register.
 	  - "Pentium-Classic" for the Intel Pentium.
 	  - "Pentium-MMX" for the Intel Pentium MMX.
-	  - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
-	  - "Pentium-III" for the Intel Pentium III
-	  and Celerons based on the Coppermine core.
+	  - "Pentium-Pro" for the Intel Pentium Pro.
+	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
+	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
 	  - "Pentium-4" for the Intel Pentium 4.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
@@ -159,18 +159,28 @@
 	  extended instructions.
 
 config M686
-	bool "Pentium-Pro/Celeron/Pentium-II"
+	bool "Pentium-Pro"
 	help
-	  Select this for a Pro/Celeron/Pentium II.  This enables the use of
+	  Select this for Intel Pentium Pro chips.  This enables the use of
 	  Pentium Pro extended instructions, and disables the init-time guard
 	  against the f00f bug found in earlier Pentiums.
 
+config MPENTIUMII
+       bool "Pentium-II/Celeron(pre-Coppermine)"
+	help
+	  Select this for Intel chips based on the Pentium-II and
+	  pre-Coppermine Celeron core.  This option enables an unaligned
+	  copy optimization, compiles the kernel with optimization flags
+	  tailored for the chip, and applies any applicable Pentium Pro
+	  optimizations.
+
 config MPENTIUMIII
 	bool "Pentium-III/Celeron(Coppermine)"
 	help
 	  Select this for Intel chips based on the Pentium-III and
-	  Celeron-Coppermine core.  Enables use of some extended prefetch
-	  instructions, in addition to the Pentium II extensions.
+	  Celeron-Coppermine core.  This option enables use of some
+	  extended prefetch instructions in addition to the Pentium II
+	  extensions.
 
 config MPENTIUM4
 	bool "Pentium-4"
@@ -258,7 +268,7 @@
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || M686 || M586MMX || M586TSC || M586
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586
 	default "4" if MELAN || M486 || M386
 	default "6" if MK7 || MK8
 	default "7" if MPENTIUM4
@@ -310,22 +320,22 @@
 
 config X86_TSC
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC || MK8
+	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8
 	default y
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || M586MMX
+	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || MK8
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8
 	default y
 
 config X86_USE_3DNOW
diff -urN linux-2.5.56/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.5.56/arch/i386/Makefile	2003-01-10 15:11:44.000000000 -0500
+++ linux/arch/i386/Makefile	2003-01-12 13:53:46.000000000 -0500
@@ -34,6 +34,7 @@
 cflags-$(CONFIG_M586TSC)	+= -march=i586
 cflags-$(CONFIG_M586MMX)	+= $(call check_gcc,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)		+= -march=i686
+cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)



