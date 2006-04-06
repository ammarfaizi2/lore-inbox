Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWDFScX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWDFScX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDFScW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:32:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:18099 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932227AbWDFScW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:32:22 -0400
Date: Thu, 6 Apr 2006 13:30:40 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: david-b@pacbell.net
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <spi-devel-general@lists.sourceforge.net>
Subject: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI
 controller
Message-ID: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports the SPI controller on the MPC83xx SoC devices from Freescale.
Note, this driver supports only the simple shift register SPI controller and not
the descriptor based CPM or QUICCEngine SPI controller.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit bb0fc026ee00c413125fad3e6b3bb18c10aacd55
tree 4e24181f85ed0fac042605a0af3175511f3695ed
parent bc33ba02f8414e91a3b2afa877be2c54d6fce564
author Kumar Gala <galak@kernel.crashing.org> Thu, 06 Apr 2006 13:30:17 -0500
committer Kumar Gala <galak@kernel.crashing.org> Thu, 06 Apr 2006 13:30:17 -0500

 drivers/spi/Kconfig         |   10 +
 drivers/spi/Makefile        |    1 
 drivers/spi/spi_mpc83xx.c   |  349 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsl_devices.h |   11 +
 4 files changed, 371 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7a75fae..af937bc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -75,6 +75,16 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_MPC83xx
