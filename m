Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUFSAaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUFSAaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUFSA1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:27:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:46819 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261925AbUFSAY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:24:58 -0400
Date: Fri, 18 Jun 2004 17:03:56 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG(?): class_device_driver_link()
Message-ID: <20040619000356.GC24902@kroah.com>
References: <20040618202305.GB18008@kroah.com> <Pine.LNX.4.44L0.0406181723020.979-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406181723020.979-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 05:36:52PM -0400, Alan Stern wrote:
> On Fri, 18 Jun 2004, Greg KH wrote:
> 
> > On Fri, Jun 18, 2004 at 04:12:32PM -0400, Alan Stern wrote:
> > > Greg:
> > > 
> > > I'm not sure if this is a bug or not, but it is inconsistent behavior in 
> > > sysfs.
> > > 
> > > When a class_device is added, if it has a regular device associated with
> > > it and that device has a driver, a symlink is added from the class_device
> > > to the driver.  However, if the class_device is added _first_ and the
> > > driver later, this symlink is not created.  It's not clear that there's
> > > any good way to create it, especially if the class_device is added by the
> > > bus layer and the device driver itself is unaware of the class_device.
> > 
> > Yes, this is the way it was designed.  The thinking was that a device
> > would be registered to a driver by the time the class code was
> > initialized for it.
> 
> That seems reasonable, but obviously it doesn't work if the driver is
> loaded much later.

The driver is the piece of code that creates a class device, so that can
not happen (scsi model excluded).

> > > Is this a known problem?  It definitely affects the sd driver, and maybe 
> > > others.
> > 
> > The sd use of classes is a monumental hack.  So much that every time I
> > see one of them in the hall at work I run the other way just to avoid
> > talking about it again :)
> > 
> > No, seriously, if this is a problem for the sd driver, we should fix it.
> 
> I'm not sure that it's a problem -- all that happens is the "driver"
> symlink under the class_device's directory isn't present.  Also, it will 
> affect every SCSI device, not just SCSI disks, since the class_device 
> management is done by the central SCSI core.
> 
> > > There is a related side-effect that is a bit unpleasant.  The symlink from
> > > the class_device to the driver increments the driver's refcount.
> > 
> > Yes, that is a recent change.
> 
> Okay, that explains why I never used to have these difficulties.
> 
> > > Since
> > > the driver is unaware of the class_device, it doesn't know to remove the
> > > symlink when its release() method runs.
> > 
> > The symlink should be removed by the class, right?
> 
> Sure.  But when you rmmod the driver, the class doesn't know that anything
> has happened.  There is no link from the driver to the class_device; the
> links all go the other way.

Again, the driver owns the class device.  scsi has something wrong
again.  Time to stop avoiding everyone at work...

thanks,

greg k-h
