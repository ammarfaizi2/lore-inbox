Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJ1Rkr>; Mon, 28 Oct 2002 12:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJ1RkZ>; Mon, 28 Oct 2002 12:40:25 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:65039 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261411AbSJ1RX7>; Mon, 28 Oct 2002 12:23:59 -0500
Date: Tue, 29 Oct 2002 02:30:17 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 17/23] add support for PC-9800 architecture (SCSI)
Message-ID: <20021029023017.A2319@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 17/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 SCSI driver related modules.
  - replace bios_param function.
  - add new driver. (pc980155)
  - export sd_get_sdisk to get disk goemetry.
    we need disk geometry to read partition table.

diffstat:
 drivers/scsi/Config.in                    |    3 
 drivers/scsi/Makefile                     |    1 
 drivers/scsi/advansys.c                   |    9 +
 drivers/scsi/aic7xxx/aic7xxx_linux_host.h |    3 
 drivers/scsi/aic7xxx_old/aic7xxx.h        |    9 -
 drivers/scsi/pc980155.c                   |  262 ++++++++++++++++++++++++++++++
 drivers/scsi/pc980155.h                   |   47 +++++
 drivers/scsi/pc980155regs.h               |   89 ++++++++++
 drivers/scsi/scsi_scan.c                  |    1 
 drivers/scsi/scsi_syms.c                  |    6 
 drivers/scsi/scsicam.c                    |   91 ++++++++++
 drivers/scsi/sd.c                         |    8 
 drivers/scsi/wd33c93.c                    |   51 +++--
 drivers/scsi/wd33c93.h                    |    5 
 include/scsi/scsicam.h                    |    5 
 15 files changed, 567 insertions(+), 23 deletions(-)

patch:
diff -urN linux/drivers/scsi/Config.in linux98/drivers/scsi/Config.in
--- linux/drivers/scsi/Config.in	Sat Oct 12 13:22:05 2002
+++ linux98/drivers/scsi/Config.in	Sun Oct 13 18:26:42 2002
@@ -258,6 +258,9 @@
 #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
    fi
 fi
+if [ "$CONFIG_PC9800" = "y" ]; then
+   dep_tristate 'NEC PC-9801-55 SCSI support' CONFIG_SCSI_PC980155 $CONFIG_SCSI
+fi
 
 endmenu
 
diff -urN linux/drivers/scsi/Makefile linux98/drivers/scsi/Makefile
--- linux/drivers/scsi/Makefile	Sat Oct 12 13:21:35 2002
+++ linux98/drivers/scsi/Makefile	Sun Oct 13 18:28:50 2002
@@ -31,6 +31,7 @@
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
 obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
+obj-$(CONFIG_SCSI_PC980155)	+= pc980155.o	wd33c93.o
 obj-$(CONFIG_MVME147_SCSI)	+= mvme147.o	wd33c93.o
 obj-$(CONFIG_SGIWD93_SCSI)	+= sgiwd93.o	wd33c93.o
 obj-$(CONFIG_CYBERSTORM_SCSI)	+= NCR53C9x.o	cyberstorm.o
diff -urN linux/drivers/scsi/advansys.c linux98/drivers/scsi/advansys.c
--- linux/drivers/scsi/advansys.c	Wed Oct 16 13:20:38 2002
+++ linux98/drivers/scsi/advansys.c	Wed Oct 16 15:26:55 2002
@@ -815,6 +815,9 @@
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 #endif /* CONFIG_PCI */
+#ifdef CONFIG_PC9800
+#include <scsi/scsicam.h>
+#endif
 
 
 /*
@@ -6117,10 +6120,13 @@
 int
 advansys_biosparam(Disk *dp, struct block_device *dep, int ip[])
 {
+#ifndef CONFIG_PC9800
     asc_board_t     *boardp;
+#endif
 
     ASC_DBG(1, "advansys_biosparam: begin\n");
     ASC_STATS(dp->device->host, biosparam);
+#ifndef CONFIG_PC9800
     boardp = ASC_BOARDP(dp->device->host);
     if (ASC_NARROW_BOARD(boardp)) {
         if ((boardp->dvc_var.asc_dvc_var.dvc_cntl &
@@ -6142,6 +6148,9 @@
         }
     }
     ip[2] = (unsigned long)dp->capacity / (ip[0] * ip[1]);
+#else /* CONFIG_PC9800 */
+    pc9800_scsi_bios_param(dp, dep, ip);
+#endif /* !CONFIG_PC9800 */
     ASC_DBG(1, "advansys_biosparam: end\n");
     return 0;
 }
