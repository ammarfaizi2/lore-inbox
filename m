Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTENBsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTENBsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:48:51 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:7148
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261454AbTENBse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:48:34 -0400
Message-ID: <3EC1A368.9010707@rogers.com>
Date: Tue, 13 May 2003 22:01:12 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com>	 <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>	 <3EB1ADEC.6080007@rogers.com> <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------000904030301000809040207"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Tue, 13 May 2003 22:01:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000904030301000809040207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>
>Is it worth the effort. Why not just let the old isa stuff live out its
>life in peace ? There is certainly no reason we couldnt make it more
>driver model like by splitting probe and activity
>
>ie ne2000 probing would do
>
>	poke around for ISA device
>	Found one ?
>		Alloc isadevice
>		Fill in ports/range/irq
>		Fill in vendor/product with invented idents
>		Announce it
>
>Then have ne2000 driver model code do the actual setup
>
>  
>
Attached is the rough beginings of a patch that does this.

Basically it adds isa bus support and uses it ne.c.

ISA Bus Support
--
The bus uses ioaddr as the bus_id because I don't think we have anything 
else unique to use.

Drivers are responsible for adding devices to the bus, through 
isa_device_register(). Once added, devices stay around forever, even 
after driver unload.
Right now I use the device id's stolen from eisa, but I can't see any 
reason not to just make ids up as necessary.


ne.c
---
ne_probe (the function called by Space.c) will autoprobe for ne2000 
devices and then as it finds them it calls isa_register_device. It 
always returns -ENODEV. (eventually if all the net drivers get moved to 
this model, some of this stuff could be moved into Space.c)
Later on, during module init the driver registers itself with with isa 
bus and then ne_isa_probe is called appropriately.

Moving to doing things this way, should make it possible to merge pci 
support back in and get rid of ne2k-pci.c, because all buses will use 
the same model. Eventually ne2k_cbus.c could probably be added merged as 
well.

Any comments or suggestions?

-Jeff

--------------000904030301000809040207
Content-Type: text/plain;
 name="isa-bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isa-bus.patch"

