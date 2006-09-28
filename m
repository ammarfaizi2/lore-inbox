Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031299AbWI1AjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031299AbWI1AjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031300AbWI1AjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:39:16 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:41654 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031299AbWI1AjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:39:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=L4WlW68ERcalD8FSmYYJhxNHE5vmWSBeTZnzf7SKbDuMoqk2qxAf6YSWQS4kRjeQIiBFn3jIVaY/8XrPVLPzk5qll/tQdzsTrxcuuDS7PvWE1tEqMzbwk8KD4d2GAJ/fWq5+sZ/RxAdKPL6ubk3GwUyFMsCHGDBQaLkq8X7fBjQ=  ;
From: David Brownell <david-b@pacbell.net>
To: tglx@linutronix.de
Subject: Re: [Bulk] Re: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip descriptors
Date: Wed, 27 Sep 2006 17:39:09 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
References: <200609220641.58938.david-b@pacbell.net> <200609271621.11608.david-b@pacbell.net> <1159401291.9326.599.camel@localhost.localdomain>
In-Reply-To: <1159401291.9326.599.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271739.10215.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 4:54 pm, Thomas Gleixner wrote:
> Dave,
> 
> On Wed, 2006-09-27 at 16:21 -0700, David Brownell wrote:
> > As you should know, irq_chip_set_defaults() ensures that every
> > irqchip has startup() and shutdown() methods.  Their default
> > implementations use enable() and disable() ... which in turn
> > have default implementations using mask()/unmask(), for use
> > with non-EIO handlers. 
> 
> True. Still you change the semantics.
> 
> 	chip->mask();
> 	chip->ack();
> 
> is not equal to :
> 
> 	if (!(desc->status & IRQ_DELAYED_DISABLE))
> 		irq_desc[irq].chip->mask(irq);

And I'd said as much.  But you'll notice that code looked like
it had lots of correctness issues in the first place:

 - Of course, there's the fact that it would oops.

 - It wouldn't use chip->mask_ack() when that exists and those
   other two routines don't, even though mask_ack_irq() is a
   conveniently defined inline.

 - Umm, how could it ever be correct to leave the IRQ active
   without a dispatcher?  ISTR the rationale for that delayed
   disable was not purely to be a PITA for all driver writers,
   but was to address some issue with edge triggering.  In that
   path, triggering was no longer to be allowed ...

 - Plus ack()ing the IRQ there just seemed pretty dubious.  It's
   not like there would be anything preventing that signal line
   from being lowered (or raised, etc) immediately after the ack(),
   which in some hardware would latch the IRQ until later unmask().

Leaving the question:  what's the point of it??  The overall
system has to behave sanely with or without the ack(); just
clearing a latch doesn't mean it couldn't get set later.


> > So what's the correct fix then ... use enable() and disable()?
> > Oopsing isn't OK... 
> 
> True, but we can not unconditionally change the semantics. 

Some current semantics are "it oopses".  That's a good definition
of semantics that _must_ be changed.  We're not Microsoft.  ;)

 
> Does it break existing or new code ?

Could any code relying on those previous semantics have been
correct in the first place, though?  Seemed to me it couldn't
have been.

Plus, unregistering IRQ dispatchers is a strange notion.  I've
never seen it done in practice ... normally, they get set up once
during chip/board setup then never changed.  Bugs in code paths
like that have been known to last for decades unfixed.

Now if IRQs were dynamically allocated rather than having hard
platform limits of NR_IRQS, I could understand that changing.


> > It was certainly _tested_ on a 2.6.18 ARM board, so you're clearly wrong
> > about at least that part of your feedback as well as the bits about the
> > shartup and shutdown calls being "optional" (in any practical sense, since
> > they are in fact _always_ present).
> 
> Sorry, I did not think about the defaults in the first place. The
> conditionals in manage,c are probably superflous leftovers from one of
> the evolvement.

And that's how I was taking that particular mask() then ack() too,
especially given it never used mask_ack() when it should have, and
since that logic oopsed in various cases with fasteoi handlers.

- Dave

