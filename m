Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUA3SAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUA3SAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:00:01 -0500
Received: from intra.cyclades.com ([64.186.161.6]:40625 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263653AbUA3R7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:59:54 -0500
Date: Fri, 30 Jan 2004 15:52:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, hch@infradead.org,
       Krzysztof Halasa <khc@pm.waw.pl>
Subject: [PATCH] PC300 update
Message-ID: <Pine.LNX.4.58L.0401301543230.1840@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch forward ports a few important fixes from the 2.4 driver. This
changes have been well tested.

Please apply.

Changelog:

- Update maintainer email address
- Mark pci_device_id list with __devinitdata.

Greg: rmk and hch checked this and found no problem.
  A bunch of other drivers are doing the same.

- Set correct protocol type on packet receive (this caused the kernel to
  drop all packets received)
- Add #ifdef DEBUG around debug printk()

Greg, Christoph: dprintk()/etc would be nice, but we're not trying
a rewrite here. Yes its ugly but its consistent with the rest.
Maybe we can do it for the whole driver, later on.

- ioctl: Add missing size checks before
  copying data from userspace.


--- linux-2.6.1/drivers/net/wan/pc300_drv.c.orig	2004-01-28 12:48:48.000000000 -0200
+++ linux-2.6.1/drivers/net/wan/pc300_drv.c	2004-01-30 10:36:00.756908936 -0200
@@ -6,9 +6,9 @@
  * pc300.c	Cyclades-PC300(tm) Driver.
  *
  * Author:	Ivan Passos <ivan@cyclades.com>
- * Maintainer:	Henrique Gobbi <henrique@cyclades.com>
+ * Maintainer:	PC300 Maintainer <pc300@cyclades.com>
  *
- * Copyright:	(c) 1999-2002 Cyclades Corp.
+ * Copyright:	(c) 1999-2003 Cyclades Corp.
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -252,7 +252,7 @@
 #undef	PC300_DEBUG_RX
 #undef	PC300_DEBUG_OTHER

-static struct pci_device_id cpc_pci_dev_id[] = {
+static struct pci_device_id cpc_pci_dev_id[] __devinitdata = {
 	/* PC300/RSV or PC300/X21, 2 chan */
 	{0x120e, 0x300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0x300},
 	/* PC300/RSV or PC300/X21, 1 chan */
@@ -1961,7 +1961,7 @@
 		}
 		stats->rx_packets++;
 		skb->mac.raw = skb->data;
-		skb->protocol = htons(ETH_P_HDLC);
+		skb->protocol = hdlc_type_trans(skb, dev);
 		netif_rx(skb);
 	}
 }
@@ -2088,9 +2088,10 @@
 					}
 				}
 				if (!(dsr_rx = cpc_readb(scabase + DSR_RX(ch)) & DSR_DE)) {
-
-printk("%s: RX intr chan[%d] (st=0x%08lx, dsr=0x%02x, dsr2=0x%02x)\n",
-	dev->name, ch, status, drx_stat, dsr_rx);
+#ifdef PC300_DEBUG_INTR
+		printk("%s: RX intr chan[%d] (st=0x%08lx, dsr=0x%02x, dsr2=0x%02x)\n",
+			dev->name, ch, status, drx_stat, dsr_rx);
+#endif
 					cpc_writeb(scabase + DSR_RX(ch), (dsr_rx | DSR_DE) & 0xfe);
 				}
 			}
@@ -2770,6 +2771,10 @@
 					if (!capable(CAP_NET_ADMIN)) {
 						return -EPERM;
 					}
+					/* incorrect data len? */
+					if (ifr->ifr_settings.size != size) {
+						return -ENOBUFS;
+					}

 					if (copy_from_user(&conf->phys_settings,
 							   settings->ifs_ifsu.sync, size)) {
@@ -2788,12 +2793,18 @@
 				case IF_IFACE_T1:
 				case IF_IFACE_E1:
 				{
+					const size_t te_size = sizeof(te1_settings);
 					const size_t size = sizeof(sync_serial_settings);

 					if (!capable(CAP_NET_ADMIN)) {
 						return -EPERM;
 					}
-
+
+					/* incorrect data len? */
+					if (ifr->ifr_settings.size != te_size) {
+						return -ENOBUFS;
+					}
+
 					if (copy_from_user(&conf->phys_settings,
 							   settings->ifs_ifsu.te1, size)) {
 						return -EFAULT;
@@ -3667,12 +3678,10 @@
 }

 static struct pci_driver cpc_driver = {
-	.name = "pc300",
-	.id_table = cpc_pci_dev_id,
-	.probe = cpc_init_one,
-	.remove = cpc_remove_one,
-	.suspend = NULL,
-	.resume = NULL,
+	.name           = "pc300",
+	.id_table       = cpc_pci_dev_id,
+	.probe          = cpc_init_one,
+	.remove         = __devexit_p(cpc_remove_one),
 };

 static int __init cpc_init(void)
@@ -3690,6 +3699,6 @@

 MODULE_DESCRIPTION("Cyclades-PC300 cards driver");
 MODULE_AUTHOR(  "Author: Ivan Passos <ivan@cyclades.com>\r\n"
-                "Maintainer: Henrique Gobbi <henrique.gobbi@cyclades.com");
+                "Maintainer: PC300 Maintainer <pc300@cyclades.com");
 MODULE_LICENSE("GPL");

