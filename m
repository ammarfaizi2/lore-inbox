Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSFDQ3n>; Tue, 4 Jun 2002 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSFDQ3i>; Tue, 4 Jun 2002 12:29:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22796 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315120AbSFDQ2e>; Tue, 4 Jun 2002 12:28:34 -0400
Message-ID: <3CFCDCFA.4020803@evision-ventures.com>
Date: Tue, 04 Jun 2002 17:30:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.20 IDE 84
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000108040700030409010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108040700030409010901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Jun  4 08:20:56 CEST 2002 ide-clean-84

- Simplify ide_cmd_type_parse by removing the handling of commands which we
   never use.

- Realize that pre_task_out_intr and pre_task_mulout_intr are semanticaly
   identical. Use only pre_task_out_intr(). This allowed us to
   eliminate the prehandler altogether.

- Updated fix for misconfigured host chips by Vojtech Pavlik.

- Be more permissive about ioctl handling to allow device type drivers to do
   they own checks.

- ali14xx cleanups by Andrej Panin.

- Unfold usage ide_cmd_type_parser in tcq.c code. This makes this operation
   local to ide-disk.c. Move it as well as the interrupt handlers used only for
   the handling of disk requests there too.

- Guard against calling handler before the drive is ready for it in
   ata_taskfile()! Well this bug was there before, but right now we inform
   about it.

- Unfold ide_cmd_type_praser in ide-disk.c. Merge the remaining bits of it with
   get_command. Well it's no more.

- Move recal_intr to ide.c - the only place where it's used.

This doesn't change the "mechanics" of the code but it makes it a lot more
"obvious" what's going on.

--------------000108040700030409010901
Content-Type: text/plain;
 name="ide-clean-84.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-84.diff"

diff -urN linux-2.5.20/arch/i386/pci/fixup.c linux/arch/i386/pci/fixup.c
--- linux-2.5.20/arch/i386/pci/fixup.c	2002-06-04 14:06:59.000000000 +0200
+++ linux/arch/i386/pci/fixup.c	2002-06-04 10:21:43.000000000 +0200
@@ -99,17 +99,6 @@
 		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
 }
 
-static void __devinit pci_fixup_ide_exbar(struct pci_dev *d)
-{
-	/*
-	 * Some new Intel IDE controllers have an EXBAR register for
-	 * MMIO instead of PIO. It's unused, undocumented (though maybe
-	 * functional). BIOSes often assign conflicting memory address
-	 * to this. Just kill it.
-	 */
-	d->resource[5].start = d->resource[5].end = d->resource[5].flags = 0;
-}
-
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
 	/*
@@ -185,9 +174,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	pci_fixup_piix4_acpi },
- 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_10,	pci_fixup_ide_exbar },
- 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_11,	pci_fixup_ide_exbar },
- 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_9,	pci_fixup_ide_exbar },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_10,	pci_fixup_ide_trash },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_11,	pci_fixup_ide_trash },
+ 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_9,	pci_fixup_ide_trash },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8622,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
diff -urN linux-2.5.20/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.20/drivers/ide/ali14xx.c	2002-06-03 03:44:48.000000000 +0200
+++ linux/drivers/ide/ali14xx.c	2002-06-04 10:28:53.000000000 +0200
@@ -13,7 +13,7 @@
  * I think the code should be pretty understandable,
  * but I'll be happy to (try to) answer questions.
  *
- * The critical part is in the setupDrive function.  The initRegisters
+ * The critical part is in the ali14xx_tune_drive function.  The init_registers
  * function doesn't seem to be necessary, but the DOS driver does it, so
  * I threw it in.
  *
@@ -37,12 +37,6 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
 
@@ -52,12 +46,14 @@
 
 /* port addresses for auto-detection */
 #define ALI_NUM_PORTS 4
-static int ports[ALI_NUM_PORTS] __initdata = {0x074, 0x0f4, 0x034, 0x0e4};
+static int ports[ALI_NUM_PORTS] __initdata = { 0x074, 0x0f4, 0x034, 0x0e4 };
 
 /* register initialization data */
-typedef struct { byte reg, data; } RegInitializer;
+struct reg_initializer {
+	u8 reg, data; 
+};
 
