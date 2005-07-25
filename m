Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVGYOqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVGYOqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGYOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:44:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261252AbVGYOmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:42:40 -0400
Date: Mon, 25 Jul 2005 06:56:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725045607.GA1851@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724174756.A20019@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds support for reading ADCs (etc), neccessary to operate touch
> > screen on Sharp Zaurus sl-5500.
> 
> I would like to know what the diffs are between my version (attached)
> and this version before they get applied.

Hmm, diff looks quite big (attached), and I got it from lenz for 99%
part.

I have made quite a lot of cleanups to touchscreen part, and it seems
to be acceptable by input people. I think it should go into
drivers/input/touchscreen/collie_ts.c... Also it looks to me like
mcp.h should go into asm/arch-sa1100, so that other drivers can use it...

> The only reason my version has not been submitted is because it lives
> in the drivers/misc directory, and mainline kernel folk don't like
> drivers which clutter up that directory.  In fact, I had been told
> that drivers/misc should remain completely empty - which makes this
> set of miscellaneous drivers homeless.

Could they simply live in arch/arm/mach-sa1100? Or is arch/arm/soc
better place?
							Pavel

--- linux-rmk/drivers/input/touchscreen/Kconfig	2005-07-14 00:41:02.000000000 +0200
+++ linux-z/drivers/input/touchscreen/Kconfig	2005-07-21 17:22:31.000000000 +0200
@@ -36,6 +36,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called ads7846_ts.
 
+config TOUCHSCREEN_COLLIE
+	tristate "Collie touchscreen (for Sharp SL-5500)"
+	depends on MCP_UCB1200
+	help
+	  Say Y here to enable the driver for the touchscreen on the 
+	  Sharp SL-5500 series of PDAs.
+
+	  If unsure, say N.
+
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
 	select SERIO
--- linux-rmk/drivers/input/touchscreen/Makefile	2005-07-14 00:41:02.000000000 +0200
+++ linux-z/drivers/input/touchscreen/Makefile	2005-07-21 06:39:52.000000000 +0200
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
+obj-$(CONFIG_TOUCHSCREEN_COLLIE)+= collie_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)	+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH) += mtouch.o
--- linux-rmk/drivers/misc/Makefile	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/Makefile	2005-07-21 06:36:17.000000000 +0200
@@ -6,12 +6,15 @@
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 
-obj-$(CONFIG_MCP)		+= mcp-core.o
-obj-$(CONFIG_MCP_SA1100)	+= mcp-sa1100.o
-obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-core.o
-obj-$(CONFIG_MCP_UCB1200_AUDIO)	+= ucb1x00-audio.o
-obj-$(CONFIG_MCP_UCB1200_TS)	+= ucb1x00-ts.o
+obj-$(CONFIG_MCP)              += mcp-core.o
+obj-$(CONFIG_MCP_UCB1200)      += ucb1x00-core.o
+obj-$(CONFIG_MCP_UCB1200_AUDIO)        += ucb1x00-audio.o
 
 ifeq ($(CONFIG_SA1100_ASSABET),y)
-obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-assabet.o
+obj-$(CONFIG_MCP_UCB1200)      += ucb1x00-assabet.o
 endif
+
+obj-$(CONFIG_MCP_SA1100)       += mcp-sa1100.o
+
+ucb1400-core-y := ucb1x00-core.o mcp-ac97.o
+obj-$(CONFIG_UCB1400_TS) += ucb1400-core.o ucb1x00-ts.o
Only in linux-z/drivers/misc: mcp-ac97.c
--- linux-rmk/drivers/misc/mcp-core.c	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/mcp-core.c	2005-07-21 06:57:36.000000000 +0200
@@ -19,9 +19,9 @@
 #include <asm/dma.h>
 #include <asm/system.h>
 
-#include "mcp.h"
+#include <asm/arch-sa1100/mcp.h>
 
-#define to_mcp(d)		container_of(d, struct mcp, attached_device)
+#define to_mcp(d)		((struct mcp *)(d)->platform_data)
 #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
 
 static int mcp_bus_match(struct device *dev, struct device_driver *drv)
@@ -46,7 +46,7 @@
 	return 0;
 }
 
-static int mcp_bus_suspend(struct device *dev, pm_message_t state)
+static int mcp_bus_suspend(struct device *dev, u32 state)
 {
 	struct mcp *mcp = to_mcp(dev);
 	int ret = 0;
@@ -179,26 +179,40 @@
 	spin_unlock_irqrestore(&mcp->lock, flags);
 }
 
