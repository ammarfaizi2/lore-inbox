Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbSJRP7e>; Fri, 18 Oct 2002 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265252AbSJRP7d>; Fri, 18 Oct 2002 11:59:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31452 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265216AbSJRP7b>;
	Fri, 18 Oct 2002 11:59:31 -0400
Date: Fri, 18 Oct 2002 12:05:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Stephen Cameron <steve.cameron@hp.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mochel <mochel@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.5.43 cciss rescan disk ioctl
In-Reply-To: <20021018094910.A856@zuul.cca.cpqcorp.net>
Message-ID: <Pine.GSO.4.21.0210181156340.21677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Oct 2002, Stephen Cameron wrote:

> Adds CCISS_RESCANDISK ioctl. Applies to 2.5.43 after the 
> previous 9 patches I sent.
> -- steve
> 
>    This is meant to be used in a configuration like 
>    Steeleye's Lifekeeper.  Two hosts connect to the storage, one 
>    reserves disks.  The 2nd will not be able to read the partition 
>    information because of the reservations.  In the event the 1st 
>    system fails, the 2nd can detect this, (via special hardware +
>    software typically) and then take over the storage and rescan 
>    the disks via this ioctl.  


> +		if (minor(inode->i_rdev) != 0) {
> +			/* if not node 0 make sure it is a partition = 0 */	
> +			if (minor(inode->i_rdev) & 0x0f)
> +				return -ENXIO;

That's bogus.  We call ->open() only for entire disk.

> +	kdev = mk_kdev(MAJOR_NR + ctlr, disk->first_minor);
> +	bdev = bdget(kdev_t_to_nr(kdev));
> +	rescan_partitions(disk, bdev);

... and that is (a) obvious leak and (b) broken unless disk is already
open - it will try to do IO on bdev.

More interesting issue, though, is whether we need to bother with
complications coming from that interface anymore.  Notice that
comment re "too many device nodes" doesn't hold these days - that
sort of stuff looks like a candidate for "write command into node
on driverfs" - especially when we are talking about configuring
the device, shutting disks down/starting them up, etc.  Linus, Pat?
Unless I'm mistaken that's precisely the sort of work that is
supposed to live in driverfs...

