Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUF1QgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUF1QgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUF1QgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:36:18 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:11683 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265053AbUF1QfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:35:09 -0400
Date: Tue, 29 Jun 2004 02:35:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 2/5 PPC64 - iseries_veth integration
Message-Id: <20040629023509.295d70dc.sfr@canb.auug.org.au>
In-Reply-To: <20040629023327.5a48b499.sfr@canb.auug.org.au>
References: <20040629022806.4fda7605.sfr@canb.auug.org.au>
	<20040629023327.5a48b499.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_35_09_+1000_wYBzKV47sLd.kXuJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_35_09_+1000_wYBzKV47sLd.kXuJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk9.base.sysvio.1/arch/ppc64/kernel/vio.c 2.6.7-bk9.base.sysvio.2/arch/ppc64/kernel/vio.c
--- 2.6.7-bk9.base.sysvio.1/arch/ppc64/kernel/vio.c	2004-06-27 21:05:41.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.2/arch/ppc64/kernel/vio.c	2004-06-29 01:20:18.000000000 +1000
@@ -26,7 +26,9 @@
 #include <asm/vio.h>
 #include <asm/hvcall.h>
 #include <asm/iSeries/vio.h>
+#include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvCallXm.h>
+#include <asm/iSeries/HvLpConfig.h>
 
 #define DBGENTER() pr_debug("%s entered\n", __FUNCTION__)
 
@@ -48,19 +50,11 @@
 static struct iommu_table veth_iommu_table;
 static struct iommu_table vio_iommu_table;
 
-static struct vio_dev _veth_dev = {
-	.iommu_table = &veth_iommu_table,
-	.dev.bus = &vio_bus_type
-};
 static struct vio_dev _vio_dev  = {
 	.iommu_table = &vio_iommu_table,
 	.dev.bus = &vio_bus_type
 };
-
-struct vio_dev *iSeries_veth_dev = &_veth_dev;
 struct device *iSeries_vio_dev = &_vio_dev.dev;
-
-EXPORT_SYMBOL(iSeries_veth_dev);
 EXPORT_SYMBOL(iSeries_vio_dev);
 
 #define device_is_compatible(a, b)	1
@@ -227,6 +221,18 @@
 #ifdef CONFIG_PPC_ISERIES
 static void probe_bus_iseries(void)
 {
+	HvLpIndexMap vlan_map = HvLpConfig_getVirtualLanIndexMap();
+	struct vio_dev *viodev;
+	int i;
+
+	vlan_map = HvLpConfig_getVirtualLanIndexMap();
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
+		if ((vlan_map & (0x8000 >> i)) == 0)
+			continue;
+		viodev = vio_register_device_iseries("vlan", i);
+		/* veth is special and has it own iommu_table */
+		viodev->iommu_table = &veth_iommu_table;
+	}
 }
 #endif
 
diff -ruN 2.6.7-bk9.base.sysvio.1/drivers/net/iseries_veth.c 2.6.7-bk9.base.sysvio.2/drivers/net/iseries_veth.c
--- 2.6.7-bk9.base.sysvio.1/drivers/net/iseries_veth.c	2004-06-16 22:15:24.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.2/drivers/net/iseries_veth.c	2004-06-20 01:34:46.000000000 +1000
@@ -81,8 +81,6 @@
 
 #include "iseries_veth.h"
 
-extern struct vio_dev *iSeries_veth_dev;
-
 MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm.com>");
 MODULE_DESCRIPTION("iSeries Virtual ethernet driver");
 MODULE_LICENSE("GPL");
@@ -119,6 +117,7 @@
 	int token;
 	unsigned long in_use;
 	struct sk_buff *skb;
+	struct device *dev;
 };
 
 struct veth_lpar_connection {
@@ -147,6 +146,7 @@
 };
 
 struct veth_port {
+	struct device *dev;
 	struct net_device_stats stats;
 	u64 mac_addr;
 	HvLpIndexMap lpar_map;
@@ -843,7 +843,7 @@
 	spin_unlock_irqrestore(&port->pending_gate, flags);
 }
 
-struct net_device * __init veth_probe_one(int vlan)
+static struct net_device * __init veth_probe_one(int vlan, struct device *vdev)
 {
 	struct net_device *dev;
 	struct veth_port *port;
@@ -869,6 +869,7 @@
 		if (map & (0x8000 >> vlan))
 			port->lpar_map |= (1 << i);
 	}
+	port->dev = vdev;
 
 	dev->dev_addr[0] = 0x02;
 	dev->dev_addr[1] = 0x01;
@@ -893,6 +894,8 @@
 	dev->watchdog_timeo = 2 * (VETH_ACKTIMEOUT * HZ / 1000000);
 	dev->tx_timeout = veth_tx_timeout;
 
