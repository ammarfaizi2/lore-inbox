Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSFCPIL>; Mon, 3 Jun 2002 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSFCPIK>; Mon, 3 Jun 2002 11:08:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55559 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317396AbSFCPH6>; Mon, 3 Jun 2002 11:07:58 -0400
Message-ID: <3CFB7899.3060209@evision-ventures.com>
Date: Mon, 03 Jun 2002 16:09:29 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: ]PATCH] 2.5.20 IDE 83
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060907070207000707070304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060907070207000707070304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon Jun  3 10:11:54 CEST 2002 ide-clean-83

- Remove last parameter from ide_dump_status. This information is now
   permanently present in device->staus field, so there is not need to pass it
   around.

- Patch for DVD read through ide-scsi. There is the possibility that we can get
   request structures passed down, which don't have the queue field set.
   At lest on the BIO code path this seems to be something worth further
   investigation. Found by Adam J. Richter. (Jens?)

- Revert my change to the hostdata handling. I did get it wrong about the way
   host structures are allocated by the generic SCSI layer. It plays
   tricks there.

- piix driver updates by Vojtech Pavlik.

- We have a ata_out_regfile, so we should have ata_in_regfile too.



--------------060907070207000707070304
Content-Type: text/plain;
 name="ide-clean-83.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-83.diff"

diff -urN linux-2.5.20/arch/i386/pci/fixup.c linux/arch/i386/pci/fixup.c
--- linux-2.5.20/arch/i386/pci/fixup.c	2002-06-03 03:44:42.000000000 +0200
+++ linux/arch/i386/pci/fixup.c	2002-06-03 16:45:45.000000000 +0200
@@ -99,6 +99,17 @@
 		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
 }
 
+static void __devinit pci_fixup_ide_exbar(struct pci_dev *d)
+{
+	/*
+	 * Some new Intel IDE controllers have an EXBAR register for
+	 * MMIO instead of PIO. It's unused, undocumented (though maybe
+	 * functional). BIOSes often assign conflicting memory address
+	 * to this. Just kill it.
+	 */
+	d->resource[5].start = d->resource[5].end = d->resource[5].flags = 0;
+}
+
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
 	/*
@@ -174,6 +185,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	pci_fixup_piix4_acpi },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_10,	pci_fixup_ide_exbar },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_11,	pci_fixup_ide_exbar },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_9,	pci_fixup_ide_exbar },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8622,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
diff -urN linux-2.5.20/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.20/drivers/ide/Config.help	2002-06-03 03:44:52.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-06-03 14:43:45.000000000 +0200
@@ -409,13 +409,14 @@
   the chip to optimum performance.
 
 CONFIG_BLK_DEV_PIIX_TRY133
-  The ICH2, ICH2-M, ICH3, ICH3-M, ICH3-S and CICH chips can support
-  UDMA133 in hardware, even though the specifications of the chips
-  say otherwise. By enabling this option, you allow the driver to
-  enable the UDMA133 mode on these chips.
+  The ICH2, ICH2-M, ICH3, ICH3-M, ICH3-S, ICH-4 and CICH chips can
+  support UDMA133 in hardware, even though the specifications of
+  the chips say otherwise. By enabling this option, you allow the
+  driver to enable the UDMA133 mode on these chips. Note that if
+  it doesn't work, your data gets lost, you're on your own, don't
+  expect any help. 
 
-  If you want to stay on the safe side, say N here.
-  If you prefer maximum performance, say Y here.
+  Say N here, unless you really know what are you doing.
 
 CONFIG_BLK_DEV_PDC202XX
   Promise Ultra33 or PDC20246
diff -urN linux-2.5.20/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.20/drivers/ide/Config.in	2002-06-03 03:44:53.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-06-03 14:43:45.000000000 +0200
@@ -53,7 +53,7 @@
       dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_bool '    Intel and Efar (SMsC) chipset support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
       if [ "$CONFIG_BLK_DEV_PIIX" = "y" ]; then
-         dep_bool '      Use UDMA133 even on ICH2, ICH3 and CICH chips (EXPERIMENTAL)' CONFIG_BLK_DEV_PIIX_TRY133 $CONFIG_EXPERIMENTAL
+         dep_bool '      Allow undocumented UDMA133 on ICH chips (EXPERIMENTAL)' CONFIG_BLK_DEV_PIIX_TRY133 $CONFIG_EXPERIMENTAL
       fi
       if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
          dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN linux-2.5.20/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.20/drivers/ide/device.c	2002-06-03 03:44:46.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-03 14:51:18.000000000 +0200
@@ -159,4 +159,18 @@
 	OUT_BYTE(rf->high_cylinder, ch->io_ports[IDE_HCYL_OFFSET]);
 }
 
+/*
+ * Output a complete register file.
+ */
+void ata_in_regfile(struct ata_device *drive, struct hd_drive_task_hdr *rf)
+{
+	struct ata_channel *ch = drive->channel;
+
+	rf->sector_count = IN_BYTE(ch->io_ports[IDE_NSECTOR_OFFSET]);
+	rf->sector_number = IN_BYTE(ch->io_ports[IDE_SECTOR_OFFSET]);
+	rf->low_cylinder = IN_BYTE(ch->io_ports[IDE_LCYL_OFFSET]);
+	rf->high_cylinder = IN_BYTE(ch->io_ports[IDE_HCYL_OFFSET]);
+}
+
+
 MODULE_LICENSE("GPL");
