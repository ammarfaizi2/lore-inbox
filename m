Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSKBSO4>; Sat, 2 Nov 2002 13:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSKBSO4>; Sat, 2 Nov 2002 13:14:56 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:596 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261392AbSKBSN4>; Sat, 2 Nov 2002 13:13:56 -0500
Date: Sun, 3 Nov 2002 03:20:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 17/20] Support for PC-9800 (SCSI)
Message-ID: <20021103032007.I1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 17/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  SCSI driver related modules.
   - replace bios_param function.
   - add new driver. (pc980155)
   - add new function sd_find_params_by_bdev() to get disk goemetry.
     we need disk geometry to read partition table.

diffstat:
  drivers/scsi/Kconfig        |    7 +
  drivers/scsi/Makefile       |    3  drivers/scsi/pc980155.c     |  262 ++++++++++++++++++++++++++++++++++++++++++++
  drivers/scsi/pc980155.h     |   47 +++++++
  drivers/scsi/pc980155regs.h |   89 ++++++++++++++
  drivers/scsi/scsi_scan.c    |    1  drivers/scsi/scsi_syms.c    |    5  drivers/scsi/scsicam.c      |   68 +++++++++++
  drivers/scsi/sd.c           |   24 +++-
  drivers/scsi/wd33c93.c      |   57 ++++++---
  drivers/scsi/wd33c93.h      |    5  include/scsi/scsicam.h      |    2  12 files changed, 548 insertions(+), 22 deletions(-)

patch:
diff -urN linux/drivers/scsi/Kconfig linux98/drivers/scsi/Kconfig
--- linux/drivers/scsi/Kconfig	Thu Oct 31 13:23:25 2002
+++ linux98/drivers/scsi/Kconfig	Thu Oct 31 19:29:18 2002
@@ -1746,6 +1746,13 @@
  	  see the picture at
  	  <http://amiga.multigraph.com/photos/oktagon.html>.
  +config SCSI_PC980155
+	tristate "NEC PC-9801-55 SCSI support"
+	depends on PC9800 && SCSI
+	help
+	  If you have the NEC PC-9801-55 SCSI interface card or compatibles
+	  for NEC PC-9801/PC-9821, say Y.
+
  #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
  #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
  endmenu
diff -urN linux/drivers/scsi/Makefile linux98/drivers/scsi/Makefile
--- linux/drivers/scsi/Makefile	Sat Oct 19 13:02:28 2002
+++ linux98/drivers/scsi/Makefile	Tue Oct 29 15:45:44 2002
@@ -18,7 +18,7 @@
  CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
  CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM
  -export-objs	:= scsi_syms.o 53c700.o
+export-objs	:= scsi_syms.o 53c700.o wd33c93.o
   subdir-$(CONFIG_PCMCIA)		+= pcmcia
  @@ -31,6 +31,7 @@
  obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
  obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
  obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
