Return-Path: <linux-kernel-owner+w=401wt.eu-S1030511AbXAHE30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbXAHE30 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbXAHE30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:29:26 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:20802 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030511AbXAHE3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:29:24 -0500
X-IronPort-AV: i="4.13,158,1167638400"; 
   d="scan'208"; a="99014991:sNHT53075979"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 07 Jan 2007 20:29:22 -0800
Message-ID: <adawt3ynntp.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jan 2007 04:29:23.0435 (UTC) FILETIME=[92BCB3B0:01C732DD]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

A few small fixes here and there:

Erez Zilber (1):
      IB/iser: Return error code when PDUs may not be sent

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
 drivers/infiniband/hw/mthca/mthca_cq.c       |    8 ++++++--
 drivers/infiniband/hw/mthca/mthca_memfree.c  |    2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c     |    4 ++--
 drivers/infiniband/ulp/iser/iser_initiator.c |   26 ++++++++++++--------------
 6 files changed, 46 insertions(+), 22 deletions(-)


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
