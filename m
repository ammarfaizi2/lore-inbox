Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVALVzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVALVzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVALVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:54:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261499AbVALVsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:40 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.O0tqjPJiAF6eouQF@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:19 -0800
Message-Id: <20051121348.HEHfXs5yLwYCfuQm@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][15/18] InfiniBand/core: add ib_find_cached_gid function
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:25.0313 (UTC) FILETIME=[717DDD10:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to find a port on a device given a GID by searching
the cached GID tables.  Document all cache functions in ib_cache.h.
Rename existing functions to better match format of verb routines.

Signed-off by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	(revision 1508)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	(revision 1509)
@@ -49,7 +49,7 @@
 	if (!qp_attr)
 		goto out;
 
-	if (ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index)) {
+	if (ib_find_cached_pkey(priv->ca, priv->port, priv->pkey, &pkey_index)) {
 		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
 		ret = -ENXIO;
 		goto out;
@@ -104,7 +104,7 @@
 	 * The port has to be assigned to the respective IB partition in
 	 * advance.
 	 */
-	ret = ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index);
+	ret = ib_find_cached_pkey(priv->ca, priv->port, priv->pkey, &pkey_index);
 	if (ret) {
 		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
 		return ret;
--- linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1508)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1509)
@@ -630,7 +630,7 @@
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	u16 pkey_index = 0;
 
-	if (ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index))
+	if (ib_find_cached_pkey(priv->ca, priv->port, priv->pkey, &pkey_index))
 		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
 	else
 		set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
--- linux/drivers/infiniband/include/ib_cache.h	(revision 1508)
+++ linux/drivers/infiniband/include/ib_cache.h	(revision 1509)
@@ -37,16 +37,66 @@
 
 #include <ib_verbs.h>
 