-static RegInitializer initData[] __initdata = {
+static struct reg_initializer init_data[] __initdata = {
 	{0x01, 0x0f}, {0x02, 0x00}, {0x03, 0x00}, {0x04, 0x00},
 	{0x05, 0x00}, {0x06, 0x00}, {0x07, 0x2b}, {0x0a, 0x0f},
 	{0x25, 0x00}, {0x26, 0x00}, {0x27, 0x00}, {0x28, 0x00},
@@ -68,37 +64,37 @@
 };
 
 /* timing parameter registers for each drive */
-static struct { byte reg1, reg2, reg3, reg4; } regTab[4] = {
-	{0x03, 0x26, 0x04, 0x27},     /* drive 0 */
-	{0x05, 0x28, 0x06, 0x29},     /* drive 1 */
-	{0x2b, 0x30, 0x2c, 0x31},     /* drive 2 */
-	{0x2d, 0x32, 0x2e, 0x33},     /* drive 3 */
+static struct {
+	u8 reg1, reg2, reg3, reg4;
+} reg_tab[4] = {
+	{ 0x03, 0x26, 0x04, 0x27 },	/* drive 0 */
+	{ 0x05, 0x28, 0x06, 0x29 },	/* drive 1 */
+	{ 0x2b, 0x30, 0x2c, 0x31 },	/* drive 2 */
+	{ 0x2d, 0x32, 0x2e, 0x33 },	/* drive 3 */
 };
 
-static int basePort;	/* base port address */
-static int regPort;	/* port for register number */
-static int dataPort;	/* port for register data */
-static byte regOn;	/* output to base port to access registers */
-static byte regOff;	/* output to base port to close registers */
-
-/*------------------------------------------------------------------------*/
+static int base_port;	/* base port address */
+static int reg_port;	/* port for register number */
+static int data_port;	/* port for register data */
+static u8 reg_on;	/* output to base port to access registers */
+static u8 reg_off;	/* output to base port to close registers */
 
 /*
  * Read a controller register.
  */
-static inline byte inReg (byte reg)
+static inline u8 in_reg(u8 reg)
 {
-	outb_p(reg, regPort);
-	return inb(dataPort);
+	outb_p(reg, reg_port);
+	return inb(data_port);
 }
 
 /*
  * Write a controller register.
  */
-static void outReg (byte data, byte reg)
+static inline void out_reg(u8 data, u8 reg)
 {
-	outb_p(reg, regPort);
-	outb_p(data, dataPort);
+	outb_p(reg, reg_port);
+	outb_p(data, data_port);
 }
 
 /*
@@ -108,7 +104,7 @@
  */
 static void ali14xx_tune_drive(struct ata_device *drive, u8 pio)
 {
-	int driveNum;
+	int drive_num;
 	int time1, time2;
 	u8 param1, param2, param3, param4;
 	unsigned long flags;
@@ -117,7 +113,7 @@
 	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
 	else
-		pio = XFER_PIO_0 + min_t(byte, pio, 4);
+		pio = XFER_PIO_0 + min_t(u8, pio, 4);
 
 	t = ata_timing_data(pio);
 
@@ -130,50 +126,50 @@
 		param3 += 8;
 		param4 += 8;
 	}
-	printk("%s: PIO mode%d, t1=%dns, t2=%dns, cycles = %d+%d, %d+%d\n",
+	printk(KERN_DEBUG "%s: PIO mode%d, t1=%dns, t2=%dns, cycles = %d+%d, %d+%d\n",
 		drive->name, pio - XFER_PIO_0, time1, time2, param1, param2, param3, param4);
 
 	/* stuff timing parameters into controller registers */
-	driveNum = (drive->channel->index << 1) + drive->select.b.unit;
+	drive_num = (drive->channel->index << 1) + drive->select.b.unit;
 	save_flags(flags);	/* all CPUs */
 	cli();			/* all CPUs */
-	outb_p(regOn, basePort);
-	outReg(param1, regTab[driveNum].reg1);
-	outReg(param2, regTab[driveNum].reg2);
-	outReg(param3, regTab[driveNum].reg3);
-	outReg(param4, regTab[driveNum].reg4);
-	outb_p(regOff, basePort);
+	outb_p(reg_on, base_port);
+	out_reg(param1, reg_tab[drive_num].reg1);
+	out_reg(param2, reg_tab[drive_num].reg2);
+	out_reg(param3, reg_tab[drive_num].reg3);
+	out_reg(param4, reg_tab[drive_num].reg4);
+	outb_p(reg_off, base_port);
 	restore_flags(flags);	/* all CPUs */
 }
 
 /*
  * Auto-detect the IDE controller port.
  */
-static int __init findPort (void)
+static int __init find_port(void)
 {
 	int i;
-	byte t;
 	unsigned long flags;
 
 	__save_flags(flags);	/* local CPU only */
 	__cli();		/* local CPU only */
-	for (i = 0; i < ALI_NUM_PORTS; ++i) {
-		basePort = ports[i];
-		regOff = inb(basePort);
-		for (regOn = 0x30; regOn <= 0x33; ++regOn) {
-			outb_p(regOn, basePort);
-			if (inb(basePort) == regOn) {
-				regPort = basePort + 4;
-				dataPort = basePort + 8;
-				t = inReg(0) & 0xf0;
-				outb_p(regOff, basePort);
+	for (i = 0; i < ALI_NUM_PORTS; i++) {
+		base_port = ports[i];
+		reg_off = inb(base_port);
+		for (reg_on = 0x30; reg_on <= 0x33; reg_on++) {
+			outb_p(reg_on, base_port);
+			if (inb(base_port) == reg_on) {
+				u8 t;
+				reg_port = base_port + 4;
+				data_port = base_port + 8;
+				t = in_reg(0) & 0xf0;
+				outb_p(reg_off, base_port);
 				__restore_flags(flags);	/* local CPU only */
 				if (t != 0x50)
 					return 0;
-				return 1;  /* success */
+				return 1;	/* success */
 			}
 		}
-		outb_p(regOff, basePort);
+		outb_p(reg_off, base_port);
 	}
 	__restore_flags(flags);	/* local CPU only */
 	return 0;
@@ -182,32 +178,34 @@
 /*
  * Initialize controller registers with default values.
  */
-static int __init initRegisters (void) {
-	RegInitializer *p;
-	byte t;
+static int __init init_registers(void)
+{
+	struct reg_initializer *p;
 	unsigned long flags;
+	u8 t;
 
 	__save_flags(flags);	/* local CPU only */
 	__cli();		/* local CPU only */
-	outb_p(regOn, basePort);
-	for (p = initData; p->reg != 0; ++p)
-		outReg(p->data, p->reg);
-	outb_p(0x01, regPort);
-	t = inb(regPort) & 0x01;
-	outb_p(regOff, basePort);
+	outb_p(reg_on, base_port);
+	for (p = init_data; p->reg != 0; ++p)
+		out_reg(p->data, p->reg);
+	outb_p(0x01, reg_port);
+	t = inb(reg_port) & 0x01;
+	outb_p(reg_off, base_port);
 	__restore_flags(flags);	/* local CPU only */
 	return t;
 }
 
-void __init init_ali14xx (void)
+void __init init_ali14xx(void)
 {
 	/* auto-detect IDE controller port */
-	if (!findPort()) {
-		printk("\nali14xx: not found");
+	if (!find_port()) {
+		printk(KERN_ERR "ali14xx: not found\n");
 		return;
 	}
 
-	printk("\nali14xx: base= 0x%03x, regOn = 0x%02x", basePort, regOn);
+	printk(KERN_DEBUG "ali14xx: base=%#03x, reg_on=%#02x\n",
+		base_port, reg_on);
 	ide_hwifs[0].chipset = ide_ali14xx;
 	ide_hwifs[1].chipset = ide_ali14xx;
 	ide_hwifs[0].tuneproc = &ali14xx_tune_drive;
@@ -216,8 +214,8 @@
 	ide_hwifs[1].unit = ATA_SECONDARY;
 
 	/* initialize controller registers */
-	if (!initRegisters()) {
-		printk("\nali14xx: Chip initialization failed");
+	if (!init_registers()) {
+		printk(KERN_ERR "ali14xx: Chip initialization failed\n");
 		return;
 	}
 }
diff -urN linux-2.5.20/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.20/drivers/ide/ide.c	2002-06-04 14:06:59.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-04 12:31:58.000000000 +0200
@@ -67,9 +67,6 @@
 #include "pcihost.h"
 #include "ioctl.h"
 
-/* default maximum number of failures */
-#define IDE_DEFAULT_MAX_FAILURES	1
-
 /*
  * CompactFlash cards and their relatives pretend to be removable hard disks, except:
  *	(1) they never have a slave unit, and
@@ -555,6 +552,19 @@
 #endif
 
 /*
+ * This is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
+ *
+ * FIXME: Why can't be just use task_no_data_intr here?
+ */
+static ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
+{
+	if (!ata_status(drive, READY_STAT, BAD_STAT))
+		return ata_error(drive, rq, __FUNCTION__);
+
+	return ide_stopped;
+}
+
+/*
  * We are still on the old request path here so issuing the recalibrate command
  * directly should just work.
  */
@@ -572,6 +582,7 @@
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
 		args.handler = recal_intr;
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 		ata_taskfile(drive, &args, NULL);
 	}
 
diff -urN linux-2.5.20/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.20/drivers/ide/ide-disk.c	2002-06-03 03:44:38.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-04 12:21:17.000000000 +0200
@@ -90,7 +90,224 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-static u8 get_command(struct ata_device *drive, int cmd)
+/*
+ * Handler for command with PIO data-in phase
+ */
+static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
+{
+	char *buf = NULL;
+	unsigned long flags;
+
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT|DRQ_STAT))
+			return ata_error(drive, rq, __FUNCTION__);
+
+		if (!(drive->status & BUSY_STAT)) {
+#if 0
+			printk("task_in_intr to Soon wait for next interrupt\n");
+#endif
+			ide_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
+
+			return ide_started;
+		}
+	}
+	buf = ide_map_rq(rq, &flags);
+#if 0
+	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+#endif
+
+	ata_read(drive, buf, SECTOR_WORDS);
+	ide_unmap_rq(rq, buf, &flags);
+
+	/* First segment of the request is complete. note that this does not
+	 * necessarily mean that the entire request is done!! this is only true
+	 * if ide_end_request() returns 0.
+	 */
+
+	if (--rq->current_nr_sectors <= 0) {
+#if 0
+		printk("Request Ended stat: %02x\n", drive->status);
+#endif
+		if (!ide_end_request(drive, rq, 1))
+			return ide_stopped;
+	}
+
+	/* still data left to transfer */
+	ide_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
+
+	return ide_started;
+}
+
+/*
+ * Handler for command with PIO data-out phase
+ */
+static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
+{
+	char *buf = NULL;
+	unsigned long flags;
+
+	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
+		return ata_error(drive, rq, __FUNCTION__);
+
+	if (!rq->current_nr_sectors)
+		if (!ide_end_request(drive, rq, 1))
+			return ide_stopped;
+
+	if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
+		buf = ide_map_rq(rq, &flags);
+#if 0
+		printk("write: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+#endif
+
+		ata_write(drive, buf, SECTOR_WORDS);
+		ide_unmap_rq(rq, buf, &flags);
+		rq->errors = 0;
+		rq->current_nr_sectors--;
+	}
+
+	ide_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
+
+	return ide_started;
+}
+
+/*
+ * Handler for command with Read Multiple
+ */
+static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
+{
+	char *buf = NULL;
+	unsigned int msect, nsect;
+	unsigned long flags;
+
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT|DRQ_STAT))
+			return ata_error(drive, rq, __FUNCTION__);
+
+		/* no data yet, so wait for another interrupt */
+		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+		return ide_started;
+	}
+
+	/* (ks/hs): Fixed Multi-Sector transfer */
+	msect = drive->mult_count;
+
+	do {
+		nsect = rq->current_nr_sectors;
+		if (nsect > msect)
+			nsect = msect;
+
+		buf = ide_map_rq(rq, &flags);
+
+#if 0
+		printk("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
+			buf, nsect, rq->current_nr_sectors);
+#endif
+		ata_read(drive, buf, nsect * SECTOR_WORDS);
+		ide_unmap_rq(rq, buf, &flags);
+		rq->errors = 0;
+		rq->current_nr_sectors -= nsect;
+		msect -= nsect;
+		if (!rq->current_nr_sectors) {
+			if (!ide_end_request(drive, rq, 1))
+				return ide_stopped;
+		}
+	} while (msect);
+
+
+	/*
+	 * more data left
+	 */
+	ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
+
+	return ide_started;
+}
+
+static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
+{
+	int ok;
+	int mcount = drive->mult_count;
+	ide_startstop_t startstop;
+
+
+	/*
+	 * FIXME: the drive->status checks here seem to be messy.
+	 *
+	 * (ks/hs): Handle last IRQ on multi-sector transfer,
+	 * occurs after all data was sent in this chunk
+	 */
+
+	ok = ata_status(drive, DATA_READY, BAD_R_STAT);
+
+	if (!ok || !rq->nr_sectors) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
+			startstop = ata_error(drive, rq, __FUNCTION__);
+
+			return startstop;
+		}
+	}
+
+	if (!rq->nr_sectors) {
+		__ide_end_request(drive, rq, 1, rq->hard_nr_sectors);
+		rq->bio = NULL;
+
+		return ide_stopped;
+	}
+
+	if (!ok) {
+		/* no data yet, so wait for another interrupt */
+		if (!drive->channel->handler)
+			ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
+
+		return ide_started;
+	}
+
+	do {
+		char *buffer;
+		int nsect = rq->current_nr_sectors;
+		unsigned long flags;
+
+		if (nsect > mcount)
+			nsect = mcount;
+		mcount -= nsect;
+
+		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
+		rq->sector += nsect;
+		rq->nr_sectors -= nsect;
+		rq->current_nr_sectors -= nsect;
+
+		/* Do we move to the next bio after this? */
+		if (!rq->current_nr_sectors) {
+			/* remember to fix this up /jens */
+			struct bio *bio = rq->bio->bi_next;
+
+			/* end early if we ran out of requests */
+			if (!bio) {
+				mcount = 0;
+			} else {
+				rq->bio = bio;
+				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+			}
+		}
+
+		/*
+		 * Ok, we're all setup for the interrupt re-entering us on the
+		 * last transfer.
+		 */
+		ata_write(drive, buffer, nsect * SECTOR_WORDS);
+		bio_kunmap_irq(buffer, &flags);
+	} while (mcount);
+
+	rq->errors = 0;
+	if (!drive->channel->handler)
+		ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
+
+	return ide_started;
+}
+
+/*
+ * Decode with physical ATA command to use and setup associated data.
+ */
+static u8 get_command(struct ata_device *drive, struct ata_taskfile *ar, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
 
@@ -100,45 +317,64 @@
 
 	if (lba48bit) {
 		if (cmd == READ) {
-			if (drive->using_tcq)
+			ar->command_type = IDE_DRIVE_TASK_IN;
+			if (drive->using_tcq) {
 				return WIN_READDMA_QUEUED_EXT;
-			if (drive->using_dma)
+			} else if (drive->using_dma) {
 				return WIN_READDMA_EXT;
-			else if (drive->mult_count)
+			} else if (drive->mult_count) {
+				ar->handler = task_mulin_intr;
 				return WIN_MULTREAD_EXT;
-			else
+			} else {
+				ar->handler = task_in_intr;
 				return WIN_READ_EXT;
+			}
 		} else if (cmd == WRITE) {
-			if (drive->using_tcq)
+			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			if (drive->using_tcq) {
 				return WIN_WRITEDMA_QUEUED_EXT;
-			if (drive->using_dma)
+			} else if (drive->using_dma) {
 				return WIN_WRITEDMA_EXT;
-			else if (drive->mult_count)
+			} else if (drive->mult_count) {
+				ar->handler = task_mulout_intr;
 				return WIN_MULTWRITE_EXT;
-			else
+			} else {
+				ar->handler = task_out_intr;
 				return WIN_WRITE_EXT;
+			}
 		}
 	} else {
 		if (cmd == READ) {
-			if (drive->using_tcq)
+			ar->command_type = IDE_DRIVE_TASK_IN;
+			if (drive->using_tcq) {
 				return WIN_READDMA_QUEUED;
-			if (drive->using_dma)
+			} else if (drive->using_dma) {
 				return WIN_READDMA;
-			else if (drive->mult_count)
+			} else if (drive->mult_count) {
+				ar->handler = task_in_intr;
 				return WIN_MULTREAD;
-			else
+			} else {
+				ar->handler = task_in_intr;
 				return WIN_READ;
+			}
 		} else if (cmd == WRITE) {
-			if (drive->using_tcq)
+			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			if (drive->using_tcq) {
 				return WIN_WRITEDMA_QUEUED;
-			if (drive->using_dma)
+			} else if (drive->using_dma) {
 				return WIN_WRITEDMA;
-			else if (drive->mult_count)
+			} else if (drive->mult_count) {
+				ar->handler = task_mulout_intr;
 				return WIN_MULTWRITE;
-			else
+			} else {
+				ar->handler = task_out_intr;
 				return WIN_WRITE;
+			}
 		}
 	}
+	ar->handler = task_no_data_intr;
+	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
+
 	return WIN_NOP;
 }
 
