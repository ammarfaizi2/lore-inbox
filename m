Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268118AbTBWJ6S>; Sun, 23 Feb 2003 04:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268169AbTBWJ5P>; Sun, 23 Feb 2003 04:57:15 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:57472 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268143AbTBWJxG>; Sun, 23 Feb 2003 04:53:06 -0500
Date: Sun, 23 Feb 2003 18:55:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI
Message-ID: <20030223095528.GQ1324@yuzuki.cinet.co.jp>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223092116.GA1324@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.62-ac1. (16/21)

SCSI host adapter support.
 - BIOS parameter change for PC98.
 - Add pc980155 driver for old PC98.
 - wd33c93.c compile fix.

Regards,
Osamu Tomita

diff -Nru linux-2.5.60/drivers/scsi/Kconfig linux98-2.5.60/drivers/scsi/Kconfig
--- linux-2.5.60/drivers/scsi/Kconfig	2003-02-11 03:38:53.000000000 +0900
+++ linux98-2.5.60/drivers/scsi/Kconfig	2003-02-11 13:27:06.000000000 +0900
@@ -1729,6 +1729,13 @@
 	  see the picture at
 	  <http://amiga.multigraph.com/photos/oktagon.html>.
 
+config SCSI_PC980155
+	tristate "NEC PC-9801-55 SCSI support"
+	depends on X86_PC9800 && SCSI
+	help
+	  If you have the NEC PC-9801-55 SCSI interface card or compatibles
+	  for NEC PC-9801/PC-9821, say Y.
+
 #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
 #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
 endmenu
diff -Nru linux-2.5.62/drivers/scsi/Makefile linux98-2.5.62/drivers/scsi/Makefile
--- linux-2.5.62/drivers/scsi/Makefile	2003-02-18 07:56:47.000000000 +0900
+++ linux98-2.5.62/drivers/scsi/Makefile	2003-02-23 11:16:05.000000000 +0900
@@ -29,6 +29,7 @@
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
 obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
+obj-$(CONFIG_SCSI_PC980155)	+= pc980155.o	wd33c93.o
 obj-$(CONFIG_MVME147_SCSI)	+= mvme147.o	wd33c93.o
 obj-$(CONFIG_SGIWD93_SCSI)	+= sgiwd93.o	wd33c93.o
 obj-$(CONFIG_CYBERSTORM_SCSI)	+= NCR53C9x.o	cyberstorm.o
@@ -130,6 +131,9 @@
 endif
 			
 sd_mod-objs	:= sd.o
+ifeq ($(CONFIG_X86_PC9800),y)
+sd_mod-objs	+= pc98_bios_param.o
+endif
 sr_mod-objs	:= sr.o sr_ioctl.o sr_vendor.o
 initio-objs	:= ini9100u.o i91uscsi.o
 a100u2w-objs	:= inia100.o i60uscsi.o
