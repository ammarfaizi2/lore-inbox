Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTJHDjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 23:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTJHDjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 23:39:44 -0400
Received: from zok.SGI.COM ([204.94.215.101]:61136 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261193AbTJHDjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 23:39:11 -0400
Date: Tue, 7 Oct 2003 20:38:09 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-ID: <20031008033809.GA29878@sgi.com>
References: <3F7CB4A9.3C1F1237@sgi.com> <200310041930.15385.bzolnier@elka.pw.edu.pl> <20031007082727.GA27934@sgi.com> <200310071527.56813.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <200310071527.56813.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2003 at 03:27:56PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 07 of October 2003 10:27, Jeremy Higdon wrote:
> > lspci gives the version number.
> > /proc/ide/sgiioc4 gives you:
> >
> >         SGI IOC4 Chipset rev 79.
> >         Chipset has 1 IDE channel and supports 2 devices on that channel.
> >         Chipset supports DMA in MultiMode-2 data transfer protocol.
> >
> > Is the # of IDE channels/devices and the DMA mode also available elsewhere?
> 
> Channels/devices is only available indirectly by /proc/ide/ device symlinks
> and mate entry in (ie.) ide0 proc directory.  Controller DMA mode info is not
> available.  However /proc/ide/sgiioc4 is useless for programs (parsing it to
> obtain needed info is a really bad idea) and info for users should be provided
> by drivers/ide/Kconfig (and optionally by init time message).

Okay, I've removed this /proc entry (which was the only /proc entry in the
driver).

