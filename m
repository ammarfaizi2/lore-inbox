Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFGEig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 00:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTFGEig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 00:38:36 -0400
Received: from dp.samba.org ([66.70.73.150]:45753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262568AbTFGEib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 00:38:31 -0400
Date: Sat, 7 Jun 2003 14:48:03 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030607044803.GE28914@krispykreme>
References: <20030607040515.GB28914@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607040515.GB28914@krispykreme>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On ppc64 we can have lots of sparse irqs. At the moment we do a similar
thing to sparc64 and provide a mapping function into the NR_IRQS sized
array of irq descriptors.

At the moment we have NR_IRQS set at 512 which wastes a bit of memory on
small machines. We also risk running out of slots on larger machines.

We are hoping to kill irq_desc[NR_IRQS] completely and instead allocate
them on demand with some sort of hash to map an interrupt number to an
irq_desc. Im working on top of Andrey Panin's irq consolidation patches
in the hope that it goes in first and other architectures can benefit 
from these changes (I think SGI's ia64 boxes have similar issues as
well as large x86)

It looks like we can do this with only a few changes:

1. move the proc/affinity stuff into the irq_desc.
2. create a for_each_irq() macro for iterating through irqs

The consolidation patch already creates the third piece, a macro for
mapping from an interrupt number to an irq descriptor - irq_desc(IRQ)

Here is an untested, uncompiled, written on a plane patch that gives a
general idea of what I want. Any complaints?

Anton

--- include/linux/irq.h.orig	2003-06-06 03:50:25.000000000 +1000
+++ include/linux/irq.h	2003-06-06 04:00:18.000000000 +1000
@@ -56,12 +56,20 @@
  *
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
+struct proc_irq_dir;
+struct proc_smp_affinity_entry;
 typedef struct {
 	unsigned int status;		/* IRQ status */
 	hw_irq_controller *handler;
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
 	spinlock_t lock;
+	/* seldom used things at the end */
+	struct proc_dir_entry *proc_irq_dir;
+#ifdef CONFIG_SMP
+	struct proc_dir_entry *proc_smp_affinity_entry;
+	unsigned long irq_affinity;
+#endif
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
--- kernel/irq.c.orig	2003-06-06 03:13:29.000000000 +1000
+++ kernel/irq.c	2003-06-07 09:34:24.000000000 +1000
@@ -61,6 +61,8 @@
 	}
 };
 
+#define for_each_irq(IRQ) for (IRQ = 0; IRQ < NR_IRQS; IRQ++)
+
 #endif
 
 /*
@@ -484,7 +486,8 @@
 	 * something may have generated an irq long ago and we want to
 	 * flush such a longstanding irq before considering it as spurious. 
 	 */
