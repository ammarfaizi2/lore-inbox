Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSEVShd>; Wed, 22 May 2002 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSEVSh1>; Wed, 22 May 2002 14:37:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11283 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316659AbSEVSfJ>; Wed, 22 May 2002 14:35:09 -0400
Message-ID: <3CEBD603.8030102@evision-ventures.com>
Date: Wed, 22 May 2002 19:31:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.17 IDE 69
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000200090308050104090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200090308050104090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Basically accumulated stuff from other people.
Thank you all again!

Wed May 22 10:26:29 CEST 2002 ide-clean-69

- Apply small host chip driver cosmetics by Andrej xxx Panin
   and Vojtech Pavlik.

- Remove support for "disc recovery time". It could only supposedly
   help with really simplistic broken devices from the past,
   which didn't have moderately sophisticated controllers.
   And finally Vojtech voted for it as well... so I just trust him.

- Apply icside host chip driver and other ARM related updates by Russell King,
   which finally settle the "portability" work a bit, well hopefully.

Still Adam Richters draft patches on my agenda remaining... But
well it's only one day...

--------------000200090308050104090506
Content-Type: text/plain;
 name="ide-clean-69.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-69.diff"

diff -urN linux-2.5.17/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.17/drivers/ide/aec62xx.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-22 13:21:11.000000000 +0200
@@ -259,7 +259,7 @@
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
+			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
 		}
 	return 0x00;
 }
@@ -268,7 +268,7 @@
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((system_bus_speed <= 33) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
+			return ((byte) ((system_bus_speed <= 33333) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
 		}
 	return 0x00;
 }
diff -urN linux-2.5.17/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.17/drivers/ide/ali14xx.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/ali14xx.c	2002-05-22 13:21:11.000000000 +0200
@@ -124,8 +124,8 @@
 	/* calculate timing, according to PIO mode */
 	time1 = t->cycle;
 	time2 = t->active;
-	param3 = param1 = (time2 * system_bus_speed + 999) / 1000;
-	param4 = param2 = (time1 * system_bus_speed + 999) / 1000 - param1;
+	param3 = param1 = (time2 * system_bus_speed + 999999) / 1000000;
+	param4 = param2 = (time1 * system_bus_speed + 999999) / 1000000 - param1;
 	if (pio < XFER_PIO_3) {
 		param3 += 8;
 		param4 += 8;
diff -urN linux-2.5.17/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.17/drivers/ide/alim15x3.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-22 13:21:11.000000000 +0200
@@ -261,18 +261,18 @@
 
 	s_time = t->setup;
 	a_time = t->active;
-	if ((s_clc = (s_time * system_bus_speed + 999) / 1000) >= 8)
+	if ((s_clc = (s_time * system_bus_speed + 999999) / 1000000) >= 8)
 		s_clc = 0;
-	if ((a_clc = (a_time * system_bus_speed + 999) / 1000) >= 8)
+	if ((a_clc = (a_time * system_bus_speed + 999999) / 1000000) >= 8)
 		a_clc = 0;
 	c_time = t->cycle;
 
 #if 0
-	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999) / 1000) >= 16)
+	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999999) / 1000000) >= 16)
 		r_clc = 0;
 #endif
 
-	if (!(r_clc = (c_time * system_bus_speed + 999) / 1000 - a_clc - s_clc)) {
+	if (!(r_clc = (c_time * system_bus_speed + 999999) / 1000000 - a_clc - s_clc)) {
 		r_clc = 1;
 	} else {
 		if (r_clc >= 16)
diff -urN linux-2.5.17/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.17/drivers/ide/amd74xx.c	2002-05-21 07:07:40.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-05-22 13:21:11.000000000 +0200
@@ -87,7 +87,6 @@
 static struct amd_ide_chip *amd_config;
 static unsigned char amd_enabled;
 static unsigned int amd_80w;
-static unsigned int amd_clock;
 
 static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
 static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };
@@ -131,7 +130,7 @@
 	amd_print("Highest DMA rate:                   %s", amd_dma[amd_config->flags & AMD_UDMA]);
 
 	amd_print("BM-DMA base:                        %#x", amd_base);
-	amd_print("PCI clock:                          %d.%dMHz", amd_clock / 1000, amd_clock / 100 % 10);
+	amd_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 	
 	amd_print("-----------------------Primary IDE-------Secondary IDE------");
 
@@ -147,7 +146,7 @@
 
 	amd_print("Cable Type:            %10s%20s", (amd_80w & 1) ? "80w" : "40w", (amd_80w & 2) ? "80w" : "40w");
 
-	if (!amd_clock)
+	if (!system_bus_speed)
                 return p - buffer;
 
 	amd_print("-------------------drive0----drive1----drive2----drive3-----");
@@ -169,22 +168,22 @@
 		den[i]  = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
 		if (den[i] && uen[i] && udma[i] == 1) {
-			speed[i] = amd_clock * 3;
-			cycle[i] = 666666 / amd_clock;
+			speed[i] = system_bus_speed * 3;
+			cycle[i] = 666666 / system_bus_speed;
 			continue;
 		}
 
-		speed[i] = 4 * amd_clock / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
-		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / amd_clock / 2;
+		speed[i] = 4 * system_bus_speed / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
+		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / system_bus_speed / 2;
 	}
 
 	amd_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / amd_clock);
-	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / amd_clock);
-	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / amd_clock);
-	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / amd_clock);
-	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / amd_clock);
+	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / system_bus_speed);
+	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / system_bus_speed);
+	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / system_bus_speed);
+	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / system_bus_speed);
+	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / system_bus_speed);
 	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -238,7 +237,7 @@
 			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
 				drive->dn >> 1, drive->dn & 1);
 
-	T = 1000000000 / amd_clock;
+	T = 1000000000 / system_bus_speed;
 	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);
 
 	ata_timing_compute(drive, speed, &t, T, UT);
@@ -248,7 +247,7 @@
 		ata_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
-	if (speed == XFER_UDMA_5 && amd_clock <= 33333) t.udma = 1;
+	if (speed == XFER_UDMA_5 && system_bus_speed <= 33333) t.udma = 1;
 
 	amd_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
@@ -358,24 +357,6 @@
 		(amd_config->flags & AMD_BAD_FIFO) ? (t & 0x0f) : (t | 0xf0));
 
 /*
- * Determine the system bus clock.
- */
-
-	amd_clock = system_bus_speed * 1000;
-
-	switch (amd_clock) {
-		case 33000: amd_clock = 33333; break;
-		case 37000: amd_clock = 37500; break;
-		case 41000: amd_clock = 41666; break;
-	}
-
-	if (amd_clock < 20000 || amd_clock > 50000) {
-		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", amd_clock);
-		printk(KERN_WARNING "AMD_IDE: Use ide0=ata66 if you want to assume 80-wire cable\n");
-		amd_clock = 33333;
-	}
-
-/*
  * Print the boot message.
  */
 
diff -urN linux-2.5.17/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.17/drivers/ide/cmd640.c	2002-05-21 07:07:38.000000000 +0200
+++ linux/drivers/ide/cmd640.c	2002-05-22 13:21:11.000000000 +0200
@@ -603,7 +603,7 @@
 	u8 cycle_count;
 
 	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / system_bus_speed;
+	clock_time = 1000000 / system_bus_speed;
 	cycle_count = (cycle_time + clock_time - 1) / clock_time;
 
 	setup_count = (setup_time + clock_time - 1) / clock_time;
diff -urN linux-2.5.17/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.17/drivers/ide/cmd64x.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-22 13:21:11.000000000 +0200
@@ -305,7 +305,7 @@
 	 */
 
 	recovery_time = t->cycle - (t->setup + t->active);
-	clock_time = 1000 / system_bus_speed;
+	clock_time = 1000000 / system_bus_speed;
 	cycle_count = (t->cycle + clock_time - 1) / clock_time;
 	setup_count = (t->setup + clock_time - 1) / clock_time;
 	active_count = (t->active + clock_time - 1) / clock_time;
