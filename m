Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTGAQcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTGAQcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:32:42 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:19205 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262931AbTGAQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:32:09 -0400
Subject: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       ak@suse.de, davem@redhat.com, suparna@in.ibm.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alex Williamson <alex_williamson@hp.com>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-ET5XZsnjad6wLdDlC2YZ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2003 11:46:12 -0500
Message-Id: <1057077975.2135.54.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ET5XZsnjad6wLdDlC2YZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Background:

Quite a few servers on the market today include an IOMMU to try to patch
up bus to memory accessibility issues.  However, a fair number come with
the caveat that actually using the IOMMU is expensive.

Some IOMMUs come with a "bypass" mode, where the IOMMU won't try to
translate the physical address coming from the device but will instead
place it directly on the memory bus. For some machines (ia-64, and
possibly x86_64) any address not programmed into the IOMMU for
translation is viewed as a bypass.  For others (parisc SBA) you have to
assert specific address bus bits to get the bypass.

All IOMMUs supporting the bypass mode will allow it to be used
selectively, so a DMA transfer may include SG both bypass and mapped
segments.

The Problem:

At the moment, the block layer assumes segments may be virtually
mergeable (i.e. two phsically discondiguous pages may be treated as a
single SG entity for DMA because the IOMMU will patch up the
discontinuity) if an IOMMU is present in the system.  This effectively
stymies using bypass mode, because segments may not be virtually merged
in a bypass operation.

The Solution:

Is to teach the block layer not to virtually merge segments if either
segment may be bypassed.  To that end, the block layer has to know what
the physical dma mask is (not the bounce limit, which is different) and
it must also know the address bits that must be asserted in bypass
mode.  To that end, I've introduced a new #define for asm/io.h

BIO_VMERGE_BYPASS_MASK

Which is set either to the physical bits that have to be asserted, or
simply to an address (like 0x1) that will always pass the device's
dma_mask.

I've also introduced a new block layer callback

blk_queue_dma_mask(q, dma_mask)

Who's job is to set the physical dma_mask of the queue (it defaults to
0xffffffff)

You can see how this works in the attached patch (block layer only; the
DMA engines of platforms wishing to take advantage of bypassing would
also have to be altered).

Comments?

James


--=-ET5XZsnjad6wLdDlC2YZ
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/block/DAC960.c 1.60 vs edited =3D=3D=3D=3D=3D
--- 1.60/drivers/block/DAC960.c	Fri Jun  6 01:37:51 2003
+++ edited/drivers/block/DAC960.c	Tue Jul  1 10:51:21 2003
@@ -2475,6 +2475,8 @@
   RequestQueue =3D &Controller->RequestQueue;
   blk_init_queue(RequestQueue, DAC960_RequestFunction, &Controller->queue_=
lock);
   blk_queue_bounce_limit(RequestQueue, Controller->BounceBufferLimit);
+  blk_queue_dma_mask(RequestQueue, Controller->BounceBufferLimit);
+
   RequestQueue->queuedata =3D Controller;
   blk_queue_max_hw_segments(RequestQueue,
 			    Controller->DriverScatterGatherLimit);
=3D=3D=3D=3D=3D drivers/block/cciss.c 1.82 vs edited =3D=3D=3D=3D=3D
--- 1.82/drivers/block/cciss.c	Thu Jun  5 08:17:28 2003
+++ edited/drivers/block/cciss.c	Tue Jul  1 10:49:56 2003
@@ -2541,6 +2541,7 @@
 	spin_lock_init(&hba[i]->lock);
         blk_init_queue(q, do_cciss_request, &hba[i]->lock);
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
+	blk_queue_dma_mask(q, hba[i]->pdev->dma_mask);
=20
 	/* This is a hardware imposed limit. */
 	blk_queue_max_hw_segments(q, MAXSGENTRIES);
