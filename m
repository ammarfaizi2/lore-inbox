Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSGJUCl>; Wed, 10 Jul 2002 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSGJUCk>; Wed, 10 Jul 2002 16:02:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:62851 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317597AbSGJUCh>;
	Wed, 10 Jul 2002 16:02:37 -0400
Date: Wed, 10 Jul 2002 13:02:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Driverfs updates 
In-Reply-To: <31410.1026257385@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0207101136580.961-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That code is not quite correct, you need something like this.
> 
> 	spin_lock(&driver_lock);
> 	drv = scan_driver_list();	
> 	if (drv && drv->owner)
> 		if (!try_inc_mod_count(drv->owner))
> 			drv = NULL;
> 	spin_unlock(&driver_lock);	/* either failed or protected by use count */
> 	if (drv && drv->open)
> 		drv->open();

Ok, I'll buy that that works. However, it's terribly inefficient. 

Taking a step back, there are at least three cases when you want to pin 
the driver in memory:

- A user process is opening a driverfs file that the driver owns
- A subsystem is about to call into the driver
- The list of drivers is being iterated over (i.e. when a device gets
  inserted and you need to attach a driver to it)

[ General speaking, this is true for all types of drivers (device, bus,
and class). Even more generally, for objects of any subsystem that can be
modular. To keep it rooted in reality, I'm just talking about device 
drivers. ]

In each case, you have a pointer to the driver, which lives in the module. 
You want to pin the driver, and hence the module, in memory. But, first 
you have to verify that the pointer you have is still a valid pointer. 

The method above requires the driver to be inserted in a global list, and 
scan_driver_list() to look something like:

struct device_driver * scan_driver_list(struct device_driver * drv)
{
	struct list_head * node;
	list_for_each(node,&driver_list) {
		struct device_driver * d = list_entry(node,struct device_driver,global_list);
		if (d == drv)
			return d;
	}
	return NULL;
}

That should work fine, and performance won't matter at all for driverfs 
file open or individual call-ins. But, I'm concerned about the case when 
we iterate over the list of drivers, like during device discovery. Esp. in 
the case when we're discovering a lot of devices.

It would even affect us when we're iterating over the list of devices for 
suspend, resume, and shutdown. Before we call any of the driver's 
callbacks, we want to pin it, causing the entire driver list to be 
iterated over. 

So, while I agree with your solution, I wonder if there is a better way to
do it. The one idea that I've been flirting with in the last couple of 
days to keep a persistant data structure in the kernel for every driver 
that is loaded, modular or not. 

When a module is loaded, and the driver is registered for the first time, 
a small structure is allocated, which includes a name, a refcount maybe, 
and a pointer to the driver itself. 

Even if the driver is unregistered, this structure stays around. If there 
are any any in-flight calls to increment the reference count on the 
driver, they will always have a valid pointer to operate on, making 
validation O(1) instead of O(n). 

If the driver is loaded again, the same structure would be reused. 

This means that for every driver loaded, memory usage would increase by 
~20 bytes + strlen(name). This memory wouldn't be freed. However, given 
the usage model I typically see, it shouldn't be much of a problem - when 
I use modular drivers, I typically load them once and never unload them; 
or if I do unload them, I reload the same ones later on. So, though we're 
leaking memory, it's a small amount at a slow rate.

Besides, as drivers are removed, these structures could be placed on some 
inactive list, which could be purged later on. 

> You only need to lock drv and do try_inc_mod_count() if the use count
> might be 0 at the start of the call.  IOW, you only need that code on a
> drv->open() or equivalent function.  Once the use count is non-zero,
> the module is locked down; it is assumed that drv belongs to the module
> and is also protected.

But, you can't assume that it's non-zero in any case, unless you're in a 
file operation in which you own the entire fops structure; i.e. you get 
some open call in which you're guaranteed that the refcount is bumped up.
For driverfs files, there is one fops structure shared for _all_ files. 
The only thing the drivers get are callbacks to read/write data. 

> close:
> 	if (drv->owner)	/* protected by non-zero mod use count */
> 		__MOD_INC_USE_COUNT(drv->owner);
> 	drv->close();
> 	if (drv->owner)
> 		__MOD_DEC_USE_COUNT(drv->owner);
> 
> There is a very small race on close where the module does
> MOD_DEC_USE_COUNT() which can take the count to 0 but the close routine
> has not returned from the module yet.  Bumping the use count around the
> close call closes that race.

That's not a problem, for the same reason - there is a shared release() 
call for all files, and that exists outside the module. 

	-pat







