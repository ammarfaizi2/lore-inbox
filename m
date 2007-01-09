Return-Path: <linux-kernel-owner+w=401wt.eu-S932441AbXAIWTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbXAIWTA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbXAIWTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:19:00 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:13089 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441AbXAIWS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:18:58 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 Jan 2007 14:18:45 -0800
Message-ID: <ada4pqz3ku2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Jan 2007 22:18:47.0336 (UTC) FILETIME=[21D0C280:01C7343C]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes the small patches from my previous pull request that you
seem to have dropped, plus two more fixes:

Dotan Barak (1):
      IB/mthca: Don't execute QUERY_QP firmware command for QP in RESET state

Erez Zilber (1):
      IB/iser: Return error code when PDUs may not be sent

Hoang-Nam Nguyen (1):
      IB/ehca: Use proper GFP_ flags for get_zeroed_page()

Jack Morgenstein (1):
      IB/mthca: Fix PRM compliance problem in atomic-send completions

Michael S. Tsirkin (1):
      IB/mthca: Fix off-by-one in FMR handling on memfree

Sean Hefty (2):
      RDMA/ucma: Fix struct ucma_event leak when backlog is full
      RDMA/ucma: Don't report events with invalid user context

Steve Wise (1):
      RDMA/iwcm: iWARP connection timeouts shouldn't be reported as rejects

 drivers/infiniband/core/cma.c                |   17 ++++++++++++++---
 drivers/infiniband/core/ucma.c               |   11 +++++++++++
 drivers/infiniband/hw/ehca/ehca_hca.c        |    8 ++++----
 drivers/infiniband/hw/ehca/ehca_irq.c        |    2 +-
 drivers/infiniband/hw/ehca/ehca_iverbs.h     |    4 ++--
 drivers/infiniband/hw/ehca/ehca_main.c       |   10 +++++-----
 drivers/infiniband/hw/ehca/ehca_mrmw.c       |    4 ++--
 drivers/infiniband/hw/ehca/ehca_qp.c         |    4 ++--
 drivers/infiniband/hw/mthca/mthca_cq.c       |    8 ++++++--
 drivers/infiniband/hw/mthca/mthca_memfree.c  |    2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c       |   26 +++++++++++++++++---------
 drivers/infiniband/ulp/iser/iscsi_iser.c     |    4 ++--
 drivers/infiniband/ulp/iser/iser_initiator.c |   26 ++++++++++++--------------
 13 files changed, 79 insertions(+), 47 deletions(-)


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 533193d..9e0ab04 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1088,10 +1088,21 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 		*sin = iw_event->local_addr;
 		sin = (struct sockaddr_in *) &id_priv->id.route.addr.dst_addr;
 		*sin = iw_event->remote_addr;
-		if (iw_event->status)
-			event.event = RDMA_CM_EVENT_REJECTED;
-		else
+		switch (iw_event->status) {
+		case 0:
 			event.event = RDMA_CM_EVENT_ESTABLISHED;
+			break;
+		case -ECONNRESET:
+		case -ECONNREFUSED:
+			event.event = RDMA_CM_EVENT_REJECTED;
+			break;
+		case -ETIMEDOUT:
+			event.event = RDMA_CM_EVENT_UNREACHABLE;
+			break;
+		default:
+			event.event = RDMA_CM_EVENT_CONNECT_ERROR;
+			break;
+		}
 		break;
 	case IW_CM_EVENT_ESTABLISHED:
 		event.event = RDMA_CM_EVENT_ESTABLISHED;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 81a5cdc..e2e8d32 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -209,10 +209,21 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		if (!ctx->backlog) {
 			ret = -EDQUOT;
+			kfree(uevent);
 			goto out;
 		}
 		ctx->backlog--;
+	} else if (!ctx->uid) {
+		/*
+		 * We ignore events for new connections until userspace has set
+		 * their context.  This can only happen if an error occurs on a
+		 * new connection before the user accepts it.  This is okay,
+		 * since the accept will just fail later.
+		 */
+		kfree(uevent);
+		goto out;
 	}
+
 	list_add_tail(&uevent->list, &ctx->file->event_list);
 	wake_up_interruptible(&ctx->file->poll_wait);
 out:
diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index e1b618c..b7be950 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -50,7 +50,7 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 					      ib_device);
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -110,7 +110,7 @@ int ehca_query_port(struct ib_device *ibdev,
 					      ib_device);
 	struct hipz_query_port *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -179,7 +179,7 @@ int ehca_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 *pkey)
 		return -EINVAL;
 	}
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -212,7 +212,7 @@ int ehca_query_gid(struct ib_device *ibdev, u8 port,
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
@@ -138,7 +138,7 @@ int ehca_error_data(struct ehca_shca *shca, void *data,
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
@@ -180,10 +180,10 @@ int ehca_mmap_register(u64 physical,void **mapped,
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
@@ -206,7 +206,7 @@ int ehca_sense_attributes(struct ehca_shca *shca)
 	u64 h_ret;
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_gen_err("Cannot allocate rblock memory.");
 		return -ENOMEM;
@@ -258,7 +258,7 @@ static int init_node_guid(struct ehca_shca *shca)
 	int ret = 0;
 	struct hipz_query_hca *rblock;
 
-	rblock = ehca_alloc_fw_ctrlblock();
+	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -469,7 +469,7 @@ static ssize_t  ehca_show_##name(struct device *dev,                       \
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
@@ -1013,7 +1013,7 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 	u32 i;
 	u64 *kpage;
 
-	kpage = ehca_alloc_fw_ctrlblock();
+	kpage = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!kpage) {
 		ehca_err(&shca->ib_device, "kpage alloc failed");
 		ret = -ENOMEM;
@@ -1124,7 +1124,7 @@ inline int ehca_rereg_mr_rereg1(struct ehca_shca *shca,
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
@@ -807,7 +807,7 @@ static int internal_modify_qp(struct ib_qp *ibqp,
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
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 283d50b..1159c8a 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -54,6 +54,10 @@ enum {
 	MTHCA_CQ_ENTRY_SIZE = 0x20
 };
 
+enum {
+	MTHCA_ATOMIC_BYTE_LEN = 8
+};
+
 /*
  * Must be packed because start is 64 bits but only aligned to 32 bits.
  */
@@ -599,11 +603,11 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
 			break;
 		case MTHCA_OPCODE_ATOMIC_CS:
 			entry->opcode    = IB_WC_COMP_SWAP;
-			entry->byte_len  = be32_to_cpu(cqe->byte_cnt);
+			entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
 			break;
 		case MTHCA_OPCODE_ATOMIC_FA:
 			entry->opcode    = IB_WC_FETCH_ADD;
-			entry->byte_len  = be32_to_cpu(cqe->byte_cnt);
+			entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
 			break;
 		case MTHCA_OPCODE_BIND_MW:
 			entry->opcode    = IB_WC_BIND_MW;
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index 15cc2f6..6b19645 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -232,7 +232,7 @@ void *mthca_table_find(struct mthca_icm_table *table, int obj)
 
 	list_for_each_entry(chunk, &icm->chunk_list, list) {
 		for (i = 0; i < chunk->npages; ++i) {
-			if (chunk->mem[i].length >= offset) {
+			if (chunk->mem[i].length > offset) {
 				page = chunk->mem[i].page;
 				goto out;
 			}
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index d844a25..5f5214c 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -429,13 +429,18 @@ int mthca_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_m
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
-	int err;
-	struct mthca_mailbox *mailbox;
+	int err = 0;
+	struct mthca_mailbox *mailbox = NULL;
 	struct mthca_qp_param *qp_param;
 	struct mthca_qp_context *context;
 	int mthca_state;
 	u8 status;
 
+	if (qp->state == IB_QPS_RESET) {
+		qp_attr->qp_state = IB_QPS_RESET;
+		goto done;
+	}
+
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
@@ -454,7 +459,6 @@ int mthca_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_m
 	mthca_state = be32_to_cpu(context->flags) >> 28;
 
 	qp_attr->qp_state 	     = to_ib_qp_state(mthca_state);
-	qp_attr->cur_qp_state 	     = qp_attr->qp_state;
 	qp_attr->path_mtu 	     = context->mtu_msgmax >> 5;
 	qp_attr->path_mig_state      =
 		to_ib_mig_state((be32_to_cpu(context->flags) >> 11) & 0x3);
@@ -464,11 +468,6 @@ int mthca_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_m
 	qp_attr->dest_qp_num 	     = be32_to_cpu(context->remote_qpn) & 0xffffff;
 	qp_attr->qp_access_flags     =
 		to_ib_qp_access_flags(be32_to_cpu(context->params2));
-	qp_attr->cap.max_send_wr     = qp->sq.max;
-	qp_attr->cap.max_recv_wr     = qp->rq.max;
-	qp_attr->cap.max_send_sge    = qp->sq.max_gs;
-	qp_attr->cap.max_recv_sge    = qp->rq.max_gs;
-	qp_attr->cap.max_inline_data = qp->max_inline_data;
 
 	if (qp->transport == RC || qp->transport == UC) {
 		to_ib_ah_attr(dev, &qp_attr->ah_attr, &context->pri_path);
@@ -495,7 +494,16 @@ int mthca_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_m
 	qp_attr->retry_cnt 	    = (be32_to_cpu(context->params1) >> 16) & 0x7;
 	qp_attr->rnr_retry 	    = context->pri_path.rnr_retry >> 5;
 	qp_attr->alt_timeout 	    = context->alt_path.ackto >> 3;
-	qp_init_attr->cap 	    = qp_attr->cap;
+
+done:
+	qp_attr->cur_qp_state	     = qp_attr->qp_state;
+	qp_attr->cap.max_send_wr     = qp->sq.max;
+	qp_attr->cap.max_recv_wr     = qp->rq.max;
+	qp_attr->cap.max_send_sge    = qp->sq.max_gs;
+	qp_attr->cap.max_recv_sge    = qp->rq.max_gs;
+	qp_attr->cap.max_inline_data = qp->max_inline_data;
+
+	qp_init_attr->cap	     = qp_attr->cap;
 
 out:
 	mthca_free_mailbox(dev, mailbox);
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 9b2041e..dd221ed 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -177,7 +177,7 @@ iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
 	 * - if yes, the mtask is recycled at iscsi_complete_pdu
 	 * - if no,  the mtask is recycled at iser_snd_completion
 	 */
-	if (error && error != -EAGAIN)
+	if (error && error != -ENOBUFS)
 		iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
 
 	return error;
@@ -241,7 +241,7 @@ iscsi_iser_ctask_xmit(struct iscsi_conn *conn,
 		error = iscsi_iser_ctask_xmit_unsol_data(conn, ctask);
 
  iscsi_iser_ctask_xmit_exit:
-	if (error && error != -EAGAIN)
+	if (error && error != -ENOBUFS)
 		iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
 	return error;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index e73c87b..0a7d1ab 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -304,18 +304,14 @@ int iser_conn_set_full_featured_mode(struct iscsi_conn *conn)
 static int
 iser_check_xmit(struct iscsi_conn *conn, void *task)
 {
-	int rc = 0;
 	struct iscsi_iser_conn *iser_conn = conn->dd_data;
 
-	write_lock_bh(conn->recv_lock);
 	if (atomic_read(&iser_conn->ib_conn->post_send_buf_count) ==
 	    ISER_QP_MAX_REQ_DTOS) {
-		iser_dbg("%ld can't xmit task %p, suspending tx\n",jiffies,task);
-		set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
-		rc = -EAGAIN;
+		iser_dbg("%ld can't xmit task %p\n",jiffies,task);
+		return -ENOBUFS;
 	}
-	write_unlock_bh(conn->recv_lock);
-	return rc;
+	return 0;
 }
 
 
@@ -340,7 +336,7 @@ int iser_send_command(struct iscsi_conn     *conn,
 		return -EPERM;
 	}
 	if (iser_check_xmit(conn, ctask))
-		return -EAGAIN;
+		return -ENOBUFS;
 
 	edtl = ntohl(hdr->data_length);
 
@@ -426,7 +422,7 @@ int iser_send_data_out(struct iscsi_conn     *conn,
 	}
 
 	if (iser_check_xmit(conn, ctask))
-		return -EAGAIN;
+		return -ENOBUFS;
 
 	itt = ntohl(hdr->itt);
 	data_seg_len = ntoh24(hdr->dlength);
@@ -498,7 +494,7 @@ int iser_send_control(struct iscsi_conn *conn,
 	}
 
 	if (iser_check_xmit(conn,mtask))
-		return -EAGAIN;
+		return -ENOBUFS;
 
 	/* build the tx desc regd header and add it to the tx desc dto */
 	mdesc->type = ISCSI_TX_CONTROL;
@@ -605,6 +601,7 @@ void iser_snd_completion(struct iser_desc *tx_desc)
 	struct iscsi_iser_conn *iser_conn = ib_conn->iser_conn;
 	struct iscsi_conn      *conn = iser_conn->iscsi_conn;
 	struct iscsi_mgmt_task *mtask;
+	int resume_tx = 0;
 
 	iser_dbg("Initiator, Data sent dto=0x%p\n", dto);
 
@@ -613,15 +610,16 @@ void iser_snd_completion(struct iser_desc *tx_desc)
 	if (tx_desc->type == ISCSI_TX_DATAOUT)
 		kmem_cache_free(ig.desc_cache, tx_desc);
 
+	if (atomic_read(&iser_conn->ib_conn->post_send_buf_count) ==
+	    ISER_QP_MAX_REQ_DTOS)
+		resume_tx = 1;
+
 	atomic_dec(&ib_conn->post_send_buf_count);
 
-	write_lock(conn->recv_lock);
-	if (conn->suspend_tx) {
+	if (resume_tx) {
 		iser_dbg("%ld resuming tx\n",jiffies);
-		clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
 		scsi_queue_work(conn->session->host, &conn->xmitwork);
 	}
-	write_unlock(conn->recv_lock);
 
 	if (tx_desc->type == ISCSI_TX_CONTROL) {
 		/* this arithmetic is legal by libiscsi dd_data allocation */
