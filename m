Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJVRv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJVRv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUJVRvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:51:17 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:4780 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264668AbUJVRis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=NDJZrutoewS0gZIkSAz6syZkWz/16enr0Rtxi50eb88bLuc5riSNjyQ0gpGuDvsUYpOHERSV3X6sQn6E6rWn+eixRbzf6g7LdNZ+u18a/qDlZviGgGq4vIAI0sttZAogvD0ZJEZ+413XzI8rVBJBBA2hi1oDcsPqz5sWIXXRcpk=
Message-ID: <58cb370e04102210385ca8b554@mail.gmail.com>
Date: Fri, 22 Oct 2004 19:38:44 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org
Subject: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More syncing with -mm.

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 arch/cris/arch-v10/drivers/ide.c |   10 -
 drivers/ide/arm/icside.c         |   38 +----
 drivers/ide/ide-cd.c             |    5 
 drivers/ide/ide-disk.c           |    2 
 drivers/ide/ide-dma.c            |   87 ++-----------
 drivers/ide/ide-io.c             |   12 +
 drivers/ide/ide-proc.c           |  257 ---------------------------------------
 drivers/ide/ide.c                |    1 
 drivers/ide/pci/sgiioc4.c        |   17 --
 drivers/ide/pci/siimage.c        |    7 -
 drivers/ide/ppc/pmac.c           |   58 --------
 drivers/scsi/ide-scsi.c          |  141 +++++++--------------
 include/linux/ide.h              |    6 
 13 files changed, 95 insertions(+), 546 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/22 1.2055)
   [ide] kill /proc/ide/ide?/config
   
   * writes to PCI config space are non-functional since 2.4.21
   * reads of full PCI config space are allowed for normal users
   * I'm not aware of any applications using this interface
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2054)
   [ide] kill ide_hwif_t->ide_dma_verbose
   
   * make __ide_dma_verbose() void and drop "__" prefix
   * ide_dma_verbose() is always available now
   * use it instead of ide_hwif_t->ide_dma_verbose
   * sgiioc4.c version reported wrong mode
   * icside.c version repeated info given by ->ide_dma_check()
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2053)
   [ide] ide-scsi: simplify+speedup DMA support
   
   * add hwif->sg_mapped flag
   * add idescsi_map_sg() converting scsi_cmd->sg into
     hwif->sg_table (this removes need for rq->bio)
   * remove code (de)allocating rq->bio
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2052)
   [ide] kill ide_raw_build_sglist()
   
   ide_build_sglist() can be now used for REQ_DRIVE_TASKFILE requests.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2051)
   [ide] use ide_map_sg()
   
   * make Etrax ide.c, icside.c and ide-dma.c use ide_map_sg()
   * use one sg for REQ_DRIVE_TASKFILE requests in ide-dma.c
     (no reason for 128 sectors per sg limit)
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2050)
   [ide] pmac: kill pmac_ide_[raw_]build_sglist()
   
   Just use ide_dma_[raw_]build_sglist() from ide-dma.c.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/arch/cris/arch-v10/drivers/ide.c b/arch/cris/arch-v10/drivers/ide.c
--- a/arch/cris/arch-v10/drivers/ide.c	2004-10-22 19:29:05 +02:00
+++ b/arch/cris/arch-v10/drivers/ide.c	2004-10-22 19:29:05 +02:00
@@ -656,15 +656,9 @@
 
 	ata_tot_size = 0;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		sg_init_one(&sg[0], rq->buffer, rq->nr_sectors * SECTOR_SIZE);
-		hwif->sg_nents = i = 1;
-	}
-	else
-	{
-		hwif->sg_nents = i = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
-	}
+	ide_map_sg(drive, rq);
 