diff -urN linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h linux98/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Fri Apr 12 13:57:53 2002
+++ linux98/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Fri Apr 12 15:45:26 2002
@@ -52,7 +52,8 @@
 int		 ahc_linux_dev_reset(Scsi_Cmnd *);
 int		 ahc_linux_abort(Scsi_Cmnd *);
 
-#if defined(__i386__)
+#include <linux/config.h>
+#if defined(__i386__) && !defined(CONFIG_PC9800)
 #  define AIC7XXX_BIOSPARAM ahc_linux_biosparam
 #else
 #  define AIC7XXX_BIOSPARAM NULL
diff -urN linux/drivers/scsi/aic7xxx_old/aic7xxx.h linux98/drivers/scsi/aic7xxx_old/aic7xxx.h
--- linux/drivers/scsi/aic7xxx_old/aic7xxx.h	Sat Oct 19 13:01:08 2002
+++ linux98/drivers/scsi/aic7xxx_old/aic7xxx.h	Sat Oct 19 15:39:43 2002
@@ -23,6 +23,13 @@
 #ifndef _aic7xxx_h
 #define _aic7xxx_h
 
+#include <linux/config.h>
+
+#ifndef CONFIG_PC9800
+#  define AIC7XXX_BIOSPARAM aic7xxx_biosparam
+#else
+#  define AIC7XXX_BIOSPARAM NULL
+#endif
 #define AIC7XXX_H_VERSION  "5.2.0"
 
 /*
@@ -44,7 +51,7 @@
 	reset: aic7xxx_reset,					\
 	slave_attach: aic7xxx_slave_attach,			\
 	slave_detach: aic7xxx_slave_detach,			\
-	bios_param: aic7xxx_biosparam,				\
+	bios_param: AIC7XXX_BIOSPARAM,				\
 	can_queue: 255,		/* max simultaneous cmds      */\
 	this_id: -1,		/* scsi id of host adapter    */\
 	sg_tablesize: 0,	/* max scatter-gather cmds    */\
