Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSBBV5J>; Sat, 2 Feb 2002 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSBBV5D>; Sat, 2 Feb 2002 16:57:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58894
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292398AbSBBV4z>; Sat, 2 Feb 2002 16:56:55 -0500
Date: Sat, 2 Feb 2002 13:48:18 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: "Axel H. Siebenwirth" <axel@hh59.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
In-Reply-To: <20020202102659.L12156@suse.de>
Message-ID: <Pine.LNX.4.10.10202021158010.26613-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

You and I know Linus will go ballistic over the reintroduction of a
working copy model using rq scratch pad.  We can go with this return to
what we are trying to get away from but we really need a way to stream the
pointers to the data register cleanly.  Otherwise the benefits of the zero
copy in block go away.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Sat, 2 Feb 2002, Jens Axboe wrote:

> On Fri, Feb 01 2002, Axel H. Siebenwirth wrote:
> > Hi Anton!
> > 
> > On Fri, 01 Feb 2002, Anton Altaparmakov wrote:
> > 
> > > I was about to send the drive (IBM 7200rpm 41GiB) back for replacement when 
> > > I as last resort tried to upgrade the firmware of the drive.
> > > 
> > > After the upgrade the drive started working again, fully passed the Drive 
> > > Fitness Test (IBM utility) and it has been working for a few weeks non-stop 
> > > in my file server RAID-1 array since then.
> > 
> > The thing is that they come up now, just since I installed 2.5.3. Might
> > there be a hope that it is a kernel-related issue (new IDE driver...). Drive
> > has been working fine ever since till now.
> 
> Please try with this patch -- it's against 2.5.3-pre3, but I think it
> should apply to 2.5.3 final as well.
> 
> diff -ur /ata/linux-2.5.3-pre3/drivers/ide/ide-disk.c drivers/ide/ide-disk.c
> --- /ata/linux-2.5.3-pre3/drivers/ide/ide-disk.c	Fri Jan 25 05:05:06 2002
> +++ drivers/ide/ide-disk.c	Fri Jan 25 02:53:03 2002
> @@ -192,11 +192,6 @@
>  	sectors = rq->nr_sectors;
>  	if (sectors == 256)
>  		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
>  
>  	taskfile.sector_count	= sectors;
>  	taskfile.sector_number	= sect;
> @@ -241,11 +236,6 @@
>  	sectors = rq->nr_sectors;
>  	if (sectors == 256)
>  		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
>  
>  	memset(&taskfile, 0, sizeof(task_struct_t));
>  	memset(&hobfile, 0, sizeof(hob_struct_t));
> @@ -300,13 +290,8 @@
>  	memset(&hobfile, 0, sizeof(hob_struct_t));
>  
>  	sectors = rq->nr_sectors;
> -	if (sectors == 256)
> +	if (sectors == 65536)
>  		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
>  
>  	taskfile.sector_count	= sectors;
>  	hobfile.sector_count	= sectors >> 8;
> diff -ur /ata/linux-2.5.3-pre3/drivers/ide/ide-probe.c drivers/ide/ide-probe.c
> --- /ata/linux-2.5.3-pre3/drivers/ide/ide-probe.c	Fri Jan 25 05:05:06 2002
> +++ drivers/ide/ide-probe.c	Fri Jan 25 04:46:26 2002
> @@ -625,7 +625,7 @@
>  	blk_queue_segment_boundary(q, 0xffff);
>  
>  	/* IDE can do up to 128K per request, pdc4030 needs smaller limit */
> -	max_sectors = (is_pdc4030_chipset ? 127 : 255);
> +	max_sectors = (is_pdc4030_chipset ? 127 : 256);
>  	blk_queue_max_sectors(q, max_sectors);
>  
>  	/* IDE DMA can do PRD_ENTRIES number of segments. */
> diff -ur /ata/linux-2.5.3-pre3/drivers/ide/ide-taskfile.c drivers/ide/ide-taskfile.c
> --- /ata/linux-2.5.3-pre3/drivers/ide/ide-taskfile.c	Fri Jan 25 05:05:06 2002
> +++ drivers/ide/ide-taskfile.c	Fri Jan 25 04:45:48 2002
> @@ -255,6 +255,7 @@
>  	return 1;		/* drive ready: *might* be interrupting */
>  }
>  
> +ide_startstop_t bio_mulout_intr (ide_drive_t *drive);
>  ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
>  {
>  	task_struct_t *taskfile = (task_struct_t *) task->tfRegister;
> @@ -263,7 +264,7 @@
>  	byte HIHI = (drive->addressing) ? 0xE0 : 0xEF;
>  
>  	/* (ks/hs): Moved to start, do not use for multiple out commands */
> -	if (task->handler != task_mulout_intr) {
> +	if (task->handler != task_mulout_intr && task->handler != bio_mulout_intr) {
>  		if (IDE_CONTROL_REG)
>  			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
>  		SELECT_MASK(HWIF(drive), drive, 0);
> @@ -313,7 +314,7 @@
>  	byte HIHI = (drive->addressing) ? 0xE0 : 0xEF;
>  
>  	/* (ks/hs): Moved to start, do not use for multiple out commands */
> -	if (*handler != task_mulout_intr) {
> +	if (*handler != task_mulout_intr && handler != bio_mulout_intr) {
>  		if (IDE_CONTROL_REG)
>  			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
>  		SELECT_MASK(HWIF(drive), drive, 0);
> @@ -936,15 +937,12 @@
>  	char *pBuf		= NULL;
>  	unsigned long flags;
>  
> -	if (!rq->current_nr_sectors) { 
> -		printk("task_out_intr: should not trigger\n");
> -		ide_end_request(1, HWGROUP(drive));
> -		return ide_stopped;
> -	}
> -
> -	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
> +	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat))
>  		return ide_error(drive, "task_out_intr", stat);
> -	}
> +
> +	if (!rq->current_nr_sectors)
> +		if (!ide_end_request(1, HWGROUP(drive)))
> +			return ide_stopped;
>  
>  	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
>  		rq = HWGROUP(drive)->rq;
> @@ -958,16 +956,8 @@
>  		rq->current_nr_sectors--;
>  	}
>  
> -	if (rq->current_nr_sectors <= 0) {
> -		if (ide_end_request(1, HWGROUP(drive))) {
> -			ide_set_handler(drive, &task_out_intr, WAIT_CMD, NULL);
> -			return ide_started;
> -		}
> -	} else {
> -		ide_set_handler(drive, &task_out_intr, WAIT_CMD, NULL);
> -		return ide_started;
> -	}
> -	return ide_stopped;
> +	ide_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
> +	return ide_started;
>  }
>  
>  /*
> @@ -1061,14 +1051,132 @@
>  	return ide_started;
>  }
>  
> +ide_startstop_t pre_bio_out_intr (ide_drive_t *drive, struct request *rq)
> +{
> +	ide_task_t *args = rq->special;
> +	ide_startstop_t startstop;
> +
> +	/*
> +	 * assign private copy for multi-write
> +	 */
> +	memcpy(&HWGROUP(drive)->wrq, rq, sizeof(struct request));
> +
> +	if (ide_wait_stat(&startstop, drive, DATA_READY, drive->bad_wstat, WAIT_DRQ))
> +		return startstop;
> +
> +	/*
> +	 * (ks/hs): Stuff the first sector(s)
> +	 * by implicitly calling the handler
> +	 */
> +	if (!(drive_is_ready(drive))) {
> +		int i;
> +		/*
> +		 * (ks/hs): FIXME: Replace hard-coded
> +		 *               100, error handling?
> +		 */
> +		for (i=0; i<100; i++) {
> +			if (drive_is_ready(drive))
> +				break;
> +		}
> +	}
> +
> +	return args->handler(drive);
> +}
> +
> +
> +ide_startstop_t bio_mulout_intr (ide_drive_t *drive)
> +{
> +#ifdef ALTSTAT_SCREW_UP
> +	byte stat	= altstat_multi_busy(drive, GET_ALTSTAT(), "write");
> +#else
> +	byte stat		= GET_STAT();
> +#endif /* ALTSTAT_SCREW_UP */
> +
> +	byte io_32bit		= drive->io_32bit;
> +	struct request *rq	= &HWGROUP(drive)->wrq;
> +	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
> +	int mcount		= drive->mult_count;
> +	ide_startstop_t startstop;
> +
> +	/*
> +	 * (ks/hs): Handle last IRQ on multi-sector transfer,
> +	 * occurs after all data was sent in this chunk
> +	 */
> +	if (!rq->nr_sectors) {
> +		if (stat & (ERR_STAT|DRQ_STAT)) {
> +			startstop = ide_error(drive, "bio_mulout_intr", stat);
> +			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
> +			return startstop;
> +		}
> +
> +		__ide_end_request(HWGROUP(drive), 1, rq->hard_nr_sectors);
> +		HWGROUP(drive)->wrq.bio = NULL;
> +		return ide_stopped;
> +	}
> +
> +	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
> +		if (stat & (ERR_STAT | DRQ_STAT)) {
> +			startstop = ide_error(drive, "bio_mulout_intr", stat);
> +			memcpy(rq, HWGROUP(drive)->rq, sizeof(struct request));
> +			return startstop;
> +		}
> +
> +		/* no data yet, so wait for another interrupt */
> +		if (hwgroup->handler == NULL)
> +			ide_set_handler(drive, bio_mulout_intr, WAIT_CMD, NULL);
> +
> +		return ide_started;
> +	}
> +
> +	do {
> +  		char *buffer;
> +  		int nsect = rq->current_nr_sectors;
> +		unsigned long flags;
> +
> +		if (nsect > mcount)
> +			nsect = mcount;
> +		mcount -= nsect;
> +
> +		buffer = ide_map_buffer(rq, &flags);
> +		rq->sector += nsect;
> +		rq->nr_sectors -= nsect;
> +		rq->current_nr_sectors -= nsect;
> +
> +		/* Do we move to the next bio after this? */
> +		if (!rq->current_nr_sectors) {
> +			/* remember to fix this up /jens */
> +			struct bio *bio = rq->bio->bi_next;
> +
> +			/* end early early we ran out of requests */
> +			if (!bio) {
> +				mcount = 0;
> +			} else {
> +				rq->bio = bio;
> +				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
> +			}
> +		}
> +
> +		/*
> +		 * Ok, we're all setup for the interrupt
> +		 * re-entering us on the last transfer.
> +		 */
> +		taskfile_output_data(drive, buffer, nsect * SECTOR_WORDS);
> +		ide_unmap_buffer(buffer, &flags);
> +	} while (mcount);
> +
> +	drive->io_32bit = io_32bit;
> +	rq->errors = 0;
> +	if (hwgroup->handler == NULL)
> +		ide_set_handler(drive, bio_mulout_intr, WAIT_CMD, NULL);
> +
> +	return ide_started;
> +}
> +
>  /* Called by internal to feature out type of command being called */
>  ide_pre_handler_t * ide_pre_handler_parser (struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
>  {
>  	switch(taskfile->command) {
>  				/* IDE_DRIVE_TASK_RAW_WRITE */
> -		case CFA_WRITE_MULTI_WO_ERASE:
> -		case WIN_MULTWRITE:
> -		case WIN_MULTWRITE_EXT:
>  				/* IDE_DRIVE_TASK_OUT */
>  		case WIN_WRITE:
>  		case WIN_WRITE_EXT:
> @@ -1077,7 +1185,10 @@
>  		case CFA_WRITE_SECT_WO_ERASE:
>  		case WIN_DOWNLOAD_MICROCODE:
>  			return &pre_task_out_intr;
> -				/* IDE_DRIVE_TASK_OUT */
> +		case CFA_WRITE_MULTI_WO_ERASE:
> +		case WIN_MULTWRITE:
> +		case WIN_MULTWRITE_EXT:
> +			return &pre_bio_out_intr;
>  		case WIN_SMART:
>  			if (taskfile->feature == SMART_WRITE_LOG_SECTOR)
>  				return &pre_task_out_intr;
> @@ -1120,7 +1231,7 @@
>  		case CFA_WRITE_MULTI_WO_ERASE:
>  		case WIN_MULTWRITE:
>  		case WIN_MULTWRITE_EXT:
> -			return &task_mulout_intr;
> +			return &bio_mulout_intr;
>  		case WIN_SMART:
>  			switch(taskfile->feature) {
>  				case SMART_READ_VALUES:
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

