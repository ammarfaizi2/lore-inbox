Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTLFA6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLFA6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:58:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:6614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264940AbTLFA6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:58:01 -0500
Date: Fri, 5 Dec 2003 16:56:44 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Mike Gorse <mgorse@mgorse.dhs.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031206005644.GA14249@kroah.com>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201093804.GA6918@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 03:08:04PM +0530, Maneesh Soni wrote:
> On Mon, Dec 01, 2003 at 12:21:14AM +0000, Mike Gorse wrote:
> > With 2.6.0-test11, I get a panic if I disconnect a USB serial device with
> > a fd open on it and then close the fd.  When the device is disconnected,
> > usb_disconnect calls usb_disable_device, which calls device_del, which
> > calls kobject_del, which removes the device's sysfs directory.  If a user
> > space program has the tts device open, then kobject_cleanup and
> > destroy_serial do not get called until the device is closed, but by then
> > the kobject_del call to the interface has caused the tty device's sysfs
> > directory to be nuked from under it.  Eventually sysfs_remove_dir is
> > called and eventually calls simple_rmdir with a dentry with a NULL
> > d_inode, causing an oops.  I can make the Oops go away with the following
> > patch:
> > 
> > --- fs/sysfs/dir.c.orig	2003-11-30 18:59:34.395284712 -0500
> > +++ fs/sysfs/dir.c	2003-11-30 18:59:50.944768808 -0500
> > @@ -83,7 +83,7 @@
> >  	struct dentry * parent = dget(d->d_parent);
> >  	down(&parent->d_inode->i_sem);
> >  	d_delete(d);
> > -	simple_rmdir(parent->d_inode,d);
> > +	if (d->d_inode) simple_rmdir(parent->d_inode,d);
> >  
> >  	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
> >  		 atomic_read(&d->d_count));
> > 
> 
> Hi Mike,
> 
> IMO d->d_inode is not expected to be NULL at this point. The only
> place it can become NULL is in d_delete(d) call, but as the dentry ref.
> count will be atleast 2, even this will not make d_inode NULL and it should
> only unhash the dentry. Probably it will become more clear if you post
> the oops message.
> 
> Mean while, I think kobject_del should not remove corresponding sysfs directory
> until all the other references to kobject has gone. There can be references
> taken in sysfs_open_file() from user space. The following patch moves the  
> sysfs_remove_dir() call, to kobject_cleanup() and I think it may solve your 
> problem also. It will be nice if you can test it.
> 
> Pat, what do you think about the below patch?

I agree with this patch.  It fixes the usbserial oops for me in my
testing.  

But wait, no, this patch is not good...

I think Mike's patch is correct.  Here's the problem (tree simplified
for this example to make it readable):
	- insert usb device, this creates a sysfs directory something
	  like:
		- pci.../usb1/1.0
	- the usbserial driver binds to this device and creates a
	  ttyUSB0 directory:
	  	- pci.../usb1/1.0/ttyUSB0
	- a user opens the ttyUSB0 device node (in /dev) which
	  increments the reference count of the kobject that controls
	  the ttyUSB0 directory in sysfs.
	- the usb device is removed from the system.  In doing this,
	  the driver core, and then the kobject code has to delete the
	  tree 1.0 directory.  
	  
Now at this point, Maneesh, your patch would prevent this directory from
being removed, until after the ttyUSB0 directory is removed.  That's all
well and good, but what happens if we have another USB device plugged
into the same place before this happens.  Then the USB code would try to
create the 1.0 directory over again (the directory names are built off
of the USB topology.  but even if they were built off of something
unique, we would still have a mess...)  If that happens, the creation of
the directory would fail, which is not acceptable.

But Mike's patch allows the whole tree from 1.0 on down to be removed,
and then later, when the ttyUSB0 node is really closed, the directory
will not tried to be removed.  Memory is still cleaned up properly, and
the kobjects are properly reference counted.

I know in the past I've argued against this kind of patch (sorry scsi
people), but now in thinking about it a bunch (and sitting though a
zillion oops messages trying to figure out what's wrong here) I think
this is the correct fix.

Any other opinions?

thanks,

greg k-h
