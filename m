Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934378AbWLDGgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbWLDGgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 01:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934422AbWLDGgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 01:36:54 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:20651 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S934378AbWLDGgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 01:36:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: maneesh@in.ibm.com
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Date: Mon, 4 Dec 2006 07:38:00 +0100
User-Agent: KMail/1.8
Cc: gregkh@suse.com, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <200612012343.07251.oliver@neukum.org> <20061204044344.GB10078@in.ibm.com>
In-Reply-To: <20061204044344.GB10078@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612040738.00923.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Dezember 2006 05:43 schrieb Maneesh Soni:
> On Fri, Dec 01, 2006 at 11:43:06PM +0100, Oliver Neukum wrote:
> > Hi,
> > 
> > Alan Stern has discovered a race in sysfs, whereby driver callbacks could be
> > called after sysfs_remove_file() has run. The attached patch should fix it.
> > 
> > It introduces a new data structure acting as a collection of all sysfs_buffers
> > associated with an attribute. Upon removal of an attribute the buffers are
> > marked orphaned and IO on them returns -ENODEV. Thus sysfs_remove_file()
> > makes sure that sysfs won't bother a driver after that call, making it safe
> > to free the associated data structures and to unload the driver.
> > 
> > 	Regards
> > 		Oliver
> 
> Hi Oliver,
> 
> Thanks for the explaining the patch but some description about the race
> would also help here. At the least the callpath to the race would be useful.
> 
> 
> Thanks
> Maneesh

We have code like this:
 static void tv_disconnect(struct usb_interface *interface)
{
	struct trancevibrator *dev;

	dev = usb_get_intfdata (interface);
	device_remove_file(&interface->dev, &dev_attr_speed);
	usb_set_intfdata(interface, NULL);
	usb_put_dev(dev->udev);
	kfree(dev);
}

This has a race:

CPU A				CPU B
open sysfs
					device_remove_file
					kfree
reading attr

We cannot do refcounting as sysfs doesn't export open/close. Therefore
we must be sure that device_remove_file() makes sure that sysfs will
leave a driver alone after the return of device_remove_file(). Currently
open will fail, but IO on an already opened file will work. The patch makes
sure it will fail with -ENODEV without calling into the driver, which may
indeed be already unloaded.

	Regards
		Oliver
