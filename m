Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJ1Rfr>; Mon, 28 Oct 2002 12:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJ1Rfj>; Mon, 28 Oct 2002 12:35:39 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:60943 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261399AbSJ1RXs>; Mon, 28 Oct 2002 12:23:48 -0500
Date: Tue, 29 Oct 2002 02:30:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 9/23] add support for PC-9800 architecture (IDE)
Message-ID: <20021029023007.A2271@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 9/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 IDE driver modules
  - IO port address change.
  - add support PC-9800 specific feature. (shared IRQ, serialize)

diffstat:
 drivers/ide/Config.in       |    4 
 drivers/ide/ide-disk.c      |   67 +++
 drivers/ide/ide-geometry.c  |    2 
 drivers/ide/ide-probe.c     |   25 +
 drivers/ide/ide-proc.c      |    3 
 drivers/ide/ide.c           |   14 
 drivers/ide/legacy/Makefile |    5 
 drivers/ide/legacy/hd98.c   |  904 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/legacy/pc9800.c |   82 +++
 include/asm-i386/ide.h      |   18 
 include/linux/hdreg.h       |   19 
 include/linux/ide.h         |    2 
 12 files changed, 1141 insertions(+), 4 deletions(-)

patch:
diff -urN linux/drivers/ide/Config.in linux98/drivers/ide/Config.in
--- linux/drivers/ide/Config.in	Sat Oct 12 13:21:33 2002
+++ linux98/drivers/ide/Config.in	Sat Oct 12 16:42:12 2002
@@ -219,4 +219,8 @@
    define_bool CONFIG_BLK_DEV_IDE_MODES n
 fi
 
+if [ "$CONFIG_PC9800" = "y" ]; then
+   define_bool CONFIG_BLK_DEV_IDE_PC9800 y
+fi
+
 endmenu
diff -urN linux/drivers/ide/ide-disk.c linux98/drivers/ide/ide-disk.c
--- linux/drivers/ide/ide-disk.c	Sat Oct 12 13:21:42 2002
+++ linux98/drivers/ide/ide-disk.c	Sat Oct 12 16:53:36 2002
@@ -1717,6 +1717,71 @@
 		blk_queue_max_sectors(&drive->queue, 2048);
 #endif
 
+#ifdef CONFIG_PC9800
+	/* XXX - need more checks */
+	if (!drive->nobios && !drive->scsi && !drive->removable) {
+		/* PC-9800's BIOS do pack drive numbers to be continuous,
+		   so extra work is needed here.  */
+
+		/* drive information passed from boot/setup.S */
+		struct drive_info_struct {
+			u16 cyl;
+			u8 sect, head;
+			u16 ssize;
+		} __attribute__ ((packed));
+		extern struct drive_info_struct drive_info[];
+
+		/* this pointer must be advanced only when *DRIVE is
+		   really hard disk. */
+		static struct drive_info_struct *info = drive_info;
+
+		if (info < &drive_info[4] && info->cyl) {
+			drive->cyl  = drive->bios_cyl  = info->cyl;
+			drive->head = drive->bios_head = info->head;
+			drive->sect = drive->bios_sect = info->sect;
+			++info;
+		}
+	}
+
+	/* =PC98 MEMO=
+	   physical capacity =< 65535*8*17 sect. : H/S=8/17 (fixed)
+	   physical capacity > 65535*8*17 sect. : use physical geometry
+	   (65535*8*17 = 8912760 sectors)
+	*/
+	printk("%s: CHS: physical %d/%d/%d, logical %d/%d/%d, BIOS %d/%d/%d\n",
+	       drive->name,
+	       id->cyls,	id->heads,	id->sectors,
+	       id->cur_cyls,	id->cur_heads,	id->cur_sectors,
+	       drive->bios_cyl,	drive->bios_head,drive->bios_sect);
+	if (!drive->cyl || !drive->head || !drive->sect) {
+		drive->cyl     = drive->bios_cyl  = id->cyls;
+		drive->head    = drive->bios_head = id->heads;
+		drive->sect    = drive->bios_sect = id->sectors;
+		printk("%s: not BIOS-supported device.\n",drive->name);
+	}
+	/* calculate drive capacity, and select LBA if possible */
+	init_idedisk_capacity(drive);
+
+	/*
+	 * if possible, give fdisk access to more of the drive,
+	 * by correcting bios_cyls:
+	 */
+	capacity = idedisk_capacity(drive);
+	if (capacity < 8912760 &&
+	   (drive->head != 8 || drive->sect != 17)) {
+		drive->head = drive->bios_head = 8;
+		drive->sect = drive->bios_sect = 17;
+		drive->cyl  = drive->bios_cyl  =
+			capacity / (drive->bios_head * drive->bios_sect);
+		printk("%s: Fixing Geometry :: CHS=%d/%d/%d to CHS=%d/%d/%d\n",
+			   drive->name,
+			   id->cur_cyls,id->cur_heads,id->cur_sectors,
+			   drive->bios_cyl,drive->bios_head,drive->bios_sect);
+		id->cur_cyls    = drive->bios_cyl;
+		id->cur_heads   = drive->bios_head;
+		id->cur_sectors = drive->bios_sect;
+	}
+#else /* !CONFIG_PC9800 */
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
 		drive->cyl     = drive->bios_cyl  = id->cyls;
@@ -1750,6 +1815,8 @@
 	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
 	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
 		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
+#endif  /* CONFIG_PC9800 */
+
 	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
 
 	/* Give size in megabytes (MB), not mebibytes (MiB). */
diff -urN linux/drivers/ide/ide-geometry.c linux98/drivers/ide/ide-geometry.c
--- linux/drivers/ide/ide-geometry.c	Sat Oct 19 13:02:28 2002
+++ linux98/drivers/ide/ide-geometry.c	Sat Oct 19 15:08:56 2002
@@ -6,6 +6,7 @@
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
+#ifndef CONFIG_PC9800
 /*
  * We query CMOS about hard disks : it could be that we have a SCSI/ESDI/etc
  * controller that is BIOS compatible with ST-506, and thus showing up in our
@@ -81,6 +82,7 @@
 	}
 #endif
 }
+#endif /* !CONFIG_PC9800 */
 
 
 extern unsigned long current_capacity (ide_drive_t *);
