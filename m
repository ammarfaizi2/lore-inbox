Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbTGKKkU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269882AbTGKKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:40:20 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32949 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S269881AbTGKKkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:40:10 -0400
Date: Fri, 11 Jul 2003 12:54:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 does not boot - TCQ oops
In-Reply-To: <20030711083437.GG843@suse.de>
Message-ID: <Pine.SOL.4.30.0307111250430.23682-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Jens Axboe wrote:

> On Fri, Jul 11 2003, Jens Axboe wrote:
> > On Fri, Jul 11 2003, Jens Axboe wrote:
> > > On Thu, Jul 10 2003, Ivan Gyurdiev wrote:
> > > > See,
> > > >
> > > > http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html
> > > >
> > > > where the bug is described for 2.5.74.
> > > > I got no replies, and the bug persists in 2.5.75 (+bk patches).
> > > >
> > > > Note:
> > > > The machine boots with TASKFILE on, TCQ is causing the problem.
> > >
> > > Looks like IDE using the queue before it has been setup, probably Bart
> > > broke it when he moved the TCQ init around. I'll take a look.
> >
> > Here's the fix. Bart, you moved the tcq init to a much earlier fase
> > (saying ide_init_drive() was too early, well ide_dma_on is much earlier
> > in the init fase). ide_init_drive() _is_ the correct location in my
> > oppinion, drive and queue has been set up at this point.

Yes, but hey you've acked this change ;-).

> Better still (and later in the probe) is this version. This is in my
> oppinion the correct place to init tcq, and also contains it to ide-disk
> where it should be.

Looks okay, thanks.
--
Bartlomiej

> --- drivers/ide/ide-dma.c~	2003-07-11 10:21:04.492561920 +0200
> +++ drivers/ide/ide-dma.c	2003-07-11 10:25:28.183474808 +0200
> @@ -572,10 +572,6 @@
>  	if (HWIF(drive)->ide_dma_host_on(drive))
>  		return 1;
>
> -#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> -	HWIF(drive)->ide_dma_queued_on(drive);
> -#endif
> -
>  	return 0;
>  }
>
> --- drivers/ide/ide-disk.c~	2003-07-11 10:30:51.783280160 +0200
> +++ drivers/ide/ide-disk.c	2003-07-11 10:31:09.873530024 +0200
> @@ -1665,6 +1665,10 @@
>  	drive->no_io_32bit = id->dword_io ? 1 : 0;
>  	if (drive->id->cfs_enable_2 & 0x3000)
>  		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> +
> +#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> +	HWIF(drive)->ide_dma_queued_on(drive);
> +#endif
>  }
>
>  static int idedisk_cleanup (ide_drive_t *drive)
>
> --
> Jens Axboe

