Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932862AbWF2Vq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbWF2Vq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWF2VoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:18 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35215 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932882AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 39] IB/ipath - use more appropriate gfp flags
X-Mercurial-Node: 9d943b828776136a2bb7f9311e28a3efa0a76160
Message-Id: <9d943b828776136a2bb7.1151617268@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:08 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This helps us to survive better when memory is fragmented.

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r fd5e733f02ac -r 9d943b828776 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:25 2006 -0700
@@ -705,6 +705,15 @@ static int ipath_create_user_egr(struct 
 	unsigned e, egrcnt, alloced, egrperchunk, chunk, egrsize, egroff;
 	size_t size;
 	int ret;
+	gfp_t gfp_flags;
+
+	/*
+	 * GFP_USER, but without GFP_FS, so buffer cache can be
+	 * coalesced (we hope); otherwise, even at order 4,
+	 * heavy filesystem activity makes these fail, and we can
+	 * use compound pages.
+	 */
+	gfp_flags = __GFP_WAIT | __GFP_IO | __GFP_COMP;
 
 	egrcnt = dd->ipath_rcvegrcnt;
 	/* TID number offset for this port */
@@ -721,10 +730,8 @@ static int ipath_create_user_egr(struct 
 	 * memory pressure (creating large files and then copying them over
 	 * NFS while doing lots of MPI jobs), we hit some allocation
 	 * failures, even though we can sleep...  (2.6.10) Still get
-	 * failures at 64K.  32K is the lowest we can go without waiting
-	 * more memory again.  It seems likely that the coalescing in
-	 * free_pages, etc. still has issues (as it has had previously
-	 * during 2.6.x development).
+	 * failures at 64K.  32K is the lowest we can go without wasting
+	 * additional memory.
 	 */
 	size = 0x8000;
 	alloced = ALIGN(egrsize * egrcnt, size);
@@ -745,12 +752,6 @@ static int ipath_create_user_egr(struct 
 		goto bail_rcvegrbuf;
 	}
 	for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
-		/*
-		 * GFP_USER, but without GFP_FS, so buffer cache can be
-		 * coalesced (we hope); otherwise, even at order 4,
-		 * heavy filesystem activity makes these fail
-		 */
-		gfp_t gfp_flags = __GFP_WAIT | __GFP_IO | __GFP_COMP;
 
 		pd->port_rcvegrbuf[e] = dma_alloc_coherent(
 			&dd->pcidev->dev, size, &pd->port_rcvegrbuf_phys[e],
@@ -1167,9 +1168,10 @@ static int ipath_mmap(struct file *fp, s
 
 	ureg = dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
 
-	ipath_cdbg(MM, "ushare: pgaddr %llx vm_start=%lx, vmlen %lx\n",
+	ipath_cdbg(MM, "pgaddr %llx vm_start=%lx len %lx port %u:%u\n",
 		   (unsigned long long) pgaddr, vma->vm_start,
-		   vma->vm_end - vma->vm_start);
+		   vma->vm_end - vma->vm_start, dd->ipath_unit,
+		   pd->port_port);
 
 	if (pgaddr == ureg)
 		ret = mmap_ureg(vma, dd, ureg);
