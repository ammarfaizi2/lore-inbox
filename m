Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSG3Wvu>; Tue, 30 Jul 2002 18:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSG3Wvu>; Tue, 30 Jul 2002 18:51:50 -0400
Received: from [64.105.35.245] ([64.105.35.245]:59569 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317328AbSG3Wvq>; Tue, 30 Jul 2002 18:51:46 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 30 Jul 2002 15:54:46 -0700
Message-Id: <200207302254.PAA00504@baldur.yggdrasil.com>
To: martin@dalecki.de
Subject: Patch?: linux-2.5.29-ide109 small bio-based cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.29/drivers/ide/pcidma.c has a bunch of code in
udma_new_table to work around transfers that cross 64kB boundaries
and transfers that are exactly 64kB when the IDE chipset might only
be able to handle transfers of *less than* 64kB.  However, the current
bio code already has limits that you can set to tell it never to send
IO requests with those problems (blk_queue_segement_boundary and
blk_queue_max_segment_size).

	The following patch makes the IDE code use the bio facilities
to set these limits, and deletes the code that was needed to work
around these cases.  This shrinks the code by a net of 29 lines,
and may allow for a tiny bit of space savings in the future,
now that we know that none of the scatterlist entries that
pci_map_sg returns will have to be split. 

	I also got rid of an unnecessary variable and some
extra data clearing and copying in init_hw_data.

	I am running this code now on the main that I'm using
to compose this email.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.29-ide109/include/linux/ide.h	2002-07-30 14:57:42.000000000 -0700
+++ linux/include/linux/ide.h	2002-07-30 15:21:52.000000000 -0700
@@ -947,6 +947,8 @@
 	void (*udma_timeout) (struct ata_device *);
 	void (*udma_irq_lost) (struct ata_device *);
 
+	unsigned long	seg_boundary_mask;
+	unsigned int	max_segment_size;
 	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
 	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
 	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
--- linux-2.5.29-ide109/drivers/ide/trm290.c	2002-07-28 08:24:34.000000000 -0700
+++ linux/drivers/ide/trm290.c	2002-07-30 15:22:21.000000000 -0700
@@ -255,6 +255,7 @@
 	struct pci_dev *dev = hwif->pci_dev;
 
 	hwif->chipset = ide_trm290;
+	hwif->seg_boundary_mask = 0xffffffff;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase)
 	{
--- linux-2.5.29-ide109/drivers/ide/probe.c	2002-07-30 07:24:19.000000000 -0700
+++ linux/drivers/ide/probe.c	2002-07-30 15:24:13.000000000 -0700
@@ -1007,8 +1013,9 @@
 		q = &drive->queue;
 		q->queuedata = drive->channel;
 		blk_init_queue(q, do_ide_request, drive->channel->lock);
-		blk_queue_segment_boundary(q, 0xffff);
+		blk_queue_segment_boundary(q, ch->seg_boundary_mask);
+		blk_queue_max_segment_size(q, ch->max_segment_size);
 
 		/* ATA can do up to 128K per request, pdc4030 needs smaller limit */
 #ifdef CONFIG_BLK_DEV_PDC4030
--- linux-2.5.29-ide109/drivers/ide/cs5530.c	2002-07-30 07:27:09.000000000 -0700
+++ linux/drivers/ide/cs5530.c	2002-07-30 14:42:51.000000000 -0700
@@ -289,7 +282,11 @@
 
 	hwif->serialized = 1;
 
+	/* We think a 64kB transfer is a 0 byte transfer, so set our
+	   segment size to be one sector smaller than 64kB. */
+	hwif->max_segment_size = (1<<16) - 512;
+
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->highmem = 1;
--- linux-2.5.29-ide109/drivers/ide/main.c	2002-07-30 07:27:09.000000000 -0700
+++ linux/drivers/ide/main.c	2002-07-30 15:21:59.000000000 -0700
@@ -172,28 +172,36 @@
 static void init_hwif_data(struct ata_channel *ch, unsigned int index)
 {
 	static const unsigned int majors[] = {
 		IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
 		IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR
 	};
 
 	unsigned int unit;
-	hw_regs_t hw;
 
 	/* bulk initialize channel & drive info with zeros */
 	memset(ch, 0, sizeof(struct ata_channel));
-	memset(&hw, 0, sizeof(hw_regs_t));
 
 	/* fill in any non-zero initial values */
 	ch->index = index;
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &ch->irq);
+	ide_init_hwif_ports(&ch->hw, ide_default_io_base(index), 0, &ch->irq);
 
-	memcpy(&ch->hw, &hw, sizeof(hw));
-	memcpy(ch->io_ports, hw.io_ports, sizeof(hw.io_ports));
+	memcpy(ch->io_ports, ch->hw.io_ports, sizeof(ch->hw.io_ports));
+
+	/* Most controllers cannot do transfers across 64kB boundaries.
+	   trm290 can do transfers within a 4GB boundary, so it changes
+	   this mask accordingly. */
+	ch->seg_boundary_mask = 0xffff;
+
+	/* Some chipsets (cs5530, any others?) think a 64kB transfer
+	   is 0 byte transfer, so set the limit one sector smaller.
+	   In the future, we may default to 64kB transfers and let
+	   invidual chipsets with this problem change ch->max_segment_size. */
+	ch->max_segment_size = (1<<16) - 512;
 
 	ch->noprobe	= !ch->io_ports[IDE_DATA_OFFSET];
 #ifdef CONFIG_BLK_DEV_HD
 
 	/* Ignore disks for which handling by the legacy driver was requested
 	 * by the used.
 	 */
 	if (ch->io_ports[IDE_DATA_OFFSET] == 0x1f0)
--- linux-2.5.29-ide109/drivers/ide/pcidma.c	2002-07-28 08:24:34.000000000 -0700
+++ linux/drivers/ide/pcidma.c	2002-07-30 15:17:52.000000000 -0700
@@ -378,83 +378,38 @@
 int udma_new_table(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned int *table = ch->dmatable_cpu;
-#ifdef CONFIG_BLK_DEV_TRM290
-	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
-#else
-	const int is_trm290_chipset = 0;
-#endif
-	unsigned int count = 0;
 	int i;
 	struct scatterlist *sg;
 
 	ch->sg_nents = i = build_sglist(drive, rq);
 	if (!i)
 		return 0;
 
+	BUG_ON(i > PRD_ENTRIES);
+
 	sg = ch->sg_table;
-	while (i) {
-		u32 cur_addr;
-		u32 cur_len;
-
-		cur_addr = sg_dma_address(sg);
-		cur_len = sg_dma_len(sg);
-
-		/*
-		 * Fill in the dma table, without crossing any 64kB boundaries.
-		 * Most hardware requires 16-bit alignment of all blocks,
-		 * but the trm290 requires 32-bit alignment.
-		 */
-
-		while (cur_len) {
-			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
-
-			if (count++ >= PRD_ENTRIES) {
-				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
-						count, ch->sg_nents, cur_len, cur_addr);
-				BUG();
-			}
-
-			if (bcount > cur_len)
-				bcount = cur_len;
-			*table++ = cpu_to_le32(cur_addr);
-			xcount = bcount & 0xffff;
-			if (is_trm290_chipset)
-				xcount = ((xcount >> 2) - 1) << 16;
-			if (xcount == 0x0000) {
-		        /*
-			 * Most chipsets correctly interpret a length of
-			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
-			 * misinterprets it as zero (!). So here we break
-			 * the 64KB entry into two 32KB entries instead.
-			 */
-				if (count++ >= PRD_ENTRIES) {
-					pci_unmap_sg(ch->pci_dev, sg,
-						     ch->sg_nents,
-						     ch->sg_dma_direction);
-					return 0;
-				}
-
-				*table++ = cpu_to_le32(0x8000);
-				*table++ = cpu_to_le32(cur_addr + 0x8000);
-				xcount = 0x8000;
-			}
-			*table++ = cpu_to_le32(xcount);
-			cur_addr += bcount;
-			cur_len -= bcount;
-		}
+	while (i--) {
+		u32 cur_addr = sg_dma_address(sg);
+		u32 cur_len = sg_dma_len(sg) & 0xffff;
+
+		/* Delete this test after linux ~2.5.35, as we care
+		   about performance in this loop. */
+		BUG_ON(cur_len > ch->max_segment_size);
+
+		*table++ = cpu_to_le32(cur_addr);
+		*table++ = cpu_to_le32(cur_len);
 
 		sg++;
-		i--;
 	}
 
-	if (!count)
-		printk(KERN_ERR "%s: empty DMA table?\n", ch->name);
-	else if (!is_trm290_chipset)
+#ifdef CONFIG_BLK_DEV_TRM290
+	if (ch->chipset == ide_trm290)
 		*--table |= cpu_to_le32(0x80000000);
+#endif
 
-	return count;
+	return ch->sg_nents;
 }
 
 /*
  * Teardown mappings after DMA has completed.
