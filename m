Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753134AbWKHVkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbWKHVkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbWKHVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:40:34 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:43525 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1753134AbWKHVkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:40:33 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk>
	<87ejsd3gcr.fsf@sycorax.lbl.gov> <20061108192924.GA4527@kernel.dk>
	<87ac313f1d.fsf@sycorax.lbl.gov> <20061108194532.GB4527@kernel.dk>
Date: Wed, 08 Nov 2006 13:40:29 -0800
In-Reply-To: <20061108194532.GB4527@kernel.dk> (message from Jens Axboe on
	Wed, 8 Nov 2006 20:45:32 +0100)
Message-ID: <8764dp39de.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> If you could retest with something crazy like this, then that would
> likely help:
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 7c47e62..010acfa 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -630,6 +630,9 @@ static void cdrom_end_request (ide_drive
>  	struct request *rq = HWGROUP(drive)->rq;
>  	int nsectors = rq->hard_cur_sectors;
>  
> +	if (blk_pc_request(rq) && rq->cmd[0] == 0x12)
> +		printk("ide-cd: end INQ rq %p\n", rq);
> +
>  	if (blk_sense_request(rq) && uptodate) {
>  		/*
>  		 * For REQ_TYPE_SENSE, "rq->buffer" points to the original
> @@ -1671,6 +1674,9 @@ static ide_startstop_t cdrom_newpc_intr(
>  	xfer_func_t *xferfunc;
>  	unsigned long flags;
>  
> +	if (rq->cmd[0] == 0x12)
> +		printk("ide-cd: newpc %p\n", rq);
> +
>  	/* Check for errors. */
>  	dma_error = 0;
>  	dma = info->dma;
> @@ -1789,6 +1795,8 @@ static ide_startstop_t cdrom_newpc_intr(
>  	return ide_started;
>  
>  end_request:
> +	if (rq->cmd[0] == 0x12)
> +		printk("ide-cd: newpc end INQ %p\n", rq);
>  	if (!rq->data_len)
>  		post_transform_command(rq);
>  
> @@ -1959,7 +1967,13 @@ static ide_startstop_t cdrom_do_block_pc
>  {
>  	struct cdrom_info *info = drive->driver_data;
>  
> -	rq->cmd_flags |= REQ_QUIET;
> +	if (rq->cmd[0] == 0x12) {
> +		printk("ide-cd: starting INQ %p\n", rq);
> +		if (rq_data_dir(rq) == WRITE)
> +			printk("ide-cd: INQ with write set seen\n");
> +	}
> +	if (!rq->bio && rq->biotail)
> +		printk("ide-cd: no bio, but biotail\n");
>  
>  	info->dma = 0;

i applied this patch on top of the old one. this is what i get now:

kernel: ide-cd: starting INQ df5ad074
kernel: ide-cd: INQ with write set seen
kernel: ide-cd: newpc df5ad074
kernel: hdc: write_intr: wrong transfer direction!
kernel: ide-cd: end INQ rq df5ad074
kernel: cdrom_newpc: dev hdc: type=2, flags=104c9
kernel: 
kernel: sector 59534648, nr/cnr 0/0
kernel: bio 00000000, biotail dee57c80, buffer 00000000, data 00000000, len 56
kernel: cdb: 12 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 
kernel: ide-cd: starting INQ df5ad074
kernel: ide-cd: newpc df5ad074
kernel: ide-cd: newpc df5ad074
kernel: ide-cd: newpc end INQ df5ad074
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0xb4 { AbortedCommand LastFailedSense=0x0b }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Aborted command -- (Sense key=0x0b)
kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 93 00 00 0d f8 00 00 00 00 00 00 "
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0x30 { LastFailedSense=0x03 }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Medium error -- (Sense key=0x03)
kernel:   Unrecovered read error -- (asc=0x11, ascq=0x00)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 a0 00 00 07 f8 00 00 00 00 00 00 "
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0xb4 { AbortedCommand LastFailedSense=0x0b }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Aborted command -- (Sense key=0x0b)
kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 9b 00 00 0d f8 00 00 00 00 00 00 "

hdc is the cdrom drive and the errors started showing up when
cdparanoia hung.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