diff -urN linux/drivers/scsi/pc980155.c linux98/drivers/scsi/pc980155.c
--- linux/drivers/scsi/pc980155.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/scsi/pc980155.c	Sun Feb  3 12:08:14 2002
@@ -0,0 +1,262 @@
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/blk.h>
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+#include <linux/module.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "wd33c93.h"
+#include "pc980155.h"
+#include "pc980155regs.h"
+
+#define DEBUG
+
+#include<linux/stat.h>
+
+static inline void __print_debug_info(unsigned int);
+static inline void __print_debug_info(unsigned int a){}
+#define print_debug_info() __print_debug_info(base_io);
+
+#define NR_BASE_IOS 4
+static int nr_base_ios = NR_BASE_IOS;
+static unsigned int base_ios[NR_BASE_IOS] = {0xcc0, 0xcd0, 0xce0, 0xcf0};
+static unsigned int  SASR;
+static unsigned int  SCMD;
+static wd33c93_regs regs = {&SASR, &SCMD};
+
+static struct Scsi_Host *pc980155_host = NULL;
+
+static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp);
+
+inline void pc980155_dma_enable(unsigned int base_io){
+  outb(0x01, REG_CWRITE);
+  WAIT();
+}
+inline void pc980155_dma_disable(unsigned int base_io){
+  outb(0x02, REG_CWRITE);
+  WAIT();
+}
+
+
+static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp)
+{
+  wd33c93_intr(pc980155_host);
+}
+
+static int dma_setup(Scsi_Cmnd *sc, int dir_in){
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
+  disable_dma(sc->host->dma_channel);
+  set_dma_mode(sc->host->dma_channel, 0x40 | (dir_in ? 0x04 : 0x08));
+  clear_dma_ff(sc->host->dma_channel);
+  set_dma_addr(sc->host->dma_channel, virt_to_phys(sc->SCp.ptr));
+  set_dma_count(sc->host->dma_channel, sc->SCp.this_residual);
+#if 0
+#ifdef DEBUG
+  printk("D%d(%x)D", sc->SCp.this_residual);
+#endif
+#endif
+  enable_dma(sc->host->dma_channel);
+
+  pc980155_dma_enable(sc->host->io_port);
+
+  return 0;
+}
+
+static void dma_stop(struct Scsi_Host *instance, Scsi_Cmnd *sc, int status){
+  /*
+   * instance: Hostadapter's instance
+   * sc: scsi command
+   * status: True if success
+   */
+
+  pc980155_dma_disable(sc->host->io_port);
+
+  disable_dma(sc->host->dma_channel);
+}  
+
+/* return non-zero on detection */
+static inline int pc980155_test_port(wd33c93_regs regs)
+{
+	/* Quick and dirty test for presence of the card. */
+	if (READ_AUX_STAT() == 0xff)
+		return 0;
+	return 1;
+}
+
+static inline int
+pc980155_getconfig(unsigned int base_io, wd33c93_regs regs,
+		    unsigned char* irq, unsigned char* dma,
+		    unsigned char* scsi_id)
+{
+	static unsigned char irqs[] = { 3, 5, 6, 9, 12, 13 };
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
+#ifdef DEBUG
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
+#ifdef DEBUG
+	unsigned char debug;
+#endif
+  
+	for (i = 0; i < nr_base_ios; i++) {
+		base_io = base_ios[i];
+		SASR = REG_ADDRST;
+		SCMD = REG_CONTRL;
+
+    /*    printk("PC-9801-55: SASR(%x = %x)\n", SASR, REG_ADDRST); */
+		if (check_region(base_io, 6))
+			continue;
+		if (! pc980155_test_port(regs))
+			continue;
+
+		if (!pc980155_getconfig(base_io, regs, &irq, &dma, &scsi_id))
+			continue;
+#ifdef DEBUG
+		printk("PC-9801-55: config: base io = %x, irq = %d, dma channel = %d, scsi id = %d\n",
+			base_io, irq, dma, scsi_id);
+#endif
+		if (request_irq(irq, pc980155_intr_handle, 0, "PC-9801-55",
+				 NULL)) {
+			printk(KERN_ERR
+				"PC-9801-55: unable to allocate IRQ %d\n",
+				irq);
+			continue;
+		}
+		if (request_dma(dma, "PC-9801-55")) {
+			printk(KERN_ERR "PC-9801-55: "
+				"unable to allocate DMA channel %d\n", dma);
+			free_irq(irq, NULL);
+			continue;
+		}
+
+		request_region(base_io, 6, "PC-9801-55");
+		pc980155_host = scsi_register(tpnt, sizeof(struct WD33C93_hostdata));
+		pc980155_host->this_id = scsi_id;
+		pc980155_host->io_port = base_io;
+		pc980155_host->n_io_port = 6;
+		pc980155_host->irq = irq;
+		pc980155_host->dma_channel = dma;
+
+#ifdef DEBUG
+		printk("PC-9801-55: scsi host found at %x irq = %d, use dma channel %d.\n", base_io, irq, dma);
+		debug = read_aux_stat(regs);
+		printk("PC-9801-55: aux: %x ", debug);
+		debug = read_wd33c93(regs, 0x17);
+		printk("status: %x\n", debug);
+#endif
+
+		pc980155_int_enable(regs);
+  
+		wd33c93_init(pc980155_host, regs, dma_setup, dma_stop,
+			      WD33C93_FS_12_15);
+    
+		return 1;
+	}
+
+	printk("PC-9801-55: not found\n");
+	return 0;
+}
+
+int pc980155_proc_info(char *buf, char **start, off_t off, int len,
+			int hostno, int in)
+{
+	/* NOT SUPPORTED YET! */
+
+	if (in) {
+		return -EPERM;
+	}
+	*start = buf;
+	return sprintf(buf, "Sorry, not supported yet.\n");
+}
+
+int pc980155_setup(char *str)
+{
+next:
+  if (!strncmp(str, "io:", 3)){
+    base_ios[0] = simple_strtoul(str+3,NULL,0);
+    nr_base_ios = 1;
+    while (*str > ' ' && *str != ',')
+      str++;
+    if (*str == ','){
+      str++;
+      goto next;
+    }
+  }
+  return 0;
+}
+
+int scsi_pc980155_release(struct Scsi_Host *pc980155_host)
+{
+#ifdef MODULE
+        pc980155_int_disable(regs);
+        release_region(pc980155_host->io_port, pc980155_host->n_io_port);
+        free_irq(pc980155_host->irq, NULL);
+        free_dma(pc980155_host->dma_channel);
+        wd33c93_release();
+#endif
+    return 1;
+}
+
+__setup("pc980155=", pc980155_setup);
+
+Scsi_Host_Template driver_template = SCSI_PC980155;
+
+#include "scsi_module.c"
diff -urN linux/drivers/scsi/pc980155.h linux98/drivers/scsi/pc980155.h
--- linux/drivers/scsi/pc980155.h	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/scsi/pc980155.h	Sun Feb  3 12:08:14 2002
@@ -0,0 +1,47 @@
+/*
+ *  PC-9801-55 SCSI host adapter driver
+ *
+ *  Copyright (C) 1997-2000  Kyoto University Microcomputer Club
+ *			     (Linux/98 project)
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
+#define SCSI_PC980155 {	proc_name:		"PC-9801-55",		\
+  			name:			"SCSI PC-9801-55",	\
+			proc_info:		pc980155_proc_info,	\
+			detect:			scsi_pc980155_detect,	\
+			release:		scsi_pc980155_release,	\
+			/* command: use queue command */		\
+			queuecommand:		wd33c93_queuecommand,	\
+			abort:			wd33c93_abort,		\
+			reset:			wd33c93_reset,		\
+			bios_param:		pc9800_scsi_bios_param,	\
+			can_queue:		CAN_QUEUE,		\
+			this_id:		7,			\
+			sg_tablesize:		SG_ALL,			 \
+			cmd_per_lun:		CMD_PER_LUN, /* dont use link command */ \
+			unchecked_isa_dma:	1, /* use dma **XXXX***/ \
+			use_clustering:		ENABLE_CLUSTERING }
+
+#endif /* _SCSI_PC9801_55_H */
diff -urN linux/drivers/scsi/pc980155regs.h linux98/drivers/scsi/pc980155regs.h
--- linux/drivers/scsi/pc980155regs.h	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/scsi/pc980155regs.h	Mon Dec  3 18:44:10 2001
@@ -0,0 +1,89 @@
+#ifndef __PC980155REGS_H
+#define __PC980155REGS_H
+
+#include "wd33c93.h"
+
+#define REG_ADDRST (base_io+0)
+#define REG_CONTRL (base_io+2)
+#define REG_CWRITE (base_io+4)
+#define REG_STATRD (base_io+4)
+
+#define WD_MEMORYBANK 0x30
+#define WD_RESETINT   0x33
+
+#if 0
+#define WAIT() outb(0x00,0x5f)
+#else
+#define WAIT() do{}while(0)
+#endif
+
+static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
+{
+  uchar data;
+  outb(reg_num, *regs.SASR);
+  WAIT();
+  data = inb(*regs.SCMD);
+  WAIT();
+  return data;
+}
+
+static inline uchar read_aux_stat(const wd33c93_regs regs)
+{
+  uchar result;
+  result = inb(*regs.SASR);
+  WAIT();
+  /*  printk("PC-9801-55: regp->SASR(%x) = %x\n", regp->SASR, result); */
+  return result;
+}
+#define READ_AUX_STAT() read_aux_stat(regs)
+
+static inline void write_wd33c93(const wd33c93_regs regs, uchar reg_num,
+				 uchar value)
+{
+  outb(reg_num, *regs.SASR);
+  WAIT();
+  outb(value, *regs.SCMD);
+  WAIT();
+}
+
+
+#define write_wd33c93_cmd(regs,cmd) write_wd33c93(regs,WD_COMMAND,cmd)
+
+static inline void write_wd33c93_count(const wd33c93_regs regs,
+					unsigned long value)
+{
+   outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
+   WAIT();
+   outb((value >> 16) & 0xff, *regs.SCMD);
+   WAIT();
+   outb((value >> 8)  & 0xff, *regs.SCMD);
+   WAIT();
+   outb( value        & 0xff, *regs.SCMD);
+   WAIT();
+}
+
+
+static inline unsigned long read_wd33c93_count(const wd33c93_regs regs)
+{
+unsigned long value;
+
+   outb(WD_TRANSFER_COUNT_MSB, *regs.SASR);
+   value = inb(*regs.SCMD) << 16;
+   value |= inb(*regs.SCMD) << 8;
+   value |= inb(*regs.SCMD);
+   return value;
+}
+
+static inline void write_wd33c93_cdb(const wd33c93_regs regs, unsigned int len,
+					unsigned char cmnd[])
+{
+  int i;
+  outb(WD_CDB_1, *regs.SASR);
+  for (i=0; i<len; i++)
+    outb(cmnd[i], *regs.SCMD);
+}
+
+#define pc980155_int_enable(regs)  write_wd33c93(regs, WD_MEMORYBANK, read_wd33c93(regs, WD_MEMORYBANK) | 0x04)
+#define pc980155_int_disable(regs) write_wd33c93(regs, WD_MEMORYBANK, read_wd33c93(regs, WD_MEMORYBANK) & ~0x04)
+
+#endif
diff -urN linux/drivers/scsi/scsi_scan.c linux98/drivers/scsi/scsi_scan.c
--- linux/drivers/scsi/scsi_scan.c	Wed Aug 28 09:52:26 2002
+++ linux98/drivers/scsi/scsi_scan.c	Wed Aug 28 13:09:39 2002
@@ -131,6 +131,7 @@
 	{"MITSUMI", "CD-R CR-2201CS", "6119", BLIST_NOLUN},	/* locks up */
 	{"RELISYS", "Scorpio", NULL, BLIST_NOLUN},	/* responds to all lun */
 	{"MICROTEK", "ScanMaker II", "5.61", BLIST_NOLUN},	/* responds to all lun */
