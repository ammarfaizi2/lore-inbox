Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSDPIHp>; Tue, 16 Apr 2002 04:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSDPIHo>; Tue, 16 Apr 2002 04:07:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58886 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313174AbSDPIHg>; Tue, 16 Apr 2002 04:07:36 -0400
Message-ID: <3CBBCD31.4090105@evision-ventures.com>
Date: Tue, 16 Apr 2002 09:05:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030007040407060907010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007040407060907010406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Apr 16 01:02:47 CEST 2002 ide-clean-36

- Consolidate ide_choose_drive() and choose_drive() in to one function.

- Remove sector data byteswpapping support. Byte-swapping the data is supported
   on the file-system level where applicable.  Byte-swapped interfaces are
   supported on a lower level anyway. And finally it was used inconsistently.

- Eliminate taskfile_input_data() and taskfile_output_data(). This allowed us
   to split up ideproc and eliminate the ugly action switch as well as the
   corresponding defines.

- Remove tons of unnecessary typedefs from ide.h

- Prepate the PIO read write code for soon overhaul.

- Misc small bits here and there :-).


--------------030007040407060907010406
Content-Type: text/plain;
 name="ide-clean-36.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-36.diff"

diff -urN linux-2.5.8/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.8/arch/cris/drivers/ide.c	Mon Apr 15 08:53:39 2002
+++ linux/arch/cris/drivers/ide.c	Tue Apr 16 03:44:10 2002
@@ -272,13 +272,17 @@
 	printk("ide: ETRAX 100LX built-in ATA DMA controller\n");
 
 	/* first initialize the channel interface data */
-	
+
 	for(h = 0; h < MAX_HWIFS; h++) {
 		struct ata_channel *hwif = &ide_hwifs[h];
+
 		hwif->chipset = ide_etrax100;
 		hwif->tuneproc = &tune_e100_ide;
 		hwif->dmaproc = &e100_dmaproc;
-		hwif->ideproc = &e100_ideproc;
+		hwif->ata_read = e100_ide_input_data;
+		hwif->ata_write = e100_ide_input_data;
+		hwif->atapi_read = e100_atapi_read;
+		hwif->atapi_write = e100_atapi_write;
 	}
 	/* actually reset and configure the etrax100 ide/ata interface */
 
@@ -375,12 +379,12 @@
  * so if an odd bytecount is specified, be sure that there's at least one
  * extra byte allocated for the buffer.
  */
