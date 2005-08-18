Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVHRQIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHRQIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHRQIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:08:11 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42430
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932276AbVHRQIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:08:10 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1124378663.23647.346.camel@tglx.tec.linutronix.de>
References: <20050818060126.GA13152@elte.hu>
	 <1124378663.23647.346.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 18 Aug 2005 18:08:35 +0200
Message-Id: <1124381316.23647.350.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 17:24 +0200, Thomas Gleixner wrote:

Oops, mailer madness.

tglx


diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt8/kernel/irq/handle.c linux-2.6.13-rc6-rt-debug/kernel/irq/handle.c
--- linux-2.6.13-rc6-rt8/kernel/irq/handle.c	2005-08-17 17:53:13.000000000 +0200
+++ linux-2.6.13-rc6-rt-debug/kernel/irq/handle.c	2005-08-18 16:32:54.000000000 +0200
@@ -171,7 +171,7 @@ fastcall notrace unsigned int __do_IRQ(u
 		 */
 		desc->handler->ack(irq);
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
-		end_irq(desc, irq);
+		desc->handler->end(irq);
 		return 1;
 	}
 
@@ -241,7 +241,7 @@ out:
 	 * The end-handler has to deal with interrupts which got
 	 * disabled while the handler was running:
 	 */
-	end_irq(desc, irq);
+	desc->handler->end(irq);
 out_no_end:
 	spin_unlock(&desc->lock);
 
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt8/kernel/irq/internals.h linux-2.6.13-rc6-rt-debug/kernel/irq/internals.h
--- linux-2.6.13-rc6-rt8/kernel/irq/internals.h	2005-08-17 17:53:13.000000000 +0200
+++ linux-2.6.13-rc6-rt-debug/kernel/irq/internals.h	2005-08-18 16:39:56.000000000 +0200
@@ -6,21 +6,6 @@ extern int noirqdebug;
 
 void recalculate_desc_flags(struct irq_desc *desc);
 
-/*
- * On PREEMPT_HARDIRQS, the ->ack handler masks interrupts, so that
- * they can be redirected to an IRQ thread, if needed. So here we
- * have to unmask the interrupt line, if needed:
- */
-static inline void end_irq(irq_desc_t *desc, unsigned int irq)
-{
-#ifdef CONFIG_PREEMPT_HARDIRQS
-	if (!(desc->status & IRQ_DISABLED))
-		desc->handler->enable(irq);
-#else
-	desc->handler->end(irq);
-#endif
-}
-
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq);
 extern void register_handler_proc(unsigned int irq, struct irqaction *action);
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt8/kernel/irq/manage.c linux-2.6.13-rc6-rt-debug/kernel/irq/manage.c
--- linux-2.6.13-rc6-rt8/kernel/irq/manage.c	2005-08-17 17:53:13.000000000 +0200
+++ linux-2.6.13-rc6-rt-debug/kernel/irq/manage.c	2005-08-18 16:31:46.000000000 +0200
@@ -442,7 +442,7 @@ static void do_hardirq(struct irq_desc *
 		 * The end-handler has to deal with interrupts which got
 		 * disabled while the handler was running:
 		 */
-		end_irq(desc, irq);
+		desc->handler->end(irq);
 	}
 	spin_unlock_irq(&desc->lock);
 


