Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSE1P1C>; Tue, 28 May 2002 11:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSE1P1B>; Tue, 28 May 2002 11:27:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47890 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316821AbSE1P0q>; Tue, 28 May 2002 11:26:46 -0400
Message-ID: <3CF392D1.6030703@evision-ventures.com>
Date: Tue, 28 May 2002 16:23:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.18
In-Reply-To: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010909020108080101080708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010909020108080101080708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Mon May 27 12:37:58 CEST 2002 ide-clean-72

- Replace ide_delay_50m with mdelay(50). There is absolutely no reason we
   should behave different behaviors whatever IDECS support is enabled or not.

- Kill last parameter of ide_register_hw(). It should return a pointer to the
   interface registered later.

- pdc202xx patches by Bartomiej onierkiewicz.

- ServerWorks chi pset support cleanup by Andrej Panin.

- Move temporarily ide_setup_ports to main.c unfold it in ide-pnp.c.

I'm trying again to make the patch chunks a bit more palatable...

--------------010909020108080101080708
Content-Type: text/plain;
 name="ide-clean-72.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-72.diff"

diff -urN linux-2.5.18/drivers/ide/buddha.c linux/drivers/ide/buddha.c
--- linux-2.5.18/drivers/ide/buddha.c	2002-05-25 03:55:25.000000000 +0200
+++ linux/drivers/ide/buddha.c	2002-05-27 16:06:44.000000000 +0200
@@ -202,9 +202,9 @@
 						xsurf_offsets, 0,
 						(ide_ioreg_t)(buddha_board+xsurf_irqports[i]),
 						xsurf_ack_intr, IRQ_AMIGA_PORTS);