-static void 
-e100_atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount)
+static void
+e100_atapi_read(ide_drive_t *drive, void *buffer, unsigned int bytecount)
 {
 	ide_ioreg_t data_reg = IDE_DATA_REG;
 
-	D(printk("atapi_input_bytes, dreg 0x%x, buffer 0x%x, count %d\n",
+	D(printk("atapi_read, dreg 0x%x, buffer 0x%x, count %d\n",
 		 data_reg, buffer, bytecount));
 	
 	if(bytecount & 1) {
@@ -454,12 +458,12 @@
 #endif
 }
 
-static void 
-e100_atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount)
+static void
+e100_atapi_write(ide_drive_t *drive, void *buffer, unsigned int bytecount)
 {
 	ide_ioreg_t data_reg = IDE_DATA_REG;
 	
-	D(printk("atapi_output_bytes, dreg 0x%x, buffer 0x%x, count %d\n",
+	D(printk("atapi_write, dreg 0x%x, buffer 0x%x, count %d\n",
 		 data_reg, buffer, bytecount));
 
 	if(bytecount & 1) {
@@ -544,7 +548,7 @@
 static void 
 e100_ide_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
-	e100_atapi_input_bytes(drive, buffer, wcount << 2);
+	e100_atapi_read(drive, buffer, wcount << 2);
 }
 
 /*
@@ -553,7 +557,7 @@
 static void
 e100_ide_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
-	e100_atapi_output_bytes(drive, buffer, wcount << 2);
+	e100_atapi_write(drive, buffer, wcount << 2);
 }
 
 /*
@@ -570,11 +574,11 @@
 		case ideproc_ide_output_data:
 			e100_ide_input_data(drive, buffer, length);
 			break;
-		case ideproc_atapi_input_bytes:
-			e100_atapi_input_bytes(drive, buffer, length);
+		case ideproc_atapi_read:
+			e100_atapi_read(drive, buffer, length);
 			break;
-		case ideproc_atapi_output_bytes:
-			e100_atapi_output_bytes(drive, buffer, length);
+		case ideproc_atapi_write:
+			e100_atapi_write(drive, buffer, length);
 			break;
 		default:
 			printk("e100_ideproc: unsupported func %d!\n", func);
diff -urN linux-2.5.8/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8/drivers/ide/ide-cd.c	Tue Apr 16 06:01:04 2002
+++ linux/drivers/ide/ide-cd.c	Tue Apr 16 03:23:56 2002
@@ -791,7 +791,7 @@
 	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	atapi_output_bytes(drive, cmd, CDROM_PACKET_SIZE);
+	atapi_write(drive, cmd, CDROM_PACKET_SIZE);
 
 	return ide_started;
 }
@@ -830,7 +830,7 @@
 	/* Read the data into the buffer. */
 	dest = info->buffer + info->nsectors_buffered * SECTOR_SIZE;
 	while (sectors_to_buffer > 0) {
-		atapi_input_bytes (drive, dest, SECTOR_SIZE);
+		atapi_read(drive, dest, SECTOR_SIZE);
 		--sectors_to_buffer;
 		--sectors_to_transfer;
 		++info->nsectors_buffered;
@@ -840,7 +840,7 @@
 	/* Throw away any remaining data. */
 	while (sectors_to_transfer > 0) {
 		char dum[SECTOR_SIZE];
-		atapi_input_bytes (drive, dum, sizeof (dum));
+		atapi_read(drive, dum, sizeof (dum));
 		--sectors_to_transfer;
 	}
 }
@@ -866,7 +866,7 @@
 		   and quit this request. */
 		while (len > 0) {
 			int dum = 0;
-			atapi_output_bytes (drive, &dum, sizeof (dum));
+			atapi_write(drive, &dum, sizeof (dum));
 			len -= sizeof (dum);
 		}
 	} else  if (ireason == 1) {
@@ -963,7 +963,7 @@
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
 		char dum[SECTOR_SIZE];
-		atapi_input_bytes (drive, dum, sizeof (dum));
+		atapi_read(drive, dum, SECTOR_SIZE);
 
 		--rq->current_nr_sectors;
 		--nskip;
@@ -994,7 +994,7 @@
 			/* Read this_transfer sectors
 			   into the current buffer. */
 			while (this_transfer > 0) {
-				atapi_input_bytes(drive, rq->buffer, SECTOR_SIZE);
+				atapi_read(drive, rq->buffer, SECTOR_SIZE);
 				rq->buffer += SECTOR_SIZE;
 				--rq->nr_sectors;
 				--rq->current_nr_sectors;
@@ -1290,13 +1290,14 @@
 	/* The drive wants to be written to. */
 	if ((ireason & 3) == 0) {
 		/* Transfer the data. */
-		atapi_output_bytes (drive, pc->buffer, thislen);
+		atapi_write(drive, pc->buffer, thislen);
 
 		/* If we haven't moved enough data to satisfy the drive,
 		   add some padding. */
 		while (len > thislen) {
 			int dum = 0;
-			atapi_output_bytes (drive, &dum, sizeof (dum));
+
+			atapi_write(drive, &dum, sizeof (dum));
 			len -= sizeof (dum);
 		}
 
@@ -1307,15 +1308,14 @@
 
 	/* Same drill for reading. */
 	else if ((ireason & 3) == 2) {
-
 		/* Transfer the data. */
-		atapi_input_bytes (drive, pc->buffer, thislen);
+		atapi_read(drive, pc->buffer, thislen);
 
 		/* If we haven't moved enough data to satisfy the drive,
 		   add some padding. */
 		while (len > thislen) {
 			int dum = 0;
-			atapi_input_bytes (drive, &dum, sizeof (dum));
+			atapi_read(drive, &dum, sizeof (dum));
 			len -= sizeof (dum);
 		}
 
@@ -1458,7 +1458,7 @@
 		   and quit this request. */
 		while (len > 0) {
 			int dum = 0;
-			atapi_output_bytes(drive, &dum, sizeof(dum));
+			atapi_write(drive, &dum, sizeof(dum));
 			len -= sizeof(dum);
 		}
 	} else {
@@ -1549,7 +1549,7 @@
 		this_transfer = MIN(sectors_to_transfer,rq->current_nr_sectors);
 
 		while (this_transfer > 0) {
-			atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
+			atapi_write(drive, rq->buffer, SECTOR_SIZE);
 			rq->buffer += SECTOR_SIZE;
 			--rq->nr_sectors;
 			--rq->current_nr_sectors;
diff -urN linux-2.5.8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8/drivers/ide/ide-disk.c	Tue Apr 16 06:01:07 2002
+++ linux/drivers/ide/ide-disk.c	Tue Apr 16 05:38:16 2002
@@ -1051,7 +1051,6 @@
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
 	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addressing,	set_lba_addressing);
-	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
@@ -1198,11 +1197,11 @@
 	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
 	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
 		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
-	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
+	printk(KERN_INFO "%s: %ld sectors", drive->name, capacity);
 
 	/* Give size in megabytes (MB), not mebibytes (MiB). */
 	/* We compute the exact rounded value, avoiding overflow. */
-	printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+	printk(" (%ld MB)", (capacity - capacity/625 + 974)/1950);
 
 	/* Only print cache size when it was specified */
 	if (id->buf_size)
@@ -1213,7 +1212,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->using_dma)
 		(void) drive->channel->dmaproc(ide_dma_verbose, drive);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 	printk("\n");
 
 	drive->mult_count = 0;
@@ -1223,15 +1222,17 @@
 		id->multsect_valid = id->multsect ? 1 : 0;
 		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
 		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
-#else	/* original, pre IDE-NFG, per request of AC */
+#else
+		/* original, pre IDE-NFG, per request of AC */
 		drive->mult_req = INITIAL_MULT_COUNT;
 		if (drive->mult_req > id->max_multsect)
 			drive->mult_req = id->max_multsect;
 		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
 			drive->special.b.set_multmode = 1;
-#endif	/* CONFIG_IDEDISK_MULTI_MODE */
+#endif
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
+
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
 	probe_lba_addressing(drive, 1);
diff -urN linux-2.5.8/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.8/drivers/ide/ide-features.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-features.c	Tue Apr 16 02:36:34 2002
@@ -130,8 +130,8 @@
 		__restore_flags(flags);	/* local CPU only */
 		return 0;
 	}
-	ata_input_data(drive, id, SECTOR_WORDS);
-	(void) GET_STAT();	/* clear drive IRQ */
+	ata_read(drive, id, SECTOR_WORDS);
+	GET_STAT();		/* clear drive IRQ */
 	ide__sti();		/* local CPU only */
 	__restore_flags(flags);	/* local CPU only */
 	ide_fix_driveid(id);
@@ -285,7 +285,7 @@
 	enable_irq(hwif->irq);
 
 	if (error) {
-		(void) ide_dump_status(drive, "set_drive_speed_status", stat);
+		ide_dump_status(drive, "set_drive_speed_status", stat);
 		return error;
 	}
 
diff -urN linux-2.5.8/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.8/drivers/ide/ide-floppy.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Apr 16 03:24:42 2002
@@ -717,7 +717,7 @@
 			return;
 		}
 		count = IDEFLOPPY_MIN (bio->bi_size - pc->b_count, bcount);
-		atapi_input_bytes (drive, bio_data(bio) + pc->b_count, count);
+		atapi_read(drive, bio_data(bio) + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 	}
 }
@@ -744,7 +744,7 @@
 			return;
 		}
 		count = IDEFLOPPY_MIN (pc->b_count, bcount);
-		atapi_output_bytes (drive, pc->b_data, count);
+		atapi_write(drive, pc->b_data, count);
 		bcount -= count; pc->b_data += count; pc->b_count -= count;
 	}
 }
@@ -979,12 +979,12 @@
 	}
 	if (test_bit (PC_WRITING, &pc->flags)) {
 		if (pc->buffer != NULL)
-			atapi_output_bytes (drive,pc->current_position,bcount.all);	/* Write the current buffer */
+			atapi_write(drive,pc->current_position,bcount.all);	/* Write the current buffer */
 		else
 			idefloppy_output_buffers (drive, pc, bcount.all);
 	} else {
 		if (pc->buffer != NULL)
-			atapi_input_bytes (drive,pc->current_position,bcount.all);	/* Read the current buffer */
+			atapi_read(drive,pc->current_position,bcount.all);	/* Read the current buffer */
 		else
 			idefloppy_input_buffers (drive, pc, bcount.all);
 	}
