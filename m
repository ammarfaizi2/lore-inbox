Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUF1Qdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUF1Qdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUF1Qdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:33:44 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:9891 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265060AbUF1Qd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:33:27 -0400
Date: Tue, 29 Jun 2004 02:33:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 1/5 PPC64 - vio infrastructure modifications
Message-Id: <20040629023327.5a48b499.sfr@canb.auug.org.au>
In-Reply-To: <20040629022806.4fda7605.sfr@canb.auug.org.au>
References: <20040629022806.4fda7605.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_33_27_+1000_eB6gnH2Uaq1xJ+Rk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_33_27_+1000_eB6gnH2Uaq1xJ+Rk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The intention here is to have no effect on pSeries except:
	1) vio_register_device is renamed to vio_register_device_node to
better reflect is purpose and to allow me to introduce
vio_register_device_iseries.
	2) I have introduced the name and type fields in struct vio_dev
to make these two fields independent of subarchitecture.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk9.base/arch/ppc64/kernel/vio.c 2.6.7-bk9.base.sysvio.1/arch/ppc64/kernel/vio.c
--- 2.6.7-bk9.base/arch/ppc64/kernel/vio.c	2004-06-16 22:15:20.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.1/arch/ppc64/kernel/vio.c	2004-06-27 21:05:41.000000000 +1000
@@ -32,16 +32,19 @@
 
 extern struct subsystem devices_subsys; /* needed for vio_find_name() */
 
-static struct iommu_table *vio_build_iommu_table(struct vio_dev *);
 static const struct vio_device_id *vio_match_device(
 		const struct vio_device_id *, const struct vio_dev *);
 
 #ifdef CONFIG_PPC_PSERIES
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *);
 static int vio_num_address_cells;
 #endif
 static struct vio_dev *vio_bus_device; /* fake "parent" device */
 
 #ifdef CONFIG_PPC_ISERIES
+static struct vio_dev *__init vio_register_device_iseries(char *type,
+		uint32_t unit_num);
+
 static struct iommu_table veth_iommu_table;
 static struct iommu_table vio_iommu_table;
 
@@ -59,6 +62,9 @@
 
 EXPORT_SYMBOL(iSeries_veth_dev);
 EXPORT_SYMBOL(iSeries_vio_dev);
+
+#define device_is_compatible(a, b)	1
+
 #endif
 
 /* convert from struct device to struct vio_dev and pass to driver.
@@ -143,14 +149,12 @@
 {
 	DBGENTER();
 
-#ifdef CONFIG_PPC_PSERIES
 	while (ids->type) {
-		if ((strncmp(((struct device_node *)dev->dev.platform_data)->type, ids->type, strlen(ids->type)) == 0) &&
+		if ((strncmp(dev->type, ids->type, strlen(ids->type)) == 0) &&
 			device_is_compatible(dev->dev.platform_data, ids->compat))
 			return ids;
 		ids++;
 	}
-#endif
 	return NULL;
 }
 
@@ -196,14 +200,41 @@
 }
 #endif
 
+#ifdef CONFIG_PPC_PSERIES
+static void probe_bus_pseries(void)
+{
+	struct device_node *node_vroot, *of_node;
+
+	node_vroot = find_devices("vdevice");
+	if ((node_vroot == NULL) || (node_vroot->child == NULL))
+		/* this machine doesn't do virtual IO, and that's ok */
+		return;
+
+	vio_num_address_cells = prom_n_addr_cells(node_vroot->child);
+
+	/*
+	 * Create struct vio_devices for each virtual device in the device tree.
+	 * Drivers will associate with them later.
+	 */
+	for (of_node = node_vroot->child; of_node != NULL;
+			of_node = of_node->sibling) {
+		printk(KERN_DEBUG "%s: processing %p\n", __FUNCTION__, of_node);
+		vio_register_device_node(of_node);
+	}
+}
+#endif
+
+#ifdef CONFIG_PPC_ISERIES
+static void probe_bus_iseries(void)
+{
+}
+#endif
+
 /**
  * vio_bus_init: - Initialize the virtual IO bus
  */
 static int __init vio_bus_init(void)
 {
-#ifdef CONFIG_PPC_PSERIES
-	struct device_node *node_vroot, *of_node;
-#endif
 	int err;
 
 	err = bus_register(&vio_bus_type);
@@ -229,25 +260,10 @@
 	}
 
 #ifdef CONFIG_PPC_PSERIES
