Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTKKXrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTKKXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:47:05 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:39163 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S263816AbTKKXrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:47:02 -0500
Date: Wed, 12 Nov 2003 00:46:51 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311111348190.1960-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311120039090.909-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> Ok, that's just strange. You can't even _read_ from the raw device, but 
> the mount works ok?

Exactly.

> And you got no IO errors anywhere? I don't see why the write would fail 
> silently.

Nope, no errors anywhere.

> I wonder whether the disk capacity is set to zero. See 
> drivers/ide/ide-cd.c, and in particular the 
> 
>         /* Now try to get the total cdrom capacity. */
>         stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
>         if (stat || !toc->capacity)
>                 stat = cdrom_read_capacity(drive, &toc->capacity, sense);
>         if (stat)
>                 toc->capacity = 0x1fffff;
> 
> and see what that says.. I really think you should start sprinkling 
> printk's around the thing to determine what goes on..

Did that. The code you quote from cdrom_read_toc is never even reached,
the first cdrom_read_tocentry in there just errors out because there
is no toc to read on an MO disk. This leaves the capacity64 member in
the associated ide_drive_t at 0 and also the capacity member in the
corresponding gendisk structure.

On mount, idecd_revalidate_disk gets called and also tries a
cdrom_read_toc, once again leaving the capacity at 0. Nevertheless,
the mount succeeds.

So, reading via dd seems to respect capacity, that explains the "no
space left on device" on writing and the read resulting in zero data
without error. Mounting doesn't even seem to look at the capacity.

My guess would be that an MO drive needs a different way to find out
the capacity than a CD-ROM. After all, when using ide-scsi, it is the
sd driver and not sr that handles the drive. The rest of the problems
could be due to the wrong capacity information?

-- 
Ciao,
Pascal


