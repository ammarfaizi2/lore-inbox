Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRIAQ0t>; Sat, 1 Sep 2001 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRIAQ0k>; Sat, 1 Sep 2001 12:26:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38532 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270795AbRIAQ0Y>;
	Sat, 1 Sep 2001 12:26:24 -0400
Date: Sat, 1 Sep 2001 12:26:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <200109011330.NAA16793@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0109011208001.18705-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Sep 2001 Andries.Brouwer@cwi.nl wrote:

> A kdev_t is a pointer to a struct that has the info now found in
> the arrays (and major, minor fields, and a name function..).
> This struct is allocated by the driver.
> Maybe it is statically compiled in, and no refcounting is needed.
> Maybe it is a static struct in the driver which is a module.
> Now refcounting is needed so that we can refuse to unload the driver
> when the count is nonzero.
> Maybe the struct was allocated dynamically, and we need a refcount
> to be able to free it again.
> Only the driver knows such details.

Umm... Apply the arguments from the char_device thread - pointers to
unions are rather bad idea.  IOW, kdev_t must die - kernel always
knows which kind we are dealing with.

> To be more precise, I usually used two levels: driverstruct and
> devicestruct, where a kdev_t is a pointer to a devicestruct
> and the devicestruct contains a pointer to the driverstruct.
> In the block device case, the handling of devicestructs is the
> task of the partitioning code. Of course the driverstructs belong
> to the driver.
> 
> An inode has fields kdev_t i_dev and dev_t i_rdev and kdev_t i_bcdev
> where the last two are significant only for devices, and the last one
> only for opened devices. It is the opened version of i_rdev, and
> significant whenever non-NULL.

How do you tell when inode is not opened anymore? Notice that counting
openers of _device_ is wrong answer - several inodes can have the same
major:minor.  By the time when the last one is closed you may have a
lot of trouble finding other ones...

> Concerning refcounting:
> i_dev comes from s_dev and no refcount is required as long as sb exists
> s_dev comes from get_unnamed_dev() or ROOT_DEV or i_bcdev
> and a refcount must be incremented when it is set
> i_bcdev comes from opening i_rdev and a refcount must be incremented
> when it is set.

When do you reset it?

> This "a refcount" is the openct field of the device struct,
> somewhat like the present bd_openers.
> 
> The decrements of the refcount are done in kill_super() for s_dev
> and at the close/umount corresponding to the open/mount that set it for i_bcdev.

??? So you decrement twice on umount?

