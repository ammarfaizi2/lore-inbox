Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJDAdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTJDAdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:33:13 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:27521 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261592AbTJDAcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 20:32:33 -0400
Message-ID: <3F7E1509.7D08EC2D@sgi.com>
Date: Fri, 03 Oct 2003 17:32:09 -0700
From: Aniket Malatpure <aniket@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.8C-SGI [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: akmp@osdl.org, gwh@sgi.com, jeremy@sgi.com, jbarnes@sgi.com,
       aniket_m@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
References: <3F7CB4A9.3C1F1237@sgi.com> <200310031645.57341.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------921E65EA1B6F7F303EB4E9E6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------921E65EA1B6F7F303EB4E9E6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

Attached is a new patch which takes into account the comments on the earlier
patch.
I have changed the patch as per the comments below :

--------------------------------------------------------------------------------------------------
a) Comments from Andrew Morton :

>> +++ b/drivers/ide/pci/sgiioc4.c       Thu Oct  2 16:53:34 2003
>> +
>>+extern int dma_timer_expiry(ide_drive_t * drive);

>This is unused.  Just as well, as it is static to a different file.

This line has been removed.

>> +static struct pci_device_id sgiioc4_pci_tbl[] __devinitdata = {

>This cannot be __devinitdata because the PCI table walking will look at it
>even after __init code has been dropped.  We've had oopses from this.

The __devinitdata attribute has been removed from this declaration.


>> --- /dev/null Wed Dec 31 16:00:00 1969
>> +++ b/drivers/ide/pci/sgiioc4.h       Thu Oct  2 16:53:34 2003

>hrm, why does this file exist?  It has only one include site, and should
>not be included by other .c files anyway because it defines static storage.
>
>It looks like the whole file should just be pasted into sgiioc4.c?

This file has been merged with sgiioc4.c as was suggested.

>> +typedef volatile struct {
>> +     u32 timing_reg0;
>> +     u32 timing_reg1;
>> +     u32 low_mem_ptr;
>> +     u32 high_mem_ptr;
>> +     u32 low_mem_addr;
>> +     u32 high_mem_addr;
>> +     u32 dev_byte_count;
>> +     u32 mem_byte_count;
>> +     u32 status;
>> +} ioc4_dma_regs_t;
>
>Does this actually need to be volatile?

This structure is no longer volatile in the new patch.

--------------------------------------------------------------------------------------------------
b) Comments from Bartlomiej Zolnierkiewicz

>Please follow Documentation/CodingStyle and respect 80-columns limit.

Lindent has been used to format the original file. Some parts have been
reformatted by hand.
The 80 column limit is respected for a majority of the patch.

+ *
+ *     This code is identical to ide_raw_build_sglist in ide-dma.c
+ *     however that it not exported and even if it were would create
+ *     dependancy problems for modular drivers.
+ */
>What problems?
>BTW during coping tabs were replaced by spaces in these functions.

Actually what I meant by problems was that, when this driver is compiled as a
module and the earlier functions are not exported, the driver fails to find
them. I have removed the earlier line from the new patch.


+       return p - buffer;
+}

>Do you really need /proc/ide/sgiioc4?
>You can print revision number during init.

It has been helpful to be able to see the firmware revision num anytime during
system operation. 
So the new patch still creates the above entry.

+                                           int ddir);
+static unsigned int __init pci_init_sgiioc4(struct pci_dev
*dev,ide_pci_device_t *d);

>Most of this declarations are not needed as sgiioc4.h is only included from shiioc4.c.

The sgiioc4.h file has been removed in the new patch.
--------------------------------------------------------------------------------------------------

Please merge this patch if there are no other issues.

Thanks
Aniket
--------------921E65EA1B6F7F303EB4E9E6
Content-Type: text/plain; charset=us-ascii;
 name="ioc4_new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioc4_new.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1433  -> 1.1434 
#	drivers/ide/pci/Makefile	1.8     -> 1.9    
#	include/linux/pci_ids.h	1.123   -> 1.124  
#	 drivers/ide/Kconfig	1.29    -> 1.30   
#	               (new)	        -> 1.1     drivers/ide/pci/sgiioc4.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/03	aniket@tomahawk.engr.sgi.com	1.1434
# Adds support for the IOC4 IDE part.
# --------------------------------------------
#
diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	Fri Oct  3 17:04:27 2003
+++ b/drivers/ide/Kconfig	Fri Oct  3 17:04:27 2003
@@ -740,6 +740,13 @@
 	  This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
 	  chipsets.
 
+config BLK_DEV_SGIIOC4
+	tristate "Silicon Graphics IOC4 chipset support"
+	help
+	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
+	  chipset.  Please say Y here, if you have an Altix System from
+	  Silicon Graphics Inc.
+		
 config BLK_DEV_SIIMAGE
 	tristate "Silicon Image chipset support"
 	help
diff -Nru a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	Fri Oct  3 17:04:27 2003
+++ b/drivers/ide/pci/Makefile	Fri Oct  3 17:04:27 2003
@@ -22,6 +22,7 @@
 obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
 obj-$(CONFIG_BLK_DEV_RZ1000)		+= rz1000.o
 obj-$(CONFIG_BLK_DEV_SVWKS)		+= serverworks.o
