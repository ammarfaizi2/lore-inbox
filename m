Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFRUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFRUrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFRUpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:45:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:27788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262085AbUFRUl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:41:27 -0400
Date: Fri, 18 Jun 2004 13:23:05 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG(?): class_device_driver_link()
Message-ID: <20040618202305.GB18008@kroah.com>
References: <Pine.LNX.4.44L0.0406181502020.702-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406181502020.702-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 04:12:32PM -0400, Alan Stern wrote:
> Greg:
> 
> I'm not sure if this is a bug or not, but it is inconsistent behavior in 
> sysfs.
> 
> When a class_device is added, if it has a regular device associated with
> it and that device has a driver, a symlink is added from the class_device
> to the driver.  However, if the class_device is added _first_ and the
> driver later, this symlink is not created.  It's not clear that there's
> any good way to create it, especially if the class_device is added by the
> bus layer and the device driver itself is unaware of the class_device.

Yes, this is the way it was designed.  The thinking was that a device
would be registered to a driver by the time the class code was
initialized for it.

> Is this a known problem?  It definitely affects the sd driver, and maybe 
> others.

The sd use of classes is a monumental hack.  So much that every time I
see one of them in the hall at work I run the other way just to avoid
talking about it again :)

No, seriously, if this is a problem for the sd driver, we should fix it.

> There is a related side-effect that is a bit unpleasant.  The symlink from
> the class_device to the driver increments the driver's refcount.

Yes, that is a recent change.

> Since
> the driver is unaware of the class_device, it doesn't know to remove the
> symlink when its release() method runs.

The symlink should be removed by the class, right?

> Consequently, if the driver is
> modprobed before the device exists and rmmod'ed after the device is added,
> the rmmod will hang until the device also goes away.  But if the driver is 
> modprobed _after_ the device exists then the rmmod will complete 
> immediately.
> 
> Perhaps the answer is that the bus layer must take these things into 
> account.  Or perhaps a struct device should somehow know about all the 
> class_devices that refer to it.

Hm, I was not wanting to have to have struct device know about classes,
only classes knowing about struct devices.  Any input here would be
appreciated.

thanks,

greg k-h