+	{"NEC", "D3856", "0009", BLIST_NOLUN},
 
 	/*
 	 * Other types of devices that have special flags.
diff -urN linux/drivers/scsi/scsi_syms.c linux98/drivers/scsi/scsi_syms.c
--- linux/drivers/scsi/scsi_syms.c	Sat Oct 19 13:01:53 2002
+++ linux98/drivers/scsi/scsi_syms.c	Sat Oct 19 15:39:43 2002
@@ -97,6 +97,12 @@
 EXPORT_SYMBOL(scsi_devicelist);
 EXPORT_SYMBOL(scsi_device_types);
 
+#ifdef CONFIG_PC9800
+EXPORT_SYMBOL(pc9800_scsi_bios_param);
+extern Scsi_Disk * sd_get_sdisk(int);
+EXPORT_SYMBOL(sd_get_sdisk);
+#endif
+
 /*
  * Externalize timers so that HBAs can safely start/restart commands.
  */
diff -urN linux/drivers/scsi/scsicam.c linux98/drivers/scsi/scsicam.c
--- linux/drivers/scsi/scsicam.c	Sat Oct 19 13:01:59 2002
+++ linux98/drivers/scsi/scsicam.c	Sun Oct 20 10:23:06 2002
@@ -12,6 +12,8 @@
 
 #include <linux/module.h>
 
