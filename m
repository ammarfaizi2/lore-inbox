Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSKMPTg>; Wed, 13 Nov 2002 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKMPTg>; Wed, 13 Nov 2002 10:19:36 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:44937 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261907AbSKMPTe>; Wed, 13 Nov 2002 10:19:34 -0500
Date: Wed, 13 Nov 2002 09:29:24 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Lanstreamer hang fix + netif_carrier_on/off
Message-ID: <Pine.LNX.4.44.0211121654260.31919-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Name: Lanstreamer update 0.5.3
Author: Kent Yoder
Status: Tested on 2.4.20-pre11

D: This patch takes 2 calls to free_irq out of the interrupt
D: function's code path, which if hit would cause the machine
D: to hang. It also adds netif_carrier_{on|off} calls where
D: necessary.

Thanks,
Kent

--- a/drivers/net/tokenring/lanstreamer.c	2002-11-12 16:20:40.000000000 -0600
+++ b/drivers/net/tokenring/lanstreamer.c	2002-11-13 09:07:53.000000000 -0600
@@ -66,6 +66,8 @@
  *             the number of TX descriptors to 1, which together can prevent 
  *             the card from locking up the box - <yoder1@us.ibm.com>
  *  09/27/02 - New PCI interface + bug fix. - <yoder1@us.ibm.com>
+ *  11/13/02 - Removed free_irq calls which could cause a hang, added
+ *	       netif_carrier_{on|off} - <yoder1@us.ibm.com>
  *  
  *  To Do:
  *
@@ -137,7 +139,7 @@
  */
 
 static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan\n"
-                        "              v0.5.2 09/30/02 - Kent Yoder";
+                        "              v0.5.3 11/13/02 - Kent Yoder";
 
 static struct pci_device_id streamer_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID, PCI_ANY_ID,},
@@ -879,6 +881,7 @@
 #endif
 
 	netif_start_queue(dev);
+	netif_carrier_on(dev);
 	return 0;
 }
 
@@ -1102,7 +1105,9 @@
 			       ntohs(readw(streamer_mmio + LAPDINC)),
 			       ntohs(readw(streamer_mmio + LAPDINC)),
 			       ntohs(readw(streamer_mmio + LAPDINC)));
-			free_irq(dev->irq, dev);
+			netif_stop_queue(dev);
+			netif_carrier_off(dev);
+			printk(KERN_WARNING "%s: Adapter must be manually reset.\n", dev->name);
 		}
 
 		/* SISR_ADAPTER_CHECK */
@@ -1200,6 +1205,7 @@
 	int i;
 
 	netif_stop_queue(dev);
+	netif_carrier_off(dev);
 	writew(streamer_priv->srb, streamer_mmio + LAPA);
 	writew(htons(SRB_CLOSE_ADAPTER << 8),streamer_mmio+LAPDINC);
 	writew(htons(STREAMER_CLEAR_RET_CODE << 8), streamer_mmio+LAPDINC);
@@ -1670,11 +1676,10 @@
 			/* @TBD. no llc reset on autostreamer writel(readl(streamer_mmio+BCTL)|(3<<13),streamer_mmio+BCTL);
 			   udelay(1);
 			   writel(readl(streamer_mmio+BCTL)&~(3<<13),streamer_mmio+BCTL); */
-			netif_stop_queue(dev);
-			free_irq(dev->irq, dev);
-
-			printk(KERN_WARNING "%s: Adapter has been closed \n", dev->name);
 
+			netif_stop_queue(dev);
+			netif_carrier_off(dev);
+			printk(KERN_WARNING "%s: Adapter must be manually reset.\n", dev->name);
 		}
 		/* If serious error */
 		if (streamer_priv->streamer_message_level) {

