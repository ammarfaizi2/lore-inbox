Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbTCWHJT>; Sun, 23 Mar 2003 02:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262926AbTCWHJK>; Sun, 23 Mar 2003 02:09:10 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:46720 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262882AbTCWHH7>; Sun, 23 Mar 2003 02:07:59 -0500
Date: Sun, 23 Mar 2003 16:18:02 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [PATCH 2.5.65-ac3] Additionals for support PC-9800 (10/10) SCSI
Message-ID: <20030323071802.GJ2951@yuzuki.cinet.co.jp>
References: <20030323065928.GF2851@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323065928.GF2851@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac3. (10/10)

SCSI host adapter support.
 - BIOS parameter change for PC98.
 - Add pc980155 driver for old PC98.
 - wd33c93.c update error handler for eh_*.
 - wd33c93.h register to int for PIO mode.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64/drivers/scsi/Kconfig linux98-2.5.64/drivers/scsi/Kconfig
--- linux-2.5.64/drivers/scsi/Kconfig	2003-03-05 13:18:53.000000000 +0900
+++ linux98-2.5.64/drivers/scsi/Kconfig	2003-03-05 15:34:46.000000000 +0900
@@ -1715,6 +1715,11 @@
 	  If you have the NEC PC-9801-55 SCSI interface card or compatibles
 	  for NEC PC-9801/PC-9821, say Y.
 
+config WD33C93_PIO
+	bool
+	depends on SCSI_PC980155
+	default y
+
 #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
 #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
 endmenu
diff -Nru linux-2.5.64/drivers/scsi/Makefile linux98-2.5.64/drivers/scsi/Makefile
--- linux-2.5.64/drivers/scsi/Makefile	2003-03-05 13:18:54.000000000 +0900
+++ linux98-2.5.64/drivers/scsi/Makefile	2003-03-05 13:40:14.000000000 +0900
@@ -29,6 +29,7 @@
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
 obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
+obj-$(CONFIG_SCSI_PC980155)	+= pc980155.o	wd33c93.o
 obj-$(CONFIG_MVME147_SCSI)	+= mvme147.o	wd33c93.o
 obj-$(CONFIG_SGIWD93_SCSI)	+= sgiwd93.o	wd33c93.o
 obj-$(CONFIG_CYBERSTORM_SCSI)	+= NCR53C9x.o	cyberstorm.o
