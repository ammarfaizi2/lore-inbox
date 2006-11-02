Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752705AbWKBWaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbWKBWaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbWKBWaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:30:46 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:38694 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752705AbWKBWao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:30:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAOf+SUWrR7PEh2dsb2JhbACMSQEBCQ4q
X-IronPort-AV: i="4.09,382,1157353200"; 
   d="scan'208"; a="338900200:sNHT141767840"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Nov 2006 14:28:04 -0800
Message-ID: <adaejsltrez.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Nov 2006 22:28:05.0175 (UTC) FILETIME=[2A393C70:01C6FECE]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes various fixes for 2.6.19-rc5:

Erez Zilber (1):
      IB/iser: Start connection after enabling iSER

Jack Morgenstein (1):
      IB/uverbs: Return sq_draining value in query_qp response

Krishna Kumar (1):
      RDMA/cma: rdma_bind_addr() leaks a cma_dev reference count

Michael S. Tsirkin (1):
      IB/mthca: Fix MAD extended header format for MAD_IFC firmware command

Paul Mackerras (1):
      IB/ehca: Fix eHCA driver compilation for uniprocessor

Sean Hefty (1):
      RDMA/addr: Use client registration to fix module unload race

Steve Wise (2):
      IB/amso1100: Use dma_alloc_coherent() instead of kmalloc/dma_map_single
      IB/amso1100: Fix incorrect pr_debug()

 drivers/infiniband/core/addr.c            |   28 ++++++++++++++-
 drivers/infiniband/core/cma.c             |   31 +++++++++++-----
 drivers/infiniband/core/uverbs_cmd.c      |    2 +-
 drivers/infiniband/hw/amso1100/c2_alloc.c |   13 +++----
 drivers/infiniband/hw/amso1100/c2_cq.c    |   18 +++------
 drivers/infiniband/hw/amso1100/c2_rnic.c  |   56 ++++++++++++-----------------
 drivers/infiniband/hw/ehca/ehca_tools.h   |    1 +
 drivers/infiniband/hw/mthca/mthca_cmd.c   |   14 ++++----
 drivers/infiniband/ulp/iser/iscsi_iser.c  |    4 +-
 include/rdma/ib_addr.h                    |   20 ++++++++++-
 include/rdma/ib_user_verbs.h              |    2 +-
 11 files changed, 114 insertions(+), 75 deletions(-)


diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 60d3fbd..e11187e 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -47,6 +47,7 @@ struct addr_req {
 	struct sockaddr src_addr;
 	struct sockaddr dst_addr;
 	struct rdma_dev_addr *addr;
+	struct rdma_addr_client *client;
 	void *context;
 	void (*callback)(int status, struct sockaddr *src_addr,
 			 struct rdma_dev_addr *addr, void *context);
@@ -61,6 +62,26 @@ static LIST_HEAD(req_list);
 static DECLARE_WORK(work, process_req, NULL);
 static struct workqueue_struct *addr_wq;
 
+void rdma_addr_register_client(struct rdma_addr_client *client)
+{
+	atomic_set(&client->refcount, 1);
+	init_completion(&client->comp);
+}
+EXPORT_SYMBOL(rdma_addr_register_client);
+
+static inline void put_client(struct rdma_addr_client *client)
+{
+	if (atomic_dec_and_test(&client->refcount))
+		complete(&client->comp);
+}
+
+void rdma_addr_unregister_client(struct rdma_addr_client *client)
+{
+	put_client(client);
+	wait_for_completion(&client->comp);
+}
+EXPORT_SYMBOL(rdma_addr_unregister_client);
+
 int rdma_copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
 		     const unsigned char *dst_dev_addr)
 {
@@ -229,6 +250,7 @@ static void process_req(void *data)
 		list_del(&req->list);
 		req->callback(req->status, &req->src_addr, req->addr,
 			      req->context);
+		put_client(req->client);
 		kfree(req);
 	}
 }
@@ -264,7 +286,8 @@ static int addr_resolve_local(struct soc
 	return ret;
 }
 
