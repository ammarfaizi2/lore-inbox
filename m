Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVA3Sym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVA3Sym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVA3Sym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:54:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16845 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261233AbVA3Syg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:54:36 -0500
Date: Sun, 30 Jan 2005 13:57:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Lukasz Kosewski <lkosewsk@nit.ca>,
       Andrew Morton <akpm@osdl.org>, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
Message-ID: <20050130155751.GA11375@logos.cnet>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com> <1105013524.4468.3.camel@laptopd505.fenrus.org> <20050106195043.4b77c63e.akpm@osdl.org> <41DE15C7.6030102@nit.ca> <20050107043832.GR27371@parcelfarce.linux.theplanet.co.uk> <20050130152749.GF5186@logos.cnet> <1107109647.4306.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107109647.4306.61.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 07:27:26PM +0100, Arjan van de Ven wrote:
> On Sun, 2005-01-30 at 13:27 -0200, Marcelo Tosatti wrote:
> > On Fri, Jan 07, 2005 at 04:38:32AM +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 06, 2005 at 11:53:27PM -0500, Lukasz Kosewski wrote:
> > > > I have an idea of something I might do for 2.6.11, but I doubt anyone
> > > > will actually agree with it.  Say we keep a counter of how many times
> > > > interrupt x has been fired off since the last timer interrupt
> > > > (obviously, a timer interrupt resets the counter).  Then we can pick an
> > > > arbitrary threshold for masking out this interrupt until another device
> > > > actually pines for it.
> > > > 
> > > > Or something.  The point is, we need a general solution to the problem,
> > > > not poking about in every single driver trying to tie it down.
> > > 
> > > Something like note_interrupt() in kernel/irq/spurious.c?
> > 
> > BTW I wonder if its feasible to add an interface on top of kernel/irq/spurious.c for 
> > notifying drivers about interrupts storms, so they can take appropriate action 
> > (try to reset the device).
> 
> the problem is... the driver just denied it was their irq (at least in
> all the common cases)... 

Hum, drivers should, at least in theory, be able to return IRQ_NONE if interrupts
can't be handled.

So is 8390 a special case? 

drivers/net/8390.c 
irqreturn_t ei_interrupt(int irq, void *dev_id, struct pt_regs * regs)
{
...

        }
        spin_unlock(&ei_local->page_lock);
        return IRQ_RETVAL(nr_serviced > 0);
}


The "workaround" looks like (at the end of ei_interrupt):

        if (!nr_serviced)
                interrupt_cnt++;
        else
                interrupt_cnt = 0;
                                                                                
        if (interrupt_cnt > 256) {
                ei_status.reset_8390(dev);
                interrupt_cnt = 0;
        }


One could argue that it is a hardware problem...