+	SET_NETDEV_DEV(dev, vdev);
+
 	rc = register_netdev(dev);
 	if (rc != 0) {
 		veth_printk(KERN_ERR,
@@ -945,7 +948,7 @@
 	}
 
 	dma_length = skb->len;
-	dma_address = vio_map_single(iSeries_veth_dev, skb->data,
+	dma_address = dma_map_single(port->dev, skb->data,
 				     dma_length, DMA_TO_DEVICE);
 
 	if (dma_mapping_error(dma_address))
@@ -954,6 +957,7 @@
 	/* Is it really necessary to check the length and address
 	 * fields of the first entry here? */
 	msg->skb = skb;
+	msg->dev = port->dev;
 	msg->data.addr[0] = dma_address;
 	msg->data.len[0] = dma_length;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
@@ -1059,7 +1063,7 @@
 		dma_address = msg->data.addr[0];
 		dma_length = msg->data.len[0];
 
-		vio_unmap_single(iSeries_veth_dev, dma_address, dma_length,
+		dma_unmap_single(msg->dev, dma_address, dma_length,
 				 DMA_TO_DEVICE);
 
 		if (msg->skb) {
@@ -1327,6 +1331,58 @@
 	spin_unlock_irqrestore(&cnx->lock, flags);
 }
 
+static int veth_remove(struct vio_dev *vdev)
+{
+	int i = vdev->unit_address;
+	struct net_device *dev;
+
+	dev = veth_dev[i];
+	if (dev != NULL) {
+		veth_dev[i] = NULL;
+		unregister_netdev(dev);
+		free_netdev(dev);
+	}
+	return 0;
+}
+
+static int veth_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	int i = vdev->unit_address;
+	struct net_device *dev;
+
+	dev = veth_probe_one(i, &vdev->dev);
+	if (dev == NULL) {
+		veth_remove(vdev);
+		return 1;
+	}
+	veth_dev[i] = dev;
+
+	/* Start the state machine on each connection, to commence
+	 * link negotiation */
+	for (i = 0; i < HVMAXARCHITECTEDLPS; i++)
+		if (veth_cnx[i])
+			veth_kick_statemachine(veth_cnx[i]);
+
+	return 0;
+}
+
+/**
+ * veth_device_table: Used by vio.c to match devices that we 
+ * support.
+ */
+static struct vio_device_id veth_device_table[] __devinitdata = {
+	{ "vlan", "" },
+	{ NULL, NULL }
+};
+MODULE_DEVICE_TABLE(vio, veth_device_table);
+
+static struct vio_driver veth_driver = {
+	.name = "iseries_veth",
+	.id_table = veth_device_table,
+	.probe = veth_probe,
+	.remove = veth_remove
+};
+
 /*
  * Module initialization/cleanup
  */
@@ -1335,27 +1391,17 @@
 {
 	int i;
 
+	vio_unregister_driver(&veth_driver);
+
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i)
 		veth_destroy_connection(i);
 
 	HvLpEvent_unregisterHandler(HvLpEvent_Type_VirtualLan);
-
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; ++i) {
-		struct net_device *dev = veth_dev[i];
-
-		if (! dev)
-			continue;
-
-		veth_dev[i] = NULL;
-		unregister_netdev(dev);
-		free_netdev(dev);
-	}
 }
 module_exit(veth_module_cleanup);
 
 int __init veth_module_init(void)
 {
-	HvLpIndexMap vlan_map = HvLpConfig_getVirtualLanIndexMap();
 	int i;
 	int rc;
 
@@ -1369,31 +1415,9 @@
 		}
 	}
 
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; ++i) {
-		struct net_device *dev;
-
-		if (! (vlan_map & (0x8000 >> i)))
-			continue;
-
-		dev = veth_probe_one(i);
-
-		if (! dev) {
-			veth_module_cleanup();
-			return rc;
-		}
-
-		veth_dev[i] = dev;
-	}
-
 	HvLpEvent_registerHandler(HvLpEvent_Type_VirtualLan,
 				  &veth_handle_event);
 
-	/* Start the state machine on each connection, to commence
-	 * link negotiation */
-	for (i = 0; i < HVMAXARCHITECTEDLPS; i++)
-		if (veth_cnx[i])
-			veth_kick_statemachine(veth_cnx[i]);
-
-	return 0;
+	return vio_register_driver(&veth_driver);
 }
 module_init(veth_module_init);
diff -ruN 2.6.7-bk9.base.sysvio.1/drivers/net/iseries_veth.h 2.6.7-bk9.base.sysvio.2/drivers/net/iseries_veth.h
--- 2.6.7-bk9.base.sysvio.1/drivers/net/iseries_veth.h	2004-05-10 15:31:17.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.2/drivers/net/iseries_veth.h	2004-06-10 17:23:33.000000000 +1000
@@ -43,6 +43,4 @@
 
 };
 
-#define HVMAXARCHITECTEDVIRTUALLANS (16)
-
 #endif	/* _ISERIES_VETH_H */
diff -ruN 2.6.7-bk9.base.sysvio.1/include/asm-ppc64/iSeries/HvTypes.h 2.6.7-bk9.base.sysvio.2/include/asm-ppc64/iSeries/HvTypes.h
--- 2.6.7-bk9.base.sysvio.1/include/asm-ppc64/iSeries/HvTypes.h	2004-02-04 17:25:21.000000000 +1100
+++ 2.6.7-bk9.base.sysvio.2/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:23:21.000000000 +1000
@@ -65,6 +65,7 @@
 
 
 #define HVMAXARCHITECTEDLPS 32
+#define HVMAXARCHITECTEDVIRTUALLANS 16
 #define HVCHUNKSIZE 256 * 1024
 #define HVPAGESIZE 4 * 1024
 #define HVLPMINMEGSPRIMARY 256

--Signature=_Tue__29_Jun_2004_02_35_09_+1000_wYBzKV47sLd.kXuJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Ei94CJfqux9a+8RAp1WAJ0Sx+pCQnIaMUbNa0hd4YpqMgQcowCglvbh
/LqD1ZfRunH4ki9hKd+v17o=
=LuUH
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_35_09_+1000_wYBzKV47sLd.kXuJ--