+obj-$(CONFIG_SCSI_PC980155)	+= pc980155.o	wd33c93.o
  obj-$(CONFIG_MVME147_SCSI)	+= mvme147.o	wd33c93.o
  obj-$(CONFIG_SGIWD93_SCSI)	+= sgiwd93.o	wd33c93.o
  obj-$(CONFIG_CYBERSTORM_SCSI)	+= NCR53C9x.o	cyberstorm.o
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
+}  +
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
+  +	printk(KERN_DEBUG "PC-9801-55: base_io=%x SASR=%x SCMD=%x\n",
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
+  +	for (i = 0; i < nr_base_ios; i++) {
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
+  +		wd33c93_init(pc980155_host, regs, dma_setup, dma_stop,
+			      WD33C93_FS_12_15);
+    +		return 1;
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
+++ linux98/drivers/scsi/pc980155.h	Sat Nov  2 17:51:18 2002
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
+#define SCSI_PC980155 {	.proc_name =		"PC-9801-55",		\
+  			.name =			"SCSI PC-9801-55",	\
+			.proc_info =		pc980155_proc_info,	\
+			.detect =		scsi_pc980155_detect,	\
+			.release =		scsi_pc980155_release,	\
+			/* command: use queue command */		\
+			.queuecommand =		wd33c93_queuecommand,	\
+			/* .abort =		wd33c93_abort, */	\
+			/* .reset =		wd33c93_reset, */	\
+			.bios_param =		pc9800_scsi_bios_param,	\
+			.can_queue =		CAN_QUEUE,		\
+			.this_id =		7,			\
+			.sg_tablesize =		SG_ALL,			 \
+			.cmd_per_lun =		CMD_PER_LUN, /* dont use link command */ \
+			.unchecked_isa_dma =	1, /* use dma **XXXX***/ \
+			.use_clustering =	ENABLE_CLUSTERING }
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
--- linux/drivers/scsi/scsi_syms.c	Thu Oct 31 13:23:30 2002
+++ linux98/drivers/scsi/scsi_syms.c	Sat Nov  2 17:10:31 2002
@@ -95,6 +95,11 @@
  EXPORT_SYMBOL(scsi_devicelist);
  EXPORT_SYMBOL(scsi_device_types);
  +/* For PC-9800 architecture support */
+EXPORT_SYMBOL(pc9800_scsi_bios_param);
+extern struct scsi_device *sd_find_params_by_bdev(struct block_device *, char **, sector_t *);
+EXPORT_SYMBOL(sd_find_params_by_bdev);
+
  /*
   * Externalize timers so that HBAs can safely start/restart commands.
   */
diff -urN linux/drivers/scsi/scsicam.c linux98/drivers/scsi/scsicam.c
--- linux/drivers/scsi/scsicam.c	Thu Oct 31 09:43:00 2002
+++ linux98/drivers/scsi/scsicam.c	Sat Nov  2 22:19:46 2002
@@ -57,6 +57,11 @@
  {
  	unsigned char *p;
  	int ret;
+	extern int pc98;	/* whether PC-9800 or not. */
+
+	if (pc98)
+		if (!pc9800_scsi_bios_param(bdev, capacity, ip))
+			return 0;
   	p = scsi_bios_ptable(bdev);
  	if (!p)
@@ -240,3 +245,66 @@
  	*hds = (unsigned int) heads;
  	return (rv);
  }
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
+extern struct scsi_device *sd_find_params_by_bdev(struct block_device *, char **, sector_t *);
+
+int pc9800_scsi_bios_param(struct block_device *bdev, sector_t capacity, int *ip)
+{
+	char *name;
+	struct scsi_device *device = sd_find_params_by_bdev(bdev, &name, NULL);
+
+	if (device && first_real_host() == device->host && device->id < 7
+	    && __PC9800SCA_TEST_BIT(PC9800SCA_DISK_EQUIPS, device->id))
+	{
+		const u8 *p = (&__PC9800SCA(u8, PC9800SCA_SCSI_PARAMS)
+			       + device->id * 4);
+
+		ip[0] = p[1];	/* # of heads */
+		ip[1] = p[0];	/* # of sectors/track */
+		ip[2] = *(u16 *)&p[2] & 0x0FFF;	/* # of cylinders */
+		if (p[3] & (1 << 6)) { /* #-of-cylinders is 16-bit */
+			ip[2] |= (ip[0] & 0xF0) << 8;
+			ip[0] &= 0x0F;
+		}
+		printk(KERN_INFO "%s: "
+			"BIOS parameters CHS:%d/%d/%d, %u bytes %s sector\n",
+			name, ip[2], ip[0], ip[1], 256 << ((p[3] >> 4) & 3),
+			p[3] & 0x80 ? "hard" : "soft");
+		return 0;
+	}
+
+	/* Assume PC-9801-92 compatible parameters for HAs without BIOS.  */
+	ip[0] = 8;
+	ip[1] = 32;
+	ip[2] = capacity / (8 * 32);
+	if (ip[2] > 65535) {	/* if capacity >= 8GB */
+		/* Recent on-board adapters seem to use this parameter.  */
+		ip[1] = 128;
+		ip[2] = capacity / (8 * 128);
+		if (ip[2] > 65535) { /* if capacity >= 32GB  */
+			/* Clip the number of cylinders.  Currently this
+			   is the limit that we deal with.  */
+			ip[2] = 65535;
+		}
+	}
+	printk(KERN_INFO "%s: BIOS parameters CHS:%d/%d/%d (assumed)\n",
+		name, ip[2], ip[0], ip[1]);
+	return 0;
+}
diff -urN linux/drivers/scsi/sd.c linux98/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Thu Oct 31 13:23:30 2002
+++ linux98/drivers/scsi/sd.c	Sat Nov  2 17:08:40 2002
@@ -193,6 +193,7 @@
  		case HDIO_GETGEO:   /* Return BIOS disk parameters */
  		{
  			struct hd_geometry *loc = (struct hd_geometry *)arg;
+			extern int pc98;
   			if (!loc)
  				return -EINVAL;
@@ -208,7 +209,7 @@
  			/* override with calculated, extended default,  			   or driver values */
  	 
-			if (host->hostt->bios_param) {
+			if (!pc98 && host->hostt->bios_param) {
  				host->hostt->bios_param(sdp, bdev,
  							capacity, diskinfo);
  			} else
@@ -1315,6 +1316,27 @@
  	kfree(sdkp);
  }
  +struct scsi_device *sd_find_params_by_bdev(struct block_device *bdev, char **disk_name, sector_t *capacity)
+{
+	struct scsi_disk *sdkp;
+	int major = major(to_kdev_t(bdev->bd_dev));
+
+	spin_lock(&sd_devlist_lock);
+	list_for_each_entry(sdkp, &sd_devlist, list) {
+		if (sdkp->disk->major == major) {
+			if (capacity)
+				*capacity = sdkp->capacity;
+			if (disk_name)
+				*disk_name = sdkp->disk->disk_name;
+			spin_unlock(&sd_devlist_lock);
+			return sdkp->device;
+		}
+	}
+
+	spin_unlock(&sd_devlist_lock);
+	return NULL;
+}
+
  /**
   *	init_sd - entry point for this driver (both when built in or when
   *	a module).
diff -urN linux/drivers/scsi/wd33c93.c linux98/drivers/scsi/wd33c93.c
--- linux/drivers/scsi/wd33c93.c	Sat Oct 19 13:02:24 2002
+++ linux98/drivers/scsi/wd33c93.c	Tue Oct 29 15:44:15 2002
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
@@ -2034,4 +2045,10 @@
     MOD_DEC_USE_COUNT;
  }
  +EXPORT_SYMBOL(wd33c93_reset);
+EXPORT_SYMBOL(wd33c93_init);
+EXPORT_SYMBOL(wd33c93_release);
+EXPORT_SYMBOL(wd33c93_abort);
+EXPORT_SYMBOL(wd33c93_queuecommand);
+EXPORT_SYMBOL(wd33c93_intr);
  MODULE_LICENSE("GPL");
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
--- linux/include/scsi/scsicam.h	Thu Oct 31 13:23:43 2002
+++ linux98/include/scsi/scsicam.h	Fri Nov  1 14:37:33 2002
@@ -16,4 +16,6 @@
  extern int scsi_partsize(unsigned char *buf, unsigned long capacity,
             unsigned int  *cyls, unsigned int *hds, unsigned int *secs);
  extern unsigned char *scsi_bios_ptable(struct block_device *bdev);
+extern int pc9800_scsi_bios_param(struct block_device *bdev, sector_t capacity,
+					int *ip);
  #endif /* def SCSICAM_H */