diff -urN linux-2.5.69/drivers/isa/isa-bus.c linux-2.5.69-isabus/drivers/isa/isa-bus.c
--- linux-2.5.69/drivers/isa/isa-bus.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.69-isabus/drivers/isa/isa-bus.c	2003-05-13 20:19:09.000000000 -0400
@@ -0,0 +1,99 @@
+/*
+ * ISA bus support functions for sysfs.
+ *
+ * Derived from eisa bus support
+ * 
+ * This code is released under the GPL version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/isa.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+
+static struct device isa_root_dev = {
+	.name = "isa bus",
+	.bus_id = "isa",
+};
+
+static int isa_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct isa_device *idev = to_isa_device(dev);
+	struct isa_driver *idrv = to_isa_driver(drv);
+	const struct isa_device_id *iids = idrv->id_table;
+	while (strlen (iids->id)) {
+		if (!strcmp(iids->id, idev->id.id)) {
+			return 1;
+		}
+		iids++;
+	}
+	return 0;
+}
+
+struct bus_type isa_bus_type = {
+	.name  = "isa",
+	.match = isa_bus_match,
+};
+
+int isa_driver_register(struct isa_driver *idrv)
+{
+	int r;
+	
+	idrv->driver.bus = &isa_bus_type;
+	if ((r = driver_register(&idrv->driver)) < 0)
+		return r;
+
+	return 0;
+}
+
+void isa_driver_unregister(struct isa_driver *idrv)
+{
+	driver_unregister(&idrv->driver);
+}
+
+int isa_device_register(unsigned long base_addr, unsigned long irq, struct isa_device_id *id)
+{
+	struct isa_device *idev;
+	if (!(idev = kmalloc(sizeof (*idev), GFP_KERNEL)))
+		return -ENOMEM;
+	
+	memset(idev, 0, sizeof (*idev));
+	
+	strncpy(idev->id.id, id->id, ISA_ID_LEN);
+	idev->id.driver_data = id->driver_data;
+	
+	idev->base_addr = base_addr;
+	idev->irq = irq;
+	idev->dev.parent = &isa_root_dev;
+	idev->dev.bus = &isa_bus_type;
+	idev->dev.dma_mask = &idev->dma_mask;
+	sprintf(idev->dev.bus_id, "%lx", base_addr);
+
+	if (device_register(&idev->dev)){
+		return -1;
+	}
+	return 0;
+}
+
+static int __init isa_init(void)
+{
+	int r;
+	if ((r = device_register(&isa_root_dev)))
+		return r;
+	if ((r = bus_register(&isa_bus_type)))
+		return r;
+	printk(KERN_INFO "ISA bus registered\n");
+	return 0;
+}
+
+postcore_initcall (isa_init);
+
+EXPORT_SYMBOL (isa_bus_type);
+EXPORT_SYMBOL (isa_device_register);
+EXPORT_SYMBOL (isa_driver_register);
+EXPORT_SYMBOL (isa_driver_unregister);
diff -urN linux-2.5.69/drivers/isa/Makefile linux-2.5.69-isabus/drivers/isa/Makefile
--- linux-2.5.69/drivers/isa/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.69-isabus/drivers/isa/Makefile	2003-05-13 20:12:24.000000000 -0400
@@ -0,0 +1,3 @@
+# Makefile for the Linux isa bus model
+
+obj-$(CONFIG_ISA)	        += isa-bus.o
diff -urN linux-2.5.69/drivers/Makefile linux-2.5.69-isabus/drivers/Makefile
--- linux-2.5.69/drivers/Makefile	2003-05-04 19:53:37.000000000 -0400
+++ linux-2.5.69-isabus/drivers/Makefile	2003-05-11 14:17:17.000000000 -0400
@@ -49,4 +49,5 @@
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
+obj-$(CONFIG_ISA)		+= isa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
diff -urN linux-2.5.69/drivers/net/ne.c linux-2.5.69-isabus/drivers/net/ne.c
--- linux-2.5.69/drivers/net/ne.c	2003-05-04 19:53:14.000000000 -0400
+++ linux-2.5.69-isabus/drivers/net/ne.c	2003-05-13 20:03:16.000000000 -0400
@@ -29,21 +29,21 @@
     last in cleanup_modue()
     Richard Guenther    : Added support for ISAPnP cards
     Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
+    Jeff Muizelaar	: moved over to generic PnP api
+    Jeff Muizelaar	: changed init code to act more probe like 
 
 */
 
 /* Routines for the NatSemi-based designs (NE[12]000). */
 
-static const char version1[] =
-"ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n";
-static const char version2[] =
-"Last modified Nov 1, 2000 by Paul Gortmaker\n";
-
+static const char version[] =
+"ne.c:v1.10b 4/1/03 Donald Becker (becker@scyld.com)\n";
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
+#include <linux/isa.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -76,20 +76,30 @@
 };
 #endif
 
-static struct isapnp_device_id isapnp_clone_list[] __initdata = {
-	{	ISAPNP_CARD_ID('A','X','E',0x2011),
-		ISAPNP_VENDOR('A','X','E'), ISAPNP_FUNCTION(0x2011),
-		(long) "NetGear EA201" },
-	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('E','D','I'), ISAPNP_FUNCTION(0x0216),
-		(long) "NN NE2000" },
-	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('P','N','P'), ISAPNP_FUNCTION(0x80d6),
-		(long) "Generic PNP" },
-	{ }	/* terminate list */
+#ifdef CONFIG_PNP
+static const struct pnp_device_id ne_pnp_table[] = {
+	/* NetGear EA201 */
+	{.id = "AXE2011", .driver_data = 0},
+	/* NN NE2000 */
+	{.id = "EDI0216", .driver_data = 0},
+	/* Novell/Anthem NE1000 */
+	{.id = "PNP80d3", .driver_data = 0},
+	/* Novell/Anthem NE2000 */
+	{.id = "PNP80d4", .driver_data = 0},
+	/* NE1000 Compatible */
+	{.id = "PNP80d5", .driver_data = 0},
+	/* NE2000 Compatible */
+	{.id = "PNP80d6", .driver_data = 0},
+	/* National Semiconductor AT/LANTIC EtherNODE 16-AT3 */
+	{.id = "PNP8160", .driver_data = 0},
 };
 