diff -urN linux-2.5.17/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.17/drivers/ide/cy82c693.c	2002-05-21 07:07:34.000000000 +0200
+++ linux/drivers/ide/cy82c693.c	2002-05-22 13:21:11.000000000 +0200
@@ -121,7 +121,7 @@
 {
 	int clocks;
 
-	clocks = (time*bus_speed+999)/1000 -1;
+	clocks = (time*bus_speed+999999)/1000000 -1;
 
 	if (clocks < 0)
 		clocks = 0;
diff -urN linux-2.5.17/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.17/drivers/ide/ht6560b.c	2002-05-21 07:07:33.000000000 +0200
+++ linux/drivers/ide/ht6560b.c	2002-05-22 13:21:11.000000000 +0200
@@ -219,8 +219,8 @@
 		/*
 		 *  Cycle times should be Vesa bus cycles
 		 */
-		active_cycles   = (active_time   * system_bus_speed + 999) / 1000;
-		recovery_cycles = (recovery_time * system_bus_speed + 999) / 1000;
+		active_cycles   = (active_time   * system_bus_speed + 999999) / 1000000;
+		recovery_cycles = (recovery_time * system_bus_speed + 999999) / 1000000;
 		/*
 		 *  Upper and lower limits
 		 */
diff -urN linux-2.5.17/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.17/drivers/ide/icside.c	2002-05-21 07:07:31.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-05-22 17:06:50.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/ide/icside.c
  *
- * Copyright (c) 1996,1997 Russell King.
+ * Copyright (c) 1996-2002 Russell King.
  *
  * Changelog:
  *  08-Jun-1996	RMK	Created
@@ -25,6 +25,7 @@
 #include <asm/dma.h>
 #include <asm/ecard.h>
 #include <asm/io.h>
+#include <asm/page.h>
 
 extern char *ide_xfer_verbose (byte xfer_rate);
 
@@ -75,6 +76,12 @@
 	ICS_ARCIN_V6_IDESTEPPING
 };
 
+struct icside_state {
+	unsigned int channel;
+	unsigned int enabled;
+	unsigned int irq_port;
+};
+
 static const card_ids icside_cids[] = {
 	{ MANU_ICS,  PROD_ICS_IDE  },
 	{ MANU_ICS2, PROD_ICS2_IDE },
@@ -122,10 +129,21 @@
  */
 static void icside_irqenable_arcin_v6 (struct expansion_card *ec, int irqnr)
 {
-	unsigned int ide_base_port = (unsigned int)ec->irq_data;
+	struct icside_state *state = ec->irq_data;
+	unsigned int base = state->irq_port;
+
+	state->enabled = 1;
 
-	outb (0, ide_base_port + ICS_ARCIN_V6_INTROFFSET_1);
-	outb (0, ide_base_port + ICS_ARCIN_V6_INTROFFSET_2);
+	switch (state->channel) {
+	case 0:
+		outb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
+		inb(base + ICS_ARCIN_V6_INTROFFSET_2);
+		break;
+	case 1:
+		outb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
+		inb(base + ICS_ARCIN_V6_INTROFFSET_1);
+		break;
+	}
 }
 
 /* Prototype: icside_irqdisable_arcin_v6 (struct expansion_card *ec, int irqnr)
@@ -133,10 +151,12 @@
  */
 static void icside_irqdisable_arcin_v6 (struct expansion_card *ec, int irqnr)
 {
-	unsigned int ide_base_port = (unsigned int)ec->irq_data;
+	struct icside_state *state = ec->irq_data;
+
+	state->enabled = 0;
 
-	inb (ide_base_port + ICS_ARCIN_V6_INTROFFSET_1);
-	inb (ide_base_port + ICS_ARCIN_V6_INTROFFSET_2);
+	inb (state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+	inb (state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
 }
 
 /* Prototype: icside_irqprobe(struct expansion_card *ec)
@@ -144,10 +164,10 @@
  */
 static int icside_irqpending_arcin_v6(struct expansion_card *ec)
 {
-	unsigned int ide_base_port = (unsigned int)ec->irq_data;
+	struct icside_state *state = ec->irq_data;
 
-	return inb(ide_base_port + ICS_ARCIN_V6_INTRSTAT_1) & 1 ||
-	       inb(ide_base_port + ICS_ARCIN_V6_INTRSTAT_2) & 1;
+	return inb(state->irq_port + ICS_ARCIN_V6_INTRSTAT_1) & 1 ||
+	       inb(state->irq_port + ICS_ARCIN_V6_INTRSTAT_2) & 1;
 }
 
 static const expansioncard_ops_t icside_ops_arcin_v6 = {
@@ -210,6 +230,39 @@
 	return iftype;
 }
 
+/*
+ * Handle routing of interrupts.  This is called before
+ * we write the command to the drive.
+ */
+static void icside_maskproc(struct ata_device *drive, int mask)
+{
+	struct ata_channel *ch = drive->channel;
+	struct icside_state *state = ch->hw.priv;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	state->channel = ch->unit;
+
+	if (state->enabled && !mask) {
+		switch (ch->unit) {
+		case 0:
+			outb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+			inb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+			break;
+		case 1:
+			outb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+			inb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+			break;
+		}
+	} else {
+		inb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+		inb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+	}
+
+	local_irq_restore(flags);
+}
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_ICS
 /*
  * SG-DMA support.
@@ -223,32 +276,42 @@
 #define NR_ENTRIES 256
 #define TABLE_SIZE (NR_ENTRIES * 8)
 
-static int ide_build_sglist(struct ata_channel *hwif, struct request *rq)
+static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
-	struct scatterlist *sg = hwif->sg_table;
-	int nents = blk_rq_map_sg(q, rq, sg);
-
-	if (rq->q && nents > rq->nr_phys_segments)
-		printk("icside: received %d segments, build %d\n",
-			rq->nr_phys_segments, nents);
+	struct scatterlist *sg = ch->sg_table;
+	int nents;
 
-	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	else
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+	if (rq->flags & REQ_DRIVE_ACB) {
+		struct ata_taskfile *args = rq->special;
 
-	return pci_map_sg(NULL, sg, nents, hwif->sg_dma_direction);
-}
+		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+			ch->sg_dma_direction = PCI_DMA_TODEVICE;
+		else
+			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
+		memset(sg, 0, sizeof(*sg));
+		sg->page   = virt_to_page(rq->buffer);
+		sg->offset = ((unsigned long)rq->buffer) & ~PAGE_MASK;
+		sg->length = rq->nr_sectors * SECTOR_SIZE;
+		nents = 1;
+	} else {
+		nents = blk_rq_map_sg(rq->q, rq, sg);
+
+		if (rq->q && nents > rq->nr_phys_segments)
+			printk("icside: received %d segments, build %d\n",
+				rq->nr_phys_segments, nents);
+
+		if (rq_data_dir(rq) == READ)
+			ch->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		else
+			ch->sg_dma_direction = PCI_DMA_TODEVICE;
+	}
 
-static int
-icside_udma_new_table(struct ata_channel *ch, struct request *rq)
-{
-	return ch->sg_nents = ide_build_sglist(ch, rq);
+	return pci_map_sg(NULL, sg, nents, ch->sg_dma_direction);
 }
 
 /* Teardown mappings after DMA has completed.  */
-static void icside_destroy_dmatable(ide_drive_t *drive)
+static void icside_destroy_dmatable(struct ata_device *drive)
 {
 	struct scatterlist *sg = drive->channel->sg_table;
 	int nents = drive->channel->sg_nents;
@@ -282,10 +345,9 @@
  *	MW2	70	25	25	120	C
  */
 static int
-icside_config_if(ide_drive_t *drive, int xfer_mode)
+icside_config_if(struct ata_device *drive, int xfer_mode)
 {
-	int func = ide_dma_off;
-	int cycle_time = 0, use_dma_info = 0;
+	int on = 0, cycle_time = 0, use_dma_info = 0;
 
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2: cycle_time = 250; use_dma_info = 1;	break;
@@ -306,7 +368,7 @@
 		drive->init_speed = xfer_mode;
 
 	if (cycle_time && ide_config_drive_speed(drive, xfer_mode) == 0)
-		func = ide_dma_on;
+		on = 1;
 	else
 		drive->drive_data = 480;
 
@@ -315,50 +377,45 @@
 
 	drive->current_speed = xfer_mode;
 
-	return func;
+	return on;
 }
 
-static int
-icside_set_speed(ide_drive_t *drive, byte speed)
+static int icside_set_speed(struct ata_device *drive, byte speed)
 {
 	return icside_config_if(drive, speed);
 }
 
-/*
- * dma_intr() is the handler for disk read/write DMA interrupts
- */
-static ide_startstop_t icside_dmaintr(struct ata_device *drive, struct request *rq)
+static void icside_dma_enable(struct ata_device *drive, int on, int verbose)
 {
-	int i;
-	byte stat, dma_stat;
-
-	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
-	stat = GET_STAT();			/* get drive status */
-	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
-		if (!dma_stat) {
-			for (i = rq->nr_sectors; i > 0;) {
-				i -= rq->current_nr_sectors;
-				ide_end_request(drive, 1);
-			}
-			return ide_stopped;
-		}
-		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
-		       drive->name, dma_stat);
+	if (!on) {
+		if (verbose)
+			printk("%s: DMA disabled\n", drive->name);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		udma_tcq_enable(drive, 0);
+#endif
 	}
-	return ide_error(drive, "dma_intr", stat);
-}
+	
+	/*
+	 * We don't need any bouncing.  Yes, this looks the
+	 * wrong way around, but it is correct.
+	 */
+	blk_queue_bounce_limit(&drive->queue, BLK_BOUNCE_ANY);
+	drive->using_dma = on;
 
+#ifdef CONFIG_CLK_DEV_IDE_TCQ_DEFAULT
+	if (on)
+		udma_tcq_enable(drive, 1);
+#endif
+}
 
-static int
-icside_dma_check(struct ata_device *drive, struct request *rq)
+static int icside_dma_check(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
-	struct ata_channel *hwif = drive->channel;
-	int autodma = hwif->autodma;
+	struct ata_channel *ch = drive->channel;
 	int xfer_mode = XFER_PIO_2;
-	int func = ide_dma_off_quietly;
+	int on;
 
-	if (!id || !(id->capability & 1) || !autodma)
+	if (!id || !(id->capability & 1) || !ch->autodma)
 		goto out;
 
 	/*
@@ -367,188 +424,284 @@
 	if (id->field_valid & 2) {
 		if (id->dma_mword & 4) {
 			xfer_mode = XFER_MW_DMA_2;
-			func = ide_dma_on;
 		} else if (id->dma_mword & 2) {
 			xfer_mode = XFER_MW_DMA_1;
-			func = ide_dma_on;
 		} else if (id->dma_mword & 1) {
 			xfer_mode = XFER_MW_DMA_0;
-			func = ide_dma_on;
 		}
-		goto out;
 	}
 
 out:
-	func = icside_config_if(drive, xfer_mode);
+	on = icside_config_if(drive, xfer_mode);
+
+	icside_dma_enable(drive, on, 0);
+
+	return 0;
+}
+
+static int icside_dma_stop(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+
+	drive->waiting_for_dma = 0;
+	disable_dma(ch->hw.dma);
+	icside_destroy_dmatable(drive);
+
+	return get_dma_residue(ch->hw.dma) != 0;
+}
+
+static int icside_dma_start(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	/*
+	 * We can not enable DMA on both channels.
+	 */
+	BUG_ON(dma_channel_active(ch->hw.dma));
+
+	enable_dma(ch->hw.dma);
+
+	return 0;
+}
+
+/*
+ * dma_intr() is the handler for disk read/write DMA interrupts
+ */
+static ide_startstop_t icside_dmaintr(struct ata_device *drive, struct request *rq)
+{
+	int dma_stat;
+	byte stat;
+
+	dma_stat = icside_dma_stop(drive);
 
-	return hwif->udma(func, drive, rq);
+	stat = GET_STAT();			/* get drive status */
+	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+		if (!dma_stat) {
+			__ide_end_request(drive, rq, 1, rq->nr_sectors);
+			return ide_stopped;
+		}
+		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
+		       drive->name, dma_stat);
+	}
+	return ide_error(drive, rq, "dma_intr", stat);
 }
 
 static int
