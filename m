Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVLWOO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVLWOO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbVLWOO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:14:27 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:57050 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030530AbVLWOO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:14:26 -0500
Date: Fri, 23 Dec 2005 17:15:06 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: david-b@pacbell.net
Cc: spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] SPI: add support for PNX/SPI controller
Message-Id: <20051223171506.76aba97a.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
inlined is a pretty much _development_ version of the Philips SPI controller support we're working with on some Philips ARM targets (PNX0106 and PNX4008, namely) based on spi_bitbang library from David Brownell. It's quite a notable thing that this buggy and in some way complicated SPI controller fits well in this bitbang framework! :)
This patch also contains dumb EEPROM driver for the onboard EEPROM behind the SPI bus. This driver was used by us for controller driver testing, mainly.

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: Dmitry Pervusin <dpervushin@gmail.com>

 drivers/spi/Kconfig                |    8
 drivers/spi/Makefile               |    2
 drivers/spi/eeprom.c               |  127 ++++++++++++
 drivers/spi/spi_pnx.c              |  365 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi_pnx.h              |   60 ++++++
 include/asm-arm/arch-pnx4008/spi.h |  370 +++++++++++++++++++++++++++++++++++++
 6 files changed, 932 insertions(+)

Index: linux-2.6/drivers/spi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/spi/Kconfig
+++ linux-2.6/drivers/spi/Kconfig
@@ -95,6 +95,14 @@ config SPI_BUTTERFLY
 # Add new SPI master controllers in alphabetical order above this line
 #
 
+config SPI_PNX
+	tristate "PNX SPI bus support"
+	depends on ARCH_PNX4008 && SPI_BITBANG
+
+config SPI_EEPROM
+	tristate "SPI EEPROM"
+	depends on SPI
+
 
 #
 # There are lots of SPI device types, with sensors and memory
Index: linux-2.6/drivers/spi/Makefile
===================================================================
--- linux-2.6.orig/drivers/spi/Makefile
+++ linux-2.6/drivers/spi/Makefile
@@ -13,9 +13,11 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
+obj-$(CONFIG_SPI_PNX)			+= spi_pnx.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
+obj-$(CONFIG_SPI_EEPROM)		+= eeprom.o
 # 	... add above this line ...
 
 # SPI slave controller drivers (upstream link)
