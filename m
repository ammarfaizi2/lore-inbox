Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290527AbSA3UNS>; Wed, 30 Jan 2002 15:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290539AbSA3UNH>; Wed, 30 Jan 2002 15:13:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57774 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S290527AbSA3UNB>;
	Wed, 30 Jan 2002 15:13:01 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 30 Jan 2002 20:12:55 GMT
Message-Id: <UTC200201302012.UAA81755.aeb@cwi.nl>
To: etrapani@unesco.org.uy, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clipped disk reports clipped lba size
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:02:14PM -0300, Eduardo Trpani wrote:

> Since my BIOS does not support my disk (WD400) I had to clip to 33.8G.
> At boot time Linux (2.4.17) uses the lba size reported by the disk,
> that is 33.8 and does not allow me to access the rest of the disk.

> +     /* If the geometry has been forced recalculate lba_capacity */
> +     if ((id->capability & 2) && lba_capacity_is_ok(id) &&
> +      drive->forced_geom)
> +     {
> +             id->lba_capacity = drive->bios_head * drive->bios_sect * drive->bios_cyl;
> +     }

This is not really the right patch, although it may solve your problem.
It looks a bit silly to first test lba_capacity_is_ok() and then throw
away lba_capacity anyway.
Using a product of strange numbers is a bad idea.
Often this simple patch will not help, see below.

My point of view would be more like: we now have three levels of information.
First C/H/S - very outdated. On all large disks it will be 16383/16/63.
Then LBA. When it looks reasonable, we believe it, and let it override C/H/S.
Third what the disk returns for READ_NATIVE_MAX_ADDRESS. Especially when LBA
says 33.8GB we have a good reason to ask for this and see whether it is more.

Some disk types fake LBA at 33.8GB, but allow access past this point.
Some disks actually give I/O errors past the 33.8GB (when jumpered),
and a SETMAX command is needed to make the rest accessible.

Two years ago I wrote a tiny utility setmax that does this.
If I am not mistaken this stuff is now part of the 2.5 kernel.
No doubt some of it will eventually be backported to 2.4 / 2.2 / 2.0.
It is in 2.4.18-pre7-ac1.

[Just looked at patch-2.5.3-pre1. And indeed, some nice code.
Andre, others: is there a reason to make CONFIG_IDEDISK_STROKE
a configuration option?  I very much dislike configuration options,
especially in cases like this, where the user may choose between
things happening correctly and things not happening correctly.
And it looks like the option is undocumented as well.
Is setting CONFIG_IDEDISK_STROKE ever harmful?

It looks like the code

+       /* if OK, compute maximum address value */
+       if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
+               addr = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
+                    | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
+                    | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
+                    | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+       }
+       addr++; /* since the return value is (maxlba - 1), we add 1 */
+       return addr;

has a bug: the addr++ should be inside the if(), I suppose.
The same bug occurs a number of places.]

Andries