-icside_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+icside_dma_common(struct ata_device *drive, struct request *rq,
+		  unsigned int dma_mode)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned int count;
+
+	/*
+	 * We can not enable DMA on both channels.
+	 */
+	BUG_ON(dma_channel_active(ch->hw.dma));
+
+	count = ch->sg_nents = ide_build_sglist(ch, rq);
+	if (!count)
+		return 1;
+
+	/*
+	 * Route the DMA signals to to this channel.
+	 */
+	outb(ch->select_data, ch->config_data);
+
+	/*
+	 * Select the correct timing for this drive.
+	 */
+	set_dma_speed(ch->hw.dma, drive->drive_data);
+
+	/*
+	 * Tell the DMA engine about the SG table and
+	 * data direction.
+	 */
+	set_dma_sg(ch->hw.dma, ch->sg_table, count);
+	set_dma_mode(ch->hw.dma, dma_mode);
+
+	drive->waiting_for_dma = 1;
+
+	return 0;
+}
+
+static int icside_dma_read(struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
-	int count, reading = 0;
+	struct ata_channel *ch = drive->channel;
+	unsigned int cmd;
 
-	switch (func) {
-	case ide_dma_off:
-		printk("%s: DMA disabled\n", drive->name);
-		/*FALLTHROUGH*/
-
-	case ide_dma_off_quietly:
-	case ide_dma_on:
-		/*
-		 * We don't need any bouncing.  Yes, this looks the
-		 * wrong way around, but it is correct.
-		 */
-		blk_queue_bounce_limit(&drive->queue, BLK_BOUNCE_ANY);
-		drive->using_dma = (func == ide_dma_on);
+	if (icside_dma_common(drive, rq, DMA_MODE_READ))
+		return 1;
+
+	if (drive->type != ATA_DISK)
 		return 0;
 
-	case ide_dma_check:
-		return icside_dma_check(drive, rq);
+	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
+
+	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
+		struct ata_taskfile *args = rq->special;
+		cmd = args->taskfile.command;
+	} else if (drive->addressing) {
+		cmd = WIN_READDMA_EXT;
+	} else {
+		cmd = WIN_READDMA;
+	}
 
-	case ide_dma_read:
-		reading = 1;
-	case ide_dma_write:
-		count = icside_udma_new_table(hwif, rq);
-		if (!count)
-			return 1;
-		disable_dma(hwif->hw.dma);
-
-		/* Route the DMA signals to
-		 * to the correct interface.
-		 */
-		outb(hwif->select_data, hwif->config_data);
-
-		/* Select the correct timing
-		 * for this drive
-		 */
-		set_dma_speed(hwif->hw.dma, drive->drive_data);
-
-		set_dma_sg(hwif->hw.dma, drive->channel->sg_table, count);
-		set_dma_mode(hwif->hw.dma, reading ? DMA_MODE_READ
-			     : DMA_MODE_WRITE);
-
-		drive->waiting_for_dma = 1;
-		if (drive->type != ATA_DISK)
-			return 0;
-
-		ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
-		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA,
-			 IDE_COMMAND_REG);
+	OUT_BYTE(cmd, IDE_COMMAND_REG);
+	enable_dma(ch->hw.dma);
+	return 0;
+}
 
-	case ide_dma_begin:
-		enable_dma(hwif->hw.dma);
+static int icside_dma_write(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned int cmd;
+
+	if (icside_dma_common(drive, rq, DMA_MODE_WRITE))
+		return 1;
+
+	if (drive->type != ATA_DISK)
 		return 0;
 
-	case ide_dma_end:
-		drive->waiting_for_dma = 0;
-		disable_dma(hwif->hw.dma);
-		icside_destroy_dmatable(drive);
-		return get_dma_residue(hwif->hw.dma) != 0;
-
-	case ide_dma_test_irq:
-		return inb((unsigned long)hwif->hw.priv) & 1;
-
-	case ide_dma_timeout:
-	default:
-		printk("icside_dmaproc: unsupported function: %d\n", func);
+	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
+
+	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
+		struct ata_taskfile *args = rq->special;
+		cmd = args->taskfile.command;
+	} else if (drive->addressing) {
+		cmd = WIN_WRITEDMA_EXT;
+	} else {
+		cmd = WIN_WRITEDMA;
 	}
-	return 1;
+	OUT_BYTE(cmd, IDE_COMMAND_REG);
+
+	enable_dma(ch->hw.dma);
+	return 0;
 }
 
