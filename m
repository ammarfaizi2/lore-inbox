Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAVIbX>; Mon, 22 Jan 2001 03:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRAVIbO>; Mon, 22 Jan 2001 03:31:14 -0500
Received: from DHCP-144-72.resnet.ua.edu ([130.160.144.72]:30336 "EHLO
	sluncho.mirizma.org") by vger.kernel.org with ESMTP
	id <S131096AbRAVIa4>; Mon, 22 Jan 2001 03:30:56 -0500
Date: Mon, 22 Jan 2001 02:30:34 -0600
From: sluncho@mirizma.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISA PnP support for the SMC EtherEZ
Message-ID: <20010122023034.A649@sluncho.nailed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 kernel has a new ISA PnP interface, as
described in Documentation/isapnp.txt. This patch adds
support for this interface to the driver for the
SMC EtherEZ ethernet card.

It has been tested on 2.4.0 and 2.4.0-ac10 (and should
also work with all other 2.4 versions).

Feedback will be appreciated. If you have a SMC EtherEZ
that is not detected as a PnP card, please send me a
cat of your /proc/isapnp.

Alexander Sotirov
sluncho@mirizma.org

http://www.mirizma.org/sluncho/hacks/smc-etherez-isapnp.patch

--- linux-2.4.0.orig/drivers/net/smc-ultra.c	Mon Dec 11 15:38:29 2000
+++ linux/drivers/net/smc-ultra.c	Sun Jan 21 23:49:55 2001
@@ -20,6 +20,7 @@
 
 		ultra_probe()	 	Detecting and initializing the card.
 		ultra_probe1()
+		ultra_probe_isapnp()
 
 		ultra_open()		The card-specific details of starting, stopping
 		ultra_reset_8390()	and resetting the 8390 NIC core.
@@ -43,6 +44,13 @@
 	Paul Gortmaker	: multiple card support for module users.
 	Donald Becker	: 4/17/96 PIO support, minor potential problems avoided.
 	Donald Becker	: 6/6/96 correctly set auto-wrap bit.
+	Alexander Sotirov : 1/20/01 Added support for ISAPnP cards
+
+	Note about the ISA PnP support:
+
+	This driver can not autoprobe for more than one SMC EtherEZ PnP card.
+	You have to configure the second card manually through the /proc/isapnp
+	interface and then load the module with an explicit io=0x___ option.
 */
 
 static const char *version =
@@ -55,6 +63,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -69,6 +78,10 @@
 int ultra_probe(struct net_device *dev);
 static int ultra_probe1(struct net_device *dev, int ioaddr);
 
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+static int ultra_probe_isapnp(struct net_device *dev);
+#endif
+
 static int ultra_open(struct net_device *dev);
 static void ultra_reset_8390(struct net_device *dev);
 static void ultra_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr,
@@ -85,6 +98,18 @@
 							 const unsigned char *buf, const int start_page);
 static int ultra_close_card(struct net_device *dev);
 
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+static struct { unsigned short card_vendor, card_device, vendor, function; char *name; }
+ultra_device_ids[] __initdata = {
+        {       ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
+                ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
+                "SMC EtherEZ (8416)" },
+        {0}
+};
+
+MODULE_DEVICE_TABLE(isapnp, ultra_device_ids);
+#endif
+
 
 #define START_PG		0x00	/* First page of TX buffer */
 
@@ -114,6 +139,14 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+	/* Look for any installed ISAPnP cards */
+	if (isapnp_present() && (ultra_probe_isapnp(dev) == 0))
+		return 0;
+
+	printk(KERN_NOTICE "smc-ultra.c: No ISAPnP cards found, trying standard ones...\n");
+#endif
+
 	for (i = 0; ultra_portlist[i]; i++)
 		if (ultra_probe1(dev, ultra_portlist[i]) == 0)
 			return 0;
@@ -245,6 +278,48 @@
 	return retval;
 }
 
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+static int __init ultra_probe_isapnp(struct net_device *dev)
+{
+        int i;
+
+        for (i = 0; ultra_device_ids[i].vendor != 0; i++) {
+                struct pci_dev *idev = NULL;
+
+                while ((idev = isapnp_find_dev(NULL,
+                                               ultra_device_ids[i].vendor,
+                                               ultra_device_ids[i].function,
+                                               idev))) {
+                        /* Avoid already found cards from previous calls */
+                        if (idev->prepare(idev))
+                                continue;
+                        if (idev->activate(idev))
+                                continue;
+                        /* if no irq, search for next */
+                        if (idev->irq_resource[0].start == 0)
+                                continue;
+                        /* found it */
+                        dev->base_addr = idev->resource[0].start;
+                        dev->irq = idev->irq_resource[0].start;
+                        printk(KERN_INFO "smc-ultra.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
+                                ultra_device_ids[i].name,
+
+                                dev->base_addr, dev->irq);
+                        if (ultra_probe1(dev, dev->base_addr) != 0) {      /* Shouldn't happen. */
+                                printk(KERN_ERR "smc-ultra.c: Probe of ISAPnP card at %#lx failed.\n", dev->base_addr);                                return -ENXIO;
+                        }
+                        ei_status.priv = (unsigned long)idev;
+                        break;
+                }
+                if (!idev)
+                        continue;
+                return 0;
+        }
+
+        return -ENODEV;
+}
+#endif
+
 static int
 ultra_open(struct net_device *dev)
 {
@@ -465,6 +540,13 @@
 		if (dev->priv != NULL) {
 			/* NB: ultra_close_card() does free_irq */
 			int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET;
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
+			if (idev)
+				idev->deactivate(idev);
+#endif
+
 			unregister_netdev(dev);
 			release_region(ioaddr, ULTRA_IO_EXTENT);
 			kfree(dev->priv);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
