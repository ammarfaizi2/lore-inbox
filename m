Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUFVEF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUFVEF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUFVEF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:05:26 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:23195 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266554AbUFVEER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:04:17 -0400
Date: Tue, 22 Jun 2004 14:04:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] iSeries virtual i/o sysfs files
Message-Id: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__22_Jun_2004_14_04_05_+1000_rGTloNOoW.RkaSYt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__22_Jun_2004_14_04_05_+1000_rGTloNOoW.RkaSYt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

This patch is to elicit comments (hopefully constructive).

OK, this is what the patch does.  All the iSeries virtual devices now
appear in /sys/devices/vio and /sys/bus/vio/devices.  Unfortunately,
apart from the veth devices, there are all possible devices there at
the moment - I need to think about how to reduce it but that requires
moving all the probe code into vio.c ...

However, in /sys/bus/drivers/<driver>/, the only devices listed are the
ones actually there.

veth devices are symlinked from /sys/class/net/eth<n>.

viodasd devices are linked from /sys/block/<dev>/device.  As are viocds.

viotape devices are linked from /sys/class/tape/.

I would like comments on the sysfs layout, any links/files I missed. I
know this needs more work and when I submit it, it will be in more
digestable pieces.  But if I can tie down the actual set of files provided
in sysfs, then that would be useful.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk4/arch/ppc64/kernel/vio.c 2.6.7-bk4.sysvio.1/arch/ppc64/kernel/vio.c
--- 2.6.7-bk4/arch/ppc64/kernel/vio.c	2004-06-16 22:15:20.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/arch/ppc64/kernel/vio.c	2004-06-20 01:36:26.000000000 +1000
@@ -26,17 +26,19 @@
 #include <asm/vio.h>
 #include <asm/hvcall.h>
 #include <asm/iSeries/vio.h>
+#include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvCallXm.h>
+#include <asm/iSeries/HvLpConfig.h>
 
 #define DBGENTER() pr_debug("%s entered\n", __FUNCTION__)
 
 extern struct subsystem devices_subsys; /* needed for vio_find_name() */
 
-static struct iommu_table *vio_build_iommu_table(struct vio_dev *);
 static const struct vio_device_id *vio_match_device(
 		const struct vio_device_id *, const struct vio_dev *);
 
 #ifdef CONFIG_PPC_PSERIES
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *);
 static int vio_num_address_cells;
 #endif
 static struct vio_dev *vio_bus_device; /* fake "parent" device */
@@ -45,20 +47,15 @@
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
+
+#define device_is_compatible(a, b)	1
+
 #endif
 
 /* convert from struct device to struct vio_dev and pass to driver.
@@ -143,14 +140,12 @@
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
 
@@ -196,14 +191,63 @@
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
+		vio_register_device(of_node);
+	}
+}
+#endif
+
+#ifdef CONFIG_PPC_ISERIES
+static void probe_bus_iseries(void)
+{
+	HvLpIndexMap vlan_map = HvLpConfig_getVirtualLanIndexMap();
+	struct vio_dev *viodev;
+	int i;
+
+	/* there is only one of each of these */
+	vio_register_device("viocons", 0);
+	vio_register_device("vioscsi", 0);
+
+	vlan_map = HvLpConfig_getVirtualLanIndexMap();
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
+		if ((vlan_map & (0x8000 >> i)) == 0)
+			continue;
+		viodev = vio_register_device("vlan", i);
+		/* veth is special and has it own iommu_table */
+		viodev->iommu_table = &veth_iommu_table;
+	}
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
+		vio_register_device("viodasd", i);
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
+		vio_register_device("viocd", i);
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
+		vio_register_device("viotape", i);
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
@@ -229,25 +273,10 @@
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
@@ -255,20 +284,19 @@
 
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
@@ -276,15 +304,41 @@
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
  * vio_register_device: - Register a new vio device.
  * @of_node:	The OF node for this device.
@@ -325,8 +379,6 @@
 	memset(viodev, 0, sizeof(struct vio_dev));
 
 	viodev->dev.platform_data = of_node_get(of_node);
