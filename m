Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVB0Ew4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVB0Ew4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 23:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVB0Ew4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 23:52:56 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:52467 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261347AbVB0Evg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 23:51:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=IlhBpzYHJAfBr73lx1jASnEJ9fOehIkdplGfN5Aq0HSFjtjdYigSR2/xC+xPqzvG3c1OKMyIBIywIoPQHKO/GRQRmpwRInRIP02VW9ngmD6l2efWu5ngGaHJXPQyXTgtJ8C6JdrGv6/MT0sr94dOsAijPA14Zc2h37GkwB362Rg=
Date: Sun, 27 Feb 2005 13:51:25 +0900
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 7/9] convert disk flush functions to use REQ_DRIVE_TASKFILE
Message-ID: <20050227045125.GA25723@htj.dyndns.org>
References: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej,

On Thu, Feb 24, 2005 at 03:45:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Original patch from Tejun Heo <htejun@gmail.com>,
> ported over recent IDE changes by me.
> 
> * teach ide_tf_get_address() about CHS

 IMHO, as patch #4 moves LBA/CHS selection into taskfile, I think
using taskfile->device to determine whether LBA or CHS is used instead
of drive->select makes more sense.

> * use ide_tf_get_address() and remove ide_get_error_location()

 IIRC, error responses for WIN_FLUSH_CACHE is in CHS if the LBA bit in
