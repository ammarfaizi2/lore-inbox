Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUJRSpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUJRSpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUJRSnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:43:33 -0400
Received: from vsmtp1.tin.it ([212.216.176.141]:55994 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S267435AbUJRSlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:41:37 -0400
Subject: [PATCH] Substitute custom Dprintk macro with pr_debug - io_apic.c
From: Daniele Pizzoni <auouo@tin.it>
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098128326.3024.52.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 21:43:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substituted custom Dprintk macro with pr_debug
Removed stale CONFIG_BALANCED_IRQ_DEBUG ocurrence

Signed-off-by: Daniele Pizzoni

Index: linux-2.6.9-rc4/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/io_apic.c	2004-10-18 20:36:22.631099360 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/io_apic.c	2004-10-18 21:18:11.357714944 +0200
@@ -20,6 +20,8 @@
  *	Paul Diefenbaugh	:	Added full ACPI support
  */
 
+//#define DEBUG // pr_debug
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -246,14 +248,9 @@ static void set_ioapic_affinity_irq(unsi
 # include <linux/kernel_stat.h>	/* kstat */
 # include <linux/slab.h>		/* kmalloc() */
 # include <linux/timer.h>	/* time_after() */
- 
-# ifdef CONFIG_BALANCED_IRQ_DEBUG
-#  define TDprintk(x...) do { printk("<%ld:%s:%d>: ", jiffies, __FILE__, __LINE__); printk(x); } while (0)
-#  define Dprintk(x...) do { TDprintk(x); } while (0)
-# else
-#  define TDprintk(x...) 
-#  define Dprintk(x...) 
-# endif
+
+/* you may want to use this */
+/* #define pr_debug(x...) do { printk("<%ld:%s:%d>: ", jiffies, __FILE__, __LINE__); printk(x); } while (0) */
 
 extern cpumask_t irq_affinity[NR_IRQS];
 
@@ -338,7 +335,7 @@ static inline void balance_irq(int cpu, 
 static inline void rotate_irqs_among_cpus(unsigned long useful_load_threshold)
 {
 	int i, j;
-	Dprintk("Rotating IRQs among CPUs.\n");
+	pr_debug("Rotating IRQs among CPUs.\n");
 	for (i = 0; i < NR_CPUS; i++) {
 		for (j = 0; cpu_online(i) && (j < NR_IRQS); j++) {
 			if (!irq_desc[j].action)
@@ -459,17 +456,17 @@ tryanothercpu:
 	max_loaded = tmp_loaded;	/* processor */
 	imbalance = (max_cpu_irq - min_cpu_irq) / 2;
 	
-	Dprintk("max_loaded cpu = %d\n", max_loaded);
-	Dprintk("min_loaded cpu = %d\n", min_loaded);
-	Dprintk("max_cpu_irq load = %ld\n", max_cpu_irq);
-	Dprintk("min_cpu_irq load = %ld\n", min_cpu_irq);
-	Dprintk("load imbalance = %lu\n", imbalance);
+	pr_debug("max_loaded cpu = %d\n", max_loaded);
+	pr_debug("min_loaded cpu = %d\n", min_loaded);
+	pr_debug("max_cpu_irq load = %ld\n", max_cpu_irq);
+	pr_debug("min_cpu_irq load = %ld\n", min_cpu_irq);
+	pr_debug("load imbalance = %lu\n", imbalance);
 
 	/* if imbalance is less than approx 10% of max load, then
 	 * observe diminishing returns action. - quit
 	 */
 	if (imbalance < (max_cpu_irq >> 3)) {
-		Dprintk("Imbalance too trivial\n");
+		pr_debug("Imbalance too trivial\n");
 		goto not_worth_the_effort;
 	}
 
@@ -529,7 +526,7 @@ tryanotherirq:
 		irq_desc_t *desc = irq_desc + selected_irq;
 		unsigned long flags;
 
-		Dprintk("irq = %d moved to cpu = %d\n",
+		pr_debug("irq = %d moved to cpu = %d\n",
 				selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock_irqsave(&desc->lock, flags);
@@ -552,7 +549,7 @@ not_worth_the_effort:
 	 */
 	balanced_irq_interval = min((long)MAX_BALANCED_IRQ_INTERVAL,
 		balanced_irq_interval + BALANCED_IRQ_MORE_DELTA);	
-	Dprintk("IRQ worth rotating not found\n");
+	pr_debug("IRQ worth rotating not found\n");
 	return;
 }
 


