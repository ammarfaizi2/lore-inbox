Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTE0Kch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTE0Kch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:32:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:12438 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263205AbTE0Kcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:32:33 -0400
Date: Tue, 27 May 2003 03:45:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xirc2ps_cs irq return fix
Message-Id: <20030527034548.4aaae353.akpm@digeo.com>
In-Reply-To: <1054028411.18165.5.camel@dhcp22.swansea.linux.org.uk>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	<3ED16351.7060904@pobox.com>
	<Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
	<1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
	<3ED2E03E.80004@pobox.com>
	<20030526205548.4853c92b.akpm@digeo.com>
	<1054028411.18165.5.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 10:45:46.0865 (UTC) FILETIME=[21692610:01C3243D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2003-05-27 at 04:55, Andrew Morton wrote:
> > It should only be turned on for special situations, where someone is trying
> > to hunt down a reproducible lockup.  These are situations in which the odd
> > false positive just doesn't matter.  And we know that there will always
> > be false positives due to apic delivery latency (at least).
> > 
> > I think the time is right to do this.  Add CONFIG_DEBUG_IRQ and get on with
> > fixing real stuff.
> 
> I not 100% convinced. I think it should be left by default but only if you get
> something like a million unhandled interrupts in a row. Thats the "your box has died"
> case where the info is useful anyway.
> 
> Maybe the number in a row is what you want to tweak in config or /proc/sys ?
> 

Maybe.

The below patch has been in -mm for some time.  It was supposed to kill the
IRQ if 750 of the previous 1000 IRQs weren't handled.

I disabled the killing code because it was triggering on someone's
works-just-fine setup.

There will be pain involved in getting all this to work right.  Do you
really think there's much value in it?





Attempt to do something intelligent with IRQ handlers which don't return
IRQ_HANDLED.

- If they return neither IRQ_HANDLED nor IRQ_NONE, complain.

- If they return IRQ_NONE more than 750 times in 1000 interrupts, complain
  and disable the IRQ.



 arch/i386/kernel/irq.c |   96 +++++++++++++++++++++++++++++++++++--------------
 include/linux/irq.h    |    2 +
 2 files changed, 72 insertions(+), 26 deletions(-)

diff -puN arch/i386/kernel/irq.c~irq-check-rate-limit arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~irq-check-rate-limit	2003-05-08 00:27:15.000000000 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2003-05-08 00:27:32.000000000 -0700
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
@@ -222,30 +225,69 @@ int handle_IRQ_event(unsigned int irq,
 	if (status & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
-	if (retval != 1) {
-		static int count = 100;
-		if (count) {
-			count--;
-			if (retval) {
-				printk("irq event %d: bogus retval mask %x\n",
-					irq, retval);
-			} else {
-				printk("irq %d: nobody cared!\n", irq);
-			}
-			dump_stack();
-			printk("handlers:\n");
-			action = first_action;
-			do {
-				printk("[<%p>]", action->handler);
-				print_symbol(" (%s)",
-					(unsigned long)action->handler);
-				printk("\n");
-				action = action->next;
-			} while (action);
+	return retval;
+}
+
+static void report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	static int count = 100;
+	struct irqaction *action;
+
+	if (count) {
+		count--;
+		if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
+			printk("irq event %d: bogus return value %x\n",
+					irq, action_ret);
+		} else {
+			printk("irq %d: nobody cared!\n", irq);
 		}
+		dump_stack();
+		printk("handlers:\n");
+		action = desc->action;
+		do {
+			printk("[<%p>]", action->handler);
+			print_symbol(" (%s)",
+				(unsigned long)action->handler);
+			printk("\n");
+			action = action->next;
+		} while (action);
 	}
+}
 
-	return status;
+/*
+ * If 750 of the previous 1000 interrupts have not been handled then assume
+ * that the IRQ is stuck in some manner.  Drop a diagnostic and try to turn the
+ * IRQ off.
+ *
+ * Called under desc->lock
+ */
+static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	if (action_ret != IRQ_HANDLED) {
+		desc->irqs_unhandled++;
+		if (action_ret != IRQ_NONE)
+			report_bad_irq(irq, desc, action_ret);
+	}
+
+	desc->irq_count++;
+	if (desc->irq_count < 1000)
+		return;
+
+	desc->irq_count = 0;
+	if (desc->irqs_unhandled > 750) {
+		/*
+		 * The interrupt is stuck
+		 */
+		report_bad_irq(irq, desc, action_ret);
+		/*
+		 * Now kill the IRQ
+		 */
+#if 0
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+#endif
+	}
+	desc->irqs_unhandled = 0;
 }
 
 /*
@@ -418,10 +460,12 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * SMP environment.
 	 */
 	for (;;) {
+		irqreturn_t action_ret;
+
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		action_ret = handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
-		
+		note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
diff -puN include/linux/irq.h~irq-check-rate-limit include/linux/irq.h
--- 25/include/linux/irq.h~irq-check-rate-limit	2003-05-08 00:27:15.000000000 -0700
+++ 25-akpm/include/linux/irq.h	2003-05-08 00:27:15.000000000 -0700
@@ -61,6 +61,8 @@ typedef struct {
 	hw_irq_controller *handler;
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
+	unsigned int irq_count;		/* For detecting broken interrupts */
+	unsigned int irqs_unhandled;
 	spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 

_