@@ -1020,7 +1020,7 @@
 
 	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
-	atapi_output_bytes (drive, floppy->pc->c, 12); /* Send the actual packet */
+	atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
 
 	return ide_started;
 }
@@ -1042,7 +1042,7 @@
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 
-	atapi_output_bytes (drive, floppy->pc->c, 12); /* Send the actual packet */
+	atapi_write(drive, floppy->pc->c, 12); /* Send the actual packet */
 	return IDEFLOPPY_WAIT_CMD;		/* Timeout for the packet command */
 }
 
diff -urN linux-2.5.8/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8/drivers/ide/ide-probe.c	Tue Apr 16 06:01:07 2002
+++ linux/drivers/ide/ide-probe.c	Tue Apr 16 03:48:14 2002
@@ -57,9 +57,18 @@
 		printk(KERN_WARNING "(ide-probe::do_identify) Out of memory.\n");
 		goto err_kmalloc;
 	}
-	/* read 512 bytes of id info */
+
+	/* Read 512 bytes of id info.
+	 *
+	 * Please note that it is well known that some *very* old drives are
+	 * able to provide only 256 of them, since this was the amount read by
+	 * DOS.
+	 *
+	 * However let's try to get away with this...
+	 */
+
 #if 1
-	ata_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id info */
+	ata_read(drive, id, SECTOR_WORDS);
 #else
         {
                 unsigned long   *ptr = (unsigned long *)id ;
@@ -580,10 +589,10 @@
 	__restore_flags(flags);	/* local CPU only */
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
-		if (drive->present) {
-			ide_tuneproc_t *tuneproc = drive->channel->tuneproc;
-			if (tuneproc != NULL && drive->autotune == 1)
-				tuneproc(drive, 255);	/* auto-tune PIO mode */
+
+		if (drive->present && (drive->autotune == 1)) {
+			if (drive->channel->tuneproc != NULL)
+				drive->channel->tuneproc(drive, 255);	/* auto-tune PIO mode */
 		}
 	}
 }
diff -urN linux-2.5.8/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.8/drivers/ide/ide-proc.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-proc.c	Tue Apr 16 04:05:19 2002
@@ -422,7 +422,6 @@
 static void create_proc_ide_drives(struct ata_channel *hwif)
 {
 	int	d;
-	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
 
diff -urN linux-2.5.8/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.8/drivers/ide/ide-tape.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-tape.c	Tue Apr 16 03:25:29 2002
@@ -1503,9 +1503,9 @@
 			idetape_discard_data (drive, bcount);
 			return;
 		}
-#endif /* IDETAPE_DEBUG_BUGS */
+#endif
 		count = min(bio->bi_size - pc->b_count, bcount);
-		atapi_input_bytes (drive, bio_data(bio) + pc->b_count, count);
+		atapi_read(drive, bio_data(bio) + pc->b_count, count);
 		bcount -= count;
 		pc->b_count += bio->bi_size;
 		if (pc->b_count == bio->bi_size) {
@@ -1530,7 +1530,7 @@
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(pc->b_count, bcount);
-		atapi_output_bytes (drive, bio_data(bio), count);
+		atapi_write(drive, bio_data(bio), count);
 		bcount -= count;
 		pc->b_data += count;
 		pc->b_count -= count;
@@ -2169,12 +2169,12 @@
 		if (pc->bio != NULL)
 			idetape_output_buffers (drive, pc, bcount.all);
 		else
-			atapi_output_bytes (drive,pc->current_position,bcount.all);	/* Write the current buffer */
+			atapi_write(drive,pc->current_position,bcount.all);	/* Write the current buffer */
 	} else {
 		if (pc->bio != NULL)
 			idetape_input_buffers (drive, pc, bcount.all);
 		else
-			atapi_input_bytes (drive,pc->current_position,bcount.all);	/* Read the current buffer */
+			atapi_read(drive,pc->current_position,bcount.all);	/* Read the current buffer */
 	}
 	pc->actually_transferred += bcount.all;					/* Update the current position */
 	pc->current_position+=bcount.all;
@@ -2259,7 +2259,7 @@
 	tape->cmd_start_time = jiffies;
 	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* Set the interrupt routine */
-	atapi_output_bytes (drive,pc->c,12);			/* Send the actual packet */
+	atapi_write(drive,pc->c,12);	/* Send the actual packet */
 	return ide_started;
 }
 
diff -urN linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8/drivers/ide/ide-taskfile.c	Tue Apr 16 06:01:04 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Apr 16 05:38:53 2002
@@ -1,4 +1,5 @@
 /*
+ *  Copyright (C) 2002		Marcin Dalecki <martin@dalecki.de>
  *  Copyright (C) 2000		Michael Cornwell <cornwell@acm.org>
  *  Copyright (C) 2000		Andre Hedrick <andre@linux-ide.org>
  *
@@ -58,15 +59,9 @@
 		bio_kunmap_irq(to, flags);
 }
 
-static void bswap_data (void *buffer, int wcount)
-{
-	u16 *p = buffer;
-
-	while (wcount--) {
-		*p = *p << 8 | *p >> 8; p++;
-		*p = *p << 8 | *p >> 8; p++;
-	}
-}
+/*
+ * Data transfer functions for polled IO.
+ */
 
 #if SUPPORT_VLB_SYNC
 /*
@@ -76,30 +71,88 @@
  * of the sector count register location, with interrupts disabled
  * to ensure that the reads all happen together.
  */
-static inline void task_vlb_sync(ide_drive_t *drive)
+static void ata_read_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
-	ide_ioreg_t port = IDE_NSECTOR_REG;
+	unsigned long flags;
 
-	IN_BYTE(port);
-	IN_BYTE(port);
-	IN_BYTE(port);
+	__save_flags(flags);	/* local CPU only */
+	__cli();		/* local CPU only */
+	IN_BYTE(IDE_NSECTOR_REG);
+	IN_BYTE(IDE_NSECTOR_REG);
+	IN_BYTE(IDE_NSECTOR_REG);
+	insl(IDE_DATA_REG, buffer, wcount);
+	__restore_flags(flags);	/* local CPU only */
+}
+
+static void ata_write_vlb(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	unsigned long flags;
+
+	__save_flags(flags);	/* local CPU only */
+	__cli();		/* local CPU only */
+	IN_BYTE(IDE_NSECTOR_REG);
+	IN_BYTE(IDE_NSECTOR_REG);
+	IN_BYTE(IDE_NSECTOR_REG);
+	outsl(IDE_DATA_REG, buffer, wcount);
+	__restore_flags(flags);	/* local CPU only */
 }
 #endif
 
