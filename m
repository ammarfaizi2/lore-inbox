Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVGVSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVGVSBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGVSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:01:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27844 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262129AbVGVSBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:01:09 -0400
Date: Fri, 22 Jul 2005 20:01:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       vojtech@suse.cz
Subject: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050722180109.GA1879@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for reading ADCs (etc), neccessary to operate touch
screen on Sharp Zaurus sl-5500.

Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>


diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -30,3 +30,20 @@ config IBM_ASM
 
 endmenu
 
+menu "Multimedia Capabilities Port drivers"
+
+config MCP
+	tristate
+
+# Interface drivers
+config MCP_SA1100
+	tristate "Support SA1100 MCP interface"
+	depends on ARCH_SA1100
+	select MCP
+
+# Chip drivers
+config MCP_UCB1200
+	tristate "Support for UCB1200 / UCB1300"
+	depends on MCP
+
+endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -5,3 +5,11 @@ obj- := misc.o	# Dummy rule to force bui
 
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
+
+obj-$(CONFIG_MCP)              += mcp-core.o
+obj-$(CONFIG_MCP_UCB1200)      += ucb1x00-core.o
+
+obj-$(CONFIG_MCP_SA1100)       += mcp-sa1100.o
+
+ucb1400-core-y := ucb1x00-core.o mcp-ac97.o
+obj-$(CONFIG_UCB1400_TS) += ucb1400-core.o ucb1x00-ts.o
diff --git a/drivers/misc/mcp-core.c b/drivers/misc/mcp-core.c
new file mode 100644
--- /dev/null
+++ b/drivers/misc/mcp-core.c
@@ -0,0 +1,257 @@
+/*
+ *  linux/drivers/misc/mcp-core.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ *  Generic MCP (Multimedia Communications Port) layer.  All MCP locking
+ *  is solely held within this file.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/device.h>
+
+#include <asm/dma.h>
+#include <asm/system.h>
+
+#include <asm/arch-sa1100/mcp.h>
+
+#define to_mcp(d)		((struct mcp *)(d)->platform_data)
+#define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
+
+static int mcp_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int mcp_bus_probe(struct device *dev)
+{
+	struct mcp *mcp = to_mcp(dev);
+	struct mcp_driver *drv = to_mcp_driver(dev->driver);
+
+	return drv->probe(mcp);
+}
+
+static int mcp_bus_remove(struct device *dev)
+{
+	struct mcp *mcp = to_mcp(dev);
+	struct mcp_driver *drv = to_mcp_driver(dev->driver);
+
+	drv->remove(mcp);
+	return 0;
+}
+
+static int mcp_bus_suspend(struct device *dev, u32 state)
+{
+	struct mcp *mcp = to_mcp(dev);
+	int ret = 0;
+
+	if (dev->driver) {
+		struct mcp_driver *drv = to_mcp_driver(dev->driver);
+
+		ret = drv->suspend(mcp, state);
+	}
+	return ret;
+}
+
+static int mcp_bus_resume(struct device *dev)
+{
+	struct mcp *mcp = to_mcp(dev);
+	int ret = 0;
+
+	if (dev->driver) {
+		struct mcp_driver *drv = to_mcp_driver(dev->driver);
+
+		ret = drv->resume(mcp);
+	}
+	return ret;
+}
+
+static struct bus_type mcp_bus_type = {
+	.name		= "mcp",
+	.match		= mcp_bus_match,
+	.suspend	= mcp_bus_suspend,
+	.resume		= mcp_bus_resume,
+};
+
+/**
+ *	mcp_set_telecom_divisor - set the telecom divisor
+ *	@mcp: MCP interface structure
+ *	@div: SIB clock divisor
+ *
+ *	Set the telecom divisor on the MCP interface.  The resulting
+ *	sample rate is SIBCLOCK/div.
+ */
+void mcp_set_telecom_divisor(struct mcp *mcp, unsigned int div)
+{
+	spin_lock_irq(&mcp->lock);
+	mcp->set_telecom_divisor(mcp, div);
+	spin_unlock_irq(&mcp->lock);
+}
+
+/**
+ *	mcp_set_audio_divisor - set the audio divisor
+ *	@mcp: MCP interface structure
+ *	@div: SIB clock divisor
+ *
+ *	Set the audio divisor on the MCP interface.
+ */
+void mcp_set_audio_divisor(struct mcp *mcp, unsigned int div)
+{
+	spin_lock_irq(&mcp->lock);
+	mcp->set_audio_divisor(mcp, div);
+	spin_unlock_irq(&mcp->lock);
+}
+
+/**
+ *	mcp_reg_write - write a device register
+ *	@mcp: MCP interface structure
+ *	@reg: 4-bit register index
+ *	@val: 16-bit data value
+ *
+ *	Write a device register.  The MCP interface must be enabled
+ *	to prevent this function hanging.
+ */
+void mcp_reg_write(struct mcp *mcp, unsigned int reg, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcp->lock, flags);
+	mcp->reg_write(mcp, reg, val);
+	spin_unlock_irqrestore(&mcp->lock, flags);
+}
+
+/**
+ *	mcp_reg_read - read a device register
+ *	@mcp: MCP interface structure
+ *	@reg: 4-bit register index
+ *
+ *	Read a device register and return its value.  The MCP interface
+ *	must be enabled to prevent this function hanging.
+ */
+unsigned int mcp_reg_read(struct mcp *mcp, unsigned int reg)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&mcp->lock, flags);
+	val = mcp->reg_read(mcp, reg);
+	spin_unlock_irqrestore(&mcp->lock, flags);
+
+	return val;
+}
+
+/**
+ *	mcp_enable - enable the MCP interface
+ *	@mcp: MCP interface to enable
+ *
+ *	Enable the MCP interface.  Each call to mcp_enable will need
+ *	a corresponding call to mcp_disable to disable the interface.
+ */
+void mcp_enable(struct mcp *mcp)
+{
+	spin_lock_irq(&mcp->lock);
+	if (mcp->use_count++ == 0)
+		mcp->enable(mcp);
+	spin_unlock_irq(&mcp->lock);
+}
+
+/**
+ *	mcp_disable - disable the MCP interface
+ *	@mcp: MCP interface to disable
+ *
+ *	Disable the MCP interface.  The MCP interface will only be
+ *	disabled once the number of calls to mcp_enable matches the
+ *	number of calls to mcp_disable.
+ */
+void mcp_disable(struct mcp *mcp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcp->lock, flags);
+	if (--mcp->use_count == 0)
+		mcp->disable(mcp);
+	spin_unlock_irqrestore(&mcp->lock, flags);
+}
+
+static void mcp_host_release(struct device *dev) {
+	struct mcp *mcp = dev->platform_data;
+	complete(&mcp->attached_device_released);
+}
+
+int mcp_host_register(struct mcp *mcp, struct device *parent)
+{
+	int ret;
+	struct device *dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	memset(dev, 0, sizeof(*dev));
+	dev->platform_data = mcp;
+	dev->parent = parent;
+	dev->bus = &mcp_bus_type;
+	dev->dma_mask = parent->dma_mask;
+	dev->release = mcp_host_release;
+	strcpy(dev->bus_id, "mcp0");
+	mcp->attached_device = dev;
+	ret = device_register(dev);
+	if (ret) {
+		mcp->attached_device = NULL;
+		kfree(dev);
+	}
+	return ret;
+}
+
+void mcp_host_unregister(struct mcp *mcp)
+{
+	init_completion(&mcp->attached_device_released);
+	device_unregister(mcp->attached_device);
+	wait_for_completion(&mcp->attached_device_released);
+	kfree(mcp->attached_device);
+	mcp->attached_device = NULL;
+}
+
+int mcp_driver_register(struct mcp_driver *mcpdrv)
+{
+	mcpdrv->drv.bus = &mcp_bus_type;
+	mcpdrv->drv.probe = mcp_bus_probe;
+	mcpdrv->drv.remove = mcp_bus_remove;
+	return driver_register(&mcpdrv->drv);
+}
+
+void mcp_driver_unregister(struct mcp_driver *mcpdrv)
+{
+	driver_unregister(&mcpdrv->drv);
+}
+
+static int __init mcp_init(void)
+{
+	return bus_register(&mcp_bus_type);
+}
+
+static void __exit mcp_exit(void)
+{
+	bus_unregister(&mcp_bus_type);
+}
+
+module_init(mcp_init);
+module_exit(mcp_exit);
+
+EXPORT_SYMBOL(mcp_set_telecom_divisor);
+EXPORT_SYMBOL(mcp_set_audio_divisor);
+EXPORT_SYMBOL(mcp_reg_write);
+EXPORT_SYMBOL(mcp_reg_read);
+EXPORT_SYMBOL(mcp_enable);
+EXPORT_SYMBOL(mcp_disable);
+EXPORT_SYMBOL(mcp_host_register);
+EXPORT_SYMBOL(mcp_host_unregister);
+EXPORT_SYMBOL(mcp_driver_register);
+EXPORT_SYMBOL(mcp_driver_unregister);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("Core multimedia communications port driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/mcp-sa1100.c b/drivers/misc/mcp-sa1100.c
new file mode 100644
--- /dev/null
+++ b/drivers/misc/mcp-sa1100.c
@@ -0,0 +1,287 @@
+/*
+ *  linux/drivers/misc/mcp-sa1100.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ *  SA1100 MCP (Multimedia Communications Port) driver.
+ *
+ *  MCP read/write timeouts from Jordi Colomer, rehacked by rmk.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/system.h>
+
+#include <asm/arch/assabet.h>
+
+#include <asm/arch-sa1100/mcp.h>
+
+
+static void
+mcp_sa1100_set_telecom_divisor(struct mcp *mcp, unsigned int divisor)
+{
+	unsigned int mccr0;
+
+	divisor /= 32;
+
+	mccr0 = Ser4MCCR0 & ~0x00007f00;
+	mccr0 |= divisor << 8;
+	Ser4MCCR0 = mccr0;
+}
+
+static void
+mcp_sa1100_set_audio_divisor(struct mcp *mcp, unsigned int divisor)
+{
+	unsigned int mccr0;
+
+	divisor /= 32;
+
+	mccr0 = Ser4MCCR0 & ~0x0000007f;
+	mccr0 |= divisor;
+	Ser4MCCR0 = mccr0;
+}
+
+/*
+ * Write data to the device.  The bit should be set after 3 subframe
+ * times (each frame is 64 clocks).  We wait a maximum of 6 subframes.
+ * We really should try doing something more productive while we
+ * wait.
+ */
+static void
+mcp_sa1100_write(struct mcp *mcp, unsigned int reg, unsigned int val)
+{
+	int ret = -ETIME;
+	int i;
+
+	Ser4MCDR2 = reg << 17 | MCDR2_Wr | (val & 0xffff);
+
+	for (i = 0; i < 2; i++) {
+		udelay(mcp->rw_timeout);
+		if (Ser4MCSR & MCSR_CWC) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret < 0)
+		printk(KERN_WARNING "mcp: write timed out\n");
+}
+
+/*
+ * Read data from the device.  The bit should be set after 3 subframe
+ * times (each frame is 64 clocks).  We wait a maximum of 6 subframes.
+ * We really should try doing something more productive while we
+ * wait.
+ */
+static unsigned int
+mcp_sa1100_read(struct mcp *mcp, unsigned int reg)
+{
+	int ret = -ETIME;
+	int i;
+
+	Ser4MCDR2 = reg << 17 | MCDR2_Rd;
+
+	for (i = 0; i < 2; i++) {
+		udelay(mcp->rw_timeout);
+		if (Ser4MCSR & MCSR_CRC) {
+			ret = Ser4MCDR2 & 0xffff;
+			break;
+		}
+	}
+
+	if (ret < 0)
+		printk(KERN_WARNING "mcp: read timed out\n");
+
+	return ret;
+}
+
+static void mcp_sa1100_enable(struct mcp *mcp)
+{
+	Ser4MCSR = -1;
+	Ser4MCCR0 |= MCCR0_MCE;
+}
+
+static void mcp_sa1100_disable(struct mcp *mcp)
+{
+	Ser4MCCR0 &= ~MCCR0_MCE;
+}
+
+/*
+ * Our methods.
+ */
+static struct mcp mcp_sa1100 = {
+	.owner			= THIS_MODULE,
+	.lock			= SPIN_LOCK_UNLOCKED,
+	.sclk_rate		= 11981000,
+	.dma_audio_rd		= DMA_Ser4MCP0Rd,
+	.dma_audio_wr		= DMA_Ser4MCP0Wr,
+	.dma_telco_rd		= DMA_Ser4MCP1Rd,
+	.dma_telco_wr		= DMA_Ser4MCP1Wr,
+	.set_telecom_divisor	= mcp_sa1100_set_telecom_divisor,
+	.set_audio_divisor	= mcp_sa1100_set_audio_divisor,
+	.reg_write		= mcp_sa1100_write,
+	.reg_read		= mcp_sa1100_read,
+	.enable			= mcp_sa1100_enable,
+	.disable		= mcp_sa1100_disable,
+};
+
+static int mcp_sa1100_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mcp *mcp = &mcp_sa1100;
+	int ret;
+
+	if (!machine_is_adsbitsy()       && !machine_is_assabet()        &&
+	    !machine_is_cerf()           && !machine_is_flexanet()       &&
+	    !machine_is_freebird()       && !machine_is_graphicsclient() &&
+	    !machine_is_graphicsmaster() && !machine_is_lart()           &&
+	    !machine_is_omnimeter()      && !machine_is_pfs168()         &&
+	    !machine_is_shannon()        && !machine_is_simpad()         &&
+	    !machine_is_yopy()		 && !machine_is_collie()) {
+		printk(KERN_WARNING "MCP-sa1100: machine is not supported\n");
+		return -ENODEV;
+	}
+
+	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp")) {
+		printk(KERN_ERR "MCP-sa1100: Unable to request memory region\n");
+		return -EBUSY;
+	}
+
+	mcp->me = dev;
+	dev_set_drvdata(dev, mcp);
+
+	if (machine_is_assabet()) {
+		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
+	}
+
+	if (machine_is_collie()) {
+		GAFR &= ~(GPIO_GPIO(16));
+		GPDR |= GPIO_GPIO(16);
+		GPSR |= GPIO_GPIO(16);
+	}
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
+	Ser4MCSR = -1;
+	Ser4MCCR1 = 0;
+	//Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
+	Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
+
+	/*
+	 * Calculate the read/write timeout (us) from the bit clock
+	 * rate.  This is the period for 3 64-bit frames.  Always
+	 * round this time up.
+	 */
+	mcp->rw_timeout = (64 * 3 * 1000000 + mcp->sclk_rate - 1) /
+			  mcp->sclk_rate;
+
+	ret = mcp_host_register(mcp, &pdev->dev);
+	if (ret != 0) {
+		release_mem_region(0x80060000, 0x60);
+		dev_set_drvdata(dev, NULL);
+	}
+
+	return ret;
+}
+
+static int mcp_sa1100_remove(struct device *dev)
+{
+	struct mcp *mcp = dev_get_drvdata(dev);
+
+	dev_set_drvdata(dev, NULL);
+
+	mcp_host_unregister(mcp);
+	release_mem_region(0x80060000, 0x60);
+
+	return 0;
+}
+
+struct mcp_sa1100_state {
+	u32	mccr0;
+	u32	mccr1;
+};
+
+static int mcp_sa1100_suspend(struct device *dev, pm_message_t state, u32 level)
+{
+	struct mcp_sa1100_state *s = (struct mcp_sa1100_state *)dev->power.saved_state;
+
+	if (!s) {
+		s = kmalloc(sizeof(struct mcp_sa1100_state), GFP_KERNEL);
+		dev->power.saved_state = (unsigned char *)s;
+	}
+
+	if (s) {
+		s->mccr0 = Ser4MCCR0;
+		s->mccr1 = Ser4MCCR1;
+	}
+
+	if (level == SUSPEND_DISABLE)
+		Ser4MCCR0 &= ~MCCR0_MCE;
+	return 0;
+}
+
+static int mcp_sa1100_resume(struct device *dev, u32 level)
+{
+	struct mcp_sa1100_state *s = (struct mcp_sa1100_state *)dev->power.saved_state;
+
+	if (s && level == RESUME_RESTORE_STATE) {
+		Ser4MCCR1 = s->mccr1;
+		Ser4MCCR0 = s->mccr0;
+
+		dev->power.saved_state = NULL;
+		kfree(s);
+	}
+	return 0;
+}
+
+/*
+ * The driver for the SA11x0 MCP port.
+ */
+static struct device_driver mcp_sa1100_driver = {
+	.name		= "sa11x0-mcp",
+	.bus		= &platform_bus_type,
+	.probe		= mcp_sa1100_probe,
+	.remove		= mcp_sa1100_remove,
+	.suspend	= mcp_sa1100_suspend,
+	.resume		= mcp_sa1100_resume,
+};
+
+/*
+ * This needs re-working
+ */
+static int __init mcp_sa1100_init(void)
+{
+	return driver_register(&mcp_sa1100_driver);
+}
+
+static void __exit mcp_sa1100_exit(void)
+{
+	driver_unregister(&mcp_sa1100_driver);
+}
+
+module_init(mcp_sa1100_init);
+module_exit(mcp_sa1100_exit);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("SA11x0 multimedia communications port driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/ucb1x00-core.c b/drivers/misc/ucb1x00-core.c
new file mode 100644
--- /dev/null
+++ b/drivers/misc/ucb1x00-core.c
@@ -0,0 +1,638 @@
+/*
+ *  linux/drivers/misc/ucb1x00-core.c
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ *  The UCB1x00 core driver provides basic services for handling IO,
+ *  the ADC, interrupts, and accessing registers.  It is designed
+ *  such that everything goes through this layer, thereby providing
+ *  a consistent locking methodology, as well as allowing the drivers
+ *  to be used on other non-MCP-enabled hardware platforms.
+ *
+ *  Note that all locks are private to this file.  Nothing else may
+ *  touch them.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+
+#include <asm/arch-sa1100/ucb1x00.h>
+
+/**
+ *	ucb1x00_io_set_dir - set IO direction
+ *	@ucb: UCB1x00 structure describing chip
+ *	@in:  bitfield of IO pins to be set as inputs
+ *	@out: bitfield of IO pins to be set as outputs
+ *
+ *	Set the IO direction of the ten general purpose IO pins on
+ *	the UCB1x00 chip.  The @in bitfield has priority over the
+ *	@out bitfield, in that if you specify a pin as both input
+ *	and output, it will end up as an input.
+ *
+ *	ucb1x00_enable must have been called to enable the comms
+ *	before using this function.
+ *
+ *	This function takes a spinlock, disabling interrupts.
+ */
+void ucb1x00_io_set_dir(struct ucb1x00 *ucb, unsigned int in, unsigned int out)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ucb->io_lock, flags);
+	ucb->io_dir |= out;
+	ucb->io_dir &= ~in;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
+
+	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
+}
+
+/**
+ *	ucb1x00_io_write - set or clear IO outputs
+ *	@ucb:   UCB1x00 structure describing chip
+ *	@set:   bitfield of IO pins to set to logic '1'
+ *	@clear: bitfield of IO pins to set to logic '0'
+ *
+ *	Set the IO output state of the specified IO pins.  The value
+ *	is retained if the pins are subsequently configured as inputs.
+ *	The @clear bitfield has priority over the @set bitfield -
+ *	outputs will be cleared.
+ *
+ *	ucb1x00_enable must have been called to enable the comms
+ *	before using this function.
+ *
+ *	This function takes a spinlock, disabling interrupts.
+ */
+void ucb1x00_io_write(struct ucb1x00 *ucb, unsigned int set, unsigned int clear)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ucb->io_lock, flags);
+	ucb->io_out |= set;
+	ucb->io_out &= ~clear;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
+
+	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
+}
+
+/**
+ *	ucb1x00_io_read - read the current state of the IO pins
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Return a bitfield describing the logic state of the ten
+ *	general purpose IO pins.
+ *
+ *	ucb1x00_enable must have been called to enable the comms
+ *	before using this function.
+ *
+ *	This function does not take any semaphores or spinlocks.
+ */
+unsigned int ucb1x00_io_read(struct ucb1x00 *ucb)
+{
+	return ucb1x00_reg_read(ucb, UCB_IO_DATA);
+}
+
+/*
+ * UCB1300 data sheet says we must:
+ *  1. enable ADC	=> 5us (including reference startup time)
+ *  2. select input	=> 51*tsibclk  => 4.3us
+ *  3. start conversion	=> 102*tsibclk => 8.5us
+ * (tsibclk = 1/11981000)
+ * Period between SIB 128-bit frames = 10.7us
+ */
+
+/**
+ *	ucb1x00_adc_enable - enable the ADC converter
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Enable the ucb1x00 and ADC converter on the UCB1x00 for use.
+ *	Any code wishing to use the ADC converter must call this
+ *	function prior to using it.
+ *
+ *	This function takes the ADC semaphore to prevent two or more
+ *	concurrent uses, and therefore may sleep.  As a result, it
+ *	can only be called from process context, not interrupt
+ *	context.
+ *
+ *	You should release the ADC as soon as possible using
+ *	ucb1x00_adc_disable.
+ */
+void ucb1x00_adc_enable(struct ucb1x00 *ucb)
+{
+	down(&ucb->adc_sem);
+
+	ucb->adc_cr |= UCB_ADC_ENA;
+
+	ucb1x00_enable(ucb);
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr);
+}
+
+/**
+ *	ucb1x00_adc_read - read the specified ADC channel
+ *	@ucb: UCB1x00 structure describing chip
+ *	@adc_channel: ADC channel mask
+ *	@sync: wait for syncronisation pulse.
+ *
+ *	Start an ADC conversion and wait for the result.  Note that
+ *	synchronised ADC conversions (via the ADCSYNC pin) must wait
+ *	until the trigger is asserted and the conversion is finished.
+ *
+ *	This function currently spins waiting for the conversion to
+ *	complete (2 frames max without sync).
+ *
+ *	If called for a synchronised ADC conversion, it may sleep
+ *	with the ADC semaphore held.
+ */
+unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync)
+{
+	unsigned int val;
+
+	if (sync)
+		adc_channel |= UCB_ADC_SYNC_ENA;
+
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel);
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel | UCB_ADC_START);
+
+	for (;;) {
+		val = ucb1x00_reg_read(ucb, UCB_ADC_DATA);
+		if (val & UCB_ADC_DAT_VAL)
+			break;
+		/* yield to other processes */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
+	return UCB_ADC_DAT(val);
+}
+
+/**
+ *	ucb1x00_adc_disable - disable the ADC converter
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Disable the ADC converter and release the ADC semaphore.
+ */
+void ucb1x00_adc_disable(struct ucb1x00 *ucb)
+{
+	ucb->adc_cr &= ~UCB_ADC_ENA;
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr);
+	ucb1x00_disable(ucb);
+
+	up(&ucb->adc_sem);
+}
+
+/*
+ * UCB1x00 Interrupt handling.
+ *
+ * The UCB1x00 can generate interrupts when the SIBCLK is stopped.
+ * Since we need to read an internal register, we must re-enable
+ * SIBCLK to talk to the chip.  We leave the clock running until
+ * we have finished processing all interrupts from the chip.
+ */
+static irqreturn_t ucb1x00_irq(int irqnr, void *devid, struct pt_regs *regs)
+{
+	struct ucb1x00 *ucb = devid;
+	struct ucb1x00_irq *irq;
+	unsigned int isr, i;
+
+	ucb1x00_enable(ucb);
+	isr = ucb1x00_reg_read(ucb, UCB_IE_STATUS);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, isr);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
+
+	for (i = 0, irq = ucb->irq_handler; i < 16 && isr; i++, isr >>= 1, irq++)
+		if (isr & 1 && irq->fn)
+			irq->fn(i, irq->devid);
+	ucb1x00_disable(ucb);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * A restriction with interrupts exists when using the ucb1400, as
+ * the codec read/write routines may sleep while waiting for codec
+ * access completion and uses semaphores for access control to the
+ * AC97 bus.  A complete codec read cycle could take  anywhere from
+ * 60 to 100uSec so we *definitely* don't want to spin inside the
+ * interrupt handler waiting for codec access.  So, we handle the
+ * interrupt by scheduling a RT kernel thread to run in process
+ * context instead of interrupt context.
+ */
+static int ucb1x00_thread(void *_ucb)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+	struct ucb1x00 *ucb = _ucb;
+
+	ucb->irq_task = tsk;
+	daemonize("kUCB1x00d");
+	allow_signal(SIGKILL);
+	tsk->policy = SCHED_FIFO;
+	tsk->rt_priority = 1;
+
+	add_wait_queue(&ucb->irq_wait, &wait);
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+	complete(&ucb->complete);
+
+	for (;;) {
+		if (signal_pending(tsk))
+			break;
+		schedule();
+		ucb1x00_irq(-1, ucb, NULL);
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+		enable_irq(ucb->irq);
+	}
+
+	remove_wait_queue(&ucb->irq_wait, &wait);
+	ucb->irq_task = NULL;
+	complete_and_exit(&ucb->complete, 0);
+}
+
+static irqreturn_t ucb1x00_threaded_irq(int irqnr, void *devid, struct pt_regs *regs)
+{
+	struct ucb1x00 *ucb = devid;
+	if (irqnr == ucb->irq) {
+		disable_irq(ucb->irq);
+		wake_up(&ucb->irq_wait);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+/**
+ *	ucb1x00_hook_irq - hook a UCB1x00 interrupt
+ *	@ucb:   UCB1x00 structure describing chip
+ *	@idx:   interrupt index
+ *	@fn:    function to call when interrupt is triggered
+ *	@devid: device id to pass to interrupt handler
+ *
+ *	Hook the specified interrupt.  You can only register one handler
+ *	for each interrupt source.  The interrupt source is not enabled
+ *	by this function; use ucb1x00_enable_irq instead.
+ *
+ *	Interrupt handlers will be called with other interrupts enabled.
+ *
+ *	Returns zero on success, or one of the following errors:
+ *	 -EINVAL if the interrupt index is invalid
+ *	 -EBUSY if the interrupt has already been hooked
+ */
+int ucb1x00_hook_irq(struct ucb1x00 *ucb, unsigned int idx, void (*fn)(int, void *), void *devid)
+{
+	struct ucb1x00_irq *irq;
+	int ret = -EINVAL;
+
+	if (idx < 16) {
+		irq = ucb->irq_handler + idx;
+		ret = -EBUSY;
+
+		spin_lock_irq(&ucb->lock);
+		if (irq->fn == NULL) {
+			irq->devid = devid;
+			irq->fn = fn;
+			ret = 0;
+		}
+		spin_unlock_irq(&ucb->lock);
+	}
+	return ret;
+}
+
+/**
+ *	ucb1x00_enable_irq - enable an UCB1x00 interrupt source
+ *	@ucb: UCB1x00 structure describing chip
+ *	@idx: interrupt index
+ *	@edges: interrupt edges to enable
+ *
+ *	Enable the specified interrupt to trigger on %UCB_RISING,
+ *	%UCB_FALLING or both edges.  The interrupt should have been
+ *	hooked by ucb1x00_hook_irq.
+ */
+void ucb1x00_enable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
+{
+	unsigned long flags;
+
+	if (idx < 16) {
+		spin_lock_irqsave(&ucb->lock, flags);
+		if (edges & UCB_RISING)
+			ucb->irq_ris_enbl |= 1 << idx;
+		if (edges & UCB_FALLING)
+			ucb->irq_fal_enbl |= 1 << idx;
+		spin_unlock_irqrestore(&ucb->lock, flags);
+
+		ucb1x00_enable(ucb);
+
+		/* This prevents spurious interrupts on the UCB1400 */
+		ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 1 << idx);
+		ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
+
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+
+		ucb1x00_disable(ucb);
+	}
+}
+
+/**
+ *	ucb1x00_disable_irq - disable an UCB1x00 interrupt source
+ *	@ucb: UCB1x00 structure describing chip
+ *	@edges: interrupt edges to disable
+ *
+ *	Disable the specified interrupt triggering on the specified
+ *	(%UCB_RISING, %UCB_FALLING or both) edges.
+ */
+void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
+{
+	unsigned long flags;
+
+	if (idx < 16) {
+		spin_lock_irqsave(&ucb->lock, flags);
+		if (edges & UCB_RISING)
+			ucb->irq_ris_enbl &= ~(1 << idx);
+		if (edges & UCB_FALLING)
+			ucb->irq_fal_enbl &= ~(1 << idx);
+		spin_unlock_irqrestore(&ucb->lock, flags);
+
+		ucb1x00_enable(ucb);
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+		ucb1x00_disable(ucb);
+	}
+}
+
+/**
+ *	ucb1x00_free_irq - disable and free the specified UCB1x00 interrupt
+ *	@ucb: UCB1x00 structure describing chip
+ *	@idx: interrupt index
+ *	@devid: device id.
+ *
+ *	Disable the interrupt source and remove the handler.  devid must
+ *	match the devid passed when hooking the interrupt.
+ *
+ *	Returns zero on success, or one of the following errors:
+ *	 -EINVAL if the interrupt index is invalid
+ *	 -ENOENT if devid does not match
+ */
+int ucb1x00_free_irq(struct ucb1x00 *ucb, unsigned int idx, void *devid)
+{
+	struct ucb1x00_irq *irq;
+	int ret;
+
+	if (idx >= 16)
+		goto bad;
+
+	irq = ucb->irq_handler + idx;
+	ret = -ENOENT;
+
+	spin_lock_irq(&ucb->lock);
+	if (irq->devid == devid) {
+		ucb->irq_ris_enbl &= ~(1 << idx);
+		ucb->irq_fal_enbl &= ~(1 << idx);
+
+		irq->fn = NULL;
+		irq->devid = NULL;
+		ret = 0;
+	}
+	spin_unlock_irq(&ucb->lock);
+
+	ucb1x00_enable(ucb);
+	ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+	ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+	ucb1x00_disable(ucb);
+
+	return ret;
+
+bad:
+	printk(KERN_ERR "Freeing bad UCB1x00 irq %d\n", idx);
+	return -EINVAL;
+}
+
+/*
+ * Try to probe our interrupt, rather than relying on lots of
+ * hard-coded machine dependencies.  For reference, the expected
+ * IRQ mappings are:
+ *
+ *  	Machine		Default IRQ
+ *	adsbitsy	IRQ_GPCIN4
+ *	cerf		IRQ_GPIO_UCB1200_IRQ
+ *	flexanet	IRQ_GPIO_GUI
+ *	freebird	IRQ_GPIO_FREEBIRD_UCB1300_IRQ
+ *	graphicsclient	ADS_EXT_IRQ(8)
+ *	graphicsmaster	ADS_EXT_IRQ(8)
+ *	lart		LART_IRQ_UCB1200
+ *	omnimeter	IRQ_GPIO23
+ *	pfs168		IRQ_GPIO_UCB1300_IRQ
+ *	simpad		IRQ_GPIO_UCB1300_IRQ
+ *	shannon		SHANNON_IRQ_GPIO_IRQ_CODEC
+ *	yopy		IRQ_GPIO_UCB1200_IRQ
+ */
+static int ucb1x00_detect_irq(struct ucb1x00 *ucb)
+{
+	unsigned long mask;
+
+	mask = probe_irq_on();
+	if (!mask)
+		return NO_IRQ;
+
+	/*
+	 * Enable the ADC interrupt.
+	 */
+	ucb1x00_reg_write(ucb, UCB_IE_RIS, UCB_IE_ADC);
+	ucb1x00_reg_write(ucb, UCB_IE_FAL, UCB_IE_ADC);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0xffff);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
+
+	/*
+	 * Cause an ADC interrupt.
+	 */
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, UCB_ADC_ENA);
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, UCB_ADC_ENA | UCB_ADC_START);
+
+	/*
+	 * Wait for the conversion to complete.
+	 */
+	while ((ucb1x00_reg_read(ucb, UCB_ADC_DATA) & UCB_ADC_DAT_VAL) == 0);
+	ucb1x00_reg_write(ucb, UCB_ADC_CR, 0);
+
+	/*
+	 * Disable and clear interrupt.
+	 */
+	ucb1x00_reg_write(ucb, UCB_IE_RIS, 0);
+	ucb1x00_reg_write(ucb, UCB_IE_FAL, 0);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0xffff);
+	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
+
+	/*
+	 * Read triggered interrupt.
+	 */
+	return probe_irq_off(mask);
+}
+
+static int ucb1x00_probe(struct mcp *mcp)
+{
+	struct ucb1x00 *ucb;
+	unsigned int id;
+	int ret = -ENODEV;
+
+	mcp_enable(mcp);
+	id = mcp_reg_read(mcp, UCB_ID);
+
+	/*if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_1400) {
+		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
+		goto err_disable;
+	}*/
+
+	ucb = kmalloc(sizeof(struct ucb1x00), GFP_KERNEL);
+	ret = -ENOMEM;
+	if (!ucb)
+		goto err_disable;
+
+	memset(ucb, 0, sizeof(struct ucb1x00));
+
+	ucb->cdev.class = &ucb1x00_class;
+	ucb->cdev.dev = mcp->attached_device;
+	strlcpy(ucb->cdev.class_id, "ucb1x00", sizeof(ucb->cdev.class_id));
+
+	spin_lock_init(&ucb->lock);
+	spin_lock_init(&ucb->io_lock);
+	sema_init(&ucb->adc_sem, 1);
+	init_waitqueue_head(&ucb->irq_wait);
+
+	ucb->mcp = mcp;
+	ucb->id  = id;
+	/* distinguish between UCB1400 revs 1B and 2A */
+	if (id == UCB_ID_1400 && mcp_reg_read(mcp, 0x00) == 0x002a)
+		ucb->id = UCB_ID_1400_BUGGY;
+
+	ucb->irq = ucb1x00_detect_irq(ucb);
+	if (ucb->irq == NO_IRQ) {
+		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
+		ret = -ENODEV;
+		goto err_free;
+	}
+
+	ret = request_irq(ucb->irq,
+			  id != UCB_ID_1400 ? ucb1x00_irq : ucb1x00_threaded_irq,
+			  0, "UCB1x00", ucb);
+	if (ret) {
+		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
+			ucb->irq, ret);
+		goto err_free;
+	}
+
+	set_irq_type(ucb->irq, IRQT_RISING);
+	mcp_set_drvdata(mcp, ucb);
+
+	ret = class_device_register(&ucb->cdev);
+
+	if (!ret && id == UCB_ID_1400) {
+		init_completion(&ucb->complete);
+		ret = kernel_thread(ucb1x00_thread, ucb, CLONE_KERNEL);
+		if (ret >= 0) {
+			wait_for_completion(&ucb->complete);
+			ret = 0;
+		}
+	}
+
+	if (ret) {
+		free_irq(ucb->irq, ucb);
+ err_free:
+		kfree(ucb);
+	}
+ err_disable:
+	mcp_disable(mcp);
+	return ret;
+}
+
+static void ucb1x00_remove(struct mcp *mcp)
+{
+	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
+
+	class_device_unregister(&ucb->cdev);
+	if (ucb->id == UCB_ID_1400 || ucb->id == UCB_ID_1400_BUGGY) {
+		send_sig(SIGKILL, ucb->irq_task, 1);
+		wait_for_completion(&ucb->complete);
+	}
+	free_irq(ucb->irq, ucb);
+}
+
+static void ucb1x00_release(struct class_device *dev)
+{
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(dev);
+	kfree(ucb);
+}
+
+static struct class ucb1x00_class = {
+	.name		= "ucb1x00",
+	.release	= ucb1x00_release,
+};
+
+int ucb1x00_register_interface(struct class_interface *intf)
+{
+	intf->class = &ucb1x00_class;
+	return class_interface_register(intf);
+}
+
+void ucb1x00_unregister_interface(struct class_interface *intf)
+{
+	class_interface_unregister(intf);
+}
+
+static struct mcp_driver ucb1x00_driver = {
+	.drv		= {
+		.name	= "ucb1x00",
+	},
+	.probe		= ucb1x00_probe,
+	.remove		= ucb1x00_remove,
+};
+
+static int __init ucb1x00_init(void)
+{
+	int ret = class_register(&ucb1x00_class);
+	if (ret == 0) {
+		ret = mcp_driver_register(&ucb1x00_driver);
+		if (ret)
+			class_unregister(&ucb1x00_class);
+	}
+	return ret;
+}
+
+static void __exit ucb1x00_exit(void)
+{
+	mcp_driver_unregister(&ucb1x00_driver);
+	class_unregister(&ucb1x00_class);
+}
+
+module_init(ucb1x00_init);
+module_exit(ucb1x00_exit);
+
+EXPORT_SYMBOL(ucb1x00_class);
+
+EXPORT_SYMBOL(ucb1x00_io_set_dir);
+EXPORT_SYMBOL(ucb1x00_io_write);
+EXPORT_SYMBOL(ucb1x00_io_read);
+
+EXPORT_SYMBOL(ucb1x00_adc_enable);
+EXPORT_SYMBOL(ucb1x00_adc_read);
+EXPORT_SYMBOL(ucb1x00_adc_disable);
+
+EXPORT_SYMBOL(ucb1x00_hook_irq);
+EXPORT_SYMBOL(ucb1x00_free_irq);
+EXPORT_SYMBOL(ucb1x00_enable_irq);
+EXPORT_SYMBOL(ucb1x00_disable_irq);
+
+EXPORT_SYMBOL(ucb1x00_register_interface);
+EXPORT_SYMBOL(ucb1x00_unregister_interface);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("UCB1x00 core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
--- a/drivers/pcmcia/sa1100_generic.h
+++ b/drivers/pcmcia/sa1100_generic.h
@@ -8,6 +8,7 @@ extern int pcmcia_adsbitsy_init(struct d
 extern int pcmcia_assabet_init(struct device *);
 extern int pcmcia_badge4_init(struct device *);
 extern int pcmcia_cerf_init(struct device *);
+extern int pcmcia_collie_init(struct device *);
 extern int pcmcia_flexanet_init(struct device *);
 extern int pcmcia_freebird_init(struct device *);
 extern int pcmcia_gcplus_init(struct device *);
diff --git a/include/asm-arm/arch-sa1100/mcp.h b/include/asm-arm/arch-sa1100/mcp.h
new file mode 100644
--- /dev/null
+++ b/include/asm-arm/arch-sa1100/mcp.h
@@ -0,0 +1,65 @@
+/*
+ *  linux/drivers/misc/mcp.h
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+#ifndef MCP_H
+#define MCP_H
+
+#ifdef CONFIG_ARCH_SA1100
+#include <asm/dma.h>
+#endif
+
+struct mcp {
+	struct module	*owner;
+	struct device	*me;
+	spinlock_t	lock;
+	int		use_count;
+	unsigned int	sclk_rate;
+#ifdef CONFIG_ARCH_SA1100
+	unsigned int	rw_timeout;
+	dma_device_t	dma_audio_rd;
+	dma_device_t	dma_audio_wr;
+	dma_device_t	dma_telco_rd;
+	dma_device_t	dma_telco_wr;
+	void		(*set_telecom_divisor)(struct mcp *, unsigned int);
+	void		(*set_audio_divisor)(struct mcp *, unsigned int);
+#endif
+	void		(*reg_write)(struct mcp *, unsigned int, unsigned int);
+	unsigned int	(*reg_read)(struct mcp *, unsigned int);
+	void		(*enable)(struct mcp *);
+	void		(*disable)(struct mcp *);
+	struct device	*attached_device;
+	struct completion attached_device_released;
+};
+
+void mcp_set_telecom_divisor(struct mcp *, unsigned int);
+void mcp_set_audio_divisor(struct mcp *, unsigned int);
+void mcp_reg_write(struct mcp *, unsigned int, unsigned int);
+unsigned int mcp_reg_read(struct mcp *, unsigned int);
+void mcp_enable(struct mcp *);
+void mcp_disable(struct mcp *);
+#define mcp_get_sclk_rate(mcp)	((mcp)->sclk_rate)
+
+int mcp_host_register(struct mcp *, struct device *);
+void mcp_host_unregister(struct mcp *);
+
+struct mcp_driver {
+	struct device_driver drv;
+	int (*probe)(struct mcp *);
+	void (*remove)(struct mcp *);
+	int (*suspend)(struct mcp *, u32);
+	int (*resume)(struct mcp *);
+};
+
+int mcp_driver_register(struct mcp_driver *);
+void mcp_driver_unregister(struct mcp_driver *);
+
+#define mcp_get_drvdata(mcp)	dev_get_drvdata((mcp)->attached_device)
+#define mcp_set_drvdata(mcp,d)	dev_set_drvdata((mcp)->attached_device, d)
+
+#endif
diff --git a/include/asm-arm/arch-sa1100/ucb1x00.h b/include/asm-arm/arch-sa1100/ucb1x00.h
new file mode 100644
--- /dev/null
+++ b/include/asm-arm/arch-sa1100/ucb1x00.h
@@ -0,0 +1,270 @@
+/*
+ *  linux/drivers/misc/ucb1x00.h
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+#ifndef UCB1200_H
+#define UCB1200_H
+
+#ifdef CONFIG_ARCH_PXA
+
+/* ucb1400 aclink register mappings: */
+
+#define UCB_IO_DATA	0x5a
+#define UCB_IO_DIR	0x5c
+#define UCB_IE_RIS	0x5e
+#define UCB_IE_FAL	0x60
+#define UCB_IE_STATUS	0x62
+#define UCB_IE_CLEAR	0x62
+#define UCB_TS_CR	0x64
+#define UCB_ADC_CR	0x66
+#define UCB_ADC_DATA	0x68
+#define UCB_ID		0x7e /* 7c is mfr id, 7e part id (from aclink spec) */
+
+#define UCB_ADC_DAT(x)		((x) & 0x3ff)
+
+#else
+
+/* ucb1x00 SIB register mappings: */
+
+#define UCB_IO_DATA	0x00
+#define UCB_IO_DIR	0x01
+#define UCB_IE_RIS	0x02
+#define UCB_IE_FAL	0x03
+#define UCB_IE_STATUS	0x04
+#define UCB_IE_CLEAR	0x04
+#define UCB_TC_A	0x05
+#define UCB_TC_B	0x06
+#define UCB_AC_A	0x07
+#define UCB_AC_B	0x08
+#define UCB_TS_CR	0x09
+#define UCB_ADC_CR	0x0a
+#define UCB_ADC_DATA	0x0b
+#define UCB_ID		0x0c
+#define UCB_MODE	0x0d
+
+#define UCB_ADC_DAT(x)		(((x) & 0x7fe0) >> 5)
+
+#endif
+
+
+#define UCB_IO_0		(1 << 0)
+#define UCB_IO_1		(1 << 1)
+#define UCB_IO_2		(1 << 2)
+#define UCB_IO_3		(1 << 3)
+#define UCB_IO_4		(1 << 4)
+#define UCB_IO_5		(1 << 5)
+#define UCB_IO_6		(1 << 6)
+#define UCB_IO_7		(1 << 7)
+#define UCB_IO_8		(1 << 8)
+#define UCB_IO_9		(1 << 9)
+
+#define UCB_IE_ADC		(1 << 11)
+#define UCB_IE_TSPX		(1 << 12)
+#define UCB_IE_TSMX		(1 << 13)
+#define UCB_IE_TCLIP		(1 << 14)
+#define UCB_IE_ACLIP		(1 << 15)
+
+#define UCB_IRQ_TSPX		12
+
+#define UCB_TC_A_LOOP		(1 << 7)	/* UCB1200 */
+#define UCB_TC_A_AMPL		(1 << 7)	/* UCB1300 */
+
+#define UCB_TC_B_VOICE_ENA	(1 << 3)
+#define UCB_TC_B_CLIP		(1 << 4)
+#define UCB_TC_B_ATT		(1 << 6)
+#define UCB_TC_B_SIDE_ENA	(1 << 11)
+#define UCB_TC_B_MUTE		(1 << 13)
+#define UCB_TC_B_IN_ENA		(1 << 14)
+#define UCB_TC_B_OUT_ENA	(1 << 15)
+
+#define UCB_AC_B_LOOP		(1 << 8)
+#define UCB_AC_B_MUTE		(1 << 13)
+#define UCB_AC_B_IN_ENA		(1 << 14)
+#define UCB_AC_B_OUT_ENA	(1 << 15)
+
+#define UCB_TS_CR_TSMX_POW	(1 << 0)
+#define UCB_TS_CR_TSPX_POW	(1 << 1)
+#define UCB_TS_CR_TSMY_POW	(1 << 2)
+#define UCB_TS_CR_TSPY_POW	(1 << 3)
+#define UCB_TS_CR_TSMX_GND	(1 << 4)
+#define UCB_TS_CR_TSPX_GND	(1 << 5)
+#define UCB_TS_CR_TSMY_GND	(1 << 6)
+#define UCB_TS_CR_TSPY_GND	(1 << 7)
+#define UCB_TS_CR_MODE_INT	(0 << 8)
+#define UCB_TS_CR_MODE_PRES	(1 << 8)
+#define UCB_TS_CR_MODE_POS	(2 << 8)
+#define UCB_TS_CR_BIAS_ENA	(1 << 11)
+#define UCB_TS_CR_TSPX_LOW	(1 << 12)
+#define UCB_TS_CR_TSMX_LOW	(1 << 13)
+
+#define UCB_ADC_SYNC_ENA	(1 << 0)
+#define UCB_ADC_VREFBYP_CON	(1 << 1)
+#define UCB_ADC_INP_TSPX	(0 << 2)
+#define UCB_ADC_INP_TSMX	(1 << 2)
+#define UCB_ADC_INP_TSPY	(2 << 2)
+#define UCB_ADC_INP_TSMY	(3 << 2)
+#define UCB_ADC_INP_AD0		(4 << 2)
+#define UCB_ADC_INP_AD1		(5 << 2)
+#define UCB_ADC_INP_AD2		(6 << 2)
+#define UCB_ADC_INP_AD3		(7 << 2)
+#define UCB_ADC_EXT_REF		(1 << 5)
+#define UCB_ADC_START		(1 << 7)
+#define UCB_ADC_ENA		(1 << 15)
+
+#define UCB_ADC_DAT_VAL		(1 << 15)
+
+#define UCB_ID_1200		0x1004
+#define UCB_ID_1300		0x1005
+#define UCB_ID_1400		0x4304
+#define UCB_ID_1400_BUGGY	0x4303	/* fake ID */
+
+#define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
+#define UCB_MODE_AUD_OFF_CAN	(1 << 13)
+
+#include "mcp.h"
+
+struct ucb1x00_irq {
+	void *devid;
+	void (*fn)(int, void *);
+};
+
+extern struct class ucb1x00_class;
+
+struct ucb1x00 {
+	struct mcp		*mcp;	/* this needs to be first */
+	spinlock_t		lock;
+	unsigned int		irq;
+	struct semaphore	adc_sem;
+	spinlock_t		io_lock;
+	wait_queue_head_t	irq_wait;
+	struct completion	complete;
+	struct task_struct	*irq_task;
+	u16			id;
+	u16			io_dir;
+	u16			io_out;
+	u16			adc_cr;
+	u16			irq_fal_enbl;
+	u16			irq_ris_enbl;
+	struct ucb1x00_irq	irq_handler[16];
+	struct class_device	cdev;
+	void			*audio_data;
+	void			*telecom_data;
+	void			*ts_data;
+};
+
+#define classdev_to_ucb1x00(cd)	container_of(cd, struct ucb1x00, cdev)
+
+int ucb1x00_register_interface(struct class_interface *intf);
+void ucb1x00_unregister_interface(struct class_interface *intf);
+
+/**
+ *	ucb1x00_clkrate - return the UCB1x00 SIB clock rate
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Return the SIB clock rate in Hz.
+ */
+static inline unsigned int ucb1x00_clkrate(struct ucb1x00 *ucb)
+{
+	return mcp_get_sclk_rate(ucb->mcp);
+}
+
+/**
+ *	ucb1x00_enable - enable the UCB1x00 SIB clock
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Enable the SIB clock.  This can be called multiple times.
+ */
+static inline void ucb1x00_enable(struct ucb1x00 *ucb)
+{
+	mcp_enable(ucb->mcp);
+}
+
+/**
+ *	ucb1x00_disable - disable the UCB1x00 SIB clock
+ *	@ucb: UCB1x00 structure describing chip
+ *
+ *	Disable the SIB clock.  The SIB clock will only be disabled
+ *	when the number of ucb1x00_enable calls match the number of
+ *	ucb1x00_disable calls.
+ */
+static inline void ucb1x00_disable(struct ucb1x00 *ucb)
+{
+	mcp_disable(ucb->mcp);
+}
+
+/**
+ *	ucb1x00_reg_write - write a UCB1x00 register
+ *	@ucb: UCB1x00 structure describing chip
+ *	@reg: UCB1x00 4-bit register index to write
+ *	@val: UCB1x00 16-bit value to write
+ *
+ *	Write the UCB1x00 register @reg with value @val.  The SIB
+ *	clock must be running for this function to return.
+ */
+static inline void ucb1x00_reg_write(struct ucb1x00 *ucb, unsigned int reg, unsigned int val)
+{
+	mcp_reg_write(ucb->mcp, reg, val);
+}
+
+/**
+ *	ucb1x00_reg_read - read a UCB1x00 register
+ *	@ucb: UCB1x00 structure describing chip
+ *	@reg: UCB1x00 4-bit register index to write
+ *
+ *	Read the UCB1x00 register @reg and return its value.  The SIB
+ *	clock must be running for this function to return.
+ */
+static inline unsigned int ucb1x00_reg_read(struct ucb1x00 *ucb, unsigned int reg)
+{
+	return mcp_reg_read(ucb->mcp, reg);
+}
+/**
+ *	ucb1x00_set_audio_divisor - 
+ *	@ucb: UCB1x00 structure describing chip
+ *	@div: SIB clock divisor
+ */
+static inline void ucb1x00_set_audio_divisor(struct ucb1x00 *ucb, unsigned int div)
+{
+	mcp_set_audio_divisor(ucb->mcp, div);
+}
+
+/**
+ *	ucb1x00_set_telecom_divisor -
+ *	@ucb: UCB1x00 structure describing chip
+ *	@div: SIB clock divisor
+ */
+static inline void ucb1x00_set_telecom_divisor(struct ucb1x00 *ucb, unsigned int div)
+{
+	mcp_set_telecom_divisor(ucb->mcp, div);
+}
+
+#define ucb1x00_get()	NULL
+
+void ucb1x00_io_set_dir(struct ucb1x00 *ucb, unsigned int, unsigned int);
+void ucb1x00_io_write(struct ucb1x00 *ucb, unsigned int, unsigned int);
+unsigned int ucb1x00_io_read(struct ucb1x00 *ucb);
+
+#define UCB_NOSYNC	(0)
+#define UCB_SYNC	(1)
+
+unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync);
+void ucb1x00_adc_enable(struct ucb1x00 *ucb);
+void ucb1x00_adc_disable(struct ucb1x00 *ucb);
+
+/*
+ * Which edges of the IRQ do you want to control today?
+ */
+#define UCB_RISING	(1 << 0)
+#define UCB_FALLING	(1 << 1)
+
+int ucb1x00_hook_irq(struct ucb1x00 *ucb, unsigned int idx, void (*fn)(int, void *), void *devid);
+void ucb1x00_enable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges);
+void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges);
+int ucb1x00_free_irq(struct ucb1x00 *ucb, unsigned int idx, void *devid);
+
+#endif