-MODULE_DEVICE_TABLE(isapnp, isapnp_clone_list);
+MODULE_DEVICE_TABLE(pnp, ne_pnp_table);
+#endif
+
+static const struct isa_device_id ne_isa_table[] = {
+	{.id = "ISA8711", .driver_data = 0},
+};
 
 #ifdef SUPPORT_NE_BAD_CLONES
 /* A list of bad clones that we none-the-less recognize. */
@@ -126,9 +136,34 @@
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-int ne_probe(struct net_device *dev);
-static int ne_probe1(struct net_device *dev, int ioaddr);
-static int ne_probe_isapnp(struct net_device *dev);
+#ifdef CONFIG_PNP
+static int ne_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id);
+static void ne_pnp_remove(struct pnp_dev *dev);
+static struct pnp_driver ne_pnp_driver = {
+	.name		= "ne",
+	.id_table 	= ne_pnp_table,
+	.probe		= ne_pnp_probe,
+	.remove		= ne_pnp_remove,
+};
+#endif
+
+static int ne_isa_probe(struct device *dev);
+static void ne_isa_remove(struct device *dev);
+static struct isa_driver ne_isa_driver = {
+	.id_table	= ne_isa_table,
+	.driver		= {
+		.name	= "ne",
+		.probe	= ne_isa_probe,
+		.remove	= ne_isa_remove
+	}
+};
+
+static int ne_detect(int ioaddr, int irq, int bad);
+static int ne_probe1(struct net_device *dev, int ioaddr, int bad);
+
+static int ne_create(struct net_device **ndev, unsigned long base_addr, 
+		unsigned long irq, int bad);
+static void ne_remove(struct net_device *dev);
 
 static int ne_open(struct net_device *dev);
 static int ne_close(struct net_device *dev);
@@ -165,89 +200,112 @@
 
 int __init ne_probe(struct net_device *dev)
 {
-	unsigned int base_addr = dev->base_addr;
-
-	SET_MODULE_OWNER(dev);
-
-	/* First check any supplied i/o locations. User knows best. <cough> */
-	if (base_addr > 0x1ff)	/* Check a single specified location. */
-		return ne_probe1(dev, base_addr);
-	else if (base_addr != 0)	/* Don't probe at all. */
-		return -ENXIO;
-
-	/* Then look for any installed ISAPnP clones */
-	if (isapnp_present() && (ne_probe_isapnp(dev) == 0))
-		return 0;
-
 #ifndef MODULE
-	/* Last resort. The semi-risky ISA auto-probe. */
-	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
-		int ioaddr = netcard_portlist[base_addr];
-		if (ne_probe1(dev, ioaddr) == 0)
-			return 0;
+	/* autoprobe */
+	int i;
+	for (i = 0; netcard_portlist[i] != 0; i++) {
+		if (ne_detect(netcard_portlist[i], 0, 0) == 0)
+			isa_device_register(netcard_portlist[i], 0, ne_isa_table);
 	}
 #endif
-
 	return -ENODEV;
 }
 