diff -urN linux/drivers/ide/ide-probe.c linux98/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	Sat Oct 19 13:01:57 2002
+++ linux98/drivers/ide/ide-probe.c	Sat Oct 19 15:08:56 2002
@@ -553,7 +553,11 @@
 
 	if (hwif->mmio == 2)
 		return 0;
+#ifndef CONFIG_PC9800
 	addr_errs  = hwif_check_region(hwif->io_ports[IDE_DATA_OFFSET], 1);
+#else
+	addr_errs  = hwif_check_region(hwif->io_ports[IDE_DATA_OFFSET], 2);
+#endif
 	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++)
 		addr_errs += hwif_check_region(hwif->io_ports[i], 1);
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
@@ -601,7 +605,13 @@
 		return;
 	}
 
+#ifndef CONFIG_PC9800
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+#else
+	/* IDE_DATA_REG is actually word (16 bits) register */
+	hwif_request_region(hwif->io_ports[IDE_DATA_OFFSET], 2, hwif->name);
+	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+#endif
 		hwif_request_region(hwif->io_ports[i], 1, hwif->name);
 }
 
@@ -619,7 +629,7 @@
 
 	if (hwif->noprobe)
 		return;
-#ifdef CONFIG_BLK_DEV_IDE
+#if !defined(CONFIG_PC9800) && defined(CONFIG_BLK_DEV_IDE)
 	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA) {
 		extern void probe_cmos_for_drives(ide_hwif_t *);
 		probe_cmos_for_drives(hwif);
@@ -630,6 +640,9 @@
 #if CONFIG_BLK_DEV_PDC4030
 	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
 #endif /* CONFIG_BLK_DEV_PDC4030 */
+#if CONFIG_BLK_DEV_IDE_PC9800
+	    (hwif->chipset != ide_pc9800 || !hwif->mate->present) &&
+#endif
 	    (hwif_check_regions(hwif))) {
 		u16 msgout = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -949,7 +962,7 @@
 	/* all CPUs; safe now that hwif->hwgroup is set up */
 	spin_unlock_irqrestore(&ide_lock, flags);
 
-#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
+#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__) && !defined(CONFIG_PC9800)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
@@ -959,6 +972,14 @@
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
 		hwif->io_ports[IDE_CONTROL_OFFSET], __irq_itoa(hwif->irq));
+#elif defined(CONFIG_PC9800)
+	printk("%s at 0x%03lx-0x%03lx,0x%03lx-0x%03lx on irq %d",
+		hwif->name,
+		hwif->io_ports[IDE_DATA_OFFSET],
+		hwif->io_ports[IDE_DATA_OFFSET]+15,
+		hwif->io_ports[IDE_CONTROL_OFFSET],
+		hwif->io_ports[IDE_CONTROL_OFFSET]+3,
+		hwif->irq);
 #else
 	printk("%s at %x on irq 0x%08x", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET], hwif->irq);
diff -urN linux/drivers/ide/ide-proc.c linux98/drivers/ide/ide-proc.c
--- linux/drivers/ide/ide-proc.c	Mon Sep 16 11:18:30 2002
+++ linux98/drivers/ide/ide-proc.c	Mon Sep 16 13:53:42 2002
@@ -365,6 +365,9 @@
 		case ide_cy82c693:	name = "cy82c693";	break;
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
+#ifdef CONFIG_PC9800
+		case ide_pc9800:	name = "pc9800";	break;
+#endif
 		default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
