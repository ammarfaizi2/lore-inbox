Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSC1J1q>; Thu, 28 Mar 2002 04:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSC1J10>; Thu, 28 Mar 2002 04:27:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:19979 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313113AbSC1J1D>; Thu, 28 Mar 2002 04:27:03 -0500
Message-ID: <3CA2E186.6060508@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:25:26 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.7 IDE 25
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090002000208060602070400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002000208060602070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wed Mar 20 01:52:22 CET 2002 ide-clean-25

- Replace the task_io_reg_t with the simple u8. There is no need to obfuscate
   the code more then necessary.

- kill some unnecessary type definitions out from hdreg.h.

- Add proper attributes to register files in hdreg.h.

- Don't use raw arrays for tfRegister and hobRegister in ide_task_s.  Use out
   nice global structures describing the fields in them.  This allows to kill
   the following defines:

     IDE_DATA_OFFSET
     IDE_FEATURE_OFFSET
     IDE_NSECTOR_OFFSET
     IDE_SECTOR_OFFSET
     IDE_LCYL_OFFSET
     IDE_HCYL_OFFSET
     IDE_SELECT_OFFSET
     IDE_COMMAND_OFFSET

   and many many others.

- Please have a look at the following in pdc4030.c. It couldn't have worked!
   This has been fixed in one go with the above change:

   memcpy(args.hobRegister, NULL, sizeof(struct hd_drive_hob_hdr));

- Kill the redundant *_REG_HOB definitions. They don't help readability in any
   way.

--------------090002000208060602070400
Content-Type: text/plain;
 name="ide-clean-25.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-25.diff"

diff -urN linux-2.5.7/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.7/drivers/ide/ide-disk.c	Wed Mar 20 03:28:37 2002
+++ linux/drivers/ide/ide-disk.c	Wed Mar 20 03:10:27 2002
@@ -106,7 +106,7 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-static task_ioreg_t get_command(ide_drive_t *drive, int cmd)
+static u8 get_command(ide_drive_t *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
 
@@ -162,17 +162,19 @@
 	unsigned int head	= (track % drive->head);
 	unsigned int cyl	= (track / drive->head);
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
 	taskfile.sector_count	= sectors;
+
 	taskfile.sector_number	= sect;
 	taskfile.low_cylinder	= cyl;
 	taskfile.high_cylinder	= (cyl>>8);
+
 	taskfile.device_head	= head;
 	taskfile.device_head	|= drive->select.all;
 	taskfile.command	=  get_command(drive, rq_data_dir(rq));
@@ -186,14 +188,14 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive,
-			(struct hd_drive_task_hdr *) &args.tfRegister,
-			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			&args.taskfile,
+			&args.hobfile,
 			args.handler,
 			args.prehandler,
 			rq);
@@ -210,14 +212,16 @@
 	if (sectors == 256)
 		sectors = 0;
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
 	taskfile.sector_count	= sectors;
 	taskfile.sector_number	= block;
-	taskfile.low_cylinder	= (block>>=8);
-	taskfile.high_cylinder	= (block>>=8);
-	taskfile.device_head	= ((block>>8)&0x0f);
+	taskfile.low_cylinder	= (block >>= 8);
+
+	taskfile.high_cylinder	= (block >>= 8);
+
+	taskfile.device_head	= ((block >> 8) & 0x0f);
 	taskfile.device_head	|= drive->select.all;
 	taskfile.command	= get_command(drive, rq_data_dir(rq));
 
@@ -230,14 +234,14 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive,
-			(struct hd_drive_task_hdr *) &args.tfRegister,
-			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			&args.taskfile,
+			&args.hobfile,
 			args.handler,
 			args.prehandler,
 			rq);
@@ -256,8 +260,8 @@
 	ide_task_t			args;
 	int				sectors;
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
 	sectors = rq->nr_sectors;
 	if (sectors == 65536)
@@ -271,12 +275,14 @@
 		hobfile.sector_count	= 0x00;
 	}
 