-static int __init ne_probe_isapnp(struct net_device *dev)
+#ifdef CONFIG_PNP
+static int ne_pnp_probe(struct pnp_dev *pdev, const struct pnp_device_id *dev_id)
 {
-	int i;
+	struct net_device *ndev;
+	int err;
+	printk(KERN_INFO "ne.c: PnP reports %s at i/o %#lx, irq %ld\n",
+			pdev->dev.name, pnp_port_start(idev, 0), pnp_irq(pdev, 0));
+	err = ne_create(&ndev, pnp_port_start(pdev, 0), pnp_irq(pdev, 0), 0);
+	if(ndev)
+		pnp_set_drvdata(pdev, ndev);
+	return err;
+}
 
-	for (i = 0; isapnp_clone_list[i].vendor != 0; i++) {
-		struct pnp_dev *idev = NULL;
+static void ne_pnp_remove(struct pnp_dev *pdev)
+{
+	struct net_device *dev = pnp_get_drvdata(pdev);	
+	ne_remove(dev);
+}
+#endif
 
-		while ((idev = pnp_find_dev(NULL,
-					    isapnp_clone_list[i].vendor,
-					    isapnp_clone_list[i].function,
-					    idev))) {
-			/* Avoid already found cards from previous calls */
-			if (pnp_device_attach(idev) < 0)
-				continue;
-			if (pnp_activate_dev(idev) < 0) {
-			      	pnp_device_detach(idev);
-			      	continue;
-			}
-			/* if no io and irq, search for next */
-			if (!pnp_port_valid(idev, 0) || !pnp_irq_valid(idev, 0)) {
-				pnp_device_detach(idev);
-				continue;
-			}
-			/* found it */
-			dev->base_addr = pnp_port_start(idev, 0);
-			dev->irq = pnp_irq(idev, 0);
-			printk(KERN_INFO "ne.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
-				(char *) isapnp_clone_list[i].driver_data,
-				dev->base_addr, dev->irq);
-			if (ne_probe1(dev, dev->base_addr) != 0) {	/* Shouldn't happen. */
-				printk(KERN_ERR "ne.c: Probe of ISAPnP card at %#lx failed.\n", dev->base_addr);
-				pnp_device_detach(idev);
-				return -ENXIO;
-			}
-			ei_status.priv = (unsigned long)idev;
-			break;
-		}
-		if (!idev)
-			continue;
-		return 0;
+static int ne_isa_probe(struct device *dev)
+{
+	struct isa_device *idev;
+	struct net_device *ndev;
+	int err;
+	idev = to_isa_device(dev);
+	err = ne_create(&ndev, idev->base_addr, idev->irq, idev->id.driver_data);
+	if(!err){
+		/* HACK to set device name */
+		strcpy(idev->dev.name, ((struct ei_device *)ndev->priv)->name);
+		isa_set_drvdata(idev, ndev);
 	}
+	return err;
+}
 
-	return -ENODEV;
+static void ne_isa_remove(struct device *dev)
+{
+	struct isa_device *idev;
+	struct net_device *ndev;
+	idev = to_isa_device(dev);
+	ndev = isa_get_drvdata(idev);
+	ne_remove(ndev);
 }
 
-static int __init ne_probe1(struct net_device *dev, int ioaddr)
+static int ne_create(struct net_device **ndev, unsigned long base_addr, unsigned long irq, int bad)
 {
-	int i;
-	unsigned char SA_prom[32];
-	int wordlength = 2;
-	const char *name = NULL;
-	int start_page, stop_page;
-	int neX000, ctron, copam, bad_card;
-	int reg0, ret;
+	int err;
+	
+	if (!(*ndev = alloc_etherdev(0)) ){
+		err = -ENOMEM;
+		goto alloc_fail;
+	}
+	
+	(*ndev)->base_addr = base_addr;
+	(*ndev)->irq = irq;
+	SET_MODULE_OWNER(*ndev);
+	
+	if (ne_probe1(*ndev, (*ndev)->base_addr, bad) != 0) {	/* Shouldn't happen. */
+		printk(KERN_ERR "ne.c: Probe at %#lx failed\n", (*ndev)->base_addr);
+		err = -ENXIO;
+		goto probe_fail;
+	}
+	
+	if ( (err = register_netdev(*ndev)) != 0)
+		goto register_fail;
+	
+	return 0;
+	
+register_fail:
+	kfree((*ndev)->priv);
+	release_region((*ndev)->base_addr, NE_IO_EXTENT);
+probe_fail:
+	kfree(*ndev);
+alloc_fail:
+	return err;
+}
+
+static void ne_remove(struct net_device *dev)
+{
+	if (dev) {
+		unregister_netdev(dev);
+		free_irq(dev->irq, dev);
+		release_region(dev->base_addr, NE_IO_EXTENT);
+		kfree(dev->priv);
+		kfree(dev);
+	}
+}
+
+
+static int __init ne_detect(int ioaddr, int irq, int bad_card)
+{
+	int reg0, ret=0;
 	static unsigned version_printed;
 
-	if (!request_region(ioaddr, NE_IO_EXTENT, dev->name))
+	if (!request_region(ioaddr, NE_IO_EXTENT, "NE2000"))
 		return -EBUSY;
 
 	reg0 = inb_p(ioaddr);
@@ -273,17 +331,14 @@
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
+		printk(KERN_INFO "%s", version);
 
 	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
 
 	/* A user with a poor card that fails to ack the reset, or that
 	   does not have a valid 0x57,0x57 signature can still use this
-	   without having to recompile. Specifying an i/o address along
-	   with an otherwise unused dev->mem_end value of "0xBAD" will
-	   cause the driver to skip these parts of the probe. */
-
-	bad_card = ((dev->base_addr != 0) && (dev->mem_end == 0xbad));
+	   without having to recompile. Specifying a bad card will cause 
+	   the driver to skip these parts of the probe. */
 
 	/* Reset card. Who knows what dain-bramaged state it was left in. */
 
@@ -296,18 +351,40 @@
 		while ((inb_p(ioaddr + EN0_ISR) & ENISR_RESET) == 0)
 		if (jiffies - reset_start_time > 2*HZ/100) {
 			if (bad_card) {
-				printk(" (warning: no reset ack)");
+				printk(" (warning: no reset ack)\n");
 				break;
 			} else {
 				printk(" not found (no reset ack).\n");
 				ret = -ENODEV;
 				goto err_out;
 			}
+		} else {
+			printk("\n");
 		}
+			
 
 		outb_p(0xff, ioaddr + EN0_ISR);		/* Ack all intr. */
 	}
 
+	
+err_out:
+	release_region(ioaddr, NE_IO_EXTENT);
+	return ret;
+}
+
+static int __init ne_probe1(struct net_device *dev, int ioaddr, int bad_card)
+{
+	int i;
+	unsigned char SA_prom[32];
+	int wordlength = 2;
+	const char *name = NULL;
+	int start_page, stop_page;
+	int neX000, ctron, copam;
+	int ret;
+	if(ne_detect(ioaddr, dev->irq, bad_card))
+		return -ENODEV;
+	if (!request_region(ioaddr, NE_IO_EXTENT, dev->name))
+		return -EBUSY;
 	/* Read the 16 bytes of station address PROM.
 	   We must first initialize registers, similar to NS8390_init(eifdev, 0).
 	   We can't reliably read the SAPROM address without this.
@@ -731,13 +808,10 @@
 	return;
 }
 
-
-#ifdef MODULE
 #define MAX_NE_CARDS	4	/* Max number of NE cards per module */
-static struct net_device dev_ne[MAX_NE_CARDS];
 static int io[MAX_NE_CARDS];
 static int irq[MAX_NE_CARDS];
-static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
+static int bad[MAX_NE_CARDS];	/* bad sig or no reset ack */
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
@@ -753,51 +827,54 @@
 is at boot) and so the probe will get confused by any other 8390 cards.
 ISA device autoprobes on a running machine are not recommended anyway. */
 
