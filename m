Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUKOFyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUKOFyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKOFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:54:41 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:54157 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261453AbUKOFyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:54:17 -0500
Date: Mon, 15 Nov 2004 16:53:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64 iSeries: don't share request queues in viocd
Message-Id: <20041115165357.2e738704.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__15_Nov_2004_16_53_57_+1100_qIi5a5iag=Xc5uBf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__15_Nov_2004_16_53_57_+1100_qIi5a5iag=Xc5uBf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch fixes the virtual cdrom driver to not share a single request
queue.  Sharing the queue causes an oops if you remove the module and more
than one cdrom exists.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please apply and send to Linus.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linux-2.6.9/drivers/cdrom/viocd.c linux-2.6.9-sfr.1/drivers/cdrom/viocd.c
--- linux-2.6.9/drivers/cdrom/viocd.c	2004-10-19 07:55:35.000000000 +1000
+++ linux-2.6.9-sfr.1/drivers/cdrom/viocd.c	2004-11-15 16:29:36.000000000 +1100
@@ -154,7 +154,6 @@
 
 #define DEVICE_NR(di)	((di) - &viocd_diskinfo[0])
 
-static request_queue_t *viocd_queue;
 static spinlock_t viocd_reqlock;
 
 #define MAX_CD_REQ	1
@@ -503,6 +502,18 @@
 	return ret;
 }
 
+static void restart_all_queues(int first_index)
+{
+	int i;
+
+	for (i = first_index + 1; i < viocd_numdev; i++)
+		if (viocd_diskinfo[i].viocd_disk)
+			blk_run_queue(viocd_diskinfo[i].viocd_disk->queue);
+	for (i = 0; i <= first_index; i++)
+		if (viocd_diskinfo[i].viocd_disk)
+			blk_run_queue(viocd_diskinfo[i].viocd_disk->queue);
+}
+
 /* This routine handles incoming CD LP events */
 static void vio_handle_cd_event(struct HvLpEvent *event)
 {
@@ -532,7 +543,7 @@
 	case viocdopen:
 		if (event->xRc == 0) {
 			di = &viocd_diskinfo[bevent->disk];
-			blk_queue_hardsect_size(viocd_queue,
+			blk_queue_hardsect_size(di->viocd_disk->queue,
 					bevent->block_size);
 			set_capacity(di->viocd_disk,
 					bevent->media_size *
@@ -584,7 +595,7 @@
 
 		/* restart handling of incoming requests */
 		spin_unlock_irqrestore(&viocd_reqlock, flags);
-		blk_run_queue(viocd_queue);
+		restart_all_queues(bevent->disk);
 		break;
 
 	default:
@@ -624,6 +635,7 @@
 	struct disk_info *d;
 	struct cdrom_device_info *c;
 	struct cdrom_info *ci;
+	struct request_queue *q;
 
 	deviceno = vdev->unit_address;
 	if (deviceno >= viocd_numdev)
@@ -643,17 +655,22 @@
 	if (register_cdrom(c) != 0) {
 		printk(VIOCD_KERN_WARNING "Cannot register viocd CD-ROM %s!\n",
 				c->name);
-		return 0;
+		goto out;
 	}
 	printk(VIOCD_KERN_INFO "cd %s is iSeries resource %10.10s "
 			"type %4.4s, model %3.3s\n",
 			c->name, ci->rsrcname, ci->type, ci->model);
+	q = blk_init_queue(do_viocd_request, &viocd_reqlock);
+	if (q == NULL) {
+		printk(VIOCD_KERN_WARNING "Cannot allocate queue for %s!\n",
+				c->name);
+		goto out_unregister_cdrom;
+	}
 	gendisk = alloc_disk(1);
 	if (gendisk == NULL) {
 		printk(VIOCD_KERN_WARNING "Cannot create gendisk for %s!\n",
 				c->name);
-		unregister_cdrom(c);
-		return 0;
+		goto out_cleanup_queue;
 	}
 	gendisk->major = VIOCD_MAJOR;
 	gendisk->first_minor = deviceno;
@@ -661,7 +678,10 @@
 			sizeof(gendisk->disk_name));
 	snprintf(gendisk->devfs_name, sizeof(gendisk->devfs_name),
 			VIOCD_DEVICE_DEVFS "%d", deviceno);
-	gendisk->queue = viocd_queue;
+	blk_queue_max_hw_segments(q, 1);
+	blk_queue_max_phys_segments(q, 1);
+	blk_queue_max_sectors(q, 4096 / 512);
+	gendisk->queue = q;
 	gendisk->fops = &viocd_fops;
 	gendisk->flags = GENHD_FL_CD|GENHD_FL_REMOVABLE;
 	set_capacity(gendisk, 0);
@@ -670,8 +690,14 @@
 	d->dev = &vdev->dev;
 	gendisk->driverfs_dev = d->dev;
 	add_disk(gendisk);
-
 	return 0;
+
+out_cleanup_queue:
+	blk_cleanup_queue(q);
+out_unregister_cdrom:
+	unregister_cdrom(c);
+out:
+	return -ENODEV;
 }
 
 static int viocd_remove(struct vio_dev *vdev)
@@ -683,6 +709,7 @@
 				"Cannot unregister viocd CD-ROM %s!\n",
 				d->viocd_info.name);
 	del_gendisk(d->viocd_disk);
+	blk_cleanup_queue(d->viocd_disk->queue);
 	put_disk(d->viocd_disk);
 	return 0;
 }
@@ -742,18 +769,10 @@
 		goto out_undo_vio;
 
 	spin_lock_init(&viocd_reqlock);
-	viocd_queue = blk_init_queue(do_viocd_request, &viocd_reqlock);
-	if (viocd_queue == NULL) {
-		ret = -ENOMEM;
-		goto out_free_info;
-	}
-	blk_queue_max_hw_segments(viocd_queue, 1);
-	blk_queue_max_phys_segments(viocd_queue, 1);
-	blk_queue_max_sectors(viocd_queue, 4096 / 512);
 
 	ret = vio_register_driver(&viocd_driver);
 	if (ret)
-		goto out_cleanup_queue;
+		goto out_free_info;
 
 	e = create_proc_entry("iSeries/viocd", S_IFREG|S_IRUGO, NULL);
 	if (e) {
@@ -763,8 +782,6 @@
 
 	return 0;
 
-out_cleanup_queue:
-	blk_cleanup_queue(viocd_queue);
 out_free_info:
 	dma_free_coherent(iSeries_vio_dev,
 			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
@@ -781,7 +798,6 @@
 {
 	remove_proc_entry("iSeries/viocd", NULL);
 	vio_unregister_driver(&viocd_driver);
-	blk_cleanup_queue(viocd_queue);
 	if (viocd_unitinfo != NULL)
 		dma_free_coherent(iSeries_vio_dev,
 				sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,

--Signature=_Mon__15_Nov_2004_16_53_57_+1100_qIi5a5iag=Xc5uBf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBmER84CJfqux9a+8RAkgQAJ9cFG/dIzoWLOEYsac1U/Rv+hcSeQCfWCBj
S9s14aqFa1lf+sUXsnyiTcM=
=Mxrr
-----END PGP SIGNATURE-----

--Signature=_Mon__15_Nov_2004_16_53_57_+1100_qIi5a5iag=Xc5uBf--
