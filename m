Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEFG2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEFG2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 02:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEFG2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 02:28:31 -0400
Received: from ozlabs.org ([203.10.76.45]:5853 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261155AbVEFG2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 02:28:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17019.3752.917407.742713@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 16:28:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org, miltonm@bga.com,
       sharada@in.ibm.com
Subject: [PATCH] ppc64: global interrupt queue cleanup
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code to set global interrupt queue membership to xics.c,
and remove no longer needed extern declarations.  Also call it on
all cpus (even the boot cpu) to prepare for kexec.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: R Sharada <sharada@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc64/kernel/pSeries_smp.c test/arch/ppc64/kernel/pSeries_smp.c
--- linux-2.6/arch/ppc64/kernel/pSeries_smp.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc64/kernel/pSeries_smp.c	2005-05-06 15:23:05.000000000 +1000
@@ -326,13 +326,6 @@
 
 	cpu_clear(cpu, of_spin_map);
 
-	/*
-	 * Put the calling processor into the GIQ.  This is really only
-	 * necessary from a secondary thread as the OF start-cpu interface
-	 * performs this function for us on primary threads.
-	 */
-	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
 }
 
 static DEFINE_SPINLOCK(timebase_lock);
diff -urN linux-2.6/arch/ppc64/kernel/xics.c test/arch/ppc64/kernel/xics.c
--- linux-2.6/arch/ppc64/kernel/xics.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc64/kernel/xics.c	2005-05-06 15:23:05.000000000 +1000
@@ -432,6 +432,7 @@
 {
 	ops->qirr_info(cpu, IPI_PRIORITY);
 }
+#endif /* CONFIG_SMP */
 
 void xics_setup_cpu(void)
 {
@@ -439,9 +440,17 @@
 
 	ops->cppr_info(cpu, 0xff);
 	iosync();
-}
 
-#endif /* CONFIG_SMP */
+	/*
+	 * Put the calling processor into the GIQ.  This is really only
+	 * necessary from a secondary thread as the OF start-cpu interface
+	 * performs this function for us on primary threads.
+	 *
+	 * XXX: undo of teardown on kexec needs this too, as may hotplug
+	 */
+	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
+}
 
 void xics_init_IRQ(void)
 {
@@ -563,8 +572,7 @@
 	for (; i < NR_IRQS; ++i)
 		get_irq_desc(i)->handler = &xics_pic;
 
-	ops->cppr_info(boot_cpuid, 0xff);
-	iosync();
+	xics_setup_cpu();
 
 	ppc64_boot_msg(0x21, "XICS Done");
 }
diff -urN linux-2.6/include/asm-ppc64/xics.h test/include/asm-ppc64/xics.h
--- linux-2.6/include/asm-ppc64/xics.h	2005-04-26 15:38:02.000000000 +1000
+++ test/include/asm-ppc64/xics.h	2005-05-06 15:23:05.000000000 +1000
@@ -30,7 +30,4 @@
 
 extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
 
-extern unsigned int default_distrib_server;
-extern unsigned int interrupt_server_size;
-
 #endif /* _PPC64_KERNEL_XICS_H */