+	i = hwif->sg_nents;
 
 	while(i) {
 		/*
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/arm/icside.c	2004-10-22 19:29:05 +02:00
@@ -212,33 +212,18 @@
 	ide_hwif_t *hwif = drive->hwif;
 	struct icside_state *state = hwif->hwif_data;
 	struct scatterlist *sg = hwif->sg_table;
-	int nents;
 
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
+	ide_map_sg(drive, rq);
 
-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-			hwif->sg_dma_direction = DMA_TO_DEVICE;
-		else
-			hwif->sg_dma_direction = DMA_FROM_DEVICE;
-
-		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
-		nents = 1;
-	} else {
-		nents = blk_rq_map_sg(drive->queue, rq, sg);
-
-		if (rq_data_dir(rq) == READ)
-			hwif->sg_dma_direction = DMA_FROM_DEVICE;
-		else
-			hwif->sg_dma_direction = DMA_TO_DEVICE;
-	}
-
-	nents = dma_map_sg(state->dev, sg, nents, hwif->sg_dma_direction);
+	if (rq_data_dir(rq) == READ)
+		hwif->sg_dma_direction = DMA_FROM_DEVICE;
+	else
+		hwif->sg_dma_direction = DMA_TO_DEVICE;
 
-	hwif->sg_nents = nents;
+	hwif->sg_nents = dma_map_sg(state->dev, sg, hwif->sg_nents,
+				    hwif->sg_dma_direction);
 }
 
-
 /*
  * Configure the IOMD to give the appropriate timings for the transfer
  * mode being requested.  We take the advice of the ATA standards, and
@@ -498,14 +483,6 @@
 			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
 }
 
-static int icside_dma_verbose(ide_drive_t *drive)
-{
-	printk(", %s (peak %dMB/s)",
-		ide_xfer_verbose(drive->current_speed),
-		2000 / drive->drive_data);
-	return 1;
-}
-
 static int icside_dma_timeout(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
@@ -554,7 +531,6 @@
 	hwif->dma_start		= icside_dma_start;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
-	hwif->ide_dma_verbose	= icside_dma_verbose;
 	hwif->ide_dma_timeout	= icside_dma_timeout;
 	hwif->ide_dma_lostirq	= icside_dma_lostirq;
 
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide-cd.c	2004-10-22 19:29:05 +02:00
@@ -3039,10 +3039,9 @@
 
 	printk(", %dkB Cache", be16_to_cpu(cap.buffer_size));
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->using_dma)
-		(void) HWIF(drive)->ide_dma_verbose(drive);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+		ide_dma_verbose(drive);
+
 	printk("\n");
 
 	return nslots;
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-22 19:29:05 +02:00
@@ -1244,7 +1244,7 @@
 	printk(", CHS=%d/%d/%d", 
 	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	if (drive->using_dma)
-		(void) HWIF(drive)->ide_dma_verbose(drive);
+		ide_dma_verbose(drive);
 	printk("\n");
 
 	drive->mult_count = 0;
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-22 19:29:05 +02:00
@@ -207,67 +207,23 @@
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
-	int nents;
 
-	nents = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
-		
+	if ((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256)
+		BUG();
+
+	ide_map_sg(drive, rq);
+
 	if (rq_data_dir(rq) == READ)
 		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
 		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	return pci_map_sg(hwif->pci_dev, sg, hwif->sg_nents, hwif->sg_dma_direction);
 }
 
 EXPORT_SYMBOL_GPL(ide_build_sglist);
 
 /**
- *	ide_raw_build_sglist	-	map IDE scatter gather for DMA
- *	@drive: the drive to build the DMA table for
- *	@rq: the request holding the sg list
- *
- *	Perform the PCI mapping magic necessary to access the source or
- *	target buffers of a taskfile request via PCI DMA. The lower layers 
- *	of the  kernel provide the necessary cache management so that we can
- *	operate in a portable fashion
- */
-
-int ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	struct scatterlist *sg = hwif->sg_table;
-	int nents = 0;
-	ide_task_t *args = rq->special;
-	u8 *virt_addr = rq->buffer;
-	int sector_count = rq->nr_sectors;
-
-	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
-	else
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-
-#if 1
-	if (sector_count > 256)
-		BUG();
-
-	if (sector_count > 128) {
-#else
-	while (sector_count > 128) {
-#endif
-		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
-		nents++;
-		virt_addr = virt_addr + (128 * SECTOR_SIZE);
-		sector_count -= 128;
-	}
-	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
-	nents++;
-
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
-}
-
-EXPORT_SYMBOL_GPL(ide_raw_build_sglist);
-
-/**
  *	ide_build_dmatable	-	build IDE DMA table
  *
  *	ide_build_dmatable() prepares a dma request. We map the command
@@ -288,10 +244,7 @@
 	int i;
 	struct scatterlist *sg;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
-		hwif->sg_nents = i = ide_raw_build_sglist(drive, rq);
-	else
-		hwif->sg_nents = i = ide_build_sglist(drive, rq);
+	hwif->sg_nents = i = ide_build_sglist(drive, rq);
 
 	if (!i)
 		return 0;
@@ -728,17 +681,14 @@
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-int __ide_dma_verbose (ide_drive_t *drive)
+void ide_dma_verbose(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
 
 	if (id->field_valid & 4) {
-		if ((id->dma_ultra >> 8) && (id->dma_mword >> 8)) {
-			printk(", BUG DMA OFF");
-			return hwif->ide_dma_off_quietly(drive);
-		}
+		if ((id->dma_ultra >> 8) && (id->dma_mword >> 8))
+			goto bug_dma_off;
 		if (id->dma_ultra & ((id->dma_ultra >> 8) & hwif->ultra_mask)) {
 			if (((id->dma_ultra >> 11) & 0x1F) &&
 			    eighty_ninty_three(drive)) {
@@ -768,19 +718,22 @@
 			printk(", (U)DMA");	/* Can be BIOS-enabled! */
 		}
 	} else if (id->field_valid & 2) {
-		if ((id->dma_mword >> 8) && (id->dma_1word >> 8)) {
-			printk(", BUG DMA OFF");
-			return hwif->ide_dma_off_quietly(drive);
-		}
+		if ((id->dma_mword >> 8) && (id->dma_1word >> 8))
+			goto bug_dma_off;
 		printk(", DMA");
 	} else if (id->field_valid & 1) {
 		printk(", BUG");
 	}