diff -urN linux/drivers/ide/ide.c linux98/drivers/ide/ide.c
--- linux/drivers/ide/ide.c	Sat Oct 19 13:01:19 2002
+++ linux98/drivers/ide/ide.c	Sat Oct 19 15:08:56 2002
@@ -1694,7 +1694,13 @@
 		hwif_release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
 		return;
 	}
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+#ifndef CONFIG_PC9800
+#define IDE_REGION_START IDE_DATA_OFFSET
+#else
+#define IDE_REGION_START IDE_ERROR_OFFSET
+	hwif_release_region(hwif->io_ports[IDE_DATA_OFFSET], 2);
+#endif
+	for (i = IDE_REGION_START; i <= IDE_STATUS_OFFSET; i++) {
 		if (hwif->io_ports[i]) {
 			hwif_release_region(hwif->io_ports[i], 1);
 		}
@@ -3057,6 +3063,12 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
+#ifdef CONFIG_BLK_DEV_IDE_PC9800
+	{
+		extern void ide_probe_for_pc9800(void);
+		ide_probe_for_pc9800();
+	}
+#endif
 #ifdef CONFIG_ETRAX_IDE
 	{
 		extern void init_e100_ide(void);
diff -urN linux/drivers/ide/legacy/Makefile linux98/drivers/ide/legacy/Makefile
--- linux/drivers/ide/legacy/Makefile	Sat Oct 12 13:21:34 2002
+++ linux98/drivers/ide/legacy/Makefile	Sun Oct 13 11:07:36 2002
@@ -2,6 +2,7 @@
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+= ali14xx.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
+obj-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
 obj-$(CONFIG_BLK_DEV_PDC4030)		+= pdc4030.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
 obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
@@ -15,7 +16,11 @@
 obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
 
 # Last of all
+ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
+else
+obj-$(CONFIG_BLK_DEV_HD)		+= hd98.o
+endif
 
 EXTRA_CFLAGS	:= -Idrivers/ide
 
diff -urN linux/drivers/ide/legacy/hd98.c linux98/drivers/ide/legacy/hd98.c
--- linux/drivers/ide/legacy/hd98.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/ide/legacy/hd98.c	Sat Oct 26 15:42:09 2002
@@ -0,0 +1,904 @@
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ * This is the low-level hd interrupt support. It traverses the
+ * request-list, using interrupts to jump between functions. As
+ * all the functions are called within interrupts, we may not
+ * sleep. Special care is recommended.
+ *
+ *  modified by Drew Eckhardt to check nr of hd's from the CMOS.
+ *
+ *  Thanks to Branko Lankester, lankeste@fwi.uva.nl, who found a bug
+ *  in the early extended-partition checks and added DM partitions
+ *
+ *  IRQ-unmask, drive-id, multiple-mode, support for ">16 heads",
+ *  and general streamlining by Mark Lord.
+ *
+ *  Removed 99% of above. Use Mark's ide driver for those options.
+ *  This is now a lightweight ST-506 driver. (Paul Gortmaker)
+ *
+ *  Modified 1995 Russell King for ARM processor.
+ *
+ *  Bugfix: max_sectors must be <= 255 or the wheels tend to come
+ *  off in a hurry once you queue things up - Paul G. 02/2001
+ */
+
+/* Uncomment the following if you want verbose error reports. */
+/* #define VERBOSE_ERRORS */
+
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/genhd.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/mc146818rtc.h> /* CMOS defines */
+#include <linux/init.h>
+#include <linux/blkpg.h>
+#include <linux/hdreg.h>
+
+#define REALLY_SLOW_IO
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define MAJOR_NR HD_MAJOR
+#define DEVICE_NR(device) (minor(device)>>6)
+#include <linux/blk.h>
+
+#include "io_ports.h"
+
+#ifdef __arm__
+#undef  HD_IRQ
+#endif
+#include <asm/irq.h>
+#ifdef __arm__
+#define HD_IRQ IRQ_HARDDISK
+#endif
+
+/* Hd controller regster ports */
+
+#define HD_DATA		0x640	/* _CTL when writing */
+#define HD_ERROR	0x642	/* see err-bits */
+#define HD_NSECTOR	0x644	/* nr of sectors to read/write */
+#define HD_SECTOR	0x646	/* starting sector */
+#define HD_LCYL		0x648	/* starting cylinder */
+#define HD_HCYL		0x64a	/* high byte of starting cyl */
+#define HD_CURRENT	0x64c	/* 101dhhhh , d=drive, hhhh=head */
+#define HD_STATUS	0x64e	/* see status-bits */
+#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
+#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
+#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
+
+#define HD_CMD		0x74c	/* used for resets */
+#define HD_ALTSTATUS	0x74c	/* same as HD_STATUS but doesn't clear irq */
+
+/* Bits of HD_STATUS */
+#define ERR_STAT		0x01
+#define INDEX_STAT		0x02
+#define ECC_STAT		0x04	/* Corrected error */
+#define DRQ_STAT		0x08
+#define SEEK_STAT		0x10
+#define SERVICE_STAT		SEEK_STAT
+#define WRERR_STAT		0x20
+#define READY_STAT		0x40
+#define BUSY_STAT		0x80
+
+/* Bits for HD_ERROR */
+#define MARK_ERR		0x01	/* Bad address mark */
+#define TRK0_ERR		0x02	/* couldn't find track 0 */
+#define ABRT_ERR		0x04	/* Command aborted */
+#define MCR_ERR			0x08	/* media change request */
+#define ID_ERR			0x10	/* ID field not found */
+#define MC_ERR			0x20	/* media changed */
+#define ECC_ERR			0x40	/* Uncorrectable ECC error */
+#define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
+#define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
+
+static spinlock_t hd_lock = SPIN_LOCK_UNLOCKED;
+
+#define TIMEOUT_VALUE	(6*HZ)
+#define	HD_DELAY	0
+
+#define MAX_ERRORS     16	/* Max read/write errors/sector */
+#define RESET_FREQ      8	/* Reset controller every 8th retry */
+#define RECAL_FREQ      4	/* Recalibrate every 4th retry */
+#define MAX_HD		2
+
+#define STAT_OK		(READY_STAT|SEEK_STAT)
+#define OK_STATUS(s)	(((s)&(STAT_OK|(BUSY_STAT|WRERR_STAT|ERR_STAT)))==STAT_OK)
+
+static void recal_intr(void);
+static void bad_rw_intr(void);
+
+static char recalibrate[MAX_HD];
+static char special_op[MAX_HD];
+
+static int reset;
+static int hd_error;
+
+#define SUBSECTOR(block) (CURRENT->current_nr_sectors > 0)
+
+/*
+ *  This struct defines the HD's and their types.
+ */
+struct hd_i_struct {
+	unsigned int head,sect,cyl,wpcom,lzone,ctl;
+};
+	
+#ifdef HD_TYPE
+struct hd_i_struct hd_info[] = { HD_TYPE };
+static int NR_HD = ((sizeof (hd_info))/(sizeof (struct hd_i_struct)));
+#else
+struct hd_i_struct hd_info[MAX_HD];
+static int NR_HD;
+#endif
+
+static struct gendisk *hd_gendisk[MAX_HD];
+
+static struct timer_list device_timer;
+
+#define TIMEOUT_VALUE (6*HZ)
+
+#define SET_TIMER							\
+	do {								\
+		mod_timer(&device_timer, jiffies + TIMEOUT_VALUE);	\
+	} while (0)
+
+static void (*do_hd)(void) = NULL;
+#define SET_HANDLER(x) \
+if ((do_hd = (x)) != NULL) \
+	SET_TIMER; \
+else \
+	del_timer(&device_timer);
+
+
+#if (HD_DELAY > 0)
+unsigned long last_req;
+
+unsigned long read_timer(void)
+{
+        extern spinlock_t i8253_lock;
+	unsigned long t, flags;
+	int i;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	t = jiffies * 11932;
+    	outb_p(0, PIT_MODE);
+	i = inb_p(PIT_CH0);
+	i |= inb(PIT_CH0) << 8;
+	spin_unlock_irqrestore(&i8253_lock, flags);
+	return(t - i);
+}
+#endif
+
+void __init hd_setup(char *str, int *ints)
+{
+	int hdind = 0;
+
+	if (ints[0] != 3)
+		return;
+	if (hd_info[0].head != 0)
+		hdind=1;
+	hd_info[hdind].head = ints[2];
+	hd_info[hdind].sect = ints[3];
+	hd_info[hdind].cyl = ints[1];
+	hd_info[hdind].wpcom = 0;
+	hd_info[hdind].lzone = ints[1];
+	hd_info[hdind].ctl = (ints[2] > 8 ? 8 : 0);
+	NR_HD = hdind+1;
+}
+
+static void dump_status (const char *msg, unsigned int stat)
+{
+	char devc;
+
+	devc = !blk_queue_empty(QUEUE) ? 'a' + DEVICE_NR(CURRENT->rq_dev) : '?';
+#ifdef VERBOSE_ERRORS
+	printk("hd%c: %s: status=0x%02x { ", devc, msg, stat & 0xff);
+	if (stat & BUSY_STAT)	printk("Busy ");
+	if (stat & READY_STAT)	printk("DriveReady ");
+	if (stat & WRERR_STAT)	printk("WriteFault ");
+	if (stat & SEEK_STAT)	printk("SeekComplete ");
+	if (stat & DRQ_STAT)	printk("DataRequest ");
+	if (stat & ECC_STAT)	printk("CorrectedError ");
+	if (stat & INDEX_STAT)	printk("Index ");
+	if (stat & ERR_STAT)	printk("Error ");
+	printk("}\n");
+	if ((stat & ERR_STAT) == 0) {
+		hd_error = 0;
+	} else {
+		hd_error = inb(HD_ERROR);
+		printk("hd%c: %s: error=0x%02x { ", devc, msg, hd_error & 0xff);
+		if (hd_error & BBD_ERR)		printk("BadSector ");
+		if (hd_error & ECC_ERR)		printk("UncorrectableError ");
+		if (hd_error & ID_ERR)		printk("SectorIdNotFound ");
+		if (hd_error & ABRT_ERR)	printk("DriveStatusError ");
+		if (hd_error & TRK0_ERR)	printk("TrackZeroNotFound ");
+		if (hd_error & MARK_ERR)	printk("AddrMarkNotFound ");
+		printk("}");
+		if (hd_error & (BBD_ERR|ECC_ERR|ID_ERR|MARK_ERR)) {
+			printk(", CHS=%d/%d/%d", (inb(HD_HCYL)<<8) + inb(HD_LCYL),
+				inb(HD_CURRENT) & 0xf, inb(HD_SECTOR));
+			if (!blk_queue_empty(QUEUE))
+				printk(", sector=%ld", CURRENT->sector);
+		}
+		printk("\n");
+	}
+#else
+	printk("hd%c: %s: status=0x%02x.\n", devc, msg, stat & 0xff);
+	if ((stat & ERR_STAT) == 0) {
+		hd_error = 0;
+	} else {
+		hd_error = inb(HD_ERROR);
+		printk("hd%c: %s: error=0x%02x.\n", devc, msg, hd_error & 0xff);
+	}
+#endif
+}
+
+void check_status(void)
+{
+	int i = inb(HD_STATUS);
+
+	if (!OK_STATUS(i)) {
+		dump_status("check_status", i);
+		bad_rw_intr();
+	}
+}
+
+static int controller_busy(void)
+{
+	int retries = 100000;
+	unsigned char status;
+
+	do {
+		status = inb(HD_STATUS);
+	} while ((status & BUSY_STAT) && --retries);
+	return status;
+}
+
+static int status_ok(void)
+{
+	unsigned char status = inb(HD_STATUS);
+
+	if (status & BUSY_STAT)
+		return 1;	/* Ancient, but does it make sense??? */
+	if (status & WRERR_STAT)
+		return 0;
+	if (!(status & READY_STAT))
+		return 0;
+	if (!(status & SEEK_STAT))
+		return 0;
+	return 1;
+}
+
+static int controller_ready(unsigned int drive, unsigned int head)
+{
+	int retry = 100;
+
+	do {
+		if (controller_busy() & BUSY_STAT)
+			return 0;
+		outb(0xA0 | (drive<<4) | head, HD_CURRENT);
+		if (status_ok())
+			return 1;
+	} while (--retry);
+	return 0;
+}
+
+static void hd_out(unsigned int drive,unsigned int nsect,unsigned int sect,
+		unsigned int head,unsigned int cyl,unsigned int cmd,
+		void (*intr_addr)(void))
+{
+	unsigned short port;
+
+#if (HD_DELAY > 0)
+	while (read_timer() - last_req < HD_DELAY)
+		/* nothing */;
+#endif
+	if (reset)
+		return;
+	if (!controller_ready(drive, head)) {
+		reset = 1;
+		return;
+	}
+	SET_HANDLER(intr_addr);
+	outb(hd_info[drive].ctl,HD_CMD);
+	port=HD_DATA + 2;
+	outb(hd_info[drive].wpcom>>2, port); port += 2;
+	outb(nsect, port); port += 2;
+	outb(sect, port); port += 2;
+	outb(cyl, port); port += 2;
+	outb(cyl>>8, port); port += 2;
+	outb(0xA0|(drive<<4)|head, port); port += 2;
+	outb(cmd, port);
+}
+
+static void hd_request (void);
+
+static int drive_busy(void)
+{
+	unsigned int i;
+	unsigned char c;
+
+	for (i = 0; i < 500000 ; i++) {
+		c = inb(HD_STATUS);
+		if ((c & (BUSY_STAT | READY_STAT | SEEK_STAT)) == STAT_OK)
+			return 0;
+	}
+	dump_status("reset timed out", c);
+	return 1;
+}
+
+static void reset_controller(void)
+{
+	int	i;
+
+	outb(4,HD_CMD);
+	for(i = 0; i < 1000; i++) barrier();
+	outb(hd_info[0].ctl & 0x0f,HD_CMD);
+	for(i = 0; i < 1000; i++) barrier();
+	if (drive_busy())
+		printk("hd: controller still busy\n");
+	else if ((hd_error = inb(HD_ERROR)) != 1)
+		printk("hd: controller reset failed: %02x\n",hd_error);
+}
+
+static void reset_hd(void)
+{
+	static int i;
+
+repeat:
+	if (reset) {
+		reset = 0;
+		i = -1;
+		reset_controller();
+	} else {
+		check_status();
+		if (reset)
+			goto repeat;
+	}
+	if (++i < NR_HD) {
+		special_op[i] = recalibrate[i] = 1;
+		hd_out(i,hd_info[i].sect,hd_info[i].sect,hd_info[i].head-1,
+			hd_info[i].cyl,WIN_SPECIFY,&reset_hd);
+		if (reset)
+			goto repeat;
+	} else
+		hd_request();
+}
+
+/*
+ * Ok, don't know what to do with the unexpected interrupts: on some machines
+ * doing a reset and a retry seems to result in an eternal loop. Right now I
+ * ignore it, and just set the timeout.
+ *
+ * On laptops (and "green" PCs), an unexpected interrupt occurs whenever the
+ * drive enters "idle", "standby", or "sleep" mode, so if the status looks
+ * "good", we just ignore the interrupt completely.
+ */
+void unexpected_hd_interrupt(void)
+{
+	unsigned int stat = inb(HD_STATUS);
+
+	if (stat & (BUSY_STAT|DRQ_STAT|ECC_STAT|ERR_STAT)) {
+		dump_status ("unexpected interrupt", stat);
+		SET_TIMER;
+	}
+}
+
+/*
+ * bad_rw_intr() now tries to be a bit smarter and does things
+ * according to the error returned by the controller.
+ * -Mika Liljeberg (liljeber@cs.Helsinki.FI)
+ */
+static void bad_rw_intr(void)
+{
+	int dev;
+
+	if (blk_queue_empty(QUEUE))
+		return;
+	dev = DEVICE_NR(CURRENT->rq_dev);
+	if (++CURRENT->errors >= MAX_ERRORS || (hd_error & BBD_ERR)) {
+		end_request(CURRENT, 0);
+		special_op[dev] = recalibrate[dev] = 1;
+	} else if (CURRENT->errors % RESET_FREQ == 0)
+		reset = 1;
+	else if ((hd_error & TRK0_ERR) || CURRENT->errors % RECAL_FREQ == 0)
+		special_op[dev] = recalibrate[dev] = 1;
+	/* Otherwise just retry */
+}
+
+static inline int wait_DRQ(void)
+{
+	int retries = 100000, stat;
+
+	while (--retries > 0)
+		if ((stat = inb(HD_STATUS)) & DRQ_STAT)
+			return 0;
+	dump_status("wait_DRQ", stat);
+	return -1;
+}
+
+static void read_intr(void)
+{
+	int i, retries = 100000;
+
+	do {
+		i = (unsigned) inb(HD_STATUS);
+		if (i & BUSY_STAT)
+			continue;
+		if (!OK_STATUS(i))
+			break;
+		if (i & DRQ_STAT)
+			goto ok_to_read;
+	} while (--retries > 0);
+	dump_status("read_intr", i);
+	bad_rw_intr();
+	hd_request();
+	return;
+ok_to_read:
+	insw(HD_DATA,CURRENT->buffer,256);
+	CURRENT->sector++;
+	CURRENT->buffer += 512;
+	CURRENT->errors = 0;
+	i = --CURRENT->nr_sectors;
+	--CURRENT->current_nr_sectors;
+#ifdef DEBUG
+	printk("hd%c: read: sector %ld, remaining = %ld, buffer=0x%08lx\n",
+		dev+'a', CURRENT->sector, CURRENT->nr_sectors,
+		(unsigned long) CURRENT->buffer+512);
+#endif
+	if (CURRENT->current_nr_sectors <= 0)
+		end_request(CURRENT, 1);
+	if (i > 0) {
+		SET_HANDLER(&read_intr);
+		return;
+	}
+	(void) inb(HD_STATUS);
+#if (HD_DELAY > 0)
+	last_req = read_timer();
+#endif
+	if (!blk_queue_empty(QUEUE))
+		hd_request();
+	return;
+}
+
+static void write_intr(void)
+{
+	int i;
+	int retries = 100000;
+
+	do {
+		i = (unsigned) inb(HD_STATUS);
+		if (i & BUSY_STAT)
+			continue;
+		if (!OK_STATUS(i))
+			break;
+		if ((CURRENT->nr_sectors <= 1) || (i & DRQ_STAT))
+			goto ok_to_write;
+	} while (--retries > 0);
+	dump_status("write_intr", i);
+	bad_rw_intr();
+	hd_request();
+	return;
+ok_to_write:
+	CURRENT->sector++;
+	i = --CURRENT->nr_sectors;
+	--CURRENT->current_nr_sectors;
+	CURRENT->buffer += 512;
+	if (!i || (CURRENT->bio && !SUBSECTOR(i)))
+		end_request(CURRENT, 1);
+	if (i > 0) {
+		SET_HANDLER(&write_intr);
+		outsw(HD_DATA,CURRENT->buffer,256);
+		local_irq_enable();
+	} else {
+#if (HD_DELAY > 0)
+		last_req = read_timer();
+#endif
+		hd_request();
+	}
+	return;
+}
+
+static void recal_intr(void)
+{
+	check_status();
+#if (HD_DELAY > 0)
+	last_req = read_timer();
+#endif
+	hd_request();
+}
+
+/*
+ * This is another of the error-routines I don't know what to do with. The
+ * best idea seems to just set reset, and start all over again.
+ */
+static void hd_times_out(unsigned long dummy)
+{
+	unsigned int dev;
+
+	do_hd = NULL;
+
+	if (blk_queue_empty(QUEUE))
+		return;
+
+	disable_irq(HD_IRQ);
+	local_irq_enable();
+	reset = 1;
+	dev = DEVICE_NR(CURRENT->rq_dev);
+	printk("hd%c: timeout\n", dev+'a');
+	if (++CURRENT->errors >= MAX_ERRORS) {
+#ifdef DEBUG
+		printk("hd%c: too many errors\n", dev+'a');
+#endif
+		end_request(CURRENT, 0);
+	}
+	local_irq_disable();
+	hd_request();
+	enable_irq(HD_IRQ);
+}
+
+int do_special_op (unsigned int dev)
+{
+	if (recalibrate[dev]) {
+		recalibrate[dev] = 0;
+		hd_out(dev,hd_info[dev].sect,0,0,0,WIN_RESTORE,&recal_intr);
+		return reset;
+	}
+	if (hd_info[dev].head > 16) {
+		printk ("hd%c: cannot handle device with more than 16 heads - giving up\n", dev+'a');
+		end_request(CURRENT, 0);
+	}
+	special_op[dev] = 0;
+	return 1;
+}
+
+/*
+ * The driver enables interrupts as much as possible.  In order to do this,
+ * (a) the device-interrupt is disabled before entering hd_request(),
+ * and (b) the timeout-interrupt is disabled before the sti().
+ *
+ * Interrupts are still masked (by default) whenever we are exchanging
+ * data/cmds with a drive, because some drives seem to have very poor
+ * tolerance for latency during I/O. The IDE driver has support to unmask
+ * interrupts for non-broken hardware, so use that driver if required.
+ */
+static void hd_request(void)
+{
+	unsigned int dev, block, nsect, sec, track, head, cyl;
+
+	if (do_hd)
+		return;
+repeat:
+	del_timer(&device_timer);
+	local_irq_enable();
+
+	if (blk_queue_empty(QUEUE)) {
+		do_hd = NULL;
+		return;
+	}
+
+	if (reset) {
+		local_irq_disable();
+		reset_hd();
+		return;
+	}
+	dev = DEVICE_NR(CURRENT->rq_dev);
+	block = CURRENT->sector;
+	nsect = CURRENT->nr_sectors;
+	if (dev >= NR_HD) {
+		printk("hd: bad disk number: %d\n", dev);
+		end_request(CURRENT, 0);
+		goto repeat;
+	}
+	if (block >= get_capacity(hd_gendisk[dev]) ||
+	    ((block+nsect) > get_capacity(hd_gendisk[dev]))) {
+		printk("%s: bad access: block=%d, count=%d\n",
+			hd_gendisk[dev]->disk_name, block, nsect);
+		end_request(CURRENT, 0);
+		goto repeat;
+	}
+
+	if (special_op[dev]) {
+		if (do_special_op(dev))
+			goto repeat;
+		return;
+	}
+	sec   = block % hd_info[dev].sect + 1;
+	track = block / hd_info[dev].sect;
+	head  = track % hd_info[dev].head;
+	cyl   = track / hd_info[dev].head;
+#ifdef DEBUG
+	printk("hd%c: %sing: CHS=%d/%d/%d, sectors=%d, buffer=0x%08lx\n",
+		dev+'a', (CURRENT->cmd == READ)?"read":"writ",
+		cyl, head, sec, nsect, (unsigned long) CURRENT->buffer);
+#endif
+	if(CURRENT->flags & REQ_CMD) {
+		switch (rq_data_dir(CURRENT)) {
+		case READ:
+			hd_out(dev,nsect,sec,head,cyl,WIN_READ,&read_intr);
+			if (reset)
+				goto repeat;
+			break;
+		case WRITE:
+			hd_out(dev,nsect,sec,head,cyl,WIN_WRITE,&write_intr);
+			if (reset)
+				goto repeat;
+			if (wait_DRQ()) {
+				bad_rw_intr();
+				goto repeat;
+			}
+			outsw(HD_DATA,CURRENT->buffer,256);
+			break;
+		default:
+			printk("unknown hd-command\n");
+			end_request(CURRENT, 0);
+			break;
+		}
+	}
+}
+
+static void do_hd_request (request_queue_t * q)
+{
+	disable_irq(HD_IRQ);
+	hd_request();
+	enable_irq(HD_IRQ);
+}
+
+static int hd_ioctl(struct inode * inode, struct file * file,
+	unsigned int cmd, unsigned long arg)
+{
+	struct hd_geometry *loc = (struct hd_geometry *) arg;
+	int dev;
+
+	if ((!inode) || kdev_none(inode->i_rdev))
+		return -EINVAL;
+	dev = DEVICE_NR(inode->i_rdev);
+	if (dev >= NR_HD)
+		return -EINVAL;
+	switch (cmd) {
+		case HDIO_GETGEO:
+		{
+			struct hd_geometry g; 
+			if (!loc)  return -EINVAL;
+			g.heads = hd_info[dev].head;
+			g.sectors = hd_info[dev].sect;
+			g.cylinders = hd_info[dev].cyl;
+			g.start = get_start_sect(inode->i_bdev);
+			return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
+		}
+
+		default:
+			return -EINVAL;
+	}
+}
+
+static int hd_open(struct inode * inode, struct file * filp)
+{
+	int target =  DEVICE_NR(inode->i_rdev);
+	if (target >= NR_HD)
+		return -ENODEV;
+	return 0;
+}
+
+/*
+ * Releasing a block device means we sync() it, so that it can safely
+ * be forgotten about...
+ */
+
+extern struct block_device_operations hd_fops;
+
+static void hd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	void (*handler)(void) = do_hd;
+
+	do_hd = NULL;
+	del_timer(&device_timer);
+	if (!handler)
+		handler = unexpected_hd_interrupt;
+	handler();
+	local_irq_enable();
+}
+
+static struct block_device_operations hd_fops = {
+	.open =		hd_open,
+	.ioctl =	hd_ioctl,
+};
+
+/*
+ * This is the hard disk IRQ description. The SA_INTERRUPT in sa_flags
+ * means we run the IRQ-handler with interrupts disabled:  this is bad for
+ * interrupt latency, but anything else has led to problems on some
+ * machines.
+ *
+ * We enable interrupts in some of the routines after making sure it's
+ * safe.
+ */
+
+static int __init hd_init(void)
+{
+	int drive;
+	if (register_blkdev(MAJOR_NR,"hd",&hd_fops)) {
+		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
+		return -1;
+	}
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_hd_request, &hd_lock);
+	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
+	init_timer(&device_timer);
+	device_timer.function = hd_times_out;
+	blk_queue_hardsect_size(QUEUE, 512);
+
+#ifdef __i386__
+	if (!NR_HD) {
+		extern struct drive_info drive_info;
+		unsigned char *BIOS = (unsigned char *) &drive_info;
+		unsigned long flags;
+#ifndef CONFIG_PC9800
+		int cmos_disks;
+#endif
+
+		for (drive=0 ; drive<2 ; drive++) {
+			hd_info[drive].cyl = *(unsigned short *) BIOS;
+			hd_info[drive].head = *(3+BIOS);
+			hd_info[drive].sect = *(2+BIOS);
+			hd_info[drive].wpcom = 0;
+			hd_info[drive].ctl = *(3+BIOS) > 8 ? 8 : 0;
+			hd_info[drive].lzone = *(unsigned short *) BIOS;
+			if (hd_info[drive].cyl && NR_HD == drive)
+				NR_HD++;
+			BIOS += 6;
+		}
+
+	}
+#endif /* __i386__ */
+#ifdef __arm__
+	if (!NR_HD) {
+		/* We don't know anything about the drive.  This means
+		 * that you *MUST* specify the drive parameters to the
+		 * kernel yourself.
+		 */
+		printk("hd: no drives specified - use hd=cyl,head,sectors"
+			" on kernel command line\n");
+	}
+#endif
+	if (!NR_HD)
+		goto out;
+
+	for (drive=0 ; drive < NR_HD ; drive++) {
+		struct gendisk *disk = alloc_disk();
+		if (!disk)
+			goto Enomem;
+		disk->major = MAJOR_NR;
+		disk->first_minor = drive << 6;
+		disk->minor_shift = 6;
+		disk->fops = &hd_fops;
+		sprintf(disk->disk_name, "hd%c", 'a'+drive);
+		hd_gendisk[drive] = disk;
+	}
+	for (drive=0 ; drive < NR_HD ; drive++) {
+		sector_t size = hd_info[drive].head *
+			hd_info[drive].sect * hd_info[drive].cyl;
+		set_capacity(hd_gendisk[drive], size);
+		printk ("%s: %ldMB, CHS=%d/%d/%d\n",
+			hd_gendisk[drive]->disk_name,
+			size / 2048, hd_info[drive].cyl,
+			hd_info[drive].head, hd_info[drive].sect);
+	}
+
+	if (request_irq(HD_IRQ, hd_interrupt, SA_INTERRUPT, "hd", NULL)) {
+		printk("hd: unable to get IRQ%d for the hard disk driver\n",
+			HD_IRQ);
+		goto out1;
+	}
+
+	if (!request_region(HD_DATA, 2, "hd(data)")) {
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		NR_HD = 0;
+		free_irq(HD_IRQ, NULL);
+		return;
+	}
+
+	if (!request_region(HD_DATA + 2, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out2;
+	}
+
+	if (!request_region(HD_DATA + 4, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out3;
+	}
+
+	if (!request_region(HD_DATA + 6, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out4;
+	}
+
+	if (!request_region(HD_DATA + 8, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out5;
+	}
+
+	if (!request_region(HD_DATA + 10, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out6;
+	}
+
+	if (!request_region(HD_DATA + 12, 1, "hd"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_DATA);
+		goto out7;
+	}
+
+	if (!request_region(HD_CMD, 1, "hd(cmd)"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_CMD);
+		goto out8;
+	}
+
+	if (!request_region(HD_CMD + 2, 1, "hd(cmd)"))
+	{
+		printk(KERN_WARNING "hd: port 0x%x busy\n", HD_CMD);
+		goto out9;
+	}
+
+	for(drive=0; drive < NR_HD; drive++) {
+		struct hd_i_struct *p = hd_info + drive;
+		set_capacity(hd_gendisk[drive], p->head * p->sect * p->cyl);
+		add_disk(hd_gendisk[drive]);
+	}
+	return 0;
+
+out9:
+	release_region(HD_CMD, 1);
+out8:
+	release_region(HD_DATA + 12, 1);
+out7:
+	release_region(HD_DATA + 10, 1);
+out6:
+	release_region(HD_DATA + 8, 1);
+out5:
+	release_region(HD_DATA + 6, 1);
+out4:
+	release_region(HD_DATA + 4, 1);
+out3:
+	release_region(HD_DATA + 2, 1);
+out2:
+	release_region(HD_DATA, 2);
+	free_irq(HD_IRQ, NULL);
+out1:
+	for (drive = 0; drive < NR_HD; drive++)
+		put_disk(hd_gendisk[drive]);
+	NR_HD = 0;
+out:
+	del_timer(&device_timer);
+	unregister_blkdev(MAJOR_NR,"hd");
+	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+	return -1;
+Enomem:
+	while (drive--)
+		put_disk(hd_gendisk[drive]);
+	goto out;
+}
+
+static int parse_hd_setup (char *line) {
+	int ints[6];
+
+	(void) get_options(line, ARRAY_SIZE(ints), ints);
+	hd_setup(NULL, ints);
+
+	return 1;
+}
+__setup("hd=", parse_hd_setup);
+
+module_init(hd_init);
diff -urN linux/drivers/ide/legacy/pc9800.c linux98/drivers/ide/legacy/pc9800.c
--- linux/drivers/ide/legacy/pc9800.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/ide/legacy/pc9800.c	Tue Oct  8 17:06:39 2002
@@ -0,0 +1,82 @@
+/*
+ *  ide_pc9800.c
+ *
+ *  Copyright (C) 1997-2000  Linux/98 project,
+ *			     Kyoto University Microcomputer Club.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+#define PC9800_IDE_BANKSELECT	0x432
+
+#define DEBUG
+
+static void
+pc9800_select(ide_drive_t *drive)
+{
+#ifdef DEBUG
+	byte old;
+
+	/* Too noisy: */
+	/* printk(KERN_DEBUG "pc9800_select(%s)\n", drive->name); */
+
+	outb(0x80, PC9800_IDE_BANKSELECT);
+	old = inb(PC9800_IDE_BANKSELECT);
+	if (old != HWIF(drive)->index)
+		printk(KERN_DEBUG "ide-pc9800: switching bank #%d -> #%d\n",
+			old, HWIF(drive)->index);
+#endif
+	outb(HWIF(drive)->index, PC9800_IDE_BANKSELECT);
+}
+
+void __init
+ide_probe_for_pc9800(void)
+{
+	byte tmp;
+
+	if (!PC9800_9821_P() /* || !PC9821_IDEIF_DOUBLE_P() */)
+		return;
+
+	if (check_region(PC9800_IDE_BANKSELECT, 1)) {
+		printk(KERN_ERR
+			"ide: bank select port (%#x) is already occupied!\n",
+			PC9800_IDE_BANKSELECT);
+		return;
+	}
+
+	/* Do actual probing. */
+	if ((tmp = inb(PC9800_IDE_BANKSELECT)) == (byte) ~0
+	    || (outb(tmp ^ 1, PC9800_IDE_BANKSELECT),
+		/* Next outb is dummy for reading status. */
+		outb(0x80, PC9800_IDE_BANKSELECT),
+		inb(PC9800_IDE_BANKSELECT) != (tmp ^ 1))) {
+		printk(KERN_INFO
+			"ide: pc9800 type bank selecting port not found\n");
+		return;
+	}
+	/* Restore original value, just in case. */
+	outb(tmp, PC9800_IDE_BANKSELECT);
+
+	request_region(PC9800_IDE_BANKSELECT, 1, "ide0/1 bank");
+
+	/* These ports are probably used by IDE I/F.  */
+	request_region(0x430, 1, "ide");
+	request_region(0x435, 1, "ide");
+
+	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET] == HD_DATA
+	    && ide_hwifs[1].io_ports[IDE_DATA_OFFSET] == HD_DATA) {
+		ide_hwifs[0].chipset = ide_pc9800;
+		ide_hwifs[0].mate = &ide_hwifs[1];
+		ide_hwifs[0].selectproc = pc9800_select;
+		ide_hwifs[1].chipset = ide_pc9800;
+		ide_hwifs[1].mate = &ide_hwifs[0];
+		ide_hwifs[1].selectproc = pc9800_select;
+	}
+}
diff -urN linux/include/asm-i386/ide.h linux98/include/asm-i386/ide.h
--- linux/include/asm-i386/ide.h	Sat Oct 12 13:21:31 2002
+++ linux98/include/asm-i386/ide.h	Sun Oct 13 23:17:54 2002
@@ -26,6 +26,9 @@
 static __inline__ int ide_default_irq(ide_ioreg_t base)
 {
 	switch (base) {
+#ifdef CONFIG_PC9800
+		case 0x640: return 9;
+#endif /* CONFIG_PC9800 */
 		case 0x1f0: return 14;
 		case 0x170: return 15;
 		case 0x1e8: return 11;
@@ -39,7 +42,11 @@
 
 static __inline__ ide_ioreg_t ide_default_io_base(int index)
 {
+#ifndef CONFIG_PC9800
 	static unsigned long ata_io_base[MAX_HWIFS] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
+#else /* CONFIG_PC9800 */
+	static unsigned long ata_io_base[MAX_HWIFS] = { 0x640, 0x640, 0, 0, 0, 0 };
+#endif /* !CONFIG_PC9800 */
 
 	return ata_io_base[index];
 }
@@ -48,13 +55,24 @@
 {
 	ide_ioreg_t reg = data_port;
 	int i;
+#ifdef CONFIG_PC9800
+	ide_ioreg_t increment = data_port == 0x640 ? 2 : 1;
+#endif
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
+#ifndef CONFIG_PC9800
 		reg += 1;
+#else
+		reg += increment;
+#endif
 	}
 	if (ctrl_port) {
 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+#ifdef CONFIG_PC9800
+	} else if (data_port == 0x640) {
+		hw->io_ports[IDE_CONTROL_OFFSET] = 0x74c;
+#endif
 	} else {
 		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
 	}
diff -urN linux/include/linux/hdreg.h linux98/include/linux/hdreg.h
--- linux/include/linux/hdreg.h	Sat Oct 12 13:22:07 2002
+++ linux98/include/linux/hdreg.h	Sat Oct 12 19:38:02 2002
@@ -5,11 +5,13 @@
  * This file contains some defines for the AT-hd-controller.
  * Various sources.
  */
+#include <linux/config.h>
 
 /* ide.c has its own port definitions in "ide.h" */
 
 #define HD_IRQ		14
 
+#ifndef CONFIG_PC9800
 /* Hd controller regs. Ref: IBM AT Bios-listing */
 #define HD_DATA		0x1f0		/* _CTL when writing */
 #define HD_ERROR	0x1f1		/* see err-bits */
@@ -25,6 +27,23 @@
 
 #define HD_CMD		0x3f6		/* used for resets */
 #define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
+#else /* CONFIG_PC9800 */
+/* Hd controller regs. for NEC PC-9800 */
+#define HD_DATA		0x640	/* _CTL when writing */
+#define HD_ERROR	0x642	/* see err-bits */
+#define HD_NSECTOR	0x644	/* nr of sectors to read/write */
+#define HD_SECTOR	0x646	/* starting sector */
+#define HD_LCYL		0x648	/* starting cylinder */
+#define HD_HCYL		0x64a	/* high byte of starting cyl */
+#define HD_CURRENT	0x64c	/* 101dhhhh , d=drive, hhhh=head */
+#define HD_STATUS	0x64e	/* see status-bits */
+#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
+#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
+#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
+
+#define HD_CMD		0x74c	/* used for resets */
+#define HD_ALTSTATUS	0x74c	/* same as HD_STATUS but doesn't clear irq */
+#endif /* CONFIG_PC9800 */
 
 /* remainder is shared between hd.c, ide.c, ide-cd.c, and the hdparm utility */
 
diff -urN linux/include/linux/ide.h linux98/include/linux/ide.h
--- linux/include/linux/ide.h	Sat Oct 12 13:21:41 2002
+++ linux98/include/linux/ide.h	Sat Oct 12 14:18:54 2002
@@ -286,7 +286,7 @@
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
-		ide_pmac,	ide_etrax100,	ide_acorn
+		ide_pmac,	ide_etrax100,	ide_acorn,	ide_pc9800
 } hwif_chipset_t;
 
 typedef struct ide_io_ops_s {
