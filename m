Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRIANbJ>; Sat, 1 Sep 2001 09:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRIANbA>; Sat, 1 Sep 2001 09:31:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25592 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270227AbRIANar>;
	Sat, 1 Sep 2001 09:30:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Sep 2001 13:30:28 GMT
Message-Id: <200109011330.NAA16793@vlet.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This sounds like a fragment in a discussion where I have not seen
the previous fragment.)

        Linus, I've looked into that (allocating ->i_bdev upon open()).
    There are several problems with this approach and none of the solutions I
    can see looks like a clear winner.

    1) when do we drop ->i_bdev?
    2) how should we change the refcounting on struct block_device?
    3) what to do with beasts that don't have major number and just set
    ->i_bdev when they allocate an inode?

(I'll use my own terminology since the above questions about i_bdev
only make sense if you first define the precise intended function of i_bdev.
Probably you'll be able to translate, or tell me what point I should address.)

A kdev_t is a pointer to a struct that has the info now found in
the arrays (and major, minor fields, and a name function..).
This struct is allocated by the driver.
Maybe it is statically compiled in, and no refcounting is needed.
Maybe it is a static struct in the driver which is a module.
Now refcounting is needed so that we can refuse to unload the driver
when the count is nonzero.
Maybe the struct was allocated dynamically, and we need a refcount
to be able to free it again.
Only the driver knows such details.

To be more precise, I usually used two levels: driverstruct and
devicestruct, where a kdev_t is a pointer to a devicestruct
and the devicestruct contains a pointer to the driverstruct.
In the block device case, the handling of devicestructs is the
task of the partitioning code. Of course the driverstructs belong
to the driver.

An inode has fields kdev_t i_dev and dev_t i_rdev and kdev_t i_bcdev
where the last two are significant only for devices, and the last one
only for opened devices. It is the opened version of i_rdev, and
significant whenever non-NULL.
(It was a mistake of mine to make i_rdev a kdev_t: device nodes
can just contain random numbers. The current code contains the same
mistake when the mknod() code does init_special_inode(inode, mode, rdev);
One should first start worrying about rdev when the thing is opened.)

Concerning refcounting:
i_dev comes from s_dev and no refcount is required as long as sb exists
s_dev comes from get_unnamed_dev() or ROOT_DEV or i_bcdev
and a refcount must be incremented when it is set
i_bcdev comes from opening i_rdev and a refcount must be incremented
when it is set.
This "a refcount" is the openct field of the device struct,
somewhat like the present bd_openers.

The decrements of the refcount are done in kill_super() for s_dev
and at the close/umount corresponding to the open/mount that set it for i_bcdev.

Andries
