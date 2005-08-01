Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVHADDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVHADDp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 23:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVHADDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 23:03:45 -0400
Received: from ms-smtp-04-smtplb.ohiordc.rr.com ([65.24.5.138]:12020 "EHLO
	ms-smtp-04-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S262057AbVHADDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 23:03:43 -0400
Date: Sun, 31 Jul 2005 23:03:25 -0400
From: ambx1@neo.rr.com
Subject: Re: revert yenta free_irq on suspend
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Message-id: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.04 (built Feb  8 2005)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Linus Torvalds <torvalds@osdl.org>
Date: Sunday, July 31, 2005 9:07 pm
Subject: Re: revert yenta free_irq on suspend

> 
> 
> On Mon, 1 Aug 2005, Dave Airlie wrote:
> > 
> > You said earlier we only should fix drivers that need fixing, but 
> they> all need fixing
> 
> I think you're still talking from a theoretical standpoing, while 
> all my 
> arguments are practical.
> 
> In _practice_, I hope that
> 
> (a) we don't see that very much (ie the people for whom things 
> work 
>     already are a strong argument that this is less of a problem in
>     practice than people try to make it appear)

They may not always be triggered, but they are real bugs.  We can't
ensure stable PM until they are fixed.  If they weren't a real issue,
then calling free_irq() in pcmcia probably wouldn't have broken the
sound driver we saw in this case.

> 
> (b) drivers, _especially_ on notebooks, are already able to handle 
> an 
>     incoming interrupt with the device in D3 state and returning 0xff
>     for all reads.
> 
>     In particular, this is exactly the same thing that you get on 
> a 
>     surprise device removal too.
> 
> iow it really _really_ shouldn't matter that a shared interrupt 
> comes in
> after (or before) a device has gone to sleep. Because a driver that 
> can'thandle that schenario is buggy for totally unrelated reasons, 
> and doing a 
> "free_irq()/request_irq()" pair at suspend time is _not_ the solution!

I understand this.  But calling free_irq()/request_irq() still seems
to make sense.  It's the cleanest and most straightforward approach.
It's the easiest way we can ensure there will not be race conditions.
An interrupt could be triggered during the device's power transition
when it's in between on and off.  More importantly, we need this change
for runtime power management anyway.

> 
> > This has nothing to do with the issues with highlevel PM interfaces
> > for shutting down hardware, this is do with fixing the drivers in 
> the> kernel currently and what the correct way to do it is without 
> breaking> someone elses hardware....
> 
> ... and I don't think this has _anything_ to do with 
> free_irq/request_irq, 
> and everything to do with the fact that we can try to make at least 
> the 
> common drivers "hardened" for unexpected interrupts coming in when 
> the hw 
> might not be ready for them.

We either need to change every driver to free irqs or "harden" each
of them.  Freeing irqs obviously seems easier.  I propose we make
this change in -mm in one pass to avoid bugs like this.

Also, as I said earlier, the better we support OSPM initiated power
management, the more likely APM will break.  This may be technically
unavoidable on some isolated boxes without quirks.  I agree with
Pavel that "do nothing" may make sense, but it seems some devices
may still need to be disabled by the OS.  As a real world example,
we currently can't turn off cardbus bridges because it breaks APM
on a couple of older laptops.

Thanks,
Adam