Index: linux-2.6/drivers/spi/eeprom.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/spi/eeprom.c
@@ -0,0 +1,127 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
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
+	struct spi_device *spi = to_spi_device(d);
+	char cmd[2];
+	struct spi_transfer t[2] = {
+		[0] = {
+			.tx_buf = cmd,
+			.len = sizeof cmd,
+		},
+		[1] = {
+			.rx_buf = block,
+			.len = 256,
+		},
+	};
+	DECLARE_SPI_MESSAGE(m);
+
+	cmd[ 0 ] = 0x03;
+	cmd[ 1 ] = 0x00;
+	list_add_tail(&t[0].link, &m.transfers);
+	list_add_tail(&t[1].link, &m.transfers);
+
+	spi_sync(spi, &m);
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
+		   .name	= DRIVER_NAME,
+		   .bus		= &spi_bus_type,
+		   .owner	= THIS_MODULE,
+	},
+	.probe = spiee_probe,
+	.remove = __devexit_p(spiee_remove),
+};
+
+static int __init spi_eeprom_init(void)
+{
+	int rc = spi_register_driver(&eeprom_driver);
+	printk("%s: %d\n", __FUNCTION__, rc);
+	return rc;
+}
+static void __exit spi_eeprom_cleanup(void)
+{
+	spi_unregister_driver(&eeprom_driver);
+}
+
+module_init(spi_eeprom_init);
+module_exit(spi_eeprom_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@gmail.com>");
+MODULE_DESCRIPTION("SPI EEPROM driver");
Index: linux-2.6/drivers/spi/spi_pnx.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/spi/spi_pnx.c
@@ -0,0 +1,365 @@
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
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <asm/io.h>
+
+#include "spi_pnx.h"
+
+#define lock_device( dev )	/* down( &dev->sem ); */
+#define unlock_device( dev )	/* up( &dev->sem );   */
+
+void spipnx_dma_handler (int channel, int cause, void* context, struct pt_regs* pt_regs )
+{
+	struct spi_pnx_data *dd = context;
+
+	if (cause & DMA_TC_INT)
+		complete(&dd->threshold);
+}
+
+int spipnx_request_hardware(struct spi_pnx_data *dd,
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
+static void spipnx_free_hardware(struct spi_pnx_data *dd,
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
+static void
+spi_pnx_chipselect(struct spi_device *spi, int is_on)
+{
+	spipnx_arch_cs(spi, is_on);
+}
+
+static int spi_pnx_xfer(struct spi_device *spidev, struct spi_transfer *t)
+{
+	u8* dat;
+	int len;
+	struct device *dev;
+	struct spi_pnx_data *dd;
+	vhblas_spiregs* regs;
+	int i;
+	u32 stat, fc, con, timeout;
+	struct spipnx_dma_transfer_t params;
+
+	dev = &spidev->dev;
+	dd = dev_get_drvdata(spidev->master->cdev.dev);
+	regs = dd->spi_regs;
+	len = t->len;
+
+	/* REVISIT */
+	con = regs->con;
+	regs->global = SPI_GLOBAL_BLRES_SPI | SPI_GLOBAL_SPI_ON;
+	udelay(10);
+	regs->global = SPI_GLOBAL_SPI_ON;
+	for (timeout = 10000; timeout >= 0; --timeout)
+		if (dd->spi_regs->global & SPIPNX_GLOBAL_SPI_ON)
+			break;
+	con |= (7<<9);
+	con &= ~(SPIPNX_CON_RXTX);
+	regs->con = con;
+
+	if (spidev->max_speed_hz)
+		spi_pnx_set_clock_rate(spidev->max_speed_hz / 1000, regs);
+
+	regs->stat |= 0x100;
+	regs->con |= SPI_CON_SPI_BIDIR | SPI_CON_SPI_BHALT | SPI_CON_SPI_BPOL |
+		SPI_CON_THR | SPI_CON_MS;
+
+	if (t->tx_buf) {
+		dat = (u8 *)t->tx_buf;
+		regs->con |= SPIPNX_CON_RXTX;
+		regs->ier |= SPIPNX_IER_EOT;
+		regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+		regs->frm = len;
+
+		if (dd->dma_mode && len >= FIFO_CHUNK_SIZE) {
+			void *dmasafe = NULL;
+			if (t->tx_dma)
+				params.dma_buffer = t->tx_dma;
+			else {
+				dmasafe = kmalloc(len, SLAB_KERNEL);
+				if (!dmasafe) {
+					len = 0;
+					goto out;
+				}
+				params.dma_buffer = dma_map_single(dev->parent, dmasafe, len, DMA_TO_DEVICE);
+				memcpy(dmasafe, dat, len);
+			}
+			params.saved_ll = NULL;
+			params.saved_ll_dma = 0;
+
+			spipnx_setup_dma(dd->iostart, dd->slave_nr, dd->dma_channel,
+				 DMA_MODE_WRITE, &params, len);
+			init_completion (&dd->threshold);
+			spipnx_start_dma(dd->dma_channel);
+			wait_for_completion (&dd->threshold);
+			spipnx_stop_dma(dd->dma_channel, &params);
+			if (dmasafe) {
+				dma_unmap_single(dev->parent, params.dma_buffer, len, DMA_TO_DEVICE);
+				kfree(dmasafe);
+			}
+		} else {
+			regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+			for (i = 0; i < len ; i ++ ) {
+				while (regs->stat & 0x04)
+		       			continue;
+				regs->dat = *dat;
+				dat ++;
+			}
+		}
+		while ((regs->stat & SPIPNX_STAT_EOT) == 0)
+			continue;
+	}
+
+	if (t->rx_buf) {
+		int stopped;
+		u8 c;
+		void *dmasafe = NULL;
+
+		dat = t->rx_buf;
+		regs->con &= ~SPIPNX_CON_RXTX;
+		regs->ier |= SPIPNX_IER_EOT;
+		regs->con &= ~SPIPNX_CON_SHIFT_OFF;
+		regs->frm = len;
+
+		regs->dat = 0;  /* kick off read */
+
+		if (dd->dma_mode && len > FIFO_CHUNK_SIZE - 1) {
+			if (t->rx_dma)
+				params.dma_buffer = t->rx_dma;
+			else {
+				dmasafe = kmalloc(len, SLAB_KERNEL);
+				if (!dmasafe) {
+					len = 0;
+					goto out;
+				}
+				params.dma_buffer = dma_map_single(dev->parent, dmasafe, len - (FIFO_CHUNK_SIZE - 1), DMA_FROM_DEVICE);
+			}
+			params.saved_ll = NULL;
+			params.saved_ll_dma = 0;
+
+			spipnx_setup_dma(dd->iostart, dd->slave_nr, dd->dma_channel,
+				 DMA_MODE_READ, &params, len - (FIFO_CHUNK_SIZE - 1));
+			init_completion (&dd->threshold);
+			spipnx_start_dma(dd->dma_channel);
+			wait_for_completion (&dd->threshold);
+			spipnx_stop_dma(dd->dma_channel, &params);
+			if (dmasafe) {
+				memcpy(dat, dmasafe, len - (FIFO_CHUNK_SIZE - 1));
+				dma_unmap_single(dev->parent, params.dma_buffer, len - (FIFO_CHUNK_SIZE - 1), DMA_FROM_DEVICE);
+				kfree(dmasafe);
+			}
+			dat = dat + len - (FIFO_CHUNK_SIZE - 1);
+			len = FIFO_CHUNK_SIZE - 1;
+		}
+
+               	stopped = 0;
+                stat = 0;
+       	        for(i = 0; i < len; ) {
+			unsigned long irq_flags;
+			local_irq_save(irq_flags);
+
+			stat = dd->spi_regs->stat;;
+			fc = dd->spi_regs->frm;
+			/* has hardware finished ? */
+			if(fc == 0) {
+				regs->con |= SPIPNX_CON_SHIFT_OFF;
+				stopped = 1;
+			}
+			/* FIFO not empty and hardware not about to finish */
+			if((!(stat & SPI_STAT_SPI_BE)) && ((fc > 4) || (stopped ))) {
+				*dat++= c = dd->spi_regs->dat;
+				i++;
+			}
+			if((stat & SPI_STAT_SPI_BF) && (!stopped)) {
+				*dat++= c = dd->spi_regs->dat;
+				i++;
+			}
+			local_irq_restore(irq_flags);
+		 }
+	}
+out:
+	return len;
+}
+
+static int spi_pnx_setup(struct spi_device *spi)
+{
+	return 0;
+}
+
+static int spi_pnx_probe(struct device *device)
+{
+	struct spi_master	*master;
+	struct spi_pnx_data	*data;
+	struct spi_bitbang	*pnx;
+	int rc = 0;
+
+	printk("spi probe called\n");
+	master = spi_alloc_master(device, sizeof *data);
+	if (!master) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	master->setup = &spi_pnx_setup;
+	master->bus_num = to_platform_device(device)->id;
+
+	pnx = spi_master_get_devdata(master);
+	pnx->master = master;
+	pnx->chipselect = &spi_pnx_chipselect;
+	pnx->txrx_bufs = &spi_pnx_xfer;
+	rc = spi_bitbang_start(pnx);
+	if (rc < 0)
+		goto out;
+
+	data = kzalloc(sizeof *data, GFP_KERNEL);
+	if (!data) {
+		spi_bitbang_stop(pnx);
+		kfree(master);
+		rc = -ENOMEM;
+		goto out;
+	}
+	data->dma_channel = -1;
+	data->slave_nr = -1;
+	data->irq = NO_IRQ;
+	data->master = master;
+	data->dma_mode = 1;
+	dev_set_drvdata(device, data);
+
+	rc = spipnx_request_hardware(data, to_platform_device(device));
+	if (rc < 0) {
+		spi_bitbang_stop(pnx);
+		kfree(master);
+		kfree(data);
+		goto out;
+	}
+out:
+	return rc;
+}
+
+static int spi_pnx_remove(struct device *device)
+{
+	struct spi_pnx_data *data = dev_get_drvdata(device);
+	struct spi_bitbang *pnx;
+
+	pnx = spi_master_get_devdata(data->master);
+
+	spipnx_free_hardware(data, to_platform_device(device));
+	spi_bitbang_stop(pnx);
+	kfree(data->master);
+	kfree(data);
+	return 0;
+}
+
+
+static struct device_driver spi_pnx_driver = {
+	.name 		= "spipnx",
+	.bus		= &platform_bus_type,
+	.probe		= spi_pnx_probe,
+	.remove		= spi_pnx_remove,
+};
+
+static int __init spi_pnx_init(void)
+{
+	return driver_register(&spi_pnx_driver);
+}
+
+static void __exit spi_pnx_cleanup(void)
+{
+	driver_unregister(&spi_pnx_driver);
+}
+
+module_init(spi_pnx_init);
+module_exit(spi_pnx_cleanup);
Index: linux-2.6/include/asm-arm/arch-pnx4008/spi.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-arm/arch-pnx4008/spi.h
@@ -0,0 +1,370 @@
+/*
+ * include/asm-arm/arch-pnx4008/spi.h
+ *
+ * Author: Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * PNX4008-specific tweaks for SPI block
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __ASM_ARCH_SPI_H__
+#define __ASM_ARCH_SPI_H__
+
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+#include <asm/dma.h>
+
+#include <asm/arch/dma.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/pm.h>
+#include <asm/arch/gpio.h>
+
+#include <asm/hardware/clock.h>
+
+#define SPI_ADR_OFFSET_GLOBAL              0x0000	/* R/W - Global control register */
+#define SPI_ADR_OFFSET_CON                 0x0004	/* R/W - Control register */
+#define SPI_ADR_OFFSET_FRM                 0x0008	/* R/W - Frame count register */
+#define SPI_ADR_OFFSET_IER                 0x000C	/* R/W - Interrupt enable register */
+#define SPI_ADR_OFFSET_STAT                0x0010	/* R/W - Status register */
+#define SPI_ADR_OFFSET_DAT                 0x0014	/* R/W - Data register */
+#define SPI_ADR_OFFSET_DAT_MSK             0x0018	/*  W  - Data register for using mask mode */
+#define SPI_ADR_OFFSET_MASK                0x001C	/* R/W - Mask register */
+#define SPI_ADR_OFFSET_ADDR                0x0020	/* R/W - Address register */
+#define SPI_ADR_OFFSET_TIMER_CTRL_REG      0x0400	/* R/W - IRQ timer control register */
+#define SPI_ADR_OFFSET_TIMER_COUNT_REG     0x0404	/* R/W - Timed interrupt period register */
+#define SPI_ADR_OFFSET_TIMER_STATUS_REG    0x0408	/* R;R/C - RxDepth and interrupt status register */
+
+/* Bit definitions for SPI_GLOBAL register */
+#define SPI_GLOBAL_BLRES_SPI               0x00000002	/*  R/W - Software reset, active high */
+#define SPI_GLOBAL_SPI_ON                  0x00000001	/* R/W - SPI interface on */
+
+/* Bit definitions for SPI_CON register */
+#define SPI_CON_SPI_BIDIR                  0x00800000	/* R/W - SPI data in bidir. mux */
+#define SPI_CON_SPI_BHALT                  0x00400000	/* R/W - Halt control */
+#define SPI_CON_SPI_BPOL                   0x00200000	/* R/W - Busy signal active polarity */
+#define SPI_CON_SPI_SHFT                   0x00100000	/* R/W - Data shifting enable in mask mode */
+#define SPI_CON_SPI_MSB                    0x00080000	/* R/W - Transfer LSB or MSB first */
+#define SPI_CON_SPI_EN                     0x00040000	/* R/W - SPULSE signal enable */
+#define SPI_CON_SPI_MODE                   0x00030000	/* R/W - SCK polarity and phase modes */
+#define SPI_CON_SPI_MODE3                  0x00030000	/* R/W - SCK polarity and phase mode 3 */
+#define SPI_CON_SPI_MODE2                  0x00020000	/* R/W - SCK polarity and phase mode 2 */
+#define SPI_CON_SPI_MODE1                  0x00010000	/* R/W - SCK polarity and phase mode 1 */
+#define SPI_CON_SPI_MODE0                  0x00000000	/* R/W - SCK polarity and phase mode 0 */
+#define SPI_CON_RxTx                       0x00008000	/* R/W - Transfer direction */
+#define SPI_CON_THR                        0x00004000	/* R/W - Threshold selection */
+#define SPI_CON_SHIFT_OFF                  0x00002000	/* R/W - Inhibits generation of clock pulses on sck_spi pin */
+#define SPI_CON_BITNUM                     0x00001E00	/* R/W - No of bits to tx or rx in one block transfer */
+#define SPI_CON_CS_EN                      0x00000100	/* R/W - Disable use of CS in slave mode */
+#define SPI_CON_MS                         0x00000080	/* R/W - Selection of master or slave mode */
+#define SPI_CON_RATE                       0x0000007F	/* R/W - Transmit/receive rate */
+
+#define SPI_CON_RATE_0                     0x00
+#define SPI_CON_RATE_1                     0x01
+#define SPI_CON_RATE_2                     0x02
+#define SPI_CON_RATE_3                     0x03
+#define SPI_CON_RATE_4                     0x04
+#define SPI_CON_RATE_13                     0x13
+
+/* Bit definitions for SPI_FRM register */
+#define SPI_FRM_SPIF                       0x0000FFFF	/* R/W - Number of frames to be transfered */
+
+/* Bit definitions for SPI_IER register */
+#define SPI_IER_SPI_INTCS                  0x00000004	/* R/W - SPI CS level change interrupt enable  */
+#define SPI_IER_SPI_INTEOT                 0x00000002	/* R/W - End of transfer interrupt enable */
+#define SPI_IER_SPI_INTTHR                 0x00000001	/* R/W - FIFO threshold interrupt enable */
+
+/* Bit definitions for SPI_STAT register */
+#define SPI_STAT_SPI_INTCLR                0x00000100	/* R/WC - Clear interrupt */
+#define SPI_STAT_SPI_EOT                   0x00000080	/* R/W - End of transfer */
+#define SPI_STAT_SPI_BSY_SL                0x00000040	/* R/W - Status of the input pin spi_busy */
+#define SPI_STAT_SPI_CSL                   0x00000020	/* R/W - Indication of the edge on SPI_CS that caused an int.  */
+#define SPI_STAT_SPI_CSS                   0x00000010	/* R/W - Level of SPI_CS has changed in slave mode */
+#define SPI_STAT_SPI_BUSY                  0x00000008	/* R/W - A data transfer is ongoing  */
+#define SPI_STAT_SPI_BF                    0x00000004	/* R/W - FIFO is full */
+#define SPI_STAT_SPI_THR                   0x00000002	/* R/W - No of entries in Tx/Rx FIFO */
+#define SPI_STAT_SPI_BE                    0x00000001	/* R/W - FIFO is empty */
+
+/* Bit definitions for SPI_DAT register */
+#define SPI_DAT_SPID                       0x0000FFFF	/* R/W - SPI data bits  */
+
+/* Bit definitions for SPI_DAT_MSK register */
+#define SPI_DAT_MSK_SPIDM                  0x0000FFFF	/*  W  - SPI data bits to send using the masking mode */
+
+/* Bit definitions for SPI_MASK register */
+#define SPI_MASK_SPIMSK                    0x0000FFFF	/* R/W - Masking bits used for validating data bits */
+
+/* Bit definitions for SPI_ADDR register */
+#define SPI_ADDR_SPIAD                     0x0000FFFF	/* R/W - Address bits to add to the data bits */
+
+/* Bit definitions for SPI_TIMER_CTRL_REG register */
+#define SPI_TIMER_CTRL_REG_TIRQE           0x00000004	/* R/W - Timer interrupt enable */
+#define SPI_TIMER_CTRL_REG_PIRQE           0x00000002	/* R/W - Peripheral interrupt enable */
+#define SPI_TIMER_CTRL_REG_MODE            0x00000001	/* R/W - Mode */
+
+/* Bit definitions for SPI_TIMER_COUNT_REG register */
+#define SPI_TIMER_COUNT_REG                0x0000FFFF	/* R/W - Timed interrupt period */
+
+/* Bit definitions for SPI_TIMER_STATUS_REG register */
+#define SPI_TIMER_STATUS_REG_INT_STAT      0x00008000	/* R/C - Interrupt status */
+#define SPI_TIMER_STATUS_REG_FIFO_DEPTH    0x0000007F	/*  R  - FIFO depth value (for debug purpose) */
+
+#define SPIPNX_STAT_EOT SPI_STAT_SPI_EOT
+#define SPIPNX_STAT_THR SPI_STAT_SPI_THR
+#define SPIPNX_IER_EOT SPI_IER_SPI_INTEOT
+#define SPIPNX_IER_THR SPI_IER_SPI_INTTHR
+#define SPIPNX_STAT_CLRINT SPI_STAT_SPI_INTCLR
+
+#define SPIPNX_GLOBAL_RESET_SPI SPI_GLOBAL_BLRES_SPI
+#define SPIPNX_GLOBAL_SPI_ON 	SPI_GLOBAL_SPI_ON
+#define SPIPNX_CON_MS		SPI_CON_MS
+#define SPIPNX_CON_BIDIR	SPI_CON_SPI_BIDIR
+#define SPIPNX_CON_RXTX		SPI_CON_RxTx
+#define SPIPNX_CON_THR		SPI_CON_THR
+#define SPIPNX_CON_SHIFT_OFF	SPI_CON_SHIFT_OFF
+#define SPIPNX_DATA		SPI_ADR_OFFSET_DAT
+#define SPI_PNX4008_CLOCK_IN  	104000000
+#define SPI_PNX4008_CLOCK 	2670000
+#define SPIPNX_CLOCK ((((SPI_PNX4008_CLOCK_IN / SPI_PNX4008_CLOCK) - 2) / 2) & SPI_CON_RATE_MASK )
+#define SPIPNX_DATA_REG(s) ( (u32)(s) + SPIPNX_DATA )
+
+typedef volatile struct {
+	u32 global;		/* 0x000             */
+	u32 con;		/* 0x004             */
+	u32 frm;		/* 0x008             */
+	u32 ier;		/* 0x00C             */
+	u32 stat;		/* 0x010             */
+	u32 dat;		/* 0x014             */
+	u32 dat_msk;		/* 0x018             */
+	u32 mask;		/* 0x01C             */
+	u32 addr;		/* 0x020             */
+	u32 _d0[(SPI_ADR_OFFSET_TIMER_CTRL_REG -
+		 (SPI_ADR_OFFSET_ADDR + sizeof(u32))) / sizeof(u32)];
+	u32 timer_ctrl;		/* 0x400             */
+	u32 timer_count;	/* 0x404             */
+	u32 timer_status;	/* 0x408             */
+}
+vhblas_spiregs, *pvhblas_spiregs;
+
+#define SPI_CON_RATE_MASK			0x7f
+
+static void spipnx_arch_set_clock_rate( int clock_khz, int ref_clock_khz, vhblas_spiregs* regs )
+{
+	u32 spi_clock;
+
+	printk( "ref clock = %d, requested clock = %d\n", ref_clock_khz, clock_khz);
+	if(!clock_khz)
+		spi_clock = ref_clock_khz < 104000 ? 0 : 1;
+	else
+		spi_clock = (ref_clock_khz/1000) / (2*(clock_khz/1000) + 2);
+	regs->con &= ~SPI_CON_RATE_MASK;
+	printk("SPI clock = %x\n", spi_clock);
+	regs->con |= spi_clock;
+}
+
+static inline void spi_pnx_set_clock_rate(int saved_clock_khz, vhblas_spiregs *regs)
+{
+	struct clk *div_clk= clk_get(0, "hclk_ck");
+	struct clk *arm_clk = clk_get(0, "ck_pll4");
+	if (!IS_ERR(arm_clk) && !IS_ERR(div_clk))
+		spipnx_arch_set_clock_rate(
+			saved_clock_khz,
+			clk_get_rate(arm_clk) / clk_get_rate(div_clk),
+			regs);
+	if (!IS_ERR(arm_clk))
+		clk_put(arm_clk);
+	if (!IS_ERR(div_clk))
+		clk_put(div_clk);
+}
+
+static inline void spipnx_clk_stop(void *clk_data)
+{
+	struct clk *clk = (struct clk *)clk_data;
+	if (clk && !IS_ERR(clk)) {
+		clk_set_rate(clk, 0);
+		clk_put(clk);
+	}
+}
+
+static inline void spipnx_clk_start(void *clk_data)
+{
+	struct clk *clk = (struct clk *)clk_data;
+	if (clk && !IS_ERR(clk)) {
+		clk_set_rate(clk, 1);
+		clk_put(clk);
+	}
+}
+
+static inline void *spipnx_clk_init(struct platform_device *dev)
+{
+	struct clk *clk = clk_get(0, dev->id == 1 ? "spi0_ck" : "spi1_ck");
+	if (IS_ERR(clk))
+		printk("spi%d_ck pointer err\n", dev->id);
+	return clk;
+}
+
+static inline void spipnx_clk_free( void* clk )
+{
+	clk_put( clk );
+}
+
+static inline void spipnx_arch_cs(struct spi_device *spi, int is_on)
+{
+	switch (spi->chip_select)
+	{
+	case 0:
+		printk("setting pin %x to %d\n", GPO_02, !is_on);
+		pnx4008_gpio_write_pin(GPO_02, !is_on);
+		break;
+	case 1:
+		printk( "setting pin %x to %d\n", GPIO_03, !is_on);
+		pnx4008_gpio_write_pin(GPIO_03, !is_on);
+		break;
+	}
+}
+
+static inline int spipnx_request_dma(
+		int *dma_channel, char *name,
+		void (*handler)( int, int, void*, struct pt_regs*),
+		void *dma_context)
+{
+	int err;
+
+	if (*dma_channel != -1) {
+		err = *dma_channel;
+		goto out;
+	}
+	err = pnx4008_request_channel(name, -1, handler, dma_context);
+	if (err >= 0) {
+		*dma_channel = err;
+	}
+out:
+	return err < 0 ? err : 0;
+}
+
+static inline void spipnx_release_dma(int *dma_channel)
+{
+	if (*dma_channel >= 0) {
+		pnx4008_free_channel(*dma_channel);
+	}
+	*dma_channel = -1;
+}
+
+static inline void spipnx_start_dma(int dma_channel)
+{
+	pnx4008_dma_ch_enable(dma_channel);
+}
+
+struct spipnx_dma_transfer_t
+{
+	dma_addr_t dma_buffer;
+	void *saved_ll;
+	u32 saved_ll_dma;
+};
+
+static inline void spipnx_stop_dma(int dma_channel, void* dev_buf)
+{
+	struct spipnx_dma_transfer_t *buf = dev_buf;
+
+	pnx4008_dma_ch_disable(dma_channel);
+	if (buf->saved_ll) {
+		pnx4008_free_ll(buf->saved_ll_dma, buf->saved_ll);
+		buf->saved_ll = NULL;
+	}
+}
+
+static inline int spipnx_setup_dma(u32 iostart, int slave_nr, int dma_channel,
+				int mode, void* params, int len)
+{
+	int err = 0;
+	struct spipnx_dma_transfer_t *buff = params;
+
+	pnx4008_dma_config_t cfg;
+	pnx4008_dma_ch_config_t ch_cfg;
+	pnx4008_dma_ch_ctrl_t ch_ctrl;
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	if (mode == DMA_MODE_READ) {
+		cfg.dest_addr = buff->dma_buffer; /* buff->dma_buffer; */
+		cfg.src_addr = (u32) SPIPNX_DATA_REG(iostart);
+		ch_cfg.flow_cntrl = FC_PER2MEM_DMA;
+		ch_cfg.src_per = slave_nr;
+		ch_cfg.dest_per = 0;
+		ch_ctrl.di = 1;
+		ch_ctrl.si = 0;
+	} else if (mode == DMA_MODE_WRITE) {
+		cfg.src_addr = buff->dma_buffer; /* buff->dma_buffer; */
+		cfg.dest_addr = (u32) SPIPNX_DATA_REG(iostart);
+		ch_cfg.flow_cntrl = FC_MEM2PER_DMA;
+		ch_cfg.dest_per = slave_nr;
+		ch_cfg.src_per = 0;
+		ch_ctrl.di = 0;
+		ch_ctrl.si = 1;
+	} else {
+		err = -EINVAL;
+	}
+
+	ch_cfg.halt = 0;
+	ch_cfg.active = 1;
+	ch_cfg.lock = 0;
+	ch_cfg.itc = 1;
+	ch_cfg.ie = 1;
+	ch_ctrl.tc_mask = 1;
+	ch_ctrl.cacheable = 0;
+	ch_ctrl.bufferable = 0;
+	ch_ctrl.priv_mode = 1;
+	ch_ctrl.dest_ahb1 = 0;
+	ch_ctrl.src_ahb1 = 0;
+	ch_ctrl.dwidth = WIDTH_BYTE;
+	ch_ctrl.swidth = WIDTH_BYTE;
+	ch_ctrl.dbsize = 1;
+	ch_ctrl.sbsize = 1;
+	ch_ctrl.tr_size = len;
+	if (0 > (err = pnx4008_dma_pack_config(&ch_cfg, &cfg.ch_cfg))) {
+		goto out;
+	}
+	if (0 > (err = pnx4008_dma_pack_control(&ch_ctrl, &cfg.ch_ctrl))) {
+		if ( err == -E2BIG ) {
+			printk( KERN_DEBUG"buffer is too large, splitting\n" );
+			pnx4008_dma_split_head_entry(&cfg, &ch_ctrl);
+			buff->saved_ll = cfg.ll;
+			buff->saved_ll_dma = cfg.ll_dma;
+			err = 0;
+		} else {
+			goto out;
+		}
+	}
+	err = pnx4008_config_channel(dma_channel, &cfg);
+out:
+	return err;
+}
+
+static inline void spipnx_start_event_init(int id)
+{
+	int se = id==0 ? SE_SPI1_DATAIN_INT : SE_SPI2_DATAIN_INT;
+
+	/*setup wakeup interrupt*/
+	start_int_set_rising_edge(se);
+	start_int_ack(se);
+	start_int_umask(se);
+}
+
+static inline void spipnx_start_event_deinit(int id)
+{
+	int se = id==0 ? SE_SPI1_DATAIN_INT : SE_SPI2_DATAIN_INT;
+
+	start_int_mask(se);
+}
+
+struct spipnx_wifi_params {
+	int gpio_cs_line;
+};
+
+#endif /* __ASM_ARCH_SPI_H___ */
+
Index: linux-2.6/drivers/spi/spi_pnx.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/spi/spi_pnx.h
@@ -0,0 +1,60 @@
+/*
+ * SPI support for Philips SPI bus on PNX's.
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
+#include <linux/spi/spi.h>
+#include <asm/arch/platform.h>
+#include <asm/arch/dma.h>
+#include <asm/dma.h>
+#include <asm/arch/spi.h>
+
+/* structures */
+struct spi_pnx_data {
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
+	struct spi_master *master;
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
