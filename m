Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265300AbUF2AU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUF2AU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 20:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUF2AU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 20:20:57 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:36994 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265300AbUF2AT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 20:19:58 -0400
Date: Mon, 28 Jun 2004 20:16:41 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, linux@dominikbrodowski.de, akpm@osdl.org,
       rml@ximian.com, greg@kroah.com
Subject: [RFC][PATCH] update drivers/net/wireless (3/3)
Message-ID: <20040628201641.GB9446@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is needed for class devices to bind to physical devices detected in
drivers/net/wireless.

Thanks,
Adam

diff -ur linux/drivers/net/wireless/airo.c linux-pcmcia/drivers/net/wireless/airo.c
--- linux/drivers/net/wireless/airo.c	2004-06-16 05:18:58.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/airo.c	2004-06-28 18:43:57.000000000 +0000
@@ -2679,7 +2679,8 @@
 }
 
 struct net_device *_init_airo_card( unsigned short irq, int port,
-				    int is_pcmcia, struct pci_dev *pci )
+				    int is_pcmcia, struct pci_dev *pci,
+				    struct device *dmdev )
 {
 	struct net_device *dev;
 	struct airo_info *ai;
@@ -2740,10 +2741,8 @@
 	dev->irq = irq;
 	dev->base_addr = port;
 
-	/* what is with PCMCIA ??? */
-	if (pci) {
-		SET_NETDEV_DEV(dev, &pci->dev);
-	}
+	SET_NETDEV_DEV(dev, dmdev);
+
 
 	rc = request_irq( dev->irq, airo_interrupt, SA_SHIRQ, dev->name, dev );
 	if (rc) {
@@ -2822,9 +2821,9 @@
 	return NULL;
 }
 
-struct net_device *init_airo_card( unsigned short irq, int port, int is_pcmcia )
+struct net_device *init_airo_card( unsigned short irq, int port, int is_pcmcia, struct device *dmdev )
 {
-	return _init_airo_card ( irq, port, is_pcmcia, 0);
+	return _init_airo_card ( irq, port, is_pcmcia, 0, dmdev);
 }
 
 EXPORT_SYMBOL(init_airo_card);
@@ -5449,9 +5448,9 @@
 	pci_set_master(pdev);
 
 	if (pdev->device == 0x5000 || pdev->device == 0xa504)
-			dev = _init_airo_card(pdev->irq, pdev->resource[0].start, 0, pdev);
+			dev = _init_airo_card(pdev->irq, pdev->resource[0].start, 0, pdev, &pdev->dev);
 	else
-			dev = _init_airo_card(pdev->irq, pdev->resource[2].start, 0, pdev);
+			dev = _init_airo_card(pdev->irq, pdev->resource[2].start, 0, pdev, &pdev->dev);
 	if (!dev)
 		return -ENODEV;
 
@@ -5554,7 +5553,7 @@
 		printk( KERN_INFO
 			"airo:  Trying to configure ISA adapter at irq=%d io=0x%x\n",
 			irq[i], io[i] );
-		if (init_airo_card( irq[i], io[i], 0 ))
+		if (init_airo_card( irq[i], io[i], 0, NULL ))
 			have_isa_dev = 1;
 	}
 
Only in linux-pcmcia/drivers/net/wireless: airo.c~
diff -ur linux/drivers/net/wireless/airo_cs.c linux-pcmcia/drivers/net/wireless/airo_cs.c
--- linux/drivers/net/wireless/airo_cs.c	2004-06-16 05:19:52.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/airo_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -89,7 +89,7 @@
    event handler. 
 */
 
-struct net_device *init_airo_card( int, int, int );
+struct net_device *init_airo_card( int, int, int, struct device * );
 void stop_airo_card( struct net_device *, int );
 int reset_airo_card( struct net_device * );
 
@@ -450,7 +450,7 @@
 	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link->handle, &link->conf));
 	((local_info_t*)link->priv)->eth_dev = 
 		init_airo_card( link->irq.AssignedIRQ,
-				link->io.BasePort1, 1 );
+				link->io.BasePort1, 1, pcmcia_lookup_device(handle) );
 	if (!((local_info_t*)link->priv)->eth_dev) goto cs_failed;
 	
 	/*
diff -ur linux/drivers/net/wireless/atmel_cs.c linux-pcmcia/drivers/net/wireless/atmel_cs.c
--- linux/drivers/net/wireless/atmel_cs.c	2004-06-16 05:19:23.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/atmel_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -347,11 +347,6 @@
 	{ 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
 };
 
-/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
-static struct device atmel_device = {
-        .bus_id    = "pcmcia",
-};
-
 static void atmel_config(dev_link_t *link)
 {
 	client_handle_t handle;
@@ -542,7 +537,7 @@
 		init_atmel_card(link->irq.AssignedIRQ,
 				link->io.BasePort1,
 				card_index == -1 ? NULL :  card_table[card_index].firmware,
-				&atmel_device,
+				pcmcia_lookup_device(handle),
 				card_present, 
 				link);
 	if (!((local_info_t*)link->priv)->eth_dev) 
diff -ur linux/drivers/net/wireless/netwave_cs.c linux-pcmcia/drivers/net/wireless/netwave_cs.c
--- linux/drivers/net/wireless/netwave_cs.c	2004-06-16 05:20:04.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/netwave_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -1075,6 +1075,8 @@
 
     dev->irq = link->irq.AssignedIRQ;
     dev->base_addr = link->io.BasePort1;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
+
     if (register_netdev(dev) != 0) {
 	printk(KERN_DEBUG "netwave_cs: register_netdev() failed\n");
 	goto failed;
diff -ur linux/drivers/net/wireless/orinoco_cs.c linux-pcmcia/drivers/net/wireless/orinoco_cs.c
--- linux/drivers/net/wireless/orinoco_cs.c	2004-06-16 05:20:03.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/orinoco_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -461,6 +461,7 @@
 
 	/* register_netdev will give us an ethX name */
 	dev->name[0] = '\0';
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
 		printk(KERN_ERR "orinoco_cs: register_netdev() failed\n");
diff -ur linux/drivers/net/wireless/ray_cs.c linux-pcmcia/drivers/net/wireless/ray_cs.c
--- linux/drivers/net/wireless/ray_cs.c	2004-06-16 05:19:13.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/ray_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -570,6 +570,7 @@
         return;
     }
 
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
     i = register_netdev(dev);
     if (i != 0) {
         printk("ray_config register_netdev() failed\n");
diff -ur linux/drivers/net/wireless/wavelan_cs.c linux-pcmcia/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless/wavelan_cs.c	2004-06-16 05:19:36.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/wavelan_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -4112,6 +4112,7 @@
 	     (u_int) dev->mem_start, dev->irq, (u_int) dev->base_addr);
 #endif
 
+      SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
       i = register_netdev(dev);
       if(i != 0)
 	{
diff -ur linux/drivers/net/wireless/wl3501_cs.c linux-pcmcia/drivers/net/wireless/wl3501_cs.c
--- linux/drivers/net/wireless/wl3501_cs.c	2004-06-16 05:18:37.000000000 +0000
+++ linux-pcmcia/drivers/net/wireless/wl3501_cs.c	2004-06-28 18:43:57.000000000 +0000
@@ -2146,6 +2146,7 @@
 
 	dev->irq = link->irq.AssignedIRQ;
 	dev->base_addr = link->io.BasePort1;
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 	if (register_netdev(dev)) {
 		printk(KERN_NOTICE "wl3501_cs: register_netdev() failed\n");
 		goto failed;