-static int
-icside_setup_dma(struct ata_channel *hwif, int autodma)
+static int icside_irq_status(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	struct icside_state *state = ch->hw.priv;
+
+	return inb(state->irq_port +
+		   (ch->unit ?
+			ICS_ARCIN_V6_INTRSTAT_2 :
+			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
+}
+
+static void icside_dma_timeout(struct ata_device *drive)
+{
+	printk(KERN_ERR "ATA: %s: UDMA timeout occured:", drive->name);
+	ide_dump_status(drive, NULL, "UDMA timeout", GET_STAT());
+}
+
+static void icside_irq_lost(struct ata_device *drive)
 {
-	printk("    %s: SG-DMA", hwif->name);
+	printk(KERN_ERR "ATA: %s: IRQ lost\n", drive->name);
+}
 
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * NR_ENTRIES,
+static int icside_setup_dma(struct ata_channel *ch)
+{
+	int autodma = 0;
+
+#ifdef CONFIG_IDEDMA_ICS_AUTO
+	autodma = 1;
+#endif
+
+	printk("    %s: SG-DMA", ch->name);
+
+	ch->sg_table = kmalloc(sizeof(struct scatterlist) * NR_ENTRIES,
 				 GFP_KERNEL);
-	if (!hwif->sg_table)
+	if (!ch->sg_table)
 		goto failed;
 
-	hwif->dmatable_cpu = NULL;
-	hwif->dmatable_dma = 0;
-	hwif->speedproc = icside_set_speed;
-	hwif->dmaproc = icside_dmaproc;
-	hwif->autodma = autodma;
+	ch->dmatable_cpu    = NULL;
+	ch->dmatable_dma    = 0;
+	ch->speedproc       = icside_set_speed;
+	ch->XXX_udma        = icside_dma_check;
+	ch->udma_enable     = icside_dma_enable;
+	ch->udma_start      = icside_dma_start;
+	ch->udma_stop       = icside_dma_stop;
+	ch->udma_read       = icside_dma_read;
+	ch->udma_write      = icside_dma_write;
+	ch->udma_irq_status = icside_irq_status;
+	ch->udma_timeout    = icside_dma_timeout;
+	ch->udma_irq_lost   = icside_irq_lost;
+	ch->autodma         = autodma;
 
-	printk(" capable%s\n", autodma ?
-		", auto-enable" : "");
+	printk(" capable%s\n", autodma ? ", auto-enable" : "");
 
 	return 1;
 
 failed:
-	printk(" -- ERROR, unable to allocate DMA table\n");
+	printk(" disabled, unable to allocate DMA table\n");
 	return 0;
 }
 
-void ide_release_dma(struct ata_channel *hwif)
+void ide_release_dma(struct ata_channel *ch)
 {
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
+	if (ch->sg_table) {
+		kfree(ch->sg_table);
+		ch->sg_table = NULL;
 	}
 }
 #endif
 
-static struct ata_channel *
-icside_find_hwif(unsigned long dataport)
+static struct ata_channel *icside_find_hwif(unsigned long dataport)
 {
-	struct ata_channel *hwif;
+	struct ata_channel *ch;
 	int index;
 
 	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == (ide_ioreg_t)dataport)
+		ch = &ide_hwifs[index];
+		if (ch->io_ports[IDE_DATA_OFFSET] == (ide_ioreg_t)dataport)
 			goto found;
 	}
 
 	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
-		if (!hwif->io_ports[IDE_DATA_OFFSET])
+		ch = &ide_hwifs[index];
+		if (!ch->io_ports[IDE_DATA_OFFSET])
 			goto found;
 	}
 
 	return NULL;
 found:
-	return hwif;
+	return ch;
 }
 
 static struct ata_channel *
 icside_setup(unsigned long base, struct cardinfo *info, int irq)
 {
 	unsigned long port = base + info->dataoffset;
-	struct ata_channel *hwif;
+	struct ata_channel *ch;
 
-	hwif = icside_find_hwif(base);
-	if (hwif) {
+	ch = icside_find_hwif(base);
+	if (ch) {
 		int i;
 
-		memset(&hwif->hw, 0, sizeof(hw_regs_t));
+		memset(&ch->hw, 0, sizeof(hw_regs_t));
 
 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-			hwif->hw.io_ports[i] = (ide_ioreg_t)port;
-			hwif->io_ports[i] = (ide_ioreg_t)port;
+			ch->hw.io_ports[i] = (ide_ioreg_t)port;
+			ch->io_ports[i] = (ide_ioreg_t)port;
 			port += 1 << info->stepping;
 		}
-		hwif->hw.io_ports[IDE_CONTROL_OFFSET] = base + info->ctrloffset;
-		hwif->io_ports[IDE_CONTROL_OFFSET] = base + info->ctrloffset;
-		hwif->hw.irq  = irq;
-		hwif->irq     = irq;
-		hwif->hw.dma  = NO_DMA;
-		hwif->noprobe = 0;
-		hwif->chipset = ide_acorn;
+		ch->hw.io_ports[IDE_CONTROL_OFFSET] = base + info->ctrloffset;
+		ch->io_ports[IDE_CONTROL_OFFSET] = base + info->ctrloffset;
+		ch->hw.irq  = irq;
+		ch->irq     = irq;
+		ch->hw.dma  = NO_DMA;
+		ch->noprobe = 0;
+		ch->chipset = ide_acorn;
 	}
 
-	return hwif;
+	return ch;
 }
 
-static int __init icside_register_v5(struct expansion_card *ec, int autodma)
+static int __init icside_register_v5(struct expansion_card *ec)
 {
 	unsigned long slot_port;
-	struct ata_channel *hwif;
+	struct ata_channel *ch;
 
 	slot_port = ecard_address(ec, ECARD_MEMC, 0);
 
@@ -562,17 +715,17 @@
 	 */
 	inb(slot_port + ICS_ARCIN_V5_INTROFFSET);
 
-	hwif = icside_setup(slot_port, &icside_cardinfo_v5, ec->irq);
+	ch = icside_setup(slot_port, &icside_cardinfo_v5, ec->irq);
 
-	return hwif ? 0 : -1;
+	return ch ? 0 : -1;
 }
 