diff -Nru linux-2.5.64/drivers/scsi/pc980155.c linux98-2.5.64/drivers/scsi/pc980155.c
--- linux-2.5.64/drivers/scsi/pc980155.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.64/drivers/scsi/pc980155.c	2003-03-13 14:31:08.000000000 +0900
@@ -0,0 +1,299 @@
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
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include <asm/dma.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "wd33c93.h"
+#include "pc980155.h"
+
+extern int pc98_bios_param(struct scsi_device *, struct block_device *,
+				sector_t, int *);
+static int scsi_pc980155_detect(Scsi_Host_Template *);
+static int scsi_pc980155_release(struct Scsi_Host *);
+
+#ifndef CMD_PER_LUN
+#define CMD_PER_LUN 2
+#endif
+
+#ifndef CAN_QUEUE
+#define CAN_QUEUE 16
+#endif
+
+#undef PC_9801_55_DEBUG
+#undef PC_9801_55_DEBUG_VERBOSE
+
+#define NR_BASE_IOS 4
+static int nr_base_ios = NR_BASE_IOS;
+static unsigned int base_ios[NR_BASE_IOS] = {0xcc0, 0xcd0, 0xce0, 0xcf0};
+static wd33c93_regs init_regs;
+static int io;
+
+static struct Scsi_Host *pc980155_host = NULL;
+
+static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp);
+
+static inline void pc980155_dma_enable(unsigned int base_io)
+{
+	outb(0x01, REG_CWRITE);
+}
+
+static inline void pc980155_dma_disable(unsigned int base_io)
+{
+	outb(0x02, REG_CWRITE);
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
+	if (inb(regs.SASR) == 0xff)
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
+		base_io, regs.SASR, regs.SCMD);
+	result = read_pc980155_resetint(regs);
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
+static int scsi_pc980155_detect(Scsi_Host_Template* tpnt)
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
+		init_regs.SASR = REG_ADDRST;
+		init_regs.SCMD = REG_CONTRL;
+#ifdef PC_9801_55_DEBUG
+		printk("PC-9801-55: SASR(%x = %x)\n", SASR, REG_ADDRST);
+#endif
+		if (!request_region(base_io, 6, "PC-9801-55"))
+			continue;
+
+		if (pc980155_test_port(init_regs) &&
+		    pc980155_getconfig(base_io, init_regs,
+					&irq, &dma, &scsi_id))
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
+		printk("PC-9801-55: scsi host found at %x irq = %d, use dma channel %d.\n", base_io, irq, dma);
+		pc980155_int_enable(init_regs);
+		wd33c93_init(pc980155_host, init_regs, dma_setup, dma_stop,
+				WD33C93_FS_12_15);
+		return 1;
+	}
+
+	printk(KERN_ERR "PC-9801-55: failed to register device\n");
+
+err2:
+	free_irq(irq, NULL);
+err1:
+	release_region(base_io, 6);
+	return 0;
+}
+
+static int scsi_pc980155_release(struct Scsi_Host *shost)
+{
+	struct WD33C93_hostdata *hostdata
+		= (struct WD33C93_hostdata *)shost->hostdata;
+
+	pc980155_int_disable(hostdata->regs);
+	release_region(shost->io_port, shost->n_io_port);
+	free_irq(shost->irq, NULL);
+	free_dma(shost->dma_channel);
+	wd33c93_release();
+	return 1;
+}
+
+static int pc980155_bus_reset(Scsi_Cmnd *cmd)
+{
+	struct WD33C93_hostdata *hostdata
+		= (struct WD33C93_hostdata *)cmd->device->host->hostdata;
+
+	pc980155_int_disable(hostdata->regs);
+	pc980155_assert_bus_reset(hostdata->regs);
+	udelay(50);
+	pc980155_negate_bus_reset(hostdata->regs);
+	(void) inb(hostdata->regs.SASR);
+	(void) read_pc980155(hostdata->regs, WD_SCSI_STATUS);
+	pc980155_int_enable(hostdata->regs);
+	wd33c93_host_reset(cmd);
+	return SUCCESS;
+}
+
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
+static Scsi_Host_Template driver_template = {
+	.proc_info		= wd33c93_proc_info,
+	.name			= "SCSI PC-9801-55",
+	.detect			= scsi_pc980155_detect,
+	.release		= scsi_pc980155_release,
+	.queuecommand		= wd33c93_queuecommand,
+	.eh_abort_handler	= wd33c93_abort,
+	.eh_bus_reset_handler	= pc980155_bus_reset,
+	.eh_host_reset_handler	= wd33c93_host_reset,
+	.bios_param		= pc98_bios_param,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN, /* dont use link command */
+	.unchecked_isa_dma	= 1, /* use dma **XXXX***/
+	.use_clustering		= ENABLE_CLUSTERING,
+	.proc_name		= "PC_9801_55",
+};
+
+#include "scsi_module.c"
diff -Nru linux-2.5.64/drivers/scsi/pc980155.h linux98-2.5.64/drivers/scsi/pc980155.h
--- linux-2.5.64/drivers/scsi/pc980155.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.64/drivers/scsi/pc980155.h	2003-03-13 13:48:15.000000000 +0900
@@ -0,0 +1,52 @@
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
+#ifndef __PC980155_H
+#define __PC980155_H
+
+#include "wd33c93.h"
+
+#define REG_ADDRST (base_io)
+#define REG_CONTRL (base_io + 2)
+#define REG_CWRITE (base_io + 4)
+#define REG_STATRD (base_io + 4)
+
+#define WD_MEMORYBANK	0x30
+#define WD_RESETINT	0x33
+
+static inline uchar read_pc980155(const wd33c93_regs regs, uchar reg_num)
+{
+	outb(reg_num, regs.SASR);
+	return (uchar)inb(regs.SCMD);
+}
+
+static inline void write_memorybank(const wd33c93_regs regs, uchar value)
+{
+      outb(WD_MEMORYBANK, regs.SASR);
+      outb(value, regs.SCMD);
+}
+
+#define read_pc980155_resetint(regs) \
+	read_pc980155((regs), WD_RESETINT)
+#define pc980155_int_enable(regs) \
+	write_memorybank((regs), read_pc980155((regs), WD_MEMORYBANK) | 0x04)
+
+#define pc980155_int_disable(regs) \
+	write_memorybank((regs), read_pc980155((regs), WD_MEMORYBANK) & ~0x04)
+
+#define pc980155_assert_bus_reset(regs) \
+	write_memorybank((regs), read_pc980155((regs), WD_MEMORYBANK) | 0x02)
+
+#define pc980155_negate_bus_reset(regs) \
+	write_memorybank((regs), read_pc980155((regs), WD_MEMORYBANK) & ~0x02)
+
+#endif /* __PC980155_H */
diff -Nru linux/drivers/scsi/scsi_pc98.c linux98/drivers/scsi/scsi_pc98.c
--- linux/drivers/scsi/scsi_pc98.c	2003-03-05 13:18:57.000000000 +0900
+++ linux98/drivers/scsi/scsi_pc98.c	2003-03-05 13:49:21.000000000 +0900
@@ -48,7 +48,7 @@
 int pc98_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 			sector_t capacity, int *ip)
 {
-	static struct Scsi_Host *first_real = first_real_host();
+	struct Scsi_Host *first_real = first_real_host();
 
 	if (sdev->host == first_real && sdev->id < 7 &&
 	    __PC9800SCA_TEST_BIT(PC9800SCA_DISK_EQUIPS, sdev->id))
diff -Nru linux-2.5.65/drivers/scsi/sd.c linux98-2.5.65/drivers/scsi/sd.c
--- linux-2.5.65/drivers/scsi/sd.c	2003-03-18 06:44:22.000000000 +0900
+++ linux98-2.5.65/drivers/scsi/sd.c	2003-03-20 11:50:17.000000000 +0900
@@ -488,6 +488,15 @@
 	else
 		scsicam_bios_param(bdev, sdkp->capacity, diskinfo);
 
+#ifdef CONFIG_X86_PC9800
+	{
+		extern int pc98_bios_param(struct scsi_device *,
+					   struct block_device *,
+					   sector_t, int *);
+		pc98_bios_param(sdp, bdev, sdkp->capacity, diskinfo);
+	}
+#endif
+
 	if (put_user(diskinfo[0], &loc->heads))
 		return -EFAULT;
 	if (put_user(diskinfo[1], &loc->sectors))
diff -Nru linux/drivers/scsi/wd33c93.c linux98/drivers/scsi/wd33c93.c
--- linux/drivers/scsi/wd33c93.c	2003-03-23 11:12:16.000000000 +0900
+++ linux98/drivers/scsi/wd33c93.c	2003-03-23 11:30:53.000000000 +0900
@@ -162,8 +162,8 @@
 {
 	uchar data;
 
-	outb(reg_num, *regs.SASR);
-	data = inb(*regs.SCMD);
+	outb(reg_num, regs.SASR);
+	data = inb(regs.SCMD);
 	return data;
 }
 
@@ -172,33 +172,33 @@
 {
 	unsigned long value;
 
-	outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
-	value = inb(*regs.SCMD) << 16;
-	value |= inb(*regs.SCMD) << 8;
-	value |= inb(*regs.SCMD);
+	outb(WD_TRANSFER_COUNT_MSB, regs.SASR);
+	value = inb(regs.SCMD) << 16;
+	value |= inb(regs.SCMD) << 8;
+	value |= inb(regs.SCMD);
 	return value;
 }
 
 static inline uchar
 read_aux_stat(const wd33c93_regs regs)
 {
-	return inb(*regs.SASR);
+	return inb(regs.SASR);
 }
 
 static inline void
 write_wd33c93(const wd33c93_regs regs, uchar reg_num, uchar value)
 {
-      outb(reg_num, *regs.SASR);
-      outb(value, *regs.SCMD);
+      outb(reg_num, regs.SASR);
+      outb(value, regs.SCMD);
 }
 
 static inline void
 write_wd33c93_count(const wd33c93_regs regs, unsigned long value)
 {
-	outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
-	outb((value >> 16) & 0xff, *regs.SCMD);
-	outb((value >> 8) & 0xff, *regs.SCMD);
-	outb( value & 0xff, *regs.SCMD);
+	outb(WD_TRANSFER_COUNT_MSB, regs.SASR);
+	outb((value >> 16) & 0xff, regs.SCMD);
+	outb((value >> 8) & 0xff, regs.SCMD);
+	outb( value & 0xff, regs.SCMD);
 }
 
 #define write_wd33c93_cmd(regs, cmd) \
@@ -209,9 +209,9 @@
 {
 	int i;
 
-	outb(WD_CDB_1, *regs.SASR);
+	outb(WD_CDB_1, regs.SASR);
 	for (i=0; i<len; i++)
-		outb(cmnd[i], *regs.SCMD);
+		outb(cmnd[i], regs.SCMD);
 }
 
 #else /* CONFIG_WD33C93_PIO */
@@ -1522,7 +1522,7 @@
 }
 
 int