-	return 1;
+	return;
+bug_dma_off:
+	printk(", BUG DMA OFF");
+	hwif->ide_dma_off_quietly(drive);
+	return;
 }
 
-EXPORT_SYMBOL(__ide_dma_verbose);
+EXPORT_SYMBOL(ide_dma_verbose);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 int __ide_dma_lostirq (ide_drive_t *drive)
 {
 	printk("%s: DMA interrupt recovery\n", drive->name);
@@ -955,8 +908,6 @@
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
 		hwif->ide_dma_test_irq = &__ide_dma_test_irq;
-	if (!hwif->ide_dma_verbose)
-		hwif->ide_dma_verbose = &__ide_dma_verbose;
 	if (!hwif->ide_dma_timeout)
 		hwif->ide_dma_timeout = &__ide_dma_timeout;
 	if (!hwif->ide_dma_lostirq)
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide-io.c	2004-10-22 19:29:05 +02:00
@@ -680,6 +680,9 @@
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 
+	if (hwif->sg_mapped)	/* needed by ide-scsi */
+		return;
+
 	if ((rq->flags & REQ_DRIVE_TASKFILE) == 0) {
 		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
 	} else {
@@ -1219,12 +1222,15 @@
 	HWGROUP(drive)->rq = NULL;
 
 	rq->errors = 0;
+
+	if (!rq->bio)
+		goto out;
+
 	rq->sector = rq->bio->bi_sector;
 	rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 	rq->hard_cur_sectors = rq->current_nr_sectors;
-	if (rq->bio)
-		rq->buffer = NULL;
-
+	rq->buffer = NULL;
+out:
 	return ret;
 }
 
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide-proc.c	2004-10-22 19:29:05 +02:00
@@ -8,37 +8,6 @@
 /*
  * This is the /proc/ide/ filesystem implementation.
  *
- * The major reason this exists is to provide sufficient access
- * to driver and config data, such that user-mode programs can
- * be developed to handle chipset tuning for most PCI interfaces.
- * This should provide better utilities, and less kernel bloat.
- *
- * The entire pci config space for a PCI interface chipset can be
- * retrieved by just reading it.  e.g.    "cat /proc/ide3/config"
- *
- * To modify registers *safely*, do something like:
- *   echo "P40:88" >/proc/ide/ide3/config
- * That expression writes 0x88 to pci config register 0x40
- * on the chip which controls ide3.  Multiple tuples can be issued,
- * and the writes will be completed as an atomic set:
- *   echo "P40:88 P41:35 P42:00 P43:00" >/proc/ide/ide3/config
- *
- * All numbers must be specified using pairs of ascii hex digits.
- * It is important to note that these writes will be performed
- * after waiting for the IDE controller (both interfaces)
- * to be completely idle, to ensure no corruption of I/O in progress.
- *
- * Non-PCI registers can also be written, using "R" in place of "P"
- * in the above examples.  The size of the port transfer is determined
- * by the number of pairs of hex digits given for the data.  If a two
- * digit value is given, the write will be a byte operation; if four
- * digits are used, the write will be performed as a 16-bit operation;
- * and if eight digits are specified, a 32-bit "dword" write will be
- * performed.  Odd numbers of digits are not permitted.
- *
- * If there is an error *anywhere* in the string of registers/data
- * then *none* of the writes will be performed.
- *
  * Drive/Driver settings can be retrieved by reading the drive's
  * "settings" files.  e.g.    "cat /proc/ide0/hda/settings"
  * To write a new value "val" into a specific setting "name", use:
@@ -51,10 +20,6 @@
  * returned data as 256 16-bit words.  The "hdparm" utility will
  * be updated someday soon to use this mechanism.
  *
- * Feel free to develop and distribute fancy GUI configuration
- * utilities for your favorite PCI chipsets.  I'll be working on
- * one for the Promise 20246 someday soon.  -ml
- *
  */
 
 #include <linux/config.h>
@@ -74,227 +39,6 @@
 
 #include <asm/io.h>
 
-static int proc_ide_write_config(struct file *file, const char __user *buffer,
-				 unsigned long count, void *data)
-{
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
-	ide_hwgroup_t *mygroup = (ide_hwgroup_t *)(hwif->hwgroup);
-	ide_hwgroup_t *mategroup = NULL;
-	unsigned long timeout;
-	unsigned long flags;
-	const char *start = NULL, *msg = NULL;
-	struct entry { u32 val; u16 reg; u8 size; u8 pci; } *prog, *q, *r;
-	int want_pci = 0;
-	char *buf, *s;
-	int err;
-
-	if (hwif->mate && hwif->mate->hwgroup)
-		mategroup = (ide_hwgroup_t *)(hwif->mate->hwgroup);
-
-	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
-		return -EACCES;
-
-	if (count >= PAGE_SIZE)
-		return -EINVAL;
-
-	s = buf = (char *)__get_free_page(GFP_USER);
-	if (!buf)
-		return -ENOMEM;
-
-	err = -ENOMEM;
-	q = prog = (struct entry *)__get_free_page(GFP_USER);
-	if (!prog)
-		goto out;
-
-	err = -EFAULT;
-	if (copy_from_user(buf, buffer, count))
-		goto out1;
-
-	buf[count] = '\0';
-
-	while (isspace(*s))
-		s++;
-
-	while (*s) {
-		char *p;
-		int digits;
-
-		start = s;
-
-		if ((char *)(q + 1) > (char *)prog + PAGE_SIZE) {
-			msg = "too many entries";
-			goto parse_error;
-		}
-
-		switch (*s++) {
-			case 'R':	q->pci = 0;
-					break;
-			case 'P':	q->pci = 1;
-					want_pci = 1;
-					break;
-			default:	msg = "expected 'R' or 'P'";
-					goto parse_error;
-		}
-
-		q->reg = simple_strtoul(s, &p, 16);
-		digits = p - s;
-		if (!digits || digits > 4 || (q->pci && q->reg > 0xff)) {
-			msg = "bad/missing register number";
-			goto parse_error;
-		}
-		if (*p++ != ':') {
-			msg = "missing ':'";
-			goto parse_error;
-		}
-		q->val = simple_strtoul(p, &s, 16);
-		digits = s - p;
-		if (digits != 2 && digits != 4 && digits != 8) {
-			msg = "bad data, 2/4/8 digits required";
-			goto parse_error;
-		}
-		q->size = digits / 2;
-
-		if (q->pci) {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-			if (q->reg & (q->size - 1)) {
-				msg = "misaligned access";
-				goto parse_error;
-			}
-#else
-			msg = "not a PCI device";
-			goto parse_error;
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		}
-
-		q++;
-
-		if (*s && !isspace(*s++)) {
-			msg = "expected whitespace after data";
-			goto parse_error;
-		}
-		while (isspace(*s))
-			s++;
-	}
-
-	/*
-	 * What follows below is fucking insane, even for IDE people.
-	 * For now I've dealt with the obvious problems on the parsing
-	 * side, but IMNSHO we should simply remove the write access
-	 * to /proc/ide/.../config, killing that FPOS completely.
-	 */
-
-	err = -EBUSY;
-	timeout = jiffies + (3 * HZ);
-	spin_lock_irqsave(&ide_lock, flags);
-	while (mygroup->busy ||
-	       (mategroup && mategroup->busy)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		if (time_after(jiffies, timeout)) {
-			printk("/proc/ide/%s/config: channel(s) busy, cannot write\n", hwif->name);
-			goto out1;
-		}
-		spin_lock_irqsave(&ide_lock, flags);
-	}
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	if (want_pci && (!hwif->pci_dev || hwif->pci_dev->vendor)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		printk("proc_ide: PCI registers not accessible for %s\n",
-			hwif->name);
-		err = -EINVAL;
-		goto out1;
-	}
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-
-	for (r = prog; r < q; r++) {
-		unsigned int reg = r->reg, val = r->val;
-		if (r->pci) {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-			int rc = 0;
-			struct pci_dev *dev = hwif->pci_dev;
-			switch (q->size) {
-				case 1:	msg = "byte";
-					rc = pci_write_config_byte(dev, reg, val);
-					break;
-				case 2:	msg = "word";
-					rc = pci_write_config_word(dev, reg, val);
-					break;
-				case 4:	msg = "dword";
-					rc = pci_write_config_dword(dev, reg, val);
-					break;
-			}
-			if (rc) {
-				spin_unlock_irqrestore(&ide_lock, flags);
-				printk("proc_ide_write_config: error writing %s at bus %02x dev
%02x reg 0x%x value 0x%x\n",
-					msg, dev->bus->number, dev->devfn, reg, val);
-				printk("proc_ide_write_config: error %d\n", rc);
-				err = -EIO;
-				goto out1;
-			}
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		} else {	/* not pci */
-			switch (r->size) {
-				case 1:	hwif->OUTB(val, reg);
-					break;
-				case 2:	hwif->OUTW(val, reg);
-					break;
-				case 4:	hwif->OUTL(val, reg);
-					break;
-			}
-		}
-	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	err = count;
-out1:
-	free_page((unsigned long)prog);
-out:
-	free_page((unsigned long)buf);
-	return err;
-
-parse_error:
-	printk("parse error\n");
-	printk("proc_ide: error: %s: '%s'\n", msg, start);
-	err = -EINVAL;
-	goto out1;
-}
-
-static int proc_ide_read_config
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	char		*out = page;
-	int		len;
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
-	struct pci_dev	*dev = hwif->pci_dev;
-	if ((hwif->pci_dev && hwif->pci_dev->vendor) && dev && dev->bus) {
-		int reg = 0;
-
-		out += sprintf(out, "pci bus %02x device %02x vendor %04x "
-				"device %04x channel %d\n",
-			dev->bus->number, dev->devfn,
-			hwif->pci_dev->vendor, hwif->pci_dev->device,
-			hwif->channel);
-		do {
-			u8 val;
-			int rc = pci_read_config_byte(dev, reg, &val);
-			if (rc) {
-				printk("proc_ide_read_config: error %d reading"
-					" bus %02x dev %02x reg 0x%02x\n",
-					rc, dev->bus->number, dev->devfn, reg);
-				out += sprintf(out, "??%c",
-					(++reg & 0xf) ? ' ' : '\n');
-			} else
-				out += sprintf(out, "%02x%c",
-					val, (++reg & 0xf) ? ' ' : '\n');
-		} while (reg < 0x100);
-	} else
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		out += sprintf(out, "(none)\n");
-	len = out - page;
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -687,7 +431,6 @@
 
 static ide_proc_entry_t hwif_entries[] = {
 	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
-	{ "config",	S_IFREG|S_IRUGO|S_IWUSR,proc_ide_read_config,	proc_ide_write_config
},
 	{ "mate",	S_IFREG|S_IRUGO,	proc_ide_read_mate,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_imodel,	NULL },
 	{ NULL,	0, NULL, NULL }
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ide.c	2004-10-22 19:29:05 +02:00
@@ -694,7 +694,6 @@
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
 	hwif->ide_dma_host_on		= tmp_hwif->ide_dma_host_on;
 	hwif->ide_dma_host_off		= tmp_hwif->ide_dma_host_off;
-	hwif->ide_dma_verbose		= tmp_hwif->ide_dma_verbose;
 	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
 	hwif->ide_dma_timeout		= tmp_hwif->ide_dma_timeout;
 
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-10-22 19:29:05 +02:00
@@ -332,17 +332,6 @@
 }
 
 static int
-sgiioc4_ide_dma_verbose(ide_drive_t * drive)
-{
-	if (drive->using_dma == 1)
-		printk(", UDMA(16)");
-	else
-		printk(", PIO");
-
-	return 1;
-}
-
-static int
 sgiioc4_ide_dma_lostirq(ide_drive_t * drive)
 {
 	HWIF(drive)->resetproc(drive);
@@ -501,10 +490,7 @@
 	unsigned int count = 0, i = 1;
 	struct scatterlist *sg;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
-		hwif->sg_nents = i = ide_raw_build_sglist(drive, rq);
-	else
-		hwif->sg_nents = i = ide_build_sglist(drive, rq);
+	hwif->sg_nents = i = ide_build_sglist(drive, rq);
 
 	if (!i)
 		return 0;	/* sglist of length Zero */
@@ -623,7 +609,6 @@
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
 	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
-	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->INB = &sgiioc4_INB;
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/pci/siimage.c	2004-10-22 19:29:05 +02:00
@@ -554,12 +554,6 @@
 	return 0;
 }
 
-static int siimage_mmio_ide_dma_verbose (ide_drive_t *drive)
-{
-	int temp = __ide_dma_verbose(drive);
-	return temp;
-}
-
 /**
  *	siimage_busproc		-	bus isolation ioctl
  *	@drive: drive to isolate/restore
@@ -1077,7 +1071,6 @@
 
 	if (hwif->mmio) {
 		hwif->ide_dma_test_irq = &siimage_mmio_ide_dma_test_irq;
-		hwif->ide_dma_verbose = &siimage_mmio_ide_dma_verbose;
 	} else {
 		hwif->ide_dma_test_irq = & siimage_io_ide_dma_test_irq;
 	}
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/ide/ppc/pmac.c	2004-10-22 19:29:05 +02:00
@@ -1560,56 +1560,6 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 /*
- * We build & map the sglist for a given request.
- */
-static int __pmac
-pmac_ide_build_sglist(ide_drive_t *drive, struct request *rq)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	struct scatterlist *sg = hwif->sg_table;
-	int nents;
-
-	nents = blk_rq_map_sg(drive->queue, rq, sg);
-		
-	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	else
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
-
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
-}
-
-/*
- * Same as above but for a "raw" taskfile request
- */
-static int __pmac
-pmac_ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	struct scatterlist *sg = hwif->sg_table;
-	int nents = 0;
-	ide_task_t *args = rq->special;
-	unsigned char *virt_addr = rq->buffer;
-	int sector_count = rq->nr_sectors;
-
-	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
-	else
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-
-	if (sector_count > 128) {
-		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
-		nents++;
-		virt_addr = virt_addr + (128 * SECTOR_SIZE);
-		sector_count -= 128;
-	}
-	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
-	nents++;
-
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
-}
-
-/*
  * pmac_ide_build_dmatable builds the DBDMA command list
  * for a transfer and sets the DBDMA channel to point to it.
  */
