Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUA1VCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUA1VCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:02:03 -0500
Received: from intra.cyclades.com ([64.186.161.6]:55683 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266162AbUA1VB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:01:56 -0500
Date: Wed, 28 Jan 2004 17:42:11 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PC300 update
Message-ID: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch forward ports some changes from latest 2.4 driver:

- Update maintainer email address
- Mark pci_device_id list with __devinitdata
- Set correct protocol type on packet receive (this caused the kernel to
  drop all packets received)
- Add #ifdef DEBUG around debug printk()

Kudos to Ivan Passos / Daniela Squassoni

Please apply.

--- linux-2.6.1/drivers/net/wan/pc300_drv.c.orig	2004-01-28 12:48:48.000000000 -0200
+++ linux-2.6.1/drivers/net/wan/pc300_drv.c	2004-01-28 13:21:23.634860712 -0200
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
@@ -3690,6 +3691,6 @@

 MODULE_DESCRIPTION("Cyclades-PC300 cards driver");
 MODULE_AUTHOR(  "Author: Ivan Passos <ivan@cyclades.com>\r\n"
-                "Maintainer: Henrique Gobbi <henrique.gobbi@cyclades.com");
+                "Maintainer: PC300 Maintainer <pc300@cyclades.com");
 MODULE_LICENSE("GPL");