-static void mcp_release(struct device *dev)
-{
-	struct mcp *mcp = container_of(dev, struct mcp, attached_device);
-
-	kfree(mcp);
+static void mcp_host_release(struct device *dev) {
+	struct mcp *mcp = dev->platform_data;
+	complete(&mcp->attached_device_released);
 }
 
 int mcp_host_register(struct mcp *mcp, struct device *parent)
 {
-	mcp->attached_device.parent = parent;
-	mcp->attached_device.bus = &mcp_bus_type;
-	mcp->attached_device.dma_mask = parent->dma_mask;
-	mcp->attached_device.release = mcp_release;
-	strcpy(mcp->attached_device.bus_id, "mcp0");
-	return device_register(&mcp->attached_device);
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
 }
 
 void mcp_host_unregister(struct mcp *mcp)
 {
-	device_unregister_wait(&mcp->attached_device);
+	init_completion(&mcp->attached_device_released);
+	device_unregister(mcp->attached_device);
+	wait_for_completion(&mcp->attached_device_released);
+	kfree(mcp->attached_device);
+	mcp->attached_device = NULL;
 }
 
 int mcp_driver_register(struct mcp_driver *mcpdrv)
--- linux-rmk/drivers/misc/mcp-sa1100.c	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/mcp-sa1100.c	2005-07-21 06:58:49.000000000 +0200
@@ -27,7 +27,8 @@
 
 #include <asm/arch/assabet.h>
 
-#include "mcp.h"
+#include <asm/arch-sa1100/mcp.h>
+
 
 static void
 mcp_sa1100_set_telecom_divisor(struct mcp *mcp, unsigned int divisor)
@@ -140,7 +141,7 @@
 static int mcp_sa1100_probe(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct mcp *mcp;
+	struct mcp *mcp = &mcp_sa1100;
 	int ret;
 
 	if (!machine_is_adsbitsy()       && !machine_is_assabet()        &&
@@ -149,20 +150,16 @@
 	    !machine_is_graphicsmaster() && !machine_is_lart()           &&
 	    !machine_is_omnimeter()      && !machine_is_pfs168()         &&
 	    !machine_is_shannon()        && !machine_is_simpad()         &&
-	    !machine_is_yopy())
+	    !machine_is_yopy()		 && !machine_is_collie()) {
+		printk(KERN_WARNING "MCP-sa1100: machine is not supported\n");
 		return -ENODEV;
+	}
 
-	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp"))
+	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp")) {
+		printk(KERN_ERR "MCP-sa1100: Unable to request memory region\n");
 		return -EBUSY;
-
-	mcp = kmalloc(sizeof(struct mcp), GFP_KERNEL);
-	if (!mcp) {
-		ret = -ENOMEM;
-		goto release;
 	}
 
-	*mcp = mcp_sa1100;
-
 	mcp->me = dev;
 	dev_set_drvdata(dev, mcp);
 
@@ -170,6 +167,12 @@
 		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
 	}
 
+	if (machine_is_collie()) {
+		GAFR &= ~(GPIO_GPIO(16));
+		GPDR |= GPIO_GPIO(16);
+		GPSR |= GPIO_GPIO(16);
+	}
+
 	/*
 	 * Setup the PPC unit correctly.
 	 */
@@ -181,7 +184,8 @@
 
 	Ser4MCSR = -1;
 	Ser4MCCR1 = 0;
