Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVF3T3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVF3T3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVF3T3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:29:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:48525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262977AbVF3T3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:29:09 -0400
Date: Thu, 30 Jun 2005 10:04:06 -0700
From: Greg KH <greg@kroah.com>
To: mat@mut38-1-82-67-62-65.fbx.proxad.net
Cc: matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
Message-ID: <20050630170406.GA11334@kroah.com>
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com> <42C301F7.4010309@free.fr> <20050629224235.GC18462@kroah.com> <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 09:26:43AM +0200, mat@mut38-1-82-67-62-65.fbx.proxad.net wrote:
> Hi,
> 
> On Wed, Jun 29, 2005 at 03:42:35PM -0700, Greg KH wrote:
> > On Wed, Jun 29, 2005 at 10:17:59PM +0200, matthieu castet wrote:
> > > Hi,
> > > 
> > > Greg KH wrote:
> > > >On Wed, Jun 29, 2005 at 06:59:00PM +0200, matthieu castet wrote:
> > > >
> > > >>Hi,
> > > >>
> > > >>I have a question about sysfs interface.
> > > >>
> > > >>If you open a sysfs file created by a module, then remove it (rmmoding 
> > > >>the module that create this sysfs file), then try to read the opened 
> > > >>file, you often get strange result (segdefault or oppps).
> > > >
> > > >
> > > >What file did you do this for?  The module count should be incremented
> > > >if you do this, to prevent the module from being unloaded.
> > > >
> > > Ok, but if we unplug a device, then disconnect will be called even if we 
> > > opened a sysfs file.
> > 
> > Yes but the device structure will still be in memory, so you will be ok.
> > 
> disconnect method isn't supposed to clear the device structure in memory ?

It all depends on the bus you are talking about :)

> > > Couldn't be a race between the moment we read our private data and check 
> > > it is valid and the moment we use it :
> > > 
> > > Process A (read/write sysfs file) 		Process B (disconnect)
> > > recover our private data from struct device
> > > check it is valid
> > > 						free our private data
> > > do operation on private data
> > 
> > No, you should not be freeing your private data on your own.  You should
> > do that in the device release function.
> But that's what I do !

What type of driver?

> I free it in  device release function = usb_disconnect in my case =
> Process B. Process A is call by sysfs and don't seem serialized with
> Process B.
> Is there another place where I could free my private data later : I don't
> think so.

For usb, no, you are correct.  I was referring to the driver core when
you were mentioning the sysfs stuff, sorry.

Hm, in thinking about it, it might make more sense to rework the usb
core to handle this better.  Possibly add a release() callback to the
driver when the device is actually being freed.  Wouldn't be that hard
to do so, and might cut down on some of the common locking errors.

> The problem is that device_remove_file don't block if the sysfs file is
> opened. So we must serialized A and B with mutex.

Yes.

> > Again, any specific place in the kernel that you see not doing this?
> I believe some drivers expected that sysfs read/write callback are always
> called when the device is plugged so they don't check if
> to_usb_interface/usb_get_intfdata return valid pointer.

Then they should be fixed.  Any specific examples?

> Also I always see driver free their privatre data in device disconnect,
> so if read/write from sysfs aren't serialized with device disconnect
> there are still a possible race like I show in my example.

Yes, you are correct.  Again, any specific drivers you see with this
problem?

thanks,

greg k-h