-int ib_cached_gid_get(struct ib_device    *device,
-		      u8                   port,
+/**
+ * ib_get_cached_gid - Returns a cached GID table entry
+ * @device: The device to query.
+ * @port_num: The port number of the device to query.
+ * @index: The index into the cached GID table to query.
+ * @gid: The GID value found at the specified index.
+ *
+ * ib_get_cached_gid() fetches the specified GID table entry stored in
+ * the local software cache.
+ */
+int ib_get_cached_gid(struct ib_device    *device,
+		      u8                   port_num,
 		      int                  index,
 		      union ib_gid        *gid);
-int ib_cached_pkey_get(struct ib_device    *device_handle,
-		       u8                   port,
+
+/**
+ * ib_find_cached_gid - Returns the port number and GID table index where
+ *   a specified GID value occurs.
+ * @device: The device to query.
+ * @gid: The GID value to search for.
+ * @port_num: The port number of the device where the GID value was found.
+ * @index: The index into the cached GID table where the GID was found.  This
+ *   parameter may be NULL.
+ *
+ * ib_find_cached_gid() searches for the specified GID value in
+ * the local software cache.
+ */
+int ib_find_cached_gid(struct ib_device *device,
+		       union ib_gid	*gid,
+		       u8               *port_num,
+		       u16              *index);
+
+/**
+ * ib_get_cached_pkey - Returns a cached PKey table entry
+ * @device: The device to query.
+ * @port_num: The port number of the device to query.
+ * @index: The index into the cached PKey table to query.
+ * @pkey: The PKey value found at the specified index.
+ *
+ * ib_get_cached_pkey() fetches the specified PKey table entry stored in
+ * the local software cache.
+ */
+int ib_get_cached_pkey(struct ib_device    *device_handle,
+		       u8                   port_num,
 		       int                  index,
 		       u16                 *pkey);
-int ib_cached_pkey_find(struct ib_device    *device,
-			u8                   port,
+
+/**
+ * ib_find_cached_pkey - Returns the PKey table index where a specified
+ *   PKey value occurs.
+ * @device: The device to query.
+ * @port_num: The port number of the device to search for the PKey.
+ * @pkey: The PKey value to search for.
+ * @index: The index into the cached PKey table where the PKey was found.
+ *
+ * ib_find_cached_pkey() searches the specified PKey table in
+ * the local software cache.
+ */
+int ib_find_cached_pkey(struct ib_device    *device,
+			u8                   port_num,
 			u16                  pkey,
 			u16                 *index);
 
--- linux/drivers/infiniband/core/cache.c	(revision 1508)
+++ linux/drivers/infiniband/core/cache.c	(revision 1509)
@@ -65,8 +65,8 @@
 	return device->node_type == IB_NODE_SWITCH ? 0 : device->phys_port_cnt;
 }
 
-int ib_cached_gid_get(struct ib_device *device,
-		      u8                port,
+int ib_get_cached_gid(struct ib_device *device,
+		      u8                port_num,
 		      int               index,
 		      union ib_gid     *gid)
 {
@@ -74,12 +74,12 @@
 	unsigned long flags;
 	int ret = 0;
 
-	if (port < start_port(device) || port > end_port(device))
+	if (port_num < start_port(device) || port_num > end_port(device))
 		return -EINVAL;
 
 	read_lock_irqsave(&device->cache.lock, flags);
 
-	cache = device->cache.gid_cache[port - start_port(device)];
+	cache = device->cache.gid_cache[port_num - start_port(device)];
 
 	if (index < 0 || index >= cache->table_len)
 		ret = -EINVAL;
@@ -90,10 +90,45 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(ib_cached_gid_get);
+EXPORT_SYMBOL(ib_get_cached_gid);
 
-int ib_cached_pkey_get(struct ib_device *device,
-		       u8                port,
+int ib_find_cached_gid(struct ib_device *device,
+		       union ib_gid	*gid,
+		       u8               *port_num,
+		       u16              *index)
+{
+	struct ib_gid_cache *cache;
+	unsigned long flags;
+	int p, i;
+	int ret = -ENOENT;
+
+	*port_num = -1;
+	if (index)
+		*index = -1;
+
+	read_lock_irqsave(&device->cache.lock, flags);
+
+	for (p = 0; p <= end_port(device) - start_port(device); ++p) {
+		cache = device->cache.gid_cache[p];
+		for (i = 0; i < cache->table_len; ++i) {
+			if (!memcmp(gid, &cache->table[i], sizeof *gid)) {
+				*port_num = p;
+				if (index)
+					*index = i;
+				ret = 0;
+				goto found;
+			}
+		}
+	}
+found:
+	read_unlock_irqrestore(&device->cache.lock, flags);
+	
+	return ret;
+}
+EXPORT_SYMBOL(ib_find_cached_gid);
+
+int ib_get_cached_pkey(struct ib_device *device,
+		       u8                port_num,
 		       int               index,
 		       u16              *pkey)
 {
@@ -101,12 +136,12 @@
 	unsigned long flags;
 	int ret = 0;
 
-	if (port < start_port(device) || port > end_port(device))
+	if (port_num < start_port(device) || port_num > end_port(device))
 		return -EINVAL;
 
 	read_lock_irqsave(&device->cache.lock, flags);
 
-	cache = device->cache.pkey_cache[port - start_port(device)];
+	cache = device->cache.pkey_cache[port_num - start_port(device)];
 
 	if (index < 0 || index >= cache->table_len)
 		ret = -EINVAL;
@@ -117,10 +152,10 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(ib_cached_pkey_get);
+EXPORT_SYMBOL(ib_get_cached_pkey);
 
-int ib_cached_pkey_find(struct ib_device *device,
-			u8                port,
+int ib_find_cached_pkey(struct ib_device *device,
+			u8                port_num,
 			u16               pkey,
 			u16              *index)
 {
@@ -129,12 +164,12 @@
 	int i;
 	int ret = -ENOENT;
 
-	if (port < start_port(device) || port > end_port(device))
+	if (port_num < start_port(device) || port_num > end_port(device))
 		return -EINVAL;
 
 	read_lock_irqsave(&device->cache.lock, flags);
 
-	cache = device->cache.pkey_cache[port - start_port(device)];
+	cache = device->cache.pkey_cache[port_num - start_port(device)];
 
 	*index = -1;
 
@@ -149,7 +184,7 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(ib_cached_pkey_find);
+EXPORT_SYMBOL(ib_find_cached_pkey);
 
 static void ib_cache_update(struct ib_device *device,
 			    u8                port)
--- linux/drivers/infiniband/hw/mthca/mthca_av.c	(revision 1508)
+++ linux/drivers/infiniband/hw/mthca/mthca_av.c	(revision 1509)
@@ -159,7 +159,7 @@
 			(be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 20) & 0xff;
 		header->grh.flow_label    =
 			ah->av->sl_tclass_flowlabel & cpu_to_be32(0xfffff);
-		ib_cached_gid_get(&dev->ib_dev,
+		ib_get_cached_gid(&dev->ib_dev,
 				  be32_to_cpu(ah->av->port_pd) >> 24,
 				  ah->av->gid_index,
 				  &header->grh.source_gid);
--- linux/drivers/infiniband/hw/mthca/mthca_qp.c	(revision 1508)
+++ linux/drivers/infiniband/hw/mthca/mthca_qp.c	(revision 1509)
@@ -1190,11 +1190,11 @@
 		sqp->ud_header.lrh.source_lid = 0xffff;
 	sqp->ud_header.bth.solicited_event = !!(wr->send_flags & IB_SEND_SOLICITED);
 	if (!sqp->qp.ibqp.qp_num)
-		ib_cached_pkey_get(&dev->ib_dev, sqp->port,
+		ib_get_cached_pkey(&dev->ib_dev, sqp->port,
 				   sqp->pkey_index,
 				   &sqp->ud_header.bth.pkey);
 	else
-		ib_cached_pkey_get(&dev->ib_dev, sqp->port,
+		ib_get_cached_pkey(&dev->ib_dev, sqp->port,
 				   wr->wr.ud.pkey_index,
 				   &sqp->ud_header.bth.pkey);
 	cpu_to_be16s(&sqp->ud_header.bth.pkey);

