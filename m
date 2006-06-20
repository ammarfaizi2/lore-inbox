Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWFTWfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWFTWfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWFTW25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:28:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51172 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751327AbWFTW2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 2/25] irq: Add moved_masked_irq
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:15 -0600
Message-Id: <11508425191381-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425183073-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently move_native_irq disables and renables the irq we are
migrating to ensure we don't take that irq when we are actually
doing the migration operation.  Disabling the irq needs to
happen but sometimes doing the work is move_native_irq is too late.

On x86 with ioapics the irq move sequences needs to be:
edge_triggered:
  mask irq.
  move irq.
  unmask irq.
  ack irq.
level_triggered:
  mask irq.
  ack irq.
  move irq.
  unmask irq.

We can esasily perform the edge triggered sequence, with the current
defintion of move_native_irq.  However the level triggered case does
not map well.  For that I have added move_masked_irq, to allow
me to disable the irqs around both the ack and the move.

Q: Why have we not seen this problem earlier?

A: The only symptom I have been able to reproduce is that if we change
   the vector before acknowleding an irq the wrong irq is acknowledged.
   Since we currently are not reprogramming the irq vector during
   migration no problems show up.

   We have to mask the irq before we acknowledge the irq or else we could
   hit a window where an irq is asserted just before we acknowledge it.

   Edge triggered irqs do not have this problem because acknowledgements
   do not propogate in the same way.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/irq.h    |    6 ++++++
 kernel/irq/migration.c |   28 +++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1ad1acb..b79d178 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -200,6 +200,7 @@ #if defined(CONFIG_GENERIC_PENDING_IRQ) 
 
 void set_pending_irq(unsigned int irq, cpumask_t mask);
 void move_native_irq(int irq);
+void move_masked_irq(int irq);
 
 #ifdef CONFIG_PCI_MSI
 /*
@@ -241,6 +242,10 @@ static inline void move_native_irq(int i
 {
 }
 
+static inline void move_masked_irq(int irq)
+{
+}
+
 static inline void set_pending_irq(unsigned int irq, cpumask_t mask)
 {
 }
@@ -256,6 +261,7 @@ #else /* CONFIG_SMP */
 
 #define move_irq(x)
 #define move_native_irq(x)
+#define move_masked_irq(x)
 
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 9b234df..4baa3bb 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -12,7 +12,7 @@ void set_pending_irq(unsigned int irq, c
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-void move_native_irq(int irq)
+void move_masked_irq(int irq)
 {
 	struct irq_desc *desc = irq_desc + irq;
 	cpumask_t tmp;
@@ -48,15 +48,29 @@ void move_native_irq(int irq)
 	 * when an active trigger is comming in. This could
 	 * cause some ioapics to mal-function.
 	 * Being paranoid i guess!
+	 *
+	 * For correct operation this depends on the caller
+	 * masking the irqs.
 	 */
 	if (likely(!cpus_empty(tmp))) {
-		if (likely(!(desc->status & IRQ_DISABLED)))
-			desc->chip->disable(irq);
-
 		desc->chip->set_affinity(irq,tmp);
-
-		if (likely(!(desc->status & IRQ_DISABLED)))
-			desc->chip->enable(irq);
 	}
 	cpus_clear(irq_desc[irq].pending_mask);
 }
+
+void move_native_irq(int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (likely(!(desc->status & IRQ_MOVE_PENDING)))
+		return;
+
+	if (likely(!(desc->status & IRQ_DISABLED)))
+		desc->chip->disable(irq);
+
+	move_masked_irq(irq);
+
+	if (likely(!(desc->status & IRQ_DISABLED)))
+		desc->chip->enable(irq);
+}
+
-- 
1.4.0.gc07e

