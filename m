Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbTLHE5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTLHE5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:57:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27100 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265336AbTLHE5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:57:21 -0500
Date: Mon, 8 Dec 2003 10:26:38 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Mike Gorse <mgorse@mgorse.dhs.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031208045638.GA4667@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com> <20031206005644.GA14249@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206005644.GA14249@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 04:56:44PM -0800, Greg KH wrote:
[..]
> 
> I agree with this patch.  It fixes the usbserial oops for me in my
> testing.  
> 
> But wait, no, this patch is not good...
> 
> I think Mike's patch is correct.  Here's the problem (tree simplified
> for this example to make it readable):
> 	- insert usb device, this creates a sysfs directory something
> 	  like:
> 		- pci.../usb1/1.0
> 	- the usbserial driver binds to this device and creates a
> 	  ttyUSB0 directory:
> 	  	- pci.../usb1/1.0/ttyUSB0
> 	- a user opens the ttyUSB0 device node (in /dev) which
> 	  increments the reference count of the kobject that controls
> 	  the ttyUSB0 directory in sysfs.
> 	- the usb device is removed from the system.  In doing this,
> 	  the driver core, and then the kobject code has to delete the
> 	  tree 1.0 directory.  
> 	  
> Now at this point, Maneesh, your patch would prevent this directory from
> being removed, until after the ttyUSB0 directory is removed.  That's all
> well and good, but what happens if we have another USB device plugged
> into the same place before this happens.  Then the USB code would try to
> create the 1.0 directory over again (the directory names are built off
> of the USB topology.  but even if they were built off of something
> unique, we would still have a mess...)  If that happens, the creation of
> the directory would fail, which is not acceptable.

I see and agree, in this case my patch will create more problems.. Actually the 
problem here is _not_ that the directory is removed even though it is in use. 
The inherent dentry ref. counting should take care for that and 
corresponding dentry will be around as long as there are existing users. The 
problem here is parent going away before child and we are trying to remove the 
child directory more than once.

> But Mike's patch allows the whole tree from 1.0 on down to be removed,
> and then later, when the ttyUSB0 node is really closed, the directory
> will not tried to be removed.  Memory is still cleaned up properly, and
> the kobjects are properly reference counted.
> 
> I know in the past I've argued against this kind of patch (sorry scsi
> people), but now in thinking about it a bunch (and sitting though a
> zillion oops messages trying to figure out what's wrong here) I think
> this is the correct fix.
> 
> Any other opinions?
> 

The only problem with Mike's fix is that it fixes the symptom and does
not fix the real cause. I don't see in which case we can have a NULL
d_inode at that point, checking for that means hiding the real problem.

Probably dump_stack() in sysfs_remove_dir() could bring more light in this 
problem. 

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
