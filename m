Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWCJAkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWCJAkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWCJAgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17294 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752151AbWCJAfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:48 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 20] ipath - infiniband verbs support
X-Mercurial-Node: 1c88f73c2ac04901805f54f3cf5b577c26e54661
Message-Id: <1c88f73c2ac04901805f.1141950947@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:47 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r f57c24166c57 -r 1c88f73c2ac0 drivers/infiniband/hw/ipath/ipath_verbs.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Mar  9 16:16:58 2006 -0800
@@ -0,0 +1,1195 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <rdma/ib_mad.h>
+#include <rdma/ib_user_verbs.h>
+#include <linux/utsname.h>
+
+#include "ipath_kernel.h"
+#include "ipath_verbs.h"
+#include "ips_common.h"
+
+/* Not static, because we don't want the compiler removing it */
+const char ipath_verbs_version[] = "ipath_verbs " IPATH_IDSTR;
+
+unsigned int ib_ipath_qp_table_size = 251;
+module_param_named(qp_table_size, ib_ipath_qp_table_size, uint, S_IRUGO);
+MODULE_PARM_DESC(qp_table_size, "QP table size");
+
+unsigned int ib_ipath_lkey_table_size = 12;
+module_param_named(lkey_table_size, ib_ipath_lkey_table_size, uint,
+		   S_IRUGO);
+MODULE_PARM_DESC(lkey_table_size,
+		 "LKEY table size in bits (2^n, 1 <= n <= 23)");
+
+unsigned int ib_ipath_debug;	/* debug mask */
+module_param_named(debug, ib_ipath_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(debug, "Verbs debug mask");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("PathScale <support@pathscale.com>");
+MODULE_DESCRIPTION("Pathscale InfiniPath driver");
+
+const int ib_ipath_state_ops[IB_QPS_ERR + 1] = {
+	[IB_QPS_RESET] = 0,
+	[IB_QPS_INIT] = IPATH_POST_RECV_OK,
+	[IB_QPS_RTR] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK,
+	[IB_QPS_RTS] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK |
+	    IPATH_POST_SEND_OK | IPATH_PROCESS_SEND_OK,
+	[IB_QPS_SQD] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK |
+	    IPATH_POST_SEND_OK,
+	[IB_QPS_SQE] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK,
+	[IB_QPS_ERR] = 0,
+};
+
+/*
+ * Translate ib_wr_opcode into ib_wc_opcode.
+ */
+const enum ib_wc_opcode ib_ipath_wc_opcode[] = {
+	[IB_WR_RDMA_WRITE] = IB_WC_RDMA_WRITE,
+	[IB_WR_RDMA_WRITE_WITH_IMM] = IB_WC_RDMA_WRITE,
+	[IB_WR_SEND] = IB_WC_SEND,
+	[IB_WR_SEND_WITH_IMM] = IB_WC_SEND,
+	[IB_WR_RDMA_READ] = IB_WC_RDMA_READ,
+	[IB_WR_ATOMIC_CMP_AND_SWP] = IB_WC_COMP_SWAP,
+	[IB_WR_ATOMIC_FETCH_AND_ADD] = IB_WC_FETCH_ADD
+};
+
+/*
+ * Array of device pointers.
+ */
+static u32 number_of_devices;
+static struct ipath_ibdev **ipath_devices;
+
+/**
+ * ipath_copy_sge - copy data to SGE memory
+ * @ss: the SGE state
+ * @data: the data to copy
+ * @length: the length of the data
+ */
+void ipath_copy_sge(struct ipath_sge_state *ss, void *data, u32 length)
+{
+	struct ipath_sge *sge = &ss->sge;
+
+	while (length) {
+		u32 len = sge->length;
+
+		BUG_ON(len == 0);
+		if (len > length)
+			len = length;
+		memcpy(sge->vaddr, data, len);
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--ss->num_sge)
+				*sge = *ss->sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr =
+				sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length =
+				sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		data += len;
+		length -= len;
+	}
+}
+
+/**
+ * ipath_skip_sge - skip over SGE memory - XXX almost dup of prev func
+ * @ss: the SGE state
+ * @length: the number of bytes to skip
+ */
+void ipath_skip_sge(struct ipath_sge_state *ss, u32 length)
+{
+	struct ipath_sge *sge = &ss->sge;
+
+	while (length > sge->sge_length) {
+		length -= sge->sge_length;
+		ss->sge = *ss->sg_list++;
+	}
+	while (length) {
+		u32 len = sge->length;
+
+		BUG_ON(len == 0);
+		if (len > length)
+			len = length;
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--ss->num_sge)
+				*sge = *ss->sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr =
+				sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length =
+				sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		length -= len;
+	}
+}
+
+/**
+ * ipath_post_send - post a send on a QP
+ * @ibqp: the QP to post the send on
+ * @wr: the list of work requests to post
+ * @bad_wr: the first bad WR is put here
+ *
+ * This may be called from interrupt context.
+ */
+static int ipath_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			   struct ib_send_wr **bad_wr)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	int err = 0;
+
+	/* Check that state is OK to post send. */
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_POST_SEND_OK)) {
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
+	for (; wr; wr = wr->next) {
+		switch (qp->ibqp.qp_type) {
+		case IB_QPT_UC:
+		case IB_QPT_RC:
+			err = ipath_post_rc_send(qp, wr);
+			break;
+
+		case IB_QPT_SMI:
+		case IB_QPT_GSI:
+		case IB_QPT_UD:
+			err = ipath_post_ud_send(qp, wr);
+			break;
+
+		default:
+			err = -EINVAL;
+		}
+		if (err) {
+			*bad_wr = wr;
+			break;
+		}
+	}
+	return err;
+}
+
+/**
+ * ipath_post_receive - post a receive on a QP
+ * @ibqp: the QP to post the receive on
+ * @wr: the WR to post
+ * @bad_wr: the first bad WR is put here
+ *
+ * This may be called from interrupt context.
+ */
+static int ipath_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			      struct ib_recv_wr **bad_wr)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	unsigned long flags;
+
+	/* Check that state is OK to post receive. */
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_POST_RECV_OK)) {
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
+	for (; wr; wr = wr->next) {
+		struct ipath_rwqe *wqe;
+		u32 next;
+		int i, j;
+
+		if (wr->num_sge > qp->r_rq.max_sge) {
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		next = qp->r_rq.head + 1;
+		if (next >= qp->r_rq.size)
+			next = 0;
+		if (next == qp->r_rq.tail) {
+			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		wqe = get_rwqe_ptr(&qp->r_rq, qp->r_rq.head);
+		wqe->wr_id = wr->wr_id;
+		wqe->sg_list[0].mr = NULL;
+		wqe->sg_list[0].vaddr = NULL;
+		wqe->sg_list[0].length = 0;
+		wqe->sg_list[0].sge_length = 0;
+		wqe->length = 0;
+		for (i = 0, j = 0; i < wr->num_sge; i++) {
+			/* Check LKEY */
+			if (to_ipd(qp->ibqp.pd)->user &&
+			    wr->sg_list[i].lkey == 0) {
+				spin_unlock_irqrestore(&qp->r_rq.lock,
+						       flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			if (wr->sg_list[i].length == 0)
+				continue;
+			if (!ipath_lkey_ok(
+				    &to_idev(qp->ibqp.device)->lk_table,
+				    &wqe->sg_list[j], &wr->sg_list[i],
+				    IB_ACCESS_LOCAL_WRITE)) {
+				spin_unlock_irqrestore(&qp->r_rq.lock,
+						       flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			wqe->length += wr->sg_list[i].length;
+			j++;
+		}
+		wqe->num_sge = j;
+		qp->r_rq.head = next;
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+	}
+	return 0;
+}
+
+/**
+ * ipath_qp_rcv - processing an incoming packet on a QP
+ * @dev: the device the packet came on
+ * @hdr: the packet header
+ * @has_grh: true if the packet has a GRH
+ * @data: the packet data
+ * @tlen: the packet length
+ * @qp: the QP the packet came on
+ *
+ * This is called from ipath_ib_rcv() to process an incoming packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+static inline void ipath_qp_rcv(struct ipath_ibdev *dev,
+				struct ipath_ib_header *hdr, int has_grh,
+				void *data, u32 tlen, struct ipath_qp *qp)
+{
+	/* Check for valid receive state. */
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_PROCESS_RECV_OK)) {
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
+/**
+ * ipath_ib_rcv - process and incoming packet
+ * @t: the device number
+ * @rhdr: the header of the packet
+ * @data: the packet data
+ * @tlen: the packet length
+ *
+ * This is called from ipath_kreceive() to process an incoming packet at
+ * interrupt level. Tlen is the length of the header + data + CRC in bytes.
+ */
+static void ipath_ib_rcv(int t, void *rhdr, void *data, u32 tlen)
+{
+	struct ipath_ibdev *dev = ipath_devices[t];
+	struct ipath_ib_header *hdr = rhdr;
+	struct ipath_other_headers *ohdr;
+	struct ipath_qp *qp;
+	u32 qp_num;
+	int lnh;
+	u8 opcode;
+	u16 lid;
+
+	if (unlikely(dev == NULL))
+		return;
+
+	if (unlikely(tlen < 24)) {	/* LRH+BTH+CRC */
+		dev->rcv_errors++;
+		return;
+	}
+
+	/* Check for a valid destination LID (see ch. 7.11.1). */
+	lid = be16_to_cpu(hdr->lrh[1]);
+	if (lid < IPS_MULTICAST_LID_BASE) {
+		lid &= ~((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
+		if (unlikely(lid != ipath_layer_get_lid(dev->dd))) {
+			dev->rcv_errors++;
+			return;
+		}
+	}
+
+	/* Check for GRH */
+	lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+	if (lnh == IPS_LRH_BTH)
+		ohdr = &hdr->u.oth;
+	else if (lnh == IPS_LRH_GRH)
+		ohdr = &hdr->u.l.oth;
+	else {
+		dev->rcv_errors++;
+		return;
+	}
+
+	opcode = be32_to_cpu(ohdr->bth[0]) >> 24;
+	dev->opstats[opcode].n_bytes += tlen;
+	dev->opstats[opcode].n_packets++;
+
+	/* Get the destination QP number. */
+	qp_num = be32_to_cpu(ohdr->bth[1]) & IPS_QPN_MASK;
+	if (qp_num == IPS_MULTICAST_QPN) {
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
+			ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data,
+				     tlen, p->qp);
+		/*
+		 * Notify ipath_multicast_detach() if it is waiting for us
+		 * to finish.
+		 */
+		if (atomic_dec_return(&mcast->refcount) <= 1)
+			wake_up(&mcast->wait);
+	} else {
+		qp = ipath_lookup_qpn(&dev->qp_table, qp_num);
+		if (qp) {
+			dev->n_unicast_rcv++;
+			ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data,
+				     tlen, qp);
+			/*
+			 * Notify ipath_destroy_qp() if it is waiting
+			 * for us to finish.
+			 */
+			if (atomic_dec_and_test(&qp->refcount))
+				wake_up(&qp->wait);
+		} else
+			dev->n_pkt_drops++;
+	}
+}
+
+/**
+ * ipath_ib_timer - verbs timer
+ * @t: the device number
+ *
+ * This is called from ipath_do_rcv_timer() at interrupt level to check for
+ * QPs which need retransmits and to collect performance numbers.
+ */
+static void ipath_ib_timer(int t)
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
+				qp->timerwait.prev =
+					(struct list_head *) rnr;
+				rnr = qp;
+				if (list_empty(last))
+					break;
+				qp = list_entry(last->next, struct ipath_qp,
+						timerwait);
+			} while (qp->s_rnr_timeout == 0);
+		}
+	}
+	/*
+	 * We should only be in the started state if pma_sample_start != 0
+	 */
+	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_STARTED &&
+	    --dev->pma_sample_start == 0) {
+		dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_RUNNING;
+		ipath_layer_snapshot_counters(dev->dd, &dev->ipath_sword,
+					      &dev->ipath_rword,
+					      &dev->ipath_spkts,
+					      &dev->ipath_rpkts,
+					      &dev->ipath_xmit_wait);
+	}
+	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_RUNNING) {
+		if (dev->pma_sample_interval == 0) {
+			u64 ta, tb, tc, td, te;
+
+			dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_DONE;
+			ipath_layer_snapshot_counters(dev->dd, &ta, &tb,
+						      &tc, &td, &te);
+
+			dev->ipath_sword = ta - dev->ipath_sword;
+			dev->ipath_rword = tb - dev->ipath_rword;
+			dev->ipath_spkts = tc - dev->ipath_spkts;
+			dev->ipath_rpkts = td - dev->ipath_rpkts;
+			dev->ipath_xmit_wait = te - dev->ipath_xmit_wait;
+		}
+		else
+			dev->pma_sample_interval--;
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
+	     qp = (struct ipath_qp *) qp->timerwait.prev)
+		tasklet_hi_schedule(&qp->s_task);
+}
+
+/**
+ * ipath_ib_piobufavail - callback when a PIO buffer is available
+ * @t: the device number
+ *
+ * This is called from ipath_intr() at interrupt level when a PIO buffer is
+ * available after ipath_verbs_send() returned an error that no buffers were
+ * available.  Return 0 if we consumed all the PIO buffers and we still have
+ * QPs waiting for buffers (for now, just do a tasklet_hi_schedule and
+ * return one).
+ */
+static int ipath_ib_piobufavail(int t)
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
+		qp = list_entry(dev->piowait.next, struct ipath_qp,
+				piowait);
+		list_del(&qp->piowait);
+		tasklet_hi_schedule(&qp->s_task);
+	}
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	return 1;
+}
+
+static int ipath_query_device(struct ib_device *ibdev,
+			      struct ib_device_attr *props)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	u32 vendor, boardrev, majrev, minrev;
+
+	memset(props, 0, sizeof(*props));
+
+	props->device_cap_flags = IB_DEVICE_BAD_PKEY_CNTR |
+		IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
+		IB_DEVICE_SYS_IMAGE_GUID;
+	ipath_layer_query_device(dev->dd, &vendor, &boardrev,
+				 &majrev, &minrev);
+	props->vendor_id = vendor;
+	props->vendor_part_id = boardrev;
+	props->hw_ver = boardrev << 16 | majrev << 8 | minrev;
+
+	props->sys_image_guid = dev->sys_image_guid;
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
+	props->max_pkeys = ipath_layer_get_npkeys(dev->dd);
+	props->max_mcast_grp = 0xffff;
+	props->max_mcast_qp_attach = 0xffff;
+	props->max_total_mcast_qp_attach = props->max_mcast_qp_attach *
+		props->max_mcast_grp;
+
+	return 0;
+}
+
+const u8 ipath_cvt_physportstate[16] = {
+	[INFINIPATH_IBCS_LT_STATE_DISABLED] = 3,
+	[INFINIPATH_IBCS_LT_STATE_LINKUP] = 5,
+	[INFINIPATH_IBCS_LT_STATE_POLLACTIVE] = 2,
+	[INFINIPATH_IBCS_LT_STATE_POLLQUIET] = 2,
+	[INFINIPATH_IBCS_LT_STATE_SLEEPDELAY] = 1,
+	[INFINIPATH_IBCS_LT_STATE_SLEEPQUIET] = 1,
+	[INFINIPATH_IBCS_LT_STATE_CFGDEBOUNCE] = 4,
+	[INFINIPATH_IBCS_LT_STATE_CFGRCVFCFG] = 4,
+	[INFINIPATH_IBCS_LT_STATE_CFGWAITRMT] = 4,
+	[INFINIPATH_IBCS_LT_STATE_CFGIDLE] = 4,
+	[INFINIPATH_IBCS_LT_STATE_RECOVERRETRAIN] = 6,
+	[INFINIPATH_IBCS_LT_STATE_RECOVERWAITRMT] = 6,
+	[INFINIPATH_IBCS_LT_STATE_RECOVERIDLE] = 6,
+};
+
+static int ipath_query_port(struct ib_device *ibdev,
+			    u8 port, struct ib_port_attr *props)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	enum ib_mtu mtu;
+	u16 lid = ipath_layer_get_lid(dev->dd);
+	u64 ibcstat;
+
+	memset(props, 0, sizeof(*props));
+	props->lid = lid ? lid : IB_LID_PERMISSIVE;
+	props->lmc = dev->mkeyprot_resv_lmc & 7;
+	props->sm_lid = dev->sm_lid;
+	props->sm_sl = dev->sm_sl;
+	ibcstat = ipath_layer_get_lastibcstat(dev->dd);
+	props->state = ((ibcstat >> 4) & 0x3) + 1;
+	/* See phys_state_show() */
+	props->phys_state = ipath_cvt_physportstate[
+		ipath_layer_get_lastibcstat(dev->dd) & 0xf];
+	props->port_cap_flags = dev->port_cap_flags;
+	props->gid_tbl_len = 1;
+	props->max_msg_sz = 4096;
+	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->dd);
+	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->dd) -
+		dev->n_pkey_violations;
+	props->qkey_viol_cntr = dev->qkey_violations;
+	props->active_width = IB_WIDTH_4X;
+	/* See rate_show() */
+	props->active_speed = 1;	/* Regular 10Mbs speed. */
+	props->max_vl_num = 1;		/* VLCap = VL0 */
+	props->init_type_reply = 0;
+
+	props->max_mtu = IB_MTU_4096;
+	switch (ipath_layer_get_ibmtu(dev->dd)) {
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
+	if (device_modify_mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
+				   IB_DEVICE_MODIFY_NODE_DESC))
+		return -EOPNOTSUPP;
+
+	if (device_modify_mask & IB_DEVICE_MODIFY_NODE_DESC)
+		memcpy(device->node_desc, device_modify->node_desc, 64);
+
+	if (device_modify_mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID)
+		to_idev(device)->sys_image_guid =
+			device_modify->sys_image_guid;
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
+		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKDOWN);
+	if (port_modify_mask & IB_PORT_RESET_QKEY_CNTR)
+		dev->qkey_violations = 0;
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
+	gid->global.interface_id = ipath_layer_get_guid(dev->dd);
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
+/**
+ * ipath_create_ah - create an address handle
+ * @pd: the protection domain
+ * @ah_attr: the attributes of the AH
+ *
+ * This may be called from interrupt context.
+ */
+static struct ib_ah *ipath_create_ah(struct ib_pd *pd,
+				     struct ib_ah_attr *ah_attr)
+{
+	struct ipath_ah *ah;
+
+	/* A multicast address requires a GRH (see ch. 8.4.1). */
+	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
+	    ah_attr->dlid != IPS_PERMISSIVE_LID &&
+	    !(ah_attr->ah_flags & IB_AH_GRH))
+		return ERR_PTR(-EINVAL);
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
+/**
+ * ipath_destroy_ah - destroy an address handle
+ * @ibah: the AH to destroy
+ *
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
+static int ipath_query_ah(struct ib_ah *ibah, struct ib_ah_attr *ah_attr)
+{
+	struct ipath_ah *ah = to_iah(ibah);
+
+	*ah_attr = ah->attr;
+
+	return 0;
+}
+
+static int ipath_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
+			    u16 *pkey)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	if (index >= ipath_layer_get_npkeys(dev->dd))
+		return -EINVAL;
+	*pkey = ipath_layer_get_pkey(dev->dd, index);
+	return 0;
+}
+
+
+/**
+ * ipath_alloc_ucontext - allocate a ucontest
+ * @ibdev: the infiniband device
+ * @udata: not used by the InfiniPath driver
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
+static int ipath_verbs_register_sysfs(struct ib_device *dev);
+
+/**
+ * ipath_register_ib_device - register our device with the infiniband core
+ * @t: the device number to register
+ * @dd: the device data structure
+ */
+static int ipath_register_ib_device(int t, struct ipath_devdata *dd)
+{
+	struct ipath_ibdev *idev;
+	struct ib_device *dev;
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
+	/* Set the prefix to the default value (see ch. 4.1.1) */
+	idev->gid_prefix = __constant_cpu_to_be64(0xfe80000000000000ULL);
+
+	ret = ipath_init_qp_table(idev, ib_ipath_qp_table_size);
+	if (ret)
+		goto err_qp;
+
+	/*
+	 * The top ib_ipath_lkey_table_size bits are used to index the
+	 * table.  The lower 8 bits can be owned by the user (copied from
+	 * the LKEY).  The remaining bits act as a generation number or tag.
+	 */
+	idev->lk_table.max = 1 << ib_ipath_lkey_table_size;
+	idev->lk_table.table = kzalloc(idev->lk_table.max *
+				       sizeof(*idev->lk_table.table),
+				       GFP_KERNEL);
+	if (idev->lk_table.table == NULL) {
+		ret = -ENOMEM;
+		goto err_lk;
+	}
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
+	idev->link_width_enabled = 3;	/* 1x or 4x */
+
+	/*
+	 * The system image GUID is supposed to be the same for all
+	 * IB HCAs in a single system.
+	 * Note that this code assumes device zero is found first.
+	 */
+	idev->sys_image_guid = t
+		? ipath_devices[t]->sys_image_guid
+		: ipath_layer_get_guid(dd);
+	idev->ib_unit = t;
+	idev->dd = dd;
+
+	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
+	dev->node_guid = ipath_layer_get_guid(dd);
+	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
+	dev->uverbs_cmd_mask =
+		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
+		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
+		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_AH)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_AH)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_AH)		|
+		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
+		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_RESIZE_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_POLL_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)	|
+		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_POST_SEND)		|
+		(1ull << IB_USER_VERBS_CMD_POST_RECV)		|
+		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
+		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
+		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
+		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
+	dev->node_type = RDMA_NODE_IB_CA;
+	dev->phys_port_cnt = 1;
+	dev->dma_device = ipath_layer_get_device(dd);
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
+	dev->query_ah = ipath_query_ah;
+	dev->create_srq = ipath_create_srq;
+	dev->modify_srq = ipath_modify_srq;
+	dev->query_srq = ipath_query_srq;
+	dev->destroy_srq = ipath_destroy_srq;
+	dev->create_qp = ipath_create_qp;
+	dev->modify_qp = ipath_modify_qp;
+	dev->query_qp = ipath_query_qp;
+	dev->destroy_qp = ipath_destroy_qp;
+	dev->post_send = ipath_post_send;
+	dev->post_recv = ipath_post_receive;
+	dev->post_srq_recv = ipath_post_srq_receive;
+	dev->create_cq = ipath_create_cq;
+	dev->destroy_cq = ipath_destroy_cq;
+	dev->resize_cq = ipath_resize_cq;
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
+	snprintf(dev->node_desc, sizeof(dev->node_desc),
+		 IPATH_IDSTR " %s kernel_SMA", system_utsname.nodename);
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
+	if (ipath_verbs_register_sysfs(dev))
+		goto err_class;
+
+	ipath_layer_enable_timer(dd);
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
+	ipath_layer_disable_timer(dev->dd);
+
+	ib_unregister_device(ibdev);
+
+	if (!list_empty(&dev->pending[0]) ||
+	    !list_empty(&dev->pending[1]) ||
+	    !list_empty(&dev->pending[2]))
+		_VERBS_ERROR("ipath%d pending list not empty!\n",
+			     dev->ib_unit);
+	if (!list_empty(&dev->piowait))
+		_VERBS_ERROR("ipath%d piowait list not empty!\n",
+			     dev->ib_unit);
+	if (!list_empty(&dev->rnrwait))
+		_VERBS_ERROR("ipath%d rnrwait list not empty!\n",
+			     dev->ib_unit);
+	if (!ipath_mcast_tree_empty())
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
+		struct ipath_devdata *dd;
+		int ret = ipath_verbs_register(i, ipath_ib_piobufavail,
+					       ipath_ib_rcv, ipath_ib_timer,
+					       &dd);
+
+		if (ret < 0) {
+			_VERBS_ERROR("ib_ipath%d cannot register "
+				     "verbs (%d)!\n", i, -ret);
+			ipath_devices[i] = NULL;
+		} else {
+			ret = ipath_register_ib_device(i, dd);
+			if (ret) {
+				_VERBS_ERROR("ib_ipath%d cannot register "
+					     "ib device (%d)!\n", i, ret);
+				ipath_verbs_unregister(dd);
+				ipath_devices[i] = NULL;
+			}
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
+			struct ipath_devdata *dd = ipath_devices[i]->dd;
+			ipath_unregister_ib_device(ipath_devices[i]);
+			ipath_verbs_unregister(dd);
+		}
+
+	kfree(ipath_devices);
+}
+
+static ssize_t show_rev(struct class_device *cdev, char *buf)
+{
+        struct ipath_ibdev *dev =
+                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+        int vendor, boardrev, majrev, minrev;
+
+        ipath_layer_query_device(dev->dd, &vendor, &boardrev,
+                                 &majrev, &minrev);
+        return sprintf(buf, "%d.%d\n", majrev, minrev);
+}
+
+static ssize_t show_hca(struct class_device *cdev, char *buf)
+{
+        struct ipath_ibdev *dev =
+                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+        int ret;
+
+        ret = ipath_layer_get_boardname(dev->dd, buf, 128);
+        if (ret < 0)
+                return ret;
+        strcat(buf, "\n");
+        return strlen(buf);
+}
+
+static ssize_t show_stats(struct class_device *cdev, char *buf)
+{
+        struct ipath_ibdev *dev =
+                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+        int i;
+        int len;
+
+        len = sprintf(buf,
+                      "RC resends  %d\n"
+                      "RC QACKs    %d\n"
+                      "RC ACKs     %d\n"
+                      "RC SEQ NAKs %d\n"
+                      "RC RDMA seq %d\n"
+                      "RC RNR NAKs %d\n"
+                      "RC OTH NAKs %d\n"
+                      "RC timeouts %d\n"
+                      "RC RDMA dup %d\n"
+                      "piobuf wait %d\n"
+                      "no piobuf   %d\n"
+                      "PKT drops   %d\n"
+                      "WQE errs    %d\n",
+                      dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
+                      dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
+                      dev->n_other_naks, dev->n_timeouts,
+                      dev->n_rdma_dup_busy, dev->n_piowait,
+                      dev->n_no_piobuf, dev->n_pkt_drops, dev->n_wqe_errs);
+        for (i = 0; i < ARRAY_SIZE(dev->opstats); i++) {
+                if (!dev->opstats[i].n_packets && !dev->opstats[i].n_bytes)
+                        continue;
+                len += sprintf(buf + len, "%02x %llu/%llu\n",
+                               i, dev->opstats[i].n_packets,
+                               dev->opstats[i].n_bytes);
+        }
+        return len;
+}
+
+static CLASS_DEVICE_ATTR(hw_rev, S_IRUGO, show_rev, NULL);
+static CLASS_DEVICE_ATTR(hca_type, S_IRUGO, show_hca, NULL);
+static CLASS_DEVICE_ATTR(board_id, S_IRUGO, show_hca, NULL);
+static CLASS_DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
+
+static struct class_device_attribute *ipath_class_attributes[] = {
+        &class_device_attr_hw_rev,
+        &class_device_attr_hca_type,
+        &class_device_attr_board_id,
+        &class_device_attr_stats
+};
+
+static int ipath_verbs_register_sysfs(struct ib_device *dev)
+{
+        int i;
+
+        for (i = 0; i < ARRAY_SIZE(ipath_class_attributes); ++i)
+                if (class_device_create_file(&dev->class_dev,
+                                             ipath_class_attributes[i]))
+                        return 1;
+
+        return 0;
+}
+
+module_init(ipath_verbs_init);
+module_exit(ipath_verbs_cleanup);
diff -r f57c24166c57 -r 1c88f73c2ac0 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Mar  9 16:16:58 2006 -0800
@@ -0,0 +1,311 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/list.h>
+#include <linux/rcupdate.h>
+
+#include "ipath_verbs.h"
+
+/*
+ * Global table of GID to attached QPs.
+ * The table is global to all ipath devices since a send from one QP/device
+ * needs to be locally routed to any locally attached QPs on the same
+ * or different device.
+ */
+static struct rb_root mcast_tree;
+static DEFINE_SPINLOCK(mcast_lock);
+
+/**
+ * ipath_mcast_qp_alloc - alloc a struct to link a QP to the mcast GID struct
+ * @qp: the QP to link
+ */
+static struct ipath_mcast_qp *ipath_mcast_qp_alloc(struct ipath_qp *qp)
+{
+	struct ipath_mcast_qp *mqp;
+
+	mqp = kmalloc(sizeof *mqp, GFP_KERNEL);
+	if (!mqp)
+		return NULL;
+
+	mqp->qp = qp;
+	atomic_inc(&qp->refcount);
+
+	return mqp;
+}
+
+static void ipath_mcast_qp_free(struct ipath_mcast_qp *mqp)
+{
+	struct ipath_qp *qp = mqp->qp;
+
+	/* Notify ipath_destroy_qp() if it is waiting. */
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+
+	kfree(mqp);
+}
+
+/**
+ * ipath_mcast_alloc - allocate the multicast GID structure
+ * @mgid: the multicast GID
+ *
+ * A list of QPs will be attached to this structure.
+ */
+static struct ipath_mcast *ipath_mcast_alloc(union ib_gid *mgid)
+{
+	struct ipath_mcast *mcast;
+
+	mcast = kmalloc(sizeof *mcast, GFP_KERNEL);
+	if (!mcast)
+		return NULL;
+
+	mcast->mgid = *mgid;
+	INIT_LIST_HEAD(&mcast->qp_list);
+	init_waitqueue_head(&mcast->wait);
+	atomic_set(&mcast->refcount, 0);
+
+	return mcast;
+}
+
+static void ipath_mcast_free(struct ipath_mcast *mcast)
+{
+	struct ipath_mcast_qp *p, *tmp;
+
+	list_for_each_entry_safe(p, tmp, &mcast->qp_list, list)
+		ipath_mcast_qp_free(p);
+
+	kfree(mcast);
+}
+
+/**
+ * ipath_mcast_find - search the global table for the given multicast GID
+ * @mgid: the multicast GID to search for
+ *
+ * Returns NULL if not found.
+ *
+ * The caller is responsible for decrementing the reference count if found.
+ */
+struct ipath_mcast *ipath_mcast_find(union ib_gid *mgid)
+{
+	struct rb_node *n;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcast_lock, flags);
+	n = mcast_tree.rb_node;
+	while (n) {
+		struct ipath_mcast *mcast;
+		int ret;
+
+		mcast = rb_entry(n, struct ipath_mcast, rb_node);
+
+		ret = memcmp(mgid->raw, mcast->mgid.raw,
+			     sizeof(union ib_gid));
+		if (ret < 0)
+			n = n->rb_left;
+		else if (ret > 0)
+			n = n->rb_right;
+		else {
+			atomic_inc(&mcast->refcount);
+			spin_unlock_irqrestore(&mcast_lock, flags);
+			return mcast;
+		}
+	}
+	spin_unlock_irqrestore(&mcast_lock, flags);
+
+	return NULL;
+}
+
+/**
+ * ipath_mcast_add - insert the mcast GID into the table and attach QP struct
+ * @mcast: the mcast GID table
+ * @mqp: the QP to attach
+ *
+ * Return zero if both were added.  Return EEXIST if the GID was already in
+ * the table but the QP was added.  Return ESRCH if the QP was already
+ * attached and neither structure was added.
+ */
+static int ipath_mcast_add(struct ipath_mcast *mcast,
+			   struct ipath_mcast_qp *mqp)
+{
+	struct rb_node **n = &mcast_tree.rb_node;
+	struct rb_node *pn = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcast_lock, flags);
+
+	while (*n) {
+		struct ipath_mcast *tmcast;
+		struct ipath_mcast_qp *p;
+		int ret;
+
+		pn = *n;
+		tmcast = rb_entry(pn, struct ipath_mcast, rb_node);
+
+		ret = memcmp(mcast->mgid.raw, tmcast->mgid.raw,
+			     sizeof(union ib_gid));
+		if (ret < 0) {
+			n = &pn->rb_left;
+			continue;
+		}
+		if (ret > 0) {
+			n = &pn->rb_right;
+			continue;
+		}
+
+		/* Search the QP list to see if this is already there. */
+		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
+			if (p->qp == mqp->qp) {
+				spin_unlock_irqrestore(&mcast_lock, flags);
+				return ESRCH;
+			}
+		}
+		list_add_tail_rcu(&mqp->list, &tmcast->qp_list);
+		spin_unlock_irqrestore(&mcast_lock, flags);
+		return EEXIST;
+	}
+
+	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
+
+	atomic_inc(&mcast->refcount);
+	rb_link_node(&mcast->rb_node, pn, n);
+	rb_insert_color(&mcast->rb_node, &mcast_tree);
+
+	spin_unlock_irqrestore(&mcast_lock, flags);
+
+	return 0;
+}
+
+int ipath_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_mcast *mcast;
+	struct ipath_mcast_qp *mqp;
+
+	/*
+	 * Allocate data structures since its better to do this outside of
+	 * spin locks and it will most likely be needed.
+	 */
+	mcast = ipath_mcast_alloc(gid);
+	if (mcast == NULL)
+		return -ENOMEM;
+	mqp = ipath_mcast_qp_alloc(qp);
+	if (mqp == NULL) {
+		ipath_mcast_free(mcast);
+		return -ENOMEM;
+	}
+	switch (ipath_mcast_add(mcast, mqp)) {
+	case ESRCH:
+		/* Neither was used: can't attach the same QP twice. */
+		ipath_mcast_qp_free(mqp);
+		ipath_mcast_free(mcast);
+		return -EINVAL;
+	case EEXIST:		/* The mcast wasn't used */
+		ipath_mcast_free(mcast);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+int ipath_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_mcast *mcast = NULL;
+	struct ipath_mcast_qp *p, *tmp;
+	struct rb_node *n;
+	unsigned long flags;
+	int last = 0;
+
+	spin_lock_irqsave(&mcast_lock, flags);
+
+	/* Find the GID in the mcast table. */
+	n = mcast_tree.rb_node;
+	while (1) {
+		int ret;
+
+		if (n == NULL) {
+			spin_unlock_irqrestore(&mcast_lock, flags);
+			return 0;
+		}
+
+		mcast = rb_entry(n, struct ipath_mcast, rb_node);
+		ret = memcmp(gid->raw, mcast->mgid.raw,
+			     sizeof(union ib_gid));
+		if (ret < 0)
+			n = n->rb_left;
+		else if (ret > 0)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	/* Search the QP list. */
+	list_for_each_entry_safe(p, tmp, &mcast->qp_list, list) {
+		if (p->qp != qp)
+			continue;
+		/*
+		 * We found it, so remove it, but don't poison the forward
+		 * link until we are sure there are no list walkers.
+		 */
+		list_del_rcu(&p->list);
+
+		/* If this was the last attached QP, remove the GID too. */
+		if (list_empty(&mcast->qp_list)) {
+			rb_erase(&mcast->rb_node, &mcast_tree);
+			last = 1;
+		}
+		break;
+	}
+
+	spin_unlock_irqrestore(&mcast_lock, flags);
+
+	if (p) {
+		/*
+		 * Wait for any list walkers to finish before freeing the
+		 * list element.
+		 */
+		wait_event(mcast->wait, atomic_read(&mcast->refcount) <= 1);
+		ipath_mcast_qp_free(p);
+	}
+	if (last) {
+		atomic_dec(&mcast->refcount);
+		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
+		ipath_mcast_free(mcast);
+	}
+
+	return 0;
+}
+
+int ipath_mcast_tree_empty(void)
+{
+	return mcast_tree.rb_node == NULL;
+}
