Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUADOoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUADOoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:44:13 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54707 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265604AbUADOoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:44:05 -0500
Date: Sun, 4 Jan 2004 15:43:50 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104144350.GD24913@louise.pinerecords.com>
References: <200401041410.i04EA61e007769@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401041410.i04EA61e007769@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-04 2004, Sun, 15:10 +0100
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> On Date: Sun, 4 Jan 2004 13:33:58 +0100, Tomas Szepe wrote:
> > > IOW, don't lie to the compiler and pretend P-M == P4
> > > with that -march=pentium4.
> > 
> > What do you recommend to use as march then?  There is
> > no pentiumm subarch support in gcc yet;  I was convinced
> > p4 was the closest match.
> 
> march=pentium3 is the closest safe choice, at least
> until gcc implements P-M specific support.

Thanks, here's the updated patch.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-01-04 03:10:01.000000000 +0100
+++ b/arch/i386/Kconfig	2004-01-04 03:06:09.000000000 +0100
@@ -231,6 +231,13 @@
 	  correct cache shift, and applies any applicable Pentium III
 	  optimizations.
 
+config MPENTIUMM
+	bool "Pentium M (Banias/Centrino)"
+	help
+	  Select this for Intel Pentium M chips.  This option enables
+	  compile flags optimized for the chip, uses the correct cache
+	  shift, and applies any applicable Pentium III/IV optimizations.
+
 config MK6
 	bool "K6/K6-II/K6-III"
 	help
@@ -330,7 +337,7 @@
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8
+	default "6" if MPENTIUMM || MK7 || MK8
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
@@ -379,17 +386,17 @@
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
 	default y
 
 config X86_USE_3DNOW
@@ -512,7 +519,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE
diff -urN a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2003-09-28 11:38:05.000000000 +0200
+++ b/arch/i386/Makefile	2004-01-04 03:02:52.000000000 +0100
@@ -35,6 +35,7 @@
 cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
diff -urN a/include/asm-i386/module.h b/include/asm-i386/module.h
--- a/include/asm-i386/module.h	2003-08-23 01:52:22.000000000 +0200
+++ b/include/asm-i386/module.h	2004-01-04 03:08:17.000000000 +0100
@@ -28,6 +28,8 @@
 #define MODULE_PROC_FAMILY "PENTIUMIII "
 #elif defined CONFIG_MPENTIUM4
 #define MODULE_PROC_FAMILY "PENTIUM4 "
+#elif defined CONFIG_MPENTIUMM
+#define MODULE_PROC_FAMILY "PENTIUMM "
 #elif defined CONFIG_MK6
 #define MODULE_PROC_FAMILY "K6 "
 #elif defined CONFIG_MK7
