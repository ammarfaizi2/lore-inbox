Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTIYSMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIYSLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:11:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:12245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261820AbTIYSJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:09:48 -0400
Date: Thu, 25 Sep 2003 11:05:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Jon Smirl <jonsmirl@yahoo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sysfs - which driver for a device?
In-Reply-To: <20030924020344.55460.qmail@web14905.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0309251102270.947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In sysfs it is easy to see which devices a driver is supporting.
> For example /sys/bus/pci/drivers/e1000 links to 0000:02:0c.0 in my system.
> 
> But how do you go the other way; starting from 0000:02:0c.0 to determine the
> driver? Is the best solution to loop though the drivers directories searching
> for the device? Or would it be better to change sysfs to add an attribute to
> each device containing the driver name?

Well, one could use a script to ascertain the driver name for a given 
device. Or, you could use the patch below, which will insert a 'driver' 
symlink that points to the device driver's directory. 


	Pat

===== drivers/base/bus.c 1.51 vs edited =====
--- 1.51/drivers/base/bus.c	Fri Aug 29 14:18:26 2003
+++ edited/drivers/base/bus.c	Thu Sep 25 10:55:14 2003
@@ -243,6 +243,7 @@
 	list_add_tail(&dev->driver_list,&dev->driver->devices);
 	sysfs_create_link(&dev->driver->kobj,&dev->kobj,
 			  kobject_name(&dev->kobj));
+	sysfs_create_link(&dev->kobj,&dev->driver->kobj,"driver");
 }
 
 
@@ -365,6 +366,7 @@
 	struct device_driver * drv = dev->driver;
 	if (drv) {
 		sysfs_remove_link(&drv->kobj,kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj,"driver");
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)

