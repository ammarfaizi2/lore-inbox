Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUL3JJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUL3JJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUL3JHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:07:49 -0500
Received: from smtp.knology.net ([24.214.63.101]:27317 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261595AbUL3Isi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:38 -0500
Date: Thu, 30 Dec 2004 03:48:37 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 21/22] typhoon: add callbacks to support crypto offload
Message-Id: <20041230035000.30@ori.thedillows.org>
References: <20041230035000.29@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 01:05:45-05:00 dave@thedillows.org 
#   Export the xfrm offload callbacks, and let the world know we
#   support IPSEC offload.
#   
#   While we're at it, allow this to controlled by ethtool.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 01:05:27-05:00 dave@thedillows.org +23 -4
#   Export the xfrm offload callbacks, and let the world know we
#   support IPSEC offload.
#   
#   While we're at it, allow this to controlled by ethtool.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:07:53 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:07:53 -05:00
@@ -33,9 +33,12 @@
 	*) Waiting for a command response takes 8ms due to non-preemptable
 		polling. Only significant for getting stats and creating
 		SAs, but an ugly wart never the less.
+	*) Inbound IPSEC packets of the form outer ESP transport, inner
+		ESP tunnel seems to fail the hash on the inner ESP
+	*) Inbound IPSEC packets of the form outer AH transport, inner
+		AH tunnel seems to fail the hash on the outer AH
 
 	TODO:
-	*) Doesn't do IPSEC offloading. Yet. Keep yer pants on, it's coming.
 	*) Add more support for ethtool (especially for NIC stats)
 	*) Allow disabling of RX checksum offloading
 	*) Fix MAC changing to work while the interface is up
@@ -100,8 +103,8 @@
 #define PKT_BUF_SZ		1536
 
 #define DRV_MODULE_NAME		"typhoon"
-#define DRV_MODULE_VERSION 	"1.5.6"
-#define DRV_MODULE_RELDATE	"04/12/17"
+#define DRV_MODULE_VERSION 	"1.5.6-ipsec"
+#define DRV_MODULE_RELDATE	"04/12/19"
 #define PFX			DRV_MODULE_NAME ": "
 #define ERR_PFX			KERN_ERR PFX
 
@@ -1406,6 +1409,8 @@
 	.get_tso		= ethtool_op_get_tso,
 	.set_tso		= ethtool_op_set_tso,
 	.get_ringparam		= typhoon_get_ringparam,
+	.get_ipsec		= ethtool_op_get_ipsec,
+	.set_ipsec		= ethtool_op_set_ipsec,
 };
 
 static int
@@ -2253,6 +2258,9 @@
 	tp->card_state = Running;
 	smp_wmb();
 
+	if(dev->features & NETIF_F_IPSEC)
+		xfrm_accel_add(dev);
+
 	iowrite32(TYPHOON_INTR_ENABLE_ALL, ioaddr + TYPHOON_REG_INTR_ENABLE);
 	iowrite32(TYPHOON_INTR_NONE, ioaddr + TYPHOON_REG_INTR_MASK);
 	typhoon_post_pci_writes(ioaddr);
@@ -2327,6 +2335,14 @@
 		typhoon_clean_tx(tp, &tp->txLoRing, &indexes->txLoCleared);
 	}
 
+	if(tp->dev->features & NETIF_F_IPSEC)
+		xfrm_accel_flush(tp->dev);
+
+	/* tp->card_state != Running, so nothing will change this out
+         * from under us.
+         */
+	tp->offload &= ~TYPHOON_OFFLOAD_IPSEC;
+
 	return 0;
 }
 
@@ -3183,6 +3199,9 @@
 	dev->set_mac_address	= typhoon_set_mac_address;
 	dev->vlan_rx_register	= typhoon_vlan_rx_register;
 	dev->vlan_rx_kill_vid	= typhoon_vlan_rx_kill_vid;
+	dev->xfrm_state_add	= typhoon_xfrm_state_add;
+	dev->xfrm_state_del	= typhoon_xfrm_state_del;
+	dev->xfrm_bundle_add	= typhoon_xfrm_bundle_add;
 	SET_ETHTOOL_OPS(dev, &typhoon_ethtool_ops);
 
 	/* We can handle scatter gather, up to 16 entries, and
@@ -3190,7 +3209,7 @@
 	 */
 	dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
 	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
-	dev->features |= NETIF_F_TSO;
+	dev->features |= NETIF_F_TSO | NETIF_F_IPSEC;
 
 	if(register_netdev(dev) < 0)
 		goto error_out_reset;