-			}	
-			
-			index = ide_register_hw(&hw, NULL);
+			}
+
+			index = ide_register_hw(&hw);
 			if (index != -1) {
 				printk("ide%d: ", index);
 				switch(type) {
diff -urN linux-2.5.18/drivers/ide/falconide.c linux/drivers/ide/falconide.c
--- linux-2.5.18/drivers/ide/falconide.c	2002-05-25 03:55:25.000000000 +0200
+++ linux/drivers/ide/falconide.c	2002-05-27 16:06:54.000000000 +0200
@@ -60,7 +60,7 @@
 
 	ide_setup_ports(&hw, (ide_ioreg_t)ATA_HD_BASE, falconide_offsets,
 			0, 0, NULL, IRQ_MFP_IDE);
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw);
 
 	if (index != -1)
 	    printk("ide%d: Falcon IDE interface\n", index);
diff -urN linux-2.5.18/drivers/ide/gayle.c linux/drivers/ide/gayle.c
--- linux-2.5.18/drivers/ide/gayle.c	2002-05-25 03:55:21.000000000 +0200
+++ linux/drivers/ide/gayle.c	2002-05-27 16:06:00.000000000 +0200
@@ -150,7 +150,7 @@
 	ide_setup_ports(&hw, base, gayle_offsets,
 			ctrlport, irqport, ack_intr, IRQ_AMIGA_PORTS);
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw);
 	if (index != -1) {
 	    switch (i) {
 		case 0:
diff -urN linux-2.5.18/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.18/drivers/ide/ide.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-28 13:21:53.000000000 +0200
@@ -151,6 +151,12 @@
 	return ret;
 }
 
+/* This is the default end request function as well */
+int ide_end_request(struct ata_device *drive, struct request *rq, int uptodate)
+{
+	return __ide_end_request(drive, rq, uptodate, 0);
+}
+
 /*
  * This should get invoked any time we exit the driver to
  * wait for an interrupt response from a drive.  handler() points
@@ -508,7 +514,7 @@
 	printk("} ");
 }
 #else
-#define ata_dump_bits(msgs,nr,bits) do { } while (0)
+# define ata_dump_bits(msgs,nr,bits) do { } while (0)
 #endif
 
 /*
@@ -1517,36 +1523,6 @@
 	return 0;
 }
 
-/*
- * Setup hw_regs_t structure described by parameters.  You
- * may set up the hw structure yourself OR use this routine to
- * do it for you.
- */
-void ide_setup_ports(hw_regs_t *hw,
-		ide_ioreg_t base, int *offsets,
-		ide_ioreg_t ctrl, ide_ioreg_t intr,
-		ide_ack_intr_t *ack_intr, int irq)
-{
-	int i;
-
-	for (i = 0; i < IDE_NR_PORTS; i++) {
-		if (offsets[i] != -1)
-			hw->io_ports[i] = base + offsets[i];
-		else
-			hw->io_ports[i] = 0;
-	}
-	if (offsets[IDE_CONTROL_OFFSET] == -1)
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl;
-/* FIMXE: check if we can remove this ifdef */
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	if (offsets[IDE_IRQ_OFFSET] == -1)
-		hw->io_ports[IDE_IRQ_OFFSET] = intr;
-#endif
-	hw->irq = irq;
-	hw->dma = NO_DMA;
-	hw->ack_intr = ack_intr;
-}
-
 int ide_spin_wait_hwgroup(struct ata_device *drive)
 {
 	/* FIXME: Wait on a proper timer. Instead of playing games on the
@@ -1572,24 +1548,6 @@
 	return 0;
 }
 
-/*
- * Delay for *at least* 50ms.  As we don't know how much time is left
- * until the next tick occurs, we wait an extra tick to be safe.
- * This is used only during the probing/polling for drives at boot time.
- *
- * However, its usefullness may be needed in other places, thus we export it now.
- * The future may change this to a millisecond setable delay.
- */
-void ide_delay_50ms (void)
-{
-#ifndef CONFIG_BLK_DEV_IDECS
-	mdelay(50);
-#else
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/20);
-#endif
-}
-
 static int ide_check_media_change(kdev_t i_rdev)
 {
 	struct ata_device *drive;
@@ -1638,12 +1596,6 @@
 		*p++ = '\0';
 }
 
-/* This is the default end request function as well */
-int ide_end_request(struct ata_device *drive, struct request *rq, int uptodate)
-{
-	return __ide_end_request(drive, rq, uptodate, 0);
-}
-
 struct block_device_operations ide_fops[] = {{
 	owner:			THIS_MODULE,
 	open:			ide_open,
@@ -1669,7 +1621,6 @@
 EXPORT_SYMBOL(ide_end_drive_cmd);
 EXPORT_SYMBOL(__ide_end_request);
 EXPORT_SYMBOL(ide_end_request);
-EXPORT_SYMBOL(ide_delay_50ms);
 EXPORT_SYMBOL(ide_stall_queue);
 
 EXPORT_SYMBOL(ide_setup_ports);
diff -urN linux-2.5.18/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
--- linux-2.5.18/drivers/ide/ide-cs.c	2002-05-25 03:55:23.000000000 +0200
+++ linux/drivers/ide/ide-cs.c	2002-05-27 16:06:29.000000000 +0200
@@ -233,7 +233,8 @@
         ide_init_hwif_ports(&hw, (ide_ioreg_t) arg1, (ide_ioreg_t) arg2, NULL);
         hw.irq = irq;
         hw.chipset = ide_pci; /* this enables IRQ sharing w/ PCI irqs */
-        return ide_register_hw(&hw, NULL);
+
+        return ide_register_hw(&hw);
 }
 
 void ide_config(dev_link_t *link)
diff -urN linux-2.5.18/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.18/drivers/ide/ide-features.c	2002-05-25 03:55:28.000000000 +0200
+++ linux/drivers/ide/ide-features.c	2002-05-28 13:23:56.000000000 +0200
@@ -189,17 +189,19 @@
 	SELECT_MASK(drive->channel, drive, 1);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
-	ide_delay_50ms();
+	mdelay(50);
 	OUT_BYTE(WIN_IDENTIFY, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (time_after(jiffies, timeout)) {
 			SELECT_MASK(drive->channel, drive, 0);
 			return 0;	/* drive timed-out */
 		}
-		ide_delay_50ms();	/* give drive a breather */
+		mdelay(50);	/* give drive a breather */
 	} while (IN_BYTE(IDE_ALTSTATUS_REG) & BUSY_STAT);
-	ide_delay_50ms();	/* wait for IRQ and DRQ_STAT */
+
+	mdelay(50);	/* wait for IRQ and DRQ_STAT */
+
 	if (!OK_STAT(GET_STAT(),DRQ_STAT,BAD_R_STAT)) {
 		SELECT_MASK(drive->channel, drive, 0);
 		printk("%s: CHECK for good STATUS\n", drive->name);
diff -urN linux-2.5.18/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.18/drivers/ide/ide-pci.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-28 11:19:39.000000000 +0200
@@ -351,7 +351,7 @@
 		base = port ? 0x170 : 0x1f0;
 
 	if ((ch = lookup_channel(base, d->bootable, dev->name)) == NULL)
-		return -ENOMEM;	/* no room in ide_hwifs[] */
+		return -ENOMEM;	/* no room */
 
 	if (ch->io_ports[IDE_DATA_OFFSET] != base) {
 		ide_init_hwif_ports(&ch->hw, base, (ctl | 2), NULL);
diff -urN linux-2.5.18/drivers/ide/ide-pnp.c linux/drivers/ide/ide-pnp.c
--- linux-2.5.18/drivers/ide/ide-pnp.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/ide-pnp.c	2002-05-28 12:44:00.000000000 +0200
@@ -32,29 +32,6 @@
 
 #define DEV_NAME(dev) (dev->bus->name ? dev->bus->name : "ISA PnP")
 
-enum {
-	GENERIC_HD_DATA,
-	GENERIC_HD_ERROR,
-	GENERIC_HD_NSECTOR,
-	GENERIC_HD_SECTOR,
-	GENERIC_HD_LCYL,
-	GENERIC_HD_HCYL,
-	GENERIC_HD_SELECT,
-	GENERIC_HD_STATUS
-};
-
-static int generic_ide_offsets[IDE_NR_PORTS] __initdata = {
-	GENERIC_HD_DATA,
-	GENERIC_HD_ERROR,
-	GENERIC_HD_NSECTOR,
-	GENERIC_HD_SECTOR,
-	GENERIC_HD_LCYL,
-	GENERIC_HD_HCYL,
-	GENERIC_HD_SELECT,
-	GENERIC_HD_STATUS,
-	-1, -1
-};
-
 /* ISA PnP device table entry */
 struct pnp_dev_t {
 	unsigned short card_vendor, card_device, vendor, device;
@@ -65,8 +42,8 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
-	struct ata_channel *hwif;
 	int index;
+	int i;
 
 	if (!enable)
 		return 0;
@@ -74,15 +51,24 @@
 	if (!(DEV_IO(dev, 0) && DEV_IO(dev, 1) && DEV_IRQ(dev, 0)))
 		return 1;
 
-	ide_setup_ports(&hw, (ide_ioreg_t) DEV_IO(dev, 0),
-			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
-			0, NULL, DEV_IRQ(dev, 0));
+	/* Initialize register access base values. */
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
+		hw.io_ports[i] = DEV_IO(dev, 0) + i;
+	hw.io_ports[IDE_CONTROL_OFFSET] = DEV_IO(dev, 1);
+
+	hw.irq = DEV_IRQ(dev, 0);
+	hw.dma = NO_DMA;
+	hw.ack_intr = NULL;
 
-	index = ide_register_hw(&hw, &hwif);
+	index = ide_register_hw(&hw);
 
 	if (index != -1) {
-		hwif->pci_dev = dev;
+		struct ata_channel *ch;
+
+		ch = &ide_hwifs[index];
+		ch->pci_dev = dev;
 		printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
+
 		return 0;
 	}
 
diff -urN linux-2.5.18/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.18/drivers/ide/ide-probe.c	2002-05-25 03:55:16.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-28 13:13:30.000000000 +0200
@@ -68,17 +68,7 @@
 	 * However let's try to get away with this...
 	 */
 
-#if 1
 	ata_read(drive, id, SECTOR_WORDS);
-#else
-        {
-                unsigned long   *ptr = (unsigned long *)id ;
-                unsigned long   lcount = 256/2 ;
-                // printk("IDE_DATA_REG = %#lx",IDE_DATA_REG);
-                while( lcount-- )
-                        *ptr++ = inl(IDE_DATA_REG);
-        }
-#endif
 	ide__sti();	/* local CPU only */
 	ide_fix_driveid(id);
 
@@ -248,7 +238,7 @@
 	rc = 1;
 	if (IDE_CONTROL_REG) {
 		/* take a deep breath */
-		ide_delay_50ms();
+		mdelay(50);
 		a = IN_BYTE(IDE_ALTSTATUS_REG);
 		s = IN_BYTE(IDE_STATUS_REG);
 		if ((a ^ s) & ~INDEX_STAT) {
@@ -258,7 +248,7 @@
 			hd_status = IDE_ALTSTATUS_REG;	/* use non-intrusive polling */
 		}
 	} else {
-		ide_delay_50ms();
+		mdelay(50);
 		hd_status = IDE_STATUS_REG;
 	}
 
@@ -281,10 +271,11 @@
 	do {
 		if (time_after(jiffies, timeout))
 			goto out;	/* drive timed-out */
-		ide_delay_50ms();		/* give drive a breather */
+		mdelay(50);		/* give drive a breather */
 	} while (IN_BYTE(hd_status) & BUSY_STAT);
 
-	ide_delay_50ms();		/* wait for IRQ and DRQ_STAT */
+	mdelay(50);		/* wait for IRQ and DRQ_STAT */
+
 	if (OK_STAT(GET_STAT(),DRQ_STAT,BAD_R_STAT)) {
 		unsigned long flags;
 		__save_flags(flags);	/* local CPU only */
@@ -345,13 +336,13 @@
 		drive->name, drive->present, drive->type,
 		(cmd == WIN_IDENTIFY) ? "ATA" : "ATAPI");
 #endif
-	ide_delay_50ms();	/* needed for some systems (e.g. crw9624 as drive0 with disk as slave) */
+	mdelay(50);	/* needed for some systems (e.g. crw9624 as drive0 with disk as slave) */
 	SELECT_DRIVE(hwif,drive);
-	ide_delay_50ms();
+	mdelay(50);
 	if (IN_BYTE(IDE_SELECT_REG) != drive->select.all && !drive->present) {
 		if (drive->select.b.unit != 0) {
 			SELECT_DRIVE(hwif,&hwif->drives[0]);	/* exit with drive0 selected */
-			ide_delay_50ms();		/* allow BUSY_STAT to assert & clear */
+			mdelay(50);		/* allow BUSY_STAT to assert & clear */
 		}
 		return 3;    /* no i/f present: mmm.. this should be a 4 -ml */
 	}
@@ -363,13 +354,13 @@
 		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), resetting drive\n", drive->name, GET_STAT());
-			ide_delay_50ms();
+			mdelay(50);
 			OUT_BYTE (drive->select.all, IDE_SELECT_REG);
-			ide_delay_50ms();
+			mdelay(50);
 			OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
 			timeout = jiffies;
 			while ((GET_STAT() & BUSY_STAT) && time_before(jiffies, timeout + WAIT_WORSTCASE))
-				ide_delay_50ms();
+				mdelay(50);
 			rc = identify(drive, cmd);
 		}
 		if (rc == 1)
@@ -380,7 +371,7 @@
 
 	if (drive->select.b.unit != 0) {
 		SELECT_DRIVE(hwif,&hwif->drives[0]);	/* exit with drive0 selected */
-		ide_delay_50ms();
+		mdelay(50);
 		(void) GET_STAT();		/* ensure drive irq is clear */
 	}
 	return rc;
@@ -392,7 +383,7 @@
 
 	printk("%s: enabling %s -- ", drive->channel->name, drive->id->model);
 	SELECT_DRIVE(drive->channel, drive);
-	ide_delay_50ms();
+	mdelay(50);
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
@@ -400,9 +391,9 @@
 			printk("failed (timeout)\n");
 			return;
 		}
-		ide_delay_50ms();
+		mdelay(50);
 	} while (GET_STAT() & BUSY_STAT);
-	ide_delay_50ms();
+	mdelay(50);
 	if (!OK_STAT(GET_STAT(), 0, BAD_STAT))
 		printk("failed (status = 0x%02x)\n", GET_STAT());
 	else
@@ -536,7 +527,7 @@
 		udelay(10);
 		OUT_BYTE(8, ch->io_ports[IDE_CONTROL_OFFSET]);
 		do {
-			ide_delay_50ms();
+			mdelay(50);
 			stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
 		} while ((stat & BUSY_STAT) && time_before(jiffies, timeout));
 	}