-	viodev->unit_address = *unit_address;
-	viodev->iommu_table = vio_build_iommu_table(viodev);
 
 	viodev->irq = NO_IRQ;
 	irq_p = (unsigned int *)get_property(of_node, "interrupts", 0);
@@ -339,36 +391,59 @@
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
+#endif
+
+#ifdef CONFIG_PPC_ISERIES
+/**
+ * vio_register_device: - Register a new vio device.
+ * @voidev:	The device to register.
+ */
+struct vio_dev *__devinit vio_register_device(char *type, uint32_t unit_num)
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
 EXPORT_SYMBOL(vio_register_device);
 
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
diff -ruN 2.6.7-bk4/drivers/block/viodasd.c 2.6.7-bk4.sysvio.1/drivers/block/viodasd.c
--- 2.6.7-bk4/drivers/block/viodasd.c	2004-06-16 22:15:21.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/drivers/block/viodasd.c	2004-06-19 21:53:41.000000000 +1000
@@ -68,7 +68,7 @@
 
 enum {
 	PARTITION_SHIFT = 3,
-	MAX_DISKNO = 32,
+	MAX_DISKNO = HVMAXARCHITECTEDVIRTUALDISKS,
 	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
 };
 
@@ -168,6 +168,7 @@
 	int		read_only;
 	spinlock_t	q_lock;
 	struct gendisk	*disk;
+	struct device	*dev;
 } viodasd_devices[MAX_DISKNO];
 
 /*
@@ -342,7 +343,7 @@
 
 	/* Now build the scatter-gather list */
 	nsg = blk_rq_map_sg(req->q, req, sg);
-	nsg = dma_map_sg(iSeries_vio_dev, sg, nsg, direction);
+	nsg = dma_map_sg(d->dev, sg, nsg, direction);
 
 	spin_lock_irqsave(&viodasd_spinlock, flags);
 	num_req_outstanding++;
@@ -422,7 +423,7 @@
 error_ret:
 	num_req_outstanding--;
 	spin_unlock_irqrestore(&viodasd_spinlock, flags);
-	dma_unmap_sg(iSeries_vio_dev, sg, nsg, direction);
+	dma_unmap_sg(d->dev, sg, nsg, direction);
 	return -1;
 }
 
@@ -557,6 +558,7 @@
 	g->fops = &viodasd_fops;
 	g->queue = q;
 	g->private_data = d;
+	g->driverfs_dev = d->dev;
 	set_capacity(g, d->size >> 9);
 
 	printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
@@ -623,7 +625,7 @@
 	struct scatterlist sg[VIOMAXBLOCKDMA];
 	struct HvLpEvent *event = &bevent->event;
 	unsigned long irq_flags;
-	int device_no;
+	struct viodasd_device *d;
 	int error;
 	spinlock_t *qlock;
 
@@ -633,7 +635,10 @@
 		pci_direction = DMA_FROM_DEVICE;
 	else
 		pci_direction = DMA_TO_DEVICE;
-	dma_unmap_sg(iSeries_vio_dev, sg, num_sg, pci_direction);
+	req = (struct request *)bevent->event.xCorrelationToken;
+	d = req->rq_disk->private_data;
+
+	dma_unmap_sg(d->dev, sg, num_sg, pci_direction);
 
 	/*
 	 * Since this is running in interrupt mode, we need to make sure
@@ -643,9 +648,6 @@
 	num_req_outstanding--;
 	spin_unlock_irqrestore(&viodasd_spinlock, irq_flags);
 
-	req = (struct request *)bevent->event.xCorrelationToken;
-	device_no = DEVICE_NO(req->rq_disk->private_data);
-
 	error = event->xRc != HvLpEvent_Rc_Good;
 	if (error) {
 		const struct vio_error_entry *err;
@@ -660,7 +662,7 @@
 	spin_unlock_irqrestore(qlock, irq_flags);
 
 	/* Finally, try to get more requests off of this device's queue */
-	viodasd_restart_all_queues_starting_from(device_no);
+	viodasd_restart_all_queues_starting_from(DEVICE_NO(d));
 
 	return 0;
 }
