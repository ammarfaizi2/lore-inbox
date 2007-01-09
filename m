Return-Path: <linux-kernel-owner+w=401wt.eu-S932193AbXAITjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXAITjX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAITjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:39:23 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46598 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932170AbXAITjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:39:21 -0500
Subject: Re: [openib-general] [PATCH 1/10] cxgb3 - main header files
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       Divy Le Ray <divy@chelsio.com>, linux-kernel@vger.kernel.org,
       openib-general <openib-general@openib.org>
In-Reply-To: <1168354013.4628.14.camel@stevo-desktop>
References: <20061220124125.6286.17148.stgit@localhost.localdomain>
	 <45918CA4.3020601@garzik.org> <45A36C22.6010009@chelsio.com>
	 <45A36E59.30500@garzik.org> <1168349908.4628.3.camel@stevo-desktop>
	 <20070109135725.GF16107@mellanox.co.il>
	 <1168354013.4628.14.camel@stevo-desktop>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 13:39:22 -0600
Message-Id: <1168371562.17406.3.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> In the interest of expediting this I'll go implement it...
> 
> Steve.
> 

Here it is.  I think this is the correct way to solve the issue (now
that I've implemented it :).  This is a delta from the driver patch
series just for reviewing purposes.


commit e6053f2aee764b21e28cbb19f52995cb413cf733
Author: Steve Wise <swise@opengridcomputing.com>
Date:   Tue Jan 9 13:06:13 2007 -0600

    Chelsio-specific solution for copying in the user cq_index.
    
    - at cq_create time, user lib passes in the address of its cq rptr u32.
    - kernel saves this address in the iwch_cq struct.
    - kernel copies in the rptr value in iwch_req_notify_cq().
    
    Signed-off-by: Steve Wise <swise@opengridcomputing.com>

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index ab99202..28be418 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -143,6 +143,7 @@ static struct ib_cq *iwch_create_cq(stru
 	struct iwch_dev *rhp;
 	struct iwch_cq *chp;
 	struct iwch_create_cq_resp uresp;
+	struct iwch_create_cq_req ureq;
 
 	PDBG("%s ib_dev %p entries %d\n", __FUNCTION__, ibdev, entries);
 	rhp = to_iwch_dev(ibdev);
@@ -150,6 +151,14 @@ static struct ib_cq *iwch_create_cq(stru
 	if (!chp)
 		return ERR_PTR(-ENOMEM);
 
+	if (context) {
+		if (ib_copy_from_udata(&ureq, udata, sizeof (ureq))) {
+			kfree(chp);
+			return ERR_PTR(-EFAULT);
+		}
+		chp->user_rptr_addr = (u32 *)(unsigned long)ureq.user_rptr_addr;
+	}
+
 	if (t3a_device(rhp)) {
 
 		/*
@@ -269,15 +278,14 @@ static int iwch_resize_cq(struct ib_cq *
 	return ret;
 }
 
-static int iwch_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
-		       struct ib_udata *udata)
+static int iwch_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
 {
 	struct iwch_dev *rhp;
 	struct iwch_cq *chp;
 	enum t3_cq_opcode cq_op;
 	int err;
 	unsigned long flag;
-	struct iwch_req_notify_cq ucmd;
+	u32 rptr;
 
 	chp = to_iwch_cq(ibcq);
 	rhp = chp->rhp;
@@ -285,11 +293,11 @@ static int iwch_arm_cq(struct ib_cq *ibc
 		cq_op = CQ_ARM_SE;
 	else
 		cq_op = CQ_ARM_AN;
-	if (udata && t3b_device(rhp)) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
+	if (chp->user_rptr_addr) {
+		if (get_user(rptr, chp->user_rptr_addr))
 			return -EFAULT;
 		spin_lock_irqsave(&chp->lock, flag);
-		chp->cq.rptr = ucmd.rptr;
+		chp->cq.rptr = rptr;
 	} else
 		spin_lock_irqsave(&chp->lock, flag);
 	PDBG("%s rptr 0x%x\n", __FUNCTION__, chp->cq.rptr);
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.h b/drivers/infiniband/hw/cxgb3/iwch_provider.h
index f339427..d9d94e3 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.h
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.h
@@ -105,6 +105,7 @@ struct iwch_cq {
 	spinlock_t lock;
 	atomic_t refcnt;
 	wait_queue_head_t wait;
+	u32 *user_rptr_addr;
 };
 
 static inline struct iwch_cq *to_iwch_cq(struct ib_cq *ibcq)
diff --git a/drivers/infiniband/hw/cxgb3/iwch_user.h b/drivers/infiniband/hw/cxgb3/iwch_user.h
index 4e4b9c9..e8ff061 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_user.h
+++ b/drivers/infiniband/hw/cxgb3/iwch_user.h
@@ -42,6 +42,9 @@ #define IWCH_UVERBS_ABI_VERSION	1
  * In particular do not use pointer types -- pass pointers in __u64
  * instead.
  */
+struct iwch_create_cq_req {
+	__u64 user_rptr_addr;
+};
 
 struct iwch_create_cq_resp {
 	__u64 physaddr;		
@@ -61,8 +64,4 @@ struct iwch_create_qp_resp {
 struct iwch_reg_user_mr_resp {
 	__u32 pbl_addr;
 };
-
-struct iwch_req_notify_cq {
-	__u32 rptr;
-};
 #endif





