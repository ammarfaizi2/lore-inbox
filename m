Return-Path: <linux-kernel-owner+w=401wt.eu-S1751974AbWLNXd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWLNXd7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWLNXd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:33:58 -0500
Received: from www.osadl.org ([213.239.205.134]:32928 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751974AbWLNXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:33:57 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612141458160.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
	 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0612140924140.5718@woody.osdl.org>
	 <1166129262.29505.120.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612141458160.5718@woody.osdl.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 00:37:42 +0100
Message-Id: <1166139462.29505.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Thu, 2006-12-14 at 14:59 -0800, Linus Torvalds wrote:
> > The kernel part of the UIO driver also knows how to shut the interrupt
> > up, so where is the difference ?
> 
> Thomas, you've been discussing some totally different and private 
> Thomas-only thread than everybody else in this thread has been.

Yeah, I even looked at different code than others, until they noticed
that email before coffee is bad. :)

> The point is NO, THE UIO DRIVER DID NOT KNOW THAT AT ALL. Go and read the 
> post that STARTED this whole thread. Go and read the "example driver". 
> 
> The example driver was complete crap and drivel. 

Sigh, I accept and also Greg has done this before, that the example
driver based on the LPT port was not a fortunate choice. It was done to
provide some example which is reproducible on COTS hardware. 

Real world drivers like the sercos example I provided - and I do it
again - are aware of that problem:

/*
 * The chip specific portion of the interrupt handler. The framework code
 * takes care of userspace notification when we return IRQ_HANDLED
 */
static irqreturn_t sercos_handler(int irq, void *dev_id, struct pt_regs *reg)
{
        /* Check, if this interrupt is originated from the SERCOS chip */
        if (!(sercos_read(IRQ_STATUS) & SERCOS_INTERRUPT_MASK))
                return IRQ_NONE;

---------^ Makes it safe for IRQ sharing

        /* Acknowledge the chip interrupts */
        sercos_write(IRQ_ACK1, SERCOS_INTERRUPT_ACK1);
        sercos_write(IRQ_ACK2, SERCOS_INTERRUPT_ACK2);

----------^
	Actually prevents the box is dead scenario, as it disables the
interrupt from that device until it is reenabled from the user space
driver code. This covers also the case where the user space driver dies,
as the kernel still has the portion of code to shut this thing up for
ever.
        return IRQ_HANDLED;
}

The concept requires, that 
- the interrupt handling is in the kernel _AND_ open source
- the mapping of the device is done via the kernel controlled mapping
function rather than by poking in the PCI regs

I really regret that I ever came up with this LPT example, but cutting
the whole discussion down to that ugly example driver does not get us
anywhere.

	tglx



