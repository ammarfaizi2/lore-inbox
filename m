Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUDVBA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUDVBA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUDVBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 21:00:28 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:17148 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263763AbUDVBAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 21:00:18 -0400
Date: Thu, 22 Apr 2004 10:58:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries virtual cdrom module fix
Message-Id: <20040422105836.0ac99736.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__22_Apr_2004_10_58_36_+1000_S2qbxRVMoxdOU2to"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__22_Apr_2004_10_58_36_+1000_S2qbxRVMoxdOU2to
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch fixes loading viocd as a module.  It would oops because
I was passing the address of a static buffer to dma_map_single and
when loaded as a module, this address is not valid for that purpose.

There are a couple of simple cleanups here as well.

Please apply to your tree and send upstream.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.6-rc2/drivers/cdrom/viocd.c 2.6.6-rc2.viocd/drivers/cdrom/viocd.c
--- 2.6.6-rc2/drivers/cdrom/viocd.c	2004-04-05 10:22:34.000000000 +1000
+++ 2.6.6-rc2.viocd/drivers/cdrom/viocd.c	2004-04-22 02:14:07.000000000 +1000
@@ -132,7 +132,12 @@
 	char	type[4];
 	char	model[3];
 };
-static struct cdrom_info viocd_unitinfo[VIOCD_MAX_CD];
+/*
+ * This needs to be allocated since it is passed to the
+ * Hypervisor and we may be a module.
+ */
+static struct cdrom_info *viocd_unitinfo;
+static dma_addr_t unitinfo_dmaaddr;
 
 struct disk_info {
 	struct gendisk			*viocd_disk;
@@ -141,7 +146,6 @@
 static struct disk_info viocd_diskinfo[VIOCD_MAX_CD];
 
 #define DEVICE_NR(di)	((di) - &viocd_diskinfo[0])
-#define VIOCDI		viocd_diskinfo[deviceno].viocd_info
 
 static request_queue_t *viocd_queue;
 static spinlock_t viocd_reqlock;
@@ -184,18 +188,20 @@
 /* Get info on CD devices from OS/400 */
 static void __init get_viocd_info(void)
 {
-	dma_addr_t dmaaddr;
 	HvLpEvent_Rc hvrc;
 	int i;
 	struct viocd_waitevent we;
 
-	dmaaddr = dma_map_single(iSeries_vio_dev, viocd_unitinfo,
-			sizeof(viocd_unitinfo), DMA_FROM_DEVICE);
-	if (dmaaddr == (dma_addr_t)-1) {
-		printk(VIOCD_KERN_WARNING "error allocating tce\n");
+	viocd_unitinfo = dma_alloc_coherent(iSeries_vio_dev,
+			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+			&unitinfo_dmaaddr, GFP_ATOMIC);
+	if (viocd_unitinfo == NULL) {
+		printk(VIOCD_KERN_WARNING "error allocating unitinfo\n");
 		return;
 	}
 
+	memset(viocd_unitinfo, 0, sizeof(*viocd_unitinfo) * VIOCD_MAX_CD);
+
 	init_completion(&we.com);
 
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
@@ -204,29 +210,34 @@
 			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
 			viopath_sourceinst(viopath_hostLp),
 			viopath_targetinst(viopath_hostLp),
-			(u64)&we, VIOVERSION << 16, dmaaddr, 0,
-			sizeof(viocd_unitinfo), 0);
+			(u64)&we, VIOVERSION << 16, unitinfo_dmaaddr, 0,
+			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD, 0);
 	if (hvrc != HvLpEvent_Rc_Good) {
 		printk(VIOCD_KERN_WARNING "cdrom error sending event. rc %d\n",
 				(int)hvrc);
-		return;
+		goto error_ret;
 	}
 
 	wait_for_completion(&we.com);
 
-	dma_unmap_single(iSeries_vio_dev, dmaaddr, sizeof(viocd_unitinfo),
-			DMA_FROM_DEVICE);
-
 	if (we.rc) {
 		const struct vio_error_entry *err =
 			vio_lookup_rc(viocd_err_table, we.sub_result);
 		printk(VIOCD_KERN_WARNING "bad rc %d:0x%04X on getinfo: %s\n",
 				we.rc, we.sub_result, err->msg);
-		return;
+		goto error_ret;
 	}
 
 	for (i = 0; (i < VIOCD_MAX_CD) && viocd_unitinfo[i].rsrcname[0]; i++)
 		viocd_numdev++;
+
+	return;
+
+error_ret:
+	dma_free_coherent(iSeries_vio_dev,
+			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+			viocd_unitinfo, unitinfo_dmaaddr);
+	viocd_unitinfo = NULL;
 }
 
 static int viocd_open(struct cdrom_device_info *cdi, int purpose)
@@ -307,10 +318,6 @@
 	}
 	dmaaddr = sg_dma_address(&sg);
 	len = sg_dma_len(&sg);
-	if (dmaaddr == (dma_addr_t)-1) {
-		printk(VIOCD_KERN_WARNING "error allocating tce\n");
-		return -1;
-	}
 
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
 			HvLpEvent_Type_VirtualIo,
@@ -604,7 +611,7 @@
 			printk(VIOCD_KERN_WARNING
 					"Cannot create gendisk for %s!\n",
 					c->name);
-			unregister_cdrom(&VIOCDI);
+			unregister_cdrom(c);
 			continue;
 		}
 		gendisk->major = VIOCD_MAJOR;
@@ -646,7 +653,10 @@
 		put_disk(d->viocd_disk);
 	}
 	blk_cleanup_queue(viocd_queue);
-
+	if (viocd_unitinfo != NULL)
+		dma_free_coherent(iSeries_vio_dev,
+				sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+				viocd_unitinfo, unitinfo_dmaaddr);
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, MAX_CD_REQ + 2);
 	vio_clearHandler(viomajorsubtype_cdio);
 	unregister_blkdev(VIOCD_MAJOR, VIOCD_DEVICE);

--Signature=_Thu__22_Apr_2004_10_58_36_+1000_S2qbxRVMoxdOU2to
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhxjAFG47PeJeR58RAhS3AKC/uKwd7s0ErtDe1Sj1OBjnFVEEIgCgwkFW
yFEeF7PwLVY+1ZEedZUDh7g=
=g6Hq
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Apr_2004_10_58_36_+1000_S2qbxRVMoxdOU2to--
