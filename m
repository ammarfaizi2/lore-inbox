Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWEQAPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWEQAPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWEQAPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:15:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40604 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751007AbWEQAPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:06 -0400
Date: Wed, 17 May 2006 02:14:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 02/50] genirq: cleanup: remove irq_descp()
Message-ID: <20060517001457.GC12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

cleanup: remove irq_descp() - explicit use of irq_desc[] is shorter and
more readable.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/ia64/hp/sim/hpsim_irq.c |    2 +-
 arch/ia64/kernel/iosapic.c   |   14 +++++++-------
 arch/ia64/kernel/irq.c       |    2 +-
 arch/ia64/kernel/irq_ia64.c  |    2 +-
 arch/ia64/kernel/mca.c       |    2 +-
 arch/ia64/kernel/smpboot.c   |    2 +-
 include/linux/irq.h          |    7 -------
 kernel/irq/migration.c       |    2 +-
 8 files changed, 13 insertions(+), 20 deletions(-)

Index: linux-genirq.q/arch/ia64/hp/sim/hpsim_irq.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/hp/sim/hpsim_irq.c
+++ linux-genirq.q/arch/ia64/hp/sim/hpsim_irq.c
@@ -44,7 +44,7 @@ hpsim_irq_init (void)
 	int i;
 
 	for (i = 0; i < NR_IRQS; ++i) {
-		idesc = irq_descp(i);
+		idesc = irq_desc + i;
 		if (idesc->handler == &no_irq_type)
 			idesc->handler = &irq_type_hp_sim;
 	}
Index: linux-genirq.q/arch/ia64/kernel/iosapic.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/iosapic.c
+++ linux-genirq.q/arch/ia64/kernel/iosapic.c
@@ -456,7 +456,7 @@ iosapic_startup_edge_irq (unsigned int i
 static void
 iosapic_ack_edge_irq (unsigned int irq)
 {
-	irq_desc_t *idesc = irq_descp(irq);
+	irq_desc_t *idesc = irq_desc + irq;
 
 	move_irq(irq);
 	/*
@@ -659,7 +659,7 @@ register_intr (unsigned int gsi, int vec
 	else
 		irq_type = &irq_type_iosapic_level;
 
-	idesc = irq_descp(vector);
+	idesc = irq_desc + vector;
 	if (idesc->handler != irq_type) {
 		if (idesc->handler != &no_irq_type)
 			printk(KERN_WARNING
@@ -793,14 +793,14 @@ again:
 			return -ENOSPC;
 	}
 
-	spin_lock_irqsave(&irq_descp(vector)->lock, flags);
+	spin_lock_irqsave(&irq_desc[vector].lock, flags);
 	spin_lock(&iosapic_lock);
 	{
 		if (gsi_to_vector(gsi) > 0) {
 			if (list_empty(&iosapic_intr_info[vector].rtes))
 				free_irq_vector(vector);
 			spin_unlock(&iosapic_lock);
-			spin_unlock_irqrestore(&irq_descp(vector)->lock,
+			spin_unlock_irqrestore(&irq_desc[vector].lock,
 					       flags);
 			goto again;
 		}
@@ -810,7 +810,7 @@ again:
 			      polarity, trigger);
 		if (err < 0) {
 			spin_unlock(&iosapic_lock);
-			spin_unlock_irqrestore(&irq_descp(vector)->lock,
+			spin_unlock_irqrestore(&irq_desc[vector].lock,
 					       flags);
 			return err;
 		}
@@ -825,7 +825,7 @@ again:
 		set_rte(gsi, vector, dest, mask);
 	}
 	spin_unlock(&iosapic_lock);
-	spin_unlock_irqrestore(&irq_descp(vector)->lock, flags);
+	spin_unlock_irqrestore(&irq_desc[vector].lock, flags);
 
 	printk(KERN_INFO "GSI %u (%s, %s) -> CPU %d (0x%04x) vector %d\n",
 	       gsi, (trigger == IOSAPIC_EDGE ? "edge" : "level"),
@@ -860,7 +860,7 @@ iosapic_unregister_intr (unsigned int gs
 	}
 	vector = irq_to_vector(irq);
 
-	idesc = irq_descp(irq);
+	idesc = irq_desc + irq;
 	spin_lock_irqsave(&idesc->lock, flags);
 	spin_lock(&iosapic_lock);
 	{
Index: linux-genirq.q/arch/ia64/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/irq.c
+++ linux-genirq.q/arch/ia64/kernel/irq.c
@@ -121,7 +121,7 @@ static void migrate_irqs(void)
 	int 		irq, new_cpu;
 
 	for (irq=0; irq < NR_IRQS; irq++) {
-		desc = irq_descp(irq);
+		desc = irq_desc + irq;
 
 		/*
 		 * No handling for now.
Index: linux-genirq.q/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/irq_ia64.c
+++ linux-genirq.q/arch/ia64/kernel/irq_ia64.c
@@ -232,7 +232,7 @@ register_percpu_irq (ia64_vector vec, st
 
 	for (irq = 0; irq < NR_IRQS; ++irq)
 		if (irq_to_vector(irq) == vec) {
-			desc = irq_descp(irq);
+			desc = irq_desc + irq;
 			desc->status |= IRQ_PER_CPU;
 			desc->handler = &irq_type_ia64_lsapic;
 			if (action)
Index: linux-genirq.q/arch/ia64/kernel/mca.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/mca.c
+++ linux-genirq.q/arch/ia64/kernel/mca.c
@@ -1788,7 +1788,7 @@ ia64_mca_late_init(void)
 			cpe_poll_enabled = 0;
 			for (irq = 0; irq < NR_IRQS; ++irq)
 				if (irq_to_vector(irq) == cpe_vector) {
-					desc = irq_descp(irq);
+					desc = irq_desc + irq;
 					desc->status |= IRQ_PER_CPU;
 					setup_irq(irq, &mca_cpe_irqaction);
 					ia64_cpe_irq = irq;
Index: linux-genirq.q/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/smpboot.c
+++ linux-genirq.q/arch/ia64/kernel/smpboot.c
@@ -677,7 +677,7 @@ int migrate_platform_irqs(unsigned int c
 			new_cpei_cpu = any_online_cpu(cpu_online_map);
 			mask = cpumask_of_cpu(new_cpei_cpu);
 			set_cpei_target_cpu(new_cpei_cpu);
-			desc = irq_descp(ia64_cpe_irq);
+			desc = irq_desc + ia64_cpe_irq;
 			/*
 			 * Switch for now, immediatly, we need to do fake intr
 			 * as other interrupts, but need to study CPEI behaviour with
Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -87,13 +87,6 @@ typedef struct irq_desc {
 
 extern irq_desc_t irq_desc [NR_IRQS];
 
-/* Return a pointer to the irq descriptor for IRQ.  */
-static inline irq_desc_t *
-irq_descp (int irq)
-{
-	return irq_desc + irq;
-}
-
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 extern int setup_irq(unsigned int irq, struct irqaction * new);
Index: linux-genirq.q/kernel/irq/migration.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/migration.c
+++ linux-genirq.q/kernel/irq/migration.c
@@ -15,7 +15,7 @@ void set_pending_irq(unsigned int irq, c
 void move_native_irq(int irq)
 {
 	cpumask_t tmp;
-	irq_desc_t *desc = irq_descp(irq);
+	irq_desc_t *desc = irq_desc + irq;
 
 	if (likely(!desc->move_irq))
 		return;
