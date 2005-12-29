Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVL2Ajr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVL2Ajr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVL2Ajp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53224 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964940AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 20] ipath - infiniband verbs support, part 3 of 3
X-Mercurial-Node: 584777b6f4dc5269fa89458a8d377abc159d5566
Message-Id: <584777b6f4dc5269fa89.1135816296@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:36 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r fc067af322a1 -r 584777b6f4dc drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 28 14:19:43 2005 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 28 14:19:43 2005 -0800
@@ -4815,3 +4815,1393 @@
 	/* Call do_rc_send() in another thread. */
 	tasklet_schedule(&qp->s_task);
 }
+
+/*
+ * This is called from ipath_ib_rcv() to process an incomming packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+static inline void ipath_qp_rcv(struct ipath_ibdev *dev,
+				struct ipath_ib_header *hdr, int has_grh,
+				void *data, u32 tlen, struct ipath_qp *qp)
+{
+	/* Check for valid receive state. */
+	if (!(state_ops[qp->state] & IPATH_PROCESS_RECV_OK)) {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		ipath_ud_rcv(dev, hdr, has_grh, data, tlen, qp);
+		break;
+
+	case IB_QPT_RC:
+		ipath_rc_rcv(dev, hdr, has_grh, data, tlen, qp);
+		break;
+
+	case IB_QPT_UC:
+		ipath_uc_rcv(dev, hdr, has_grh, data, tlen, qp);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/*
+ * This is called from ipath_kreceive() to process an incomming packet at
+ * interrupt level. Tlen is the length of the header + data + CRC in bytes.
+ */
+static void ipath_ib_rcv(const ipath_type t, void *rhdr, void *data, u32 tlen)
+{
+	struct ipath_ibdev *dev = ipath_devices[t];
+	struct ipath_ib_header *hdr = rhdr;
+	struct ipath_other_headers *ohdr;
+	struct ipath_qp *qp;
+	u32 qp_num;
+	int lnh;
+	u8 opcode;
+
+	if (dev == NULL)
+		return;
+
+	if (tlen < 24) {	/* LRH+BTH+CRC */
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/* Check for GRH */
+	lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+	if (lnh == IPS_LRH_BTH)
+		ohdr = &hdr->u.oth;
+	else if (lnh == IPS_LRH_GRH)
+		ohdr = &hdr->u.l.oth;
+	else {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	opcode = *(u8 *) (&ohdr->bth[0]);
+	dev->opstats[opcode].n_bytes += tlen;
+	dev->opstats[opcode].n_packets++;
+
+	/* Get the destination QP number. */
+	qp_num = be32_to_cpu(ohdr->bth[1]) & 0xFFFFFF;
+	if (qp_num == 0xFFFFFF) {
+		struct ipath_mcast *mcast;
+		struct ipath_mcast_qp *p;
+
+		mcast = ipath_mcast_find(&hdr->u.l.grh.dgid);
+		if (mcast == NULL) {
+			dev->n_pkt_drops++;
+			return;
+		}
+		dev->n_multicast_rcv++;
+		list_for_each_entry_rcu(p, &mcast->qp_list, list)
+			ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data, tlen,
+				     p->qp);
+		/*
+		 * Notify ipath_multicast_detach() if it is waiting for us
+		 * to finish.
+		 */
+		if (atomic_dec_return(&mcast->refcount) <= 1)
+			wake_up(&mcast->wait);
+	} else if ((qp = ipath_lookup_qpn(&dev->qp_table, qp_num)) != NULL) {
+		dev->n_unicast_rcv++;
+		ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data, tlen, qp);
+		/*
+		 * Notify ipath_destroy_qp() if it is waiting for us to finish.
+		 */
+		if (atomic_dec_and_test(&qp->refcount))
+			wake_up(&qp->wait);
+	} else
+		dev->n_pkt_drops++;
+}
+
+/*
+ * This is called from ipath_do_rcv_timer() at interrupt level
+ * to check for QPs which need retransmits and to collect performance numbers.
+ */
+static void ipath_ib_timer(const ipath_type t)
+{
+	struct ipath_ibdev *dev = ipath_devices[t];
+	struct ipath_qp *resend = NULL;
+	struct ipath_qp *rnr = NULL;
+	struct list_head *last;
+	struct ipath_qp *qp;
+	unsigned long flags;
+
+	if (dev == NULL)
+		return;
+
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	/* Start filling the next pending queue. */
+	if (++dev->pending_index >= ARRAY_SIZE(dev->pending))
+		dev->pending_index = 0;
+	/* Save any requests still in the new queue, they have timed out. */
+	last = &dev->pending[dev->pending_index];
+	while (!list_empty(last)) {
+		qp = list_entry(last->next, struct ipath_qp, timerwait);
+		if (last->next == LIST_POISON1 ||
+		    last->next != &qp->timerwait ||
+		    qp->timerwait.prev != last) {
+			INIT_LIST_HEAD(last);
+		} else {
+			list_del(&qp->timerwait);
+			qp->timerwait.prev = (struct list_head *) resend;
+			resend = qp;
+			atomic_inc(&qp->refcount);
+		}
+	}
+	last = &dev->rnrwait;
+	if (!list_empty(last)) {
+		qp = list_entry(last->next, struct ipath_qp, timerwait);
+		if (--qp->s_rnr_timeout == 0) {
+			do {
+				if (last->next == LIST_POISON1 ||
+				    last->next != &qp->timerwait ||
+				    qp->timerwait.prev != last) {
+					INIT_LIST_HEAD(last);
+					break;
+				}
+				list_del(&qp->timerwait);
+				qp->timerwait.prev = (struct list_head *) rnr;
+				rnr = qp;
+				if (list_empty(last))
+					break;
+				qp = list_entry(last->next, struct ipath_qp,
+						timerwait);
+			} while (qp->s_rnr_timeout == 0);
+		}
+	}
+	/* We should only be in the started state if pma_sample_start != 0 */
+	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_STARTED &&
+	    --dev->pma_sample_start == 0) {
+		dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_RUNNING;
+		ipath_layer_snapshot_counters(dev->ib_unit, &dev->ipath_sword,
+					      &dev->ipath_rword,
+					      &dev->ipath_spkts,
+					      &dev->ipath_rpkts);
+	}
+	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_RUNNING) {
+		if (dev->pma_sample_interval == 0) {
+			u64 ta, tb, tc, td;
+
+			dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_DONE;
+			ipath_layer_snapshot_counters(dev->ib_unit,
+						      &ta, &tb, &tc, &td);
+
+			dev->ipath_sword = ta - dev->ipath_sword;
+			dev->ipath_rword = tb - dev->ipath_rword;
+			dev->ipath_spkts = tc - dev->ipath_spkts;
+			dev->ipath_rpkts = td - dev->ipath_rpkts;
+		} else {
+			dev->pma_sample_interval--;
+		}
+	}
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	/* XXX What if timer fires again while this is running? */
+	for (qp = resend; qp != NULL;
+	     qp = (struct ipath_qp *) qp->timerwait.prev) {
+		struct ib_wc wc;
+
+		spin_lock_irqsave(&qp->s_lock, flags);
+		if (qp->s_last != qp->s_tail && qp->state == IB_QPS_RTS) {
+			dev->n_timeouts++;
+			ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+		}
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+
+		/* Notify ipath_destroy_qp() if it is waiting. */
+		if (atomic_dec_and_test(&qp->refcount))
+			wake_up(&qp->wait);
+	}
+	for (qp = rnr; qp != NULL;
+	     qp = (struct ipath_qp *) qp->timerwait.prev) {
+		tasklet_schedule(&qp->s_task);
+	}
+}
+
+/*
+ * This is called from ipath_intr() at interrupt level when a PIO buffer
+ * is available after ipath_verbs_send() returned an error that no
+ * buffers were available.
+ * Return 0 if we consumed all the PIO buffers and we still have QPs
+ * waiting for buffers (for now, just do a tasklet_schedule and return one).
+ */
+static int ipath_ib_piobufavail(const ipath_type t)
+{
+	struct ipath_ibdev *dev = ipath_devices[t];
+	struct ipath_qp *qp;
+	unsigned long flags;
+
+	if (dev == NULL)
+		return 1;
+
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	while (!list_empty(&dev->piowait)) {
+		qp = list_entry(dev->piowait.next, struct ipath_qp, piowait);
+		list_del(&qp->piowait);
+		tasklet_schedule(&qp->s_task);
+	}
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	return 1;
+}
+
+static struct ib_qp *ipath_create_qp(struct ib_pd *ibpd,
+				     struct ib_qp_init_attr *init_attr,
+				     struct ib_udata *udata)
+{
+	struct ipath_qp *qp;
+	int err;
+	struct ipath_swqe *swq = NULL;
+	struct ipath_ibdev *dev;
+	size_t sz;
+
+	if (init_attr->cap.max_send_sge > 255 ||
+	    init_attr->cap.max_recv_sge > 255)
+		return ERR_PTR(-ENOMEM);
+
+	switch (init_attr->qp_type) {
+	case IB_QPT_UC:
+	case IB_QPT_RC:
+		sz = sizeof(struct ipath_sge) * init_attr->cap.max_send_sge +
+		    sizeof(struct ipath_swqe);
+		swq = vmalloc((init_attr->cap.max_send_wr + 1) * sz);
+		if (swq == NULL)
+			return ERR_PTR(-ENOMEM);
+		/* FALLTHROUGH */
+	case IB_QPT_UD:
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		qp = kmalloc(sizeof(*qp), GFP_KERNEL);
+		if (!qp)
+			return ERR_PTR(-ENOMEM);
+		qp->r_rq.size = init_attr->cap.max_recv_wr + 1;
+		sz = sizeof(struct ipath_sge) * init_attr->cap.max_recv_sge +
+		    sizeof(struct ipath_rwqe);
+		qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
+		if (!qp->r_rq.wq) {
+			kfree(qp);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		/*
+		 * ib_create_qp() will initialize qp->ibqp
+		 * except for qp->ibqp.qp_num.
+		 */
+		spin_lock_init(&qp->s_lock);
+		spin_lock_init(&qp->r_rq.lock);
+		atomic_set(&qp->refcount, 0);
+		init_waitqueue_head(&qp->wait);
+		tasklet_init(&qp->s_task,
+			     init_attr->qp_type == IB_QPT_RC ? do_rc_send :
+			     do_uc_send, (unsigned long)qp);
+		qp->piowait.next = LIST_POISON1;
+		qp->piowait.prev = LIST_POISON2;
+		qp->timerwait.next = LIST_POISON1;
+		qp->timerwait.prev = LIST_POISON2;
+		qp->state = IB_QPS_RESET;
+		qp->s_wq = swq;
+		qp->s_size = init_attr->cap.max_send_wr + 1;
+		qp->s_max_sge = init_attr->cap.max_send_sge;
+		qp->r_rq.max_sge = init_attr->cap.max_recv_sge;
+		qp->s_flags = init_attr->sq_sig_type == IB_SIGNAL_REQ_WR ?
+			1 << IPATH_S_SIGNAL_REQ_WR : 0;
+		dev = to_idev(ibpd->device);
+		err = ipath_alloc_qpn(&dev->qp_table, qp, init_attr->qp_type);
+		if (err) {
+			vfree(swq);
+			vfree(qp->r_rq.wq);
+			kfree(qp);
+			return ERR_PTR(err);
+		}
+		ipath_reset_qp(qp);
+
+		/* Tell the core driver that the kernel SMA is present. */
+		if (qp->ibqp.qp_type == IB_QPT_SMI)
+			ipath_verbs_set_flags(dev->ib_unit,
+					      IPATH_VERBS_KERNEL_SMA);
+		break;
+
+	default:
+		/* Don't support raw QPs */
+		return ERR_PTR(-ENOSYS);
+	}
+
+	init_attr->cap.max_inline_data = 0;
+
+	return &qp->ibqp;
+}
+
+/*
+ * Note that this can be called while the QP is actively sending or receiving!
+ */
+static int ipath_destroy_qp(struct ib_qp *ibqp)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
+	unsigned long flags;
+
+	/* Tell the core driver that the kernel SMA is gone. */
+	if (qp->ibqp.qp_type == IB_QPT_SMI)
+		ipath_verbs_set_flags(dev->ib_unit, 0);
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+	spin_lock(&qp->s_lock);
+	qp->state = IB_QPS_ERR;
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+
+	/* Stop the sending tasklet. */
+	tasklet_kill(&qp->s_task);
+
+	/* Make sure the QP isn't on the timeout list. */
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	if (qp->piowait.next != LIST_POISON1)
+		list_del(&qp->piowait);
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	/*
+	 * Make sure that the QP is not in the QPN table so receive interrupts
+	 * will discard packets for this QP.
+	 * XXX Also remove QP from multicast table.
+	 */
+	if (atomic_read(&qp->refcount) != 0)
+		ipath_free_qp(&dev->qp_table, qp);
+
+	vfree(qp->s_wq);
+	vfree(qp->r_rq.wq);
+	kfree(qp);
+	return 0;
+}
+
+static struct ib_srq *ipath_create_srq(struct ib_pd *ibpd,
+				       struct ib_srq_init_attr *srq_init_attr,
+				       struct ib_udata *udata)
+{
+	struct ipath_srq *srq;
+	u32 sz;
+
+	if (srq_init_attr->attr.max_sge < 1)
+		return ERR_PTR(-EINVAL);
+
+	srq = kmalloc(sizeof(*srq), GFP_KERNEL);
+	if (!srq)
+		return ERR_PTR(-ENOMEM);
+
+	/* Need to use vmalloc() if we want to support large #s of entries. */
+	srq->rq.size = srq_init_attr->attr.max_wr + 1;
+	sz = sizeof(struct ipath_sge) * srq_init_attr->attr.max_sge +
+	    sizeof(struct ipath_rwqe);
+	srq->rq.wq = vmalloc(srq->rq.size * sz);
+	if (!srq->rq.wq) {
+		kfree(srq);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * ib_create_srq() will initialize srq->ibsrq.
+	 */
+	spin_lock_init(&srq->rq.lock);
+	srq->rq.head = 0;
+	srq->rq.tail = 0;
+	srq->rq.max_sge = srq_init_attr->attr.max_sge;
+	srq->limit = srq_init_attr->attr.srq_limit;
+
+	return &srq->ibsrq;
+}
+
+int ipath_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
+		     enum ib_srq_attr_mask attr_mask)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+	unsigned long flags;
+
+	if (attr_mask & IB_SRQ_LIMIT) {
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		srq->limit = attr->srq_limit;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	if (attr_mask & IB_SRQ_MAX_WR) {
+		u32 size = attr->max_wr + 1;
+		struct ipath_rwqe *wq, *p;
+		u32 n;
+		u32 sz;
+
+		if (attr->max_sge < srq->rq.max_sge)
+			return -EINVAL;
+
+		sz = sizeof(struct ipath_rwqe) +
+			attr->max_sge * sizeof(struct ipath_sge);
+		wq = vmalloc(size * sz);
+		if (!wq)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		if (srq->rq.head < srq->rq.tail)
+			n = srq->rq.size + srq->rq.head - srq->rq.tail;
+		else
+			n = srq->rq.head - srq->rq.tail;
+		if (size <= n || size <= srq->limit) {
+			spin_unlock_irqrestore(&srq->rq.lock, flags);
+			vfree(wq);
+			return -EINVAL;
+		}
+		n = 0;
+		p = wq;
+		while (srq->rq.tail != srq->rq.head) {
+			struct ipath_rwqe *wqe;
+			int i;
+
+			wqe = get_rwqe_ptr(&srq->rq, srq->rq.tail);
+			p->wr_id = wqe->wr_id;
+			p->length = wqe->length;
+			p->num_sge = wqe->num_sge;
+			for (i = 0; i < wqe->num_sge; i++)
+				p->sg_list[i] = wqe->sg_list[i];
+			n++;
+			p = (struct ipath_rwqe *)((char *) p + sz);
+			if (++srq->rq.tail >= srq->rq.size)
+				srq->rq.tail = 0;
+		}
+		vfree(srq->rq.wq);
+		srq->rq.wq = wq;
+		srq->rq.size = size;
+		srq->rq.head = n;
+		srq->rq.tail = 0;
+		srq->rq.max_sge = attr->max_sge;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	return 0;
+}
+
+static int ipath_destroy_srq(struct ib_srq *ibsrq)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+
+	vfree(srq->rq.wq);
+	kfree(srq);
+
+	return 0;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_poll_cq(struct ib_cq *ibcq, int num_entries,
+			 struct ib_wc *entry)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+	unsigned long flags;
+	int npolled;
+
+	spin_lock_irqsave(&cq->lock, flags);
+
+	for (npolled = 0; npolled < num_entries; ++npolled, ++entry) {
+		if (cq->tail == cq->head)
+			break;
+		*entry = cq->queue[cq->tail];
+		if (++cq->tail == cq->ibcq.cqe)
+			cq->tail = 0;
+	}
+
+	spin_unlock_irqrestore(&cq->lock, flags);
+
+	return npolled;
+}
+
+static struct ib_cq *ipath_create_cq(struct ib_device *ibdev, int entries,
+				     struct ib_ucontext *context,
+				     struct ib_udata *udata)
+{
+	struct ipath_cq *cq;
+
+	/* Need to use vmalloc() if we want to support large #s of entries. */
+	cq = vmalloc(sizeof(*cq) + entries * sizeof(*cq->queue));
+	if (!cq)
+		return ERR_PTR(-ENOMEM);
+	/*
+	 * ib_create_cq() will initialize cq->ibcq except for cq->ibcq.cqe.
+	 * The number of entries should be >= the number requested or
+	 * return an error.
+	 */
+	cq->ibcq.cqe = entries + 1;
+	cq->notify = IB_CQ_NONE;
+	cq->triggered = 0;
+	spin_lock_init(&cq->lock);
+	tasklet_init(&cq->comptask, send_complete, (unsigned long)cq);
+	cq->head = 0;
+	cq->tail = 0;
+
+	return &cq->ibcq;
+}
+
+static int ipath_destroy_cq(struct ib_cq *ibcq)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+
+	tasklet_kill(&cq->comptask);
+	vfree(cq);
+
+	return 0;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+{
+	struct ipath_cq *cq = to_icq(ibcq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->lock, flags);
+	/*
+	 * Don't change IB_CQ_NEXT_COMP to IB_CQ_SOLICITED but allow
+	 * any other transitions.
+	 */
+	if (cq->notify != IB_CQ_NEXT_COMP)
+		cq->notify = notify;
+	spin_unlock_irqrestore(&cq->lock, flags);
+	return 0;
+}
+
+static int ipath_query_device(struct ib_device *ibdev,
+			      struct ib_device_attr *props)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	uint32_t vendor, boardrev, majrev, minrev;
+
+	memset(props, 0, sizeof(*props));
+
+	props->device_cap_flags = IB_DEVICE_BAD_PKEY_CNTR |
+		IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
+		IB_DEVICE_SYS_IMAGE_GUID;
+	ipath_layer_query_device(dev->ib_unit, &vendor, &boardrev,
+				 &majrev, &minrev);
+	props->vendor_id = vendor;
+	props->vendor_part_id = boardrev;
+	props->hw_ver = boardrev << 16 | majrev << 8 | minrev;
+
+	props->sys_image_guid = dev->sys_image_guid;
+	props->node_guid = ipath_layer_get_guid(dev->ib_unit);
+
+	props->max_mr_size = ~0ull;
+	props->max_qp = 0xffff;
+	props->max_qp_wr = 0xffff;
+	props->max_sge = 255;
+	props->max_cq = 0xffff;
+	props->max_cqe = 0xffff;
+	props->max_mr = 0xffff;
+	props->max_pd = 0xffff;
+	props->max_qp_rd_atom = 1;
+	props->max_qp_init_rd_atom = 1;
+	/* props->max_res_rd_atom */
+	props->max_srq = 0xffff;
+	props->max_srq_wr = 0xffff;
+	props->max_srq_sge = 255;
+	/* props->local_ca_ack_delay */
+	props->atomic_cap = IB_ATOMIC_HCA;
+	props->max_pkeys = ipath_layer_get_npkeys(dev->ib_unit);
+	props->max_mcast_grp = 0xffff;
+	props->max_mcast_qp_attach = 0xffff;
+	props->max_total_mcast_qp_attach = props->max_mcast_qp_attach *
+					   props->max_mcast_grp;
+
+	return 0;
+}
+
+static int ipath_query_port(struct ib_device *ibdev,
+			    u8 port, struct ib_port_attr *props)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	uint32_t flags = ipath_layer_get_flags(dev->ib_unit);
+	enum ib_mtu mtu;
+	uint32_t l;
+	uint16_t lid = ipath_layer_get_lid(dev->ib_unit);
+
+	memset(props, 0, sizeof(*props));
+	props->lid = lid ? lid : IB_LID_PERMISSIVE;
+	props->lmc = dev->mkeyprot_resv_lmc & 7;
+	props->sm_lid = dev->sm_lid;
+	props->sm_sl = dev->sm_sl;
+	if (flags & IPATH_LINKDOWN)
+		props->state = IB_PORT_DOWN;
+	else if (flags & IPATH_LINKARMED)
+		props->state = IB_PORT_ARMED;
+	else if (flags & IPATH_LINKACTIVE)
+		props->state = IB_PORT_ACTIVE;
+	else if (flags & IPATH_LINK_SLEEPING)
+		props->state = IB_PORT_ACTIVE_DEFER;
+	else
+		props->state = IB_PORT_NOP;
+	/* See phys_state_show() */
+	props->phys_state = 5;	/* LinkUp */
+	props->port_cap_flags = dev->port_cap_flags;
+	props->gid_tbl_len = 1;
+	props->max_msg_sz = 4096;
+	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->ib_unit);
+	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->ib_unit);
+	props->qkey_viol_cntr = dev->qkey_violations;
+	props->active_width = IB_WIDTH_4X;
+	/* See rate_show() */
+	props->active_speed = 1;	/* Regular 10Mbs speed. */
+	props->max_vl_num = 1;		/* VLCap = VL0 */
+	props->init_type_reply = 0;
+
+	props->max_mtu = IB_MTU_4096;
+	l = ipath_layer_get_ibmtu(dev->ib_unit);
+	switch (l) {
+	case 4096:
+		mtu = IB_MTU_4096;
+		break;
+	case 2048:
+		mtu = IB_MTU_2048;
+		break;
+	case 1024:
+		mtu = IB_MTU_1024;
+		break;
+	case 512:
+		mtu = IB_MTU_512;
+		break;
+	case 256:
+		mtu = IB_MTU_256;
+		break;
+	default:
+		mtu = IB_MTU_2048;
+	}
+	props->active_mtu = mtu;
+	props->subnet_timeout = dev->subnet_timeout;
+
+	return 0;
+}
+
+static int ipath_modify_device(struct ib_device *device,
+			       int device_modify_mask,
+			       struct ib_device_modify *device_modify)
+{
+	if (device_modify_mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID)
+		to_idev(device)->sys_image_guid = device_modify->sys_image_guid;
+
+	return 0;
+}
+
+static int ipath_modify_port(struct ib_device *ibdev,
+			     u8 port, int port_modify_mask,
+			     struct ib_port_modify *props)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	atomic_set_mask(props->set_port_cap_mask, &dev->port_cap_flags);
+	atomic_clear_mask(props->clr_port_cap_mask, &dev->port_cap_flags);
+	if (port_modify_mask & IB_PORT_SHUTDOWN)
+		ipath_kset_linkstate(dev->ib_unit << 16 | IPATH_IB_LINKDOWN);
+	if (port_modify_mask & IB_PORT_RESET_QKEY_CNTR)
+		dev->qkey_violations = 0;
+	return 0;
+}
+
+static int ipath_query_pkey(struct ib_device *ibdev,
+			    u8 port, u16 index, u16 *pkey)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	if (index >= ipath_layer_get_npkeys(dev->ib_unit))
+		return -EINVAL;
+	*pkey = ipath_layer_get_pkey(dev->ib_unit, index);
+	return 0;
+}
+
+static int ipath_query_gid(struct ib_device *ibdev, u8 port,
+			   int index, union ib_gid *gid)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	if (index >= 1)
+		return -EINVAL;
+	gid->global.subnet_prefix = dev->gid_prefix;
+	gid->global.interface_id = ipath_layer_get_guid(dev->ib_unit);
+
+	return 0;
+}
+
+static struct ib_pd *ipath_alloc_pd(struct ib_device *ibdev,
+				    struct ib_ucontext *context,
+				    struct ib_udata *udata)
+{
+	struct ipath_pd *pd;
+
+	pd = kmalloc(sizeof *pd, GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	/* ib_alloc_pd() will initialize pd->ibpd. */
+	pd->user = udata != NULL;
+
+	return &pd->ibpd;
+}
+
+static int ipath_dealloc_pd(struct ib_pd *ibpd)
+{
+	struct ipath_pd *pd = to_ipd(ibpd);
+
+	kfree(pd);
+
+	return 0;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static struct ib_ah *ipath_create_ah(struct ib_pd *pd,
+				     struct ib_ah_attr *ah_attr)
+{
+	struct ipath_ah *ah;
+
+	ah = kmalloc(sizeof *ah, GFP_ATOMIC);
+	if (!ah)
+		return ERR_PTR(-ENOMEM);
+
+	/* ib_create_ah() will initialize ah->ibah. */
+	ah->attr = *ah_attr;
+
+	return &ah->ibah;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_destroy_ah(struct ib_ah *ibah)
+{
+	struct ipath_ah *ah = to_iah(ibah);
+
+	kfree(ah);
+
+	return 0;
+}
+
+static struct ib_mr *ipath_get_dma_mr(struct ib_pd *pd, int acc)
+{
+	struct ipath_mr *mr;
+
+	mr = kmalloc(sizeof *mr, GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	/* ib_get_dma_mr() will initialize mr->ibmr except for lkey and rkey. */
+	memset(mr, 0, sizeof *mr);
+	mr->mr.access_flags = acc;
+	return &mr->ibmr;
+}
+
+static struct ib_mr *ipath_reg_phys_mr(struct ib_pd *pd,
+				       struct ib_phys_buf *buffer_list,
+				       int num_phys_buf,
+				       int acc, u64 *iova_start)
+{
+	struct ipath_mr *mr;
+	int n, m, i;
+
+	/* Allocate struct plus pointers to first level page tables. */
+	m = (num_phys_buf + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
+	mr = kmalloc(sizeof *mr + m * sizeof mr->mr.map[0], GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate first level page tables. */
+	for (i = 0; i < m; i++) {
+		mr->mr.map[i] = kmalloc(sizeof *mr->mr.map[0], GFP_KERNEL);
+		if (!mr->mr.map[i]) {
+			while (i)
+				kfree(mr->mr.map[--i]);
+			kfree(mr);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	mr->mr.mapsz = m;
+
+	/*
+	 * ib_reg_phys_mr() will initialize mr->ibmr except for
+	 * lkey and rkey.
+	 */
+	if (!ipath_alloc_lkey(&to_idev(pd->device)->lk_table, &mr->mr)) {
+		while (i)
+			kfree(mr->mr.map[--i]);
+		kfree(mr);
+		return ERR_PTR(-ENOMEM);
+	}
+	mr->ibmr.rkey = mr->ibmr.lkey = mr->mr.lkey;
+	mr->mr.user_base = *iova_start;
+	mr->mr.iova = *iova_start;
+	mr->mr.length = 0;
+	mr->mr.offset = 0;
+	mr->mr.access_flags = acc;
+	mr->mr.max_segs = num_phys_buf;
+	m = 0;
+	n = 0;
+	for (i = 0; i < num_phys_buf; i++) {
+		mr->mr.map[m]->segs[n].vaddr =
+			phys_to_virt(buffer_list[i].addr);
+		mr->mr.map[m]->segs[n].length = buffer_list[i].size;
+		mr->mr.length += buffer_list[i].size;
+		if (++n == IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
+	return &mr->ibmr;
+}
+
+static struct ib_mr *ipath_reg_user_mr(struct ib_pd *pd,
+				       struct ib_umem *region,
+				       int mr_access_flags,
+				       struct ib_udata *udata)
+{
+	struct ipath_mr *mr;
+	struct ib_umem_chunk *chunk;
+	int n, m, i;
+
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list)
+	    n += chunk->nents;
+
+	/* Allocate struct plus pointers to first level page tables. */
+	m = (n + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
+	mr = kmalloc(sizeof *mr + m * sizeof mr->mr.map[0], GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate first level page tables. */
+	for (i = 0; i < m; i++) {
+		mr->mr.map[i] = kmalloc(sizeof *mr->mr.map[0], GFP_KERNEL);
+		if (!mr->mr.map[i]) {
+			while (i)
+				kfree(mr->mr.map[--i]);
+			kfree(mr);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	mr->mr.mapsz = m;
+
+	/*
+	 * ib_uverbs_reg_mr() will initialize mr->ibmr except for
+	 * lkey and rkey.
+	 */
+	if (!ipath_alloc_lkey(&to_idev(pd->device)->lk_table, &mr->mr)) {
+		while (i)
+			kfree(mr->mr.map[--i]);
+		kfree(mr);
+		return ERR_PTR(-ENOMEM);
+	}
+	mr->ibmr.rkey = mr->ibmr.lkey = mr->mr.lkey;
+	mr->mr.user_base = region->user_base;
+	mr->mr.iova = region->virt_base;
+	mr->mr.length = region->length;
+	mr->mr.offset = region->offset;
+	mr->mr.access_flags = mr_access_flags;
+	mr->mr.max_segs = n;
+	m = 0;
+	n = 0;
+	list_for_each_entry(chunk, &region->chunk_list, list) {
+		for (i = 0; i < chunk->nmap; i++) {
+			mr->mr.map[m]->segs[n].vaddr =
+			    page_address(chunk->page_list[i].page);
+			mr->mr.map[m]->segs[n].length = region->page_size;
+			if (++n == IPATH_SEGSZ) {
+				m++;
+				n = 0;
+			}
+		}
+	}
+	return &mr->ibmr;
+}
+
+/*
+ * Note that this is called to free MRs created by
+ * ipath_get_dma_mr() or ipath_reg_user_mr().
+ */
+static int ipath_dereg_mr(struct ib_mr *ibmr)
+{
+	struct ipath_mr *mr = to_imr(ibmr);
+	int i;
+
+	ipath_free_lkey(&to_idev(ibmr->device)->lk_table, ibmr->lkey);
+	i = mr->mr.mapsz;
+	while (i)
+		kfree(mr->mr.map[--i]);
+	kfree(mr);
+	return 0;
+}
+
+static struct ib_fmr *ipath_alloc_fmr(struct ib_pd *pd,
+				      int mr_access_flags,
+				      struct ib_fmr_attr *fmr_attr)
+{
+	struct ipath_fmr *fmr;
+	int m, i;
+
+	/* Allocate struct plus pointers to first level page tables. */
+	m = (fmr_attr->max_pages + IPATH_SEGSZ - 1) / IPATH_SEGSZ;
+	fmr = kmalloc(sizeof *fmr + m * sizeof fmr->mr.map[0], GFP_KERNEL);
+	if (!fmr)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate first level page tables. */
+	for (i = 0; i < m; i++) {
+		fmr->mr.map[i] = kmalloc(sizeof *fmr->mr.map[0], GFP_KERNEL);
+		if (!fmr->mr.map[i]) {
+			while (i)
+				kfree(fmr->mr.map[--i]);
+			kfree(fmr);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	fmr->mr.mapsz = m;
+
+	/* ib_alloc_fmr() will initialize fmr->ibfmr except for lkey & rkey. */
+	if (!ipath_alloc_lkey(&to_idev(pd->device)->lk_table, &fmr->mr)) {
+		while (i)
+			kfree(fmr->mr.map[--i]);
+		kfree(fmr);
+		return ERR_PTR(-ENOMEM);
+	}
+	fmr->ibfmr.rkey = fmr->ibfmr.lkey = fmr->mr.lkey;
+	/* Resources are allocated but no valid mapping (RKEY can't be used). */
+	fmr->mr.user_base = 0;
+	fmr->mr.iova = 0;
+	fmr->mr.length = 0;
+	fmr->mr.offset = 0;
+	fmr->mr.access_flags = mr_access_flags;
+	fmr->mr.max_segs = fmr_attr->max_pages;
+	fmr->page_size = fmr_attr->page_size;
+	return &fmr->ibfmr;
+}
+
+/*
+ * This may be called from interrupt context.
+ * XXX Can we ever be called to map a portion of the RKEY space?
+ */
+static int ipath_map_phys_fmr(struct ib_fmr *ibfmr,
+			      u64 * page_list, int list_len, u64 iova)
+{
+	struct ipath_fmr *fmr = to_ifmr(ibfmr);
+	struct ipath_lkey_table *rkt;
+	unsigned long flags;
+	int m, n, i;
+	u32 ps;
+
+	if (list_len > fmr->mr.max_segs)
+		return -EINVAL;
+	rkt = &to_idev(ibfmr->device)->lk_table;
+	spin_lock_irqsave(&rkt->lock, flags);
+	fmr->mr.user_base = iova;
+	fmr->mr.iova = iova;
+	ps = 1 << fmr->page_size;
+	fmr->mr.length = list_len * ps;
+	m = 0;
+	n = 0;
+	ps = 1 << fmr->page_size;
+	for (i = 0; i < list_len; i++) {
+		fmr->mr.map[m]->segs[n].vaddr = phys_to_virt(page_list[i]);
+		fmr->mr.map[m]->segs[n].length = ps;
+		if (++n == IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
+	spin_unlock_irqrestore(&rkt->lock, flags);
+	return 0;
+}
+
+static int ipath_unmap_fmr(struct list_head *fmr_list)
+{
+	struct ipath_fmr *fmr;
+
+	list_for_each_entry(fmr, fmr_list, ibfmr.list) {
+		fmr->mr.user_base = 0;
+		fmr->mr.iova = 0;
+		fmr->mr.length = 0;
+	}
+	return 0;
+}
+
+static int ipath_dealloc_fmr(struct ib_fmr *ibfmr)
+{
+	struct ipath_fmr *fmr = to_ifmr(ibfmr);
+	int i;
+
+	ipath_free_lkey(&to_idev(ibfmr->device)->lk_table, ibfmr->lkey);
+	i = fmr->mr.mapsz;
+	while (i)
+		kfree(fmr->mr.map[--i]);
+	kfree(fmr);
+	return 0;
+}
+
+static ssize_t show_rev(struct class_device *cdev, char *buf)
+{
+	struct ipath_ibdev *dev =
+	    container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int vendor, boardrev, majrev, minrev;
+
+	ipath_layer_query_device(dev->ib_unit, &vendor, &boardrev,
+				 &majrev, &minrev);
+	return sprintf(buf, "%d.%d\n", majrev, minrev);
+}
+
+static ssize_t show_hca(struct class_device *cdev, char *buf)
+{
+	struct ipath_ibdev *dev =
+	    container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int vendor, boardrev, majrev, minrev;
+
+	ipath_layer_query_device(dev->ib_unit, &vendor, &boardrev,
+				 &majrev, &minrev);
+	ipath_get_boardname(dev->ib_unit, buf, 128);
+	strcat(buf, "\n");
+	return strlen(buf);
+}
+
+static ssize_t show_board(struct class_device *cdev, char *buf)
+{
+	struct ipath_ibdev *dev =
+	    container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int vendor, boardrev, majrev, minrev;
+
+	ipath_layer_query_device(dev->ib_unit, &vendor, &boardrev,
+				 &majrev, &minrev);
+	ipath_get_boardname(dev->ib_unit, buf, 128);
+	strcat(buf, "\n");
+	return strlen(buf);
+}
+
+static ssize_t show_stats(struct class_device *cdev, char *buf)
+{
+	struct ipath_ibdev *dev =
+	    container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	char *p;
+	int i;
+
+	sprintf(buf,
+		"RC resends  %d\n"
+		"RC QACKs    %d\n"
+		"RC ACKs     %d\n"
+		"RC SEQ NAKs %d\n"
+		"RC RDMA seq %d\n"
+		"RC RNR NAKs %d\n"
+		"RC OTH NAKs %d\n"
+		"RC timeouts %d\n"
+		"RC RDMA dup %d\n"
+		"piobuf wait %d\n"
+		"no piobuf   %d\n"
+		"PKT drops   %d\n"
+		"WQE errs    %d\n",
+		dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
+		dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
+		dev->n_other_naks, dev->n_timeouts, dev->n_rdma_dup_busy,
+		dev->n_piowait, dev->n_no_piobuf, dev->n_pkt_drops,
+		dev->n_wqe_errs);
+	p = buf;
+	for (i = 0; i < ARRAY_SIZE(dev->opstats); i++) {
+		if (!dev->opstats[i].n_packets && !dev->opstats[i].n_bytes)
+			continue;
+		p += strlen(p);
+		sprintf(p, "%02x %llu/%llu\n",
+			i, dev->opstats[i].n_packets, dev->opstats[i].n_bytes);
+	}
+	return strlen(buf);
+}
+
+static CLASS_DEVICE_ATTR(hw_rev, S_IRUGO, show_rev, NULL);
+static CLASS_DEVICE_ATTR(hca_type, S_IRUGO, show_hca, NULL);
+static CLASS_DEVICE_ATTR(board_id, S_IRUGO, show_board, NULL);
+static CLASS_DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
+
+static struct class_device_attribute *ipath_class_attributes[] = {
+	&class_device_attr_hw_rev,
+	&class_device_attr_hca_type,
+	&class_device_attr_board_id,
+	&class_device_attr_stats
+};
+
+/*
+ * Allocate a ucontext.
+ */
+
+static struct ib_ucontext *ipath_alloc_ucontext(struct ib_device *ibdev,
+						struct ib_udata *udata)
+{
+	struct ipath_ucontext *context;
+
+	context = kmalloc(sizeof *context, GFP_KERNEL);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	return &context->ibucontext;
+}
+
+static int ipath_dealloc_ucontext(struct ib_ucontext *context)
+{
+	kfree(to_iucontext(context));
+	return 0;
+}
+
+/*
+ * Register our device with the infiniband core.
+ */
+static int ipath_register_ib_device(const ipath_type t)
+{
+	struct ipath_ibdev *idev;
+	struct ib_device *dev;
+	int i;
+	int ret;
+
+	idev = (struct ipath_ibdev *)ib_alloc_device(sizeof *idev);
+	if (idev == NULL)
+		return -ENOMEM;
+
+	dev = &idev->ibdev;
+
+	/* Only need to initialize non-zero fields. */
+	spin_lock_init(&idev->qp_table.lock);
+	spin_lock_init(&idev->lk_table.lock);
+	idev->sm_lid = IB_LID_PERMISSIVE;
+	idev->gid_prefix = __constant_cpu_to_be64(0xfe80000000000000UL);
+	idev->qp_table.last = 1;	/* QPN 0 and 1 are special. */
+	idev->qp_table.max = ib_ipath_qp_table_size;
+	idev->qp_table.nmaps = 1;
+	idev->qp_table.table = kmalloc(idev->qp_table.max *
+				       sizeof(*idev->qp_table.table),
+				       GFP_KERNEL);
+	if (idev->qp_table.table == NULL) {
+		ret = -ENOMEM;
+		goto err_qp;
+	}
+	memset(idev->qp_table.table, 0,
+	       idev->qp_table.max * sizeof(*idev->qp_table.table));
+	for (i = 0; i < ARRAY_SIZE(idev->qp_table.map); i++) {
+		atomic_set(&idev->qp_table.map[i].n_free, BITS_PER_PAGE);
+		idev->qp_table.map[i].page = NULL;
+	}
+	/*
+	 * The top ib_ipath_lkey_table_size bits are used to index the table.
+	 * The lower 8 bits can be owned by the user (copied from the LKEY).
+	 * The remaining bits act as a generation number or tag.
+	 */
+	idev->lk_table.max = 1 << ib_ipath_lkey_table_size;
+	idev->lk_table.table = kmalloc(idev->lk_table.max *
+				       sizeof(*idev->lk_table.table),
+				       GFP_KERNEL);
+	if (idev->lk_table.table == NULL) {
+		ret = -ENOMEM;
+		goto err_lk;
+	}
+	memset(idev->lk_table.table, 0,
+	       idev->lk_table.max * sizeof(*idev->lk_table.table));
+	spin_lock_init(&idev->pending_lock);
+	INIT_LIST_HEAD(&idev->pending[0]);
+	INIT_LIST_HEAD(&idev->pending[1]);
+	INIT_LIST_HEAD(&idev->pending[2]);
+	INIT_LIST_HEAD(&idev->piowait);
+	INIT_LIST_HEAD(&idev->rnrwait);
+	idev->pending_index = 0;
+	idev->port_cap_flags =
+		IB_PORT_SYS_IMAGE_GUID_SUP | IB_PORT_CLIENT_REG_SUP;
+	idev->pma_counter_select[0] = IB_PMA_PORT_XMIT_DATA;
+	idev->pma_counter_select[1] = IB_PMA_PORT_RCV_DATA;
+	idev->pma_counter_select[2] = IB_PMA_PORT_XMIT_PKTS;
+	idev->pma_counter_select[3] = IB_PMA_PORT_RCV_PKTS;
+	idev->pma_counter_select[5] = IB_PMA_PORT_XMIT_WAIT;
+
+	/*
+	 * The system image GUI is supposed to be the same for all
+	 * IB HCAs in a single system.
+	 * Note that this code assumes device zero is found first.
+	 */
+	idev->sys_image_guid =
+		t ? ipath_devices[t]->sys_image_guid : ipath_layer_get_guid(t);
+	idev->ib_unit = t;
+
+	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
+	dev->node_guid = ipath_layer_get_guid(t);
+	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
+	dev->uverbs_cmd_mask =
+		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
+		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
+		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)		|
+		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
+		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_POLL_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)	|
+		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
+		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_POST_SEND)		|
+		(1ull << IB_USER_VERBS_CMD_POST_RECV)		|
+		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
+		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
+		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
+	dev->node_type = IB_NODE_CA;
+	dev->phys_port_cnt = 1;
+	dev->dma_device = ipath_layer_get_pcidev(t);
+	dev->class_dev.dev = dev->dma_device;
+	dev->query_device = ipath_query_device;
+	dev->modify_device = ipath_modify_device;
+	dev->query_port = ipath_query_port;
+	dev->modify_port = ipath_modify_port;
+	dev->query_pkey = ipath_query_pkey;
+	dev->query_gid = ipath_query_gid;
+	dev->alloc_ucontext = ipath_alloc_ucontext;
+	dev->dealloc_ucontext = ipath_dealloc_ucontext;
+	dev->alloc_pd = ipath_alloc_pd;
+	dev->dealloc_pd = ipath_dealloc_pd;
+	dev->create_ah = ipath_create_ah;
+	dev->destroy_ah = ipath_destroy_ah;
+	dev->create_srq = ipath_create_srq;
+	dev->modify_srq = ipath_modify_srq;
+	dev->destroy_srq = ipath_destroy_srq;
+	dev->create_qp = ipath_create_qp;
+	dev->modify_qp = ipath_modify_qp;
+	dev->destroy_qp = ipath_destroy_qp;
+	dev->post_send = ipath_post_send;
+	dev->post_recv = ipath_post_receive;
+	dev->post_srq_recv = ipath_post_srq_receive;
+	dev->create_cq = ipath_create_cq;
+	dev->destroy_cq = ipath_destroy_cq;
+	dev->poll_cq = ipath_poll_cq;
+	dev->req_notify_cq = ipath_req_notify_cq;
+	dev->get_dma_mr = ipath_get_dma_mr;
+	dev->reg_phys_mr = ipath_reg_phys_mr;
+	dev->reg_user_mr = ipath_reg_user_mr;
+	dev->dereg_mr = ipath_dereg_mr;
+	dev->alloc_fmr = ipath_alloc_fmr;
+	dev->map_phys_fmr = ipath_map_phys_fmr;
+	dev->unmap_fmr = ipath_unmap_fmr;
+	dev->dealloc_fmr = ipath_dealloc_fmr;
+	dev->attach_mcast = ipath_multicast_attach;
+	dev->detach_mcast = ipath_multicast_detach;
+	dev->process_mad = ipath_process_mad;
+
+	ret = ib_register_device(dev);
+	if (ret)
+		goto err_reg;
+
+	/*
+	 * We don't need to register a MAD agent, we just need to create
+	 * a linker dependency on ib_mad so the module is loaded before
+	 * this module is initialized.  The call to ib_register_device()
+	 * above will then cause ib_mad to create QP 0 & 1.
+	 */
+	(void) ib_register_mad_agent(dev, 1, (enum ib_qp_type) 2,
+				     NULL, 0, NULL, NULL, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(ipath_class_attributes); ++i) {
+		ret = class_device_create_file(&dev->class_dev,
+					       ipath_class_attributes[i]);
+		if (ret)
+			goto err_class;
+	}
+
+	ipath_layer_enable_timer(t);
+
+	ipath_devices[t] = idev;
+	return 0;
+
+err_class:
+	ib_unregister_device(dev);
+err_reg:
+	kfree(idev->lk_table.table);
+err_lk:
+	kfree(idev->qp_table.table);
+err_qp:
+	ib_dealloc_device(dev);
+	return ret;
+}
+
+static void ipath_unregister_ib_device(struct ipath_ibdev *dev)
+{
+	struct ib_device *ibdev = &dev->ibdev;
+
+	ipath_layer_disable_timer(dev->ib_unit);
+
+	ib_unregister_device(ibdev);
+
+	if (!list_empty(&dev->pending[0]) || !list_empty(&dev->pending[1]) ||
+	    !list_empty(&dev->pending[2]))
+		_VERBS_ERROR("ipath%d pending list not empty!\n", dev->ib_unit);
+	if (!list_empty(&dev->piowait))
+		_VERBS_ERROR("ipath%d piowait list not empty!\n", dev->ib_unit);
+	if (!list_empty(&dev->rnrwait))
+		_VERBS_ERROR("ipath%d rnrwait list not empty!\n", dev->ib_unit);
+	if (mcast_tree.rb_node != NULL)
+		_VERBS_ERROR("ipath%d multicast table memory leak!\n",
+			     dev->ib_unit);
+	/*
+	 * Note that ipath_unregister_ib_device() can be called before all
+	 * the QPs are destroyed!
+	 */
+	ipath_free_all_qps(&dev->qp_table);
+	kfree(dev->qp_table.table);
+	kfree(dev->lk_table.table);
+	ib_dealloc_device(ibdev);
+}
+
+int __init ipath_verbs_init(void)
+{
+	int i;
+
+	number_of_devices = ipath_layer_get_num_of_dev();
+	i = number_of_devices * sizeof(struct ipath_ibdev *);
+	ipath_devices = kmalloc(i, GFP_ATOMIC);
+	if (ipath_devices == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < number_of_devices; i++) {
+		int ret = ipath_verbs_register(i, ipath_ib_piobufavail,
+					       ipath_ib_rcv, ipath_ib_timer);
+
+		if (ret == 0)
+			ipath_devices[i] = NULL;
+		else if ((ret = ipath_register_ib_device(i)) != 0) {
+			_VERBS_ERROR("ib_ipath%d cannot register ib device "
+				     "(%d)!\n", i, ret);
+			ipath_verbs_unregister(i);
+			ipath_devices[i] = NULL;
+		}
+	}
+
+	return 0;
+}
+
+void __exit ipath_verbs_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < number_of_devices; i++)
+		if (ipath_devices[i]) {
+			ipath_unregister_ib_device(ipath_devices[i]);
+			ipath_verbs_unregister(i);
+		}
+
+	kfree(ipath_devices);
+}
+
+module_init(ipath_verbs_init);
+module_exit(ipath_verbs_cleanup);
