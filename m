Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVHQUvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVHQUvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVHQUvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:51:44 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:61655 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751243AbVHQUvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:51:43 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=RVqpuHYzsXwB7xe8kw/WEatfAEXQJLJ0J0nv3GZWwl7FMpgpci7NscSWTXqrNLQOX
	npuozClwJSAKusVxXY8SA==
Date: Wed, 17 Aug 2005 13:51:24 -0700
From: David Brownell <david-b@pacbell.net>
To: stern@rowland.harvard.edu
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Cc: tglx@linutronix.de, some.nzguy@gmail.com, paulmck@us.ibm.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org, gregkh@suse.de,
       a.p.zijlstra@chello.nl
References: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050817205125.06ABCBF3E9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > Interrupts are disabled during usb_hcd_giveback_urb because that's
> > > > > how it was done originally and nobody has made an effort to remove
> > > > > this assumption from the USB device drivers.
> > 
> > Also Host Controller Drivers (HCDs).  You do sort of have to
> > remember who's calling this routine.  It's normally an HCD in
> > the middle of its IRQ processing, tending hardware.
> > 
> > I'd actually say the reason that has IRQs disabled is because
> > of the amount of work that would have been involved in changing
> > that assumption ...  I actually did look at what it'd take to
> > let IRQs be enabled during USB completion callbacks a while back,
> > and concluded it'd be a lot of work for hardly any return.
>
> Maybe Ingo's priorities are sufficiently different that he thinks the
> return _will_ be worthwhile.

Maybe.  I think I didn't catch all the discussion either; what
I saw was questioning the USB-specific changes related to the
interrupt thread work.  That touches on a lot of other things
too, more than a few of which raise interesting issues.  :)


>		We've already mentioned the work involved in
> auditing all the USB drivers.  You bring up the point that the HCDs may
> need adjustments also.

Yes, both HCDs and usbcore.


> >   1 ALWAYS complete() with IRQs disabled
> > 
> >   2 NEVER complete() with them disabled
> > 
> >   3 SOMETIMEs complete() with them disabled.
> > 
> > Right now we're with #1 which is simple, consistent and guaranteed.
> > 
> > We couldn't switch to #2 with patches that simple.  They'd in fact
> > be rather involved ...
>
> I'm in favor of #2 on general principle.

Which principle would that be, though?  :)

I think "Keep It Simple, Stupid" argues strongly against #3,
and also -- at least for now -- against #2 as well.


>		The issue you mention,
> maintaining bandwidth reservations (and hardware data structures) for
> periodic endpoint queues, is not all that difficult to handle.

There were other places I remember logic that relied on such
API guarantees, but I couldn't list them all now.

In any case, I'm not going to invest time to rewrite any HCDs to
help make that happen.  I'm sure there are other people competent
to do that though, and some of them would surely bring some new 
insights into how the USB stack can be improved.

In fact I think this sort of thing might usefully be looked at
along with other performance related issues.  That whole stack
seems functional enough now that it might well be time to look
at thing that slow it down, or which it slows down.

- Dave

