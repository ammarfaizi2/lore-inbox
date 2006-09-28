Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWI1BQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWI1BQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWI1BQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:16:37 -0400
Received: from www.osadl.org ([213.239.205.134]:44764 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964981AbWI1BQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:16:36 -0400
Subject: Re: [Bulk] Re: [patch 2.6.18] genirq: remove oops with fasteoi
	irq_chip descriptors
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <200609271739.10215.david-b@pacbell.net>
References: <200609220641.58938.david-b@pacbell.net>
	 <200609271621.11608.david-b@pacbell.net>
	 <1159401291.9326.599.camel@localhost.localdomain>
	 <200609271739.10215.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 03:18:19 +0200
Message-Id: <1159406299.9326.644.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Wed, 2006-09-27 at 17:39 -0700, David Brownell wrote:
>  - It wouldn't use chip->mask_ack() when that exists and those
>    other two routines don't, even though mask_ack_irq() is a
>    conveniently defined inline.

So why not replace it by mask_ack_irq() ?

>  - Umm, how could it ever be correct to leave the IRQ active
>    without a dispatcher?  ISTR the rationale for that delayed
>    disable was not purely to be a PITA for all driver writers,
>    but was to address some issue with edge triggering.  In that
>    path, triggering was no longer to be allowed ...

Your patch would result in default_disable() when no shutdown function
is provided. default_disable() does the delayed disable thing, while you
remove the handler. The next event on that line will cause a spurious
IRQ.

>  - Plus ack()ing the IRQ there just seemed pretty dubious.  It's
>    not like there would be anything preventing that signal line
>    from being lowered (or raised, etc) immediately after the ack(),
>    which in some hardware would latch the IRQ until later unmask().
>
> Leaving the question:  what's the point of it??  The overall
> system has to behave sanely with or without the ack(); just
> clearing a latch doesn't mean it couldn't get set later.

Fair enough.

> > > So what's the correct fix then ... use enable() and disable()?
> > > Oopsing isn't OK... 
> > 
> > True, but we can not unconditionally change the semantics. 
> 
> Some current semantics are "it oopses".  That's a good definition
> of semantics that _must_ be changed.  We're not Microsoft.  ;)

Agreed, it just depends on how they get fixed.

> > Does it break existing or new code ?
> 
> Could any code relying on those previous semantics have been
> correct in the first place, though?  Seemed to me it couldn't
> have been.
> 
> Plus, unregistering IRQ dispatchers is a strange notion.  I've
> never seen it done in practice ... normally, they get set up once
> during chip/board setup then never changed.  Bugs in code paths
> like that have been known to last for decades unfixed.

Agreed. Nothing is using this currently.

> > Sorry, I did not think about the defaults in the first place. The
> > conditionals in manage,c are probably superflous leftovers from one of
> > the evolvement.
> 
> And that's how I was taking that particular mask() then ack() too,
> especially given it never used mask_ack() when it should have, and
> since that logic oopsed in various cases with fasteoi handlers.

The remaining question is whether mask_ack_irq() or shutdown() is the
correct approach. Your patch would make it mandatory to implement
shutdown at least for such removable stuff.

I'm not sure about that right now as I'm too tired.

	tglx