diff -Nru linux/drivers/scsi/pc98_bios_param.c linux98/drivers/scsi/pc98_bios_param.c
--- linux/drivers/scsi/pc98_bios_param.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/scsi/pc98_bios_param.c	2003-02-23 11:57:54.000000000 +0900
@@ -0,0 +1,79 @@
+/*
+ *
+ *  drivers/scsi/pc98_bios_param.c
+ *
+ *  Return BIOS parameter for PC-9801
+ *
+ *  Copyright (C) 2003  Osamu Tomita <tomita@cinet.co.jp>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/genhd.h>
+#include <linux/blk.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "sd.h"
+
+#include <asm/pc9800.h>
+
+
+/* XXX - For now, we assume the first (i.e. having the least host_no)
+   real (i.e. non-emulated) host adapter shall be BIOS-controlled one.
+   We *SHOULD* invent another way.  */
+
+static inline struct Scsi_Host *first_real_host(void)
+{
+	struct Scsi_Host *h = NULL;
+
+	while ((h = scsi_host_get_next(h)))
+		if (!h->hostt->emulated)
+			break;
+
+	return h;
+}
+
+int pc98_bios_param(struct block_device *bdev, int *ip)
+{
+	/* Note: This function is called from fs/partitions/nec98.c too. */
+	/* So we creat 'sdp' from 'bdev' here.				 */
+	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_device *sdp = sdkp->device;
+
+	if (sdp && first_real_host() == sdp->host && sdp->id < 7
+	    && __PC9800SCA_TEST_BIT(PC9800SCA_DISK_EQUIPS, sdp->id))
+	{
+		const u8 *p = (&__PC9800SCA(u8, PC9800SCA_SCSI_PARAMS)
+			       + sdp->id * 4);
+
+		ip[0] = p[1];	/* # of heads */
+		ip[1] = p[0];	/* # of sectors/track */
+		ip[2] = *(u16 *)&p[2] & 0x0fff;	/* # of cylinders */
+		if (p[3] & (1 << 6)) { /* #-of-cylinders is 16-bit */
+			ip[2] |= (ip[0] & 0xf0) << 8;
+			ip[0] &= 0x0f;
+		}
+		return 0;
+	}
+
+	/* Assume PC-9801-92 compatible parameters for HAs without BIOS.  */
+	ip[0] = 8;
+	ip[1] = 32;
+	ip[2] = sdkp->capacity / (8 * 32);
+	if (ip[2] > 65535) {	/* if capacity >= 8GB */
+		/* Recent on-board adapters seem to use this parameter.  */
+		ip[1] = 128;
+		ip[2] = sdkp->capacity / (8 * 128);
+		if (ip[2] > 65535) { /* if capacity >= 32GB  */
+			/* Clip the number of cylinders.  Currently this
+			   is the limit that we deal with.  */
+			ip[2] = 65535;
+		}
+	}
+	return 0;
+}
+
diff -Nru linux/drivers/scsi/pc980155.c linux98/drivers/scsi/pc980155.c
--- linux/drivers/scsi/pc980155.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/scsi/pc980155.c	2003-02-21 17:52:41.000000000 +0900
@@ -0,0 +1,273 @@
+/*
+ *
+ *  drivers/scsi/pc980155.c
+ *
+ *  PC-9801-55 SCSI host adapter driver
+ *
+ *  Copyright (C) 1997-2003  Kyoto University Microcomputer Club
+ *			     (Linux/98 project)
+ *			     Tomoharu Ugawa <ohirune@kmc.gr.jp>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/blk.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+
+#include <asm/dma.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "wd33c93.h"
+#include "pc980155.h"
+#include "pc980155regs.h"
+
+#define PC_9801_55_DEBUG
+#undef PC_9801_55_DEBUG_VERBOSE
+
+#define NR_BASE_IOS 4
+static int nr_base_ios = NR_BASE_IOS;
+static unsigned int base_ios[NR_BASE_IOS] = {0xcc0, 0xcd0, 0xce0, 0xcf0};
+static unsigned int  SASR;
+static unsigned int  SCMD;
+static wd33c93_regs regs = {&SASR, &SCMD};
+static int io = 0;
+
+static struct Scsi_Host *pc980155_host = NULL;
+
+static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp);
+
+inline void pc980155_dma_enable(unsigned int base_io)
+{
+	outb(0x01, REG_CWRITE);
+	WAIT();
+}
+
+inline void pc980155_dma_disable(unsigned int base_io)
+{
+	outb(0x02, REG_CWRITE);
+	WAIT();
+}
+
+
+static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp)
+{
+	wd33c93_intr(pc980155_host);
+}
+
+static int dma_setup(Scsi_Cmnd *sc, int dir_in)
+{
+  /*
+   * sc->SCp.this_residual : transfer count
+   * sc->SCp.ptr : distination address (virtual address)
+   * dir_in : data direction (DATA_OUT_DIR:0 or DATA_IN_DIR:1)
+   *
+   * if success return 0
+   */
+
+   /*
+    * DMA WRITE MODE
+    * bit 7,6 01b single mode (this mode only)
+    * bit 5   inc/dec (default:0 = inc)
+    * bit 4   auto initialize (normaly:0 = off)
+    * bit 3,2 01b memory -> io
+    *         10b io -> memory
+    *         00b verify
+    * bit 1,0 channel
+    */
+	disable_dma(sc->device->host->dma_channel);
+	set_dma_mode(sc->device->host->dma_channel,
+			0x40 | (dir_in ? 0x04 : 0x08));
+	clear_dma_ff(sc->device->host->dma_channel);
+	set_dma_addr(sc->device->host->dma_channel, virt_to_phys(sc->SCp.ptr));
+	set_dma_count(sc->device->host->dma_channel, sc->SCp.this_residual);
+#ifdef PC_9801_55_DEBUG
+	printk("D%d(%x)D", sc->device->host->dma_channel,
+		sc->SCp.this_residual);
+#endif
+	enable_dma(sc->device->host->dma_channel);
+	pc980155_dma_enable(sc->device->host->io_port);
+	return 0;
+}
+
+static void dma_stop(struct Scsi_Host *instance, Scsi_Cmnd *sc, int status)
+{
+  /*
+   * instance: Hostadapter's instance
+   * sc: scsi command
+   * status: True if success
+   */
+	pc980155_dma_disable(sc->device->host->io_port);
+	disable_dma(sc->device->host->dma_channel);
+}  
+
+/* return non-zero on detection */
+static inline int pc980155_test_port(wd33c93_regs regs)
+{
+	/* Quick and dirty test for presence of the card. */
+	if (READ_AUX_STAT() == 0xff)
+		return 0;
+
+	return 1;
+}
+
+static inline int pc980155_getconfig(unsigned int base_io, wd33c93_regs regs,
+					unsigned char* irq, unsigned char* dma,
+					unsigned char* scsi_id)
+{
+	static unsigned char irqs[] = {3, 5, 6, 9, 12, 13};
+	unsigned char result;
+  
+	printk(KERN_DEBUG "PC-9801-55: base_io=%x SASR=%x SCMD=%x\n",
+		base_io, *regs.SASR, *regs.SCMD);
+	result = read_wd33c93(regs, WD_RESETINT);
+	printk(KERN_DEBUG "PC-9801-55: getting config (%x)\n", result);
+	*scsi_id = result & 0x07;
+	*irq = (result >> 3) & 0x07;
+	if (*irq > 5) {
+		printk(KERN_ERR "PC-9801-55 (base %#x): impossible IRQ (%d)"
+			" - other device here?\n", base_io, *irq);
+		return 0;
+	}
+
+	*irq = irqs[*irq];
+	result = inb(REG_STATRD);
+	WAIT();
+	*dma = result & 0x03;
+	if (*dma == 1) {
+		printk(KERN_ERR
+			"PC-9801-55 (base %#x): impossible DMA channl (%d)"
+			" - other device here?\n", base_io, *dma);
+		return 0;
+	}
+#ifdef PC_9801_55_DEBUG
+	printk("PC-9801-55: end of getconfig\n");
+#endif
+	return 1;
+}
+
+/* return non-zero on detection */
+int scsi_pc980155_detect(Scsi_Host_Template* tpnt)
+{
+	unsigned int base_io;
+	unsigned char irq, dma, scsi_id;
+	int i;
+#ifdef PC_9801_55_DEBUG
+	unsigned char debug;
+#endif
+  
+	if (io) {
+		base_ios[0] = io;
+		nr_base_ios = 1;
+	}
+
+	for (i = 0; i < nr_base_ios; i++) {
+		base_io = base_ios[i];
+		SASR = REG_ADDRST;
+		SCMD = REG_CONTRL;
+#ifdef PC_9801_55_DEBUG_VERBOSE
+		printk("PC-9801-55: SASR(%x = %x)\n", SASR, REG_ADDRST);
+#endif
+		if (!request_region(base_io, 6, "PC-9801-55"))
+			continue;
+
+		if (pc980155_test_port(regs) &&
+		    pc980155_getconfig(base_io, regs, &irq, &dma, &scsi_id))
+			goto found;
+
+		release_region(base_io, 6);
+	}
+
+	printk("PC-9801-55: not found\n");
+	return 0;
+
+	found:
+#ifdef PC_9801_55_DEBUG
+	printk("PC-9801-55: config: base io = %x, irq = %d, dma channel = %d, scsi id = %d\n", base_io, irq, dma, scsi_id);
+#endif
+	if (request_irq(irq, pc980155_intr_handle, 0, "PC-9801-55", NULL)) {
+		printk(KERN_ERR "PC-9801-55: unable to allocate IRQ %d\n", irq);
+		goto err1;
+	}
+
+	if (request_dma(dma, "PC-9801-55")) {
+		printk(KERN_ERR "PC-9801-55: unable to allocate DMA channel %d\n", dma);
+		goto err2;
+	}
+
+	pc980155_host = scsi_register(tpnt, sizeof(struct WD33C93_hostdata));
+	if (pc980155_host) {
+		pc980155_host->this_id = scsi_id;
+		pc980155_host->io_port = base_io;
+		pc980155_host->n_io_port = 6;
+		pc980155_host->irq = irq;
+		pc980155_host->dma_channel = dma;
+#ifdef PC_9801_55_DEBUG
+		printk("PC-9801-55: scsi host found at %x irq = %d, use dma channel %d.\n", base_io, irq, dma);
+		debug = read_aux_stat(regs);
+		printk("PC-9801-55: aux: %x ", debug);
+		debug = read_wd33c93(regs, 0x17);
+		printk("status: %x\n", debug);
+#endif
+		pc980155_int_enable(regs);
+		wd33c93_init(pc980155_host, regs, dma_setup, dma_stop,
+				WD33C93_FS_12_15);
+		return 1;
+	}
+
+	printk(KERN_ERR "PC-9801-55: failed to register device\n");
+
+	err2:
+	free_irq(irq, NULL);
+	err1:
+	release_region(base_io, 6);
+	return 0;
+}
+
+int scsi_pc980155_release(struct Scsi_Host *pc980155_host)
+{
+	pc980155_int_disable(regs);
+	release_region(pc980155_host->io_port, pc980155_host->n_io_port);
+	free_irq(pc980155_host->irq, NULL);
+	free_dma(pc980155_host->dma_channel);
+	wd33c93_release();
+	return 1;
+}
+
+#ifndef MODULE
+static int __init pc980155_setup(char *str)
+{
+        int ints[4];
+
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0)
+		io = ints[1];
+        return 1;
+}
+__setup("pc980155_io=", pc980155_setup);
+#endif
+
+MODULE_PARM(io, "i");
+MODULE_AUTHOR("Tomoharu Ugawa <ohirune@kmc.gr.jp>");
+MODULE_DESCRIPTION("PC-9801-55 SCSI host adapter driver");
+MODULE_LICENSE("GPL");
+
+Scsi_Host_Template driver_template = {
+	.name			= "SCSI PC-9801-55",
+	.detect			= scsi_pc980155_detect,
+	.release		= scsi_pc980155_release,
+	/* command: use queue command */
+	.queuecommand		= wd33c93_queuecommand,
+	.abort			= wd33c93_abort,
+	.reset			= wd33c93_reset,
+	.bios_param		= scsicam_bios_param,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN, /* dont use link command */
+	.unchecked_isa_dma	= 1, /* use dma **XXXX***/
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+#include "scsi_module.c"
diff -Nru linux/drivers/scsi/pc980155.h linux98/drivers/scsi/pc980155.h
--- linux/drivers/scsi/pc980155.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/scsi/pc980155.h	2003-02-21 16:28:49.000000000 +0900
@@ -0,0 +1,35 @@
+/*
+ *
+ *  drivers/scsi/pc980155.h
+ *
+ *  PC-9801-55 SCSI host adapter driver
+ *
+ *  Copyright (C) 1997-2003  Kyoto University Microcomputer Club
+ *			     (Linux/98 project)
+ *			     Tomoharu Ugawa <ohirune@kmc.gr.jp>
+ *
+ */
+
+#ifndef _SCSI_PC9801_55_H
+#define _SCSI_PC9801_55_H
+
+#include <linux/types.h>
+#include <linux/kdev_t.h>
+#include <scsi/scsicam.h>
+
+int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+int wd33c93_abort(Scsi_Cmnd *);
+int wd33c93_reset(Scsi_Cmnd *, unsigned int);
+int scsi_pc980155_detect(Scsi_Host_Template *);
+int scsi_pc980155_release(struct Scsi_Host *);
+int pc980155_proc_info(char *, char **, off_t, int, int, int);
+
+#ifndef CMD_PER_LUN
+#define CMD_PER_LUN 2
+#endif
+
+#ifndef CAN_QUEUE
+#define CAN_QUEUE 16
+#endif
+
+#endif /* _SCSI_PC9801_55_H */
diff -Nru linux/drivers/scsi/pc980155regs.h linux98/drivers/scsi/pc980155regs.h
--- linux/drivers/scsi/pc980155regs.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/scsi/pc980155regs.h	2003-02-21 16:29:11.000000000 +0900
@@ -0,0 +1,105 @@
+/*
+ *
+ *  drivers/scsi/pc980155regs.h
+ *
+ *  PC-9801-55 SCSI host adapter driver
+ *
+ *  Copyright (C) 1997-2003  Kyoto University Microcomputer Club
+ *			     (Linux/98 project)
+ *			     Tomoharu Ugawa <ohirune@kmc.gr.jp>
+ *
+ */
+
+#ifndef __PC980155REGS_H
+#define __PC980155REGS_H
+
+#include "wd33c93.h"
+
+#define REG_ADDRST (base_io)
+#define REG_CONTRL (base_io + 2)
+#define REG_CWRITE (base_io + 4)
+#define REG_STATRD (base_io + 4)
+
+#define WD_MEMORYBANK 0x30
+#define WD_RESETINT   0x33
+
+#if 0
+#define WAIT() outb(0x00, 0x5f)
+#else
+#define WAIT() do{}while(0)
+#endif
+
+static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
+{
+	uchar data;
+
+	outb(reg_num, *regs.SASR);
+	WAIT();
+	data = inb(*regs.SCMD);
+	WAIT();
+	return data;
+}
+
+static inline uchar read_aux_stat(const wd33c93_regs regs)
+{
+	uchar result;
+
+	result = inb(*regs.SASR);
+	WAIT();
+	/* printk("PC-9801-55: regp->SASR(%x) = %x\n", regp->SASR, result); */
+	return result;
+}
+
+#define READ_AUX_STAT() read_aux_stat(regs)
+
+static inline void write_wd33c93(const wd33c93_regs regs, uchar reg_num,
+					uchar value)
+{
+	outb(reg_num, *regs.SASR);
+	WAIT();
+	outb(value, *regs.SCMD);
+	WAIT();
+}
+
+
+#define write_wd33c93_cmd(regs, cmd) write_wd33c93(regs, WD_COMMAND, cmd)
+
+static inline void write_wd33c93_count(const wd33c93_regs regs,
+					unsigned long value)
+{
+	outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
+	WAIT();
+	outb((value >> 16) & 0xff, *regs.SCMD);
+	WAIT();
+	outb((value >> 8) & 0xff, *regs.SCMD);
+	WAIT();
+	outb( value & 0xff, *regs.SCMD);
+	WAIT();
+}
+
+
+static inline unsigned long read_wd33c93_count(const wd33c93_regs regs)
+{
+	unsigned long value;
+
+	outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
+	value = inb(*regs.SCMD) << 16;
+	value |= inb(*regs.SCMD) << 8;
+	value |= inb(*regs.SCMD);
+	return value;
+}
+
+static inline void write_wd33c93_cdb(const wd33c93_regs regs, unsigned int len,
+					unsigned char cmnd[])
+{
+	int i;
+	outb(WD_CDB_1, *regs.SASR);
+	for (i=0; i<len; i++)
+		outb(cmnd[i], *regs.SCMD);
+}
+
+#define pc980155_int_enable(regs)  write_wd33c93(regs, WD_MEMORYBANK, read_wd33c93(regs, WD_MEMORYBANK) | 0x04)
+
+#define pc980155_int_disable(regs) write_wd33c93(regs, WD_MEMORYBANK, read_wd33c93(regs, WD_MEMORYBANK) & ~0x04)
+
+#endif
diff -Nru linux/drivers/scsi/scsi_scan.c linux98/drivers/scsi/scsi_scan.c
--- linux/drivers/scsi/scsi_scan.c	2002-12-24 14:21:04.000000000 +0900
+++ linux98/drivers/scsi/scsi_scan.c	2002-12-26 14:28:56.000000000 +0900
@@ -128,6 +128,7 @@
 	{"MITSUMI", "CD-R CR-2201CS", "6119", BLIST_NOLUN},	/* locks up */
 	{"RELISYS", "Scorpio", NULL, BLIST_NOLUN},	/* responds to all lun */
 	{"MICROTEK", "ScanMaker II", "5.61", BLIST_NOLUN},	/* responds to all lun */
+	{"NEC", "D3856", "0009", BLIST_NOLUN},
 
 	/*
 	 * Other types of devices that have special flags.
diff -Nru linux/drivers/scsi/sd.c linux98/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	2003-02-18 07:56:43.000000000 +0900
+++ linux98/drivers/scsi/sd.c	2003-02-23 11:36:00.000000000 +0900
@@ -49,6 +49,7 @@
 
 #include "scsi.h"
 #include "hosts.h"
+#include "sd.h"
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsicam.h>
 
@@ -69,19 +70,6 @@
  */
 #define SD_MAX_RETRIES		5
 
-struct scsi_disk {
-	struct list_head list;		/* list of all scsi_disks */
-	struct Scsi_Device_Template *driver;	/* always &sd_template */
-	struct scsi_device *device;
-	struct gendisk	*disk;
-	sector_t	capacity;	/* size in 512-byte sectors */
-	u32		index;
-	u8		media_present;
-	u8		write_prot;
-	unsigned	WCE : 1;	/* state of disk WCE bit */
-	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
-};
-
 static LIST_HEAD(sd_devlist);
 static spinlock_t sd_devlist_lock = SPIN_LOCK_UNLOCKED;
 
@@ -157,11 +145,6 @@
 	spin_unlock(&sd_devlist_lock);
 }
  
