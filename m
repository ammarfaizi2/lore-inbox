Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSJ2SmI>; Tue, 29 Oct 2002 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSJ2SmI>; Tue, 29 Oct 2002 13:42:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36365 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261874AbSJ2Slx>;
	Tue, 29 Oct 2002 13:41:53 -0500
Date: Tue, 29 Oct 2002 10:45:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP driver changes for 2.5.44
Message-ID: <20021029184541.GE27082@kroah.com>
References: <20021029184010.GA27082@kroah.com> <20021029184318.GB27082@kroah.com> <20021029184419.GC27082@kroah.com> <20021029184453.GD27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029184453.GD27082@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.808.4.4, 2002/10/24 00:26:22-07:00, ambx1@neo.rr.com

[PATCH] Convert CS4236B driver - 2.5.44 (3/4)

This patch converts the CS4236B sound card driver to the new PnP APIs.  Also it
makes pnp_driver_register return the number of matches during the driver add.
This should serve as a sample driver, along with the serial and parport_pc.


diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Oct 29 10:38:37 2002
+++ b/drivers/pnp/driver.c	Tue Oct 29 10:38:37 2002
@@ -151,6 +151,8 @@
 int pnp_register_driver(struct pnp_driver *drv)
 {
 	int count;
+	struct list_head *pos;
+
 	pnp_dbg("the driver '%s' has been registered", drv->name);
 
 	drv->driver.name = drv->name;
@@ -159,7 +161,15 @@
 	drv->driver.remove = pnp_device_remove;
 
 	count = driver_register(&drv->driver);
-	return count ? count : 1;
+
+	/* get the number of initial matches */
+	if (count >= 0){
+		count = 0;
+		list_for_each(pos,&drv->driver.devices){
+			count++;
+		}
+	}
+	return count;
 }
 
 void pnp_unregister_driver(struct pnp_driver *drv)
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Oct 29 10:38:37 2002
+++ b/include/linux/pnp.h	Tue Oct 29 10:38:37 2002
@@ -94,7 +94,6 @@
 	int  (*probe)  (struct pnp_dev *dev, const struct pnp_id *card_id,
 		 	const struct pnp_id *dev_id);
 	void (*remove) (struct pnp_dev *dev);
-	struct device * (*legacy) (void);
 	struct device_driver	driver;
 };
 
diff -Nru a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Tue Oct 29 10:38:37 2002
+++ b/sound/oss/ad1848.c	Tue Oct 29 10:38:37 2002
@@ -3026,8 +3026,6 @@
 {
 	char *busname = bus->name[0] ? bus->name : ad1848_isapnp_list[slot].name;
 
-	printk(KERN_INFO "ad1848: %s detected\n", busname);
-
 	/* Initialize this baby. */
 
 	if(ad1848_init_generic(bus, hw_config, slot)) {
@@ -3039,9 +3037,6 @@
 		       hw_config->dma2);
 		return 1;
 	}
-	else
-		printk(KERN_INFO "ad1848: Failed to initialize %s\n", busname);
-
 	return 0;
 }
 
diff -Nru a/sound/oss/cs4232.c b/sound/oss/cs4232.c
--- a/sound/oss/cs4232.c	Tue Oct 29 10:38:37 2002
+++ b/sound/oss/cs4232.c	Tue Oct 29 10:38:37 2002
@@ -46,7 +46,7 @@
  */
 
 #include <linux/config.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -71,7 +71,7 @@
 static int synth_base = 0, synth_irq = 0;
 static int mpu_detected = 0;
 
-int __init probe_cs4232_mpu(struct address_info *hw_config)
+int probe_cs4232_mpu(struct address_info *hw_config)
 {
 	/*
 	 *	Just write down the config values.
@@ -83,7 +83,7 @@
 	return 1;
 }
 
-static unsigned char crystal_key[] __initdata =	/* A 32 byte magic key sequence */
+static unsigned char crystal_key[] =	/* A 32 byte magic key sequence */
 {
 	0x96, 0x35, 0x9a, 0xcd, 0xe6, 0xf3, 0x79, 0xbc,
 	0x5e, 0xaf, 0x57, 0x2b, 0x15, 0x8a, 0xc5, 0xe2,
@@ -97,7 +97,7 @@
 	schedule_timeout(howlong);
 }
 
-int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
+int probe_cs4232(struct address_info *hw_config, int isapnp_configured)
 {
 	int i, n;
 	int base = hw_config->io_base, irq = hw_config->irq;
@@ -218,7 +218,7 @@
 	return 0;
 }
 
-void __init attach_cs4232(struct address_info *hw_config)
+void attach_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base,
 		irq = hw_config->irq,
@@ -277,7 +277,7 @@
 	}
 }
 
-static void __exit unload_cs4232(struct address_info *hw_config)
+static void unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
@@ -357,48 +357,24 @@
 
 /* All cs4232 based cards have the main ad1848 card either as CSC0000 or
  * CSC0100. */