diff -urN linux-2.5.18/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.18/drivers/ide/ide-taskfile.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-28 11:41:22.000000000 +0200
@@ -353,13 +353,20 @@
 
 	OUT_BYTE((args->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
 	if (args->handler != NULL) {
+
+		/* This is apparently supposed to reset the wait timeout for
+		 * the interrupt to accur.
+		 */
+
 		ide_set_handler(drive, args->handler, WAIT_CMD, NULL);
 		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+
 		/*
 		 * Warning check for race between handler and prehandler for
 		 * writing first block of data.  however since we are well
 		 * inside the boundaries of the seek, we should be okay.
 		 */
+
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
@@ -579,7 +586,8 @@
 	return ide_started;
 }
 
-/* Called by ioctl to feature out type of command being called */
+/* Called to figure out the type of command being called.
+ */
 void ide_cmd_type_parser(struct ata_taskfile *args)
 {
 	struct hd_drive_task_hdr *taskfile = &args->taskfile;
diff -urN linux-2.5.18/drivers/ide/macide.c linux/drivers/ide/macide.c
--- linux-2.5.18/drivers/ide/macide.c	2002-05-25 03:55:19.000000000 +0200
+++ linux/drivers/ide/macide.c	2002-05-27 16:05:38.000000000 +0200
@@ -100,17 +100,17 @@
 	case MAC_IDE_QUADRA:
 		ide_setup_ports(&hw, (ide_ioreg_t)IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr, IRQ_NUBUS_F);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, (ide_ioreg_t)IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr, IRQ_NUBUS_C);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, (ide_ioreg_t)BABOON_BASE, macide_offsets,
 				0, 0, NULL, IRQ_BABOON_1);
-		index = ide_register_hw(&hw, NULL);
+		index = ide_register_hw(&hw);
 		if (index == -1) break;
 		if (macintosh_config->ident == MAC_MODEL_PB190) {
 
diff -urN linux-2.5.18/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.18/drivers/ide/main.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/main.c	2002-05-28 12:44:05.000000000 +0200
@@ -133,6 +133,43 @@
  */
 struct ata_channel ide_hwifs[MAX_HWIFS];	/* master data repository */
 
+/*
+ * FIXME: This function should be unrolled in the palces where it get's used,
+ * since in reality it's simple architecture specific initialization.
+ *
+ * Setup hw_regs_t structure described by parameters.  You may set up the hw
+ * structure yourself OR use this routine to do it for you.
+ */
+void ide_setup_ports(hw_regs_t *hw,
+		ide_ioreg_t base,
+		int *offsets,
+		ide_ioreg_t ctrl,
+		ide_ioreg_t intr,
+		ide_ack_intr_t *ack_intr,
+		int irq)
+{
+	int i;
+
+	for (i = 0; i < IDE_NR_PORTS; i++) {
+		if (offsets[i] != -1)
+			hw->io_ports[i] = base + offsets[i];
+		else
+			hw->io_ports[i] = 0;
+	}
+	if (offsets[IDE_CONTROL_OFFSET] == -1)
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl;
+
+	/* FIMXE: check if we can remove this ifdef */
+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
+	if (offsets[IDE_IRQ_OFFSET] == -1)
+		hw->io_ports[IDE_IRQ_OFFSET] = intr;
+#endif
+
+	hw->irq = irq;
+	hw->dma = NO_DMA;
+	hw->ack_intr = ack_intr;
+}
+
 static void init_hwif_data(struct ata_channel *ch, unsigned int index)
 {
 	static const unsigned int majors[] = {
@@ -148,15 +185,18 @@
 	memset(&hw, 0, sizeof(hw_regs_t));
 
 	/* fill in any non-zero initial values */
-	ch->index     = index;
+	ch->index = index;
 	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &ch->irq);
+
 	memcpy(&ch->hw, &hw, sizeof(hw));
 	memcpy(ch->io_ports, hw.io_ports, sizeof(hw.io_ports));
+
 	ch->noprobe	= !ch->io_ports[IDE_DATA_OFFSET];
 #ifdef CONFIG_BLK_DEV_HD
 	if (ch->io_ports[IDE_DATA_OFFSET] == HD_DATA)
 		ch->noprobe = 1; /* may be overridden by ide_setup() */
 #endif
+
 	ch->major = majors[index];
 	sprintf(ch->name, "ide%d", index);
 	ch->bus_state = BUSSTATE_ON;
@@ -576,7 +616,7 @@
  * Register an IDE interface, specifing exactly the registers etc
  * Set init=1 iff calling before probes have taken place.
  */
-int ide_register_hw(hw_regs_t *hw, struct ata_channel **hwifp)
+int ide_register_hw(hw_regs_t *hw)
 {
 	int h;
 	int retry = 1;
@@ -627,9 +667,6 @@
 			break;
 	}
 
-	if (hwifp)
-		*hwifp = ch;
-
 	return (initializing || ch->present) ? h : -1;
 }
 
diff -urN linux-2.5.18/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.18/drivers/ide/pdc202xx.c	2002-05-25 03:55:30.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-28 17:03:47.000000000 +0200
@@ -53,10 +53,6 @@
 #define PDC202XX_DEBUG_DRIVE_INFO		0
 #define PDC202XX_DECODE_REGISTER_INFO		0
 
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 /* A Register */
@@ -67,103 +63,62 @@
 #define	IORDY_EN	0x20	/* PIO: IOREADY */
 #define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
 
-#define	PA3		0x08	/* PIO"A" timing */
-#define	PA2		0x04	/* PIO"A" timing */
-#define	PA1		0x02	/* PIO"A" timing */
-#define	PA0		0x01	/* PIO"A" timing */
-
-/* B Register */
-
-#define	MB2		0x80	/* DMA"B" timing */
-#define	MB1		0x40	/* DMA"B" timing */
-#define	MB0		0x20	/* DMA"B" timing */
-
-#define	PB4		0x10	/* PIO_FORCE 1:0 */
-
-#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
-#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
-#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
-#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
-
-/* C Register */
-#define	IORDYp_NO_SPEED	0x4F
-#define	SPEED_DIS	0x0F
-
-#define	DMARQp		0x80
-#define	IORDYp		0x40
-#define	DMAR_EN		0x20
-#define	DMAW_EN		0x10
-
-#define	MC3		0x08	/* DMA"C" timing */
-#define	MC2		0x04	/* DMA"C" timing */
-#define	MC1		0x02	/* DMA"C" timing */
-#define	MC0		0x01	/* DMA"C" timing */
-
 #if PDC202XX_DECODE_REGISTER_INFO
 
-#define REG_A		0x01
-#define REG_B		0x02
-#define REG_C		0x04
-#define REG_D		0x08
+struct pdc_bit_messages {
+	u8 mask;
+	const char *msg;
+};
 
-static void decode_registers (byte registers, byte value)
+static struct pdc_bit_messages pdc_reg_A[] = {
+	{ 0x80, "SYNC_IN" },
+	{ 0x40, "ERRDY_EN" },
+	{ 0x20, "IORDY_EN" },
+	{ 0x10, "PREFETCH_EN" },
+	/* PA3-PA0 - PIO "A" timing */
+	{ 0x08, "PA3" },
+	{ 0x04, "PA2" },
+	{ 0x02, "PA1" },
+	{ 0x01, "PA0" }
+};
+
+static struct pdc_bit_messages pdc_reg_B[] = {
+	/* MB2-MB0 - DMA "B" timing */
+	{ 0x80, "MB2" },
+	{ 0x40, "MB1" },
+	{ 0x20, "MB0" },
+	{ 0x10, "PIO_FORCED/PB4" },	/* PIO_FORCE 1:0 */
+	/* PB3-PB0 - PIO "B" timing */
+	{ 0x08, "PB3" },		/* PIO flow Control mode */
+	{ 0x04, "PB2" },		/* PIO 4 */
+	{ 0x02, "PB1" },		/* PIO 3 half */
+	{ 0x01, "PB0" }			/* PIO 3 other half */
+};
+
+static struct pdc_bit_messages pdc_reg_C[] = {
+	{ 0x80, "DMARQp" },
+	{ 0x40, "IORDYp" },
+	{ 0x20, "DMAR_EN" },
+	{ 0x10, "DMAW_EN" },
+	/* MC3-MC0 - DMA "C" timing */
+	{ 0x08, "MC3" },
+	{ 0x04, "MC2" },
+	{ 0x02, "MC1" },
+	{ 0x01, "MC0" }
+};
+
+static void pdc_dump_bits(struct pdc_bit_messages *msgs, byte bits)
 {
-	byte	bit = 0, bit1 = 0, bit2 = 0;
+	int i;
 
-	switch(registers) {
-		case REG_A:
-			printk("A Register ");
-			if (value & 0x80) printk("SYNC_IN ");
-			if (value & 0x40) printk("ERRDY_EN ");
-			if (value & 0x20) printk("IORDY_EN ");
-			if (value & 0x10) printk("PREFETCH_EN ");
-			if (value & 0x08) { printk("PA3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PA2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PA1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PA0 ");bit2 |= 0x01; }
-			printk("PIO(A) = %d ", bit2);
-			break;
-		case REG_B:
-			printk("B Register ");
-			if (value & 0x80) { printk("MB2 ");bit1 |= 0x80; }
-			if (value & 0x40) { printk("MB1 ");bit1 |= 0x40; }
-			if (value & 0x20) { printk("MB0 ");bit1 |= 0x20; }
-			printk("DMA(B) = %d ", bit1 >> 5);
-			if (value & 0x10) printk("PIO_FORCED/PB4 ");
-			if (value & 0x08) { printk("PB3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PB2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PB1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PB0 ");bit2 |= 0x01; }
-			printk("PIO(B) = %d ", bit2);
-			break;
-		case REG_C:
-			printk("C Register ");
-			if (value & 0x80) printk("DMARQp ");
-			if (value & 0x40) printk("IORDYp ");
-			if (value & 0x20) printk("DMAR_EN ");
-			if (value & 0x10) printk("DMAW_EN ");
-
-			if (value & 0x08) { printk("MC3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("MC2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("MC1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("MC0 ");bit2 |= 0x01; }
-			printk("DMA(C) = %d ", bit2);
-			break;
-		case REG_D:
-			printk("D Register ");
-			break;
-		default:
-			return;
-	}
-	printk("\n        %s ", (registers & REG_D) ? "DP" :
-				(registers & REG_C) ? "CP" :
-				(registers & REG_B) ? "BP" :
-				(registers & REG_A) ? "AP" : "ERROR");
-	for (bit=128;bit>0;bit/=2)
-		printk("%s", (value & bit) ? "1" : "0");
-	printk("\n");
-}
+	printk(KERN_DEBUG " { ");
+
+	for (i = 0; i < 8; i++, msgs++)
+		if (bits & msgs->mask)
+			printk(KERN_DEBUG "%s ", msgs->msg);
 
+	printk(KERN_DEBUG " }\n");
+}
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 
 int check_in_drive_lists(struct ata_device *drive)
@@ -222,13 +177,10 @@
 	byte			drive_pci, AP, BP, CP, DP;
 	byte			TA = 0, TB = 0, TC = 0;
 
-	switch (drive->dn) {
-		case 0: drive_pci = 0x60; break;
-		case 1: drive_pci = 0x64; break;
-		case 2: drive_pci = 0x68; break;
-		case 3: drive_pci = 0x6c; break;
-		default: return -1;
-	}
+	if (drive->dn > 3)
+		return -1;
+
+	drive_pci = 0x60 + (drive->dn << 2);
 
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return -1;
@@ -245,11 +197,8 @@
 			/* clear DMA modes of upper 842 bits of B Register */
 			/* clear PIO forced mode upper 1 bit of B Register */
 			pci_write_config_byte(dev, (drive_pci)|0x01, BP & ~0xF0);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-
 			/* clear DMA modes of lower 8421 bits of C Register */
 			pci_write_config_byte(dev, (drive_pci)|0x02, CP & ~0x0F);
-			pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
 		}
 	} else {
 #else
@@ -258,14 +207,8 @@
 		if ((AP & 0x0F) || (BP & 0x07)) {
 			/* clear PIO modes of lower 8421 bits of A Register */
 			pci_write_config_byte(dev, (drive_pci), AP & ~0x0F);
-			pci_read_config_byte(dev, (drive_pci), &AP);
-
 			/* clear PIO modes of lower 421 bits of B Register */
 			pci_write_config_byte(dev, (drive_pci)|0x01, BP & ~0x07);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-
-			pci_read_config_byte(dev, (drive_pci), &AP);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
 		}
 	}
 
@@ -277,17 +220,17 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		/* case XFER_UDMA_6: */
 		case XFER_UDMA_5:
-		case XFER_UDMA_4:	TB = 0x20; TC = 0x01; break;	/* speed 8 == UDMA mode 4 */
-		case XFER_UDMA_3:	TB = 0x40; TC = 0x02; break;	/* speed 7 == UDMA mode 3 */
-		case XFER_UDMA_2:	TB = 0x20; TC = 0x01; break;	/* speed 6 == UDMA mode 2 */
-		case XFER_UDMA_1:	TB = 0x40; TC = 0x02; break;	/* speed 5 == UDMA mode 1 */
-		case XFER_UDMA_0:	TB = 0x60; TC = 0x03; break;	/* speed 4 == UDMA mode 0 */
-		case XFER_MW_DMA_2:	TB = 0x60; TC = 0x03; break;	/* speed 4 == MDMA mode 2 */
-		case XFER_MW_DMA_1:	TB = 0x60; TC = 0x04; break;	/* speed 3 == MDMA mode 1 */
-		case XFER_MW_DMA_0:	TB = 0x60; TC = 0x05; break;	/* speed 2 == MDMA mode 0 */
-		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;	/* speed 0 == SDMA mode 2 */
-		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;	/* speed 1 == SDMA mode 1 */
-		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;	/* speed 0 == SDMA mode 0 */
+		case XFER_UDMA_4:	TB = 0x20; TC = 0x01; break;
+		case XFER_UDMA_3:	TB = 0x40; TC = 0x02; break;
+		case XFER_UDMA_2:	TB = 0x20; TC = 0x01; break;
+		case XFER_UDMA_1:	TB = 0x40; TC = 0x02; break;
+		case XFER_UDMA_0:	TB = 0x60; TC = 0x03; break;
+		case XFER_MW_DMA_2:	TB = 0x60; TC = 0x03; break;
+		case XFER_MW_DMA_1:	TB = 0x60; TC = 0x04; break;
+		case XFER_MW_DMA_0:	TB = 0x60; TC = 0x05; break;
+		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;
+		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;
+		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 		case XFER_PIO_4:	TA = 0x01; TB = 0x04; break;
 		case XFER_PIO_3:	TA = 0x02; TB = 0x06; break;
@@ -315,11 +258,18 @@
 	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
 	pci_read_config_byte(dev, (drive_pci)|0x03, &DP);
 
-	decode_registers(REG_A, AP);
-	decode_registers(REG_B, BP);
-	decode_registers(REG_C, CP);
-	decode_registers(REG_D, DP);
-#endif /* PDC202XX_DECODE_REGISTER_INFO */
+	printk(KERN_DEBUG "AP(%x): PIO(A) = %d\n", AP, AP & 0x0f);
+	pdc_dump_bits(pdc_reg_A, AP);
+
+	printk(KERN_DEBUG "BP(%x): DMA(B) = %d PIO(B) = %d\n",
+			  BP, (BP & 0xe0) >> 5, BP & 0x0f);
+	pdc_dump_bits(pdc_reg_B, BP);
+
+	printk(KERN_DEBUG "CP(%x): DMA(C) = %d\n", CP, CP & 0x0f);
+	pdc_dump_bits(pdc_reg_C, CP);
+
+	printk(KERN_DEBUG "DP(%x)\n", DP);
+#endif
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
@@ -352,8 +302,7 @@
 	unsigned long indexreg	= (hwif->dma_base + 1);
 	unsigned long datareg	= (hwif->dma_base + 3);
 #else
-	struct pci_dev *dev	= hwif->pci_dev;
-	unsigned long high_16	= pci_resource_start(dev, 4);
+	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
 	unsigned long indexreg	= high_16 + (hwif->unit ? 0x09 : 0x01);
 	unsigned long datareg	= (indexreg + 2);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -473,6 +422,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+/* FIXME: split this for old & new chipsets (jumpbit) --bkz */
 static int config_chipset_for_dma(struct ata_device *drive, byte udma)
 {
 	struct hd_driveid *id	= drive->id;
@@ -483,19 +433,13 @@
 	unsigned long dma_base  = hwif->dma_base;
 	unsigned long indexreg	= dma_base + 1;
 	unsigned long datareg	= dma_base + 3;
-	byte iordy		= 0x13;
 	byte adj		= (drive->dn%2) ? 0x08 : 0x00;
-	byte cable		= 0;
 	byte jumpbit		= 0;
 	unsigned int		drive_conf;
-	byte drive_pci = 0, mate_pci = 0;
-	byte			test1, test2, mode = -1;
-	byte			AP;
-	unsigned short		EP;
+	byte drive_pci = 0, AP, tmp, mode = -1;
 	byte CLKSPD		= 0;
 	/* primary - second bit, secondary - fourth bit */
 	byte mask		= hwif->unit ? 0x08 : 0x02;
-	unsigned short c_mask	= hwif->unit ? (1<<11) : (1<<10);
 	int map;
 
 	byte needs_80w = ((id->dma_ultra & 0x0008) ||
@@ -504,24 +448,14 @@
 			  (id->dma_ultra & 0x0040));
 
 	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-		case PCI_DEVICE_ID_PROMISE_20268:
-			OUT_BYTE(0x0b, indexreg);
-			cable = ((IN_BYTE(datareg) & 0x04));
-			jumpbit = 1;
-			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20262:
-			pci_read_config_word(dev, 0x50, &EP);
-			cable = (EP & c_mask);
+		case PCI_DEVICE_ID_PROMISE_20246:
 			jumpbit = 0;
 			break;
-		default:
-			cable = 1; jumpbit = 0;
+		default: /* chipsets newer then 20268 */
+			jumpbit = 1;
 			break;
 	}
 
@@ -541,7 +475,7 @@
 	 */
 	if (needs_80w) {
 		/* FIXME: this check is wrong for 20246 --bkz */
-		if (cable) {
+		if (!hwif->udma_four) {
 			printk(KERN_WARNING "%s: channel requires an 80-pin cable.\n", hwif->name);
 			printk(KERN_WARNING "%s: reduced to UDMA(33) mode.\n", drive->name);
 			if (!jumpbit)
@@ -563,37 +497,30 @@
 		}
 	}
 
-	if (jumpbit) {
-		if (drive->type != ATA_DISK)
-			return 0;
-		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
-			set_2regs(iordy, (IN_BYTE(datareg)|0x03));
-		}
-		goto jumpbit_is_set;
-	}
+	if (jumpbit)
+		goto chipset_is_set;
 
-	switch(drive->dn) {
-		case 0:	drive_pci = 0x60;
-		case 2:	drive_pci = 0x68;
-			pci_read_config_dword(dev, drive_pci, &drive_conf);
-			if ((drive_conf != 0x004ff304) && (drive_conf != 0x004ff3c4))
-				goto chipset_is_set;
-			pci_read_config_byte(dev, drive_pci, &test1);
-			if (!(test1 & SYNC_ERRDY_EN))
-				pci_write_config_byte(dev, drive_pci, test1|SYNC_ERRDY_EN);
-			break;
-		case 1:	drive_pci = 0x64; mate_pci = 0x60;
-		case 3:	drive_pci = 0x6c; mate_pci = 0x68;
-			pci_read_config_dword(dev, drive_pci, &drive_conf);
-			if ((drive_conf != 0x004ff304) && (drive_conf != 0x004ff3c4))
-				goto chipset_is_set;
-			pci_read_config_byte(dev, mate_pci, &test1);
-			pci_read_config_byte(dev, drive_pci, &test2);
-			if ((test1 & SYNC_ERRDY_EN) && !(test2 & SYNC_ERRDY_EN))
-				pci_write_config_byte(dev, drive_pci, test2|SYNC_ERRDY_EN);
-			break;
-		default:
-			return 0;
+	if (drive->dn > 3)	/* FIXME: remove this --bkz */
+		return 0;
+
+	drive_pci = 0x60 + (drive->dn << 2);
+	pci_read_config_dword(dev, drive_pci, &drive_conf);
+	if ((drive_conf != 0x004ff304) && (drive_conf != 0x004ff3c4))
+		goto chipset_is_set;
+
+	/* FIXME: what if SYNC_ERRDY is enabled for slave
+		  and disabled for master? --bkz */
+	pci_read_config_byte(dev, drive_pci, &AP);
+	if (!(AP & SYNC_ERRDY_EN)) {
+		if (drive->dn == 0 || drive->dn == 2) {
+			/* enable SYNC_ERRDY for master */
+			pci_write_config_byte(dev, drive_pci, AP|SYNC_ERRDY_EN);
+		} else {
+			/* enable SYNC_ERRDY for slave if enabled for master */
+			pci_read_config_byte(dev, drive_pci - 4, &tmp);
+			if (tmp & SYNC_ERRDY_EN)
+				pci_write_config_byte(dev, drive_pci, AP|SYNC_ERRDY_EN);
+		}
 	}
 
 chipset_is_set:
@@ -601,14 +528,18 @@
 	if (drive->type != ATA_DISK)
 		return 0;
 
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	if (id->capability & 4)	/* IORDY_EN */
-		pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	if (drive->type == ATA_DISK)	/* PREFETCH_EN */
-		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
-
-jumpbit_is_set:
+	if (jumpbit) {
+		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
+			set_2regs(0x13, (IN_BYTE(datareg)|0x03));
+		}
+	} else {
+		pci_read_config_byte(dev, drive_pci, &AP);
+		if (id->capability & 4)		/* IORDY_EN */
+			pci_write_config_byte(dev, drive_pci, AP|IORDY_EN);
+		pci_read_config_byte(dev, drive_pci, &AP);
+		if (drive->type == ATA_DISK)	/* PREFETCH_EN */
+			pci_write_config_byte(dev, drive_pci, AP|PREFETCH_EN);
+	}
 
 	if (udma) {
 		map = pdc202xx_ratemask(drive);
@@ -688,24 +619,13 @@
 
 static int pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
 {
-	u8 lba48hack = 0, clock = 0;
 	struct ata_channel *ch = drive->channel;
-	struct pci_dev *dev	= ch->pci_dev;
-	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long atapi_reg	= high_16 + (ch->unit ? 0x24 : 0x00);
+	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
+	unsigned long atapi_reg = high_16 + (ch->unit ? 0x24 : 0x00);
 
-	switch (dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			lba48hack = 1;
-			clock = IN_BYTE(high_16 + 0x11);
-		default:
-			break;
-	}
-
-	if (drive->addressing && lba48hack) {
+	if (drive->addressing) {
 		unsigned long word_count = 0;
+		u8 clock = IN_BYTE(high_16 + 0x11);
 
 		outb(clock|(ch->unit ? 0x08 : 0x02), high_16 + 0x11);
 		word_count = (rq->nr_sectors << 8);
@@ -725,26 +645,13 @@
 
 int pdc202xx_udma_stop(struct ata_device *drive)
 {
-	u8 lba48hack = 0, clock = 0;
 	struct ata_channel *ch = drive->channel;
-	struct pci_dev *dev	= ch->pci_dev;
-	unsigned long high_16	= pci_resource_start(dev, 4);
+	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
 	unsigned long atapi_reg	= high_16 + (ch->unit ? 0x24 : 0x00);
 	unsigned long dma_base = ch->dma_base;
-	u8 dma_stat;
+	u8 dma_stat, clock;
 
-	switch (dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			lba48hack = 1;
-			/* FIXME: why do we need this here --bkz */
-			clock = IN_BYTE(high_16 + 0x11);
- 		default:
-			break;
-	}
-
-	if (drive->addressing && lba48hack) {
+	if (drive->addressing) {
 		outl(0, atapi_reg);	/* zero out extra */
 		clock = IN_BYTE(high_16 + 0x11);
 		OUT_BYTE(clock & ~(ch->unit ? 0x08:0x02), high_16 + 0x11);
@@ -762,34 +669,10 @@
 static int pdc202xx_udma_irq_status(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	u8 dma_stat = 0;
-	u8 sc1d	= 0;
-	u8 newchip = 0;
-	u8 clock = 0;
-	struct pci_dev *dev = ch->pci_dev;
-	unsigned long high_16 = pci_resource_start(dev, 4);
-	unsigned long dma_base = ch->dma_base;
-
-	switch (dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20268R:
-		case PCI_DEVICE_ID_PROMISE_20268:
-			newchip = 1;
-			break;
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			/* FIXME: why do we need this here --bkz */
-			clock = IN_BYTE(high_16 + 0x11);
-		default:
-			break;
-	}
+	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
+	u8 dma_stat, sc1d;
 
-	dma_stat = IN_BYTE(dma_base + 2);
-	if (newchip)
-		return (dma_stat & 4) == 4;
+	dma_stat = IN_BYTE(ch->dma_base + 2);
 
 	sc1d = IN_BYTE(high_16 + 0x001d);
 	if (ch->unit) {
@@ -838,6 +721,7 @@
 		drive->channel->unit ? "Secondary" : "Primary");
 }
 
+/* FIXME: should be splited for old & new chipsets --bkz */
 static unsigned int __init pdc202xx_init_chipset(struct pci_dev *dev)
 {
 	unsigned long high_16	= pci_resource_start(dev, 4);
@@ -877,6 +761,8 @@
 			set_reg_and_wait(udma_speed_flag & ~0x10, high_16 + 0x001f, 2000);   /* 2 seconds ?! */
 			break;
 		default:
+		/* FIXME: only checked for 20246 - is this right?,
+			  if it is needed it should go to ide-pci --bkz */
 			if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 				byte irq = 0, irq2 = 0;
 				pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
@@ -949,6 +835,15 @@
 		case PCI_DEVICE_ID_PROMISE_20265:
 		case PCI_DEVICE_ID_PROMISE_20262:
 			hwif->resetproc	= &pdc202xx_reset;
+#ifdef CONFIG_BLK_DEV_IDEDMA
+			/* we need special functions for lba48 */
+			if (hwif->dma_base) {
+				hwif->udma_start = pdc202xx_udma_start;
+				hwif->udma_stop = pdc202xx_udma_stop;
+				hwif->udma_irq_status = pdc202xx_udma_irq_status;
+			}
+#endif
+		/* FIXME: check whether 20246 works with lba48 --bkz */
 		case PCI_DEVICE_ID_PROMISE_20246:
 			hwif->speedproc = &pdc202xx_tune_chipset;
 		default:
@@ -957,9 +852,6 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
-		hwif->udma_start = pdc202xx_udma_start;
-		hwif->udma_stop = pdc202xx_udma_stop;
-		hwif->udma_irq_status = pdc202xx_udma_irq_status;
 		hwif->udma_irq_lost = pdc202xx_bug;
 		hwif->udma_timeout = pdc202xx_bug;
 		hwif->XXX_udma = pdc202xx_dmaproc;
diff -urN linux-2.5.18/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.18/drivers/ide/pdc4030.c	2002-05-25 03:55:21.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-27 15:03:08.000000000 +0200
@@ -342,7 +342,7 @@
 	outb(0x14, IDE_SELECT_REG);
 	outb(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
 
-	ide_delay_50ms();
+	mdelay(50);
 
 	if (inb(IDE_ERROR_REG) == 'P' &&
 	    inb(IDE_NSECTOR_REG) == 'T' &&
diff -urN linux-2.5.18/drivers/ide/q40ide.c linux/drivers/ide/q40ide.c
--- linux-2.5.18/drivers/ide/q40ide.c	2002-05-25 03:55:27.000000000 +0200
+++ linux/drivers/ide/q40ide.c	2002-05-27 16:07:08.000000000 +0200
@@ -82,10 +82,10 @@
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
 
-	ide_setup_ports(&hw,(ide_ioreg_t) pcide_bases[i], (int *)pcide_offsets, 
-			pcide_bases[i]+0x206, 
+	ide_setup_ports(&hw,(ide_ioreg_t) pcide_bases[i], (int *)pcide_offsets,
+			pcide_bases[i] + 0x206,
 			0, NULL, q40ide_default_irq(pcide_bases[i]));
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
     }
 }
 
diff -urN linux-2.5.18/drivers/ide/rapide.c linux/drivers/ide/rapide.c
--- linux-2.5.18/drivers/ide/rapide.c	2002-05-25 03:55:22.000000000 +0200
+++ linux/drivers/ide/rapide.c	2002-05-27 16:06:08.000000000 +0200
@@ -41,7 +41,7 @@
 	hw.io_ports[IDE_CONTROL_OFFSET] = port + 0x206;
 	hw.irq = ec->irq;
 
-	return ide_register_hw(&hw, NULL);
+	return ide_register_hw(&hw);
 }
 
 int __init rapide_init(void)
diff -urN linux-2.5.18/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.18/drivers/ide/serverworks.c	2002-05-25 03:55:27.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-28 10:28:49.000000000 +0200
@@ -98,7 +98,7 @@
 #undef DISPLAY_SVWKS_TIMINGS
 #undef SVWKS_DEBUG_DRIVE_INFO
 
-static u8 svwks_revision = 0;
+static u8 svwks_revision;
 
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
@@ -230,12 +230,13 @@
 				((reg40&0x005D0000)==0x005D0000)?"0":"?");
 	return p-buffer;	 /* => must be less than 4k! */
 }
+
+static byte svwks_proc;
+
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 
-byte svwks_proc = 0;
-
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 static struct pci_dev *isa_dev;
@@ -262,7 +263,6 @@
 
 static int svwks_tune_chipset(struct ata_device *drive, byte speed)
 {
-	static u8 udma_modes[]	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
 	static u8 dma_modes[]	= { 0x77, 0x21, 0x20 };
 	static u8 pio_modes[]	= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
 
@@ -271,26 +271,23 @@
 	byte unit		= (drive->select.b.unit & 0x01);
 	byte csb5		= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
 
-	byte drive_pci		= 0x00;
-	byte drive_pci2		= 0x00;
-	byte drive_pci3		= hwif->unit ? 0x57 : 0x56;
-
-	byte ultra_enable	= 0x00;
-	byte ultra_timing	= 0x00;
-	byte dma_timing		= 0x00;
-	byte pio_timing		= 0x00;
-	unsigned short csb5_pio	= 0x00;
+	byte drive_pci, drive_pci2;
+	byte drive_pci3	= hwif->unit ? 0x57 : 0x56;
+
+	byte ultra_enable, ultra_timing, dma_timing, pio_timing;
+	unsigned short csb5_pio;
 
 	byte pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
         switch (drive->dn) {
-		case 0: drive_pci = 0x41; drive_pci2 = 0x45; break;
-		case 1: drive_pci = 0x40; drive_pci2 = 0x44; break;
-		case 2: drive_pci = 0x43; drive_pci2 = 0x47; break;
-		case 3: drive_pci = 0x42; drive_pci2 = 0x46; break;
+		case 0: drive_pci = 0x41; break;
+		case 1: drive_pci = 0x40; break;
+		case 2: drive_pci = 0x43; break;
+		case 3: drive_pci = 0x42; break;
 		default:
 			return -1;
 	}
+	drive_pci2 = drive_pci + 4;
 
 	pci_read_config_byte(dev, drive_pci, &pio_timing);
 	pci_read_config_byte(dev, drive_pci2, &dma_timing);
@@ -337,7 +334,7 @@
 			pio_timing   |= pio_modes[pio];
 			csb5_pio     |= (pio << (4*drive->dn));
 			dma_timing   |= dma_modes[2];
-			ultra_timing |= ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
+			ultra_timing |= ((speed - XFER_UDMA_0) << (4*unit));
 			ultra_enable |= (0x01 << drive->dn);
 #endif
 		default:
diff -urN linux-2.5.18/drivers/macintosh/mediabay.c linux/drivers/macintosh/mediabay.c
--- linux-2.5.18/drivers/macintosh/mediabay.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/macintosh/mediabay.c	2002-05-27 16:07:38.000000000 +0200
@@ -569,7 +569,7 @@
 				pmu_suspend();
 				ide_init_hwif_ports(&hw, (ide_ioreg_t) bay->cd_base, (ide_ioreg_t) 0, NULL);
 				hw.irq = bay->cd_irq;
-				bay->cd_index = ide_register_hw(&hw, NULL);
+				bay->cd_index = ide_register_hw(&hw);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
diff -urN linux-2.5.18/include/asm-alpha/ide.h linux/include/asm-alpha/ide.h
--- linux-2.5.18/include/asm-alpha/ide.h	2002-05-25 03:55:23.000000000 +0200
+++ linux/include/asm-alpha/ide.h	2002-05-27 16:10:37.000000000 +0200
@@ -77,7 +77,7 @@
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-arm/arch-anakin/ide.h linux/include/asm-arm/arch-anakin/ide.h
--- linux-2.5.18/include/asm-arm/arch-anakin/ide.h	2002-05-25 03:55:17.000000000 +0200
+++ linux/include/asm-arm/arch-anakin/ide.h	2002-05-27 16:09:24.000000000 +0200
@@ -29,9 +29,9 @@
 		hw->io_ports[i] = reg;
 		reg += regincr;
 	}
-	
+
 	hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
-	
+
 	if (irq)
 		*irq = 0;
 }
@@ -46,10 +46,10 @@
 {
     hw_regs_t hw;
 
-    ide_init_hwif_ports(&hw, IO_BASE + COMPACTFLASH, 
-    			IO_BASE + COMPACTFLASH + IDE_CONTROL_OFFSET, NULL);
+    ide_init_hwif_ports(&hw, IO_BASE + COMPACTFLASH,
+			IO_BASE + COMPACTFLASH + IDE_CONTROL_OFFSET, NULL);
     hw.irq = IRQ_COMPACTFLASH;
-    ide_register_hw(&hw, NULL);
+    ide_register_hw(&hw);
 }
 
 
diff -urN linux-2.5.18/include/asm-arm/arch-arc/ide.h linux/include/asm-arm/arch-arc/ide.h
--- linux-2.5.18/include/asm-arm/arch-arc/ide.h	2002-05-25 03:55:22.000000000 +0200
+++ linux/include/asm-arm/arch-arc/ide.h	2002-05-27 16:09:47.000000000 +0200
@@ -50,6 +50,6 @@
 
 		ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
 		hw.irq = IRQ_HARDDISK;
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 }
diff -urN linux-2.5.18/include/asm-arm/arch-cl7500/ide.h linux/include/asm-arm/arch-cl7500/ide.h
--- linux-2.5.18/include/asm-arm/arch-cl7500/ide.h	2002-05-25 03:55:27.000000000 +0200
+++ linux/include/asm-arm/arch-cl7500/ide.h	2002-05-27 16:10:04.000000000 +0200
@@ -43,8 +43,8 @@
 ide_init_default_hwifs(void)
 {
 	hw_regs_t hw;
-   
+
 	ide_init_hwif_ports(&hw, ISASLOT_IO + 0x1f0, ISASLOT_IO + 0x3f6, NULL);
-   	hw.irq = IRQ_ISA_14;
-	ide_register_hw(&hw, NULL);
+	hw.irq = IRQ_ISA_14;
+	ide_register_hw(&hw);
 }
diff -urN linux-2.5.18/include/asm-arm/arch-ebsa285/ide.h linux/include/asm-arm/arch-ebsa285/ide.h
--- linux-2.5.18/include/asm-arm/arch-ebsa285/ide.h	2002-05-25 03:55:29.000000000 +0200
+++ linux/include/asm-arm/arch-ebsa285/ide.h	2002-05-27 16:09:38.000000000 +0200
@@ -44,6 +44,6 @@
 
 	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
 	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 #endif
 }
diff -urN linux-2.5.18/include/asm-arm/arch-rpc/ide.h linux/include/asm-arm/arch-rpc/ide.h
--- linux-2.5.18/include/asm-arm/arch-rpc/ide.h	2002-05-25 03:55:25.000000000 +0200
+++ linux/include/asm-arm/arch-rpc/ide.h	2002-05-27 16:09:00.000000000 +0200
@@ -44,5 +44,5 @@
 
 	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
 	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 }
diff -urN linux-2.5.18/include/asm-arm/arch-sa1100/ide.h linux/include/asm-arm/arch-sa1100/ide.h
--- linux-2.5.18/include/asm-arm/arch-sa1100/ide.h	2002-05-25 03:55:18.000000000 +0200
+++ linux/include/asm-arm/arch-sa1100/ide.h	2002-05-27 16:08:52.000000000 +0200
@@ -84,10 +84,10 @@
 	   doesn't match the silkscreen however. */
 	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x40, PCMCIA_IO_0_BASE + 0x78, NULL);
 	hw.irq = EMPEG_IRQ_IDE2;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x00, PCMCIA_IO_0_BASE + 0x38, NULL);
 	hw.irq = ,EMPEG_IRQ_IDE1;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 #endif
     }
 
@@ -104,7 +104,7 @@
 
 	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x1f0, PCMCIA_IO_0_BASE + 0x3f6, NULL);
 	hw.irq = IRQ_GPIO7;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 #endif
     }
     else if (machine_is_lart()) {
@@ -114,14 +114,14 @@
         /* Enable GPIO as interrupt line */
         GPDR &= ~LART_GPIO_IDE;
 	set_irq_type(LART_IRQ_IDE, IRQT_RISING);
-        
+
         /* set PCMCIA interface timing */
         MECR = 0x00060006;
 
         /* init the interface */
 	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x0000, PCMCIA_IO_0_BASE + 0x1000, NULL);
         hw.irq = LART_IRQ_IDE;
