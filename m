Return-Path: <linux-kernel-owner+w=401wt.eu-S964769AbWLMOXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWLMOXX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLMOXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:23:23 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:55498 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964769AbWLMOXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:23:22 -0500
X-Greylist: delayed 1775 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:23:21 EST
Subject: [patch] Add allowed_affinity to the irq_desc to make it possible
	to have restricted irqs
From: Arjan van de Ven <arjan@linux.intel.com>
To: ebiederm@xmission.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Dec 2006 14:53:40 +0100
Message-Id: <1166018020.27217.805.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[due to a broken libata in current -git I've not been able to test this patch enough]


This patch adds an "allowed_affinity" mask to each interrupt, in addition to the 
existing actual affinity mask. In addition this new mask is exported to userspace
in a similar way as the actual affinity is exported. (this is so that irqbalance
can find out about the restriction and take it into account)

The purpose for having this mask is to allow for the situation where interrupts
just can't or shouldn't go to all cpus; one example is the "per cpu" IRQ thing 
that powerpc and others have. Another soon-to-come example is MSIX devices that 
can generate a different MSI interrupt for each cpu; in that case the MSI needs to
be strictly constrained to it's designated cpu.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 include/linux/irq.h |    2 ++
 kernel/irq/chip.c   |    1 +
 kernel/irq/handle.c |    3 ++-
 kernel/irq/manage.c |    5 ++++-
 kernel/irq/proc.c   |   27 +++++++++++++++++++++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/irq.h
===================================================================
--- linux-2.6.orig/include/linux/irq.h
+++ linux-2.6/include/linux/irq.h
@@ -137,6 +137,7 @@ struct irq_chip {
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @lock:		locking for SMP
  * @affinity:		IRQ affinity on SMP
+ * @allowed_affinity	The allowed affinity for this IRQ
  * @cpu:		cpu index useful for balancing
  * @pending_mask:	pending rebalanced interrupts
  * @dir:		/proc/irq/ procfs entry
@@ -160,6 +161,7 @@ struct irq_desc {
 	spinlock_t		lock;
 #ifdef CONFIG_SMP
 	cpumask_t		affinity;
+	cpumask_t		allowed_affinity;
 	unsigned int		cpu;
 #endif
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
Index: linux-2.6/kernel/irq/chip.c
===================================================================
--- linux-2.6.orig/kernel/irq/chip.c
+++ linux-2.6/kernel/irq/chip.c
@@ -46,6 +46,7 @@ void dynamic_irq_init(unsigned int irq)
 	desc->irqs_unhandled = 0;
 #ifdef CONFIG_SMP
 	desc->affinity = CPU_MASK_ALL;
+	desc->allowed_affinity = CPU_MASK_ALL;
 #endif
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
Index: linux-2.6/kernel/irq/handle.c
===================================================================
--- linux-2.6.orig/kernel/irq/handle.c
+++ linux-2.6/kernel/irq/handle.c
@@ -56,7 +56,8 @@ struct irq_desc irq_desc[NR_IRQS] __cach
 		.depth = 1,
 		.lock = __SPIN_LOCK_UNLOCKED(irq_desc->lock),
 #ifdef CONFIG_SMP
-		.affinity = CPU_MASK_ALL
+		.affinity = CPU_MASK_ALL,
+		.allowed_affinity = CPU_MASK_ALL
 #endif
 	}
 };
Index: linux-2.6/kernel/irq/manage.c
===================================================================
--- linux-2.6.orig/kernel/irq/manage.c
+++ linux-2.6/kernel/irq/manage.c
@@ -278,8 +278,13 @@ int setup_irq(unsigned int irq, struct i
 
 	*p = new;
 #if defined(CONFIG_IRQ_PER_CPU)
-	if (new->flags & IRQF_PERCPU)
+	if (new->flags & IRQF_PERCPU) {
 		desc->status |= IRQ_PER_CPU;
+		/* don't allow affinity to be set for per cpu interrupts */
+#ifdef CONFIG_SMP
+		desc->allowed_affinity = CPU_MASK_NONE;
+#endif
+	}
 #endif
 	if (!shared) {
 		irq_chip_set_defaults(desc->chip);
Index: linux-2.6/kernel/irq/proc.c
===================================================================
--- linux-2.6.orig/kernel/irq/proc.c
+++ linux-2.6/kernel/irq/proc.c
@@ -47,6 +47,20 @@ static int irq_affinity_read_proc(char *
 	return len;
 }
 
+
+static int irq_affinity_read_allowed_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, irq_desc[(long)data].allowed_affinity);
+
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+
+
 int no_irq_affinity;
 static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
 				   unsigned long count, void *data)
@@ -62,6 +76,9 @@ static int irq_affinity_write_proc(struc
 	if (err)
 		return err;
 
+	/* mask off the allowed_affinity mask to only leave legal cpus */
+	cpus_and(new_value, new_value, irq_desc[irq].allowed_affinity);
+
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
@@ -141,6 +158,16 @@ void register_irq_proc(unsigned int irq)
 			entry->read_proc = irq_affinity_read_proc;
 			entry->write_proc = irq_affinity_write_proc;
 		}
+
+		/* create /proc/irq/<irq>/smp_affinity */
+		entry = create_proc_entry("allowed_affinity", 0400, irq_desc[irq].dir);
+
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_affinity_read_allowed_proc;
+		}
+
 	}
 #endif
 }

