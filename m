Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271525AbTGQV5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271533AbTGQV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:57:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57267 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271525AbTGQV5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:57:42 -0400
Date: Fri, 18 Jul 2003 00:12:10 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: disk geometry
In-Reply-To: <UTC200307172139.h6HLdmr02281.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0307172351320.15109-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Jul 2003 Andries.Brouwer@cwi.nl wrote:

> Dear Bartlomiej,
>
> Long ago I used to take care of disk geometry stuff.
> By some coincidence I looked today at ide-disk.c:init_idedisk_capacity().
> A sad sight. Three times the statement
> 	drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
> Why not once? Or not at all?

I would like to now too.  It looks as it can be simplified.

> Started making a patch, but it got a bit large.
> If I were Linus or Andrew I would never accept it at this stage.
> [Nevertheless, there are actual bugs here, that will cause devices to fail.]
> [Nevertheless, if Linus/Andrew/you are interested, I can come with a slow
> trickle of obviously correct changes fixing this whole area.]

Please finish this patch, it will go into -ide tree later.

> So, instead of a patch just some minor muttering. Maybe you can
> use some of it in future changes.
>
> Disk geometry does not exist. That makes it very confusing.
>
> Properly written code separates cleanly the source of information
> (is it from the user on the kernel command line?
> is it from the disk, from the IDENTIFY DEVICE command?
> is it from the BIOS? (From which BIOS function?)
> is it a guess based on a DOS-type partition table?
> is it some random number like 63 or 255 that we thought might
> be a good idea?).
>
> Properly written code separates cleanly the use of information
> (is it for CHS addressing the disk? then "heads" can be at most 16.
> is it for telling LILO about what we think the BIOS disk translation is?
> then "heads" can be at most 256, maybe at most 255).

So where is this properly written code? ;-)

> The present driver has drive->{head,sect,cyl} for the data
> used for CHS addressing.
> The present driver has drive->bios_{head,sect,cyl} for the translation
> data we think the BIOS uses.
>
> It follows that lines like "drive->head = 255;" are bugs.
>
> What is the use of
>
>         if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
>                 drive->capacity48 = id->lba_capacity_2;
>                 drive->head = 255;
>                 drive->sect = 63;
>                 drive->cyl = (unsigned long)(drive->capacity48)
> 			   / (drive->head * drive->sect);
>         }
>
> ? If the disk knows about 48-bit LBA then probably it will not be
> addressed by CHS, but still - why change drive->head? To some
> ridiculous value?

Don't know, I need to check with ATA standard.
Also Andre added to cc:.

> It also follows that lines like "drive->id->lba_capacity_2 = ..."
> are very undesirable. Here the kernel modifies the disk report
> with some of its own inventions. But drive->id should be the
> unmodified IDENTIFY DRIVE output. Whatever the kernel thinks
> about the disk capacity should be written in drive->foocapacity.
> Lines like this make the HDIO_GET_IDENTITY ioctl rather worthless:
> one wants to investigate some disk problem, but the ioctl does not
> tell us what the disk reported, and instead gives some polluted version.

I think HDIO_GET_IDENTIFY should be fixed to read identify data directly
from device, just like /proc/ide/hdx/identify now does.

> Looking at this was prompted by reports on problems with pdcraid.
> It seems its geometry plays some role, so it is necessary to recognize
> precisely which geometry it is that plays a role, and then use the
> proper unmodified one.

Yes, I've read this thread.

Thanks for your comments,
--
Bartlomiej

> Andries