-wd33c93_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
+wd33c93_host_reset(Scsi_Cmnd * SCpnt)
 {
 	struct Scsi_Host *instance;
 	struct WD33C93_hostdata *hostdata;
@@ -1553,7 +1553,7 @@
 	reset_wd33c93(instance);
 	SCpnt->result = DID_RESET << 16;
 	enable_irq(instance->irq);
-	return 0;
+	return SUCCESS;
 }
 
 int
@@ -1591,7 +1591,7 @@
 			     instance->host_no, cmd->pid);
 			enable_irq(cmd->device->host->irq);
 			cmd->scsi_done(cmd);
-			return SCSI_ABORT_SUCCESS;
+			return SUCCESS;
 		}
 		prev = tmp;
 		tmp = (Scsi_Cmnd *) tmp->host_scribble;
@@ -1666,7 +1666,7 @@
 
 		enable_irq(cmd->device->host->irq);
 		cmd->scsi_done(cmd);
-		return SCSI_ABORT_SUCCESS;
+		return SUCCESS;
 	}
 
 /*
@@ -1681,9 +1681,9 @@
 			printk
 			    ("scsi%d: Abort - command %ld found on disconnected_Q - ",
 			     instance->host_no, cmd->pid);
-			printk("returning ABORT_SNOOZE. ");
+			printk("Abort SNOOZE. ");
 			enable_irq(cmd->device->host->irq);
-			return SCSI_ABORT_SNOOZE;
+			return FAILED;
 		}
 		tmp = (Scsi_Cmnd *) tmp->host_scribble;
 	}
@@ -1704,7 +1704,7 @@
 	enable_irq(cmd->device->host->irq);
 	printk("scsi%d: warning : SCSI command probably completed successfully"
 	       "         before abortion. ", instance->host_no);
-	return SCSI_ABORT_NOT_RUNNING;
+	return FAILED;
 }
 
 #define MAX_WD33C93_HOSTS 4
@@ -1755,7 +1755,7 @@
 
 	return 1;
 }
-__setup("wd33c9=", wd33c93_setup);
+__setup("wd33c93=", wd33c93_setup);
 
 /* check_setup_args() returns index if key found, 0 if not
  */
