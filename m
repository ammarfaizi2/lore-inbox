Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUATDS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUATDS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:18:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49034 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263800AbUATDSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:18:53 -0500
Message-ID: <400C9DED.3040208@us.ibm.com>
Date: Mon, 19 Jan 2004 21:18:05 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kobj_to_dev ?
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com> <20040117001739.GB3840@kroah.com> <400C3D87.3010502@us.ibm.com> <20040120000405.GA5656@kroah.com> <1DFA0D5A-4ADF-11D8-B557-000A95A0560C@us.ibm.com> <20040120005338.GA5954@kroah.com>
In-Reply-To: <20040120005338.GA5954@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2004, at 6:53 PM, Greg KH wrote:

 > I don't know.  If you enable debugging for kobjects (in kobject.c) do
 > you see any kobjects getting added to your bus with no name?

Sigh, that took too long.

c000000001d29828 -- address of the struct device I register
c000000001d29818 -- address present in vio_bus_type.devices.list

I think the problem is that bus_add_device() adds a struct device to 
bus_type.devices.list, but that's a a kset! So it contains a list of 
kobjects, not devices. The obvious fix doesn't work because 
driver_attach() got it wrong too. However it seems bus_for_each_dev() 
got it right.

This patch compiles but I haven't tested the driver_attach() part yet. 
Oh also to_dev is different in bus.c than in core.c, so I don't think it 
will work here. I'm going home... I have a vague feeling that some other 
language might work better for all this list stuff..

-- 
Hollis Blanchard
IBM Linux Technology Center

===== drivers/base/bus.c 1.52 vs edited =====
--- 1.52/drivers/base/bus.c     Tue Sep 30 10:59:35 2003
+++ edited/drivers/base/bus.c   Mon Jan 19 21:19:18 2004
@@ -337,7 +337,12 @@
                 return;

         list_for_each(entry,&bus->devices.list) {
-               struct device * dev = container_of(entry,struct 
device,bus_list);
+               struct kobject * kobj = container_of(entry,struct 
kobject,entry);
+               struct device * dev;
+
+               if (!kobj)
+                       return;
+               dev = container_of(kobj,struct device,kobj);
                 if (!dev->driver) {
                         error = bus_match(dev,drv);
                         if (error && (error != -ENODEV))
@@ -405,7 +410,7 @@
         if (bus) {
                 down_write(&dev->bus->subsys.rwsem);
                 pr_debug("bus %s: add device %s\n",bus->name,dev->bus_id);
-               list_add_tail(&dev->bus_list,&dev->bus->devices.list);
+               list_add_tail(&dev->kobj.entry,&dev->bus->devices.list);
                 device_attach(dev);
                 up_write(&dev->bus->subsys.rwsem);
 
sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);