diff -urN linux-2.5.20/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.20/drivers/ide/hpt34x.c	2002-06-03 03:44:41.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-03 12:35:54.000000000 +0200
@@ -253,7 +253,7 @@
 	unsigned int count;
 	u8 cmd;
 
-	if (!(count = udma_new_table(ch, rq)))
+	if (!(count = udma_new_table(drive, rq)))
 		return 1;	/* try PIO instead of DMA */
 
 	if (rq_data_dir(rq) == READ)
diff -urN linux-2.5.20/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.20/drivers/ide/icside.c	2002-06-03 03:44:41.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-03 12:35:54.000000000 +0200
@@ -275,8 +275,9 @@
 #define NR_ENTRIES 256
 #define TABLE_SIZE (NR_ENTRIES * 8)
 
-static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
+static int ide_build_sglist(struct ata_device *drive, struct request *rq)
 {
+	struct ata_channel *ch = drive->channel;
 	struct scatterlist *sg = ch->sg_table;
 	int nents;
 
@@ -294,7 +295,7 @@
 		sg->length = rq->nr_sectors * SECTOR_SIZE;
 		nents = 1;
 	} else {
-		nents = blk_rq_map_sg(rq->q, rq, sg);
+		nents = blk_rq_map_sg(&drive->queue, rq, sg);
 
 		if (rq->q && nents > rq->nr_phys_segments)
 			printk("icside: received %d segments, build %d\n",
@@ -586,7 +587,7 @@
 {
 	printk(KERN_ERR "ATA: %s: UDMA timeout occured:", drive->name);
 	ata_status(drive, 0, 0);
-	ide_dump_status(drive, NULL, "UDMA timeout", drive->status);
+	ata_dump(drive, NULL, "UDMA timeout");
 }
 
 static void icside_irq_lost(struct ata_device *drive)
diff -urN linux-2.5.20/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.20/drivers/ide/ide.c	2002-06-03 03:44:48.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-03 14:52:20.000000000 +0200
@@ -405,10 +405,7 @@
 		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
 		if (ar) {
 			ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
-			ar->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
-			ar->taskfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
-			ar->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
-			ar->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
+			ata_in_regfile(drive, &ar->taskfile);
 			ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
 			if ((drive->id->command_set_2 & 0x0400) &&
 			    (drive->id->cfs_enable_2 & 0x0400) &&
@@ -416,10 +413,7 @@
 				/* The following command goes to the hob file! */
 				OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
 				ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
-				ar->hobfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
-				ar->hobfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
-				ar->hobfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
-				ar->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
+				ata_in_regfile(drive, &ar->hobfile);
 			}
 		}
 	}
@@ -437,46 +431,46 @@
 };
 
 static struct ata_bit_messages ata_status_msgs[] = {
-	{ BUSY_STAT,  BUSY_STAT,  "Busy"           },
-	{ READY_STAT, READY_STAT, "DriveReady"     },
-	{ WRERR_STAT, WRERR_STAT, "DeviceFault"    },
-	{ SEEK_STAT,  SEEK_STAT,  "SeekComplete"   },
-	{ DRQ_STAT,   DRQ_STAT,   "DataRequest"    },
-	{ ECC_STAT,   ECC_STAT,   "CorrectedError" },
-	{ INDEX_STAT, INDEX_STAT, "Index"          },
-	{ ERR_STAT,   ERR_STAT,   "Error"          }
+	{ BUSY_STAT,  BUSY_STAT,  "busy"            },
+	{ READY_STAT, READY_STAT, "drive ready"     },
+	{ WRERR_STAT, WRERR_STAT, "device fault"    },
+	{ SEEK_STAT,  SEEK_STAT,  "seek complete"   },
+	{ DRQ_STAT,   DRQ_STAT,   "data request"    },
+	{ ECC_STAT,   ECC_STAT,   "corrected error" },
+	{ INDEX_STAT, INDEX_STAT, "index"           },
+	{ ERR_STAT,   ERR_STAT,   "error"           }
 };
 
 static struct ata_bit_messages ata_error_msgs[] = {
-	{ ICRC_ERR|ABRT_ERR,	ABRT_ERR,		"DriveStatusError"   },
-	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"BadSector"	     },
-	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR|ABRT_ERR,	"BadCRC"	     },
-	{ ECC_ERR,		ECC_ERR,		"UncorrectableError" },
-	{ ID_ERR,		ID_ERR,			"SectorIdNotFound"   },
-	{ TRK0_ERR,		TRK0_ERR,		"TrackZeroNotFound"  },
-	{ MARK_ERR,		MARK_ERR,		"AddrMarkNotFound"   }
+	{ ICRC_ERR|ABRT_ERR,	ABRT_ERR,		"drive status error"	},
+	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"bad sectorr"		},
+	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR|ABRT_ERR,	"invalid checksum"	},
+	{ ECC_ERR,		ECC_ERR,		"uncorrectable error"	},
+	{ ID_ERR,		ID_ERR,			"sector id not found"   },
+	{ TRK0_ERR,		TRK0_ERR,		"track zero not found"	},
+	{ MARK_ERR,		MARK_ERR,		"addr mark not found"   }
 };
 