+#include <linux/config.h>
+
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
@@ -61,7 +63,14 @@
 	int ret_code;
 	int size = disk->capacity;
 	unsigned long temp_cyl;
-	unsigned char *p = scsi_bios_ptable(bdev);
+	unsigned char *p;
+
+#ifdef CONFIG_PC9800
+	if (!pc9800_scsi_bios_param(disk, bdev, ip))
+		return 0;
+#endif
+
+	p = scsi_bios_ptable(bdev);
 
 	if (!p)
 		return -1;
@@ -238,3 +247,83 @@
 	*hds = (unsigned int) heads;
 	return (rv);
 }
+
+#ifdef CONFIG_PC9800
+
+#include <asm/pc9800.h>
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
+/* There is no standard device-to-name translation function. Sigh.  */
+static inline void sd_devname(char *buf, kdev_t dev)
+{
+	int diskno = (major(dev) & SD_MAJOR_MASK) * 16 + (minor(dev) >> 4);
+
+	buf[0] = 'a' + diskno;
+	buf[1] = '\0';
+	if (diskno >= 26) {
+		buf[0] = 'a' + (diskno / 26 - 1);
+		buf[1] = 'a' + (diskno % 26);
+		buf[2] = '\0';
+	}
+}
+
+int pc9800_scsi_bios_param(Disk *disk, struct block_device *bdev, int *ip)
+{
+	char namebuf[4];
+
+	sd_devname(namebuf, to_kdev_t(bdev->bd_dev));
+
+	if (first_real_host () == disk->device->host
+	    && disk->device->id < 7
+	    && __PC9800SCA_TEST_BIT(PC9800SCA_DISK_EQUIPS, disk->device->id))
+	{
+		const u8 *p = (&__PC9800SCA(u8, PC9800SCA_SCSI_PARAMS)
+			       + disk->device->id * 4);
+
+		ip[0] = p[1];	/* # of heads */
+		ip[1] = p[0];	/* # of sectors/track */
+		ip[2] = *(u16 *)&p[2] & 0x0FFF;	/* # of cylinders */
+		if (p[3] & (1 << 6)) { /* #-of-cylinders is 16-bit */
+			ip[2] |= (ip[0] & 0xF0) << 8;
+			ip[0] &= 0x0F;
+		}
+		printk(KERN_INFO "sd%s: "
+			"BIOS parameters CHS:%d/%d/%d, %u bytes %s sector\n",
+			namebuf, ip[2], ip[0], ip[1], 256 << ((p[3] >> 4) & 3),
+			p[3] & 0x80 ? "hard" : "soft");
+		return 0;
+	}
+
+	/* Assume PC-9801-92 compatible parameters for HAs without BIOS.  */
+	ip[0] = 8;
+	ip[1] = 32;
+	ip[2] = disk->capacity / (8 * 32);
+	if (ip[2] > 65535) {	/* if capacity >= 8GB */
+		/* Recent on-board adapters seem to use this parameter.  */
+		ip[1] = 128;
+		ip[2] = disk->capacity / (8 * 128);
+		if (ip[2] > 65535) { /* if capacity >= 32GB  */
+			/* Clip the number of cylinders.  Currently this
+			   is the limit that we deal with.  */
+			ip[2] = 65535;
+		}
+	}
+	printk(KERN_INFO "sd%s: BIOS parameters CHS:%d/%d/%d (assumed)\n",
+		namebuf, ip[2], ip[0], ip[1]);
+	return 0;
+}
+#endif /* CONFIG_PC9800 */
diff -urN linux/drivers/scsi/sd.c linux98/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Sat Oct 19 13:02:27 2002
+++ linux98/drivers/scsi/sd.c	Sat Oct 19 15:39:43 2002
@@ -124,7 +124,11 @@
 
 static void sd_rw_intr(Scsi_Cmnd * SCpnt);
 