@@ -2080,7 +2080,7 @@
 {
 }
 
-EXPORT_SYMBOL(wd33c93_reset);
+EXPORT_SYMBOL(wd33c93_host_reset);
 EXPORT_SYMBOL(wd33c93_init);
 EXPORT_SYMBOL(wd33c93_release);
 EXPORT_SYMBOL(wd33c93_abort);
diff -Nru linux/drivers/scsi/wd33c93.h linux98/drivers/scsi/wd33c93.h
--- linux/drivers/scsi/wd33c93.h	2003-03-05 12:29:03.000000000 +0900
+++ linux98/drivers/scsi/wd33c93.h	2003-03-13 14:38:15.000000000 +0900
@@ -186,8 +186,13 @@
 
    /* This is what the 3393 chip looks like to us */
 typedef struct {
+#ifdef CONFIG_WD33C93_PIO
+   unsigned int   SASR;
+   unsigned int   SCMD;
+#else
    volatile unsigned char  *SASR;
    volatile unsigned char  *SCMD;
+#endif
 } wd33c93_regs;
 
 
@@ -334,7 +339,7 @@
 int wd33c93_queuecommand (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *));
 void wd33c93_intr (struct Scsi_Host *instance);
 int wd33c93_proc_info(char *, char **, off_t, int, int, int);
-int wd33c93_reset (Scsi_Cmnd *, unsigned int);
+int wd33c93_host_reset (Scsi_Cmnd *);
 void wd33c93_release(void);
 
 #endif /* WD33C93_H */