=3D=3D=3D=3D=3D drivers/block/cpqarray.c 1.77 vs edited =3D=3D=3D=3D=3D
--- 1.77/drivers/block/cpqarray.c	Wed Jun 11 01:33:24 2003
+++ edited/drivers/block/cpqarray.c	Tue Jul  1 10:51:52 2003
@@ -389,6 +389,7 @@
 		spin_lock_init(&hba[i]->lock);
 		blk_init_queue(q, do_ida_request, &hba[i]->lock);
 		blk_queue_bounce_limit(q, hba[i]->pci_dev->dma_mask);
+		blk_queue_dma_mask(q, hba[i]->pci_dev->dma_mask);
=20
 		/* This is a hardware imposed limit. */
 		blk_queue_max_hw_segments(q, SG_MAX);
=3D=3D=3D=3D=3D drivers/block/ll_rw_blk.c 1.174 vs edited =3D=3D=3D=3D=3D
--- 1.174/drivers/block/ll_rw_blk.c	Mon Jun  2 20:32:46 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Jul  1 10:39:46 2003
@@ -213,12 +213,32 @@
 	 * by default assume old behaviour and bounce for any highmem page
 	 */
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+	/*
+	 * and assume a 32 bit dma mask=20
+	 */
+	blk_queue_dma_mask(q, 0xffffffff);
=20
 	init_waitqueue_head(&q->queue_wait);
 	INIT_LIST_HEAD(&q->plug_list);
 }
=20
 /**
+ * blk_queue_dma_mask - set queue dma mask
+ * @q:	the request queue for the device
+ * @dma_addr:	bus address limit
+ *
+ * Description:
+ *    This will set the device physical DMA mask.  This is used by
+ *    the bio layer to arrange the segments correctly for IOMMUs that
+ *    can be programmed in bypass mode.  Note: setting this does *not*
+ *    change whether the device goes through an IOMMU or not
+ **/
+void blk_queue_dma_mask(request_queue_t *q, u64 dma_mask)
+{
+	q->dma_mask =3D dma_mask;
+}
+
+/**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q:  the request queue for the device
  * @dma_addr:   bus address limit
@@ -746,7 +766,7 @@
 			continue;
 		}
 new_segment:
-		if (!bvprv || !BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+		if (!bvprv || !BIOVEC_VIRT_MERGEABLE(q, bvprv, bv))
 			nr_hw_segs++;
=20
 		nr_phys_segs++;
@@ -787,7 +807,7 @@
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
 		return 0;
=20
-	if (!BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(nxt)))
+	if (!BIOVEC_VIRT_MERGEABLE(q, __BVEC_END(bio), __BVEC_START(nxt)))
 		return 0;
 	if (bio->bi_size + nxt->bi_size > q->max_segment_size)
 		return 0;
@@ -909,7 +929,7 @@
 		return 0;
 	}
=20
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(req->biotail), __BVEC_START(bio)))
+	if (BIOVEC_VIRT_MERGEABLE(q, __BVEC_END(req->biotail), __BVEC_START(bio))=
)
 		return ll_new_mergeable(q, req, bio);
=20
 	return ll_new_hw_segment(q, req, bio);
@@ -924,7 +944,7 @@
 		return 0;
 	}
=20
-	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(bio), __BVEC_START(req->bio)))
+	if (BIOVEC_VIRT_MERGEABLE(q, __BVEC_END(bio), __BVEC_START(req->bio)))
 		return ll_new_mergeable(q, req, bio);
=20
 	return ll_new_hw_segment(q, req, bio);
=3D=3D=3D=3D=3D drivers/ide/ide-lib.c 1.8 vs edited =3D=3D=3D=3D=3D
--- 1.8/drivers/ide/ide-lib.c	Thu Mar  6 17:27:52 2003
+++ edited/drivers/ide/ide-lib.c	Tue Jul  1 10:49:14 2003
@@ -406,6 +406,9 @@
 			addr =3D HWIF(drive)->pci_dev->dma_mask;
 	}
=20
+	if((HWIF(drive)->pci_dev))
+		blk_queue_dma_mask(&drive->queue,
+				   HWIF(drive)->pci_dev->dma_mask);
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
=20
=3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.99 vs edited =3D=3D=3D=3D=3D
--- 1.99/drivers/scsi/scsi_lib.c	Sun Jun 29 20:14:44 2003
+++ edited/drivers/scsi/scsi_lib.c	Tue Jul  1 10:54:19 2003
@@ -1256,6 +1256,8 @@
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 	blk_queue_max_sectors(q, shost->max_sectors);
 	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
+	if(scsi_get_device(shost) && scsi_get_device(shost)->dma_mask)
+		blk_queue_dma_mask(q, *scsi_get_device(shost)->dma_mask);
=20
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
=3D=3D=3D=3D=3D include/linux/bio.h 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/include/linux/bio.h	Tue Jun 10 07:54:25 2003
+++ edited/include/linux/bio.h	Tue Jul  1 11:20:26 2003
@@ -30,6 +30,11 @@
 #define BIO_VMERGE_BOUNDARY	0
 #endif
=20
+/* Can the IOMMU (if any) work in bypass mode */
+#ifndef BIO_VMERGE_BYPASS_MASK
+#define BIO_VMERGE_BYPASS_MASK	0
+#endif
+
 #define BIO_DEBUG
