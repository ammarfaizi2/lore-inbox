Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUFRWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUFRWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUFRVzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:55:41 -0400
Received: from ida.rowland.org ([192.131.102.52]:7940 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264482AbUFRVgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:36:52 -0400
Date: Fri, 18 Jun 2004 17:36:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG(?): class_device_driver_link()
In-Reply-To: <20040618202305.GB18008@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0406181723020.979-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Greg KH wrote:

> On Fri, Jun 18, 2004 at 04:12:32PM -0400, Alan Stern wrote:
> > Greg:
> > 
> > I'm not sure if this is a bug or not, but it is inconsistent behavior in 
> > sysfs.
> > 
> > When a class_device is added, if it has a regular device associated with
> > it and that device has a driver, a symlink is added from the class_device
> > to the driver.  However, if the class_device is added _first_ and the
> > driver later, this symlink is not created.  It's not clear that there's
> > any good way to create it, especially if the class_device is added by the
> > bus layer and the device driver itself is unaware of the class_device.
> 
> Yes, this is the way it was designed.  The thinking was that a device
> would be registered to a driver by the time the class code was
> initialized for it.

That seems reasonable, but obviously it doesn't work if the driver is
loaded much later.  I don't know what happens when the driver is loaded by
the hotplug system following a device attach, for example, but probably
that won't work either.

> > Is this a known problem?  It definitely affects the sd driver, and maybe 
> > others.
> 
> The sd use of classes is a monumental hack.  So much that every time I
> see one of them in the hall at work I run the other way just to avoid
> talking about it again :)
> 
> No, seriously, if this is a problem for the sd driver, we should fix it.

I'm not sure that it's a problem -- all that happens is the "driver"
symlink under the class_device's directory isn't present.  Also, it will 
affect every SCSI device, not just SCSI disks, since the class_device 
management is done by the central SCSI core.

> > There is a related side-effect that is a bit unpleasant.  The symlink from
> > the class_device to the driver increments the driver's refcount.
> 
> Yes, that is a recent change.

Okay, that explains why I never used to have these difficulties.

> > Since
> > the driver is unaware of the class_device, it doesn't know to remove the
> > symlink when its release() method runs.
> 
> The symlink should be removed by the class, right?

Sure.  But when you rmmod the driver, the class doesn't know that anything
has happened.  There is no link from the driver to the class_device; the
links all go the other way.

> > Consequently, if the driver is
> > modprobed before the device exists and rmmod'ed after the device is added,
> > the rmmod will hang until the device also goes away.  But if the driver is 
> > modprobed _after_ the device exists then the rmmod will complete 
> > immediately.
> > 
> > Perhaps the answer is that the bus layer must take these things into 
> > account.  Or perhaps a struct device should somehow know about all the 
> > class_devices that refer to it.
> 
> Hm, I was not wanting to have to have struct device know about classes,
> only classes knowing about struct devices.  Any input here would be
> appreciated.

I don't know what the best approach is.  Linus would probably say that 
having rmmod hang until the device is gone isn't a problem since unloading 
drivers is only done for development.  As a developer, I find it somewhat 
inconvenient.

Perhaps James will have some ideas about how changes to the SCSI core 
might improve the situation.

Alan Stern

