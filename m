Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJJROF>; Thu, 10 Oct 2002 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJJROF>; Thu, 10 Oct 2002 13:14:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2483 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261593AbSJJROD>;
	Thu, 10 Oct 2002 13:14:03 -0400
Date: Thu, 10 Oct 2002 10:21:56 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] gendisk refcounting
In-Reply-To: <Pine.GSO.4.21.0210092136040.10320-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210100925060.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Alexander Viro wrote:

> 	OK, I think I've figured it out.  Presuming that we are going to have
> at least one struct device in struct gendisk, we need the following:
> 
> 	* destruction of struct gendisk is triggered by ->release()
> 
> Agreed?
> 
> 	Now, we also need references that didn't come from driverfs.
> E.g. opened struct block_device will need to hold a pointer to gendisk.
> 
> 	I can live with ->refcount for one of struct device acting as
> global refcount.  Then put_disk(disk) turns into put_device(&disk->dev)
> and get_disk(disk) - into atomic_inc() on disk->dev.refcount (we
> do that only when we hold a reference to disk).
> 
> 	->release() for disk->dev would act as destructor for gendisk.
> 
> 	There is only one problem.  Namely, we might never call
> device_register() at all or call it some time after the thing had
> been allocated.  Notice that we have separate moments when device
> is unregistered and freed.  And that's fine.  What we don't have is
> similar splitup on the creation end of things.
> 
> 	I.e. it would be really nice if we had device_initialize(dev)
> and device_add(dev); the former setting refcount/initializing lists/etc.
> and the latter doing the rest of device_register().  Then we have a nice
> symmetric picture - and a nice way to piggyback on struct device refcounting.
> 
> 	alloc_disk() would do device_initialize(&disk->dev).
> 	get_disk() would be atomic_inc(&disk->dev.refcount).
> 	add_disk() would do device_add(&disk->dev) letting the world see it.
> 	del_gendisk() would do device_unregister(&disk->dev).
> 	put_disk() would be device_put(&disk->dev).
> 	and release_disk() would be ->release() of disk->dev, triggered when
> (shared) refcount hits zero and actually freeing stuff.
> 
> That's it - now refcount for struct gendisk is guaranteed to be consistent
> with struct device, simply because it _is_ refcount of struct device.

This definitely sounds sane, but...

Do you need a full struct device in struct gendisk? The device 
information, like the driver, power state, etc are redundant with the 
struct device in the (IDE, SCSI) drive structure. The generic disk 
structure doesn't follow the same semantics as a device structure. 

But, there are common fields and interfaces that struct gendisk (and 
several other objects) can benefit from. This is what I was getting at 
yesterday with replacing the struct device in hd_struct with just a struct 
driver_dir_entry. That's of course not enough, but something like: 

struct sys_object {
	struct list_head entry;	/* entry in global list of this type */
	atomic_t refcount;
	u32 present;
	struct driver_dir_entry dir;
	void (*release) (struct sys_object *);
};

We'd wind up with something similar to what you described before, though a 
little more generic:

alloc_disk() - initialize object. 
release_disk() - free object via ->release()
get_disk()/put_disk() - get()/put() on generic object. 

Then, the one thing that really integrates into the driver model: Wrap
add_disk() and del_gendisk() into ->add_device() and ->remove_device()  
of disk_devclass.

disk_devclass is initialized and added to the tree in 
drivers/block/genhd.c::device_init(). Once a driver is bound a device, it 
is added to the class the driver belongs to, which calls struct 
device_class::add_device(), with a pointer to the struct device of the 
drive. 

The other huge benefits of having a generic object like this are:

- all the current driver model objects can share them, along with the code 
  to operate on them. 
- driverfs can easily be taught about them, making reference counting 
  easier.
- The glue layers for adding driverfs support for different object types 
  becomes quite a bit less. 


	-pat











