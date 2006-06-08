Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWFHP3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWFHP3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWFHP3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:29:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49170 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964865AbWFHP3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:29:35 -0400
Date: Thu, 8 Jun 2006 16:29:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] genirq: Fix missing initializer for unmask in no_irq_chip
Message-ID: <20060608152926.GA15337@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu> <20060607165456.GC13165@flint.arm.linux.org.uk> <1149700829.5257.16.camel@localhost.localdomain> <1149706650.5257.19.camel@localhost.localdomain> <20060608113534.GA5050@flint.arm.linux.org.uk> <1149768256.5257.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149768256.5257.37.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 02:04:15PM +0200, Thomas Gleixner wrote:
> On Thu, 2006-06-08 at 12:35 +0100, Russell King wrote:
> > Okay, works on Versatile (which is a trivial platform) it doesn't work
> > on Neponset (a rather more complex setup).  Neponset has a case where
> > there's an interrupt "concentrator" which consists of logically ORing
> > three interrupt sources, and providing a status register so you know
> > which occurred.
> > 
> > Hence, there is no "chip" for this, and while it works with the ARM
> > IRQ subsystem, it doesn't even boot with the genirq stuff.
> > 
> > This doesn't happen with the ARM IRQ subsystem because the "no chip"
> > handlers are all pointing at a dummy function instead of being NULL.
> > Could we do the same with genirq ?
> 
> We missed to initialize unmask, which causes problems on neponset.

Okay, with -rc6 + genirq + the following patch, it appears to work
provided you don't stress it.  As soon as I load the system up with
CF activity, a full-sized flood ping and hit "enter" a few times on
the console, it locks up solid - no oops, no nothing, the machine
just completely freezes.

This does not happen with the existing ARM IRQ code.

I'll try to debug this odd behaviour later today, but first I need to
resurect my NMI oopser code for this platform.

--- linux-2.6.17-rc6/kernel/irq/handle.c	2006-06-07 20:54:01.000000000 +0200
+++ b/kernel/irq/handle.c
@@ -91,7 +91,8 @@
 	.shutdown	= noop,
 	.enable		= noop,
 	.disable	= noop,
-	.ack		= ack_bad,
+	.ack		= noop, // needed to quiten down boot time complaints
+	.unmask		= noop,	// needed to prevent oops on sa1111 init
 	.end		= noop,
 };
 
--- linux-2.6.17-rc6/kernel/irq/manage.c	2006-06-07 20:53:54.000000000 +0200
+++ b/kernel/irq/manage.c
@@ -199,8 +199,8 @@
 	if (irq >= NR_IRQS)
 		return -EINVAL;
 
-	if (desc->chip == &no_irq_chip)
-		return -ENOSYS;
+//	if (desc->chip == &no_irq_chip) // prevents smc91x initialising
+//		return -ENOSYS;
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
 	 * so we have to be careful not to interfere with a


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
