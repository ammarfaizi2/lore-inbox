Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVCNIpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVCNIpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVCNIpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:45:38 -0500
Received: from ozlabs.org ([203.10.76.45]:19593 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262066AbVCNIod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:44:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.20257.750890.165845@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 19:45:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Arnd Bergmann <arnd@arndb.de>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Make RTAS code usable on non-pSeries machines
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Arnd Bergmann <arndb@de.ibm.com>.

RTAS is not actually pSeries specific, but some PPC64 code that relies
on RTAS is currently protected by CONFIG_PPC_PSERIES.
This introduces a generic configuration option PPC_RTAS that can be used
by other subarchitectures as well. The existing option with the same
name is renamed to the more specific RTAS_PROC.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/Kconfig test/arch/ppc64/Kconfig
--- linux-2.5/arch/ppc64/Kconfig	2005-03-14 08:25:07.000000000 +1100
+++ test/arch/ppc64/Kconfig	2005-03-14 19:31:22.000000000 +1100
@@ -255,16 +255,21 @@
 
 
 config PPC_RTAS
-	bool "Proc interface to RTAS"
+	bool
 	depends on PPC_PSERIES
+	default y
+
+config RTAS_PROC
+	bool "Proc interface to RTAS"
+	depends on PPC_RTAS
 
 config RTAS_FLASH
 	tristate "Firmware flash interface"
-	depends on PPC_RTAS
+	depends on RTAS_PROC
 
 config SCANLOG
 	tristate "Scanlog dump interface"
-	depends on PPC_RTAS
+	depends on RTAS_PROC && PPC_PSERIES
 
 config LPARCFG
 	tristate "LPAR Configuration Data"
diff -urN linux-2.5/arch/ppc64/kernel/Makefile test/arch/ppc64/kernel/Makefile
--- linux-2.5/arch/ppc64/kernel/Makefile	2005-03-07 08:21:53.000000000 +1100
+++ test/arch/ppc64/kernel/Makefile	2005-03-14 19:31:22.000000000 +1100
@@ -39,7 +39,7 @@
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
-obj-$(CONFIG_PPC_RTAS)		+= rtas-proc.o
+obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
 obj-$(CONFIG_SCANLOG)		+= scanlog.o
 obj-$(CONFIG_VIOPATH)		+= viopath.o
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
diff -urN linux-2.5/arch/ppc64/kernel/entry.S test/arch/ppc64/kernel/entry.S
--- linux-2.5/arch/ppc64/kernel/entry.S	2005-02-07 07:55:28.000000000 +1100
+++ test/arch/ppc64/kernel/entry.S	2005-03-14 19:31:22.000000000 +1100
@@ -616,7 +616,7 @@
 	bl	.unrecoverable_exception
 	b	unrecov_restore
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_RTAS
 /*
  * On CHRP, the Run-Time Abstraction Services (RTAS) have to be
  * called with the MMU off.
@@ -753,7 +753,7 @@
 	mtlr    r0
         blr				/* return to caller */
 
-#endif /* CONFIG_PPC_PSERIES */
+#endif /* CONFIG_PPC_RTAS */
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 
diff -urN linux-2.5/arch/ppc64/kernel/misc.S test/arch/ppc64/kernel/misc.S
--- linux-2.5/arch/ppc64/kernel/misc.S	2005-03-14 08:25:07.000000000 +1100
+++ test/arch/ppc64/kernel/misc.S	2005-03-14 19:31:22.000000000 +1100
@@ -680,7 +680,7 @@
 	ld	r30,-16(r1)
 	blr
 
-#ifndef CONFIG_PPC_PSERIES	/* hack hack hack */
+#ifdef CONFIG_PPC_RTAS /* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
 #endif
 
diff -urN linux-2.5/arch/ppc64/kernel/prom.c test/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2005-03-10 09:14:12.000000000 +1100
+++ test/arch/ppc64/kernel/prom.c	2005-03-14 19:31:22.000000000 +1100
@@ -894,7 +894,7 @@
 	if (get_flat_dt_prop(node, "linux,iommu-force-on", NULL) != NULL)
 		iommu_force_on = 1;
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_RTAS
 	/* To help early debugging via the front panel, we retreive a minimal
 	 * set of RTAS infos now if available
 	 */
@@ -910,7 +910,7 @@
 			rtas.size = *prop;
 		}
 	}
-#endif /* CONFIG_PPC_PSERIES */
+#endif /* CONFIG_PPC_RTAS */
 
 	/* break now */
 	return 1;
diff -urN linux-2.5/arch/ppc64/kernel/rtc.c test/arch/ppc64/kernel/rtc.c
--- linux-2.5/arch/ppc64/kernel/rtc.c	2004-11-17 09:38:21.000000000 +1100
+++ test/arch/ppc64/kernel/rtc.c	2005-03-14 19:31:22.000000000 +1100
@@ -337,7 +337,7 @@
 }
 #endif
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_RTAS
 #define MAX_RTC_WAIT 5000	/* 5 sec */
 #define RTAS_CLOCK_BUSY (-2)
 void pSeries_get_boot_time(struct rtc_time *rtc_tm)
diff -urN linux-2.5/arch/ppc64/kernel/setup.c test/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2005-03-07 08:21:53.000000000 +1100
+++ test/arch/ppc64/kernel/setup.c	2005-03-14 19:31:22.000000000 +1100
@@ -605,12 +605,12 @@
 	 */
 	initialize_cache_info();
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_RTAS
 	/*
 	 * Initialize RTAS if available
 	 */
 	rtas_initialize();
-#endif /* CONFIG_PPC_PSERIES */
+#endif /* CONFIG_PPC_RTAS */
 
 	/*
 	 * Check if we have an initrd provided via the device-tree
diff -urN linux-2.5/arch/ppc64/oprofile/op_model_power4.c test/arch/ppc64/oprofile/op_model_power4.c
--- linux-2.5/arch/ppc64/oprofile/op_model_power4.c	2005-03-07 08:21:53.000000000 +1100
+++ test/arch/ppc64/oprofile/op_model_power4.c	2005-03-14 19:31:22.000000000 +1100
@@ -224,7 +224,7 @@
 	if (mmcra & MMCRA_SIPR)
 		return pc;
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_RTAS
 	/* Were we in RTAS? */
 	if (pc >= rtas.base && pc < (rtas.base + rtas.size))
 		/* function descriptor madness */
