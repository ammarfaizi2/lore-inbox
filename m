Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319023AbSHFJD5>; Tue, 6 Aug 2002 05:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319025AbSHFJD5>; Tue, 6 Aug 2002 05:03:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:8453 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S319023AbSHFJDm>;
	Tue, 6 Aug 2002 05:03:42 -0400
Message-ID: <3D4F909D.60400@evision.ag>
Date: Tue, 06 Aug 2002 11:02:21 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.30 IDE 113
Content-Type: multipart/mixed;
 boundary="------------060300060708070300090704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300060708070300090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OK now an interresting part.

- Split up the handling of SG list setup, so we can now handle the
   TRM-290, which is using a custom physical layout better.
   The BIO code for detecting sectors crossing sector size boundaries
   is still, well somehow flaky. One thing for example is that the PIIX4
   docu states cleanly that all SG list entires should be double word
   aligned, but we don't see any code there to maintain this property.
   Purly accidentally the kernel allocation code is maintaining cache
   boundaries, which makes this code work accidentally right now :-/
   We will target this next.

- Make some local stuff properly tagged as static. Review the host
   controller code for such occurencies.

- Actually use blk_insert_request() in ide_raw_taskfile. Use a
   preallocated structure there for REQ_SPECIAL requests to avoid
   passing down values residing on the stack.

- Open code ata_start_dma() to make the host controller drivers more
   independant from the generic code. We don't have anything chipset
   specific in pcidma.c anylonger.

--------------060300060708070300090704
Content-Type: text/plain;
 name="ide-113.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ide-113.diff"

diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.30/drivers/ide/alim15x3.c	2002-08-01 23:16:29.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-08-06 01:01:38.000000000 +0200
@@ -362,12 +362,10 @@ static void __init ali15x3_init_channel(
 
 static void __init ali15x3_init_dma(struct ata_channel *ch, unsigned long dmabase)
 {
-	if (dmabase && (m5229_revision < 0x20)) {
+	if (dmabase && (m5229_revision < 0x20))
 		ch->autodma = 0;
-		return;
-	}
-
-	ata_init_dma(ch, dmabase);
+	else
+		ata_init_dma(ch, dmabase);
 }
 
 
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.30/drivers/ide/cmd640.c	2002-08-01 23:16:22.000000000 +0200
+++ linux/drivers/ide/cmd640.c	2002-08-05 12:01:24.000000000 +0200
@@ -220,7 +220,7 @@ static unsigned int cmd640_chip_version;
 static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
 {
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&pci_lock, flags);
 	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
 	outb_p(val, (reg & 3) | 0xcfc);
@@ -382,7 +382,7 @@ static int __init secondary_port_respond
 /*
  * Dump out all cmd640 registers.  May be called from ide.c
  */
-void cmd640_dump_regs (void)
+static void cmd640_dump_regs (void)
 {
 	unsigned int reg = cmd640_vlb ? 0x50 : 0x00;
 
@@ -693,18 +693,17 @@ out_lock:
 
 #endif
 
-/**
- *	pci_conf1	-	check for PCI type 1 configuration
- *	
- *	Issues a safe probe sequence for PCI configuration type 1 and
- *	returns non-zero if conf1 is supported. Takes the pci_config lock
+/*
+ * Check for PCI type 1 configuration
+ *
+ * Issues a safe probe sequence for PCI configuration type 1 and
+ * returns non-zero if conf1 is supported. Takes the pci_config lock
  */
- 
 static int pci_conf1(void)
 {
 	u32 tmp;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&pci_lock, flags);
 
 	OUT_BYTE(0x01, 0xCFB);
@@ -720,19 +719,17 @@ static int pci_conf1(void)
 	return 0;
 }
 
-/**
- *	pci_conf2	-	check for PCI type 2 configuration
- *	
- *	Issues a safe probe sequence for PCI configuration type 2 and
- *	returns non-zero if conf2 is supported. Takes the pci_config lock.
+/*
+ * Check for PCI type 2 configuration
+ *
+ * Issues a safe probe sequence for PCI configuration type 2 and
+ * returns non-zero if conf2 is supported. Takes the pci_config lock.
  */
- 
-
 static int pci_conf2(void)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&pci_lock, flags);
-	
+
 	OUT_BYTE(0x00, 0xCFB);
 	OUT_BYTE(0x00, 0xCF8);
 	OUT_BYTE(0x00, 0xCFA);
@@ -904,4 +901,3 @@ int __init ide_probe_for_cmd640x(void)
 #endif
 	return 1;
 }