-static void ata_dump_bits(struct ata_bit_messages *msgs, int nr, byte bits)
+static void dump_bits(struct ata_bit_messages *msgs, int nr, byte bits)
 {
 	int i;
 
-	printk(" { ");
+	printk(" [ ");
 
 	for (i = 0; i < nr; i++, msgs++)
 		if ((bits & msgs->mask) == msgs->match)
 			printk("%s ", msgs->msg);
 
-	printk("} ");
+	printk("] ");
 }
 #else
-# define ata_dump_bits(msgs,nr,bits) do { } while (0)
+# define dump_bits(msgs,nr,bits) do { } while (0)
 #endif
 
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
-u8 ide_dump_status(struct ata_device *drive, struct request * rq, const char *msg, u8 stat)
+u8 ata_dump(struct ata_device *drive, struct request * rq, const char *msg)
 {
 	unsigned long flags;
 	u8 err = 0;
@@ -484,16 +478,16 @@
 	__save_flags (flags);	/* local CPU only */
 	ide__sti();		/* local CPU only */
 
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	ata_dump_bits(ata_status_msgs, ARRAY_SIZE(ata_status_msgs), stat);
+	printk("%s: %s: status=0x%02x", drive->name, msg, drive->status);
+	dump_bits(ata_status_msgs, ARRAY_SIZE(ata_status_msgs), drive->status);
 	printk("\n");
 
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
+	if ((drive->status & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = GET_ERR();
 		printk("%s: %s: error=0x%02x", drive->name, msg, err);
 #if FANCY_STATUS_DUMPS
 		if (drive->type == ATA_DISK) {
-			ata_dump_bits(ata_error_msgs, ARRAY_SIZE(ata_error_msgs), err);
+			dump_bits(ata_error_msgs, ARRAY_SIZE(ata_error_msgs), err);
 
 			if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
 				if ((drive->id->command_set_2 & 0x0400) &&
@@ -592,7 +586,7 @@
 	u8 err;
 	u8 stat = drive->status;
 
-	err = ide_dump_status(drive, rq, msg, stat);
+	err = ata_dump(drive, rq, msg);
 	if (!drive || !rq)
 		return ide_stopped;
 
@@ -1476,7 +1470,7 @@
 EXPORT_SYMBOL(do_ide_request);
 
 EXPORT_SYMBOL(ide_set_handler);
-EXPORT_SYMBOL(ide_dump_status);
+EXPORT_SYMBOL(ata_dump);
 EXPORT_SYMBOL(ata_error);
 
 EXPORT_SYMBOL(ide_wait_stat);
diff -urN linux-2.5.20/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.20/drivers/ide/ide-cd.c	2002-06-03 03:44:48.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-03 10:46:58.000000000 +0200
@@ -614,7 +614,7 @@
 			return 0;
 		} else if (!pc->quiet) {
 			/* Otherwise, print an error. */
-			ide_dump_status(drive, rq, "packet command error", drive->status);
+			ata_dump(drive, rq, "packet command error");
 		}
 
 		/* Set the error flag and complete the request.
@@ -662,13 +662,13 @@
 			   sense_key == DATA_PROTECT) {
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
-			ide_dump_status(drive, rq, "command error", drive->status);
+			ata_dump(drive, rq, "command error");
 			cdrom_end_request(drive, rq,  0);
 		} else if (sense_key == MEDIUM_ERROR) {
 			/* No point in re-trying a zillion times on a bad
 			 * sector.  The error is not correctable at all.
 			 */
-			ide_dump_status(drive, rq, "media error (bad sector)", drive->status);
+			ata_dump(drive, rq, "media error (bad sector)");
 			cdrom_end_request(drive, rq, 0);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
diff -urN linux-2.5.20/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.20/drivers/ide/pcidma.c	2002-06-03 03:44:43.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-03 12:35:54.000000000 +0200
@@ -58,8 +58,9 @@
  * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
  * FIXME: I agree with Jens --mdcki!
  */
-static int build_sglist(struct ata_channel *ch, struct request *rq)
+static int build_sglist(struct ata_device *drive, struct request *rq)
 {
+	struct ata_channel *ch = drive->channel;
 	struct scatterlist *sg = ch->sg_table;
 	int nents = 0;
 
@@ -69,7 +70,7 @@
 		unsigned char *virt_addr = rq->buffer;
 		int sector_count = rq->nr_sectors;
 #else
-		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
+		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
 
 		if (nents > rq->nr_segments)
 			printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
@@ -99,7 +100,7 @@
 		sg[nents].length =  sector_count  * SECTOR_SIZE;
 		++nents;
 	} else {
-		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
+		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
 
 		if (rq->q && nents > rq->nr_phys_segments)
 			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
@@ -150,7 +151,7 @@
 		reading = 1 << 3;
 
 	/* try PIO instead of DMA */
-	if (!udma_new_table(ch, rq))
+	if (!udma_new_table(drive, rq))
 		return 1;
 
 	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
@@ -306,8 +307,9 @@
  * This prepares a dma request.  Returns 0 if all went okay, returns 1
  * otherwise.  May also be invoked from trm290.c
  */
-int udma_new_table(struct ata_channel *ch, struct request *rq)
+int udma_new_table(struct ata_device *drive, struct request *rq)
 {
+	struct ata_channel *ch = drive->channel;
 	unsigned int *table = ch->dmatable_cpu;
 #ifdef CONFIG_BLK_DEV_TRM290
 	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
@@ -318,7 +320,7 @@
 	int i;
 	struct scatterlist *sg;
 
-	ch->sg_nents = i = build_sglist(ch, rq);
+	ch->sg_nents = i = build_sglist(drive, rq);
 	if (!i)
 		return 0;
 
diff -urN linux-2.5.20/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.20/drivers/ide/piix.c	2002-06-03 03:44:47.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-06-03 14:43:45.000000000 +0200
@@ -1,6 +1,5 @@
-/**** vi:set ts=8 sts=8 sw=8:************************************************
- *
- * $Id: piix.c,v 1.3 2002/03/29 16:06:06 vojtech Exp $
+/*
+ *  piix.c, v1.5 2002/05/03
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -9,6 +8,7 @@
  *      Andre Hedrick
  *
  *  Thanks to Daniela Egbert for advice on PIIX bugs.
+ *  Thanks to Ulf Axelsson for noticing that ICH4 only documents UDMA100.
  */
 
 /*
@@ -85,20 +85,20 @@
 	unsigned short id;
 	unsigned char flags;
 } piix_ide_chips[] = {
-	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
-	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3/ICH3-S */
-	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
-	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
-	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
-	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
-	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },                    /* Intel 82801AB ICH0 */
-	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },                    /* Intel 82801AA ICH */
-	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	                                    /* Intel 82372FB PIIX5 */
-	{ PCI_DEVICE_ID_INTEL_82443MX_1,	PIIX_UDMA_33 },                                     /* Intel 82443MX MPIIX4 */
-	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },                                     /* Intel 82371AB/EB PIIX4/PIIX4E */
-	{ PCI_DEVICE_ID_INTEL_82371SB_1,	PIIX_UDMA_NONE },                                   /* Intel 82371SB PIIX3 */
-	{ PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_UDMA_NONE | PIIX_NO_SITRE | PIIX_CHECK_REV },  /* Intel 82371FB PIIX */
-	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_66 | PIIX_VICTORY },                      /* Efar Victory66 */
+	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801DB ICH4 */
+	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801CA ICH3/ICH3-S */
+	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801CAM ICH3-M */
+	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801E C-ICH */
+	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801BA ICH2 */
+	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },			/* Intel 82801BAM ICH2-M */
+	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG},				/* Intel 82801AB ICH0 */
+	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },			/* Intel 82801AA ICH */
+	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },						/* Intel 82372FB PIIX5 */
+	{ PCI_DEVICE_ID_INTEL_82443MX_1,	PIIX_UDMA_33 },						/* Intel 82443MX MPIIX4 */
+	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },						/* Intel 82371AB/EB PIIX4/PIIX4E */
+	{ PCI_DEVICE_ID_INTEL_82371SB_1,	PIIX_UDMA_NONE },					/* Intel 82371SB PIIX3 */
+	{ PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_UDMA_NONE | PIIX_NO_SITRE | PIIX_CHECK_REV },	/* Intel 82371FB PIIX */
+	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_66 | PIIX_VICTORY },				/* Efar Victory66 */
 	{ 0 }
 };
 
