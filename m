Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271229AbTHMWbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTHMWbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:31:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57735 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271229AbTHMWbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:31:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Niehusmann <jan@gondor.com>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Date: Thu, 14 Aug 2003 00:32:00 +0200
User-Agent: KMail/1.5
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030806150335.GA5430@gondor.com> <20030813132733.GA6565@win.tue.nl> <20030813220532.GA1799@gondor.com>
In-Reply-To: <20030813220532.GA1799@gondor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308140032.00632.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 of August 2003 00:05, Jan Niehusmann wrote:
> On Wed, Aug 13, 2003 at 03:27:33PM +0200, Andries Brouwer wrote:
> > Ah, yes, it was that one. Yes, my patch turned into a mess of rejects
> > after your layout changes of earlier patches from that series.
>
> Here is the most important part (limiting the disk capacity to 137GB if
> LBA48 is not available) as a patch agains 2.4.21. The goto is not nice,
> but I didn't want to do a major rewrite.

Major rewrite is already present in 2.6.0-test3 and there is more to go.

> Note that the function contains a bogous if-clause:
>
> 	if (id->cfs_enable_2 & 0x0400) {
> 	[...]
> 		return;
> 	}
> 	[...]
> 	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
> 	[...]
>
> The second if-condition can never be true. But I didn't want to touch
> that stuff.

Already removed from 2.6.

> --- linux-2.4.21/drivers/ide/ide-disk.c.orig	2003-08-13 23:14:32.000000000
> +0200 +++ linux-2.4.21/drivers/ide/ide-disk.c	2003-08-13 23:14:34.000000000
> +0200 @@ -1196,7 +1196,7 @@
>  		drive->bios_cyl		= drive->cyl;
>  		drive->capacity48	= capacity_2;
>  		drive->capacity		= (unsigned long) capacity_2;
> -		return;
> +		goto check_capacity48;
>  	/* Determine capacity, and use LBA if the drive properly supports it */
>  	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
>  		capacity = id->lba_capacity;
> @@ -1228,6 +1228,15 @@
>  		drive->sect = 63;
>  		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head *
> drive->sect); }
> +
> +check_capacity48:
> +	/* Limit disk size to 137GB if LBA48 addressing is not supported */
> +	if (drive->addressing == 0 && drive->capacity48 > (1ULL)<<28) {
> +		printk("%s: cannot use LBA48 - capacity reset "
> +			"from %llu to %llu\n",
> +			drive->name, drive->capacity48, (1ULL)<<28);
> +		drive->capacity48 = (1ULL)<<28;
> +	}
>  }
>
>  static unsigned long idedisk_capacity (ide_drive_t *drive)

Yep, thats basically it.

Have you already tried doing LBA-48 as previously suggested
(after applying hang-fix of course)?

--bartlomiej