-static inline struct scsi_disk *scsi_disk(struct gendisk *disk)
-{
-	return container_of(disk->private_data, struct scsi_disk, driver);
-}
-
 /**
  *	sd_init_command - build a scsi (read or write) command from
  *	information in the request structure.
@@ -485,6 +468,8 @@
 	else
 		scsicam_bios_param(bdev, sdkp->capacity, diskinfo);
 
+	BIOS_PARAM_OVERRIDE(sdp, bdev, sdkp->capacity, diskinfo);
+
 	if (put_user(diskinfo[0], &loc->heads))
 		return -EFAULT;
 	if (put_user(diskinfo[1], &loc->sectors))
diff -Nru linux/drivers/scsi/sd.h linux98/drivers/scsi/sd.h
--- linux/drivers/scsi/sd.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/scsi/sd.h	2003-02-23 11:48:53.000000000 +0900
@@ -0,0 +1,40 @@
+/*
+ *  drivers/scsi/sd.h
+ *
+ *  Split out from sd.c by Osamu Tomita <tomita@cinet.co.jp>
+ *  for architecture specific BIOS parameter functions.
+ *
+ */
+
+#ifndef _SD_H
+#define _SD_H
+
+#include <linux/config.h>
+
+struct scsi_disk {
+	struct list_head list;		/* list of all scsi_disks */
+	struct Scsi_Device_Template *driver;	/* always &sd_template */
+	struct scsi_device *device;
+	struct gendisk	*disk;
+	sector_t	capacity;	/* size in 512-byte sectors */
+	u32		index;
+	u8		media_present;
+	u8		write_prot;
+	unsigned	WCE : 1;	/* state of disk WCE bit */
+	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
+};
+
+static inline struct scsi_disk *scsi_disk(struct gendisk *disk)
+{
+	return container_of(disk->private_data, struct scsi_disk, driver);
+}
+
+#ifdef CONFIG_X86_PC9800
+extern int pc98_bios_param(struct block_device *, int *);
+#define BIOS_PARAM_OVERRIDE(sdp, bdev, capacity, diskinfo) \
+		pc98_bios_param(bdev, diskinfo)
+#else
+#define BIOS_PARAM_OVERRIDE(sdp, bdev, capacity, diskinfo) do{}while(0)
+#endif
+
+#endif /* _SD_H */
diff -Nru linux-2.5.61/drivers/scsi/wd33c93.c linux98-2.5.61/drivers/scsi/wd33c93.c
--- linux-2.5.61/drivers/scsi/wd33c93.c	2003-02-15 08:52:04.000000000 +0900
+++ linux98-2.5.61/drivers/scsi/wd33c93.c	2003-02-20 17:17:19.000000000 +0900
@@ -174,6 +174,9 @@
 #endif
 
 
