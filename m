Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUCBVKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUCBVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:10:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37528 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261815AbUCBVIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:08:25 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups for 2.6.4-rc1 (3/3)
Date: Tue, 2 Mar 2004 22:15:39 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022215.39560.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove IDE_*_OFFSET_HOB and IDE_*_REG_HOB defines

They are identical to non _HOB versions (except IDE_CONTROL_OFFSET_HOB).

 linux-2.6.4-rc1-root/drivers/ide/ide-disk.c     |   34 ++++++++++++------------
 linux-2.6.4-rc1-root/drivers/ide/ide-io.c       |   14 ++++-----
 linux-2.6.4-rc1-root/drivers/ide/ide-taskfile.c |   16 +++++------
 linux-2.6.4-rc1-root/include/linux/ide.h        |   19 -------------
 4 files changed, 32 insertions(+), 51 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_HOB_cleanup drivers/ide/ide-disk.c
--- linux-2.6.4-rc1/drivers/ide/ide-disk.c~ide_HOB_cleanup	2004-03-02 22:11:08.500833952 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-disk.c	2004-03-02 22:11:08.521830760 +0100
@@ -706,11 +706,11 @@ static ide_startstop_t lba_48_rw_disk (i
 	if (blk_rq_tagged(rq)) {
 		args.tfRegister[IDE_FEATURE_OFFSET] = sectors;
 		args.tfRegister[IDE_NSECTOR_OFFSET] = rq->tag << 3;
-		args.hobRegister[IDE_FEATURE_OFFSET_HOB] = sectors >> 8;
-		args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = 0;
+		args.hobRegister[IDE_FEATURE_OFFSET] = sectors >> 8;
+		args.hobRegister[IDE_NSECTOR_OFFSET] = 0;
 	} else {
 		args.tfRegister[IDE_NSECTOR_OFFSET] = sectors;
-		args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = sectors >> 8;
+		args.hobRegister[IDE_NSECTOR_OFFSET] = sectors >> 8;
 	}
 
 	args.tfRegister[IDE_SECTOR_OFFSET]	= block;	/* low lba */
@@ -718,10 +718,10 @@ static ide_startstop_t lba_48_rw_disk (i
 	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
 	args.tfRegister[IDE_SELECT_OFFSET]	= drive->select.all;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
-	args.hobRegister[IDE_SECTOR_OFFSET_HOB]	= (block>>=8);	/* low lba */
-	args.hobRegister[IDE_LCYL_OFFSET_HOB]	= (block>>=8);	/* mid lba */
-	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= (block>>=8);	/* hi  lba */
-	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= drive->select.all;
+	args.hobRegister[IDE_SECTOR_OFFSET]	= (block>>=8);	/* low lba */
+	args.hobRegister[IDE_LCYL_OFFSET]	= (block>>=8);	/* mid lba */
+	args.hobRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
+	args.hobRegister[IDE_SELECT_OFFSET]	= drive->select.all;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
@@ -963,9 +963,9 @@ static unsigned long long idedisk_read_n
 
 	/* if OK, compute maximum address value */
 	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = ((args.hobRegister[IDE_HCYL_OFFSET_HOB])<<16) |
-			   ((args.hobRegister[IDE_LCYL_OFFSET_HOB])<<8) |
-  			    (args.hobRegister[IDE_SECTOR_OFFSET_HOB]); 
+		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
+			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
+			    args.hobRegister[IDE_SECTOR_OFFSET];
 		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
@@ -1021,10 +1021,10 @@ static unsigned long long idedisk_set_ma
 	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
 	args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX_EXT;
-	args.hobRegister[IDE_SECTOR_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_LCYL_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
-	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= 0x40;
+	args.hobRegister[IDE_SECTOR_OFFSET]	= (addr_req >>= 8) & 0xff;
+	args.hobRegister[IDE_LCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
+	args.hobRegister[IDE_HCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
+	args.hobRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
@@ -1032,9 +1032,9 @@ static unsigned long long idedisk_set_ma
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
 	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = ((args.hobRegister[IDE_HCYL_OFFSET_HOB])<<16) |
-			   ((args.hobRegister[IDE_LCYL_OFFSET_HOB])<<8) |
-			    (args.hobRegister[IDE_SECTOR_OFFSET_HOB]);
+		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
+			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
+			    args.hobRegister[IDE_SECTOR_OFFSET];
 		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
diff -puN drivers/ide/ide-io.c~ide_HOB_cleanup drivers/ide/ide-io.c
--- linux-2.6.4-rc1/drivers/ide/ide-io.c~ide_HOB_cleanup	2004-03-02 22:11:08.503833496 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-io.c	2004-03-02 22:11:08.522830608 +0100
@@ -197,7 +197,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			if (args->tf_in_flags.b.data) {
 				u16 data				= hwif->INW(IDE_DATA_REG);
 				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET_HOB]	= (data >> 8) & 0xFF;
+				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
 			}
 			args->tfRegister[IDE_ERROR_OFFSET]   = err;
 			args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
@@ -208,12 +208,12 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 
 			if (drive->addressing == 1) {
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
-				args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
-				args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
-				args->hobRegister[IDE_SECTOR_OFFSET_HOB]  = hwif->INB(IDE_SECTOR_REG);
-				args->hobRegister[IDE_LCYL_OFFSET_HOB]    = hwif->INB(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET_HOB]    = hwif->INB(IDE_HCYL_REG);
+				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
+				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
+				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
+				args->hobRegister[IDE_SECTOR_OFFSET]	= hwif->INB(IDE_SECTOR_REG);
+				args->hobRegister[IDE_LCYL_OFFSET]	= hwif->INB(IDE_LCYL_REG);
+				args->hobRegister[IDE_HCYL_OFFSET]	= hwif->INB(IDE_HCYL_REG);
 			}
 		}
 	} else if (blk_pm_request(rq)) {
diff -puN drivers/ide/ide-taskfile.c~ide_HOB_cleanup drivers/ide/ide-taskfile.c
--- linux-2.6.4-rc1/drivers/ide/ide-taskfile.c~ide_HOB_cleanup	2004-03-02 22:11:08.513831976 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-taskfile.c	2004-03-02 22:11:08.524830304 +0100
@@ -121,13 +121,13 @@ void debug_taskfile (ide_drive_t *drive,
 	printk("TF.6=x%02x ", args->tfRegister[IDE_SELECT_OFFSET]);
 	printk("TF.7=x%02x\n", args->tfRegister[IDE_COMMAND_OFFSET]);
 	printk(KERN_INFO "%s: ", drive->name);
-//	printk("HTF.0=x%02x ", args->hobRegister[IDE_DATA_OFFSET_HOB]);
-	printk("HTF.1=x%02x ", args->hobRegister[IDE_FEATURE_OFFSET_HOB]);
-	printk("HTF.2=x%02x ", args->hobRegister[IDE_NSECTOR_OFFSET_HOB]);
-	printk("HTF.3=x%02x ", args->hobRegister[IDE_SECTOR_OFFSET_HOB]);
-	printk("HTF.4=x%02x ", args->hobRegister[IDE_LCYL_OFFSET_HOB]);
-	printk("HTF.5=x%02x ", args->hobRegister[IDE_HCYL_OFFSET_HOB]);
-	printk("HTF.6=x%02x ", args->hobRegister[IDE_SELECT_OFFSET_HOB]);
+//	printk("HTF.0=x%02x ", args->hobRegister[IDE_DATA_OFFSET]);
+	printk("HTF.1=x%02x ", args->hobRegister[IDE_FEATURE_OFFSET]);
+	printk("HTF.2=x%02x ", args->hobRegister[IDE_NSECTOR_OFFSET]);
+	printk("HTF.3=x%02x ", args->hobRegister[IDE_SECTOR_OFFSET]);
+	printk("HTF.4=x%02x ", args->hobRegister[IDE_LCYL_OFFSET]);
+	printk("HTF.5=x%02x ", args->hobRegister[IDE_HCYL_OFFSET]);
+	printk("HTF.6=x%02x ", args->hobRegister[IDE_SELECT_OFFSET]);
 	printk("HTF.7=x%02x\n", args->hobRegister[IDE_CONTROL_OFFSET_HOB]);
 }
 #endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
@@ -1018,7 +1018,7 @@ int ide_diag_taskfile (ide_drive_t *driv
 	 */
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
-			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
+			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
 		else
 			rq.nr_sectors = data_size / SECTOR_SIZE;
 
diff -puN include/linux/ide.h~ide_HOB_cleanup include/linux/ide.h
--- linux-2.6.4-rc1/include/linux/ide.h~ide_HOB_cleanup	2004-03-02 22:11:08.517831368 +0100
+++ linux-2.6.4-rc1-root/include/linux/ide.h	2004-03-02 22:11:08.526830000 +0100
@@ -143,17 +143,8 @@ typedef unsigned char	byte;	/* used ever
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
 
-#define IDE_DATA_OFFSET_HOB	(0)
-#define IDE_ERROR_OFFSET_HOB	(1)
-#define IDE_NSECTOR_OFFSET_HOB	(2)
-#define IDE_SECTOR_OFFSET_HOB	(3)
-#define IDE_LCYL_OFFSET_HOB	(4)
-#define IDE_HCYL_OFFSET_HOB	(5)
-#define IDE_SELECT_OFFSET_HOB	(6)
 #define IDE_CONTROL_OFFSET_HOB	(7)
 
-#define IDE_FEATURE_OFFSET_HOB	IDE_ERROR_OFFSET_HOB
-
 #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
 #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
@@ -165,16 +156,6 @@ typedef unsigned char	byte;	/* used ever
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

_

