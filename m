Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWELX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWELX6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWELX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:55977 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932210AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 53] ipath - replace uses of LIST_POISON
X-Mercurial-Node: 947e92f4b370dc17f898c2308e93b94018d43aaf
Message-Id: <947e92f4b370dc17f898.1147477384@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:04 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Andrew's request.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r df954e47ff67 -r 947e92f4b370 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
@@ -375,10 +375,10 @@ static void ipath_error_qp(struct ipath_
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock(&dev->pending_lock);
 
 	wc.status = IB_WC_WR_FLUSH_ERR;
@@ -722,10 +722,8 @@ struct ib_qp *ipath_create_qp(struct ib_
 			     init_attr->qp_type == IB_QPT_RC ?
 			     ipath_do_rc_send : ipath_do_uc_send,
 			     (unsigned long)qp);
-		qp->piowait.next = LIST_POISON1;
-		qp->piowait.prev = LIST_POISON2;
-		qp->timerwait.next = LIST_POISON1;
-		qp->timerwait.prev = LIST_POISON2;
+		INIT_LIST_HEAD(&qp->piowait);
+		INIT_LIST_HEAD(&qp->timerwait);
 		qp->state = IB_QPS_RESET;
 		qp->s_wq = swq;
 		qp->s_size = init_attr->cap.max_send_wr + 1;
@@ -795,10 +793,10 @@ int ipath_destroy_qp(struct ib_qp *ibqp)
 
 	/* Make sure the QP isn't on the timeout list. */
 	spin_lock_irqsave(&dev->pending_lock, flags);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 	/*
@@ -867,10 +865,10 @@ void ipath_sqerror_qp(struct ipath_qp *q
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock(&dev->pending_lock);
 
 	ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
diff -r df954e47ff67 -r 947e92f4b370 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Fri May 12 15:55:28 2006 -0700
@@ -57,7 +57,7 @@ static void ipath_init_restart(struct ip
 	qp->s_len = wqe->length - len;
 	dev = to_idev(qp->ibqp.device);
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next == LIST_POISON1)
+	if (list_empty(&qp->timerwait))
 		list_add_tail(&qp->timerwait,
 			      &dev->pending[dev->pending_index]);
 	spin_unlock(&dev->pending_lock);
@@ -356,7 +356,7 @@ static inline int ipath_make_rc_req(stru
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		spin_lock(&dev->pending_lock);
-		if (qp->timerwait.next == LIST_POISON1)
+		if (list_empty(&qp->timerwait))
 			list_add_tail(&qp->timerwait,
 				      &dev->pending[dev->pending_index]);
 		spin_unlock(&dev->pending_lock);
@@ -726,8 +726,8 @@ void ipath_restart_rc(struct ipath_qp *q
 	 */
 	dev = to_idev(qp->ibqp.device);
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
 	if (wqe->wr.opcode == IB_WR_RDMA_READ)
@@ -886,8 +886,8 @@ static int do_rc_ack(struct ipath_qp *qp
 	 * just won't find anything to restart if we ACK everything.
 	 */
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
 	/*
@@ -1194,8 +1194,7 @@ static inline void ipath_rc_rcv_resp(str
 		     IB_WR_RDMA_READ))
 		goto ack_done;
 	spin_lock(&dev->pending_lock);
-	if (qp->s_rnr_timeout == 0 &&
-	    qp->timerwait.next != LIST_POISON1)
+	if (qp->s_rnr_timeout == 0 && !list_empty(&qp->timerwait))
 		list_move_tail(&qp->timerwait,
 			       &dev->pending[dev->pending_index]);
 	spin_unlock(&dev->pending_lock);
diff -r df954e47ff67 -r 947e92f4b370 drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri May 12 15:55:28 2006 -0700
@@ -435,7 +435,7 @@ void ipath_no_bufs_available(struct ipat
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->pending_lock, flags);
-	if (qp->piowait.next == LIST_POISON1)
+	if (list_empty(&qp->piowait))
 		list_add_tail(&qp->piowait, &dev->piowait);
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 	/*
diff -r df954e47ff67 -r 947e92f4b370 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -517,7 +517,7 @@ static void ipath_ib_timer(void *arg)
 	last = &dev->pending[dev->pending_index];
 	while (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
-		list_del(&qp->timerwait);
+		list_del_init(&qp->timerwait);
 		qp->timer_next = resend;
 		resend = qp;
 		atomic_inc(&qp->refcount);
@@ -527,7 +527,7 @@ static void ipath_ib_timer(void *arg)
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
 		if (--qp->s_rnr_timeout == 0) {
 			do {
-				list_del(&qp->timerwait);
+				list_del_init(&qp->timerwait);
 				tasklet_hi_schedule(&qp->s_task);
 				if (list_empty(last))
 					break;
@@ -607,7 +607,7 @@ static int ipath_ib_piobufavail(void *ar
 	while (!list_empty(&dev->piowait)) {
 		qp = list_entry(dev->piowait.next, struct ipath_qp,
 				piowait);
-		list_del(&qp->piowait);
+		list_del_init(&qp->piowait);
 		tasklet_hi_schedule(&qp->s_task);
 	}
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
