Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755377AbWKNIQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377AbWKNIQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbWKNIQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:16:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12932 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755377AbWKNIQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:16:06 -0500
Subject: [patch] irq: do not mask interrupts by default
From: Ingo Molnar <mingo@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	 <1162985578.8335.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <7813413.118221162987983254.komurojun-mbn@nifty.com>
	 <11940937.327381163162570124.komurojun-mbn@nifty.com>
	 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	 <m13b8ns24j.fsf@ebiederm.dsl.xmission.com> <1163450677.7473.86.camel@earth>
	 <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 09:14:00 +0100
Message-Id: <1163492040.28401.76.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 14:11 -0700, Eric W. Biederman wrote:
> -       else
> +       else {
> +               irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
>                 set_irq_chip_and_handler_name(irq, &ioapic_chip,
>                                               handle_edge_irq,
> "edge");
> +       }
>  } 

yeah. Komuro, could you try my patch below - Eric's patch only updates
x86_64 while your failure was on the i386 kernel.

Note, i also took another approach to fix this problem, that should
cover both the case found by Komuro, and some other cases as well. The
theory is this:

1) disable_irq() is relatively rare (used in about 10% of drivers, but
there it's overwhelmingly used in some slowpath) so it's performance
uncritical.

2) missing an IRQ while the line is masked is often a lethal regression
to the user. An IRQ could be missed even if we think that the IRQ line
is 'level-triggered'.

so my patch changes the default irq-disable logic of /all/ controllers
to "delayed disable". (IRQ chips can still override this by providing a
different chip->disable method that just clones their ->mask method, if
it is absolutely sure that no IRQs can be lost while masked)

So this patch has the worst-case effect of getting at most one 'extra'
interrupt after the IRQ line has been 'disabled' - at which point the
line will be masked for real (by the flow handler). (I updated the
fasteoi and the simple irq flow handlers to mask the IRQ for real if an
IRQ triggers and the line was disabled.)

It's a bit late in the -rc cycle for a change like this, but i'm fairly
positive about it. I booted it on a couple of boxes and saw no badness.
(neither did i see any increase in IRQ rates)

	Ingo

NOTE: this also means that the old IRQ_DELAYED_DISABLE bit can probably
be scrapped - i'll do that later on in a separate mail, if this patch
works out fine.

------------>
Subject: irq: do not mask interrupts by default
From: Ingo Molnar <mingo@elte.hu>

never mask interrupts immediately upon request. Disabling
interrupts in high-performance codepaths is rare, and on
the other hand this change could recover lost edges (or
even other types of lost interrupts) by conservatively
only masking interrupts after they happen. (NOTE: with
this change the highlevel irq-disable code still soft-disables
this IRQ line - and if such an interrupt happens then the
IRQ flow handler keeps the IRQ masked.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/chip.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -202,10 +202,6 @@ static void default_enable(unsigned int 
  */
 static void default_disable(unsigned int irq)
 {
-	struct irq_desc *desc = irq_desc + irq;
-
-	if (!(desc->status & IRQ_DELAYED_DISABLE))
-		desc->chip->mask(irq);
 }
 
 /*
@@ -272,8 +268,11 @@ handle_simple_irq(unsigned int irq, stru
 	kstat_cpu(cpu).irqs[irq]++;
 
 	action = desc->action;
-	if (unlikely(!action || (desc->status & IRQ_DISABLED)))
+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
 		goto out_unlock;
+	}
 
 	desc->status |= IRQ_INPROGRESS;
 	spin_unlock(&desc->lock);
@@ -366,11 +365,13 @@ handle_fasteoi_irq(unsigned int irq, str
 
 	/*
 	 * If its disabled or no action available
-	 * keep it masked and get out of here
+	 * then mask it and get out of here:
 	 */
 	action = desc->action;
 	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
 		desc->status |= IRQ_PENDING;
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
 		goto out;
 	}
 


