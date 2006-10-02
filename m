Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965441AbWJBV5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbWJBV5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965446AbWJBV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:57:34 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:50621 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965441AbWJBV5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:57:32 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 14:57:01 -0700
Message-ID: <ada7izitm8i.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 21:57:02.0619 (UTC) FILETIME=[B13F7EB0:01C6E66D]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

We're through the bulk of our 2.6.19 merge, but this will get some
fixes for drivers and the RDMA CM:

Hoang-Nam Nguyen:
      IB/ehca: Fix device registration
      IB/ehca: Tweak trace message format

Krishna Kumar:
      RDMA/cma: Fix leak of cm_ids in case of failures
      RDMA/cma: Fix device removal race
      RDMA/cma: Eliminate unnecessary remove_list
      RDMA/cma: Optimize error handling

Ralph Campbell:
      IB/ipath: Fix RDMA reads

Sean Hefty:
      RDMA/cma: Set status correctly on route resolution error

 drivers/infiniband/core/cma.c           |   47 +++++++++++++++----------
 drivers/infiniband/hw/ehca/ehca_main.c  |   36 ++++++++++---------
 drivers/infiniband/hw/ehca/ehca_tools.h |    2 +
 drivers/infiniband/hw/ipath/ipath_rc.c  |   59 +++++++++++++++++--------------
 4 files changed, 80 insertions(+), 64 deletions(-)


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1178bd4..9ae4f3a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -874,23 +874,25 @@ static struct rdma_id_private *cma_new_i
 	__u16 port;
 	u8 ip_ver;
 
+	if (cma_get_net_info(ib_event->private_data, listen_id->ps,
+			     &ip_ver, &port, &src, &dst))
+		goto err;
+
 	id = rdma_create_id(listen_id->event_handler, listen_id->context,
 			    listen_id->ps);
 	if (IS_ERR(id))
-		return NULL;
+		goto err;
+
+	cma_save_net_info(&id->route.addr, &listen_id->route.addr,
+			  ip_ver, port, src, dst);
 
 	rt = &id->route;
 	rt->num_paths = ib_event->param.req_rcvd.alternate_path ? 2 : 1;
-	rt->path_rec = kmalloc(sizeof *rt->path_rec * rt->num_paths, GFP_KERNEL);
+	rt->path_rec = kmalloc(sizeof *rt->path_rec * rt->num_paths,
+			       GFP_KERNEL);
 	if (!rt->path_rec)
-		goto err;
+		goto destroy_id;
 
-	if (cma_get_net_info(ib_event->private_data, listen_id->ps,
-			     &ip_ver, &port, &src, &dst))
-		goto err;
-
-	cma_save_net_info(&id->route.addr, &listen_id->route.addr,
-			  ip_ver, port, src, dst);
 	rt->path_rec[0] = *ib_event->param.req_rcvd.primary_path;
 	if (rt->num_paths == 2)
 		rt->path_rec[1] = *ib_event->param.req_rcvd.alternate_path;
@@ -903,8 +905,10 @@ static struct rdma_id_private *cma_new_i
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->state = CMA_CONNECT;
 	return id_priv;
-err:
+
+destroy_id:
 	rdma_destroy_id(id);
+err:
 	return NULL;
 }
 
