Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWDLACD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWDLACD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDLACD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:02:03 -0400
Received: from ns1.suse.de ([195.135.220.2]:36041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751105AbWDLACB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:02:01 -0400
From: Neil Brown <neilb@suse.de>
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 12 Apr 2006 10:01:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17468.17241.14299.46051@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-Reply-To: message from Pavel Machek on Tuesday April 11
References: <17463.14285.31029.943738@cse.unsw.edu.au>
	<20060411170721.GA1893@elf.ucw.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 11, pavel@suse.cz wrote:
> > 
> >  Now if the IRQ is handled as an edge-triggered line (which I believe
> >  they are in Linux), then losing this race will mean that we don't see
> >  any more interrupts on this line.
> 
> I believe that
> 
> a) any shared interrupts should be level-triggered. It is not okay to
> share edge-triggered interrupt

I see that now, thanks.

> 
> b) your patch does not fix that issue. It only makes race window
> smaller.
> 
> >  	if (!(action->flags & SA_INTERRUPT))
> >  		local_irq_enable();
> >  
> >  	do {
> >  		ret = action->handler(irq, action->dev_id, regs);
> > -		if (ret == IRQ_HANDLED)
> > +		if (ret == IRQ_HANDLED) {
> >  			status |= action->flags;
> > +			repeat = 1;
> > +		}
> >  		retval |= ret;
> >  		action = action->next;
> > +		if (!action &&
> > +		    repeat &&
> > +		    safeirq &&
> > +		    (actionlist->flags & SA_SHIRQ)) {
> > +			/* at least one handler on the list did something,
> > +			 * and the interrupt is sharable, so give
> > +			 * every handler another chance, incase a new event
> > +			 * came in and is holding the irq line asserted.
> > +			 */
> > +			action = actionlist;
> > +			repeat = 0;
> > +		}
> >  	} while (action);
> 
> I think it is still racy. What if another interrupt comes here?

Well... at this point we are certain that the irq line was low at some
point since the loop was first entered, otherwise we would not have
been able to pass through all actions without getting a single
IRQ_HANDLED.
So if an interrupt happens now, it will generate an edge.
However I concede that I don't know how the PIC works exactly.  The
interrupt is still disabled in the PIC at this point.  If this means
that the edge will be ignored, then you are right.  If it just means
that the edge will be "delayed" and we will see the interrupt when
they are re-enabled at the PIC, then we should be safe.


> 
> >  	if (status & SA_SAMPLE_RANDOM)
> 
> 								Pavel
> -- 
> Thanks for all the (sleeping) penguins.

Do you have a gallery somewhere ???

Thanks for your input.

NeilBrown
