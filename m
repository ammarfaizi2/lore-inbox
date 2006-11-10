Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946659AbWKJOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946659AbWKJOAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946671AbWKJOAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:00:31 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:1643 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946659AbWKJOAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:00:30 -0500
Message-ID: <455484E4.1020100@openvz.org>
Date: Fri, 10 Nov 2006 16:55:48 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kirill Korotaev <dev@openvz.org>
Subject: [RFC] [PATCH] Fix misrouted interrupts deadlocks
Content-Type: multipart/mixed;
 boundary="------------010901050609000904010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901050609000904010605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

While testing kernel on machine with "irqpoll" option
I've caught such a lockup:

	__do_IRQ()
	   spin_lock(&desc->lock);
           desc->chip->ack(); /* IRQ is ACKed */
	note_interrupt()
	misrouted_irq()
	handle_IRQ_event()
           if (...)
	      local_irq_enable_in_hardirq();
	/* interrupts are enabled from now */
	...
	__do_IRQ() /* same IRQ we've started from */
	   spin_lock(&desc->lock); /* LOCKUP */

Looking at misrouted_irq() code I've found that a potential
deadlock like this can also take place:

1CPU:
__do_IRQ()
   spin_lock(&desc->lock); /* irq = A */
misrouted_irq()
   for (i = 1; i < NR_IRQS; i++) {
      spin_lock(&desc->lock); /* irq = B */
      if (desc->status & IRQ_INPROGRESS) {

2CPU:
__do_IRQ()
   spin_lock(&desc->lock); /* irq = B */
misrouted_irq()
   for (i = 1; i < NR_IRQS; i++) {
      spin_lock(&desc->lock); /* irq = A */
      if (desc->status & IRQ_INPROGRESS) {

As the second lock on booth CPUs is taken before checking that
this irq is being handled in another processor this may cause
a deadlock. This issue is only theoretical.

I propose the attached patch to fix booth problems: when trying
to handle misrouted IRQ active desc->lock may be unlocked.

Please comment.

--------------010901050609000904010605
Content-Type: text/plain;
 name="diff-misrouted-irq-lockup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-misrouted-irq-lockup"

--- ./kernel/irq/spurious.c.irqlockup	2006-11-09 11:19:10.000000000 +0300
+++ ./kernel/irq/spurious.c	2006-11-10 16:53:38.000000000 +0300
@@ -147,7 +147,11 @@ void note_interrupt(unsigned int irq, st
 	if (unlikely(irqfixup)) {
 		/* Don't punish working computers */
 		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
-			int ok = misrouted_irq(irq);
+			int ok;
+
+			spin_unlock(&desc->lock);
+			ok = misrouted_irq(irq);
+			spin_lock(&desc->lock);
 			if (action_ret == IRQ_NONE)
 				desc->irqs_unhandled -= ok;
 		}

--------------010901050609000904010605--
