Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVAMBS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVAMBS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVAMBRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:17:55 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261276AbVALVrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:47:53 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121346.ovB7UajyiLcLxIWH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:46:22 -0800
Message-Id: <20051121346.WdeZxxpd8OfUS1Xw@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][1/18] InfiniBand/IPoIB: use correct static rate in IpoIB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:46:23.0126 (UTC) FILETIME=[28A99B60:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate static rate for IPoIB address handles based on local
width/speed and path rate.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/include/ib_sa.h	(revision 1409)
+++ linux/drivers/infiniband/include/ib_sa.h	(revision 1410)
@@ -59,6 +59,34 @@
 	IB_SA_BEST = 3
 };
 
+enum ib_sa_rate {
+	IB_SA_RATE_2_5_GBPS = 2,
+	IB_SA_RATE_5_GBPS   = 5,
+	IB_SA_RATE_10_GBPS  = 3,
+	IB_SA_RATE_20_GBPS  = 6,
+	IB_SA_RATE_30_GBPS  = 4,
+	IB_SA_RATE_40_GBPS  = 7,
+	IB_SA_RATE_60_GBPS  = 8,
+	IB_SA_RATE_80_GBPS  = 9,
+	IB_SA_RATE_120_GBPS = 10
+};
+
+static inline int ib_sa_rate_enum_to_int(enum ib_sa_rate rate)
+{
+	switch (rate) {
+	case IB_SA_RATE_2_5_GBPS: return  1;
+	case IB_SA_RATE_5_GBPS:   return  2;
+	case IB_SA_RATE_10_GBPS:  return  4;
+	case IB_SA_RATE_20_GBPS:  return  8;
+	case IB_SA_RATE_30_GBPS:  return 12;
+	case IB_SA_RATE_40_GBPS:  return 16;
+	case IB_SA_RATE_60_GBPS:  return 24;
+	case IB_SA_RATE_80_GBPS:  return 32;
+	case IB_SA_RATE_120_GBPS: return 48;
+	default: 	          return -1;
+	}
+}
+
 typedef u64 __bitwise ib_sa_comp_mask;
 
 #define IB_SA_COMP_MASK(n)	((__force ib_sa_comp_mask) cpu_to_be64(1ull << n))
--- linux/drivers/infiniband/ulp/ipoib/ipoib_main.c	(revision 1410)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_main.c	(revision 1411)
@@ -283,21 +283,21 @@
 	skb_queue_head_init(&skqueue);
 
 	if (!status) {
-		/*
-		 * For now we set static_rate to 0.  This is not
-		 * really correct: we should look at the rate
-		 * component of the path member record, compare it
-		 * with the rate of our local port (calculated from
-		 * the active link speed and link width) and set an
-		 * inter-packet delay appropriately.
-		 */
 		struct ib_ah_attr av = {
 			.dlid 	       = be16_to_cpu(pathrec->dlid),
 			.sl 	       = pathrec->sl,
-			.static_rate   = 0,
 			.port_num      = priv->port
 		};
 
+		if (ib_sa_rate_enum_to_int(pathrec->rate) > 0)
+			av.static_rate = (2 * priv->local_rate -
+					  ib_sa_rate_enum_to_int(pathrec->rate) - 1) /
+				(priv->local_rate ? priv->local_rate : 1);
+
+		ipoib_dbg(priv, "static_rate %d for local port %dX, path %dX\n",
+			  av.static_rate, priv->local_rate,
+			  ib_sa_rate_enum_to_int(pathrec->rate));
+
 		ah = ipoib_create_ah(dev, priv->pd, &av);
 	}
 
--- linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1410)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1411)
@@ -238,19 +238,10 @@
 	}
 
 	{
-		/*
-		 * For now we set static_rate to 0.  This is not
-		 * really correct: we should look at the rate
-		 * component of the MC member record, compare it with
-		 * the rate of our local port (calculated from the
-		 * active link speed and link width) and set an
-		 * inter-packet delay appropriately.
-		 */
 		struct ib_ah_attr av = {
 			.dlid	       = be16_to_cpu(mcast->mcmember.mlid),
 			.port_num      = priv->port,
 			.sl	       = mcast->mcmember.sl,
-			.static_rate   = 0,
 			.ah_flags      = IB_AH_GRH,
 			.grh	       = {
 				.flow_label    = be32_to_cpu(mcast->mcmember.flow_label),
@@ -262,6 +253,15 @@
 
 		av.grh.dgid = mcast->mcmember.mgid;
 
+		if (ib_sa_rate_enum_to_int(mcast->mcmember.rate) > 0)
+			av.static_rate = (2 * priv->local_rate -
+					  ib_sa_rate_enum_to_int(mcast->mcmember.rate) - 1) /
+				(priv->local_rate ? priv->local_rate : 1);
+
+		ipoib_dbg_mcast(priv, "static_rate %d for local port %dX, mcmember %dX\n",
+				av.static_rate, priv->local_rate,
+				ib_sa_rate_enum_to_int(mcast->mcmember.rate));
+
 		mcast->ah = ipoib_create_ah(dev, priv->pd, &av);
 		if (!mcast->ah) {
 			ipoib_warn(priv, "ib_address_create failed\n");
@@ -506,6 +506,17 @@
 	else
 		memcpy(priv->dev->dev_addr + 4, priv->local_gid.raw, sizeof (union ib_gid));
 
+	{
+		struct ib_port_attr attr;
+
+		if (!ib_query_port(priv->ca, priv->port, &attr)) {
+			priv->local_lid  = attr.lid;
+			priv->local_rate = attr.active_speed *
+				ib_width_enum_to_int(attr.active_width);
+		} else
+			ipoib_warn(priv, "ib_query_port failed\n");
+	}
+
 	if (!priv->broadcast) {
 		priv->broadcast = ipoib_mcast_alloc(dev, 1);
 		if (!priv->broadcast) {
@@ -554,15 +565,6 @@
 		return;
 	}
 
-	{
-		struct ib_port_attr attr;
-
-		if (!ib_query_port(priv->ca, priv->port, &attr))
-			priv->local_lid = attr.lid;
-		else
-			ipoib_warn(priv, "ib_query_port failed\n");
-	}
-
 	priv->mcast_mtu = ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu) -
 		IPOIB_ENCAP_LEN;
 	dev->mtu = min(priv->mcast_mtu, priv->admin_mtu);
--- linux/drivers/infiniband/ulp/ipoib/ipoib.h	(revision 1410)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib.h	(revision 1411)
@@ -143,6 +143,7 @@
 
 	union ib_gid local_gid;
 	u16          local_lid;
+	u8           local_rate;
 
 	unsigned int admin_mtu;
 	unsigned int mcast_mtu;

