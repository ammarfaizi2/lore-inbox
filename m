Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWFTW2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWFTW2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWFTW2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:28:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50404 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751326AbWFTW2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:51 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/25] irq: Convert the move_irq flag from a 32bit word to a single bit
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:14 -0600
Message-Id: <11508425183073-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor space optimization.  In practice I don't think
this has any affect because of our alignment constraints and
the other fields but there is not point in chewing up an
uncessary word and since we already read the flag field
this should improve the cache hit ratio of the irq handler.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/irq.h    |    5 +++--
 kernel/irq/migration.c |    6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c684bab..1ad1acb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -45,6 +45,9 @@ #define IRQ_NOREQUEST	1024	/* IRQ cannot
 #define IRQ_NOAUTOEN	2048	/* IRQ will not be enabled on request irq */
 #define IRQ_DELAYED_DISABLE \
 			4096	/* IRQ disable (masking) happens delayed. */
+#if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
+# define IRQ_MOVE_PENDING 8192	/* need to re-target IRQ destination */
+#endif
 
 /*
  * IRQ types, see also include/linux/interrupt.h
@@ -130,7 +133,6 @@ #endif
  * @affinity:		IRQ affinity on SMP
  * @cpu:		cpu index useful for balancing
  * @pending_mask:	pending rebalanced interrupts
- * @move_irq:		need to re-target IRQ destination
  * @dir:		/proc/irq/ procfs entry
  * @affinity_entry:	/proc/irq/smp_affinity procfs entry on SMP
  *
@@ -156,7 +158,6 @@ #ifdef CONFIG_SMP
 #endif
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 	cpumask_t		pending_mask;
-	unsigned int		move_irq;	/* need to re-target IRQ dest */
 #endif
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *dir;
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index a57ebe9..9b234df 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -7,7 +7,7 @@ void set_pending_irq(unsigned int irq, c
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	desc->move_irq = 1;
+	desc->status |= IRQ_MOVE_PENDING;
 	irq_desc[irq].pending_mask = mask;
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
@@ -17,7 +17,7 @@ void move_native_irq(int irq)
 	struct irq_desc *desc = irq_desc + irq;
 	cpumask_t tmp;
 
-	if (likely(!desc->move_irq))
+	if (likely(!(desc->status & IRQ_MOVE_PENDING)))
 		return;
 
 	/*
@@ -28,7 +28,7 @@ void move_native_irq(int irq)
 		return;
 	}
 
-	desc->move_irq = 0;
+	desc->status &= ~IRQ_MOVE_PENDING;
 
 	if (unlikely(cpus_empty(irq_desc[irq].pending_mask)))
 		return;
-- 
1.4.0.gc07e

