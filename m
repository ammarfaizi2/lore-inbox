Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030736AbWKUIxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbWKUIxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030737AbWKUIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:53:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:47977 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030736AbWKUIxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:53:03 -0500
Message-ID: <4562BD4E.20600@openvz.org>
Date: Tue, 21 Nov 2006 11:48:14 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@in.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>
Subject: [RFC][PATCH] Fix locking on misrouted interrupts
Content-Type: multipart/mixed;
 boundary="------------080709080502010506090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709080502010506090302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vivek noted that many places call note_interrupt()
without desc->lock being held. Since note_interrupt()
which tries to unlock this lock to handle spurious
interrupts accodring to
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f72fa707604c015a6625e80f269506032d5430dc

Looking at note_interrupt() I found that desc->lock
IS required in this function but all the places that
call note_interrupt() lock it after the call. One
exception from this rule is __do_IRQ().

So I move spin_lock(&desc->lock); before calling
note_interrupt() in all places.

Signed-off-bt: Pavel Emelianov <xemul@openvz.org>

--------------080709080502010506090302
Content-Type: text/plain;
 name="diff-note-interrupt-locking-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-note-interrupt-locking-fix"

--- ./kernel/irq/chip.c.noteintfix	2006-11-21 11:27:18.000000000 +0300
+++ ./kernel/irq/chip.c	2006-11-21 11:48:18.000000000 +0300
@@ -281,10 +281,11 @@ handle_simple_irq(unsigned int irq, stru
 	spin_unlock(&desc->lock);
 
 	action_ret = handle_IRQ_event(irq, action);
+
+	spin_lock(&desc->lock);
 	if (!noirqdebug)
 		note_interrupt(irq, desc, action_ret);
 
-	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 out_unlock:
 	spin_unlock(&desc->lock);
@@ -330,10 +331,11 @@ handle_level_irq(unsigned int irq, struc
 	spin_unlock(&desc->lock);
 
 	action_ret = handle_IRQ_event(irq, action);
+
+	spin_lock(&desc->lock);
 	if (!noirqdebug)
 		note_interrupt(irq, desc, action_ret);
 
-	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
 		desc->chip->unmask(irq);
@@ -381,10 +383,11 @@ handle_fasteoi_irq(unsigned int irq, str
 	spin_unlock(&desc->lock);
 
 	action_ret = handle_IRQ_event(irq, action);
+
+	spin_lock(&desc->lock);
 	if (!noirqdebug)
 		note_interrupt(irq, desc, action_ret);
 
-	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
 out:
 	desc->chip->eoi(irq);
@@ -460,10 +463,12 @@ handle_edge_irq(unsigned int irq, struct
 
 		desc->status &= ~IRQ_PENDING;
 		spin_unlock(&desc->lock);
+
 		action_ret = handle_IRQ_event(irq, action);
+
+		spin_lock(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
-		spin_lock(&desc->lock);
 
 	} while ((desc->status & (IRQ_PENDING | IRQ_DISABLED)) == IRQ_PENDING);
 
@@ -483,6 +488,7 @@ out_unlock:
 void fastcall
 handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
 {
+	unsigned long flags;
 	irqreturn_t action_ret;
 
 	kstat_this_cpu.irqs[irq]++;
@@ -491,8 +497,11 @@ handle_percpu_irq(unsigned int irq, stru
 		desc->chip->ack(irq);
 
 	action_ret = handle_IRQ_event(irq, desc->action);
-	if (!noirqdebug)
+	if (!noirqdebug) {
+		spin_lock_irqsave(&desc->lock, flags);
 		note_interrupt(irq, desc, action_ret);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
 
 	if (desc->chip->eoi)
 		desc->chip->eoi(irq);

--------------080709080502010506090302--
