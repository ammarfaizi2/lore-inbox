Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbTIQJKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTIQJKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:10:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10380 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262715AbTIQJJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:09:19 -0400
Date: Wed, 17 Sep 2003 14:41:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: lkcd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] Poll-based IDE dump driver for LKCD
Message-ID: <20030917144120.A11425@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ALL,
	Attached patch adds poll-based dump driver support in LKCD 
for IDE disks. The patch is against 2.6.0-test4. You will need
the latest LKCD sources (lkcd.sourceforge.net) before you can
apply this patch. 

The IDE dump driver does PIO to the disk drive and is based on 
Rusty's OOPS dump driver and the kernel IDE disk driver. 

The driver disables drive interrupts (nIEN bit) while 
writing to the disk. It then does a PIO of dump data to the 
disk and keeps polling for the write to be complete. After
the write is over, it issues PIO for the next chunk of dump
data and again polls for the write to get over.
This process is repeated till all the dump data is written to disk.
At the end of it, drive interrupts are enabled again.

The driver makes use of the multiple sector mode feature (if any)
that may be supported by the disk drive. For instance, if the drive
supports writing upto 16 sectors at a time, then 8KB (16 * 512) of dump
data are written at a time by the driver. This improves
the write performance.

The driver tries to minimize the dependency on kernel while
writing to disk (since the state of the kernel may not
be predictable at the time of the crash). In this regard, it makes 
a separate copy of the ide_hwif_t data structure associated
with the IDE drive and also has several ide_* functions duplicated
The duplicated ide_* function have been made "dump safe" in some cases
and in other cases have been merely duplicated to insulate
from changes happening in the mainline IDE layer.

It is possible to introduce all this dump functionality
in the existing kernel IDE disk driver itself and not 
have a separate IDE dump driver. We will do this based on the 
feedback from community.

I need inputs from IDE experts on several points:

	- Would a reset of the drive be required before talking to it?
	- When dump is initiated, I am assuming that the drive will be 
 	  accessible at the I/O port addresses assigned to it initially 
          during bootup. Can this assumption be wrong under some circumstances? 
  	  If so, how do I deal with it? 
	- What if the drive is in some power-save state when dump is being
	  initiated? How to deal with that situation?
	- Range of IDE controllers supported:
		Ideally I would like this driver to run on all the 
		IDE controllers supported in Linux. To this extent, I have 
		tried calling the I/O functions (OUTB, INB etc) associated 
		with the IDE hwif (I have made an assumption that these I/O 
		functions are dump safe).

		Like this, are there some more measures that I need to take
		in order for my driver to run on all the IDE controllers 
		supported in Linux?


Thanks in advance for any review comments on my patch!




diff -Naur linux-2.6.0-test4.org/drivers/dump/Makefile linux-2.6.0-test4/drivers/dump/Makefile
--- linux-2.6.0-test4.org/drivers/dump/Makefile	Sun Jul  6 18:52:21 2003
+++ linux-2.6.0-test4/drivers/dump/Makefile	Wed Sep 17 11:35:15 2003
@@ -9,7 +9,13 @@
 dump-objs				+= $(dump-y)
 
 obj-$(CONFIG_CRASH_DUMP)		+= dump.o
-obj-$(CONFIG_CRASH_DUMP_BLOCKDEV)	+= dump_blockdev.o
+
+# We link first dump_blockdev.o and then dump_ide.o.
+# This is done so that IDE driver gets a chance to claim the
+# target dump device and if it can't (because target is non-IDE disk)
+# dump_blockdev.c can claim it.
+
+obj-$(CONFIG_CRASH_DUMP_BLOCKDEV)	+= dump_blockdev.o dump_ide.o
 obj-$(CONFIG_CRASH_DUMP_NETDEV)	+= dump_netdev.o
 obj-$(CONFIG_CRASH_DUMP_COMPRESS_RLE)	+= dump_rle.o
 obj-$(CONFIG_CRASH_DUMP_COMPRESS_GZIP)	+= dump_gzip.o