@@ -1632,11 +1582,8 @@
 	while (readl(&dma->status) & RUN)
 		udelay(1);
 
-	/* Build sglist */
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
-		hwif->sg_nents = i = pmac_ide_raw_build_sglist(drive, rq);
-	else
-		hwif->sg_nents = i = pmac_ide_build_sglist(drive, rq);
+	hwif->sg_nents = i = ide_build_sglist(drive, rq);
+
 	if (!i)
 		return 0;
 
@@ -2078,7 +2025,6 @@
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
 	hwif->ide_dma_host_on = &pmac_ide_dma_host_on;
-	hwif->ide_dma_verbose = &__ide_dma_verbose;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
 
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2004-10-22 19:29:05 +02:00
+++ b/drivers/scsi/ide-scsi.c	2004-10-22 19:29:05 +02:00
@@ -45,6 +45,7 @@
 #include <linux/hdreg.h>
 #include <linux/slab.h>
 #include <linux/ide.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -253,17 +254,6 @@
 		kfree(atapi_buf);
 }
 
-static inline void idescsi_free_bio (struct bio *bio)
-{
-	struct bio *bhp;
-
-	while (bio) {
-		bhp = bio;
-		bio = bio->bi_next;
-		bio_put(bhp);
-	}
-}
-
 static void hexdump(u8 *x, int len)
 {
 	int i;
@@ -421,7 +411,6 @@
 	spin_lock_irqsave(host->host_lock, flags);
 	pc->done(pc->scsi_cmd);
 	spin_unlock_irqrestore(host->host_lock, flags);
-	idescsi_free_bio(rq->bio);
 	kfree(pc);
 	kfree(rq);
 	scsi->pc = NULL;
@@ -585,6 +574,50 @@
 	return ide_started;
 }
 