> > How important is this to you?  It seems more a style issue.  I agree with
> > you, by the way.  When I write code, I try to minimize forward
> > declarations. If I can get rid of some easily, will that be good enough?
> 
> Okay, I can clear the rest.
> 
> It is good for simplicity (people reading this code) and maintainability
> (you don't have to update declaration if you change corresponding function).

Once I got started, I found that I was able to get rid of all of them.


> > What are they used for (i.e. what are you looking for in the comment)?
> 
> It is mainly x86 thing (if channel is disabled in BIOS we don't probe it).
> You can just put "/* SGI IOC4 doesn't have enablebits. */ somewhere.

done

> > > sgiioc4_init_one():
> > > +	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> > > +	class_rev &= 0xff;
> > >
> > > Access to PCI devices before pci_enable_device()
> > > (it is called later in pci_init_sgiioc4).
> >
> > Is pci_enable_device required before a config space access?
> 
> Yes, please read Documentation/pci.txt chapter 3.

Fixed.

Attached is the latest patch, which also includes your patch sent previously.
Thanks for your review and assistance.

I will be on a vacation starting tomorrow, so I won't be able to reply until
Oct 19th or 20th, in case there are any more issues.  Hopefully this one will
be okay  :-)

thanks

jeremy

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioc4.26.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1490  -> 1.1492 
#	drivers/ide/pci/Makefile	1.9     -> 1.10   
#	 include/linux/ide.h	1.75    -> 1.76   
#	include/linux/pci_ids.h	1.123   -> 1.124  
#	 drivers/ide/Kconfig	1.30    -> 1.32   
#	drivers/ide/arm/icside.c	1.10    -> 1.11   
#	drivers/ide/ide-dma.c	1.21    -> 1.22   
#	               (new)	        -> 1.2     drivers/ide/pci/sgiioc4.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/07	jeremy@tomahawk.engr.sgi.com	1.1491
# Add SGI IOC4.
# --------------------------------------------
# 03/10/07	jeremy@tomahawk.engr.sgi.com	1.1492
# Changes based on comments from Bartlomiej.
# --------------------------------------------
#
diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	Tue Oct  7 20:32:21 2003
+++ b/drivers/ide/Kconfig	Tue Oct  7 20:32:21 2003
@@ -740,6 +740,13 @@
 	  This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
 	  chipsets.
 
+config BLK_DEV_SGIIOC4
+	tristate "Silicon Graphics IOC4 chipset support"
+	help
+	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
+	  chipset, which has one channel and can support two devices.
+	  Please say Y here if you have an Altix System from SGI.
+		
 config BLK_DEV_SIIMAGE
 	tristate "Silicon Image chipset support"
 	help
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	Tue Oct  7 20:32:21 2003
+++ b/drivers/ide/arm/icside.c	Tue Oct  7 20:32:21 2003
@@ -214,7 +214,7 @@
 #define NR_ENTRIES 256
 #define TABLE_SIZE (NR_ENTRIES * 8)
 
-static void ide_build_sglist(ide_drive_t *drive, struct request *rq)
+static void icside_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct icside_state *state = hwif->hwif_data;
@@ -543,7 +543,7 @@
 	BUG_ON(hwif->sg_dma_active);
 	BUG_ON(dma_channel_active(hwif->hw.dma));
 
-	ide_build_sglist(drive, rq);
+	icside_build_sglist(drive, rq);
 
 	/*
 	 * Ensure that we have the right interrupt routed.
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Tue Oct  7 20:32:21 2003
+++ b/drivers/ide/ide-dma.c	Tue Oct  7 20:32:21 2003
@@ -200,8 +200,8 @@
  *	kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
- 
-static int ide_build_sglist (ide_drive_t *drive, struct request *rq)
+
+int ide_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
@@ -220,6 +220,8 @@
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
+EXPORT_SYMBOL_GPL(ide_build_sglist);
+
 /**
  *	ide_raw_build_sglist	-	map IDE scatter gather for DMA
  *	@drive: the drive to build the DMA table for
@@ -230,8 +232,8 @@
  *	of the  kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
- 
-static int ide_raw_build_sglist (ide_drive_t *drive, struct request *rq)
+
+int ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
@@ -269,6 +271,8 @@
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
+
+EXPORT_SYMBOL_GPL(ide_raw_build_sglist);
 
 /**
  *	ide_build_dmatable	-	build IDE DMA table
diff -Nru a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	Tue Oct  7 20:32:21 2003
+++ b/drivers/ide/pci/Makefile	Tue Oct  7 20:32:21 2003
@@ -21,6 +21,7 @@
 obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
 obj-$(CONFIG_BLK_DEV_RZ1000)		+= rz1000.o
 obj-$(CONFIG_BLK_DEV_SVWKS)		+= serverworks.o
+obj-$(CONFIG_BLK_DEV_SGIIOC4)		+= sgiioc4.o
 obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
 obj-$(CONFIG_BLK_DEV_SIS5513)		+= sis5513.o
 obj-$(CONFIG_BLK_DEV_SL82C105)		+= sl82c105.o
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/ide/pci/sgiioc4.c	Tue Oct  7 20:32:21 2003
@@ -0,0 +1,844 @@
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
+#define IOC4_CTRL_OFFSET	0x120
+#define IOC4_DMA_OFFSET		0x140
+#define IOC4_INTR_OFFSET	0x0
+
+#define IOC4_TIMING		0x00
+#define IOC4_DMA_PTR_L		0x01
+#define IOC4_DMA_PTR_H		0x02
+#define IOC4_DMA_ADDR_L		0x03
+#define IOC4_DMA_ADDR_H		0x04
+#define IOC4_BC_DEV		0x05
+#define IOC4_BC_MEM		0x06
+#define	IOC4_DMA_CTRL		0x07
+#define	IOC4_DMA_END_ADDR	0x08
+
+/* Bits in the IOC4 Control/Status Register */
+#define	IOC4_S_DMA_START	0x01
+#define	IOC4_S_DMA_STOP		0x02
+#define	IOC4_S_DMA_DIR		0x04
+#define	IOC4_S_DMA_ACTIVE	0x08
+#define	IOC4_S_DMA_ERROR	0x10
+#define	IOC4_ATA_MEMERR		0x02
+
+/* Read/Write Directions */
+#define	IOC4_DMA_WRITE		0x04
+#define	IOC4_DMA_READ		0x00
+
+/* Interrupt Register Offsets */
+#define IOC4_INTR_REG		0x03
+#define	IOC4_INTR_SET		0x05
+#define	IOC4_INTR_CLEAR		0x07
+
+#define IOC4_IDE_CACHELINE_SIZE	128
+#define IOC4_CMD_CTL_BLK_SIZE	0x20
+#define IOC4_SUPPORTED_FIRMWARE_REV 46
+
+/* Weeds out non-IDE interrupts to the IOC4 */
+#define ide_ack_intr(hwif) ((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
+
+#define SGIIOC4_MAX_DEVS	32
+
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
+
+
+static void
+sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
+			unsigned long ctrl_port, unsigned long irq_port)
+{
+	unsigned long reg = data_port;
+	int i;
+
+	/* Registers are word (32 bit) aligned */
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+		hw->io_ports[i] = reg + i * 4;
+
+	if (ctrl_port)
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+
+	if (irq_port)
+		hw->io_ports[IDE_IRQ_OFFSET] = irq_port;
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
+			pci_err_addr_low =
+				hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET]);
+			pci_err_addr_high =
+				hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + 4);
+			pci_read_config_dword(hwif->pci_dev, PCI_COMMAND,
+					      &pci_stat_cmd_reg);
+			printk(KERN_ERR
+			       "%s(%s) : PCI Bus Error when doing DMA:"
+				   " status-cmd reg is 0x%x\n",
+			       __FUNCTION__, drive->name, pci_stat_cmd_reg);
+			printk(KERN_ERR
+			       "%s(%s) : PCI Error Address is 0x%x%x\n",
+			       __FUNCTION__, drive->name,
+			       pci_err_addr_high, pci_err_addr_low);
+			/* Clear the PCI Error indicator */
+			pci_write_config_dword(hwif->pci_dev, PCI_COMMAND,
+					       0x00000146);
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
+static u32
+sgiioc4_ide_dma_stop(ide_hwif_t *hwif, u64 dma_base)
+{
+	u32	ioc4_dma;
+	int	count;
+
+	count = 0;
+	do {
+		xide_delay(count);
+		ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+		count += 10;
+	} while ((ioc4_dma & IOC4_S_DMA_STOP) && (count < 100));
+	return ioc4_dma;
+}
+
+/* Stops the IOC4 DMA Engine */
+static int
+sgiioc4_ide_dma_end(ide_drive_t * drive)
+{
+	u32 ioc4_dma, bc_dev, bc_mem, num, valid = 0, cnt = 0;
+	ide_hwif_t *hwif = HWIF(drive);
+	uint64_t dma_base = hwif->dma_base;
+	int dma_stat = 0;
+	unsigned long *ending_dma = (unsigned long *) hwif->dma_base2;
+
+	hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+
+	ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
+
+	if (ioc4_dma & IOC4_S_DMA_STOP) {
+		printk(KERN_ERR
+		       "%s(%s): IOC4 DMA STOP bit is still 1 :"
+		       "ioc4_dma_reg 0x%x\n",
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
+			       "%s(%s): WARNING!! byte_count_dev %d "
+			       "!= byte_count_mem %d\n",
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
+		       "Couldnot set %s in Multimode-2 DMA mode | "
+			   "Drive %s using PIO instead\n",
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
+static void
+sgiioc4_resetproc(ide_drive_t * drive)
+{
+	sgiioc4_ide_dma_end(drive);
+	sgiioc4_clearirq(drive);
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
+			/* Clear the Interrupt, Error bits on the IOC4 */
+			if (intr_reg & 0x03) {
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
+		       "%s(%s) -- ERROR, Addresses 0x%p to 0x%p "
+		       "ALREADY in use\n",
+		       __FUNCTION__, hwif->name, (void *) dma_base,
+		       (void *) dma_base + num_ports - 1);
+		goto dma_alloc_failure;
+	}
+
+	hwif->dma_base = dma_base;
+	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
+					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+					  &hwif->dmatable_dma);
+
+	if (!hwif->dmatable_cpu)
+		goto dma_alloc_failure;
+
+	hwif->sg_table =
+	    kmalloc(sizeof (struct scatterlist) * IOC4_PRD_ENTRIES, GFP_KERNEL);
+
+	if (!hwif->sg_table)
+		goto dma_sgalloc_failure;
+
+	hwif->dma_base2 = (unsigned long)
+		pci_alloc_consistent(hwif->pci_dev,
+				     IOC4_IDE_CACHELINE_SIZE,
+				     (dma_addr_t *) &(hwif->dma_status));
+
+	if (!hwif->dma_base2)
+		goto dma_base2alloc_failure;
+
+	return;
+
+dma_base2alloc_failure:
+	kfree(hwif->sg_table);
+
+dma_sgalloc_failure:
+	pci_free_consistent(hwif->pci_dev,
+			    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+			    hwif->dmatable_cpu, hwif->dmatable_dma);
+	printk(KERN_INFO
+	       "%s() -- Error! Unable to allocate DMA Maps for drive %s\n",
+	       __FUNCTION__, hwif->name);
+	printk(KERN_INFO
+	       "Changing from DMA to PIO mode for Drive %s\n", hwif->name);
+
+dma_alloc_failure:
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
+	ide_hwif_t *hwif = HWIF(drive);
+	uint64_t dma_base = hwif->dma_base;
+	uint32_t dma_addr, ending_dma_addr;
+
+	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+
+	if (ioc4_dma & IOC4_S_DMA_ACTIVE) {
+		printk(KERN_WARNING
+			"%s(%s):Warning!! DMA from previous transfer was still active\n",
+		       __FUNCTION__, drive->name);
+		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
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
+		       "%s(%s) : Warning!! - DMA Error during Previous"
+		       " transfer | status 0x%x\n",
+		       __FUNCTION__, drive->name, ioc4_dma);
+		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
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
+/* IOC4 Scatter Gather list Format 					 */
+/* 128 Bit entries to support 64 bit addresses in the future		 */
+/* The Scatter Gather list Entry should be in the BIG-ENDIAN Format	 */
+/* --------------------------------------------------------------------- */
+/* | Upper 32 bits - Zero           |	 	Lower 32 bits- address | */
+/* --------------------------------------------------------------------- */
+/* | Upper 32 bits - Zero	    |EOL| 15 unused     | 16 Bit Length| */
+/* --------------------------------------------------------------------- */
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
+		hwif->sg_nents = i = ide_raw_build_sglist(drive, rq);
+	else
+		hwif->sg_nents = i = ide_build_sglist(drive, rq);
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
+				/* put the addr, length in
+				 * the IOC4 dma-table format */
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
+use_pio_instead:
+	pci_unmap_sg(hwif->pci_dev, hwif->sg_table, hwif->sg_nents,
+		     hwif->sg_dma_direction);
+	hwif->sg_dma_active = 0;
+
+	return 0;		/* revert to PIO for this request */
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
+	hwif->reset_poll = NULL;/* No HBA specific reset_poll needed */
+	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
+	hwif->resetproc = &sgiioc4_resetproc;/* Reset DMA engine,
+						clear interrupts */
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
+	hwif->ide_dma_count = &__ide_dma_count;
+	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
+	hwif->ide_dma_retune = &__ide_dma_retune;
+	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
+	hwif->ide_dma_timeout = &__ide_dma_timeout;
+	hwif->INB = &sgiioc4_INB;
+}
+
+static int __init
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
+			"%s : %s -- ERROR, Port Addresses "
+			"0x%p to 0x%p ALREADY in use\n",
+		       __FUNCTION__, hwif->name, (void *) base,
+		       (void *) base + IOC4_CMD_CTL_BLK_SIZE);
+		return 1;
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
+	hwif->gendev.parent = &dev->dev;/* setup proper ancestral information */
+
+	/* Initializing chipset IRQ Registers */
+	hwif->OUTL(0x03, irqport + IOC4_INTR_SET * 4);
+
+	ide_init_sgiioc4(hwif);
+
+	if (dma_base)
+		ide_dma_sgiioc4(hwif, dma_base);
+	else
+		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
+		       hwif->name, d->name);
+
+	probe_hwif_init(hwif);
+	return 0;
+}
+
+/* This ensures that we can build this for generic kernels without
+ * having all the SN2 code sync'd and merged.
+ */
+typedef enum pciio_endian_e {
+	PCIDMA_ENDIAN_BIG,
+	PCIDMA_ENDIAN_LITTLE
+} pciio_endian_t;
+pciio_endian_t __attribute__ ((weak)) snia_pciio_endian_set(struct pci_dev
+					    *pci_dev, pciio_endian_t device_end,
+					    pciio_endian_t desired_end);
+
+static unsigned int __init
+pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
+{
+	unsigned int class_rev;
+
+	if (pci_enable_device(dev)) {
+		printk(KERN_ERR
+		       "Failed to enable device %s at slot %s\n",
+		       d->name, dev->slot_name);
+		return 1;
+	}
+	pci_set_master(dev);
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
+			d->name, dev->slot_name, class_rev);
+	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
+		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
+			"firmware is obsolete - please upgrade to revision"
+			"46 or higher\n", d->name, dev->slot_name);
+		return 1;
+	}
+
+	/* Enable Byte Swapping in the PIC... */
+	if (snia_pciio_endian_set) {
+		snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
+				      PCIDMA_ENDIAN_BIG);
+	} else {
+		printk(KERN_ERR
+		       "Failed to set endianness for device %s at slot %s\n",
+		       d->name, dev->slot_name);
+		return 1;
+	}
+
+	return sgiioc4_ide_setup_pci_device(dev, d);
+}
+
+
+static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
+	{
+	 /* Channel 0 */
+	 .vendor = PCI_VENDOR_ID_SGI,
+	 .device = PCI_DEVICE_ID_SGI_IOC4,
+	 .name = "SGIIOC4",
+	 .init_hwif = ide_init_sgiioc4,
+	 .init_dma = ide_dma_sgiioc4,
+	 .channels = 1,
+	 .autodma = AUTODMA,
+	 /* SGI IOC4 doesn't have enablebits. */
+	 .bootable = ON_BOARD,
+	}
+};
+
+static int __devinit
+sgiioc4_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &sgiioc4_chipsets[id->driver_data];
+	if (dev->device != d->device) {
+		printk(KERN_ERR "Error in %s(dev 0x%p | id 0x%p )\n",
+		       __FUNCTION__, (void *) dev, (void *) id);
+		BUG();
+	}
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
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Tue Oct  7 20:32:21 2003
+++ b/include/linux/ide.h	Tue Oct  7 20:32:21 2003
@@ -1695,6 +1695,8 @@
 #define GOOD_DMA_DRIVE		1
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+extern int ide_build_sglist(ide_drive_t *, struct request *);
+extern int ide_raw_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Oct  7 20:32:21 2003
+++ b/include/linux/pci_ids.h	Tue Oct  7 20:32:21 2003
@@ -896,6 +896,7 @@
 
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
+#define PCI_DEVICE_ID_SGI_IOC4		0x100a
 #define PCI_VENDOR_ID_SGI_LITHIUM	0x1002
 
 #define PCI_VENDOR_ID_ACC		0x10aa

--fdj2RfSjLxBAspz7--