@@ -170,7 +406,7 @@
 
 	args.taskfile.device_head = head;
 	args.taskfile.device_head |= drive->select.all;
-	args.cmd =  get_command(drive, rq_data_dir(rq));
+	args.cmd = get_command(drive, &args, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -181,7 +417,6 @@
 	printk("buffer=%p\n", rq->buffer);
 #endif
 
-	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive, &args, rq);
@@ -211,7 +446,7 @@
 
 	args.taskfile.device_head = ((block >> 8) & 0x0f);
 	args.taskfile.device_head |= drive->select.all;
-	args.cmd = get_command(drive, rq_data_dir(rq));
+	args.cmd = get_command(drive, &args, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -222,7 +457,6 @@
 	printk("buffer=%p\n", rq->buffer);
 #endif
 
-	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive, &args, rq);
@@ -264,7 +498,7 @@
 	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
 	args.hobfile.device_head = drive->select.all;
 
-	args.cmd = get_command(drive, rq_data_dir(rq));
+	args.cmd = get_command(drive, &args, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -275,7 +509,6 @@
 	printk("buffer=%p\n",rq->buffer);
 #endif
 
-	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive, &args, rq);
@@ -354,9 +587,9 @@
 		check_disk_change(inode->i_rdev);
 
 		memset(&args, 0, sizeof(args));