@@ -744,8 +746,47 @@
 }
 static DRIVER_ATTR(probe, S_IWUSR, NULL, probe_disks)
 
+static int viodasd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	struct viodasd_device *d = &viodasd_devices[vdev->unit_address];
+
+	d->dev = &vdev->dev;
+	probe_disk(d);
+	if (d->disk == NULL)
+		return -ENODEV;
+	return 0;
+}
+
+static int viodasd_remove(struct vio_dev *vdev)
+{
+	struct viodasd_device *d;
+
+	d = &viodasd_devices[vdev->unit_address];
+	if (d->disk) {
+		del_gendisk(d->disk);
+		put_disk(d->disk);
+		blk_cleanup_queue(d->disk->queue);
+		d->disk = NULL;
+	}
+	d->dev = NULL;
+	return 0;
+}
+
+/**
+ * viodasd_device_table: Used by vio.c to match devices that we 
+ * support.
+ */
+static struct vio_device_id viodasd_device_table[] __devinitdata = {
+	{ "viodasd", "" },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(vio, viodasd_device_table);
 static struct vio_driver viodasd_driver = {
-	.name = "viodasd"
+	.name = "viodasd",
+	.id_table = viodasd_device_table,
+	.probe = viodasd_probe,
+	.remove = viodasd_remove
 };
 
 /*
@@ -754,7 +795,7 @@
  */
 static int __init viodasd_init(void)
 {
-	int i;
+	int rc;
 
 	/* Try to open to our host lp */
 	if (viopath_hostLp == HvLpIndexInvalid)
@@ -788,33 +829,17 @@
 	/* Initialize our request handler */
 	vio_setHandler(viomajorsubtype_blockio, handle_block_event);
 
-	for (i = 0; i < MAX_DISKNO; i++)
-		probe_disk(&viodasd_devices[i]);
-
-	vio_register_driver(&viodasd_driver);	/* FIX ME - error checking */
-	driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
-
-	return 0;
+	rc = vio_register_driver(&viodasd_driver);
+	if (rc == 0)
+		driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
+	return rc;
 }
 module_init(viodasd_init);
 
 void viodasd_exit(void)
 {
-	int i;
-	struct viodasd_device *d;
-
 	driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
 	vio_unregister_driver(&viodasd_driver);
-
-        for (i = 0; i < MAX_DISKNO; i++) {
-		d = &viodasd_devices[i];
-		if (d->disk) {
-			del_gendisk(d->disk);
-			put_disk(d->disk);
-			blk_cleanup_queue(d->disk->queue);
-			d->disk = NULL;
-		}
-	}
 	vio_clearHandler(viomajorsubtype_blockio);
 	unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
 	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
diff -ruN 2.6.7-bk4/drivers/cdrom/viocd.c 2.6.7-bk4.sysvio.1/drivers/cdrom/viocd.c
--- 2.6.7-bk4/drivers/cdrom/viocd.c	2004-05-10 15:31:08.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/drivers/cdrom/viocd.c	2004-06-20 00:11:22.000000000 +1000
@@ -44,6 +44,7 @@
 
 #include <asm/bug.h>
 
+#include <asm/vio.h>
 #include <asm/scatterlist.h>
 #include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvLpEvent.h>
@@ -84,7 +85,7 @@
 /*
  * Should probably make this a module parameter....sigh
  */
-#define VIOCD_MAX_CD 8
+#define VIOCD_MAX_CD	HVMAXARCHITECTEDVIRTUALCDROMS
 
 static const struct vio_error_entry viocd_err_table[] = {
 	{0x0201, EINVAL, "Invalid Range"},
@@ -144,6 +145,7 @@
 struct disk_info {
 	struct gendisk			*viocd_disk;
 	struct cdrom_device_info	viocd_info;
+	struct device			*dev;
 };
 static struct disk_info viocd_diskinfo[VIOCD_MAX_CD];
 
@@ -260,13 +262,13 @@
 	for (i = 0; (i < VIOCD_MAX_CD) && viocd_unitinfo[i].rsrcname[0]; i++)
 		viocd_numdev++;
 
-	return;
-
 error_ret:
-	dma_free_coherent(iSeries_vio_dev,
-			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-			viocd_unitinfo, unitinfo_dmaaddr);
-	viocd_unitinfo = NULL;
+	if (viocd_numdev == 0) {
+		dma_free_coherent(iSeries_vio_dev,
+				sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+				viocd_unitinfo, unitinfo_dmaaddr);
+		viocd_unitinfo = NULL;
+	}
 }
 
 static int viocd_open(struct cdrom_device_info *cdi, int purpose)
@@ -341,7 +343,7 @@
 		return -1;
 	}
 
-	if (dma_map_sg(iSeries_vio_dev, &sg, 1, DMA_FROM_DEVICE) == 0) {
+	if (dma_map_sg(diskinfo->dev, &sg, 1, DMA_FROM_DEVICE) == 0) {
 		printk(VIOCD_KERN_WARNING "error allocating sg tce\n");
 		return -1;
 	}
@@ -513,8 +515,9 @@
 		 * Since this is running in interrupt mode, we need to
 		 * make sure we're not stepping on any global I/O operations
 		 */
+		di = &viocd_diskinfo[bevent->disk];
 		spin_lock_irqsave(&viocd_reqlock, flags);
-		dma_unmap_single(iSeries_vio_dev, bevent->token, bevent->len,
+		dma_unmap_single(di->dev, bevent->token, bevent->len,
 				DMA_FROM_DEVICE);
 		req = (struct request *)bevent->event.xCorrelationToken;
 		rwreq--;
@@ -565,12 +568,97 @@
 	return entry->capability;
 }
 
-static int __init viocd_init(void)
+static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	struct gendisk *gendisk;
 	int deviceno;
-	int ret = 0;
+	struct disk_info *d;
+	struct cdrom_device_info *c;
+	struct cdrom_info *ci;
+
+	deviceno = vdev->unit_address;
+	if (deviceno >= viocd_numdev)
+		return -ENODEV;
+
+	d = &viocd_diskinfo[deviceno];
+	c = &d->viocd_info;
+	ci = &viocd_unitinfo[deviceno];
+
+	c->ops = &viocd_dops;
+	c->speed = 4;
+	c->capacity = 1;
+	c->handle = d;
+	c->mask = ~find_capability(ci->type);
+	sprintf(c->name, VIOCD_DEVICE "%c", 'a' + deviceno);
+
+	if (register_cdrom(c) != 0) {
+		printk(VIOCD_KERN_WARNING "Cannot register viocd CD-ROM %s!\n",
+				c->name);
+		return 0;
+	}
+	printk(VIOCD_KERN_INFO "cd %s is iSeries resource %10.10s "
+			"type %4.4s, model %3.3s\n",
+			c->name, ci->rsrcname, ci->type, ci->model);
+	gendisk = alloc_disk(1);
+	if (gendisk == NULL) {
+		printk(VIOCD_KERN_WARNING "Cannot create gendisk for %s!\n",
+				c->name);
+		unregister_cdrom(c);
+		return 0;
+	}
+	gendisk->major = VIOCD_MAJOR;
+	gendisk->first_minor = deviceno;
+	strncpy(gendisk->disk_name, c->name,
+			sizeof(gendisk->disk_name));
+	snprintf(gendisk->devfs_name, sizeof(gendisk->devfs_name),
+			VIOCD_DEVICE_DEVFS "%d", deviceno);
+	gendisk->queue = viocd_queue;
+	gendisk->fops = &viocd_fops;
+	gendisk->flags = GENHD_FL_CD|GENHD_FL_REMOVABLE;
+	set_capacity(gendisk, 0);
+	gendisk->private_data = d;
+	d->viocd_disk = gendisk;
+	d->dev = &vdev->dev;
+	gendisk->driverfs_dev = d->dev;
+	add_disk(gendisk);
+	
+	return 0;
+}
+
+static int viocd_remove(struct vio_dev *vdev)
+{
+	struct disk_info *d = &viocd_diskinfo[vdev->unit_address];
+
+	if (unregister_cdrom(&d->viocd_info) != 0)
+		printk(VIOCD_KERN_WARNING
+				"Cannot unregister viocd CD-ROM %s!\n",
+				d->viocd_info.name);
+	del_gendisk(d->viocd_disk);
+	put_disk(d->viocd_disk);
+	return 0;
+}
+
+/**
+ * viocd_device_table: Used by vio.c to match devices that we 
+ * support.
+ */
+static struct vio_device_id viocd_device_table[] __devinitdata = {
+	{ "viocd", "" },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(vio, viocd_device_table);
+static struct vio_driver viocd_driver = {
+	.name = "viocd",
+	.id_table = viocd_device_table,
+	.probe = viocd_probe,
+	.remove = viocd_remove
+};
+
+static int __init viocd_init(void)
+{
 	struct proc_dir_entry *e;
+	int ret = 0;
 
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		vio_set_hostlp();
@@ -583,8 +671,7 @@
 			viopath_hostLp);
 
 	if (register_blkdev(VIOCD_MAJOR, VIOCD_DEVICE) != 0) {
-		printk(VIOCD_KERN_WARNING
-				"Unable to get major %d for %s\n",
+		printk(VIOCD_KERN_WARNING "Unable to get major %d for %s\n",
 				VIOCD_MAJOR, VIOCD_DEVICE);
 		return -EIO;
 	}
@@ -605,59 +692,19 @@
 	if (viocd_numdev == 0)
 		goto out_undo_vio;
 
-	ret = -ENOMEM;
 	spin_lock_init(&viocd_reqlock);
 	viocd_queue = blk_init_queue(do_viocd_request, &viocd_reqlock);
-	if (viocd_queue == NULL)
-		goto out_unregister;
+	if (viocd_queue == NULL) {
+		ret = -ENOMEM;
+		goto out_free_info;
+	}
 	blk_queue_max_hw_segments(viocd_queue, 1);
 	blk_queue_max_phys_segments(viocd_queue, 1);
 	blk_queue_max_sectors(viocd_queue, 4096 / 512);
 
-	/* initialize units */
-	for (deviceno = 0; deviceno < viocd_numdev; deviceno++) {
-		struct disk_info *d = &viocd_diskinfo[deviceno];
-		struct cdrom_device_info *c = &d->viocd_info;
-		struct cdrom_info *ci = &viocd_unitinfo[deviceno];
-
-		c->ops = &viocd_dops;
-		c->speed = 4;
-		c->capacity = 1;
-		c->handle = d;
-		c->mask = ~find_capability(ci->type);
-		sprintf(c->name, VIOCD_DEVICE "%c", 'a' + deviceno);
-
-		if (register_cdrom(c) != 0) {
-			printk(VIOCD_KERN_WARNING
-					"Cannot register viocd CD-ROM %s!\n",
-					c->name);
-			continue;
-		}
-		printk(VIOCD_KERN_INFO "cd %s is iSeries resource %10.10s "
-				"type %4.4s, model %3.3s\n",
-				c->name, ci->rsrcname, ci->type, ci->model);
-		gendisk = alloc_disk(1);
-		if (gendisk == NULL) {
-			printk(VIOCD_KERN_WARNING
-					"Cannot create gendisk for %s!\n",
-					c->name);
-			unregister_cdrom(c);
-			continue;
-		}
-		gendisk->major = VIOCD_MAJOR;
-		gendisk->first_minor = deviceno;
-		strncpy(gendisk->disk_name, c->name,
-				sizeof(gendisk->disk_name));
-		snprintf(gendisk->devfs_name, sizeof(gendisk->devfs_name),
-				VIOCD_DEVICE_DEVFS "%d", deviceno);
-		gendisk->queue = viocd_queue;
-		gendisk->fops = &viocd_fops;
-		gendisk->flags = GENHD_FL_CD|GENHD_FL_REMOVABLE;
-		set_capacity(gendisk, 0);
-		gendisk->private_data = d;
-		d->viocd_disk = gendisk;
-		add_disk(gendisk);
-	}
+	ret = vio_register_driver(&viocd_driver);
+	if (ret)
+		goto out_cleanup_queue;
 
 	e = create_proc_entry("iSeries/viocd", S_IFREG|S_IRUGO, NULL);
 	if (e) {
@@ -667,6 +714,12 @@
 
 	return 0;
 
+out_cleanup_queue:
+	blk_cleanup_queue(viocd_queue);
+out_free_info:
+	dma_free_coherent(iSeries_vio_dev,
+			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+			viocd_unitinfo, unitinfo_dmaaddr);
 out_undo_vio:
 	vio_clearHandler(viomajorsubtype_cdio);
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, MAX_CD_REQ + 2);
@@ -677,18 +730,8 @@
 
 static void __exit viocd_exit(void)
 {
-	int deviceno;
-
 	remove_proc_entry("iSeries/viocd", NULL);
-	for (deviceno = 0; deviceno < viocd_numdev; deviceno++) {
-		struct disk_info *d = &viocd_diskinfo[deviceno];
-		if (unregister_cdrom(&d->viocd_info) != 0)
-			printk(VIOCD_KERN_WARNING
-					"Cannot unregister viocd CD-ROM %s!\n",
-					d->viocd_info.name);
-		del_gendisk(d->viocd_disk);
-		put_disk(d->viocd_disk);
-	}
+	vio_unregister_driver(&viocd_driver);
 	blk_cleanup_queue(viocd_queue);
 	if (viocd_unitinfo != NULL)
 		dma_free_coherent(iSeries_vio_dev,
diff -ruN 2.6.7-bk4/drivers/char/viotape.c 2.6.7-bk4.sysvio.1/drivers/char/viotape.c
--- 2.6.7-bk4/drivers/char/viotape.c	2004-05-10 15:31:09.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/drivers/char/viotape.c	2004-06-20 01:17:34.000000000 +1000
@@ -53,6 +53,7 @@
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
+#include <asm/vio.h>
 #include <asm/iSeries/vio.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvCallEvent.h>
@@ -216,7 +217,7 @@
 };
 
 /* Maximum number of tapes we support */
-#define VIOTAPE_MAX_TAPE	8
+#define VIOTAPE_MAX_TAPE	HVMAXARCHITECTEDVIRTUALTAPES
 #define MAX_PARTITIONS		4
 
 /* defines for current tape state */
@@ -238,6 +239,8 @@
 
 static struct class_simple *tape_class;
 
+static struct device *tape_device[VIOTAPE_MAX_TAPE];
+
 /*
  * maintain the current state of each tape (and partition)
  * so that we know when to write EOF marks.
@@ -262,6 +265,7 @@
 	int			rc;
 	int			non_blocking;
 	struct completion	com;
+	struct device		*dev;
 	struct op_struct	*next;
 };
 
@@ -459,7 +463,8 @@
 		down(&reqSem);
 
 	/* Allocate a DMA buffer */
-	op->buffer = dma_alloc_coherent(iSeries_vio_dev, count, &op->dmaaddr,
+	op->dev = tape_device[devi.devno];
+	op->buffer = dma_alloc_coherent(op->dev, count, &op->dmaaddr,
 			GFP_ATOMIC);
 
 	if (op->buffer == NULL) {
@@ -509,7 +514,7 @@
 	}
 
 free_dma:
-	dma_free_coherent(iSeries_vio_dev, count, op->buffer, op->dmaaddr);
+	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
 	up(&reqSem);
 free_op:
@@ -550,7 +555,8 @@
 	chg_state(devi.devno, VIOT_READING, file);
 
 	/* Allocate a DMA buffer */
-	op->buffer = dma_alloc_coherent(iSeries_vio_dev, count, &op->dmaaddr,
+	op->dev = tape_device[devi.devno];
+	op->buffer = dma_alloc_coherent(op->dev, count, &op->dmaaddr,
 			GFP_ATOMIC);
 	if (op->buffer == NULL) {
 		ret = -EFAULT;
@@ -588,7 +594,7 @@
 	}
 
 free_dma:
-	dma_free_coherent(iSeries_vio_dev, count, op->buffer, op->dmaaddr);
+	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
 	up(&reqSem);
 free_op:
@@ -910,7 +916,7 @@
 		break;
 	case viotapewrite:
 		if (op->non_blocking) {
-			dma_free_coherent(iSeries_vio_dev, op->count,
+			dma_free_coherent(op->dev, op->count,
 					op->buffer, op->dmaaddr);
 			free_op_struct(op);
 			up(&reqSem);
@@ -936,12 +942,70 @@
 	}
 }
 
+static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	char tapename[32];
+	int i = vdev->unit_address;
+	int j;
+
+	if (i >= viotape_numdev)
+		return -ENODEV;
+
+	tape_device[i] = &vdev->dev;
+
+	state[i].cur_part = 0;
+	for (j = 0; j < MAX_PARTITIONS; ++j)
+		state[i].part_stat_rwi[j] = VIOT_IDLE;
+	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i), NULL,
+			"iseries!vt%d", i);
+	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
+			NULL, "iseries!nvt%d", i);
+	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
+			"iseries/vt%d", i);
+	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
+			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
+	sprintf(tapename, "iseries/vt%d", i);
+	state[i].dev_handle = devfs_register_tape(tapename);
+	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
+			"resource %10.10s type %4.4s, model %3.3s\n",
+			tapename, viotape_unitinfo[i].rsrcname,
+			viotape_unitinfo[i].type, viotape_unitinfo[i].model);
+	return 0;
+}
+
+static int viotape_remove(struct vio_dev *vdev)
+{
+	int i = vdev->unit_address;
+
+	devfs_remove("iseries/nvt%d", i);
+	devfs_remove("iseries/vt%d", i);
+	devfs_unregister_tape(state[i].dev_handle);
+	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i | 0x80));
+	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i));
+	return 0;
+}
+
+/**
+ * viotape_device_table: Used by vio.c to match devices that we 
+ * support.
+ */
+static struct vio_device_id viotape_device_table[] __devinitdata = {
+	{ "viotape", "" },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(vio, viotape_device_table);
+static struct vio_driver viotape_driver = {
+	.name = "viotape",
+	.id_table = viotape_device_table,
+	.probe = viotape_probe,
+	.remove = viotape_remove
+};
+
 
 int __init viotap_init(void)
 {
 	int ret;
-	char tapename[32];
-	int i;
 	struct proc_dir_entry *e;
 
 	op_struct_list = NULL;
@@ -993,31 +1057,9 @@
 		goto unreg_class;
 	}
 
-	for (i = 0; i < viotape_numdev; i++) {
-		int j;
-
-		state[i].cur_part = 0;
-		for (j = 0; j < MAX_PARTITIONS; ++j)
-			state[i].part_stat_rwi[j] = VIOT_IDLE;
-		class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i),
-				NULL, "iseries!vt%d", i);
-		class_simple_device_add(tape_class,
-				MKDEV(VIOTAPE_MAJOR, i | 0x80),
-				NULL, "iseries!nvt%d", i);
-		devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"iseries/vt%d", i);
-		devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"iseries/nvt%d", i);
-		sprintf(tapename, "iseries/vt%d", i);
-		state[i].dev_handle = devfs_register_tape(tapename);
-		printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
-				"resource %10.10s type %4.4s, model %3.3s\n",
-				tapename, viotape_unitinfo[i].rsrcname,
-				viotape_unitinfo[i].type,
-				viotape_unitinfo[i].model);
-	}
+	ret = vio_register_driver(&viotape_driver);
+	if (ret)
+		goto unreg_class;
 
 	e = create_proc_entry("iSeries/viotape", S_IFREG|S_IRUGO, NULL);
 	if (e) {
@@ -1064,17 +1106,10 @@
 /* Cleanup */
 static void __exit viotap_exit(void)
 {
-	int i, ret;
+	int ret;
 
 	remove_proc_entry("iSeries/viotape", NULL);
-
-	for (i = 0; i < viotape_numdev; ++i) {
-		devfs_remove("iseries/nvt%d", i);
-		devfs_remove("iseries/vt%d", i);
-		devfs_unregister_tape(state[i].dev_handle);
-		class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i | 0x80));
-		class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i));
-	}
+	vio_unregister_driver(&viotape_driver);
 	class_simple_destroy(tape_class);
 	ret = unregister_chrdev(VIOTAPE_MAJOR, "viotape");
 	if (ret < 0)
