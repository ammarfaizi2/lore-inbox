Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUAVTkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUAVTkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:40:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5615 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266369AbUAVTkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:40:01 -0500
Message-ID: <401026CD.2030600@us.ibm.com>
Date: Thu, 22 Jan 2004 13:38:53 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mochel@digitalimplant.org
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: (driver model) bus kset list manipulation bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick, I know you've passed maintainership of the driver model code 
on, but I was hoping I could jog your memory.

I've found a bug in drivers/base/bus.c, where the bus_type.devices.list 
is treated as a list of device structs. bus_type.devices is a kset 
though, so devices.list should contain kobjects rather than devices. 
Here is the diff I've come up with:

===== drivers/base/bus.c 1.52 vs edited =====
--- 1.52/drivers/base/bus.c     Tue Sep 30 10:59:35 2003
+++ edited/drivers/base/bus.c   Thu Jan 22 11:22:15 2004
@@ -18,7 +18,7 @@
  #include "base.h"
  #include "power/power.h"

-#define to_dev(node) container_of(node,struct device,bus_list)
+#define to_dev(node) container_of(node,struct device,kobj.entry)
  #define to_drv(node) container_of(node,struct device_driver,kobj.entry)

  #define to_bus_attr(_attr) container_of(_attr,struct bus_attribute,attr)
@@ -164,7 +164,7 @@
         if (!(bus = get_bus(bus)))
                 return -EINVAL;

-       head = start ? &start->bus_list : &bus->devices.list;
+       head = start ? &start->kobj.entry : &bus->devices.list;

         down_read(&bus->subsys.rwsem);
         list_for_each(entry,head) {
@@ -337,7 +337,7 @@
                 return;

         list_for_each(entry,&bus->devices.list) {
-               struct device * dev = container_of(entry,struct 
device,bus_list);
+               struct device * dev = to_dev(entry);
                 if (!dev->driver) {
                         error = bus_match(dev,drv);
                         if (error && (error != -ENODEV))
@@ -405,7 +405,7 @@
         if (bus) {
                 down_write(&dev->bus->subsys.rwsem);
                 pr_debug("bus %s: add device %s\n",bus->name,dev->bus_id);
-               list_add_tail(&dev->bus_list,&dev->bus->devices.list);
+               list_add_tail(&dev->kobj.entry,&dev->bus->devices.list);
                 device_attach(dev);
                 up_write(&dev->bus->subsys.rwsem);
 
sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);

The first hunk you can see is symmetrical with to_drv just below. The 
next hunk, to bus_for_each_dev, makes it match up with bus_for_each_drv 
(I take this as evidence that I'm right). The next hunk, in 
driver_attach, can be compared with device_attach and again you'll see 
the symmetry (to_drv/to_dev).

The last hunk in bus_add_device is where we were inserting the 
device.bus_list rather than devices.kobject.entry into the kset.

These are the only 3 users of the devices kset that I could find. 
Unfortunately when I make these changes I get a panic like so:
    bus_match +0x28
    driver_attach +0xa0
    bus_add_driver +0xdc
    driver_register +0x38
    pci_register_driver +0x6c
    serial8250_pci_init +0x28

I'm having a bit of trouble figuring out what went wrong. Are there 
other users of bus_type.devices that I've missed and need updating? Thanks!

-- 
Hollis Blanchard
IBM Linux Technology Center