-
 		args.cmd = WIN_DOORLOCK;
-		ide_cmd_type_parser(&args);
+		args.handler = task_no_data_intr;
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 		/*
 		 * Ignore the return code from door_lock, since the open() has
@@ -381,7 +614,8 @@
 	else
 		args.cmd = WIN_FLUSH_CACHE;
 
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	return ide_raw_taskfile(drive, &args);
 }
@@ -396,7 +630,8 @@
 
 		memset(&args, 0, sizeof(args));
 		args.cmd = WIN_DOORUNLOCK;
-		ide_cmd_type_parser(&args);
+		args.handler = task_no_data_intr;
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 		if (drive->doorlocking &&
 		    ide_raw_taskfile(drive, &args))
@@ -445,7 +680,8 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	if (!ide_raw_taskfile(drive, &args)) {
 		/* all went well track this setting as valid */
@@ -476,7 +712,9 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+
 	ide_raw_taskfile(drive, &args);
 
 	drive->wcache = arg;
@@ -490,7 +728,8 @@
 
 	memset(&args, 0, sizeof(args));
 	args.cmd = WIN_STANDBYNOW1;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	return ide_raw_taskfile(drive, &args);
 }
@@ -503,7 +742,9 @@
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+
 	ide_raw_taskfile(drive, &args);
 
 	drive->acoustic = arg;
