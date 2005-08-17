Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVHQCXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVHQCXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHQCXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:23:32 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:19878 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750708AbVHQCXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:23:32 -0400
X-ORBL: [69.107.32.110]
Date: Tue, 16 Aug 2005 19:23:19 -0700
From: David Brownell <david-b@pacbell.net>
To: stern@rowland.harvard.edu, mingo@elte.hu
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Cc: tglx@linutronix.de, some.nzguy@gmail.com, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, gregkh@suse.de, a.p.zijlstra@chello.nl
References: <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050817022319.5038EC16A5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Interrupts are disabled during usb_hcd_giveback_urb because that's how 
> > > it was done originally and nobody has made an effort to remove this 
> > > assumption from the USB device drivers.

Also Host Controller Drivers (HCDs).  You do sort of have to
remember who's calling this routine.  It's normally an HCD in
the middle of its IRQ processing, tending hardware.

I'd actually say the reason that has IRQs disabled is because
of the amount of work that would have been involved in changing
that assumption ...  I actually did look at what it'd take to
let IRQs be enabled during USB completion callbacks a while back,
and concluded it'd be a lot of work for hardly any return.


> > > 			There's no real reason for it 
> > > other than historical inertia.  It's not done for serialization -- 
> > > there's no need for serialization since an URB can't be resubmitted 
> > > before the previous callback occurs (unless a driver is badly broken).  
> > > The "detached" method is used simply to avoid an extra pair of 
> > > enable/disable instructions.
> > 
> > so we can remove it altogether, via the patch below?

Sounds dangerous to me.


> > 					(If there's any 
> > unsafe driver, it should already be unsafe on SMP, and with the 
> > proliferation of HT and dual-core CPUs, SMP will be the norm within a 
> > year or so - so the sooner we trigger any breakages, the better i 
> > guess.)
> > 
> > i'll give it a whirl in the -RT tree.
>
> In general yes, the patch should be okay.  But there are a few things to
> check for.  Perhaps most of the USB drivers don't care whether interrupts
> are enabled or not in their completion routines.

And in general, all drivers have been _allowed_ to know that IRQs are
disabled in completion handlers ever since the earliest 2.2 kernels
that included USB support.

Changes like that -- interactions between at least three obvious
subsystems (usbcore, usb drivers, hcds) and lots of unobvious ones
(whoever the drivers talk to) -- sound rather error prone to me.
Worth taking very cautiously, with lots of regression testing of
stress loads on some of the funkier hardware.


Not that I'm deeply opposed to such changes, you understand, but
there seem to be three choices here:

  1 ALWAYS complete() with IRQs disabled

  2 NEVER complete() with them disabled

  3 SOMETIMEs complete() with them disabled.

Right now we're with #1 which is simple, consistent and guaranteed.

We couldn't switch to #2 with patches that simple.  They'd in fact
be rather involved, because there is logic like "If the endpoint's
queue is empty when the completion handler returns, then deschedule
that queueue" inside IRQ handlers.  Basic things, like correctness,
for periodic scheduling depend on such logic.

And I don't see much point to #3.  It's got all the DIS-advantages
of #1 and #2 and the advantages of neither ...

- Dave

