Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbTLKKVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLKKVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:21:51 -0500
Received: from mail1.kontent.de ([81.88.34.36]:61375 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264877AbTLKKTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:19:32 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 11:19:00 +0100
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101758.02334.oliver@neukum.org> <200312111045.11275.baldrick@free.fr>
In-Reply-To: <200312111045.11275.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111119.00289.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Dezember 2003 10:45 schrieb Duncan Sands:
> > > > > __usb_set_configuration - lockless version
> > > > > usb_set_configuration - locked version
> > > >
> > > > Partially done.
> > > > That's what the _physical version of usb_reset_device() is about.
> > >
> > > Unfortunately, usb_physical_reset_device calls usb_set_configuration
> > > which takes dev->serialize.
> >
> > That is bad, but the solution is obvious.
> > All such operations need a _physical version.
> > At first sight this may look less elegant than some lock dropping schemes,
> > but it is a solution that produces obviously correct code paths with
> > respect to locking.
> 
> Hi Oliver, I agree, except that there are several layers of locking: dev->serialize
> but also the bus rwsem.  So does "physical" mean no subsys.rwsem or no
> dev->serialize or both?

"physical" means no locking at all. It's the caller's responsibility.

> int usb_reset_device(struct usb_device *udev)
> {
>         struct device *gdev = &udev->dev;
>         int r;
> 
>         down_read(&gdev->bus->subsys.rwsem);
>         r = usb_physical_reset_device(udev);
>         up_read(&gdev->bus->subsys.rwsem);
> 
>         return r;
> }

That's what the core cares about. No probe() while a reset is in
progress. Taking the semaphore ensures that.

	Regards
		Oliver

