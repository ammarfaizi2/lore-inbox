Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbTC1DJN>; Thu, 27 Mar 2003 22:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbTC1DJN>; Thu, 27 Mar 2003 22:09:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7174 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261952AbTC1DJE>; Thu, 27 Mar 2003 22:09:04 -0500
Date: Thu, 27 Mar 2003 19:16:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new IDE PIO handlers 1/4
In-Reply-To: <Pine.SOL.4.30.0303280054270.6453-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10303271841210.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wondered when you would publish the BIO traversing code!
Now if we can make it generic for block then it will fix all the broken
scsi hba's that were lost in the transition, iirc.

Cheers,

On Fri, 28 Mar 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> # Rewritten PIO handlers, both single and multiple sector sizes.
> #
> # They make use of new bio travelsing code and are supposed to be
> # correct in respect to ATA state machine.
> #
> # Patch 1/4 - Implement them, do not activate yet.
> #	      Fix do_rw_taskfile() and flagged_taskfile() for correct
> #	      handling of new prehandlers.
> #
> # Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
> 
> diff -uNr linux-2.5.66/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
> --- linux-2.5.66/drivers/ide/ide-taskfile.c	Tue Mar 25 22:53:09 2003
> +++ linux/drivers/ide/ide-taskfile.c	Wed Mar 26 22:49:34 2003
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
>   *  Copyright (C) 2001-2002	Klaus Smolin
>   *					IBM Storage Technology Division
> + *  Copyright (C) 2003		Bartlomiej Zolnierkiewicz
>   *
>   *  The big the bad and the ugly.
>   *
> @@ -176,9 +177,12 @@
> 
>  	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
>  	if (task->handler != NULL) {
> -		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
> -		if (task->prehandler != NULL)
> +		if (task->prehandler != NULL) {
> +			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
> +			ndelay(400);	/* FIXME */
>  			return task->prehandler(drive, task->rq);
> +		}
> +		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
>  		return ide_started;
>  	}
> 
> @@ -535,6 +539,262 @@
> 
>  EXPORT_SYMBOL(task_no_data_intr);
> 
> +#define PIO_IN	0
> +#define PIO_OUT	1
> +
> +static inline void task_sectors(ide_drive_t *drive, struct request *rq,
> +				unsigned nsect, int rw)
> +{
> +	unsigned long flags;
> +	char *buf;
> +
> +	buf = task_map_rq(rq, &flags);
> +
> +	/*
> +	 * IRQ can happen instantly after reading/writing
> +	 * last sector of the datablock.
> +	 */
> +	process_that_request_first(rq, nsect);
> +
> +	if (rw == PIO_OUT)
> +		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
> +	else
> +		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
> +
> +	task_unmap_rq(rq, buf, &flags);
> +}
> +
> +/*
> + * Handler for command with PIO data-in phase (Read).
> + */
> +ide_startstop_t task_in_intr (ide_drive_t *drive)
> +{
> +	struct request *rq = HWGROUP(drive)->rq;
> +	u8 stat, good_stat;
> +
> +	good_stat = DATA_READY;
> +check_status:
> +	stat = HWIF(drive)->INB(IDE_STATUS_REG);
> +	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
> +		if (stat & (ERR_STAT|DRQ_STAT))
> +			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> +		/* No data yet, so wait for another IRQ. */
> +		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
> +		return ide_started;
> +	}
> +
> +	/*
> +	 * Complete previously submitted bios (if any).
> +	 * Status was already verifyied.
> +	 */
> +	while (rq->hard_bio != rq->bio)
> +		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
> +			return ide_stopped;
> +
> +	rq->errors = 0;
> +	task_sectors(drive, rq, 1, PIO_IN);
> +
> +	/* If it was the last datablock check status and finish transfer. */
> +	if (!rq->nr_sectors) {
> +		good_stat = 0;
> +		goto check_status;
> +	}
> +
> +	/* Still data left to transfer. */
> +	ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
> +
> +	return ide_started;
> +}
> +
> +EXPORT_SYMBOL(task_in_intr);
> +
> +/*
> + * Handler for command with PIO data-in phase (Read Multiple).
> + */
> +ide_startstop_t task_mulin_intr (ide_drive_t *drive)
> +{
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int msect = drive->mult_count;
> +	unsigned int nsect;
> +	u8 stat, good_stat;
> +
> +	good_stat = DATA_READY;
> +check_status:
> +	stat = HWIF(drive)->INB(IDE_STATUS_REG);
> +	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
> +		if (stat & (ERR_STAT|DRQ_STAT))
> +			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> +		/* No data yet, so wait for another IRQ. */
> +		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
> +		return ide_started;
> +	}
> +
> +	/*
> +	 * Complete previously submitted bios (if any).
> +	 * Status was already verifyied.
> +	 */
> +	while (rq->hard_bio != rq->bio)
> +		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
> +			return ide_stopped;
> +
> +	rq->errors = 0;
> +	do {
> +		nsect = rq->current_nr_sectors;
> +		if (nsect > msect)
> +			nsect = msect;
> +
> +		task_sectors(drive, rq, nsect, PIO_IN);
> +
> +		if (!rq->nr_sectors)
> +			msect = 0;
> +		else
> +			msect -= nsect;
> +	} while (msect);
> +
> +	/* If it was the last datablock check status and finish transfer. */
> +	if (!rq->nr_sectors) {
> +		good_stat = 0;
> +		goto check_status;
> +	}
> +
> +	/* Still data left to transfer. */
> +	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
> +
> +	return ide_started;
> +}
> +
> +EXPORT_SYMBOL(task_mulin_intr);
> +
> +/*
> + * Handler for command with PIO data-out phase (Write).
> + */
> +ide_startstop_t task_out_intr (ide_drive_t *drive)
> +{
> +	struct request *rq = HWGROUP(drive)->rq;
> +	u8 stat;
> +	int ok_stat;
> +
> +	stat = HWIF(drive)->INB(IDE_STATUS_REG);
> +	ok_stat = OK_STAT(stat, DRIVE_READY, drive->bad_wstat);
> +
> +	if (!ok_stat || !rq->nr_sectors) {
> +		if (stat & (ERR_STAT|DRQ_STAT))
> +			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> +		if (stat & BUSY_STAT) {
> +			/* Not ready yet, so wait for another IRQ. */
> +			ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
> +			return ide_started;
> +		}
> +	}
> +
> +	/*
> +	 * Complete previously submitted bios (if any).
> +	 * Status was already verifyied.
> +	 */
> +	while (rq->hard_bio != rq->bio)
> +		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
> +			return ide_stopped;
> +
> +	/* Still data left to transfer. */
> +	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
> +
> +	rq->errors = 0;
> +	task_sectors(drive, rq, 1, PIO_OUT);
> +
> +	return ide_started;
> +}
> +
> +EXPORT_SYMBOL(task_out_intr);
> +
> +ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
> +{
> +	ide_startstop_t startstop;
> +
> +	if (ide_wait_stat(&startstop, drive, DATA_READY,
> +			  drive->bad_wstat, WAIT_DRQ)) {
> +		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
> +				drive->name, drive->addressing ? "_EXT" : "");
> +		return startstop;
> +	}
> +
> +	return task_out_intr(drive);
> +}
> +
> +EXPORT_SYMBOL(pre_task_out_intr);
> +
> +/*
> + * Handler for command with PIO data-out phase (Write Multiple).
> + */
> +ide_startstop_t task_mulout_intr (ide_drive_t *drive)
> +{
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int msect = drive->mult_count;
> +	unsigned int nsect;
> +	u8 stat;
> +	int ok_stat;
> +
> +	stat = HWIF(drive)->INB(IDE_STATUS_REG);
> +	ok_stat = OK_STAT(stat, DRIVE_READY, drive->bad_wstat);
> +
> +	if (!ok_stat || !rq->nr_sectors) {
> +		if (stat & (ERR_STAT|DRQ_STAT))
> +			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> +		if (stat & BUSY_STAT) {
> +			/* Not ready yet, so wait for another IRQ. */
> +			ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
> +			return ide_started;
> +		}
> +	}
> +
> +	/*
> +	 * Complete previously submitted bios (if any).
> +	 * Status was already verifyied.
> +	 */
> +	while (rq->hard_bio != rq->bio)
> +		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
> +			return ide_stopped;
> +
> +	/* Still data left to transfer. */
> +	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
> +
> +	rq->errors = 0;
> +	do {
> +		nsect = rq->current_nr_sectors;
> +		if (nsect > msect)
> +			nsect = msect;
> +
> +		task_sectors(drive, rq, nsect, PIO_OUT);
> +
> +		if (!rq->nr_sectors)
> +			msect = 0;
> +		else
> +			msect -= nsect;
> +
> +	} while (msect);
> +
> +	return ide_started;
> +}
> +
> +EXPORT_SYMBOL(task_mulout_intr);
> +
> +ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
> +{
> +	ide_startstop_t startstop;
> +
> +	if (ide_wait_stat(&startstop, drive, DATA_READY,
> +			  drive->bad_wstat, WAIT_DRQ)) {
> +		printk(KERN_ERR "%s: no DRQ after issuing MULTWRITE%s\n",
> +				drive->name, drive->addressing ? "_EXT" : "");
> +		return startstop;
> +	}
> +
> +	return task_mulout_intr(drive);
> +}
> +
> +EXPORT_SYMBOL(pre_task_mulout_intr);
> +
> +
> +#if 0
>  /*
>   * Handler for command with PIO data-in phase, READ
>   */
> @@ -932,6 +1192,7 @@
>  }
> 
>  EXPORT_SYMBOL(task_mulout_intr);
> +#endif	/* 0 */
> 
>  /* Called by internal to feature out type of command being called */
>  //ide_pre_handler_t * ide_pre_handler_parser (task_struct_t *taskfile, hob_struct_t *hobfile)
> @@ -1873,10 +2134,14 @@
>   			if (task->handler == NULL)
>  				return ide_stopped;
> 
> +			if (task->prehandler != NULL) {
> +				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
> +				ndelay(400);	/* FIXME */
> +				return task->prehandler(drive, HWGROUP(drive)->rq);
> +			}
> +
>  			/* Issue the command */
>  			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
> -			if (task->prehandler != NULL)
> -				return task->prehandler(drive, HWGROUP(drive)->rq);
>  	}
> 
>  	return ide_started;
> 
> 

Andre Hedrick
LAD Storage Consulting Group