+static void ata_read_32(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	insl(IDE_DATA_REG, buffer, wcount);
+}
+
+static void ata_write_32(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	outsl(IDE_DATA_REG, buffer, wcount);
+}
+
+#if SUPPORT_SLOW_DATA_PORTS
+static void ata_read_slow(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	unsigned short *ptr = (unsigned short *) buffer;
+
+	while (wcount--) {
+		*ptr++ = inw_p(IDE_DATA_REG);
+		*ptr++ = inw_p(IDE_DATA_REG);
+	}
+}
+
+static void ata_write_slow(struct ata_device *drive, void *buffer, unsigned int wcount)
+{
+	unsigned short *ptr = (unsigned short *) buffer;
+
+	while (wcount--) {
+		outw_p(*ptr++, IDE_DATA_REG);
+		outw_p(*ptr++, IDE_DATA_REG);
+	}
+}
+#endif
+
+static void ata_read_16(ide_drive_t *drive, void *buffer, unsigned int wcount)
+{
+	insw(IDE_DATA_REG, buffer, wcount<<1);
+}
+
+static void ata_write_16(ide_drive_t *drive, void *buffer, unsigned int wcount)
+{
+	outsw(IDE_DATA_REG, buffer, wcount<<1);
+}
+
 /*
- * This is used for most PIO data transfers *from* the IDE interface
+ * This is used for most PIO data transfers *from* the device.
  */
-void ata_input_data(ide_drive_t *drive, void *buffer, unsigned int wcount)
+void ata_read(ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
-	byte io_32bit;
+	int io_32bit;
 
 	/*
-	 * first check if this controller has defined a special function
-	 * for handling polled ide transfers
+	 * First check if this controller has defined a special function
+	 * for handling polled ide transfers.
 	 */
-
-	if (drive->channel->ideproc) {
-		drive->channel->ideproc(ideproc_ide_input_data, drive, buffer, wcount);
+	if (drive->channel->ata_read) {
+		drive->channel->ata_read(drive, buffer, wcount);
 		return;
 	}
 
@@ -107,39 +160,30 @@
 
 	if (io_32bit) {
 #if SUPPORT_VLB_SYNC
-		if (io_32bit & 2) {
-			unsigned long flags;
-			__save_flags(flags);	/* local CPU only */
-			__cli();		/* local CPU only */
-			task_vlb_sync(drive);
-			insl(IDE_DATA_REG, buffer, wcount);
-			__restore_flags(flags);	/* local CPU only */
-		} else
+		if (io_32bit & 2)
+			ata_read_vlb(drive, buffer, wcount);
+		else
 #endif
-			insl(IDE_DATA_REG, buffer, wcount);
+			ata_read_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
-		if (drive->slow) {
-			unsigned short *ptr = (unsigned short *) buffer;
-			while (wcount--) {
-				*ptr++ = inw_p(IDE_DATA_REG);
-				*ptr++ = inw_p(IDE_DATA_REG);
-			}
-		} else
+		if (drive->slow)
+			ata_read_slow(drive, buffer, wcount);
+		else
 #endif
-			insw(IDE_DATA_REG, buffer, wcount<<1);
+			ata_read_16(drive, buffer, wcount);
 	}
 }
 
 /*
- * This is used for most PIO data transfers *to* the IDE interface
+ * This is used for most PIO data transfers *to* the device interface.
  */
-void ata_output_data(ide_drive_t *drive, void *buffer, unsigned int wcount)
+void ata_write(ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
-	byte io_32bit;
+	int io_32bit;
 
-	if (drive->channel->ideproc) {
-		drive->channel->ideproc(ideproc_ide_output_data, drive, buffer, wcount);
+	if (drive->channel->ata_write) {
+		drive->channel->ata_write(drive, buffer, wcount);
 		return;
 	}
 
@@ -147,27 +191,18 @@
 
 	if (io_32bit) {
 #if SUPPORT_VLB_SYNC
-		if (io_32bit & 2) {
-			unsigned long flags;
-			__save_flags(flags);	/* local CPU only */
-			__cli();		/* local CPU only */
-			task_vlb_sync(drive);
-			outsl(IDE_DATA_REG, buffer, wcount);
-			__restore_flags(flags);	/* local CPU only */
-		} else
+		if (io_32bit & 2)
+			ata_write_vlb(drive, buffer, wcount);
+		else
 #endif
-			outsl(IDE_DATA_REG, buffer, wcount);
+			ata_write_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
-		if (drive->slow) {
-			unsigned short *ptr = (unsigned short *) buffer;
-			while (wcount--) {
-				outw_p(*ptr++, IDE_DATA_REG);
-				outw_p(*ptr++, IDE_DATA_REG);
-			}
-		} else
+		if (drive->slow)
+			ata_write_slow(drive, buffer, wcount);
+		else
 #endif
-			outsw(IDE_DATA_REG, buffer, wcount<<1);
+			ata_write_16(drive, buffer, wcount<<1);
 	}
 }
 
@@ -178,10 +213,10 @@
  * so if an odd bytecount is specified, be sure that there's at least one
  * extra byte allocated for the buffer.
  */
-void atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount)
+void atapi_read(ide_drive_t *drive, void *buffer, unsigned int bytecount)
 {
-	if (drive->channel->ideproc) {
-		drive->channel->ideproc(ideproc_atapi_input_bytes, drive, buffer, bytecount);
+	if (drive->channel->atapi_read) {
+		drive->channel->atapi_read(drive, buffer, bytecount);
 		return;
 	}
 
@@ -193,15 +228,15 @@
 		return;
 	}
 #endif
-	ata_input_data (drive, buffer, bytecount / 4);
+	ata_read(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
-		insw (IDE_DATA_REG, ((byte *)buffer) + (bytecount & ~0x03), 1);
+		insw(IDE_DATA_REG, ((byte *)buffer) + (bytecount & ~0x03), 1);
 }
 
-void atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount)
+void atapi_write(ide_drive_t *drive, void *buffer, unsigned int bytecount)
 {
-	if (drive->channel->ideproc) {
-		drive->channel->ideproc(ideproc_atapi_output_bytes, drive, buffer, bytecount);
+	if (drive->channel->atapi_write) {
+		drive->channel->atapi_write(drive, buffer, bytecount);
 		return;
 	}
 
@@ -213,29 +248,11 @@
 		return;
 	}
 #endif
-	ata_output_data (drive, buffer, bytecount / 4);
+	ata_write(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
 		outsw(IDE_DATA_REG, ((byte *)buffer) + (bytecount & ~0x03), 1);
 }
 
-void taskfile_input_data(ide_drive_t *drive, void *buffer, unsigned int wcount)
-{
-	ata_input_data(drive, buffer, wcount);
-	if (drive->bswap)
-		bswap_data(buffer, wcount);
-}
-
-void taskfile_output_data(ide_drive_t *drive, void *buffer, unsigned int wcount)
-{
-	if (drive->bswap) {
-		bswap_data(buffer, wcount);
-		ata_output_data(drive, buffer, wcount);
-		bswap_data(buffer, wcount);
-	} else {
-		ata_output_data(drive, buffer, wcount);
-	}
-}
-
 /*
  * Needed for PCI irq sharing
  */
@@ -311,8 +328,6 @@
 static ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
 	byte stat		= GET_STAT();
-	/* FIXME: this should go possible as well */
-	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= &HWGROUP(drive)->wrq;
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	int mcount		= drive->mult_count;
@@ -378,14 +393,13 @@
 		}
 
 		/*
-		 * Ok, we're all setup for the interrupt
-		 * re-entering us on the last transfer.
+		 * Ok, we're all setup for the interrupt re-entering us on the
+		 * last transfer.
 		 */
-		taskfile_output_data(drive, buffer, nsect * SECTOR_WORDS);
+		ata_write(drive, buffer, nsect * SECTOR_WORDS);
 		bio_kunmap_irq(buffer, &flags);
 	} while (mcount);
 
