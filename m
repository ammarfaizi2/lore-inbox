Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937261AbWLDSsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937261AbWLDSsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937262AbWLDSsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:48:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:53052 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937261AbWLDSsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:48:01 -0500
Date: Mon, 4 Dec 2006 10:47:50 -0800
From: Greg KH <gregkh@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Message-ID: <20061204184750.GA22139@suse.de>
References: <200612012343.07251.oliver@neukum.org> <20061204044344.GB10078@in.ibm.com> <200612040738.00923.oliver@neukum.org> <20061204130406.GA2314@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204130406.GA2314@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 06:34:06PM +0530, Maneesh Soni wrote:
> On Mon, Dec 04, 2006 at 07:38:00AM +0100, Oliver Neukum wrote:
> > Am Montag, 4. Dezember 2006 05:43 schrieb Maneesh Soni:
> > > On Fri, Dec 01, 2006 at 11:43:06PM +0100, Oliver Neukum wrote:
> > > > Hi,
> > > >
> > > > Alan Stern has discovered a race in sysfs, whereby driver callbacks could be
> > > > called after sysfs_remove_file() has run. The attached patch should fix it.
> > > >
> > > > It introduces a new data structure acting as a collection of all sysfs_buffers
> > > > associated with an attribute. Upon removal of an attribute the buffers are
> > > > marked orphaned and IO on them returns -ENODEV. Thus sysfs_remove_file()
> > > > makes sure that sysfs won't bother a driver after that call, making it safe
> > > > to free the associated data structures and to unload the driver.
> > > >
> > > > 	Regards
> > > > 		Oliver
> > >
> > > Hi Oliver,
> > >
> > > Thanks for the explaining the patch but some description about the race
> > > would also help here. At the least the callpath to the race would be useful.
> > >
> > >
> > > Thanks
> > > Maneesh
> > 
> > We have code like this:
> >  static void tv_disconnect(struct usb_interface *interface)
> > {
> > 	struct trancevibrator *dev;
> > 
> > 	dev = usb_get_intfdata (interface);
> > 	device_remove_file(&interface->dev, &dev_attr_speed);
> > 	usb_set_intfdata(interface, NULL);
> > 	usb_put_dev(dev->udev);
> > 	kfree(dev);
> > }
> > 
> > This has a race:
> > 
> > CPU A				CPU B
> > open sysfs
> > 					device_remove_file
> > 					kfree
> > reading attr
> > 
> > We cannot do refcounting as sysfs doesn't export open/close. Therefore
> > we must be sure that device_remove_file() makes sure that sysfs will
> > leave a driver alone after the return of device_remove_file(). Currently
> > open will fail, but IO on an already opened file will work. The patch makes
> > sure it will fail with -ENODEV without calling into the driver, which may
> > indeed be already unloaded.
> > 
> > 	Regards
> > 		Oliver
> 
> hmm, I guess Greg has to say the final word. The question is either to fail
> the IO (-ENODEV) or fail the file removal (-EBUSY). If we are not going to
> fail the removal then your patch is the way to go.

We can't fail the removal, as we just aren't allowed to do that at times
(the device is physically removed).

So failing the IO is the way to go.

thanks,

greg k-h