-	taskfile.sector_number	= block;	/* low lba */
-	taskfile.low_cylinder	= (block>>=8);	/* mid lba */
-	taskfile.high_cylinder	= (block>>=8);	/* hi  lba */
-	hobfile.sector_number	= (block>>=8);	/* low lba */
-	hobfile.low_cylinder	= (block>>=8);	/* mid lba */
-	hobfile.high_cylinder	= (block>>=8);	/* hi  lba */
+	taskfile.sector_number	= block;		/* low lba */
+	taskfile.low_cylinder	= (block >>= 8);	/* mid lba */
+	taskfile.high_cylinder	= (block >>= 8);	/* hi  lba */
+
+	hobfile.sector_number	= (block >>= 8);	/* low lba */
+	hobfile.low_cylinder	= (block >>= 8);	/* mid lba */
+	hobfile.high_cylinder	= (block >>= 8);	/* hi  lba */
+
 	taskfile.device_head	= drive->select.all;
 	hobfile.device_head	= taskfile.device_head;
 	hobfile.control		= (drive->ctl|0x80);
@@ -291,14 +297,14 @@
 	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
 #endif
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
+	args.taskfile = taskfile;
+	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive,
-			(struct hd_drive_task_hdr *) &args.tfRegister,
-			(struct hd_drive_hob_hdr *) &args.hobRegister,
+			&args.taskfile,
+			&args.hobfile,
 			args.handler,
 			args.prehandler,
 			rq);
@@ -355,6 +361,7 @@
 		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
 		check_disk_change(inode->i_rdev);
+
 		taskfile.command = WIN_DOORLOCK;
 
 		/*
@@ -376,9 +383,9 @@
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 	if (drive->id->cfs_enable_2 & 0x2400)
-		taskfile.command	= WIN_FLUSH_CACHE_EXT;
+		taskfile.command = WIN_FLUSH_CACHE_EXT;
 	else
-		taskfile.command	= WIN_FLUSH_CACHE;
+		taskfile.command = WIN_FLUSH_CACHE;
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 }
 
@@ -387,9 +394,12 @@
 	if (drive->removable && !drive->usage) {
 		struct hd_drive_task_hdr taskfile;
 		struct hd_drive_hob_hdr hobfile;
+
 		memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+
 		invalidate_bdev(inode->i_bdev, 0);
+
 		taskfile.command = WIN_DOORUNLOCK;
 		if (drive->doorlocking &&
 		    ide_wait_taskfile(drive, &taskfile, &hobfile, NULL))
@@ -423,21 +433,23 @@
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
-	args.handler				= task_no_data_intr;
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_READ_NATIVE_MAX;
+	args.handler = task_no_data_intr;
 
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		addr = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((args.taskfile.command & 0x01) == 0) {
+		addr = ((args.taskfile.device_head & 0x0f) << 24)
+		     | (args.taskfile.high_cylinder << 16)
+		     | (args.taskfile.low_cylinder <<  8)
+		     | args.taskfile.sector_number;
 	}
+
 	addr++;	/* since the return value is (maxlba - 1), we add 1 */
+
 	return addr;
 }
 
@@ -449,24 +461,26 @@
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
 
-	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
-	args.handler				= task_no_data_intr;
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_READ_NATIVE_MAX_EXT;
+	args.handler = task_no_data_intr;
 
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = ((args.hobRegister[IDE_HCYL_OFFSET_HOB])<<16) |
-			   ((args.hobRegister[IDE_LCYL_OFFSET_HOB])<<8) |
-			    (args.hobRegister[IDE_SECTOR_OFFSET_HOB]);
-		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((args.taskfile.command & 0x01) == 0) {
+		u32 high = (args.hobfile.high_cylinder << 16) |
+			   (args.hobfile.low_cylinder << 8) |
+			    args.hobfile.sector_number;
+		u32 low  = (args.taskfile.high_cylinder << 16) |
+			   (args.taskfile.low_cylinder << 8) |
+			    args.taskfile.sector_number;
 		addr = ((__u64)high << 24) | low;
 	}
+
 	addr++;	/* since the return value is (maxlba - 1), we add 1 */
+
 	return addr;
 }
 
@@ -483,20 +497,22 @@
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>  8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >> 16) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
+
+	args.taskfile.sector_number = (addr_req >> 0);
+	args.taskfile.low_cylinder = (addr_req >> 8);
+	args.taskfile.high_cylinder = (addr_req >> 16);
+
+	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
+	args.taskfile.command = WIN_SET_MAX;
 	args.handler				= task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		addr_set = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((args.taskfile.command & 0x01) == 0) {
+		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
+			 | (args.taskfile.high_cylinder << 16)
+			 | (args.taskfile.low_cylinder <<  8)
+			 | args.taskfile.sector_number;
 	}
 	addr_set++;
 	return addr_set;