-	drive->io_32bit = io_32bit;
 	rq->errors = 0;
 	if (hwgroup->handler == NULL)
 		ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
@@ -542,7 +556,6 @@
 static ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
 	byte stat		= GET_STAT();
-	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
 	unsigned long flags;
@@ -561,10 +574,8 @@
 	pBuf = ide_map_rq(rq, &flags);
 	DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
-	drive->io_32bit = 0;
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
+	ata_read(drive, pBuf, SECTOR_WORDS);
 	ide_unmap_rq(rq, pBuf, &flags);
-	drive->io_32bit = io_32bit;
 
 	if (--rq->current_nr_sectors <= 0) {
 		/* (hs): swapped next 2 lines */
@@ -597,7 +608,7 @@
 		unsigned long flags;
 		char *buf = ide_map_rq(rq, &flags);
 		/* For Write_sectors we need to stuff the first sector */
-		taskfile_output_data(drive, buf, SECTOR_WORDS);
+		ata_write(drive, buf, SECTOR_WORDS);
 		rq->current_nr_sectors--;
 		ide_unmap_rq(rq, buf, &flags);
 	} else {
@@ -613,8 +624,6 @@
 static ide_startstop_t task_out_intr(ide_drive_t *drive)
 {
 	byte stat		= GET_STAT();
-	/* FIXME: this should go possible as well */
-	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
 	unsigned long flags;
@@ -631,9 +640,8 @@
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
-		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
+		ata_write(drive, pBuf, SECTOR_WORDS);
 		ide_unmap_rq(rq, pBuf, &flags);
-		drive->io_32bit = io_32bit;
 		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
@@ -649,8 +657,6 @@
 {
 	unsigned int		msect, nsect;
 	byte stat		= GET_STAT();
-	/* FIXME: this should go possible as well */
-	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
 	unsigned long flags;
@@ -676,10 +682,8 @@
 
 		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
 			pBuf, nsect, rq->current_nr_sectors);
-		drive->io_32bit = 0;
-		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+		ata_read(drive, pBuf, nsect * SECTOR_WORDS);
 		ide_unmap_rq(rq, pBuf, &flags);
-		drive->io_32bit = io_32bit;
 		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
@@ -1025,12 +1029,11 @@
 }
 
 EXPORT_SYMBOL(drive_is_ready);
-EXPORT_SYMBOL(ata_input_data);
-EXPORT_SYMBOL(ata_output_data);
-EXPORT_SYMBOL(atapi_input_bytes);
-EXPORT_SYMBOL(atapi_output_bytes);
-EXPORT_SYMBOL(taskfile_input_data);
-EXPORT_SYMBOL(taskfile_output_data);
+
+EXPORT_SYMBOL(ata_read);
+EXPORT_SYMBOL(ata_write);
+EXPORT_SYMBOL(atapi_read);
+EXPORT_SYMBOL(atapi_write);
 
 EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 06:01:07 2002
+++ linux/drivers/ide/ide.c	Tue Apr 16 05:38:37 2002
@@ -383,7 +383,7 @@
 		spin_lock_irqsave(&ide_lock, flags);
 
 		if ((jiffies - ar->ar_time > ATA_AR_MAX_TURNAROUND) && drive->queue_depth > 1) {
-			printk("%s: exceeded max command turn-around time (%d seconds)\n", drive->name, ATA_AR_MAX_TURNAROUND / HZ);
+			printk(KERN_INFO "%s: exceeded max command turn-around time (%d seconds)\n", drive->name, ATA_AR_MAX_TURNAROUND / HZ);
 			drive->queue_depth >>= 1;
 		}
 
@@ -474,7 +474,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static void ata_pre_reset (ide_drive_t *drive)
+static void ata_pre_reset(ide_drive_t *drive)
 {
 	if (ata_ops(drive) && ata_ops(drive)->pre_reset)
 		ata_ops(drive)->pre_reset(drive);
@@ -528,10 +528,9 @@
 	printk("%s: ata_special: 0x%02x\n", drive->name, s->all);
 #endif
 	if (s->b.set_tune) {
-		ide_tuneproc_t *tuneproc = drive->channel->tuneproc;
 		s->b.set_tune = 0;
-		if (tuneproc != NULL)
-			tuneproc(drive, drive->tune_req);
+		if (drive->channel->tuneproc != NULL)
+			drive->channel->tuneproc(drive, drive->tune_req);
 	} else if (drive->driver != NULL) {
 		if (ata_ops(drive)->special)
 			return ata_ops(drive)->special(drive);
@@ -899,23 +898,24 @@
 }
 
 /*
- * try_to_flush_leftover_data() is invoked in response to a drive
- * unexpectedly having its DRQ_STAT bit set.  As an alternative to
- * resetting the drive, this routine tries to clear the condition
- * by read a sector's worth of data from the drive.  Of course,
+ * This gets invoked in response to a drive unexpectedly having its DRQ_STAT
+ * bit set.  As an alternative to resetting the drive, it tries to clear the
+ * condition by reading a sector's worth of data from the drive.  Of course,
  * this may not help if the drive is *waiting* for data from *us*.
  */
 static void try_to_flush_leftover_data (ide_drive_t *drive)
 {
-	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
+	int i = (drive->mult_count ? drive->mult_count : 1);
 
 	if (drive->type != ATA_DISK)
 		return;
+
 	while (i > 0) {
-		u32 buffer[16];
-		unsigned int wcount = (i > 16) ? 16 : i;
-		i -= wcount;
-		ata_input_data (drive, buffer, wcount);
+		u32 buffer[SECTOR_WORDS];
+		unsigned int count = (i > 1) ? 1 : i;
+
+		ata_read(drive, buffer, count * SECTOR_WORDS);
+		i -= count;
 	}
 }
 
@@ -1002,16 +1002,18 @@
 static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	byte *args = (byte *) rq->buffer;
-	byte stat = GET_STAT();
+	u8 *args = rq->buffer;
+	u8 stat = GET_STAT();
 	int retries = 10;
 
 	ide__sti();	/* local CPU only */
 	if ((stat & DRQ_STAT) && args && args[3]) {
-		byte io_32bit = drive->io_32bit;
+		int io_32bit = drive->io_32bit;
+
 		drive->io_32bit = 0;
-		ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
+		ata_read(drive, &args[4], args[3] * SECTOR_WORDS);
 		drive->io_32bit = io_32bit;
+
 		while (((stat = GET_STAT()) & BUSY_STAT) && retries--)
 			udelay(100);
 	}
@@ -1019,6 +1021,7 @@
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
 		return ide_error(drive, "drive_cmd", stat); /* calls ide_end_drive_cmd */
 	ide_end_drive_cmd (drive, stat, GET_ERR());
+
 	return ide_stopped;
 }
 
@@ -1266,31 +1269,26 @@
 /*
  * Select the next drive which will be serviced.
  */
-static inline ide_drive_t *choose_drive(ide_hwgroup_t *hwgroup)
+static ide_drive_t *choose_drive(ide_hwgroup_t *hwgroup)
 {
-	ide_drive_t *drive, *best;
+	ide_drive_t *tmp;
+	ide_drive_t *drive = NULL;
+	unsigned long sleep = 0;
 
-	best = NULL;
-	drive = hwgroup->drive;
+	tmp = hwgroup->drive;
 	do {
-		if (!list_empty(&drive->queue.queue_head)
-		&& (!drive->PADAM_sleep	|| time_after_eq(drive->PADAM_sleep, jiffies))) {
-			if (!best
-			 || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep)))
-			 || (!best->PADAM_sleep && time_after(best->PADAM_service_start + 2 * best->PADAM_service_time, drive->PADAM_service_start + 2 * drive->PADAM_service_time)))
+		if (!list_empty(&tmp->queue.queue_head)
+		&& (!tmp->PADAM_sleep || time_after_eq(tmp->PADAM_sleep, jiffies))) {
+			if (!drive
+			 || (tmp->PADAM_sleep && (!drive->PADAM_sleep || time_after(drive->PADAM_sleep, tmp->PADAM_sleep)))
+			 || (!drive->PADAM_sleep && time_after(drive->PADAM_service_start + 2 * drive->PADAM_service_time, tmp->PADAM_service_start + 2 * tmp->PADAM_service_time)))
 			{
-				if (!blk_queue_plugged(&drive->queue))
-					best = drive;
+				if (!blk_queue_plugged(&tmp->queue))
+					drive = tmp;
 			}
 		}
-	} while ((drive = drive->next) != hwgroup->drive);
-	return best;
-}
-
-static ide_drive_t *ide_choose_drive(ide_hwgroup_t *hwgroup)
-{
-	ide_drive_t *drive = choose_drive(hwgroup);
-	unsigned long sleep = 0;
+		tmp = tmp->next;
+	} while (tmp != hwgroup->drive);
 
 	if (drive)
 		return drive;
