Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUJQQJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUJQQJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJQQJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:09:42 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:60893 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S269175AbUJQQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:09:09 -0400
Subject: [PATCH 2/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - io_apic.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032561.3023.114.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:10:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk with pr_debug from kernel.h.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/io_apic.c	2004-10-17 16:57:00.352612336 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/io_apic.c	2004-10-17 17:01:21.672885616 +0200
@@ -20,6 +20,7 @@
  *	Paul Diefenbaugh	:	Added full ACPI support
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -246,14 +247,12 @@ static void set_ioapic_affinity_irq(unsi
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
+/* this may be useful while debugging
+ *
+ * #define pr_debug(x...) \
+ *	do { printk("<%ld:%s:%d>: ", jiffies, __FILE__, __LINE__); printk(x); } while (0)
+ */
 
 extern cpumask_t irq_affinity[NR_IRQS];
 
@@ -338,7 +337,7 @@ static inline void balance_irq(int cpu, 
 static inline void rotate_irqs_among_cpus(unsigned long useful_load_threshold)
 {
 	int i, j;
-	Dprintk("Rotating IRQs among CPUs.\n");
+	pr_debug("Rotating IRQs among CPUs.\n");
 	for (i = 0; i < NR_CPUS; i++) {
 		for (j = 0; cpu_online(i) && (j < NR_IRQS); j++) {
 			if (!irq_desc[j].action)
@@ -459,17 +458,17 @@ tryanothercpu:
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
 
@@ -529,7 +528,7 @@ tryanotherirq:
 		irq_desc_t *desc = irq_desc + selected_irq;
 		unsigned long flags;
 
-		Dprintk("irq = %d moved to cpu = %d\n",
+		pr_debug("irq = %d moved to cpu = %d\n",
 				selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock_irqsave(&desc->lock, flags);
@@ -552,7 +551,7 @@ not_worth_the_effort:
 	 */
 	balanced_irq_interval = min((long)MAX_BALANCED_IRQ_INTERVAL,
 		balanced_irq_interval + BALANCED_IRQ_MORE_DELTA);	
-	Dprintk("IRQ worth rotating not found\n");
+	pr_debug("IRQ worth rotating not found\n");
 	return;
 }
 


