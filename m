Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVIUIBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIUIBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIUIBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:01:44 -0400
Received: from [194.90.237.34] ([194.90.237.34]:25658 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750748AbVIUIBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:01:43 -0400
Date: Wed, 21 Sep 2005 11:02:30 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: openib-general@openib.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       Dror Goldenberg <gdror@mellanox.co.il>
Subject: RFC: struct netdevice changes for IPoIB UC support
Message-ID: <20050921080230.GE18449@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I am working on IP over InfiniBand net device support.
Existing code in mainline kernel only supports UD (unreliable datagram)
mode of operation, with max MTU of 2Kbyte.
I'm looking into support for UC (unreliable connected) mode of operation,
which can support MTU with theorectical limit up to 2Gbyte.

As was discussed on the openib list, one of the difficulties with
IP over IB support for UC mode, is the fact that the same device
has to support sending both UC (max MTU 2Gbyte) and UD (max MTU 2Kbyte)
packets, depending on packet link address.

I propose the following simple patch to let the netdevice override
the path MTU per dst entry. The patch was tested by modifying
existing IPoIB code to use MTU of 1K for some addresses, and 2K for
others.

Please comment on this approach: does it make sense to you guys?
Please Cc me directly, I'm not on the list.

Thanks a bunch,
MST

---

Make it possible for a network device to support more than one MTU value at a
time (depending on packet link address, or other criteria).

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.12.5/include/linux/netdevice.h
===================================================================
--- linux-2.6.12.5.orig/include/linux/netdevice.h
+++ linux-2.6.12.5/include/linux/netdevice.h
@@ -454,6 +454,10 @@ struct net_device
 #define HAVE_CHANGE_MTU
 	int			(*change_mtu)(struct net_device *dev, int new_mtu);
 
+#define HAVE_GET_MTU
+	u32			(*get_mtu)(struct net_device *dev,
+					   struct neighbour *neigh,
+					   int path_mtu);
 #define HAVE_TX_TIMEOUT
 	void			(*tx_timeout) (struct net_device *dev);
 
Index: linux-2.6.12.5/include/net/dst.h
===================================================================
--- linux-2.6.12.5.orig/include/net/dst.h
+++ linux-2.6.12.5/include/net/dst.h
@@ -111,7 +111,12 @@ dst_metric(const struct dst_entry *dst, 
 
 static inline u32 dst_mtu(const struct dst_entry *dst)
 {
-	u32 mtu = dst_metric(dst, RTAX_MTU);
+	u32 mtu;
+	if (dst->dev && dst->dev->get_mtu)
+		mtu = dst->dev->get_mtu(dst->dev, dst->neighbour,
+					dst_metric(dst, RTAX_MTU));
+	else
+		mtu = dst_metric(dst, RTAX_MTU);
 	/*
 	 * Alexey put it here, so ask him about it :)
 	 */

-- 
MST