-	Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
+	//Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
+	Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
 
 	/*
 	 * Calculate the read/write timeout (us) from the bit clock
@@ -192,14 +196,11 @@
 			  mcp->sclk_rate;
 
 	ret = mcp_host_register(mcp, &pdev->dev);
-	if (ret == 0)
-		goto out;
-
- release:
-	release_mem_region(0x80060000, 0x60);
-	dev_set_drvdata(dev, NULL);
+	if (ret != 0) {
+		release_mem_region(0x80060000, 0x60);
+		dev_set_drvdata(dev, NULL);
+	}
 
- out:
 	return ret;
 }
 
@@ -208,6 +209,7 @@
 	struct mcp *mcp = dev_get_drvdata(dev);
 
 	dev_set_drvdata(dev, NULL);
+
 	mcp_host_unregister(mcp);
 	release_mem_region(0x80060000, 0x60);
 
Only in linux-rmk/drivers/misc: mcp.h
--- linux-rmk/drivers/misc/ucb1x00-assabet.c	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/ucb1x00-assabet.c	2005-07-21 06:55:31.000000000 +0200
@@ -35,34 +35,34 @@
 UCB1X00_ATTR(vcharger, UCB_ADC_INP_AD0);
 UCB1X00_ATTR(batt_temp, UCB_ADC_INP_AD2);
 
-static int ucb1x00_assabet_add(struct ucb1x00_dev *dev)
+static int ucb1x00_assabet_add(struct class_device *dev)
 {
-	class_device_create_file(&dev->ucb->cdev, &class_device_attr_vbatt);
-	class_device_create_file(&dev->ucb->cdev, &class_device_attr_vcharger);
-	class_device_create_file(&dev->ucb->cdev, &class_device_attr_batt_temp);
+	class_device_create_file(dev, &class_device_attr_vbatt);
+	class_device_create_file(dev, &class_device_attr_vcharger);
+	class_device_create_file(dev, &class_device_attr_batt_temp);
 	return 0;
 }
 
-static void ucb1x00_assabet_remove(struct ucb1x00_dev *dev)
+static void ucb1x00_assabet_remove(struct class_device *dev)
 {
-	class_device_remove_file(&dev->ucb->cdev, &class_device_attr_batt_temp);
-	class_device_remove_file(&dev->ucb->cdev, &class_device_attr_vcharger);
-	class_device_remove_file(&dev->ucb->cdev, &class_device_attr_vbatt);
+	class_device_remove_file(dev, &class_device_attr_batt_temp);
+	class_device_remove_file(dev, &class_device_attr_vcharger);
+	class_device_remove_file(dev, &class_device_attr_vbatt);
 }
 
-static struct ucb1x00_driver ucb1x00_assabet_driver = {
+static struct class_interface ucb1x00_assabet_interface = {
 	.add	= ucb1x00_assabet_add,
 	.remove	= ucb1x00_assabet_remove,
 };
 
 static int __init ucb1x00_assabet_init(void)
 {
-	return ucb1x00_register_driver(&ucb1x00_assabet_driver);
+	return ucb1x00_register_interface(&ucb1x00_assabet_interface);
 }
 
 static void __exit ucb1x00_assabet_exit(void)
 {
-	ucb1x00_unregister_driver(&ucb1x00_assabet_driver);
+	ucb1x00_unregister_interface(&ucb1x00_assabet_interface);
 }
 
 module_init(ucb1x00_assabet_init);
--- linux-rmk/drivers/misc/ucb1x00-audio.c	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/ucb1x00-audio.c	2005-07-21 06:55:31.000000000 +0200
@@ -50,11 +50,6 @@
 	unsigned short		input_level;
 };
 
-struct ucb1x00_devdata {
-	struct ucb1x00_audio	audio;
-	struct ucb1x00_audio	telecom;
-};
-
 #define REC_MASK	(SOUND_MASK_VOLUME | SOUND_MASK_MIC)
 #define DEV_MASK	REC_MASK
 
@@ -285,122 +280,134 @@
 	return sa1100_audio_attach(inode, file, &ucba->state);
 }
 
-static int
-ucb1x00_audio_add_one(struct ucb1x00 *ucb, struct ucb1x00_audio *a, int telecom)
+static struct ucb1x00_audio *ucb1x00_audio_alloc(struct ucb1x00 *ucb)
 {
-	memset(a, 0, sizeof(*a));
+	struct ucb1x00_audio *ucba;
 
-	a->magic = MAGIC;
-	a->ucb = ucb;
-	a->fops.owner = THIS_MODULE;
-	a->fops.open  = ucb1x00_audio_open;
-	a->mops.owner = THIS_MODULE;
-	a->mops.ioctl = ucb1x00_mixer_ioctl;
-	a->state.output_stream = &a->output_stream;
-	a->state.input_stream = &a->input_stream;
-	a->state.data = a;
-	a->state.hw_init = ucb1x00_audio_startup;
-	a->state.hw_shutdown = ucb1x00_audio_shutdown;
-	a->state.client_ioctl = ucb1x00_audio_ioctl;
-
-	/* There is a bug in the StrongARM causes corrupt MCP data to be sent to
-	 * the codec when the FIFOs are empty and writes are made to the OS timer
-	 * match register 0. To avoid this we must make sure that data is always
-	 * sent to the codec.
-	 */
-	a->state.need_tx_for_rx = 1;
+	ucba = kmalloc(sizeof(*ucba), GFP_KERNEL);
+	if (ucba) {
+		memset(ucba, 0, sizeof(*ucba));
+
+		ucba->magic = MAGIC;
+		ucba->ucb = ucb;
+		ucba->fops.owner = THIS_MODULE;
+		ucba->fops.open  = ucb1x00_audio_open;
+		ucba->mops.owner = THIS_MODULE;
+		ucba->mops.ioctl = ucb1x00_mixer_ioctl;
+		ucba->state.output_stream = &ucba->output_stream;
+		ucba->state.input_stream = &ucba->input_stream;
+		ucba->state.data = ucba;
+		ucba->state.hw_init = ucb1x00_audio_startup;
+		ucba->state.hw_shutdown = ucb1x00_audio_shutdown;
+		ucba->state.client_ioctl = ucb1x00_audio_ioctl;
+
+		/* There is a bug in the StrongARM causes corrupt MCP data to be sent to
+		 * the codec when the FIFOs are empty and writes are made to the OS timer
+		 * match register 0. To avoid this we must make sure that data is always
+		 * sent to the codec.
+		 */
+		ucba->state.need_tx_for_rx = 1;
+
+		init_MUTEX(&ucba->state.sem);
+		ucba->rate = 8000;
+	}
+	return ucba;
+}
+
+static struct ucb1x00_audio *ucb1x00_audio_add_one(struct ucb1x00 *ucb, int telecom)
+{
+	struct ucb1x00_audio *a;
 
-	init_MUTEX(&a->state.sem);
-	a->rate = 8000;
-	a->telecom = telecom;
-	a->input_stream.dev = ucb->cdev.dev;
-	a->output_stream.dev = ucb->cdev.dev;
-	a->ctrl_a = 0;
-
-	if (a->telecom) {
-		a->input_stream.dma_dev = ucb->mcp->dma_telco_rd;
-		a->input_stream.id = "UCB1x00 telco in";
-		a->output_stream.dma_dev = ucb->mcp->dma_telco_wr;
-		a->output_stream.id = "UCB1x00 telco out";
-		a->ctrl_b = UCB_TC_B_IN_ENA|UCB_TC_B_OUT_ENA;
+	a = ucb1x00_audio_alloc(ucb);
+	if (a) {
+		a->telecom = telecom;
+
+		a->input_stream.dev = ucb->cdev.dev;
+		a->output_stream.dev = ucb->cdev.dev;
+		a->ctrl_a = 0;
+
+		if (a->telecom) {
+			a->input_stream.dma_dev = ucb->mcp->dma_telco_rd;
+			a->input_stream.id = "UCB1x00 telco in";
+			a->output_stream.dma_dev = ucb->mcp->dma_telco_wr;
+			a->output_stream.id = "UCB1x00 telco out";
+			a->ctrl_b = UCB_TC_B_IN_ENA|UCB_TC_B_OUT_ENA;
 #if 0
-		a->daa_oh_bit = UCB_IO_8;
+			a->daa_oh_bit = UCB_IO_8;
 
-		ucb1x00_enable(ucb);
-		ucb1x00_io_write(ucb, a->daa_oh_bit, 0);
-		ucb1x00_io_set_dir(ucb, UCB_IO_7 | UCB_IO_6, a->daa_oh_bit);
-		ucb1x00_disable(ucb);
+			ucb1x00_enable(ucb);
+			ucb1x00_io_write(ucb, a->daa_oh_bit, 0);
+			ucb1x00_io_set_dir(ucb, UCB_IO_7 | UCB_IO_6, a->daa_oh_bit);
+			ucb1x00_disable(ucb);
 #endif
-	} else {
-		a->input_stream.dma_dev  = ucb->mcp->dma_audio_rd;
-		a->input_stream.id = "UCB1x00 audio in";
-		a->output_stream.dma_dev = ucb->mcp->dma_audio_wr;
-		a->output_stream.id = "UCB1x00 audio out";
-		a->ctrl_b = UCB_AC_B_IN_ENA|UCB_AC_B_OUT_ENA;
-	}
+		} else {
+			a->input_stream.dma_dev  = ucb->mcp->dma_audio_rd;
+			a->input_stream.id = "UCB1x00 audio in";
+			a->output_stream.dma_dev = ucb->mcp->dma_audio_wr;
+			a->output_stream.id = "UCB1x00 audio out";
+			a->ctrl_b = UCB_AC_B_IN_ENA|UCB_AC_B_OUT_ENA;
+		}
 
-	a->dev_id = register_sound_dsp(&a->fops, -1);
-	a->mix_id = register_sound_mixer(&a->mops, -1);
+		a->dev_id = register_sound_dsp(&a->fops, -1);
+		a->mix_id = register_sound_mixer(&a->mops, -1);
 
-	printk("Sound: UCB1x00 %s: dsp id %d mixer id %d\n",
-		a->telecom ? "telecom" : "audio",
-		a->dev_id, a->mix_id);
+		printk("Sound: UCB1x00 %s: dsp id %d mixer id %d\n",
+			a->telecom ? "telecom" : "audio",
+			a->dev_id, a->mix_id);
+	}
 
-	return 0;
+	return a;
 }
 
 static void ucb1x00_audio_remove_one(struct ucb1x00_audio *a)
 {
 	unregister_sound_dsp(a->dev_id);
 	unregister_sound_mixer(a->mix_id);
+	kfree(a);
 }
 