@@ -1495,7 +1493,7 @@
 		/*
 		 * will clear IDE_BUSY, if appropriate
 		 */
-		if ((drive = ide_choose_drive(hwgroup)) == NULL)
+		if ((drive = choose_drive(hwgroup)) == NULL)
 			break;
 
 		hwif = drive->channel;
@@ -2298,7 +2296,10 @@
 	channel->maskproc = old_hwif.maskproc;
 	channel->quirkproc = old_hwif.quirkproc;
 	channel->rwproc	= old_hwif.rwproc;
-	channel->ideproc = old_hwif.ideproc;
+	channel->ata_read = old_hwif.ata_read;
+	channel->ata_write = old_hwif.ata_write;
+	channel->atapi_read = old_hwif.atapi_read;
+	channel->atapi_write = old_hwif.atapi_write;
 	channel->dmaproc = old_hwif.dmaproc;
 	channel->busproc = old_hwif.busproc;
 	channel->bus_state = old_hwif.bus_state;
@@ -2565,13 +2566,17 @@
 	return 0;
 }
 
-static int set_io_32bit(ide_drive_t *drive, int arg)
+static int set_io_32bit(struct ata_device *drive, int arg)
 {
+	if (drive->no_io_32bit)
+		return -EIO;
+
 	drive->io_32bit = arg;
 #ifdef CONFIG_BLK_DEV_DTC2278
 	if (drive->channel->chipset == ide_dtc2278)
 		drive->channel->drives[!drive->select.b.unit].io_32bit = arg;
-#endif /* CONFIG_BLK_DEV_DTC2278 */
+#endif
+
 	return 0;
 }
 
@@ -3018,8 +3023,6 @@
  * "hdx=slow"		: insert a huge pause after each access to the data
  *				port. Should be used only as a last resort.
  *
- * "hdx=swapdata"	: when the drive is a disk, byte swap all data
- * "hdx=bswap"		: same as above..........
  * "hdxlun=xx"          : set the drive last logical unit.
  * "hdx=flash"		: allows for more than one ata_flash disk to be
  *				registered. In most cases, only one device
@@ -3127,8 +3130,7 @@
 	if (!strncmp(s, "hd", 2) && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
-				"slow", "swapdata", "bswap", "flash",
-				"remap", "noremap", "scsi", NULL};
+				"slow", "flash", "remap", "noremap", "scsi", NULL};
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -3178,20 +3180,16 @@
 			case -8: /* "slow" */
 				drive->slow = 1;
 				goto done;