-int init_module(void)
-{
-	int this_dev, found = 0;
 
-	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ne[this_dev];
-		dev->irq = irq[this_dev];
-		dev->mem_end = bad[this_dev];
-		dev->base_addr = io[this_dev];
-		dev->init = ne_probe;
-		if (register_netdev(dev) == 0) {
-			found++;
-			continue;
-		}
-		if (found != 0) { 	/* Got at least one. */
-			return 0;
+static int __init ne_init(void)
+{
+	int i;
+	int err;
+#ifdef CONFIG_PNP	
+	err = pnp_register_driver(&ne_pnp_driver);
+	if (err < 0) {
+		goto pnp_fail;
+	}
+#endif
+	/* First check any supplied i/o locations. User knows best. <cough> */
+	for (i = 0; i < MAX_NE_CARDS; i++) {
+		if (io[i] > 0x1ff) {
+			err = ne_detect(io[i], irq[i], bad[i]);
+			if (!err)
+				isa_device_register(io[i], irq[i], ne_isa_table);
+			else 
+				printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[i]);
+				
 		}
-		if (io[this_dev] != 0)
-			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
-		else
-			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
-		return -ENXIO;
 	}
+
+	err = isa_driver_register(&ne_isa_driver);
+	if (err < 0) {
+		goto isa_fail;
+	}
+	
 	return 0;
+isa_fail:
+	printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
+#ifdef CONFIG_PNP
+	pnp_unregister_driver(&ne_pnp_driver);
+pnp_fail:
+#endif
+	return -ENODEV;
 }
 
-void cleanup_module(void)
+static void __exit ne_cleanup(void)
 {
-	int this_dev;
-
-	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ne[this_dev];
-		if (dev->priv != NULL) {
-			void *priv = dev->priv;
-			struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-			if (idev)
-				pnp_device_detach(idev);
-			free_irq(dev->irq, dev);
-			release_region(dev->base_addr, NE_IO_EXTENT);
-			unregister_netdev(dev);
-			kfree(priv);
-		}
-	}
+#ifdef CONFIG_PNP	
+	pnp_unregister_driver(&ne_pnp_driver);
+#endif
+	isa_driver_unregister(&ne_isa_driver);
 }
