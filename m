Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291092AbSBGDna>; Wed, 6 Feb 2002 22:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291093AbSBGDnT>; Wed, 6 Feb 2002 22:43:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12563
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291092AbSBGDnM>; Wed, 6 Feb 2002 22:43:12 -0500
Date: Wed, 6 Feb 2002 19:34:01 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: linux-kernel@vger.kernel.org
cc: Dave Jones <davej@suse.de>, Pavel Machek <pavel@suse.cz>, vojtech@ucw.cz
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10202061928220.8641-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BZZT, I don't think so.

Since you have not the input or insight to why it was expanded maybe you
should just leave it alone.  Since I am working on how to fix the
MUNGE/KLUDGE that was added to make the PIO work, just maybe you may want
rething the rathole you just created by attempting to compress the code
before it is finished.  What you doing is BORKING the driver to the point
where adding in the TCQ will not work.  Next you have screwed the future
interface for Serial ATA.

Have a good day now!

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


On Wed, 6 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> IDE is
> * infested with polish notation
> * programmed by cut-copy-paste
> * full of unneccessary casts
> (there are examples of all these in the patch)
> -> totally unreadable
> 
> This attempts to clean worst mess in ide-disk.c. Dave, please apply;
> or if you feel it is "too big" let me know and I'll feed linus.
> 									Pavel
> 
> --- clean/drivers/ide/ide-disk.c	Thu Jan 31 23:42:14 2002
> +++ linux-dm/drivers/ide/ide-disk.c	Wed Feb  6 21:43:51 2002
> @@ -123,29 +123,24 @@
>   */
>  static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
>  {
> -	if (rq->flags & REQ_CMD)
> -		goto good_command;
> -
> -	blk_dump_rq_flags(rq, "do_rw_disk, bad command");
> -	ide_end_request(0, HWGROUP(drive));
> -	return ide_stopped;
> -
> -good_command:
> +	if (!(rq->flags & REQ_CMD)) {
> +		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
> +		ide_end_request(0, HWGROUP(drive));
> +		return ide_stopped;
> +	}
>  
> -#ifdef CONFIG_BLK_DEV_PDC4030
>  	if (IS_PDC4030_DRIVE) {
>  		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
>  		return promise_rw_disk(drive, rq, block);
>  	}
> -#endif /* CONFIG_BLK_DEV_PDC4030 */
>  
>  	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))	/* 48-bit LBA */
> -		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
> +		return lba_48_rw_disk(drive, rq, block);
>  	if (drive->select.b.lba)		/* 28-bit LBA */
> -		return lba_28_rw_disk(drive, rq, (unsigned long) block);
> +		return lba_28_rw_disk(drive, rq, block);
>  
>  	/* 28-bit CHS : DIE DIE DIE piece of legacy crap!!! */
> -	return chs_rw_disk(drive, rq, (unsigned long) block);
> +	return chs_rw_disk(drive, rq, block);
>  }
>  
>  static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
> @@ -172,6 +167,30 @@
>  		return WIN_NOP;
>  }
>  
> +static int get_sectors (ide_drive_t *drive, struct request *rq, task_ioreg_t command)
> +{
> +	int sectors = rq->nr_sectors;
> +
> +	if (sectors == 256)
> +		sectors = 0;
> +	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> +		sectors = drive->mult_count;
> +		if (sectors > rq->current_nr_sectors)
> +			sectors = rq->current_nr_sectors;
> +	}
> +	return sectors;
> +}
> +
> +static void fill_args (ide_task_t *args, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
> +{
> +	memcpy(args->tfRegister, taskfile, sizeof(struct hd_drive_task_hdr));
> +	memcpy(args->hobRegister, hobfile, sizeof(struct hd_drive_hob_hdr));
> +	args->command_type	= ide_cmd_type_parser(args);
> +	args->prehandler	= ide_pre_handler_parser(taskfile, hobfile);
> +	args->handler		= ide_handler_parser(taskfile, hobfile);
> +	args->posthandler	= NULL;
> +}
> +
>  static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
>  {
>  	struct hd_drive_task_hdr	taskfile;
> @@ -186,17 +205,10 @@
>  	unsigned int head	= (track % drive->head);
>  	unsigned int cyl	= (track / drive->head);
>  
> -	memset(&taskfile, 0, sizeof(task_struct_t));
> -	memset(&hobfile, 0, sizeof(hob_struct_t));
> +	memset(&taskfile, 0, sizeof(taskfile));
> +	memset(&hobfile, 0, sizeof(hobfile));
>  
> -	sectors = rq->nr_sectors;
> -	if (sectors == 256)
> -		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
> +	sectors = get_sectors(drive, rq, command);
>  
>  	taskfile.sector_count	= sectors;
>  	taskfile.sector_number	= sect;
> @@ -215,16 +227,10 @@
>  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
>  #endif
>  
> -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> -	args.command_type	= ide_cmd_type_parser(&args);
> -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> -	args.posthandler	= NULL;
> -	args.rq			= (struct request *) rq;
> +	fill_args(&args, &taskfile, &hobfile);
> +	args.rq			= rq;
>  	args.block		= block;
> -	rq->special		= NULL;
> -	rq->special		= (ide_task_t *)&args;
> +	rq->special		= &args;
>  
>  	return do_rw_taskfile(drive, &args);
>  }
> @@ -237,18 +243,10 @@
>  	int				sectors;
>  
>  	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
> +	sectors = get_sectors(drive, rq, command);
>  
> -	sectors = rq->nr_sectors;
> -	if (sectors == 256)
> -		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
> -
> -	memset(&taskfile, 0, sizeof(task_struct_t));
> -	memset(&hobfile, 0, sizeof(hob_struct_t));
> +	memset(&taskfile, 0, sizeof(taskfile));
> +	memset(&hobfile, 0, sizeof(hobfile));
>  
>  	taskfile.sector_count	= sectors;
>  	taskfile.sector_number	= block;
> @@ -267,16 +265,10 @@
>  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
>  #endif
>  
> -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> -	args.command_type	= ide_cmd_type_parser(&args);
> -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> -	args.posthandler	= NULL;
> -	args.rq			= (struct request *) rq;
> +	fill_args(&args, &taskfile, &hobfile);
> +	args.rq			= rq;
>  	args.block		= block;
> -	rq->special		= NULL;
> -	rq->special		= (ide_task_t *)&args;
> +	rq->special		= &args;
>  
>  	return do_rw_taskfile(drive, &args);
>  }
> @@ -296,17 +288,10 @@
>  
>  	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
>  
> -	memset(&taskfile, 0, sizeof(task_struct_t));
> -	memset(&hobfile, 0, sizeof(hob_struct_t));
> +	memset(&taskfile, 0, sizeof(taskfile));
> +	memset(&hobfile, 0, sizeof(hobfile));
>  
> -	sectors = rq->nr_sectors;
> -	if (sectors == 256)
> -		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> -		sectors = drive->mult_count;
> -		if (sectors > rq->current_nr_sectors)
> -			sectors = rq->current_nr_sectors;
> -	}
> +	sectors = get_sectors(drive, rq, command);
>  
>  	taskfile.sector_count	= sectors;
>  	hobfile.sector_count	= sectors >> 8;
> @@ -336,16 +321,10 @@
>  	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
>  #endif
>  
> -	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
> -	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
> -	args.command_type	= ide_cmd_type_parser(&args);
> -	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
> -	args.handler		= ide_handler_parser(&taskfile, &hobfile);
> -	args.posthandler	= NULL;
> -	args.rq			= (struct request *) rq;
> +	fill_args(&args, &taskfile, &hobfile);
> +	args.rq			= rq;
>  	args.block		= block;
> -	rq->special		= NULL;
> -	rq->special		= (ide_task_t *)&args;
> +	rq->special		= &args;
>  
>  	return do_rw_taskfile(drive, &args);
>  }
> --- clean/drivers/ide/ide-proc.c	Thu Jan 31 23:42:14 2002
> +++ linux-dm/drivers/ide/ide-proc.c	Mon Feb  4 23:05:09 2002
> @@ -591,13 +591,13 @@
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
>  	ide_drive_t	*drive = (ide_drive_t *) data;
> -	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
> +	ide_driver_t    *driver = drive->driver;
>  	int		len;
>  
>  	if (!driver)
>  		len = sprintf(page, "(none)\n");
>          else
> -		len = sprintf(page,"%llu\n", (__u64) ((ide_driver_t *)drive->driver)->capacity(drive));
> +		len = sprintf(page,"%llu\n", (__u64) drive->driver->capacity(drive));
>  	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
>  }
>  
> @@ -629,7 +629,7 @@
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
>  	ide_drive_t	*drive = (ide_drive_t *) data;
> -	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
> +	ide_driver_t	*driver = drive->driver;
>  	int		len;
>  
>  	if (!driver)
> @@ -746,7 +746,6 @@
>  	struct proc_dir_entry *ent;
>  	struct proc_dir_entry *parent = hwif->proc;
>  	char name[64];
> -//	ide_driver_t *driver = drive->driver;
>  
>  	if (drive->present && !drive->proc) {
>  		drive->proc = proc_mkdir(drive->name, parent);
> --- clean/include/linux/ide.h	Thu Jan 31 23:42:29 2002
> +++ linux-dm/include/linux/ide.h	Wed Feb  6 21:32:41 2002
> @@ -424,12 +425,12 @@
>  	unsigned long	capacity;	/* total number of sectors */
>  	unsigned long long capacity48;	/* total number of sectors */
>  	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
> -	void		  *hwif;	/* actually (ide_hwif_t *) */
> +	struct hwif_s   *hwif;		/* actually (ide_hwif_t *) */
>  	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
>  	struct hd_driveid *id;		/* drive model identification info */
>  	struct hd_struct  *part;	/* drive partition table */
>  	char		name[4];	/* drive name, such as "hda" */
> -	void 		*driver;	/* (ide_driver_t *) */
> +	struct ide_driver_s *driver;	/* (ide_driver_t *) */
>  	void		*driver_data;	/* extra driver data */
>  	devfs_handle_t	de;		/* directory for device */
>  	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
> 
> 
> -- 
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa


