Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUFIEXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUFIEXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 00:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUFIEXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 00:23:46 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:36997 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265530AbUFIEXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 00:23:39 -0400
Date: Wed, 9 Jun 2004 14:23:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries vio_dev cleanups
Message-Id: <20040609142331.71544e13.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__9_Jun_2004_14_23_31_+1000_2wWXsTeLoeYSXXpF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__9_Jun_2004_14_23_31_+1000_2wWXsTeLoeYSXXpF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

This patch removes the archdata and driver_data members of struct vio_dev
and uses the platform_data and driver_data members of the embedded
struct device instead.  I also declared a couple of routines static.

This is part of a work in progress.  Please apply.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-rc3/arch/ppc64/kernel/vio.c 2.6.7-rc3.vio.1/arch/ppc64/kernel/vio.c
--- 2.6.7-rc3/arch/ppc64/kernel/vio.c	2004-06-08 10:30:52.000000000 +1000
+++ 2.6.7-rc3.vio.1/arch/ppc64/kernel/vio.c	2004-06-09 14:03:55.000000000 +1000
@@ -32,7 +32,9 @@
 
 extern struct subsystem devices_subsys; /* needed for vio_find_name() */
 
-struct iommu_table *vio_build_iommu_table(struct vio_dev *dev);
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *);
+static const struct vio_device_id *vio_match_device(
+		const struct vio_device_id *, const struct vio_dev *);
 
 #ifdef CONFIG_PPC_PSERIES
 static int vio_num_address_cells;
@@ -136,15 +138,15 @@
  * system is in its list of supported devices. Returns the matching
  * vio_device_id structure or NULL if there is no match.
  */
-const struct vio_device_id * vio_match_device(const struct vio_device_id *ids,
+static const struct vio_device_id * vio_match_device(const struct vio_device_id *ids,
 	const struct vio_dev *dev)
 {
 	DBGENTER();
 
 #ifdef CONFIG_PPC_PSERIES
 	while (ids->type) {
-		if ((strncmp(dev->archdata->type, ids->type, strlen(ids->type)) == 0) &&
-			device_is_compatible((struct device_node*)dev->archdata, ids->compat))
+		if ((strncmp(((struct device_node *)dev->dev.platform_data)->type, ids->type, strlen(ids->type)) == 0) &&
+			device_is_compatible(dev->dev.platform_data, ids->compat))
 			return ids;
 		ids++;
 	}
@@ -263,14 +265,13 @@
 	DBGENTER();
 
 	/* XXX free TCE table */
-	of_node_put(viodev->archdata);
+	of_node_put(viodev->dev.platform_data);
 	kfree(viodev);
 }
 
 static ssize_t viodev_show_devspec(struct device *dev, char *buf)
 {
-	struct vio_dev *viodev = to_vio_dev(dev);
-	struct device_node *of_node = viodev->archdata;
+	struct device_node *of_node = dev->platform_data;
 
 	return sprintf(buf, "%s\n", of_node->full_name);
 }
@@ -278,8 +279,7 @@
 
 static ssize_t viodev_show_name(struct device *dev, char *buf)
 {
-	struct vio_dev *viodev = to_vio_dev(dev);
-	struct device_node *of_node = viodev->archdata;
+	struct device_node *of_node = dev->platform_data;
 
 	return sprintf(buf, "%s\n", of_node->name);
 }
@@ -290,7 +290,7 @@
  * @of_node:	The OF node for this device.
  *
  * Creates and initializes a vio_dev structure from the data in
- * of_node (archdata) and adds it to the list of virtual devices.
+ * of_node (dev.platform_data) and adds it to the list of virtual devices.
  * Returns a pointer to the created vio_dev or NULL if node has
  * NULL device_type or compatible fields.
  */
@@ -324,7 +324,7 @@
 	}
 	memset(viodev, 0, sizeof(struct vio_dev));
 
-	viodev->archdata = (void *)of_node_get(of_node);
+	viodev->dev.platform_data = of_node_get(of_node);
 	viodev->unit_address = *unit_address;
 	viodev->iommu_table = vio_build_iommu_table(viodev);
 
