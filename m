Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284744AbRLJX5Y>; Mon, 10 Dec 2001 18:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLJX5O>; Mon, 10 Dec 2001 18:57:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11163 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284744AbRLJX47>;
	Mon, 10 Dec 2001 18:56:59 -0500
Date: Mon, 10 Dec 2001 18:56:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs=only and boot
In-Reply-To: <200112101824.fBAIOLJ22603@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0112101847410.14238-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > 	Richard, just how devfs=only is supposed to work with
> > loading ramdisk from floppies?
> 
> IIRC, it's supposed to work just like normal reading from a
> floppy. That should still work.

How?  blkdev_get() is not going to work in that case...
 
> > 	BTW, with initrd exiting with real-root-dev set (regardless of
> > devfs=only) your code still goes by root_device_name and ignores new
> > ROOT_DEV.  Again, what behaviour is expected?
> 
> The intent is that root_device_name is changed, so it should just
> work. Has something broken? AFAIK, this too used to work.

What would change it?  We have ROOT_DEV = new_root_dev; in change_root(),
so your ROOT_DEVICE_NAME is non-NULL...  What's more, where are you going
to get the new name?

> I'll try to have a closer look at this tonight. Which kernel version
> are you staring at?

Pretty much anything - heck, 2.4.0 should be the same in that respect.

> Alexander Viro writes:
> > 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> > fs/devfs/base.c.  Calling ->check_media_change() with no protection
> > whatsoever.  If rmmod happens at that point...
> 
> How about if I do this sequence:
> 	lock_kernel();
> 	devfs checks;
> 	if (bd_op->owner)
> 		__MOD_INC_USE_COUNT(bd_op->owner);
> 	revalidate();
> 	if (bd_op->owner)
> 		__MOD_DEC_USE_COUNT(bd_op->owner);
> 	unlock_kernel();
> 
> Is there any reason why that won't work?

For one thing, the situation when you are already half-way through the
module removal.  At least use try_inc_mod_count().