-struct isapnp_device_id isapnp_cs4232_list[] __initdata = {
-	{       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100),
-		0 },
-	{       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0000),
-		0 },
+static const struct pnp_id cs4232_pnp_table[] = {
+	{ .id = "CSC0100", .driver_data = 0 },
+	{ .id = "CSC0000", .driver_data = 0 },
 	/* Guillemot Turtlebeach something appears to be cs4232 compatible
 	 * (untested) */
-	{       ISAPNP_VENDOR('C','S','C'), ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('G','I','M'), ISAPNP_FUNCTION(0x0100),
-		0 },
-	{0}
+	{ .id = "GIM0100", .driver_data = 0 },
+	{ .id = ""}
 };
 
-MODULE_DEVICE_TABLE(isapnp, isapnp_cs4232_list);
+/*MODULE_DEVICE_TABLE(isapnp, isapnp_cs4232_list);*/
 
-int cs4232_isapnp_probe(struct pci_dev *dev, const struct isapnp_device_id *id)
+static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
 {
-	int ret;
 	struct address_info *isapnpcfg;
 
 	isapnpcfg=(struct address_info*)kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);
-	if (!isapnpcfg) 
+	if (!isapnpcfg)
 		return -ENOMEM;
-	/*
-	 * If device is active, assume configured with /proc/isapnp
-	 * and use anyway. Any other way to check this?
-	 */
-	ret = dev->prepare(dev);
-	if(ret && ret != -EBUSY) {
-		printk(KERN_ERR "cs4232: ISA PnP found device that could not be autoconfigured.\n");
-		kfree(isapnpcfg);
-		return -ENODEV;
-	}
-	if(ret != -EBUSY) {
-		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING "cs4232: ISA PnP activate failed\n");
-			kfree(isapnpcfg);
-			return -ENODEV;
-		}
-	} /* else subfunction is already activated */
 
 	isapnpcfg->irq		= dev->irq_resource[0].start;
 	isapnpcfg->dma		= dev->dma_resource[0].start;
@@ -409,10 +385,25 @@
 		return -ENODEV;
 	}
 	attach_cs4232(isapnpcfg);
-	pci_set_drvdata(dev,isapnpcfg);
+	dev->driver_data = isapnpcfg;
 	return 0;
 }
 
+static void cs4232_pnp_remove(struct pnp_dev *dev)
+{
+	struct address_info *cfg = (struct address_info*) dev->driver_data;
+	if (cfg)
+		unload_cs4232(cfg);
+}
+
+static struct pnp_driver cs4232_driver = {
+	.name		= "cs4232",
+	.card_id_table	= NULL,
+	.id_table	= cs4232_pnp_table,
+	.probe		= cs4232_pnp_probe,
+	.remove		= cs4232_pnp_remove,
+};
+
 static int __init init_cs4232(void)
 {
 #ifdef CONFIG_SOUND_WAVEFRONT_MODULE
@@ -420,7 +411,7 @@
 		printk(KERN_INFO "cs4232: set synthio and synthirq to use the wavefront facilities.\n");
 	else {
 		synth_base = synthio;
-		synth_irq =  synthirq;	
+		synth_irq =  synthirq;
 	}
 #else
 	if(synthio != -1)
@@ -429,7 +420,7 @@
 	cfg.irq = -1;
 
 	if (isapnp &&
-	    (isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_probe) > 0)
+	    (pnp_register_driver(&cs4232_driver) > 0)
 	)
 		return 0;
 
@@ -456,24 +447,13 @@
 	if (probe_cs4232(&cfg,FALSE) == 0)
 		return -ENODEV;
 	attach_cs4232(&cfg);
-	
-	return 0;
-}
 
-static int __exit cs4232_isapnp_remove(struct pci_dev *dev,
-			const struct isapnp_device_id *id)
-{
-	struct address_info *cfg = (struct address_info*)pci_get_drvdata(dev);
-	if (cfg)
-		unload_cs4232(cfg);
-	pci_set_drvdata(dev,NULL);
-	dev->deactivate(dev);
 	return 0;
 }
 
 static void __exit cleanup_cs4232(void)
 {
-	isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_remove);
+	pnp_unregister_driver(&cs4232_driver);
         if (cfg.irq != -1)
 		unload_cs4232(&cfg); /* Unloads global MPU as well, if needed */
 }
@@ -488,7 +468,7 @@
 	int ints[7];
 
 	/* If we have isapnp cards, no need for options */
-	if (isapnp_probe_devs(isapnp_cs4232_list, cs4232_isapnp_probe) > 0)
+	if (pnp_register_driver(&cs4232_driver) > 0)
 		return 1;
 	
 	str = get_options(str, ARRAY_SIZE(ints), ints);