+#ifndef CONFIG_PC9800
 static Scsi_Disk * sd_get_sdisk(int index);
+#else
+Scsi_Disk * sd_get_sdisk(int index);
+#endif
 
 #if defined(CONFIG_PPC32)
 /**
@@ -1613,7 +1617,11 @@
 	return (the_result == 0);
 }
 
+#ifndef CONFIG_PC9800
 static Scsi_Disk * sd_get_sdisk(int index)
+#else
+Scsi_Disk * sd_get_sdisk(int index)
+#endif
 {
 	Scsi_Disk * sdkp = NULL;
 	unsigned long iflags;
diff -urN linux/drivers/scsi/wd33c93.c linux98/drivers/scsi/wd33c93.c
--- linux/drivers/scsi/wd33c93.c	Sat Oct 19 13:02:24 2002
+++ linux98/drivers/scsi/wd33c93.c	Sat Oct 19 16:16:46 2002
@@ -84,6 +84,7 @@
 #include <linux/init.h>
 #include <asm/irq.h>
 #include <linux/blk.h>
+#include <linux/spinlock.h>
 
 #include "scsi.h"
 #include "hosts.h"
@@ -173,7 +174,11 @@
 MODULE_PARM(setup_strings, "s");
 #endif
 
+static spinlock_t wd_lock = SPIN_LOCK_UNLOCKED;
 
+#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
+#include "pc980155regs.h"
+#else /* !CONFIG_SCSI_PC980155 */
 
 static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
 {
@@ -203,6 +208,7 @@
    *regs.SCMD = cmd;
    mb();
 }
