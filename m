Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWDXV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDXV0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWDXVXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:50 -0400
Received: from mx.pathscale.com ([64.160.42.68]:36035 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751297AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 13] ipath - simplify IB timer usage
X-Mercurial-Node: 36447eb1f256c4c1d7bddd354f4f3e81616caee4
Message-Id: <36447eb1f256c4c1d7bd.1145913786@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:06 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 4eabd5fc05bb -r 36447eb1f256 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Mon Apr 24 14:21:04 2006 -0700
@@ -449,7 +449,6 @@ static void ipath_ib_timer(void *arg)
 {
 	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
 	struct ipath_qp *resend = NULL;
-	struct ipath_qp *rnr = NULL;
 	struct list_head *last;
 	struct ipath_qp *qp;
 	unsigned long flags;
@@ -465,32 +464,18 @@ static void ipath_ib_timer(void *arg)
 	last = &dev->pending[dev->pending_index];
 	while (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
-		if (last->next == LIST_POISON1 ||
-		    last->next != &qp->timerwait ||
-		    qp->timerwait.prev != last) {
-			INIT_LIST_HEAD(last);
-		} else {
-			list_del(&qp->timerwait);
-			qp->timerwait.prev = (struct list_head *) resend;
-			resend = qp;
-			atomic_inc(&qp->refcount);
-		}
+		list_del(&qp->timerwait);
+		qp->timer_next = resend;
+		resend = qp;
+		atomic_inc(&qp->refcount);
 	}
 	last = &dev->rnrwait;
 	if (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
 		if (--qp->s_rnr_timeout == 0) {
 			do {
-				if (last->next == LIST_POISON1 ||
-				    last->next != &qp->timerwait ||
-				    qp->timerwait.prev != last) {
-					INIT_LIST_HEAD(last);
-					break;
-				}
 				list_del(&qp->timerwait);
-				qp->timerwait.prev =
-					(struct list_head *) rnr;
-				rnr = qp;
+				tasklet_hi_schedule(&qp->s_task);
 				if (list_empty(last))
 					break;
 				qp = list_entry(last->next, struct ipath_qp,
@@ -530,8 +515,7 @@ static void ipath_ib_timer(void *arg)
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 	/* XXX What if timer fires again while this is running? */
-	for (qp = resend; qp != NULL;
-	     qp = (struct ipath_qp *) qp->timerwait.prev) {
+	for (qp = resend; qp != NULL; qp = qp->timer_next) {
 		struct ib_wc wc;
 
 		spin_lock_irqsave(&qp->s_lock, flags);
@@ -545,9 +529,6 @@ static void ipath_ib_timer(void *arg)
 		if (atomic_dec_and_test(&qp->refcount))
 			wake_up(&qp->wait);
 	}
-	for (qp = rnr; qp != NULL;
-	     qp = (struct ipath_qp *) qp->timerwait.prev)
-		tasklet_hi_schedule(&qp->s_task);
 }
 
 /**
@@ -556,9 +537,9 @@ static void ipath_ib_timer(void *arg)
  *
  * This is called from ipath_intr() at interrupt level when a PIO buffer is
  * available after ipath_verbs_send() returned an error that no buffers were
- * available.  Return 0 if we consumed all the PIO buffers and we still have
+ * available.  Return 1 if we consumed all the PIO buffers and we still have
  * QPs waiting for buffers (for now, just do a tasklet_hi_schedule and
- * return one).
+ * return zero).
  */
 static int ipath_ib_piobufavail(void *arg)
 {
@@ -579,7 +560,7 @@ static int ipath_ib_piobufavail(void *ar
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 bail:
-	return 1;
+	return 0;
 }
 
 static int ipath_query_device(struct ib_device *ibdev,
@@ -1159,7 +1140,7 @@ static ssize_t show_stats(struct class_d
 
 	len = sprintf(buf,
 		      "RC resends  %d\n"
-		      "RC QACKs    %d\n"
+		      "RC no QACK  %d\n"
 		      "RC ACKs     %d\n"
 		      "RC SEQ NAKs %d\n"
 		      "RC RDMA seq %d\n"
diff -r 4eabd5fc05bb -r 36447eb1f256 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Mon Apr 24 14:21:04 2006 -0700
@@ -282,7 +282,8 @@ struct ipath_srq {
  */
 struct ipath_qp {
 	struct ib_qp ibqp;
-	struct ipath_qp *next;	/* link list for QPN hash table */
+	struct ipath_qp *next;		/* link list for QPN hash table */
+	struct ipath_qp *timer_next;	/* link list for ipath_ib_timer() */
 	struct list_head piowait;	/* link for wait PIO buf */
 	struct list_head timerwait;	/* link for waiting for timeouts */
 	struct ib_ah_attr remote_ah_attr;
