Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVKGSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVKGSKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVKGSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:10:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33806 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965141AbVKGSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:10:19 -0500
Date: Mon, 7 Nov 2005 18:10:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ben Dooks <ben@fluff.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051107181010.GB28605@flint.arm.linux.org.uk>
Mail-Followup-To: Ben Dooks <ben@fluff.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <20051107124220.GA16281@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107124220.GA16281@home.fluff.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:42:20PM +0000, Ben Dooks wrote:
> On Sun, Nov 06, 2005 at 08:40:12AM +0000, Russell King wrote:
> > I haven't had any feedback on this patch.  akpm - can you add it to -mm
> > please?  Here's the sign-off for it, thanks.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > ----- Forwarded message from Russell King <rmk+lkml@arm.linux.org.uk> -----
> > Date:	Fri, 28 Oct 2005 22:57:47 +0100
> > From:	Russell King <rmk+lkml@arm.linux.org.uk>
> > To:	Linux Kernel List <linux-kernel@vger.kernel.org>
> > Subject: [RFC] IRQ type flags
> > 
> > Hi,
> > 
> > Some ARM platforms have the ability to program the interrupt controller
> > to detect various interrupt edges and/or levels.  For some platforms,
> > this is critical to setup correctly, particularly those which the
> > setting is dependent on the device.
> > 
> > Currently, ARM drivers do (eg) the following:
> > 
> > 	err = request_irq(irq, ...);
> > 
> > 	set_irq_type(irq, IRQT_RISING);
> > 
> > However, if the interrupt has previously been programmed to be level
> > sensitive (for whatever reason) then this will cause an interrupt
> > storm.
> 
> surely, thats the other way around, going from edge to level.

No.  How can an edge triggered interrupt possibly cause a storm?

If the interrupt signal is at logic '0' and it was previously
configured for a low level to interrupt, when you call request_irq()
with your handler, the interrupt will be enabled.

Because it's level sensitive, it'll immediately interrupt, and
the handler will be invoked.  When the handler returns, the interrupt
signal will still be at logic '0' so it's still active.  So you
immediately get another interrupt and the handler will be re-invoked.
Repeat infinitely.

So it is exactly as I describe.

> How about making these compatible with the
> triggers compatible with the flags from
> include/linux/ioport.h definitions for the
> IRQ resource (IORESOURCE_IRQ_*). 

We could do, but I took the set_irq_type() implementation. 8)  We
could change both to conform.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