+static inline int idescsi_set_direction(idescsi_pc_t *pc)
+{
+	switch (pc->c[0]) {
+		case READ_6: case READ_10: case READ_12:
+			clear_bit(PC_WRITING, &pc->flags);
+			return 0;
+		case WRITE_6: case WRITE_10: case WRITE_12:
+			set_bit(PC_WRITING, &pc->flags);
+			return 0;
+		default:
+			return 1;
+	}
+}
+
+static int idescsi_map_sg(ide_drive_t *drive, idescsi_pc_t *pc)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct scatterlist *sg, *scsi_sg;
+	int segments;
+
+	if (!pc->request_transfer || pc->request_transfer % 1024)
+		return 1;
+
+	if (idescsi_set_direction(pc))
+		return 1;
+
+	sg = hwif->sg_table;
+	scsi_sg = pc->scsi_cmd->request_buffer;
+	segments = pc->scsi_cmd->use_sg;
+
+	if (segments > hwif->sg_max_nents)
+		return 1;
+
+	if (!segments) {
+		hwif->sg_nents = 1;
+		sg_init_one(sg, pc->scsi_cmd->request_buffer, pc->request_transfer);
+	} else {
+		hwif->sg_nents = segments;
+		memcpy(sg, scsi_sg, sizeof(*sg) * segments);
+	}
+
+	return 0;
+}
+
 /*
  *	Issue a packet command
  */