-			case -9: /* "swapdata" or "bswap" */
-			case -10:
-				drive->bswap = 1;
-				goto done;
-			case -11: /* "flash" */
+			case -9: /* "flash" */
 				drive->ata_flash = 1;
 				goto done;
-			case -12: /* "remap" */
+			case -10: /* "remap" */
 				drive->remap_0_to_1 = 1;
 				goto done;
-			case -13: /* "noremap" */
+			case -11: /* "noremap" */
 				drive->remap_0_to_1 = 2;
 				goto done;
-			case -14: /* "scsi" */
+			case -12: /* "scsi" */
 #if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
 				drive->scsi = 1;
 				goto done;
diff -urN linux-2.5.8/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.8/drivers/ide/pdc202xx.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/pdc202xx.c	Tue Apr 16 05:39:06 2002
@@ -1270,9 +1270,10 @@
 #ifdef CONFIG_PDC202XX_32_UNMASK
 	hwif->drives[0].io_32bit = 1;
 	hwif->drives[1].io_32bit = 1;
+
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
-#endif /* CONFIG_PDC202XX_32_UNMASK */
+#endif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
@@ -1285,9 +1286,9 @@
 		hwif->drives[1].autotune = 1;
 		hwif->autodma = 0;
 	}
-#else /* !CONFIG_BLK_DEV_IDEDMA */
+#else
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 	hwif->autodma = 0;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 }
diff -urN linux-2.5.8/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8/drivers/ide/pdc4030.c	Tue Apr 16 06:01:07 2002
+++ linux/drivers/ide/pdc4030.c	Tue Apr 16 02:59:10 2002
@@ -183,7 +183,7 @@
 			"%s: Failed Promise read config!\n",hwif->name);
 		return 0;
 	}
-	ata_input_data(drive, &ident, SECTOR_WORDS);
+	ata_read(drive, &ident, SECTOR_WORDS);
 	if (ident.id[1] != 'P' || ident.id[0] != 'T') {
 		return 0;
 	}
@@ -332,7 +332,7 @@
 		nsect = sectors_avail;
 	sectors_avail -= nsect;
 	to = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
-	ata_input_data(drive, to, nsect * SECTOR_WORDS);
+	ata_read(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG_READ
 	printk(KERN_DEBUG "%s:  promise_read: sectors(%ld-%ld), "
 	       "buf=0x%08lx, rem=%ld\n", drive->name, rq->sector,
@@ -460,7 +460,7 @@
 		 * Ok, we're all setup for the interrupt
 		 * re-entering us on the last transfer.
 		 */
-		taskfile_output_data(drive, buffer, nsect<<7);
+		ata_write(drive, buffer, nsect << 7);
 		bio_kunmap_irq(buffer, &flags);
 	} while (mcount);
 
diff -urN linux-2.5.8/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.8/drivers/scsi/ide-scsi.c	Mon Apr 15 08:53:51 2002
+++ linux/drivers/scsi/ide-scsi.c	Tue Apr 16 03:39:25 2002
@@ -140,7 +140,7 @@
 		}
 		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
-		atapi_input_bytes (drive, buf + pc->b_count, count);
+		atapi_read(drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -162,7 +162,7 @@
 		}
 		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
-		atapi_output_bytes (drive, buf + pc->b_count, count);
+		atapi_write(drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -363,7 +363,7 @@
 					if (pc->sg)
 						idescsi_input_buffers(drive, pc, temp);
 					else
-						atapi_input_bytes(drive, pc->current_position, temp);
+						atapi_read(drive, pc->current_position, temp);
 					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, bcount);
 				}
 				pc->actually_transferred += temp;
@@ -382,13 +382,13 @@
 		if (pc->sg)
 			idescsi_input_buffers (drive, pc, bcount);
 		else
-			atapi_input_bytes (drive,pc->current_position,bcount);
+			atapi_read(drive,pc->current_position,bcount);
 	} else {
 		set_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
 			idescsi_output_buffers (drive, pc, bcount);
 		else
-			atapi_output_bytes (drive,pc->current_position,bcount);
+			atapi_write(drive,pc->current_position,bcount);
 	}
 	pc->actually_transferred+=bcount;				/* Update the current position */
 	pc->current_position+=bcount;
@@ -414,7 +414,7 @@
 		return ide_stopped;
 	}
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* Set the interrupt routine */
-	atapi_output_bytes (drive, scsi->pc->c, 12);			/* Send the actual packet */
+	atapi_write(drive, scsi->pc->c, 12);			/* Send the actual packet */
 	return ide_started;
 }
 
diff -urN linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Tue Apr 16 06:01:07 2002
+++ linux/include/linux/ide.h	Tue Apr 16 05:44:28 2002
@@ -313,9 +313,11 @@
 #define IDE_CUR_AR(drive)	(HWGROUP((drive))->rq->special)
 
 struct ide_settings_s;