+#endif /* CONFIG_SCSI_PC980155 */
 
 
 static inline uchar read_1_byte(const wd33c93_regs regs)
@@ -220,6 +226,7 @@
    return x;
 }
 
+#if !defined(CONFIG_SCSI_PC980155) && !defined(CONFIG_SCSI_PC980155_MODULE)
 
 static void write_wd33c93_count(const wd33c93_regs regs, unsigned long value)
 {
@@ -244,6 +251,7 @@
    mb();
    return value;
 }
+#endif /* !CONFIG_SCSI_PC980155 */
 
 
 /* The 33c93 needs to be told which direction a command transfers its
@@ -385,8 +393,7 @@
     * sense data is not lost before REQUEST_SENSE executes.
     */
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&wd_lock, flags);
 
    if (!(hostdata->input_Q) || (cmd->cmnd[0] == REQUEST_SENSE)) {
       cmd->host_scribble = (uchar *)hostdata->input_Q;
@@ -407,7 +414,7 @@
 
 DB(DB_QUEUE_COMMAND,printk(")Q-%ld ",cmd->pid))
 
-   restore_flags(flags);
+   spin_unlock_irqrestore(&wd_lock, flags);
    return 0;
 }
 
@@ -428,7 +435,6 @@
 struct WD33C93_hostdata *hostdata = (struct WD33C93_hostdata *)instance->hostdata;
 const wd33c93_regs regs = hostdata->regs;
 Scsi_Cmnd *cmd, *prev;
-int i;
 
 DB(DB_EXECUTE,printk("EX("))
 
