Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272369AbTGYWax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272370AbTGYWax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:30:53 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:18914 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S272369AbTGYWav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:30:51 -0400
Message-ID: <3F21B3BF.1030104@pacbell.net>
Date: Fri, 25 Jul 2003 15:48:31 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston>
In-Reply-To: <1059153629.528.2.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote, responding to Alan Stern:
>>I think the hub driver's power management code may be at fault.  It needs
>>to cancel the status interrupt URB when suspending and resubmit it when
>>waking up; right now it probably does neither one.
>>
>>Or maybe I'm wrong about that.  Perhaps it's okay to leave the URB active.  
>>If that's the case, then the root hub power management code needs to be 
>>changed to restart the status URB timer after a wakeup.

I thought that patch got merged already ...


>>I'm not sure how the design is intended to work, but either way something 
>>needs to be fixed.

Yes, it seems like all the HCDs (and the hub driver) need attention.

Plus, the enumeration process should respect hubs' power budgets,
and handle overcurrent better.  I had a hub re-enumerate over forty
times not that long ago, just because it enabled too many things at
once and the surge currents made lots of trouble.  Plenty of power,
if it got turned on carefully enough... :)


> Could well be. I need to spend some time auditing power management
> in the USB drivers in general. The idea here is that a sub-driver
> (USB device driver) should make sure it has no more pending URBs
> when returning from suspend() and the HCD driver should just cancel
> pending URBs if still any and reject any one that would be submited

Agreed, this needs work.  Some USB device drivers will likely need to
implement suspend()/resume() callbacks, which thoughtfully enough the
driver model conversion already gave us.  At one point it was planned
to have it automatically traverse the devices and suspend, leaves up to
root; and resume in the reverse order.  Is that behaving now?

Suspend should likely enable remote wakeup (trevor.pering@intel.com
has been asking about that), at least as a config option.  That'll
be useful for things like keyboards and mice.

Now's probably a good time to work on this sort of integration issue.
I'll be glad to see contributions in this area.


> before it's woken up. It's especially very important on OHCI to not
> touch chip registers (like enabling bulk queue etc...) after the chip
> have been put to suspend state. On some chips, that can cause random
> bus mastering to main memory during sleep, which can cause all sorts
> of interesting results especially when the north bridge is asleep...

There's already code in the OHCI driver to handle that for some
of the Apple hardware, as you know.  And it should kick in on at
least some of the power management paths; although not all, as
Pavel has noted.

- Dave


