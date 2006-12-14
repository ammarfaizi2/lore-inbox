Return-Path: <linux-kernel-owner+w=401wt.eu-S932791AbWLNOVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWLNOVz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNOTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:19:37 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46394 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932750AbWLNOT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:19:27 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v4 01/13] Linux RDMA Core Changes
Date: Thu, 14 Dec 2006 07:53:05 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061214135303.21159.61880.stgit@dell3.ogc.int>
In-Reply-To: <20061214135233.21159.78613.stgit@dell3.ogc.int>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Support provider-specific data in ib_uverbs_cmd_req_notify_cq().
The Chelsio iwarp provider library needs to pass information to the
kernel verb for re-arming the CQ.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/core/uverbs_cmd.c      |    9 +++++++--
 drivers/infiniband/hw/amso1100/c2.h       |    2 +-
 drivers/infiniband/hw/amso1100/c2_cq.c    |    3 ++-
 drivers/infiniband/hw/ehca/ehca_iverbs.h  |    3 ++-
 drivers/infiniband/hw/ehca/ehca_reqs.c    |    3 ++-
 drivers/infiniband/hw/ipath/ipath_cq.c    |    4 +++-
 drivers/infiniband/hw/ipath/ipath_verbs.h |    3 ++-
 drivers/infiniband/hw/mthca/mthca_cq.c    |    6 ++++--
 drivers/infiniband/hw/mthca/mthca_dev.h   |    4 ++--
 include/rdma/ib_verbs.h                   |    5 +++--
 10 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 743247e..5dd1de9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -959,6 +959,7 @@ ssize_t ib_uverbs_req_notify_cq(struct i
 				int out_len)
 {
 	struct ib_uverbs_req_notify_cq cmd;
+	struct ib_udata		      udata;
 	struct ib_cq                  *cq;
 
 	if (copy_from_user(&cmd, buf, sizeof cmd))
@@ -968,8 +969,12 @@ ssize_t ib_uverbs_req_notify_cq(struct i
 	if (!cq)
 		return -EINVAL;
 
-	ib_req_notify_cq(cq, cmd.solicited_only ?
-			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
+	INIT_UDATA(&udata, buf + sizeof cmd, 0,
+		   in_len - sizeof cmd, 0); 
+
+	cq->device->req_notify_cq(cq, cmd.solicited_only ?
+				  IB_CQ_SOLICITED : IB_CQ_NEXT_COMP,
+				  &udata);
 
 	put_cq_read(cq);
 
diff --git a/drivers/infiniband/hw/amso1100/c2.h b/drivers/infiniband/hw/amso1100/c2.h
index 04a9db5..9a76869 100644
--- a/drivers/infiniband/hw/amso1100/c2.h
+++ b/drivers/infiniband/hw/amso1100/c2.h
@@ -519,7 +519,7 @@ extern void c2_free_cq(struct c2_dev *c2
 extern void c2_cq_event(struct c2_dev *c2dev, u32 mq_index);
 extern void c2_cq_clean(struct c2_dev *c2dev, struct c2_qp *qp, u32 mq_index);
 extern int c2_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry);
-extern int c2_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify);
+extern int c2_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify, struct ib_udata *udata);
 
 /* CM */
 extern int c2_llp_connect(struct iw_cm_id *cm_id,
diff --git a/drivers/infiniband/hw/amso1100/c2_cq.c b/drivers/infiniband/hw/amso1100/c2_cq.c
index 05c9154..7ce8bca 100644
--- a/drivers/infiniband/hw/amso1100/c2_cq.c
+++ b/drivers/infiniband/hw/amso1100/c2_cq.c
@@ -217,7 +217,8 @@ int c2_poll_cq(struct ib_cq *ibcq, int n
 	return npolled;
 }
 
-int c2_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+int c2_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
+	      struct ib_udata *udata)
 {
 	struct c2_mq_shared __iomem *shared;
 	struct c2_cq *cq;
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index 3720e30..566b30c 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -135,7 +135,8 @@ int ehca_poll_cq(struct ib_cq *cq, int n
 
 int ehca_peek_cq(struct ib_cq *cq, int wc_cnt);
 
-int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify);
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify,
+		       struct ib_udata *udata);
 
 struct ib_qp *ehca_create_qp(struct ib_pd *pd,
 			     struct ib_qp_init_attr *init_attr,
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index b46bda1..3ed6992 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -634,7 +634,8 @@ poll_cq_exit0:
 	return ret;
 }
 
-int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify)
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify,
+		       struct ib_udata *udata)
 {
 	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_cq.c b/drivers/infiniband/hw/ipath/ipath_cq.c
index 87462e0..27ba4db 100644
--- a/drivers/infiniband/hw/ipath/ipath_cq.c
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c
@@ -307,13 +307,15 @@ int ipath_destroy_cq(struct ib_cq *ibcq)
  * ipath_req_notify_cq - change the notification type for a completion queue
  * @ibcq: the completion queue
  * @notify: the type of notification to request
+ * @udata: user data 
  *
  * Returns 0 for success.
  *
  * This may be called from interrupt context.  Also called by
  * ib_req_notify_cq() in the generic verbs code.
  */
-int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
+			struct ib_udata *udata)
 {
 	struct ipath_cq *cq = to_icq(ibcq);
 	unsigned long flags;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
index 8039f6e..0d39960 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h
@@ -716,7 +716,8 @@ struct ib_cq *ipath_create_cq(struct ib_
 
 int ipath_destroy_cq(struct ib_cq *ibcq);
 
-int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify);
+int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
+			struct ib_udata *udata);
 
 int ipath_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 283d50b..15cbd49 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -722,7 +722,8 @@ repoll:
 	return err == 0 || err == -EAGAIN ? npolled : err;
 }
 
-int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify)
+int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, 
+		       struct ib_udata *udata)
 {
 	__be32 doorbell[2];
 
@@ -739,7 +740,8 @@ int mthca_tavor_arm_cq(struct ib_cq *cq,
 	return 0;
 }
 
-int mthca_arbel_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+int mthca_arbel_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
+		       struct ib_udata *udata)
 {
 	struct mthca_cq *cq = to_mcq(ibcq);
 	__be32 doorbell[2];
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index fe5cecf..6b9ccf6 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -493,8 +493,8 @@ void mthca_unmap_eq_icm(struct mthca_dev
 
 int mthca_poll_cq(struct ib_cq *ibcq, int num_entries,
 		  struct ib_wc *entry);
-int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
-int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
+int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, struct ib_udata *udata);
+int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, struct ib_udata *udata);
 int mthca_init_cq(struct mthca_dev *dev, int nent,
 		  struct mthca_ucontext *ctx, u32 pdn,
 		  struct mthca_cq *cq);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8eacc35..e3e1a2c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -941,7 +941,8 @@ struct ib_device {
 					      struct ib_wc *wc);
 	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
 	int                        (*req_notify_cq)(struct ib_cq *cq,
-						    enum ib_cq_notify cq_notify);
+						    enum ib_cq_notify cq_notify,
+						    struct ib_udata *udata);
 	int                        (*req_ncomp_notif)(struct ib_cq *cq,
 						      int wc_cnt);
 	struct ib_mr *             (*get_dma_mr)(struct ib_pd *pd,
@@ -1373,7 +1374,7 @@ int ib_peek_cq(struct ib_cq *cq, int wc_
 static inline int ib_req_notify_cq(struct ib_cq *cq,
 				   enum ib_cq_notify cq_notify)
 {
-	return cq->device->req_notify_cq(cq, cq_notify);
+	return cq->device->req_notify_cq(cq, cq_notify, NULL);
 }
 
 /**
