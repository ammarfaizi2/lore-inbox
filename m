Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282819AbRLLGAw>; Wed, 12 Dec 2001 01:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLLGAm>; Wed, 12 Dec 2001 01:00:42 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58781 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282819AbRLLGAc>; Wed, 12 Dec 2001 01:00:32 -0500
Date: Tue, 11 Dec 2001 23:00:25 -0700
Message-Id: <200112120600.fBC60PR10830@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs=only and boot
In-Reply-To: <Pine.GSO.4.21.0112101847410.14238-100000@binet.math.psu.edu>
In-Reply-To: <200112101824.fBAIOLJ22603@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0112101847410.14238-100000@binet.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 10 Dec 2001, Richard Gooch wrote:
> 
> > Alexander Viro writes:
> > > 	Richard, just how devfs=only is supposed to work with
> > > loading ramdisk from floppies?
> > 
> > IIRC, it's supposed to work just like normal reading from a
> > floppy. That should still work.
> 
> How?  blkdev_get() is not going to work in that case...

To clarify: are you saying that normal floppy access cannot work with
devfs=only? I assure you, it works with 2.4.17.

> > > 	BTW, with initrd exiting with real-root-dev set (regardless of
> > > devfs=only) your code still goes by root_device_name and ignores new
> > > ROOT_DEV.  Again, what behaviour is expected?
> > 
> > The intent is that root_device_name is changed, so it should just
> > work. Has something broken? AFAIK, this too used to work.
> 
> What would change it?  We have ROOT_DEV = new_root_dev; in
> change_root(), so your ROOT_DEVICE_NAME is non-NULL...  What's more,
> where are you going to get the new name?

Sorry, scratch what I said, I've just had a chance to look at the
code. OK, the way it's supposed to work is that after the
change_root(), ROOT_DEVICE_NAME points to root_device_name, which
should contain the "final" root device.

But while loading the RD from floppy, it has to use ROOT_DEV, which is
the RD device number. I think what you're wondering is how that can
work if you pass "devfs=only", right? Well, it should work, because
rd.c calls register_blkdev() and *not* devfs_register_blkdev(). So a
call to blkdev_get() should always work.

Does this help?

> > Alexander Viro writes:
> > > 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> > > fs/devfs/base.c.  Calling ->check_media_change() with no protection
> > > whatsoever.  If rmmod happens at that point...
> > 
> > How about if I do this sequence:
> > 	lock_kernel();
> > 	devfs checks;
> > 	if (bd_op->owner)
> > 		__MOD_INC_USE_COUNT(bd_op->owner);
> > 	revalidate();
> > 	if (bd_op->owner)
> > 		__MOD_DEC_USE_COUNT(bd_op->owner);
> > 	unlock_kernel();
> > 
> > Is there any reason why that won't work?
> 
> For one thing, the situation when you are already half-way through the
> module removal.  At least use try_inc_mod_count().

Fair enough. So do you see anything wrong with this sequence:
	lock_kernel();
	if (devfs_sees_it() && bd_op->owner && try_inc_mod_count(bd_op->owner))
	{
		revalidate();
		__MOD_DEC_USE_COUNT(bd_op->owner);
	}
	unlock_kernel();

Any more problems you can see?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