-	for (i = NR_IRQS - 1; i > 0; i--)  {
+	/* XXX this used to walk through the irqs backwards */
+	for_each_irq(i) {
 		desc = irq_desc(i);
 
 		spin_lock_irq(&desc->lock);
@@ -502,7 +505,8 @@
 	 * (we must startup again here because if a longstanding irq
 	 * happened in the previous stage, it may have masked itself)
 	 */
-	for (i = NR_IRQS-1; i > 0; i--) {
+	/* XXX this used to walk through the irqs backwards */
+	for_each_irq(i) {
 		desc = irq_desc(i);
 
 		spin_lock_irq(&desc->lock);
@@ -524,7 +528,7 @@
 	 * Now filter out any obviously spurious interrupts
 	 */
 	val = 0;
-	for (i = 0; i < NR_IRQS; i++) {
+	for_each_irq(i) {
 		irq_desc_t *desc = irq_desc(i);
 		unsigned int status;
 
@@ -563,10 +567,11 @@
 {
 	int i;
 	unsigned int mask;
+	int irq;
 
 	mask = 0;
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc(i);
+	for_each_irq(irq) {
+		irq_desc_t *desc = irq_desc(irq);
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
@@ -609,7 +614,7 @@
 
 	nr_irqs = 0;
 	irq_found = 0;
-	for (i = 0; i < NR_IRQS; i++) {
+	for_each_irq(i) {
 		irq_desc_t *desc = irq_desc(i);
 		unsigned int status;
 
@@ -678,22 +683,23 @@
 #define MAX_NAMELEN 10
 
 struct proc_dir_entry *root_irq_dir;
-static struct proc_dir_entry *irq_dir[NR_IRQS];
 
 #ifdef CONFIG_SMP
-static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
-
-unsigned long irq_affinity[NR_IRQS] = { 
-	[0 ... NR_IRQS - 1] = ARCH_DEFAULT_IRQ_AFFINITY
-};
 
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 				  int count, int *eof, void *data)
 {
+	irq_desc_t *irq_desc;
+
 	if (count < ARCH_AFFINITY_WIDTH + 1)
 		return -EINVAL;
+
+	irq_desc = irq_desc((long)data);
+	if (!irq_desc)
+		return -EINVAL;
+
 	return sprintf (page, "%0" __stringify(ARCH_AFFINITY_WIDTH) "lx\n",
-			irq_affinity[(long)data]);
+			irq_desc->irq_affinity);
 }
 
 static int irq_affinity_write_proc(struct file *file, const char *buffer,
@@ -701,8 +707,13 @@
 {
 	int irq = (long) data, full_count = count, err;
 	unsigned long new_value;
+	irq_desc_t *irq_desc;
 
-	if (!irq_desc(irq)->handler->set_affinity)
+	irq_desc = irq_desc(irq);
+	if (!irq_desc)
+		return -EINVAL;
+
+	if (!irq_desc->handler->set_affinity)
 		return -EIO;
 
 	err = parse_hex_value(buffer, count, &new_value);
@@ -715,8 +726,8 @@
 	if (!(new_value & cpu_online_map))
 		return -EINVAL;
 
-	irq_affinity[irq] = new_value;
-	irq_desc(irq)->handler->set_affinity(irq, new_value);
+	irq_desc->irq_affinity = new_value;
+	irq_desc->handler->set_affinity(irq, new_value);
 
 	return full_count;
 }
@@ -727,21 +738,26 @@
 	char name[MAX_NAMELEN];
 
 	if (!root_irq_dir || (irq_desc(irq)->handler == &no_irq_type) ||
-			irq_dir[irq])
+			irq_desc(irq)->proc_irq_dir)
 		return;
 
 	memset(name, 0, MAX_NAMELEN);
 	sprintf(name, "%d", irq);
 
 	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
+	irq_desc(irq)->proc_irq_dir = proc_mkdir(name, root_irq_dir);
 
 #if CONFIG_SMP
 	if (irq_desc(irq)->handler->set_affinity) {
 		struct proc_dir_entry *entry;
 
+		/* give this irq a default affinity */
+		/* XXX does this clash with arch setting of affinity? */
+		irq_desc(irq)->smp_affinity = ARCH_DEFAULT_IRQ_AFFINITY;
+
 		/* create /proc/irq/1234/smp_affinity */
-		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
+		entry = create_proc_entry("smp_affinity", 0600, 
+					  irq_desc(irq)->proc_irq_dir);
 
 		if (entry) {
 			entry->nlink = 1;
@@ -750,7 +766,7 @@
 			entry->write_proc = irq_affinity_write_proc;
 		}
 
-		smp_affinity_entry[irq] = entry;
+		irq_desc(irq)->proc_smp_affinity_entry = entry;
 	}
 #endif
 }
@@ -811,7 +827,7 @@
 	 * Create entries for all existing IRQs.
 	 */
 	if (arch_can_create_irq_proc())
-		for (i = 0; irq_valid(i); i++)
+		for_each_irq(i) {
 			if (irq_desc(i)->handler != &no_irq_type)
 				register_irq_proc(i);
 }