-int rdma_resolve_ip(struct sockaddr *src_addr, struct sockaddr *dst_addr,
+int rdma_resolve_ip(struct rdma_addr_client *client,
+		    struct sockaddr *src_addr, struct sockaddr *dst_addr,
 		    struct rdma_dev_addr *addr, int timeout_ms,
 		    void (*callback)(int status, struct sockaddr *src_addr,
 				     struct rdma_dev_addr *addr, void *context),
@@ -285,6 +308,8 @@ int rdma_resolve_ip(struct sockaddr *src
 	req->addr = addr;
 	req->callback = callback;
 	req->context = context;
+	req->client = client;
+	atomic_inc(&client->refcount);
 
 	src_in = (struct sockaddr_in *) &req->src_addr;
 	dst_in = (struct sockaddr_in *) &req->dst_addr;
@@ -305,6 +330,7 @@ int rdma_resolve_ip(struct sockaddr *src
 		break;
 	default:
 		ret = req->status;
+		atomic_dec(&client->refcount);
 		kfree(req);
 		break;
 	}
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9ae4f3a..845090b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -63,6 +63,7 @@ static struct ib_client cma_client = {
 };
 
 static struct ib_sa_client sa_client;
+static struct rdma_addr_client addr_client;
 static LIST_HEAD(dev_list);
 static LIST_HEAD(listen_any_list);
 static DEFINE_MUTEX(lock);
@@ -1625,8 +1626,8 @@ int rdma_resolve_addr(struct rdma_cm_id
 	if (cma_any_addr(dst_addr))
 		ret = cma_resolve_loopback(id_priv);
 	else
-		ret = rdma_resolve_ip(&id->route.addr.src_addr, dst_addr,
-				      &id->route.addr.dev_addr,
+		ret = rdma_resolve_ip(&addr_client, &id->route.addr.src_addr,
+				      dst_addr, &id->route.addr.dev_addr,
 				      timeout_ms, addr_handler, id_priv);
 	if (ret)
 		goto err;
@@ -1762,22 +1763,29 @@ int rdma_bind_addr(struct rdma_cm_id *id
 
 	if (!cma_any_addr(addr)) {
 		ret = rdma_translate_ip(addr, &id->route.addr.dev_addr);
-		if (!ret) {
-			mutex_lock(&lock);
-			ret = cma_acquire_dev(id_priv);
-			mutex_unlock(&lock);
-		}
 		if (ret)
-			goto err;
+			goto err1;
+
+		mutex_lock(&lock);
+		ret = cma_acquire_dev(id_priv);
+		mutex_unlock(&lock);
+		if (ret)
+			goto err1;
 	}
 
 	memcpy(&id->route.addr.src_addr, addr, ip_addr_size(addr));
 	ret = cma_get_port(id_priv);
 	if (ret)
-		goto err;
+		goto err2;
 
 	return 0;
-err:
+err2:
+	if (!cma_any_addr(addr)) {
+		mutex_lock(&lock);
+		cma_detach_from_dev(id_priv);
+		mutex_unlock(&lock);
+	}
+err1:
 	cma_comp_exch(id_priv, CMA_ADDR_BOUND, CMA_IDLE);
 	return ret;
 }
@@ -2210,6 +2218,7 @@ static int cma_init(void)
 		return -ENOMEM;
 
 	ib_sa_register_client(&sa_client);
+	rdma_addr_register_client(&addr_client);
 
 	ret = ib_register_client(&cma_client);
 	if (ret)
@@ -2217,6 +2226,7 @@ static int cma_init(void)
 	return 0;
 
 err:
+	rdma_addr_unregister_client(&addr_client);
 	ib_sa_unregister_client(&sa_client);
 	destroy_workqueue(cma_wq);
 	return ret;
@@ -2225,6 +2235,7 @@ err:
 static void cma_cleanup(void)
 {
 	ib_unregister_client(&cma_client);
+	rdma_addr_unregister_client(&addr_client);
 	ib_sa_unregister_client(&sa_client);
 	destroy_workqueue(cma_wq);
 	idr_destroy(&sdp_ps);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b72c7f6..743247e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1214,7 +1214,7 @@ ssize_t ib_uverbs_query_qp(struct ib_uve
 	resp.qp_access_flags        = attr->qp_access_flags;
 	resp.pkey_index             = attr->pkey_index;
 	resp.alt_pkey_index         = attr->alt_pkey_index;
-	resp.en_sqd_async_notify    = attr->en_sqd_async_notify;
+	resp.sq_draining            = attr->sq_draining;
 	resp.max_rd_atomic          = attr->max_rd_atomic;
 	resp.max_dest_rd_atomic     = attr->max_dest_rd_atomic;
 	resp.min_rnr_timer          = attr->min_rnr_timer;
diff --git a/drivers/infiniband/hw/amso1100/c2_alloc.c b/drivers/infiniband/hw/amso1100/c2_alloc.c
index 028a60b..0315f99 100644
--- a/drivers/infiniband/hw/amso1100/c2_alloc.c
+++ b/drivers/infiniband/hw/amso1100/c2_alloc.c
@@ -42,13 +42,14 @@ static int c2_alloc_mqsp_chunk(struct c2
 {
 	int i;
 	struct sp_chunk *new_head;
+	dma_addr_t dma_addr;
 
-	new_head = (struct sp_chunk *) __get_free_page(gfp_mask);
+	new_head = dma_alloc_coherent(&c2dev->pcidev->dev, PAGE_SIZE,
+				      &dma_addr, gfp_mask);
 	if (new_head == NULL)
 		return -ENOMEM;
 
-	new_head->dma_addr = dma_map_single(c2dev->ibdev.dma_device, new_head,
-					    PAGE_SIZE, DMA_FROM_DEVICE);
+	new_head->dma_addr = dma_addr;
 	pci_unmap_addr_set(new_head, mapping, new_head->dma_addr);
 
 	new_head->next = NULL;
@@ -80,10 +81,8 @@ void c2_free_mqsp_pool(struct c2_dev *c2
 
 	while (root) {
 		next = root->next;
-		dma_unmap_single(c2dev->ibdev.dma_device,
-				 pci_unmap_addr(root, mapping), PAGE_SIZE,
-			         DMA_FROM_DEVICE);
-		__free_page((struct page *) root);
+		dma_free_coherent(&c2dev->pcidev->dev, PAGE_SIZE, root,
+				  pci_unmap_addr(root, mapping));
 		root = next;
 	}
 }
diff --git a/drivers/infiniband/hw/amso1100/c2_cq.c b/drivers/infiniband/hw/amso1100/c2_cq.c
index 9d7bcc5..05c9154 100644
--- a/drivers/infiniband/hw/amso1100/c2_cq.c
+++ b/drivers/infiniband/hw/amso1100/c2_cq.c
@@ -246,20 +246,17 @@ int c2_arm_cq(struct ib_cq *ibcq, enum i
 
 static void c2_free_cq_buf(struct c2_dev *c2dev, struct c2_mq *mq)
 {
-
-	dma_unmap_single(c2dev->ibdev.dma_device, pci_unmap_addr(mq, mapping),
-			 mq->q_size * mq->msg_size, DMA_FROM_DEVICE);
-	free_pages((unsigned long) mq->msg_pool.host,
-		   get_order(mq->q_size * mq->msg_size));
+	dma_free_coherent(&c2dev->pcidev->dev, mq->q_size * mq->msg_size,
+			  mq->msg_pool.host, pci_unmap_addr(mq, mapping));
 }
 
 static int c2_alloc_cq_buf(struct c2_dev *c2dev, struct c2_mq *mq, int q_size,
 			   int msg_size)
 {
-	unsigned long pool_start;
+	u8 *pool_start;
 
-	pool_start = __get_free_pages(GFP_KERNEL,
-				      get_order(q_size * msg_size));
+	pool_start = dma_alloc_coherent(&c2dev->pcidev->dev, q_size * msg_size,
+					&mq->host_dma, GFP_KERNEL);
 	if (!pool_start)
 		return -ENOMEM;
 
@@ -267,13 +264,10 @@ static int c2_alloc_cq_buf(struct c2_dev
 		       0,		/* index (currently unknown) */
 		       q_size,
 		       msg_size,
-		       (u8 *) pool_start,
+		       pool_start,
 		       NULL,	/* peer (currently unknown) */
 		       C2_MQ_HOST_TARGET);
 
-	mq->host_dma = dma_map_single(c2dev->ibdev.dma_device,
-				      (void *)pool_start,
-				      q_size * msg_size, DMA_FROM_DEVICE);
 	pci_unmap_addr_set(mq, mapping, mq->host_dma);
 
 	return 0;
diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
index 30409e1..21d9612 100644
--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -517,14 +517,12 @@ int c2_rnic_init(struct c2_dev *c2dev)
 	/* Initialize the Verbs Reply Queue */
 	qsize = be32_to_cpu(readl(mmio_regs + C2_REGS_Q1_QSIZE));
 	msgsize = be32_to_cpu(readl(mmio_regs + C2_REGS_Q1_MSGSIZE));
-	q1_pages = kmalloc(qsize * msgsize, GFP_KERNEL);
+	q1_pages = dma_alloc_coherent(&c2dev->pcidev->dev, qsize * msgsize,
+				      &c2dev->rep_vq.host_dma, GFP_KERNEL);
 	if (!q1_pages) {
 		err = -ENOMEM;
 		goto bail1;
 	}
-	c2dev->rep_vq.host_dma = dma_map_single(c2dev->ibdev.dma_device,
-					        (void *)q1_pages, qsize * msgsize,
-				      		DMA_FROM_DEVICE);
 	pci_unmap_addr_set(&c2dev->rep_vq, mapping, c2dev->rep_vq.host_dma);
 	pr_debug("%s rep_vq va %p dma %llx\n", __FUNCTION__, q1_pages,
 		 (unsigned long long) c2dev->rep_vq.host_dma);
@@ -540,17 +538,15 @@ int c2_rnic_init(struct c2_dev *c2dev)
 	/* Initialize the Asynchronus Event Queue */
 	qsize = be32_to_cpu(readl(mmio_regs + C2_REGS_Q2_QSIZE));
 	msgsize = be32_to_cpu(readl(mmio_regs + C2_REGS_Q2_MSGSIZE));
-	q2_pages = kmalloc(qsize * msgsize, GFP_KERNEL);
+	q2_pages = dma_alloc_coherent(&c2dev->pcidev->dev, qsize * msgsize,
+				      &c2dev->aeq.host_dma, GFP_KERNEL);
 	if (!q2_pages) {
 		err = -ENOMEM;
 		goto bail2;
 	}
-	c2dev->aeq.host_dma = dma_map_single(c2dev->ibdev.dma_device,
-					        (void *)q2_pages, qsize * msgsize,
-				      		DMA_FROM_DEVICE);
 	pci_unmap_addr_set(&c2dev->aeq, mapping, c2dev->aeq.host_dma);
-	pr_debug("%s aeq va %p dma %llx\n", __FUNCTION__, q1_pages,
-		 (unsigned long long) c2dev->rep_vq.host_dma);
+	pr_debug("%s aeq va %p dma %llx\n", __FUNCTION__, q2_pages,
+		 (unsigned long long) c2dev->aeq.host_dma);
 	c2_mq_rep_init(&c2dev->aeq,
 		       2,
 		       qsize,
@@ -597,17 +593,13 @@ int c2_rnic_init(struct c2_dev *c2dev)
       bail4:
 	vq_term(c2dev);
       bail3:
-	dma_unmap_single(c2dev->ibdev.dma_device,
-			 pci_unmap_addr(&c2dev->aeq, mapping),
-			 c2dev->aeq.q_size * c2dev->aeq.msg_size,
-		  	 DMA_FROM_DEVICE);
-	kfree(q2_pages);
+	dma_free_coherent(&c2dev->pcidev->dev,
+			  c2dev->aeq.q_size * c2dev->aeq.msg_size,
+			  q2_pages, pci_unmap_addr(&c2dev->aeq, mapping));
       bail2:
-	dma_unmap_single(c2dev->ibdev.dma_device,
-			 pci_unmap_addr(&c2dev->rep_vq, mapping),
-			 c2dev->rep_vq.q_size * c2dev->rep_vq.msg_size,
-		  	 DMA_FROM_DEVICE);
-	kfree(q1_pages);
+	dma_free_coherent(&c2dev->pcidev->dev,
+			  c2dev->rep_vq.q_size * c2dev->rep_vq.msg_size,
+			  q1_pages, pci_unmap_addr(&c2dev->rep_vq, mapping));
       bail1:
 	c2_free_mqsp_pool(c2dev, c2dev->kern_mqsp_pool);
       bail0:
@@ -640,19 +632,17 @@ void c2_rnic_term(struct c2_dev *c2dev)
 	/* Free the verbs request allocator */
 	vq_term(c2dev);
 
-	/* Unmap and free the asynchronus event queue */
-	dma_unmap_single(c2dev->ibdev.dma_device,
-			 pci_unmap_addr(&c2dev->aeq, mapping),
-			 c2dev->aeq.q_size * c2dev->aeq.msg_size,
-		  	 DMA_FROM_DEVICE);
-	kfree(c2dev->aeq.msg_pool.host);
-
-	/* Unmap and free the verbs reply queue */
-	dma_unmap_single(c2dev->ibdev.dma_device,
-			 pci_unmap_addr(&c2dev->rep_vq, mapping),
-			 c2dev->rep_vq.q_size * c2dev->rep_vq.msg_size,
-		  	 DMA_FROM_DEVICE);
-	kfree(c2dev->rep_vq.msg_pool.host);
+	/* Free the asynchronus event queue */
+	dma_free_coherent(&c2dev->pcidev->dev,
+			  c2dev->aeq.q_size * c2dev->aeq.msg_size,
+			  c2dev->aeq.msg_pool.host,
+			  pci_unmap_addr(&c2dev->aeq, mapping));
+
+	/* Free the verbs reply queue */
+	dma_free_coherent(&c2dev->pcidev->dev,
+			  c2dev->rep_vq.q_size * c2dev->rep_vq.msg_size,
+			  c2dev->rep_vq.msg_pool.host,
+			  pci_unmap_addr(&c2dev->rep_vq, mapping));
 
 	/* Free the MQ shared pointer pool */
 	c2_free_mqsp_pool(c2dev, c2dev->kern_mqsp_pool);
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 809da3e..973c4b5 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -63,6 +63,7 @@ #include <asm/abs_addr.h>
 #include <asm/ibmebus.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/hvcall.h>
 
 extern int ehca_debug_level;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 99a94d7..768df72 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -1820,11 +1820,11 @@ int mthca_MAD_IFC(struct mthca_dev *dev,
 
 #define MAD_IFC_BOX_SIZE      0x400
 #define MAD_IFC_MY_QPN_OFFSET 0x100
-#define MAD_IFC_RQPN_OFFSET   0x104
-#define MAD_IFC_SL_OFFSET     0x108
-#define MAD_IFC_G_PATH_OFFSET 0x109
-#define MAD_IFC_RLID_OFFSET   0x10a
-#define MAD_IFC_PKEY_OFFSET   0x10e
+#define MAD_IFC_RQPN_OFFSET   0x108
+#define MAD_IFC_SL_OFFSET     0x10c
+#define MAD_IFC_G_PATH_OFFSET 0x10d
+#define MAD_IFC_RLID_OFFSET   0x10e
+#define MAD_IFC_PKEY_OFFSET   0x112
 #define MAD_IFC_GRH_OFFSET    0x140
 
 	inmailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
@@ -1862,7 +1862,7 @@ #define MAD_IFC_GRH_OFFSET    0x140
 
 		val = in_wc->dlid_path_bits |
 			(in_wc->wc_flags & IB_WC_GRH ? 0x80 : 0);
-		MTHCA_PUT(inbox, val,               MAD_IFC_GRH_OFFSET);
+		MTHCA_PUT(inbox, val,               MAD_IFC_G_PATH_OFFSET);
 
 		MTHCA_PUT(inbox, in_wc->slid,       MAD_IFC_RLID_OFFSET);
 		MTHCA_PUT(inbox, in_wc->pkey_index, MAD_IFC_PKEY_OFFSET);
@@ -1870,7 +1870,7 @@ #define MAD_IFC_GRH_OFFSET    0x140
 		if (in_grh)
 			memcpy(inbox + MAD_IFC_GRH_OFFSET, in_grh, 40);
 
-		op_modifier |= 0x10;
+		op_modifier |= 0x4;
 
 		in_modifier |= in_wc->slid << 16;
 	}
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index eb6f98d..9b2041e 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -363,11 +363,11 @@ iscsi_iser_conn_start(struct iscsi_cls_c
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	int err;
 
-	err = iscsi_conn_start(cls_conn);
+	err = iser_conn_set_full_featured_mode(conn);
 	if (err)
 		return err;
 
-	return iser_conn_set_full_featured_mode(conn);
+	return iscsi_conn_start(cls_conn);
 }
 
 static struct iscsi_transport iscsi_iser_transport;
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index 81b6230..c094e50 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -36,6 +36,22 @@ #include <linux/netdevice.h>
 #include <linux/socket.h>
 #include <rdma/ib_verbs.h>
 
+struct rdma_addr_client {
+	atomic_t refcount;
+	struct completion comp;
+};
+
+/**
+ * rdma_addr_register_client - Register an address client.
+ */
+void rdma_addr_register_client(struct rdma_addr_client *client);
+
+/**
+ * rdma_addr_unregister_client - Deregister an address client.
+ * @client: Client object to deregister.
+ */
+void rdma_addr_unregister_client(struct rdma_addr_client *client);
+
 struct rdma_dev_addr {
 	unsigned char src_dev_addr[MAX_ADDR_LEN];
 	unsigned char dst_dev_addr[MAX_ADDR_LEN];
@@ -52,6 +68,7 @@ int rdma_translate_ip(struct sockaddr *a
 /**
  * rdma_resolve_ip - Resolve source and destination IP addresses to
  *   RDMA hardware addresses.
+ * @client: Address client associated with request.
  * @src_addr: An optional source address to use in the resolution.  If a
  *   source address is not provided, a usable address will be returned via
  *   the callback.
@@ -64,7 +81,8 @@ int rdma_translate_ip(struct sockaddr *a
  *   or been canceled.  A status of 0 indicates success.
  * @context: User-specified context associated with the call.
  */
-int rdma_resolve_ip(struct sockaddr *src_addr, struct sockaddr *dst_addr,
+int rdma_resolve_ip(struct rdma_addr_client *client,
+		    struct sockaddr *src_addr, struct sockaddr *dst_addr,
 		    struct rdma_dev_addr *addr, int timeout_ms,
 		    void (*callback)(int status, struct sockaddr *src_addr,
 				     struct rdma_dev_addr *addr, void *context),
diff --git a/include/rdma/ib_user_verbs.h b/include/rdma/ib_user_verbs.h
index db1b814..64a721f 100644
--- a/include/rdma/ib_user_verbs.h
+++ b/include/rdma/ib_user_verbs.h
@@ -458,7 +458,7 @@ struct ib_uverbs_query_qp_resp {
 	__u8  cur_qp_state;
 	__u8  path_mtu;
 	__u8  path_mig_state;
-	__u8  en_sqd_async_notify;
+	__u8  sq_draining;
 	__u8  max_rd_atomic;
 	__u8  max_dest_rd_atomic;
 	__u8  min_rnr_timer;