@@ -594,7 +627,6 @@
 	ide_hwif_t *hwif = drive->hwif;
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
-	struct request *rq = pc->rq;
 
 	scsi->pc=pc;							/* Set the current packet command */
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
@@ -602,8 +634,11 @@
 	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to
transfer the entire buffer at once */
 
 	feature.all = 0;
-	if (drive->using_dma && rq->bio)
+	if (drive->using_dma && !idescsi_map_sg(drive, pc)) {
+		hwif->sg_mapped = 1;
 		feature.b.dma = !hwif->dma_setup(drive);
+		hwif->sg_mapped = 0;
+	}
 
 	SELECT_DRIVE(drive);
 	if (IDE_CONTROL_REG)
@@ -775,81 +810,6 @@
 	return -EINVAL;
 }
 
-static inline struct bio *idescsi_kmalloc_bio (int count)
-{
-	struct bio *bh, *bhp, *first_bh;
-
-	if ((first_bh = bhp = bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
-		goto abort;
-	bio_init(bh);
-	bh->bi_vcnt = 1;
-	while (--count) {
-		if ((bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
-			goto abort;
-		bio_init(bh);
-		bh->bi_vcnt = 1;
-		bhp->bi_next = bh;
-		bhp = bh;
-		bh->bi_next = NULL;
-	}
-	return first_bh;
-abort:
-	idescsi_free_bio (first_bh);
-	return NULL;
-}
-
-static inline int idescsi_set_direction (idescsi_pc_t *pc)
-{
-	switch (pc->c[0]) {
-		case READ_6: case READ_10: case READ_12:
-			clear_bit (PC_WRITING, &pc->flags);
-			return 0;
-		case WRITE_6: case WRITE_10: case WRITE_12:
-			set_bit (PC_WRITING, &pc->flags);
-			return 0;
-		default:
-			return 1;
-	}
-}
-
-static inline struct bio *idescsi_dma_bio(ide_drive_t *drive, idescsi_pc_t *pc)
-{
-	struct bio *bh = NULL, *first_bh = NULL;
-	int segments = pc->scsi_cmd->use_sg;
-	struct scatterlist *sg = pc->scsi_cmd->request_buffer;
-
-	if (!drive->using_dma || !pc->request_transfer || pc->request_transfer % 1024)
-		return NULL;
-	if (idescsi_set_direction(pc))
-		return NULL;
-	if (segments) {
-		if ((first_bh = bh = idescsi_kmalloc_bio (segments)) == NULL)
-			return NULL;
-#if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB
total\n", drive->name, segments, pc->request_transfer >> 10);
-#endif /* IDESCSI_DEBUG_LOG */
-		while (segments--) {
-			bh->bi_io_vec[0].bv_page = sg->page;
-			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = sg->offset;
-			bh->bi_size = sg->length;
-			bh = bh->bi_next;
-			sg++;
-		}
-	} else {
-		if ((first_bh = bh = idescsi_kmalloc_bio (1)) == NULL)
-			return NULL;
-#if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer
(%dkB)\n", drive->name, pc->request_transfer >> 10);
-#endif /* IDESCSI_DEBUG_LOG */
-		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
-		bh->bi_io_vec[0].bv_offset = offset_in_page(pc->scsi_cmd->request_buffer);
-		bh->bi_io_vec[0].bv_len = pc->request_transfer;
-		bh->bi_size = pc->request_transfer;
-	}
-	return first_bh;
-}
-
 static inline int should_transform(ide_drive_t *drive, struct scsi_cmnd *cmd)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
@@ -921,7 +881,6 @@
 
 	ide_init_drive_cmd (rq);
 	rq->special = (char *) pc;
-	rq->bio = idescsi_dma_bio (drive, pc);
 	rq->flags = REQ_SPECIAL;
 	spin_unlock_irq(host->host_lock);
 	(void) ide_do_drive_cmd (drive, rq, ide_end);
@@ -975,7 +934,6 @@
 		 */
 		printk (KERN_ERR "ide-scsi: cmd aborted!\n");
 
-		idescsi_free_bio(scsi->pc->rq->bio);
 		if (scsi->pc->rq->flags & REQ_SENSE)
 			kfree(scsi->pc->buffer);
 		kfree(scsi->pc->rq);
@@ -1024,7 +982,6 @@
 	/* kill current request */
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
-	idescsi_free_bio(req->bio);
 	if (req->flags & REQ_SENSE)
 		kfree(scsi->pc->buffer);
 	kfree(scsi->pc);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-22 19:29:05 +02:00
+++ b/include/linux/ide.h	2004-10-22 19:29:05 +02:00
@@ -874,7 +874,6 @@
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
-	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 
@@ -938,6 +937,7 @@
 	unsigned	no_lba48_dma : 1; /* 1 = cannot do LBA48 DMA */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
+	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
 	struct semaphore gendev_rel_sem; /* To deal with device release() */
@@ -1492,10 +1492,10 @@
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
+void ide_dma_verbose(ide_drive_t *);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
-extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
@@ -1511,13 +1511,13 @@
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
-extern int __ide_dma_verbose(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #else
 static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
+static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 #ifndef CONFIG_BLK_DEV_IDEDMA_PCI
