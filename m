Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVCaSEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVCaSEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVCaSEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:04:32 -0500
Received: from digitalimplant.org ([64.62.235.95]:12166 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261616AbVCaSEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:04:23 -0500
Date: Thu, 31 Mar 2005 10:04:11 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503311119010.1510-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0503311000510.7249-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503311119010.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, Alan Stern wrote:

> On Wed, 30 Mar 2005, Patrick Mochel wrote:
>
> > > Having thought it through, I believe all we need for USB support is this:
> > >
> > > 	Whenever usb_register() in the USB core calls driver_register()
> > > 	and the call filters down to driver_attach(), that routine
> > > 	should lock dev->parent->sem before calling driver_probe_device()
> > > 	(and unlock it afterward, of course).
> > >
> > > 	(For the corresponding remove pathway, where usb_deregister()
> > > 	calls driver_unregister(), it would be nice if __remove_driver()
> > > 	locked dev->parent->sem before calling device_release_driver().
> > > 	This is not really needed, however, since USB drivers aren't
> > > 	supposed to touch the device in their disconnect() method.)
> >
> >
> > Why can't you just lock it in ->probe() and ->remove() yourself?
>
> Aha!  There you go...  This explains why you need explicit locking rules.
>
> When probe() and remove() are called, the driver-model core already owns
> the device's lock.  If the driver then tried to lock the parent, it would
> mean acquiring locks in the wrong order.  This could easily lead to
> deadlock.

I should have been more clear. From what I understand, when some devices
are probed they also want to probe and add their children. It *seems* like
this is essentially true with USB devices and interfaces, though I could
be wrong.

What I meant was that when the parent device's ->probe() method is called,
the parent's semaphore could be taken before the children are discovered
and added. This would keep the parent locked while all the fiddling is
going on with the children. Right?


	Pat