@@ -510,27 +526,31 @@
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX_EXT;
-	args.hobRegister[IDE_SECTOR_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_LCYL_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= 0x40;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
+
+	args.taskfile.sector_number = (addr_req >>  0);
+	args.taskfile.low_cylinder = (addr_req >>= 8);
+	args.taskfile.high_cylinder = (addr_req >>= 8);
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_SET_MAX_EXT;
+
+	args.hobfile.sector_number = (addr_req >>= 8);
+	args.hobfile.low_cylinder = (addr_req >>= 8);
+	args.hobfile.high_cylinder = (addr_req >>= 8);
+
+	args.hobfile.device_head = 0x40;
+	args.hobfile.control = (drive->ctl | 0x80);
+
         args.handler				= task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = ((args.hobRegister[IDE_HCYL_OFFSET_HOB])<<16) |
-			   ((args.hobRegister[IDE_LCYL_OFFSET_HOB])<<8) |
-			    (args.hobRegister[IDE_SECTOR_OFFSET_HOB]);
-		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((args.taskfile.command & 0x01) == 0) {
+		u32 high = (args.hobfile.high_cylinder << 16) |
+			   (args.hobfile.low_cylinder << 8) |
+			    args.hobfile.sector_number;
+		u32 low  = (args.taskfile.high_cylinder << 16) |
+			   (args.taskfile.low_cylinder << 8) |
+			    args.taskfile.sector_number;
 		addr_set = ((__u64)high << 24) | low;
 	}
 	return addr_set;
diff -urN linux-2.5.7/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.7/drivers/ide/ide-dma.c	Mon Mar 18 21:37:07 2002
+++ linux/drivers/ide/ide-dma.c	Wed Mar 20 02:44:47 2002
@@ -592,7 +592,7 @@
 			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
 			    (drive->addressing == 1)) {
 				ide_task_t *args = HWGROUP(drive)->rq->special;
-				OUT_BYTE(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
+				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 			} else if (drive->addressing) {
 				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 			} else {
diff -urN linux-2.5.7/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.7/drivers/ide/ide-features.c	Mon Mar 18 21:37:17 2002
+++ linux/drivers/ide/ide-features.c	Wed Mar 20 03:03:34 2002
@@ -2,7 +2,7 @@
  * linux/drivers/block/ide-features.c	Version 0.04	June 9, 2000
  *
  *  Copyright (C) 1999-2000	Linus Torvalds & authors (see below)
- *  
+ *
  *  Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  *
  *  Extracts if ide.c to address the evolving transfer rate code for
@@ -186,9 +186,9 @@
  */
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
+	if ((args->taskfile.command == WIN_SETFEATURES) &&
+	    (args->taskfile.sector_number > XFER_UDMA_2) &&
+	    (args->taskfile.feature == SETFEATURES_XFER)) {
 		if (!HWIF(drive)->udma_four) {
 			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", HWIF(drive)->name);
 			return 1;
@@ -213,9 +213,9 @@
  */
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
+	if ((args->taskfile.command == WIN_SETFEATURES) &&
+	    (args->taskfile.sector_number >= XFER_SW_DMA_0) &&
+	    (args->taskfile.feature == SETFEATURES_XFER) &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
diff -urN linux-2.5.7/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux-2.5.7/drivers/ide/ide-geometry.c	Mon Mar 18 21:37:03 2002
+++ linux/drivers/ide/ide-geometry.c	Wed Mar 20 02:03:29 2002
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/types.h>
 #include <linux/ide.h>
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
diff -urN linux-2.5.7/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.7/drivers/ide/ide-taskfile.c	Wed Mar 20 03:28:37 2002
+++ linux/drivers/ide/ide-taskfile.c	Wed Mar 20 03:06:52 2002
@@ -534,8 +534,8 @@
 	}
 
 	/* (ks/hs): Fixed Multi Write */
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] != WIN_MULTWRITE) &&
-	    (args->tfRegister[IDE_COMMAND_OFFSET] != WIN_MULTWRITE_EXT)) {
+	if ((args->taskfile.command != WIN_MULTWRITE) &&
+	    (args->taskfile.command != WIN_MULTWRITE_EXT)) {
 		unsigned long flags;
 		char *buf = ide_map_rq(rq, &flags);
 		/* For Write_sectors we need to stuff the first sector */
@@ -741,12 +741,12 @@
 /* Called by ioctl to feature out type of command being called */
 void ide_cmd_type_parser(ide_task_t *args)
 {
-	struct hd_drive_task_hdr *taskfile = (struct hd_drive_task_hdr *) args->tfRegister;
+	struct hd_drive_task_hdr *taskfile = &args->taskfile;
 
 	args->prehandler = NULL;
 	args->handler = NULL;
 
-	switch(args->tfRegister[IDE_COMMAND_OFFSET]) {
+	switch(args->taskfile.command) {
 		case WIN_IDENTIFY:
 		case WIN_PIDENTIFY:
 			args->handler = task_in_intr;
@@ -797,9 +797,11 @@
 		case WIN_SMART:
 			if (taskfile->feature == SMART_WRITE_LOG_SECTOR)
 				args->prehandler = pre_task_out_intr;
-			args->tfRegister[IDE_LCYL_OFFSET] = SMART_LCYL_PASS;
-			args->tfRegister[IDE_HCYL_OFFSET] = SMART_HCYL_PASS;
-			switch(args->tfRegister[IDE_FEATURE_OFFSET]) {
+
+			args->taskfile.low_cylinder = SMART_LCYL_PASS;
+			args->taskfile.high_cylinder = SMART_HCYL_PASS;
+
+			switch(args->taskfile.feature) {
 				case SMART_READ_VALUES:
 				case SMART_READ_THRESHOLDS:
 				case SMART_READ_LOG_SECTOR:
@@ -837,7 +839,7 @@
 #endif
 		case WIN_SETFEATURES:
 			args->handler = task_no_data_intr;
-			switch(args->tfRegister[IDE_FEATURE_OFFSET]) {
+			switch(args->taskfile.feature) {
 				case SETFEATURES_XFER:
 					args->command_type = IDE_DRIVE_TASK_SET_XFER;
 					return;
@@ -944,27 +946,13 @@
 int ide_wait_taskfile(ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf)
 {
 	struct request rq;
+	/* FIXME: This is on stack! */
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
 
-	args.tfRegister[IDE_DATA_OFFSET]         = taskfile->data;
-	args.tfRegister[IDE_FEATURE_OFFSET]      = taskfile->feature;
-	args.tfRegister[IDE_NSECTOR_OFFSET]      = taskfile->sector_count;
-	args.tfRegister[IDE_SECTOR_OFFSET]       = taskfile->sector_number;
-	args.tfRegister[IDE_LCYL_OFFSET]         = taskfile->low_cylinder;
-	args.tfRegister[IDE_HCYL_OFFSET]         = taskfile->high_cylinder;
-	args.tfRegister[IDE_SELECT_OFFSET]       = taskfile->device_head;
-	args.tfRegister[IDE_COMMAND_OFFSET]      = taskfile->command;
-
-	args.hobRegister[IDE_DATA_OFFSET_HOB]    = hobfile->data;
-	args.hobRegister[IDE_FEATURE_OFFSET_HOB] = hobfile->feature;
-	args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = hobfile->sector_count;
-	args.hobRegister[IDE_SECTOR_OFFSET_HOB]  = hobfile->sector_number;
-	args.hobRegister[IDE_LCYL_OFFSET_HOB]    = hobfile->low_cylinder;
-	args.hobRegister[IDE_HCYL_OFFSET_HOB]    = hobfile->high_cylinder;
-	args.hobRegister[IDE_SELECT_OFFSET_HOB]  = hobfile->device_head;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB] = hobfile->control;
+	args.taskfile = *taskfile;
+	args.hobfile = *hobfile;
 
 	init_taskfile_request(&rq);
 
@@ -986,7 +974,9 @@
 	rq.buffer = buf;
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
-		rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
+		rq.current_nr_sectors = rq.nr_sectors
+			= (args->hobfile.sector_count << 8)
+			| args->taskfile.sector_count;
 
 	rq.special = args;
 
@@ -1032,13 +1022,13 @@
 	if (copy_from_user(args, (void *)arg, 4))
 		return -EFAULT;
 
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  = args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];
+	tfargs.taskfile.feature = args[2];
+	tfargs.taskfile.sector_count = args[3];
+	tfargs.taskfile.sector_number = args[1];
+	tfargs.taskfile.low_cylinder = 0x00;
+	tfargs.taskfile.high_cylinder = 0x00;
+	tfargs.taskfile.device_head = 0x00;
+	tfargs.taskfile.command = args[0];
 
 	if (args[3]) {
 		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
diff -urN linux-2.5.7/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.7/drivers/ide/ide.c	Wed Mar 20 03:28:37 2002
+++ linux/drivers/ide/ide.c	Wed Mar 20 03:17:31 2002
@@ -737,22 +737,25 @@
 		ide_task_t *args = (ide_task_t *) rq->special;
 		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
 		if (args) {
-			args->tfRegister[IDE_ERROR_OFFSET]   = err;
-			args->tfRegister[IDE_NSECTOR_OFFSET] = IN_BYTE(IDE_NSECTOR_REG);
-			args->tfRegister[IDE_SECTOR_OFFSET]  = IN_BYTE(IDE_SECTOR_REG);
-			args->tfRegister[IDE_LCYL_OFFSET]    = IN_BYTE(IDE_LCYL_REG);
-			args->tfRegister[IDE_HCYL_OFFSET]    = IN_BYTE(IDE_HCYL_REG);
-			args->tfRegister[IDE_SELECT_OFFSET]  = IN_BYTE(IDE_SELECT_REG);
-			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
+			args->taskfile.feature = err;
+			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
+			args->taskfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
+			args->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
+			args->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
+			args->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
+			args->taskfile.command = stat;
 			if ((drive->id->command_set_2 & 0x0400) &&
 			    (drive->id->cfs_enable_2 & 0x0400) &&
 			    (drive->addressing == 1)) {
-				OUT_BYTE(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
-				args->hobRegister[IDE_FEATURE_OFFSET_HOB] = IN_BYTE(IDE_FEATURE_REG);
-				args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = IN_BYTE(IDE_NSECTOR_REG);
-				args->hobRegister[IDE_SECTOR_OFFSET_HOB]  = IN_BYTE(IDE_SECTOR_REG);
-				args->hobRegister[IDE_LCYL_OFFSET_HOB]    = IN_BYTE(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET_HOB]    = IN_BYTE(IDE_HCYL_REG);
+				/* The following command goes to the hob file! */
+
+				OUT_BYTE(drive->ctl|0x80, IDE_CONTROL_REG);
+				args->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
+				args->hobfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
+
+				args->hobfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
+				args->hobfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
+				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
 	}
@@ -1081,12 +1084,12 @@
 					goto args_error;
 
 				ata_taskfile(drive,
-						(struct hd_drive_task_hdr *)&args->tfRegister,
-						(struct hd_drive_hob_hdr *)&args->hobRegister,
+						&args->taskfile,
+						&args->hobfile,
 						args->handler, NULL, NULL);
 
 				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
-							(args->command_type == IDE_DRIVE_TASK_OUT)) &&
+					(args->command_type == IDE_DRIVE_TASK_OUT)) &&
 						args->prehandler && args->handler)
 					return args->prehandler(drive, rq);
 				return ide_started;
diff -urN linux-2.5.7/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.7/drivers/ide/pdc4030.c	Wed Mar 20 03:28:37 2002
+++ linux/drivers/ide/pdc4030.c	Wed Mar 20 03:09:00 2002
@@ -549,8 +549,8 @@
  */
 ide_startstop_t do_pdc4030_io (ide_drive_t *drive, ide_task_t *task)
 {
-	struct request *rq	= HWGROUP(drive)->rq;
-	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
+	struct request *rq = HWGROUP(drive)->rq;
+	struct hd_drive_task_hdr *taskfile = &task->taskfile;
 	unsigned long timeout;
 	byte stat;
 
@@ -652,8 +652,9 @@
 	taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
 	taskfile.command	= (rq_data_dir(rq)==READ)?PROMISE_READ:PROMISE_WRITE;
 
-	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
-	memcpy(args.hobRegister, NULL, sizeof(struct hd_drive_hob_hdr));
+	args.taskfile = taskfile;
+	memset(&args.hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+
 	ide_cmd_type_parser(&args);
 	/* We don't use the generic inerrupt handlers here? */
 	args.prehandler		= NULL;
diff -urN linux-2.5.7/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.7/include/linux/hdreg.h	Mon Mar 18 21:37:14 2002
+++ linux/include/linux/hdreg.h	Wed Mar 20 03:23:44 2002
@@ -54,16 +54,9 @@
  *	HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
  */
 
-#if 0
-#include <asm/hdreg.h>
-typedef ide_ioreg_t task_ioreg_t;
-#else
-typedef unsigned char task_ioreg_t;
-#endif
-
-#define HDIO_DRIVE_CMD_HDR_SIZE		4*sizeof(task_ioreg_t)
-#define HDIO_DRIVE_TASK_HDR_SIZE	8*sizeof(task_ioreg_t)
-#define HDIO_DRIVE_HOB_HDR_SIZE		8*sizeof(task_ioreg_t)
+#define HDIO_DRIVE_CMD_HDR_SIZE		(4 * sizeof(u8))
+#define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(u8))
+#define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(u8))
 
 #define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_NO_DATA		0
@@ -74,57 +67,27 @@
 #define IDE_DRIVE_TASK_OUT		3
 #define IDE_DRIVE_TASK_RAW_WRITE	4
 
-struct hd_drive_cmd_hdr {
-	task_ioreg_t command;
-	task_ioreg_t sector_number;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
-};
-
-typedef struct hd_drive_task_hdr {
-	task_ioreg_t data;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
-	task_ioreg_t sector_number;
-	task_ioreg_t low_cylinder;
-	task_ioreg_t high_cylinder;
-	task_ioreg_t device_head;
-	task_ioreg_t command;
-} task_struct_t;
-
-typedef struct hd_drive_hob_hdr {
-	task_ioreg_t data;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
-	task_ioreg_t sector_number;
-	task_ioreg_t low_cylinder;
-	task_ioreg_t high_cylinder;
-	task_ioreg_t device_head;
-	task_ioreg_t control;
-} hob_struct_t;
-
-typedef union ide_reg_valid_s {
-	unsigned all				: 16;
-	struct {
-		unsigned data			: 1;
-		unsigned error_feature		: 1;
-		unsigned sector			: 1;
-		unsigned nsector		: 1;
-		unsigned lcyl			: 1;
-		unsigned hcyl			: 1;
-		unsigned select			: 1;
-		unsigned status_command		: 1;
-
-		unsigned data_hob		: 1;
-		unsigned error_feature_hob	: 1;
-		unsigned sector_hob		: 1;
-		unsigned nsector_hob		: 1;
-		unsigned lcyl_hob		: 1;
-		unsigned hcyl_hob		: 1;
-		unsigned select_hob		: 1;
-		unsigned control_hob		: 1;
-	} b;
-} ide_reg_valid_t;
+struct hd_drive_task_hdr {
+	u8 data;
+	u8 feature;
+	u8 sector_count;
+	u8 sector_number;
+	u8 low_cylinder;
+	u8 high_cylinder;
+	u8 device_head;
+	u8 command;
+} __attribute__((packed));
+
+struct hd_drive_hob_hdr {
+	u8 data;
+	u8 feature;
+	u8 sector_count;
+	u8 sector_number;
+	u8 low_cylinder;
+	u8 high_cylinder;
+	u8 device_head;
+	u8 control;
+} __attribute__((packed));
 
 /*
  * Define standard taskfile in/out register
@@ -134,23 +97,6 @@
 #define IDE_HOB_STD_OUT_FLAGS		0xC0
 #define IDE_HOB_STD_IN_FLAGS		0xC0
 
-typedef struct ide_task_request_s {
-	task_ioreg_t	io_ports[8];
-	task_ioreg_t	hob_ports[8];
-	ide_reg_valid_t	out_flags;
-	ide_reg_valid_t	in_flags;
-	int		data_phase;
-	int		req_cmd;
-	unsigned long	out_size;
-	unsigned long	in_size;
-} ide_task_request_t;
-
-typedef struct ide_ioctl_request_s {
-	ide_task_request_t	*task_request;
-	unsigned char		*out_buffer;
-	unsigned char		*in_buffer;
-} ide_ioctl_request_t;
-
 #define TASKFILE_INVALID		0x7fff
 #define TASKFILE_48			0x8000
 
@@ -212,7 +158,7 @@
 #define WIN_PIDENTIFY			0xA1 /* identify ATAPI device	*/
 #define WIN_QUEUED_SERVICE		0xA2
 #define WIN_SMART			0xB0 /* self-monitoring and reporting */
-#define CFA_ERASE_SECTORS       	0xC0
+#define CFA_ERASE_SECTORS		0xC0
 #define WIN_MULTREAD			0xC4 /* read sectors using multiple mode*/
 #define WIN_MULTWRITE			0xC5 /* write sectors using multiple mode */
 #define WIN_SETMULT			0xC6 /* enable/disable multiple mode */
@@ -221,12 +167,12 @@
 #define WIN_WRITEDMA			0xCA /* write sectors using DMA transfers */
 #define WIN_WRITEDMA_QUEUED		0xCC /* write sectors using Queued DMA transfers */
 #define CFA_WRITE_MULTI_WO_ERASE	0xCD /* CFA Write multiple without erase */
-#define WIN_GETMEDIASTATUS		0xDA	
+#define WIN_GETMEDIASTATUS		0xDA
 #define WIN_DOORLOCK			0xDE /* lock door on removable drives */
 #define WIN_DOORUNLOCK			0xDF /* unlock door on removable drives */
 #define WIN_STANDBYNOW1			0xE0
 #define WIN_IDLEIMMEDIATE		0xE1 /* force drive to become "ready" */
-#define WIN_STANDBY             	0xE2 /* Set device in Standby Mode */
+#define WIN_STANDBY			0xE2 /* Set device in Standby Mode */
 #define WIN_SETIDLE1			0xE3
 #define WIN_READ_BUFFER			0xE4 /* force read only 1 sector */
 #define WIN_CHECKPOWERMODE1		0xE5
@@ -268,7 +214,7 @@
 
 #define SMART_LCYL_PASS			0x4F
 #define SMART_HCYL_PASS			0xC2
-		
+
 /* WIN_SETFEATURES sub-commands */
 
 #define SETFEATURES_EN_WCACHE	0x02	/* Enable write cache */
diff -urN linux-2.5.7/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.7/include/linux/ide.h	Wed Mar 20 03:28:37 2002
+++ linux/include/linux/ide.h	Wed Mar 20 03:23:51 2002
@@ -90,17 +90,6 @@
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
 
-#define IDE_DATA_OFFSET_HOB	(0)
-#define IDE_ERROR_OFFSET_HOB	(1)
-#define IDE_NSECTOR_OFFSET_HOB	(2)
-#define IDE_SECTOR_OFFSET_HOB	(3)
-#define IDE_LCYL_OFFSET_HOB	(4)
-#define IDE_HCYL_OFFSET_HOB	(5)
-#define IDE_SELECT_OFFSET_HOB	(6)
-#define IDE_CONTROL_OFFSET_HOB	(7)
-
-#define IDE_FEATURE_OFFSET_HOB	IDE_ERROR_OFFSET_HOB
-
 #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
 #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
@@ -112,16 +101,6 @@
 #define IDE_CONTROL_REG		(HWIF(drive)->io_ports[IDE_CONTROL_OFFSET])
 #define IDE_IRQ_REG		(HWIF(drive)->io_ports[IDE_IRQ_OFFSET])
 
-#define IDE_DATA_REG_HOB	(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
-#define IDE_ERROR_REG_HOB	(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
-#define IDE_NSECTOR_REG_HOB	(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
-#define IDE_SECTOR_REG_HOB	(HWIF(drive)->io_ports[IDE_SECTOR_OFFSET])
-#define IDE_LCYL_REG_HOB	(HWIF(drive)->io_ports[IDE_LCYL_OFFSET])
-#define IDE_HCYL_REG_HOB	(HWIF(drive)->io_ports[IDE_HCYL_OFFSET])
-#define IDE_SELECT_REG_HOB	(HWIF(drive)->io_ports[IDE_SELECT_OFFSET])
-#define IDE_STATUS_REG_HOB	(HWIF(drive)->io_ports[IDE_STATUS_OFFSET])
-#define IDE_CONTROL_REG_HOB	(HWIF(drive)->io_ports[IDE_CONTROL_OFFSET])
-
 #define IDE_FEATURE_REG		IDE_ERROR_REG
 #define IDE_COMMAND_REG		IDE_STATUS_REG
 #define IDE_ALTSTATUS_REG	IDE_CONTROL_REG
@@ -785,8 +764,8 @@
 void ide_end_drive_cmd (ide_drive_t *drive, byte stat, byte err);
 
 typedef struct ide_task_s {
-	task_ioreg_t		tfRegister[8];
-	task_ioreg_t		hobRegister[8];
+	struct hd_drive_task_hdr taskfile;
+	struct hd_drive_hob_hdr  hobfile;
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;

--------------090002000208060602070400--

