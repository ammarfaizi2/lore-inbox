Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUHMRKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUHMRKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUHMRKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:10:11 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:53476 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266244AbUHMRJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:09:39 -0400
Message-ID: <411CF5CD.9020207@embeddedintelligence.com>
Date: Fri, 13 Aug 2004 13:09:33 -0400
From: Stephen Glow <sglow@embeddedintelligence.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040726
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to generate hotplug events in drivers?
References: <411C1EC0.3010302@embeddedintelligence.com> <20040813070643.GA6785@kroah.com>
In-Reply-To: <20040813070643.GA6785@kroah.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
| udev needs to see a file called "dev" in the proper structure show up in
| the sysfs tree in either /sys/class/* or /sys/block/*.  So, you need to
| either use the misc char device interface, the block interface, some
| other char interface that already has sysfs support, or add your own.
| If you need to add your own, I suggest looking into the class_simple
| interface, as that's a lot easier to work with to start out with.
|
| Hope this helps,
|
| greg k-h

Hi Greg;

Thanks for the response, things seem to be working now.

I'm still a little fuzzy about how all this works together, but the
picture is starting to become a bit clearer.  Here are the basic steps I
took in my PCI driver to get the device node to show up, please let me
know if anyone sees an error here:

In the init module function, I create a new class_simple pointer:

static struct class_simple *myclass;

int init_module( void )
{
~    ...
~    myclass = class_simple_create( THIS_MODULE, "myclassname" );
~    ...
}

This causes the new class directory to show up under /sys/class

In the PCI probe function I do the following:

probe(...)
{
~   ...

~   // Allocate a device numer
~   dev_t mydev;
~   alloc_chrdev_region( &mydev, 0, 1, "mydevicename" );

~   // Add this device number to my class.  Note I'm passing NULL for
~   // the device pointer.  I'm not exactly sure what this is for, but
~   // most devices in the kernel tree seem to pass NULL here.
~   class_simple_add_device( myclass, mydev, NULL, "mydevicename" );

~   // Finally, I init and add my cdev structure.
~   cdev_init( &mycdev, &myfops );
~   mycdev.owner = THIS_MODULE;
~   kobject_set_name( &mycdev.kobj, "mydevicename" );
~   cdev_add( &mycdev, mydev, 1 );

~   ...
}

Of course, my real code has error checking and does cleanup in the PCI
remove function and the module exit function.

Thanks again!

Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBHPXNDMBOo/wgA5QRAlAkAKCFrxmtrkEhVcCPQ8pBZzPQZccM5ACeJz/e
G/ulXO9/OdoScmgwSBJJ3xM=
=ylWm
-----END PGP SIGNATURE-----