-
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.30/drivers/ide/cmd64x.c	2002-08-01 23:16:19.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-08-05 12:18:38.000000000 +0200
@@ -30,9 +30,9 @@
 #define CMD_DEBUG 0
 
 #if CMD_DEBUG
-#define cmdprintk(x...)	printk(##x)
+# define cmdprintk(x...)	printk(##x)
 #else
-#define cmdprintk(x...)
+# define cmdprintk(x...)
 #endif
 
 /*
@@ -49,7 +49,7 @@
 #define	CMDTIM		0x52
 #define	ARTTIM0		0x53
 #define	DRWTIM0		0x54
-#define ARTTIM1 	0x55
+#define ARTTIM1		0x55
 #define DRWTIM1		0x56
 #define ARTTIM23	0x57
 #define   ARTTIM23_DIS_RA2	0x04
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.30/drivers/ide/cs5530.c	2002-08-06 01:18:58.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-08-05 12:03:01.000000000 +0200
@@ -35,7 +35,7 @@
 /*
  * Set a new transfer mode at the drive
  */
-int cs5530_set_xfer_mode(struct ata_device *drive, u8 mode)
+static int cs5530_set_xfer_mode(struct ata_device *drive, u8 mode)
 {
 	int error = 0;
 
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.30/drivers/ide/hpt34x.c	2002-08-01 23:16:07.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-08-06 00:28:43.000000000 +0200
@@ -99,26 +99,33 @@ static int hpt34x_udma_init(struct ata_d
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
-	unsigned int count;
 	u8 cmd;
 
-	if (!(count = udma_new_table(drive, rq)))
-		return ATA_OP_FINISHED;	/* try PIO instead of DMA */
+	/* try PIO instead of DMA */
+	if (!udma_new_table(drive, rq))
+		return ATA_OP_FINISHED;
 
+	/* No DMA transfers on ATAPI devices. */
+	if (drive->type != ATA_DISK)
+		return ATA_OP_CONTINUES;
+
+	/* The only difference from standard PIIX code is that we must have the
+	 * lowest bit set in the command word here.
+	 */
 	if (rq_data_dir(rq) == READ)
 		cmd = 0x09;
 	else
 		cmd = 0x01;
 
-	outl(ch->dmatable_dma, dma_base + 4);	/* PRD table */
-	outb(cmd, dma_base);			/* specify r/w */
-	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	outl(ch->dmatable_dma, dma_base + 4);		/* PRD table */
+	outb(cmd, dma_base);				/* specify r/w */
+	outb(inb(dma_base + 2) | 6, dma_base + 2);	/* clear INTR & ERROR flags */
 
-	if (drive->type == ATA_DISK) {
-		ata_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
-		OUT_BYTE((cmd == 0x09) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
-	}
+	ata_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
+	/* issue cmd to drive */
+	OUT_BYTE((cmd == 0x09) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
+	/* FIXME: should we call udma_start here?! */
 	return ATA_OP_CONTINUES;
 }
 #endif
@@ -190,7 +197,7 @@ static void __init ide_init_hpt34x(struc
 		hwif->no_atapi_autodma = 1;
 		hwif->udma_setup = hpt34x_udma_setup;
 		hwif->highmem = 1;
-	} else 
+	} else
 #endif
 	{
 		hwif->drives[0].autotune = 1;
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.30/drivers/ide/icside.c	2002-08-01 23:16:06.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-08-05 23:20:06.000000000 +0200
@@ -598,7 +598,7 @@ failed:
 	return 0;
 }
 
-void ide_release_dma(struct ata_channel *ch)
+void ata_release_dma(struct ata_channel *ch)
 {
 	if (ch->sg_table) {
 		kfree(ch->sg_table);
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.30/drivers/ide/ide-taskfile.c	2002-08-06 01:18:47.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-08-04 02:24:49.000000000 +0200
@@ -188,41 +188,26 @@ static ide_startstop_t special_intr(stru
 
 int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar, char *buf)
 {
-	struct request *rq;
-	unsigned long flags;
+	struct request *rq = &drive->srequest;
 	struct ata_channel *ch = drive->channel;
 	request_queue_t *q = &drive->queue;
-	struct list_head *queue_head = &q->queue_head;
 	DECLARE_COMPLETION(wait);
-	struct request req;
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (ch->chipset == ide_pdc4030 && buf)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
 
-	memset(&req, 0, sizeof(req));
-	rq = &req;
-	
-	rq->flags = REQ_SPECIAL;
+	memset(rq, 0, sizeof(*rq));
+
 	rq->buffer = buf;
-	rq->special = ar;
-	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->waiting = &wait;
 
 	ar->XXX_handler = special_intr;
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 
-	spin_lock_irqsave(ch->lock, flags);
-
-	if (!blk_queue_empty(&drive->queue))
-		queue_head = queue_head->prev;
-	__elv_add_request(q, rq, queue_head);
-
-	q->request_fn(q);
-	spin_unlock_irqrestore(ch->lock, flags);
-
+	blk_insert_request(q, rq, 1, ar);
 	wait_for_completion(&wait);	/* wait for it to be serviced */
 
 	return rq->errors ? -EIO : 0;	/* return -EIO if errors */
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.30/drivers/ide/main.c	2002-08-01 23:16:01.000000000 +0200
+++ linux/drivers/ide/main.c	2002-08-05 23:19:51.000000000 +0200
@@ -478,7 +478,7 @@ void ide_unregister(struct ata_channel *
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	ide_release_dma(ch);
+	ata_release_dma(ch);
 #endif
 
 	/*
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.30/drivers/ide/opti621.c	2002-08-01 23:16:09.000000000 +0200
+++ linux/drivers/ide/opti621.c	2002-08-05 12:08:03.000000000 +0200
@@ -130,7 +130,7 @@
 #define STRAP_REG 5	/* index of Strap register */
 #define MISC_REG 6	/* index of Miscellaneous register */
 
-int reg_base;
+static int reg_base;
 
 #define PIO_NOT_EXIST 254
 #define PIO_DONT_KNOW 255
@@ -244,10 +244,11 @@ static void compute_clocks(int pio, pio_
 
 }
 
-/* Main tune procedure, called from tuneproc.
-   Assumes IRQ's are disabled or at least that no other process will
-   attempt to access the IDE registers concurrently.
-*/
+/*
+ * Main tune procedure, called from tuneproc.
+ * Assumes IRQ's are disabled or at least that no other process will
+ * attempt to access the IDE registers concurrently.
+ */
 static void opti621_tune_drive(struct ata_device *drive, u8 pio)
 {
 	/* primary and secondary drives share some registers,
@@ -308,7 +309,7 @@ static void opti621_tune_drive(struct at
 }
 
 /*
- * ide_init_opti621() is called once for each hwif found at boot.
+ * This is called once for each hwif found at boot.
  */
 static void __init ide_init_opti621(struct ata_channel *hwif)
 {
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.30/drivers/ide/pcidma.c	2002-08-01 23:16:12.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-08-06 01:28:14.000000000 +0200
@@ -59,67 +59,6 @@ ide_startstop_t ide_dma_intr(struct ata_
 }
 
 /*
- * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
- * FIXME: I agree with Jens --mdcki!
- */
-static int build_sglist(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	struct scatterlist *sg = ch->sg_table;
-	int nents = 0;
-
-	if ((rq->flags & REQ_SPECIAL) && (drive->type == ATA_DISK)) {
-		struct ata_taskfile *args = rq->special;
-#if 1
-		unsigned char *virt_addr = rq->buffer;
-		int sector_count = rq->nr_sectors;
-#else
-		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
-
-		if (nents > rq->nr_segments)
-			printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
-#endif
-
-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-			ch->sg_dma_direction = PCI_DMA_TODEVICE;
-		else
-			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
-
-		/*
-		 * FIXME: This depends upon a hard coded page size!
-		 */
-		if (sector_count > 128) {
-			memset(&sg[nents], 0, sizeof(*sg));
-
-			sg[nents].page = virt_to_page(virt_addr);
-			sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
-			sg[nents].length = 128  * SECTOR_SIZE;
-			++nents;
-			virt_addr = virt_addr + (128 * SECTOR_SIZE);
-			sector_count -= 128;
-		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
-		sg[nents].length =  sector_count  * SECTOR_SIZE;
-		++nents;
-	} else {
-		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
-
-		if (rq->q && nents > rq->nr_phys_segments)
-			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
-
-		if (rq_data_dir(rq) == READ)
-			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
-		else
-			ch->sg_dma_direction = PCI_DMA_TODEVICE;
-
-	}
-
-	return pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
-}
-
-/*
  * 1 dma-ing, 2 error, 4 intr
  */
 static ide_startstop_t dma_timer_expiry(struct ata_device *drive, struct request *rq, unsigned long *wait)
@@ -147,26 +86,6 @@ static ide_startstop_t dma_timer_expiry(
 	return ATA_OP_FINISHED;
 }
 
-int ata_start_dma(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned long dma_base = ch->dma_base;
-	unsigned int reading = 0;
-
-	if (rq_data_dir(rq) == READ)
-		reading = 1 << 3;
-
-	/* try PIO instead of DMA */
-	if (!udma_new_table(drive, rq))
-		return 1;
-
-	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
-	outb(reading, dma_base);		/* specify r/w */
-	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
-
-	return 0;
-}
-
 /* generic udma_setup() function for drivers having ->speedproc/tuneproc */
 int udma_generic_setup(struct ata_device *drive, int map)
 {
@@ -293,9 +212,9 @@ int udma_pci_setup(struct ata_device *dr
 }
 
 /*
- * Needed for allowing full modular support of ide-driver
+ * Release data allocated for physical descriptor table.
  */
-void ide_release_dma(struct ata_channel *ch)
+void ata_release_dma(struct ata_channel *ch)
 {
 	if (!ch->dma_base)
 		return;
@@ -372,41 +291,45 @@ void udma_pci_enable(struct ata_device *
 }
 
 /*
- * This prepares a dma request.  Returns 0 if all went okay, returns 1
- * otherwise.  May also be invoked from trm290.c
+ * Prepare the physical region descriptor table for DMA transfers.
+ * Returns 0 if all went okay, returns 1 otherwise.
  */
 int udma_new_table(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned int *table = ch->dmatable_cpu;
+	u32 *prdt = ch->dmatable_cpu;
+	struct scatterlist *sg = ch->sg_table;
+	int nents;
 	int i;
-	struct scatterlist *sg;
 
-	ch->sg_nents = i = build_sglist(drive, rq);
+	nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
+
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ATA: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+
+	if (rq_data_dir(rq) == READ)
+		ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+	else
+		ch->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	i = ch->sg_nents = pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
+
 	if (!i)
 		return 0;
-
 	BUG_ON(i > PRD_ENTRIES);
 
-	sg = ch->sg_table;
 	while (i--) {
 		u32 cur_addr = sg_dma_address(sg);
-		u32 cur_len = sg_dma_len(sg) & 0xffff;
-
-		/* Delete this test after linux ~2.5.35, as we care
-		   about performance in this loop. */
-		BUG_ON(cur_len > ch->max_segment_size);
-
-		*table++ = cpu_to_le32(cur_addr);
-		*table++ = cpu_to_le32(cur_len);
+		u32 cur_len = sg_dma_len(sg);
 
-		sg++;
+		*prdt++ = cpu_to_le32(cur_addr);
+		*prdt++ = cpu_to_le32(cur_len & 0xffff);
+		++sg;
 	}
 
-#ifdef CONFIG_BLK_DEV_TRM290
-	if (ch->chipset == ide_trm290)
-		*--table |= cpu_to_le32(0x80000000);
-#endif
+	/* Indicate End Of Table for the hardware. */
+	--prdt;
+	*prdt |= cpu_to_le32(0x80000000);
 
 	return ch->sg_nents;
 }
@@ -478,6 +401,8 @@ void udma_pci_irq_lost(struct ata_device
  */
 void ata_init_dma(struct ata_channel *ch, unsigned long dma_base)
 {
+	u8 stat;
+
 	if (!request_region(dma_base, 8, ch->name)) {
 		printk(KERN_ERR "ATA: ERROR: BM DMA portst already in use!\n");
 
@@ -486,19 +411,22 @@ void ata_init_dma(struct ata_channel *ch
 	printk(KERN_INFO"    %s: BM-DMA at 0x%04lx-0x%04lx", ch->name, dma_base, dma_base + 7);
 	ch->dma_base = dma_base;
 	ch->dmatable_cpu = pci_alloc_consistent(ch->pci_dev,
-						  PRD_ENTRIES * PRD_BYTES,
-						  &ch->dmatable_dma);
-	if (ch->dmatable_cpu == NULL)
+			PRD_ENTRIES * PRD_BYTES, &ch->dmatable_dma);
+	if (!ch->dmatable_cpu)
 		goto dma_alloc_failure;
 
-	ch->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
-				 GFP_KERNEL);
-	if (ch->sg_table == NULL) {
+	ch->sg_table = kmalloc(sizeof(*ch->sg_table) * PRD_ENTRIES, GFP_KERNEL);
+	if (!ch->sg_table) {
 		pci_free_consistent(ch->pci_dev, PRD_ENTRIES * PRD_BYTES,
-				    ch->dmatable_cpu, ch->dmatable_dma);
+				ch->dmatable_cpu, ch->dmatable_dma);
 		goto dma_alloc_failure;
 	}
 
+	stat = inb(dma_base + 2);
+	printk(", BIOS settings: %s:%s, %s:%s\n",
+			ch->drives[0].name, (stat & 0x20) ? "DMA" : "pio",
+			ch->drives[1].name, (stat & 0x40) ? "DMA" : "pio");
+
 	/*
 	 * We could just assign them, and then leave it up to the chipset
 	 * specific code to override these after they've called this function.
@@ -515,22 +443,15 @@ void ata_init_dma(struct ata_channel *ch
 		ch->udma_init = udma_pci_init;
 	if (!ch->udma_irq_status)
 		ch->udma_irq_status = udma_pci_irq_status;
-	if (!ch->udma_timeout)
-		ch->udma_timeout = udma_pci_timeout;
 	if (!ch->udma_irq_lost)
 		ch->udma_irq_lost = udma_pci_irq_lost;
+	if (!ch->udma_timeout)
+		ch->udma_timeout = udma_pci_timeout;
 
-	if (ch->chipset != ide_trm290) {
-		u8 dma_stat = inb(dma_base+2);
-		printk(", BIOS settings: %s:%s, %s:%s",
-		       ch->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       ch->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
-	}
-	printk("\n");
 	return;
 
 dma_alloc_failure:
-	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
+	printk("ATA: error unable to allocate BM-DMA PRD-tables\n");
 }
 
 /*
@@ -541,10 +462,13 @@ dma_alloc_failure:
  */
 int udma_pci_init(struct ata_device *drive, struct request *rq)
 {
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
 	u8 cmd;
 
-	if (ata_start_dma(drive, rq))
-		return ATA_OP_FINISHED;
+	/* try PIO instead of DMA */
+	if (!udma_new_table(drive, rq))
+		return 1;
 
 	/* No DMA transfers on ATAPI devices. */
 	if (drive->type != ATA_DISK)
@@ -555,6 +479,10 @@ int udma_pci_init(struct ata_device *dri
 	else
 		cmd = 0x00;
 
+	outl(ch->dmatable_dma, dma_base + 4);		/* PRD table */
+	outb(cmd, dma_base);				/* specify r/w */
+	outb(inb(dma_base + 2) | 6, dma_base + 2);	/* clear INTR & ERROR flags */
+
 	ata_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);
 	if (drive->addressing)
 		outb(cmd ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.30/drivers/ide/pdc202xx.c	2002-08-01 23:16:40.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-08-05 12:10:21.000000000 +0200
@@ -3,7 +3,7 @@
  *  linux/drivers/ide/pdc202xx.c	Version 0.30	May. 28, 2002
  *
  *  Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2002		BartÅ^Âomiej Å»oÅ^Ânierkiewicz
+ *  Copyright (C) 2002		BartÅ‚omiej Å»oÅ‚nierkiewicz
  *
  *  Portions Copyright (C) 1999-2002 Promise Technology, Inc.
  *  Author:	Frank Tiernan <frankt@promise.com>
@@ -117,11 +117,11 @@ static void pdc_dump_bits(struct pdc_bit
 
 	printk(KERN_DEBUG " }\n");
 }
-#endif				/* PDC202XX_DECODE_REGISTER_INFO */
+#endif
 
 static struct ata_device *drives[4];
 
-int check_in_drive_lists(struct ata_device *drive)
+static int check_in_drive_lists(struct ata_device *drive)
 {
 	static const char *pdc_quirk_drives[] = {
 		"QUANTUM FIREBALLlct08 08",
@@ -661,7 +661,7 @@ static void pdc202xx_reset_host(struct p
 	printk(KERN_INFO "%s: device reseted.\n", dev->name);
 }
 
-void pdc202xx_reset(struct ata_device *drive)
+static void pdc202xx_reset(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	printk(KERN_INFO "%s: channel needs reset.\n", ch->name);
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.30/drivers/ide/piix.c	2002-08-01 23:16:39.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-08-06 01:00:02.000000000 +0200
@@ -380,8 +380,8 @@ static void __init piix_init_channel(str
 static void __init piix_init_dma(struct ata_channel *ch, unsigned long dmabase)
 {
 	if (((piix_enabled >> ch->unit) & 1)
-		&& !(piix_config->flags & PIIX_NODMA))
-			ata_init_dma(ch, dmabase);
+			&& !(piix_config->flags & PIIX_NODMA))
+		ata_init_dma(ch, dmabase);
 }
 
 
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.30/drivers/ide/tcq.c	2002-08-01 23:16:33.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-08-06 00:30:54.000000000 +0200
@@ -523,10 +523,14 @@ static int tcq_wait_dataphase(struct ata
 /*
  * Invoked from a SERVICE interrupt, command etc already known.  Just need to
  * start the dma engine for this tag.
+ *
+ * FIXME: Integrate this with udma_pci_init().
  */
 static ide_startstop_t udma_tcq_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 cmd = 0;
 
 	TCQ_PRINTK("%s: setting up queued %d\n", __FUNCTION__, rq->tag);
 	if (!test_bit(IDE_BUSY, ch->active))
@@ -535,9 +539,19 @@ static ide_startstop_t udma_tcq_start(st
 	if (tcq_wait_dataphase(drive))
 		return ATA_OP_FINISHED;
 
-	if (ata_start_dma(drive, rq))
+	/* try PIO instead of DMA */
+	if (!udma_new_table(drive, rq))
 		return ATA_OP_FINISHED;
 
+	if (rq_data_dir(rq) == READ)
+		cmd = 0x08;
+	else
+		cmd = 0x00;
+
+	outl(ch->dmatable_dma, dma_base + 4);		/* PRD table */
+	outb(cmd, dma_base);				/* specify r/w */
+	outb(inb(dma_base + 2) | 6, dma_base + 2);	/* clear INTR & ERROR flags */
+
 	__set_irq(ch, ide_dmaq_intr);
 	udma_start(drive, rq);
 
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.30/drivers/ide/trm290.c	2002-08-01 23:16:12.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-08-06 01:27:25.000000000 +0200
@@ -1,12 +1,8 @@
 /**** vi:set ts=8 sts=8 sw=8:************************************************
  *
- *  linux/drivers/ide/trm290.c		Version 1.02	Mar. 18, 2000
- *
  *  Copyright (c) 1997-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
- */
-
-/*
+ *
  * This module provides support for the bus-master IDE DMA function
  * of the Tekram TRM290 chip, used on a variety of PCI IDE add-on boards,
  * including a "Precision Instruments" board.  The TRM290 pre-dates
@@ -144,7 +140,7 @@
 
 static void trm290_prepare_drive(struct ata_device *drive, unsigned int use_dma)
 {
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 	unsigned int reg;
 	unsigned long flags;
 
@@ -153,17 +149,17 @@ static void trm290_prepare_drive(struct 
 
 	local_irq_save(flags);
 
-	if (reg != hwif->select_data) {
-		hwif->select_data = reg;
-		outb(0x51|(hwif->unit<<3), hwif->config_data+1);	/* set PIO/DMA */
-		outw(reg & 0xff, hwif->config_data);
+	if (reg != ch->select_data) {
+		ch->select_data = reg;
+		outb(0x51|(ch->unit<<3), ch->config_data+1);	/* set PIO/DMA */
+		outw(reg & 0xff, ch->config_data);
 	}
 
 	/* enable IRQ if not probing */
 	if (drive->present) {
-		reg = inw(hwif->config_data+3) & 0x13;
-		reg &= ~(1 << hwif->unit);
-		outw(reg, hwif->config_data+3);
+		reg = inw(ch->config_data+3) & 0x13;
+		reg &= ~(1 << ch->unit);
+		outw(reg, ch->config_data+3);
 	}
 
 	local_irq_restore(flags);
@@ -189,6 +185,47 @@ static int trm290_udma_stop(struct ata_d
 	return (inw(ch->dma_base + 2) != 0x00ff);
 }
 
+/*
+ * Prepare the physical region descriptor table for DMA transfers.
+ * Returns 0 if all went okay, returns 1 otherwise.
+ */
+static int trm290_new_table(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	u32 *prdt = ch->dmatable_cpu;
+	struct scatterlist *sg = ch->sg_table;
+	int nents;
+	int i;
+
+	nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
+
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ATA: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+
+	if (rq_data_dir(rq) == READ)
+		ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+	else
+		ch->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	i = ch->sg_nents = pci_map_sg(ch->pci_dev, sg, nents, ch->sg_dma_direction);
+
+	if (!i)
+		return 0;
+	BUG_ON(i > PRD_ENTRIES);
+
+	while (i--) {
+		u32 cur_addr = sg_dma_address(sg);
+		u32 cur_len = sg_dma_len(sg);
+
+		*prdt++ = cpu_to_le32(cur_addr);
+		/* FIXME: hopefully the following does the right thing */
+		*prdt++ = cpu_to_le32((((cur_len & 0xffff) >> 2) - 1) << 16);
+		++sg;
+	}
+
+	return ch->sg_nents;
+}
+
 static int trm290_udma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
@@ -215,7 +252,7 @@ static int trm290_udma_init(struct ata_d
 		writing = 0;
 	}
 
-	if (!(count = udma_new_table(drive, rq))) {
+	if (!(count = trm290_new_table(drive, rq))) {
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 		return ATA_OP_FINISHED;	/* try PIO instead of DMA */
 	}
@@ -223,7 +260,7 @@ static int trm290_udma_init(struct ata_d
 	trm290_prepare_drive(drive, 1);	/* select DMA xfer */
 
 	outl(ch->dmatable_dma|reading|writing, ch->dma_base);
-	outw((count * 2) - 1, ch->dma_base+2); /* start DMA */
+	outw((count * 2) - 1, ch->dma_base + 2); /* start DMA */
 
 	if (drive->type == ATA_DISK) {
 		ata_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
@@ -247,37 +284,37 @@ static int trm290_udma_setup(struct ata_
 /*
  * Invoked from ide-dma.c at boot time.
  */
-static void __init trm290_init_channel(struct ata_channel *hwif)
+static void __init trm290_init_channel(struct ata_channel *ch)
 {
 	unsigned int cfgbase = 0;
 	unsigned long flags;
 	u8 reg;
-	struct pci_dev *dev = hwif->pci_dev;
+	struct pci_dev *dev = ch->pci_dev;
+	unsigned long dma_base;
 
-	hwif->chipset = ide_trm290;
-	hwif->seg_boundary_mask = 0xffffffff;
+	ch->chipset = ide_trm290;
+	ch->seg_boundary_mask = 0xffffffff;
 	cfgbase = pci_resource_start(dev, 4);
-	if ((dev->class & 5) && cfgbase)
-	{
-		hwif->config_data = cfgbase;
-		printk("TRM290: chip config base at 0x%04lx\n", hwif->config_data);
+	if ((dev->class & 5) && cfgbase) {
+		ch->config_data = cfgbase;
+		printk("TRM290: chip config base at 0x%04lx\n", ch->config_data);
 	} else {
-		hwif->config_data = 0x3df0;
-		printk("TRM290: using default config base at 0x%04lx\n", hwif->config_data);
+		ch->config_data = 0x3df0;
+		printk("TRM290: using default config base at 0x%04lx\n", ch->config_data);
 	}
 
 	local_irq_save(flags);
-	/* put config reg into first byte of hwif->select_data */
-	outb(0x51|(hwif->unit<<3), hwif->config_data+1);
-	hwif->select_data = 0x21;			/* select PIO as default */
-	outb(hwif->select_data, hwif->config_data);
-	reg = inb(hwif->config_data+3);			/* get IRQ info */
+	/* put config reg into first byte of ch->select_data */
+	outb(0x51 | (ch->unit << 3), ch->config_data + 1);
+	ch->select_data = 0x21;			/* select PIO as default */
+	outb(ch->select_data, ch->config_data);
+	reg = inb(ch->config_data+3);			/* get IRQ info */
 	reg = (reg & 0x10) | 0x03;			/* mask IRQs for both ports */
-	outb(reg, hwif->config_data+3);
+	outb(reg, ch->config_data+3);
 	local_irq_restore(flags);
 
 	if ((reg & 0x10))
-		hwif->irq = hwif->unit ? 15 : 14;	/* legacy mode */
+		ch->irq = ch->unit ? 15 : 14;	/* legacy mode */
 	else {
 		static int primary_irq = 0;
 
@@ -285,40 +322,64 @@ static void __init trm290_init_channel(s
 		 * chip use the same IRQ line.
 		 */
 
-		if (hwif->unit == ATA_PRIMARY)
-			primary_irq = hwif->irq;
-		else if (!hwif->irq)
-			hwif->irq = primary_irq;
+		if (ch->unit == ATA_PRIMARY)
+			primary_irq = ch->irq;
+		else if (!ch->irq)
+			ch->irq = primary_irq;
 	}
 
-	ata_init_dma(hwif, (hwif->config_data + 4) ^ (hwif->unit ? 0x0080 : 0x0000));
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->udma_start = trm290_udma_start;
-	hwif->udma_stop = trm290_udma_stop;
-	hwif->udma_init = trm290_udma_init;
-	hwif->udma_irq_status = trm290_udma_irq_status;
-	hwif->udma_setup = trm290_udma_setup;
+	dma_base  = (ch->config_data + 4) ^ (ch->unit ? 0x0080 : 0x0000);
+	if (!request_region(dma_base, 8, ch->name)) {
+		printk(KERN_ERR "ATA: ERROR: BM DMA portst already in use!\n");
+
+		return;
+	}
+	printk(KERN_INFO"    %s: BM-DMA at 0x%04lx-0x%04lx\n", ch->name, dma_base, dma_base + 7);
+	ch->dma_base = dma_base;
+	ch->dmatable_cpu = pci_alloc_consistent(ch->pci_dev,
+			PRD_ENTRIES * PRD_BYTES, &ch->dmatable_dma);
+	if (!ch->dmatable_cpu)
+		goto dma_alloc_failure;
+
+	ch->sg_table = kmalloc(sizeof(*ch->sg_table) * PRD_ENTRIES, GFP_KERNEL);
+	if (!ch->sg_table) {
+		pci_free_consistent(ch->pci_dev, PRD_ENTRIES * PRD_BYTES,
+				ch->dmatable_cpu, ch->dmatable_dma);
+		goto dma_alloc_failure;
+	}
+
+	ch->udma_setup		= trm290_udma_setup;
+	ch->udma_enable		= udma_pci_enable;
+	ch->udma_start		= trm290_udma_start;
+	ch->udma_stop		= trm290_udma_stop;
+	ch->udma_init		= trm290_udma_init;
+	ch->udma_irq_status	= trm290_udma_irq_status;
+	ch->udma_irq_lost	= udma_pci_irq_lost;
+	ch->udma_timeout	= udma_pci_timeout;
+
+dma_alloc_failure:
+	printk("ATA: error unable to allocate BM-DMA PRD-tables\n");
 #endif
 
-	hwif->selectproc = &trm290_selectproc;
+	ch->selectproc = &trm290_selectproc;
 #if 1
 	{
 		/*
-		 * My trm290-based card doesn't seem to work with all possible values
+		 * My TRM290-based card doesn't seem to work with all possible values
 		 * for the control basereg, so this kludge ensures that we use only
 		 * values that are known to work.  Ugh.		-ml
 		 */
-		unsigned short old, compat = hwif->unit ? 0x374 : 0x3f4;
+		unsigned short old, compat = ch->unit ? 0x374 : 0x3f4;
 		static unsigned short next_offset = 0;
 
-		outb(0x54|(hwif->unit<<3), hwif->config_data+1);
-		old = inw(hwif->config_data) & ~1;
+		outb(0x54|(ch->unit<<3), ch->config_data+1);
+		old = inw(ch->config_data) & ~1;
 		if (old != compat && inb(old+2) == 0xff) {
 			compat += (next_offset += 0x400);	/* leave lower 10 bits untouched */
-			hwif->io_ports[IDE_CONTROL_OFFSET] = compat + 2;
-			outw(compat|1, hwif->config_data);
-			printk("%s: control basereg workaround: old=0x%04x, new=0x%04x\n", hwif->name, old, inw(hwif->config_data) & ~1);
+			ch->io_ports[IDE_CONTROL_OFFSET] = compat + 2;
+			outw(compat|1, ch->config_data);
+			printk("%s: control basereg workaround: old=0x%04x, new=0x%04x\n", ch->name, old, inw(ch->config_data) & ~1);
 		}
 	}
 #endif
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.30/drivers/ide/umc8672.c	2002-08-01 23:16:17.000000000 +0200
+++ linux/drivers/ide/umc8672.c	2002-08-05 12:13:16.000000000 +0200
@@ -2,9 +2,7 @@
  *  linux/drivers/ide/umc8672.c		Version 0.05	Jul 31, 1996
  *
  *  Copyright (C) 1995-1996  Linus Torvalds & author (see below)
- */
-
-/*
+ *
  *  Principal Author/Maintainer:  PODIEN@hml2.atlas.de (Wolfram Podien)
  *
  *  This file provides support for the advanced features
@@ -118,7 +116,7 @@ static void tune_umc(struct ata_device *
 	umc_set_speeds (current_speeds);
 }
 
-void __init init_umc8672(void)	/* called from ide.c */
+void __init init_umc8672(void)
 {
 	unsigned long flags;
 
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.30/drivers/ide/via82cxxx.c	2002-08-01 23:16:34.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-08-05 12:13:48.000000000 +0200
@@ -8,9 +8,7 @@
  *	Michel Aubry
  *	Jeff Garzik
  *	Andre Hedrick
- */
-
-/*
+ *
  * VIA IDE driver for Linux. Supports
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.30/include/linux/ide.h	2002-08-06 01:18:58.000000000 +0200
+++ linux/include/linux/ide.h	2002-08-06 00:29:41.000000000 +0200
@@ -763,6 +763,7 @@ struct ata_device {
 
 	request_queue_t	queue;		/* per device request queue */
 	struct request *rq;		/* current request */
+	struct request srequest;	/* special requests */
 
 	u8	 retry_pio;		/* retrying dma capable host in pio */
 	u8	 state;			/* retry state */
@@ -1245,10 +1246,9 @@ extern int udma_tcq_enable(struct ata_de
 
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 extern int check_drive_lists(struct ata_device *, int good_bad);
-extern void ide_release_dma(struct ata_channel *);
-extern int ata_start_dma(struct ata_device *, struct request *rq);
 
 extern void ata_init_dma(struct ata_channel *,	unsigned long) __init;
+extern void ata_release_dma(struct ata_channel *);
 
 #endif
 

--------------060300060708070300090704--