-static int ucb1x00_audio_add(struct ucb1x00_dev *dev)
+static int ucb1x00_audio_add(struct class_device *cdev)
 {
-	struct ucb1x00_devdata *dd;
-	struct ucb1x00 *ucb = dev->ucb;
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(cdev);
 
 	if (ucb->cdev.dev == NULL || ucb->cdev.dev->dma_mask == NULL)
 		return -ENXIO;
 
-	dd = kmalloc(sizeof(struct ucb1x00_devdata), GFP_KERNEL);
-	if (!dd)
-		return -ENOMEM;
-
-	ucb1x00_audio_add_one(ucb, &dd->audio, 0);
-	ucb1x00_audio_add_one(ucb, &dd->telecom, 1);
-
-	dev->priv = dd;
+	ucb->audio_data = ucb1x00_audio_add_one(ucb, 0);
+	ucb->telecom_data = ucb1x00_audio_add_one(ucb, 1);
 
 	return 0;
 }
 
-static void ucb1x00_audio_remove(struct ucb1x00_dev *dev)
+static void ucb1x00_audio_remove(struct class_device *cdev)
 {
-	struct ucb1x00_devdata *dd = dev->priv;
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(cdev);
 
-	ucb1x00_audio_remove_one(&dd->audio);
-	ucb1x00_audio_remove_one(&dd->telecom);
-	kfree(dd);
+	ucb1x00_audio_remove_one(ucb->audio_data);
+	ucb1x00_audio_remove_one(ucb->telecom_data);
 }
 
-#ifdef CONFIG_PM
-static int ucb1x00_audio_suspend(struct ucb1x00_dev *dev, pm_message_t state)
+#if 0 //def CONFIG_PM
+static int ucb1x00_audio_suspend(struct ucb1x00 *ucb, u32 state)
 {
-	struct ucb1x00_devdata *dd = dev->priv;
+	struct ucb1x00_audio *a;
 
-	sa1100_audio_suspend(&dd->audio.state, state);
-	sa1100_audio_suspend(&dd->telecom.state, state);
+	a = ucb->audio_data;
+	sa1100_audio_suspend(&a->state, state);
+	a = ucb->telecom_data;
+	sa1100_audio_suspend(&a->state, state);
 
 	return 0;
 }
 
-static int ucb1x00_audio_resume(struct ucb1x00_dev *dev)
+static int ucb1x00_audio_resume(struct ucb1x00 *ucb)
 {
-	struct ucb1x00_devdata *dd = dev->priv;
+	struct ucb1x00_audio *a;
 
-	sa1100_audio_resume(&dd->audio.state);
-	sa1100_audio_resume(&dd->telecom.state);
+	a = ucb->audio_data;
+	sa1100_audio_resume(&a->state);
+	a = ucb->telecom_data;
+	sa1100_audio_resume(&a->state);
 
 	return 0;
 }
@@ -409,21 +416,19 @@
 #define ucb1x00_audio_resume	NULL
 #endif
 
