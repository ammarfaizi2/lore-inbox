Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263632AbRFARgn>; Fri, 1 Jun 2001 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263638AbRFARgd>; Fri, 1 Jun 2001 13:36:33 -0400
Received: from ns.caldera.de ([212.34.180.1]:60564 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263637AbRFARgR>;
	Fri, 1 Jun 2001 13:36:17 -0400
Date: Fri, 1 Jun 2001 19:35:33 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: cs4232 isapnp support
Message-ID: <20010601193533.A14769@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds ISAPnP support to cs4232.c.


It is missing MPU401 ISAPnP support only because my testcard does not 
have a MPU on it.  (If you sent me one that has, I will add it ;)

Note clever (?) use of probe_devs to remove instances again.

Knowledge on CSC0000/CSC0100 autoprobing guessing derived from the
Caldera Hardware Database.

Tested on IBM Netfinity 3500, which has an onboard cs4232 chip.

Ciao, Marcus

Index: drivers/sound/cs4232.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/cs4232.c,v
retrieving revision 1.10
diff -u -r1.10 cs4232.c
--- drivers/sound/cs4232.c	2001/05/27 18:06:09	1.10
+++ drivers/sound/cs4232.c	2001/06/01 17:26:52
@@ -42,9 +42,11 @@
  * 	Arnaldo C. de Melo	got rid of attach_uart401
  *	Bartlomiej Zolnierkiewicz
  *				Added some __init/__initdata/__exit
+ *	Marcus Meissner		Added ISA PnP support.
  */
 
 #include <linux/config.h>
+#include <linux/isapnp.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -95,7 +97,7 @@
 	schedule_timeout(howlong);
 }
 
-int __init probe_cs4232(struct address_info *hw_config)
+int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
 {
 	int i, n;
 	int base = hw_config->io_base, irq = hw_config->irq;
@@ -110,8 +112,13 @@
 		printk(KERN_ERR "cs4232.c: I/O port 0x%03x not free\n", base);
 		return 0;
 	}
-	if (ad1848_detect(hw_config->io_base, NULL, hw_config->osp))
+	if (ad1848_detect(hw_config->io_base, NULL, hw_config->osp)) {
 		return 1;	/* The card is already active */
+	}
+	if (isapnp_configured) {
+		printk(KERN_ERR "cs4232.c: ISA PnP configured, but not detected?\n");
+		return 0;
+	}
 
 	/*
 	 * This version of the driver doesn't use the PnP method when configuring
@@ -318,22 +325,92 @@
 static int __initdata mpuirq	= -1;
 static int __initdata synthio	= -1;
 static int __initdata synthirq	= -1;
-
+static int __initdata isapnp	= 1;
 
+MODULE_DESCRIPTION("CS4232 based soundcard driver"); 
+MODULE_AUTHOR("Hannu Savolainen, Paul Barton-Davis"); 
 MODULE_PARM(io,"i");
+MODULE_PARM_DESC(io,"base I/O port for AD1848");
 MODULE_PARM(irq,"i");
+MODULE_PARM_DESC(irq,"IRQ for AD1848 chip");
 MODULE_PARM(dma,"i");
+MODULE_PARM_DESC(dma,"8 bit DMA for AD1848 chip");
 MODULE_PARM(dma2,"i");
+MODULE_PARM_DESC(dma2,"16 bit DMA for AD1848 chip");
 MODULE_PARM(mpuio,"i");
+MODULE_PARM_DESC(mpuio,"MPU 401 base address");
 MODULE_PARM(mpuirq,"i");
+MODULE_PARM_DESC(mpuirq,"MPU 401 IRQ");
 MODULE_PARM(synthio,"i");
+MODULE_PARM_DESC(synthio,"Maui WaveTable base I/O port");
 MODULE_PARM(synthirq,"i");
+MODULE_PARM_DESC(synthirq,"Maui WaveTable IRQ");
+MODULE_PARM(isapnp,"i");
+MODULE_PARM_DESC(isapnp,"Enable ISAPnP probing (default 1)");
 
 /*
  *	Install a CS4232 based card. Need to have ad1848 and mpu401
  *	loaded ready.
  */
 
