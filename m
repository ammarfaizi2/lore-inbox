Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRG0Xk6>; Fri, 27 Jul 2001 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265377AbRG0Xkr>; Fri, 27 Jul 2001 19:40:47 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:43694
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S264447AbRG0Xke>; Fri, 27 Jul 2001 19:40:34 -0400
Message-ID: <000701c116f5$8268a820$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>,
        "Richard Gooch" <rgooch@ras.ucalgary.ca>
Cc: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>,
        "devfs mailing list" <devfs@oss.sgi.com>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net>
Subject: Re: [PATCH]: ide-floppy & devfs
Date: Fri, 27 Jul 2001 16:40:25 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Also note that I have already forwarded a patch to Richard to make the devfs
nodes that get created when grok_partitions runs get removed when the media
is removed and new media is validated (i.e. the partition nodes will stay in
sync with the cartridge in the drive).

----- Original Message -----
From: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>
To: "Richard Gooch" <rgooch@ras.ucalgary.ca>
Cc: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>; "devfs mailing list"
<devfs@oss.sgi.com>; "Linux Kernel mailing list"
<linux-kernel@vger.kernel.org>
Sent: Friday, July 27, 2001 12:34 PM
Subject: [PATCH]: ide-floppy & devfs


>
> Hi,
>
> The following patch causes ide-floppy to register a disc
> even if no cartridge is in the drive, so that devfs creates
> nodes for the drive for later use. Without this patch,
> if devfs is used, no device node is ever created, and
> ide-floppy must be rmmoded and reloaded if a floppy is inserted
> into a drive that was empty at boot time.
>
> The reason is that grok_partitions() returns immediately if the
> device passed has a size parameter of 0, which was the case
> in ide-floppy with no cartrifge in the drive.
>
> The patch is against 2.4.7.
>
> It is somewhat a hack, perhaps somebody else finds a more elegant
> way to do it. But it makes sense that an empty drive
> does not return a capacity of 0, but the capacity of a standard media
> cartridge.
>
> Martin
>
> --
> Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
> FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113
>
> --- 2.4.7a/drivers/ide/ide-probe.c Sun Mar 18 18:25:02 2001
> +++ 2.4.7/drivers/ide/ide-probe.c Fri Jul 27 23:01:49 2001
> @@ -122,6 +122,7 @@
>   printk("cdrom or floppy?, assuming ");
>   if (drive->media != ide_cdrom) {
>   printk ("FLOPPY");
> + drive->removable = 1;
>   break;
>   }
>   }
> --- 2.4.7a/drivers/ide/ide-floppy.c Wed Jul 25 20:20:44 2001
> +++ 2.4.7/drivers/ide/ide-floppy.c Fri Jul 27 23:00:38 2001
> @@ -1279,7 +1279,15 @@
>   printk (KERN_NOTICE "%s: warning: non 512 bytes block size not fully
supported\n", drive->name);
>   rc = 0;
>   }
> - }
> + } else if (!i && descriptor->dc == CAPACITY_NO_CARTRIDGE
> +    && drive->removable && !(length % 512)) {
> +         /*
> +    Set these two so that idefloppy_capacity returns a positive value,
> +    needed for devfs registration.
> + */
> + floppy->blocks = blocks;
> + floppy->bs_factor = length / 512;
> + };
>  #if IDEFLOPPY_DEBUG_INFO
>   if (!i) printk (KERN_INFO "Descriptor 0 Code: %d\n", descriptor->dc);
>   printk (KERN_INFO "Descriptor %d: %dkB, %d blocks, %d sector size\n", i,
blocks * length / 1024, blocks, length);
>
>
>
>