+#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
+#include "pc980155regs.h"
+#else /* !CONFIG_SCSI_PC980155 */
 
 static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
 {
@@ -203,6 +206,7 @@
    *regs.SCMD = cmd;
    mb();
 }
+#endif /* CONFIG_SCSI_PC980155 */
 
 
 static inline uchar read_1_byte(const wd33c93_regs regs)
@@ -220,6 +224,7 @@
    return x;
 }
 
+#if !defined(CONFIG_SCSI_PC980155) && !defined(CONFIG_SCSI_PC980155_MODULE)
 
 static void write_wd33c93_count(const wd33c93_regs regs, unsigned long value)
 {
@@ -244,6 +249,7 @@
    mb();
    return value;
 }
+#endif /* !CONFIG_SCSI_PC980155 */
 
 
 /* The 33c93 needs to be told which direction a command transfers its
@@ -316,9 +322,10 @@
    struct WD33C93_hostdata *hostdata;
    Scsi_Cmnd *tmp;
 
-   hostdata = (struct WD33C93_hostdata *)cmd->host->hostdata;
+   hostdata = (struct WD33C93_hostdata *)cmd->device->host->hostdata;
 
-DB(DB_QUEUE_COMMAND,printk("Q-%d-%02x-%ld( ",cmd->target,cmd->cmnd[0],cmd->pid))
+DB(DB_QUEUE_COMMAND,printk("Q-%d-%02x-%ld( ",cmd->device->id,
+				cmd->cmnd[0],cmd->pid))
 
 /* Set up a few fields in the Scsi_Cmnd structure for our own use:
  *  - host_scribble is the pointer to the next cmd in the input queue
@@ -401,7 +408,7 @@
  * Go see if any of them are runnable!
  */
 
