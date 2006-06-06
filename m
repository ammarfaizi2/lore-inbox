Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750841AbWFFDuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFFDuJ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFFDuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:50:09 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:21461 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750841AbWFFDuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:50:07 -0400
Subject: [RFC][PATCH -mm] postpone misrouted irqs when disabled
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060604214448.GA6602@elte.hu>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
	 <1149456532.29652.29.camel@localhost.localdomain>
	 <20060604214448.GA6602@elte.hu>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:49:42 -0400
Message-Id: <1149565782.16247.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 23:44 +0200, Ingo Molnar wrote:

> pretty much the only correct solution seems to be to go with Arjan's 
> suggestion and make the 'disabled' property per-action, instead of the 
> current per-desc thing. (obviously the physical act of masking an 
> interrupt line is fundamentally per-desc, but the act of running an 
> action "behind the back" of a masked line is still OK.) Unfortunately 
> this would also mean the manual conversion of 300+ places that use 
> disable_irq()/enable_irq() currently ... so it's no small work. (and the 
> hardest part of the work is to find a safe method to convert them 
> without introducing bugs)

OK, I got some time to play.

This is what I was talking about before.  Here I honour the IRQ_DISABLED
in misrouted_irq, but I have some accounting that will not enable the
irq on exit of the interrupt handler if the misrouted irq encountered a
disabled interrupt.  What happens is that the IRQ stays masked until who
ever disabled the irq enables it.

On enable_irq a check is made and if a misrouted irq was done while the
irq was disabled, it then calls the interrupt handler, and checks to see
if it should unmask the irq in question.

Disclaimer: I did this patch in between compiles of doing real work, so
it is really a big hack.  But it helps to explain what I'm getting at.
BTW, my machine with the vortex card deadlocks without this patch
(happens in the disabled_irq with spin_lock-irqs-enabled section).  But
with this patch it actual runs, and I put in my internal logging to see
if the disable_irq + misrouted_irq that deadlocks normal happens.  It
did happen and the machine kept on going :)

And Ingo, this was inspired by the way -rt does hard irq threading.
That is to keep the irq unmasked until the thread takes care of it.
That's all, I wasn't suggesting that we add irq threads here.

Another positive with this approach: you don't need to update 300+ calls
to disable_irq and enable_irq and make sure they are right.

This patch goes against -mm3 + the patch I sent earlier to fix the
desc->chip->end() bug.

-- Steve

(Signing off, but this isn't a real patch - needs more work)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.17-rc5-mm3/include/linux/irq.h
===================================================================
--- linux-2.6.17-rc5-mm3.orig/include/linux/irq.h	2006-06-05 17:26:15.000000000 -0400
+++ linux-2.6.17-rc5-mm3/include/linux/irq.h	2006-06-05 23:08:07.000000000 -0400
@@ -165,6 +165,8 @@ struct irq_desc {
 
 extern struct irq_desc irq_desc[NR_IRQS];
 
+extern void misroute_enable_irq(unsigned int irq, struct irq_desc *desc);
+
 /*
  * Migration helpers for obsolete names, they will go away:
  */
@@ -332,8 +334,8 @@ static inline void generic_handle_irq(un
 }
 
 /* Handling of unhandled and spurious interrupts: */
-extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
-			   int action_ret, struct pt_regs *regs);
+extern int note_interrupt(unsigned int irq, struct irq_desc *desc,
+			  int action_ret, struct pt_regs *regs);
 
 /* Resending of interrupts :*/
 void check_irq_resend(struct irq_desc *desc, unsigned int irq);
Index: linux-2.6.17-rc5-mm3/kernel/irq/handle.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/irq/handle.c	2006-06-05 22:34:55.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/irq/handle.c	2006-06-05 23:07:33.000000000 -0400
@@ -153,6 +153,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 	struct irq_desc *desc = irq_desc + irq;
 	struct irqaction *action;
 	unsigned int status;
+	int misrouted_pending = 0;
 
 	spin_lock(&sdr_lock);
 	if (!irq) {
@@ -237,19 +238,23 @@ fastcall unsigned int __do_IRQ(unsigned 
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret, regs);
+			misrouted_pending = note_interrupt(irq, desc, action_ret, regs);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
+		if (unlikely(misrouted_pending))
+			break;
 		desc->status &= ~IRQ_PENDING;
 	}
 	desc->status &= ~IRQ_INPROGRESS;
 
 out:
-	/*
-	 * The ->end() handler has to deal with interrupts which got
-	 * disabled while the handler was running.
-	 */
-	desc->chip->end(irq);
+	if (likely(!misrouted_pending)) {
+		/*
+		 * The ->end() handler has to deal with interrupts which got
+		 * disabled while the handler was running.
+		 */
+		desc->chip->end(irq);
+	}
 	spin_unlock(&desc->lock);
 
 	return 1;
Index: linux-2.6.17-rc5-mm3/kernel/irq/manage.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/irq/manage.c	2006-06-05 17:26:15.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/irq/manage.c	2006-06-05 23:05:24.000000000 -0400
@@ -123,6 +123,16 @@ void enable_irq(unsigned int irq)
 
 		/* Prevent probing on this irq: */
 		desc->status = status | IRQ_NOPROBE;
+		/*
+		 * Here we check to see if we need to handle
+		 * a misrouted irq, and we were disabled when
+		 * it happened.
+		 * Really, the check_irq_resend could handle this
+		 * but that code is dependent on the chip having
+		 * a retrigger operation and the misrouted irq
+		 * can't depend on that.
+		 */
+		misroute_enable_irq(irq, desc);
 		check_irq_resend(desc, irq);
 		/* fall-through */
 	}
