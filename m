Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTLSMxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLSMw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:52:56 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:28602 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262790AbTLSM2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:42 -0500
Subject: [PATCH 3/12] Add new DVB driver
In-Reply-To: <10718369194031@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:40 +0100
Message-Id: <10718369203166@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - new DVB driver for bt878 based "budget" DVB cards (Nebula, Pinnacle PCTV, Twinhan DST)
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/Kconfig linux-2.6.0-p/drivers/media/dvb/Kconfig
--- linux-2.6.0/drivers/media/dvb/Kconfig	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/Kconfig	2003-10-13 12:52:18.000000000 +0200
@@ -45,5 +45,9 @@
 	depends on DVB_CORE && PCI
 source "drivers/media/dvb/b2c2/Kconfig"
 
+comment "Supported BT878 Adapters"
+	depends on DVB_CORE && PCI
+source "drivers/media/dvb/bt8xx/Kconfig"
+
 endmenu
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/Makefile linux-2.6.0-p/drivers/media/dvb/Makefile
--- linux-2.6.0/drivers/media/dvb/Makefile	2003-12-18 03:58:57.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/Makefile	2003-10-01 12:18:11.000000000 +0200
@@ -2,5 +2,5 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := dvb-core/ frontends/ ttpci/ ttusb-dec/ ttusb-budget/ b2c2/
+obj-y        := dvb-core/ frontends/ ttpci/ ttusb-dec/ ttusb-budget/ b2c2/ bt8xx/
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/Kconfig linux-2.6.0-p/drivers/media/dvb/bt8xx/Kconfig
--- linux-2.6.0/drivers/media/dvb/bt8xx/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/Kconfig	2003-10-13 12:52:18.000000000 +0200
@@ -0,0 +1,13 @@
+config DVB_BT8XX
+	tristate "Nebula/Pinnacle PCTV PCI cards"
+	depends on DVB_CORE && PCI && VIDEO_BT848
+	help
+	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
+	  the Nebula cards, the Pinnacle PCTV cards, and Twinhan DST cards.
+
+          Since these cards have no MPEG decoder onboard, they transmit
+	  only compressed MPEG data over the PCI bus, so you need
+	  an external software decoder to watch TV on your computer.
+
+	  Say Y if you own such a device and want to use it.
+
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/Makefile linux-2.6.0-p/drivers/media/dvb/bt8xx/Makefile
--- linux-2.6.0/drivers/media/dvb/bt8xx/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/Makefile	2003-07-15 11:18:59.000000000 +0200
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o
+
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video
+
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/bt878.c linux-2.6.0-p/drivers/media/dvb/bt8xx/bt878.c
--- linux-2.6.0/drivers/media/dvb/bt8xx/bt878.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/bt878.c	2003-11-20 09:44:03.000000000 +0100
@@ -0,0 +1,618 @@
+/*
+ * bt878.c: part of the driver for the Pinnacle PCTV Sat DVB PCI card
+ *
+ * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+ *
+ * large parts based on the bttv driver
+ * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
+ *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
+ * (c) 1999,2000 Gerd Knorr <kraxel@goldbach.in-berlin.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * 
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
+ * 
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/ioport.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/kmod.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+
+#include "dmxdev.h"
+#include "dvbdev.h"
+#include "bt878.h"
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+#include "dst-bt878.h"
+#else
+#include "../frontends/dst-bt878.h"
+#endif
+
+#include "dvb_functions.h"
+
+/**************************************/
+/* Miscellaneous utility  definitions */
+/**************************************/
+
+unsigned int bt878_verbose = 1;
+unsigned int bt878_debug = 0;
+MODULE_PARM(bt878_verbose, "i");
+MODULE_PARM_DESC(bt878_verbose,
+		 "verbose startup messages, default is 1 (yes)");
+MODULE_PARM(bt878_debug, "i");
+MODULE_PARM_DESC(bt878_debug, "debug messages, default is 0 (no)");
+MODULE_LICENSE("GPL");
+
+int bt878_num;
+struct bt878 bt878[BT878_MAX];
+
+EXPORT_SYMBOL(bt878_debug);
+EXPORT_SYMBOL(bt878_verbose);
+EXPORT_SYMBOL(bt878_num);
+EXPORT_SYMBOL(bt878);
+
+#define btwrite(dat,adr)    bmtwrite((dat), (bt->bt878_mem+(adr)))
+#define btread(adr)         bmtread(bt->bt878_mem+(adr))
+
+#define btand(dat,adr)      btwrite((dat) & btread(adr), adr)
+#define btor(dat,adr)       btwrite((dat) | btread(adr), adr)
+#define btaor(dat,mask,adr) btwrite((dat) | ((mask) & btread(adr)), adr)
+
+#if defined(dprintk)
+#undef dprintk
+#endif
+#define dprintk if(bt878_debug) printk
+
+static void bt878_mem_free(struct bt878 *bt)
+{
+	if (bt->buf_cpu) {
+		pci_free_consistent(bt->dev, bt->buf_size, bt->buf_cpu,
+				    bt->buf_dma);
+		bt->buf_cpu = NULL;
+	}
+
+	if (bt->risc_cpu) {
+		pci_free_consistent(bt->dev, bt->risc_size, bt->risc_cpu,
+				    bt->risc_dma);
+		bt->risc_cpu = NULL;
+	}
+}
+
+static int bt878_mem_alloc(struct bt878 *bt)
+{
+	if (!bt->buf_cpu) {
+		bt->buf_size = 128 * 1024;
+
+		bt->buf_cpu =
+		    pci_alloc_consistent(bt->dev, bt->buf_size,
+					 &bt->buf_dma);
+
+		if (!bt->buf_cpu)
+			return -ENOMEM;
+
+		memset(bt->buf_cpu, 0, bt->buf_size);
+	}
+
+	if (!bt->risc_cpu) {
+		bt->risc_size = PAGE_SIZE;
+		bt->risc_cpu =
+		    pci_alloc_consistent(bt->dev, bt->risc_size,
+					 &bt->risc_dma);
+
+		if (!bt->risc_cpu) {
+			bt878_mem_free(bt);
+			return -ENOMEM;
+		}
+
+		memset(bt->risc_cpu, 0, bt->risc_size);
+	}
+
+	return 0;
+}
+
+/* RISC instructions */
+#define RISC_WRITE        	(0x01 << 28)
+#define RISC_JUMP         	(0x07 << 28)
+#define RISC_SYNC         	(0x08 << 28)
+
+/* RISC bits */
+#define RISC_WR_SOL       	(1 << 27)
+#define RISC_WR_EOL       	(1 << 26)
+#define RISC_IRQ          	(1 << 24)
+#define RISC_STATUS(status)	((((~status) & 0x0F) << 20) | ((status & 0x0F) << 16))
+#define RISC_SYNC_RESYNC  	(1 << 15)
+#define RISC_SYNC_FM1     	0x06
+#define RISC_SYNC_VRO     	0x0C
+
+#define RISC_FLUSH()		bt->risc_pos = 0
+#define RISC_INSTR(instr) 	bt->risc_cpu[bt->risc_pos++] = cpu_to_le32(instr)
+
+static int bt878_make_risc(struct bt878 *bt)
+{
+	bt->block_bytes = bt->buf_size >> 4;
+	bt->block_count = 1 << 4;
+	bt->line_bytes = bt->block_bytes;
+	bt->line_count = bt->block_count;
+
+	while (bt->line_bytes > 4095) {
+		bt->line_bytes >>= 1;
+		bt->line_count <<= 1;
+	}
+
+	if (bt->line_count > 255) {
+		printk("bt878: buffer size error!\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static void bt878_risc_program(struct bt878 *bt, u32 op_sync_orin)
+{
+	u32 buf_pos = 0;
+	u32 line;
+
+	RISC_FLUSH();
+	RISC_INSTR(RISC_SYNC | RISC_SYNC_FM1 | op_sync_orin);
+	RISC_INSTR(0);
+
+	dprintk("bt878: risc len lines %u, bytes per line %u\n", 
+			bt->line_count, bt->line_bytes);
+	for (line = 0; line < bt->line_count; line++) {
+		// At the beginning of every block we issue an IRQ with previous (finished) block number set
+		if (!(buf_pos % bt->block_bytes))
+			RISC_INSTR(RISC_WRITE | RISC_WR_SOL | RISC_WR_EOL |
+				   RISC_IRQ |
+				   RISC_STATUS(((buf_pos /
+						 bt->block_bytes) +
+						(bt->block_count -
+						 1)) %
+					       bt->block_count) | bt->
+				   line_bytes);
+		else
+			RISC_INSTR(RISC_WRITE | RISC_WR_SOL | RISC_WR_EOL |
+				   bt->line_bytes);
+		RISC_INSTR(bt->buf_dma + buf_pos);
+		buf_pos += bt->line_bytes;
+	}
+
+	RISC_INSTR(RISC_SYNC | op_sync_orin | RISC_SYNC_VRO);
+	RISC_INSTR(0);
+
+	RISC_INSTR(RISC_JUMP);
+	RISC_INSTR(bt->risc_dma);
+
+	btwrite((bt->line_count << 16) | bt->line_bytes, BT878_APACK_LEN);
+}
+
+/*****************************/
+/* Start/Stop grabbing funcs */
+/*****************************/
+
+void bt878_start(struct bt878 *bt, u32 controlreg, u32 op_sync_orin,
+		u32 irq_err_ignore)
+{
+	u32 int_mask;
+
+	dprintk("bt878 debug: bt878_start (ctl=%8.8x)\n", controlreg);
+	/* complete the writing of the risc dma program now we have
+	 * the card specifics
+	 */
+	bt878_risc_program(bt, op_sync_orin);
+	controlreg &= ~0x1f;
+	controlreg |= 0x1b;
+
+	btwrite(cpu_to_le32(bt->risc_dma), BT878_ARISC_START);
+
+	/* original int mask had :
+	 *    6    2    8    4    0
+	 * 1111 1111 1000 0000 0000
+	 * SCERR|OCERR|PABORT|RIPERR|FDSR|FTRGT|FBUS|RISCI
+	 * Hacked for DST to:
+	 * SCERR | OCERR | FDSR | FTRGT | FBUS | RISCI
+	 */
+	int_mask = BT878_ASCERR | BT878_AOCERR | BT878_APABORT | 
+		BT878_ARIPERR | BT878_APPERR | BT878_AFDSR | BT878_AFTRGT | 
+		BT878_AFBUS | BT878_ARISCI;
+
+
+	/* ignore pesky bits */
+	int_mask &= ~irq_err_ignore;
+	
+	btwrite(int_mask, BT878_AINT_MASK);
+	btwrite(controlreg, BT878_AGPIO_DMA_CTL);
+}
+
+void bt878_stop(struct bt878 *bt)
+{
+	u32 stat;
+	int i = 0;
+
+	dprintk("bt878 debug: bt878_stop\n");
+
+	btwrite(0, BT878_AINT_MASK);
+	btand(~0x13, BT878_AGPIO_DMA_CTL);
+
+	do {
+		stat = btread(BT878_AINT_STAT);
+		if (!(stat & BT878_ARISC_EN))
+			break;
+		i++;
+	} while (i < 500);
+
+	dprintk("bt878(%d) debug: bt878_stop, i=%d, stat=0x%8.8x\n",
+		bt->nr, i, stat);
+}
+
+EXPORT_SYMBOL(bt878_start);
+EXPORT_SYMBOL(bt878_stop);
+
+/*****************************/
+/* Interrupt service routine */
+/*****************************/
+
+static irqreturn_t bt878_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	u32 stat, astat, mask;
+	int count;
+	struct bt878 *bt;
+
+	bt = (struct bt878 *) dev_id;
+
+	count = 0;
+	while (1) {
+		stat = btread(BT878_AINT_STAT);
+		mask = btread(BT878_AINT_MASK);
+		if (!(astat = (stat & mask)))
+			return IRQ_NONE;	/* this interrupt is not for me */
+/*		dprintk("bt878(%d) debug: irq count %d, stat 0x%8.8x, mask 0x%8.8x\n",bt->nr,count,stat,mask); */
+		btwrite(astat, BT878_AINT_STAT);	/* try to clear interupt condition */
+
+
+		if (astat & (BT878_ASCERR | BT878_AOCERR)) {
+			if (bt878_verbose) {
+				printk("bt878(%d): irq%s%s risc_pc=%08x\n",
+				       bt->nr,
+				       (astat & BT878_ASCERR) ? " SCERR" :
+				       "",
+				       (astat & BT878_AOCERR) ? " OCERR" :
+				       "", btread(BT878_ARISC_PC));
+			}
+		}
+		if (astat & (BT878_APABORT | BT878_ARIPERR | BT878_APPERR)) {
+			if (bt878_verbose) {
+				printk
+				    ("bt878(%d): irq%s%s%s risc_pc=%08x\n",
+				     bt->nr,
+				     (astat & BT878_APABORT) ? " PABORT" :
+				     "",
+				     (astat & BT878_ARIPERR) ? " RIPERR" :
+				     "",
+				     (astat & BT878_APPERR) ? " PPERR" :
+				     "", btread(BT878_ARISC_PC));
+			}
+		}
+		if (astat & (BT878_AFDSR | BT878_AFTRGT | BT878_AFBUS)) {
+			if (bt878_verbose) {
+				printk
+				    ("bt878(%d): irq%s%s%s risc_pc=%08x\n",
+				     bt->nr,
+				     (astat & BT878_AFDSR) ? " FDSR" : "",
+				     (astat & BT878_AFTRGT) ? " FTRGT" :
+				     "",
+				     (astat & BT878_AFBUS) ? " FBUS" : "",
+				     btread(BT878_ARISC_PC));
+			}
+		}
+		if (astat & BT878_ARISCI) {
+			bt->finished_block = (stat & BT878_ARISCS) >> 28;
+			tasklet_schedule(&bt->tasklet);
+			break;
+		}
+		count++;
+		if (count > 20) {
+			btwrite(0, BT878_AINT_MASK);
+			printk(KERN_ERR
+			       "bt878(%d): IRQ lockup, cleared int mask\n",
+			       bt->nr);
+			break;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+extern int bttv_gpio_enable(unsigned int card, unsigned long mask, unsigned long data);
+extern int bttv_read_gpio(unsigned int card, unsigned long *data);
+extern int bttv_write_gpio(unsigned int card, unsigned long mask, unsigned long data);
+
+int
+bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp)
+{
+	int retval;
+
+	retval = 0;
+	if (down_interruptible (&bt->gpio_lock))
+		return -ERESTARTSYS;
+	/* special gpio signal */
+	switch (cmd) {
+	    case DST_IG_ENABLE:
+		// dprintk("dvb_bt8xx: dst enable mask 0x%02x enb 0x%02x \n", mp->dstg.enb.mask, mp->dstg.enb.enable);
+		retval = bttv_gpio_enable(bt->bttv_nr,
+				mp->enb.mask,
+				mp->enb.enable);
+		break;
+	    case DST_IG_WRITE:
+		// dprintk("dvb_bt8xx: dst write gpio mask 0x%02x out 0x%02x\n", mp->dstg.outp.mask, mp->dstg.outp.highvals);
+		retval = bttv_write_gpio(bt->bttv_nr,
+				mp->outp.mask,
+				mp->outp.highvals);
+
+		break;
+	    case DST_IG_READ:
+		/* read */
+		retval =  bttv_read_gpio(bt->bttv_nr, &mp->rd.value);
+		// dprintk("dvb_bt8xx: dst read gpio 0x%02x\n", (unsigned)mp->dstg.rd.value);
+		break;
+	    case DST_IG_TS:
+		/* Set packet size */
+		bt->TS_Size = mp->psize;
+		break;
+
+	    default:
+		retval = -EINVAL;
+		break;
+	}
+	up(&bt->gpio_lock);
+	return retval;
+}
+
+EXPORT_SYMBOL(bt878_device_control);
+
+struct bt878 *bt878_find_by_dvb_adap(struct dvb_adapter *adap)
+{
+	unsigned int card_nr;
+	
+	printk("bt878 find by dvb adap: checking \"%s\"\n",adap->name);
+	for (card_nr = 0; card_nr < bt878_num; card_nr++) {
+		if (bt878[card_nr].adap_ptr == adap)
+			return &bt878[card_nr];
+	}
+	printk("bt878 find by dvb adap: NOT found \"%s\"\n",adap->name);
+	return NULL;
+}
+
+EXPORT_SYMBOL(bt878_find_by_dvb_adap);
+
+/***********************/
+/* PCI device handling */
+/***********************/
+
+static int __devinit bt878_probe(struct pci_dev *dev,
+				 const struct pci_device_id *pci_id)
+{
+	int result;
+	unsigned char lat;
+	struct bt878 *bt;
+#if defined(__powerpc__)
+	unsigned int cmd;
+#endif
+
+	printk(KERN_INFO "bt878: Bt878 AUDIO function found (%d).\n",
+	       bt878_num);
+
+	bt = &bt878[bt878_num];
+	bt->dev = dev;
+	bt->nr = bt878_num;
+	bt->shutdown = 0;
+
+	bt->id = dev->device;
+	bt->irq = dev->irq;
+	bt->bt878_adr = pci_resource_start(dev, 0);
+	if (pci_enable_device(dev))
+		return -EIO;
+	if (!request_mem_region(pci_resource_start(dev, 0),
+				pci_resource_len(dev, 0), "bt878")) {
+		return -EBUSY;
+	}
+
+	pci_read_config_byte(dev, PCI_CLASS_REVISION, &bt->revision);
+	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
+	printk(KERN_INFO "bt878(%d): Bt%x (rev %d) at %02x:%02x.%x, ",
+	       bt878_num, bt->id, bt->revision, dev->bus->number,
+	       PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	printk("irq: %d, latency: %d, memory: 0x%lx\n",
+	       bt->irq, lat, bt->bt878_adr);
+
+
+#if defined(__powerpc__)
+	/* on OpenFirmware machines (PowerMac at least), PCI memory cycle */
+	/* response on cards with no firmware is not enabled by OF */
+	pci_read_config_dword(dev, PCI_COMMAND, &cmd);
+	cmd = (cmd | PCI_COMMAND_MEMORY);
+	pci_write_config_dword(dev, PCI_COMMAND, cmd);
+#endif
+
+#ifdef __sparc__
+	bt->bt878_mem = (unsigned char *) bt->bt878_adr;
+#else
+	bt->bt878_mem = ioremap(bt->bt878_adr, 0x1000);
+#endif
+
+	/* clear interrupt mask */
+	btwrite(0, BT848_INT_MASK);
+
+	result = request_irq(bt->irq, bt878_irq,
+			     SA_SHIRQ | SA_INTERRUPT, "bt878",
+			     (void *) bt);
+	if (result == -EINVAL) {
+		printk(KERN_ERR "bt878(%d): Bad irq number or handler\n",
+		       bt878_num);
+		goto fail1;
+	}
+	if (result == -EBUSY) {
+		printk(KERN_ERR
+		       "bt878(%d): IRQ %d busy, change your PnP config in BIOS\n",
+		       bt878_num, bt->irq);
+		goto fail1;
+	}
+	if (result < 0)
+		goto fail1;
+
+	pci_set_master(dev);
+	pci_set_drvdata(dev, bt);
+
+/*        if(init_bt878(btv) < 0) {
+                bt878_remove(dev);
+                return -EIO;
+        }
+*/
+
+	if ((result = bt878_mem_alloc(bt))) {
+		printk("bt878: failed to allocate memory!\n");
+		goto fail2;
+	}
+
+	bt878_make_risc(bt);
+	btwrite(0, BT878_AINT_MASK);
+	bt878_num++;
+
+	return 0;
+
+      fail2:
+	free_irq(bt->irq, bt);
+      fail1:
+	release_mem_region(pci_resource_start(bt->dev, 0),
+			   pci_resource_len(bt->dev, 0));
+	return result;
+}
+
+static void __devexit bt878_remove(struct pci_dev *pci_dev)
+{
+	u8 command;
+	struct bt878 *bt = pci_get_drvdata(pci_dev);
+
+	if (bt878_verbose)
+		printk("bt878(%d): unloading\n", bt->nr);
+
+	/* turn off all capturing, DMA and IRQs */
+	btand(~13, BT878_AGPIO_DMA_CTL);
+
+	/* first disable interrupts before unmapping the memory! */
+	btwrite(0, BT878_AINT_MASK);
+	btwrite(~0x0UL, BT878_AINT_STAT);
+
+	/* disable PCI bus-mastering */
+	pci_read_config_byte(bt->dev, PCI_COMMAND, &command);
+	/* Should this be &=~ ?? */
+	command &= ~PCI_COMMAND_MASTER;
+	pci_write_config_byte(bt->dev, PCI_COMMAND, command);
+
+	free_irq(bt->irq, bt);
+	printk(KERN_DEBUG "bt878_mem: 0x%p.\n", bt->bt878_mem);
+	if (bt->bt878_mem)
+		iounmap(bt->bt878_mem);
+
+	release_mem_region(pci_resource_start(bt->dev, 0),
+			   pci_resource_len(bt->dev, 0));
+	/* wake up any waiting processes
+	   because shutdown flag is set, no new processes (in this queue)
+	   are expected
+	 */
+	bt->shutdown = 1;
+	bt878_mem_free(bt);
+
+	pci_set_drvdata(pci_dev, NULL);
+	return;
+}
+
+static struct pci_device_id bt878_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BROOKTREE_878,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, bt878_pci_tbl);
+
+static struct pci_driver bt878_pci_driver = {
+      .name 	= "bt878",
+      .id_table = bt878_pci_tbl,
+      .probe 	= bt878_probe,
+      .remove 	= bt878_remove,
+};
+
+static int bt878_pci_driver_registered = 0;
+
+/* This will be used later by dvb-bt8xx to only use the audio
+ * dma of certain cards */
+int bt878_find_audio_dma(void)
+{
+	// pci_register_driver(&bt878_pci_driver);
+	bt878_pci_driver_registered = 1;
+	return 0;
+}
+
+EXPORT_SYMBOL(bt878_find_audio_dma);
+
+/*******************************/
+/* Module management functions */
+/*******************************/
+
+int bt878_init_module(void)
+{
+	bt878_num = 0;
+	bt878_pci_driver_registered = 0;
+
+	printk(KERN_INFO "bt878: AUDIO driver version %d.%d.%d loaded\n",
+	       (BT878_VERSION_CODE >> 16) & 0xff,
+	       (BT878_VERSION_CODE >> 8) & 0xff,
+	       BT878_VERSION_CODE & 0xff);
+/*
+        bt878_check_chipset();
+*/
+	/* later we register inside of bt878_find_audio_dma
+	 * because we may want to ignore certain cards */
+	bt878_pci_driver_registered = 1;
+	return pci_module_init(&bt878_pci_driver);
+}
+
+void bt878_cleanup_module(void)
+{
+	if (bt878_pci_driver_registered) {
+		bt878_pci_driver_registered = 0;
+		pci_unregister_driver(&bt878_pci_driver);
+	}
+	return;
+}
+
+EXPORT_SYMBOL(bt878_init_module);
+EXPORT_SYMBOL(bt878_cleanup_module);
+module_init(bt878_init_module);
+module_exit(bt878_cleanup_module);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/bt878.h linux-2.6.0-p/drivers/media/dvb/bt8xx/bt878.h
--- linux-2.6.0/drivers/media/dvb/bt8xx/bt878.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/bt878.h	2003-10-28 10:39:42.000000000 +0100
@@ -0,0 +1,145 @@
+/* 
+    bt878.h - Bt878 audio module (register offsets)
+
+    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef _BT878_H_
+#define _BT878_H_
+
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include "bt848.h"
+
+#define BT878_VERSION_CODE 0x000000
+
+#define BT878_AINT_STAT		0x100
+#define BT878_ARISCS		(0xf<<28)
+#define BT878_ARISC_EN		(1<<27)
+#define BT878_ASCERR		(1<<19)
+#define BT878_AOCERR		(1<<18)
+#define BT878_APABORT		(1<<17)
+#define BT878_ARIPERR		(1<<16)
+#define BT878_APPERR		(1<<15)
+#define BT878_AFDSR		(1<<14)
+#define BT878_AFTRGT		(1<<13)
+#define BT878_AFBUS		(1<<12)
+#define BT878_ARISCI		(1<<11)
+#define BT878_AOFLOW		(1<<3)
+
+#define BT878_AINT_MASK		0x104
+
+#define BT878_AGPIO_DMA_CTL	0x10c
+#define BT878_A_GAIN		(0xf<<28)
+#define BT878_A_G2X		(1<<27)
+#define BT878_A_PWRDN		(1<<26)
+#define BT878_A_SEL		(3<<24)
+#define BT878_DA_SCE		(1<<23)
+#define BT878_DA_LRI		(1<<22)
+#define BT878_DA_MLB		(1<<21)
+#define BT878_DA_LRD		(0x1f<<16)
+#define BT878_DA_DPM		(1<<15)
+#define BT878_DA_SBR		(1<<14)
+#define BT878_DA_ES2		(1<<13)
+#define BT878_DA_LMT		(1<<12)
+#define BT878_DA_SDR		(0xf<<8)
+#define BT878_DA_IOM		(3<<6)
+#define BT878_DA_APP		(1<<5)
+#define BT878_ACAP_EN		(1<<4)
+#define BT878_PKTP		(3<<2)
+#define BT878_RISC_EN		(1<<1)
+#define BT878_FIFO_EN		1
+
+#define BT878_APACK_LEN		0x110
+#define BT878_AFP_LEN		(0xff<<16)
+#define BT878_ALP_LEN		0xfff
+
+#define BT878_ARISC_START	0x114
+
+#define BT878_ARISC_PC		0x120
+
+/* BT878 FUNCTION 0 REGISTERS */
+#define BT878_GPIO_DMA_CTL	0x10c
+
+/* Interrupt register */
+#define BT878_INT_STAT		0x100
+#define BT878_INT_MASK		0x104
+#define BT878_I2CRACK		(1<<25)
+#define BT878_I2CDONE		(1<<8)
+
+#define BT878_MAX 4
+
+#define BT878_RISC_SYNC_MASK	(1 << 15)
+
+extern int bt878_num;
+extern struct bt878 bt878[BT878_MAX];
+
+struct bt878 {
+	struct semaphore  gpio_lock;
+	unsigned int nr;
+	unsigned int bttv_nr;
+	struct dvb_adapter *adap_ptr;
+	struct pci_dev *dev;
+	unsigned int id;
+	unsigned int TS_Size;
+	unsigned char revision;
+	unsigned int irq;
+	unsigned long bt878_adr;
+	unsigned char *bt878_mem; /* function 1 */
+
+	volatile u32 finished_block;
+	volatile u32 last_block;
+	u32 block_count;
+	u32 block_bytes;
+	u32 line_bytes;
+	u32 line_count;
+
+	u32 buf_size;
+	u8 *buf_cpu;
+	dma_addr_t buf_dma;
+
+	u32 risc_size;
+	u32 *risc_cpu;
+	dma_addr_t risc_dma;
+	u32 risc_pos;
+
+	struct tasklet_struct tasklet;
+	int shutdown;	
+};
+
+void bt878_start(struct bt878 *bt, u32 controlreg, u32 op_sync_orin,
+		u32 irq_err_ignore);
+void bt878_stop(struct bt878 *bt);	     
+
+#if defined(__powerpc__)	/* big-endian */
+extern __inline__ void io_st_le32(volatile unsigned *addr, unsigned val)
+{
+	__asm__ __volatile__("stwbrx %1,0,%2":"=m"(*addr):"r"(val),
+			     "r"(addr));
+	__asm__ __volatile__("eieio":::"memory");
+}
+
+#define bmtwrite(dat,adr)  io_st_le32((unsigned *)(adr),(dat))
+#define bmtread(adr)       ld_le32((unsigned *)(adr))
+#else
+#define bmtwrite(dat,adr)  writel((dat), (char *) (adr))
+#define bmtread(adr)       readl(adr)
+#endif
+
+#endif
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.0-p/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.0/drivers/media/dvb/bt8xx/dvb-bt8xx.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2003-11-25 13:10:26.000000000 +0100
@@ -0,0 +1,565 @@
+/*
+ * Bt8xx based DVB adapter driver 
+ *
+ * Copyright (C) 2002,2003 Florian Schirmer <schirmer@taytron.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <asm/bitops.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+
+#include "dmxdev.h"
+#include "dvbdev.h"
+#include "dvb_demux.h"
+#include "dvb_frontend.h"
+
+#include "dvb-bt8xx.h"
+
+#include "dvb_functions.h"
+
+#include "bt878.h"
+
+/* ID THAT MUST GO INTO i2c ids */
+#ifndef  I2C_DRIVERID_DVB_BT878A
+# define I2C_DRIVERID_DVB_BT878A I2C_DRIVERID_EXP0+10
+#endif
+
+
+#define dprintk if (debug) printk
+
+extern int bttv_get_cardinfo(unsigned int card, int *type, int *cardid);
+extern struct pci_dev* bttv_get_pcidev(unsigned int card);
+
+static LIST_HEAD(card_list);
+static int debug = 0;
+
+static void dvb_bt8xx_task(unsigned long data)
+{
+	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *)data;
+
+	//printk("%d ", finished_block);
+
+	while (card->bt->last_block != card->bt->finished_block) {
+		(card->bt->TS_Size ? dvb_dmx_swfilter_204 : dvb_dmx_swfilter)(&card->demux, &card->bt->buf_cpu[card->bt->last_block * card->bt->block_bytes], card->bt->block_bytes);
+		card->bt->last_block = (card->bt->last_block + 1) % card->bt->block_count;
+	}
+}
+
+static int dvb_bt8xx_start_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
+	struct dvb_bt8xx_card *card = dvbdmx->priv;
+
+	dprintk("dvb_bt8xx: start_feed\n");
+	
+	if (!dvbdmx->dmx.frontend)
+		return -EINVAL;
+
+	if (card->active)
+		return 0;
+		
+	card->active = 1;
+	
+//	bt878_start(card->bt, card->gpio_mode);
+
+	return 0;
+}
+
+static int dvb_bt8xx_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
+	struct dvb_bt8xx_card *card = dvbdmx->priv;
+
+	dprintk("dvb_bt8xx: stop_feed\n");
+	
+	if (!dvbdmx->dmx.frontend)
+		return -EINVAL;
+		
+	if (!card->active)
+		return 0;
+
+//	bt878_stop(card->bt);
+
+	card->active = 0;
+
+	return 0;
+}
+
+static int master_xfer (struct dvb_i2c_bus *i2c, const struct i2c_msg msgs[], int num)
+{
+	struct dvb_bt8xx_card *card = i2c->data;
+	int retval;
+
+	if (down_interruptible (&card->bt->gpio_lock))
+		return -ERESTARTSYS;
+
+	retval = i2c_transfer(card->i2c_adapter,
+			      (struct i2c_msg*) msgs,
+			      num);
+
+	up(&card->bt->gpio_lock);
+
+	return retval;
+}
+
+static int is_pci_slot_eq(struct pci_dev* adev, struct pci_dev* bdev)
+{
+	if ((adev->subsystem_vendor == bdev->subsystem_vendor) &&
+		(adev->subsystem_device == bdev->subsystem_device) &&
+		(adev->bus->number == bdev->bus->number) &&
+		(PCI_SLOT(adev->devfn) == PCI_SLOT(bdev->devfn)))
+		return 1;
+	return 0;
+}
+
+static struct bt878 __init *dvb_bt8xx_878_match(unsigned int bttv_nr, struct pci_dev* bttv_pci_dev)
+{
+	unsigned int card_nr;
+	
+	/* Hmm, n squared. Hope n is small */
+	for (card_nr = 0; card_nr < bt878_num; card_nr++) {
+		if (is_pci_slot_eq(bt878[card_nr].dev, bttv_pci_dev))
+			return &bt878[card_nr];
+	}
+	return NULL;
+}
+
+static int __init dvb_bt8xx_card_match(unsigned int bttv_nr, char *card_name, u32 gpio_mode, u32 op_sync_orin, u32 irq_err_ignore)
+{
+	struct dvb_bt8xx_card *card;
+	struct pci_dev* bttv_pci_dev;
+
+	dprintk("dvb_bt8xx: identified card%d as %s\n", bttv_nr, card_name);
+			
+	if (!(card = kmalloc(sizeof(struct dvb_bt8xx_card), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(card, 0, sizeof(*card));
+	card->bttv_nr = bttv_nr;
+	strncpy(card->card_name, card_name, sizeof(card_name) - 1);
+	
+	if (!(bttv_pci_dev = bttv_get_pcidev(bttv_nr))) {
+		printk("dvb_bt8xx: no pci device for card %d\n", card->bttv_nr);
+		kfree(card);
+		return -EFAULT;
+	}
+
+	if (!(card->bt = dvb_bt8xx_878_match(card->bttv_nr, bttv_pci_dev))) {
+		printk("dvb_bt8xx: unable to determine DMA core of card %d\n", card->bttv_nr);
+	
+		kfree(card);
+		return -EFAULT;
+		
+	}
+	init_MUTEX(&card->bt->gpio_lock);
+	card->bt->bttv_nr = bttv_nr;
+	card->gpio_mode = gpio_mode;
+	card->op_sync_orin = op_sync_orin;
+	card->irq_err_ignore = irq_err_ignore;
+	list_add_tail(&card->list, &card_list);
+
+	return 0;
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+/* with 2.6.x not needed thanks to the driver model + sysfs */
+
+extern struct i2c_adapter *bttv_get_i2c_adap(unsigned int card);
+
+static void __init dvb_bt8xx_get_adaps(void)
+{
+	struct dvb_bt8xx_card *card;
+	struct list_head *entry, *entry_safe;
+
+	list_for_each_safe(entry, entry_safe, &card_list) {
+		card = list_entry(entry, struct dvb_bt8xx_card, list);
+		card->i2c_adapter =  bttv_get_i2c_adap(card->bttv_nr);
+		if (!card->i2c_adapter) {
+			printk("dvb_bt8xx: unable to determine i2c adaptor of card %d, deleting\n", card->bttv_nr);
+
+			list_del(&card->list);
+			kfree(card);
+		}
+	}
+}
+
+static void dvb_bt8xx_i2c_adap_free(struct i2c_adapter *adap)
+{
+}
+
+static void __exit dvb_bt8xx_exit_adaps(void)
+{
+}
+
+#else
+
+/* More complicated. but cleaner better */
+
+static struct dvb_bt8xx_card *dvb_bt8xx_find_by_i2c_adap(struct i2c_adapter *adap)
+{
+	struct dvb_bt8xx_card *card;
+	struct list_head *item;
+	
+	printk("find by i2c adap: checking \"%s\"\n",adap->name);
+	list_for_each(item, &card_list) {
+		card = list_entry(item, struct dvb_bt8xx_card, list);
+		if (card->i2c_adapter == adap)
+			return card;
+	}
+	return NULL;
+}
+
+static struct dvb_bt8xx_card *dvb_bt8xx_find_by_pci(struct i2c_adapter *adap)
+{
+	struct dvb_bt8xx_card *card;
+	struct list_head *item;
+	struct device  *dev;
+	struct pci_dev *pci;
+	
+	printk("find by pci: checking \"%s\"\n",adap->name);
+	dev = adap->dev.parent;
+	if (NULL == dev) {
+		/* shoudn't happen with 2.6.0-test7 + newer */
+		printk("attach: Huh? i2c adapter not in sysfs tree?\n");
+		return 0;
+	}
+	pci = to_pci_dev(dev);
+	list_for_each(item, &card_list) {
+		card = list_entry(item, struct dvb_bt8xx_card, list);
+		if (is_pci_slot_eq(pci, card->bt->dev)) {
+			return card;
+		}
+	}
+	return NULL;
+}
+
+static int dvb_bt8xx_attach(struct i2c_adapter *adap)
+{
+	struct dvb_bt8xx_card *card;
+	
+	printk("attach: checking \"%s\"\n",adap->name);
+
+	/* looking for bt878 cards ... */
+	if (adap->id != (I2C_ALGO_BIT | I2C_HW_B_BT848))
+		return 0;
+	card = dvb_bt8xx_find_by_pci(adap);
+	if (!card)
+		return 0;
+	card->i2c_adapter = adap;
+	printk("attach: \"%s\", to card %d\n",
+	       adap->name, card->bttv_nr);
+	try_module_get(adap->owner);
+
+	return 0;
+}
+
+static void dvb_bt8xx_i2c_adap_free(struct i2c_adapter *adap)
+{
+	module_put(adap->owner);
+}
+
+static int dvb_bt8xx_detach(struct i2c_adapter *adap)
+{
+	struct dvb_bt8xx_card *card;
+
+	card = dvb_bt8xx_find_by_i2c_adap(adap);
+	if (!card)
+		return 0;
+
+	/* This should not happen. We have locked the module! */
+	printk("detach: \"%s\", for card %d removed\n",
+	       adap->name, card->bttv_nr);
+	return 0;
+}
+
+static struct i2c_driver dvb_bt8xx_driver = {
+	.owner           = THIS_MODULE,
+	.name            = "dvb_bt8xx",
+        .id              = I2C_DRIVERID_DVB_BT878A,
+	.flags           = I2C_DF_NOTIFY,
+        .attach_adapter  = dvb_bt8xx_attach,
+        .detach_adapter  = dvb_bt8xx_detach,
+};
+
+static void __init dvb_bt8xx_get_adaps(void)
+{
+	i2c_add_driver(&dvb_bt8xx_driver);
+}
+
+static void __exit dvb_bt8xx_exit_adaps(void)
+{
+	i2c_del_driver(&dvb_bt8xx_driver);
+}
+#endif
+
+static int __init dvb_bt8xx_load_card( struct dvb_bt8xx_card *card)
+{
+	int result;
+
+	if (!card->i2c_adapter) {
+		printk("dvb_bt8xx: unable to determine i2c adaptor of card %d, deleting\n", card->bttv_nr);
+
+		return -EFAULT;
+	
+	}
+
+	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name)) < 0) {
+	
+		printk("dvb_bt8xx: dvb_register_adapter failed (errno = %d)\n", result);
+		
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		return result;
+		
+	}
+	card->bt->adap_ptr = card->dvb_adapter;
+
+	if (!(dvb_register_i2c_bus(master_xfer, card, card->dvb_adapter, 0))) {
+		printk("dvb_bt8xx: dvb_register_i2c_bus of card%d failed\n", card->bttv_nr);
+
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+
+		return -EFAULT;
+	}
+
+	memset(&card->demux, 0, sizeof(struct dvb_demux));
+
+	card->demux.dmx.capabilities = DMX_TS_FILTERING | DMX_SECTION_FILTERING | DMX_MEMORY_BASED_FILTERING;
+
+	card->demux.priv = card;
+	card->demux.filternum = 256;
+	card->demux.feednum = 256;
+	card->demux.start_feed = dvb_bt8xx_start_feed;
+	card->demux.stop_feed = dvb_bt8xx_stop_feed;
+	card->demux.write_to_decoder = NULL;
+	
+	if ((result = dvb_dmx_init(&card->demux)) < 0) {
+		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
+
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		
+		return result;
+	}
+
+	card->dmxdev.filternum = 256;
+	card->dmxdev.demux = &card->demux.dmx;
+	card->dmxdev.capabilities = 0;
+	
+	if ((result = dvb_dmxdev_init(&card->dmxdev, card->dvb_adapter)) < 0) {
+		printk("dvb_bt8xx: dvb_dmxdev_init failed (errno = %d)\n", result);
+
+		dvb_dmx_release(&card->demux);
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		
+		return result;
+	}
+
+	card->fe_hw.source = DMX_FRONTEND_0;
+
+	if ((result = card->demux.dmx.add_frontend(&card->demux.dmx, &card->fe_hw)) < 0) {
+		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
+
+		dvb_dmxdev_release(&card->dmxdev);
+		dvb_dmx_release(&card->demux);
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		
+		return result;
+	}
+	
+	card->fe_mem.source = DMX_MEMORY_FE;
+
+	if ((result = card->demux.dmx.add_frontend(&card->demux.dmx, &card->fe_mem)) < 0) {
+		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
+
+		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
+		dvb_dmxdev_release(&card->dmxdev);
+		dvb_dmx_release(&card->demux);
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		
+		return result;
+	}
+
+	if ((result = card->demux.dmx.connect_frontend(&card->demux.dmx, &card->fe_hw)) < 0) {
+		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
+
+		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_mem);
+		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
+		dvb_dmxdev_release(&card->dmxdev);
+		dvb_dmx_release(&card->demux);
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_unregister_adapter(card->dvb_adapter);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		
+		return result;
+	}
+
+	dvb_net_init(card->dvb_adapter, &card->dvbnet, &card->demux.dmx);
+
+	tasklet_init(&card->bt->tasklet, dvb_bt8xx_task, (unsigned long) card);
+	
+	bt878_start(card->bt, card->gpio_mode, card->op_sync_orin, card->irq_err_ignore);
+
+	return 0;
+}
+
+static int __init dvb_bt8xx_load_all(void)
+{
+	struct dvb_bt8xx_card *card;
+	struct list_head *entry, *entry_safe;
+
+	list_for_each_safe(entry, entry_safe, &card_list) {
+		card = list_entry(entry, struct dvb_bt8xx_card, list);
+		if (dvb_bt8xx_load_card(card) < 0) {
+			list_del(&card->list);
+			kfree(card);
+			continue;
+		}
+	}
+	return 0;
+
+}
+
+#define BT878_NEBULA	0x68
+#define BT878_TWINHAN_DST 0x71
+
+static int __init dvb_bt8xx_init(void)
+{
+	unsigned int card_nr = 0;
+	int card_id;
+	int card_type;
+
+	dprintk("dvb_bt8xx: enumerating available bttv cards...\n");
+	
+	while (bttv_get_cardinfo(card_nr, &card_type, &card_id) == 0) {
+		switch(card_id) {
+			case 0x001C11BD:
+				dvb_bt8xx_card_match(card_nr, "Pinnacle PCTV DVB-S",
+					       0x0400C060, 0, 0);
+				/* 26, 15, 14, 6, 5 
+				 * A_G2X  DA_DPM DA_SBR DA_IOM_DA 
+				 * DA_APP(parallel) */
+				break;
+			case 0x01010071:
+nebula:
+				dvb_bt8xx_card_match(card_nr, "Nebula DigiTV DVB-T",
+					     (1 << 26) | (1 << 14) | (1 << 5),
+					     0, 0);
+				/* A_PWRDN DA_SBR DA_APP (high speed serial) */
+				break;
+			case 0x07611461:
+				dvb_bt8xx_card_match(card_nr, "Avermedia DVB-T",
+					     (1 << 26) | (1 << 14) | (1 << 5),
+					     0, 0);
+				/* A_PWRDN DA_SBR DA_APP (high speed serial) */
+				break;
+			case 0x0:
+				if (card_type == BT878_NEBULA ||
+					card_type == BT878_TWINHAN_DST)
+					goto dst;
+				goto unknown_card;
+			case 0x2611BD:
+			case 0x11822:
+dst:
+				dvb_bt8xx_card_match(card_nr, "DST DVB-S", 0x2204f2c,
+						BT878_RISC_SYNC_MASK,
+						BT878_APABORT | BT878_ARIPERR | BT878_APPERR | BT878_AFBUS);
+				/* 25,21,14,11,10,9,8,3,2 then
+				 * 0x33 = 5,4,1,0
+				 * A_SEL=SML, DA_MLB, DA_SBR, 
+				 * DA_SDR=f, fifo trigger = 32 DWORDS
+				 * IOM = 0 == audio A/D
+				 * DPM = 0 == digital audio mode
+				 * == async data parallel port
+				 * then 0x33 (13 is set by start_capture)
+				 * DA_APP = async data parallel port, 
+				 * ACAP_EN = 1,
+				 * RISC+FIFO ENABLE */
+				break;
+			default:
+unknown_card:
+				printk("%s: unknown card_id found %0X\n",
+					__FUNCTION__, card_id);
+				if (card_type == BT878_NEBULA) {
+					printk("%s: bttv type set to nebula\n",
+						__FUNCTION__);
+					goto nebula;
+				}
+				if (card_type == BT878_TWINHAN_DST) {
+					printk("%s: bttv type set to Twinhan DST\n",
+						__FUNCTION__);
+					goto dst;
+				}
+				printk("%s: unknown card_type found %0X, NOT LOADED\n",
+					__FUNCTION__, card_type);
+				printk("%s: unknown card_nr found %0X\n",
+					__FUNCTION__, card_nr);
+		}
+		card_nr++;
+	}
+	dvb_bt8xx_get_adaps();
+	dvb_bt8xx_load_all();
+
+	return 0;
+
+}
+
+static void __exit dvb_bt8xx_exit(void)
+{
+	struct dvb_bt8xx_card *card;
+	struct list_head *entry, *entry_safe;
+
+	dvb_bt8xx_exit_adaps();
+	list_for_each_safe(entry, entry_safe, &card_list) {
+		card = list_entry(entry, struct dvb_bt8xx_card, list);
+		
+		dprintk("dvb_bt8xx: unloading card%d\n", card->bttv_nr);
+
+		bt878_stop(card->bt);
+		tasklet_kill(&card->bt->tasklet);
+		dvb_net_release(&card->dvbnet);
+		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_mem);
+		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
+		dvb_dmxdev_release(&card->dmxdev);
+		dvb_dmx_release(&card->demux);
+		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
+		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
+		dvb_unregister_adapter(card->dvb_adapter);
+		
+		list_del(&card->list);
+		kfree(card);
+	}
+
+}
+
+module_init(dvb_bt8xx_init);
+module_exit(dvb_bt8xx_exit);
+MODULE_DESCRIPTION("Bt8xx based DVB adapter driver");
+MODULE_AUTHOR("Florian Schirmer <schirmer@taytron.net>");
+MODULE_LICENSE("GPL");
+MODULE_PARM(debug, "i");
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.0-p/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- linux-2.6.0/drivers/media/dvb/bt8xx/dvb-bt8xx.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2003-11-25 13:10:26.000000000 +0100
@@ -0,0 +1,47 @@
+/*
+ * Bt8xx based DVB adapter driver 
+ *
+ * Copyright (C) 2002,2003 Florian Schirmer <schirmer@taytron.net>
+ * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+ * Copyright (C) 1999-2001 Ralph  Metzler & Marcus Metzler for convergence integrated media GmbH
+ * Copyright (C) 1998,1999 Christian Theiss <mistert@rz.fh-augsburg.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/i2c.h>
+#include "dvbdev.h"
+#include "dvb_net.h"
+
+struct dvb_bt8xx_card {
+
+	struct list_head list;
+	u8 active;
+	char card_name[32];
+	struct dvb_adapter *dvb_adapter;
+	struct bt878 *bt;
+	unsigned int bttv_nr;
+	struct dvb_demux demux;
+	struct dmxdev dmxdev;
+	struct dmx_frontend fe_hw;
+	struct dmx_frontend fe_mem;
+	u32 gpio_mode;
+	u32 op_sync_orin;
+	u32 irq_err_ignore;
+	struct i2c_adapter *i2c_adapter;
+	struct dvb_net dvbnet;
+				
+};
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/Kconfig linux-2.6.0-p/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.0/drivers/media/dvb/frontends/Kconfig	2003-12-18 03:58:16.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/Kconfig	2003-11-20 09:44:03.000000000 +0100
@@ -1,6 +1,17 @@
 comment "Supported Frontend Modules"
 	depends on DVB
 
+config DVB_TWINHAN_DST
+	tristate "TWINHAN DST based DVB-S frontend (QPSK)"
+	depends on DVB_CORE
+	help
+	  Used in such cards as the VP-1020/1030, Twinhan DST,
+	  VVmer TV@SAT. Say Y when you want to support frontends 
+	  using this asic.
+
+	  This module requires the dvb-bt8xx driver and dvb bt878
+	  module.
+
 config DVB_STV0299
 	tristate "STV0299 based DVB-S frontend (QPSK)"
 	depends on DVB_CORE
@@ -145,3 +155,19 @@
             wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
             unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
             mv ttlcdacc.dll /etc/dvb/tda1004x.bin
+
+config DVB_SP887X_FIRMWARE_FILE
+        string "Full pathname of sp887x firmware file"
+        depends on DVB_SP887X
+        default "/etc/dvb/sc_main.mc"
+        help
+          This driver needs a copy of the Avermedia firmware. The version tested
+	  is part of the Avermedia DVB-T 1.3.26.3 Application. This can be downloaded
+	  from the Avermedia web site.
+	  If the software is installed in Windows the file will be in the
+	  /Program Files/AVerTV DVB-T/ directory and is called sc_main.mc.
+	  Alternatively it can "extracted" from the install cab files but this will have
+	  to be done in windows as I don't know of a linux version of extract.exe.
+	  Copy this file to /etc/dvb/sc_main.mc. With this version of the file the first
+	  10 bytes are discarded and the next 0x4000 loaded. This may change in future
+	  versions.
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/Makefile linux-2.6.0-p/drivers/media/dvb/frontends/Makefile
--- linux-2.6.0/drivers/media/dvb/frontends/Makefile	2003-12-18 03:58:03.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/Makefile	2003-10-13 12:52:18.000000000 +0200
@@ -4,6 +4,7 @@
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
 
+obj-$(CONFIG_DVB_TWINHAN_DST) += dst.o
 obj-$(CONFIG_DVB_STV0299) += stv0299.o
 obj-$(CONFIG_DVB_ALPS_TDLB7) += alps_tdlb7.o
 obj-$(CONFIG_DVB_ALPS_TDMB7) += alps_tdmb7.o
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/dst-bt878.h linux-2.6.0-p/drivers/media/dvb/frontends/dst-bt878.h
--- linux-2.6.0/drivers/media/dvb/frontends/dst-bt878.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/dst-bt878.h	2003-10-28 03:33:54.000000000 +0100
@@ -0,0 +1,33 @@
+
+struct dst_gpio_enable {
+	u32	mask;
+	u32	enable;
+};
+
+struct dst_gpio_output {
+	u32	mask;
+	u32	highvals;
+};
+
+struct dst_gpio_read {
+	unsigned long value;
+};
+
+union dst_gpio_packet {
+	struct dst_gpio_enable enb;
+	struct dst_gpio_output outp;
+	struct dst_gpio_read rd;
+	int    psize;
+};
+
+#define DST_IG_ENABLE	0
+#define DST_IG_WRITE	1
+#define DST_IG_READ	2
+#define DST_IG_TS       3
+
+struct bt878 ;
+
+int
+bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
+
+struct bt878 *bt878_find_by_dvb_adap(struct dvb_adapter *adap);
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/dst.c linux-2.6.0-p/drivers/media/dvb/frontends/dst.c
--- linux-2.6.0/drivers/media/dvb/frontends/dst.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/dst.c	2003-11-05 16:42:47.000000000 +0100
@@ -0,0 +1,1189 @@
+/* 
+    Frontend-driver for TwinHan DST Frontend
+
+    Copyright (C) 2003 Jamie Honan
+
+
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/    
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <asm/div64.h>
+#include <asm/delay.h>
+
+#include "dvb_frontend.h"
+#include "dvb_functions.h"
+#include "dst-bt878.h"
+
+unsigned int dst_debug = 0;
+unsigned int dst_verbose = 0;
+
+MODULE_PARM(dst_verbose, "i");
+MODULE_PARM_DESC(dst_verbose,
+		 "verbose startup messages, default is 1 (yes)");
+MODULE_PARM(dst_debug, "i");
+MODULE_PARM_DESC(dst_debug, "debug messages, default is 0 (no)");
+
+unsigned int dst_type = (-1U);
+unsigned int dst_type_flags = (-1U);
+MODULE_PARM(dst_type, "i");
+MODULE_PARM_DESC(dst_type,
+		"Type of DST card, 0 Satellite, 1 terrestial TV, 2 Cable, default driver determined");
+MODULE_PARM(dst_type_flags, "i");
+MODULE_PARM_DESC(dst_type_flags,
+		"Type flags of DST card, bitfield 1=10 byte tuner, 2=TS is 204, 4=symdiv");
+
+#define dprintk	if (dst_debug) printk
+
+#define DST_TYPE_IS_SAT		0
+#define DST_TYPE_IS_TERR	1
+#define DST_TYPE_IS_CABLE	2
+
+#define DST_TYPE_HAS_NEWTUNE	1
+#define DST_TYPE_HAS_TS204	2
+#define DST_TYPE_HAS_SYMDIV	4
+
+#define HAS_LOCK	1
+#define ATTEMPT_TUNE	2
+#define HAS_POWER	4
+
+struct dst_data {
+	u8	tx_tuna[10];
+	u8	rx_tuna[10];
+	u8	rxbuffer[10];
+	u8	diseq_flags;
+	u8	dst_type;
+	u32	type_flags;
+	u32 frequency;     /* intermediate frequency in kHz for QPSK */
+        fe_spectral_inversion_t inversion;
+        u32   symbol_rate;  /* symbol rate in Symbols per second */
+	fe_code_rate_t  fec;
+	fe_sec_voltage_t voltage;
+	fe_sec_tone_mode_t tone;
+	u32 decode_freq;
+	u8  decode_lock;
+	u16 decode_strength;
+	u16 decode_snr;
+	unsigned long cur_jiff;
+	u8  k22;
+	fe_bandwidth_t bandwidth;
+	struct bt878 *bt;
+	struct dvb_i2c_bus *i2c;
+} ;
+
+static struct dvb_frontend_info dst_info_sat = {
+	.name 			= "DST SAT",
+	.type 			= FE_QPSK,
+	.frequency_min 		= 950000,
+	.frequency_max 		= 2150000,
+	.frequency_stepsize 	= 1000,           /* kHz for QPSK frontends */
+	.frequency_tolerance 	= 29500,
+	.symbol_rate_min	= 1000000,
+	.symbol_rate_max	= 45000000,
+/*     . symbol_rate_tolerance	= 	???,*/
+	.notifier_delay		= 50,                /* 1/20 s */
+	.caps = FE_CAN_INVERSION_AUTO |
+		FE_CAN_FEC_AUTO |
+		FE_CAN_QPSK
+};
+
+static struct dvb_frontend_info dst_info_cable = {
+	.name 			= "DST CABLE",
+	.type 			= FE_QAM,
+        .frequency_stepsize 	= 62500,
+	.frequency_min 		= 51000000,
+	.frequency_max 		= 858000000,
+	.symbol_rate_min	= 1000000,
+	.symbol_rate_max	= 45000000,
+/*     . symbol_rate_tolerance	= 	???,*/
+	.notifier_delay		= 50,                /* 1/20 s */
+	.caps = FE_CAN_INVERSION_AUTO |
+		FE_CAN_FEC_AUTO |
+		FE_CAN_QAM_AUTO
+};
+
+static struct dvb_frontend_info dst_info_tv = {
+	.name 			= "DST TERR",
+	.type 			= FE_OFDM,
+	.frequency_min 		= 137000000,
+	.frequency_max 		= 858000000,
+	.frequency_stepsize 	= 166667,
+	.caps = FE_CAN_INVERSION_AUTO |
+	    FE_CAN_FEC_AUTO |
+	    FE_CAN_QAM_AUTO |
+	    FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
+};
+
+static void dst_packsize(struct dst_data *dst, int psize)
+{
+	union dst_gpio_packet bits;
+
+	bits.psize = psize;
+	bt878_device_control(dst->bt, DST_IG_TS, &bits);
+}
+
+static int dst_gpio_outb(struct dst_data *dst, u32 mask, u32 enbb, u32 outhigh)
+{
+	union dst_gpio_packet enb;
+	union dst_gpio_packet bits;
+	int err;
+
+	enb.enb.mask = mask;
+	enb.enb.enable = enbb;
+        if ((err = bt878_device_control(dst->bt, DST_IG_ENABLE, &enb)) < 0) {
+		dprintk ("%s: dst_gpio_enb error (err == %i, mask == 0x%02x, enb == 0x%02x)\n", __FUNCTION__, err, mask, enbb);
+		return -EREMOTEIO;
+	}
+
+	/* because complete disabling means no output, no need to do
+	 * output packet */
+	if (enbb == 0)
+		return 0;
+
+	bits.outp.mask = enbb;
+	bits.outp.highvals = outhigh;
+
+        if ((err = bt878_device_control(dst->bt, DST_IG_WRITE, &bits)) < 0) {
+		dprintk ("%s: dst_gpio_outb error (err == %i, enbb == 0x%02x, outhigh == 0x%02x)\n", __FUNCTION__, err, enbb, outhigh);
+		return -EREMOTEIO;
+	}
+        return 0;
+}
+
+static int dst_gpio_inb(struct dst_data *dst, u8 *result)
+{
+	union dst_gpio_packet rd_packet;
+	int err;
+
+	*result = 0;
+
+        if ((err = bt878_device_control(dst->bt, DST_IG_READ, &rd_packet)) < 0) {
+		dprintk ("%s: dst_gpio_inb error (err == %i)\n", __FUNCTION__, err);
+		return -EREMOTEIO;
+	}
+	*result = (u8)rd_packet.rd.value;
+        return 0;
+}
+
+#define DST_I2C_ENABLE	1
+#define DST_8820  	2
+
+static int
+dst_reset8820(struct dst_data *dst)
+{
+int retval;
+	/* pull 8820 gpio pin low, wait, high, wait, then low */
+	// dprintk ("%s: reset 8820\n", __FUNCTION__);
+	retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
+	if (retval < 0)
+		return retval;
+	dvb_delay(10);
+	retval = dst_gpio_outb(dst, DST_8820, DST_8820, DST_8820);
+	if (retval < 0)
+		return retval;
+	/* wait for more feedback on what works here *
+	dvb_delay(10);
+	retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
+	if (retval < 0)
+		return retval;
+	*/
+	return 0;
+}
+
+static int
+dst_i2c_enable(struct dst_data *dst)
+{
+int retval;
+	/* pull I2C enable gpio pin low, wait */
+	// dprintk ("%s: i2c enable\n", __FUNCTION__);
+	retval = dst_gpio_outb(dst, ~0, DST_I2C_ENABLE, 0);
+	if (retval < 0)
+		return retval;
+	// dprintk ("%s: i2c enable delay\n", __FUNCTION__);
+	dvb_delay(33);
+	return 0;
+}
+
+static int
+dst_i2c_disable(struct dst_data *dst)
+{
+int retval;
+	/* release I2C enable gpio pin, wait */
+	// dprintk ("%s: i2c disable\n", __FUNCTION__);
+	retval = dst_gpio_outb(dst, ~0, 0, 0);
+	if (retval < 0)
+		return retval;
+	// dprintk ("%s: i2c disable delay\n", __FUNCTION__);
+	dvb_delay(33);
+	return 0;
+}
+
+static int
+dst_wait_dst_ready(struct dst_data *dst)
+{
+u8 reply;
+int retval;
+int i;
+	for (i = 0; i < 200; i++) {
+		retval = dst_gpio_inb(dst, &reply);
+		if (retval < 0)
+			return retval;
+		if ((reply & DST_I2C_ENABLE) == 0) {
+			dprintk ("%s: dst wait ready after %d\n", __FUNCTION__, i);
+			return 1;
+		}
+		dvb_delay(5);
+	}
+	dprintk ("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
+	return 0;
+}
+
+#define DST_I2C_ADDR 0x55
+
+static int write_dst (struct dst_data *dst, u8 *data, u8 len)
+{
+	struct i2c_msg msg = {
+		.addr = DST_I2C_ADDR, .flags = 0, .buf = data, .len = len };
+	int err;
+	int cnt;
+
+	if (dst_debug && dst_verbose) {
+		u8 i;
+		dprintk("%s writing",__FUNCTION__);
+		for (i = 0 ; i < len ; i++) {
+			dprintk(" 0x%02x", data[i]);
+		}
+		dprintk("\n");
+	}
+	dvb_delay(30);
+	for (cnt = 0; cnt < 4; cnt++) {
+		if ((err = dst->i2c->xfer (dst->i2c, &msg, 1)) < 0) {
+			dprintk ("%s: write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
+			dst_i2c_disable(dst);
+			dvb_delay(500);
+			dst_i2c_enable(dst);
+			dvb_delay(500);
+			continue;
+		} else
+			break;
+	}
+	if (cnt >= 4)
+		return -EREMOTEIO;
+        return 0;
+}
+
+static int read_dst (struct dst_data *dst, u8 *ret, u8 len)
+{
+	struct i2c_msg msg = 
+		{ .addr = DST_I2C_ADDR, .flags = I2C_M_RD, .buf = ret, .len = len };
+	int err;
+	int cnt;
+
+	for (cnt = 0; cnt < 4; cnt++) {
+		if ((err = dst->i2c->xfer (dst->i2c, &msg, 1)) < 0) {
+			dprintk ("%s: read_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, ret[0]);
+			dst_i2c_disable(dst);
+			dst_i2c_enable(dst);
+			continue;
+		} else
+			break;
+	}
+	if (cnt >= 4)
+		return -EREMOTEIO;
+	dprintk("%s reply is 0x%x\n", __FUNCTION__, ret[0]);
+	if (dst_debug && dst_verbose) {
+		for (err = 1; err < len; err++)
+			dprintk(" 0x%x", ret[err]);
+		if (err > 1)
+			dprintk("\n");
+	}
+	return 0;
+}
+
+static int dst_set_freq(struct dst_data *dst, u32 freq)
+{
+	u8 *val;
+
+	dst->frequency = freq;
+
+	// dprintk("%s: set frequency %u\n", __FUNCTION__, freq);
+	if (dst->dst_type == DST_TYPE_IS_SAT) {
+		freq = freq / 1000;
+		if (freq < 950 || freq > 2150)
+			return -EINVAL;
+		val = &dst->tx_tuna[0];
+		val[2] = (freq >> 8) & 0x7f;
+		val[3] = (u8)freq;
+		val[4] = 1;
+		val[8] &= ~4;
+		if (freq < 1531)
+			val[8] |= 4;
+	} else if (dst->dst_type == DST_TYPE_IS_TERR) {
+		freq = freq / 1000;
+		if (freq < 137000 || freq > 858000)
+			return -EINVAL;
+		val = &dst->tx_tuna[0];
+		val[2] = (freq >> 16) & 0xff;
+		val[3] = (freq >> 8) & 0xff;
+		val[4] = (u8)freq;
+		val[5] = 0;
+		switch (dst->bandwidth) {
+		case BANDWIDTH_6_MHZ:
+			val[6] = 6;
+			break;
+
+		case BANDWIDTH_7_MHZ:
+		case BANDWIDTH_AUTO:
+			val[6] = 7;
+			break;
+
+		case BANDWIDTH_8_MHZ:
+			val[6] = 8;
+			break;
+		}
+
+		val[7] = 0;
+		val[8] = 0;
+	} else if (dst->dst_type == DST_TYPE_IS_CABLE) {
+		/* guess till will get one */
+		freq = freq / 1000;
+		val = &dst->tx_tuna[0];
+		val[2] = (freq >> 16) & 0xff;
+		val[3] = (freq >> 8) & 0xff;
+		val[4] = (u8)freq;
+	} else
+		return -EINVAL;
+	return 0;
+}
+
+static int dst_set_bandwidth(struct dst_data *dst, fe_bandwidth_t bandwidth)
+{
+	u8 *val;
+
+	dst->bandwidth = bandwidth;
+
+	if (dst->dst_type != DST_TYPE_IS_TERR)
+		return 0;
+
+	val = &dst->tx_tuna[0];
+        switch (bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		val[6] = 6;
+		break;
+
+	case BANDWIDTH_7_MHZ:
+		val[6] = 7;
+		break;
+
+	case BANDWIDTH_8_MHZ:
+		val[6] = 8;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int dst_set_inversion (struct dst_data *dst, fe_spectral_inversion_t inversion)
+{
+	u8 *val;
+
+	dst->inversion = inversion;
+
+	val = &dst->tx_tuna[0];
+
+	val[8] &= ~0x80;
+
+	switch (inversion) {
+	case INVERSION_OFF:
+		break;
+	case INVERSION_ON:
+		val[8] |= 0x80;
+		break;
+	case INVERSION_AUTO:
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static int dst_set_fec (struct dst_data *dst, fe_code_rate_t fec)
+{
+	dst->fec = fec;
+	return 0;
+}
+
+static fe_code_rate_t dst_get_fec (struct dst_data *dst)
+{
+	return dst->fec;
+}
+
+static int dst_set_symbolrate (struct dst_data *dst, u32 srate)
+{
+	u8 *val;
+	u32 symcalc;
+	u64 sval;
+
+	dst->symbol_rate = srate;
+
+	if (dst->dst_type == DST_TYPE_IS_TERR) {
+		return 0;
+	}
+
+	// dprintk("%s: set srate %u\n", __FUNCTION__, srate);
+	srate /= 1000;
+	val = &dst->tx_tuna[0];
+
+	if (dst->type_flags & DST_TYPE_HAS_SYMDIV) {
+		sval = srate;
+		sval <<= 20;
+		do_div(sval, 88000);
+	        symcalc = (u32)sval;
+		// dprintk("%s: set symcalc %u\n", __FUNCTION__, symcalc);
+		val[5] = (u8)(symcalc >> 12);
+		val[6] = (u8)(symcalc >> 4);
+		val[7] = (u8)(symcalc << 4);
+	} else {
+		val[5] = (u8)(srate >> 16) & 0x7f;
+		val[6] = (u8)(srate >> 8);
+		val[7] = (u8)srate;
+	}
+	val[8] &= ~0x20;
+	if (srate > 8000)
+		val[8] |= 0x20;
+	return 0;
+}
+
+
+static u8 dst_check_sum(u8 *buf, u32 len)
+{
+	u32 i;
+	u8  val = 0;
+	if (!len)
+		return 0;
+	for (i = 0; i < len; i++) {
+		val += buf[i];
+	}
+	return ((~val) + 1);
+}
+
+typedef struct dst_types {
+	char	*mstr;
+	int	offs;
+	u8	dst_type;
+	u32	type_flags;
+} DST_TYPES;
+
+struct dst_types dst_tlist[] = {
+	{ "DST-020", 0,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_SYMDIV },
+	{ "DST-030", 0,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_TS204|DST_TYPE_HAS_NEWTUNE },
+	{ "DST-03T", 0,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_SYMDIV|DST_TYPE_HAS_TS204},
+	{ "DST-MOT", 0,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_SYMDIV },
+	{ "DST-CI",  1,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_TS204|DST_TYPE_HAS_NEWTUNE },
+	{ "DSTMCI",  1,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_NEWTUNE },
+	{ "DSTFCI",  1,  DST_TYPE_IS_SAT,    DST_TYPE_HAS_NEWTUNE },
+	{ "DCTNEW",  1,  DST_TYPE_IS_CABLE,  DST_TYPE_HAS_NEWTUNE },
+	{ "DCT_CI",  1,  DST_TYPE_IS_CABLE,  DST_TYPE_HAS_NEWTUNE|DST_TYPE_HAS_TS204 },
+	{ "DTTDIG" , 1,  DST_TYPE_IS_TERR,   0} };
+/* DCTNEW and DCT-CI are guesses */
+
+static void dst_type_flags_print(u32 type_flags)
+{
+	printk("DST type flags :");
+	if (type_flags & DST_TYPE_HAS_NEWTUNE)
+		printk(" 0x%x newtuner", DST_TYPE_HAS_NEWTUNE);
+	if (type_flags & DST_TYPE_HAS_TS204)
+		printk(" 0x%x ts204", DST_TYPE_HAS_TS204);
+	if (type_flags & DST_TYPE_HAS_SYMDIV)
+		printk(" 0x%x symdiv", DST_TYPE_HAS_SYMDIV);
+	printk("\n");
+}
+
+static int dst_type_print(u8 type)
+{
+	char *otype;
+	switch (type) {
+		case DST_TYPE_IS_SAT:
+			otype = "satellite";
+			break;
+		case DST_TYPE_IS_TERR:
+			otype = "terrestial TV";
+			break;
+		case DST_TYPE_IS_CABLE:
+			otype = "terrestial TV";
+			break;
+		default:
+			printk("%s: invalid dst type %d\n",
+				__FUNCTION__, type);
+			return -EINVAL;
+	}
+	printk("DST type : %s\n", otype);
+	return 0;
+}
+
+static int dst_check_ci (struct dst_data *dst)
+{
+	u8 txbuf[8];
+	u8 rxbuf[8];
+	int retval;
+	int i;
+	struct dst_types *dsp;
+	u8 use_dst_type;
+	u32 use_type_flags;
+
+	memset(txbuf, 0, sizeof(txbuf));
+	txbuf[1] = 6;
+	txbuf[7] = dst_check_sum (txbuf, 7);
+ 
+	dst_i2c_enable(dst);
+	dst_reset8820(dst);
+	retval = write_dst (dst, txbuf, 8);
+	if (retval < 0) {
+		dst_i2c_disable(dst);
+		dprintk("%s: write not successful, maybe no card?\n", __FUNCTION__);
+		return retval;
+	}
+	dvb_delay(3);
+	retval = read_dst (dst, rxbuf, 1);
+	dst_i2c_disable(dst);
+	if (retval < 0) {
+		dprintk("%s: read not successful, maybe no card?\n", __FUNCTION__);
+		return retval;
+	}
+	if (rxbuf[0] != 0xff) {
+		dprintk("%s: write reply not 0xff, not ci (%02x)\n", __FUNCTION__, rxbuf[0]);
+		return retval;
+	}
+	if (!dst_wait_dst_ready(dst))
+		return 0;
+	// dst_i2c_enable(i2c); Dimitri
+	retval = read_dst (dst, rxbuf, 8);
+	dst_i2c_disable(dst);
+	if (retval < 0) {
+		dprintk("%s: read not successful\n", __FUNCTION__);
+		return retval;
+	}
+	if (rxbuf[7] != dst_check_sum (rxbuf, 7)) {
+		dprintk("%s: checksum failure\n", __FUNCTION__);
+		return retval;
+	}
+	rxbuf[7] = '\0';
+	for (i = 0, dsp = &dst_tlist[0]; i < sizeof(dst_tlist) / sizeof(dst_tlist[0]); i++, dsp++) {
+		if (!strncmp(&rxbuf[dsp->offs],
+				dsp->mstr,
+				strlen(dsp->mstr))) {
+			use_type_flags = dsp->type_flags;
+			use_dst_type = dsp->dst_type;
+			printk("%s: recognize %s\n", __FUNCTION__, dsp->mstr);
+			break;
+		}
+	}
+	if (i >= sizeof(dst_tlist) / sizeof(dst_tlist[0])) {
+		printk("%s: unable to recognize %s or %s\n", __FUNCTION__, &rxbuf[0], &rxbuf[1]);
+		printk("%s please email linux-dvb@linuxtv.org with this type in\n", __FUNCTION__);
+		use_dst_type = DST_TYPE_IS_SAT;
+		use_type_flags = DST_TYPE_HAS_SYMDIV;
+	}
+	switch (dst_type) {
+		case (-1U):
+			/* not used */
+			break;
+		case DST_TYPE_IS_SAT:
+		case DST_TYPE_IS_TERR:
+		case DST_TYPE_IS_CABLE:
+			use_dst_type = (u8)dst_type;
+			break;
+		default:
+			printk("%s: invalid user override dst type %d, not used\n",
+				__FUNCTION__, dst_type);
+			break;
+	}
+	dst_type_print(use_dst_type);
+	if (dst_type_flags != (-1U)) {
+		printk("%s: user override dst type flags 0x%x\n",
+				__FUNCTION__, dst_type_flags);
+		use_type_flags = dst_type_flags;
+	}
+	dst->type_flags = use_type_flags;
+	dst->dst_type= use_dst_type;
+	dst_type_flags_print(dst->type_flags);
+
+	if (dst->type_flags & DST_TYPE_HAS_TS204) {
+		dst_packsize(dst, 204);
+	}
+	return 0;
+}
+
+static int dst_command (struct dst_data *dst, u8 *data, u8 len)
+{
+	int retval;
+	u8 reply;
+
+	dst_i2c_enable(dst);
+	dst_reset8820(dst);
+	retval = write_dst (dst, data, len);
+	if (retval < 0) {
+		dst_i2c_disable(dst);
+		dprintk("%s: write not successful\n", __FUNCTION__);
+		return retval;
+	}
+	dvb_delay(33);
+	retval = read_dst (dst, &reply, 1);
+	dst_i2c_disable(dst);
+	if (retval < 0) {
+		dprintk("%s: read verify  not successful\n", __FUNCTION__);
+		return retval;
+	}
+	if (reply != 0xff) {
+		dprintk("%s: write reply not 0xff 0x%02x \n", __FUNCTION__, reply);
+		return 0;
+	}
+	if (len >= 2 && data[0] == 0 && (data[1] == 1 || data[1] == 3))
+		return 0;
+	if (!dst_wait_dst_ready(dst))
+		return 0;
+	// dst_i2c_enable(i2c); Per dimitri
+	retval = read_dst (dst, dst->rxbuffer, 8);
+	dst_i2c_disable(dst);
+	if (retval < 0) {
+		dprintk("%s: read not successful\n", __FUNCTION__);
+		return 0;
+	}
+	if (dst->rxbuffer[7] != dst_check_sum (dst->rxbuffer, 7)) {
+		dprintk("%s: checksum failure\n", __FUNCTION__);
+		return 0;
+	}
+	return 0;
+}
+
+static int dst_get_signal(struct dst_data *dst)
+{
+	int retval;
+	u8 get_signal[] = {0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb};
+
+	if ((dst->diseq_flags & ATTEMPT_TUNE) == 0) {
+		dst->decode_lock = dst->decode_strength = dst->decode_snr = 0;
+		return 0;
+	}
+	if (0 == (dst->diseq_flags & HAS_LOCK)) {
+		dst->decode_lock = dst->decode_strength = dst->decode_snr = 0;
+		return 0;
+	}
+	if (time_after_eq(jiffies, dst->cur_jiff + (HZ/5))) {
+		retval =  dst_command(dst, get_signal, 8);
+		if (retval < 0)
+			return retval;
+		if (dst->dst_type == DST_TYPE_IS_SAT) {
+			dst->decode_lock = ((dst->rxbuffer[6] & 0x10) == 0) ?
+					1 : 0;
+			dst->decode_strength = dst->rxbuffer[5] << 8;
+			dst->decode_snr = dst->rxbuffer[2] << 8 |
+				dst->rxbuffer[3];
+		} else if ((dst->dst_type == DST_TYPE_IS_TERR) ||
+				(dst->dst_type == DST_TYPE_IS_CABLE)) {
+			dst->decode_lock = (dst->rxbuffer[1]) ?
+					1 : 0;
+			dst->decode_strength = dst->rxbuffer[4] << 8;
+			dst->decode_snr = dst->rxbuffer[3] << 8;
+		}
+		dst->cur_jiff = jiffies;
+	}
+	return 0;
+}
+
+/*
+ * line22k0    0x00, 0x09, 0x00, 0xff, 0x01, 0x00, 0x00, 0x00
+ * line22k1    0x00, 0x09, 0x01, 0xff, 0x01, 0x00, 0x00, 0x00
+ * line22k2    0x00, 0x09, 0x02, 0xff, 0x01, 0x00, 0x00, 0x00
+ * tone        0x00, 0x09, 0xff, 0x00, 0x01, 0x00, 0x00, 0x00
+ * data        0x00, 0x09, 0xff, 0x01, 0x01, 0x00, 0x00, 0x00
+ * power_off   0x00, 0x09, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00
+ * power_on    0x00, 0x09, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00
+ * Diseqc 1    0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec
+ * Diseqc 2    0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf4, 0xe8 
+ * Diseqc 3    0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf8, 0xe4 
+ * Diseqc 4    0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xfc, 0xe0 
+ */
+
+static int dst_set_diseqc (struct dst_data *dst, u8 *cmd, u8 len)
+{
+	u8 paket[8] =  {0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec };
+
+	if (dst->dst_type == DST_TYPE_IS_TERR)
+		return 0;
+
+	if (len == 0 || len > 4)
+		return -EINVAL;
+	memcpy(&paket[3], cmd, len);
+	paket[7] = dst_check_sum (&paket[0], 7);
+	dst_command(dst, paket, 8);
+	return 0;
+}
+
+static int dst_tone_power_cmd (struct dst_data *dst)
+{
+	u8 paket[8] =  {0x00, 0x09, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00};
+
+	if (dst->dst_type == DST_TYPE_IS_TERR)
+		return 0;
+
+	if (dst->voltage == SEC_VOLTAGE_OFF) 
+		paket[4] = 0;
+	else
+		paket[4] = 1;
+	if (dst->tone == SEC_TONE_ON)
+		paket[2] = dst->k22;
+	else
+		paket[2] = 0;
+	paket[7] = dst_check_sum (&paket[0], 7);
+	dst_command(dst, paket, 8);
+	return 0;
+}
+
+static int dst_set_voltage (struct dst_data *dst, fe_sec_voltage_t voltage)
+{
+	u8 *val;
+	int need_cmd;
+
+	dst->voltage = voltage;
+
+	if (dst->dst_type == DST_TYPE_IS_TERR)
+		return 0;
+
+	need_cmd = 0;
+	val = &dst->tx_tuna[0];
+	val[8] &= ~0x40;
+	switch (voltage) {
+	case SEC_VOLTAGE_13:
+		if ((dst->diseq_flags & HAS_POWER) == 0)
+			need_cmd = 1;
+		dst->diseq_flags |= HAS_POWER;
+		break;
+	case SEC_VOLTAGE_18:
+		if ((dst->diseq_flags & HAS_POWER) == 0)
+			need_cmd = 1;
+		dst->diseq_flags |= HAS_POWER;
+		val[8] |= 0x40;
+		break;
+	case SEC_VOLTAGE_OFF:
+		need_cmd = 1;
+		dst->diseq_flags &= ~(HAS_POWER|HAS_LOCK|ATTEMPT_TUNE);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (need_cmd) {
+		dst_tone_power_cmd(dst);
+	}
+	return 0;
+}
+
+
+static int dst_set_tone (struct dst_data *dst, fe_sec_tone_mode_t tone)
+{
+	u8 *val;
+
+	dst->tone = tone;
+
+	if (dst->dst_type == DST_TYPE_IS_TERR)
+		return 0;
+
+	val = &dst->tx_tuna[0];
+
+	val[8] &= ~0x1;
+
+	switch (tone) {
+	case SEC_TONE_OFF:
+		break;
+	case SEC_TONE_ON:
+		val[8] |= 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	dst_tone_power_cmd(dst);
+	return 0;
+}
+
+static int dst_get_tuna (struct dst_data *dst)
+{
+int retval;
+	if ((dst->diseq_flags & ATTEMPT_TUNE) == 0)
+		return 0;
+	dst->diseq_flags &= ~(HAS_LOCK);
+	if (!dst_wait_dst_ready(dst))
+		return 0;
+	if (dst->type_flags & DST_TYPE_HAS_NEWTUNE) {
+		/* how to get variable length reply ???? */
+		retval = read_dst (dst, dst->rx_tuna, 10);
+	} else {
+		retval = read_dst (dst, &dst->rx_tuna[2], 8);
+	}
+	if (retval < 0) {
+		dprintk("%s: read not successful\n", __FUNCTION__);
+		return 0;
+	}
+	if (dst->type_flags & DST_TYPE_HAS_NEWTUNE) {
+		if (dst->rx_tuna[9] != dst_check_sum (&dst->rx_tuna[0], 9)) {
+			dprintk("%s: checksum failure?\n", __FUNCTION__);
+			return 0;
+		}
+	} else {
+		if (dst->rx_tuna[9] != dst_check_sum (&dst->rx_tuna[2], 7)) {
+			dprintk("%s: checksum failure?\n", __FUNCTION__);
+			return 0;
+		}
+	}
+	if (dst->rx_tuna[2] == 0 && dst->rx_tuna[3] == 0)
+		return 0;
+	dst->decode_freq = ((dst->rx_tuna[2] & 0x7f) << 8) +  dst->rx_tuna[3];
+
+	dst->decode_lock = 1;
+	/*
+	dst->decode_n1 = (dst->rx_tuna[4] << 8) +  
+			(dst->rx_tuna[5]);
+
+	dst->decode_n2 = (dst->rx_tuna[8] << 8) +  
+			(dst->rx_tuna[7]);
+	*/
+	dst->diseq_flags |= HAS_LOCK;
+	/* dst->cur_jiff = jiffies; */
+	return 1;
+}
+
+static int dst_write_tuna (struct dst_data *dst)
+{
+	int retval;
+	u8 reply;
+
+	dprintk("%s: type_flags 0x%x \n", __FUNCTION__, dst->type_flags);
+	dst->decode_freq = 0;
+	dst->decode_lock = dst->decode_strength = dst->decode_snr = 0;
+	if (dst->dst_type == DST_TYPE_IS_SAT) {
+		if (!(dst->diseq_flags & HAS_POWER))
+			dst_set_voltage (dst, SEC_VOLTAGE_13);
+	}
+	dst->diseq_flags &= ~(HAS_LOCK|ATTEMPT_TUNE);
+	dst_i2c_enable(dst);
+	if (dst->type_flags & DST_TYPE_HAS_NEWTUNE) {
+		dst_reset8820(dst);
+		dst->tx_tuna[9] = dst_check_sum (&dst->tx_tuna[0], 9);
+		retval = write_dst (dst, &dst->tx_tuna[0], 10);
+	} else {
+		dst->tx_tuna[9] = dst_check_sum (&dst->tx_tuna[2], 7);
+		retval = write_dst (dst, &dst->tx_tuna[2], 8);
+	}
+	if (retval < 0) {
+		dst_i2c_disable(dst);
+		dprintk("%s: write not successful\n", __FUNCTION__);
+		return retval;
+	}
+	dvb_delay(3);
+	retval = read_dst (dst, &reply, 1);
+	dst_i2c_disable(dst);
+	if (retval < 0) {
+		dprintk("%s: read verify  not successful\n", __FUNCTION__);
+		return retval;
+	}
+	if (reply != 0xff) {
+		dprintk("%s: write reply not 0xff 0x%02x \n", __FUNCTION__, reply);
+		return 0;
+	}
+	dst->diseq_flags |= ATTEMPT_TUNE;
+	return dst_get_tuna(dst);
+}
+
+static void dst_init (struct dst_data *dst)
+{
+static u8 ini_satci_tuna[] = {  9, 0, 3, 0xb6, 1, 0,    0x73, 0x21, 0, 0 };
+static u8 ini_satfta_tuna[] = { 0, 0, 3, 0xb6, 1, 0x55, 0xbd, 0x50, 0, 0 };
+static u8 ini_tvfta_tuna[] = { 0, 0,  3, 0xb6, 1, 7,    0x0,   0x0, 0, 0 };
+static u8 ini_tvci_tuna[] = { 9, 0,  3, 0xb6, 1, 7,    0x0,   0x0, 0, 0 };
+static u8 ini_cabfta_tuna[] = { 0, 0,  3, 0xb6, 1, 7,    0x0,   0x0, 0, 0 };
+static u8 ini_cabci_tuna[] = { 9, 0,  3, 0xb6, 1, 7,    0x0,   0x0, 0, 0 };
+	dst->inversion = INVERSION_ON;
+	dst->voltage = SEC_VOLTAGE_13;
+	dst->tone = SEC_TONE_OFF;
+	dst->symbol_rate = 29473000;
+	dst->fec = FEC_AUTO;
+	dst->diseq_flags = 0;
+	dst->k22 = 0x02;
+	dst->bandwidth = BANDWIDTH_7_MHZ;
+	dst->cur_jiff = jiffies;
+	if (dst->dst_type == DST_TYPE_IS_SAT) {
+		dst->frequency = 950000;
+		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
+					ini_satci_tuna : ini_satfta_tuna),
+				sizeof(ini_satfta_tuna));
+	} else if (dst->dst_type == DST_TYPE_IS_TERR) {
+		dst->frequency = 137000000;
+		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
+					ini_tvci_tuna : ini_tvfta_tuna),
+				sizeof(ini_tvfta_tuna));
+	} else if (dst->dst_type == DST_TYPE_IS_CABLE) {
+		dst->frequency = 51000000;
+		memcpy(dst->tx_tuna, ((dst->type_flags &  DST_TYPE_HAS_NEWTUNE )? 
+					ini_cabci_tuna : ini_cabfta_tuna),
+				sizeof(ini_cabfta_tuna));
+	}
+}
+
+struct lkup {
+	unsigned int cmd;
+	char *desc;
+} looker[] = {
+	{FE_GET_INFO,                "FE_GET_INFO:"},
+	{FE_READ_STATUS,             "FE_READ_STATUS:" },
+	{FE_READ_BER,                "FE_READ_BER:" },
+	{FE_READ_SIGNAL_STRENGTH,    "FE_READ_SIGNAL_STRENGTH:" },
+	{FE_READ_SNR,                "FE_READ_SNR:" },
+	{FE_READ_UNCORRECTED_BLOCKS, "FE_READ_UNCORRECTED_BLOCKS:" },
+	{FE_SET_FRONTEND,            "FE_SET_FRONTEND:" },
+	{FE_GET_FRONTEND,            "FE_GET_FRONTEND:" },
+	{FE_SLEEP,                   "FE_SLEEP:" },
+	{FE_INIT,                    "FE_INIT:" },
+	{FE_RESET,                   "FE_RESET:" },
+	{FE_SET_TONE,                "FE_SET_TONE:" },
+	{FE_SET_VOLTAGE,             "FE_SET_VOLTAGE:" },
+	};
+
+static int dst_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct dst_data *dst = fe->data;
+	int retval;
+	/*
+	char  *cc;
+                
+	cc = "FE_UNSUPP:";
+	for(retval = 0; retval < sizeof(looker) / sizeof(looker[0]); retval++) {
+		if (looker[retval].cmd == cmd) {
+			cc = looker[retval].desc;
+			break;
+		}
+	}
+	dprintk("%s cmd %s (0x%x)\n",__FUNCTION__, cc, cmd);
+	*/
+	// printk("%s: dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, dst, dst->bt, dst->i2c);
+	/* should be set by attach, but just in case */
+	dst->i2c = fe->i2c;
+        switch (cmd) {
+        case FE_GET_INFO: 
+	{
+	     struct dvb_frontend_info *info;
+		info = &dst_info_sat;
+		if (dst->dst_type == DST_TYPE_IS_TERR)
+			info = &dst_info_tv;
+		else if (dst->dst_type == DST_TYPE_IS_CABLE)
+			info = &dst_info_cable;
+		memcpy (arg, info, sizeof(struct dvb_frontend_info));
+		break;
+	}
+        case FE_READ_STATUS:
+	{
+		fe_status_t *status = arg;
+
+		*status = 0;
+		if (dst->diseq_flags & HAS_LOCK) {
+			dst_get_signal(dst);
+			if (dst->decode_lock)
+				*status |= FE_HAS_LOCK 
+					| FE_HAS_SIGNAL 
+					| FE_HAS_CARRIER
+					| FE_HAS_SYNC
+					| FE_HAS_VITERBI;
+		}
+		break;
+	}
+
+        case FE_READ_BER:
+	{
+		/* guess */
+		// *(u32*) arg = dst->decode_n1;
+		*(u32*) arg = 0;
+		return -EOPNOTSUPP; 
+	}
+
+        case FE_READ_SIGNAL_STRENGTH:
+	{
+		dst_get_signal(dst);
+		*((u16*) arg) = dst->decode_strength;
+		break;
+	}
+
+        case FE_READ_SNR:
+	{
+		dst_get_signal(dst);
+		*((u16*) arg) = dst->decode_snr;
+		break;
+	}
+
+	case FE_READ_UNCORRECTED_BLOCKS: 
+	{
+		*((u32*) arg) = 0;    /* the stv0299 can't measure BER and */
+		return -EOPNOTSUPP;   /* errors at the same time.... */
+	}
+
+        case FE_SET_FRONTEND:
+        {
+		struct dvb_frontend_parameters *p = arg;
+
+		dst_set_freq (dst, p->frequency);
+		dst_set_inversion (dst, p->inversion);
+		if (dst->dst_type == DST_TYPE_IS_SAT) {
+			dst_set_fec (dst, p->u.qpsk.fec_inner);
+			dst_set_symbolrate (dst, p->u.qpsk.symbol_rate);
+		} else if (dst->dst_type == DST_TYPE_IS_TERR) {
+			dst_set_bandwidth(dst, p->u.ofdm.bandwidth);
+		} else if (dst->dst_type == DST_TYPE_IS_CABLE) {
+			dst_set_fec (dst, p->u.qam.fec_inner);
+			dst_set_symbolrate (dst, p->u.qam.symbol_rate);
+		}
+		dst_write_tuna (dst);
+
+                break;
+        }
+
+	case FE_GET_FRONTEND:
+	{
+		struct dvb_frontend_parameters *p = arg;
+
+
+		p->frequency = dst->decode_freq;
+		p->inversion = dst->inversion;
+		if (dst->dst_type == DST_TYPE_IS_SAT) {
+			p->u.qpsk.symbol_rate = dst->symbol_rate;
+			p->u.qpsk.fec_inner = dst_get_fec (dst);
+		} else if (dst->dst_type == DST_TYPE_IS_TERR) {
+			p->u.ofdm.bandwidth = dst->bandwidth;
+		} else if (dst->dst_type == DST_TYPE_IS_CABLE) {
+			p->u.qam.symbol_rate = dst->symbol_rate;
+			p->u.qam.fec_inner = dst_get_fec (dst);
+			p->u.qam.modulation = QAM_AUTO;
+		}
+		break;
+	}
+
+        case FE_SLEEP:
+		return 0;
+
+        case FE_INIT:
+		dst_init(dst);
+		break;
+
+	case FE_RESET:
+		break;
+
+	case FE_DISEQC_SEND_MASTER_CMD:
+	{
+		struct dvb_diseqc_master_cmd *cmd = (struct dvb_diseqc_master_cmd *)arg;
+		retval = dst_set_diseqc (dst, cmd->msg, cmd->msg_len);
+		if (retval < 0)
+			return retval;
+		break;
+	}
+	case FE_SET_TONE:
+		retval = dst_set_tone (dst, (fe_sec_tone_mode_t) arg);
+		if (retval < 0)
+			return retval;
+		break;
+	case FE_SET_VOLTAGE:
+		retval = dst_set_voltage (dst, (fe_sec_voltage_t) arg);
+		if (retval < 0)
+			return retval;
+		break;
+	default:
+		return -EOPNOTSUPP;
+        };
+        
+        return 0;
+} 
+
+
+static int dst_attach (struct dvb_i2c_bus *i2c, void **data)
+{
+	struct dst_data *dst;
+	struct bt878 *bt;
+	struct dvb_frontend_info *info;
+
+	dprintk("%s: check ci\n", __FUNCTION__);
+	bt = bt878_find_by_dvb_adap(i2c->adapter);
+	if (!bt)
+		return -ENODEV;
+	dst = kmalloc(sizeof(struct dst_data), GFP_KERNEL);
+	if (dst == NULL) {
+		printk(KERN_INFO "%s: Out of memory.\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	memset(dst, 0, sizeof(*dst));
+	*data = dst;
+	dst->bt = bt;
+	dst->i2c = i2c;
+	if (dst_check_ci(dst) < 0) {
+		kfree(dst);
+		return -ENODEV;
+	}
+
+	dst_init (dst);
+	dprintk("%s: register dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, 
+			(u32)dst, (u32)(dst->bt), (u32)(dst->i2c));
+
+	info = &dst_info_sat;
+	if (dst->dst_type == DST_TYPE_IS_TERR)
+		info = &dst_info_tv;
+	else if (dst->dst_type == DST_TYPE_IS_CABLE)
+		info = &dst_info_cable;
+
+	dvb_register_frontend (dst_ioctl, i2c, dst, info);
+
+	return 0;
+}
+
+static void dst_detach (struct dvb_i2c_bus *i2c, void *data)
+{
+	dvb_unregister_frontend (dst_ioctl, i2c);
+	dprintk("%s: unregister dst %8.8x\n", __FUNCTION__, (u32)(data));
+	if (data)
+		kfree(data);
+}
+
+static int __init init_dst (void)
+{
+	return dvb_register_i2c_device (THIS_MODULE, dst_attach, dst_detach);
+}
+
+static void __exit exit_dst (void)
+{
+	dvb_unregister_i2c_device (dst_attach);
+}
+
+
+module_init(init_dst);
+module_exit(exit_dst);
+
+MODULE_DESCRIPTION("DST DVB-S Frontend");
+MODULE_AUTHOR("Jamie Honan");
+MODULE_LICENSE("GPL");
+