-	node_vroot = find_devices("vdevice");
-	if ((node_vroot == NULL) || (node_vroot->child == NULL)) {
-		/* this machine doesn't do virtual IO, and that's ok */
-		return 0;
-	}
-
-	vio_num_address_cells = prom_n_addr_cells(node_vroot->child);
-
-	/*
-	 * Create struct vio_devices for each virtual device in the device tree.
-	 * Drivers will associate with them later.
-	 */
-	for (of_node = node_vroot->child;
-			of_node != NULL;
-			of_node = of_node->sibling) {
-		printk(KERN_DEBUG "%s: processing %p\n", __FUNCTION__, of_node);
-
-		vio_register_device(of_node);
-	}
+	probe_bus_pseries();
+#endif
+#ifdef CONFIG_PPC_ISERIES
+	probe_bus_iseries();
 #endif
 
 	return 0;
@@ -255,20 +271,19 @@
 
 __initcall(vio_bus_init);
 
-
-#ifdef CONFIG_PPC_PSERIES
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	struct vio_dev *viodev = to_vio_dev(dev);
-
 	DBGENTER();
 
+#ifdef CONFIG_PPC_PSERIES
 	/* XXX free TCE table */
-	of_node_put(viodev->dev.platform_data);
-	kfree(viodev);
+	of_node_put(dev->platform_data);
+#endif
+	kfree(to_vio_dev(dev));
 }
 
+#ifdef CONFIG_PPC_PSERIES
 static ssize_t viodev_show_devspec(struct device *dev, char *buf)
 {
 	struct device_node *of_node = dev->platform_data;
@@ -276,17 +291,43 @@
 	return sprintf(buf, "%s\n", of_node->full_name);
 }
 DEVICE_ATTR(devspec, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_devspec, NULL);
+#endif
 
 static ssize_t viodev_show_name(struct device *dev, char *buf)
 {
-	struct device_node *of_node = dev->platform_data;
-
-	return sprintf(buf, "%s\n", of_node->name);
+	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
 }
 DEVICE_ATTR(name, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_name, NULL);
 
+static struct vio_dev * __devinit vio_register_device_common(
+		struct vio_dev *viodev, char *name, char *type,
+		uint32_t unit_address, struct iommu_table *iommu_table)
+{
+	DBGENTER();
+
+	viodev->name = name;
+	viodev->type = type;
+	viodev->unit_address = unit_address;
+	viodev->iommu_table = iommu_table;
+	/* init generic 'struct device' fields: */
+	viodev->dev.parent = &vio_bus_device->dev;
+	viodev->dev.bus = &vio_bus_type;
+	viodev->dev.release = vio_dev_release;
+
+	/* register with generic device framework */
+	if (device_register(&viodev->dev)) {
+		printk(KERN_ERR "%s: failed to register device %s\n",
+				__FUNCTION__, viodev->dev.bus_id);
+		return NULL;
+	}
+	device_create_file(&viodev->dev, &dev_attr_name);
+
+	return viodev;
+}
+
+#ifdef CONFIG_PPC_PSERIES
 /**
- * vio_register_device: - Register a new vio device.
+ * vio_register_device_node: - Register a new vio device.
  * @of_node:	The OF node for this device.
  *
  * Creates and initializes a vio_dev structure from the data in
@@ -294,7 +335,7 @@
  * Returns a pointer to the created vio_dev or NULL if node has
  * NULL device_type or compatible fields.
  */
-struct vio_dev * __devinit vio_register_device(struct device_node *of_node)
+struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
 {
 	struct vio_dev *viodev;
 	unsigned int *unit_address;
@@ -325,8 +366,6 @@
 	memset(viodev, 0, sizeof(struct vio_dev));
 
 	viodev->dev.platform_data = of_node_get(of_node);
-	viodev->unit_address = *unit_address;
-	viodev->iommu_table = vio_build_iommu_table(viodev);
 
 	viodev->irq = NO_IRQ;
 	irq_p = (unsigned int *)get_property(of_node, "interrupts", 0);
@@ -339,36 +378,60 @@
 			viodev->irq = irq_offset_up(virq);
 	}
 
-	/* init generic 'struct device' fields: */
-	viodev->dev.parent = &vio_bus_device->dev;
-	viodev->dev.bus = &vio_bus_type;
-	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%x", viodev->unit_address);
-	viodev->dev.release = vio_dev_release;
+	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%x", *unit_address);
 
 	/* register with generic device framework */
-	if (device_register(&viodev->dev)) {
-		printk(KERN_ERR "%s: failed to register device %s\n", __FUNCTION__,
-			viodev->dev.bus_id);
+	if (vio_register_device_common(viodev, of_node->name, of_node->type,
+				*unit_address, vio_build_iommu_table(viodev))
+			== NULL) {
 		/* XXX free TCE table */
 		kfree(viodev);
 		return NULL;
 	}
-	device_create_file(&viodev->dev, &dev_attr_name);
 	device_create_file(&viodev->dev, &dev_attr_devspec);
 
 	return viodev;
 }
