Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbVLOKDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbVLOKDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 05:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbVLOKDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 05:03:22 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:17086 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1422682AbVLOKDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 05:03:21 -0500
Date: Thu, 15 Dec 2005 13:03:54 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net, david-b@pacbell.net,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git 3/3] SPI core refresh: SPI/PNX bus driver and EEPROM
 driver
Message-Id: <20051215130354.5ca3d99f.vwool@ru.mvista.com>
In-Reply-To: <20051215130205.2ebdea18.vwool@ru.mvista.com>
References: <20051215125800.4fa95de6.vwool@ru.mvista.com>
	<20051215130027.1347634b.vwool@ru.mvista.com>
	<20051215130205.2ebdea18.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>
Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 Kconfig          |    8
 pnx4008-eeprom.c |  121 +++++++++++++
 spipnx-init.h    |    9
 spipnx.c         |  510 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 spipnx.h         |   58 ++++++
 5 files changed, 706 insertions(+)

Index: linux-2.6.orig/drivers/spi/Kconfig
===================================================================
--- linux-2.6.orig.orig/drivers/spi/Kconfig
+++ linux-2.6.orig/drivers/spi/Kconfig
@@ -42,5 +42,13 @@ config SPI_CHARDEV
 	  Say Y here to use /dev/spiNN device files. They make it possible to have user-space
 	  programs use the SPI bus.
 
+config SPI_PNX
+ 	tristate "PNX SPI bus support"
+ 	depends on ARCH_PNX4008 && SPI
+
+config SPI_PNX4008_EEPROM
+ 	tristate "Dummy EEPROM driver"
+ 	depends on SPI && SPI_PNX && ARCH_PNX4008
+
 endmenu
 
