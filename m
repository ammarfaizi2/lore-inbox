Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUHFCge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUHFCge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268027AbUHFCfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:35:53 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:23938 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S264912AbUHFCeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:34:31 -0400
Date: Thu, 5 Aug 2004 22:26:07 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: rmk@arm.linux.org.uk
Cc: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia driver model support [3/5]
Message-ID: <20040805222607.GD11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PCMCIA] update wireless drivers

This patch updates pcmcia wireless drivers so that their class devices are
linked to the correct physical device.

diff -urw a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	2004-08-05 13:05:42.000000000 +0000
+++ b/drivers/net/wireless/airo.c	2004-08-05 14:10:57.000000000 +0000
@@ -2681,7 +2681,8 @@
 }
 
 struct net_device *_init_airo_card( unsigned short irq, int port,
-				    int is_pcmcia, struct pci_dev *pci )
+				    int is_pcmcia, struct pci_dev *pci,
+				    struct device *dmdev )
 {
 	struct net_device *dev;
 	struct airo_info *ai;
@@ -2742,10 +2743,8 @@
 	dev->irq = irq;
 	dev->base_addr = port;
 
-	/* what is with PCMCIA ??? */
-	if (pci) {
-		SET_NETDEV_DEV(dev, &pci->dev);
-	}
+	SET_NETDEV_DEV(dev, dmdev);
+
 
 	if (test_bit(FLAG_MPI,&ai->flags))
 		reset_card (dev, 1);
@@ -2827,9 +2826,10 @@
 	return NULL;
 }
 
-struct net_device *init_airo_card( unsigned short irq, int port, int is_pcmcia )
+struct net_device *init_airo_card( unsigned short irq, int port, int is_pcmcia,
+				  struct device *dmdev)
 {
-	return _init_airo_card ( irq, port, is_pcmcia, NULL);
+	return _init_airo_card ( irq, port, is_pcmcia, NULL, dmdev);
 }
 
 EXPORT_SYMBOL(init_airo_card);
@@ -5461,9 +5461,9 @@
 	pci_set_master(pdev);
 
 	if (pdev->device == 0x5000 || pdev->device == 0xa504)
-			dev = _init_airo_card(pdev->irq, pdev->resource[0].start, 0, pdev);
+			dev = _init_airo_card(pdev->irq, pdev->resource[0].start, 0, pdev, &pdev->dev);
 	else
-			dev = _init_airo_card(pdev->irq, pdev->resource[2].start, 0, pdev);
+			dev = _init_airo_card(pdev->irq, pdev->resource[2].start, 0, pdev, &pdev->dev);
 	if (!dev)
 		return -ENODEV;
 
@@ -5566,7 +5566,7 @@
 		printk( KERN_INFO
 			"airo:  Trying to configure ISA adapter at irq=%d io=0x%x\n",
 			irq[i], io[i] );
-		if (init_airo_card( irq[i], io[i], 0 ))
+		if (init_airo_card( irq[i], io[i], 0, NULL ))
 			have_isa_dev = 1;
 	}
 
diff -urw a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
--- a/drivers/net/wireless/airo_cs.c	2004-08-05 13:05:43.000000000 +0000
+++ b/drivers/net/wireless/airo_cs.c	2004-08-05 14:04:21.000000000 +0000
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
diff -urw a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
--- a/drivers/net/wireless/atmel_cs.c	2004-08-05 13:05:43.000000000 +0000
+++ b/drivers/net/wireless/atmel_cs.c	2004-08-05 14:17:26.000000000 +0000
@@ -347,21 +347,6 @@
 	{ 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
 };
 
-/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
-static struct device *atmel_device(void)
-{
-	static char *kobj_name = "atmel_cs";
-
-	static struct device dev = {
-		.bus_id    = "pcmcia",
-	};
-	dev.kobj.k_name = kmalloc(strlen(kobj_name)+1, GFP_KERNEL);
-	strcpy(dev.kobj.k_name, kobj_name);
-	kobject_init(&dev.kobj);
-	
-	return &dev;
-}
-
 static void atmel_config(dev_link_t *link)
 {
 	client_handle_t handle;
@@ -552,7 +537,7 @@
 		init_atmel_card(link->irq.AssignedIRQ,
 				link->io.BasePort1,
 				card_index == -1 ? NULL :  card_table[card_index].firmware,
-				atmel_device(),
+				pcmcia_lookup_device(handle),
 				card_present, 
 				link);
 	if (!((local_info_t*)link->priv)->eth_dev) 
diff -urw a/drivers/net/wireless/netwave_cs.c b/drivers/net/wireless/netwave_cs.c
--- a/drivers/net/wireless/netwave_cs.c	2004-08-05 13:02:00.000000000 +0000
+++ b/drivers/net/wireless/netwave_cs.c	2004-08-05 14:04:25.000000000 +0000
@@ -1075,6 +1075,8 @@
 
     dev->irq = link->irq.AssignedIRQ;
     dev->base_addr = link->io.BasePort1;
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
+
     if (register_netdev(dev) != 0) {
 	printk(KERN_DEBUG "netwave_cs: register_netdev() failed\n");
 	goto failed;
diff -urw a/drivers/net/wireless/orinoco_cs.c b/drivers/net/wireless/orinoco_cs.c
--- a/drivers/net/wireless/orinoco_cs.c	2004-08-05 13:02:00.000000000 +0000
+++ b/drivers/net/wireless/orinoco_cs.c	2004-08-05 14:04:25.000000000 +0000
@@ -461,6 +461,7 @@
 
 	/* register_netdev will give us an ethX name */
 	dev->name[0] = '\0';
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 	/* Tell the stack we exist */
 	if (register_netdev(dev) != 0) {
 		printk(KERN_ERR "orinoco_cs: register_netdev() failed\n");
diff -urw a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
--- a/drivers/net/wireless/ray_cs.c	2004-08-05 13:05:43.000000000 +0000
+++ b/drivers/net/wireless/ray_cs.c	2004-08-05 14:04:25.000000000 +0000
@@ -570,6 +570,7 @@
         return;
     }
 
+    SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
     i = register_netdev(dev);
     if (i != 0) {
         printk("ray_config register_netdev() failed\n");
diff -urw a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
--- a/drivers/net/wireless/wavelan_cs.c	2004-08-05 13:02:00.000000000 +0000
+++ b/drivers/net/wireless/wavelan_cs.c	2004-08-05 14:04:25.000000000 +0000
@@ -4112,6 +4112,7 @@
 	     (u_int) dev->mem_start, dev->irq, (u_int) dev->base_addr);
 #endif
 
+      SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
       i = register_netdev(dev);
       if(i != 0)
 	{
diff -urw a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
--- a/drivers/net/wireless/wl3501_cs.c	2004-08-05 13:02:00.000000000 +0000
+++ b/drivers/net/wireless/wl3501_cs.c	2004-08-05 14:04:25.000000000 +0000
@@ -2146,6 +2146,7 @@
 
 	dev->irq = link->irq.AssignedIRQ;
 	dev->base_addr = link->io.BasePort1;
+	SET_NETDEV_DEV(dev, pcmcia_lookup_device(handle));
 	if (register_netdev(dev)) {
 		printk(KERN_NOTICE "wl3501_cs: register_netdev() failed\n");
 		goto failed;