@@ -932,6 +936,7 @@ static int cma_req_handler(struct ib_cm_
 	mutex_unlock(&lock);
 	if (ret) {
 		ret = -ENODEV;
+		cma_exch(conn_id, CMA_DESTROYING);
 		cma_release_remove(conn_id);
 		rdma_destroy_id(&conn_id->id);
 		goto out;
@@ -1307,6 +1312,7 @@ static void cma_query_handler(int status
 		work->old_state = CMA_ROUTE_QUERY;
 		work->new_state = CMA_ADDR_RESOLVED;
 		work->event.event = RDMA_CM_EVENT_ROUTE_ERROR;
+		work->event.status = status;
 	}
 
 	queue_work(cma_wq, &work->work);
@@ -1862,6 +1868,11 @@ static int cma_connect_ib(struct rdma_id
 
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
 out:
+	if (ret && !IS_ERR(id_priv->cm_id.ib)) {
+		ib_destroy_cm_id(id_priv->cm_id.ib);
+		id_priv->cm_id.ib = NULL;
+	}
+
 	kfree(private_data);
 	return ret;
 }
@@ -1889,10 +1900,8 @@ static int cma_connect_iw(struct rdma_id
 	cm_id->remote_addr = *sin;
 
 	ret = cma_modify_qp_rtr(&id_priv->id);
-	if (ret) {
-		iw_destroy_cm_id(cm_id);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
 	iw_param.ord = conn_param->initiator_depth;
 	iw_param.ird = conn_param->responder_resources;
@@ -1904,6 +1913,10 @@ static int cma_connect_iw(struct rdma_id
 		iw_param.qpn = conn_param->qp_num;
 	ret = iw_cm_connect(cm_id, &iw_param);
 out:
+	if (ret && !IS_ERR(cm_id)) {
+		iw_destroy_cm_id(cm_id);
+		id_priv->cm_id.iw = NULL;
+	}
 	return ret;
 }
 
@@ -2142,12 +2155,9 @@ static int cma_remove_id_dev(struct rdma
 
 static void cma_process_remove(struct cma_device *cma_dev)
 {
-	struct list_head remove_list;
 	struct rdma_id_private *id_priv;
 	int ret;
 
-	INIT_LIST_HEAD(&remove_list);
-
 	mutex_lock(&lock);
 	while (!list_empty(&cma_dev->id_list)) {
 		id_priv = list_entry(cma_dev->id_list.next,
@@ -2158,8 +2168,7 @@ static void cma_process_remove(struct cm
 			continue;
 		}
 
-		list_del(&id_priv->list);
-		list_add_tail(&id_priv->list, &remove_list);
+		list_del_init(&id_priv->list);
 		atomic_inc(&id_priv->refcount);
 		mutex_unlock(&lock);
 
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 2380994..024d511 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -49,7 +49,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0016");
+MODULE_VERSION("SVNEHCA_0017");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -239,7 +239,7 @@ init_node_guid1:
 	return ret;
 }
 
-int ehca_register_device(struct ehca_shca *shca)
+int ehca_init_device(struct ehca_shca *shca)
 {
 	int ret;
 
@@ -317,11 +317,6 @@ int ehca_register_device(struct ehca_shc
 	/* shca->ib_device.process_mad	    = ehca_process_mad;	    */
 	shca->ib_device.mmap		    = ehca_mmap;
 
-	ret = ib_register_device(&shca->ib_device);
-	if (ret)
-		ehca_err(&shca->ib_device,
-			 "ib_register_device() failed ret=%x", ret);
-
 	return ret;
 }
 
@@ -561,9 +556,9 @@ static int __devinit ehca_probe(struct i
 		goto probe1;
 	}
 
-	ret = ehca_register_device(shca);
+	ret = ehca_init_device(shca);
 	if (ret) {
-		ehca_gen_err("Cannot register Infiniband device");
+		ehca_gen_err("Cannot init ehca  device struct");
 		goto probe1;
 	}
 
@@ -571,7 +566,7 @@ static int __devinit ehca_probe(struct i
 	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
 	if (ret) {
 		ehca_err(&shca->ib_device, "Cannot create EQ.");
-		goto probe2;
+		goto probe1;
 	}
 
 	ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
@@ -600,6 +595,13 @@ static int __devinit ehca_probe(struct i
 		goto probe5;
 	}
 
+	ret = ib_register_device(&shca->ib_device);
+	if (ret) {
+		ehca_err(&shca->ib_device,
+			 "ib_register_device() failed ret=%x", ret);
+		goto probe6;
+	}
+
 	/* create AQP1 for port 1 */
 	if (ehca_open_aqp1 == 1) {
 		shca->sport[0].port_state = IB_PORT_DOWN;
@@ -607,7 +609,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 1.");
-			goto probe6;
+			goto probe7;
 		}
 	}
 
@@ -618,7 +620,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 2.");
-			goto probe7;
+			goto probe8;
 		}
 	}
 
@@ -630,12 +632,15 @@ static int __devinit ehca_probe(struct i
 
 	return 0;
 
-probe7:
+probe8:
 	ret = ehca_destroy_aqp1(&shca->sport[0]);
 	if (ret)
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy AQP1 for port 1. ret=%x", ret);
 
+probe7:
+	ib_unregister_device(&shca->ib_device);
+
 probe6:
 	ret = ehca_dereg_internal_maxmr(shca);
 	if (ret)
@@ -660,9 +665,6 @@ probe3:
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy EQ. ret=%x", ret);
 
-probe2:
-	ib_unregister_device(&shca->ib_device);
-
 probe1:
 	ib_dealloc_device(&shca->ib_device);
 
@@ -750,7 +752,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0016)\n");
+	                 "(Rel.: SVNEHCA_0017)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 9f56bb8..809da3e 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -117,7 +117,7 @@ #define ehca_dmp(adr, len, format, args.
 		unsigned int l = (unsigned int)(len); \
 		unsigned char *deb = (unsigned char*)(adr);	\
 		for (x = 0; x < l; x += 16) { \
-			printk("EHCA_DMP:%s" format \
+			printk("EHCA_DMP:%s " format \
 			       " adr=%p ofs=%04x %016lx %016lx\n", \
 			       __FUNCTION__, ##args, deb, x, \
 			       *((u64 *)&deb[0]), *((u64 *)&deb[8])); \
diff --git a/drivers/infiniband/hw/ipath/ipath_rc.c b/drivers/infiniband/hw/ipath/ipath_rc.c
index a504cf6..ce60387 100644
--- a/drivers/infiniband/hw/ipath/ipath_rc.c
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c
@@ -241,10 +241,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		 * original work request since we may need to resend
 		 * it.
 		 */
-		qp->s_sge.sge = wqe->sg_list[0];
-		qp->s_sge.sg_list = wqe->sg_list + 1;
-		qp->s_sge.num_sge = wqe->wr.num_sge;
-		qp->s_len = len = wqe->length;
+		len = wqe->length;
 		ss = &qp->s_sge;
 		bth2 = 0;
 		switch (wqe->wr.opcode) {
@@ -368,14 +365,23 @@ int ipath_make_rc_req(struct ipath_qp *q
 		default:
 			goto done;
 		}
+		qp->s_sge.sge = wqe->sg_list[0];
+		qp->s_sge.sg_list = wqe->sg_list + 1;
+		qp->s_sge.num_sge = wqe->wr.num_sge;
+		qp->s_len = wqe->length;
 		if (newreq) {
 			qp->s_tail++;
 			if (qp->s_tail >= qp->s_size)
 				qp->s_tail = 0;
 		}
-		bth2 |= qp->s_psn++ & IPATH_PSN_MASK;
-		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
-			qp->s_next_psn = qp->s_psn;
+		bth2 |= qp->s_psn & IPATH_PSN_MASK;
+		if (wqe->wr.opcode == IB_WR_RDMA_READ)
+			qp->s_psn = wqe->lpsn + 1;
+		else {
+			qp->s_psn++;
+			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
+				qp->s_next_psn = qp->s_psn;
+		}
 		/*
 		 * Put the QP on the pending list so lost ACKs will cause
 		 * a retry.  More than one request can be pending so the
@@ -690,13 +696,6 @@ void ipath_restart_rc(struct ipath_qp *q
 	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
 	struct ipath_ibdev *dev;
 
-	/*
-	 * If there are no requests pending, we are done.
-	 */
-	if (ipath_cmp24(psn, qp->s_next_psn) >= 0 ||
-	    qp->s_last == qp->s_tail)
-		goto done;
-
 	if (qp->s_retry == 0) {
 		wc->wr_id = wqe->wr.wr_id;
 		wc->status = IB_WC_RETRY_EXC_ERR;
@@ -731,8 +730,6 @@ void ipath_restart_rc(struct ipath_qp *q
 		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
 
 	reset_psn(qp, psn);
-
-done:
 	tasklet_hi_schedule(&qp->s_task);
 
 bail:
@@ -765,6 +762,7 @@ static int do_rc_ack(struct ipath_qp *qp
 	struct ib_wc wc;
 	struct ipath_swqe *wqe;
 	int ret = 0;
+	u32 ack_psn;
 
 	/*
 	 * Remove the QP from the timeout queue (or RNR timeout queue).
@@ -777,26 +775,26 @@ static int do_rc_ack(struct ipath_qp *qp
 		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
+	/* Nothing is pending to ACK/NAK. */
+	if (unlikely(qp->s_last == qp->s_tail))
+		goto bail;
+
 	/*
 	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
 	 * requests and implicitly NAK RDMA read and atomic requests issued
 	 * before the NAK'ed request.  The MSN won't include the NAK'ed
 	 * request but will include an ACK'ed request(s).
 	 */
+	ack_psn = psn;
+	if (aeth >> 29)
+		ack_psn--;
 	wqe = get_swqe_ptr(qp, qp->s_last);
 
-	/* Nothing is pending to ACK/NAK. */
-	if (qp->s_last == qp->s_tail)
-		goto bail;
-
 	/*
 	 * The MSN might be for a later WQE than the PSN indicates so
 	 * only complete WQEs that the PSN finishes.
 	 */
-	while (ipath_cmp24(psn, wqe->lpsn) >= 0) {
-		/* If we are ACKing a WQE, the MSN should be >= the SSN. */
-		if (ipath_cmp24(aeth, wqe->ssn) < 0)
-			break;
+	while (ipath_cmp24(ack_psn, wqe->lpsn) >= 0) {
 		/*
 		 * If this request is a RDMA read or atomic, and the ACK is
 		 * for a later operation, this ACK NAKs the RDMA read or
@@ -807,7 +805,8 @@ static int do_rc_ack(struct ipath_qp *qp
 		 * is sent but before the response is received.
 		 */
 		if ((wqe->wr.opcode == IB_WR_RDMA_READ &&
-		     opcode != OP(RDMA_READ_RESPONSE_LAST)) ||
+		     (opcode != OP(RDMA_READ_RESPONSE_LAST) ||
+		       ipath_cmp24(ack_psn, wqe->lpsn) != 0)) ||
 		    ((wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 		      wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) &&
 		     (opcode != OP(ATOMIC_ACKNOWLEDGE) ||
@@ -825,6 +824,10 @@ static int do_rc_ack(struct ipath_qp *qp
 			 */
 			goto bail;
 		}
+		if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+			tasklet_hi_schedule(&qp->s_task);
 		/* Post a send completion queue entry if requested. */
 		if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
 		    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
@@ -1055,7 +1058,8 @@ static inline void ipath_rc_rcv_resp(str
 		/* no AETH, no ACK */
 		if (unlikely(ipath_cmp24(psn, qp->s_last_psn + 1))) {
 			dev->n_rdma_seq++;
-			ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+			if (qp->s_last != qp->s_tail)
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
 			goto ack_done;
 		}
 	rdma_read:
@@ -1091,7 +1095,8 @@ static inline void ipath_rc_rcv_resp(str
 		/* ACKs READ req. */
 		if (unlikely(ipath_cmp24(psn, qp->s_last_psn + 1))) {
 			dev->n_rdma_seq++;
-			ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+			if (qp->s_last != qp->s_tail)
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
 			goto ack_done;
 		}
 		/* FALLTHROUGH */