+obj-$(CONFIG_BLK_DEV_SGIIOC4)		+= sgiioc4.o
 obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
 obj-$(CONFIG_BLK_DEV_SIS5513)		+= sis5513.o
 obj-$(CONFIG_BLK_DEV_SL82C105)		+= sl82c105.o
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/ide/pci/sgiioc4.c	Fri Oct  3 17:04:27 2003
@@ -0,0 +1,1044 @@
+/*
+ * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/hdreg.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <asm/io.h>
+
+#define IDE_ARCH_ACK_INTR	1
+#include <linux/ide.h>
+
+/* IOC4 Specific Definitions */
+#define IOC4_CMD_OFFSET		0x100
+#define IOC4_CTRL_OFFSET		0x120
+#define IOC4_DMA_OFFSET		0x140
+#define IOC4_INTR_OFFSET		0x0
+
+#define IOC4_TIMING			0x00
+#define IOC4_DMA_PTR_L			0x01
+#define IOC4_DMA_PTR_H			0x02
+#define IOC4_DMA_ADDR_L		0x03
+#define IOC4_DMA_ADDR_H		0x04
+#define IOC4_BC_DEV			0x05
+#define IOC4_BC_MEM			0x06
+#define IOC4_DMA_CTRL			0x07
+#define IOC4_DMA_END_ADDR		0x08
+
+/* Bits in the IOC4 Control/Status Register */
+#define IOC4_S_DMA_START		0x01
+#define IOC4_S_DMA_STOP		0x02
+#define IOC4_S_DMA_DIR			0x04
+#define IOC4_S_DMA_ACTIVE		0x08
+#define IOC4_S_DMA_ERROR		0x10
+#define IOC4_ATA_MEMERR		0x02
+
+/* Read/Write Directions */
+#define IOC4_DMA_WRITE			0x04
+#define IOC4_DMA_READ			0x00
+
+/* Interrupt Register Offsets */
+#define IOC4_INTR_REG			0x03
+#define IOC4_INTR_SET			0x05
+#define IOC4_INTR_CLEAR		0x07
+
+#define IOC4_IDE_CACHELINE_SIZE	128
+#define IOC4_CMD_CTL_BLK_SIZE		0x20
+#define IOC4_SUPPORTED_FIRMWARE_REV 46
+
+/* Weeds out non-IDE interrupts to the IOC4 */
+#define ide_ack_intr(hwif) ((hwif)->hw.ack_intr ?(hwif)->hw.ack_intr(hwif) : 1)
+
+#define SGIIOC4_MAX_DEVS	32
+
+#if  defined(CONFIG_PROC_FS)
+#include <linux/stat.h>
+#include <linux/proc_fs.h>
+
+static u8 sgiioc4_proc;
+
+static struct pci_dev *sgiioc4_devs[SGIIOC4_MAX_DEVS];
+static int sgiioc4_get_info(char *, char **, off_t, int);
+
+static ide_pci_host_proc_t sgiioc4_procs[] __initdata = {
+	{
+	 .name = "sgiioc4",
+	 .set = 1,
+	 .get_info = sgiioc4_get_info,
+	 .parent = NULL,
+	 }
+};
+#endif
+
+typedef struct {
+	u32 timing_reg0;
+	u32 timing_reg1;
+	u32 low_mem_ptr;
+	u32 high_mem_ptr;
+	u32 low_mem_addr;
+	u32 high_mem_addr;
+	u32 dev_byte_count;
+	u32 mem_byte_count;
+	u32 status;
+} ioc4_dma_regs_t;
+
+/* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
+/* IOC4 has only 1 IDE channel */
+#define IOC4_PRD_BYTES       16
+#define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
+
+typedef enum pciio_endian_e {
+	PCIDMA_ENDIAN_BIG,
+	PCIDMA_ENDIAN_LITTLE
+} pciio_endian_t;
+
+static void sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
+				    unsigned long ctrl_port,
+				    unsigned long irq_port);
+static void sgiioc4_ide_setup_pci_device(struct pci_dev *dev,
+					 ide_pci_device_t * d);
+static void sgiioc4_resetproc(ide_drive_t * drive);
+static void sgiioc4_maskproc(ide_drive_t * drive, int mask);
+static void sgiioc4_configure_for_dma(int dma_direction, ide_drive_t * drive);
+static void __init ide_init_sgiioc4(ide_hwif_t * hwif);
+static void __init ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base);
+static int sgiioc4_checkirq(ide_hwif_t * hwif);
+static int sgiioc4_clearirq(ide_drive_t * drive);
+static int sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count);
+static int sgiioc4_ide_dma_read(ide_drive_t * drive);
+static int sgiioc4_ide_dma_write(ide_drive_t * drive);
+static int sgiioc4_ide_dma_begin(ide_drive_t * drive);
+static int sgiioc4_ide_dma_end(ide_drive_t * drive);
+static int sgiioc4_ide_dma_check(ide_drive_t * drive);
+static int sgiioc4_ide_dma_on(ide_drive_t * drive);
+static int sgiioc4_ide_dma_off(ide_drive_t * drive);
+static int sgiioc4_ide_dma_off_quietly(ide_drive_t * drive);
+static int sgiioc4_ide_dma_test_irq(ide_drive_t * drive);
+static int sgiioc4_ide_dma_host_on(ide_drive_t * drive);
+static int sgiioc4_ide_dma_host_off(ide_drive_t * drive);
+static int sgiioc4_ide_dma_count(ide_drive_t * drive);
+static int sgiioc4_ide_dma_verbose(ide_drive_t * drive);
+static int sgiioc4_ide_dma_lostirq(ide_drive_t * drive);
+static int sgiioc4_ide_dma_timeout(ide_drive_t * drive);
+static int sgiioc4_ide_build_sglist(ide_drive_t * drive, struct request *rq);
+static int sgiioc4_ide_raw_build_sglist(ide_drive_t * drive,
+					struct request *rq);
+static u8 sgiioc4_INB(unsigned long port);
+static inline void xide_delay(long ticks);
+static unsigned int sgiioc4_build_dma_table(ide_drive_t * drive,
+					    struct request *rq, int ddir);
+static unsigned int __init pci_init_sgiioc4(struct pci_dev *dev,
+					    ide_pci_device_t * d);
+
+static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
+	{
+	 /* Channel 0 */
+	 .vendor = PCI_VENDOR_ID_SGI,
+	 .device = PCI_DEVICE_ID_SGI_IOC4,
+	 .name = "SGIIOC4",
+	 .init_chipset = NULL,
+	 .init_iops = NULL,
+	 .init_hwif = ide_init_sgiioc4,
+	 .init_dma = ide_dma_sgiioc4,
+	 .channels = 1,
+	 .autodma = AUTODMA,
+	 .enablebits = {{0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}},
+	 .bootable = ON_BOARD,
+	 .extra = 0,
+	 }
+};
+
+#ifdef CONFIG_PROC_FS
+static u8 sgiioc4_proc;
+#endif				/* CONFIG_PROC_FS */
+
+static int n_sgiioc4_devs;
+
+static inline void
+xide_delay(long ticks)
+{
+	if (!ticks)
+		return;
+
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(ticks);
+}
+static void __init
+sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
+{
+	unsigned long base = 0, ctl = 0, dma_base = 0, irqport = 0;
+	ide_hwif_t *hwif = NULL;
+	int h = 0;
+
+	/*  Get the CmdBlk and CtrlBlk Base Registers */
+	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
+	ctl = pci_resource_start(dev, 0) + IOC4_CTRL_OFFSET;
+	irqport = pci_resource_start(dev, 0) + IOC4_INTR_OFFSET;
+	dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;
+
+	if (!request_region(base, IOC4_CMD_CTL_BLK_SIZE, hwif->name)) {
+		printk(KERN_ERR
+		       "%s:%s -- Warning, Port Addresses 0x%p to 0x%p ALREADY in use\n",
+		       __FUNCTION__, hwif->name, (void *) base,
+		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
+	}
+
+	for (h = 0; h < MAX_HWIFS; ++h) {
+		hwif = &ide_hwifs[h];
+		/* Find an empty HWIF */
+		if (hwif->chipset == ide_unknown)
+			break;
+	}
+
+	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
+		/* Initialize the IO registers */
+		sgiioc4_init_hwif_ports(&hwif->hw, base, ctl, irqport);
+		memcpy(hwif->io_ports, hwif->hw.io_ports,
+		       sizeof (hwif->io_ports));
+		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
+	}
+
+	hwif->irq = dev->irq;
+	hwif->chipset = ide_pci;
+	hwif->pci_dev = dev;
+	hwif->channel = 0;	/* Single Channel chip */
+	hwif->cds = (struct ide_pci_device_s *) d;
+	hwif->hw.ack_intr = &sgiioc4_checkirq;	/* MultiFunction Chip */
+	hwif->gendev.parent = &dev->dev;	/* setup proper ancestral information */
+
+	/* Initializing chipset IRQ Registers */
+	hwif->OUTL(0x03, irqport + IOC4_INTR_SET * 4);
+
+	(void) ide_init_sgiioc4(hwif);
+
+	if (dma_base)
+		ide_dma_sgiioc4(hwif, dma_base);
+	else
+		printk(KERN_INFO "%s: %s Bus-Master DMA disabled \n",
+		       hwif->name, d->name);
+
+	probe_hwif_init(hwif);
+}
+
+/* This ensures that we can build this for generic kernels without
+ * having all the SN2 code sync'd and merged. 
+ */
+
+pciio_endian_t __attribute__ ((weak)) snia_pciio_endian_set(struct pci_dev
+							    *pci_dev, pciio_endian_t device_end,
+							    pciio_endian_t desired_end);
+
+static unsigned int __init
+pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
+{
+
+	if (pci_enable_device(dev)) {
+		printk(KERN_INFO
+		       "Failed to enable device %s at slot %s \n",
+		       d->name, dev->slot_name);
+		return 1;
+	}
+	pci_set_master(dev);
+
+	/* Enable Byte Swapping in the PIC... */
+	if (snia_pciio_endian_set) {
+		snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
+				      PCIDMA_ENDIAN_BIG);
+	} else {
+		printk(KERN_INFO
+		       "Failed to set endianness for device %s at slot %s \n",
+		       d->name, dev->slot_name);
+		return 1;
+	}
+
+#ifdef CONFIG_PROC_FS
+	sgiioc4_devs[n_sgiioc4_devs++] = dev;
+	if (!sgiioc4_proc) {
+		sgiioc4_proc = 1;
+		ide_pci_register_host_proc(&sgiioc4_procs[0]);
+	}
+#endif
+	sgiioc4_ide_setup_pci_device(dev, d);
+
+	return 0;
+}
+
+static void
+sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
+			unsigned long ctrl_port, unsigned long irq_port)
+{
+	unsigned long reg = data_port;
+	int i;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+		hw->io_ports[i] = reg + i * 4;/* Registers are word (32 bit) aligned */
+
+	if (ctrl_port)
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+
+	if (irq_port)
+		hw->io_ports[IDE_IRQ_OFFSET] = irq_port;
+}
+
+static void
+sgiioc4_resetproc(ide_drive_t * drive)
+{
+	sgiioc4_ide_dma_end(drive);
+	sgiioc4_clearirq(drive);
+}
+
+static void
+sgiioc4_maskproc(ide_drive_t * drive, int mask)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	hwif->OUTB(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
+		   IDE_CONTROL_REG);
+}
+
+static void __init
+ide_init_sgiioc4(ide_hwif_t * hwif)
+{
+	hwif->mmio = 2;
+	hwif->autodma = 1;
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
+	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
+	hwif->swdma_mask = 0x2;
+	hwif->identify = NULL;
+	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */
+	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
+	hwif->selectproc = NULL;/* Use the default routine to select drive */
+	hwif->reset_poll = NULL;	/* No HBA specific reset_poll needed */
+	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
+	hwif->resetproc = &sgiioc4_resetproc;/*Reset DMA engine, clear interrupts */
+	hwif->intrproc = NULL;	/* Enable or Disable interrupt from drive */
+	hwif->maskproc = &sgiioc4_maskproc;	/* Mask on/off NIEN register */
+	hwif->quirkproc = NULL;
+	hwif->busproc = NULL;
+
+	hwif->ide_dma_read = &sgiioc4_ide_dma_read;
+	hwif->ide_dma_write = &sgiioc4_ide_dma_write;
+	hwif->ide_dma_begin = &sgiioc4_ide_dma_begin;
+	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
+	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
+	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
+	hwif->ide_dma_off = &sgiioc4_ide_dma_off;
+	hwif->ide_dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
+	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
+	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
+	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
+	hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
+	hwif->ide_dma_good_drive = &__ide_dma_good_drive;
+	hwif->ide_dma_count = &sgiioc4_ide_dma_count;
+	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
+	hwif->ide_dma_retune = &__ide_dma_retune;
+	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
+	hwif->ide_dma_timeout = &sgiioc4_ide_dma_timeout;
+	hwif->INB = &sgiioc4_INB;
+}
+
+static int
+sgiioc4_ide_dma_read(ide_drive_t * drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int count = 0;
+
+	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_FROMDEVICE))) {
+		/* try PIO instead of DMA */
+		return 1;
+	}
+	/* Writes FROM the IOC4 TO Main Memory */
+	sgiioc4_configure_for_dma(IOC4_DMA_WRITE, drive);
+
+	return 0;
+}
+
+static int
+sgiioc4_ide_dma_write(ide_drive_t * drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int count = 0;
+
+	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_TODEVICE))) {
+		/* try PIO instead of DMA */
+		return 1;
+	}
+
+	sgiioc4_configure_for_dma(IOC4_DMA_READ, drive);
+	/* Writes TO the IOC4 FROM Main Memory */
+
+	return 0;
+}
+
+static int
+sgiioc4_ide_dma_begin(ide_drive_t * drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int reg = hwif->INL(hwif->dma_base + IOC4_DMA_CTRL * 4);
+	unsigned int temp_reg = reg | IOC4_S_DMA_START;
+
+	hwif->OUTL(temp_reg, hwif->dma_base + IOC4_DMA_CTRL * 4);
+
+	return 0;
+}
+
+/* Stops the IOC4 DMA Engine */
+static int
+sgiioc4_ide_dma_end(ide_drive_t * drive)
+{
+	u32 ioc4_dma, bc_dev, bc_mem, num, valid = 0, cnt = 0;
+	ide_hwif_t *hwif = HWIF(drive);
+	uint64_t dma_base = hwif->dma_base;
+	int dma_stat = 0, count;
+	unsigned long *ending_dma = (unsigned long *) hwif->dma_base2;
+
+	hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+
+	count = 0;
+	do {
+		xide_delay(count);
+		ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+		count += 10;
+	} while ((ioc4_dma & IOC4_S_DMA_STOP) && (count < 100));
+
+	if (ioc4_dma & IOC4_S_DMA_STOP) {
+		printk(KERN_ERR
+		       "%s(%s): IOC4 DMA STOP bit is still 1 : ioc4_dma_reg 0x%x\n",
+		       __FUNCTION__, drive->name, ioc4_dma);
+		dma_stat = 1;
+	}
+
+	if (ending_dma) {
+		do {
+			for (num = 0; num < 16; num++) {
+				if (ending_dma[num] & (~0ul)) {
+					valid = 1;
+					break;
+				}
+			}
+			xide_delay(cnt);
+		} while ((cnt++ < 100) && (!valid));
+	}
+
+	if (!valid)
+		printk(KERN_INFO "%s(%s) : Stale DMA Data in Memory\n",
+		       __FUNCTION__, drive->name);
+
+	bc_dev = hwif->INL(dma_base + IOC4_BC_DEV * 4);
+	bc_mem = hwif->INL(dma_base + IOC4_BC_MEM * 4);
+
+	if ((bc_dev & 0x01FF) || (bc_mem & 0x1FF)) {
+		if (bc_dev > bc_mem + 8) {
+			printk(KERN_ERR
+			       "%s(%s): WARNING!! byte_count_dev %d != byte_count_mem %d\n",
+			       __FUNCTION__, drive->name, bc_dev, bc_mem);
+		}
+	}
+
+	drive->waiting_for_dma = 0;
+	ide_destroy_dmatable(drive);
+
+	return dma_stat;
+}
+
+static int
+sgiioc4_ide_dma_check(ide_drive_t * drive)
+{
+	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
+		printk(KERN_INFO
+		       "Couldnot set %s in Multimode-2 DMA mode \
+			   \ | Drive %s using PIO instead\n",
+		       drive->name, drive->name);
+		drive->using_dma = 0;
+	} else
+		drive->using_dma = 1;
+
+	return 0;
+}
+
+static int
+sgiioc4_ide_dma_on(ide_drive_t * drive)
+{
+	drive->using_dma = 1;
+
+	return HWIF(drive)->ide_dma_host_on(drive);
+}
+
+static int
+sgiioc4_ide_dma_off(ide_drive_t * drive)
+{
+	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
+
+	return HWIF(drive)->ide_dma_off_quietly(drive);
+}
+
+static int
+sgiioc4_ide_dma_off_quietly(ide_drive_t * drive)
+{
+	drive->using_dma = 0;
+
+	return HWIF(drive)->ide_dma_host_off(drive);
+}
+
+/* returns 1 if dma irq issued, 0 otherwise */
+static int
+sgiioc4_ide_dma_test_irq(ide_drive_t * drive)
+{
+	return sgiioc4_checkirq(HWIF(drive));
+}
+
+static int
+sgiioc4_ide_dma_host_on(ide_drive_t * drive)
+{
+	if (drive->using_dma)
+		return 0;
+
+	return 1;
+}
+
+static int
+sgiioc4_ide_dma_host_off(ide_drive_t * drive)
+{
+	sgiioc4_clearirq(drive);
+
+	return 0;
+}
+
+static int
+sgiioc4_ide_dma_count(ide_drive_t * drive)
+{
+	return HWIF(drive)->ide_dma_begin(drive);
+}
+
+static int
+sgiioc4_ide_dma_verbose(ide_drive_t * drive)
+{
+	if (drive->using_dma == 1)
+		printk(", UDMA(16)");
+	else
+		printk(", PIO");
+
+	return 1;
+}
+
+static int
+sgiioc4_ide_dma_lostirq(ide_drive_t * drive)
+{
+	HWIF(drive)->resetproc(drive);
+
+	return __ide_dma_lostirq(drive);
+}
+
+static int
+sgiioc4_ide_dma_timeout(ide_drive_t * drive)
+{
+	printk(KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
+	if (HWIF(drive)->ide_dma_test_irq(drive))
+		return 0;
+
+	return HWIF(drive)->ide_dma_end(drive);
+}
+
+static u8
+sgiioc4_INB(unsigned long port)
+{
+	u8 reg = (u8) inb(port);
+
+	if ((port & 0xFFF) == 0x11C) {	/* Status register of IOC4 */
+		if (reg & 0x51) {	/* Not busy...check for interrupt */
+			unsigned long other_ir = port - 0x110;
+			unsigned int intr_reg = (u32) inl(other_ir);
+
+			if (intr_reg & 0x03) {
+				/* Clear the Interrupt, Error bits on the IOC4 */
+				outl(0x03, other_ir);
+				intr_reg = (u32) inl(other_ir);
+			}
+		}
+	}
+
+	return reg;
+}
+
+/* Creates a dma map for the scatter-gather list entries */
+static void __init
+ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
+{
+	int num_ports = sizeof (ioc4_dma_regs_t);
+
+	printk(KERN_INFO "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name,
+	       dma_base, dma_base + num_ports - 1);
+
+	if (!request_region(dma_base, num_ports, hwif->name)) {
+		printk(KERN_ERR
+		       "%s(%s) -- WARNING, Addresses 0x%p to 0x%p ALREADY in use\n",
+		       __FUNCTION__, hwif->name, (void *) dma_base,
+		       (void *) dma_base + num_ports - 1);
+	}
+
+	hwif->dma_base = dma_base;
+	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
+						  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+						  &hwif->dmatable_dma);
+
+	if (!hwif->dmatable_cpu)
+		goto dma_alloc_failure;
+
+	hwif->sg_table =
+	    kmalloc(sizeof (struct scatterlist) * IOC4_PRD_ENTRIES, GFP_KERNEL);
+
+	if (!hwif->sg_table) {
+		pci_free_consistent(hwif->pci_dev,
+				    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
+		goto dma_alloc_failure;
+	}
+
+	hwif->dma_base2 =
+	    (unsigned long) pci_alloc_consistent(hwif->pci_dev,
+						 IOC4_IDE_CACHELINE_SIZE,
+						 (dma_addr_t *) &(hwif->dma_status));
+
+	if (!hwif->dma_base2) {
+		pci_free_consistent(hwif->pci_dev,
+				    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
+		kfree(hwif->sg_table);
+		goto dma_alloc_failure;
+	}
+
+	return;
+
+      dma_alloc_failure:
+	printk(KERN_INFO
+	       "%s() -- Error! Unable to allocate DMA Maps for drive %s\n",
+	       __FUNCTION__, hwif->name);
+	printk(KERN_INFO
+	       "Changing from DMA to PIO mode for Drive %s \n", hwif->name);
+
+	/* Disable DMA because we couldnot allocate any DMA maps */
+	hwif->autodma = 0;
+	hwif->atapi_dma = 0;
+}
+
+/* Initializes the IOC4 DMA Engine */
+static void
+sgiioc4_configure_for_dma(int dma_direction, ide_drive_t * drive)
+{
+	u32 ioc4_dma;
+	int count;
+	ide_hwif_t *hwif = HWIF(drive);
+	uint64_t dma_base = hwif->dma_base;
+	uint32_t dma_addr, ending_dma_addr;
+
+	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+
+	if (ioc4_dma & IOC4_S_DMA_ACTIVE) {
+		printk(KERN_WARNING
+		       "%s(%s):Warning!! DMA from previous transfer was still active\n",
+		       __FUNCTION__, drive->name);
+		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		count = 0;
+		do {
+			xide_delay(count);
+			ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+			count += 10;
+		} while ((ioc4_dma & IOC4_S_DMA_STOP) && (count < 100));
+
+		if (ioc4_dma & IOC4_S_DMA_STOP)
+			printk(KERN_ERR
+			       "%s(%s) : IOC4 Dma STOP bit is still 1\n",
+			       __FUNCTION__, drive->name);
+	}
+
+	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+	if (ioc4_dma & IOC4_S_DMA_ERROR) {
+		printk(KERN_WARNING
+		       "%s(%s) : Warning!! - DMA Error during Previous transfer |\
+			   \ status 0x%x \n",
+		       __FUNCTION__, drive->name, ioc4_dma);
+		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		count = 0;
+		do {
+			ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+			xide_delay(count);
+			count += 10;
+		} while ((ioc4_dma & IOC4_S_DMA_STOP) && (count < 100));
+
+		if (ioc4_dma & IOC4_S_DMA_STOP)
+			printk(KERN_ERR
+			       "%s(%s) : IOC4 DMA STOP bit is still 1\n",
+			       __FUNCTION__, drive->name);
+	}
+
+	/* Address of the Scatter Gather List */
+	dma_addr = cpu_to_le32(hwif->dmatable_dma);
+	hwif->OUTL(dma_addr, dma_base + IOC4_DMA_PTR_L * 4);
+
+	/* Address of the Ending DMA */
+	memset((unsigned int *) hwif->dma_base2, 0, IOC4_IDE_CACHELINE_SIZE);
+	ending_dma_addr = cpu_to_le32(hwif->dma_status);
+	hwif->OUTL(ending_dma_addr, dma_base + IOC4_DMA_END_ADDR * 4);
+
+	hwif->OUTL(dma_direction, dma_base + IOC4_DMA_CTRL * 4);
+	drive->waiting_for_dma = 1;
+}
+
+/* IOC4 Scatter Gather list Format 						*/
+/* 128 Bit entries to support 64 bit addresses in the future			*/
+/* The Scatter Gather list Entry should be in the BIG-ENDIAN Format		*/
+/* --------------------------------------------------------------------	*/
+/* | Upper 32 bits - Zero 		| 	Lower 32 bits- address	     |		*/
+/* --------------------------------------------------------------------	*/
+/* | Upper 32 bits - Zero		|EOL|	 16 Bit Data Length	     |		*/
+/* --------------------------------------------------------------------	*/
+
+/* Creates the scatter gather list, DMA Table */
+static unsigned int
+sgiioc4_build_dma_table(ide_drive_t * drive, struct request *rq, int ddir)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int *table = hwif->dmatable_cpu;
+	unsigned int count = 0, i = 1;
+	struct scatterlist *sg;
+
+	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
+		hwif->sg_nents = i = sgiioc4_ide_raw_build_sglist(drive, rq);
+	else
+		hwif->sg_nents = i = sgiioc4_ide_build_sglist(drive, rq);
+
+	if (!i)
+		return 0;	/* sglist of length Zero */
+
+	sg = hwif->sg_table;
+	while (i && sg_dma_len(sg)) {
+		dma_addr_t cur_addr;
+		int cur_len;
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		while (cur_len) {
+			if (count++ >= IOC4_PRD_ENTRIES) {
+				printk(KERN_WARNING
+				       "%s: DMA table too small\n",
+				       drive->name);
+				goto use_pio_instead;
+			} else {
+				uint32_t xcount, bcount =
+				    0x10000 - (cur_addr & 0xffff);
+
+				if (bcount > cur_len)
+					bcount = cur_len;
+
+				/* put the addr, length in the IOC4 dma-table format */
+				*table = 0x0;
+				table++;
+				*table = cpu_to_be32(cur_addr);
+				table++;
+				*table = 0x0;
+				table++;
+
+				xcount = bcount & 0xffff;
+				*table = cpu_to_be32(xcount);
+				table++;
+
+				cur_addr += bcount;
+				cur_len -= bcount;
+			}
+		}
+
+		sg++;
+		i--;
+	}
+
+	if (count) {
+		table--;
+		*table |= cpu_to_be32(0x80000000);
+		return count;
+	}
+
+      use_pio_instead:
+	pci_unmap_sg(hwif->pci_dev, hwif->sg_table, hwif->sg_nents,
+		     hwif->sg_dma_direction);
+	hwif->sg_dma_active = 0;
+
+	return 0;		/* revert to PIO for this request */
+}
+
+static int
+sgiioc4_checkirq(ide_hwif_t * hwif)
+{
+	uint8_t intr_reg =
+	    hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + IOC4_INTR_REG * 4);
+
+	if (intr_reg & 0x03)
+		return 1;
+
+	return 0;
+}
+
+static int
+sgiioc4_clearirq(ide_drive_t * drive)
+{
+	u32 intr_reg;
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long other_ir =
+	    hwif->io_ports[IDE_IRQ_OFFSET] + (IOC4_INTR_REG << 2);
+
+	/* Code to check for PCI error conditions */
+	intr_reg = hwif->INL(other_ir);
+	if (intr_reg & 0x03) {
+		/* Valid IOC4-IDE interrupt */
+		u8 stat = hwif->INB(IDE_STATUS_REG);
+		int count = 0;
+		do {
+			xide_delay(count);
+			stat = hwif->INB(IDE_STATUS_REG);	
+			/* Removes Interrupt from IDE Device */
+		} while ((stat & 0x80) && (count++ < 1024));
+
+		if (intr_reg & 0x02) {
+			/* Error when transferring DMA data on PCI bus */
+			uint32_t pci_err_addr_low, pci_err_addr_high,
+			    pci_stat_cmd_reg;
+
+			pci_err_addr_low = hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET]);
+			pci_err_addr_high = hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + 4);
+			pci_read_config_dword(hwif->pci_dev,PCI_COMMAND, &pci_stat_cmd_reg);
+			printk(KERN_ERR
+			       "%s(%s) : PCI Bus Error when doing DMA \
+				   \ : status-cmd reg is 0x%x \n",
+			       __FUNCTION__, drive->name, pci_stat_cmd_reg);
+			printk(KERN_ERR
+			       "%s(%s) : PCI Error Address is 0x%x%x \n",
+			       __FUNCTION__, drive->name,
+			       pci_err_addr_high, pci_err_addr_low);
+			/* Clear the PCI Error indicator */
+			pci_write_config_dword(hwif->pci_dev, PCI_COMMAND, 0x00000146);
+		}
+
+		/* Clear the Interrupt, Error bits on the IOC4 */
+		hwif->OUTL(0x03, other_ir);	
+
+		intr_reg = hwif->INL(other_ir);
+	}
+
+	return intr_reg;
+}
+
+/**
+ * 	"Copied from drivers/ide/ide-dma.c"
+ *	sgiioc4_ide_build_sglist - map IDE scatter gather for DMA I/O
+ *	@hwif: the interface to build the DMA table for
+ *	@rq: the request holding the sg list
+ *	@ddir: data direction
+ *
+ *	Perform the PCI mapping magic neccessary to access the source
+ *	or target buffers of a request via PCI DMA. The lower layers
+ *	of the kernel provide the neccessary cache management so that
+ *	we can operate in a portable fashion.
+ *
+ *	This code is identical to ide_build_sglist in ide-dma.c
+ *	however that is not exported.
+ */
+
+static int
+sgiioc4_ide_build_sglist(ide_drive_t * drive, struct request *rq)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct scatterlist *sg = hwif->sg_table;
+	int nents;
+
+	if (hwif->sg_dma_active)
+		BUG();
+
+	nents = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
+
+	if (rq_data_dir(rq) == READ)
+		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+	else
+		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+}
+
+/**
+ * 	Copied from drivers/ide/ide-dma.c
+ *	sgiioc4_ide_raw_build_sglist	-	map IDE scatter gather for DMA
+ *	@hwif: the interface to build the DMA table for
+ *	@rq: the request holding the sg list
+ *
+ *	Perform the PCI mapping magic neccessary to access the source or
+ *	target buffers of a taskfile request via PCI DMA. The lower layers
+ *	of the  kernel provide the neccessary cache management so that we can
+ *	operate in a portable fashion
+ *
+ *	This code is identical to ide_raw_build_sglist in ide-dma.c
+ *	however that is not exported 
+ */
+
+static int
+sgiioc4_ide_raw_build_sglist(ide_drive_t * drive, struct request *rq)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct scatterlist *sg = hwif->sg_table;
+	int nents = 0;
+	ide_task_t *args = rq->special;
+	u8 *virt_addr = rq->buffer;
+	int sector_count = rq->nr_sectors;
+
+	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+	else
+		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
+#if 1
+	if (sector_count > 256)
+		BUG();
+
+	if (sector_count > 128) {
+#else
+	while (sector_count > 128) {
+#endif
+		memset(&sg[nents], 0, sizeof (*sg));
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = offset_in_page(virt_addr);
+		sg[nents].length = 128 * SECTOR_SIZE;
+		nents++;
+		virt_addr = virt_addr + (128 * SECTOR_SIZE);
+		sector_count -= 128;
+	}
+	memset(&sg[nents], 0, sizeof (*sg));
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = offset_in_page(virt_addr);
+	sg[nents].length = sector_count * SECTOR_SIZE;
+	nents++;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+}
+
+#ifdef CONFIG_PROC_FS
+
+static int
+sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	unsigned int class_rev;
+	int i = 0;
+
+	while (i < n_sgiioc4_devs) {
+		pci_read_config_dword(sgiioc4_devs[i], PCI_CLASS_REVISION, &class_rev);
+		class_rev &= 0xff;
+
+		if (sgiioc4_devs[i]->device == PCI_DEVICE_ID_SGI_IOC4) {
+			p += sprintf(p,
+					"\n\tSGI IOC4 Chipset rev %d. ",class_rev);
+			p += sprintf(p,
+					"\n\tChipset has 1 IDE channel and supports 2 devices on that channel.");
+			p += sprintf(p,
+					"\n\tChipset supports DMA in MultiMode-2 data transfer protocol.\n");
+			/* Do we need more info. here? */
+		}
+		i++;
+	}
+
+	return p - buffer;
+}
+
+#endif				/* CONFIG_PROC_FS */
+
+static int __devinit
+sgiioc4_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	unsigned int class_rev;
+	ide_pci_device_t *d = &sgiioc4_chipsets[id->driver_data];
+	if (dev->device != d->device) {
+		printk(KERN_ERR "Error in %s(dev 0x%p | id 0x%p )\n",
+		       __FUNCTION__, (void *) dev, (void *) id);
+		BUG();
+	}
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+
+	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
+		printk(KERN_INFO
+		       "Disabling IOC4 IDE Part due to unsupported Firmware Rev (%d)",
+		       class_rev);
+		printk(KERN_INFO
+		       "\nPlease upgrade to Firmware Rev 46 or higher \n");
+		return 0;
+	}
+
+	printk(KERN_INFO "%s: IDE controller at PCI slot %s\n", d->name,
+	       dev->slot_name);
+
+	if (pci_init_sgiioc4(dev, d))
+		return 0;
+
+	MOD_INC_USE_COUNT;
+
+	return 0;
+}
+
+static struct pci_device_id sgiioc4_pci_tbl[] = {
+	{PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4, PCI_ANY_ID,
+	 PCI_ANY_ID, 0x0b4000, 0xFFFFFF, 0},
+	{0}
+};
+
+static struct pci_driver driver = {
+	.name = "SGI-IOC4 IDE",
+	.id_table = sgiioc4_pci_tbl,
+	.probe = sgiioc4_init_one,
+};
+
+static int
+sgiioc4_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+static void
+sgiioc4_ide_exit(void)
+{
+	ide_pci_unregister_driver(&driver);
+}
+
+module_init(sgiioc4_ide_init);
+module_exit(sgiioc4_ide_exit);
+
+MODULE_AUTHOR("Aniket Malatpure - Silicon Graphics Inc. (SGI)");
+MODULE_DESCRIPTION("PCI driver module for SGI IOC4 Base-IO Card");
+MODULE_LICENSE("GPL");
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri Oct  3 17:04:27 2003
+++ b/include/linux/pci_ids.h	Fri Oct  3 17:04:27 2003
@@ -896,6 +896,7 @@
 
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
+#define PCI_DEVICE_ID_SGI_IOC4		0x100a
 #define PCI_VENDOR_ID_SGI_LITHIUM	0x1002
 
 #define PCI_VENDOR_ID_ACC		0x10aa

--------------921E65EA1B6F7F303EB4E9E6--

