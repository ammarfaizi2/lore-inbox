Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVL2Ajl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVL2Ajl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVL2Ajg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:36 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52456 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932579AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 20] ipath - infiniband verbs header
X-Mercurial-Node: 26993cb5faeef807a8408e51427d79d2de810836
Message-Id: <26993cb5faeef807a840.1135816293@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:33 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r f9bcd9de3548 -r 26993cb5faee drivers/infiniband/hw/ipath/ipath_verbs.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,532 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#ifndef IPATH_VERBS_H
+#define IPATH_VERBS_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <rdma/ib_pack.h>
+
+#include "ipath_kernel.h"
+#include "verbs_debug.h"
+
+#define CTL_IPATH_VERBS 0x70736e68	/* "spin" as a hex value, top level */
+#define CTL_IPATH_VERBS_FAULT 1
+#define CTL_IPATH_VERBS_DEBUG 2
+
+#define QPN_MAX                 (1 << 24)
+#define QPNMAP_ENTRIES          (QPN_MAX / PAGE_SIZE / BITS_PER_BYTE)
+
+/*
+ * Increment this value if any changes that break userspace ABI
+ * compatibility are made.
+ */
+#define IPATH_UVERBS_ABI_VERSION       1
+
+/*
+ * Define an ib_cq_notify value that is not valid so we know when CQ
+ * notifications are armed.
+ */
+#define IB_CQ_NONE	(IB_CQ_NEXT_COMP + 1)
+
+enum {
+	IB_RNR_NAK = 0x20,
+
+	IB_NAK_PSN_ERROR = 0x60,
+	IB_NAK_INVALID_REQUEST = 0x61,
+	IB_NAK_REMOTE_ACCESS_ERROR = 0x62,
+	IB_NAK_REMOTE_OPERATIONAL_ERROR = 0x63,
+	IB_NAK_INVALID_RD_REQUEST = 0x64
+};
+
+/* IB Performance Manager status values */
+enum {
+	IB_PMA_SAMPLE_STATUS_DONE = 0x00,
+	IB_PMA_SAMPLE_STATUS_STARTED = 0x01,
+	IB_PMA_SAMPLE_STATUS_RUNNING = 0x02
+};
+
+/* Mandatory IB performance counter select values. */
+#define IB_PMA_PORT_XMIT_DATA	__constant_htons(0x0001)
+#define IB_PMA_PORT_RCV_DATA	__constant_htons(0x0002)
+#define IB_PMA_PORT_XMIT_PKTS	__constant_htons(0x0003)
+#define IB_PMA_PORT_RCV_PKTS	__constant_htons(0x0004)
+#define IB_PMA_PORT_XMIT_WAIT	__constant_htons(0x0005)
+
+struct ib_reth {
+	u64 vaddr;
+	u32 rkey;
+	u32 length;
+} __attribute__ ((packed));
+
+struct ib_atomic_eth {
+	u64 vaddr;
+	u32 rkey;
+	u64 swap_data;
+	u64 compare_data;
+} __attribute__ ((packed));
+
+struct ipath_other_headers {
+	u32 bth[3];
+	union {
+		struct {
+			u32 deth[2];
+			u32 imm_data;
+		} ud;
+		struct {
+			struct ib_reth reth;
+			u32 imm_data;
+		} rc;
+		struct {
+			u32 aeth;
+			u64 atomic_ack_eth;
+		} at;
+		u32 imm_data;
+		u32 aeth;
+		struct ib_atomic_eth atomic_eth;
+	} u;
+} __attribute__ ((packed));
+
+/*
+ * Note that UD packets with a GRH header are 8+40+12+8 = 68 bytes long
+ * (72 w/ imm_data).
+ * Only the first 56 bytes of the IB header will be in the
+ * eager header buffer.  The remaining 12 or 16 bytes are in the data buffer.
+ */
+struct ipath_ib_header {
+	u16 lrh[4];
+	union {
+		struct {
+			struct ib_grh grh;
+			struct ipath_other_headers oth;
+		} l;
+		struct ipath_other_headers oth;
+	} u;
+} __attribute__ ((packed));
+
+/*
+ * There is one struct ipath_mcast for each multicast GID.
+ * All attached QPs are then stored as a list of
+ * struct ipath_mcast_qp.
+ */
+struct ipath_mcast_qp {
+	struct list_head list;
+	struct ipath_qp *qp;
+};
+
+struct ipath_mcast {
+	struct rb_node rb_node;
+	union ib_gid mgid;
+	struct list_head qp_list;
+	wait_queue_head_t wait;
+	atomic_t refcount;
+};
+
+/* Memory region */
+struct ipath_mr {
+	struct ib_mr ibmr;
+	struct ipath_mregion mr;	/* must be last */
+};
+
+/* Fast memory region */
+struct ipath_fmr {
+	struct ib_fmr ibfmr;
+	u8 page_size;
+	struct ipath_mregion mr;	/* must be last */
+};
+
+/* Protection domain */
+struct ipath_pd {
+	struct ib_pd ibpd;
+	int user;		/* non-zero if created from user space */
+};
+
+/* Address Handle */
+struct ipath_ah {
+	struct ib_ah ibah;
+	struct ib_ah_attr attr;
+};
+
+/*
+ * Quick description of our CQ/QP locking scheme:
+ *
+ * We have one global lock that protects dev->cq/qp_table.  Each
+ * struct ipath_cq/qp also has its own lock.  An individual qp lock
+ * may be taken inside of an individual cq lock.  Both cqs attached to
+ * a qp may be locked, with the send cq locked first.  No other
+ * nesting should be done.
+ *
+ * Each struct ipath_cq/qp also has an atomic_t ref count.  The
+ * pointer from the cq/qp_table to the struct counts as one reference.
+ * This reference also is good for access through the consumer API, so
+ * modifying the CQ/QP etc doesn't need to take another reference.
+ * Access because of a completion being polled does need a reference.
+ *
+ * Finally, each struct ipath_cq/qp has a wait_queue_head_t for the
+ * destroy function to sleep on.
+ *
+ * This means that access from the consumer API requires nothing but
+ * taking the struct's lock.
+ *
+ * Access because of a completion event should go as follows:
+ * - lock cq/qp_table and look up struct
+ * - increment ref count in struct
+ * - drop cq/qp_table lock
+ * - lock struct, do your thing, and unlock struct
+ * - decrement ref count; if zero, wake up waiters
+ *
+ * To destroy a CQ/QP, we can do the following:
+ * - lock cq/qp_table, remove pointer, unlock cq/qp_table lock
+ * - decrement ref count
+ * - wait_event until ref count is zero
+ *
+ * It is the consumer's responsibilty to make sure that no QP
+ * operations (WQE posting or state modification) are pending when the
+ * QP is destroyed.  Also, the consumer must make sure that calls to
+ * qp_modify are serialized.
+ *
+ * Possible optimizations (wait for profile data to see if/where we
+ * have locks bouncing between CPUs):
+ * - split cq/qp table lock into n separate (cache-aligned) locks,
+ *   indexed (say) by the page in the table
+ */
+
+struct ipath_cq {
+	struct ib_cq ibcq;
+	struct tasklet_struct comptask;
+	spinlock_t lock;
+	u8 notify;
+	u8 triggered;
+	u32 head;		/* new records added to the head */
+	u32 tail;		/* poll_cq() reads from here. */
+	struct ib_wc queue[1];	/* this is actually ibcq.cqe + 1 */
+};
+
+/*
+ * Send work request queue entry.
+ * The size of the sg_list is determined when the QP is created and stored
+ * in qp->s_max_sge.
+ */
+struct ipath_swqe {
+	struct ib_send_wr wr;	/* don't use wr.sg_list */
+	u32 psn;		/* first packet sequence number */
+	u32 lpsn;		/* last packet sequence number */
+	u32 ssn;		/* send sequence number */
+	u32 length;		/* total length of data in sg_list */
+	struct ipath_sge sg_list[0];
+};
+
+/*
+ * Receive work request queue entry.
+ * The size of the sg_list is determined when the QP is created and stored
+ * in qp->r_max_sge.
+ */
+struct ipath_rwqe {
+	u64 wr_id;
+	u32 length;		/* total length of data in sg_list */
+	u8 num_sge;
+	struct ipath_sge sg_list[0];
+};
+
+struct ipath_rq {
+	spinlock_t lock;
+	u32 head;		/* new work requests posted to the head */
+	u32 tail;		/* receives pull requests from here. */
+	u32 size;		/* size of RWQE array */
+	u8 max_sge;
+	struct ipath_rwqe *wq;	/* RWQE array */
+};
+
+struct ipath_srq {
+	struct ib_srq ibsrq;
+	struct ipath_rq rq;
+	u32 limit;		/* send signal when number of RWQEs < limit */
+};
+
+/*
+ * Variables prefixed with s_ are for the requester (sender).
+ * Variables prefixed with r_ are for the responder (receiver).
+ * Variables prefixed with ack_ are for responder replies.
+ *
+ * Common variables are protected by both r_rq.lock and s_lock in that order
+ * which only happens in modify_qp() or changing the QP 'state'.
+ */
+struct ipath_qp {
+	struct ib_qp ibqp;
+	struct ipath_qp *next;		/* link list for QPN hash table */
+	struct list_head piowait;	/* link for wait PIO buf */
+	struct list_head timerwait;	/* link for waiting for timeouts */
+	struct ib_ah_attr remote_ah_attr;
+	struct ipath_ib_header s_hdr;	/* next packet header to send */
+	atomic_t refcount;
+	wait_queue_head_t wait;
+	struct tasklet_struct s_task;
+	struct ipath_sge_state *s_cur_sge;
+	struct ipath_sge_state s_sge;	/* current send request data */
+	struct ipath_sge_state s_rdma_sge; /* current RDMA read send data */
+	struct ipath_sge_state r_sge;	/* current receive data */
+	spinlock_t s_lock;
+	int s_flags;
+	u32 s_hdrwords;		/* size of s_hdr in 32 bit words */
+	u32 s_cur_size;		/* size of send packet in bytes */
+	u32 s_len;		/* total length of s_sge */
+	u32 s_rdma_len;		/* total length of s_rdma_sge */
+	u32 s_next_psn;		/* PSN for next request */
+	u32 s_last_psn;		/* last response PSN processed */
+	u32 s_psn;		/* current packet sequence number */
+	u32 s_rnr_timeout;	/* number of milliseconds for RNR timeout */
+	u32 s_ack_psn;		/* PSN for next ACK or RDMA_READ */
+	u64 s_ack_atomic;	/* data for atomic ACK */
+	u64 r_wr_id;		/* ID for current receive WQE */
+	u64 r_atomic_data;	/* data for last atomic op */
+	u32 r_atomic_psn;	/* PSN of last atomic op */
+	u32 r_len;		/* total length of r_sge */
+	u32 r_rcv_len;		/* receive data len processed */
+	u32 r_psn;		/* expected rcv packet sequence number */
+	u8 state;		/* QP state */
+	u8 s_state;		/* opcode of last packet sent */
+	u8 s_ack_state;		/* opcode of packet to ACK */
+	u8 s_nak_state;		/* non-zero if NAK is pending */
+	u8 r_state;		/* opcode of last packet received */
+	u8 r_reuse_sge;		/* for UC receive errors */
+	u8 r_sge_inx;		/* current index into sg_list */
+	u8 s_max_sge;		/* size of s_wq->sg_list */
+	u8 qp_access_flags;
+	u8 s_retry_cnt;		/* number of times to retry */
+	u8 s_rnr_retry_cnt;
+	u8 s_min_rnr_timer;
+	u8 s_retry;		/* requester retry counter */
+	u8 s_rnr_retry;		/* requester RNR retry counter */
+	u8 s_pkey_index;	/* PKEY index to use */
+	enum ib_mtu path_mtu;
+	atomic_t msn;		/* message sequence number */
+	u32 remote_qpn;
+	u32 qkey;		/* QKEY for this QP (for UD or RD) */
+	u32 s_size;		/* send work queue size */
+	u32 s_head;		/* new entries added here */
+	u32 s_tail;		/* next entry to process */
+	u32 s_cur;		/* current work queue entry */
+	u32 s_last;		/* last un-ACK'ed entry */
+	u32 s_ssn;		/* SSN of tail entry */
+	u32 s_lsn;		/* limit sequence number (credit) */
+	struct ipath_swqe *s_wq;	/* send work queue */
+	struct ipath_rq r_rq;	/* receive work queue */
+};
+
+/*
+ * Bit definitions for s_flags.
+ */
+#define IPATH_S_BUSY		0
+#define IPATH_S_SIGNAL_REQ_WR	1
+
+/*
+ * Since struct ipath_swqe is not a fixed size, we can't simply index into
+ * struct ipath_qp.s_wq.  This function does the array index computation.
+ */
+static inline struct ipath_swqe *get_swqe_ptr(struct ipath_qp *qp, unsigned n)
+{
+	return (struct ipath_swqe *)((char *) qp->s_wq +
+		(sizeof(struct ipath_swqe) +
+		 qp->s_max_sge * sizeof(struct ipath_sge)) * n);
+}
+
+/*
+ * Since struct ipath_rwqe is not a fixed size, we can't simply index into
+ * struct ipath_rq.wq.  This function does the array index computation.
+ */
+static inline struct ipath_rwqe *get_rwqe_ptr(struct ipath_rq *rq, unsigned n)
+{
+	return (struct ipath_rwqe *)((char *) rq->wq +
+		(sizeof(struct ipath_rwqe) +
+		 rq->max_sge * sizeof(struct ipath_sge)) * n);
+}
+
+/*
+ * QPN-map pages start out as NULL, they get allocated upon
+ * first use and are never deallocated. This way,
+ * large bitmaps are not allocated unless large numbers of QPs are used.
+ */
+struct qpn_map {
+	atomic_t n_free;
+	void *page;
+};
+
+struct ipath_qp_table {
+	spinlock_t lock;
+	u32 last;		/* last QP number allocated */
+	u32 max;		/* size of the hash table */
+	u32 nmaps;		/* size of the map table */
+	struct ipath_qp **table;
+	struct qpn_map map[QPNMAP_ENTRIES];	/* bit map of free numbers */
+};
+
+struct ipath_lkey_table {
+	spinlock_t lock;
+	u32 next;		/* next unused index (speeds search) */
+	u32 gen;		/* generation count */
+	u32 max;		/* size of the table */
+	struct ipath_mregion **table;
+};
+
+struct ipath_opcode_stats {
+	u64	n_packets;	/* number of packets */
+	u64	n_bytes;	/* total number of bytes */
+};
+
+struct ipath_ibdev {
+	struct ib_device ibdev;
+	ipath_type ib_unit;	/* This is the device number */
+	u16 sm_lid;		/* in host order */
+	u8 sm_sl;
+	u8 mkeyprot_resv_lmc;
+	unsigned long mkey_lease_timeout;	/* non-zero when timer is set */
+
+	/* The following fields are really per port. */
+	struct ipath_qp_table qp_table;
+	struct ipath_lkey_table lk_table;
+	struct list_head pending[3];	/* FIFO of QPs waiting for ACKs */
+	struct list_head piowait;	/* list for wait PIO buf */
+	struct list_head rnrwait;	/* list of QPs waiting for RNR timer */
+	spinlock_t pending_lock;
+	__be64 sys_image_guid;	/* in network order */
+	__be64 gid_prefix;	/* in network order */
+	__be64 mkey;
+	u64 ipath_sword;	/* total dwords sent (sample result) */
+	u64 ipath_rword;	/* total dwords received (sample result) */
+	u64 ipath_spkts;	/* total packets sent (sample result) */
+	u64 ipath_rpkts;	/* total packets received (sample result) */
+	u64 n_unicast_xmit;	/* total unicast packets sent */
+	u64 n_unicast_rcv;	/* total unicast packets received */
+	u64 n_multicast_xmit;	/* total multicast packets sent */
+	u64 n_multicast_rcv;	/* total multicast packets received */
+	u64 n_symbol_error_counter;		/* starting count for PMA */
+	u64 n_link_error_recovery_counter;	/* starting count for PMA */
+	u64 n_link_downed_counter;		/* starting count for PMA */
+	u64 n_port_rcv_errors;			/* starting count for PMA */
+	u64 n_port_rcv_remphys_errors;		/* starting count for PMA */
+	u64 n_port_xmit_discards;		/* starting count for PMA */
+	u64 n_port_xmit_data;			/* starting count for PMA */
+	u64 n_port_rcv_data;			/* starting count for PMA */
+	u64 n_port_xmit_packets;		/* starting count for PMA */
+	u64 n_port_rcv_packets;			/* starting count for PMA */
+	u32 n_rc_resends;
+	u32 n_rc_acks;
+	u32 n_rc_qacks;
+	u32 n_seq_naks;
+	u32 n_rdma_seq;
+	u32 n_rnr_naks;
+	u32 n_other_naks;
+	u32 n_timeouts;
+	u32 n_pkt_drops;
+	u32 n_wqe_errs;
+	u32 n_rdma_dup_busy;
+	u32 n_piowait;
+	u32 n_no_piobuf;
+	u32 port_cap_flags;
+	u32 pma_sample_start;
+	u32 pma_sample_interval;
+	__be16 pma_counter_select[5];
+	u16 pma_tag;
+	u16 qkey_violations;
+	u16 mkey_violations;
+	u16 mkey_lease_period;
+	u16 pending_index;	/* which pending queue is active */
+	u8 pma_sample_status;
+	u8 subnet_timeout;
+	struct ipath_opcode_stats opstats[128];
+};
+
+struct ipath_ucontext {
+	struct ib_ucontext ibucontext;
+};
+
+static inline struct ipath_mr *to_imr(struct ib_mr *ibmr)
+{
+	return container_of(ibmr, struct ipath_mr, ibmr);
+}
+
+static inline struct ipath_fmr *to_ifmr(struct ib_fmr *ibfmr)
+{
+	return container_of(ibfmr, struct ipath_fmr, ibfmr);
+}
+
+static inline struct ipath_pd *to_ipd(struct ib_pd *ibpd)
+{
+	return container_of(ibpd, struct ipath_pd, ibpd);
+}
+
+static inline struct ipath_ah *to_iah(struct ib_ah *ibah)
+{
+	return container_of(ibah, struct ipath_ah, ibah);
+}
+
+static inline struct ipath_cq *to_icq(struct ib_cq *ibcq)
+{
+	return container_of(ibcq, struct ipath_cq, ibcq);
+}
+
+static inline struct ipath_srq *to_isrq(struct ib_srq *ibsrq)
+{
+	return container_of(ibsrq, struct ipath_srq, ibsrq);
+}
+
+static inline struct ipath_qp *to_iqp(struct ib_qp *ibqp)
+{
+	return container_of(ibqp, struct ipath_qp, ibqp);
+}
+
+static inline struct ipath_ibdev *to_idev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct ipath_ibdev, ibdev);
+}
+
+int ipath_process_mad(struct ib_device *ibdev,
+		      int mad_flags,
+		      u8 port_num,
+		      struct ib_wc *in_wc,
+		      struct ib_grh *in_grh,
+		      struct ib_mad *in_mad, struct ib_mad *out_mad);
+
+static inline struct ipath_ucontext *to_iucontext(struct ib_ucontext
+						  *ibucontext)
+{
+	return container_of(ibucontext, struct ipath_ucontext, ibucontext);
+}
+
+#endif /* IPATH_VERBS_H */
diff -r f9bcd9de3548 -r 26993cb5faee drivers/infiniband/hw/ipath/verbs_debug.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/verbs_debug.h	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#ifndef _VERBS_DEBUG_H
+#define _VERBS_DEBUG_H
+
+/*
+ * This file contains tracing code for the ib_ipath kernel module.
+ */
+#ifndef _VERBS_DEBUGGING	/* tracing enabled or not */
+#define _VERBS_DEBUGGING 1
+#endif
+
+extern unsigned ib_ipath_debug;
+
+#define _VERBS_ERROR(fmt,...) \
+	do { \
+		printk(KERN_ERR "%s: " fmt, "ib_ipath", ##__VA_ARGS__); \
+	} while(0)
+
+#define _VERBS_UNIT_ERROR(unit,fmt,...) \
+	do { \
+		printk(KERN_ERR "%s: " fmt, "ib_ipath", ##__VA_ARGS__); \
+	} while(0)
+
+#if _VERBS_DEBUGGING
+
+/*
+ * Mask values for debugging.  The scheme allows us to compile out any of
+ * the debug tracing stuff, and if compiled in, to enable or disable dynamically
+ * This can be set at modprobe time also:
+ *      modprobe ib_path ib_ipath_debug=3
+ */
+
+#define __VERBS_INFO        0x1		/* generic low verbosity stuff */
+#define __VERBS_DBG         0x2		/* generic debug */
+#define __VERBS_VDBG        0x4		/* verbose debug */
+#define __VERBS_SMADBG      0x8000	/* sma packet debug */
+
+#define _VERBS_INFO(fmt,...) \
+	do { \
+		if(unlikely(ib_ipath_debug&__VERBS_INFO)) \
+			printk(KERN_INFO "%s: " fmt,"ib_ipath",##__VA_ARGS__); \
+	} while(0)
+
+#define _VERBS_DBG(fmt,...) \
+	do { \
+		if(unlikely(ib_ipath_debug&__VERBS_DBG)) \
+			printk(KERN_DEBUG "%s: " fmt, __func__,##__VA_ARGS__); \
+	} while(0)
+
+#define _VERBS_VDBG(fmt,...) \
+	do { \
+		if(unlikely(ib_ipath_debug&__VERBS_VDBG))  \
+			printk(KERN_DEBUG "%s: " fmt, __func__,##__VA_ARGS__); \
+	} while(0)
+
+#define _VERBS_SMADBG(fmt,...) \
+	do { \
+		if(unlikely(ib_ipath_debug&__VERBS_SMADBG)) \
+			printk(KERN_DEBUG "%s: " fmt, __func__,##__VA_ARGS__); \
+	} while(0)
+
+#else /* ! _VERBS_DEBUGGING */
+
+#define _VERBS_INFO(fmt,...)
+#define _VERBS_DBG(fmt,...)
+#define _VERBS_VDBG(fmt,...)
+#define _VERBS_SMADBG(fmt,...)
+
+#endif /* _VERBS_DEBUGGING */
+
+#endif /* _VERBS_DEBUG_H */