diff -ruN 2.6.7-bk4/drivers/net/iseries_veth.c 2.6.7-bk4.sysvio.1/drivers/net/iseries_veth.c
--- 2.6.7-bk4/drivers/net/iseries_veth.c	2004-06-16 22:15:24.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/drivers/net/iseries_veth.c	2004-06-20 01:34:46.000000000 +1000
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
diff -ruN 2.6.7-bk4/drivers/net/iseries_veth.h 2.6.7-bk4.sysvio.1/drivers/net/iseries_veth.h
--- 2.6.7-bk4/drivers/net/iseries_veth.h	2004-05-10 15:31:17.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/drivers/net/iseries_veth.h	2004-06-10 17:23:33.000000000 +1000
@@ -43,6 +43,4 @@
 
 };
 
-#define HVMAXARCHITECTEDVIRTUALLANS (16)
-
 #endif	/* _ISERIES_VETH_H */
diff -ruN 2.6.7-bk4/include/asm-ppc64/iSeries/HvTypes.h 2.6.7-bk4.sysvio.1/include/asm-ppc64/iSeries/HvTypes.h
--- 2.6.7-bk4/include/asm-ppc64/iSeries/HvTypes.h	2004-02-04 17:25:21.000000000 +1100
+++ 2.6.7-bk4.sysvio.1/include/asm-ppc64/iSeries/HvTypes.h	2004-06-19 17:59:21.000000000 +1000
@@ -65,6 +65,10 @@
 
 
 #define HVMAXARCHITECTEDLPS 32