-        ide_register_hw(&hw, NULL);
+        ide_register_hw(&hw);
 #endif
     }
 }
diff -urN linux-2.5.18/include/asm-arm/arch-shark/ide.h linux/include/asm-arm/arch-shark/ide.h
--- linux-2.5.18/include/asm-arm/arch-shark/ide.h	2002-05-25 03:55:29.000000000 +0200
+++ linux/include/asm-arm/arch-shark/ide.h	2002-05-27 16:10:11.000000000 +0200
@@ -42,6 +42,6 @@
 
 	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
 	hw.irq = 14;
-	ide_register_hw(&hw, NULL);
+	ide_register_hw(&hw);
 }
 
diff -urN linux-2.5.18/include/asm-cris/ide.h linux/include/asm-cris/ide.h
--- linux-2.5.18/include/asm-cris/ide.h	2002-05-25 03:55:20.000000000 +0200
+++ linux/include/asm-cris/ide.h	2002-05-27 16:10:54.000000000 +0200
@@ -84,7 +84,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 }
 
diff -urN linux-2.5.18/include/asm-i386/ide.h linux/include/asm-i386/ide.h
--- linux-2.5.18/include/asm-i386/ide.h	2002-05-25 03:55:19.000000000 +0200
+++ linux/include/asm-i386/ide.h	2002-05-28 11:29:24.000000000 +0200
@@ -41,16 +41,9 @@
 
 static __inline__ ide_ioreg_t ide_default_io_base(int index)
 {
-	switch (index) {
-		case 0:	return 0x1f0;
-		case 1:	return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-		default:
-			return 0;
-	}
+	static unsigned long ata_io_base[MAX_HWIFS] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
+
+	return ata_io_base[index];
 }
 
 static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
