Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266480AbUAVXgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUAVXgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:36:12 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42956 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266480AbUAVXgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:36:07 -0500
Message-ID: <40105E26.5030600@us.ibm.com>
Date: Thu, 22 Jan 2004 17:35:02 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: mochel@digitalimplant.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: (driver model) bus kset list manipulation bug
References: <401026CD.2030600@us.ibm.com>
In-Reply-To: <401026CD.2030600@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:

> Hi Patrick, I know you've passed maintainership of the driver model code 
> on, but I was hoping I could jog your memory.

Sorry, found the Mozilla "do not wrap" option now.

===== drivers/base/bus.c 1.52 vs edited =====
--- 1.52/drivers/base/bus.c     Tue Sep 30 10:59:35 2003
+++ edited/drivers/base/bus.c   Thu Jan 22 11:22:15 2004
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/module.h>
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
-               struct device * dev = container_of(entry,struct device,bus_list);
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


-- 
Hollis Blanchard
IBM Linux Technology Center