-static struct ucb1x00_driver ucb1x00_audio_driver = {
+static struct class_interface ucb1x00_audio_interface = {
 	.add		= ucb1x00_audio_add,
 	.remove		= ucb1x00_audio_remove,
-	.suspend	= ucb1x00_audio_suspend,
-	.resume		= ucb1x00_audio_resume,
 };
 
 static int __init ucb1x00_audio_init(void)
 {
-	return ucb1x00_register_driver(&ucb1x00_audio_driver);
+	return ucb1x00_register_interface(&ucb1x00_audio_interface);
 }
 
 static void __exit ucb1x00_audio_exit(void)
 {
-	ucb1x00_unregister_driver(&ucb1x00_audio_driver);
+	ucb1x00_unregister_interface(&ucb1x00_audio_interface);
 }
 
 module_init(ucb1x00_audio_init);
--- linux-rmk/drivers/misc/ucb1x00-core.c	2005-07-25 05:17:11.000000000 +0200
+++ linux-z/drivers/misc/ucb1x00-core.c	2005-07-22 03:28:07.000000000 +0200
@@ -29,11 +29,7 @@
 #include <asm/hardware.h>
 #include <asm/irq.h>
 
-#include "ucb1x00.h"
-
-static DECLARE_MUTEX(ucb1x00_sem);
-static LIST_HEAD(ucb1x00_drivers);
-static LIST_HEAD(ucb1x00_devices);
+#include <asm/arch-sa1100/ucb1x00.h>
 
 /**
  *	ucb1x00_io_set_dir - set IO direction
@@ -58,9 +54,9 @@
 	spin_lock_irqsave(&ucb->io_lock, flags);
 	ucb->io_dir |= out;
 	ucb->io_dir &= ~in;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
-	spin_unlock_irqrestore(&ucb->io_lock, flags);
 }
 
 /**
@@ -86,9 +82,9 @@
 	spin_lock_irqsave(&ucb->io_lock, flags);
 	ucb->io_out |= set;
 	ucb->io_out &= ~clear;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
-	spin_unlock_irqrestore(&ucb->io_lock, flags);
 }
 
 /**
@@ -174,7 +170,7 @@
 		if (val & UCB_ADC_DAT_VAL)
 			break;
 		/* yield to other processes */
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 
@@ -223,6 +219,57 @@
 	return IRQ_HANDLED;
 }
 
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
 /**
  *	ucb1x00_hook_irq - hook a UCB1x00 interrupt
  *	@ucb:   UCB1x00 structure describing chip
@@ -276,18 +323,22 @@
 
 	if (idx < 16) {
 		spin_lock_irqsave(&ucb->lock, flags);
-
-		ucb1x00_enable(ucb);
-		if (edges & UCB_RISING) {
+		if (edges & UCB_RISING)
 			ucb->irq_ris_enbl |= 1 << idx;
-			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		}
-		if (edges & UCB_FALLING) {
+		if (edges & UCB_FALLING)
 			ucb->irq_fal_enbl |= 1 << idx;
-			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		}
-		ucb1x00_disable(ucb);
 		spin_unlock_irqrestore(&ucb->lock, flags);
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
 	}
 }
 
@@ -305,18 +356,16 @@
 
 	if (idx < 16) {
 		spin_lock_irqsave(&ucb->lock, flags);
-
-		ucb1x00_enable(ucb);
-		if (edges & UCB_RISING) {
+		if (edges & UCB_RISING)
 			ucb->irq_ris_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		}
-		if (edges & UCB_FALLING) {
+		if (edges & UCB_FALLING)
 			ucb->irq_fal_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		}
-		ucb1x00_disable(ucb);
 		spin_unlock_irqrestore(&ucb->lock, flags);
+
+		ucb1x00_enable(ucb);
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+		ucb1x00_disable(ucb);
 	}
 }
 
@@ -349,16 +398,17 @@
 		ucb->irq_ris_enbl &= ~(1 << idx);
 		ucb->irq_fal_enbl &= ~(1 << idx);
 
-		ucb1x00_enable(ucb);
-		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		ucb1x00_disable(ucb);
-
 		irq->fn = NULL;
 		irq->devid = NULL;
 		ret = 0;
 	}
 	spin_unlock_irq(&ucb->lock);
+
+	ucb1x00_enable(ucb);
+	ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+	ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+	ucb1x00_disable(ucb);
+
 	return ret;
 
 bad:
@@ -366,36 +416,6 @@
 	return -EINVAL;
 }
 
-static int ucb1x00_add_dev(struct ucb1x00 *ucb, struct ucb1x00_driver *drv)
-{
-	struct ucb1x00_dev *dev;
-	int ret = -ENOMEM;
-
-	dev = kmalloc(sizeof(struct ucb1x00_dev), GFP_KERNEL);
-	if (dev) {
-		dev->ucb = ucb;
-		dev->drv = drv;
-
-		ret = drv->add(dev);
-
-		if (ret == 0) {
-			list_add(&dev->dev_node, &ucb->devs);
-			list_add(&dev->drv_node, &drv->devs);
-		} else {
-			kfree(dev);
-		}
-	}
-	return ret;
-}
-
-static void ucb1x00_remove_dev(struct ucb1x00_dev *dev)
-{
-	dev->drv->remove(dev);
-	list_del(&dev->dev_node);
-	list_del(&dev->drv_node);
-	kfree(dev);
-}
-
 /*
  * Try to probe our interrupt, rather than relying on lots of
  * hard-coded machine dependencies.  For reference, the expected
@@ -460,17 +480,16 @@
 static int ucb1x00_probe(struct mcp *mcp)
 {
 	struct ucb1x00 *ucb;
-	struct ucb1x00_driver *drv;
 	unsigned int id;
 	int ret = -ENODEV;
 
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
+	/*if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_1400) {
 		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
 		goto err_disable;
-	}
+	}*/
 
 	ucb = kmalloc(sizeof(struct ucb1x00), GFP_KERNEL);
 	ret = -ENOMEM;
