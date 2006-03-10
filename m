Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWCJAlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWCJAlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCJAgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:24 -0500
Received: from mx.pathscale.com ([64.160.42.68]:15246 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752157AbWCJAfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:51 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 20] ipath - infiniband UC and UD protocol support
X-Mercurial-Node: e6b07a6f5a6410e2d1770d0467b8abbf163587a4
Message-Id: <e6b07a6f5a6410e2d177.1141950943@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:43 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 3d2a9e8f845c -r e6b07a6f5a64 drivers/infiniband/hw/ipath/ipath_uc.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Mar  9 16:16:31 2006 -0800
@@ -0,0 +1,625 @@
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
+#include "ipath_verbs.h"
+#include "ips_common.h"
+
+/**
+ * ipath_do_uc_send - do a send on a UC queue
+ * @data: contains a pointer to the QP to send on
+ *
+ * Process entries in the send work queue until the queue is exhausted.
+ * Only allow one CPU to send a packet per QP (tasklet).
+ * Otherwise, after we drop the QP lock, two threads could send
+ * packets out of order.
+ * This is similar to ipath_do_rc_send() below except we don't have
+ * timeouts or resends.
+ */
+void ipath_do_uc_send(unsigned long data)
+{
+	struct ipath_qp *qp = (struct ipath_qp *)data;
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ipath_swqe *wqe;
+	unsigned long flags;
+	u16 lrh0;
+	u32 hwords;
+	u32 nwords;
+	u32 extra_bytes;
+	u32 bth0;
+	u32 bth2;
+	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
+	u32 len;
+	struct ipath_other_headers *ohdr;
+	struct ib_wc wc;
+
+	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
+		return;
+
+	if (unlikely(qp->remote_ah_attr.dlid ==
+		     ipath_layer_get_lid(dev->dd))) {
+		/* Pass in an uninitialized ib_wc to save stack space. */
+		ipath_ruc_loopback(qp, &wc);
+		clear_bit(IPATH_S_BUSY, &qp->s_flags);
+		return;
+	}
+
+	ohdr = &qp->s_hdr.u.oth;
+	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
+		ohdr = &qp->s_hdr.u.l.oth;
+
+again:
+	/* Check for a constructed packet to be sent. */
+	if (qp->s_hdrwords != 0) {
+			/*
+			 * If no PIO bufs are available, return.
+			 * An interrupt will call ipath_ib_piobufavail()
+			 * when one is available.
+			 */
+			if (ipath_verbs_send(dev->dd, qp->s_hdrwords,
+					     (u32 *) &qp->s_hdr,
+					     qp->s_cur_size,
+					     qp->s_cur_sge)) {
+				ipath_no_bufs_available(qp, dev);
+				return;
+			}
+			dev->n_unicast_xmit++;
+		/* Record that we sent the packet and s_hdr is empty. */
+		qp->s_hdrwords = 0;
+	}
+
+	lrh0 = IPS_LRH_BTH;
+	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+	hwords = 5;
+
+	/*
+	 * The lock is needed to synchronize between
+	 * setting qp->s_ack_state and post_send().
+	 */
+	spin_lock_irqsave(&qp->s_lock, flags);
+
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
+		goto done;
+
+	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+
+	/* Send a request. */
+	wqe = get_swqe_ptr(qp, qp->s_last);
+	switch (qp->s_state) {
+	default:
+		/*
+		 * Signal the completion of the last send (if there is
+		 * one).
+		 */
+		if (qp->s_last != qp->s_tail) {
+			if (++qp->s_last == qp->s_size)
+				qp->s_last = 0;
+			if (!test_bit(IPATH_S_SIGNAL_REQ_WR,
+				      &qp->s_flags) ||
+			    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
+				wc.wr_id = wqe->wr.wr_id;
+				wc.status = IB_WC_SUCCESS;
+				wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+				wc.vendor_err = 0;
+				wc.byte_len = wqe->length;
+				wc.qp_num = qp->ibqp.qp_num;
+				wc.src_qp = qp->remote_qpn;
+				wc.pkey_index = 0;
+				wc.slid = qp->remote_ah_attr.dlid;
+				wc.sl = qp->remote_ah_attr.sl;
+				wc.dlid_path_bits = 0;
+				wc.port_num = 0;
+				ipath_cq_enter(to_icq(qp->ibqp.send_cq),
+					       &wc, 0);
+			}
+			wqe = get_swqe_ptr(qp, qp->s_last);
+		}
+		/* Check if send work queue is empty. */
+		if (qp->s_tail == qp->s_head)
+			goto done;
+		/*
+		 * Start a new request.
+		 */
+		qp->s_psn = wqe->psn = qp->s_next_psn;
+		qp->s_sge.sge = wqe->sg_list[0];
+		qp->s_sge.sg_list = wqe->sg_list + 1;
+		qp->s_sge.num_sge = wqe->wr.num_sge;
+		qp->s_len = len = wqe->length;
+		switch (wqe->wr.opcode) {
+		case IB_WR_SEND:
+		case IB_WR_SEND_WITH_IMM:
+			if (len > pmtu) {
+				qp->s_state = IB_OPCODE_UC_SEND_FIRST;
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_SEND)
+				qp->s_state = IB_OPCODE_UC_SEND_ONLY;
+			else {
+				qp->s_state =
+					IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE;
+				/* Immediate data comes after the BTH */
+				ohdr->u.imm_data = wqe->wr.imm_data;
+				hwords += 1;
+			}
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= 1 << 23;
+			break;
+
+		case IB_WR_RDMA_WRITE:
+		case IB_WR_RDMA_WRITE_WITH_IMM:
+			ohdr->u.rc.reth.vaddr =
+				cpu_to_be64(wqe->wr.wr.rdma.remote_addr);
+			ohdr->u.rc.reth.rkey =
+				cpu_to_be32(wqe->wr.wr.rdma.rkey);
+			ohdr->u.rc.reth.length = cpu_to_be32(len);
+			hwords += sizeof(struct ib_reth) / 4;
+			if (len > pmtu) {
+				qp->s_state = IB_OPCODE_UC_RDMA_WRITE_FIRST;
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_RDMA_WRITE)
+				qp->s_state = IB_OPCODE_UC_RDMA_WRITE_ONLY;
+			else {
+				qp->s_state =
+					IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE;
+				/* Immediate data comes after the RETH */
+				ohdr->u.rc.imm_data = wqe->wr.imm_data;
+				hwords += 1;
+				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+					bth0 |= 1 << 23;
+			}
+			break;
+
+		default:
+			goto done;
+		}
+		if (++qp->s_tail >= qp->s_size)
+			qp->s_tail = 0;
+		break;
+
+	case IB_OPCODE_UC_SEND_FIRST:
+		qp->s_state = IB_OPCODE_UC_SEND_MIDDLE;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_SEND_MIDDLE:
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_SEND)
+			qp->s_state = IB_OPCODE_UC_SEND_LAST;
+		else {
+			qp->s_state = IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE;
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.imm_data;
+			hwords += 1;
+		}
+		if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+			bth0 |= 1 << 23;
+		break;
+
+	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+		qp->s_state = IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_RDMA_WRITE)
+			qp->s_state = IB_OPCODE_UC_RDMA_WRITE_LAST;
+		else {
+			qp->s_state =
+				IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE;
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.imm_data;
+			hwords += 1;
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= 1 << 23;
+		}
+		break;
+	}
+	bth2 = qp->s_next_psn++ & IPS_PSN_MASK;
+	qp->s_len -= len;
+	bth0 |= qp->s_state << 24;
+
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	/* Construct the header. */
+	extra_bytes = (4 - len) & 3;
+	nwords = (len + extra_bytes) >> 2;
+	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
+		/* Header size in 32-bit words. */
+		hwords += 10;
+		lrh0 = IPS_LRH_GRH;
+		qp->s_hdr.u.l.grh.version_tclass_flow =
+			cpu_to_be32((6 << 28) |
+				    (qp->remote_ah_attr.grh.traffic_class
+				     << 20) |
+				    qp->remote_ah_attr.grh.flow_label);
+		qp->s_hdr.u.l.grh.paylen =
+			cpu_to_be16(((hwords - 12) + nwords +
+				     SIZE_OF_CRC) << 2);
+		/* next_hdr is defined by C8-7 in ch. 8.4.1 */
+		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
+		qp->s_hdr.u.l.grh.hop_limit =
+			qp->remote_ah_attr.grh.hop_limit;
+		/* The SGID is 32-bit aligned. */
+		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix =
+			dev->gid_prefix;
+		qp->s_hdr.u.l.grh.sgid.global.interface_id =
+			ipath_layer_get_guid(dev->dd);
+		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
+	}
+	qp->s_hdrwords = hwords;
+	qp->s_cur_sge = &qp->s_sge;
+	qp->s_cur_size = len;
+	lrh0 |= qp->remote_ah_attr.sl << 4;
+	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
+	/* DEST LID */
+	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
+	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
+	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
+	bth0 |= extra_bytes << 20;
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
+	ohdr->bth[2] = cpu_to_be32(bth2);
+
+	/* Check for more work to do. */
+	goto again;
+
+done:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	clear_bit(IPATH_S_BUSY, &qp->s_flags);
+}
+
+/**
+ * ipath_uc_rcv - handle an incoming UC packet
+ * @dev: the device the packet came in on
+ * @hdr: the header of the packet
+ * @has_grh: true if the packet has a GRH
+ * @data: the packet data
+ * @tlen: the length of the packet
+ * @qp: the QP for this packet.
+ *
+ * This is called from ipath_qp_rcv() to process an incoming UC packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+void ipath_uc_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
+		  int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
+{
+	struct ipath_other_headers *ohdr;
+	int opcode;
+	u32 hdrsize;
+	u32 psn;
+	u32 pad;
+	unsigned long flags;
+	struct ib_wc wc;
+	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
+	struct ib_reth *reth;
+
+	/* Check for GRH */
+	if (!has_grh) {
+		ohdr = &hdr->u.oth;
+		hdrsize = 8 + 12;	/* LRH + BTH */
+		psn = be32_to_cpu(ohdr->bth[2]);
+	} else {
+		ohdr = &hdr->u.l.oth;
+		hdrsize = 8 + 40 + 12;	/* LRH + GRH + BTH */
+		/*
+		 * The header with GRH is 60 bytes and the
+		 * core driver sets the eager header buffer
+		 * size to 56 bytes so the last 4 bytes of
+		 * the BTH header (PSN) is in the data buffer.
+		 */
+		psn = be32_to_cpu(((u32 *) data)[0]);
+		data += sizeof(u32);
+	}
+	/*
+	 * The opcode is in the low byte when its in network order
+	 * (top byte when in host order).
+	 */
+	opcode = be32_to_cpu(ohdr->bth[0]) >> 24;
+
+	wc.imm_data = 0;
+	wc.wc_flags = 0;
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+
+	/* Compare the PSN verses the expected PSN. */
+	if (unlikely(ipath_cmp24(psn, qp->r_psn) != 0)) {
+		/*
+		 * Handle a sequence error.
+		 * Silently drop any current message.
+		 */
+		qp->r_psn = psn;
+	inv:
+		qp->r_state = IB_OPCODE_UC_SEND_LAST;
+		switch (opcode) {
+		case IB_OPCODE_UC_SEND_FIRST:
+		case IB_OPCODE_UC_SEND_ONLY:
+		case IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE:
+			goto send_first;
+
+		case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+		case IB_OPCODE_UC_RDMA_WRITE_ONLY:
+		case IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE:
+			goto rdma_first;
+
+		default:
+			dev->n_pkt_drops++;
+			goto done;
+		}
+	}
+
+	/* Check for opcode sequence errors. */
+	switch (qp->r_state) {
+	case IB_OPCODE_UC_SEND_FIRST:
+	case IB_OPCODE_UC_SEND_MIDDLE:
+		if (opcode == IB_OPCODE_UC_SEND_MIDDLE ||
+		    opcode == IB_OPCODE_UC_SEND_LAST ||
+		    opcode == IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE)
+			break;
+		goto inv;
+
+	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
+		if (opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_LAST ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE)
+			break;
+		goto inv;
+
+	default:
+		if (opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    opcode == IB_OPCODE_UC_SEND_ONLY ||
+		    opcode == IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE)
+			break;
+		goto inv;
+	}
+
+	/* OK, process the packet. */
+	switch (opcode) {
+	case IB_OPCODE_UC_SEND_FIRST:
+	case IB_OPCODE_UC_SEND_ONLY:
+	case IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE:
+	send_first:
+		if (qp->r_reuse_sge) {
+			qp->r_reuse_sge = 0;
+			qp->r_sge = qp->s_rdma_sge;
+		} else if (!ipath_get_rwqe(qp, 0)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Save the WQE so we can reuse it in case of an error. */
+		qp->s_rdma_sge = qp->r_sge;
+		qp->r_rcv_len = 0;
+		if (opcode == IB_OPCODE_UC_SEND_ONLY)
+			goto send_last;
+		else if (opcode == IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE)
+			goto send_last_imm;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_SEND_MIDDLE:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4))) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len)) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		ipath_copy_sge(&qp->r_sge, data, pmtu);
+		break;
+
+	case IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE:
+	send_last_imm:
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else {
+			/* Immediate data comes after BTH */
+			wc.imm_data = ohdr->u.imm_data;
+		}
+		hdrsize += 4;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_SEND_LAST:
+	send_last:
+		/* Get the number of bytes the message was padded by. */
+		pad = (be32_to_cpu(ohdr->bth[0]) >> 20) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		wc.byte_len = tlen + qp->r_rcv_len;
+		if (unlikely(wc.byte_len > qp->r_len)) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* XXX Need to free SGEs */
+	last_imm:
+		ipath_copy_sge(&qp->r_sge, data, tlen);
+		wc.wr_id = qp->r_wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.opcode = IB_WC_RECV;
+		wc.vendor_err = 0;
+		wc.qp_num = qp->ibqp.qp_num;
+		wc.src_qp = qp->remote_qpn;
+		wc.pkey_index = 0;
+		wc.slid = qp->remote_ah_attr.dlid;
+		wc.sl = qp->remote_ah_attr.sl;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		/* Signal completion event if the solicited bit is set. */
+		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
+			       ohdr->bth[0] &
+			       __constant_cpu_to_be32(1 << 23));
+		break;
+
+	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_UC_RDMA_WRITE_ONLY:
+	case IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE: /* consume RWQE */
+	rdma_first:
+		/* RETH comes after BTH */
+		if (!has_grh)
+			reth = &ohdr->u.rc.reth;
+		else {
+			reth = (struct ib_reth *)data;
+			data += sizeof(*reth);
+		}
+		hdrsize += sizeof(*reth);
+		qp->r_len = be32_to_cpu(reth->length);
+		qp->r_rcv_len = 0;
+		if (qp->r_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = be64_to_cpu(reth->vaddr);
+
+			/* Check rkey */
+			if (unlikely(!ipath_rkey_ok(
+					     dev, &qp->r_sge, qp->r_len,
+					     vaddr, rkey,
+					     IB_ACCESS_REMOTE_WRITE))) {
+				dev->n_pkt_drops++;
+				goto done;
+			}
+		} else {
+			qp->r_sge.sg_list = NULL;
+			qp->r_sge.sge.mr = NULL;
+			qp->r_sge.sge.vaddr = NULL;
+			qp->r_sge.sge.length = 0;
+			qp->r_sge.sge.sge_length = 0;
+		}
+		if (unlikely(!(qp->qp_access_flags &
+			       IB_ACCESS_REMOTE_WRITE))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY)
+			goto rdma_last;
+		else if (opcode ==
+			 IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE)
+			goto rdma_last_imm;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		ipath_copy_sge(&qp->r_sge, data, pmtu);
+		break;
+
+	case IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+	rdma_last_imm:
+		/* Get the number of bytes the message was padded by. */
+		pad = (be32_to_cpu(ohdr->bth[0]) >> 20) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (qp->r_reuse_sge) {
+			qp->r_reuse_sge = 0;
+		} else if (!ipath_get_rwqe(qp, 1)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else {
+			/* Immediate data comes after BTH */
+			wc.imm_data = ohdr->u.imm_data;
+		}
+		hdrsize += 4;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		wc.byte_len = 0;
+		goto last_imm;
+
+	case IB_OPCODE_UC_RDMA_WRITE_LAST:
+	rdma_last:
+		/* Get the number of bytes the message was padded by. */
+		pad = (be32_to_cpu(ohdr->bth[0]) >> 20) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		ipath_copy_sge(&qp->r_sge, data, tlen);
+		break;
+
+	default:
+		/* Drop packet for unknown opcodes. */
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	qp->r_psn++;
+	qp->r_state = opcode;
+done:
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+}
diff -r 3d2a9e8f845c -r e6b07a6f5a64 drivers/infiniband/hw/ipath/ipath_ud.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Mar  9 16:16:31 2006 -0800
@@ -0,0 +1,581 @@
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
+#include "ipath_verbs.h"
+#include "ips_common.h"
+
+/**
+ * ipath_ud_loopback - handle send on loopback QPs
+ * @sqp: the QP
+ * @ss: the SGE state
+ * @length: the length of the data to send
+ * @wr: the work request
+ * @wc: the work completion entry
+ *
+ * This is called from ipath_post_ud_send() to forward a WQE addressed
+ * to the same HCA.
+ */
+void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
+		       u32 length, struct ib_send_wr *wr, struct ib_wc *wc)
+{
+	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
+	struct ipath_qp *qp;
+	struct ib_ah_attr *ah_attr;
+	unsigned long flags;
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_sge_state rsge;
+	struct ipath_sge *sge;
+	struct ipath_rwqe *wqe;
+
+	qp = ipath_lookup_qpn(&dev->qp_table, wr->wr.ud.remote_qpn);
+	if (!qp)
+		return;
+
+	/*
+	 * Check that the qkey matches (except for QP0, see 9.6.1.4.1).
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	if (unlikely(qp->ibqp.qp_num &&
+		     ((int) wr->wr.ud.remote_qkey < 0
+		      ? qp->qkey : wr->wr.ud.remote_qkey) != qp->qkey)) {
+		/* XXX OK to lose a count once in a while. */
+		dev->qkey_violations++;
+		dev->n_pkt_drops++;
+		goto done;
+	}
+
+	/*
+	 * A GRH is expected to preceed the data even if not
+	 * present on the wire.
+	 */
+	wc->byte_len = length + sizeof(struct ib_grh);
+
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wr->imm_data;
+	} else {
+		wc->wc_flags = 0;
+		wc->imm_data = 0;
+	}
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 * Note that it is safe to drop the lock after changing rq->tail
+	 * since ipath_post_receive() won't fill the empty slot.
+	 */
+	if (qp->ibqp.srq) {
+		srq = to_isrq(qp->ibqp.srq);
+		rq = &srq->rq;
+	} else {
+		srq = NULL;
+		rq = &qp->r_rq;
+	}
+	spin_lock_irqsave(&rq->lock, flags);
+	if (rq->tail == rq->head) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		goto done;
+	}
+	/* Silently drop packets which are too big. */
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	if (wc->byte_len > wqe->length) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		goto done;
+	}
+	wc->wr_id = wqe->wr_id;
+	rsge.sge = wqe->sg_list[0];
+	rsge.sg_list = wqe->sg_list + 1;
+	rsge.num_sge = wqe->num_sge;
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq && srq->ibsrq.event_handler) {
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			struct ib_event ev;
+
+			srq->limit = 0;
+			spin_unlock_irqrestore(&rq->lock, flags);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev,
+						 srq->ibsrq.srq_context);
+		} else
+			spin_unlock_irqrestore(&rq->lock, flags);
+	} else
+		spin_unlock_irqrestore(&rq->lock, flags);
+	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		ipath_copy_sge(&rsge, &ah_attr->grh, sizeof(struct ib_grh));
+		wc->wc_flags |= IB_WC_GRH;
+	} else
+		ipath_skip_sge(&rsge, sizeof(struct ib_grh));
+	sge = &ss->sge;
+	while (length) {
+		u32 len = sge->length;
+
+		if (len > length)
+			len = length;
+		BUG_ON(len == 0);
+		ipath_copy_sge(&rsge, sge->vaddr, len);
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
+	wc->status = IB_WC_SUCCESS;
+	wc->opcode = IB_WC_RECV;
+	wc->vendor_err = 0;
+	wc->qp_num = qp->ibqp.qp_num;
+	wc->src_qp = sqp->ibqp.qp_num;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc->pkey_index = 0;
+	wc->slid = ipath_layer_get_lid(dev->dd) |
+		(ah_attr->src_path_bits &
+		 ((1 << (dev->mkeyprot_resv_lmc & 7)) - 1));
+	wc->sl = ah_attr->sl;
+	wc->dlid_path_bits =
+		ah_attr->dlid & ((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
+		       wr->send_flags & IB_SEND_SOLICITED);
+
+done:
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+}
+
+/**
+ * ipath_post_ud_send - post a UD send on QP
+ * @qp: the QP
+ * @wr: the work request
+ *
+ * Note that we actually send the data as it is posted instead of putting
+ * the request into a ring buffer.  If we wanted to use a ring buffer,
+ * we would need to save a reference to the destination address in the SWQE.
+ */
+int ipath_post_ud_send(struct ipath_qp *qp, struct ib_send_wr *wr)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ipath_other_headers *ohdr;
+	struct ib_ah_attr *ah_attr;
+	struct ipath_sge_state ss;
+	struct ipath_sge *sg_list;
+	struct ib_wc wc;
+	u32 hwords;
+	u32 nwords;
+	u32 len;
+	u32 extra_bytes;
+	u32 bth0;
+	u16 lrh0;
+	u16 lid;
+	int i;
+
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
+		return 0;
+
+	/* IB spec says that num_sge == 0 is OK. */
+	if (wr->num_sge > qp->s_max_sge)
+		return -EINVAL;
+
+	if (wr->num_sge > 1) {
+		sg_list = kmalloc((qp->s_max_sge - 1) * sizeof(*sg_list),
+				  GFP_ATOMIC);
+		if (!sg_list)
+			return -ENOMEM;
+	} else
+		sg_list = NULL;
+
+	/* Check the buffer to send. */
+	ss.sg_list = sg_list;
+	ss.sge.mr = NULL;
+	ss.sge.vaddr = NULL;
+	ss.sge.length = 0;
+	ss.sge.sge_length = 0;
+	ss.num_sge = 0;
+	len = 0;
+	for (i = 0; i < wr->num_sge; i++) {
+		/* Check LKEY */
+		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0)
+			return -EINVAL;
+
+		if (wr->sg_list[i].length == 0)
+			continue;
+		if (!ipath_lkey_ok(&dev->lk_table, ss.num_sge ?
+				   sg_list + ss.num_sge - 1 : &ss.sge,
+				   &wr->sg_list[i], 0))
+			return -EINVAL;
+		len += wr->sg_list[i].length;
+		ss.num_sge++;
+	}
+	extra_bytes = (4 - len) & 3;
+	nwords = (len + extra_bytes) >> 2;
+
+	/* Construct the header. */
+	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
+	if (ah_attr->dlid == 0)
+		return -EINVAL;
+	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE) {
+		if (ah_attr->dlid != IPS_PERMISSIVE_LID)
+			dev->n_multicast_xmit++;
+		else
+			dev->n_unicast_xmit++;
+	} else {
+		dev->n_unicast_xmit++;
+		lid = ah_attr->dlid &
+			~((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
+		if (unlikely(lid == ipath_layer_get_lid(dev->dd))) {
+			/*
+			 * Pass in an uninitialized ib_wc to save stack
+			 * space.
+			 */
+			ipath_ud_loopback(qp, &ss, len, wr, &wc);
+			goto done;
+		}
+	}
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		/* Header size in 32-bit words. */
+		hwords = 17;
+		lrh0 = IPS_LRH_GRH;
+		ohdr = &qp->s_hdr.u.l.oth;
+		qp->s_hdr.u.l.grh.version_tclass_flow =
+			cpu_to_be32((6 << 28) |
+				    (ah_attr->grh.traffic_class << 20) |
+				    ah_attr->grh.flow_label);
+		qp->s_hdr.u.l.grh.paylen =
+			cpu_to_be16(((wr->opcode ==
+				      IB_WR_SEND_WITH_IMM ? 6 : 5) +
+				     nwords + SIZE_OF_CRC) << 2);
+		/* next_hdr is defined by C8-7 in ch. 8.4.1 */
+		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
+		qp->s_hdr.u.l.grh.hop_limit = ah_attr->grh.hop_limit;
+		/* The SGID is 32-bit aligned. */
+		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix =
+			dev->gid_prefix;
+		qp->s_hdr.u.l.grh.sgid.global.interface_id =
+			ipath_layer_get_guid(dev->dd);
+		qp->s_hdr.u.l.grh.dgid = ah_attr->grh.dgid;
+		/*
+		 * Don't worry about sending to locally attached multicast
+		 * QPs.  It is unspecified by the spec. what happens.
+		 */
+	} else {
+		/* Header size in 32-bit words. */
+		hwords = 7;
+		lrh0 = IPS_LRH_BTH;
+		ohdr = &qp->s_hdr.u.oth;
+	}
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		ohdr->u.ud.imm_data = wr->imm_data;
+		wc.imm_data = wr->imm_data;
+		hwords += 1;
+		bth0 = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE << 24;
+	} else if (wr->opcode == IB_WR_SEND) {
+		wc.imm_data = 0;
+		bth0 = IB_OPCODE_UD_SEND_ONLY << 24;
+	} else
+		return -EINVAL;
+	lrh0 |= ah_attr->sl << 4;
+	if (qp->ibqp.qp_type == IB_QPT_SMI)
+		lrh0 |= 0xF000;	/* Set VL (see ch. 13.5.3.1) */
+	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
+	qp->s_hdr.lrh[1] = cpu_to_be16(ah_attr->dlid);	/* DEST LID */
+	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
+	lid = ipath_layer_get_lid(dev->dd);
+	if (lid) {
+		lid |= ah_attr->src_path_bits &
+			((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
+		qp->s_hdr.lrh[3] = cpu_to_be16(lid);
+	} else
+		qp->s_hdr.lrh[3] = IB_LID_PERMISSIVE;
+	if (wr->send_flags & IB_SEND_SOLICITED)
+		bth0 |= 1 << 23;
+	bth0 |= extra_bytes << 20;
+	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPS_DEFAULT_P_KEY :
+		ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	/*
+	 * Use the multicast QP if the destination LID is a multicast LID.
+	 */
+	ohdr->bth[1] = ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
+		ah_attr->dlid != IPS_PERMISSIVE_LID ?
+		__constant_cpu_to_be32(IPS_MULTICAST_QPN) :
+		cpu_to_be32(wr->wr.ud.remote_qpn);
+	/* XXX Could lose a PSN count but not worth locking */
+	ohdr->bth[2] = cpu_to_be32(qp->s_next_psn++ & IPS_PSN_MASK);
+	/*
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	ohdr->u.ud.deth[0] = cpu_to_be32((int)wr->wr.ud.remote_qkey < 0 ?
+					 qp->qkey : wr->wr.ud.remote_qkey);
+	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
+	if (ipath_verbs_send(dev->dd, hwords, (u32 *) &qp->s_hdr,
+			     len, &ss))
+		dev->n_no_piobuf++;
+
+done:
+	/* Queue the completion status entry. */
+	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
+	    (wr->send_flags & IB_SEND_SIGNALED)) {
+		wc.wr_id = wr->wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.vendor_err = 0;
+		wc.opcode = IB_WC_SEND;
+		wc.byte_len = len;
+		wc.qp_num = qp->ibqp.qp_num;
+		wc.src_qp = 0;
+		wc.wc_flags = 0;
+		/* XXX initialize other fields? */
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 0);
+	}
+	kfree(sg_list);
+
+	return 0;
+}
+
+/**
+ * ipath_ud_rcv - receive an incoming UD packet
+ * @dev: the device the packet came in on
+ * @hdr: the packet header
+ * @has_grh: true if the packet has a GRH
+ * @data: the packet data
+ * @tlen: the packet length
+ * @qp: the QP the packet came on
+ *
+ * This is called from ipath_qp_rcv() to process an incoming UD packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+void ipath_ud_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
+		  int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
+{
+	struct ipath_other_headers *ohdr;
+	int opcode;
+	u32 hdrsize;
+	u32 pad;
+	unsigned long flags;
+	struct ib_wc wc;
+	u32 qkey;
+	u32 src_qp;
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_rwqe *wqe;
+	u16 dlid;
+
+	/* Check for GRH */
+	if (!has_grh) {
+		ohdr = &hdr->u.oth;
+		hdrsize = 8 + 12 + 8;	/* LRH + BTH + DETH */
+		qkey = be32_to_cpu(ohdr->u.ud.deth[0]);
+		src_qp = be32_to_cpu(ohdr->u.ud.deth[1]);
+	} else {
+		ohdr = &hdr->u.l.oth;
+		hdrsize = 8 + 40 + 12 + 8; /* LRH + GRH + BTH + DETH */
+		/*
+		 * The header with GRH is 68 bytes and the core driver sets
+		 * the eager header buffer size to 56 bytes so the last 12
+		 * bytes of the IB header is in the data buffer.
+		 */
+		qkey = be32_to_cpu(((u32 *) data)[1]);
+		src_qp = be32_to_cpu(((u32 *) data)[2]);
+		data += 12;
+	}
+	src_qp &= IPS_QPN_MASK;
+
+	/*
+	 * Check that the permissive LID is only used on QP0
+	 * and the QKEY matches (see 9.6.1.4.1 and 9.6.1.5.1).
+	 */
+	if (qp->ibqp.qp_num) {
+		if (unlikely(hdr->lrh[1] == IB_LID_PERMISSIVE ||
+			     hdr->lrh[3] == IB_LID_PERMISSIVE)) {
+			dev->n_pkt_drops++;
+			return;
+		}
+		if (unlikely(qkey != qp->qkey)) {
+			/* XXX OK to lose a count once in a while. */
+			dev->qkey_violations++;
+			dev->n_pkt_drops++;
+			return;
+		}
+	}
+
+	/* Get the number of bytes the message was padded by. */
+	pad = (be32_to_cpu(ohdr->bth[0]) >> 20) & 3;
+	if (unlikely(tlen < (hdrsize + pad + 4))) {
+		/* Drop incomplete packets. */
+		dev->n_pkt_drops++;
+		return;
+	}
+	tlen -= hdrsize + pad + 4;
+
+	/* Drop invalid MAD packets (see 13.5.3.1). */
+	if (unlikely((qp->ibqp.qp_num == 0 &&
+		      (tlen != 256 ||
+		       (be16_to_cpu(hdr->lrh[0]) >> 12) != 15)) ||
+		     (qp->ibqp.qp_num == 1 &&
+		      (tlen != 256 ||
+		       (be16_to_cpu(hdr->lrh[0]) >> 12) == 15)))) {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/*
+	 * A GRH is expected to preceed the data even if not
+	 * present on the wire.
+	 */
+	wc.byte_len = tlen + sizeof(struct ib_grh);
+
+	/*
+	 * The opcode is in the low byte when its in network order
+	 * (top byte when in host order).
+	 */
+	opcode = be32_to_cpu(ohdr->bth[0]) >> 24;
+	if (qp->ibqp.qp_num > 1 &&
+	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else
+			wc.imm_data = ohdr->u.ud.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		hdrsize += sizeof(u32);
+	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
+		wc.imm_data = 0;
+		wc.wc_flags = 0;
+	} else {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 * Note that it is safe to drop the lock after changing rq->tail
+	 * since ipath_post_receive() won't fill the empty slot.
+	 */
+	if (qp->ibqp.srq) {
+		srq = to_isrq(qp->ibqp.srq);
+		rq = &srq->rq;
+	} else {
+		srq = NULL;
+		rq = &qp->r_rq;
+	}
+	spin_lock_irqsave(&rq->lock, flags);
+	if (rq->tail == rq->head) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	/* Silently drop packets which are too big. */
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	if (wc.byte_len > wqe->length) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	wc.wr_id = wqe->wr_id;
+	qp->r_sge.sge = wqe->sg_list[0];
+	qp->r_sge.sg_list = wqe->sg_list + 1;
+	qp->r_sge.num_sge = wqe->num_sge;
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq && srq->ibsrq.event_handler) {
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			struct ib_event ev;
+
+			srq->limit = 0;
+			spin_unlock_irqrestore(&rq->lock, flags);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev,
+						 srq->ibsrq.srq_context);
+		} else
+			spin_unlock_irqrestore(&rq->lock, flags);
+	} else
+		spin_unlock_irqrestore(&rq->lock, flags);
+	if (has_grh) {
+		ipath_copy_sge(&qp->r_sge, &hdr->u.l.grh,
+			       sizeof(struct ib_grh));
+		wc.wc_flags |= IB_WC_GRH;
+	} else
+		ipath_skip_sge(&qp->r_sge, sizeof(struct ib_grh));
+	ipath_copy_sge(&qp->r_sge, data,
+		       wc.byte_len - sizeof(struct ib_grh));
+	wc.status = IB_WC_SUCCESS;
+	wc.opcode = IB_WC_RECV;
+	wc.vendor_err = 0;
+	wc.qp_num = qp->ibqp.qp_num;
+	wc.src_qp = src_qp;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc.pkey_index = 0;
+	wc.slid = be16_to_cpu(hdr->lrh[3]);
+	wc.sl = (be16_to_cpu(hdr->lrh[0]) >> 4) & 0xF;
+	dlid = be16_to_cpu(hdr->lrh[1]);
+	/*
+	 * Save the LMC lower bits if the destination LID is a unicast LID.
+	 */
+	wc.dlid_path_bits = dlid >= IPS_MULTICAST_LID_BASE ? 0 :
+		dlid & ((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
+		       ohdr->bth[0] & __constant_cpu_to_be32(1 << 23));
+}