@@ -591,9 +597,16 @@
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
@@ -765,7 +778,7 @@
    if (!(asr & ASR_INT) || (asr & ASR_BSY))
       return;
 
-   save_flags(flags);
+   local_save_flags(flags);
 
 #ifdef PROC_STATISTICS
    hostdata->int_cnt++;
@@ -831,7 +844,7 @@
      * is here...
      */
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 /* We are not connected to a target - check to see if there
  * are commands waiting to be executed.
@@ -1085,7 +1098,7 @@
                write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
             }
-         restore_flags(flags);
+         local_irq_restore(flags);
          break;
 
 
@@ -1117,7 +1130,7 @@
 /* We are no longer  connected to a target - check to see if
  * there are commands waiting to be executed.
  */
-       restore_flags(flags);
+            local_irq_restore(flags);
             wd33c93_execute(instance);
             }
          else {
@@ -1200,7 +1213,7 @@
  * there are commands waiting to be executed.
  */
     /* look above for comments on scsi_done() */
-    restore_flags(flags);
+         local_irq_restore(flags);
          wd33c93_execute(instance);
          break;
 
@@ -1228,7 +1241,7 @@
                else
                   cmd->result = cmd->SCp.Status | (cmd->SCp.Message << 8);
                cmd->scsi_done(cmd);
-          restore_flags(flags);
+               local_irq_restore(flags);
                break;
             case S_PRE_TMP_DISC:
             case S_RUNNING_LEVEL2:
@@ -1693,7 +1706,7 @@
    return 1;
 }
 
-__setup("wd33c93", wd33c93_setup);
+__setup("wd33c93=", wd33c93_setup);
 
 
 /* check_setup_args() returns index if key found, 0 if not
@@ -1831,10 +1844,9 @@
 
 
    { unsigned long flags;
-     save_flags(flags);
-     cli();
+     spin_lock_irqsave(&wd_lock, flags);
      reset_wd33c93(instance);
-     restore_flags(flags);
+     spin_unlock_irqrestore(&wd_lock, flags);
    }
 
    printk("wd33c93-%d: chip=%s/%d no_sync=0x%x no_dma=%d",instance->host_no,
@@ -1929,8 +1941,7 @@
       return len;
       }
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&wd_lock, flags);
    bp = buf;
    *bp = '\0';
    if (hd->proc & PR_VERSION) {
@@ -2005,7 +2016,7 @@
          }
       }
    strcat(bp,"\n");
-   restore_flags(flags);
+   spin_unlock_irqrestore(&wd_lock, flags);
    *start = buf;
    if (stop) {
       stop = 0;
diff -urN linux/drivers/scsi/wd33c93.h linux98/drivers/scsi/wd33c93.h
--- linux/drivers/scsi/wd33c93.h	Sat Oct 12 13:21:35 2002
+++ linux98/drivers/scsi/wd33c93.h	Sat Oct 12 14:18:53 2002
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
 
 
diff -urN linux/include/scsi/scsicam.h linux98/include/scsi/scsicam.h
--- linux/include/scsi/scsicam.h	Thu Jul 25 06:03:26 2002
+++ linux98/include/scsi/scsicam.h	Fri Jul 26 11:32:39 2002
@@ -12,8 +12,13 @@
 
 #ifndef SCSICAM_H
 #define SCSICAM_H
+#include <linux/config.h>
 extern int scsicam_bios_param (Disk *disk, struct block_device *bdev, int *ip);
 extern int scsi_partsize(unsigned char *buf, unsigned long capacity,
            unsigned int  *cyls, unsigned int *hds, unsigned int *secs);
 extern unsigned char *scsi_bios_ptable(struct block_device *bdev);
+#ifdef CONFIG_PC9800
+extern int pc9800_scsi_bios_param(Disk *disk, struct block_device *bdev,
+					int *ip);
+#endif
 #endif /* def SCSICAM_H */