@@ -380,7 +380,7 @@
 */
 const void * vio_get_attribute(struct vio_dev *vdev, void* which, int* length)
 {
-	return get_property((struct device_node *)vdev->archdata, (char*)which, length);
+	return get_property(vdev->dev.platform_data, (char*)which, length);
 }
 EXPORT_SYMBOL(vio_get_attribute);
 
@@ -427,7 +427,7 @@
  * Returns a pointer to the built tce tree, or NULL if it can't
  * find property.
 */
-struct iommu_table * vio_build_iommu_table(struct vio_dev *dev)
+static struct iommu_table * vio_build_iommu_table(struct vio_dev *dev)
 {
 	unsigned int *dma_window;
 	struct iommu_table *newTceTable;
@@ -435,7 +435,7 @@
 	unsigned long size;
 	int dma_window_property_size;
 
-	dma_window = (unsigned int *) get_property((struct device_node *)dev->archdata, "ibm,my-dma-window", &dma_window_property_size);
+	dma_window = (unsigned int *) get_property(dev->dev.platform_data, "ibm,my-dma-window", &dma_window_property_size);
 	if(!dma_window) {
 		return NULL;
 	}
diff -ruN 2.6.7-rc3/drivers/net/ibmveth.c 2.6.7-rc3.vio.1/drivers/net/ibmveth.c
--- 2.6.7-rc3/drivers/net/ibmveth.c	2004-06-08 10:31:05.000000000 +1000
+++ 2.6.7-rc3.vio.1/drivers/net/ibmveth.c	2004-06-09 14:04:44.000000000 +1000
@@ -901,7 +901,7 @@
 
 	adapter = netdev->priv;
 	memset(adapter, 0, sizeof(adapter));
-	dev->driver_data = netdev;
+	dev->dev.driver_data = netdev;
 
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
@@ -971,7 +971,7 @@
 
 static int __devexit ibmveth_remove(struct vio_dev *dev)
 {
-	struct net_device *netdev = dev->driver_data;
+	struct net_device *netdev = dev->dev.driver_data;
 	struct ibmveth_adapter *adapter = netdev->priv;
 
 	unregister_netdev(netdev);
diff -ruN 2.6.7-rc3/include/asm-ppc64/vio.h 2.6.7-rc3.vio.1/include/asm-ppc64/vio.h
--- 2.6.7-rc3/include/asm-ppc64/vio.h	2004-05-10 15:31:34.000000000 +1000
+++ 2.6.7-rc3.vio.1/include/asm-ppc64/vio.h	2004-06-09 14:05:04.000000000 +1000
@@ -43,8 +43,6 @@
 
 int vio_register_driver(struct vio_driver *drv);
 void vio_unregister_driver(struct vio_driver *drv);
-const struct vio_device_id * vio_match_device(const struct vio_device_id *ids, 
-						const struct vio_dev *dev);
 
 struct vio_dev * __devinit vio_register_device(struct device_node *node_vdev);
 void __devinit vio_unregister_device(struct vio_dev *dev);
@@ -52,7 +50,6 @@
 
 const void * vio_get_attribute(struct vio_dev *vdev, void* which, int* length);
 int vio_get_irq(struct vio_dev *dev);
-struct iommu_table * vio_build_iommu_table(struct vio_dev *dev);
 int vio_enable_interrupts(struct vio_dev *dev);
 int vio_disable_interrupts(struct vio_dev *dev);
 
@@ -110,8 +107,6 @@
  * The vio_dev structure is used to describe virtual I/O devices.
  */
 struct vio_dev {
-	struct device_node *archdata;   /* Open Firmware node */
-	void *driver_data;              /* data private to the driver */
 	struct iommu_table *iommu_table;     /* vio_map_* uses this */
 	uint32_t unit_address;	
 	unsigned int irq;

--Signature=_Wed__9_Jun_2004_14_23_31_+1000_2wWXsTeLoeYSXXpF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxpDDFG47PeJeR58RAi1pAKDJc1YQLFXT8dr5Y/w6DnH7LrNdMACfQSsv
yTKa27vH7z/pg9uqeHNydwI=
=A2gb
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jun_2004_14_23_31_+1000_2wWXsTeLoeYSXXpF--