diff -urN linux-2.5.20/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.20/drivers/ide/ide-taskfile.c	2002-06-03 03:44:50.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-04 12:43:06.000000000 +0200
@@ -42,24 +42,6 @@
 #endif
 
 /*
- * for now, taskfile requests are special :/
- */
-static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
-{
-	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
-	else
-		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
-}
-
-static inline void ide_unmap_rq(struct request *rq, char *to,
-				unsigned long *flags)
-{
-	if (rq->bio)
-		bio_kunmap_irq(to, flags);
-}
-
-/*
  * Data transfer functions for polled IO.
  */
 
@@ -195,119 +177,24 @@
 }
 
 /*
- * Polling wait until the drive is ready.
- *
- * Stuff the first sector(s) by implicitly calling the handler driectly
- * therafter.
+ * Handler for commands without a data phase
  */
-void ata_poll_drive_ready(struct ata_device *drive)
-{
-	int i;
-
-	if (drive_is_ready(drive))
-		return;
-
-	/* FIXME: Replace hard-coded 100, what about error handling?
-	 */
-	for (i = 0; i < 100; ++i) {
-		if (drive_is_ready(drive))
-			break;
-	}
-}
-
-static ide_startstop_t pre_task_mulout_intr(struct ata_device *drive, struct request *rq)
-{
-	struct ata_taskfile *args = rq->special;
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ))
-		return startstop;
-
-	ata_poll_drive_ready(drive);
-
-	return args->handler(drive, rq);
-}
-
-static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
+ide_startstop_t task_no_data_intr(struct ata_device *drive, struct request *rq)
 {
-	int ok;
-	int mcount = drive->mult_count;
-	ide_startstop_t startstop;
-
-
-	/*
-	 * FIXME: the drive->status checks here seem to be messy.
-	 *
-	 * (ks/hs): Handle last IRQ on multi-sector transfer,
-	 * occurs after all data was sent in this chunk
-	 */
-
-	ok = ata_status(drive, DATA_READY, BAD_R_STAT);
-
-	if (!ok || !rq->nr_sectors) {
-		if (drive->status & (ERR_STAT | DRQ_STAT)) {
-			startstop = ata_error(drive, rq, __FUNCTION__);
-
-			return startstop;
-		}
-	}
-
-	if (!rq->nr_sectors) {
-		__ide_end_request(drive, rq, 1, rq->hard_nr_sectors);
-		rq->bio = NULL;
-
-		return ide_stopped;
-	}
+	struct ata_taskfile *ar = rq->special;
 
-	if (!ok) {
-		/* no data yet, so wait for another interrupt */
-		if (!drive->channel->handler)
-			ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
+	ide__sti();	/* local CPU only */
 
-		return ide_started;
+	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
+		/* Keep quiet for NOP because it is expected to fail. */
+		if (ar && ar->cmd != WIN_NOP)
+			return ata_error(drive, rq, __FUNCTION__);
 	}
 
-	do {
-		char *buffer;
-		int nsect = rq->current_nr_sectors;
-		unsigned long flags;
-
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-
-		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
-		rq->sector += nsect;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bio after this? */
-		if (!rq->current_nr_sectors) {
-			/* remember to fix this up /jens */
-			struct bio *bio = rq->bio->bi_next;
-
-			/* end early if we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
-			}
-		}
-
-		/*
-		 * Ok, we're all setup for the interrupt re-entering us on the
-		 * last transfer.
-		 */
-		ata_write(drive, buffer, nsect * SECTOR_WORDS);
-		bio_kunmap_irq(buffer, &flags);
-	} while (mcount);
-
-	rq->errors = 0;
-	if (!drive->channel->handler)
-		ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
+	if (ar)
+		ide_end_drive_cmd(drive, rq);
 
-	return ide_started;
+	return ide_stopped;
 }
 
 ide_startstop_t ata_taskfile(struct ata_device *drive,
@@ -315,8 +202,11 @@
 {
 	struct hd_driveid *id = drive->id;
 
-	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (ar->handler != task_mulout_intr) {
+	/* (ks/hs): Moved to start, do not use for multiple out commands.
+	 * FIXME: why not?! */
+	if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+	      ar->cmd == WIN_MULTWRITE ||
+	      ar->cmd == WIN_MULTWRITE_EXT)) {
 		ata_irq_enable(drive, 1);
 		ata_mask(drive);
 	}
@@ -324,14 +214,12 @@
 	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
 	    (drive->addressing == 1))
 		ata_out_regfile(drive, &ar->hobfile);
-
 	ata_out_regfile(drive, &ar->taskfile);
 
-	{
-		u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
-		OUT_BYTE((ar->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
-	}
-	if (ar->handler != NULL) {
+	OUT_BYTE((ar->taskfile.device_head & (drive->addressing ? 0xE0 : 0xEF)) | drive->select.all,
+			IDE_SELECT_REG);
+
+	if (ar->handler) {
 
 		/* This is apparently supposed to reset the wait timeout for
 		 * the interrupt to accur.
@@ -340,34 +228,90 @@
 		ide_set_handler(drive, ar->handler, WAIT_CMD, NULL);
 		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
 
-		/*
-		 * Warning check for race between handler and prehandler for
-		 * writing first block of data.  however since we are well
+		/* FIXME: Warning check for race between handler and prehandler
+		 * for writing first block of data.  however since we are well
 		 * inside the boundaries of the seek, we should be okay.
+		 *
+		 * FIXME: Replace the switch by using a proper command_type.
 		 */
 
-		if (ar->prehandler != NULL)
-			return ar->prehandler(drive, rq);
+		if (ar->cmd == CFA_WRITE_SECT_WO_ERASE ||
+		    ar->cmd == WIN_WRITE ||
+		    ar->cmd == WIN_WRITE_EXT ||
+		    ar->cmd == WIN_WRITE_VERIFY ||
+		    ar->cmd == WIN_WRITE_BUFFER ||
+		    ar->cmd == WIN_DOWNLOAD_MICROCODE ||
+		    ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+		    ar->cmd == WIN_MULTWRITE ||
+		    ar->cmd == WIN_MULTWRITE_EXT) {
+			ide_startstop_t startstop;
+
+			if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
+				printk(KERN_ERR "%s: no DRQ after issuing %s\n",
+						drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
+				return startstop;
+			}
+
+			/* FIXME: This doesn't make the slightest sense.
+			 * (ks/hs): Fixed Multi Write
+			 */
+			if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+			      ar->cmd == WIN_MULTWRITE ||
+			      ar->cmd == WIN_MULTWRITE_EXT)) {
+				unsigned long flags;
+				char *buf = ide_map_rq(rq, &flags);
+
+				/* For Write_sectors we need to stuff the first sector */
+				ata_write(drive, buf, SECTOR_WORDS);
+
+				rq->current_nr_sectors--;
+				ide_unmap_rq(rq, buf, &flags);
+
+				return ide_started;
+			} else {
+				int i;
+
+				/* Polling wait until the drive is ready.
+				 *
+				 * Stuff the first sector(s) by calling the
+				 * handler driectly therafter.
+				 *
+				 * FIXME: Replace hard-coded 100, what about
+				 * error handling?
+				 */
+
+				for (i = 0; i < 100; ++i) {
+					if (drive_is_ready(drive))
+						break;
+				}
+				if (!drive_is_ready(drive)) {
+					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
+				}
+				return ar->handler(drive, rq);
+			}
+		}
 	} else {
 		/*
 		 * FIXME: This is a gross hack, need to unify tcq dma proc and
 		 * regular dma proc. It should now be easier.
+		 *
+		 * FIXME: Handle the alternateives by a command type.
 		 */
 
 		if (!drive->using_dma)
 			return ide_started;
 
 		/* for dma commands we don't set the handler */
-		if (ar->cmd == WIN_WRITEDMA
-		      || ar->cmd == WIN_WRITEDMA_EXT
-		      || ar->cmd == WIN_READDMA
-		      || ar->cmd == WIN_READDMA_EXT)
+		if (ar->cmd == WIN_WRITEDMA ||
+		    ar->cmd == WIN_WRITEDMA_EXT ||
+		    ar->cmd == WIN_READDMA ||
+		    ar->cmd == WIN_READDMA_EXT)
 			return !udma_init(drive, rq);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-		else if (ar->cmd == WIN_WRITEDMA_QUEUED
-		      || ar->cmd == WIN_WRITEDMA_QUEUED_EXT
-		      || ar->cmd == WIN_READDMA_QUEUED
-		      || ar->cmd == WIN_READDMA_QUEUED_EXT)
+		else if (ar->cmd == WIN_WRITEDMA_QUEUED ||
+			 ar->cmd == WIN_WRITEDMA_QUEUED_EXT ||
+			 ar->cmd == WIN_READDMA_QUEUED ||
+			 ar->cmd == WIN_READDMA_QUEUED_EXT)
 			return udma_tcq_taskfile(drive, rq);
 #endif
 		else {
@@ -380,363 +324,6 @@
 }
 
 /*
- * This is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
- */
-ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
-{
-	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ata_error(drive, rq, __FUNCTION__);
-
-	return ide_stopped;
-}
-
-/*
- * Handler for commands without a data phase
- */
-ide_startstop_t task_no_data_intr(struct ata_device *drive, struct request *rq)
-{
-	struct ata_taskfile *ar = rq->special;
-
-	ide__sti();	/* local CPU only */
-
-	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
-		/* Keep quiet for NOP because it is expected to fail. */
-		if (ar && ar->cmd != WIN_NOP)
-			return ata_error(drive, rq, __FUNCTION__);
-	}
-
-	if (ar)
-		ide_end_drive_cmd(drive, rq);
-
-	return ide_stopped;
-}
-
-/*
- * Handler for command with PIO data-in phase
- */
-static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
-{
-	char *buf = NULL;
-	unsigned long flags;
-
-	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT))
-			return ata_error(drive, rq, __FUNCTION__);
-
-		if (!(drive->status & BUSY_STAT)) {
-			DTF("task_in_intr to Soon wait for next interrupt\n");
-			ide_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
-
-			return ide_started;
-		}
-	}
-	DTF("stat: %02x\n", drive->status);
-	buf = ide_map_rq(rq, &flags);
-	DTF("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
-
-	ata_read(drive, buf, SECTOR_WORDS);
-	ide_unmap_rq(rq, buf, &flags);
-
-	/* First segment of the request is complete. note that this does not
-	 * necessarily mean that the entire request is done!! this is only true
-	 * if ide_end_request() returns 0.
-	 */
-
-	if (--rq->current_nr_sectors <= 0) {
-		DTF("Request Ended stat: %02x\n", drive->status);
-		if (!ide_end_request(drive, rq, 1))
-			return ide_stopped;
-	}
-
-	/* still data left to transfer */
-	ide_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
-
-	return ide_started;
-}
-
-static ide_startstop_t pre_task_out_intr(struct ata_device *drive, struct request *rq)
-{
-	struct ata_taskfile *args = rq->special;
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, rq, DATA_READY, drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing %s\n", drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
-		return startstop;
-	}
-
-	/* (ks/hs): Fixed Multi Write */
-	if ((args->cmd != WIN_MULTWRITE) &&
-	    (args->cmd != WIN_MULTWRITE_EXT)) {
-		unsigned long flags;
-		char *buf = ide_map_rq(rq, &flags);
-		/* For Write_sectors we need to stuff the first sector */
-		ata_write(drive, buf, SECTOR_WORDS);
-		rq->current_nr_sectors--;
-		ide_unmap_rq(rq, buf, &flags);
-	} else {
-		ata_poll_drive_ready(drive);
-		return args->handler(drive, rq);
-	}
-	return ide_started;
-}
-
-/*
- * Handler for command with PIO data-out phase
- */
-static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
-{
-	char *buf = NULL;
-	unsigned long flags;
-
-	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
-		return ata_error(drive, rq, __FUNCTION__);
-
-	if (!rq->current_nr_sectors)
-		if (!ide_end_request(drive, rq, 1))
-			return ide_stopped;
-
-	if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
-		buf = ide_map_rq(rq, &flags);
-		DTF("write: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
-
-		ata_write(drive, buf, SECTOR_WORDS);
-		ide_unmap_rq(rq, buf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors--;
-	}
-
-	ide_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
-
-	return ide_started;
-}
-
-/*
- * Handler for command with Read Multiple
- */
-static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
-{
-	char *buf = NULL;
-	unsigned int msect, nsect;
-	unsigned long flags;
-
-	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT))
-			return ata_error(drive, rq, __FUNCTION__);
-
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
-		return ide_started;
-	}
-
-	/* (ks/hs): Fixed Multi-Sector transfer */
-	msect = drive->mult_count;
-
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-
-		buf = ide_map_rq(rq, &flags);
-
-		DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %d\n",
-			buf, nsect, rq->current_nr_sectors);
-		ata_read(drive, buf, nsect * SECTOR_WORDS);
-		ide_unmap_rq(rq, buf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors -= nsect;
-		msect -= nsect;
-		if (!rq->current_nr_sectors) {
-			if (!ide_end_request(drive, rq, 1))
-				return ide_stopped;
-		}
-	} while (msect);
-
-
-	/*
-	 * more data left
-	 */
-	ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
-
-	return ide_started;
-}
-
-/* Called to figure out the type of command being called.
- */
-void ide_cmd_type_parser(struct ata_taskfile *ar)
-{
-	struct hd_drive_task_hdr *taskfile = &ar->taskfile;
-
-	ar->prehandler = NULL;
-	ar->handler = NULL;
-
-	switch (ar->cmd) {
-		case WIN_IDENTIFY:
-		case WIN_PIDENTIFY:
-		case CFA_TRANSLATE_SECTOR:
-		case WIN_READ:
-		case WIN_READ_EXT:
-		case WIN_READ_BUFFER:
-			ar->handler = task_in_intr;
-			ar->command_type = IDE_DRIVE_TASK_IN;
-			return;
-
-		case CFA_WRITE_SECT_WO_ERASE:
-		case WIN_WRITE:
-		case WIN_WRITE_EXT:
-		case WIN_WRITE_VERIFY:
-		case WIN_WRITE_BUFFER:
-		case WIN_DOWNLOAD_MICROCODE:
-			ar->prehandler = pre_task_out_intr;
-			ar->handler = task_out_intr;
-			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-			return;
-
-		case WIN_MULTREAD:
-		case WIN_MULTREAD_EXT:
-			ar->handler = task_mulin_intr;
-			ar->command_type = IDE_DRIVE_TASK_IN;
-			return;
-
-		case CFA_WRITE_MULTI_WO_ERASE:
-		case WIN_MULTWRITE:
-		case WIN_MULTWRITE_EXT:
-			ar->prehandler = pre_task_mulout_intr;
-			ar->handler = task_mulout_intr;
-			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-			return;
-
-		case WIN_SECURITY_DISABLE:
-		case WIN_SECURITY_ERASE_UNIT:
-		case WIN_SECURITY_SET_PASS:
-		case WIN_SECURITY_UNLOCK:
-			ar->handler = task_out_intr;
-			ar->command_type = IDE_DRIVE_TASK_OUT;
-			return;
-
-		case WIN_SMART:
-			if (taskfile->feature == SMART_WRITE_LOG_SECTOR)
-				ar->prehandler = pre_task_out_intr;
-
-			ar->taskfile.low_cylinder = SMART_LCYL_PASS;
-			ar->taskfile.high_cylinder = SMART_HCYL_PASS;
-
-			switch(ar->taskfile.feature) {
-				case SMART_READ_VALUES:
-				case SMART_READ_THRESHOLDS:
-				case SMART_READ_LOG_SECTOR:
-					ar->handler = task_in_intr;
-					ar->command_type = IDE_DRIVE_TASK_IN;
-					return;
-
-				case SMART_WRITE_LOG_SECTOR:
-					ar->handler = task_out_intr;
-					ar->command_type = IDE_DRIVE_TASK_OUT;
-					return;
-
-				default:
-					ar->handler = task_no_data_intr;
-					ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-					return;
-
-			}
-#ifdef CONFIG_BLK_DEV_IDEDMA
-		case WIN_READDMA:
-		case WIN_IDENTIFY_DMA:
-		case WIN_READDMA_QUEUED:
-		case WIN_READDMA_EXT:
-		case WIN_READDMA_QUEUED_EXT:
-			ar->command_type = IDE_DRIVE_TASK_IN;
-			return;
-
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_QUEUED:
-		case WIN_WRITEDMA_EXT:
-		case WIN_WRITEDMA_QUEUED_EXT:
-			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-			return;
-
-#endif
-		case WIN_SETFEATURES:
-			ar->handler = task_no_data_intr;
-			switch (ar->taskfile.feature) {
-				case SETFEATURES_XFER:
-					ar->command_type = IDE_DRIVE_TASK_SET_XFER;
-					return;
-				case SETFEATURES_DIS_DEFECT:
-				case SETFEATURES_EN_APM:
-				case SETFEATURES_DIS_MSN:
-				case SETFEATURES_EN_RI:
-				case SETFEATURES_EN_SI:
-				case SETFEATURES_DIS_RPOD:
-				case SETFEATURES_DIS_WCACHE:
-				case SETFEATURES_EN_DEFECT:
-				case SETFEATURES_DIS_APM:
-				case SETFEATURES_EN_MSN:
-				case SETFEATURES_EN_RLA:
-				case SETFEATURES_PREFETCH:
-				case SETFEATURES_EN_RPOD:
-				case SETFEATURES_DIS_RI:
-				case SETFEATURES_DIS_SI:
-				default:
-					ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-					return;
-			}
-
-		case WIN_SPECIFY:
-			ar->handler = task_no_data_intr;
-			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-			return;
-
-		case WIN_RESTORE:
-			ar->handler = recal_intr;
-			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-			return;
-
-		case WIN_DIAGNOSE:
-		case WIN_FLUSH_CACHE:
-		case WIN_FLUSH_CACHE_EXT:
-		case WIN_STANDBYNOW1:
-		case WIN_STANDBYNOW2:
-		case WIN_SLEEPNOW1:
-		case WIN_SLEEPNOW2:
-		case WIN_SETIDLE1:
-		case WIN_CHECKPOWERMODE1:
-		case WIN_CHECKPOWERMODE2:
-		case WIN_GETMEDIASTATUS:
-		case WIN_MEDIAEJECT:
-		case CFA_REQ_EXT_ERROR_CODE:
-		case CFA_ERASE_SECTORS:
-		case WIN_VERIFY:
-		case WIN_VERIFY_EXT:
-		case WIN_SEEK:
-		case WIN_READ_NATIVE_MAX:
-		case WIN_SET_MAX:
-		case WIN_READ_NATIVE_MAX_EXT:
-		case WIN_SET_MAX_EXT:
-		case WIN_SECURITY_ERASE_PREPARE:
-		case WIN_SECURITY_FREEZE_LOCK:
-		case WIN_DOORLOCK:
-		case WIN_DOORUNLOCK:
-		case DISABLE_SEAGATE:
-		case EXABYTE_ENABLE_NEST:
-		case WIN_SETMULT:
-		case WIN_NOP:
-			ar->handler = task_no_data_intr;
-			ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-			return;
-
-		case WIN_FORMAT:
-		case WIN_INIT:
-		case WIN_DEVICE_RESET:
-		case WIN_QUEUED_SERVICE:
-		case WIN_PACKETCMD:
-		default:
-			ar->command_type = IDE_DRIVE_TASK_INVALID;
-			return;
-	}
-}
-
-/*
  * This function issues a special IDE device request onto the request queue.
  *
  * If action is ide_wait, then the rq is queued at the end of the request
@@ -813,8 +400,6 @@
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
 EXPORT_SYMBOL(ata_taskfile);
-EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(task_no_data_intr);
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_raw_taskfile);
-EXPORT_SYMBOL(ide_cmd_type_parser);
diff -urN linux-2.5.20/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.20/drivers/ide/ioctl.c	2002-06-03 03:44:45.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-04 10:27:36.000000000 +0200
@@ -150,19 +150,22 @@
 	 * configuration.
 	 */
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	switch (cmd) {
 		case HDIO_GET_32BIT: {
 			unsigned long val = drive->channel->io_32bit;
 
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
 			return 0;
 		}
 
 		case HDIO_SET_32BIT:
+		        if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
@@ -178,6 +181,9 @@
 			return 0;
 
 		case HDIO_SET_PIO_MODE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (arg < 0 || arg > 255)
 				return -EINVAL;
 
@@ -198,6 +204,9 @@
 		case HDIO_GET_UNMASKINTR: {
 			unsigned long val = drive->channel->unmask;
 
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
 
@@ -205,6 +214,9 @@
 		}
 
 		case HDIO_SET_UNMASKINTR:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
@@ -222,6 +234,9 @@
 		case HDIO_GET_DMA: {
 			unsigned long val = drive->using_dma;
 
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (put_user(val, (unsigned long *) arg))
 				return -EFAULT;
 
@@ -229,6 +244,9 @@
 		}
 
 		case HDIO_SET_DMA:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
 
@@ -250,6 +268,9 @@
 			struct hd_geometry *loc = (struct hd_geometry *) arg;
 			unsigned short bios_cyl = drive->bios_cyl; /* truncate */
 
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
 				return -EINVAL;
 
@@ -272,6 +293,9 @@
 		case HDIO_GETGEO_BIG_RAW: {
 			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
 
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
 				return -EINVAL;
 
@@ -292,6 +316,9 @@
 		}
 
 		case HDIO_GET_IDENTITY:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (minor(inode->i_rdev) & PARTN_MASK)
 				return -EINVAL;
 
@@ -304,11 +331,17 @@
 			return 0;
 
 		case HDIO_GET_NICE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			return put_user(drive->dsc_overlap << IDE_NICE_DSC_OVERLAP |
 					drive->atapi_overlap << IDE_NICE_ATAPI_OVERLAP,
 					(long *) arg);
 
 		case HDIO_SET_NICE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP))))
 				return -EPERM;
 