-
-typedef struct ide_drive_s {
-	struct ata_channel *channel;	/* parent pointer to the channel we are attached to  */
+/* structure describing an ATA/ATAPI device */
+typedef
+struct ata_device {
+	struct ata_channel *	channel;
+	char			name[6];	/* device name */
 
 	unsigned int usage;		/* current "open()" count for drive */
 	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
@@ -324,11 +326,11 @@
 	 * could move this to the channel and many sync problems would
 	 * magically just go away.
 	 */
-	request_queue_t	queue;	/* per device request queue */
+	request_queue_t	queue;		/* per device request queue */
 
-	struct list_head free_req; /* free ata requests */
+	struct list_head free_req;	/* free ata requests */
 
-	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
+	struct ata_device *next;	/* circular list of hwgroup drives */
 
 	/* Those are directly injected jiffie values. They should go away and
 	 * we should use generic timers instead!!!
@@ -346,8 +348,6 @@
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     unmask;		/* flag: okay to unmask other irqs */
-	byte     slow;			/* flag: slow data port */
-	byte     bswap;			/* flag: byte swap data */
 	byte     dsc_overlap;		/* flag: DSC overlap */
 
 	unsigned waiting_for_dma: 1;	/* dma currently in progress */
@@ -359,7 +359,6 @@
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
-	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned nobios		: 1;	/* flag: do not probe bios for drive */
 	unsigned revalidate	: 1;	/* request revalidation */
 	unsigned atapi_overlap	: 1;	/* flag: ATAPI overlap (not supported) */
@@ -376,7 +375,6 @@
 	byte		mult_count;	/* current multiple sector setting */
 	byte		mult_req;	/* requested multiple sector setting */
 	byte		tune_req;	/* requested drive tuning setting */
-	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	byte		bad_wstat;	/* used for ignoring WRERR_STAT */
 	byte		nowerr;		/* used for ignoring WRERR_STAT */
 	byte		sect0;		/* offset of first sector for DM6:DDO */
@@ -390,12 +388,18 @@
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
 
+	/* FIXME: Those are properties of a channel and not a drive!  Move them
+	 * later there.
+	 */
+	byte		slow;		/* flag: slow data port */
+	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
+	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
+
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 
-	char		name[6];	/* drive name, such as "hda" */
 	struct ata_operations *driver;
 
 	void		*driver_data;	/* extra driver data */
@@ -447,47 +451,6 @@
 
 typedef int (ide_dmaproc_t)(ide_dma_action_t, ide_drive_t *);
 
-/*
- * An ide_ideproc_t() performs CPU-polled transfers to/from a drive.
- * Arguments are: the drive, the buffer pointer, and the length (in bytes or
- * words depending on if it's an IDE or ATAPI call).
- *
- * If it is not defined for a controller, standard-code is used from ide.c.
- *
- * Controllers which are not memory-mapped in the standard way need to
- * override that mechanism using this function to work.
- *
- */
-typedef enum { ideproc_ide_input_data,    ideproc_ide_output_data,
-	       ideproc_atapi_input_bytes, ideproc_atapi_output_bytes
-} ide_ide_action_t;
-
-typedef void (ide_ideproc_t)(ide_ide_action_t, ide_drive_t *, void *, unsigned int);
-
-/*
- * An ide_tuneproc_t() is used to set the speed of an IDE interface
- * to a particular PIO mode.  The "byte" parameter is used
- * to select the PIO mode by number (0,1,2,3,4,5), and a value of 255
- * indicates that the interface driver should "auto-tune" the PIO mode
- * according to the drive capabilities in drive->id;
- *
- * Not all interface types support tuning, and not all of those
- * support all possible PIO settings.  They may silently ignore
- * or round values as they see fit.
- */
-typedef void (ide_tuneproc_t) (ide_drive_t *, byte);
-typedef int (ide_speedproc_t) (ide_drive_t *, byte);
-
-/*
- * This is used to provide support for strange interfaces
- */
-typedef void (ide_selectproc_t) (ide_drive_t *);
-typedef void (ide_resetproc_t) (ide_drive_t *);
-typedef int (ide_quirkproc_t) (ide_drive_t *);
-typedef void (ide_intrproc_t) (ide_drive_t *);
-typedef void (ide_maskproc_t) (ide_drive_t *, int);
-typedef void (ide_rw_proc_t) (ide_drive_t *, ide_dma_action_t);
-
 enum {
 	ATA_PRIMARY	= 0,
 	ATA_SECONDARY	= 1
@@ -507,15 +470,40 @@
 #endif
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
 	struct gendisk	*gd;		/* gendisk structure */
-	ide_tuneproc_t	*tuneproc;	/* routine to tune PIO mode for drives */
-	ide_speedproc_t	*speedproc;	/* routine to retune DMA modes for drives */
-	ide_selectproc_t *selectproc;	/* tweaks hardware to select drive */
-	ide_resetproc_t	*resetproc;	/* routine to reset controller after a disk reset */
-	ide_intrproc_t	*intrproc;	/* special interrupt handling for shared pci interrupts */
-	ide_maskproc_t	*maskproc;	/* special host masking for drive selection */
-	ide_quirkproc_t	*quirkproc;	/* check host's drive quirk list */
-	ide_rw_proc_t	*rwproc;	/* adjust timing based upon rq->cmd direction */
-	ide_ideproc_t   *ideproc;       /* CPU-polled transfer routine */
+
+	/*
+	 * Routines to tune PIO and DMA mode for drives.
+	 *
+	 * A value of 255 indicates that the function should choose the optimal
+	 * mode itself.
+	 */
+	void (*tuneproc) (ide_drive_t *, byte pio);
+	int (*speedproc) (ide_drive_t *, byte pio);
+
+	/* tweaks hardware to select drive */
+	void (*selectproc) (ide_drive_t *);
+
+	/* routine to reset controller after a disk reset */
+	void (*resetproc) (ide_drive_t *);
+
+	/* special interrupt handling for shared pci interrupts */
+	void (*intrproc) (ide_drive_t *);
+
+	/* special host masking for drive selection */
+	void (*maskproc) (ide_drive_t *, int);
+
+	/* adjust timing based upon rq->cmd direction */
+	void (*rwproc) (ide_drive_t *, ide_dma_action_t);
+
+	/* check host's drive quirk list */
+	int (*quirkproc) (ide_drive_t *);
+
+	/* CPU-polled transfer routines */
+	void (*ata_read)(ide_drive_t *, void *, unsigned int);
+	void (*ata_write)(ide_drive_t *, void *, unsigned int);
+	void (*atapi_read)(ide_drive_t *, void *, unsigned int);
+	void (*atapi_write)(ide_drive_t *, void *, unsigned int);
+
 	ide_dmaproc_t	*dmaproc;	/* dma read/write/abort routine */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned	dma_extra;	/* extra addr for dma ports */
@@ -829,7 +817,7 @@
  */
 struct ata_request {
 	struct request		*ar_rq;		/* real request */
-	struct ide_drive_s	*ar_drive;	/* associated drive */
+	struct ata_device	*ar_drive;	/* associated drive */
 	unsigned long		ar_flags;	/* ATA_AR_* flags */
 	int			ar_tag;		/* tag number, if any */
 	struct list_head	ar_queue;	/* pending list */
@@ -848,12 +836,11 @@
 
 #define AR_TASK_CMD(ar)	((ar)->ar_task.taskfile.command)
 
-void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
-void ata_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
-void atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount);
-void atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount);
-void taskfile_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
-void taskfile_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
+extern void ata_read(ide_drive_t *drive, void *buffer, unsigned int wcount);
+extern void ata_write(ide_drive_t *drive, void *buffer, unsigned int wcount);
+
+extern void atapi_read(ide_drive_t *drive, void *buffer, unsigned int bytecount);
+extern void atapi_write(ide_drive_t *drive, void *buffer, unsigned int bytecount);
 
 extern ide_startstop_t ata_taskfile(ide_drive_t *drive,
 		struct ata_taskfile *args, struct request *rq);

--------------030007040407060907010406--