@@ -122,7 +122,7 @@
 
 	switch (dn & 1) {
 
-		case 1: 
+		case 1:
 			if (timing->cycle > 9) {
 				t &= ~0x30;
 				break;
@@ -177,7 +177,7 @@
 			&& ~piix_config->flags & PIIX_VICTORY) {
 
 			pci_read_config_dword(dev, PIIX_IDECFG, &c);
-			
+
 			if ((piix_config->flags & PIIX_UDMA) > PIIX_UDMA_66)
 				c &= ~(1 << (dn + 12));
 			c &= ~(1 << dn);
@@ -214,7 +214,7 @@
 		umul = 2;
 	if (speed > XFER_UDMA_4 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100)
 		umul = 4;
-	
+
 	T = 1000000000 / system_bus_speed;
 	UT = T / umul;
 
@@ -280,6 +280,7 @@
  */
 static unsigned int __init piix_init_chipset(struct pci_dev *dev)
 {
+	struct pci_dev *orion = NULL;
 	unsigned int u;
 	unsigned short w;
 	unsigned char t;
@@ -293,55 +294,24 @@
 		if (dev->device == piix_config->id)
 			break;
 
-	if (!piix_config->id) {
-		printk(KERN_WARNING "PIIX: Unknown PIIX/ICH chip %#x, contact Vojtech Pavlik <vojtech@ucw.cz>\n", dev->device);
-		return -ENODEV;
-	}
-
 /*
  * Check for possibly broken DMA configs.
  */
 
-	{
-		struct pci_dev *orion = NULL;
-
-		if (piix_config->flags & PIIX_CHECK_REV) {
-			pci_read_config_byte(dev, PCI_REVISION_ID, &t);
-			if (t < 2) {
-				printk(KERN_INFO "PIIX: Found buggy old PIIX rev %#x, disabling DMA\n", t);
-				piix_config->flags |= PIIX_NODMA;
-			}
-		}
-
-		if ((orion = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454GX, NULL))) {
-			pci_read_config_byte(orion, PCI_REVISION_ID, &t);
-			if (t < 4) {
-				printk(KERN_INFO "PIIX: Found buggy 82454GX Orion bridge rev %#x, disabling DMA\n", t);
-				piix_config->flags |= PIIX_NODMA;
-			}
+	if (piix_config->flags & PIIX_CHECK_REV) {
+		pci_read_config_byte(dev, PCI_REVISION_ID, &t);
+		if (t < 2) {
+			printk(KERN_INFO "PIIX: Found buggy old PIIX rev %#x, disabling DMA\n", t);
+			piix_config->flags |= PIIX_NODMA;
 		}
 	}
 
-/*
- * Check 80-wire cable presence.
- */
-
-	switch (piix_config->flags & PIIX_UDMA) {
-
-		case PIIX_UDMA_66:
-			if (piix_config->flags && PIIX_VICTORY) {
-				pci_read_config_byte(dev, PIIX_IDESTAT, &t);
-				piix_80w = ((t & 2) ? 1 : 0) | ((t & 1) ? 2 : 0);
-				break;
-			}
-
-#ifndef CONFIG_BLK_DEV_PIIX_TRY133
-		case PIIX_UDMA_100:
-#endif
-		case PIIX_UDMA_133:
-			pci_read_config_dword(dev, PIIX_IDECFG, &u);
-			piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
-			break;
+	if ((orion = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454GX, NULL))) {
+		pci_read_config_byte(orion, PCI_REVISION_ID, &t);
+		if (t < 4) {
+			printk(KERN_INFO "PIIX: Found buggy 82454GX Orion bridge rev %#x, disabling DMA\n", t);
+			piix_config->flags |= PIIX_NODMA;
+		}
 	}
 
 /*
@@ -377,32 +347,44 @@
 	return 0;
 }
 
-static unsigned int __init piix_ata66_check(struct ata_channel *hwif)
+static unsigned int __init piix_ata66_check(struct ata_channel *ch)
 {
-	return ((piix_enabled & piix_80w) >> hwif->unit) & 1;
+	unsigned char t;
+	unsigned int u;
+
+	if ((piix_config->flags & PIIX_UDMA) < PIIX_UDMA_66)
+		return 0;
+
+	if (piix_config->flags & PIIX_VICTORY) {
+		pci_read_config_byte(ch->pci_dev, PIIX_IDESTAT, &t);
+		return ch->unit ? (t & 1) : !!(t & 2);
+	}
+
+	pci_read_config_dword(ch->pci_dev, PIIX_IDECFG, &u);
+	return ch->unit ? !!(u & 0xc0) : !!(u & 0x30);
 }
 
-static void __init piix_init_channel(struct ata_channel *hwif)
+static void __init piix_init_channel(struct ata_channel *ch)
 {
 	int i;
 
-	hwif->tuneproc = &piix_tune_drive;
-	hwif->speedproc = &piix_set_drive;
-	hwif->autodma = 0;
-	hwif->io_32bit = 1;
-	hwif->unmask = 1;
+	ch->tuneproc = &piix_tune_drive;
+	ch->speedproc = &piix_set_drive;
+	ch->autodma = 0;
+	ch->io_32bit = 1;
+	ch->unmask = 1;
 	for (i = 0; i < 2; i++) {
-		hwif->drives[i].autotune = 1;
-		hwif->drives[i].dn = hwif->unit * 2 + i;
+		ch->drives[i].autotune = 1;
+		ch->drives[i].dn = ch->unit * 2 + i;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->dma_base) {
-		hwif->highmem = 1;
-		hwif->udma_setup = piix_udma_setup;
+	if (ch->dma_base) {
+		ch->highmem = 1;
+		ch->udma_setup = piix_udma_setup;
 # ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
-			hwif->autodma = 1;
+			ch->autodma = 1;
 # endif
 	}
 #endif
@@ -412,11 +394,11 @@
  * We allow the BM-DMA driver only work on enabled interfaces,
  * and only if DMA is safe with the chip and bridge.
  */
-static void __init piix_init_dma(struct ata_channel *hwif, unsigned long dmabase)
+static void __init piix_init_dma(struct ata_channel *ch, unsigned long dmabase)
 {
-	if (((piix_enabled >> hwif->unit) & 1)
+	if (((piix_enabled >> ch->unit) & 1)
 		&& !(piix_config->flags & PIIX_NODMA))
-			ata_init_dma(hwif, dmabase);
+			ata_init_dma(ch, dmabase);
 }
 
 
diff -urN linux-2.5.20/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.20/drivers/ide/probe.c	2002-06-03 03:44:37.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-06-03 10:45:51.000000000 +0200
@@ -385,7 +385,7 @@
 	enable_irq(ch->irq);
 
 	if (error) {
-		ide_dump_status(drive, NULL, "set_drive_speed_status", drive->status);
+		ata_dump(drive, NULL, "set drive speed");
 		return error;
 	}
 
diff -urN linux-2.5.20/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.20/drivers/ide/tcq.c	2002-06-03 03:44:52.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-03 10:51:31.000000000 +0200
@@ -247,8 +247,7 @@
 	OUT_BYTE(WIN_QUEUED_SERVICE, IDE_COMMAND_REG);
 
 	if (wait_altstat(drive, &stat, BUSY_STAT)) {
-		printk(KERN_ERR"%s: BUSY clear took too long\n", __FUNCTION__);
-		ide_dump_status(drive, rq, __FUNCTION__, stat);
+		ata_dump(drive, rq, "BUSY clear took too long");
 		tcq_invalidate_queue(drive);
 
 		return ide_stopped;
@@ -262,7 +261,7 @@
 	 * FIXME, invalidate queue
 	 */
 	if (stat & ERR_STAT) {
-		ide_dump_status(drive, rq, __FUNCTION__, stat);
+		ata_dump(drive, rq, "ERR condition");
 		tcq_invalidate_queue(drive);
 
 		return ide_stopped;
@@ -328,8 +327,7 @@
 	 * must be end of I/O, check status and complete as necessary
 	 */
 	if (!ata_status(drive, READY_STAT, drive->bad_wstat | DRQ_STAT)) {
-		printk(KERN_ERR "%s: %s: error status %x\n", __FUNCTION__, drive->name, drive->status);
-		ide_dump_status(drive, rq, __FUNCTION__, drive->status);
+		ata_dump(drive, rq, __FUNCTION__);
 		tcq_invalidate_queue(drive);
 
 		return ide_stopped;
@@ -557,7 +555,7 @@
 	OUT_BYTE(args->cmd, IDE_COMMAND_REG);
 
 	if (wait_altstat(drive, &stat, BUSY_STAT)) {
-		ide_dump_status(drive, rq, "queued start", stat);
+		ata_dump(drive, rq, "queued start");
 		tcq_invalidate_queue(drive);
 		return ide_stopped;
 	}
@@ -567,7 +565,7 @@
 #endif
 
 	if (stat & ERR_STAT) {
-		ide_dump_status(drive, rq, "tcq_start", stat);
+		ata_dump(drive, rq, "tcq_start");
 		return ide_stopped;
 	}
 
diff -urN linux-2.5.20/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.20/drivers/ide/trm290.c	2002-06-03 03:44:43.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-03 12:35:54.000000000 +0200
@@ -217,7 +217,7 @@
 		writing = 0;
 	}
 
-	if (!(count = udma_new_table(ch, rq))) {
+	if (!(count = udma_new_table(drive, rq))) {
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 		return 1;	/* try PIO instead of DMA */
 	}
diff -urN linux-2.5.20/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.20/drivers/scsi/ide-scsi.c	2002-06-03 03:44:39.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-03 12:37:26.000000000 +0200
@@ -229,10 +229,15 @@
 	printk("]\n");
 }
 
+static inline idescsi_scsi_t *idescsi_private(struct Scsi_Host *host)
+{
+	return (idescsi_scsi_t*) &host[1];
+}
+
 static int idescsi_end_request(struct ata_device *drive, struct request *rq, int uptodate)
 {
 	struct Scsi_Host *host = drive->driver_data;
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(host);
 	struct atapi_packet_command *pc = (struct atapi_packet_command *) rq->special;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	u8 *scsi_buf;
@@ -289,7 +294,7 @@
 static ide_startstop_t idescsi_pc_intr(struct ata_device *drive, struct request *rq)
 {
 	struct Scsi_Host *host = drive->driver_data;
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(host);
 	u8 ireason;
 	int bcount;
 	struct atapi_packet_command *pc=scsi->pc;
@@ -372,7 +377,7 @@
 static ide_startstop_t idescsi_transfer_pc(struct ata_device *drive, struct request *rq)
 {
 	struct Scsi_Host *host = drive->driver_data;
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(host);
 	struct atapi_packet_command *pc = scsi->pc;
 	byte ireason;
 	ide_startstop_t startstop;
@@ -398,7 +403,7 @@
 		struct atapi_packet_command *pc)
 {
 	struct Scsi_Host *host = drive->driver_data;
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(host);
 	int bcount;
 	int dma_ok = 0;
 
@@ -473,7 +478,6 @@
 	if (ide_unregister_subdriver (drive)) {
 		return 1;
 	}
-	kfree((idescsi_scsi_t *) host->hostdata[0]);
 	scsi_unregister(host);
 
 	return 0;
@@ -515,7 +519,7 @@
 
 static int idescsi_ioctl(Scsi_Device *dev, int cmd, void *arg)
 {
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) dev->host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(dev->host);
 
 	if (cmd == SG_SET_TRANSFORM) {
 		if (arg)
@@ -612,7 +616,7 @@
 static inline int should_transform(struct ata_device *drive, Scsi_Cmnd *cmd)
 {
 	struct Scsi_Host *host = drive->driver_data;
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(host);
 
 	if (major(cmd->request.rq_dev) == SCSI_GENERIC_MAJOR)
 		return test_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
@@ -621,7 +625,7 @@
 
 static int idescsi_queue(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) cmd->host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(cmd->host);
 	struct ata_device *drive = scsi->drive;
 	struct request *rq = NULL;
 	struct atapi_packet_command *pc = NULL;
@@ -691,7 +695,7 @@
 
 static int idescsi_bios(Disk *disk, kdev_t dev, int *parm)
 {
-	idescsi_scsi_t *scsi = (idescsi_scsi_t *) disk->device->host->hostdata[0];
+	idescsi_scsi_t *scsi = idescsi_private(disk->device->host);
 	struct ata_device *drive = scsi->drive;
 
 	if (drive->bios_cyl && drive->bios_head && drive->bios_sect) {
@@ -758,8 +762,7 @@
 	drive->driver_data = host;
 	drive->ready_stat = 0;
 
-	scsi = kmalloc(sizeof(*scsi), GFP_ATOMIC);
-	host->hostdata[0] = (unsigned long) scsi;
+	scsi = idescsi_private(host);
 	memset(scsi,0, sizeof (*scsi));
 	scsi->drive = drive;
 
diff -urN linux-2.5.20/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.20/include/linux/ide.h	2002-06-03 03:44:43.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-03 14:52:03.000000000 +0200
@@ -610,11 +610,7 @@
 extern void ide_set_handler(struct ata_device *drive, ata_handler_t handler,
 		unsigned long timeout, ata_expiry_t expiry);
 
-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
- */
-extern u8 ide_dump_status(struct ata_device *, struct request *rq, const char *, u8);
-
+extern u8 ata_dump(struct ata_device *, struct request *, const char *);
 extern ide_startstop_t ata_error(struct ata_device *, struct request *rq, const char *);
 
 extern void ide_fixstring(char *s, const int bytecount, const int byteswap);
@@ -799,7 +795,7 @@
 extern void udma_pci_irq_lost(struct ata_device *);
 extern int udma_pci_setup(struct ata_device *);
 
-extern int udma_new_table(struct ata_channel *, struct request *);
+extern int udma_new_table(struct ata_device *, struct request *);
 extern void udma_destroy_table(struct ata_channel *);
 extern void udma_print(struct ata_device *);
 
@@ -834,5 +830,6 @@
 extern int ata_irq_enable(struct ata_device *, int);
 extern void ata_reset(struct ata_channel *);
 extern void ata_out_regfile(struct ata_device *, struct hd_drive_task_hdr *);
+extern void ata_in_regfile(struct ata_device *, struct hd_drive_task_hdr *);
 
 #endif

--------------060907070207000707070304--