=20
 #ifdef BIO_DEBUG
@@ -156,6 +161,13 @@
=20
 #define __bio_kunmap_atomic(addr, kmtype) kunmap_atomic(addr, kmtype)
=20
+/* can the bio vec be directly physically addressed by the device */
+#define __BVEC_PHYS_DIRECT_OK(q, vec) \
+	((bvec_to_phys(vec) & (q)->dma_mask) =3D=3D bvec_to_phys(vec))
+/* Is the queue dma_mask eligible to be bypassed */
+#define __BIO_CAN_BYPASS(q) \
+	((BIO_VMERGE_BYPASS_MASK) && ((q)->dma_mask & (BIO_VMERGE_BYPASS_MASK)) =
=3D=3D (BIO_VMERGE_BYPASS_MASK))
+
 /*
  * merge helpers etc
  */
@@ -164,8 +176,10 @@
 #define __BVEC_START(bio)	bio_iovec_idx((bio), 0)
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) =3D=3D bvec_to_phys((vec2)))
-#define BIOVEC_VIRT_MERGEABLE(vec1, vec2)	\
-	((((bvec_to_phys((vec1)) + (vec1)->bv_len) | bvec_to_phys((vec2))) & (BIO=
_VMERGE_BOUNDARY - 1)) =3D=3D 0)
+#define BIOVEC_VIRT_MERGEABLE(q, vec1, vec2)	\
+	(((((bvec_to_phys((vec1)) + (vec1)->bv_len) | bvec_to_phys((vec2))) & (BI=
O_VMERGE_BOUNDARY - 1)) =3D=3D 0) \
+	&& !( __BIO_CAN_BYPASS(q) && (__BVEC_PHYS_DIRECT_OK(q, vec1) \
+				      || __BVEC_PHYS_DIRECT_OK(q, vec2))))
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) =3D=3D (((addr2) - 1) | (mask)))
 #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
=3D=3D=3D=3D=3D include/linux/blkdev.h 1.109 vs edited =3D=3D=3D=3D=3D
--- 1.109/include/linux/blkdev.h	Wed Jun 11 20:17:55 2003
+++ edited/include/linux/blkdev.h	Tue Jul  1 10:39:18 2003
@@ -255,6 +255,12 @@
 	unsigned long		bounce_pfn;
 	int			bounce_gfp;
=20
+	/*
+	 * The physical dma_mask for the queue (used to make IOMMU
+	 * bypass decisions)
+	 */
+	u64			dma_mask;
+
 	struct list_head	plug_list;
=20
 	/*
@@ -458,6 +464,7 @@
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void blk_queue_bounce_limit(request_queue_t *, u64);
+extern void blk_queue_dma_mask(request_queue_t *, u64);
 extern void blk_queue_max_sectors(request_queue_t *, unsigned short);
 extern void blk_queue_max_phys_segments(request_queue_t *, unsigned short)=
;
 extern void blk_queue_max_hw_segments(request_queue_t *, unsigned short);

--=-ET5XZsnjad6wLdDlC2YZ--

