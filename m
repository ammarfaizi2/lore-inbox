Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286350AbRLJSZ2>; Mon, 10 Dec 2001 13:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286348AbRLJSZY>; Mon, 10 Dec 2001 13:25:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:1176 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286354AbRLJSY0>; Mon, 10 Dec 2001 13:24:26 -0500
Date: Mon, 10 Dec 2001 11:24:21 -0700
Message-Id: <200112101824.fBAIOLJ22603@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs=only and boot
In-Reply-To: <Pine.GSO.4.21.0112101019001.14238-100000@binet.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112101019001.14238-100000@binet.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	Richard, just how devfs=only is supposed to work with
> loading ramdisk from floppies?

IIRC, it's supposed to work just like normal reading from a
floppy. That should still work.

> 	BTW, with initrd exiting with real-root-dev set (regardless of
> devfs=only) your code still goes by root_device_name and ignores new
> ROOT_DEV.  Again, what behaviour is expected?

The intent is that root_device_name is changed, so it should just
work. Has something broken? AFAIK, this too used to work.

I'll try to have a closer look at this tonight. Which kernel version
are you staring at?

BTW: you didn't respond to my question about fixing devfs+blkdev
races. If my scheme will work, or at least improve things, I'd like to
include that in my next patch. Marcelo is waiting for me to fix
something else. Here's what I wrote a couple of days ago:

Alexander Viro writes:
> 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> fs/devfs/base.c.  Calling ->check_media_change() with no protection
> whatsoever.  If rmmod happens at that point...

How about if I do this sequence:
	lock_kernel();
	devfs checks;
	if (bd_op->owner)
		__MOD_INC_USE_COUNT(bd_op->owner);
	revalidate();
	if (bd_op->owner)
		__MOD_DEC_USE_COUNT(bd_op->owner);
	unlock_kernel();

Is there any reason why that won't work?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
