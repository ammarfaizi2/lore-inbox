Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFTKLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFTKLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTKLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:11:30 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13469 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261312AbVFTKKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:10:14 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] fix line break in ide messages
Date: Mon, 20 Jun 2005 13:10:00 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4XptCF5v7kfKmPo"
Message-Id: <200506201310.00987.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4XptCF5v7kfKmPo
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Bart,

Rediff against 2.6.12.

* printk("\n") is misplaced, resulting in stray empty line in kernel log
* cleanups nerby: some back-to-back printks are combined, etc

Context is increased in order to make patch correctness more obvious.
--
vda

--Boundary-00=_4XptCF5v7kfKmPo
Content-Type: text/x-diff;
  charset="koi8-r";
  name="ide-lib.c.2612.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-lib.c.2612.diff"

--- linux-2.6.12.src/drivers/ide/ide-lib.c.orig	Thu Mar  3 09:30:33 2005
+++ linux-2.6.12.src/drivers/ide/ide-lib.c	Sun Jun 19 18:32:25 2005
@@ -470,101 +470,98 @@ static void ide_dump_opcode(ide_drive_t 
 			task_struct_t *tf = (task_struct_t *) args->tfRegister;
 			opcode = tf->command;
 			found = 1;
 		}
 	}
 
 	printk("ide: failed opcode was: ");
 	if (!found)
 		printk("unknown\n");
 	else
 		printk("0x%02x\n", opcode);
 }
 
 static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	u8 err = 0;
 
 	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
+	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (stat & BUSY_STAT)
 		printk("Busy ");
 	else {
 		if (stat & READY_STAT)	printk("DriveReady ");
 		if (stat & WRERR_STAT)	printk("DeviceFault ");
 		if (stat & SEEK_STAT)	printk("SeekComplete ");
 		if (stat & DRQ_STAT)	printk("DataRequest ");
 		if (stat & ECC_STAT)	printk("CorrectedError ");
 		if (stat & INDEX_STAT)	printk("Index ");
 		if (stat & ERR_STAT)	printk("Error ");
 	}
-	printk("}");
-	printk("\n");
+	printk("}\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-		printk(" { ");
+		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
 		if (err & ABRT_ERR)	printk("DriveStatusError ");
 		if (err & ICRC_ERR)
-			printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
+			printk((err & ABRT_ERR) ? "BadCRC " : "BadSector ");
 		if (err & ECC_ERR)	printk("UncorrectableError ");
 		if (err & ID_ERR)	printk("SectorIdNotFound ");
 		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
 		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
 		printk("}");
 		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
 		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
 			if (drive->addressing == 1) {
 				__u64 sectors = 0;
 				u32 low = 0, high = 0;
 				low = ide_read_24(drive);
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 				high = ide_read_24(drive);
 				sectors = ((__u64)high << 24) | low;
 				printk(", LBAsect=%llu, high=%d, low=%d",
 				       (unsigned long long) sectors,
 				       high, low);
 			} else {
 				u8 cur = hwif->INB(IDE_SELECT_REG);
 				if (cur & 0x40) {	/* using LBA? */
 					printk(", LBAsect=%ld", (unsigned long)
 					 ((cur&0xf)<<24)
 					 |(hwif->INB(IDE_HCYL_REG)<<16)
 					 |(hwif->INB(IDE_LCYL_REG)<<8)
 					 | hwif->INB(IDE_SECTOR_REG));
 				} else {
 					printk(", CHS=%d/%d/%d",
 					 (hwif->INB(IDE_HCYL_REG)<<8) +
 					  hwif->INB(IDE_LCYL_REG),
 					  cur & 0xf,
 					  hwif->INB(IDE_SECTOR_REG));
 				}
 			}
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
 				printk(", sector=%llu",
 					(unsigned long long)HWGROUP(drive)->rq->sector);
 		}
+		printk("\n");
 	}
-	printk("\n");
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
 	return err;
 }
 
 /**
  *	ide_dump_atapi_status       -       print human readable atapi status
  *	@drive: drive that status applies to
  *	@msg: text message to print
  *	@stat: status byte to decode
  *
  *	Error reporting, in human readable form (luxurious, but a memory hog).
  */
 
 static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;
 
 	atapi_status_t status;
 	atapi_error_t error;

--Boundary-00=_4XptCF5v7kfKmPo--

