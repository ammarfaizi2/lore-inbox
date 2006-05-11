Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWEKFln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWEKFln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWEKFlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 01:41:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:40171 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965125AbWEKFlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 01:41:42 -0400
Subject: [PATCH] PowerMac use of SA_CASCADEIRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1147325215.30380.45.camel@localhost.localdomain>
References: <1147325215.30380.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 May 2006 15:41:17 +1000
Message-Id: <1147326077.30380.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 15:26 +1000, Benjamin Herrenschmidt wrote:

> This patch is an implementation that was quickly tested on G5 (a second
> patch to use that for the G5 follows) and seems to work fine.

Here is the patch implementing that for the cascaced MPIC. Seems to work
fine here. (This is not useful on Quad G5s btw, only older ones really
use a cascade). This is more a test patch, not intended for merging.
I'll do a proper one if the support for SA_CASCADEIRQ goes in. There are
other issues with the way the PowerMac codes uses static irqaction
structures & directly calls setup_irq() in order to be able to install
irq actions before kmalloc is available. I want to make request_irq()
useable earlier instead, by having fallback on bootmem alloc, it make a
lot of sense for low level architecture interrupts that will never be
freed. I also noticed that the irq proc stuff has an issue with irqs
created before /proc is initialized, it will create the /proc/irq/* but
nothing below for existing actions. I'll look into fixing that as well.

Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2006-05-11 15:27:58.000000000 +1000
@@ -199,7 +199,7 @@ struct hw_interrupt_type gatwick_pic = {
 
 static irqreturn_t gatwick_action(int cpl, void *dev_id, struct pt_regs *regs)
 {
-	int irq, bits;
+	unsigned int irq, bits;
 
 	for (irq = max_irqs; (irq -= 32) >= max_real_irqs; ) {
 		int i = irq >> 5;
@@ -210,8 +210,7 @@ static irqreturn_t gatwick_action(int cp
 		if (bits == 0)
 			continue;
 		irq += __ilog2(bits);
-		__do_IRQ(irq, regs);
-		return IRQ_HANDLED;
+		return irq;
 	}
 	printk("gatwick irq not from gatwick pic\n");
 	return IRQ_NONE;
@@ -382,7 +381,7 @@ static struct irqaction xmon_action = {
 
 static struct irqaction gatwick_cascade_action = {
 	.handler	= gatwick_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= SA_CASCADEIRQ | SA_INTERRUPT,
 	.mask		= CPU_MASK_NONE,
 	.name		= "cascade",
 };
@@ -503,11 +502,6 @@ static void __init pmac_pic_probe_oldsty
 }
 #endif /* CONFIG_PPC32 */
 
-static int pmac_u3_cascade(struct pt_regs *regs, void *data)
-{
-	return mpic_get_one_irq((struct mpic *)data, regs);
-}
-
 static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
 {
 #if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
@@ -562,12 +556,28 @@ static struct mpic * __init pmac_setup_o
 	mpic_init(mpic);
 
 	return mpic;
- }
+}
+
+static irqreturn_t mpic_cascade(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int ret = mpic_get_one_irq(dev_id, regs);
+	if (unlikely(ret < 0))
+		return IRQ_NONE;
+	return ret;
+}
+
+static struct irqaction mpic_cascade_action = {
+	.handler	= mpic_cascade,
+	.flags		= SA_INTERRUPT | SA_CASCADEIRQ,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
 
 static int __init pmac_pic_probe_mpic(void)
 {
 	struct mpic *mpic1, *mpic2;
 	struct device_node *np, *master = NULL, *slave = NULL;
+	int rc;
 
 	/* We can have up to 2 MPICs cascaded */
 	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
@@ -613,7 +623,14 @@ static int __init pmac_pic_probe_mpic(vo
 		of_node_put(slave);
 		return 0;
 	}
-	mpic_setup_cascade(slave->intrs[0].line, pmac_u3_cascade, mpic2);
+
+	printk(KERN_DEBUG "Setting up MPIC 2 cascade on irq %d\n",
+	       slave->intrs[0].line);
+	mpic_cascade_action.dev_id = mpic2;
+	rc = setup_irq(slave->intrs[0].line, &mpic_cascade_action);
+	if (rc)
+		printk(KERN_DEBUG "Failed setting up MPIC 2 cascade on irq %d"
+		       " error %d\n", slave->intrs[0].line, rc);
 
 	of_node_put(slave);
 	return 0;
Index: linux-work/kernel/irq/proc.c
===================================================================
--- linux-work.orig/kernel/irq/proc.c	2006-01-14 14:43:37.000000000 +1100
+++ linux-work/kernel/irq/proc.c	2006-05-11 14:55:39.000000000 +1000
@@ -166,6 +166,8 @@ void init_irq_proc(void)
 
 	/*
 	 * Create entries for all existing IRQs.
+	 *
+	 * FIXME: Call register_handler_proc() for existing actions
 	 */
 	for (i = 0; i < NR_IRQS; i++)
 		register_irq_proc(i);

 


