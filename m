Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLHXJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTLHXJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:09:09 -0500
Received: from ida.rowland.org ([192.131.102.52]:38148 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261957AbTLHXJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:09:03 -0500
Date: Mon, 8 Dec 2003 18:09:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312082255.43481.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Duncan Sands wrote:

> > > You can't keep the ps->devsem lock and use ps->dev->serialize, because it
> > > leads to deadlock.
> >
> > How so?  Remember that I am almost totally unfamiliar with the details of
> > the usbfs code.  Are you saying there are places where the driver holds
> > one lock and needs to acquire the other and vice versa?
> 
> Yes.  ps->devsem is used to protect against disconnection: all top level
> routines take it (as a read lock), and in driver_disconnect it is taken as a
> write lock.  Top level routines call lower level routines which sometimes
> need to take dev->serialize (and do already in several places).
> 
> Thus: ps->devsem taken, then dev->serialize.
> 
> However, dev->serialize is taken by the USB core before calling
> driver_disconnect.
> 
> Thus: dev->serialize taken, then ps->devsem.

This is a tricky situation, no doubt about it.

Your situation is a little different from the usual one because ps->devsem
locks the whole device, not just a single interface.  It should still be
able to work.  But maybe you're right; since ps->devsem locks the same
thing as ps->dev->serialize, maybe it's not needed.  By the way, when
usbfs takes ownership of a device, does it bind to the device's
interfaces?

> Right.  And why should (for example) dev->serialize not be held when it
> calls usb_set_configuration? - because usb_set_configuration takes
> dev->serialize.  This is one of the places I mentioned above where
> deadlock can occur right now.

You may simply have to release the lock because calling 
usb_set_configuration and then reacquire it afterwards.

That leads to the question of how to assure that the device doesn't go 
away before usb_set_configuration is called.  Perhaps 
usb_set_configuration and usb_unbind_interface should be changed to 
require the caller to hold the serialize lock.


> > If you call usb_ifnum_to_if() you ought to hold the serialize lock;
> > otherwise the configuration might change out from under you.  But it's not
> > necessary.  Likewise for usb_epnum_to_ep_desc if you're looking up an
> > endpoint that isn't part of an interface you have bound.
> 
> Why isn't it necessary?  As far as I can see it is vital.

I mean it won't cause an oops, although it might provide an invalid 
result.  It's not _required_ by the API (maybe it should be).

Actually, there's another sense in which it's not necessary.  Since
changing configurations first involves unbinding the existing drivers, if
you hold a driver-private lock that will block your disconnect routine
then you can safely call usb_ifnum_to_if even without holding
dev->serialize.

> > There's some sort of misunderstanding here.  It's not fatal to do
> > usb_put_dev() after disconnect, provided you called usb_get_dev() earlier.
> > I'm not sure what the cause was of the oops you were getting, but it
> > wasn't that.
> 
> It was AFAICS, though of course it shouldn't be.

I didn't note the reason for the oops.  Was it a segmentation violation?  
The usb_device memory isn't deallocated until the reference count goes to 
0.  Maybe something was doing an extra usb_put_dev.

Alan Stern

