Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTEFPDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTEFPDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:03:08 -0400
Received: from [12.47.58.20] ([12.47.58.20]:19759 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263781AbTEFPDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:03:01 -0400
Date: Tue, 6 May 2003 08:17:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: shrybman@sympatico.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
Message-Id: <20030506081716.60de29d1.akpm@digeo.com>
In-Reply-To: <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
References: <1052141029.2527.27.camel@mars.goatskin.org>
	<20030505143006.29c0301a.akpm@digeo.com>
	<1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 15:15:26.0483 (UTC) FILETIME=[528A2E30:01C313E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>  With APIC at least it doesnt suprise me the least. The IRQ hack seems
>  extremely racey.

Good point.  How about we do something like "if half of the past 1000
interrupts weren't handled then try to kill the IRQ"?



 arch/i386/kernel/irq.c |   55 +++++++++++++++++++++++++++++++++++++++----------
 include/linux/irq.h    |    2 +
 2 files changed, 46 insertions(+), 11 deletions(-)

diff -puN arch/i386/kernel/irq.c~irq-check-rate-limit arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~irq-check-rate-limit	2003-05-06 07:54:17.000000000 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2003-05-06 08:16:15.000000000 -0700
@@ -66,8 +66,12 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
-	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+	[0 ... NR_IRQS-1] = {
+		.handler = &no_irq_type,
+		.lock = SPIN_LOCK_UNLOCKED
+	}
+};
 
 static void register_irq_proc (unsigned int irq);
 
@@ -209,7 +213,6 @@ int handle_IRQ_event(unsigned int irq,
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
 	int retval = 0;
-	struct irqaction *first_action = action;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
@@ -222,19 +225,43 @@ int handle_IRQ_event(unsigned int irq,
 	if (status & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
-	if (retval != 1) {
+	return status;
+}
+
+/*
+ * If 500 of the previous 1000 interrupts have not been handled then assume
+ * that the IRQ is stuck in some manner.  Drop a diagnostic and try to turn the
+ * IRQ off.
+ *
+ * Called under desc->lock
+ */
+static void note_interrupt(irq_desc_t *desc, int irq, int status)
+{
+	if (status != IRQ_HANDLED)
+		desc->irqs_unhandled++;
+	desc->irq_count++;
+	if (desc->irq_count < 1000)
+		return;
+
+	desc->irq_count = 0;
+	if (desc->irqs_unhandled > 500) {
+		/*
+		 * The interrupt is stuck
+		 */
 		static int count = 100;
+		struct irqaction *action;
+
 		if (count) {
 			count--;
-			if (retval) {
+			if (status) {
 				printk("irq event %d: bogus retval mask %x\n",
-					irq, retval);
+					irq, status);
 			} else {
 				printk("irq %d: nobody cared!\n", irq);
 			}
 			dump_stack();
 			printk("handlers:\n");
-			action = first_action;
+			action = desc->action;
 			do {
 				printk("[<%p>]", action->handler);
 				print_symbol(" (%s)",
@@ -243,9 +270,13 @@ int handle_IRQ_event(unsigned int irq,
 				action = action->next;
 			} while (action);
 		}
+		/*
+		 * Now kill the IRQ
+		 */
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
 	}
-
-	return status;
+	desc->irqs_unhandled = 0;
 }
 
 /*
@@ -418,10 +449,12 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * SMP environment.
 	 */
 	for (;;) {
+		int status;
+
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		status = handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
-		
+		note_interrupt(desc, irq, status);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
diff -puN include/linux/irq.h~irq-check-rate-limit include/linux/irq.h
--- 25/include/linux/irq.h~irq-check-rate-limit	2003-05-06 07:56:03.000000000 -0700
+++ 25-akpm/include/linux/irq.h	2003-05-06 08:05:17.000000000 -0700
@@ -61,6 +61,8 @@ typedef struct {
 	hw_irq_controller *handler;
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
+	unsigned int irq_count;		/* For detecting broken interrupts */
+	unsigned int irqs_unhandled;
 	spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 

_

