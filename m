Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCHBlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCHBlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVCGWlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:41:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55542 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261822AbVCGVsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:13 -0500
Date: Mon, 7 Mar 2005 13:48:08 -0800
From: Frank Rowand <frowand@mvista.com>
Message-Id: <200503072148.j27Lm8wj006329@localhost.localdomain>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 5/5] ppc RT: smp405.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/arch/ppc/kernel/head_4xx.S
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/head_4xx.S
+++ linux-2.6.10/arch/ppc/kernel/head_4xx.S
@@ -1017,6 +1017,10 @@ _GLOBAL(set_context)
 					/* TLBs after changing PID */
 	blr
 
+/* needed to be able to compile with SMP enabled */
+_GLOBAL(__save_cpu_setup)
+	blr
+
 /* We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
  */
Index: linux-2.6.10/arch/ppc/mm/4xx_mmu.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/mm/4xx_mmu.c
+++ linux-2.6.10/arch/ppc/mm/4xx_mmu.c
@@ -53,6 +53,10 @@
 #include "mmu_decl.h"
 
 extern int __map_without_ltlbs;
+
+/* needed to be able to compile with SMP enabled */
+void hash_page_sync(void) {}
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
Index: linux-2.6.10/arch/ppc/platforms/4xx/walnut.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/4xx/walnut.c
+++ linux-2.6.10/arch/ppc/platforms/4xx/walnut.c
@@ -44,6 +44,50 @@ void *kb_cs;
 void *kb_data;
 void *walnut_rtc_base;
 
+
+#ifdef CONFIG_SMP
+static void
+walnut_message_pass(int target, int msg, unsigned long data, int wait)
+{
+}
+
+static int __init
+walnut_probe(void)
+{
+	return 1;
+}
+
+static void __init
+walnut_kick_cpu(int nr)
+{
+	printk("walnut_kick_cpu(): CPU released, waiting\n");
+}
+
+static void __init
+walnut_setup_cpu(int cpu_nr)
+{
+}
+
+static void __init
+walnut_take_timebase(void)
+{
+}
+
+static void __init
+walnut_give_timebase(void)
+{
+}
+
+static struct smp_ops_t walnut_smp_ops = {
+	.message_pass  = walnut_message_pass,
+	.probe         = walnut_probe,
+	.kick_cpu      = walnut_kick_cpu,
+	.setup_cpu     = walnut_setup_cpu,
+	.take_timebase = walnut_take_timebase,
+	.give_timebase = walnut_give_timebase,
+};
+#endif /* CONFIG_SMP */
+
 /* Some IRQs unique to Walnut.
  * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
  */
@@ -119,6 +163,10 @@ walnut_setup_arch(void)
 		  walnut_rtc_base, 8);
 	/* Identify the system */
 	printk("IBM Walnut port (C) 2000-2002 MontaVista Software, Inc. (source@mvista.com)\n");
+
+#ifdef CONFIG_SMP
+	ppc_md.smp_ops = &walnut_smp_ops;
+#endif
 }
 
 void __init