-static int __init icside_register_v6(struct expansion_card *ec, int autodma)
+static int __init icside_register_v6(struct expansion_card *ec)
 {
 	unsigned long slot_port, port;
-	struct ata_channel *hwif;
-	struct ata_channel *mate;
-	int sel = 0;
+	struct icside_state *state;
+	struct ata_channel *ch0, *ch1;
+	unsigned int sel = 0;
 
 	slot_port = ecard_address(ec, ECARD_IOC, ECARD_FAST);
 	port      = ecard_address(ec, ECARD_EASI, ECARD_FAST);
@@ -584,55 +737,57 @@
 
 	outb(sel, slot_port);
 
-	ec->irq_data = (void *)port;
-	ec->ops      = (expansioncard_ops_t *)&icside_ops_arcin_v6;
-
 	/*
 	 * Be on the safe side - disable interrupts
 	 */
 	inb(port + ICS_ARCIN_V6_INTROFFSET_1);
 	inb(port + ICS_ARCIN_V6_INTROFFSET_2);
 
-	hwif = icside_setup(port, &icside_cardinfo_v6_1, ec->irq);
-	mate = icside_setup(port, &icside_cardinfo_v6_2, ec->irq);
+	/*
+	 * Find and register the interfaces.
+	 */
+	ch0 = icside_setup(port, &icside_cardinfo_v6_1, ec->irq);
+	ch1 = icside_setup(port, &icside_cardinfo_v6_2, ec->irq);
+
+	if (!ch0 || !ch1)
+		return -ENODEV;
+
+	state = kmalloc(sizeof(struct icside_state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->channel    = 0;
+	state->enabled    = 0;
+	state->irq_port   = port;
+
+	ec->irq_data      = state;
+	ec->ops           = (expansioncard_ops_t *)&icside_ops_arcin_v6;
+
+	ch0->maskproc     = icside_maskproc;
+	ch0->unit         = 0;
+	ch0->hw.priv      = state;
+	ch0->config_data  = slot_port;
+	ch0->select_data  = sel;
+	ch0->hw.dma       = ec->dma;
+
+	ch1->maskproc     = icside_maskproc;
+	ch1->unit         = 1;
+	ch1->hw.priv      = state;
+	ch1->config_data  = slot_port;
+	ch1->select_data  = sel | 1;
+	ch1->hw.dma       = ec->dma;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_ICS
-	if (ec->dma != NO_DMA) {
-		if (request_dma(ec->dma, hwif->name))
-			goto no_dma;
-
-		if (hwif) {
-			hwif->config_data = slot_port;
-			hwif->select_data = sel;
-			hwif->hw.dma  = ec->dma;
-			hwif->hw.priv = (void *)
-					(port + ICS_ARCIN_V6_INTRSTAT_1);
-			hwif->unit = 0;
-			icside_setup_dma(hwif, autodma);
-		}
-		if (mate) {
-			mate->config_data = slot_port;
-			mate->select_data = sel | 1;
-			mate->hw.dma  = ec->dma;
-			mate->hw.priv = (void *)
-					(port + ICS_ARCIN_V6_INTRSTAT_2);
-			mate->unit = 1;
-			icside_setup_dma(mate, autodma);
-		}
+	if (ec->dma != NO_DMA && !request_dma(ec->dma, ch0->name)) {
+		icside_setup_dma(ch0);
+		icside_setup_dma(ch1);
 	}
-no_dma:
 #endif
-	return hwif || mate ? 0 : -1;
+	return 0;
 }
 
 int __init icside_init(void)
 {
-	int autodma = 0;
-
-#ifdef CONFIG_IDEDMA_ICS_AUTO
-	autodma = 1;
-#endif
-
 	ecard_startfind ();
 
 	do {
@@ -647,11 +802,11 @@
 
 		switch (icside_identifyif(ec)) {
 		case ics_if_arcin_v5:
-			result = icside_register_v5(ec, autodma);
+			result = icside_register_v5(ec);
 			break;
 
 		case ics_if_arcin_v6:
-			result = icside_register_v6(ec, autodma);
+			result = icside_register_v6(ec);
 			break;
 
 		default:
diff -urN linux-2.5.17/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.17/drivers/ide/ide.c	2002-05-22 20:11:43.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-22 17:06:50.000000000 +0200
@@ -139,34 +139,6 @@
  */
 struct ata_channel ide_hwifs[MAX_HWIFS];	/* master data repository */
 
-#if (DISK_RECOVERY_TIME > 0)
-/*
- * For really screwed hardware (hey, at least it *can* be used with Linux)
- * we can enforce a minimum delay time between successive operations.
- */
-static unsigned long read_timer (void)
-{
-	unsigned long t, flags;
-	int i;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-	t = jiffies * 11932;
-	outb_p(0, 0x43);
-	i = inb_p(0x40);
-	i |= inb(0x40) << 8;
-	__restore_flags(flags);	/* local CPU only */
-	return (t - i);
-}
-#endif
-
-static inline void set_recovery_timer(struct ata_channel *channel)
-{
-#if (DISK_RECOVERY_TIME > 0)
-	channel->last_time = read_timer();
-#endif
-}
-
 static void init_hwif_data(struct ata_channel *ch, unsigned int index)
 {
 	static const byte ide_major[] = {
@@ -241,8 +213,6 @@
 
 	/* Add default hw interfaces */
 	ide_init_default_hwifs();
-
-	idebus_parameter = 0;
 }
 
 /*
@@ -667,6 +637,50 @@
 	end_that_request_last(rq);
 }
 
+#if FANCY_STATUS_DUMPS
+struct ata_bit_messages {
+	u8 mask;
+	u8 match;
+	const char *msg;
+};
+
+static struct ata_bit_messages ata_status_msgs[] = {
+	{ BUSY_STAT,  BUSY_STAT,  "Busy"           },
+	{ READY_STAT, READY_STAT, "DriveReady"     },
+	{ WRERR_STAT, WRERR_STAT, "DeviceFault"    },
+	{ SEEK_STAT,  SEEK_STAT,  "SeekComplete"   },
+	{ DRQ_STAT,   DRQ_STAT,   "DataRequest"    },
+	{ ECC_STAT,   ECC_STAT,   "CorrectedError" },
+	{ INDEX_STAT, INDEX_STAT, "Index"          },
+	{ ERR_STAT,   ERR_STAT,   "Error"          }
+};
+
+static struct ata_bit_messages ata_error_msgs[] = {
+	{ ICRC_ERR|ABRT_ERR,	ABRT_ERR,		"DriveStatusError"   },
+	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"BadSector"	     },
+	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR|ABRT_ERR,	"BadCRC"	     },
+	{ ECC_ERR,		ECC_ERR,		"UncorrectableError" },
+	{ ID_ERR,		ID_ERR,			"SectorIdNotFound"   },
+	{ TRK0_ERR,		TRK0_ERR,		"TrackZeroNotFound"  },
+	{ MARK_ERR,		MARK_ERR,		"AddrMarkNotFound"   }
+};
+
+static void ata_dump_bits(struct ata_bit_messages *msgs, int nr, byte bits)
+{
+	int i;
+
+	printk(" { ");
+
+	for (i = 0; i < nr; i++, msgs++)
+		if ((bits & msgs->mask) == msgs->match)
+			printk("%s ", msgs->msg);
+
+	printk("} ");
+}
+#else
+#define ata_dump_bits(msgs,nr,bits) do { } while (0)
+#endif
+
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
@@ -674,49 +688,22 @@
 {
 	unsigned long flags;
 	byte err = 0;
+	int i;
 
 	__save_flags (flags);	/* local CPU only */
 	ide__sti();		/* local CPU only */
-#if !(FANCY_STATUS_DUMPS)
-	printk("%s: %s: status=0x%02x\n", drive->name, msg, stat);
-#else
-	printk(" { ");
-	{
-		char *msg = "";
-		if (stat & BUSY_STAT)
-			msg = "Busy";
-		else {
-			if (stat & READY_STAT)
-				msg = "DriveReady";
-			if (stat & WRERR_STAT)
-				msg = "DeviceFault";
-			if (stat & SEEK_STAT)
-				msg = "SeekComplete";
-			if (stat & DRQ_STAT)
-				msg = "DataRequest";
-			if (stat & ECC_STAT)
-				msg = "CorrectedError";
-			if (stat & INDEX_STAT)
-				msg = "Index";
-			if (stat & ERR_STAT)
-				msg = "Error";
-		}
-	}
-	printk("%s }\n", msg);
-#endif
+
+	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
+	ata_dump_bits(ata_status_msgs, ARRAY_SIZE(ata_status_msgs), stat);
+	printk("\n");
+
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = GET_ERR();
 		printk("%s: %s: error=0x%02x", drive->name, msg, err);
 #if FANCY_STATUS_DUMPS
 		if (drive->type == ATA_DISK) {
-			printk(" { ");
-			if (err & ABRT_ERR)	printk("DriveStatusError ");
-			if (err & ICRC_ERR)	printk("%s", (err & ABRT_ERR) ? "BadCRC " : "BadSector ");
-			if (err & ECC_ERR)	printk("UncorrectableError ");
-			if (err & ID_ERR)	printk("SectorIdNotFound ");
-			if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-			if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-			printk("}");
+			ata_dump_bits(ata_error_msgs, ARRAY_SIZE(ata_error_msgs), err);
+
 			if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
 				if ((drive->id->command_set_2 & 0x0400) &&
 				    (drive->id->cfs_enable_2 & 0x0400) &&
@@ -988,11 +975,6 @@
 	 */
 	if (block == 0 && drive->remap_0_to_1 == 1)
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
-
-#if (DISK_RECOVERY_TIME > 0)
-	while ((read_timer() - ch->last_time) < DISK_RECOVERY_TIME);
-#endif
-
 	{
 		ide_startstop_t res;
 
@@ -1464,7 +1446,6 @@
 				} else
 					startstop = ide_error(drive, drive->rq, "irq timeout", GET_STAT());
 			}
-			set_recovery_timer(ch);
 			enable_irq(ch->irq);
 
 			spin_lock_irq(ch->lock);
@@ -1614,7 +1595,6 @@
 	 * same irq as is currently being serviced here, and Linux
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
-	set_recovery_timer(drive->channel);
 	if (startstop == ide_stopped) {
 		if (!ch->handler) {	/* paranoia */
 			clear_bit(IDE_BUSY, ch->active);
@@ -2787,10 +2767,7 @@
 	if (!strncmp(s, "idebus", 6)) {
 		if (match_parm(&s[6], NULL, vals, 1) != 1)
 			goto bad_option;
-		if (vals[0] >= 20 && vals[0] <= 66) {
-			idebus_parameter = vals[0];
-		} else
-			printk(" -- BAD BUS SPEED! Expected value from 20 to 66");
+		idebus_parameter = vals[0];
 		goto done;
 	}
 
@@ -3219,27 +3196,40 @@
 
 	ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
 
-	/* Initialize system bus speed.
-	 *
-	 * This can be changed by a particular chipse initialization module.
-	 * Otherwise we assume 33MHz as a safe value for PCI bus based systems.
-	 * 50MHz will be assumed for abolitions like VESA, since higher values
-	 * result in more conservative timing setups.
-	 *
-	 * The kernel parameter idebus=XX overrides the default settings.
-	 */
+/*
+ * Because most of the ATA adapters represent the timings in unit of bus
+ * clocks, and there is no known reliable way to detect the bus clock
+ * frequency, we assume 50 MHz for non-PCI (VLB, EISA) and 33 MHz for PCI based
+ * systems. Since assuming only hurts performance and not stability, this is
+ * OK. The user can change this on the command line by using the "idebus=XX"
+ * parameter. While the system_bus_speed variable is in kHz units, we accept
+ * both MHz and kHz entry on the command line for backward compatibility.
+ */
 
-	system_bus_speed = 50;
-	if (idebus_parameter)
-	    system_bus_speed = idebus_parameter;
-#ifdef CONFIG_PCI
-	else if (pci_present())
-	    system_bus_speed = 33;
-#endif
+	system_bus_speed = 50000;
 
-	printk(KERN_INFO "ATA: system bus speed %dMHz\n", system_bus_speed);
+	if (pci_present())
+	    system_bus_speed = 33333;
 
-	init_ide_data ();
+	if (idebus_parameter >= 20 && idebus_parameter <= 80) {
+
+		system_bus_speed = idebus_parameter * 1000;
+
+		switch (system_bus_speed) {
+			case 33000: system_bus_speed = 33333; break;
+			case 37000: system_bus_speed = 37500; break;
+			case 41000: system_bus_speed = 41666; break;
+			case 66000: system_bus_speed = 66666; break;
+		}
+	}
+
+	if (idebus_parameter >= 20000 && idebus_parameter <= 80000)
+	    system_bus_speed = idebus_parameter;
+	
+	printk(KERN_INFO "ATA: %s bus speed %d.%dMHz\n",
+		pci_present() ? "PCI" : "System", system_bus_speed / 1000, system_bus_speed / 100 % 10);
+
+	init_ide_data();
 
 	initializing = 1;
 
diff -urN linux-2.5.17/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.17/drivers/ide/opti621.c	2002-05-21 07:07:32.000000000 +0200
+++ linux/drivers/ide/opti621.c	2002-05-22 13:21:11.000000000 +0200
@@ -175,7 +175,7 @@
  * Use idebus=xx to select right frequency.
  */
 {
-	return ((time*bus_speed+999)/1000);
+	return ((time*bus_speed+999999)/1000000);
 }
 
 static void write_reg(byte value, int reg)
diff -urN linux-2.5.17/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.17/drivers/ide/pcidma.c	2002-05-21 07:07:33.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-05-22 17:06:50.000000000 +0200
@@ -258,7 +258,7 @@
  * recovery" in the ATAPI drivers. This was just plain wrong before, in esp.
  * not portable, and just got uncovered now.
  */
-static void udma_pci_enable(struct ata_device *drive, int on, int verbose)
+void udma_pci_enable(struct ata_device *drive, int on, int verbose)
 {
 	struct ata_channel *ch = drive->channel;
 	int set_high = 1;
@@ -396,7 +396,7 @@
  * about addressing modes.
  */
 
-static int udma_pci_start(struct ata_device *drive, struct request *rq)
+int udma_pci_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
@@ -410,7 +410,7 @@
 	return 0;
 }
 
-static int udma_pci_stop(struct ata_device *drive)
+int udma_pci_stop(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
@@ -425,12 +425,12 @@
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 }
 
-static int udma_pci_read(struct ata_device *drive, struct request *rq)
+int udma_pci_read(struct ata_device *drive, struct request *rq)
 {
 	return ata_do_udma(1, drive, rq);
 }
 
-static int udma_pci_write(struct ata_device *drive, struct request *rq)
+int udma_pci_write(struct ata_device *drive, struct request *rq)
 {
 	return ata_do_udma(0, drive, rq);
 }
@@ -438,7 +438,7 @@
 /*
  * FIXME: This should be attached to a channel as we can see now!
  */
-static int udma_pci_irq_status(struct ata_device *drive)
+int udma_pci_irq_status(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	u8 dma_stat;
@@ -449,12 +449,12 @@
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static void udma_pci_timeout(struct ata_device *drive)
+void udma_pci_timeout(struct ata_device *drive)
 {
 	printk(KERN_ERR "ATA: UDMA timeout occured %s!\n", drive->name);
 }
 
-static void udma_pci_irq_lost(struct ata_device *drive)
+void udma_pci_irq_lost(struct ata_device *drive)
 {
 }
 
@@ -553,3 +553,11 @@
 
 EXPORT_SYMBOL(ata_do_udma);
 EXPORT_SYMBOL(ide_dma_intr);
+EXPORT_SYMBOL(udma_pci_enable);
+EXPORT_SYMBOL(udma_pci_start);
+EXPORT_SYMBOL(udma_pci_stop);
+EXPORT_SYMBOL(udma_pci_read);
+EXPORT_SYMBOL(udma_pci_write);
+EXPORT_SYMBOL(udma_pci_irq_status);
+EXPORT_SYMBOL(udma_pci_timeout);
+EXPORT_SYMBOL(udma_pci_irq_lost);
diff -urN linux-2.5.17/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.17/drivers/ide/pdc202xx.c	2002-05-21 07:07:42.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-22 11:47:10.000000000 +0200
@@ -166,10 +166,12 @@
 
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 
-int check_in_drive_lists(struct ata_device *drive) {
-	const char *pdc_quirk_drives[] = {
+int check_in_drive_lists(struct ata_device *drive)
+{
+	static const char *pdc_quirk_drives[] = {
 		"QUANTUM FIREBALLlct08 08",
 		"QUANTUM FIREBALLP KA6.4",
+		"QUANTUM FIREBALLP KA9.1",
 		"QUANTUM FIREBALLP LM20.4",
 		"QUANTUM FIREBALLP KX20.5",
 		"QUANTUM FIREBALLP KX27.3",
diff -urN linux-2.5.17/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.17/drivers/ide/piix.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-05-22 13:21:11.000000000 +0200
@@ -105,7 +105,6 @@
 static struct piix_ide_chip *piix_config;
 static unsigned char piix_enabled;
 static unsigned int piix_80w;
-static unsigned int piix_clock;
 
 static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
@@ -147,7 +146,7 @@
 								: piix_dma[piix_config->flags & PIIX_UDMA]);
 
 	piix_print("BM-DMA base:                        %#x", piix_base);
-	piix_print("PCI clock:                          %d.%dMHz", piix_clock / 1000, piix_clock / 100 % 10);
+	piix_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 
 	piix_print("-----------------------Primary IDE-------Secondary IDE------");
 
@@ -160,7 +159,7 @@
 
 	piix_print("Cable Type:            %10s%20s", (piix_80w & 1) ? "80w" : "40w", (piix_80w & 2) ? "80w" : "40w");
 
-	if (!piix_clock)
+	if (!system_bus_speed)
                 return p - buffer;
 
 	piix_print("-------------------drive0----drive1----drive2----drive3-----");
@@ -192,8 +191,8 @@
 		}
 
 		dmaen[i] = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
-		cycle[i] = 1000000 / piix_clock * (active[i] + recover[i]);
-		speed[i] = 2 * piix_clock / (active[i] + recover[i]);
+		cycle[i] = 1000000 / system_bus_speed * (active[i] + recover[i]);
+		speed[i] = 2 * system_bus_speed / (active[i] + recover[i]);
 
 		if (!(piix_config->flags & PIIX_UDMA))
 			continue;
@@ -213,17 +212,17 @@
 			udma[i] = (4 - ((e >> (i << 2)) & 3)) * umul;
 		} else  udma[i] = (8 - ((e >> (i << 2)) & 7)) * 2;
 
-		speed[i] = 8 * piix_clock / udma[i];
-		cycle[i] = 250000 * udma[i] / piix_clock;
+		speed[i] = 8 * system_bus_speed / udma[i];
+		cycle[i] = 250000 * udma[i] / system_bus_speed;
 	}
 
 	piix_print_drive("Transfer Mode: ", "%10s", dmaen[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	piix_print_drive("Address Setup: ", "%8dns", (1000000 / piix_clock) * 3);
-	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / piix_clock) * 12);
-	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / piix_clock) * 18);
-	piix_print_drive("Data Active:   ", "%8dns", (1000000 / piix_clock) * active[i]);
-	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / piix_clock) * recover[i]);
+	piix_print_drive("Address Setup: ", "%8dns", (1000000 / system_bus_speed) * 3);
+	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / system_bus_speed) * 12);
+	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / system_bus_speed) * 18);
+	piix_print_drive("Data Active:   ", "%8dns", (1000000 / system_bus_speed) * active[i]);
+	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / system_bus_speed) * recover[i]);
 	piix_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	piix_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -339,7 +338,7 @@
 	if (speed > XFER_UDMA_4 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100)
 		umul = 4;
 	
-	T = 1000000000 / piix_clock;
+	T = 1000000000 / system_bus_speed;
 	UT = T / umul;
 
 	ata_timing_compute(drive, speed, &t, T, UT);
@@ -494,24 +493,6 @@
 	}
 
 /*
- * Determine the system bus clock.
- */
-
-	piix_clock = system_bus_speed * 1000;
-
-	switch (piix_clock) {
-		case 33000: piix_clock = 33333; break;
-		case 37000: piix_clock = 37500; break;
-		case 41000: piix_clock = 41666; break;
-	}
-
-	if (piix_clock < 20000 || piix_clock > 50000) {
-		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", piix_clock);
-		printk(KERN_WARNING "PIIX: Use ide0=ata66 if you want to assume 80-wire cable\n");
-		piix_clock = 33333;
-	}
-
-/*
  * Print the boot message.
  */
 