Index: linux-2.6.17-rc5-mm3/kernel/irq/spurious.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/irq/spurious.c	2006-06-05 19:53:27.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/irq/spurious.c	2006-06-05 23:29:42.000000000 -0400
@@ -10,15 +10,20 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
+#include <linux/bitops.h>
 
 static int irqfixup __read_mostly;
 
+DEFINE_SPINLOCK(misroute_lock);
+DECLARE_BITMAP(misroute_irq_disabled, NR_IRQS);
+DECLARE_BITMAP(misroute_irq_pending, NR_IRQS);
+
 /*
  * Recovery handler for misrouted interrupts.
  */
 static int misrouted_irq(int irq, struct pt_regs *regs)
 {
-	int i, ok = 0, work = 0;
+	int i, ok = 0, work = 0, disabled = 0;
 
 	for (i = 1; i < NR_IRQS; i++) {
 		struct irq_desc *desc = irq_desc + i;
@@ -39,8 +44,28 @@ static int misrouted_irq(int irq, struct
 			spin_unlock(&desc->lock);
 			continue;
 		}
+		/* Honour disable irq */
+		if (desc->status & IRQ_DISABLED) {
+			/*
+			 * Disabled: We set the pending bit to let the
+			 * enabled_irq know that it should check to
+			 * run again, and that we might not have unmasked
+			 * the interrupt yet.
+			 */
+			if (desc->action && (desc->action->flags & SA_SHIRQ)) {
+				desc->status |= IRQ_PENDING;
+				spin_lock(&misroute_lock);
+				__set_bit(i, misroute_irq_disabled);
+				spin_unlock(&misroute_lock);
+				disabled = 1;
+			}
+			spin_unlock(&desc->lock);
+			continue;
+		}
+
 		/* Honour the normal IRQ locking */
 		desc->status |= IRQ_INPROGRESS;
+
 		action = desc->action;
 		spin_unlock(&desc->lock);
 
@@ -133,9 +158,12 @@ report_bad_irq(unsigned int irq, struct 
 	}
 }
 
-void note_interrupt(unsigned int irq, struct irq_desc *desc,
-		    irqreturn_t action_ret, struct pt_regs *regs)
+int note_interrupt(unsigned int irq, struct irq_desc *desc,
+		   irqreturn_t action_ret, struct pt_regs *regs)
 {
+	int ok = -1;
+	int ret = 0;
+
 	if (unlikely(action_ret != IRQ_HANDLED)) {
 		desc->irqs_unhandled++;
 		if (unlikely(action_ret != IRQ_NONE))
@@ -145,15 +173,26 @@ void note_interrupt(unsigned int irq, st
 	if (unlikely(irqfixup)) {
 		/* Don't punish working computers */
 		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
-			int ok = misrouted_irq(irq, regs);
+			ok = misrouted_irq(irq, regs);
 			if (action_ret == IRQ_NONE)
 				desc->irqs_unhandled -= ok;
 		}
 	}
 
 	desc->irq_count++;
+	spin_lock(&misroute_lock);
+	/*
+	 * If we didn't handle an interrupt, and we have disabled
+	 * interrupts, then don't unmask this when we leave
+	 * the interrupt handler.
+	 */
+	if (!ok && find_first_bit(misroute_irq_disabled, NR_IRQS) != NR_IRQS) {
+		__set_bit(irq, misroute_irq_pending);
+		ret = 1;
+	}
+	spin_unlock(&misroute_lock);
 	if (likely(desc->irq_count < 100000))
-		return;
+		return ret;
 
 	desc->irq_count = 0;
 	if (unlikely(desc->irqs_unhandled > 99900)) {
@@ -170,6 +209,114 @@ void note_interrupt(unsigned int irq, st
 		desc->chip->disable(irq);
 	}
 	desc->irqs_unhandled = 0;
+	return ret;
+}
+
+/*
+ * When called, the desc->lock is held.
+ */
+void misroute_enable_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct irqaction *action;
+	int ok = 0;
+	int i;
+
+	/*
+	 * Perhaps a new flag would be good so that systems
+	 * without misroute irq enabled would skip this every time.
+	 */
+	if ((desc->status & IRQ_PENDING) == 0)
+		return;
+
+	spin_lock(&misroute_lock);
+	if (!test_and_clear_bit(irq, misroute_irq_disabled)) {
+		spin_unlock(&misroute_lock);
+		return;
+	}
+
+	spin_unlock(&misroute_lock);
+
+	/*
+	 * Run our handler.  This really needs to be wrapped up
+	 * in another function.
+	 */
+	desc->status |= IRQ_INPROGRESS;
+	desc->status &= ~IRQ_PENDING;
+
+	action = desc->action;
+	spin_unlock(&desc->lock);
+
+	while (action) {
+		/* Only shared IRQ handlers are safe to call */
+		if (action->flags & SA_SHIRQ) {
+			/*
+			 * Really no handler looks at regs.
+			 */
+			if (action->handler(irq, action->dev_id, NULL) ==
+			    IRQ_HANDLED)
+				ok = 1;
+		}
+		action = action->next;
+	}
+	/* Now clean up the flags */
+	spin_lock(&desc->lock);
+	action = desc->action;
+
+	/*
+	 * While we were looking for a fixup someone queued a real
+	 * IRQ clashing with our walk:
+	 */
+	while ((desc->status & IRQ_PENDING) && action) {
+		/*
+		 * Perform real IRQ processing for the IRQ we deferred
+		 */
+		ok = 1;
+		spin_unlock(&desc->lock);
+		handle_IRQ_event(irq, NULL, action);
+		spin_lock(&desc->lock);
+		desc->status &= ~IRQ_PENDING;
+	}
+	desc->status &= ~IRQ_INPROGRESS;
+	spin_unlock(&desc->lock);
+
+	spin_lock(&misroute_lock);
+	/*
+	 * If we did something or there are no more misrouted irqs then
+	 * unmask all the irqs that were waiting on us.
+	 */
+	while ((i = find_first_bit(misroute_irq_pending, NR_IRQS)) != NR_IRQS) {
+		struct irq_desc *d = irq_desc + i;
+		int m;
+
+		spin_unlock(&misroute_lock);
+
+		spin_lock(&d->lock);
+		spin_lock(&misroute_lock);
+		/*
+		 * Need to make sure that we suddenly didn't have another misroute.
+		 */
+		if ((m=find_first_bit(misroute_irq_disabled, NR_IRQS)) != NR_IRQS) {
+			spin_unlock(&d->lock);
+			break;
+		}
+
+		if (desc->chip && desc->chip->end)
+			desc->chip->end(i);
+		clear_bit(i, misroute_irq_pending);
+		spin_lock(&misroute_lock);
+		spin_unlock(&d->lock);
+	}
+	{
+		static int once;
+		if (!once) {
+			once = 1;
+			LOGDUMP();
+		}
+	}
+	spin_unlock(&misroute_lock);
+
+	/* leave as we came */
+	spin_lock(&desc->lock);
 }
 
 int noirqdebug __read_mostly;


