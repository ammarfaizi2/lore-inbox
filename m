Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbSJJBr1>; Wed, 9 Oct 2002 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJJBr1>; Wed, 9 Oct 2002 21:47:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32207 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262568AbSJJBr0>;
	Wed, 9 Oct 2002 21:47:26 -0400
Date: Wed, 9 Oct 2002 21:53:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: [RFC] gendisk refcounting
Message-ID: <Pine.GSO.4.21.0210092136040.10320-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, I think I've figured it out.  Presuming that we are going to have
at least one struct device in struct gendisk, we need the following:

	* destruction of struct gendisk is triggered by ->release()

Agreed?

	Now, we also need references that didn't come from driverfs.
E.g. opened struct block_device will need to hold a pointer to gendisk.

	I can live with ->refcount for one of struct device acting as
global refcount.  Then put_disk(disk) turns into put_device(&disk->dev)
and get_disk(disk) - into atomic_inc() on disk->dev.refcount (we
do that only when we hold a reference to disk).

	->release() for disk->dev would act as destructor for gendisk.

	There is only one problem.  Namely, we might never call
device_register() at all or call it some time after the thing had
been allocated.  Notice that we have separate moments when device
is unregistered and freed.  And that's fine.  What we don't have is
similar splitup on the creation end of things.

	I.e. it would be really nice if we had device_initialize(dev)
and device_add(dev); the former setting refcount/initializing lists/etc.
and the latter doing the rest of device_register().  Then we have a nice
symmetric picture - and a nice way to piggyback on struct device refcounting.

	alloc_disk() would do device_initialize(&disk->dev).
	get_disk() would be atomic_inc(&disk->dev.refcount).
	add_disk() would do device_add(&disk->dev) letting the world see it.
	del_gendisk() would do device_unregister(&disk->dev).
	put_disk() would be device_put(&disk->dev).
	and release_disk() would be ->release() of disk->dev, triggered when
(shared) refcount hits zero and actually freeing stuff.

That's it - now refcount for struct gendisk is guaranteed to be consistent
with struct device, simply because it _is_ refcount of struct device.

Folks, does that work for you?  Linus, Pat?