@@ -81,7 +74,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-ia64/ide.h linux/include/asm-ia64/ide.h
--- linux-2.5.18/include/asm-ia64/ide.h	2002-05-25 03:55:28.000000000 +0200
+++ linux/include/asm-ia64/ide.h	2002-05-27 16:08:01.000000000 +0200
@@ -87,7 +87,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-mips/ide.h linux/include/asm-mips/ide.h
--- linux-2.5.18/include/asm-mips/ide.h	2002-05-25 03:55:20.000000000 +0200
+++ linux/include/asm-mips/ide.h	2002-05-27 16:10:17.000000000 +0200
@@ -60,7 +60,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-mips64/ide.h linux/include/asm-mips64/ide.h
--- linux-2.5.18/include/asm-mips64/ide.h	2002-05-25 03:55:17.000000000 +0200
+++ linux/include/asm-mips64/ide.h	2002-05-27 16:11:03.000000000 +0200
@@ -63,7 +63,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-parisc/ide.h linux/include/asm-parisc/ide.h
--- linux-2.5.18/include/asm-parisc/ide.h	2002-05-25 03:55:24.000000000 +0200
+++ linux/include/asm-parisc/ide.h	2002-05-27 16:10:23.000000000 +0200
@@ -76,7 +76,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-ppc/ide.h linux/include/asm-ppc/ide.h
--- linux-2.5.18/include/asm-ppc/ide.h	2002-05-25 03:55:24.000000000 +0200
+++ linux/include/asm-ppc/ide.h	2002-05-27 16:08:17.000000000 +0200
@@ -100,7 +100,7 @@
 			continue;
 		ide_init_hwif_ports(&hw, base, 0, NULL);
 		hw.irq = ide_default_irq(base);
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-sh/ide.h linux/include/asm-sh/ide.h
--- linux-2.5.18/include/asm-sh/ide.h	2002-05-25 03:55:22.000000000 +0200
+++ linux/include/asm-sh/ide.h	2002-05-27 16:11:09.000000000 +0200
@@ -102,7 +102,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-sparc/ide.h linux/include/asm-sparc/ide.h
--- linux-2.5.18/include/asm-sparc/ide.h	2002-05-25 03:55:27.000000000 +0200
+++ linux/include/asm-sparc/ide.h	2002-05-27 16:10:48.000000000 +0200
@@ -68,7 +68,7 @@
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-sparc64/ide.h linux/include/asm-sparc64/ide.h
--- linux-2.5.18/include/asm-sparc64/ide.h	2002-05-25 03:55:24.000000000 +0200
+++ linux/include/asm-sparc64/ide.h	2002-05-27 16:10:31.000000000 +0200
@@ -64,7 +64,7 @@
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/asm-x86_64/ide.h linux/include/asm-x86_64/ide.h
--- linux-2.5.18/include/asm-x86_64/ide.h	2002-05-25 03:55:26.000000000 +0200
+++ linux/include/asm-x86_64/ide.h	2002-05-28 11:29:19.000000000 +0200
@@ -41,16 +41,9 @@
 
 static __inline__ ide_ioreg_t ide_default_io_base(int index)
 {
-	switch (index) {
-		case 0:	return 0x1f0;
-		case 1:	return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-		default:
-			return 0;
-	}
+	static unsigned long ata_io_base[MAX_HWIFS] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
+
+	return ata_io_base[index];
 }
 
 static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
