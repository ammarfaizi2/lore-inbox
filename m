Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTEAQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTEAQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:46:26 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:63854
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261161AbTEAQqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:46:20 -0400
Message-ID: <3EB15242.4060105@rogers.com>
Date: Thu, 01 May 2003 12:58:42 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com>
In-Reply-To: <3EB15127.2060409@rogers.com>
Content-Type: multipart/mixed;
 boundary="------------030505040403090603020807"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 12:58:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030505040403090603020807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030505040403090603020807
Content-Type: text/plain;
 name="ne-pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-pnp.patch"

--- linux-2.5.66/drivers/net/ne.c	2003-03-24 17:00:21.000000000 -0500
+++ linux-2.5.66-nepnp/drivers/net/ne.c	2003-03-29 21:39:17.000000000 -0500
@@ -29,21 +29,20 @@
     last in cleanup_modue()
     Richard Guenther    : Added support for ISAPnP cards
     Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
+    Jeff Muizelaar	: moved over to generic PnP api
 
 */
 
 /* Routines for the NatSemi-based designs (NE[12]000). */
 
-static const char version1[] =
-"ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n";
-static const char version2[] =
-"Last modified Nov 1, 2000 by Paul Gortmaker\n";
+static const char version[] =
+"ne.c:v1.10a 1/26/03 Donald Becker (becker@scyld.com)\n";
 
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -76,20 +75,18 @@
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
+	/* NE2000 Compatible */
+	{.id = "PNP80d6", .driver_data = 0},
 };
 
-MODULE_DEVICE_TABLE(isapnp, isapnp_clone_list);
+MODULE_DEVICE_TABLE(pnp, ne_pnp_table);
+#endif
 
 #ifdef SUPPORT_NE_BAD_CLONES
 /* A list of bad clones that we none-the-less recognize. */
@@ -126,9 +123,20 @@
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
+#ifdef CONFIG_PNP
+static int ne_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id);
+static void ne_pnp_remove(struct pnp_dev *dev);
+
+static struct pnp_driver ne_pnp_driver = {
+	.name		= "ne",
+	.id_table 	= ne_pnp_table,
+	.probe		= ne_pnp_probe,
+	.remove		= ne_pnp_remove,
+};
+#endif
+
 int ne_probe(struct net_device *dev);
 static int ne_probe1(struct net_device *dev, int ioaddr);
-static int ne_probe_isapnp(struct net_device *dev);
 
 static int ne_open(struct net_device *dev);
 static int ne_close(struct net_device *dev);
@@ -175,10 +183,6 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-	/* Then look for any installed ISAPnP clones */
-	if (isapnp_present() && (ne_probe_isapnp(dev) == 0))
-		return 0;
-
 #ifndef MODULE
 	/* Last resort. The semi-risky ISA auto-probe. */
 	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
@@ -191,50 +195,58 @@
 	return -ENODEV;
 }
 
-static int __init ne_probe_isapnp(struct net_device *dev)
+#ifdef CONFIG_PNP
+static int ne_pnp_probe(struct pnp_dev *idev, const struct pnp_device_id *dev_id)
 {
-	int i;
-
-	for (i = 0; isapnp_clone_list[i].vendor != 0; i++) {
-		struct pnp_dev *idev = NULL;
+	struct net_device *dev;
+	int err;
+	
+	if ( !(dev = alloc_etherdev(0)) ){
+		err = -ENOMEM;
+		goto alloc_fail;
+	}
+	
+	dev->base_addr = pnp_port_start(idev, 0);
+	dev->irq = pnp_irq(idev, 0);
+	printk(KERN_INFO "ne.c: PnP reports %s at i/o %#lx, irq %d\n",
+			idev->dev.name, dev->base_addr, dev->irq);
+	
+	SET_MODULE_OWNER(dev);
+	
+	if (ne_probe1(dev, dev->base_addr) != 0) {	/* Shouldn't happen. */
+		printk(KERN_ERR "ne.c: Probe of PnP card at %#lx failed\n", dev->base_addr);
+		err = -ENXIO;
+		goto probe_fail;
+	}
+	
+	if ( (err = register_netdev(dev)) != 0)
+		goto register_fail;
 
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
+	pnp_set_drvdata(idev, dev);
+	
+	return 0;
+	
+register_fail:
+		kfree(dev->priv);
+		release_region(dev->base_addr, NE_IO_EXTENT);
+probe_fail:
+		kfree(dev);
+alloc_fail:
+		return err;
+}
+
+static void ne_pnp_remove(struct pnp_dev *idev)
+{
+	struct net_device *dev = pnp_get_drvdata(idev);	
+	if (dev) {
+		unregister_netdev(dev);
+		free_irq(dev->irq, dev);
+		release_region(dev->base_addr, NE_IO_EXTENT);
+		kfree(dev->priv);
+		kfree(dev);
 	}
-
-	return -ENODEV;
 }
+#endif
 
 static int __init ne_probe1(struct net_device *dev, int ioaddr)
 {
@@ -273,7 +285,7 @@
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
+		printk(KERN_INFO "%s", version);
 
 	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
 
@@ -757,6 +769,13 @@
 {
 	int this_dev, found = 0;
 
+#ifdef CONFIG_PNP	
+	found = pnp_register_driver(&ne_pnp_driver);
+	if (found < 0) {
+		return found;
+	}
+#endif
+
 	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
 		struct net_device *dev = &dev_ne[this_dev];
 		dev->irq = irq[this_dev];
@@ -774,6 +793,9 @@
 			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
 		else
 			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
+#ifdef CONFIG_PNP
+		pnp_unregister_driver(&ne_pnp_driver);
+#endif
 		return -ENXIO;
 	}
 	return 0;
@@ -783,17 +805,16 @@
 {
 	int this_dev;
 
+#ifdef CONFIG_PNP	
+	pnp_unregister_driver(&ne_pnp_driver);
+#endif
 	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
 		struct net_device *dev = &dev_ne[this_dev];
 		if (dev->priv != NULL) {
-			void *priv = dev->priv;
-			struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
-			if (idev)
-				pnp_device_detach(idev);
+			unregister_netdev(dev);
 			free_irq(dev->irq, dev);
 			release_region(dev->base_addr, NE_IO_EXTENT);
-			unregister_netdev(dev);
-			kfree(priv);
+			kfree(dev->priv);
 		}
 	}
 }

--------------030505040403090603020807--