@@ -480,15 +499,20 @@
 	memset(ucb, 0, sizeof(struct ucb1x00));
 
 	ucb->cdev.class = &ucb1x00_class;
-	ucb->cdev.dev = &mcp->attached_device;
+	ucb->cdev.dev = mcp->attached_device;
 	strlcpy(ucb->cdev.class_id, "ucb1x00", sizeof(ucb->cdev.class_id));
 
 	spin_lock_init(&ucb->lock);
 	spin_lock_init(&ucb->io_lock);
 	sema_init(&ucb->adc_sem, 1);
+	init_waitqueue_head(&ucb->irq_wait);
 
-	ucb->id  = id;
 	ucb->mcp = mcp;
+	ucb->id  = id;
+	/* distinguish between UCB1400 revs 1B and 2A */
+	if (id == UCB_ID_1400 && mcp_reg_read(mcp, 0x00) == 0x002a)
+		ucb->id = UCB_ID_1400_BUGGY;
+
 	ucb->irq = ucb1x00_detect_irq(ucb);
 	if (ucb->irq == NO_IRQ) {
 		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
@@ -496,7 +520,9 @@
 		goto err_free;
 	}
 
-	ret = request_irq(ucb->irq, ucb1x00_irq, 0, "UCB1x00", ucb);
+	ret = request_irq(ucb->irq,
+			  id != UCB_ID_1400 ? ucb1x00_irq : ucb1x00_threaded_irq,
+			  0, "UCB1x00", ucb);
 	if (ret) {
 		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
 			ucb->irq, ret);
@@ -507,43 +533,36 @@
 	mcp_set_drvdata(mcp, ucb);
 
 	ret = class_device_register(&ucb->cdev);
-	if (ret)
-		goto err_irq;
 
-	INIT_LIST_HEAD(&ucb->devs);
-	down(&ucb1x00_sem);
-	list_add(&ucb->node, &ucb1x00_devices);
-	list_for_each_entry(drv, &ucb1x00_drivers, node) {
-		ucb1x00_add_dev(ucb, drv);
+	if (!ret && id == UCB_ID_1400) {
+		init_completion(&ucb->complete);
+		ret = kernel_thread(ucb1x00_thread, ucb, CLONE_KERNEL);
+		if (ret >= 0) {
+			wait_for_completion(&ucb->complete);
+			ret = 0;
+		}
 	}
-	up(&ucb1x00_sem);
-	goto out;
 
- err_irq:
-	free_irq(ucb->irq, ucb);
+	if (ret) {
+		free_irq(ucb->irq, ucb);
  err_free:
-	kfree(ucb);
+		kfree(ucb);
+	}
  err_disable:
 	mcp_disable(mcp);
- out:
 	return ret;
 }
 
 static void ucb1x00_remove(struct mcp *mcp)
 {
 	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
-	struct list_head *l, *n;
 
-	down(&ucb1x00_sem);
-	list_del(&ucb->node);
-	list_for_each_safe(l, n, &ucb->devs) {
-		struct ucb1x00_dev *dev = list_entry(l, struct ucb1x00_dev, dev_node);
-		ucb1x00_remove_dev(dev);
+	class_device_unregister(&ucb->cdev);
+	if (ucb->id == UCB_ID_1400 || ucb->id == UCB_ID_1400_BUGGY) {
+		send_sig(SIGKILL, ucb->irq_task, 1);
+		wait_for_completion(&ucb->complete);
 	}
-	up(&ucb1x00_sem);
-
 	free_irq(ucb->irq, ucb);
-	class_device_unregister(&ucb->cdev);
 }
 
 static void ucb1x00_release(struct class_device *dev)
@@ -557,59 +576,15 @@
 	.release	= ucb1x00_release,
 };
 
-int ucb1x00_register_driver(struct ucb1x00_driver *drv)
-{
-	struct ucb1x00 *ucb;
-
-	INIT_LIST_HEAD(&drv->devs);
-	down(&ucb1x00_sem);
-	list_add(&drv->node, &ucb1x00_drivers);
-	list_for_each_entry(ucb, &ucb1x00_devices, node) {
-		ucb1x00_add_dev(ucb, drv);
-	}
-	up(&ucb1x00_sem);
-	return 0;
-}
-
-void ucb1x00_unregister_driver(struct ucb1x00_driver *drv)
+int ucb1x00_register_interface(struct class_interface *intf)
 {
-	struct list_head *n, *l;
-
-	down(&ucb1x00_sem);
-	list_del(&drv->node);
-	list_for_each_safe(l, n, &drv->devs) {
-		struct ucb1x00_dev *dev = list_entry(l, struct ucb1x00_dev, drv_node);
-		ucb1x00_remove_dev(dev);
-	}
-	up(&ucb1x00_sem);
+	intf->class = &ucb1x00_class;
+	return class_interface_register(intf);
 }
 