@@ -322,18 +355,27 @@
 			return 0;
 
 		case HDIO_GET_BUSSTATE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (put_user(drive->channel->bus_state, (long *)arg))
 				return -EFAULT;
 
 			return 0;
 
 		case HDIO_SET_BUSSTATE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (drive->channel->busproc)
 				drive->channel->busproc(drive, (int)arg);
 
 			return 0;
 
 		case HDIO_DRIVE_CMD:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			if (!arg) {
 				if (ide_spin_wait_hwgroup(drive))
 					return -EBUSY;
diff -urN linux-2.5.20/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.20/drivers/ide/tcq.c	2002-06-04 14:06:59.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-04 11:10:59.000000000 +0200
@@ -406,7 +406,8 @@
 
 	args.taskfile.feature = 0x01;
 	args.cmd = WIN_NOP;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	/*
 	 * do taskfile and check ABRT bit -- intelligent adapters will not
@@ -441,7 +442,8 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: failed to enable write cache\n", drive->name);
@@ -455,7 +457,8 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
 	args.cmd = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
@@ -469,7 +472,8 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
 	args.cmd = WIN_SETFEATURES;
-	ide_cmd_type_parser(&args);
+	args.handler = task_no_data_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
diff -urN linux-2.5.20/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.20/include/linux/ide.h	2002-06-04 14:07:00.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-04 12:31:54.000000000 +0200
@@ -664,7 +664,6 @@
 	struct hd_drive_task_hdr  hobfile;
 	u8 cmd;					/* actual ATA command */
 	int command_type;
-	ide_startstop_t (*prehandler)(struct ata_device *, struct request *);
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);
 };
 
@@ -678,17 +677,31 @@
  * Special Flagged Register Validation Caller
  */
 
-extern ide_startstop_t recal_intr(struct ata_device *, struct request *);
-extern ide_startstop_t task_no_data_intr(struct ata_device *, struct request *);
+/*
+ * for now, taskfile requests are special :/
+ */
+static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
+{
+	if (rq->bio)
+		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+	else
+		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
+}
 
-extern void ide_cmd_type_parser(struct ata_taskfile *args);
+static inline void ide_unmap_rq(struct request *rq, char *to,
+				unsigned long *flags)
+{
+	if (rq->bio)
+		bio_kunmap_irq(to, flags);
+}
+
+extern ide_startstop_t task_no_data_intr(struct ata_device *, struct request *);
 extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
 
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_config_drive_speed(struct ata_device *, byte);
 extern byte eighty_ninty_three(struct ata_device *);
 
-
 extern void ide_stall_queue(struct ata_device *, unsigned long);
 
 extern int system_bus_speed;

--------------000108040700030409010901--

