Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266601AbSKGVym>; Thu, 7 Nov 2002 16:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266602AbSKGVyl>; Thu, 7 Nov 2002 16:54:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16003 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266601AbSKGVyk>; Thu, 7 Nov 2002 16:54:40 -0500
Date: Thu, 7 Nov 2002 14:02:44 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [BUG] 2.5.46 reloading a block device module doesn't probe devices
Message-ID: <20021107220244.GD1690@beaverton.ibm.com>
Mail-Followup-To: Dave Olien <dmo@osdl.org>,
	linux-kernel@vger.kernel.org, mochel@osdl.org
References: <20021107125116.A16707@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107125116.A16707@acpi.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien [dmo@osdl.org] wrote:
> 
> 
> I just converted the DAC960 driver in 2.5.46 to use the pci_register_driver()
> to discover devices.
> 
> I've been experimenting loading the DAC960 driver module, unloading
> the module, and then loading it again.  I get curious behavior.
> The load, unload seem to work fine.
> 
> The reload also APPEARS to succeed. The insmod command completes
> with a successful status.
> 
> But the second loading of the driver never calls the driver's probe routines.
> I added printfs, and determined that the module_init() function
> DOES get called the second time.  But a printf in the probe() routine
> doesn't show up the second time.
> 
> Has there been a patch recently for this problem?

Dave,

In scsi we where having issues of insmod / rmmod not cleaning up sysfs
correctly resulting in secondary insmod problems and shutdown oops. 

The problems where:
 - If no probe routine than a device is attach, but error is returned
   allowing more than one attach.
 - Parent always +2 on device_register.
 - driver_unregister lacks full cleanup.

The patch below contains a few workarounds patmans and I have been using
to get our scsi insmod / rmmod plus shutdown working. Mochel has been
offline for a few days so I have not got any feedback from him on the
correctness.  YMMV.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 bus.c    |    4 +++-
 core.c   |    2 --
 driver.c |    2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)
------

--- 1.22/drivers/base/bus.c	Thu Oct 31 08:20:23 2002
+++ edited/drivers/base/bus.c	Wed Nov  6 22:06:39 2002
@@ -209,8 +209,10 @@
 				attach(dev);
 			else
 				dev->driver = NULL;
-		} else 
+		} else  {
 			attach(dev);
+			error = 0;
+		}
 	}
 	return error;
 }
--- 1.50/drivers/base/core.c	Thu Oct 31 08:20:23 2002
+++ edited/drivers/base/core.c	Wed Nov  6 13:07:47 2002
@@ -173,8 +173,6 @@
 		return -EINVAL;
 
 	device_initialize(dev);
-	if (dev->parent)
-		get_device(dev->parent);
 	error = device_add(dev);
 	if (error && dev->parent)
 		put_device(dev->parent);
--- 1.14/drivers/base/driver.c	Wed Oct 30 16:35:48 2002
+++ edited/drivers/base/driver.c	Wed Nov  6 21:41:48 2002
@@ -127,6 +127,8 @@
 	drv->present = 0;
 	spin_unlock(&device_lock);
 	pr_debug("driver %s:%s: unregistering\n",drv->bus->name,drv->name);
+	bus_remove_driver(drv);
+	kobject_unregister(&drv->kobj);
 	put_driver(drv);
 }
 