@@ -81,7 +74,7 @@
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
+		ide_register_hw(&hw);
 	}
 #endif
 }
diff -urN linux-2.5.18/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.18/include/linux/ide.h	2002-05-28 17:15:53.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-28 12:44:03.000000000 +0200
@@ -71,18 +71,20 @@
 /*
  * Definitions for accessing IDE controller registers
  */
-#define IDE_NR_PORTS		(10)
 
-#define IDE_DATA_OFFSET		(0)
-#define IDE_ERROR_OFFSET	(1)
-#define IDE_NSECTOR_OFFSET	(2)
-#define IDE_SECTOR_OFFSET	(3)
-#define IDE_LCYL_OFFSET		(4)
-#define IDE_HCYL_OFFSET		(5)
-#define IDE_SELECT_OFFSET	(6)
-#define IDE_STATUS_OFFSET	(7)
-#define IDE_CONTROL_OFFSET	(8)
-#define IDE_IRQ_OFFSET		(9)
+enum {
+	IDE_DATA_OFFSET	    = 0,
+	IDE_ERROR_OFFSET    = 1,
+	IDE_NSECTOR_OFFSET  = 2,
+	IDE_SECTOR_OFFSET   = 3,
+	IDE_LCYL_OFFSET	    = 4,
+	IDE_HCYL_OFFSET	    = 5,
+	IDE_SELECT_OFFSET   = 6,
+	IDE_STATUS_OFFSET   = 7,
+	IDE_CONTROL_OFFSET  = 8,
+	IDE_IRQ_OFFSET	    = 9,
+	IDE_NR_PORTS	    = 10
+};
 
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
@@ -549,7 +551,7 @@
 /*
  * Register new hardware with ide
  */
-extern int ide_register_hw(hw_regs_t *hw, struct ata_channel **hwifp);
+extern int ide_register_hw(hw_regs_t *hw);
 extern void ide_unregister(struct ata_channel *hwif);
 
 struct ata_taskfile;
@@ -759,8 +761,6 @@
 extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
 extern int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg);
 
-void ide_delay_50ms(void);
-
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_driveid_update(struct ata_device *);
 extern int ide_config_drive_speed(struct ata_device *, byte);

--------------010909020108080101080708--