the device register is zero; likewise, in LBA if the LBA bit is one.
I don't know if drives can change the LBA bit when posting error
result.  The original code reads back the device register on error to
determine whether to interpret the error response in CHS or LBA.
(ATA/ATAPI-6 isn't clear on this issue.  Is ATA/ATAPI-7 updated?)

 This change combined with patch #2/#5 can make error address
calculation wrong on LBA28 drives.  I think setting the LBA bit in the
device register according to the drive's addressing mode in
ide_task_init_flush() and use taskfile->device in ide_tf_get_address()
should fix the problem.

> * use ide_task_init_flush() and remove ide_fill_flush_cmd()
> * convert idedisk_issue_flush() to use REQ_DRIVE_TASKFILE.
>   This and switching to ide_tf_get_address() removes
>   a possible race condition between getting the failed
>   sector number and other requests.
> * convert ide_queue_flush_cmd() to use REQ_DRIVE_TASKFILE
> 
> By this change, when WIN_FLUSH_CACHE_EXT is used, full HOB
> registers are written and read.  This isn't optimal but
> shouldn't be noticeable either.
> 
> diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c	2005-02-24 15:29:50 +01:00
> +++ b/drivers/ide/ide-disk.c	2005-02-24 15:29:50 +01:00
> @@ -349,7 +349,7 @@
> 
>  	/* if OK, compute maximum address value */
>  	if ((tf->command & 1) == 0) {
> -		addr = ide_tf_get_address(tf);
> +		addr = ide_tf_get_address(drive, tf);
>  		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}
>  	return addr;
> @@ -392,7 +392,7 @@
>  	ide_raw_taskfile(drive, &args, NULL);
>  	/* if OK, compute maximum address value */
>  	if ((tf->command & 1) == 0) {
> -		addr_set = ide_tf_get_address(tf);
> +		addr_set = ide_tf_get_address(drive, tf);
>  		addr_set++;
>  	}
>  	return addr_set;
> @@ -639,24 +639,18 @@
>  {
>  	ide_drive_t *drive = q->queuedata;
>  	struct request *rq;
> +	ide_task_t task;
>  	int ret;
> 
>  	if (!drive->wcache)
>  		return 0;
> 
> -	rq = blk_get_request(q, WRITE, __GFP_WAIT);
> -
> -	memset(rq->cmd, 0, sizeof(rq->cmd));
> -
> -	if (ide_id_has_flush_cache_ext(drive->id) &&
> -	    (drive->capacity64 >= (1UL << 28)))
> -		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
> -	else
> -		rq->cmd[0] = WIN_FLUSH_CACHE;
> +	ide_task_init_flush(drive, &task);
> 
> +	rq = blk_get_request(q, WRITE, __GFP_WAIT);
> 
> -	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
> -	rq->buffer = rq->cmd;
> +	rq->flags |= REQ_DRIVE_TASKFILE | REQ_SOFTBARRIER;
> +	rq->special = &task;
> 
>  	ret = blk_execute_rq(q, disk, rq);
> 
> @@ -664,7 +658,7 @@
>  	 * if we failed and caller wants error offset, get it
>  	 */
>  	if (ret && error_sector)
> -		*error_sector = ide_get_error_location(drive, rq->cmd);
> +		*error_sector = ide_tf_get_address(drive, &task.tf);
> 
>  	blk_put_request(rq);
>  	return ret;
> diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> --- a/drivers/ide/ide-io.c	2005-02-24 15:29:50 +01:00
> +++ b/drivers/ide/ide-io.c	2005-02-24 15:29:50 +01:00
> @@ -74,24 +74,6 @@
> 
>  EXPORT_SYMBOL_GPL(ide_task_init_flush);
> 
> -static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
> -{
> -	char *buf = rq->cmd;
> -
> -	/*
> -	 * reuse cdb space for ata command
> -	 */
> -	memset(buf, 0, sizeof(rq->cmd));
> -
> -	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
> -	rq->buffer = buf;
> -	rq->buffer[0] = WIN_FLUSH_CACHE;
> -
> -	if (ide_id_has_flush_cache_ext(drive->id) &&
> -	    (drive->capacity64 >= (1UL << 28)))
> -		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> -}
> -
>  /*
>   * preempt pending requests, and store this cache flush for immediate
>   * execution
> @@ -99,7 +81,9 @@
>  static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
>  					   struct request *rq, int post)
>  {
> -	struct request *flush_rq = &HWGROUP(drive)->wrq;
> +	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
> +	struct request *flush_rq = &hwgroup->flush_rq;
> +	ide_task_t *task = &hwgroup->flush_task;
> 
>  	/*
>  	 * write cache disabled, clear the barrier bit and treat it like
> @@ -110,11 +94,14 @@
>  		return rq;
>  	}
> 
> -	ide_init_drive_cmd(flush_rq);
> -	ide_fill_flush_cmd(drive, flush_rq);
> +	ide_task_init_flush(drive, task);
> 
> -	flush_rq->special = rq;
> +	ide_init_drive_cmd(flush_rq);
> +	flush_rq->flags = REQ_DRIVE_TASKFILE | REQ_STARTED;
>  	flush_rq->nr_sectors = rq->nr_sectors;
> +	flush_rq->special = task;
> +
> +	hwgroup->flush_real_rq = rq;
> 
>  	if (!post) {
>  		drive->doing_barrier = 1;
> @@ -124,7 +111,7 @@
>  		flush_rq->flags |= REQ_BAR_POSTFLUSH;
> 
>  	__elv_add_request(drive->queue, flush_rq, ELEVATOR_INSERT_FRONT, 0);
> -	HWGROUP(drive)->rq = NULL;
> +	hwgroup->rq = NULL;
>  	return flush_rq;
>  }
> 
> @@ -181,12 +168,13 @@
> 
>  int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
>  {
> +	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
>  	struct request *rq;
>  	unsigned long flags;
>  	int ret = 1;
> 
>  	spin_lock_irqsave(&ide_lock, flags);
> -	rq = HWGROUP(drive)->rq;
> +	rq = hwgroup->rq;
> 
>  	if (!nr_sectors)
>  		nr_sectors = rq->hard_cur_sectors;
> @@ -194,7 +182,7 @@
>  	if (!blk_barrier_rq(rq) || !drive->wcache)
>  		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
>  	else {
> -		struct request *flush_rq = &HWGROUP(drive)->wrq;
> +		struct request *flush_rq = &hwgroup->flush_rq;
> 
>  		flush_rq->nr_sectors -= nr_sectors;
>  		if (!flush_rq->nr_sectors) {
> @@ -330,60 +318,34 @@
>  	spin_unlock_irqrestore(&ide_lock, flags);
>  }
> 
> -u64 ide_tf_get_address(struct ata_taskfile *tf)
> +u64 ide_tf_get_address(ide_drive_t *drive, struct ata_taskfile *tf)
>  {
>  	u32 high, low;
> 
> -	if (tf->flags & ATA_TFLAG_LBA48)
> +	if (tf->flags & ATA_TFLAG_LBA48) {
>  		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> -	else
> -		high = tf->device & 0xf;
> -
> -	low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> -
> -	return ((u64)high << 24) | low;
> -}
> -
> -EXPORT_SYMBOL_GPL(ide_tf_get_address);
> -
> -/*
> - * FIXME: probably move this somewhere else, name is bad too :)
> - */
> -u64 ide_get_error_location(ide_drive_t *drive, char *args)
> -{
> -	u32 high, low;
> -	u8 hcyl, lcyl, sect;
> -	u64 sector;
> -
> -	high = 0;
> -	hcyl = args[5];
> -	lcyl = args[4];
> -	sect = args[3];
> -
> -	if (ide_id_has_flush_cache_ext(drive->id)) {
> -		low = (hcyl << 16) | (lcyl << 8) | sect;
> -		HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
> -		high = ide_read_24(drive);
> +		low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  	} else {
> -		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
> -		if (cur & 0x40)
> -			low = (hcyl << 16) | (lcyl << 8) | sect;
> -		else {
> -			low = hcyl * drive->head * drive->sect;
> -			low += lcyl * drive->sect;
> -			low += sect - 1;
> +		if (drive->select.b.lba) {
> +			high = tf->device & 0xf;
> +			low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> +		} else {
> +			high = 0;
> +			low = tf->lbah * drive->head * drive->sect;
> +			low += tf->lbam * drive->sect;
> +			low += tf->lbal - 1;
>  		}
>  	}
> 
> -	sector = ((u64) high << 24) | low;
> -	return sector;
> +	return ((u64)high << 24) | low;
>  }
> -EXPORT_SYMBOL(ide_get_error_location);
> +
> +EXPORT_SYMBOL_GPL(ide_tf_get_address);
> 
>  static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
>  				 int error)
>  {
> -	struct request *real_rq = rq->special;
> +	struct request *real_rq = drive->hwif->hwgroup->flush_real_rq;
>  	int good_sectors, bad_sectors;
>  	sector_t sector;
> 
> @@ -430,7 +392,9 @@
>  		 */
>  		good_sectors = 0;
>  		if (blk_barrier_postflush(rq)) {
> -			sector = ide_get_error_location(drive, rq->buffer);
> +			ide_task_t *task = rq->special;
> +
> +			sector = ide_tf_get_address(drive, &task->tf);
> 
>  			if ((sector >= real_rq->hard_sector) &&
>  			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
> diff -Nru a/include/linux/ide.h b/include/linux/ide.h
> --- a/include/linux/ide.h	2005-02-24 15:29:50 +01:00
> +++ b/include/linux/ide.h	2005-02-24 15:29:50 +01:00
> @@ -962,8 +962,12 @@
>  	struct request *rq;
>  		/* failsafe timer */
>  	struct timer_list timer;
> -		/* local copy of current write rq */
> -	struct request wrq;
> +		/* rq used for flushing */
> +	struct request flush_rq;
> +		/* task used for flushing */
> +	ide_task_t flush_task;
> +		/* real_rq for flushing */
> +	struct request *flush_real_rq;
>  		/* timeout value during long polls */
>  	unsigned long poll_timeout;
>  		/* queried upon timeouts */
> @@ -1204,12 +1208,7 @@
> 
>  void ide_task_init_flush(ide_drive_t *, ide_task_t *);
> 
> -u64 ide_tf_get_address(struct ata_taskfile *);
> -
> -/*
> - * this function returns error location sector offset in case of a write error
> - */
> -extern u64 ide_get_error_location(ide_drive_t *, char *);
> +u64 ide_tf_get_address(ide_drive_t *, struct ata_taskfile *);
> 
>  /*
>   * "action" parameter type for ide_do_drive_cmd() below.

-- 
tejun