-   wd33c93_execute(cmd->host);
+   wd33c93_execute(cmd->device->host);
 
 DB(DB_QUEUE_COMMAND,printk(")Q-%ld ",cmd->pid))
 
@@ -426,7 +433,6 @@
 struct WD33C93_hostdata *hostdata = (struct WD33C93_hostdata *)instance->hostdata;
 const wd33c93_regs regs = hostdata->regs;
 Scsi_Cmnd *cmd, *prev;
-int i;
 
 DB(DB_EXECUTE,printk("EX("))
 
@@ -445,7 +451,7 @@
    cmd = (Scsi_Cmnd *)hostdata->input_Q;
    prev = 0;
    while (cmd) {
-      if (!(hostdata->busy[cmd->target] & (1 << cmd->lun)))
+      if (!(hostdata->busy[cmd->device->id] & (1 << cmd->device->lun)))
          break;
       prev = cmd;
       cmd = (Scsi_Cmnd *)cmd->host_scribble;
@@ -468,7 +474,7 @@
       hostdata->input_Q = (Scsi_Cmnd *)cmd->host_scribble;
 
 #ifdef PROC_STATISTICS
-   hostdata->cmd_cnt[cmd->target]++;
+   hostdata->cmd_cnt[cmd->device->id]++;
 #endif
 
    /*
@@ -476,9 +482,9 @@
     */
 
    if (is_dir_out(cmd))
-      write_wd33c93(regs, WD_DESTINATION_ID, cmd->target);
+      write_wd33c93(regs, WD_DESTINATION_ID, cmd->device->id);
    else
-      write_wd33c93(regs, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
+      write_wd33c93(regs, WD_DESTINATION_ID, cmd->device->id | DSTID_DPD);
 
 /* Now we need to figure out whether or not this command is a good
  * candidate for disconnect/reselect. We guess to the best of our
@@ -516,7 +522,8 @@
       goto no;
    for (prev=(Scsi_Cmnd *)hostdata->input_Q; prev;
          prev=(Scsi_Cmnd *)prev->host_scribble) {
-      if ((prev->target != cmd->target) || (prev->lun != cmd->lun)) {
+      if ((prev->device->id != cmd->device->id)
+		|| (prev->device->lun != cmd->device->lun)) {
          for (prev=(Scsi_Cmnd *)hostdata->input_Q; prev;
                prev=(Scsi_Cmnd *)prev->host_scribble)
             prev->SCp.phase = 1;
@@ -529,19 +536,20 @@
    cmd->SCp.phase = 1;
 
 #ifdef PROC_STATISTICS
-   hostdata->disc_allowed_cnt[cmd->target]++;
+   hostdata->disc_allowed_cnt[cmd->device->id]++;
 #endif
 
 no:
 
    write_wd33c93(regs, WD_SOURCE_ID, ((cmd->SCp.phase)?SRCID_ER:0));
 
-   write_wd33c93(regs, WD_TARGET_LUN, cmd->lun);
-   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
-   hostdata->busy[cmd->target] |= (1 << cmd->lun);
+   write_wd33c93(regs, WD_TARGET_LUN, cmd->device->lun);
+   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,
+			hostdata->sync_xfer[cmd->device->id]);
+   hostdata->busy[cmd->device->id] |= (1 << cmd->device->lun);
 
    if ((hostdata->level2 == L2_NONE) ||
-       (hostdata->sync_stat[cmd->target] == SS_UNSET)) {
+       (hostdata->sync_stat[cmd->device->id] == SS_UNSET)) {
 
          /*
           * Do a 'Select-With-ATN' command. This will end with
@@ -565,8 +573,8 @@
  * later, but at that time we'll negotiate for async by specifying a
  * sync fifo depth of 0.
  */
-      if (hostdata->sync_stat[cmd->target] == SS_UNSET)
-            hostdata->sync_stat[cmd->target] = SS_FIRST;
+      if (hostdata->sync_stat[cmd->device->id] == SS_UNSET)
+            hostdata->sync_stat[cmd->device->id] = SS_FIRST;
       hostdata->state = S_SELECTING;
       write_wd33c93_count(regs, 0); /* guarantee a DATA_PHASE interrupt */
       write_wd33c93_cmd(regs, WD_CMD_SEL_ATN);
@@ -589,9 +597,16 @@
     * (take advantage of auto-incrementing)
     */
 
-      *regs.SASR = WD_CDB_1;
-      for (i=0; i<cmd->cmd_len; i++)
-         *regs.SCMD = cmd->cmnd[i];
+#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
+      write_wd33c93_cdb(regs, cmd->cmd_len, cmd->cmnd);
+#else /* !CONFIG_SCSI_PC980155 */
+      {
+         int i;
+         *regs.SASR = WD_CDB_1;
+         for (i = 0; i < cmd->cmd_len; i++)
+            *regs.SCMD = cmd->cmnd[i];
+      }
+#endif /* CONFIG_SCSI_PC980155 */
 
    /* The wd33c93 only knows about Group 0, 1, and 5 commands when
     * it's doing a 'select-and-transfer'. To be safe, we write the
@@ -677,7 +692,7 @@
 struct WD33C93_hostdata *hostdata;
 unsigned long length;
 
-   hostdata = (struct WD33C93_hostdata *)cmd->host->hostdata;
+   hostdata = (struct WD33C93_hostdata *)cmd->device->host->hostdata;
 
 /* Normally, you'd expect 'this_residual' to be non-zero here.
  * In a series of scatter-gather transfers, however, this
@@ -695,7 +710,8 @@
 		     cmd->SCp.buffer->offset;
       }
 
-   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
+   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,
+			hostdata->sync_xfer[cmd->device->id]);
 
 /* 'hostdata->no_dma' is TRUE if we don't even want to try DMA.
  * Update 'this_residual' and 'ptr' after 'transfer_pio()' returns.
@@ -792,7 +808,7 @@
 
    if (hostdata->dma == D_DMA_RUNNING) {
 DB(DB_TRANSFER,printk("[%p/%d:",cmd->SCp.ptr,cmd->SCp.this_residual))
-      hostdata->dma_stop(cmd->host, cmd, 1);
+      hostdata->dma_stop(cmd->device->host, cmd, 1);
       hostdata->dma = D_DMA_OFF;
       length = cmd->SCp.this_residual;
       cmd->SCp.this_residual = read_wd33c93_count(regs);
@@ -815,7 +831,7 @@
             }
 
          cmd->result = DID_NO_CONNECT << 16;
-         hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+         hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
          hostdata->state = S_UNCONNECTED;
          cmd->scsi_done(cmd);
 
@@ -849,16 +865,16 @@
 
       /* construct an IDENTIFY message with correct disconnect bit */
 
-         hostdata->outgoing_msg[0] = (0x80 | 0x00 | cmd->lun);
+         hostdata->outgoing_msg[0] = (0x80 | 0x00 | cmd->device->lun);
          if (cmd->SCp.phase)
             hostdata->outgoing_msg[0] |= 0x40;
 
-         if (hostdata->sync_stat[cmd->target] == SS_FIRST) {
+         if (hostdata->sync_stat[cmd->device->id] == SS_FIRST) {
 #ifdef SYNC_DEBUG
 printk(" sending SDTR ");
 #endif
 
-            hostdata->sync_stat[cmd->target] = SS_WAITING;
+            hostdata->sync_stat[cmd->device->id] = SS_WAITING;
 
 /* Tack on a 2nd message to ask about synchronous transfers. If we've
  * been asked to do only asynchronous transfers on this device, we
@@ -869,7 +885,7 @@
             hostdata->outgoing_msg[1] = EXTENDED_MESSAGE;
             hostdata->outgoing_msg[2] = 3;
             hostdata->outgoing_msg[3] = EXTENDED_SDTR;
-            if (hostdata->no_sync & (1 << cmd->target)) {
+            if (hostdata->no_sync & (1 << cmd->device->id)) {
                hostdata->outgoing_msg[4] = hostdata->default_sx_per/4;
                hostdata->outgoing_msg[5] = 0;
                }
@@ -995,8 +1011,8 @@
 #ifdef SYNC_DEBUG
 printk("-REJ-");
 #endif
-               if (hostdata->sync_stat[cmd->target] == SS_WAITING)
-                  hostdata->sync_stat[cmd->target] = SS_SET;
+               if (hostdata->sync_stat[cmd->device->id] == SS_WAITING)
+                  hostdata->sync_stat[cmd->device->id] = SS_SET;
                write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
                break;
@@ -1017,7 +1033,7 @@
                   switch (ucp[2]) {   /* what's the EXTENDED code? */
                      case EXTENDED_SDTR:
                         id = calc_sync_xfer(ucp[3],ucp[4]);
-                        if (hostdata->sync_stat[cmd->target] != SS_WAITING) {
+                        if (hostdata->sync_stat[cmd->device->id] != SS_WAITING) {
 
 /* A device has sent an unsolicited SDTR message; rather than go
  * through the effort of decoding it and then figuring out what
@@ -1035,16 +1051,16 @@
                            hostdata->outgoing_msg[3] = hostdata->default_sx_per/4;
                            hostdata->outgoing_msg[4] = 0;
                            hostdata->outgoing_len = 5;
-                           hostdata->sync_xfer[cmd->target] =
+                           hostdata->sync_xfer[cmd->device->id] =
                                        calc_sync_xfer(hostdata->default_sx_per/4,0);
                            }
                         else {
-                           hostdata->sync_xfer[cmd->target] = id;
+                           hostdata->sync_xfer[cmd->device->id] = id;
                            }
 #ifdef SYNC_DEBUG
-printk("sync_xfer=%02x",hostdata->sync_xfer[cmd->target]);
+printk("sync_xfer=%02x",hostdata->sync_xfer[cmd->device->id]);
 #endif
-                        hostdata->sync_stat[cmd->target] = SS_SET;
+                        hostdata->sync_stat[cmd->device->id] = SS_SET;
                         write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                         hostdata->state = S_CONNECTED;
                         break;
@@ -1107,7 +1123,7 @@
             lun = read_wd33c93(regs, WD_TARGET_LUN);
 DB(DB_INTR,printk(":%d.%d",cmd->SCp.Status,lun))
             hostdata->connected = NULL;
-            hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+            hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
             hostdata->state = S_UNCONNECTED;
             if (cmd->SCp.Status == ILLEGAL_STATUS_BYTE)
                cmd->SCp.Status = lun;
@@ -1195,7 +1211,7 @@
             }
 DB(DB_INTR,printk("UNEXP_DISC-%ld",cmd->pid))
          hostdata->connected = NULL;
-         hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+         hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
          hostdata->state = S_UNCONNECTED;
          if (cmd->cmnd[0] == REQUEST_SENSE && cmd->SCp.Status != GOOD)
             cmd->result = (cmd->result & 0x00ffff) | (DID_ERROR << 16);
@@ -1227,7 +1243,7 @@
          switch (hostdata->state) {
             case S_PRE_CMP_DISC:
                hostdata->connected = NULL;
-               hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+               hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
                hostdata->state = S_UNCONNECTED;
 DB(DB_INTR,printk(":%d",cmd->SCp.Status))
                if (cmd->cmnd[0] == REQUEST_SENSE && cmd->SCp.Status != GOOD)
@@ -1244,7 +1260,7 @@
                hostdata->state = S_UNCONNECTED;
 
 #ifdef PROC_STATISTICS
-               hostdata->disc_done_cnt[cmd->target]++;
+               hostdata->disc_done_cnt[cmd->device->id]++;
 #endif
 
                break;
@@ -1278,7 +1294,7 @@
             if (hostdata->selecting) {
                cmd = (Scsi_Cmnd *)hostdata->selecting;
                hostdata->selecting = NULL;
-               hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+               hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
                cmd->host_scribble = (uchar *)hostdata->input_Q;
                hostdata->input_Q = cmd;
                }
@@ -1288,7 +1304,7 @@
 
             if (cmd) {
                if (phs == 0x00) {
-                  hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+                  hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
                   cmd->host_scribble = (uchar *)hostdata->input_Q;
                   hostdata->input_Q = cmd;
                   }
@@ -1364,7 +1380,7 @@
          cmd = (Scsi_Cmnd *)hostdata->disconnected_Q;
          patch = NULL;
          while (cmd) {
-            if (id == cmd->target && lun == cmd->lun)
+            if (id == cmd->device->id && lun == cmd->device->lun)
                break;
             patch = cmd;
             cmd = (Scsi_Cmnd *)cmd->host_scribble;
@@ -1392,9 +1408,9 @@
     */
 
          if (is_dir_out(cmd))
-            write_wd33c93(regs, WD_DESTINATION_ID, cmd->target);
+            write_wd33c93(regs, WD_DESTINATION_ID, cmd->device->id);
          else
-            write_wd33c93(regs, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
+            write_wd33c93(regs, WD_DESTINATION_ID, cmd->device->id | DSTID_DPD);
          if (hostdata->level2 >= L2_RESELECT) {
             write_wd33c93_count(regs, 0);  /* we want a DATA_PHASE interrupt */
             write_wd33c93(regs, WD_COMMAND_PHASE, 0x45);
@@ -1467,7 +1483,7 @@
 struct WD33C93_hostdata *hostdata;
 int i;
 
-   instance = SCpnt->host;
+   instance = SCpnt->device->host;
    hostdata = (struct WD33C93_hostdata *)instance->hostdata;
 
    printk("scsi%d: reset. ", instance->host_no);
@@ -1503,9 +1519,9 @@
 wd33c93_regs regs;
 Scsi_Cmnd *tmp, *prev;
 
-   disable_irq(cmd->host->irq);
+   disable_irq(cmd->device->host->irq);
 
-   instance = cmd->host;
+   instance = cmd->device->host;
    hostdata = (struct WD33C93_hostdata *)instance->hostdata;
    regs = hostdata->regs;
 
@@ -1526,7 +1542,7 @@
          cmd->result = DID_ABORT << 16;
          printk("scsi%d: Abort - removing command %ld from input_Q. ",
            instance->host_no, cmd->pid);
-    enable_irq(cmd->host->irq);
+    enable_irq(cmd->device->host->irq);
          cmd->scsi_done(cmd);
          return SCSI_ABORT_SUCCESS;
          }
@@ -1591,7 +1607,7 @@
       sr = read_wd33c93(regs, WD_SCSI_STATUS);
       printk("asr=%02x, sr=%02x.",asr,sr);
 
-      hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
+      hostdata->busy[cmd->device->id] &= ~(1 << cmd->device->lun);
       hostdata->connected = NULL;
       hostdata->state = S_UNCONNECTED;
       cmd->result = DID_ABORT << 16;
@@ -1599,7 +1615,7 @@
 /*      sti();*/
       wd33c93_execute (instance);
 
-      enable_irq(cmd->host->irq);
+      enable_irq(cmd->device->host->irq);
       cmd->scsi_done(cmd);
       return SCSI_ABORT_SUCCESS;
       }
@@ -1616,7 +1632,7 @@
          printk("scsi%d: Abort - command %ld found on disconnected_Q - ",
                  instance->host_no, cmd->pid);
          printk("returning ABORT_SNOOZE. ");
-    enable_irq(cmd->host->irq);
+    enable_irq(cmd->device->host->irq);
          return SCSI_ABORT_SNOOZE;
          }
       tmp = (Scsi_Cmnd *)tmp->host_scribble;
@@ -1635,7 +1651,7 @@
 /*   sti();*/
    wd33c93_execute (instance);
 
-   enable_irq(cmd->host->irq);
+   enable_irq(cmd->device->host->irq);
    printk("scsi%d: warning : SCSI command probably completed successfully"
       "         before abortion. ", instance->host_no);
    return SCSI_ABORT_NOT_RUNNING;
@@ -1703,7 +1719,7 @@
    return 1;
 }
 
-__setup("wd33c93", wd33c93_setup);
+__setup("wd33c93=", wd33c93_setup);
 
 
 /* check_setup_args() returns index if key found, 0 if not
@@ -1984,7 +2000,7 @@
       if (hd->connected) {
          cmd = (Scsi_Cmnd *)hd->connected;
          sprintf(tbuf," %ld-%d:%d(%02x)",
-               cmd->pid, cmd->target, cmd->lun, cmd->cmnd[0]);
+               cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
          strcat(bp,tbuf);
          }
       }
@@ -1993,7 +2009,7 @@
       cmd = (Scsi_Cmnd *)hd->input_Q;
       while (cmd) {
          sprintf(tbuf," %ld-%d:%d(%02x)",
-               cmd->pid, cmd->target, cmd->lun, cmd->cmnd[0]);
+               cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
          strcat(bp,tbuf);
          cmd = (Scsi_Cmnd *)cmd->host_scribble;
          }
@@ -2003,7 +2019,7 @@
       cmd = (Scsi_Cmnd *)hd->disconnected_Q;
       while (cmd) {
          sprintf(tbuf," %ld-%d:%d(%02x)",
-               cmd->pid, cmd->target, cmd->lun, cmd->cmnd[0]);
+               cmd->pid, cmd->device->id, cmd->device->lun, cmd->cmnd[0]);
          strcat(bp,tbuf);
          cmd = (Scsi_Cmnd *)cmd->host_scribble;
          }
@@ -2037,4 +2053,10 @@
 {
 }
 
+EXPORT_SYMBOL(wd33c93_reset);
+EXPORT_SYMBOL(wd33c93_init);
+EXPORT_SYMBOL(wd33c93_release);
+EXPORT_SYMBOL(wd33c93_abort);
+EXPORT_SYMBOL(wd33c93_queuecommand);
+EXPORT_SYMBOL(wd33c93_intr);
 MODULE_LICENSE("GPL");
diff -Nru linux/drivers/scsi/wd33c93.h linux98/drivers/scsi/wd33c93.h
--- linux/drivers/scsi/wd33c93.h	2002-10-12 13:21:35.000000000 +0900
+++ linux98/drivers/scsi/wd33c93.h	2002-10-12 14:18:53.000000000 +0900
@@ -186,8 +186,13 @@
 
    /* This is what the 3393 chip looks like to us */
 typedef struct {
+#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
+   volatile unsigned int   *SASR;
+   volatile unsigned int   *SCMD;
+#else
    volatile unsigned char  *SASR;
    volatile unsigned char  *SCMD;
+#endif
 } wd33c93_regs;
 
 
