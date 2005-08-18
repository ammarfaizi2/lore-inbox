Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVHROn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVHROn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVHROn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:43:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37769 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932237AbVHROn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:43:57 -0400
Date: Thu, 18 Aug 2005 10:43:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: mingo@elte.hu, <tglx@linutronix.de>, <some.nzguy@gmail.com>,
       <paulmck@us.ibm.com>, <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <akpm@osdl.org>, <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
In-Reply-To: <20050818063750.036C685F16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0508181000390.4965-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Ingo Molnar wrote:

> but fortunately this is a relatively straightforward process, and it
> seems Alan has identified most of the affected functions. 

Ooh...  Don't assume that!  I only identified the two that occurred to me 
at the moment.  There could be plenty of others -- I haven't looked.


On Wed, 17 Aug 2005, David Brownell wrote:

> Of course, "never ... unless really really necessary" can fight
> against the principle of "as simple as practical".  Tradeoffs
> somehow never seem far away in engineering, somehow.

I don't think making this change will involve any loss of simplicity.  See 
below.

> And the only places either is used relate to some tricky lock hierarchy
> games that need to be played when canceling URBs ...  where usbcore has to
> account for the fact that the URB being canceled may _at that instant_
> be in the middle of being given back to the device driver (from the
> HCD, via usbcore) by an IRQ handler on another CPU.  There's no "naked
> disabling" at all; it's used exclusively when two different irq-safe
> locks need to be coordinated.

Are you two talking about the same thing?  I gather that by "naked 
disabling" Ingo means something like (see hcd_endpoint_disable):

	local_irq_disable ();

whereas Dave appears to be talking about nested spinlocks (see 
hcd_unlink_urb):

	spin_lock_irqsave (&urb->lock, flags);
	spin_lock (&hcd_data_lock);

There's no question that nested locking is important and necessary.  The
calls to local_irq_disable are more dubious.  AFAICT each place they
occur in hcd.c, it is solely to fulfill the guarantee that
usb_hcd_giveback_urb calls the completion handler with local interrupts
disabled.  It has no bearing at all on matters of concurrency, such as
cancelling an URB that is at that instant being given back -- the
spinlocks take care of that.  (Or more accurately, they would if the
local_irq_{dis,en}enable calls were removed and the corresponding
outermost calls to spin_lock were replaced by spin_lock_irq.)

> But as I pointed out, that answer was incomplete.  Or maybe it
> only addressed some of the code paths, not all of them.  Not
> all the issues are "mostly historic".

It's true that I haven't examined all the code paths.  Leaving aside the 
completion handlers themselves, however, I don't think there is anything 
in usbcore or the HCDs that would really be affected by enabling local 
interrupts during the callbacks.  If there is, it's almost certainly a 
bug.

Take for example the issue you mentioned before, about descheduling empty 
endpoint queues when the completion handler returns.  By enabling local 
interrupts, we would allow the possibility that an unrelated IRQ routine 
might enqueue or dequeue an entry while the handler was running.  But that 
possibility has always existed, since the unrelated IRQ routine could in 
any case be running on a different CPU.

Alan Stern