-#endif /* MODULE */
+
+module_init(ne_init);
+module_exit(ne_cleanup);
 
 
 /*
diff -urN linux-2.5.69/include/linux/isa.h linux-2.5.69-isabus/include/linux/isa.h
--- linux-2.5.69/include/linux/isa.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.69-isabus/include/linux/isa.h	2003-05-12 20:18:54.000000000 -0400
@@ -0,0 +1,45 @@
+#ifndef _LINUX_ISA_H
+#define _LINUX_ISA_H
+
+#define ISA_ID_LEN 9 
+
+struct isa_device_id {
+	char			id[ISA_ID_LEN];
+	unsigned long		driver_data;
+};
+
+struct isa_device {
+	struct isa_device_id	id;
+	unsigned long		base_addr;
+	unsigned int		irq;
+	u64			dma_mask;
+	struct device		dev;
+};
+
+#define to_isa_device(n) container_of(n, struct isa_device, dev)
+
+struct isa_driver {
+	const struct isa_device_id	*id_table;
+	struct device_driver		driver;
+};
+
+
+#define to_isa_driver(drv) container_of(drv, struct isa_driver, driver)
+
+extern struct bus_type isa_bus_type;
+int isa_driver_register(struct isa_driver *idrv);
+void isa_driver_unregister(struct isa_driver *idrv);
+
+int isa_device_register(unsigned long base_addr, unsigned long irq, struct isa_device_id *id);
+
+static inline void *isa_get_drvdata(struct isa_device *idev)
+{
+        return idev->dev.driver_data;
+}
+
+static inline void isa_set_drvdata(struct isa_device *idev, void *data)
+{
+        idev->dev.driver_data = data;
+}
+
+#endif

--------------000904030301000809040207--