diff -urN linux-2.5.17/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.17/drivers/ide/qd65xx.c	2002-05-21 07:07:35.000000000 +0200
+++ linux/drivers/ide/qd65xx.c	2002-05-22 13:21:11.000000000 +0200
@@ -133,12 +133,12 @@
 {
 	byte active_cycle,recovery_cycle;
 
-	if (system_bus_speed <= 33) {
-		active_cycle =   9  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 9);
-		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 0, 15);
+	if (system_bus_speed <= 33333) {
+		active_cycle =   9  - IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 2, 9);
+		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 0, 15);
 	} else {
-		active_cycle =   8  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 1, 8);
-		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 3, 18);
+		active_cycle =   8  - IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 1, 8);
+		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 3, 18);
 	}
 
 	return((recovery_cycle<<4) | 0x08 | active_cycle);
@@ -152,8 +152,8 @@
 
 static byte qd6580_compute_timing (int active_time, int recovery_time)
 {
-	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 17);
-	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 2, 15);
+	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_speed / 1000000 + 1, 2, 17);
+	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_speed / 1000000 + 1, 2, 15);
 
 	return((recovery_cycle<<4) | active_cycle);
 }
diff -urN linux-2.5.17/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.17/drivers/ide/serverworks.c	2002-05-21 07:07:40.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-22 11:10:00.000000000 +0200
@@ -242,9 +242,9 @@
 
 static int svwks_tune_chipset(struct ata_device *drive, byte speed)
 {
-	byte udma_modes[]	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
-	byte dma_modes[]	= { 0x77, 0x21, 0x20 };
-	byte pio_modes[]	= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
+	static u8 udma_modes[]	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+	static u8 dma_modes[]	= { 0x77, 0x21, 0x20 };
+	static u8 pio_modes[]	= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
 
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -253,7 +253,7 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	unsigned long dma_base	= hwif->dma_base;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 	int err;
 
 	byte drive_pci		= 0x00;
diff -urN linux-2.5.17/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.17/drivers/ide/sl82c105.c	2002-05-21 07:07:35.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-05-22 17:09:02.000000000 +0200
@@ -5,8 +5,12 @@
  *
  * Maintainer unknown.
  *
- * Drive tuning added from Rebel.com's kernel sources
- *  -- Russell King (15/11/98) linux@arm.linux.org.uk
+ * Changelog:
+ *
+ * 15/11/1998	RMK	Drive tuning added from Rebel.com's kernel
+ *			sources
+ * 30/03/2002	RMK	Add fixes specified in W83C553F errata.
+ *			(with special thanks to Todd Inglett)
  */
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -28,6 +32,17 @@
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 /*
+ * SL82C105 PCI config register 0x40 bits.
+ */
+#define CTRL_IDE_IRQB	(1 << 30)
+#define CTRL_IDE_IRQA	(1 << 28)
+#define CTRL_LEGIRQ	(1 << 11)
+#define CTRL_P1F16	(1 << 5)
+#define CTRL_P1EN	(1 << 4)
+#define CTRL_P0F16	(1 << 1)
+#define	CTRL_P0EN	(1 << 0)
+
+/*
  * Convert a PIO mode and cycle time to the required on/off
  * times for the interface.  This has protection against run-away
  * timings.
@@ -111,6 +126,7 @@
 	return 0;
 }
 
+
 /*
  * Check to see if the drive and
  * chipset is capable of DMA mode
@@ -146,6 +162,7 @@
 			break;
 		}
 	} while (0);
+
 	if (on)
 		config_for_dma(drive);
 	else
@@ -153,12 +170,12 @@
 
 	udma_enable(drive, on, 0);
 
-
 	return 0;
 }
 
 /*
- * Our own dmaproc, only to intercept ide_dma_check
+ * Our very own dmaproc.  We need to intercept various calls
+ * to fix up the SL82C105 specific behaviour.
  */
 static int sl82c105_dmaproc(struct ata_device *drive)
 {
@@ -166,6 +183,93 @@
 }
 
 /*
+ * The SL82C105 holds off all IDE interrupts while in DMA mode until
+ * all DMA activity is completed.  Sometimes this causes problems (eg,
+ * when the drive wants to report an error condition).
+ *
+ * 0x7e is a "chip testing" register.  Bit 2 resets the DMA controller
+ * state machine.  We need to kick this to work around various bugs.
+ */
+static inline void sl82c105_reset_host(struct pci_dev *dev)
+{
+	u16 val;
+
+	pci_read_config_word(dev, 0x7e, &val);
+	pci_write_config_word(dev, 0x7e, val | (1 << 2));
+	pci_write_config_word(dev, 0x7e, val & ~(1 << 2));
+}
+
+static void sl82c105_dma_enable(struct ata_device *drive, int on, int verbose)
+{
+	if (!on || config_for_dma(drive)) {
+		config_for_pio(drive, 4, 0);
+		on = 0;
+	}
+	udma_pci_enable(drive, on, verbose);
+}
+
+/*
+ * ATAPI devices can cause the SL82C105 DMA state machine to go gaga.
+ * Winbond recommend that the DMA state machine is reset prior to
+ * setting the bus master DMA enable bit.
+ *
+ * The generic IDE core will have disabled the BMEN bit before this
+ * function is called.
+ */
+static int sl82c105_dma_read(struct ata_device *drive, struct request *rq)
+{
+	sl82c105_reset_host(drive->channel->pci_dev);
+	return udma_pci_read(drive, rq);
+}
+
+static int sl82c105_dma_write(struct ata_device *drive, struct request *rq)
+{
+	sl82c105_reset_host(drive->channel->pci_dev);
+	return udma_pci_write(drive, rq);
+}
+
+static void sl82c105_timeout(struct ata_device *drive)
+{
+	sl82c105_reset_host(drive->channel->pci_dev);
+}
+
+/*
+ * If we get an IRQ timeout, it might be that the DMA state machine
+ * got confused.  Fix from Todd Inglett.  Details from Winbond.
+ *
+ * This function is called when the IDE timer expires, the drive
+ * indicates that it is READY, and we were waiting for DMA to complete.
+ */
+static void sl82c105_lostirq(ide_drive_t *drive)
+{
+	struct ata_channel *ch = drive->channel;
+	struct pci_dev *dev = ch->pci_dev;
+	u32 val, mask = ch->unit ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
+	unsigned long dma_base = ch->dma_base;
+
+	printk("sl82c105: lost IRQ: resetting host\n");
+
+	/*
+	 * Check the raw interrupt from the drive.
+	 */
+	pci_read_config_dword(dev, 0x40, &val);
+	if (val & mask)
+		printk("sl82c105: drive was requesting IRQ, but host lost it\n");
+
+	/*
+	 * Was DMA enabled?  If so, disable it - we're resetting the
+	 * host.  The IDE layer will be handling the drive for us.
+	 */
+	val = inb(dma_base);
+	if (val & 1) {
+		outb(val & ~1, dma_base);
+		printk("sl82c105: DMA was enabled\n");
+	}
+
+	sl82c105_reset_host(dev);
+}
+
+/*
  * We only deal with PIO mode here - DMA mode 'using_dma' is not
  * initialised at the point that this function is called.
  */
@@ -185,21 +289,25 @@
  * Return the revision of the Winbond bridge
  * which this function is part of.
  */
-static unsigned int sl82c105_bridge_revision(struct pci_dev *dev)
+static __init unsigned int sl82c105_bridge_revision(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 	unsigned char rev;
 
-	bridge = pci_find_device(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_83C553, NULL);
-
 	/*
-	 * If we are part of a Winbond 553
+	 * The bridge should be part of the same device, but function 0.
 	 */
-	if (!bridge || bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA)
+	bridge = pci_find_slot(dev->bus->number,
+			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	if (!bridge)
 		return -1;
 
-	if (bridge->bus != dev->bus ||
-	    PCI_SLOT(bridge->devfn) != PCI_SLOT(dev->devfn))
+	/*
+	 * Make sure it is a Winbond 553 and is an ISA bridge.
+	 */
+	if (bridge->vendor != PCI_VENDOR_ID_WINBOND ||
+	    bridge->device != PCI_DEVICE_ID_WINBOND_83C553 ||
+	    bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA)
 		return -1;
 
 	/*
@@ -215,49 +323,55 @@
  */
 static unsigned int __init sl82c105_init_chipset(struct pci_dev *dev)
 {
-	unsigned char ctrl_stat;
+	u32 val;
 
-	/*
-	 * Enable the ports
-	 */
-	pci_read_config_byte(dev, 0x40, &ctrl_stat);
-	pci_write_config_byte(dev, 0x40, ctrl_stat | 0x33);
+	pci_read_config_dword(dev, 0x40, &val);
+	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1EN | CTRL_P1F16;
+	pci_write_config_dword(dev, 0x40, val);
 
 	return dev->irq;
 }
 
-static void __init sl82c105_init_dma(struct ata_channel *hwif, unsigned long dma_base)
+static void __init sl82c105_init_dma(struct ata_channel *ch, unsigned long dma_base)
 {
-	unsigned int rev;
+	unsigned int bridge_rev;
 	byte dma_state;
 
 	dma_state = inb(dma_base + 2);
-	rev = sl82c105_bridge_revision(hwif->pci_dev);
-	if (rev <= 5) {
-		hwif->autodma = 0;
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	bridge_rev = sl82c105_bridge_revision(ch->pci_dev);
+	if (bridge_rev <= 5) {
+		ch->autodma = 0;
+		ch->drives[0].autotune = 1;
+		ch->drives[1].autotune = 1;
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
-		       hwif->name, rev);
+		       ch->name, bridge_rev);
 		dma_state &= ~0x60;
 	} else {
 		dma_state |= 0x60;
-		hwif->autodma = 1;
+		ch->autodma = 1;
 	}
 	outb(dma_state, dma_base + 2);
 
-	hwif->XXX_udma = NULL;
-	ata_init_dma(hwif, dma_base);
-	if (hwif->XXX_udma)
-		hwif->XXX_udma = sl82c105_dmaproc;
+	ata_init_dma(ch, dma_base);
+
+	if (bridge_rev <= 5)
+		ch->XXX_udma = NULL;
+	else {
+		ch->XXX_udma      = sl82c105_dmaproc;
+		ch->udma_enable   = sl82c105_dma_enable;
+		ch->udma_read     = sl82c105_dma_read;
+		ch->udma_write    = sl82c105_dma_write;
+		ch->udma_timeout  = sl82c105_timeout;
+		ch->udma_irq_lost = sl82c105_lostirq;
+	}
 }
 
 /*
  * Initialise the chip
  */
-static void __init sl82c105_init_channel(struct ata_channel *hwif)
+static void __init sl82c105_init_channel(struct ata_channel *ch)
 {
-	hwif->tuneproc = tune_sl82c105;
+	ch->tuneproc = tune_sl82c105;
 }
 
 
diff -urN linux-2.5.17/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.17/drivers/ide/via82cxxx.c	2002-05-22 20:11:38.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-05-22 13:21:11.000000000 +0200
@@ -105,7 +105,7 @@
 	unsigned char rev_min;
 	unsigned char rev_max;
 	unsigned short flags;
-} via_isa_bridges[] = {
+} via_isa_bridges [] __initdata = {
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
@@ -132,7 +132,6 @@
 static struct via_isa_bridge *via_config;
 static unsigned char via_enabled;
 static unsigned int via_80w;
-static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
 /*
@@ -175,7 +174,7 @@
 	via_print("Highest DMA rate:                   %s", via_dma[via_config->flags & VIA_UDMA]);
 
 	via_print("BM-DMA base:                        %#x", via_base);
-	via_print("PCI clock:                          %d.%dMHz", via_clock / 1000, via_clock / 100 % 10);
+	via_print("PCI clock:                          %d.%dMHz", system_bus_speed / 1000, system_bus_speed / 100 % 10);
 
 	pci_read_config_byte(dev, VIA_MISC_1, &t);
 	via_print("Master Read  Cycle IRDY:            %dws", (t & 64) >> 6);
@@ -223,8 +222,8 @@
 		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
 		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
-		speed[i] = 2 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
+		speed[i] = 2 * system_bus_speed / (active[i] + recover[i]);
+		cycle[i] = 1000000 * (active[i] + recover[i]) / system_bus_speed;
 
 		if (!uen[i] || !den[i])
 			continue;
@@ -232,34 +231,34 @@
 		switch (via_config->flags & VIA_UDMA) {
 
 			case VIA_UDMA_33:
-				speed[i] = 2 * via_clock / udma[i];
-				cycle[i] = 1000000 * udma[i] / via_clock;
+				speed[i] = 2 * system_bus_speed / udma[i];
+				cycle[i] = 1000000 * udma[i] / system_bus_speed;
 				break;
 
 			case VIA_UDMA_66:
-				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
+				speed[i] = 4 * system_bus_speed / (udma[i] * umul[i]);
+				cycle[i] = 500000 * (udma[i] * umul[i]) / system_bus_speed;
 				break;
 
 			case VIA_UDMA_100:
-				speed[i] = 6 * via_clock / udma[i];
-				cycle[i] = 333333 * udma[i] / via_clock;
+				speed[i] = 6 * system_bus_speed / udma[i];
+				cycle[i] = 333333 * udma[i] / system_bus_speed;
 				break;
 
 			case VIA_UDMA_133:
-				speed[i] = 8 * via_clock / udma[i];
-				cycle[i] = 250000 * udma[i] / via_clock;
+				speed[i] = 8 * system_bus_speed / udma[i];
+				cycle[i] = 250000 * udma[i] / system_bus_speed;
 				break;
 		}
 	}
 
 	via_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	via_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / via_clock);
-	via_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / via_clock);
-	via_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / via_clock);
-	via_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / via_clock);
-	via_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / via_clock);
+	via_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / system_bus_speed);
+	via_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / system_bus_speed);
+	via_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / system_bus_speed);
+	via_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / system_bus_speed);
+	via_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / system_bus_speed);
 	via_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	via_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
@@ -314,7 +313,7 @@
 			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
 				drive->dn >> 1, drive->dn & 1);
 
-	T = 1000000000 / via_clock;
+	T = 1000000000 / system_bus_speed;
 
 	switch (via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:   UT = T;   break;
@@ -471,24 +470,6 @@
 	pci_write_config_byte(dev, VIA_FIFO_CONFIG, t);
 
 /*
- * Determine system bus clock.
- */
-
-	via_clock = system_bus_speed * 1000;
-
-	switch (via_clock) {
-		case 33000: via_clock = 33333; break;
-		case 37000: via_clock = 37500; break;
-		case 41000: via_clock = 41666; break;
-	}
-
-	if (via_clock < 20000 || via_clock > 50000) {
-		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
-		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
-		via_clock = 33333;
-	}
-
-/*
  * Print the boot message.
  */
 
diff -urN linux-2.5.17/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.17/include/linux/ide.h	2002-05-22 20:11:38.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-22 19:28:27.000000000 +0200
@@ -40,9 +40,6 @@
 
 /* Right now this is only needed by a promise controlled.
  */
-#ifndef DISK_RECOVERY_TIME		/* off=0; on=access_delay_time */
-# define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
-#endif
 #ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
 # define OK_TO_RESET_CONTROLLER	0	/* 0 for use with AH2372A/B interface */
 #endif
@@ -202,7 +199,8 @@
 	ide_cmd646,
 	ide_cy82c693,
 	ide_pmac,
-	ide_etrax100
+	ide_etrax100,
+	ide_acorn
 } hwif_chipset_t;
 
 
@@ -547,10 +545,6 @@
 	unsigned slow		: 1;	/* flag: slow data port */
 	unsigned io_32bit	: 1;	/* 0=16-bit, 1=32-bit */
 	unsigned char bus_state;	/* power state of the IDE bus */
-
-#if (DISK_RECOVERY_TIME > 0)
-	unsigned long last_time;	/* time when previous rq was done */
-#endif
 };
 
 /*
@@ -861,6 +855,15 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 
+void udma_pci_enable(struct ata_device *drive, int on, int verbose);
+int udma_pci_start(struct ata_device *drive, struct request *rq);
+int udma_pci_stop(struct ata_device *drive);
+int udma_pci_read(struct ata_device *drive, struct request *rq);
+int udma_pci_write(struct ata_device *drive, struct request *rq);
+int udma_pci_irq_status(struct ata_device *drive);
+void udma_pci_timeout(struct ata_device *drive);
+void udma_pci_irq_lost(struct ata_device *);
+
 extern int udma_new_table(struct ata_channel *, struct request *);
 extern void udma_destroy_table(struct ata_channel *);
 extern void udma_print(struct ata_device *);

--------------000200090308050104090506--

