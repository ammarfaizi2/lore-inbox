Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbSAUKl0>; Mon, 21 Jan 2002 05:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbSAUKlR>; Mon, 21 Jan 2002 05:41:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62482 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281809AbSAUKlE>;
	Mon, 21 Jan 2002 05:41:04 -0500
Date: Mon, 21 Jan 2002 11:40:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1 (fwd)
Message-ID: <20020121114057.V27835@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201210149290.13727-200000@master.linux-ide.org> <20020121113549.U27835@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121113549.U27835@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Jens Axboe wrote:
> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > @@ -189,13 +189,14 @@
> >  	memset(&taskfile, 0, sizeof(task_struct_t));
> >  	memset(&hobfile, 0, sizeof(hob_struct_t));
> >  
> > -	sectors = rq->nr_sectors;
> >  	if (sectors == 256)
> >  		sectors = 0;
> > -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> > +	if (command == WIN_MULTWRITE) {
> >  		sectors = drive->mult_count;
> >  		if (sectors > rq->current_nr_sectors)
> >  			sectors = rq->current_nr_sectors;
> > +		if (sectors != drive->mult_count)
> > +			command = WIN_WRITE;
> 
> I think this is too restrictive, something ala
> 
> 		if (sectors % drive->mult_count)
> 			command = WIN_WRITE;
> 
> should suffice. However, we still need to cover the read... So something
> like this maybe:
> 
> 	if (sectors % drive->mult_count)
> 		don't use multi write _or_ read, use WIN_{READ,WRITE}
> 
> 	/* usual setup */

Patch attached, note it contains other stuff, the get_command change is
the one to note...

--- /opt/kernel/linux-2.5.3-pre2/drivers/ide/ide-disk.c	Mon Jan 21 00:43:13 2002
+++ drivers/ide/ide-disk.c	Mon Jan 21 03:37:20 2002
@@ -139,18 +142,33 @@
 	}
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 
+	/*
+	 * get a new command (push ar further down to avoid grabbing lock here
+	 */
+	spin_lock_irqsave(drive->queue.queue_lock, flags);
+	ar = ata_ar_get(drive);
+	spin_unlock_irqrestore(drive->queue.queue_lock, flags);
+
+	BUG_ON(!ar);
+	ar->ar_rq = rq;
+
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))	/* 48-bit LBA */
-		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
+		return lba_48_rw_disk(drive, ar, block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
-		return lba_28_rw_disk(drive, rq, (unsigned long) block);
+		return lba_28_rw_disk(drive, ar, block);
 
 	/* 28-bit CHS : DIE DIE DIE piece of legacy crap!!! */
-	return chs_rw_disk(drive, rq, (unsigned long) block);
+	return chs_rw_disk(drive, ar, block);
 }
 
-static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
+static task_ioreg_t get_command (ide_drive_t *drive, struct request *rq)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
+	int multi_count = drive->mult_count;
+	int cmd = rq_data_dir(rq);
+
+	if (rq->nr_sectors % multi_count)
+		multi_count = 0;
 
 #if 1
 	lba48bit = drive->addressing;
@@ -172,14 +190,15 @@
 		return WIN_NOP;
 }
 
-static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t chs_rw_disk (ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	ide_task_t			*args = &ar->ar_task;
 	int				sectors;
+	struct request			*rq = ar->ar_rq;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
@@ -192,7 +211,7 @@
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
-	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+	if (command == WIN_MULTWRITE) {
 		sectors = drive->mult_count;
 		if (sectors > rq->current_nr_sectors)
 			sectors = rq->current_nr_sectors;
@@ -215,33 +234,33 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
-	args.command_type	= ide_cmd_type_parser(&args);
-	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
-	args.handler		= ide_handler_parser(&taskfile, &hobfile);
-	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
-	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	memcpy(args->tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(args->hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args->command_type	= ide_cmd_type_parser(args);
+	args->prehandler	= ide_pre_handler_parser(&taskfile, &hobfile);
+	args->handler		= ide_handler_parser(&taskfile, &hobfile);
+	args->posthandler	= NULL;
+	args->ar		= ar;
+	args->block		= block;
+	rq->special		= ar;
 
-	return do_rw_taskfile(drive, &args);
+	return do_rw_taskfile(drive, args);
 }
 
-static ide_startstop_t lba_28_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t lba_28_rw_disk (ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	ide_task_t			*args = &ar->ar_task;
 	int				sectors;
+	struct request			*rq = ar->ar_rq;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
-	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+	if (command == WIN_MULTWRITE) {
 		sectors = drive->mult_count;
 		if (sectors > rq->current_nr_sectors)
 			sectors = rq->current_nr_sectors;
@@ -267,18 +286,17 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
-	args.command_type	= ide_cmd_type_parser(&args);
-	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
-	args.handler		= ide_handler_parser(&taskfile, &hobfile);
-	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
-	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	memcpy(args->tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(args->hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args->command_type	= ide_cmd_type_parser(args);
+	args->prehandler	= ide_pre_handler_parser(&taskfile, &hobfile);
+	args->handler		= ide_handler_parser(&taskfile, &hobfile);
+	args->posthandler	= NULL;
+	args->ar		= ar;
+	args->block		= block;
+	rq->special		= ar;
 
-	return do_rw_taskfile(drive, &args);
+	return do_rw_taskfile(drive, args);
 }
 
 /*
@@ -287,22 +305,23 @@
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
 
-static ide_startstop_t lba_48_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long long block)
+static ide_startstop_t lba_48_rw_disk (ide_drive_t *drive, ata_request_t *ar, sector_t block)
 {
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
-	ide_task_t			args;
+	ide_task_t			*args = &ar->ar_task;
 	int				sectors;
+	struct request			*rq = ar->ar_rq;
 
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
+	task_ioreg_t command	= get_command(drive, rq);
 
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
 	sectors = rq->nr_sectors;
-	if (sectors == 256)
+	if (sectors == 65536)
 		sectors = 0;
-	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
+	if (command == WIN_MULTWRITE_EXT) {
 		sectors = drive->mult_count;
 		if (sectors > rq->current_nr_sectors)
 			sectors = rq->current_nr_sectors;
@@ -311,11 +330,6 @@
 	taskfile.sector_count	= sectors;
 	hobfile.sector_count	= sectors >> 8;
 
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
-	}
-
 	taskfile.sector_number	= block;	/* low lba */
 	taskfile.low_cylinder	= (block>>=8);	/* mid lba */
 	taskfile.high_cylinder	= (block>>=8);	/* hi  lba */
@@ -336,18 +350,17 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
-	args.command_type	= ide_cmd_type_parser(&args);
-	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
-	args.handler		= ide_handler_parser(&taskfile, &hobfile);
-	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
-	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	memcpy(args->tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
+	memcpy(args->hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args->command_type	= ide_cmd_type_parser(args);
+	args->prehandler	= ide_pre_handler_parser(&taskfile, &hobfile);
+	args->handler		= ide_handler_parser(&taskfile, &hobfile);
+	args->posthandler	= NULL;
+	args->ar		= ar;
+	args->block		= block;
+	rq->special		= ar;
 
-	return do_rw_taskfile(drive, &args);
+	return do_rw_taskfile(drive, args);
 }
 
 static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)

-- 
Jens Axboe

