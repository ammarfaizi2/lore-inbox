Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUL3Isu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUL3Isu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUL3Ist
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:48:49 -0500
Received: from smtp.knology.net ([24.214.63.101]:56538 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261570AbUL3Isg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:36 -0500
Date: Thu, 30 Dec 2004 03:48:34 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 2/22] xfrm: Add xfrm offload management calls to struct netdevice
Message-Id: <20041230035000.11@ori.thedillows.org>
References: <20041230035000.10@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:28:25-05:00 dave@thedillows.org 
#   Add the xfrm offload management calls to struct netdevice.
#   
#   xfrm_state_add() is called for inbound xfrm states
#   xfrm_bundle_add() is called for outbound xfrm bundles
#   xfrm_state_del() is called for all offloaded xfrms,
#   	inbound or outbound.
#   
#   If a driver adds NETIF_F_IPSEC to its features, it must
#   provide all three callbacks.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/linux/netdevice.h
#   2004/12/30 00:28:07-05:00 dave@thedillows.org +11 -0
#   Add the xfrm offload management calls to struct netdevice.
#   
#   xfrm_state_add() is called for inbound xfrm states
#   xfrm_bundle_add() is called for outbound xfrm bundles
#   xfrm_state_del() is called for all offloaded xfrms,
#   	inbound or outbound.
#   
#   If a driver adds NETIF_F_IPSEC to its features, it must
#   provide all three callbacks.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	2004-12-30 01:11:56 -05:00
+++ b/include/linux/netdevice.h	2004-12-30 01:11:56 -05:00
@@ -250,6 +250,9 @@
 };
 #define NETDEV_BOOT_SETUP_MAX 8
 
+struct xfrm_state;
+struct xfrm_offload;
+struct xfrm_bundle_list;
 
 /*
  *	The DEVICE structure.
@@ -415,6 +418,7 @@
 #define NETIF_F_VLAN_CHALLENGED	1024	/* Device cannot handle VLAN packets */
 #define NETIF_F_TSO		2048	/* Can offload TCP/IP segmentation */
 #define NETIF_F_LLTX		4096	/* LockLess TX */
+#define NETIF_F_IPSEC		8192	/* Can offload IPSEC crypto */
 
 	/* Called after device is detached from network. */
 	void			(*uninit)(struct net_device *dev);
@@ -464,6 +468,13 @@
 						   unsigned short vid);
 	void			(*vlan_rx_kill_vid)(struct net_device *dev,
 						    unsigned short vid);
+
+	void			(*xfrm_state_add)(struct net_device *dev,
+						  struct xfrm_state *x);
+	void			(*xfrm_bundle_add)(struct net_device *dev,
+						   struct xfrm_bundle_list *bl);
+	void			(*xfrm_state_del)(struct net_device *dev,
+						  struct xfrm_offload *xol);
 
 	int			(*hard_header_parse)(struct sk_buff *skb,
 						     unsigned char *haddr);