-static int ucb1x00_suspend(struct mcp *mcp, pm_message_t state)
+void ucb1x00_unregister_interface(struct class_interface *intf)
 {
-	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
-	struct ucb1x00_dev *dev;
-
-	down(&ucb1x00_sem);
-	list_for_each_entry(dev, &ucb->devs, dev_node) {
-		if (dev->drv->suspend)
-			dev->drv->suspend(dev, state);
-	}
-	up(&ucb1x00_sem);
-	return 0;
-}
-
-static int ucb1x00_resume(struct mcp *mcp)
-{
-	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
-	struct ucb1x00_dev *dev;
-
-	down(&ucb1x00_sem);
-	list_for_each_entry(dev, &ucb->devs, dev_node) {
-		if (dev->drv->resume)
-			dev->drv->resume(dev);
-	}
-	up(&ucb1x00_sem);
-	return 0;
+	class_interface_unregister(intf);
 }
 
 static struct mcp_driver ucb1x00_driver = {
@@ -618,8 +593,6 @@
 	},
 	.probe		= ucb1x00_probe,
 	.remove		= ucb1x00_remove,
-	.suspend	= ucb1x00_suspend,
-	.resume		= ucb1x00_resume,
 };
 
 static int __init ucb1x00_init(void)
@@ -657,8 +630,8 @@
 EXPORT_SYMBOL(ucb1x00_enable_irq);
 EXPORT_SYMBOL(ucb1x00_disable_irq);
 
