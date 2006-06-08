Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWFHS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWFHS5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWFHS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:57:19 -0400
Received: from www.osadl.org ([213.239.205.134]:59110 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964942AbWFHS5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:57:18 -0400
Subject: Re: [PATCH] genirq: Fix missing initializer for unmask in
	no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1149782293.5257.43.camel@localhost.localdomain>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
	 <1149700829.5257.16.camel@localhost.localdomain>
	 <1149706650.5257.19.camel@localhost.localdomain>
	 <20060608113534.GA5050@flint.arm.linux.org.uk>
	 <1149768256.5257.37.camel@localhost.localdomain>
	 <20060608152926.GA15337@flint.arm.linux.org.uk>
	 <1149782293.5257.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 20:57:55 +0200
Message-Id: <1149793075.5257.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 17:58 +0200, Thomas Gleixner wrote:
> >  it appears to work
> > provided you don't stress it.  As soon as I load the system up with
> > CF activity, a full-sized flood ping and hit "enter" a few times on
> > the console, it locks up solid - no oops, no nothing, the machine
> > just completely freezes.
> > 
> > This does not happen with the existing ARM IRQ code.
> > 
> > I'll try to debug this odd behaviour later today, but first I need to
> > resurect my NMI oopser code for this platform.

Russell, 

thanks for tracking this down. It turned out to be a reentrancy problem
which was silently ignored by the original ARM implementation.

I uploaded a new patch series which contains the ARM side fix and I
added error messages for that case at the appropriate places.

http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq4.patch

http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq4.patches.tar.bz2

Ingo, Ben,

can you please check whether the following patch does trigger any false
positives for you ?

	tglx

 kernel/irq/chip.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc6/kernel/irq/chip.c
===================================================================
--- linux-2.6.17-rc6.orig/kernel/irq/chip.c	2006-06-08 19:26:16.000000000 +0200
+++ linux-2.6.17-rc6/kernel/irq/chip.c	2006-06-08 19:26:16.000000000 +0200
@@ -208,8 +208,11 @@
 
 	spin_lock(&desc->lock);
 
-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely(desc->status & IRQ_INPROGRESS)) {
+		printk(KERN_ERR "handle_simple_irq reentered while "
+		       "processing irq %d\n", irq);
 		goto out_unlock;
+	}
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -251,8 +254,11 @@
 	spin_lock(&desc->lock);
 	mask_ack_irq(desc, irq);
 
-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely(desc->status & IRQ_INPROGRESS)) {
+		printk(KERN_ERR "handle_level_irq reentered while "
+		       "processing irq %d\n", irq);
 		goto out;
+	}
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -273,9 +279,9 @@
 
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
-out:
 	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
 		desc->chip->unmask(irq);
+out:
 	spin_unlock(&desc->lock);
 }
 


