Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWEaIiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWEaIiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWEaIiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:38:08 -0400
Received: from www.osadl.org ([213.239.205.134]:29907 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964866AbWEaIiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:38:07 -0400
Subject: Re: genirq vs. fastack
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1149040361.766.10.camel@localhost.localdomain>
References: <1149040361.766.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 May 2006 10:38:54 +0200
Message-Id: <1149064735.20582.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Wed, 2006-05-31 at 11:52 +1000, Benjamin Herrenschmidt wrote:
> Hi Thomas, Ingo !
> 
> There is one bit in genirq that I don't get (and doesn't work for me),
> it's the "fastack" handler. It does:
> 
> out:
> 	if (!(desc->status & IRQ_DISABLED))
> 		desc->chip->ack(irq);
> 	else
> 		desc->chip->mask(irq);
> 
> Which doesn't at all match the needs of things like XICS or MPIC and
> thus I wonder if it does also make sense for controllers for which you
> intend it. It should just be:
> 
> 	desc->chip->end(irq);
> 
> Basically, those controllers will have 1) already acke'd the interrupt
> by the time you get the vector (the act of getting the vector does the
> ack), 2) will use a processor priority mecanism to handle non-reentrency
> of an interrupt thus mask/unmask is completely orthogonal to handling of
> interrupts and thus there is no need to do anything about mask/unmask in
> the handler, 3) all we need is to do an "EOI" (end of interrupt) at the
> end of the handling, which is what is done logically in the end()
> handler.

I see your point, but isn't EOI the chip specific implementation of
chip->ack() in that case ? 

The intention was to get down to the chip primitives and away from the
flow type chip->functions. Your patch would actually force the flow
control part (if (!(desc->status & IRQ_DISABLED))) back into the end()
function for Ingo's x86 implementation. So the intended seperation of
low level chip functions and flow control would be moot.

	tglx


