Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUHMRYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUHMRYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMRYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:24:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:47066 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266274AbUHMRYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:24:12 -0400
Date: Fri, 13 Aug 2004 10:23:58 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Glow <sglow@embeddedintelligence.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to generate hotplug events in drivers?
Message-ID: <20040813172358.GB1254@kroah.com>
References: <411C1EC0.3010302@embeddedintelligence.com> <20040813070643.GA6785@kroah.com> <411CF5CD.9020207@embeddedintelligence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411CF5CD.9020207@embeddedintelligence.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 01:09:33PM -0400, Stephen Glow wrote:
> Thanks for the response, things seem to be working now.

Good.

> I'm still a little fuzzy about how all this works together, but the
> picture is starting to become a bit clearer.  Here are the basic steps I
> took in my PCI driver to get the device node to show up, please let me
> know if anyone sees an error here:
> 
> In the init module function, I create a new class_simple pointer:
> 
> static struct class_simple *myclass;
> 
> int init_module( void )
> {
> ~    ...
> ~    myclass = class_simple_create( THIS_MODULE, "myclassname" );
> ~    ...
> }
> 
> This causes the new class directory to show up under /sys/class
> 
> In the PCI probe function I do the following:
> 
> probe(...)
> {
> ~   ...
> 
> ~   // Allocate a device numer
> ~   dev_t mydev;
> ~   alloc_chrdev_region( &mydev, 0, 1, "mydevicename" );
> 
> ~   // Add this device number to my class.  Note I'm passing NULL for
> ~   // the device pointer.  I'm not exactly sure what this is for, but
> ~   // most devices in the kernel tree seem to pass NULL here.
> ~   class_simple_add_device( myclass, mydev, NULL, "mydevicename" );

Pass in a pointer to the struct pci_dev ->dev structure.  Something
like &pci_dev->dev should work well.  Then you will see the "device"
symlink show up in your class device directory in sysfs, which makes
tools like udev much easier to use.

> ~   // Finally, I init and add my cdev structure.
> ~   cdev_init( &mycdev, &myfops );
> ~   mycdev.owner = THIS_MODULE;

Not needed, as it should be pulled from the fops structure.

> ~   kobject_set_name( &mycdev.kobj, "mydevicename" );

Not needed anymore.

> ~   cdev_add( &mycdev, mydev, 1 );

You might want to move the class_simple_add_device() line after the
cdev_add line, just to handle the error conditions easier.

Other than those minor things, this looks good.

thanks,

greg k-h
