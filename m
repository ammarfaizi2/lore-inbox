Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUA0Xdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUA0Xdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:33:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:432 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263771AbUA0Xd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:33:29 -0500
In-Reply-To: <401026CD.2030600@us.ibm.com>
References: <401026CD.2030600@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0041A388-5121-11D8-B18F-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mochel@digitalimplant.org,
       Andrew Morton <akpm@osdl.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: (driver model) bus kset list manipulation bug
Date: Tue, 27 Jan 2004 17:31:58 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2004, at 1:38 PM, Hollis Blanchard wrote:
>
> I've found a bug in drivers/base/bus.c, where the 
> bus_type.devices.list is treated as a list of device structs. 
> bus_type.devices is a kset though, so devices.list should contain 
> kobjects rather than devices. Here is the diff I've come up with:
>
[big snip]

> @@ -405,7 +405,7 @@
>         if (bus) {
>                 down_write(&dev->bus->subsys.rwsem);
>                 pr_debug("bus %s: add device 
> %s\n",bus->name,dev->bus_id);
> -               list_add_tail(&dev->bus_list,&dev->bus->devices.list);
> +               
> list_add_tail(&dev->kobj.entry,&dev->bus->devices.list);
>                 device_attach(dev);
>                 up_write(&dev->bus->subsys.rwsem);

Here's the problem: dev->kobj is already in use; it's part of the 
global devices_subsys kset.

devices_subsys looks like it's only used for two things: global hotplug 
policy and suspend. Of the 3 hotplug functions it provides 
(dev_hotplug_filter, dev_hotplug_name, and dev_hotplug), 2 of them 
refer to bus data or code anyways.

I'm very surprised to see it's used by device_shutdown(). I thought one 
of the points of the device tree was to do depth-first-suspend, so e.g 
we don't try to suspend a PCI bridge and *then* try to suspend children 
of that bridge. Instead we're walking a global list in the reverse 
order they were registered. I guess this works because busses are 
discovered from the root down, so going backwards will give you the 
deepest first.

I see three options, and I like the last best:
- add another kobject to struct device. This will allow a device to be 
registered with the global devices_subsys as well as a bus.devices kset 
simultaneously.
- change the kset "bus_type.devices" to a normal "list_head*" (which is 
how it's being used today, incorrectly). This will preclude some of the 
nice kobject/kset functionality however (e.g. see last paragraph 
below).
- remove devices_subsys. The hotplug policy is already entirely 
bus-specific anyways. The suspend code can be made to use bus 
structures as well instead of a global device list (can it?).

The point of all of this is I want to be able to call
	device_find("mydevice", &my_bus_type)
device_find() uses kset_find_obj() on the bus_type.devices kset, and 
that doesn't work because bus_type.devices isn't a real kset, and it's 
not a real kset because you can't register device kobjects in it, and 
you can't because those kobjects have already been registered with 
devices_subsys. I could call
	device_find("mydevice", &devices_subsys.kset)
instead, but I already know what bus my device is on; no need to search 
them all...

-- 
Hollis Blanchard
IBM Linux Technology Center