+/* All cs4232 based cards have the main ad1848 card either as CSC0000 or
+ * CSC0100. */
+struct isapnp_device_id isapnp_cs4232_list[] __initdata = {
+	{       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100),
+		0 },
+	{       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0000),
+		0 },
+	/* Guillemot Turtlebeach something appears to be cs4232 compatible
+	 * (untested) */
+	{       ISAPNP_VENDOR('C','S','C'), ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('G','I','M'), ISAPNP_FUNCTION(0x0100),
+		0 },
+	{0}
+};
+
+MODULE_DEVICE_TABLE(isapnp, isapnp_cs4232_list);
+
+int cs4232_isapnp_probe(struct pci_dev *dev, const struct isapnp_device_id *id)
+{
+	int ret;
+	struct address_info *isapnpcfg;
+
+	isapnpcfg=(struct address_info*)kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);
+	if (!isapnpcfg) 
+		return -ENOMEM;
+	/*
+	 * If device is active, assume configured with /proc/isapnp
+	 * and use anyway. Any other way to check this?
+	 */
+	ret = dev->prepare(dev);
+	if(ret && ret != -EBUSY) {
+		printk(KERN_ERR "cs4232: ISA PnP found device that could not be autoconfigured.\n");
+		kfree(isapnpcfg);
+		return -ENODEV;
+	}
+	if(ret != -EBUSY) {
+		if(dev->activate(dev) < 0) {
+			printk(KERN_WARNING "cs4232: ISA PnP activate failed\n");
+			kfree(isapnpcfg);
+			return -ENODEV;
+		}
+	} /* else subfunction is already activated */
+
+	isapnpcfg->irq		= dev->irq_resource[0].start;
+	isapnpcfg->dma		= dev->dma_resource[0].start;
+	isapnpcfg->dma2		= dev->dma_resource[1].start;
+	isapnpcfg->io_base	= dev->resource[0].start;
+	if (probe_cs4232(isapnpcfg,TRUE) == 0) {
+		printk(KERN_ERR "cs4232: ISA PnP card found, but not detected?\n");
+		return -ENODEV;
+	}
+	attach_cs4232(isapnpcfg);
+	pci_set_drvdata(dev,isapnpcfg);
+	return 0;
+}
+
 static int __init init_cs4232(void)
 {
 #ifdef CONFIG_SOUND_WAVEFRONT_MODULE
@@ -347,6 +424,13 @@
 	if(synthio != -1)
 		printk(KERN_WARNING "cs4232: wavefront support not enabled in this driver.\n");
 #endif
+	cfg.irq = -1;
+
+	if (isapnp &&
+	    (isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_probe) > 0)
+	)
+		return 0;
+
 	if(io==-1||irq==-1||dma==-1)
 	{
 		printk(KERN_ERR "cs4232: Must set io, irq and dma.\n");
@@ -367,16 +451,27 @@
 		probe_cs4232_mpu(&cfg_mpu); /* Bug always returns 0 not OK -- AC */
 	}
 
-	if (probe_cs4232(&cfg) == 0)
+	if (probe_cs4232(&cfg,FALSE) == 0)
 		return -ENODEV;
 	attach_cs4232(&cfg);
 	
 	return 0;
 }
 
+int cs4232_isapnp_remove(struct pci_dev *dev, const struct isapnp_device_id *id)
+{
+	struct address_info *cfg = (struct address_info*)pci_get_drvdata(dev);
+	if (cfg) unload_cs4232(cfg);
+	pci_set_drvdata(dev,NULL);
+	dev->deactivate(dev);
+	return 0;
+}
+
 static void __exit cleanup_cs4232(void)
 {
-        unload_cs4232(&cfg); /* unloads MPU as well, if needed */
+	isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_remove);
+        if (cfg.irq != -1)
+		unload_cs4232(&cfg); /* Unloads global MPU as well, if needed */
 }
 
 module_init(init_cs4232);
@@ -387,6 +482,10 @@
 {
 	/* io, irq, dma, dma2 mpuio, mpuirq*/
 	int ints[7];
+
+	/* If we have isapnp cards, no need for options */
+	if (isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_probe) > 0)
+		return 1;
 	
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 	
Index: drivers/sound/cs4232.h
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/cs4232.h,v
retrieving revision 1.1
diff -u -r1.1 cs4232.h
--- drivers/sound/cs4232.h	2001/04/17 14:50:30	1.1
+++ drivers/sound/cs4232.h	2001/06/01 14:44:47
@@ -5,7 +5,7 @@
  *
  */
 
-int probe_cs4232 (struct address_info *hw_config);
+int probe_cs4232 (struct address_info *hw_config,int useisapnp);
 void attach_cs4232 (struct address_info *hw_config);
 int probe_cs4232_mpu (struct address_info *hw_config);
 void attach_cs4232_mpu (struct address_info *hw_config);
