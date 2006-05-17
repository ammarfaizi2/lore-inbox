Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWEQAQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWEQAQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEQAQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11472 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932297AbWEQAPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:44 -0400
Date: Wed, 17 May 2006 02:15:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 05/50] genirq: cleanup: reduce irq_desc_t use, mark it obsolete
Message-ID: <20060517001530.GF12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

cleanup: remove irq_desc_t use from the generic IRQ code, and mark it
obsolete.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h    |   18 +++++++++++++-----
 kernel/irq/autoprobe.c |    6 +++---
 kernel/irq/handle.c    |    4 ++--
 kernel/irq/manage.c    |    6 +++---
 kernel/irq/migration.c |    4 ++--
 kernel/irq/spurious.c  |    9 +++++----
 6 files changed, 28 insertions(+), 19 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -68,7 +68,7 @@ typedef struct hw_interrupt_type  hw_irq
  *
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
-typedef struct irq_desc {
+struct irq_desc {
 	hw_irq_controller *handler;
 	void *handler_data;
 	struct irqaction *action;	/* IRQ action list */
@@ -83,11 +83,19 @@ typedef struct irq_desc {
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 	unsigned int move_irq;		/* Flag need to re-target intr dest*/
 #endif
-} ____cacheline_aligned irq_desc_t;
+} ____cacheline_aligned;
 
-extern irq_desc_t irq_desc [NR_IRQS];
+extern struct irq_desc irq_desc[NR_IRQS];
 
-#include <asm/hw_irq.h> /* the arch dependent stuff */
+/*
+ * Migration helpers for obsolete names, they will go away:
+ */
+typedef struct irq_desc		irq_desc_t;
+
+/*
+ * Pick up the arch-dependent methods:
+ */
+#include <asm/hw_irq.h>
 
 extern int setup_irq(unsigned int irq, struct irqaction *new);
 
@@ -181,7 +189,7 @@ extern int handle_IRQ_event(unsigned int
  */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 
-extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
+extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
Index: linux-genirq.q/kernel/irq/autoprobe.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/autoprobe.c
+++ linux-genirq.q/kernel/irq/autoprobe.c
@@ -27,8 +27,8 @@ static DECLARE_MUTEX(probe_sem);
  */
 unsigned long probe_irq_on(void)
 {
+	struct irq_desc *desc;
 	unsigned long mask;
-	irq_desc_t *desc;
 	unsigned int i;
 
 	down(&probe_sem);
@@ -116,7 +116,7 @@ unsigned int probe_irq_mask(unsigned lon
 
 	mask = 0;
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
+		struct irq_desc *desc = irq_desc + i;
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
@@ -159,7 +159,7 @@ int probe_irq_off(unsigned long val)
 	int i, irq_found = 0, nr_irqs = 0;
 
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
+		struct irq_desc *desc = irq_desc + i;
 		unsigned int status;
 
 		spin_lock_irq(&desc->lock);
Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -28,7 +28,7 @@
  *
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned = {
 	[0 ... NR_IRQS-1] = {
 		.status = IRQ_DISABLED,
 		.handler = &no_irq_type,
@@ -109,7 +109,7 @@ int handle_IRQ_event(unsigned int irq, s
  */
 fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 	struct irqaction *action;
 	unsigned int status;
 
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(synchronize_irq);
  */
 void disable_irq_nosync(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 
 	if (irq >= NR_IRQS)
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(disable_irq_nosync);
  */
 void disable_irq(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 
 	if (irq >= NR_IRQS)
 		return;
@@ -109,7 +109,7 @@ EXPORT_SYMBOL(disable_irq);
  */
 void enable_irq(unsigned int irq)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 
 	if (irq >= NR_IRQS)
Index: linux-genirq.q/kernel/irq/migration.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/migration.c
+++ linux-genirq.q/kernel/irq/migration.c
@@ -3,7 +3,7 @@
 
 void set_pending_irq(unsigned int irq, cpumask_t mask)
 {
-	irq_desc_t *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
@@ -14,8 +14,8 @@ void set_pending_irq(unsigned int irq, c
 
 void move_native_irq(int irq)
 {
+	struct irq_desc *desc = irq_desc + irq;
 	cpumask_t tmp;
-	irq_desc_t *desc = irq_desc + irq;
 
 	if (likely(!desc->move_irq))
 		return;
Index: linux-genirq.q/kernel/irq/spurious.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/spurious.c
+++ linux-genirq.q/kernel/irq/spurious.c
@@ -97,7 +97,8 @@ static int misrouted_irq(int irq, struct
  */
 
 static void
-__report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+__report_bad_irq(unsigned int irq, struct irq_desc *desc,
+		 irqreturn_t action_ret)
 {
 	struct irqaction *action;
 
@@ -122,7 +123,7 @@ __report_bad_irq(unsigned int irq, irq_d
 }
 
 static void
-report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+report_bad_irq(unsigned int irq, struct irq_desc *desc, irqreturn_t action_ret)
 {
 	static int count = 100;
 
@@ -132,8 +133,8 @@ report_bad_irq(unsigned int irq, irq_des
 	}
 }
 
-void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret,
-		    struct pt_regs *regs)
+void note_interrupt(unsigned int irq, struct irq_desc *desc,
+		    irqreturn_t action_ret, struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