-EXPORT_SYMBOL(vio_register_device);
+EXPORT_SYMBOL(vio_register_device_node);
+#endif
+
+#ifdef CONFIG_PPC_ISERIES
+/**
+ * vio_register_device: - Register a new vio device.
+ * @voidev:	The device to register.
+ */
+static struct vio_dev *__init vio_register_device_iseries(char *type,
+		uint32_t unit_num)
+{
+	struct vio_dev *viodev;
+
+	DBGENTER();
+
+	/* allocate a vio_dev for this node */
+	viodev = kmalloc(sizeof(struct vio_dev), GFP_KERNEL);
+	if (!viodev)
+		return NULL;
+	memset(viodev, 0, sizeof(struct vio_dev));
+
+	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%s%d", type, unit_num);
+
+	return vio_register_device_common(viodev, viodev->dev.bus_id, type,
+			unit_num, &vio_iommu_table);
+}
+#endif
 
 void __devinit vio_unregister_device(struct vio_dev *viodev)
 {
 	DBGENTER();
+#ifdef CONFIG_PPC_PSERIES
 	device_remove_file(&viodev->dev, &dev_attr_devspec);
+#endif
 	device_remove_file(&viodev->dev, &dev_attr_name);
 	device_unregister(&viodev->dev);
 }
 EXPORT_SYMBOL(vio_unregister_device);
 
+#ifdef CONFIG_PPC_PSERIES
 /**
  * vio_get_attribute: - get attribute for virtual device
  * @vdev:	The vio device to get property.
diff -ruN 2.6.7-bk9.base/drivers/pci/hotplug/rpaphp_vio.c 2.6.7-bk9.base.sysvio.1/drivers/pci/hotplug/rpaphp_vio.c
--- 2.6.7-bk9.base/drivers/pci/hotplug/rpaphp_vio.c	2004-06-27 13:31:04.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.1/drivers/pci/hotplug/rpaphp_vio.c	2004-06-27 20:35:41.000000000 +1000
@@ -87,7 +87,7 @@
 	slot->dev_type = VIO_DEV;
 	slot->dev.vio_dev = vio_find_node(dn);
 	if (!slot->dev.vio_dev)
-		slot->dev.vio_dev = vio_register_device(dn);
+		slot->dev.vio_dev = vio_register_device_node(dn);
 	if (slot->dev.vio_dev)
 		slot->state = CONFIGURED;
 	else
@@ -108,7 +108,7 @@
 {
 	int retval = 0;
 
-	if ((slot->dev.vio_dev = vio_register_device(slot->dn))) {
+	if ((slot->dev.vio_dev = vio_register_device_node(slot->dn))) {
 		info("%s: VIO adapter %s in slot[%s] has been configured\n",
 			__FUNCTION__, slot->dn->name, slot->name);
 		slot->state = CONFIGURED;
diff -ruN 2.6.7-bk9.base/include/asm-ppc64/vio.h 2.6.7-bk9.base.sysvio.1/include/asm-ppc64/vio.h
--- 2.6.7-bk9.base/include/asm-ppc64/vio.h	2004-06-16 22:15:30.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.1/include/asm-ppc64/vio.h	2004-06-27 20:45:48.000000000 +1000
@@ -14,6 +14,7 @@
 #ifndef _ASM_VIO_H
 #define _ASM_VIO_H
 
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -44,7 +45,10 @@
 int vio_register_driver(struct vio_driver *drv);
 void vio_unregister_driver(struct vio_driver *drv);
 
-struct vio_dev * __devinit vio_register_device(struct device_node *node_vdev);
+#ifdef CONFIG_PPC_PSERIES
+struct vio_dev * __devinit vio_register_device_node(
+		struct device_node *node_vdev);
+#endif
 void __devinit vio_unregister_device(struct vio_dev *dev);
 struct vio_dev *vio_find_node(struct device_node *vnode);
 
@@ -108,6 +112,8 @@
  */
 struct vio_dev {
 	struct iommu_table *iommu_table;     /* vio_map_* uses this */
+	char *name;
+	char *type;
 	uint32_t unit_address;	
 	unsigned int irq;
 

--Signature=_Tue__29_Jun_2004_02_33_27_+1000_eB6gnH2Uaq1xJ+Rk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4EhX4CJfqux9a+8RAoTxAJwO7InKyZ912qIXpltlrkm4gKs0wACgjtlC
Kx0hBLkRTbzevo17iDLHLHM=
=frpb
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_33_27_+1000_eB6gnH2Uaq1xJ+Rk--