diff -Naur linux-2.6.0-test4.org/drivers/dump/dump_ide.c linux-2.6.0-test4/drivers/dump/dump_ide.c
--- linux-2.6.0-test4.org/drivers/dump/dump_ide.c	Thu Jan  1 05:30:00 1970
+++ linux-2.6.0-test4/drivers/dump/dump_ide.c	Wed Sep 17 11:28:57 2003
@@ -0,0 +1,629 @@
+/* Polling dump driver for IDE disks.
+ *
+ * Started: August 2003 - Srivatsa Vaddagiri (vatsa@in.ibm.com)
+ * 	    Based on dump_blockdev.c, IDE Disk Driver and 
+ * 	    Rusty's OOPS dump driver
+ *
+ * This code is released under version 2 of the GNU GPL.
+ *
+ */
+
+
+
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <asm/hardirq.h>
+#include <linux/dump.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include "dump_methods.h"
+
+/* ToDo : Need to make target_hwif an array if we have to support dumping to multiple
+ * 	  devices simultaneously.
+ */
+
+
+/* ToDo : Move this structure to dumpdev.h ??? */
+
+struct dump_ideinfo {
+	struct dump_dev ddev;
+	kdev_t kdev_id;
+	struct block_device *bdev;
+	loff_t limit;
+	int err;
+	ide_hwif_t      target_hwif;
+	sector_t        target_offset;
+	loff_t start_offset;
+	int             target_hardsectsize;
+};
+
+ide_hwif_t      *ptarget_hwif;
+ide_drive_t     *ptarget_drive;
+
+static inline struct dump_ideinfo *DUMP_IDEDEV(struct dump_dev *dev)
+{
+	        return container_of(dev, struct dump_ideinfo, ddev);
+}
+
+#define DUMP_WAIT_DRQ	50000
+
+/* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
+/* ToDo : replace this routine based on loops_per_jiffy?? */
+static inline void dump_udelay(unsigned int num_usec)
+{
+	unsigned int i;
+	for (i = 0; i < 10000 * num_usec; i++);
+}
+
+static inline int
+match_hwif(ide_hwif_t *hwif)
+{
+	int i=0;
+
+	for (i=0; i<MAX_HWIFS; ++i)
+		if (hwif == &ide_hwifs[i])
+			return 1;
+
+	return 0;
+}
+
+/* Open the specified dump device.
+ *
+ * The open routine also serves as a 'probing' function 
+ * to determine if the target is a IDE disk.
+ */
+static int
+dump_ide_open(struct dump_dev *dev, unsigned long arg)
+{
+	struct dump_ideinfo *dump_idev = DUMP_IDEDEV(dev);
+	struct block_device *bdev;
+	int retval;
+	ide_drive_t *drive;
+	ide_hwif_t *hwif;
+	kdev_t	tdev;
+
+	if (!arg) {
+		retval = -EINVAL;
+		goto err;
+	}
+
+	/* get a corresponding block_dev struct for this */
+        bdev = bdget((dev_t)arg);
+        if (!bdev) {
+                retval = -ENODEV;
+                goto err;
+        }
+
+        /* get the block device opened */
+        if ((retval = blkdev_get(bdev, O_RDWR | O_LARGEFILE, 0, BDEV_RAW))) {
+                goto err1;
+        }
+
+	tdev = to_kdev_t((dev_t)arg);
+
+	drive = (ide_drive_t *) bdev->bd_disk->private_data;
+	if (!drive) {
+		retval = -ENODEV;
+		printk ("dump_ide_open: (%d, %d) not a valid IDE device\n", major(tdev), minor(tdev));
+		goto err2;
+	}
+
+	hwif = HWIF(drive);
+	if (!match_hwif(hwif)) {
+		retval = -ENODEV;
+		printk ("dump_ide_open: (%d, %d) not a valid IDE device\n", major(tdev), minor(tdev));
+		goto err2;
+	}
+	
+	if (!drive->present || !hwif->present || drive->media != ide_disk) {
+		retval = -ENODEV;
+		printk ("dump_ide_open: Error - No target disk present or target not
+			       a IDE disk \n");
+		goto err2;
+	}
+
+	/* Ok ..Seems to a valid IDE disk ...*/
+
+	memcpy(ptarget_hwif, HWIF(drive), sizeof(ide_hwif_t));
+	ptarget_drive = &ptarget_hwif->drives[drive->select.b.unit];
+
+	/* assign the new dump dev structure */
+        dump_idev->kdev_id = tdev;
+        dump_idev->bdev = bdev;
+	dump_idev->target_hardsectsize = bdev_hardsect_size(bdev);
+	dump_idev->target_offset       = bdev->bd_offset;
+        /* make a note of the limit */
+        dump_idev->limit = bdev->bd_inode->i_size;
+
+	printk ("Target IDE Drive is %s \n", drive->select.b.unit?"slave":"master");
+	printk ("Partition size = %d \n", dump_idev->limit );
+	printk ("Partition offset = %d \n", dump_idev->target_offset );
+	printk ("Sector size = %d \n", dump_idev->target_hardsectsize);
+	printk ("mult count = %d \n", ptarget_drive->mult_count);
+	printk ("io32bit = %d \n", ptarget_drive->io_32bit);
+	printk ("sect0 = %d \n", ptarget_drive->sect0);
+	printk ("IDE_DATA_REG  = %lx \n", IDE_DATA_REG);
+
+	printk("IDE Block device (%d,%d) successfully configured for dumping\n",
+               major(dump_idev->kdev_id),
+               minor(dump_idev->kdev_id));
+
+
+	/* ToDo : Do we need to do blkdev_put at the end of open routine
+	 * 	  to avoid caching problems?? 
+	 */
+
+
+        /* after opening the block device, return */
+        return retval;
+
+err2:   if (bdev) blkdev_put(bdev, BDEV_RAW);
+		goto err;
+err1:   if (bdev) bdput(bdev);
+        dump_idev->bdev = NULL;
+err:    return retval;
+}
+
+
+/* This is essentially same as 'ide_wait_stat' but 
+ * with these changes:
+ *
+ * 	- Calls to local_irq_set/local_irq_restore removed
+ * 	  (Interrupts need to be kept disabled while dump
+ * 	  is is in progress)
+ * 	- Dont consider max_failures for the drive
+ * 
+ */
+int dump_ide_wait_stat (ide_startstop_t *startstop, ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	u8 stat;
+	int i;
+ 
+	dump_udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
+	if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+		i=0;
+		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+			dump_udelay(1000);
+			i+=1000;
+			if (timeout && i>timeout) {
+				printk ("dump_ide_wait_stat: Timed out waiting for drive to be ready \n");
+				return 1;
+			}
+		}
+	}
+	/*
+	 * Allow status to settle, then read it again.
+	 * A few rare drives vastly violate the 400ns spec here,
+	 * so we'll wait up to 10usec for a "good" status
+	 * rather than expensively fail things immediately.
+	 * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
+	 */
+	for (i = 0; i < 10; i++) {
+		dump_udelay(1);
+		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
+			return 0;
+	}
+
+	return 1;
+
+}
+
+/* Same as 'ata_vlb_sync'.
+ * Has been duplicated to insulate from changes that
+ * can happen there
+ *
+ * ToDo: Remove this duplicate and call the original
+ * 'ata_tlb_sync'?
+ */
+void dump_ata_vlb_sync (ide_drive_t *drive, unsigned long port)
+{
+        (void) HWIF(drive)->INB(port);
+        (void) HWIF(drive)->INB(port);
+        (void) HWIF(drive)->INB(port);
+}
+
+
+/* Same as 'ata_output_data' but
+ * with these changes:
+ *
+ * 	- Remove calls to local_irq_save/local_irq_restore.
+ *
+ */
+void dump_ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
+{
+        ide_hwif_t *hwif        = HWIF(drive);
+        u8 io_32bit             = drive->io_32bit;
+
+        if (io_32bit) {
+                if (io_32bit & 2) {
+                        dump_ata_vlb_sync(drive, IDE_NSECTOR_REG);
+                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
+                } else
+                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
+        } else {
+                hwif->OUTSW(IDE_DATA_REG, buffer, wcount<<1);
+        }
+}
+
+
+/* Same as 'ata_bswap_data'.
+ * Has been duplicated to insulate from changes that
+ * can happen there
+ *
+ * ToDo: Remove this duplicate and call the original
+ * 'ata_bswap_data'?
+ */
+static void dump_ata_bswap_data (void *buffer, int wcount)
+{
+        u16 *p = buffer;
+
+        while (wcount--) {
+                *p = *p << 8 | *p >> 8; p++;
+                *p = *p << 8 | *p >> 8; p++;
+        }
+}
+
+
+/* Same as 'taskfile_output_data'.
+ * Has been duplicated to insulate from changes that
+ * can happen there
+ *
+ * ToDo: Remove this duplicate and call the original
+ * 'taskfile_output_data'?
+ */
+static void
+dump_taskfile_output_data(ide_drive_t *drive, void *buffer, u32 wcount)
+{
+	if (drive->bswap) {
+               dump_ata_bswap_data(buffer, wcount);
+               dump_ata_output_data(drive, buffer, wcount);
+               dump_ata_bswap_data(buffer, wcount);
+        } else {
+               dump_ata_output_data(drive, buffer, wcount);
+        }
+}
+
+/* Highly simplified version of 'ide_multwrite' */
+
+static int
+dump_ide_multwrite(ide_drive_t *drive, void *buf, unsigned long len)
+{
+	int tx_words;
+
+        tx_words = len>>2;
+
+        dump_taskfile_output_data(drive, buf, tx_words);
+
+        return len;
+}
+
+/*
+ * Write out a buffer after checking the device limitations,
+ * sector sizes, etc. Assumes the buffer is in directly mapped
+ * kernel address space (not vmalloc'ed).
+ * 
+ * Returns: number of bytes written or -ERRNO.
+ */
+static int
+dump_ide_write(struct dump_dev *dev, void *buf, unsigned long len)
+{
+	struct dump_ideinfo *dump_idev = DUMP_IDEDEV(dev);
+        loff_t offset = dev->curr_offset + dump_idev->start_offset;
+        int retval = -ENOSPC;
+	sector_t	block;
+	ide_drive_t	*drive = ptarget_drive;
+	ata_nsector_t	nsectors;
+	u8 lba48      = (drive->addressing == 1) ? 1 : 0;
+	task_ioreg_t command    = WIN_NOP;
+	ide_startstop_t	ret;
+        int mcount = drive->mult_count? drive->mult_count: 1;
+        int burstlen;
+        int actlen;
+
+        if (offset >= dump_idev->limit) {
+                printk("write: not enough space left on device!\n");
+                goto out;
+        }
+
+        /* don't write more blocks than our max limit */
+        if (offset + len > dump_idev->limit)
+                len = dump_idev->limit - offset;
+
+	retval=0;
+
+
+	/* ToDo : Should we consider making burstlen less than what device 
+	 * 	  supports?
+	 */
+	burstlen = mcount<<9;
+        actlen = len < burstlen?len:burstlen;
+
+	block = dump_idev->target_offset + (offset>>9);
+	nsectors.all = actlen >> 9;
+
+	block += ptarget_drive->sect0;
+
+	/* ToDo : How safe is it to access the OUTB function below??
+	 * 	  In most cases it should just be outb which shld 
+	 * 	  be safe enough. However, if on some platforms OUTB
+	 * 	  does something more complicated, then we need to make
+	 * 	  sure that it is dump "safe".
+	 *
+	 * 	  The same issue holds good for other I/O functions 
+	 * 	  (like INB, OUTSL etc) assosciated with the IDE interface.
+	 *
+	 */ 
+	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
+
+	if (drive->select.b.lba) {
+		if (drive->addressing == 1) {
+			task_ioreg_t tasklets[10];
+
+			tasklets[0] = 0;
+			tasklets[1] = 0;
+			tasklets[2] = nsectors.b.low;
+			tasklets[3] = nsectors.b.high;
+
+			tasklets[4] = (task_ioreg_t) block;
+			tasklets[5] = (task_ioreg_t) (block>>8);
+			tasklets[6] = (task_ioreg_t) (block>>16);
+			tasklets[7] = (task_ioreg_t) (block>>24);
+			if (sizeof(block) == 4) {
+				tasklets[8] = (task_ioreg_t) 0;
+				tasklets[9] = (task_ioreg_t) 0;
+			} else {
+				tasklets[8] = (task_ioreg_t)((u64)block >> 32);
+				tasklets[9] = (task_ioreg_t)((u64)block >> 40);
+			}
+			HWIF(drive)->OUTB(tasklets[1], IDE_FEATURE_REG);
+			HWIF(drive)->OUTB(tasklets[3], IDE_NSECTOR_REG);
+			HWIF(drive)->OUTB(tasklets[7], IDE_SECTOR_REG);
+			HWIF(drive)->OUTB(tasklets[8], IDE_LCYL_REG);
+			HWIF(drive)->OUTB(tasklets[9], IDE_HCYL_REG);
+
+			HWIF(drive)->OUTB(tasklets[0], IDE_FEATURE_REG);
+			HWIF(drive)->OUTB(tasklets[2], IDE_NSECTOR_REG);
+			HWIF(drive)->OUTB(tasklets[4], IDE_SECTOR_REG);
+			HWIF(drive)->OUTB(tasklets[5], IDE_LCYL_REG);
+			HWIF(drive)->OUTB(tasklets[6], IDE_HCYL_REG);
+			HWIF(drive)->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
+		} else {
+			HWIF(drive)->OUTB(0x00, IDE_FEATURE_REG);
+			HWIF(drive)->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+
+			HWIF(drive)->OUTB(block, IDE_SECTOR_REG);
+			HWIF(drive)->OUTB(block>>=8, IDE_LCYL_REG);
+			HWIF(drive)->OUTB(block>>=8, IDE_HCYL_REG);
+			HWIF(drive)->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
+		}
+	} else {
+		unsigned int sect,head,cyl,track;
+		track = (int)block / drive->sect;
+		sect  = (int)block % drive->sect + 1;
+		HWIF(drive)->OUTB(sect, IDE_SECTOR_REG);
+		head  = track % drive->head;
+		cyl   = track / drive->head;
+
+		HWIF(drive)->OUTB(0x00, IDE_FEATURE_REG);
+		HWIF(drive)->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+
+		HWIF(drive)->OUTB(cyl, IDE_LCYL_REG);
+		HWIF(drive)->OUTB(cyl>>8, IDE_HCYL_REG);
+		HWIF(drive)->OUTB(head|drive->select.all,IDE_SELECT_REG);
+	}
+
+	command = ((drive->mult_count) ?
+                           ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
+                           ((lba48) ? WIN_WRITE_EXT : WIN_WRITE));
+        HWIF(drive)->OUTB(command, IDE_COMMAND_REG);
+
+	dump_ide_wait_stat(&ret, drive, DATA_READY, drive->bad_wstat, DUMP_WAIT_DRQ);
+
+	retval = dump_ide_multwrite(drive, buf, actlen);
+
+	if (retval > 0)
+		dev->curr_offset += retval;
+
+out:
+	return retval;
+
+}
+
+/*
+ * Name: dump_block_ready()
+ * Func: check if the last dump write is over and ready for next request
+ */
+static int
+dump_ide_ready(struct dump_dev *dev, void *buf)
+{
+	int rc = -EAGAIN;
+	ide_drive_t	*drive = ptarget_drive; /* Needed for IDE_ macros below */
+
+	if ((ptarget_hwif->INB(IDE_STATUS_REG)) & BUSY_STAT)
+		goto out;
+
+	if (((ptarget_hwif->INB(IDE_STATUS_REG)) & READY_STAT))
+		rc = 0;
+
+out:
+	return rc;
+}
+
+
+static void inline
+disable_drive_interrupts(ide_drive_t *drive)
+{
+	if (IDE_CONTROL_REG)
+		HWIF(drive)->OUTB(drive->ctl|2, IDE_CONTROL_REG);
+
+}
+
+static void inline
+enable_drive_interrupts(ide_drive_t *drive)
+{
+	if (IDE_CONTROL_REG)
+		HWIF(drive)->OUTB(drive->ctl&0xfd, IDE_CONTROL_REG);
+
+}
+
+/*
+ * Prepare the dump device for use (silence any ongoing activity
+ * and quiesce state) when the system crashes.
+ */
+static int
+dump_ide_silence(struct dump_dev *dev)
+{
+	struct dump_ideinfo *dump_idev = DUMP_IDEDEV(dev);
+
+
+        /*
+         * Move to a softer level of silencing where no spin_lock_irqs
+         * are held on other cpus
+         */
+
+        dump_silence_level = DUMP_SOFT_SPIN_CPUS;
+
+	disable_drive_interrupts(ptarget_drive);
+
+	/* ToDo : 
+	 * 	- What if the disk is in some power save state? Need to wake it up?
+	 * 	- What if the disk is inaccessible (for some weird reason) at the I/O ports
+	 * 	  that were initially assigned to it? For ex: PCI configuration has changed 
+	 * 	  from the time the device was initialized to the point in time when dump is
+	 * 	  taken. Is this possible???
+	 * 	- Would a RESET of device be required before we start talking to the device?
+	 */
+
+	
+	/* ToDo : Need to evaluate the safety of calling
+	 * 	  kernel functions like printk, smp_processor_id etc
+	 */
+        printk("Dumping to block device (%d,%d) on CPU %d ...\n",
+               major(dump_idev->kdev_id), minor(dump_idev->kdev_id),
+               smp_processor_id());
+
+        return 0;
+}
+
+
+/*
+ * Seek to the specified offset in the dump device.
+ * Makes sure this is a valid offset, otherwise returns an error.
+ */
+static int
+dump_ide_seek(struct dump_dev *dev, loff_t off)
+{
+        struct dump_ideinfo *dump_idev = DUMP_IDEDEV(dev);
+	loff_t offset = off + dump_idev->start_offset;
+	
+        if (offset & ( PAGE_SIZE - 1)) {
+                printk("seek: non-page aligned\n");
+                return -EINVAL;
+        }
+
+        if (offset & (dump_idev->target_hardsectsize - 1)) {
+                printk("seek: not sector aligned \n");
+                return -EINVAL;
+        }
+
+        if (offset > dump_idev->limit) {
+                printk("seek: not enough space left on device!\n");
+                return -ENOSPC;
+        }
+        dev->curr_offset = off;
+        return 0;
+}
+
+/*
+ * Invoked when dumping is done. This is the time to put things back
+ * (i.e. undo the effects of dump_block_silence) so the device is
+ * available for normal use.
+ */
+static int
+dump_ide_resume(struct dump_dev *dev)
+{
+	enable_drive_interrupts(ptarget_drive);
+        return 0;
+}
+
+
+
+/*
+ * Close the dump device and release associated resources
+ * Invoked when unconfiguring the dump device.
+ */
+static int
+dump_ide_release(struct dump_dev *dev)
+{
+        struct dump_ideinfo *dump_idev = DUMP_IDEDEV(dev);
+
+        /* release earlier bdev if present */
+        if (dump_idev->bdev) {
+                blkdev_put(dump_idev->bdev, BDEV_RAW);
+                dump_idev->bdev = NULL;
+        }
+
+        return 0;
+}
+
+
+struct dump_dev_ops dump_idedev_ops = {
+        .open           = dump_ide_open,
+        .release        = dump_ide_release,
+        .silence        = dump_ide_silence,
+        .resume         = dump_ide_resume,
+        .seek           = dump_ide_seek,
+        .write          = dump_ide_write,
+        /* .read not implemented */
+        .ready          = dump_ide_ready
+};
+
+
+static struct dump_ideinfo default_dump_idedev = {
+        .ddev = {.type_name = "blockdev", .ops = &dump_idedev_ops,
+                        .curr_offset = 0},
+        /*
+         * leave enough room for the longest swap header possibly written
+         * written by mkswap (likely the largest page size supported by
+         * the arch 
+         */
+        .start_offset   = DUMP_HEADER_OFFSET,
+        .err            = 0
+        /* assume the rest of the fields are zeroed by default */
+};
+
+
+struct dump_ideinfo *dump_idedev = &default_dump_idedev;
+
+
+static int __init
+dump_idedev_init(void)
+{
+        if (dump_register_device(&dump_idedev->ddev) < 0) {
+                printk("IDE dump device driver registration failed\n");
+                return -1;
+        }
+	ptarget_hwif = &dump_idedev->target_hwif;
+
+        printk("IDE dump device driver for LKCD registered\n");
+        return 0;
+}
+
+static void __exit
+dump_idedev_cleanup(void)
+{
+	dump_unregister_device(&dump_idedev->ddev);
+	printk("IDE dump device driver for LKCD unregistered\n");
+}
+
+
+MODULE_AUTHOR("LKCD Development Team <lkcd-devel@lists.sourceforge.net>");
+MODULE_DESCRIPTION("IDE Dump Driver for Linux Kernel Crash Dump (LKCD)");
+MODULE_LICENSE("GPL");
+
+module_init(dump_idedev_init);
+module_exit(dump_idedev_cleanup);
diff -Naur linux-2.6.0-test4.org/drivers/dump/dump_scheme.c linux-2.6.0-test4/drivers/dump/dump_scheme.c
--- linux-2.6.0-test4.org/drivers/dump/dump_scheme.c	Sun Jul  6 18:52:21 2003
+++ linux-2.6.0-test4/drivers/dump/dump_scheme.c	Wed Sep 17 12:39:57 2003
@@ -279,7 +279,7 @@
 
 int dump_generic_configure(unsigned long devid)
 {
-	struct dump_dev *dev = dump_config.dumper->dev;
+	struct dump_dev *dev;
 	struct dump_data_filter *filter;
 	void *buf;
 	int ret = 0;
@@ -299,12 +299,24 @@
 	dump_config.dumper->dump_buf = buf + DUMP_PAGE_SIZE;
 	dumper_reset();
 
-	/* Open the dump device */
-	if (!dev)
+	/* Find the appropriate block driver (IDE or SCSI) 
+	 * for this device.
+	 *
+	 * Note: dump_target_init implicitly calls the open
+	 * 	 routine of the appropriate driver to 
+	 * 	 handle this device.
+	 */
+	if (dump_target_init(devid)) {
+		dump_free_mem(buf);
 		return -ENODEV;
+	}
 
-	if ((ret = dev->ops->open(dev, devid))) {
-	       return ret;
+	dev = dump_config.dumper->dev = dump_dev;
+	
+	/* Open the dump device */
+	if (!dev) {
+		dump_free_mem(buf);
+		return -ENODEV;
 	}
 
 	/* Initialise the memory ranges in the dump filter */
diff -Naur linux-2.6.0-test4.org/drivers/dump/dump_setup.c linux-2.6.0-test4/drivers/dump/dump_setup.c
--- linux-2.6.0-test4.org/drivers/dump/dump_setup.c	Thu Sep  4 12:16:08 2003
+++ linux-2.6.0-test4/drivers/dump/dump_setup.c	Tue Sep 16 16:56:06 2003
@@ -418,7 +418,6 @@
 	} else {
 		dump_config.dumper = &dumper_singlestage;
 	}	
-	dump_config.dumper->dev = dump_dev;
 
 	ret = dump_configure(devid);
 	if (!ret) {
@@ -434,12 +433,13 @@
 	return ret;
 }
 
-static int
-dump_target_init(int target)
+int
+dump_target_init(unsigned long devid)
 {
 	char type[20];
 	struct list_head *tmp;
 	struct dump_dev *dev;
+	int target = dump_config.flags & DUMP_FLAGS_TARGETMASK;
 	
 	switch (target) {
 		case DUMP_FLAGS_DISKDUMP:
@@ -458,8 +458,17 @@
 	list_for_each(tmp, &dump_target_list) {
 		dev = list_entry(tmp, struct dump_dev, list);
 		if (strcmp(type, dev->type_name) == 0) {
-			dump_dev = dev;
-			return 0;
+			int rc;
+
+			/* Essentially the open routine below
+			 * serves as a probing function.
+			 */
+			rc = dev->ops->open(dev, devid);
+			if (!rc) {
+				/* Ok ..the driver has accepted this device ..*/
+				dump_dev = dev;
+				return 0;
+			}
 		}
 	}
 	return -1;
@@ -543,9 +552,6 @@
 		if (arg < 0)
 			return -EINVAL;
 			
-		if (dump_target_init(arg & DUMP_FLAGS_TARGETMASK) < 0)
-			return -EINVAL; /* return proper error */
-
 		dump_config.flags = arg;
 		
 		pr_debug("Dump Flags 0x%lx\n", dump_config.flags);
@@ -645,6 +651,23 @@
 int
 dump_register_device(struct dump_dev *ddev)
 {
+
+	/* Allow more than one driver to register
+	 * with the same type_name. This is done
+	 * so that we can have multiple dump drivers (ex: IDE dump
+	 * driver, SCSI dump driver) of the same type
+	 * that can coexist.
+	 *
+	 * At configuration time, if the dump target is disk,
+	 * then the open routine of all registered dump drivers
+	 * having 'type_name' of "blockdev" will be invoked.
+	 * If the dump target is IDE disk, then the IDE dump
+	 * driver will claim it, if it is SCSI disk,
+	 * then the SCSI dump driver can claim it etc.
+	 *
+	 */
+
+#if 0
 	struct list_head *tmp;
 	struct dump_dev *dev;
 
@@ -656,6 +679,7 @@
 			return -1; /* return proper error */
 		}
 	}
+#endif
 	list_add(&(ddev->list), &dump_target_list);
 	
 	return 0;





		




-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
