Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLHVzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTLHVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:55:51 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:47548 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262052AbTLHVzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:55:47 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Mon, 8 Dec 2003 22:55:43 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081538510.2034-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081538510.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312082255.43481.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can't keep the ps->devsem lock and use ps->dev->serialize, because it
> > leads to deadlock.
>
> How so?  Remember that I am almost totally unfamiliar with the details of
> the usbfs code.  Are you saying there are places where the driver holds
> one lock and needs to acquire the other and vice versa?

Yes.  ps->devsem is used to protect against disconnection: all top level
routines take it (as a read lock), and in driver_disconnect it is taken as a
write lock.  Top level routines call lower level routines which sometimes
need to take dev->serialize (and do already in several places).

Thus: ps->devsem taken, then dev->serialize.

However, dev->serialize is taken by the USB core before calling
driver_disconnect.

Thus: dev->serialize taken, then ps->devsem.

> >  Actually, simply replacing ps->devsem with ps->dev->serialize
> > cannot lead to any new deadlocks, it makes deadlocks that could
> > occasionally happen always happen (such deadlocks exist right now in
> > usbfs).  Some of the current deadlocks can be eliminated without giving
> > up ps->devsem, but not all. So the question is: must ps->dev->serialize
> > be used?
>
> It must be held when you call usb_reset_configuration().  It must _not_ be
> held when you call usb_set_configuration().  For usb_reset_device() right
> now you must not hold it, although that may change in the future.  For
> usb_unbind_interface() you must not hold it.  There's a note that
> usb_driver_claim_interface() grabs the BKL for some reason having to do
> with usbfs -- no doubt when usbfs is fixed that won't be needed and the
> caller will be required to hold dev->serialize instead.

Right.  And why should (for example) dev->serialize not be held when it
calls usb_set_configuration? - because usb_set_configuration takes
dev->serialize.  This is one of the places I mentioned above where
deadlock can occur right now.

> If you call usb_ifnum_to_if() you ought to hold the serialize lock;
> otherwise the configuration might change out from under you.  But it's not
> necessary.  Likewise for usb_epnum_to_ep_desc if you're looking up an
> endpoint that isn't part of an interface you have bound.

Why isn't it necessary?  As far as I can see it is vital.

> > > Are they any reasons for not keeping ps->devsem?  Since usbfs generally
> > > acts as a driver and drivers generally don't have to concern themselves
> > > with usbdev->serialize (the core handles it for them), shouldn't usbfs
> > > also be able to ignore ps->dev->serialize?
> >
> > No, because it needs to do operations on interfaces it hasn't claimed
> > (such as looking them up and claiming them).  This is why it needs to
> > protect itself, at least momentarily, against configurations shifting
> > under it.  This can be done by using the BKL more.  However it can be
> > done more simply using ps->dev->serialize (in fact it is simpler than
> > what is there now).
>
> That agrees with my assessment.  It ought to be possible to remove these
> references to the BKL in favor of ps->dev->serialize.

Yes, and that is what my patch does.  And due to the above problem with
deadlock it replaces ps->devsem with ps->dev->serialize everywhere.

> > By the way, if it is somehow fatal to do usb_put_dev after disconnect,
> > what is the point of referencing counting at all?  You might as well
> > free up the usb_device structure immediately after disconnect, since
> > there is sure to be a reference before disconnect, and (apparently)
> > there had better not be a reference after disconnect...
>
> There's some sort of misunderstanding here.  It's not fatal to do
> usb_put_dev() after disconnect, provided you called usb_get_dev() earlier.
> I'm not sure what the cause was of the oops you were getting, but it
> wasn't that.

It was AFAICS, though of course it shouldn't be.

Ciao,

Duncan.
