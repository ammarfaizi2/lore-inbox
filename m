Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTLHVcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLHVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:32:18 -0500
Received: from ida.rowland.org ([192.131.102.52]:30212 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261796AbTLHVcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:32:16 -0500
Date: Mon, 8 Dec 2003 16:32:15 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312082053.25541.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312081538510.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Duncan Sands wrote:

> > If you would keep the ps->devsem lock, would there be any problem in
> > setting ps->dev to NULL to indicate disconnection?
> 
> You can't keep the ps->devsem lock and use ps->dev->serialize, because it
> leads to deadlock.

How so?  Remember that I am almost totally unfamiliar with the details of 
the usbfs code.  Are you saying there are places where the driver holds 
one lock and needs to acquire the other and vice versa?

>  Actually, simply replacing ps->devsem with ps->dev->serialize
> cannot lead to any new deadlocks, it makes deadlocks that could occasionally
> happen always happen (such deadlocks exist right now in usbfs).  Some of the
> current deadlocks can be eliminated without giving up ps->devsem, but not all.
> So the question is: must ps->dev->serialize be used?

It must be held when you call usb_reset_configuration().  It must _not_ be
held when you call usb_set_configuration().  For usb_reset_device() right
now you must not hold it, although that may change in the future.  For
usb_unbind_interface() you must not hold it.  There's a note that
usb_driver_claim_interface() grabs the BKL for some reason having to do
with usbfs -- no doubt when usbfs is fixed that won't be needed and the 
caller will be required to hold dev->serialize instead.

If you call usb_ifnum_to_if() you ought to hold the serialize lock; 
otherwise the configuration might change out from under you.  But it's not 
necessary.  Likewise for usb_epnum_to_ep_desc if you're looking up an 
endpoint that isn't part of an interface you have bound.

> > Are they any reasons for not keeping ps->devsem?  Since usbfs generally
> > acts as a driver and drivers generally don't have to concern themselves
> > with usbdev->serialize (the core handles it for them), shouldn't usbfs
> > also be able to ignore ps->dev->serialize?
> 
> No, because it needs to do operations on interfaces it hasn't claimed (such
> as looking them up and claiming them).  This is why it needs to protect
> itself, at least momentarily, against configurations shifting under it.  This
> can be done by using the BKL more.  However it can be done more simply
> using ps->dev->serialize (in fact it is simpler than what is there now).

That agrees with my assessment.  It ought to be possible to remove these 
references to the BKL in favor of ps->dev->serialize.


> By the way, if it is somehow fatal to do usb_put_dev after disconnect,
> what is the point of referencing counting at all?  You might as well
> free up the usb_device structure immediately after disconnect, since
> there is sure to be a reference before disconnect, and (apparently)
> there had better not be a reference after disconnect...

There's some sort of misunderstanding here.  It's not fatal to do 
usb_put_dev() after disconnect, provided you called usb_get_dev() earlier.
I'm not sure what the cause was of the oops you were getting, but it 
wasn't that.

Alan Stern