+#define HVMAXARCHITECTEDVIRTUALLANS 16
+#define HVMAXARCHITECTEDVIRTUALDISKS 32
+#define HVMAXARCHITECTEDVIRTUALCDROMS 8
+#define HVMAXARCHITECTEDVIRTUALTAPES 8
 #define HVCHUNKSIZE 256 * 1024
 #define HVPAGESIZE 4 * 1024
 #define HVLPMINMEGSPRIMARY 256
diff -ruN 2.6.7-bk4/include/asm-ppc64/vio.h 2.6.7-bk4.sysvio.1/include/asm-ppc64/vio.h
--- 2.6.7-bk4/include/asm-ppc64/vio.h	2004-06-16 22:15:30.000000000 +1000
+++ 2.6.7-bk4.sysvio.1/include/asm-ppc64/vio.h	2004-06-20 01:36:47.000000000 +1000
@@ -14,6 +14,7 @@
 #ifndef _ASM_VIO_H
 #define _ASM_VIO_H
 
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -44,7 +45,12 @@
 int vio_register_driver(struct vio_driver *drv);
 void vio_unregister_driver(struct vio_driver *drv);
 
+#ifdef CONFIG_PPC_PSERIES
 struct vio_dev * __devinit vio_register_device(struct device_node *node_vdev);
+#endif
+#ifdef CONFIG_PPC_ISERIES
+struct vio_dev * __devinit vio_register_device(char *type, uint32_t unit_num);
+#endif
 void __devinit vio_unregister_device(struct vio_dev *dev);
 struct vio_dev *vio_find_node(struct device_node *vnode);
 
@@ -108,6 +114,8 @@
  */
 struct vio_dev {
 	struct iommu_table *iommu_table;     /* vio_map_* uses this */
+	char *name;
+	char *type;
 	uint32_t unit_address;	
 	unsigned int irq;
 

--Signature=_Tue__22_Jun_2004_14_04_05_+1000_rGTloNOoW.RkaSYt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA16+7FG47PeJeR58RAr3nAKCIEMmobf3F4EXxl4oYKIBWBbyolQCg31qv
vmp5mmkEP6RXxYz3jVoCboU=
=6QYr
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Jun_2004_14_04_05_+1000_rGTloNOoW.RkaSYt--
