Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTDDNL0 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDDNL0 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:11:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21144 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263500AbTDDNLG (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:11:06 -0500
Date: Fri, 4 Apr 2003 15:22:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030404132214.GC786@suse.de>
References: <20030404122936.GB786@suse.de> <86k7ea2ydy.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86k7ea2ydy.fsf@trasno.mitica>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04 2003, Juan Quintela wrote:
> >>>>> "jens" == Jens Axboe <axboe@suse.de> writes:
> 
> jens> Hi,
> jens> 48-bit lba has a non-significant overhead (twice the outb's, 12 instead
> jens> of 6 per command), so it makes sense to use 28-bit lba commands whenever
> jens> we can.
> 
> jens> Patch is against 2.5.66-BK.
> 
> jens> ===== drivers/ide/ide-disk.c 1.36 vs edited =====
> jens> --- 1.36/drivers/ide/ide-disk.c	Wed Mar 26 21:23:01 2003
> jens> +++ edited/drivers/ide/ide-disk.c	Fri Apr  4 14:18:41 2003
> jens> @@ -367,12 +367,15 @@
> jens> static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
> jens> {
> jens> ide_hwif_t *hwif	= HWIF(drive);
> jens> -	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
> jens> +	u8 lba48		= 0;
> jens> task_ioreg_t command	= WIN_NOP;
> jens> ata_nsector_t		nsectors;
>  
> jens> nsectors.all		= (u16) rq->nr_sectors;
>  
> jens> +	if (drive->addressing == 1 && block > 0xfffffff)
> jens> +		lba48 = 1;
> jens> +
> 
> lba48 = (drive->addressing == 1) && (block > 0xfffffff);
> 
> should do the trick.

I'm not going to use such nonsense, sorry. The spelled out versions are
a lot more readable. The command ?: constructs used in ide-disk are a
joke, imo.

> jens> +	if (lba48bit && block > 0xfffffff)
> 
> that test should be equivalent to:
> 
> if (lba48bit)

Yes that is correct, that should be changed.

> Talking about consistency, wouldn't be better to use always the same
> name, lba48 or lba48bit?

There was no consistency to begin with, if anything my patch is
consistent with the inconsistent source :)

-- 
Jens Axboe

