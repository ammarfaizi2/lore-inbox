Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbRFABdZ>; Thu, 31 May 2001 21:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263309AbRFABdR>; Thu, 31 May 2001 21:33:17 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:18334 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S263300AbRFABdB>;
	Thu, 31 May 2001 21:33:01 -0400
Message-ID: <3B16F12A.61ABCF06@sun.com>
Date: Thu, 31 May 2001 18:34:34 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: [PATCH] HPT370 misc (for real this time)
In-Reply-To: <Pine.LNX.4.10.10103272243300.17821-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------2B46F3B8530387A283373CCF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B46F3B8530387A283373CCF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre,

Attached is a patch for hpt366.c for the following:
	better support for multiple controllers
	better /proc output
	66 MHz PCI timings
	implement the HDIO_GET/SET_BUSSTATE ioctls (see previous patch)

This patch does rely on the PCI busspeed patch (sent to lkml earlier).

Please let me know if you have any problems with this for general
inclusion.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------2B46F3B8530387A283373CCF
Content-Type: text/plain; charset=us-ascii;
 name="hpt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpt.diff"

diff -ruN dist-2.4.5/drivers/ide/hpt366.c cobalt-2.4.5/drivers/ide/hpt366.c
--- dist-2.4.5/drivers/ide/hpt366.c	Sat May 19 17:43:06 2001
+++ cobalt-2.4.5/drivers/ide/hpt366.c	Thu May 31 14:32:15 2001
@@ -11,6 +11,17 @@
  *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
+ * add function for getting/setting power status of drive
+ * 	Adrian Sun <asun@cobalt.com>
+ *
+ * add drive timings for 66MHz PCI bus,
+ * fix ATA Cable signal detection, fix incorrect /proc info
+ * add /proc display for per-drive PIO/DMA/UDMA mode and
+ * per-channel ATA-33/66 Cable detect.
+ * 	Duncan Laurie <duncan@cobalt.com>
+ *
+ * fixup /proc output for multiple controllers
+ *	Tim Hockin <thockin@sun.com>
  */
 
 #include <linux/config.h>
@@ -28,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 
+#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -170,62 +182,126 @@
 	{	0,		0x06514e57,	0x06514e57	}
 };
 
+struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
+	{       XFER_UDMA_5,    0x14846231,     0x14846231      },
+	{       XFER_UDMA_4,    0x14886231,     0x14886231      },
+	{       XFER_UDMA_3,    0x148c6231,     0x148c6231      },
+	{       XFER_UDMA_2,    0x148c6231,     0x148c6231      },
+	{       XFER_UDMA_1,    0x14906231,     0x14906231      },
+	{       XFER_UDMA_0,    0x14986231,     0x14986231      },
+	
+	{       XFER_MW_DMA_2,  0x26514e21,     0x26514e21      },
+	{       XFER_MW_DMA_1,  0x26514e33,     0x26514e33      },
+	{       XFER_MW_DMA_0,  0x26514e97,     0x26514e97      },
+	
+	{       XFER_PIO_4,     0x06514e21,     0x06514e21      },
+	{       XFER_PIO_3,     0x06514e22,     0x06514e22      },
+	{       XFER_PIO_2,     0x06514e33,     0x06514e33      },
+	{       XFER_PIO_1,     0x06914e43,     0x06914e43      },
+	{       XFER_PIO_0,     0x06914e57,     0x06914e57      },
+	{       0,              0x06514e57,     0x06514e57      }
+};
+
 #define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT370_ALLOW_ATA100_5		1
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
+#define HPT366_MAX_DEVS			8
+
+static struct pci_dev *hpt_devs[HPT366_MAX_DEVS];
+static int n_hpt_devs;
+
+static unsigned int pci_rev_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev2_check_hpt3xx(struct pci_dev *dev);
+byte hpt366_proc = 0;
+byte hpt363_shared_irq;
+byte hpt363_shared_pin;
+extern char *ide_xfer_verbose (byte xfer_rate);
 
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 static int hpt366_get_info(char *, char **, off_t, int);
 extern int (*hpt366_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 extern char *ide_media_verbose(ide_drive_t *);
-static struct pci_dev *bmide_dev;
-static struct pci_dev *bmide2_dev;
 
 static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
 {
-	char *p		= buffer;
-	u32 bibma	= bmide_dev->resource[4].start;
-	u32 bibma2 	= bmide2_dev->resource[4].start;
-	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A"};
-	u8  c0 = 0, c1 = 0;
-	u32 class_rev;
-
-	pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
-
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	if (bmide2_dev)
-		c1 = inb_p((unsigned short)bibma2 + 0x02);
-
-	p += sprintf(p, "\n                                %s Chipset.\n", chipset_names[class_rev]);
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	p += sprintf(p, "                %sabled                         %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-			(c0&0x20) ? "yes" : "no ", (c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ", (c1&0x40) ? "yes" : "no " );
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
+	char *p	= buffer;
+	char *chipset_nums[] = {"366", "366", "368", "370", "370A"};
+	int i;
+
+	p += sprintf(p, "\n                             "
+		"HighPoint HPT366/368/370\n");
+	for (i = 0; i < n_hpt_devs; i++) {
+		struct pci_dev *dev = hpt_devs[i];
+		unsigned short iobase = dev->resource[4].start;
+		u32 class_rev;
+		u8 c0, c1;
+
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+		class_rev &= 0xff;
+
+		p += sprintf(p, "\nController: %d\n", i);
+		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		p += sprintf(p, "Bus speed: %d MHz\n", dev->bus->bus_speed);
+		p += sprintf(p, "--------------- Primary Channel "
+				"--------------- Secondary Channel "
+				"--------------\n");
+
+		/* get the bus master status registers */
+		c0 = inb_p(iobase + 0x2);
+		c1 = inb_p(iobase + 0xa);
+		p += sprintf(p, "Enabled:        %s"
+				"                             %s\n",
+			(c0 & 0x80) ? "no" : "yes",
+			(c1 & 0x80) ? "no" : "yes");
+
+		if (pci_rev_check_hpt3xx(dev)) {
+			u8 cbl;
+			cbl = inb_p(iobase + 0x7b);
+			outb_p(cbl | 1, iobase + 0x7b);
+			outb_p(cbl & ~1, iobase + 0x7b);
+			cbl = inb_p(iobase + 0x7a);
+			p += sprintf(p, "Cable:          ATA-%d"
+					"                          ATA-%d\n",
+				(cbl & 0x02) ? 33 : 66,
+				(cbl & 0x01) ? 33 : 66);
+			p += sprintf(p, "\n");
+		}
 
+		p += sprintf(p, "--------------- drive0 --------- drive1 "
+				"------- drive0 ---------- drive1 -------\n");
+		p += sprintf(p, "DMA capable:    %s              %s" 
+				"            %s               %s\n",
+			(c0 & 0x20) ? "yes" : "no ", 
+			(c0 & 0x40) ? "yes" : "no ",
+			(c1 & 0x20) ? "yes" : "no ", 
+			(c1 & 0x40) ? "yes" : "no ");
+
+		if (pci_rev2_check_hpt3xx(dev)) {
+			u8 c2, c3;
+			c0 = inb_p(iobase + 0x63);
+			c1 = inb_p(iobase + 0x67);
+			c2 = inb_p(iobase + 0x6b);
+			c3 = inb_p(iobase + 0x6f);
+
+			p += sprintf(p, "Mode:           %s             %s"
+					"           %s              %s\n",
+				(c0 & 0x10) ? "UDMA" : (c0 & 0x20) ? "DMA " : 
+					(c0 & 0x80) ? "PIO " : "off ",
+				(c1 & 0x10) ? "UDMA" : (c1 & 0x20) ? "DMA " :
+					(c1 & 0x80) ? "PIO " : "off ",
+				(c2 & 0x10) ? "UDMA" : (c2 & 0x20) ? "DMA " :
+					(c2 & 0x80) ? "PIO " : "off ",
+				(c3 & 0x10) ? "UDMA" : (c3 & 0x20) ? "DMA " :
+					(c3 & 0x80) ? "PIO " : "off ");
+		}
+	}
+	p += sprintf(p, "\n");
+	
 	return p-buffer;/* => must be less than 4k! */
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-byte hpt366_proc = 0;
-
-extern char *ide_xfer_verbose (byte xfer_rate);
-byte hpt363_shared_irq;
-byte hpt363_shared_pin;
-
 static unsigned int pci_rev_check_hpt3xx (struct pci_dev *dev)
 {
 	unsigned int class_rev;
@@ -320,35 +396,76 @@
 static void hpt370_tune_chipset (ide_drive_t *drive, byte speed, int direction)
 {
 	byte regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
-	byte reg5bh		= (speed != XFER_UDMA_5) ? 0x22 : (direction) ? 0x20 : 0x22;
-	unsigned int list_conf	= pci_bus_clock_list(speed, direction, thirty_three_base_hpt370);
+	byte reg5bh		= 0x22;
+	unsigned int list_conf	= 0;
 	unsigned int drive_conf = 0;
 	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
-	byte drive_pci		= 0;
+	byte drive_pci		= 0x40 + (drive->dn * 4);
 	byte drive_fast		= 0;
+	struct pci_dev *dev 	= HWIF(drive)->pci_dev;
+	int bus_freq 		= dev->bus->bus_speed;
 
-	switch (drive->dn) {
-		case 0: drive_pci = 0x40; break;
-		case 1: drive_pci = 0x44; break;
-		case 2: drive_pci = 0x48; break;
-		case 3: drive_pci = 0x4c; break;
-		default: return;
-	}
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 */
 	pci_read_config_byte(HWIF(drive)->pci_dev, regfast, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x80);
+	if (drive_fast & 0x02)
+		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x02);
 
-	pci_read_config_dword(HWIF(drive)->pci_dev, drive_pci, &drive_conf);
-	pci_write_config_byte(HWIF(drive)->pci_dev, 0x5b, reg5bh);
+	/*
+	 * enable the internal PLL IFF required by drive timing,
+	 * otherwise speed is based off PCI bus frequency
+	 * 
+	 * internal PLL is required in two cases:
+	 * 1. UDMA mode 5 write timing when PCI bus is at 33MHz (too slow)
+	 * 2. PCI bus frequency is at 66MHz
+	 *
+	 * enabled by default
+	 * to disable set bit 1 (0x02) of register 0x5b
+	 */
+	if (bus_freq == 66 || (speed == XFER_UDMA_5 && direction)) {
+		reg5bh &= ~(0x02);
+	}
+	pci_write_config_byte(dev, 0x5b, reg5bh);
 
-	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
 	/*
-	 * Disable on-chip PIO FIFO/buffer (to avoid problems handling I/O errors later)
+	 * get drive timing values to be written to IDE Timing Register for
+	 * the channel to which this drive is attached.  Values depend on 
+	 * frequency of the PCI bus.
+	 *
+	 * since we don't know the actual magic algorithm, we can only know
+	 * what to do at 66 or 33 MHz.
 	 */
-	list_conf &= ~0x80000000;
+	if (bus_freq != 33 && bus_freq != 66) {
+		int n = bus_freq;
+		static int warned;
+		
+		if (bus_freq <= 49) {
+			n = 33;
+		} else {
+			n = 66;
+		}
+		if (!warned) {
+			printk("HPT366: I don't know how to handle a %d MHz "
+				"bus - setting up for %d MHz\n", bus_freq, n);
+			warned = 1;
+		}
+		bus_freq = n;
+	}
+	if (bus_freq == 33) {
+		list_conf = pci_bus_clock_list(speed, direction,
+			thirty_three_base_hpt370);
+	} else if (bus_freq != 66) {
+		list_conf = pci_bus_clock_list(speed, direction,
+			sixty_six_base_hpt370);
+	}
+
+	pci_read_config_dword(dev, drive_pci, &drive_conf);
+	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
+	
+	if (speed < XFER_MW_DMA_0) {
+		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
+	}
 
 	pci_write_config_dword(HWIF(drive)->pci_dev, drive_pci, list_conf);
 }
@@ -493,9 +610,8 @@
 
 void hpt3xx_intrproc (ide_drive_t *drive)
 {
-	if (drive->quirk_list) {
+	if (!drive->quirk_list) {
 		/* drives in the quirk_list may not like intr setups/cleanups */
-	} else {
 		OUT_BYTE((drive)->ctl|2, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
 	}
 }
@@ -632,14 +752,8 @@
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 
 	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &test);
-
-#if 0
-	if (test != 0x08)
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0x08);
-#else
 	if (test != (L1_CACHE_BYTES / 4))
 		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
-#endif
 
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &test);
 	if (test != 0x78)
@@ -653,17 +767,12 @@
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
+	hpt_devs[n_hpt_devs++] = dev;
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!hpt366_proc) {
 		hpt366_proc = 1;
-		bmide_dev = dev;
-		if (pci_rev_check_hpt3xx(dev))
-			bmide2_dev = dev;
 		hpt366_display_info = &hpt366_get_info;
 	}
