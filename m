Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWGMPdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWGMPdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWGMPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:33:08 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:28336 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S1030233AbWGMPdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:33:07 -0400
Date: Thu, 13 Jul 2006 18:33:44 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fmr pool: remove unnecessary pointer dereference
Message-ID: <20060713153344.GA22648@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060709090521.GB2609@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709090521.GB2609@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Jul 2006 15:38:19.0750 (UTC) FILETIME=[5DE71860:01C6A692]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you please drop the following into -mm and on to Linus?

---

ib_fmr_pool_map_phys gets the virtual address by pointer but never writes there,
and users (e.g. srp) seem to assume this and ignore the value returned. This
patch cleans up the API to get the VA by value, and updates all users.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Acked-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/rdma/ib_fmr_pool.h b/include/rdma/ib_fmr_pool.h
index 4ace54c..00dadbf 100644
--- a/include/rdma/ib_fmr_pool.h
+++ b/include/rdma/ib_fmr_pool.h
@@ -88,7 +88,7 @@ int ib_flush_fmr_pool(struct ib_fmr_pool
 struct ib_pool_fmr *ib_fmr_pool_map_phys(struct ib_fmr_pool *pool_handle,
 					 u64                *page_list,
 					 int                 list_len,
-					 u64                *io_virtual_address);
+					 u64                 io_virtual_address);
 
 int ib_fmr_pool_unmap(struct ib_pool_fmr *fmr);
diff --git a/drivers/infiniband/core/fmr_pool.c b/drivers/infiniband/core/fmr_pool.c
index 615fe9c..86a3b2d 100644
--- a/drivers/infiniband/core/fmr_pool.c
+++ b/drivers/infiniband/core/fmr_pool.c
@@ -426,7 +426,7 @@ EXPORT_SYMBOL(ib_flush_fmr_pool);
 struct ib_pool_fmr *ib_fmr_pool_map_phys(struct ib_fmr_pool *pool_handle,
 					 u64                *page_list,
 					 int                 list_len,
-					 u64                *io_virtual_address)
+					 u64                 io_virtual_address)
 {
 	struct ib_fmr_pool *pool = pool_handle;
 	struct ib_pool_fmr *fmr;
@@ -440,7 +440,7 @@ struct ib_pool_fmr *ib_fmr_pool_map_phys
 	fmr = ib_fmr_cache_lookup(pool,
 				  page_list,
 				  list_len,
-				  *io_virtual_address);
+				  io_virtual_address);
 	if (fmr) {
 		/* found in cache */
 		++fmr->ref_count;
@@ -464,7 +464,7 @@ struct ib_pool_fmr *ib_fmr_pool_map_phys
 	spin_unlock_irqrestore(&pool->pool_lock, flags);
 
 	result = ib_map_phys_fmr(fmr->fmr, page_list, list_len,
-				 *io_virtual_address);
+				 io_virtual_address);
 
 	if (result) {
 		spin_lock_irqsave(&pool->pool_lock, flags);
@@ -481,7 +481,7 @@ struct ib_pool_fmr *ib_fmr_pool_map_phys
 	fmr->ref_count = 1;
 
 	if (pool->cache_bucket) {
-		fmr->io_virtual_address = *io_virtual_address;
+		fmr->io_virtual_address = io_virtual_address;
 		fmr->page_list_len      = list_len;
 		memcpy(fmr->page_list, page_list, list_len * sizeof(*page_list));
 
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index ff117bb..72febf1 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -594,7 +594,7 @@ int iser_reg_page_vec(struct iser_conn  
 	mem  = ib_fmr_pool_map_phys(ib_conn->fmr_pool,
 				    page_list,
 				    page_vec->length,
-				    &io_addr);
+				    io_addr);
 
 	if (IS_ERR(mem)) {
 		status = (int)PTR_ERR(mem);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4e22afe..9bf182a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -615,7 +615,7 @@ static int srp_map_fmr(struct srp_device
 				(sg_dma_address(&scat[i]) & dev->fmr_page_mask) + j;
 
 	req->fmr = ib_fmr_pool_map_phys(dev->fmr_pool,
-					dma_pages, page_cnt, &io_addr);
+					dma_pages, page_cnt, io_addr);
 	if (IS_ERR(req->fmr)) {
 		ret = PTR_ERR(req->fmr);
 		goto out;
 
-- 
MST