+	tristate "Freescale MPC83xx SPI controller"
+	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
+	select SPI_BITBANG
+	help
+	  This enables using the Freescale MPC83xx SPI controller in master mode.
+	  Note, this driver uniquely supports the SPI controller on the MPC83xx
+	  family of PowerPC processors.  The MPC83xx uses a simple set of shift
+	  registers for data (opposed to the CPM based descriptor model).
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c2c87e8..502ac0b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
+obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
new file mode 100644
index 0000000..a18e768
--- /dev/null
+++ b/drivers/spi/spi_mpc83xx.c
@@ -0,0 +1,349 @@
+/*
+ * MPC83xx SPI controller driver.
+ *
+ * Maintainer: Kumar Gala
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/platform_device.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+
+/* SPI Controller register offsets */
+#define	SPMODE_REG	0x20
+#define	SPIE_REG	0x24
+#define	SPIM_REG	0x28
+#define	SPCOM_REG	0x2C
+#define	SPITD_REG	0x30
+#define	SPIRD_REG	0x34
+
+/* SPI Controller mode register definitions */
+#define	SPMODE_CI_INACTIVEHIGH	(1 << 29)
+#define	SPMODE_CP_RISE_EDGECLK	(1 << 28)
+#define	SPMODE_DIV16		(1 << 27)
+#define	SPMODE_REV		(1 << 26)
+#define	SPMODE_MS		(1 << 25)
+#define	SPMODE_ENABLE		(1 << 24)
+#define	SPMODE_LEN(x)		((x) << 20)
+#define	SPMODE_PM(x)		((x) << 16)
+
+/* Default for SPI Mode, slowest speed, MSB, inactive high, 8-bit char */
+#define	SPMODE_INIT_VAL (SPMODE_CI_INACTIVEHIGH | SPMODE_CP_RISE_EDGECLK | \
+			 SPMODE_DIV16 | SPMODE_REV | SPMODE_MS | \
+			 SPMODE_LEN(7) | SPMODE_PM(0xf))
+
+/* SPIE register values */
+#define	SPIE_NE		0x00000200	/* Not empty */
+#define	SPIE_NF		0x00000100	/* Not full */
+
+/* SPIM register values */
+#define	SPIM_NE		0x00000200	/* Not empty */
+#define	SPIM_NF		0x00000100	/* Not full */
+
+/* SPI Controller driver's private data. */
+struct mpc83xx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion tx_done, rx_ready;
+
+	u32 __iomem *base;
+	u32 irq;
+
+	u32 rx_data;
+
+	u32 sysclk;
+	void (*activate_cs) (u8 cs, u8 polarity);
+	void (*deactivate_cs) (u8 cs, u8 polarity);
+};
+
+static inline void mpc83xx_spi_write_reg(__be32 * base, u32 reg, u32 val)
+{
+	out_be32(base + (reg >> 2), val);
+}
+
+static inline u32 mpc83xx_spi_read_reg(__be32 * base, u32 reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static
+int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct mpc83xx_spi *mpc83xx_spi;
+	u32 regval;
+	u32 len = t->bits_per_word - 1;
+
+	if (len == 32)
+		len = 0;
+
+	mpc83xx_spi = spi_master_get_devdata(spi->master);
+	regval = mpc83xx_spi_read_reg(mpc83xx_spi->base, SPMODE_REG);
+
+	/* Mask out length */
+	regval &= 0xff0fffff;
+	regval |= SPMODE_LEN(len);
+
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPMODE_REG, regval);
+
+	return spi_bitbang_setup_transfer(spi, t);
+}
+
+static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
+{
+	struct mpc83xx_spi *mpc83xx_spi;
+	u8 pol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+
+	mpc83xx_spi = spi_master_get_devdata(spi->master);
+
+	if (value == BITBANG_CS_INACTIVE) {
+		if (mpc83xx_spi->deactivate_cs)
+			mpc83xx_spi->deactivate_cs(spi->chip_select, pol);
+	}
+
+	if (value == BITBANG_CS_ACTIVE) {
+		u32 regval =
+		    mpc83xx_spi_read_reg(mpc83xx_spi->base, SPMODE_REG);
+		u32 len = spi->bits_per_word - 1;
+		if (len == 32)
+			len = 0;
+
+		/* mask out bits we are going to set */
+		regval &= ~0x38ff0000;
+
+		if (spi->mode & SPI_CPHA)
+			regval |= SPMODE_CP_RISE_EDGECLK;
+		if ((spi->mode & SPI_CPOL) == 0)
+			regval |= SPMODE_CI_INACTIVEHIGH;
+
+		regval |= SPMODE_LEN(len);
+
+		if ((mpc83xx_spi->sysclk / spi->max_speed_hz) >= 64) {
+			u8 pm = mpc83xx_spi->sysclk / (spi->max_speed_hz * 64);
+			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
+		} else {
+			u8 pm = mpc83xx_spi->sysclk / (spi->max_speed_hz * 4);
+			regval |= SPMODE_PM(pm);
+		}
+
+		mpc83xx_spi_write_reg(mpc83xx_spi->base, SPMODE_REG, regval);
+		if (mpc83xx_spi->activate_cs)
+			mpc83xx_spi->activate_cs(spi->chip_select, pol);
+	}
+}
+
+static u32
+mpc83xx_spi_txrx(struct spi_device *spi, unsigned nsecs, u32 word, u8 bits)
+{
+	struct mpc83xx_spi *mpc83xx_spi;
+	mpc83xx_spi = spi_master_get_devdata(spi->master);
+
+	INIT_COMPLETION(mpc83xx_spi->tx_done);
+	INIT_COMPLETION(mpc83xx_spi->rx_ready);
+
+	/* enable tx/rx ints */
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIM_REG, SPIM_NF | SPIM_NE);
+
+	/* transmit word */
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPITD_REG, word);
+
+	/* wait for both a tx & rx interrupt */
+	wait_for_completion(&mpc83xx_spi->tx_done);
+	wait_for_completion(&mpc83xx_spi->rx_ready);
+
+	return mpc83xx_spi->rx_data;
+}
+
+irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data,
+			    struct pt_regs * ptregs)
+{
+	struct mpc83xx_spi *mpc83xx_spi = context_data;
+	u32 regval, event;
+
+	/* Get interrupt events(tx/rx) */
+	event = mpc83xx_spi_read_reg(mpc83xx_spi->base, SPIE_REG);
+
+	/* We need handle RX first */
+	if (event & SPIE_NE) {
+		mpc83xx_spi->rx_data =
+		    mpc83xx_spi_read_reg(mpc83xx_spi->base, SPIRD_REG);
+
+		/* disable rx ints */
+		regval = mpc83xx_spi_read_reg(mpc83xx_spi->base, SPIM_REG);
+		regval &= ~SPIM_NE;
+		mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIM_REG, regval);
+
+		complete(&mpc83xx_spi->rx_ready);
+	}
+
+	if (event & SPIE_NF) {
+		/* disable tx ints */
+		regval = mpc83xx_spi_read_reg(mpc83xx_spi->base, SPIM_REG);
+		regval &= ~SPIM_NF;
+		mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIM_REG, regval);
+
+		complete(&mpc83xx_spi->tx_done);
+	}
+
+	/* Clear the events */
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIE_REG, event);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit mpc83xx_spi_probe(struct platform_device *dev)
+{
+	struct spi_master *master;
+	struct mpc83xx_spi *mpc83xx_spi;
+	struct fsl_spi_platform_data *pdata;
+	struct resource *r;
+	u32 regval;
+	int ret = 0;
+
+	/* Get resources(memory, IRQ) associated with the device */
+	master = spi_alloc_master(&dev->dev, sizeof(struct mpc83xx_spi));
+
+	if (master == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(dev, master);
+	pdata = dev->dev.platform_data;
+
+	if (pdata == NULL) {
+		ret = -ENODEV;
+		goto free_master;
+	}
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENODEV;
+		goto free_master;
+	}
+
+	mpc83xx_spi = spi_master_get_devdata(master);
+	mpc83xx_spi->bitbang.master = spi_master_get(master);
+	mpc83xx_spi->bitbang.chipselect = mpc83xx_spi_chipselect;
+	mpc83xx_spi->bitbang.setup_transfer = mpc83xx_spi_setup_transfer;
+	mpc83xx_spi->bitbang.txrx_word[SPI_MODE_0] = mpc83xx_spi_txrx;
+	mpc83xx_spi->bitbang.txrx_word[SPI_MODE_1] = mpc83xx_spi_txrx;
+	mpc83xx_spi->bitbang.txrx_word[SPI_MODE_2] = mpc83xx_spi_txrx;
+	mpc83xx_spi->bitbang.txrx_word[SPI_MODE_3] = mpc83xx_spi_txrx;
+	mpc83xx_spi->sysclk = pdata->sysclk;
+	mpc83xx_spi->activate_cs = pdata->activate_cs;
+	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
+
+	init_completion(&mpc83xx_spi->tx_done);
+	init_completion(&mpc83xx_spi->rx_ready);
+
+	mpc83xx_spi->base = ioremap(r->start, r->end - r->start + 1);
+	if (mpc83xx_spi->base == NULL) {
+		ret = -ENOMEM;
+		goto put_master;
+	}
+
+	mpc83xx_spi->irq = platform_get_irq(dev, 0);
+
+	if (mpc83xx_spi->irq < 0) {
+		ret = -ENXIO;
+		goto unmap_io;
+	}
+
+	/* Register for SPI Interrupt */
+	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
+			  0, "mpc83xx_spi", mpc83xx_spi);
+
+	if (ret != 0)
+		goto unmap_io;
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->max_chipselect;
+
+	/* SPI controller initializations */
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPMODE_REG, 0);
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIM_REG, 0);
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPCOM_REG, 0);
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPIE_REG, 0xffffffff);
+
+	/* Enable SPI interface */
+	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	mpc83xx_spi_write_reg(mpc83xx_spi->base, SPMODE_REG, regval);
+
+	ret = spi_bitbang_start(&mpc83xx_spi->bitbang);
+
+	if (ret != 0)
+		goto free_irq;
+
+	printk(KERN_INFO
+	       "%s: MPC83xx SPI Controller driver at 0x%p (irq = %d)\n",
+	       dev->dev.bus_id, mpc83xx_spi->base, mpc83xx_spi->irq);
+
+	return ret;
+
+free_irq:
+	free_irq(mpc83xx_spi->irq, mpc83xx_spi);
+unmap_io:
+	iounmap(mpc83xx_spi->base);
+put_master:
+	spi_master_put(master);
+free_master:
+	kfree(master);
+err:
+	return ret;
+}
+
+static int __devexit mpc83xx_spi_remove(struct platform_device *dev)
+{
+	struct mpc83xx_spi *mpc83xx_spi;
+	struct spi_master *master;
+
+	master = platform_get_drvdata(dev);
+	mpc83xx_spi = spi_master_get_devdata(master);
+
+	spi_bitbang_stop(&mpc83xx_spi->bitbang);
+	free_irq(mpc83xx_spi->irq, mpc83xx_spi);
+	iounmap(mpc83xx_spi->base);
+	spi_master_put(mpc83xx_spi->bitbang.master);
+
+	return 0;
+}
+
+static struct platform_driver mpc83xx_spi_driver = {
+	.probe = mpc83xx_spi_probe,
+	.remove = __devexit_p(mpc83xx_spi_remove),
+	.driver = {
+		   .name = "mpc83xx_spi",
+		   },
+};
+
+static int __init mpc83xx_spi_init(void)
+{
+	return platform_driver_register(&mpc83xx_spi_driver);
+}
+
+static void __exit mpc83xx_spi_exit(void)
+{
+	platform_driver_unregister(&mpc83xx_spi_driver);
+}
+
+module_init(mpc83xx_spi_init);
+module_exit(mpc83xx_spi_exit);
+
+MODULE_AUTHOR("Kumar Gala");
+MODULE_DESCRIPTION("Simple Platform SPI Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index a3a0e07..121b860 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -110,5 +110,16 @@ struct fsl_usb2_platform_data {
 #define FSL_USB2_PORT0_ENABLED	0x00000001
 #define FSL_USB2_PORT1_ENABLED	0x00000002
 
+struct fsl_spi_platform_data {
+	u32 	initial_spmode;	/* initial SPMODE value */
+	u16	bus_num;	
+
+	/* board specific information */
+	u16	max_chipselect;
+	void	(*activate_cs)(u8 cs, u8 polarity);
+	void	(*deactivate_cs)(u8 cs, u8 polarity);
+	u32	sysclk;
+};
+
 #endif				/* _FSL_DEVICE_H_ */
 #endif				/* __KERNEL__ */

