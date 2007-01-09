Return-Path: <linux-kernel-owner+w=401wt.eu-S932252AbXAIRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbXAIRIJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXAIRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:08:08 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:52337 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbXAIRIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:08:07 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.20] ehca: use proper flag for get_zeroed_page() to prevent BUG:scheduling while atomic...
Date: Tue, 9 Jan 2007 18:04:14 +0100
User-Agent: KMail/1.8.2
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701091804.14297.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!

Here is a patch for ehca to use proper flag, ie. GFP_ATOMIC resp. GFP_KERNEL, when
calling get_zeroed_page() to prevent "Bug: scheduling while atomic...". This error
does not cause a kernel panic but makes ipoib un-usable afterwards. It is 
reproducible on 2.6.20-rc4 if one does ifconfig down during a flood ping test. 
I have not observed this error in earlier releases incl. 2.6.20-rc1. Due to 
vacation time I just recognized it last couple of days.

This error occurs when a qp event/irq is received and ehca event handler allocates
a control block/page to obtain HCA error data block. Use of GFP_ATOMIC prevents this
issue.

Since this has a good chance of crashing the kernel every time HCA error data is 
fetched, it would be great if you pushed this patch upstream.

Regards
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_hca.c    |    8 ++++----
 ehca_irq.c    |    2 +-
 ehca_iverbs.h |    4 ++--
 ehca_main.c   |   10 +++++-----
 ehca_mrmw.c   |    4 ++--
 ehca_qp.c     |    4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index e1b618c..b7be950 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -50,7 +50,7 @@ int ehca_query_device(struct ib_device *
 					      ib_device);
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -110,7 +110,7 @@ int ehca_query_port(struct ib_device *ib
 					      ib_device);
 	struct hipz_query_port *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -179,7 +179,7 @@ int ehca_query_pkey(struct ib_device *ib
 		return -EINVAL;
 	}
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -212,7 +212,7 @@ int ehca_query_gid(struct ib_device *ibd
 		return -EINVAL;
 	}
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index c3ea746..e7209af 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -138,7 +138,7 @@ int ehca_error_data(struct ehca_shca *sh
 	u64 *rblock;
 	unsigned long block_count;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_ATOMIC);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Cannot allocate rblock memory.");
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index 3720e30..cd7789f 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -180,10 +180,10 @@ int ehca_mmap_register(u64 physical,void
 int ehca_munmap(unsigned long addr, size_t len);
 
 #ifdef CONFIG_PPC_64K_PAGES
-void *ehca_alloc_fw_ctrlblock(void);
+void *ehca_alloc_fw_ctrlblock(gfp_t flags);
 void ehca_free_fw_ctrlblock(void *ptr);
 #else
-#define ehca_alloc_fw_ctrlblock() ((void *) get_zeroed_page(GFP_KERNEL))
+#define ehca_alloc_fw_ctrlblock(flags) ((void *) get_zeroed_page(flags))
 #define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
 #endif
 
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index cc47e4c..6574fbb 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -106,9 +106,9 @@ static struct timer_list poll_eqs_timer;
 #ifdef CONFIG_PPC_64K_PAGES
 static struct kmem_cache *ctblk_cache = NULL;
 
-void *ehca_alloc_fw_ctrlblock(void)
+void *ehca_alloc_fw_ctrlblock(gfp_t flags)
 {
-	void *ret = kmem_cache_zalloc(ctblk_cache, GFP_KERNEL);
+	void *ret = kmem_cache_zalloc(ctblk_cache, flags);
 	if (!ret)
 		ehca_gen_err("Out of memory for ctblk");
 	return ret;
@@ -206,7 +206,7 @@ int ehca_sense_attributes(struct ehca_sh
 	u64 h_ret;
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_gen_err("Cannot allocate rblock memory.");
 		return -ENOMEM;
@@ -258,7 +258,7 @@ static int init_node_guid(struct ehca_sh
 	int ret = 0;
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -469,7 +469,7 @@ static ssize_t  ehca_show_##name(struct 
 									   \
 	shca = dev->driver_data;					   \
 									   \
-	rblock = ehca_alloc_fw_ctrlblock();				   \
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);			   \
 	if (!rblock) {						           \
 		dev_err(dev, "Can't allocate rblock memory.");		   \
 		return 0;						   \
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 0a5e221..cfb362a 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1013,7 +1013,7 @@ int ehca_reg_mr_rpages(struct ehca_shca 
 	u32 i;
 	u64 *kpage;
 
-	kpage = ehca_alloc_fw_ctrlblock();
+	kpage = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!kpage) {
 		ehca_err(&shca->ib_device, "kpage alloc failed");
 		ret = -ENOMEM;
@@ -1124,7 +1124,7 @@ inline int ehca_rereg_mr_rereg1(struct e
 	ehca_mrmw_map_acl(acl, &hipz_acl);
 	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
 
-	kpage = ehca_alloc_fw_ctrlblock();
+	kpage = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!kpage) {
 		ehca_err(&shca->ib_device, "kpage alloc failed");
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index c6c9cef..34b8555 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -807,7 +807,7 @@ static int internal_modify_qp(struct ib_
 	unsigned long spl_flags = 0;
 
 	/* do query_qp to obtain current attr values */
-	mqpcb = ehca_alloc_fw_ctrlblock();
+	mqpcb = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!mqpcb) {
 		ehca_err(ibqp->device, "Could not get zeroed page for mqpcb "
 			 "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
@@ -1273,7 +1273,7 @@ int ehca_query_qp(struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	qpcb = ehca_alloc_fw_ctrlblock();
+	qpcb = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!qpcb) {
 		ehca_err(qp->device,"Out of memory for qpcb "
 			 "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
