Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUF1Qkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUF1Qkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbUF1Qkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:40:45 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:16291 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265065AbUF1Qjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:39:55 -0400
Date: Tue, 29 Jun 2004 02:39:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 4/5 PPC64 - viocd integration
Message-Id: <20040629023956.3f2dab50.sfr@canb.auug.org.au>
In-Reply-To: <20040629023825.01a629de.sfr@canb.auug.org.au>
References: <20040629022806.4fda7605.sfr@canb.auug.org.au>
	<20040629023327.5a48b499.sfr@canb.auug.org.au>
	<20040629023509.295d70dc.sfr@canb.auug.org.au>
	<20040629023825.01a629de.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_39_56_+1000_g6OKcCqAVsww8Jt_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_39_56_+1000_g6OKcCqAVsww8Jt_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk9.base.sysvio.3/arch/ppc64/kernel/vio.c 2.6.7-bk9.base.sysvio.4/arch/ppc64/kernel/vio.c
--- 2.6.7-bk9.base.sysvio.3/arch/ppc64/kernel/vio.c	2004-06-29 01:31:21.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.4/arch/ppc64/kernel/vio.c	2004-06-29 01:48:10.000000000 +1000
@@ -235,6 +235,8 @@
 	}
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
 		vio_register_device_iseries("viodasd", i);
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
+		vio_register_device_iseries("viocd", i);
 }
 #endif
 
diff -ruN 2.6.7-bk9.base.sysvio.3/drivers/cdrom/viocd.c 2.6.7-bk9.base.sysvio.4/drivers/cdrom/viocd.c
--- 2.6.7-bk9.base.sysvio.3/drivers/cdrom/viocd.c	2004-05-10 15:31:08.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.4/drivers/cdrom/viocd.c	2004-06-20 00:11:22.000000000 +1000
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
diff -ruN 2.6.7-bk9.base.sysvio.3/include/asm-ppc64/iSeries/HvTypes.h 2.6.7-bk9.base.sysvio.4/include/asm-ppc64/iSeries/HvTypes.h
--- 2.6.7-bk9.base.sysvio.3/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:39:53.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.4/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:49:33.000000000 +1000
@@ -67,6 +67,7 @@
 #define HVMAXARCHITECTEDLPS 32
 #define HVMAXARCHITECTEDVIRTUALLANS 16
 #define HVMAXARCHITECTEDVIRTUALDISKS 32
+#define HVMAXARCHITECTEDVIRTUALCDROMS 8
 #define HVCHUNKSIZE 256 * 1024
 #define HVPAGESIZE 4 * 1024
 #define HVLPMINMEGSPRIMARY 256

--Signature=_Tue__29_Jun_2004_02_39_56_+1000_g6OKcCqAVsww8Jt_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Enc4CJfqux9a+8RAqrAAJ40VNLTUX+5B4m6Mjm+b+Bk3K0e/wCePNRn
onUzX+TriOKpbC+bhYN5USE=
=YQ5A
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_39_56_+1000_g6OKcCqAVsww8Jt_--
