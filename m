Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUF1Qi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUF1Qi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUF1Qi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:38:56 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:15267 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265063AbUF1QiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:38:24 -0400
Date: Tue, 29 Jun 2004 02:38:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 3/5 PPC64 - viodasd integration
Message-Id: <20040629023825.01a629de.sfr@canb.auug.org.au>
In-Reply-To: <20040629023509.295d70dc.sfr@canb.auug.org.au>
References: <20040629022806.4fda7605.sfr@canb.auug.org.au>
	<20040629023327.5a48b499.sfr@canb.auug.org.au>
	<20040629023509.295d70dc.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_38_25_+1000_jvRPD.9FrMtuGeRZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_38_25_+1000_jvRPD.9FrMtuGeRZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

[Just realised I forgot the signed-off-by stuff]

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk9.base.sysvio.2/arch/ppc64/kernel/vio.c 2.6.7-bk9.base.sysvio.3/arch/ppc64/kernel/vio.c
--- 2.6.7-bk9.base.sysvio.2/arch/ppc64/kernel/vio.c	2004-06-29 01:20:18.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.3/arch/ppc64/kernel/vio.c	2004-06-29 01:31:21.000000000 +1000
@@ -233,6 +233,8 @@
 		/* veth is special and has it own iommu_table */
 		viodev->iommu_table = &veth_iommu_table;
 	}
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
+		vio_register_device_iseries("viodasd", i);
 }
 #endif
 
diff -ruN 2.6.7-bk9.base.sysvio.2/drivers/block/viodasd.c 2.6.7-bk9.base.sysvio.3/drivers/block/viodasd.c
--- 2.6.7-bk9.base.sysvio.2/drivers/block/viodasd.c	2004-06-27 20:30:00.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.3/drivers/block/viodasd.c	2004-06-27 20:33:23.000000000 +1000
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
 static DRIVER_ATTR(probe, S_IWUSR, NULL, probe_disks);
 
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
diff -ruN 2.6.7-bk9.base.sysvio.2/include/asm-ppc64/iSeries/HvTypes.h 2.6.7-bk9.base.sysvio.3/include/asm-ppc64/iSeries/HvTypes.h
--- 2.6.7-bk9.base.sysvio.2/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:23:21.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.3/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:39:53.000000000 +1000
@@ -66,6 +66,7 @@
 
 #define HVMAXARCHITECTEDLPS 32
 #define HVMAXARCHITECTEDVIRTUALLANS 16
+#define HVMAXARCHITECTEDVIRTUALDISKS 32
 #define HVCHUNKSIZE 256 * 1024
 #define HVPAGESIZE 4 * 1024
 #define HVLPMINMEGSPRIMARY 256

--Signature=_Tue__29_Jun_2004_02_38_25_+1000_jvRPD.9FrMtuGeRZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4EmB4CJfqux9a+8RAg/SAJ0f02+cnQFKCYoAHXlUvxwdXMq95QCdFVrB
Z8KUOZP/gqI+f5N6bQD70wM=
=/50N
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_38_25_+1000_jvRPD.9FrMtuGeRZ--