-	if ((hpt366_proc) && ((dev->devfn - bmide_dev->devfn) == 1)) {
-		bmide2_dev = dev;
-	}
 #endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
 
 	return dev->irq;
@@ -672,31 +781,118 @@
 unsigned int __init ata66_hpt366 (ide_hwif_t *hwif)
 {
 	byte ata66 = 0;
+	int is33 = 0;
 
+	if (pci_rev_check_hpt3xx(hwif->pci_dev)) {
+		/* strobe bit 0 of reg 5b to latch cable detect signals */
+		pci_read_config_byte(hwif->pci_dev, 0x5b, &ata66);
+		pci_write_config_byte(hwif->pci_dev, 0x5b, ata66 | 1);
+		udelay(10);
+		pci_write_config_byte(hwif->pci_dev, 0x5b, ata66 & ~1);
+		udelay(10);
+	}
 	pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+	if (hwif->channel) {
+		is33 = ata66 & 1;
+	} else {
+		is33 = ata66 & 2;
+	}
+
 #ifdef DEBUG
 	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",
-		ata66, (ata66 & 0x02) ? "33" : "66",
+		ata66, is33 ? "33" : "66",
 		PCI_FUNC(hwif->pci_dev->devfn));
 #endif /* DEBUG */
-	return ((ata66 & 0x02) ? 0 : 1);
+	return (!is33);
+}
+
+/* 
+ * set/get power state for a drive.
+ * turning the power off does the following things:
+ *   1) soft-reset the drive
+ *   2) tri-states the ide bus
+ *
+ * when we turn things back on, we need to re-initialize things.
+ */
+#define TRISTATE_BIT  0x8000
+static int hpt3xx_busproc(ide_hwif_t *hwif, int state)
+{
+	byte tristate, resetmask, bus_reg;
+	u16 tri_reg;
+
+	if (!hwif)
+		return -EINVAL;
+
+	hwif->bus_state = state;
+
+	if (hwif->channel) { 
+		/* secondary channel */
+		tristate = 0x56;
+		resetmask = 0x80; 
+	} else { 
+		/* primary channel */
+		tristate = 0x52;
+		resetmask = 0x40;
+	}
+
+	/* grab status */
+	pci_read_config_word(hwif->pci_dev, tristate, &tri_reg);
+	pci_read_config_byte(hwif->pci_dev, 0x59, &bus_reg);
+
+	/* set the state. we don't set it if we don't need to do so.
+	 * make sure that the drive knows that it has failed if it's off */
+	switch (state) {
+	case BUSSTATE_ON:
+		hwif->drives[0].failures = 0;
+		hwif->drives[1].failures = 0;
+		if ((bus_reg & resetmask) == 0)
+			return 0;
+		tri_reg &= ~TRISTATE_BIT;
+		bus_reg &= ~resetmask;
+		break;
+	case BUSSTATE_OFF:
+		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
+		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+		if ((tri_reg & TRISTATE_BIT) == 0 && (bus_reg & resetmask))
+			return 0;
+		tri_reg &= ~TRISTATE_BIT;
+		bus_reg |= resetmask;
+		break;
+	case BUSSTATE_TRISTATE:
+		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
+		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+		if ((tri_reg & TRISTATE_BIT) && (bus_reg & resetmask))
+			return 0;
+		tri_reg |= TRISTATE_BIT;
+		bus_reg |= resetmask;
+		break;
+	}
+	pci_write_config_byte(hwif->pci_dev, 0x59, bus_reg);
+	pci_write_config_word(hwif->pci_dev, tristate, tri_reg);
+
+	return 0;
 }
 
 void __init ide_init_hpt366 (ide_hwif_t *hwif)
 {
+	int hpt_rev;
+
 	hwif->tuneproc	= &hpt3xx_tune_drive;
 	hwif->speedproc	= &hpt3xx_tune_chipset;
 	hwif->quirkproc	= &hpt3xx_quirkproc;
 	hwif->intrproc	= &hpt3xx_intrproc;
 	hwif->maskproc	= &hpt3xx_maskproc;
 
-	if (pci_rev2_check_hpt3xx(hwif->pci_dev)) {
-		/* do nothing now but will split device types */
+	hpt_rev = pci_rev_check_hpt3xx(hwif->pci_dev);
+	if (hpt_rev) {
+		/* set up ioctl for power status. note: power affects both
+		 * drives on each channel */
+		hwif->busproc = &hpt3xx_busproc;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
-		if (pci_rev_check_hpt3xx(hwif->pci_dev)) {
+		if (hpt_rev) {
 			byte reg5ah = 0;
 			pci_read_config_byte(hwif->pci_dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */

--------------2B46F3B8530387A283373CCF--