Index: linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
@@ -0,0 +1,121 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+
+#include "spipnx.h"
+
+#define EEPROM_SIZE		256
+#define DRIVER_NAME		"EEPROM"
+#define READ_BUFF_SIZE 160
+
+static int __init spi_eeprom_init(void);
+static void __exit spi_eeprom_cleanup(void);
+
+static int spiee_read_block (struct device *d, void *block)
+{
+	struct spi_device *device = TO_SPI_DEV (d);
+	char cmd[2];
+	struct spi_msg *msg = spimsg_alloc(device,
+					SPI_M_CS|SPI_M_CSREL,
+					NULL,
+					0,
+					NULL);
+	struct spi_msg *msg_cmd = spimsg_chain(msg, SPI_M_CS|SPI_M_WR|SPI_M_DMAUNSAFE, cmd, 2, NULL);
+	spimsg_chain(msg_cmd, SPI_M_RD|SPI_M_CSREL,  block, 256, NULL);
+
+	cmd[ 0 ] = 0x03;
+	cmd[ 1 ] = 0x00;
+
+	spimsg_set_clock(msg, 2000000); /* 2 MHz */
+	spi_transfer(msg, NULL);
+	spimsg_free(msg);
+	return 256;
+}
+static ssize_t blk_show (struct device *d, struct device_attribute *attr, char *text )
+{
+	char *rdbuff = kmalloc (256, SLAB_KERNEL);
+	char line1[80],line2[80];
+	char item1[5], item2[5];
+	int bytes, i, x, blen;
+
+	blen = spiee_read_block (d, rdbuff);
+
+	bytes = 0;
+
+	strcpy(text, "");
+	for (i = 0; i < blen; i += 8) {
+		strcpy(line1, "");
+		strcpy(line2, "" );
+		for (x = i; x < i + 8; x++) {
+			if (x > blen) {
+				sprintf(item1, "   ");
+				sprintf(item2, " " );
+			} else {
+				sprintf(item1, "%02x ", rdbuff[x]);
+				if (isprint(rdbuff[x])) {
+					sprintf(item2, "%c", rdbuff[x]);
+				} else {
+					sprintf(item2, ".");
+				}
+			}
+			strcat(line1, item1);
+			strcat(line2, item2);
+		}
+
+		strcat(text, line1);
+		strcat(text, "|  " );
+		strcat(text, line2);
+		strcat(text, "\n" );
+
+		bytes += (strlen (line1 ) + strlen(line2) + 4);
+	}
+
+	kfree (rdbuff);
+
+	return bytes + 1;
+}
+
+static DEVICE_ATTR(blk, S_IRUGO, blk_show, NULL );
+
+
+static int spiee_probe(struct spi_device *this_dev)
+{
+	device_create_file(&this_dev->dev, &dev_attr_blk);
+	return 0;
+}
+
+static int spiee_remove(struct spi_device *this_dev)
+{
+	device_remove_file(&this_dev->dev, &dev_attr_blk);
+	return 0;
+}
+
+static struct spi_driver eeprom_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+	},
+	.probe = spiee_probe,
+	.remove = spiee_remove,
+};
+
+static int __init spi_eeprom_init(void)
+{
+	return spi_driver_add(&eeprom_driver);
+}
+static void __exit spi_eeprom_cleanup(void)
+{
+	spi_driver_del(&eeprom_driver);
+}
+
+module_init(spi_eeprom_init);
+module_exit(spi_eeprom_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@gmail.com>");
+MODULE_DESCRIPTION("SPI EEPROM driver");
Index: linux-2.6.orig/drivers/spi/spipnx-init.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spipnx-init.h
@@ -0,0 +1,9 @@
+#include <linux/kernel.h>
+#include <asm/arch/spi.h>
+
+#ifdef CONFIG_ARCH_PNX4008
+struct spipnx_wifi_params spipnx_wifi_params = {
+	.gpio_cs_line = GPIO_03,
+};
+#endif
+
Index: linux-2.6.orig/drivers/spi/spipnx.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spipnx.c
@@ -0,0 +1,510 @@
+/*
+ * drivers/spi/spi-pnx.c
+ *
+ * SPI support for PNX 010x/4008 boards.
+ *
+ * Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ * Based on Dennis Kovalev's <dkovalev@ru.mvista.com> bus driver for pnx010x
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/platform.h>
+#include <linux/spi.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/dma.h>
+#include <asm/dma-mapping.h>
+#include <asm/hardware/clock.h>
+
+#include "spipnx.h"
+#include "spipnx-init.h"
+
+#define lock_device( dev )	/* down( &dev->sem ); */
+#define unlock_device( dev )	/* up( &dev->sem );   */
+
+#define spipnx_dump_xchg(xxx...) pr_debug( xxx )
+
+
+static int spipnx_spi_init(struct device *bus_device);
+static int spipnx_xfer(struct spi_msg *msg);
+static int spipnx_probe(struct device *bus_device);
+static int spipnx_remove(struct device *bus_device);
+static int spipnx_suspend(struct device *bus_device, pm_message_t);
+static int spipnx_resume(struct device *bus_device);
+static void spipnx_control(struct spi_device *device, int code, u32 ctl);
+static int spipnx_request_hardware(struct spipnx_driver_data *dd,
+				   struct platform_device *dev);
+static void spipnx_free_hardware(struct spipnx_driver_data *dd,
+				 struct platform_device *dev);
+static void spipnx_set_clock(struct device *bus_device, u32 clock);
+static void spipnx_reset (struct device *bus_device, u32 context);
+static void *spipnx_alloc(void *buf, size_t len, int dir);
+static void spipnx_free(void *buf, void *safe, size_t len, int dir);
+
+
+static struct spi_bus_driver spipnx_driver = {
+	.driver = {
+		   .bus = &platform_bus_type,
+		   .name = "spipnx",
+		   .probe = spipnx_probe,
+		   .remove = spipnx_remove,
+		   .suspend = spipnx_suspend,
+		   .resume = spipnx_resume,
+		   },
+	.xfer = spipnx_xfer,
+	.set_clock = spipnx_set_clock,
+ 	.reset = spipnx_reset,
+	.dma_safe_alloc = spipnx_alloc,
+	.dma_safe_free = spipnx_free,
+};
+
+static void *spipnx_alloc(void *buf, size_t len, int dir)
+{
+	void *safe = kmalloc(len, SLAB_KERNEL);
+
+	if (safe && (dir & SPI_M_WR))
+		memcpy(safe, buf, len);
+
+	return safe;
+}
+
+static void spipnx_free(void *buf, void *safe, size_t len, int dir)
+{
+	if (dir & SPI_M_RD)
+		memcpy(buf, safe, len);
+	kfree(safe);
+}
+
+void spipnx_set_mode(struct device *bus_device, int mode)
+{
+	struct spipnx_driver_data *dd = dev_get_drvdata(bus_device);
+
+	lock_device(bus_device);
+	dd->dma_mode = mode;
+	unlock_device(bus_device);
+}
+
+static void spipnx_set_clock(struct device *bus_device, u32 clock)
+{
+	struct spipnx_driver_data *dd = dev_get_drvdata(bus_device);
+
+	dd->saved_clock = clock;
+	dev_dbg (bus_device, "setting clock speed to %d\n", dd->saved_clock );
+}
+
+static void spipnx_reset (struct device *bus_device, u32 context )
+{
+	struct spipnx_driver_data *dd = dev_get_drvdata(bus_device);
+
+	dd->spi_regs->con = context;
+	dev_dbg (bus_device, "CON set to 0x%08X\n", context );
+}
+
+static int spipnx_probe(struct device *device)
+{
+	struct spipnx_driver_data *dd;
+	int err;
+
+	dd = kzalloc(sizeof(struct spipnx_driver_data), GFP_KERNEL);
+	if (!dd) {
+		err = -ENOMEM;
+		goto probe_fail_1;
+	}
+	/*
+	 * these special values are needed because 0 is the valid
+	 * assignment to IRQ# and DMA channel as well as DMA slave#
+	 */
+	dd->dma_channel = -1;
+	dd->slave_nr = -1;
+	dd->irq = NO_IRQ;
+
+	err = spipnx_request_hardware(dd, to_platform_device(device));
+	if (err)
+		goto probe_fail_2;
+
+	spi_bus_driver_init(&spipnx_driver, device);
+
+	dd->state = SPIPNX_STATE_READY;
+
+	dev_set_drvdata(device, dd);
+
+	spipnx_arch_add_devices( device, to_platform_device(device)->id );
+
+	return 0;
+
+probe_fail_2:
+	spipnx_remove(device);
+probe_fail_1:
+	return err;
+}
+
+int spipnx_remove(struct device *device)
+{
+	struct spipnx_driver_data *dd = dev_get_drvdata(device);
+
+	spi_bus_driver_cleanup(TO_SPI_BUS_DRIVER(device->driver), device);
+	spipnx_free_hardware(dd, to_platform_device(device));
+	kfree(dd);
+	return 0;
+}
+
+static void spipnx_free_hardware(struct spipnx_driver_data *dd,
+				 struct platform_device *dev)
+{
+	lock_device(&dev->dev);
+
+	spipnx_clk_stop(dd->clk);
+
+	if (dd->io_flags & IORESOURCE_IRQ) {
+		free_irq(dd->irq, dev->dev.bus_id);
+		dd->io_flags &= ~IORESOURCE_IRQ;
+	}
+	if (dd->io_flags & IORESOURCE_MEM) {
+		/*
+		release_mem_region((unsigned long)dd->iostart,
+				   dd->ioend - dd->iostart + 1);
+		*/
+		dd->io_flags &= ~IORESOURCE_MEM;
+	}
+	if (dd->io_flags & IORESOURCE_DMA) {
+		spipnx_release_dma(&dd->dma_channel);
+		dd->io_flags &= ~IORESOURCE_DMA;
+	}
+
+	spipnx_clk_free(dd->clk);
+
+#ifdef DEBUG
+	if (dd->io_flags)
+		printk(KERN_ERR
+		       "Oops, dd_ioflags for driver data %p is still 0x%x!\n",
+		       dd, dd->io_flags);
+#endif
+	unlock_device(&dev->dev);
+}
+
+void spipnx_dma_handler (int channel, int cause, void* context, struct pt_regs* pt_regs )
+{
+#ifdef CONFIG_ARCH_PNX4008
+	struct spipnx_driver_data *dd = context;
+
+	if (cause & DMA_TC_INT )
+		complete( &dd->threshold );
+#endif
+}
+
+int spipnx_request_hardware(struct spipnx_driver_data *dd,
+			    struct platform_device *dev)
+{
+	int err = 0;
+	struct resource *rsrc;
+
+	lock_device(&dev->dev);
+	rsrc = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (rsrc) {
+		dd->iostart = rsrc->start;
+		dd->ioend = rsrc->end;
+		dd->spi_regs = ioremap(dd->iostart, SZ_4K);
+		/*
+		if (!request_mem_region
+		    (dd->iostart, dd->ioend - dd->iostart + 1, dev->dev.bus_id))
+			err = -ENODEV;
+		else
+		*/
+			dd->io_flags |= IORESOURCE_MEM;
+	}
+	dd->clk = spipnx_clk_init(dev);
+	if (IS_ERR(dd->clk)) {
+		err = PTR_ERR(dd->clk);
+		goto out;
+	}
+
+	spipnx_clk_start(dd->clk);
+
+	dd->irq = platform_get_irq(dev, 0);
+	if (dd->irq != NO_IRQ) {
+		dd->spi_regs->ier = 0;
+		dd->spi_regs->stat = 0;
+	}
+
+	rsrc = platform_get_resource(dev, IORESOURCE_DMA, 0);
+	if (rsrc) {
+		dd->slave_nr = rsrc->start;
+		err = spipnx_request_dma(&dd->dma_channel, dev->dev.bus_id, spipnx_dma_handler, dd);
+		if (!err)
+			dd->io_flags |= IORESOURCE_DMA;
+	}
+out:
+	unlock_device(&dev.dev);
+	return err;
+}
+
+int __init spipnx_init(void)
+{
+	printk("PNX/SPI bus driver\n");
+	return spi_bus_driver_register(&spipnx_driver);
+}
+
+void __exit spipnx_cleanup(void)
+{
+	spi_bus_driver_unregister(&spipnx_driver);
+}
+
+static int spipnx_spi_init(struct device *bus_device)
+{
+	struct spipnx_driver_data *dd = dev_get_drvdata(bus_device);
+	int timeout;
+	u32 config;
+
+	config = dd->spi_regs->con;
+
+	dd->spi_regs->global = SPIPNX_GLOBAL_RESET_SPI | SPIPNX_GLOBAL_SPI_ON;
+	udelay(10);
+	dd->spi_regs->global = SPIPNX_GLOBAL_SPI_ON;
+	for (timeout = 10000; timeout >= 0; --timeout)
+		if (dd->spi_regs->global & SPIPNX_GLOBAL_SPI_ON)
+			break;
+	if (timeout <= 0)
+		return -1;
+
+	config |= (7<<9);
+	config &= ~(SPIPNX_CON_RXTX);
+	dd->spi_regs->con = config;
+	spipnx_arch_init(dd->saved_clock / 1000, dd->spi_regs);
+	dd->spi_regs->stat |= 0x100;
+	return 0;
+}
+
+void spipnx_control(struct spi_device *device, int type, u32 ctl)
+{
+	spipnx_arch_control(device, type, ctl);
+}
+
+static inline int
+spipnx_xfer_buggy (struct spi_msg *msg)
+{
+	u8* dat;
+	void *buf;
+	int len;
+	struct spi_msg *pmsg;
+	struct spi_device *spidev;
+	struct device *dev;
+	struct spipnx_driver_data *dd;
+	vhblas_spiregs* regs;
+	int i, rc = 0;
+	u32 stat, fc;
+	struct spipnx_dma_transfer_t params;
+	u32 flags = 0;
+
+	if (!msg) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	spidev = spimsg_get_spidev(msg);
+	dev = &spidev->dev;
+	dd = dev_get_drvdata(dev->parent);
+	regs = dd->spi_regs;
+
+	for (pmsg = msg; pmsg; pmsg = spimsg_getnext(pmsg)) {
+		flags = spimsg_get_flags(pmsg);
+		len = spimsg_get_buffer(pmsg, &buf);
+		dat = buf;
+
+		spipnx_control(spidev, MESSAGE_START, flags & SPI_M_CS);
+		if (flags & SPI_M_WR) {
+			regs->con |= SPIPNX_CON_RXTX;
+			regs->ier |= SPIPNX_IER_EOT;
+			regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+			regs->frm = len;
+
+			if (dd->dma_mode && len >= FIFO_CHUNK_SIZE) {
+				params.dma_buffer = dma_map_single(dev->parent, dat, len, DMA_TO_DEVICE);
+				params.saved_ll = NULL;
+				params.saved_ll_dma = 0;
+
+				spipnx_setup_dma(dd->iostart, dd->slave_nr, dd->dma_channel,
+					 DMA_MODE_WRITE, dat, len);
+				init_completion (&dd->threshold);
+				spipnx_start_dma(dd->dma_channel);
+				wait_for_completion (&dd->threshold);
+				spipnx_stop_dma(dd->dma_channel, dat);
+				dma_unmap_single(dev->parent, params.dma_buffer, len, DMA_TO_DEVICE);
+			} else {
+				regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+				for (i = 0; i < len ; i ++ ) {
+					while (regs->stat & 0x04)
+			       			continue;
+					regs->dat = *dat;
+					dat ++;
+				}
+			}
+
+			while ((regs->stat & SPIPNX_STAT_EOT) == 0)
+				continue;
+		}
+
+		if (flags & SPI_M_RD) {
+			int stopped;
+			u8 c;
+
+			regs->con &= ~SPIPNX_CON_RXTX;
+			regs->ier |= SPIPNX_IER_EOT;
+			regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+			regs->frm = len;
+
+			regs->dat = 0;  /* kick off read */
+
+			if (dd->dma_mode && len > FIFO_CHUNK_SIZE - 1) {
+				params.dma_buffer = dma_map_single(dev->parent, dat, len - (FIFO_CHUNK_SIZE - 1), DMA_FROM_DEVICE);
+				params.saved_ll = NULL;
+				params.saved_ll_dma = 0;
+
+				spipnx_setup_dma(dd->iostart, dd->slave_nr, dd->dma_channel,
+					 DMA_MODE_READ, dat, len - (FIFO_CHUNK_SIZE - 1));
+				init_completion (&dd->threshold);
+				spipnx_start_dma(dd->dma_channel);
+				wait_for_completion (&dd->threshold);
+				spipnx_stop_dma(dd->dma_channel, dat);
+				dma_unmap_single(dev->parent, params.dma_buffer, len - (FIFO_CHUNK_SIZE - 1), DMA_FROM_DEVICE);
+				dat = dat + len - (FIFO_CHUNK_SIZE - 1);
+				len = FIFO_CHUNK_SIZE - 1;
+			}
+
+                	stopped = 0;
+	                stat = 0;
+        	        for(i = 0; i < len; ) {
+				unsigned long irq_flags;
+				local_irq_save(irq_flags);
+
+				stat = dd->spi_regs->stat;;
+				fc = dd->spi_regs->frm;
+				/* has hardware finished ? */
+				if(fc == 0) {
+					regs->con |= SPIPNX_CON_SHIFT_OFF;
+					stopped = 1;
+				}
+				/* FIFO not empty and hardware not about to finish */
+				if((!(stat & SPI_STAT_SPI_BE)) && ((fc > 4) || (stopped ))) {
+					*dat++= c = dd->spi_regs->dat;
+					i++;
+				}
+				if((stat & SPI_STAT_SPI_BF) && (!stopped)) {
+					*dat++= c = dd->spi_regs->dat;
+					i++;
+				}
+				local_irq_restore(irq_flags);
+			 }
+		}
+		regs->stat |= SPIPNX_STAT_CLRINT;
+		spipnx_control(spidev, MESSAGE_END, flags & SPI_M_CSREL);
+		spimsg_put_buffer(pmsg, buf);
+	}
+out:
+	return rc;
+}
+
+static inline char *spimsg_flags_str(unsigned flags)
+{
+	static char s[4] = "";
+
+	s[0] = 0;
+	if (flags & SPI_M_RD)
+		strcat(s, "R");
+	if (flags & SPI_M_WR)
+		strcat(s, "W");
+	if (flags & ~(SPI_M_WR | SPI_M_RD))
+		strcat(s, "*");
+	return s;
+}
+
+int spipnx_xfer(struct spi_msg *msg)
+{
+	struct spi_device *dev = spimsg_get_spidev(msg);
+	struct spipnx_driver_data *dd = dev_get_drvdata(dev->dev.parent);
+	int status;
+
+	lock_device(dev->parent);
+	if (!SPIPNX_IS_READY(dd)) {
+		status = -EIO;
+		goto unlock_and_out;
+	}
+
+	dev_dbg(&dev->dev, " message (%s)\n",
+		spimsg_flags_str(spimsg_get_flags(msg)));
+
+	if (spipnx_spi_init(dev->dev.parent) < 0) {
+		dev_dbg(&dev->dev, "spi_init failed, skipping the transfer\n");
+		status = -EFAULT;
+		goto unlock_and_out;
+	}
+
+	dd->progress = 1;
+	status = spipnx_xfer_buggy(msg);
+	dd->progress = 0;
+unlock_and_out:
+	unlock_device(dev->parent);
+	return status;
+}
+
+static int spipnx_suspend(struct device *dev, pm_message_t level)
+{
+	int err = 0;
+#ifdef CONFIG_PM
+	struct spipnx_driver_data *dd = dev_get_drvdata(dev);
+
+	lock_device(dev);
+	spipnx_release_dma(&dd->dma_channel);	/* any sanity checks, eg using DMA,
+						   will be done here */
+	spipnx_clk_stop(dd->clk);
+	dev->power.power_state = level;
+	unlock_device(dev);
+#endif
+	return err;
+}
+
+static int spipnx_resume(struct device *dev)
+{
+	int err = 0;
+#ifdef CONFIG_PM
+	struct spipnx_driver_data *dd = dev_get_drvdata(dev);
+
+	lock_device(dev);
+	spipnx_clk_start(dd->clk);
+	if (dd->slave_nr >= 0)
+		spipnx_request_dma(&dd->dma_channel, dev->bus_id, spipnx_dma_handler, dd);
+	dev->power.power_state = PMSG_ON;
+	unlock_device(dev);
+#endif				/* CONFIG_PM */
+	return err;
+}
+
+EXPORT_SYMBOL(spipnx_set_mode);
+MODULE_AUTHOR("dmitry pervushin <dpervushin@ru.mvista.com>");
+MODULE_DESCRIPTION("SPI driver for Philips' PNX boards");
+MODULE_LICENSE("GPL");
+module_init(spipnx_init);
+module_exit(spipnx_cleanup);
Index: linux-2.6.orig/drivers/spi/spipnx.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/spi/spipnx.h
@@ -0,0 +1,58 @@
+/*
+ * SPI support for pnx010x.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _SPI_PNX_BUS_DRIVER
+#define _SPI_PNX_BUS_DRIVER
+
+#include <asm/arch/platform.h>
+#include <asm/arch/dma.h>
+#include <asm/dma.h>
+#include <asm/arch/spi.h>
+
+/* structures */
+struct spipnx_driver_data {
+	unsigned io_flags;
+
+	int irq;
+
+	int dma_mode;
+	int dma_channel;
+	int slave_nr;
+
+	u32 iostart, ioend;
+	vhblas_spiregs *spi_regs;
+
+	struct clk *clk;
+	int clk_id[4];
+
+	int state;
+	u32 saved_clock;
+
+	struct completion op_complete;
+	struct completion threshold;
+
+	int progress;
+
+	void (*control) (struct spi_device * dev, int code, u32 ctl);
+};
+
+#define SPIPNX_STATE_UNINITIALIZED 0
+#define SPIPNX_STATE_READY         1
+#define SPIPNX_STATE_SUSPENDED     2
+
+#define SPIPNX_IS_READY( bus )  ( (bus)->state == SPIPNX_STATE_READY )
+
+#define FIFO_CHUNK_SIZE		56
+
+#define SPI_ENDIAN_SWAP_NO                 0
+#define SPI_ENDIAN_SWAP_YES                1
+
+#endif				// __SPI_PNX_BUS_DRIVER
