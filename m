Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUEOMIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUEOMIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 08:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUEOMHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 08:07:41 -0400
Received: from ee.oulu.fi ([130.231.61.23]:39097 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262339AbUEOMGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 08:06:07 -0400
Date: Sat, 15 May 2004 15:05:19 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Miroslav Zubcic <mvz@nimium.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, netdev@oss.sgi.com,
       jgarzik@pobox.com
Subject: [PATCH] Re: ethernet/b44: Bug in b44.c:v0.93 (Mar, 2004) ethernet driver in 2.6.6
Message-ID: <20040515120518.GA9480@ee.oulu.fi>
References: <lzekpnlxwl.fsf@nimiumvax.nimium.local> <20040514130206.GA9583@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040514130206.GA9583@ee.oulu.fi>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:02:06PM +0300, Pekka Pietikainen wrote:
> haven't put that much effort in tracking the reason what magic
> "break b44 bit" bit broadcom drivers  set. I suppose I could give it a few 
> hours this weekend tho... On some machines (I think dells) the timeout
Could you try this patch? It makes the b44 after bcm4400 scenario work for
me. What was happening is that the broadcom driver sets a "power off MAC"
bit, and we didn't remove that when initializing the chip.
Also added some (a bit ugly, I know :-) ) logic to clear up the address
filter stuff, which is what recent broadcom drivers do...

--- linux-2.6.5-1.358/drivers/net/b44.c.orig	2004-05-15 13:59:57.000000000 +0300
+++ linux-2.6.5-1.358/drivers/net/b44.c	2004-05-15 14:59:39.794720368 +0300
@@ -27,8 +27,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.94"
-#define DRV_MODULE_RELDATE	"May 4, 2004"
+#define DRV_MODULE_VERSION	"0.95"
+#define DRV_MODULE_RELDATE	"May 15, 2004"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -1187,8 +1187,9 @@
 	b44_chip_reset(bp);
 	b44_phy_reset(bp);
 	b44_setup_phy(bp);
-	val = br32(B44_MAC_CTRL);
-	bw32(B44_MAC_CTRL, val | MAC_CTRL_CRC32_ENAB);
+
+	/* Enable CRC32, set proper LED modes and power on MAC */
+	bw32(B44_MAC_CTRL, MAC_CTRL_CRC32_ENAB | MAC_CTRL_PHY_LEDCTRL);
 	bw32(B44_RCV_LAZY, (1 << RCV_LAZY_FC_SHIFT));
 
 	/* This sets the MAC address too.  */
@@ -1337,7 +1338,7 @@
 	return nstat;
 }
 
-static void __b44_load_mcast(struct b44 *bp, struct net_device *dev)
+static int __b44_load_mcast(struct b44 *bp, struct net_device *dev)
 {
 	struct dev_mc_list *mclist;
 	int i, num_ents;
@@ -1347,12 +1348,15 @@
 	for (i = 0; mclist && i < num_ents; i++, mclist = mclist->next) {
 		__b44_cam_write(bp, mclist->dmi_addr, i + 1);
 	}
+	return i+1;
 }
 
 static void __b44_set_rx_mode(struct net_device *dev)
 {
 	struct b44 *bp = dev->priv;
 	u32 val;
+	int i=0;
+	unsigned char zero[6] = {0,0,0,0,0,0};
 
 	val = br32(B44_RXCONFIG);
 	val &= ~(RXCONFIG_PROMISC | RXCONFIG_ALLMULTI);
@@ -1365,8 +1369,11 @@
 		if (dev->flags & IFF_ALLMULTI)
 			val |= RXCONFIG_ALLMULTI;
 		else
-			__b44_load_mcast(bp, dev);
-
+			i=__b44_load_mcast(bp, dev);
+		
+		for(;i<64;i++) {
+			__b44_cam_write(bp, zero, i);			
+		}
 		bw32(B44_RXCONFIG, val);
         	val = br32(B44_CAM_CTRL);
 	        bw32(B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
