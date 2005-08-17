Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVHQOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVHQOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVHQOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:10:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60345 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751134AbVHQOKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:10:24 -0400
Date: Wed, 17 Aug 2005 10:10:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: mingo@elte.hu, <tglx@linutronix.de>, <some.nzguy@gmail.com>,
       <paulmck@us.ibm.com>, <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
In-Reply-To: <20050817022319.5038EC16A5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0508170959410.4862-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, David Brownell wrote:

> > > > Interrupts are disabled during usb_hcd_giveback_urb because that's how 
> > > > it was done originally and nobody has made an effort to remove this 
> > > > assumption from the USB device drivers.
> 
> Also Host Controller Drivers (HCDs).  You do sort of have to
> remember who's calling this routine.  It's normally an HCD in
> the middle of its IRQ processing, tending hardware.
> 
> I'd actually say the reason that has IRQs disabled is because
> of the amount of work that would have been involved in changing
> that assumption ...  I actually did look at what it'd take to
> let IRQs be enabled during USB completion callbacks a while back,
> and concluded it'd be a lot of work for hardly any return.

Maybe Ingo's priorities are sufficiently different that he thinks the
return _will_ be worthwhile.  We've already mentioned the work involved in
auditing all the USB drivers.  You bring up the point that the HCDs may
need adjustments also.


>   1 ALWAYS complete() with IRQs disabled
> 
>   2 NEVER complete() with them disabled
> 
>   3 SOMETIMEs complete() with them disabled.
> 
> Right now we're with #1 which is simple, consistent and guaranteed.
> 
> We couldn't switch to #2 with patches that simple.  They'd in fact
> be rather involved, because there is logic like "If the endpoint's
> queue is empty when the completion handler returns, then deschedule
> that queueue" inside IRQ handlers.  Basic things, like correctness,
> for periodic scheduling depend on such logic.

I'm in favor of #2 on general principle.  The issue you mention,
maintaining bandwidth reservations (and hardware data structures) for
periodic endpoint queues, is not all that difficult to handle.  Are there
any other parts of the HCDs you can think of that would be affected by
such a change?  (I can't think of any for uhci-hcd, although I haven't
looked through the code to make sure.)

Alan Stern

