Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTLIKw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTLIKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:52:57 -0500
Received: from maclaurence.math.u-psud.fr ([129.175.50.15]:55168 "EHLO
	perso.free.fr") by vger.kernel.org with ESMTP id S262750AbTLIKwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:52:41 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 11:23:54 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091123.54412.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes.  ps->devsem is used to protect against disconnection: all top level
> > routines take it (as a read lock), and in driver_disconnect it is taken
> > as a write lock.  Top level routines call lower level routines which
> > sometimes need to take dev->serialize (and do already in several places).
> >
> > Thus: ps->devsem taken, then dev->serialize.
> >
> > However, dev->serialize is taken by the USB core before calling
> > driver_disconnect.
> >
> > Thus: dev->serialize taken, then ps->devsem.
>
> This is a tricky situation, no doubt about it.
>
> Your situation is a little different from the usual one because ps->devsem
> locks the whole device, not just a single interface.  It should still be
> able to work.  But maybe you're right; since ps->devsem locks the same
> thing as ps->dev->serialize, maybe it's not needed.  By the way, when
> usbfs takes ownership of a device, does it bind to the device's
> interfaces?

Well usbfs never owns anything really.  What it does is allow you (from user
space) to claim and use an interface that nobody else has claimed yet.  Thus
it needs to be able to look at the interfaces of any USB device, find out which
ones are already claimed and maybe claim any ones that are not in use.

> > Right.  And why should (for example) dev->serialize not be held when it
> > calls usb_set_configuration? - because usb_set_configuration takes
> > dev->serialize.  This is one of the places I mentioned above where
> > deadlock can occur right now.
>
> You may simply have to release the lock because calling
> usb_set_configuration and then reacquire it afterwards.

Right, I did this in my patch along with the other changes, but in fact it could
be fixed separately.

> That leads to the question of how to assure that the device doesn't go
> away before usb_set_configuration is called.  Perhaps
> usb_set_configuration and usb_unbind_interface should be changed to
> require the caller to hold the serialize lock.

Well, you could just ensure you have a reference to the usb_device, and
change usb_set_configuration and friends so that they don't Oops if the
device has been disconnected.  This should be done anyway by the way -
surely all core routines should behave themselves (eg: by failing with
an error code) when called with a not-yet-freed struct usb_device?

> > > If you call usb_ifnum_to_if() you ought to hold the serialize lock;
> > > otherwise the configuration might change out from under you.  But it's
> > > not necessary.  Likewise for usb_epnum_to_ep_desc if you're looking up
> > > an endpoint that isn't part of an interface you have bound.
> >
> > Why isn't it necessary?  As far as I can see it is vital.
>
> I mean it won't cause an oops, although it might provide an invalid
> result.  It's not _required_ by the API (maybe it should be).

It will cause an Oops - actconfig may be NULL.  This is the case after
disconnect for example, and also momentarily the case doing configuration
changes.

> Actually, there's another sense in which it's not necessary.  Since
> changing configurations first involves unbinding the existing drivers, if
> you hold a driver-private lock that will block your disconnect routine
> then you can safely call usb_ifnum_to_if even without holding
> dev->serialize.

The disconnect routine is only called if you have claimed an interface.
If usbfs is looking for an interface to claim (and hasn't yet claimed
one), then disconnect will not be called.  There is code in inode.c that
informs usbfs when the device has been disconnected, but now that
disconnect is per-interface, that is not good enough.

> > > There's some sort of misunderstanding here.  It's not fatal to do
> > > usb_put_dev() after disconnect, provided you called usb_get_dev()
> > > earlier. I'm not sure what the cause was of the oops you were getting,
> > > but it wasn't that.
> >
> > It was AFAICS, though of course it shouldn't be.
>
> I didn't note the reason for the oops.  Was it a segmentation violation?
> The usb_device memory isn't deallocated until the reference count goes to
> 0.  Maybe something was doing an extra usb_put_dev.

More on this in another email.

Ciao,

Duncan.