-EXPORT_SYMBOL(ucb1x00_register_driver);
-EXPORT_SYMBOL(ucb1x00_unregister_driver);
+EXPORT_SYMBOL(ucb1x00_register_interface);
+EXPORT_SYMBOL(ucb1x00_unregister_interface);
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("UCB1x00 core driver");
Only in linux-rmk/drivers/misc: ucb1x00-ts.c
Only in linux-rmk/drivers/misc: ucb1x00.h
--- /dev/null	2005-07-11 13:10:49.000000000 +0200
+++ linux-z/drivers/input/touchscreen/collie_ts.c	2005-07-23 14:13:28.000000000 +0200
@@ -0,0 +1,367 @@
+/*
+ *  linux/drivers/input/touchscreen/collie_ts.c
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * 21-Jan-2002 <jco@ict.es> :
+ *
+ * Added support for synchronous A/D mode. This mode is useful to
+ * avoid noise induced in the touchpanel by the LCD, provided that
+ * the UCB1x00 has a valid LCD sync signal routed to its ADCSYNC pin.
+ * It is important to note that the signal connected to the ADCSYNC
+ * pin should provide pulses even when the LCD is blanked, otherwise
+ * a pen touch needed to unblank the LCD will never be read.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+
+#include <asm/dma.h>
+#include <asm/semaphore.h>
+
+#include <asm/arch-sa1100/ucb1x00.h>
+
+
+struct ucb1x00_ts {
+	struct input_dev	idev;
+	struct ucb1x00		*ucb;
+
+	struct semaphore	irq_wait;
+	struct task_struct	*rtask;
+	u16			x_res;
+	u16			y_res;
+
+	int			restart:1;
+	int			adcsync:1;
+};
+
+/*
+ * Switch to interrupt mode.
+ */
+static inline void ucb1x00_ts_mode_int(struct ucb1x00_ts *ts)
+{
+	int val = UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+		  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+		  UCB_TS_CR_MODE_INT;
+	if (ts->ucb->id == UCB_ID_1400_BUGGY)
+		val &= ~(UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, val);
+}
+
+/*
+ * Switch to pressure mode, and read pressure.  We don't need to wait
+ * here, since both plates are being driven.
+ */
+static inline unsigned int ucb1x00_ts_read_pressure(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+}
+
+/*
+ * Switch to X position mode and measure Y plate.  We switch the plate
+ * configuration in pressure mode, then switch to position mode.  This
+ * gives a faster response time.  Even so, we need to wait about 55us
+ * for things to stabilise.
+ */
+static inline unsigned int ucb1x00_ts_read_xpos(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
+
+	udelay(55);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+}
+
+/*
+ * Switch to Y position mode and measure X plate.  We switch the plate
+ * configuration in pressure mode, then switch to position mode.  This
+ * gives a faster response time.  Even so, we need to wait about 55us
+ * for things to stabilise.
+ */
+static inline unsigned int ucb1x00_ts_read_ypos(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
+
+	udelay(55);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPX, ts->adcsync);
+}
+
+/*
+ * Switch to X plate resistance mode.  Set MX to ground, PX to
+ * supply.  Measure current.
+ */
+static inline unsigned int ucb1x00_ts_read_xres(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+}
+
+/*
+ * Switch to Y plate resistance mode.  Set MY to ground, PY to
+ * supply.  Measure current.
+ */
+static inline unsigned int ucb1x00_ts_read_yres(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+}
+
+/*
+ * This is a RT kernel thread that handles the ADC accesses
+ * (mainly so we can use semaphores in the UCB1200 core code
+ * to serialise accesses to the ADC).  The UCB1400 access
+ * functions are expected to be able to sleep as well.
+ */
+static int ucb1x00_thread(void *_ts)
+{
+	struct ucb1x00_ts *ts = _ts;
+	struct task_struct *tsk = current;
+	int valid;
+
+	ts->rtask = tsk;
+
+	/*
+	 * We run as a real-time thread.  However, thus far
+	 * this doesn't seem to be necessary.
+	 */
+	tsk->policy = SCHED_FIFO;
+	tsk->rt_priority = 1;
+
+	valid = 0;
+	for (;;) {
+		unsigned int x, y, p, val;
+
+		ts->restart = 0;
+
+		ucb1x00_adc_enable(ts->ucb);
+
+		x = ucb1x00_ts_read_xpos(ts);
+		y = ucb1x00_ts_read_ypos(ts);
+		p = ucb1x00_ts_read_pressure(ts);
+
+		/*
+		 * Switch back to interrupt mode.
+		 */
+		ucb1x00_ts_mode_int(ts);
+		ucb1x00_adc_disable(ts->ucb);
+
+		msleep(10);
+
+		ucb1x00_enable(ts->ucb);
+		val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
+
+		if (val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW)) {
+			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+			ucb1x00_disable(ts->ucb);
+
+			/*
+			 * If we spat out a valid sample set last time,
+			 * spit out a "pen off" sample here.
+			 */
+			if (valid) {
+				input_report_abs(&ts->idev, ABS_PRESSURE, 0);
+				input_sync(&ts->idev);
+				valid = 0;
+			}
+
+			/*
+			 * Since ucb1x00_enable_irq() might sleep due
+			 * to the way the UCB1400 regs are accessed, we
+			 * can't use set_task_state() before that call,
+			 * and not changing state before enabling the
+			 * interrupt is racy.  A semaphore solves all
+			 * those issues quite nicely.
+			 */
+			down_interruptible(&ts->irq_wait);
+		} else {
+			ucb1x00_disable(ts->ucb);
+
+			/*
+			 * Filtering is policy.  Policy belongs in user
+			 * space.  We therefore leave it to user space
+			 * to do any filtering they please.
+			 */
+			if (!ts->restart) {
+				input_report_abs(&ts->idev, ABS_X, x);
+				input_report_abs(&ts->idev, ABS_Y, y);
+				input_report_abs(&ts->idev, ABS_PRESSURE, p);
+				input_sync(&ts->idev);
+				valid = 1;
+			}
+
+			msleep_interruptible(10);
+		}
+
+		if (kthread_should_stop())
+			break;
+	}
+
+	ts->rtask = NULL;
+	return 0;
+}
+
+/*
+ * We only detect touch screen _touches_ with this interrupt
+ * handler, and even then we just schedule our task.
+ */
+static void ucb1x00_ts_irq(int idx, void *id)
+{
+	struct ucb1x00_ts *ts = id;
+	ucb1x00_disable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+	up(&ts->irq_wait);
+}
+
+static int ucb1x00_ts_open(struct input_dev *idev)
+{
+	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+	int ret = 0;
+	struct task_struct *task;
+
+	BUG_ON(ts->rtask);
+
+	sema_init(&ts->irq_wait, 0);
+	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If we do this at all, we should allow the user to
+	 * measure and read the X and Y resistance at any time.
+	 */
+	ucb1x00_adc_enable(ts->ucb);
+	ts->x_res = ucb1x00_ts_read_xres(ts);
+	ts->y_res = ucb1x00_ts_read_yres(ts);
+	ucb1x00_adc_disable(ts->ucb);
+
+	task = kthread_run(ucb1x00_thread, ts, "ktsd");
+	if (!IS_ERR(task)) {
+		ret = 0;
+	} else {
+		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+		ret = -EFAULT;
+	}
+
+ out:
+	return ret;
+}
+
+/*
+ * Release touchscreen resources.  Disable IRQs.
+ */
+static void ucb1x00_ts_close(struct input_dev *idev)
+{
+	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+
+	if (ts->rtask)
+		kthread_stop(ts->rtask);
+
+	ucb1x00_enable(ts->ucb);
+	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
+	ucb1x00_disable(ts->ucb);
+}
+
+/*
+ * Initialisation.
+ */
+static int ucb1x00_ts_add(struct class_device *dev)
+{
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(dev);
+	struct ucb1x00_ts *ts;
+
+	ts = kmalloc(sizeof(struct ucb1x00_ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	memset(ts, 0, sizeof(struct ucb1x00_ts));
+
+	ts->ucb = ucb;
+	ts->adcsync = UCB_NOSYNC;
+
+	ts->idev.name       = "Touchscreen panel";
+	ts->idev.id.product = ts->ucb->id;
+	ts->idev.open       = ucb1x00_ts_open;
+	ts->idev.close      = ucb1x00_ts_close;
+
+	set_bit(EV_ABS, ts->idev.evbit);
+	set_bit(ABS_X, ts->idev.absbit);
+	set_bit(ABS_Y, ts->idev.absbit);
+	set_bit(ABS_PRESSURE, ts->idev.absbit);
+
+	input_register_device(&ts->idev);
+
+	ucb->ts_data = ts;
+
+	return 0;
+}
+
+static void ucb1x00_ts_remove(struct class_device *dev)
+{
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(dev);
+	struct ucb1x00_ts *ts = ucb->ts_data;
+
+	input_unregister_device(&ts->idev);
+	kfree(ts);
+}
+
+static struct class_interface ucb1x00_ts_interface = {
+	.add		= ucb1x00_ts_add,
+	.remove		= ucb1x00_ts_remove,
+};
+
+static int __init ucb1x00_ts_init(void)
+{
+	return ucb1x00_register_interface(&ucb1x00_ts_interface);
+}
+
+static void __exit ucb1x00_ts_exit(void)
+{
+	ucb1x00_unregister_interface(&ucb1x00_ts_interface);
+}
+
+module_init(ucb1x00_ts_init);
+module_exit(ucb1x00_ts_exit);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("UCB1x00 touchscreen driver");
+MODULE_LICENSE("GPL");


-- 
teflon -- maybe it is a trademark, but it should not be.
