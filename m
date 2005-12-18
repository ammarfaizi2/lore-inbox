Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbVLRT7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbVLRT7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVLRT7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:59:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1186 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965262AbVLRT7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:59:13 -0500
Date: Sun, 18 Dec 2005 11:59:22 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10/13]  [RFC] ipath verbs, part 1
Message-ID: <20051218195922.GC31184@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200512161548.zxp6FKcabEu47EnS@cisco.com> <200512161548.W9sJn4CLmdhnSTcH@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.W9sJn4CLmdhnSTcH@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:48:55PM -0800, Roland Dreier wrote:
> First half of ipath verbs driver

Some RCU-related questions interspersed.  Basic question is "where is
the lock-free read-side traversal?"

						Thanx, Paul

> ---
> 
>  drivers/infiniband/hw/ipath/ipath_verbs.c | 3244 +++++++++++++++++++++++++++++
>  1 files changed, 3244 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/infiniband/hw/ipath/ipath_verbs.c
> 
> 72075ecec75f8c42e444a7d7d8ffcf340a845b96
> diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
> new file mode 100644
> index 0000000..808326e
> --- /dev/null
> +++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
> @@ -0,0 +1,3244 @@
> +/*
> + * Copyright (c) 2005. PathScale, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Patent licenses, if any, provided herein do not apply to
> + * combinations of this program with other software, or any other
> + * product whatsoever.
> + *
> + * $Id: ipath_verbs.c 4491 2005-12-15 22:20:31Z rjwalsh $
> + */
> +
> +#include <linux/config.h>
> +#include <linux/version.h>
> +#include <linux/pci.h>
> +#include <linux/err.h>
> +#include <rdma/ib_pack.h>
> +#include <rdma/ib_smi.h>
> +#include <rdma/ib_mad.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +#include <asm/uaccess.h>
> +#include <asm-generic/bug.h>
> +
> +#include "ipath_common.h"
> +#include "ips_common.h"
> +#include "ipath_layer.h"
> +#include "ipath_verbs.h"
> +
> +/*
> + * Compare the lower 24 bits of the two values.
> + * Returns an integer <, ==, or > than zero.
> + */
> +static inline int cmp24(u32 a, u32 b)
> +{
> +	return (((int) a) - ((int) b)) << 8;
> +}
> +
> +#define MODNAME "ib_ipath"
> +#define DRIVER_LOAD_MSG "PathScale " MODNAME " loaded: "
> +#define PFX MODNAME ": "
> +
> +
> +/* Not static, because we don't want the compiler removing it */
> +const char ipath_verbs_version[] = "ipath_verbs " _IPATH_IDSTR;
> +
> +unsigned int ib_ipath_qp_table_size = 251;
> +module_param(ib_ipath_qp_table_size, uint, 0444);
> +MODULE_PARM_DESC(ib_ipath_qp_table_size, "QP table size");
> +
> +unsigned int ib_ipath_lkey_table_size = 12;
> +module_param(ib_ipath_lkey_table_size, uint, 0444);
> +MODULE_PARM_DESC(ib_ipath_lkey_table_size,
> +		 "LKEY table size in bits (2^n, 1 <= n <= 23)");
> +
> +unsigned int ib_ipath_debug;	/* debug mask */
> +module_param(ib_ipath_debug, uint, 0644);
> +MODULE_PARM_DESC(ib_ipath_debug, "Verbs debug mask");
> +
> +
> +static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
> +			      u32 len, struct ib_send_wr *wr, struct ib_wc *wc);
> +static void ipath_ruc_loopback(struct ipath_qp *sqp, struct ib_wc *wc);
> +static int ipath_destroy_qp(struct ib_qp *ibqp);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("PathScale <infinipath-support@pathscale.com>");
> +MODULE_DESCRIPTION("Pathscale InfiniPath driver");
> +
> +enum {
> +	IPATH_FAULT_RC_DROP_SEND_F = 1,
> +	IPATH_FAULT_RC_DROP_SEND_M,
> +	IPATH_FAULT_RC_DROP_SEND_L,
> +	IPATH_FAULT_RC_DROP_SEND_O,
> +	IPATH_FAULT_RC_DROP_RDMA_WRITE_F,
> +	IPATH_FAULT_RC_DROP_RDMA_WRITE_M,
> +	IPATH_FAULT_RC_DROP_RDMA_WRITE_L,
> +	IPATH_FAULT_RC_DROP_RDMA_WRITE_O,
> +	IPATH_FAULT_RC_DROP_RDMA_READ_RESP_F,
> +	IPATH_FAULT_RC_DROP_RDMA_READ_RESP_M,
> +	IPATH_FAULT_RC_DROP_RDMA_READ_RESP_L,
> +	IPATH_FAULT_RC_DROP_RDMA_READ_RESP_O,
> +	IPATH_FAULT_RC_DROP_ACK,
> +};
> +
> +enum {
> +	IPATH_TRANS_INVALID = 0,
> +	IPATH_TRANS_ANY2RST,
> +	IPATH_TRANS_RST2INIT,
> +	IPATH_TRANS_INIT2INIT,
> +	IPATH_TRANS_INIT2RTR,
> +	IPATH_TRANS_RTR2RTS,
> +	IPATH_TRANS_RTS2RTS,
> +	IPATH_TRANS_SQERR2RTS,
> +	IPATH_TRANS_ANY2ERR,
> +	IPATH_TRANS_RTS2SQD,	/* XXX Wait for expected ACKs & signal event */
> +	IPATH_TRANS_SQD2SQD,	/* error if not drained & parameter change */
> +	IPATH_TRANS_SQD2RTS,	/* error if not drained */
> +};
> +
> +enum {
> +	IPATH_POST_SEND_OK = 0x0001,
> +	IPATH_POST_RECV_OK = 0x0002,
> +	IPATH_PROCESS_RECV_OK = 0x0004,
> +	IPATH_PROCESS_SEND_OK = 0x0008,
> +};
> +
> +static int state_ops[IB_QPS_ERR + 1] = {
> +	[IB_QPS_RESET] = 0,
> +	[IB_QPS_INIT] = IPATH_POST_RECV_OK,
> +	[IB_QPS_RTR] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK,
> +	[IB_QPS_RTS] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK |
> +	    IPATH_POST_SEND_OK | IPATH_PROCESS_SEND_OK,
> +	[IB_QPS_SQD] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK |
> +	    IPATH_POST_SEND_OK,
> +	[IB_QPS_SQE] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK,
> +	[IB_QPS_ERR] = 0,
> +};
> +
> +/*
> + * Convert the AETH credit code into the number of credits.
> + */
> +static u32 credit_table[31] = {
> +	0,			/* 0 */
> +	1,			/* 1 */
> +	2,			/* 2 */
> +	3,			/* 3 */
> +	4,			/* 4 */
> +	6,			/* 5 */
> +	8,			/* 6 */
> +	12,			/* 7 */
> +	16,			/* 8 */
> +	24,			/* 9 */
> +	32,			/* A */
> +	48,			/* B */
> +	64,			/* C */
> +	96,			/* D */
> +	128,			/* E */
> +	192,			/* F */
> +	256,			/* 10 */
> +	384,			/* 11 */
> +	512,			/* 12 */
> +	768,			/* 13 */
> +	1024,			/* 14 */
> +	1536,			/* 15 */
> +	2048,			/* 16 */
> +	3072,			/* 17 */
> +	4096,			/* 18 */
> +	6144,			/* 19 */
> +	8192,			/* 1A */
> +	12288,			/* 1B */
> +	16384,			/* 1C */
> +	24576,			/* 1D */
> +	32768			/* 1E */
> +};
> +
> +/*
> + * Convert the AETH RNR timeout code into the number of milliseconds.
> + */
> +static u32 rnr_table[32] = {
> +	656,			/* 0 */
> +	1,			/* 1 */
> +	1,			/* 2 */
> +	1,			/* 3 */
> +	1,			/* 4 */
> +	1,			/* 5 */
> +	1,			/* 6 */
> +	1,			/* 7 */
> +	1,			/* 8 */
> +	1,			/* 9 */
> +	1,			/* A */
> +	1,			/* B */
> +	1,			/* C */
> +	1,			/* D */
> +	2,			/* E */
> +	2,			/* F */
> +	3,			/* 10 */
> +	4,			/* 11 */
> +	6,			/* 12 */
> +	8,			/* 13 */
> +	11,			/* 14 */
> +	16,			/* 15 */
> +	21,			/* 16 */
> +	31,			/* 17 */
> +	41,			/* 18 */
> +	62,			/* 19 */
> +	82,			/* 1A */
> +	123,			/* 1B */
> +	164,			/* 1C */
> +	246,			/* 1D */
> +	328,			/* 1E */
> +	492			/* 1F */
> +};
> +
> +/*
> + * Translate ib_wr_opcode into ib_wc_opcode.
> + */
> +static enum ib_wc_opcode wc_opcode[] = {
> +	[IB_WR_RDMA_WRITE] = IB_WC_RDMA_WRITE,
> +	[IB_WR_RDMA_WRITE_WITH_IMM] = IB_WC_RDMA_WRITE,
> +	[IB_WR_SEND] = IB_WC_SEND,
> +	[IB_WR_SEND_WITH_IMM] = IB_WC_SEND,
> +	[IB_WR_RDMA_READ] = IB_WC_RDMA_READ,
> +	[IB_WR_ATOMIC_CMP_AND_SWP] = IB_WC_COMP_SWAP,
> +	[IB_WR_ATOMIC_FETCH_AND_ADD] = IB_WC_FETCH_ADD
> +};
> +
> +/*
> + * Array of device pointers.
> + */
> +static uint32_t number_of_devices;
> +static struct ipath_ibdev **ipath_devices;
> +
> +/*
> + * Global table of GID to attached QPs.
> + * The table is global to all ipath devices since a send from one QP/device
> + * needs to be locally routed to any locally attached QPs on the same
> + * or different device.
> + */
> +static struct rb_root mcast_tree;
> +static spinlock_t mcast_lock = SPIN_LOCK_UNLOCKED;
> +
> +/*
> + * Allocate a structure to link a QP to the multicast GID structure.
> + */
> +static struct ipath_mcast_qp *ipath_mcast_qp_alloc(struct ipath_qp *qp)
> +{
> +	struct ipath_mcast_qp *mqp;
> +
> +	mqp = kmalloc(sizeof(*mqp), GFP_KERNEL);
> +	if (!mqp)
> +		return NULL;
> +
> +	mqp->qp = qp;
> +	atomic_inc(&qp->refcount);
> +
> +	return mqp;
> +}
> +
> +static void ipath_mcast_qp_free(struct ipath_mcast_qp *mqp)
> +{
> +	struct ipath_qp *qp = mqp->qp;
> +
> +	/* Notify ipath_destroy_qp() if it is waiting. */
> +	if (atomic_dec_and_test(&qp->refcount))
> +		wake_up(&qp->wait);
> +
> +	kfree(mqp);
> +}
> +
> +/*
> + * Allocate a structure for the multicast GID.
> + * A list of QPs will be attached to this structure.
> + */
> +static struct ipath_mcast *ipath_mcast_alloc(union ib_gid *mgid)
> +{
> +	struct ipath_mcast *mcast;
> +
> +	mcast = kmalloc(sizeof(*mcast), GFP_KERNEL);
> +	if (!mcast)
> +		return NULL;
> +
> +	mcast->mgid = *mgid;
> +	INIT_LIST_HEAD(&mcast->qp_list);
> +	init_waitqueue_head(&mcast->wait);
> +	atomic_set(&mcast->refcount, 0);
> +
> +	return mcast;
> +}
> +
> +static void ipath_mcast_free(struct ipath_mcast *mcast)
> +{
> +	struct ipath_mcast_qp *p, *tmp;
> +
> +	list_for_each_entry_safe(p, tmp, &mcast->qp_list, list)
> +		ipath_mcast_qp_free(p);
> +
> +	kfree(mcast);
> +}
> +
> +/*
> + * Search the global table for the given multicast GID.
> + * Return it or NULL if not found.
> + * The caller is responsible for decrementing the reference count if found.
> + */
> +static struct ipath_mcast *ipath_mcast_find(union ib_gid *mgid)
> +{
> +	struct rb_node *n;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mcast_lock, flags);
> +	n = mcast_tree.rb_node;
> +	while (n) {
> +		struct ipath_mcast *mcast;
> +		int ret;
> +
> +		mcast = rb_entry(n, struct ipath_mcast, rb_node);
> +
> +		ret = memcmp(mgid->raw, mcast->mgid.raw, sizeof(union ib_gid));
> +		if (ret < 0)
> +			n = n->rb_left;
> +		else if (ret > 0)
> +			n = n->rb_right;
> +		else {
> +			atomic_inc(&mcast->refcount);
> +			spin_unlock_irqrestore(&mcast_lock, flags);
> +			return mcast;
> +		}
> +	}
> +	spin_unlock_irqrestore(&mcast_lock, flags);
> +
> +	return NULL;
> +}
> +
> +/*
> + * Insert the multicast GID into the table and
> + * attach the QP structure.
> + * Return zero if both were added.
> + * Return EEXIST if the GID was already in the table but the QP was added.
> + * Return ESRCH if the QP was already attached and neither structure was added.
> + */
> +static int ipath_mcast_add(struct ipath_mcast *mcast,
> +			   struct ipath_mcast_qp *mqp)
> +{
> +	struct rb_node **n = &mcast_tree.rb_node;
> +	struct rb_node *pn = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mcast_lock, flags);
> +
> +	while (*n) {
> +		struct ipath_mcast *tmcast;
> +		struct ipath_mcast_qp *p;
> +		int ret;
> +
> +		pn = *n;
> +		tmcast = rb_entry(pn, struct ipath_mcast, rb_node);
> +
> +		ret = memcmp(mcast->mgid.raw, tmcast->mgid.raw,
> +			     sizeof(union ib_gid));
> +		if (ret < 0) {
> +			n = &pn->rb_left;
> +			continue;
> +		}
> +		if (ret > 0) {
> +			n = &pn->rb_right;
> +			continue;
> +		}
> +
> +		/* Search the QP list to see if this is already there. */
> +		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {

Given that we hold the global mcast_lock, how is RCU helping here?

Is there a lock-free read-side traversal path somewhere that I am
missing?

> +			if (p->qp == mqp->qp) {
> +				spin_unlock_irqrestore(&mcast_lock, flags);
> +				return ESRCH;
> +			}
> +		}
> +		list_add_tail_rcu(&mqp->list, &tmcast->qp_list);

Ditto...

> +		spin_unlock_irqrestore(&mcast_lock, flags);
> +		return EEXIST;
> +	}
> +
> +	list_add_tail_rcu(&mqp->list, &mcast->qp_list);

Ditto...

> +		spin_unlock_irqrestore(&mcast_lock, flags);
> +
> +	atomic_inc(&mcast->refcount);
> +	rb_link_node(&mcast->rb_node, pn, n);
> +	rb_insert_color(&mcast->rb_node, &mcast_tree);
> +
> +	spin_unlock_irqrestore(&mcast_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ipath_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid,
> +				  u16 lid)
> +{
> +	struct ipath_qp *qp = to_iqp(ibqp);
> +	struct ipath_mcast *mcast;
> +	struct ipath_mcast_qp *mqp;
> +
> +	/*
> +	 * Allocate data structures since its better to do this outside of
> +	 * spin locks and it will most likely be needed.
> +	 */
> +	mcast = ipath_mcast_alloc(gid);
> +	if (mcast == NULL)
> +		return -ENOMEM;
> +	mqp = ipath_mcast_qp_alloc(qp);
> +	if (mqp == NULL) {
> +		ipath_mcast_free(mcast);
> +		return -ENOMEM;
> +	}
> +	switch (ipath_mcast_add(mcast, mqp)) {
> +	case ESRCH:
> +		/* Neither was used: can't attach the same QP twice. */
> +		ipath_mcast_qp_free(mqp);
> +		ipath_mcast_free(mcast);
> +		return -EINVAL;
> +	case EEXIST:		/* The mcast wasn't used */
> +		ipath_mcast_free(mcast);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int ipath_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid,
> +				  u16 lid)
> +{
> +	struct ipath_qp *qp = to_iqp(ibqp);
> +	struct ipath_mcast *mcast = NULL;
> +	struct ipath_mcast_qp *p, *tmp;
> +	struct rb_node *n;
> +	unsigned long flags;
> +	int last = 0;
> +
> +	spin_lock_irqsave(&mcast_lock, flags);
> +
> +	/* Find the GID in the mcast table. */
> +	n = mcast_tree.rb_node;
> +	while (1) {
> +		int ret;
> +
> +		if (n == NULL) {
> +			spin_unlock_irqrestore(&mcast_lock, flags);
> +			return 0;
> +		}
> +
> +		mcast = rb_entry(n, struct ipath_mcast, rb_node);
> +		ret = memcmp(gid->raw, mcast->mgid.raw, sizeof(union ib_gid));
> +		if (ret < 0)
> +			n = n->rb_left;
> +		else if (ret > 0)
> +			n = n->rb_right;
> +		else
> +			break;
> +	}
> +
> +	/* Search the QP list. */
> +	list_for_each_entry_safe(p, tmp, &mcast->qp_list, list) {
> +		if (p->qp != qp)
> +			continue;
> +		/*
> +		 * We found it, so remove it, but don't poison the forward link
> +		 * until we are sure there are no list walkers.
> +		 */
> +		list_del_rcu(&p->list);

Ditto...

> +		spin_unlock_irqrestore(&mcast_lock, flags);
> +
> +		/* If this was the last attached QP, remove the GID too. */
> +		if (list_empty(&mcast->qp_list)) {
> +			rb_erase(&mcast->rb_node, &mcast_tree);
> +			last = 1;
> +		}
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&mcast_lock, flags);
> +
> +	if (p) {
> +		/*
> +		 * Wait for any list walkers to finish before freeing the
> +		 * list element.
> +		 */
> +		wait_event(mcast->wait, atomic_read(&mcast->refcount) <= 1);
> +		ipath_mcast_qp_free(p);
> +	}
> +	if (last) {
> +		atomic_dec(&mcast->refcount);
> +		wait_event(mcast->wait, !atomic_read(&mcast->refcount));
> +		ipath_mcast_free(mcast);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy data to SGE memory.
> + */
> +static void copy_sge(struct ipath_sge_state *ss, void *data, u32 length)
> +{
> +	struct ipath_sge *sge = &ss->sge;
> +
> +	while (length) {
> +		u32 len = sge->length;
> +
> +		BUG_ON(len == 0);
> +		if (len > length)
> +			len = length;
> +		memcpy(sge->vaddr, data, len);
> +		sge->vaddr += len;
> +		sge->length -= len;
> +		sge->sge_length -= len;
> +		if (sge->sge_length == 0) {
> +			if (--ss->num_sge)
> +				*sge = *ss->sg_list++;
> +		} else if (sge->length == 0 && sge->mr != NULL) {
> +			if (++sge->n >= IPATH_SEGSZ) {
> +				if (++sge->m >= sge->mr->mapsz)
> +					break;
> +				sge->n = 0;
> +			}
> +			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
> +			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
> +		}
> +		data += len;
> +		length -= len;
> +	}
> +}
> +
> +/*
> + * Skip over length bytes of SGE memory.
> + */
> +static void skip_sge(struct ipath_sge_state *ss, u32 length)
> +{
> +	struct ipath_sge *sge = &ss->sge;
> +
> +	while (length > sge->sge_length) {
> +		length -= sge->sge_length;
> +		ss->sge = *ss->sg_list++;
> +	}
> +	while (length) {
> +		u32 len = sge->length;
> +
> +		BUG_ON(len == 0);
> +		if (len > length)
> +			len = length;
> +		sge->vaddr += len;
> +		sge->length -= len;
> +		sge->sge_length -= len;
> +		if (sge->sge_length == 0) {
> +			if (--ss->num_sge)
> +				*sge = *ss->sg_list++;
> +		} else if (sge->length == 0 && sge->mr != NULL) {
> +			if (++sge->n >= IPATH_SEGSZ) {
> +				if (++sge->m >= sge->mr->mapsz)
> +					break;
> +				sge->n = 0;
> +			}
> +			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
> +			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
> +		}
> +		length -= len;
> +	}
> +}
> +
> +static inline u32 alloc_qpn(struct ipath_qp_table *qpt)
> +{
> +	u32 i, offset, max_scan, qpn;
> +	struct qpn_map *map;
> +
> +	qpn = qpt->last + 1;
> +	if (qpn >= QPN_MAX)
> +		qpn = 2;
> +	offset = qpn & BITS_PER_PAGE_MASK;
> +	map = &qpt->map[qpn / BITS_PER_PAGE];
> +	max_scan = qpt->nmaps - !offset;
> +	for (i = 0;;) {
> +		if (unlikely(!map->page)) {
> +			unsigned long page = get_zeroed_page(GFP_KERNEL);
> +			unsigned long flags;
> +
> +			/*
> +			 * Free the page if someone raced with us
> +			 * installing it:
> +			 */
> +			spin_lock_irqsave(&qpt->lock, flags);
> +			if (map->page)
> +				free_page(page);
> +			else
> +				map->page = (void *)page;
> +			spin_unlock_irqrestore(&qpt->lock, flags);
> +			if (unlikely(!map->page))
> +				break;
> +		}
> +		if (likely(atomic_read(&map->n_free))) {
> +			do {
> +				if (!test_and_set_bit(offset, map->page)) {
> +					atomic_dec(&map->n_free);
> +					qpt->last = qpn;
> +					return qpn;
> +				}
> +				offset = find_next_offset(map, offset);
> +				qpn = mk_qpn(qpt, map, offset);
> +				/*
> +				 * This test differs from alloc_pidmap().
> +				 * If find_next_offset() does find a zero bit,
> +				 * we don't need to check for QPN wrapping
> +				 * around past our starting QPN.  We
> +				 * just need to be sure we don't loop forever.
> +				 */
> +			} while (offset < BITS_PER_PAGE && qpn < QPN_MAX);
> +		}
> +		/*
> +		 * In order to keep the number of pages allocated to a minimum,
> +		 * we scan the all existing pages before increasing the size
> +		 * of the bitmap table.
> +		 */
> +		if (++i > max_scan) {
> +			if (qpt->nmaps == QPNMAP_ENTRIES)
> +				break;
> +			map = &qpt->map[qpt->nmaps++];
> +			offset = 0;
> +		} else if (map < &qpt->map[qpt->nmaps]) {
> +			++map;
> +			offset = 0;
> +		} else {
> +			map = &qpt->map[0];
> +			offset = 2;
> +		}
> +		qpn = mk_qpn(qpt, map, offset);
> +	}
> +	return 0;
> +}
> +
> +static inline void free_qpn(struct ipath_qp_table *qpt, u32 qpn)
> +{
> +	struct qpn_map *map;
> +
> +	map = qpt->map + qpn / BITS_PER_PAGE;
> +	if (map->page)
> +		clear_bit(qpn & BITS_PER_PAGE_MASK, map->page);
> +	atomic_inc(&map->n_free);
> +}
> +
> +/*
> + * Allocate the next available QPN and put the QP into the hash table.
> + * The hash table holds a reference to the QP.
> + */
> +static int ipath_alloc_qpn(struct ipath_qp_table *qpt, struct ipath_qp *qp,
> +			   enum ib_qp_type type)
> +{
> +	unsigned long flags;
> +	u32 qpn;
> +
> +	if (type == IB_QPT_SMI)
> +		qpn = 0;
> +	else if (type == IB_QPT_GSI)
> +		qpn = 1;
> +	else {
> +		/* Allocate the next available QPN */
> +		qpn = alloc_qpn(qpt);
> +		if (qpn == 0) {
> +			return -ENOMEM;
> +		}
> +	}
> +	qp->ibqp.qp_num = qpn;
> +
> +	/* Add the QP to the hash table. */
> +	spin_lock_irqsave(&qpt->lock, flags);
> +
> +	qpn %= qpt->max;
> +	qp->next = qpt->table[qpn];
> +	qpt->table[qpn] = qp;
> +	atomic_inc(&qp->refcount);
> +
> +	spin_unlock_irqrestore(&qpt->lock, flags);
> +	return 0;
> +}
> +
> +/*
> + * Remove the QP from the table so it can't be found asynchronously by
> + * the receive interrupt routine.
> + */
> +static void ipath_free_qp(struct ipath_qp_table *qpt, struct ipath_qp *qp)
> +{
> +	struct ipath_qp *q, **qpp;
> +	unsigned long flags;
> +	int fnd = 0;
> +
> +	spin_lock_irqsave(&qpt->lock, flags);
> +
> +	/* Remove QP from the hash table. */
> +	qpp = &qpt->table[qp->ibqp.qp_num % qpt->max];
> +	for (; (q = *qpp) != NULL; qpp = &q->next) {
> +		if (q == qp) {
> +			*qpp = qp->next;
> +			qp->next = NULL;
> +			atomic_dec(&qp->refcount);
> +			fnd = 1;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&qpt->lock, flags);
> +
> +	if (!fnd)
> +		return;
> +
> +	/* If QPN is not reserved, mark QPN free in the bitmap. */
> +	if (qp->ibqp.qp_num > 1)
> +		free_qpn(qpt, qp->ibqp.qp_num);
> +
> +	wait_event(qp->wait, !atomic_read(&qp->refcount));
> +}
> +
> +/*
> + * Remove all QPs from the table.
> + */
> +static void ipath_free_all_qps(struct ipath_qp_table *qpt)
> +{
> +	unsigned long flags;
> +	struct ipath_qp *qp, *nqp;
> +	u32 n;
> +
> +	for (n = 0; n < qpt->max; n++) {
> +		spin_lock_irqsave(&qpt->lock, flags);
> +		qp = qpt->table[n];
> +		qpt->table[n] = NULL;
> +		spin_unlock_irqrestore(&qpt->lock, flags);
> +
> +		while (qp) {
> +			nqp = qp->next;
> +			if (qp->ibqp.qp_num > 1)
> +				free_qpn(qpt, qp->ibqp.qp_num);
> +			if (!atomic_dec_and_test(&qp->refcount) ||
> +			    !ipath_destroy_qp(&qp->ibqp))
> +				_VERBS_INFO("QP memory leak!\n");
> +			qp = nqp;
> +		}
> +	}
> +
> +	for (n = 0; n < ARRAY_SIZE(qpt->map); n++) {
> +		if (qpt->map[n].page)
> +			free_page((unsigned long)qpt->map[n].page);
> +	}
> +}
> +
> +/*
> + * Return the QP with the given QPN.
> + * The caller is responsible for decrementing the QP reference count when done.
> + */
> +static struct ipath_qp *ipath_lookup_qpn(struct ipath_qp_table *qpt, u32 qpn)
> +{
> +	unsigned long flags;
> +	struct ipath_qp *qp;
> +
> +	spin_lock_irqsave(&qpt->lock, flags);
> +
> +	for (qp = qpt->table[qpn % qpt->max]; qp; qp = qp->next) {
> +		if (qp->ibqp.qp_num == qpn) {
> +			atomic_inc(&qp->refcount);
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&qpt->lock, flags);
> +	return qp;
> +}
> +
> +static int ipath_alloc_lkey(struct ipath_lkey_table *rkt,
> +			    struct ipath_mregion *mr)
> +{
> +	unsigned long flags;
> +	u32 r;
> +	u32 n;
> +
> +	spin_lock_irqsave(&rkt->lock, flags);
> +
> +	/* Find the next available LKEY */
> +	r = n = rkt->next;
> +	for (;;) {
> +		if (rkt->table[r] == NULL)
> +			break;
> +		r = (r + 1) & (rkt->max - 1);
> +		if (r == n) {
> +			spin_unlock_irqrestore(&rkt->lock, flags);
> +			_VERBS_INFO("LKEY table full\n");
> +			return 0;
> +		}
> +	}
> +	rkt->next = (r + 1) & (rkt->max - 1);
> +	/*
> +	 * Make sure lkey is never zero which is reserved to indicate an
> +	 * unrestricted LKEY.
> +	 */
> +	rkt->gen++;
> +	mr->lkey = (r << (32 - ib_ipath_lkey_table_size)) |
> +	    ((((1 << (24 - ib_ipath_lkey_table_size)) - 1) & rkt->gen) << 8);
> +	if (mr->lkey == 0) {
> +		mr->lkey |= 1 << 8;
> +		rkt->gen++;
> +	}
> +	rkt->table[r] = mr;
> +	spin_unlock_irqrestore(&rkt->lock, flags);
> +
> +	return 1;
> +}
> +
> +static void ipath_free_lkey(struct ipath_lkey_table *rkt, u32 lkey)
> +{
> +	unsigned long flags;
> +	u32 r;
> +
> +	if (lkey == 0)
> +		return;
> +	r = lkey >> (32 - ib_ipath_lkey_table_size);
> +	spin_lock_irqsave(&rkt->lock, flags);
> +	rkt->table[r] = NULL;
> +	spin_unlock_irqrestore(&rkt->lock, flags);
> +}
> +
> +/*
> + * Check the IB SGE for validity and initialize our internal version of it.
> + * Return 1 if OK, else zero.
> + */
> +static int ipath_lkey_ok(struct ipath_lkey_table *rkt, struct ipath_sge *isge,
> +			 struct ib_sge *sge, int acc)
> +{
> +	struct ipath_mregion *mr;
> +	size_t off;
> +
> +	/*
> +	 * We use LKEY == zero to mean a physical kmalloc() address.
> +	 * This is a bit of a hack since we rely on dma_map_single()
> +	 * being reversible by calling bus_to_virt().
> +	 */
> +	if (sge->lkey == 0) {
> +		isge->mr = NULL;
> +		isge->vaddr = bus_to_virt(sge->addr);
> +		isge->length = sge->length;
> +		isge->sge_length = sge->length;
> +		return 1;
> +	}
> +	spin_lock(&rkt->lock);
> +	mr = rkt->table[(sge->lkey >> (32 - ib_ipath_lkey_table_size))];
> +	spin_unlock(&rkt->lock);
> +	if (unlikely(mr == NULL || mr->lkey != sge->lkey))
> +		return 0;
> +
> +	off = sge->addr - mr->user_base;
> +	if (unlikely(sge->addr < mr->user_base ||
> +		     off + sge->length > mr->length ||
> +		     (mr->access_flags & acc) != acc))
> +		return 0;
> +
> +	off += mr->offset;
> +	isge->mr = mr;
> +	isge->m = 0;
> +	isge->n = 0;
> +	while (off >= mr->map[isge->m]->segs[isge->n].length) {
> +		off -= mr->map[isge->m]->segs[isge->n].length;
> +		if (++isge->n >= IPATH_SEGSZ) {
> +			isge->m++;
> +			isge->n = 0;
> +		}
> +	}
> +	isge->vaddr = mr->map[isge->m]->segs[isge->n].vaddr + off;
> +	isge->length = mr->map[isge->m]->segs[isge->n].length - off;
> +	isge->sge_length = sge->length;
> +	return 1;
> +}
> +
> +/*
> + * Initialize the qp->s_sge after a restart.
> + * The QP s_lock should be held.
> + */
> +static void ipath_init_restart(struct ipath_qp *qp, struct ipath_swqe *wqe)
> +{
> +	struct ipath_ibdev *dev;
> +	u32 len;
> +
> +	len = ((qp->s_psn - wqe->psn) & 0xFFFFFF) *
> +	    ib_mtu_enum_to_int(qp->path_mtu);
> +	qp->s_sge.sge = wqe->sg_list[0];
> +	qp->s_sge.sg_list = wqe->sg_list + 1;
> +	qp->s_sge.num_sge = wqe->wr.num_sge;
> +	skip_sge(&qp->s_sge, len);
> +	qp->s_len = wqe->length - len;
> +	dev = to_idev(qp->ibqp.device);
> +	spin_lock(&dev->pending_lock);
> +	if (qp->timerwait.next == LIST_POISON1)
> +		list_add_tail(&qp->timerwait,
> +			      &dev->pending[dev->pending_index]);
> +	spin_unlock(&dev->pending_lock);
> +}
> +
> +/*
> + * Check the IB virtual address, length, and RKEY.
> + * Return 1 if OK, else zero.
> + * The QP r_rq.lock should be held.
> + */
> +static int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
> +			 u32 len, u64 vaddr, u32 rkey, int acc)
> +{
> +	struct ipath_lkey_table *rkt = &dev->lk_table;
> +	struct ipath_sge *sge = &ss->sge;
> +	struct ipath_mregion *mr;
> +	size_t off;
> +
> +	spin_lock(&rkt->lock);
> +	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
> +	spin_unlock(&rkt->lock);
> +	if (unlikely(mr == NULL || mr->lkey != rkey))
> +		return 0;
> +
> +	off = vaddr - mr->iova;
> +	if (unlikely(vaddr < mr->iova || off + len > mr->length ||
> +		     (mr->access_flags & acc) == 0))
> +		return 0;
> +
> +	off += mr->offset;
> +	sge->mr = mr;
> +	sge->m = 0;
> +	sge->n = 0;
> +	while (off >= mr->map[sge->m]->segs[sge->n].length) {
> +		off -= mr->map[sge->m]->segs[sge->n].length;
> +		if (++sge->n >= IPATH_SEGSZ) {
> +			sge->m++;
> +			sge->n = 0;
> +		}
> +	}
> +	sge->vaddr = mr->map[sge->m]->segs[sge->n].vaddr + off;
> +	sge->length = mr->map[sge->m]->segs[sge->n].length - off;
> +	sge->sge_length = len;
> +	ss->sg_list = NULL;
> +	ss->num_sge = 1;
> +	return 1;
> +}
> +
> +/*
> + * Add a new entry to the completion queue.
> + * This may be called with one of the qp->s_lock or qp->r_rq.lock held.
> + */
> +static void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int sig)
> +{
> +	unsigned long flags;
> +	u32 next;
> +
> +	spin_lock_irqsave(&cq->lock, flags);
> +
> +	cq->queue[cq->head] = *entry;
> +	next = cq->head + 1;
> +	if (next == cq->ibcq.cqe)
> +		next = 0;
> +	if (next != cq->tail)
> +		cq->head = next;
> +	else {
> +		/* XXX - need to mark current wr as having an error... */
> +	}
> +
> +	if (cq->notify == IB_CQ_NEXT_COMP ||
> +	    (cq->notify == IB_CQ_SOLICITED && sig)) {
> +		cq->notify = IB_CQ_NONE;
> +		cq->triggered++;
> +		/*
> +		 * This will cause send_complete() to be called in
> +		 * another thread.
> +		 */
> +		tasklet_schedule(&cq->comptask);
> +	}
> +
> +	spin_unlock_irqrestore(&cq->lock, flags);
> +
> +	if (entry->status != IB_WC_SUCCESS)
> +		to_idev(cq->ibcq.device)->n_wqe_errs++;
> +}
> +
> +static void send_complete(unsigned long data)
> +{
> +	struct ipath_cq *cq = (struct ipath_cq *)data;
> +
> +	/*
> +	 * The completion handler will most likely rearm the notification
> +	 * and poll for all pending entries.  If a new completion entry
> +	 * is added while we are in this routine, tasklet_schedule()
> +	 * won't call us again until we return so we check triggered to
> +	 * see if we need to call the handler again.
> +	 */
> +	for (;;) {
> +		u8 triggered = cq->triggered;
> +
> +		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +
> +		if (cq->triggered == triggered)
> +			return;
> +	}
> +}
> +
> +/*
> + * This is the QP state transition table.
> + * See ipath_modify_qp() for details.
> + */
> +static const struct {
> +	int trans;
> +	u32 req_param[IB_QPT_RAW_IPV6];
> +	u32 opt_param[IB_QPT_RAW_IPV6];
> +} qp_state_table[IB_QPS_ERR + 1][IB_QPS_ERR + 1] = {
> +	[IB_QPS_RESET] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_INIT] = {
> +			.trans = IPATH_TRANS_RST2INIT,
> +			.req_param = {
> +				[IB_QPT_SMI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_ACCESS_FLAGS),
> +				[IB_QPT_RC] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_ACCESS_FLAGS),
> +			},
> +		},
> +	},
> +	[IB_QPS_INIT] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_INIT] = {
> +			.trans = IPATH_TRANS_INIT2INIT,
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_ACCESS_FLAGS),
> +				[IB_QPT_RC] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_PORT |
> +					 IB_QP_ACCESS_FLAGS),
> +			}
> +		},
> +		[IB_QPS_RTR] = {
> +			.trans = IPATH_TRANS_INIT2RTR,
> +			.req_param = {
> +				[IB_QPT_UC] = (IB_QP_AV |
> +					 IB_QP_PATH_MTU |
> +					 IB_QP_DEST_QPN |
> +					 IB_QP_RQ_PSN),
> +				[IB_QPT_RC] = (IB_QP_AV |
> +					 IB_QP_PATH_MTU |
> +					 IB_QP_DEST_QPN |
> +					 IB_QP_RQ_PSN |
> +					 IB_QP_MAX_DEST_RD_ATOMIC |
> +					 IB_QP_MIN_RNR_TIMER),
> +			},
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_PKEY_INDEX |
> +					 IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX),
> +				[IB_QPT_RC] = (IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX),
> +			}
> +		}
> +	},
> +	[IB_QPS_RTR] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_RTS] = {
> +			.trans = IPATH_TRANS_RTR2RTS,
> +			.req_param = {
> +				[IB_QPT_SMI] = IB_QP_SQ_PSN,
> +				[IB_QPT_GSI] = IB_QP_SQ_PSN,
> +				[IB_QPT_UD] = IB_QP_SQ_PSN,
> +				[IB_QPT_UC] = IB_QP_SQ_PSN,
> +				[IB_QPT_RC] = (IB_QP_TIMEOUT |
> +					 IB_QP_RETRY_CNT |
> +					 IB_QP_RNR_RETRY |
> +					 IB_QP_SQ_PSN |
> +					 IB_QP_MAX_QP_RD_ATOMIC),
> +			},
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX |
> +					 IB_QP_PATH_MIG_STATE),
> +				[IB_QPT_RC] = (IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX |
> +					 IB_QP_MIN_RNR_TIMER |
> +					 IB_QP_PATH_MIG_STATE),
> +			}
> +		}
> +	},
> +	[IB_QPS_RTS] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_RTS] = {
> +			.trans = IPATH_TRANS_RTS2RTS,
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_ACCESS_FLAGS |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_PATH_MIG_STATE),
> +				[IB_QPT_RC] = (IB_QP_ACCESS_FLAGS |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_PATH_MIG_STATE |
> +					 IB_QP_MIN_RNR_TIMER),
> +			}
> +		},
> +		[IB_QPS_SQD] = {
> +			.trans = IPATH_TRANS_RTS2SQD,
> +		},
> +	},
> +	[IB_QPS_SQD] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_RTS] = {
> +			.trans = IPATH_TRANS_SQD2RTS,
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PATH_MIG_STATE),
> +				[IB_QPT_RC] = (IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_MIN_RNR_TIMER |
> +					 IB_QP_PATH_MIG_STATE),
> +			}
> +		},
> +		[IB_QPS_SQD] = {
> +			.trans = IPATH_TRANS_SQD2SQD,
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_PKEY_INDEX | IB_QP_QKEY),
> +				[IB_QPT_UC] = (IB_QP_AV |
> +					 IB_QP_TIMEOUT |
> +					 IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX |
> +					 IB_QP_PATH_MIG_STATE),
> +				[IB_QPT_RC] = (IB_QP_AV |
> +					 IB_QP_TIMEOUT |
> +					 IB_QP_RETRY_CNT |
> +					 IB_QP_RNR_RETRY |
> +					 IB_QP_MAX_QP_RD_ATOMIC |
> +					 IB_QP_MAX_DEST_RD_ATOMIC |
> +					 IB_QP_CUR_STATE |
> +					 IB_QP_ALT_PATH |
> +					 IB_QP_ACCESS_FLAGS |
> +					 IB_QP_PKEY_INDEX |
> +					 IB_QP_MIN_RNR_TIMER |
> +					 IB_QP_PATH_MIG_STATE),
> +			}
> +		}
> +	},
> +	[IB_QPS_SQE] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR },
> +		[IB_QPS_RTS] = {
> +			.trans = IPATH_TRANS_SQERR2RTS,
> +			.opt_param = {
> +				[IB_QPT_SMI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_GSI] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UD] = (IB_QP_CUR_STATE | IB_QP_QKEY),
> +				[IB_QPT_UC] = IB_QP_CUR_STATE,
> +				[IB_QPT_RC] = (IB_QP_CUR_STATE |
> +					 IB_QP_MIN_RNR_TIMER),
> +			}
> +		}
> +	},
> +	[IB_QPS_ERR] = {
> +		[IB_QPS_RESET] = { .trans = IPATH_TRANS_ANY2RST },
> +		[IB_QPS_ERR] = { .trans = IPATH_TRANS_ANY2ERR }
> +	}
> +};
> +
> +/*
> + * Initialize the QP state to the reset state.
> + */
> +static void ipath_reset_qp(struct ipath_qp *qp)
> +{
> +	qp->remote_qpn = 0;
> +	qp->qkey = 0;
> +	qp->qp_access_flags = 0;
> +	qp->s_hdrwords = 0;
> +	qp->s_psn = 0;
> +	qp->r_psn = 0;
> +	atomic_set(&qp->msn, 0);
> +	if (qp->ibqp.qp_type == IB_QPT_RC) {
> +		qp->s_state = IB_OPCODE_RC_SEND_LAST;
> +		qp->r_state = IB_OPCODE_RC_SEND_LAST;
> +	} else {
> +		qp->s_state = IB_OPCODE_UC_SEND_LAST;
> +		qp->r_state = IB_OPCODE_UC_SEND_LAST;
> +	}
> +	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +	qp->s_nak_state = 0;
> +	qp->s_rnr_timeout = 0;
> +	qp->s_head = 0;
> +	qp->s_tail = 0;
> +	qp->s_cur = 0;
> +	qp->s_last = 0;
> +	qp->s_ssn = 1;
> +	qp->s_lsn = 0;
> +	qp->r_rq.head = 0;
> +	qp->r_rq.tail = 0;
> +	qp->r_reuse_sge = 0;
> +}
> +
> +/*
> + * Flush send work queue.
> + * The QP s_lock should be held.
> + */
> +static void ipath_sqerror_qp(struct ipath_qp *qp, struct ib_wc *wc)
> +{
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
> +
> +	_VERBS_INFO("Send queue error on QP%d/%d: err: %d\n",
> +		    qp->ibqp.qp_num, qp->remote_qpn, wc->status);
> +
> +	spin_lock(&dev->pending_lock);
> +	/* XXX What if its already removed by the timeout code? */
> +	if (qp->timerwait.next != LIST_POISON1)
> +		list_del(&qp->timerwait);
> +	if (qp->piowait.next != LIST_POISON1)
> +		list_del(&qp->piowait);
> +	spin_unlock(&dev->pending_lock);
> +
> +	ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
> +	if (++qp->s_last >= qp->s_size)
> +		qp->s_last = 0;
> +
> +	wc->status = IB_WC_WR_FLUSH_ERR;
> +
> +	while (qp->s_last != qp->s_head) {
> +		wc->wr_id = wqe->wr.wr_id;
> +		wc->opcode = wc_opcode[wqe->wr.opcode];
> +		ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
> +		if (++qp->s_last >= qp->s_size)
> +			qp->s_last = 0;
> +		wqe = get_swqe_ptr(qp, qp->s_last);
> +	}
> +	qp->s_cur = qp->s_tail = qp->s_head;
> +	qp->state = IB_QPS_SQE;
> +}
> +
> +/*
> + * Flush both send and receive work queues.
> + * QP r_rq.lock and s_lock should be held.
> + */
> +static void ipath_error_qp(struct ipath_qp *qp)
> +{
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	struct ib_wc wc;
> +
> +	_VERBS_INFO("QP%d/%d in error state\n",
> +		    qp->ibqp.qp_num, qp->remote_qpn);
> +
> +	spin_lock(&dev->pending_lock);
> +	/* XXX What if its already removed by the timeout code? */
> +	if (qp->timerwait.next != LIST_POISON1)
> +		list_del(&qp->timerwait);
> +	if (qp->piowait.next != LIST_POISON1)
> +		list_del(&qp->piowait);
> +	spin_unlock(&dev->pending_lock);
> +
> +	wc.status = IB_WC_WR_FLUSH_ERR;
> +	wc.vendor_err = 0;
> +	wc.byte_len = 0;
> +	wc.imm_data = 0;
> +	wc.qp_num = qp->ibqp.qp_num;
> +	wc.src_qp = 0;
> +	wc.wc_flags = 0;
> +	wc.pkey_index = 0;
> +	wc.slid = 0;
> +	wc.sl = 0;
> +	wc.dlid_path_bits = 0;
> +	wc.port_num = 0;
> +
> +	while (qp->s_last != qp->s_head) {
> +		struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
> +
> +		wc.wr_id = wqe->wr.wr_id;
> +		wc.opcode = wc_opcode[wqe->wr.opcode];
> +		if (++qp->s_last >= qp->s_size)
> +			qp->s_last = 0;
> +		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 1);
> +	}
> +	qp->s_cur = qp->s_tail = qp->s_head;
> +	qp->s_hdrwords = 0;
> +	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +
> +	wc.opcode = IB_WC_RECV;
> +	while (qp->r_rq.tail != qp->r_rq.head) {
> +		wc.wr_id = get_rwqe_ptr(&qp->r_rq, qp->r_rq.tail)->wr_id;
> +		if (++qp->r_rq.tail >= qp->r_rq.size)
> +			qp->r_rq.tail = 0;
> +		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc, 1);
> +	}
> +}
> +
> +static int ipath_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> +			   int attr_mask)
> +{
> +	struct ipath_qp *qp = to_iqp(ibqp);
> +	enum ib_qp_state cur_state, new_state;
> +	u32 req_param, opt_param;
> +	unsigned long flags;
> +
> +	if (attr_mask & IB_QP_CUR_STATE) {
> +		cur_state = attr->cur_qp_state;
> +		if (cur_state != IB_QPS_RTR &&
> +		    cur_state != IB_QPS_RTS &&
> +		    cur_state != IB_QPS_SQD && cur_state != IB_QPS_SQE)
> +			return -EINVAL;
> +		spin_lock_irqsave(&qp->r_rq.lock, flags);
> +		spin_lock(&qp->s_lock);
> +	} else {
> +		spin_lock_irqsave(&qp->r_rq.lock, flags);
> +		spin_lock(&qp->s_lock);
> +		cur_state = qp->state;
> +	}
> +
> +	if (attr_mask & IB_QP_STATE) {
> +		new_state = attr->qp_state;
> +		if (new_state < 0 || new_state > IB_QPS_ERR)
> +			goto inval;
> +	} else
> +		new_state = cur_state;
> +
> +	switch (qp_state_table[cur_state][new_state].trans) {
> +	case IPATH_TRANS_INVALID:
> +		goto inval;
> +
> +	case IPATH_TRANS_ANY2RST:
> +		ipath_reset_qp(qp);
> +		break;
> +
> +	case IPATH_TRANS_ANY2ERR:
> +		ipath_error_qp(qp);
> +		break;
> +
> +	}
> +
> +	req_param =
> +	    qp_state_table[cur_state][new_state].req_param[qp->ibqp.qp_type];
> +	opt_param =
> +	    qp_state_table[cur_state][new_state].opt_param[qp->ibqp.qp_type];
> +
> +	if ((req_param & attr_mask) != req_param)
> +		goto inval;
> +
> +	if (attr_mask & ~(req_param | opt_param | IB_QP_STATE))
> +		goto inval;
> +
> +	if (attr_mask & IB_QP_PKEY_INDEX) {
> +		struct ipath_ibdev *dev = to_idev(ibqp->device);
> +
> +		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->ib_unit))
> +			goto inval;
> +		qp->s_pkey_index = attr->pkey_index;
> +	}
> +
> +	if (attr_mask & IB_QP_DEST_QPN)
> +		qp->remote_qpn = attr->dest_qp_num;
> +
> +	if (attr_mask & IB_QP_SQ_PSN) {
> +		qp->s_next_psn = attr->sq_psn;
> +		qp->s_last_psn = qp->s_next_psn - 1;
> +	}
> +
> +	if (attr_mask & IB_QP_RQ_PSN)
> +		qp->r_psn = attr->rq_psn;
> +
> +	if (attr_mask & IB_QP_ACCESS_FLAGS)
> +		qp->qp_access_flags = attr->qp_access_flags;
> +
> +	if (attr_mask & IB_QP_AV)
> +		qp->remote_ah_attr = attr->ah_attr;
> +
> +	if (attr_mask & IB_QP_PATH_MTU)
> +		qp->path_mtu = attr->path_mtu;
> +
> +	if (attr_mask & IB_QP_RETRY_CNT)
> +		qp->s_retry = qp->s_retry_cnt = attr->retry_cnt;
> +
> +	if (attr_mask & IB_QP_RNR_RETRY) {
> +		qp->s_rnr_retry = attr->rnr_retry;
> +		if (qp->s_rnr_retry > 7)
> +			qp->s_rnr_retry = 7;
> +		qp->s_rnr_retry_cnt = qp->s_rnr_retry;
> +	}
> +
> +	if (attr_mask & IB_QP_MIN_RNR_TIMER)
> +		qp->s_min_rnr_timer = attr->min_rnr_timer & 0x1F;
> +
> +	if (attr_mask & IB_QP_QKEY)
> +		qp->qkey = attr->qkey;
> +
> +	if (attr_mask & IB_QP_PKEY_INDEX)
> +		qp->s_pkey_index = attr->pkey_index;
> +
> +	qp->state = new_state;
> +	spin_unlock(&qp->s_lock);
> +	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +
> +	/*
> +	 * Try to move to ARMED if QP1 changed to the RTS state.
> +	 */
> +	if (qp->ibqp.qp_num == 1 && new_state == IB_QPS_RTS) {
> +		struct ipath_ibdev *dev = to_idev(ibqp->device);
> +
> +		/*
> +		 * Bounce the link even if it was active so the SM will
> +		 * reinitialize the SMA's state.
> +		 */
> +		ipath_kset_linkstate((dev->ib_unit << 16) | IPATH_IB_LINKDOWN);
> +		ipath_kset_linkstate((dev->ib_unit << 16) | IPATH_IB_LINKARM);
> +	}
> +	return 0;
> +
> +inval:
> +	spin_unlock(&qp->s_lock);
> +	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +	return -EINVAL;
> +}
> +
> +/*
> + * Compute the AETH (syndrome + MSN).
> + * The QP s_lock should be held.
> + */
> +static u32 ipath_compute_aeth(struct ipath_qp *qp)
> +{
> +	u32 aeth = atomic_read(&qp->msn) & 0xFFFFFF;
> +
> +	if (qp->s_nak_state) {
> +		aeth |= qp->s_nak_state << 24;
> +	} else if (qp->ibqp.srq) {
> +		/* Shared receive queues don't generate credits. */
> +		aeth |= 0x1F << 24;
> +	} else {
> +		u32 min, max, x;
> +		u32 credits;
> +
> +		/*
> +		 * Compute the number of credits available (RWQEs).
> +		 * XXX Not holding the r_rq.lock here so there is a small
> +		 * chance that the pair of reads are not atomic.
> +		 */
> +		credits = qp->r_rq.head - qp->r_rq.tail;
> +		if ((int)credits < 0)
> +			credits += qp->r_rq.size;
> +		/* Binary search the credit table to find the code to use. */
> +		min = 0;
> +		max = 31;
> +		for (;;) {
> +			x = (min + max) / 2;
> +			if (credit_table[x] == credits)
> +				break;
> +			if (credit_table[x] > credits)
> +				max = x;
> +			else if (min == x)
> +				break;
> +			else
> +				min = x;
> +		}
> +		aeth |= x << 24;
> +	}
> +	return cpu_to_be32(aeth);
> +}
> +
> +
> +static void no_bufs_available(struct ipath_qp *qp, struct ipath_ibdev *dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->pending_lock, flags);
> +	if (qp->piowait.next == LIST_POISON1)
> +		list_add_tail(&qp->piowait, &dev->piowait);
> +	spin_unlock_irqrestore(&dev->pending_lock, flags);
> +	/*
> +	 * Note that as soon as ipath_layer_want_buffer() is called and
> +	 * possibly before it returns, ipath_ib_piobufavail()
> +	 * could be called.  If we are still in the tasklet function,
> +	 * tasklet_schedule() will not call us until the next time
> +	 * tasklet_schedule() is called.
> +	 * We clear the tasklet flag now since we are committing to return
> +	 * from the tasklet function.
> +	 */
> +	tasklet_unlock(&qp->s_task);
> +	ipath_layer_want_buffer(dev->ib_unit);
> +	dev->n_piowait++;
> +}
> +
> +/*
> + * Process entries in the send work queue until the queue is exhausted.
> + * Only allow one CPU to send a packet per QP (tasklet).
> + * Otherwise, after we drop the QP lock, two threads could send
> + * packets out of order.
> + * This is similar to do_rc_send() below except we don't have timeouts or
> + * resends.
> + */
> +static void do_uc_send(unsigned long data)
> +{
> +	struct ipath_qp *qp = (struct ipath_qp *)data;
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	struct ipath_swqe *wqe;
> +	unsigned long flags;
> +	u16 lrh0;
> +	u32 hwords;
> +	u32 nwords;
> +	u32 extra_bytes;
> +	u32 bth0;
> +	u32 bth2;
> +	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
> +	u32 len;
> +	struct ipath_other_headers *ohdr;
> +	struct ib_wc wc;
> +
> +	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
> +		return;
> +
> +	if (unlikely(qp->remote_ah_attr.dlid ==
> +		     ipath_layer_get_lid(dev->ib_unit))) {
> +		/* Pass in an uninitialized ib_wc to save stack space. */
> +		ipath_ruc_loopback(qp, &wc);
> +		clear_bit(IPATH_S_BUSY, &qp->s_flags);
> +		return;
> +	}
> +
> +	ohdr = &qp->s_hdr.u.oth;
> +	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
> +		ohdr = &qp->s_hdr.u.l.oth;
> +
> +again:
> +	/* Check for a constructed packet to be sent. */
> +	if (qp->s_hdrwords != 0) {
> +			/*
> +			 * If no PIO bufs are available, return.
> +			 * An interrupt will call ipath_ib_piobufavail()
> +			 * when one is available.
> +			 */
> +			if (ipath_verbs_send(dev->ib_unit, qp->s_hdrwords,
> +					     (uint32_t *) &qp->s_hdr,
> +					     qp->s_cur_size, qp->s_cur_sge)) {
> +				no_bufs_available(qp, dev);
> +				return;
> +			}
> +		/* Record that we sent the packet and s_hdr is empty. */
> +		qp->s_hdrwords = 0;
> +	}
> +
> +	lrh0 = IPS_LRH_BTH;
> +	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
> +	hwords = 5;
> +
> +	/*
> +	 * The lock is needed to synchronize between
> +	 * setting qp->s_ack_state and post_send().
> +	 */
> +	spin_lock_irqsave(&qp->s_lock, flags);
> +
> +	if (!(state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
> +		goto done;
> +
> +	bth0 = ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
> +
> +	/* Send a request. */
> +	wqe = get_swqe_ptr(qp, qp->s_last);
> +	switch (qp->s_state) {
> +	default:
> +		/* Signal the completion of the last send (if there is one). */
> +		if (qp->s_last != qp->s_tail) {
> +			if (++qp->s_last == qp->s_size)
> +				qp->s_last = 0;
> +			if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
> +			    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
> +				wc.wr_id = wqe->wr.wr_id;
> +				wc.status = IB_WC_SUCCESS;
> +				wc.opcode = wc_opcode[wqe->wr.opcode];
> +				wc.vendor_err = 0;
> +				wc.byte_len = wqe->length;
> +				wc.qp_num = qp->ibqp.qp_num;
> +				wc.src_qp = qp->remote_qpn;
> +				wc.pkey_index = 0;
> +				wc.slid = qp->remote_ah_attr.dlid;
> +				wc.sl = qp->remote_ah_attr.sl;
> +				wc.dlid_path_bits = 0;
> +				wc.port_num = 0;
> +				ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc,
> +					       0);
> +			}
> +			wqe = get_swqe_ptr(qp, qp->s_last);
> +		}
> +		/* Check if send work queue is empty. */
> +		if (qp->s_tail == qp->s_head)
> +			goto done;
> +		/*
> +		 * Start a new request.
> +		 */
> +		qp->s_psn = wqe->psn = qp->s_next_psn;
> +		qp->s_sge.sge = wqe->sg_list[0];
> +		qp->s_sge.sg_list = wqe->sg_list + 1;
> +		qp->s_sge.num_sge = wqe->wr.num_sge;
> +		qp->s_len = len = wqe->length;
> +		switch (wqe->wr.opcode) {
> +		case IB_WR_SEND:
> +		case IB_WR_SEND_WITH_IMM:
> +			if (len > pmtu) {
> +				qp->s_state = IB_OPCODE_UC_SEND_FIRST;
> +				len = pmtu;
> +				break;
> +			}
> +			if (wqe->wr.opcode == IB_WR_SEND) {
> +				qp->s_state = IB_OPCODE_UC_SEND_ONLY;
> +			} else {
> +				qp->s_state =
> +				    IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE;
> +				/* Immediate data comes after the BTH */
> +				ohdr->u.imm_data = wqe->wr.imm_data;
> +				hwords += 1;
> +			}
> +			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +				bth0 |= 1 << 23;
> +			break;
> +
> +		case IB_WR_RDMA_WRITE:
> +		case IB_WR_RDMA_WRITE_WITH_IMM:
> +			ohdr->u.rc.reth.vaddr =
> +			    cpu_to_be64(wqe->wr.wr.rdma.remote_addr);
> +			ohdr->u.rc.reth.rkey =
> +			    cpu_to_be32(wqe->wr.wr.rdma.rkey);
> +			ohdr->u.rc.reth.length = cpu_to_be32(len);
> +			hwords += sizeof(struct ib_reth) / 4;
> +			if (len > pmtu) {
> +				qp->s_state = IB_OPCODE_UC_RDMA_WRITE_FIRST;
> +				len = pmtu;
> +				break;
> +			}
> +			if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
> +				qp->s_state = IB_OPCODE_UC_RDMA_WRITE_ONLY;
> +			} else {
> +				qp->s_state =
> +				    IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE;
> +				/* Immediate data comes after the RETH */
> +				ohdr->u.rc.imm_data = wqe->wr.imm_data;
> +				hwords += 1;
> +				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +					bth0 |= 1 << 23;
> +			}
> +			break;
> +
> +		default:
> +			goto done;
> +		}
> +		if (++qp->s_tail >= qp->s_size)
> +			qp->s_tail = 0;
> +		break;
> +
> +	case IB_OPCODE_UC_SEND_FIRST:
> +		qp->s_state = IB_OPCODE_UC_SEND_MIDDLE;
> +		/* FALLTHROUGH */
> +	case IB_OPCODE_UC_SEND_MIDDLE:
> +		len = qp->s_len;
> +		if (len > pmtu) {
> +			len = pmtu;
> +			break;
> +		}
> +		if (wqe->wr.opcode == IB_WR_SEND)
> +			qp->s_state = IB_OPCODE_UC_SEND_LAST;
> +		else {
> +			qp->s_state = IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE;
> +			/* Immediate data comes after the BTH */
> +			ohdr->u.imm_data = wqe->wr.imm_data;
> +			hwords += 1;
> +		}
> +		if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +			bth0 |= 1 << 23;
> +		break;
> +
> +	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
> +		qp->s_state = IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
> +		/* FALLTHROUGH */
> +	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
> +		len = qp->s_len;
> +		if (len > pmtu) {
> +			len = pmtu;
> +			break;
> +		}
> +		if (wqe->wr.opcode == IB_WR_RDMA_WRITE)
> +			qp->s_state = IB_OPCODE_UC_RDMA_WRITE_LAST;
> +		else {
> +			qp->s_state =
> +			    IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE;
> +			/* Immediate data comes after the BTH */
> +			ohdr->u.imm_data = wqe->wr.imm_data;
> +			hwords += 1;
> +			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +				bth0 |= 1 << 23;
> +		}
> +		break;
> +	}
> +	bth2 = qp->s_next_psn++ & 0xFFFFFF;
> +	qp->s_len -= len;
> +	bth0 |= qp->s_state << 24;
> +
> +	spin_unlock_irqrestore(&qp->s_lock, flags);
> +
> +	/* Construct the header. */
> +	extra_bytes = (4 - len) & 3;
> +	nwords = (len + extra_bytes) >> 2;
> +	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
> +		/* Header size in 32-bit words. */
> +		hwords += 10;
> +		lrh0 = IPS_LRH_GRH;
> +		qp->s_hdr.u.l.grh.version_tclass_flow =
> +		    cpu_to_be32((6 << 28) |
> +				(qp->remote_ah_attr.grh.traffic_class << 20) |
> +				qp->remote_ah_attr.grh.flow_label);
> +		qp->s_hdr.u.l.grh.paylen =
> +		    cpu_to_be16(((hwords - 12) + nwords + SIZE_OF_CRC) << 2);
> +		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
> +		qp->s_hdr.u.l.grh.hop_limit = qp->remote_ah_attr.grh.hop_limit;
> +		/* The SGID is 32-bit aligned. */
> +		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
> +		qp->s_hdr.u.l.grh.sgid.global.interface_id =
> +		    ipath_layer_get_guid(dev->ib_unit);
> +		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
> +	}
> +	qp->s_hdrwords = hwords;
> +	qp->s_cur_sge = &qp->s_sge;
> +	qp->s_cur_size = len;
> +	lrh0 |= qp->remote_ah_attr.sl << 4;
> +	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
> +	/* DEST LID */
> +	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
> +	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
> +	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->ib_unit));
> +	bth0 |= extra_bytes << 20;
> +	ohdr->bth[0] = cpu_to_be32(bth0);
> +	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
> +	ohdr->bth[2] = cpu_to_be32(bth2);
> +
> +	/* Check for more work to do. */
> +	goto again;
> +
> +done:
> +	spin_unlock_irqrestore(&qp->s_lock, flags);
> +	clear_bit(IPATH_S_BUSY, &qp->s_flags);
> +}
> +
> +/*
> + * Process entries in the send work queue until credit or queue is exhausted.
> + * Only allow one CPU to send a packet per QP (tasklet).
> + * Otherwise, after we drop the QP s_lock, two threads could send
> + * packets out of order.
> + */
> +static void do_rc_send(unsigned long data)
> +{
> +	struct ipath_qp *qp = (struct ipath_qp *)data;
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	struct ipath_swqe *wqe;
> +	struct ipath_sge_state *ss;
> +	unsigned long flags;
> +	u16 lrh0;
> +	u32 hwords;
> +	u32 nwords;
> +	u32 extra_bytes;
> +	u32 bth0;
> +	u32 bth2;
> +	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
> +	u32 len;
> +	struct ipath_other_headers *ohdr;
> +	char newreq;
> +
> +	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
> +		return;
> +
> +	if (unlikely(qp->remote_ah_attr.dlid ==
> +		     ipath_layer_get_lid(dev->ib_unit))) {
> +		struct ib_wc wc;
> +
> +		/*
> +		 * Pass in an uninitialized ib_wc to be consistent with
> +		 * other places where ipath_ruc_loopback() is called.
> +		 */
> +		ipath_ruc_loopback(qp, &wc);
> +		clear_bit(IPATH_S_BUSY, &qp->s_flags);
> +		return;
> +	}
> +
> +	ohdr = &qp->s_hdr.u.oth;
> +	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
> +		ohdr = &qp->s_hdr.u.l.oth;
> +
> +again:
> +	/* Check for a constructed packet to be sent. */
> +	if (qp->s_hdrwords != 0) {
> +			/*
> +			 * If no PIO bufs are available, return.
> +			 * An interrupt will call ipath_ib_piobufavail()
> +			 * when one is available.
> +			 */
> +			if (ipath_verbs_send(dev->ib_unit, qp->s_hdrwords,
> +					     (uint32_t *) &qp->s_hdr,
> +					     qp->s_cur_size, qp->s_cur_sge)) {
> +				no_bufs_available(qp, dev);
> +				return;
> +			}
> +		/* Record that we sent the packet and s_hdr is empty. */
> +		qp->s_hdrwords = 0;
> +	}
> +
> +	lrh0 = IPS_LRH_BTH;
> +	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
> +	hwords = 5;
> +
> +	/*
> +	 * The lock is needed to synchronize between
> +	 * setting qp->s_ack_state, resend timer, and post_send().
> +	 */
> +	spin_lock_irqsave(&qp->s_lock, flags);
> +
> +	bth0 = ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
> +
> +	/* Sending responses has higher priority over sending requests. */
> +	if (qp->s_ack_state != IB_OPCODE_RC_ACKNOWLEDGE) {
> +		/*
> +		 * Send a response.
> +		 * Note that we are in the responder's side of the QP context.
> +		 */
> +		switch (qp->s_ack_state) {
> +		case IB_OPCODE_RC_RDMA_READ_REQUEST:
> +			ss = &qp->s_rdma_sge;
> +			len = qp->s_rdma_len;
> +			if (len > pmtu) {
> +				len = pmtu;
> +				qp->s_ack_state =
> +				    IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
> +			} else {
> +				qp->s_ack_state =
> +				    IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;
> +			}
> +			qp->s_rdma_len -= len;
> +			bth0 |= qp->s_ack_state << 24;
> +			ohdr->u.aeth = ipath_compute_aeth(qp);
> +			hwords++;
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
> +			qp->s_ack_state =
> +			    IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
> +			/* FALLTHROUGH */
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
> +			ss = &qp->s_rdma_sge;
> +			len = qp->s_rdma_len;
> +			if (len > pmtu) {
> +				len = pmtu;
> +			} else {
> +				ohdr->u.aeth = ipath_compute_aeth(qp);
> +				hwords++;
> +				qp->s_ack_state =
> +				    IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
> +			}
> +			qp->s_rdma_len -= len;
> +			bth0 |= qp->s_ack_state << 24;
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
> +			/*
> +			 * We have to prevent new requests from changing
> +			 * the r_sge state while a ipath_verbs_send()
> +			 * is in progress.
> +			 * Changing r_state allows the receiver
> +			 * to continue processing new packets.
> +			 * We do it here now instead of above so
> +			 * that we are sure the packet was sent before
> +			 * changing the state.
> +			 */
> +			qp->r_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
> +			qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +			goto send_req;
> +
> +		case IB_OPCODE_RC_COMPARE_SWAP:
> +		case IB_OPCODE_RC_FETCH_ADD:
> +			ss = NULL;
> +			len = 0;
> +			qp->r_state = IB_OPCODE_RC_SEND_LAST;
> +			qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +			bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
> +			ohdr->u.at.aeth = ipath_compute_aeth(qp);
> +			ohdr->u.at.atomic_ack_eth =
> +			    cpu_to_be64(qp->s_ack_atomic);
> +			hwords += sizeof(ohdr->u.at) / 4;
> +			break;
> +
> +		default:
> +			/* Send a regular ACK. */
> +			ss = NULL;
> +			len = 0;
> +			qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +			bth0 |= qp->s_ack_state << 24;
> +			ohdr->u.aeth = ipath_compute_aeth(qp);
> +			hwords++;
> +		}
> +		bth2 = qp->s_ack_psn++ & 0xFFFFFF;
> +	} else {
> +	      send_req:
> +		if (!(state_ops[qp->state] & IPATH_PROCESS_SEND_OK) ||
> +		    qp->s_rnr_timeout)
> +			goto done;
> +
> +		/* Send a request. */
> +		wqe = get_swqe_ptr(qp, qp->s_cur);
> +		switch (qp->s_state) {
> +		default:
> +			/*
> +			 * Resend an old request or start a new one.
> +			 *
> +			 * We keep track of the current SWQE so that
> +			 * we don't reset the "furthest progress" state
> +			 * if we need to back up.
> +			 */
> +			newreq = 0;
> +			if (qp->s_cur == qp->s_tail) {
> +				/* Check if send work queue is empty. */
> +				if (qp->s_tail == qp->s_head)
> +					goto done;
> +				qp->s_psn = wqe->psn = qp->s_next_psn;
> +				newreq = 1;
> +			}
> +			/*
> +			 * Note that we have to be careful not to modify the
> +			 * original work request since we may need to resend
> +			 * it.
> +			 */
> +			qp->s_sge.sge = wqe->sg_list[0];
> +			qp->s_sge.sg_list = wqe->sg_list + 1;
> +			qp->s_sge.num_sge = wqe->wr.num_sge;
> +			qp->s_len = len = wqe->length;
> +			ss = &qp->s_sge;
> +			bth2 = 0;
> +			switch (wqe->wr.opcode) {
> +			case IB_WR_SEND:
> +			case IB_WR_SEND_WITH_IMM:
> +				/* If no credit, return. */
> +				if (qp->s_lsn != (u32) -1 &&
> +				    cmp24(wqe->ssn, qp->s_lsn + 1) > 0) {
> +					goto done;
> +				}
> +				wqe->lpsn = wqe->psn;
> +				if (len > pmtu) {
> +					wqe->lpsn += (len - 1) / pmtu;
> +					qp->s_state = IB_OPCODE_RC_SEND_FIRST;
> +					len = pmtu;
> +					break;
> +				}
> +				if (wqe->wr.opcode == IB_WR_SEND) {
> +					qp->s_state = IB_OPCODE_RC_SEND_ONLY;
> +				} else {
> +					qp->s_state =
> +					    IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE;
> +					/* Immediate data comes after the BTH */
> +					ohdr->u.imm_data = wqe->wr.imm_data;
> +					hwords += 1;
> +				}
> +				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +					bth0 |= 1 << 23;
> +				bth2 = 1 << 31;	/* Request ACK. */
> +				if (++qp->s_cur == qp->s_size)
> +					qp->s_cur = 0;
> +				break;
> +
> +			case IB_WR_RDMA_WRITE:
> +				if (newreq)
> +					qp->s_lsn++;
> +				/* FALLTHROUGH */
> +			case IB_WR_RDMA_WRITE_WITH_IMM:
> +				/* If no credit, return. */
> +				if (qp->s_lsn != (u32) -1 &&
> +				    cmp24(wqe->ssn, qp->s_lsn + 1) > 0) {
> +					goto done;
> +				}
> +				ohdr->u.rc.reth.vaddr =
> +				    cpu_to_be64(wqe->wr.wr.rdma.remote_addr);
> +				ohdr->u.rc.reth.rkey =
> +				    cpu_to_be32(wqe->wr.wr.rdma.rkey);
> +				ohdr->u.rc.reth.length = cpu_to_be32(len);
> +				hwords += sizeof(struct ib_reth) / 4;
> +				wqe->lpsn = wqe->psn;
> +				if (len > pmtu) {
> +					wqe->lpsn += (len - 1) / pmtu;
> +					qp->s_state =
> +					    IB_OPCODE_RC_RDMA_WRITE_FIRST;
> +					len = pmtu;
> +					break;
> +				}
> +				if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
> +					qp->s_state =
> +					    IB_OPCODE_RC_RDMA_WRITE_ONLY;
> +				} else {
> +					qp->s_state =
> +					    IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE;
> +					/* Immediate data comes after RETH */
> +					ohdr->u.rc.imm_data = wqe->wr.imm_data;
> +					hwords += 1;
> +					if (wqe->wr.
> +					    send_flags & IB_SEND_SOLICITED)
> +						bth0 |= 1 << 23;
> +				}
> +				bth2 = 1 << 31;	/* Request ACK. */
> +				if (++qp->s_cur == qp->s_size)
> +					qp->s_cur = 0;
> +				break;
> +
> +			case IB_WR_RDMA_READ:
> +				ohdr->u.rc.reth.vaddr =
> +				    cpu_to_be64(wqe->wr.wr.rdma.remote_addr);
> +				ohdr->u.rc.reth.rkey =
> +				    cpu_to_be32(wqe->wr.wr.rdma.rkey);
> +				ohdr->u.rc.reth.length = cpu_to_be32(len);
> +				qp->s_state = IB_OPCODE_RC_RDMA_READ_REQUEST;
> +				hwords += sizeof(ohdr->u.rc.reth) / 4;
> +				if (newreq) {
> +					qp->s_lsn++;
> +					/*
> +					 * Adjust s_next_psn to count the
> +					 * expected number of responses.
> +					 */
> +					if (len > pmtu)
> +						qp->s_next_psn +=
> +						    (len - 1) / pmtu;
> +					wqe->lpsn = qp->s_next_psn++;
> +				}
> +				ss = NULL;
> +				len = 0;
> +				if (++qp->s_cur == qp->s_size)
> +					qp->s_cur = 0;
> +				break;
> +
> +			case IB_WR_ATOMIC_CMP_AND_SWP:
> +			case IB_WR_ATOMIC_FETCH_AND_ADD:
> +				qp->s_state =
> +				    wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ?
> +				    IB_OPCODE_RC_COMPARE_SWAP :
> +				    IB_OPCODE_RC_FETCH_ADD;
> +				ohdr->u.atomic_eth.vaddr =
> +				    cpu_to_be64(wqe->wr.wr.atomic.remote_addr);
> +				ohdr->u.atomic_eth.rkey =
> +				    cpu_to_be32(wqe->wr.wr.atomic.rkey);
> +				ohdr->u.atomic_eth.swap_data =
> +				    cpu_to_be64(wqe->wr.wr.atomic.swap);
> +				ohdr->u.atomic_eth.compare_data =
> +				    cpu_to_be64(wqe->wr.wr.atomic.compare_add);
> +				hwords += sizeof(struct ib_atomic_eth) / 4;
> +				if (newreq) {
> +					qp->s_lsn++;
> +					wqe->lpsn = wqe->psn;
> +				}
> +				if (++qp->s_cur == qp->s_size)
> +					qp->s_cur = 0;
> +				ss = NULL;
> +				len = 0;
> +				break;
> +
> +			default:
> +				goto done;
> +			}
> +			if (newreq) {
> +				if (++qp->s_tail >= qp->s_size)
> +					qp->s_tail = 0;
> +			}
> +			bth2 |= qp->s_psn++ & 0xFFFFFF;
> +			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
> +				qp->s_next_psn = qp->s_psn;
> +			spin_lock(&dev->pending_lock);
> +			if (qp->timerwait.next == LIST_POISON1) {
> +				list_add_tail(&qp->timerwait,
> +					      &dev->pending[dev->
> +							    pending_index]);
> +			}
> +			spin_unlock(&dev->pending_lock);
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
> +			/*
> +			 * This case can only happen if a send is
> +			 * restarted.  See ipath_restart_rc().
> +			 */
> +			ipath_init_restart(qp, wqe);
> +			/* FALLTHROUGH */
> +		case IB_OPCODE_RC_SEND_FIRST:
> +			qp->s_state = IB_OPCODE_RC_SEND_MIDDLE;
> +			/* FALLTHROUGH */
> +		case IB_OPCODE_RC_SEND_MIDDLE:
> +			bth2 = qp->s_psn++ & 0xFFFFFF;
> +			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
> +				qp->s_next_psn = qp->s_psn;
> +			ss = &qp->s_sge;
> +			len = qp->s_len;
> +			if (len > pmtu) {
> +				/*
> +				 * Request an ACK every 1/2 MB to avoid
> +				 * retransmit timeouts.
> +				 */
> +				if (((wqe->length - len) % (512 * 1024)) == 0)
> +					bth2 |= 1 << 31;
> +				len = pmtu;
> +				break;
> +			}
> +			if (wqe->wr.opcode == IB_WR_SEND)
> +				qp->s_state = IB_OPCODE_RC_SEND_LAST;
> +			else {
> +				qp->s_state =
> +				    IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE;
> +				/* Immediate data comes after the BTH */
> +				ohdr->u.imm_data = wqe->wr.imm_data;
> +				hwords += 1;
> +			}
> +			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +				bth0 |= 1 << 23;
> +			bth2 |= 1 << 31;	/* Request ACK. */
> +			if (++qp->s_cur >= qp->s_size)
> +				qp->s_cur = 0;
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
> +			/*
> +			 * This case can only happen if a RDMA write is
> +			 * restarted.  See ipath_restart_rc().
> +			 */
> +			ipath_init_restart(qp, wqe);
> +			/* FALLTHROUGH */
> +		case IB_OPCODE_RC_RDMA_WRITE_FIRST:
> +			qp->s_state = IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
> +			/* FALLTHROUGH */
> +		case IB_OPCODE_RC_RDMA_WRITE_MIDDLE:
> +			bth2 = qp->s_psn++ & 0xFFFFFF;
> +			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
> +				qp->s_next_psn = qp->s_psn;
> +			ss = &qp->s_sge;
> +			len = qp->s_len;
> +			if (len > pmtu) {
> +				/*
> +				 * Request an ACK every 1/2 MB to avoid
> +				 * retransmit timeouts.
> +				 */
> +				if (((wqe->length - len) % (512 * 1024)) == 0)
> +					bth2 |= 1 << 31;
> +				len = pmtu;
> +				break;
> +			}
> +			if (wqe->wr.opcode == IB_WR_RDMA_WRITE)
> +				qp->s_state = IB_OPCODE_RC_RDMA_WRITE_LAST;
> +			else {
> +				qp->s_state =
> +				    IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE;
> +				/* Immediate data comes after the BTH */
> +				ohdr->u.imm_data = wqe->wr.imm_data;
> +				hwords += 1;
> +				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
> +					bth0 |= 1 << 23;
> +			}
> +			bth2 |= 1 << 31;	/* Request ACK. */
> +			if (++qp->s_cur >= qp->s_size)
> +				qp->s_cur = 0;
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
> +			/*
> +			 * This case can only happen if a RDMA read is
> +			 * restarted.  See ipath_restart_rc().
> +			 */
> +			ipath_init_restart(qp, wqe);
> +			len = ((qp->s_psn - wqe->psn) & 0xFFFFFF) * pmtu;
> +			ohdr->u.rc.reth.vaddr =
> +			    cpu_to_be64(wqe->wr.wr.rdma.remote_addr + len);
> +			ohdr->u.rc.reth.rkey =
> +			    cpu_to_be32(wqe->wr.wr.rdma.rkey);
> +			ohdr->u.rc.reth.length = cpu_to_be32(qp->s_len);
> +			qp->s_state = IB_OPCODE_RC_RDMA_READ_REQUEST;
> +			hwords += sizeof(ohdr->u.rc.reth) / 4;
> +			bth2 = qp->s_psn++ & 0xFFFFFF;
> +			if ((int)(qp->s_psn - qp->s_next_psn) > 0)
> +				qp->s_next_psn = qp->s_psn;
> +			ss = NULL;
> +			len = 0;
> +			if (++qp->s_cur == qp->s_size)
> +				qp->s_cur = 0;
> +			break;
> +
> +		case IB_OPCODE_RC_RDMA_READ_REQUEST:
> +		case IB_OPCODE_RC_COMPARE_SWAP:
> +		case IB_OPCODE_RC_FETCH_ADD:
> +			/*
> +			 * We shouldn't start anything new until this request
> +			 * is finished.  The ACK will handle rescheduling us.
> +			 * XXX The number of outstanding ones is negotiated
> +			 * at connection setup time (see pg. 258,289)?
> +			 * XXX Also, if we support multiple outstanding
> +			 * requests, we need to check the WQE IB_SEND_FENCE
> +			 * flag and not send a new request if a RDMA read or
> +			 * atomic is pending.
> +			 */
> +			goto done;
> +		}
> +		qp->s_len -= len;
> +		bth0 |= qp->s_state << 24;
> +		/* XXX queue resend timeout. */
> +	}
> +	/* Make sure it is non-zero before dropping the lock. */
> +	qp->s_hdrwords = hwords;
> +	spin_unlock_irqrestore(&qp->s_lock, flags);
> +
> +	/* Construct the header. */
> +	extra_bytes = (4 - len) & 3;
> +	nwords = (len + extra_bytes) >> 2;
> +	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
> +		/* Header size in 32-bit words. */
> +		hwords += 10;
> +		lrh0 = IPS_LRH_GRH;
> +		qp->s_hdr.u.l.grh.version_tclass_flow =
> +		    cpu_to_be32((6 << 28) |
> +				(qp->remote_ah_attr.grh.traffic_class << 20) |
> +				qp->remote_ah_attr.grh.flow_label);
> +		qp->s_hdr.u.l.grh.paylen =
> +		    cpu_to_be16(((hwords - 12) + nwords + SIZE_OF_CRC) << 2);
> +		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
> +		qp->s_hdr.u.l.grh.hop_limit = qp->remote_ah_attr.grh.hop_limit;
> +		/* The SGID is 32-bit aligned. */
> +		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
> +		qp->s_hdr.u.l.grh.sgid.global.interface_id =
> +		    ipath_layer_get_guid(dev->ib_unit);
> +		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
> +		qp->s_hdrwords = hwords;
> +	}
> +	qp->s_cur_sge = ss;
> +	qp->s_cur_size = len;
> +	lrh0 |= qp->remote_ah_attr.sl << 4;
> +	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
> +	/* DEST LID */
> +	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
> +	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
> +	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->ib_unit));
> +	bth0 |= extra_bytes << 20;
> +	ohdr->bth[0] = cpu_to_be32(bth0);
> +	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
> +	ohdr->bth[2] = cpu_to_be32(bth2);
> +
> +	/* Check for more work to do. */
> +	goto again;
> +
> +done:
> +	spin_unlock_irqrestore(&qp->s_lock, flags);
> +	clear_bit(IPATH_S_BUSY, &qp->s_flags);
> +}
> +
> +static void send_rc_ack(struct ipath_qp *qp)
> +{
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	u16 lrh0;
> +	u32 bth0;
> +	u32 hwords;
> +	struct ipath_other_headers *ohdr;
> +
> +	/* Construct the header. */
> +	ohdr = &qp->s_hdr.u.oth;
> +	lrh0 = IPS_LRH_BTH;
> +	/* header size in 32-bit words LRH+BTH+AETH = (8+12+4)/4. */
> +	hwords = 6;
> +	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
> +		ohdr = &qp->s_hdr.u.l.oth;
> +		/* Header size in 32-bit words. */
> +		hwords += 10;
> +		lrh0 = IPS_LRH_GRH;
> +		qp->s_hdr.u.l.grh.version_tclass_flow =
> +		    cpu_to_be32((6 << 28) |
> +				(qp->remote_ah_attr.grh.traffic_class << 20) |
> +				qp->remote_ah_attr.grh.flow_label);
> +		qp->s_hdr.u.l.grh.paylen =
> +		    cpu_to_be16(((hwords - 12) + SIZE_OF_CRC) << 2);
> +		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
> +		qp->s_hdr.u.l.grh.hop_limit = qp->remote_ah_attr.grh.hop_limit;
> +		/* The SGID is 32-bit aligned. */
> +		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
> +		qp->s_hdr.u.l.grh.sgid.global.interface_id =
> +		    ipath_layer_get_guid(dev->ib_unit);
> +		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
> +	}
> +	bth0 = ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
> +	ohdr->u.aeth = ipath_compute_aeth(qp);
> +	if (qp->s_ack_state >= IB_OPCODE_RC_COMPARE_SWAP) {
> +		bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
> +		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
> +		hwords += sizeof(ohdr->u.at.atomic_ack_eth) / 4;
> +	} else {
> +		bth0 |= IB_OPCODE_RC_ACKNOWLEDGE << 24;
> +	}
> +	lrh0 |= qp->remote_ah_attr.sl << 4;
> +	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
> +	/* DEST LID */
> +	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
> +	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + SIZE_OF_CRC);
> +	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->ib_unit));
> +	ohdr->bth[0] = cpu_to_be32(bth0);
> +	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
> +	ohdr->bth[2] = cpu_to_be32(qp->s_ack_psn & 0xFFFFFF);
> +
> +	/*
> +	 * If we can send the ACK, clear the ACK state.
> +	 */
> +	if (ipath_verbs_send(dev->ib_unit, hwords, (uint32_t *) &qp->s_hdr,
> +			     0, NULL) == 0) {
> +		qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
> +		dev->n_rc_qacks++;
> +	}
> +}
> +
> +/*
> + * Back up the requester to resend the last un-ACKed request.
> + * The QP s_lock should be held.
> + */
> +static void ipath_restart_rc(struct ipath_qp *qp, u32 psn, struct ib_wc *wc)
> +{
> +	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
> +	struct ipath_ibdev *dev;
> +	u32 n;
> +
> +	/*
> +	 * If there are no requests pending, we are done.
> +	 */
> +	if (cmp24(psn, qp->s_next_psn) >= 0 || qp->s_last == qp->s_tail)
> +		goto done;
> +
> +	if (qp->s_retry == 0) {
> +		wc->wr_id = wqe->wr.wr_id;
> +		wc->status = IB_WC_RETRY_EXC_ERR;
> +		wc->opcode = wc_opcode[wqe->wr.opcode];
> +		wc->vendor_err = 0;
> +		wc->byte_len = 0;
> +		wc->qp_num = qp->ibqp.qp_num;
> +		wc->src_qp = qp->remote_qpn;
> +		wc->pkey_index = 0;
> +		wc->slid = qp->remote_ah_attr.dlid;
> +		wc->sl = qp->remote_ah_attr.sl;
> +		wc->dlid_path_bits = 0;
> +		wc->port_num = 0;
> +		ipath_sqerror_qp(qp, wc);
> +		return;
> +	}
> +	qp->s_retry--;
> +
> +	/*
> +	 * Remove the QP from the timeout queue.
> +	 * Note: it may already have been removed by ipath_ib_timer().
> +	 */
> +	dev = to_idev(qp->ibqp.device);
> +	spin_lock(&dev->pending_lock);
> +	if (qp->timerwait.next != LIST_POISON1)
> +		list_del(&qp->timerwait);
> +	spin_unlock(&dev->pending_lock);
> +
> +	if (wqe->wr.opcode == IB_WR_RDMA_READ)
> +		dev->n_rc_resends++;
> +	else
> +		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
> +
> +	/*
> +	 * If we are starting the request from the beginning, let the
> +	 * normal send code handle initialization.
> +	 */
> +	qp->s_cur = qp->s_last;
> +	if (cmp24(psn, wqe->psn) <= 0) {
> +		qp->s_state = IB_OPCODE_RC_SEND_LAST;
> +		qp->s_psn = wqe->psn;
> +	} else {
> +		n = qp->s_cur;
> +		for (;;) {
> +			if (++n == qp->s_size)
> +				n = 0;
> +			if (n == qp->s_tail) {
> +				if (cmp24(psn, qp->s_next_psn) >= 0) {
> +					qp->s_cur = n;
> +					wqe = get_swqe_ptr(qp, n);
> +				}
> +				break;
> +			}
> +			wqe = get_swqe_ptr(qp, n);
> +			if (cmp24(psn, wqe->psn) < 0)
> +				break;
> +			qp->s_cur = n;
> +		}
> +		qp->s_psn = psn;
> +
> +		/*
> +		 * Reset the state to restart in the middle of a request.
> +		 * Don't change the s_sge, s_cur_sge, or s_cur_size.
> +		 * See do_rc_send().
> +		 */
> +		switch (wqe->wr.opcode) {
> +		case IB_WR_SEND:
> +		case IB_WR_SEND_WITH_IMM:
> +			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
> +			break;
> +
> +		case IB_WR_RDMA_WRITE:
> +		case IB_WR_RDMA_WRITE_WITH_IMM:
> +			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
> +			break;
> +
> +		case IB_WR_RDMA_READ:
> +			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
> +			break;
> +
> +		default:
> +			/*
> +			 * This case shouldn't happen since its only
> +			 * one PSN per req.
> +			 */
> +			qp->s_state = IB_OPCODE_RC_SEND_LAST;
> +		}
> +	}
> +
> +done:
> +	tasklet_schedule(&qp->s_task);
> +}
> +
> +/*
> + * Handle RC and UC post sends.
> + */
> +static int ipath_post_rc_send(struct ipath_qp *qp, struct ib_send_wr *wr)
> +{
> +	struct ipath_swqe *wqe;
> +	unsigned long flags;
> +	u32 next;
> +	int i, j;
> +	int acc;
> +
> +	/*
> +	 * Don't allow RDMA reads or atomic operations on UC or
> +	 * undefined operations.
> +	 * Make sure buffer is large enough to hold the result for atomics.
> +	 */
> +	if (qp->ibqp.qp_type == IB_QPT_UC) {
> +		if ((unsigned) wr->opcode >= IB_WR_RDMA_READ)
> +			return -EINVAL;
> +	} else if ((unsigned) wr->opcode > IB_WR_ATOMIC_FETCH_AND_ADD)
> +		return -EINVAL;
> +	else if (wr->opcode >= IB_WR_ATOMIC_CMP_AND_SWP &&
> +		 (wr->num_sge == 0 || wr->sg_list[0].length < sizeof(u64) ||
> +		  wr->sg_list[0].addr & 0x7))
> +		return -EINVAL;
> +
> +	/* IB spec says that num_sge == 0 is OK. */
> +	if (wr->num_sge > qp->s_max_sge)
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&qp->s_lock, flags);
> +	next = qp->s_head + 1;
> +	if (next >= qp->s_size)
> +		next = 0;
> +	if (next == qp->s_last) {
> +		spin_unlock_irqrestore(&qp->s_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	wqe = get_swqe_ptr(qp, qp->s_head);
> +	wqe->wr = *wr;
> +	wqe->ssn = qp->s_ssn++;
> +	wqe->sg_list[0].mr = NULL;
> +	wqe->sg_list[0].vaddr = NULL;
> +	wqe->sg_list[0].length = 0;
> +	wqe->sg_list[0].sge_length = 0;
> +	wqe->length = 0;
> +	acc = wr->opcode >= IB_WR_RDMA_READ ? IB_ACCESS_LOCAL_WRITE : 0;
> +	for (i = 0, j = 0; i < wr->num_sge; i++) {
> +		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0) {
> +			spin_unlock_irqrestore(&qp->s_lock, flags);
> +			return -EINVAL;
> +		}
> +		if (wr->sg_list[i].length == 0)
> +			continue;
> +		if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
> +				   &wqe->sg_list[j], &wr->sg_list[i], acc)) {
> +			spin_unlock_irqrestore(&qp->s_lock, flags);
> +			return -EINVAL;
> +		}
> +		wqe->length += wr->sg_list[i].length;
> +		j++;
> +	}
> +	wqe->wr.num_sge = j;
> +	qp->s_head = next;
> +	/*
> +	 * Wake up the send tasklet if the QP is not waiting
> +	 * for an RNR timeout.
> +	 */
> +	next = qp->s_rnr_timeout;
> +	spin_unlock_irqrestore(&qp->s_lock, flags);
> +
> +	if (next == 0) {
> +		if (qp->ibqp.qp_type == IB_QPT_UC)
> +			do_uc_send((unsigned long) qp);
> +		else
> +			do_rc_send((unsigned long) qp);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Note that we actually send the data as it is posted instead of putting
> + * the request into a ring buffer.  If we wanted to use a ring buffer,
> + * we would need to save a reference to the destination address in the SWQE.
> + */
> +static int ipath_post_ud_send(struct ipath_qp *qp, struct ib_send_wr *wr)
> +{
> +	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
> +	struct ipath_other_headers *ohdr;
> +	struct ib_ah_attr *ah_attr;
> +	struct ipath_sge_state ss;
> +	struct ipath_sge *sg_list;
> +	struct ib_wc wc;
> +	u32 hwords;
> +	u32 nwords;
> +	u32 len;
> +	u32 extra_bytes;
> +	u32 bth0;
> +	u16 lrh0;
> +	u16 lid;
> +	int i;
> +
> +	if (!(state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
> +		return 0;
> +
> +	/* IB spec says that num_sge == 0 is OK. */
> +	if (wr->num_sge > qp->s_max_sge)
> +		return -EINVAL;
> +
> +	if (wr->num_sge > 1) {
> +		sg_list = kmalloc((qp->s_max_sge - 1) * sizeof(*sg_list),
> +				  GFP_ATOMIC);
> +		if (!sg_list)
> +			return -ENOMEM;
> +	} else
> +		sg_list = NULL;
> +
> +	/* Check the buffer to send. */
> +	ss.sg_list = sg_list;
> +	ss.sge.mr = NULL;
> +	ss.sge.vaddr = NULL;
> +	ss.sge.length = 0;
> +	ss.sge.sge_length = 0;
> +	ss.num_sge = 0;
> +	len = 0;
> +	for (i = 0; i < wr->num_sge; i++) {
> +		/* Check LKEY */
> +		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0)
> +			return -EINVAL;
> +
> +		if (wr->sg_list[i].length == 0)
> +			continue;
> +		if (!ipath_lkey_ok(&dev->lk_table, ss.num_sge ?
> +				   sg_list + ss.num_sge : &ss.sge,
> +				   &wr->sg_list[i], 0)) {
> +			return -EINVAL;
> +		}
> +		len += wr->sg_list[i].length;
> +		ss.num_sge++;
> +	}
> +	extra_bytes = (4 - len) & 3;
> +	nwords = (len + extra_bytes) >> 2;
> +
> +	/* Construct the header. */
> +	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
> +	if (ah_attr->dlid >= 0xC000 && ah_attr->dlid < 0xFFFF)
> +		dev->n_multicast_xmit++;
> +	if (unlikely(ah_attr->dlid == ipath_layer_get_lid(dev->ib_unit))) {
> +		/* Pass in an uninitialized ib_wc to save stack space. */
> +		ipath_ud_loopback(qp, &ss, len, wr, &wc);
> +		goto done;
> +	}
> +	if (ah_attr->ah_flags & IB_AH_GRH) {
> +		/* Header size in 32-bit words. */
> +		hwords = 17;
> +		lrh0 = IPS_LRH_GRH;
> +		ohdr = &qp->s_hdr.u.l.oth;
> +		qp->s_hdr.u.l.grh.version_tclass_flow =
> +		    cpu_to_be32((6 << 28) |
> +				(ah_attr->grh.traffic_class << 20) |
> +				ah_attr->grh.flow_label);
> +		qp->s_hdr.u.l.grh.paylen =
> +		    cpu_to_be16(((wr->opcode ==
> +				  IB_WR_SEND_WITH_IMM ? 6 : 5) + nwords +
> +				 SIZE_OF_CRC) << 2);
> +		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
> +		qp->s_hdr.u.l.grh.hop_limit = ah_attr->grh.hop_limit;
> +		/* The SGID is 32-bit aligned. */
> +		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
> +		qp->s_hdr.u.l.grh.sgid.global.interface_id =
> +		    ipath_layer_get_guid(dev->ib_unit);
> +		qp->s_hdr.u.l.grh.dgid = ah_attr->grh.dgid;
> +		/*
> +		 * Don't worry about sending to locally attached
> +		 * multicast QPs.  It is unspecified by the spec. what happens.
> +		 */
> +	} else {
> +		/* Header size in 32-bit words. */
> +		hwords = 7;
> +		lrh0 = IPS_LRH_BTH;
> +		ohdr = &qp->s_hdr.u.oth;
> +	}
> +	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
> +		ohdr->u.ud.imm_data = wr->imm_data;
> +		wc.imm_data = wr->imm_data;
> +		hwords += 1;
> +		bth0 = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE << 24;
> +	} else if (wr->opcode == IB_WR_SEND) {
> +		wc.imm_data = 0;
> +		bth0 = IB_OPCODE_UD_SEND_ONLY << 24;
> +	} else
> +		return -EINVAL;
> +	lrh0 |= ah_attr->sl << 4;
> +	if (qp->ibqp.qp_type == IB_QPT_SMI)
> +		lrh0 |= 0xF000;	/* Set VL */
> +	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
> +	qp->s_hdr.lrh[1] = cpu_to_be16(ah_attr->dlid);	/* DEST LID */
> +	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
> +	lid = ipath_layer_get_lid(dev->ib_unit);
> +	qp->s_hdr.lrh[3] = lid ? cpu_to_be16(lid) : IB_LID_PERMISSIVE;
> +	if (wr->send_flags & IB_SEND_SOLICITED)
> +		bth0 |= 1 << 23;
> +	bth0 |= extra_bytes << 20;
> +	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPS_DEFAULT_P_KEY :
> +	    ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
> +	ohdr->bth[0] = cpu_to_be32(bth0);
> +	ohdr->bth[1] = cpu_to_be32(wr->wr.ud.remote_qpn);
> +	/* XXX Could lose a PSN count but not worth locking */
> +	ohdr->bth[2] = cpu_to_be32(qp->s_psn++ & 0xFFFFFF);
> +	/*
> +	 * Qkeys with the high order bit set mean use the
> +	 * qkey from the QP context instead of the WR.
> +	 */
> +	ohdr->u.ud.deth[0] = cpu_to_be32((int)wr->wr.ud.remote_qkey < 0 ?
> +					 qp->qkey : wr->wr.ud.remote_qkey);
> +	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
> +	if (ipath_verbs_send(dev->ib_unit, hwords, (uint32_t *) &qp->s_hdr,
> +			     len, &ss))
> +		dev->n_no_piobuf++;
> +
> +done:
> +	/* Queue the completion status entry. */
> +	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
> +	    (wr->send_flags & IB_SEND_SIGNALED)) {
> +		wc.wr_id = wr->wr_id;
> +		wc.status = IB_WC_SUCCESS;
> +		wc.vendor_err = 0;
> +		wc.opcode = IB_WC_SEND;
> +		wc.byte_len = len;
> +		wc.qp_num = qp->ibqp.qp_num;
> +		wc.src_qp = 0;
> +		wc.wc_flags = 0;
> +		/* XXX initialize other fields? */
> +		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 0);
> +	}
> +	kfree(sg_list);
> +
> +	return 0;
> +}
> +
> +/*
> + * This may be called from interrupt context.
> + */
> +static int ipath_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
> +			   struct ib_send_wr **bad_wr)
> +{
> +	struct ipath_qp *qp = to_iqp(ibqp);
> +	int err = 0;
> +
> +	/* Check that state is OK to post send. */
> +	if (!(state_ops[qp->state] & IPATH_POST_SEND_OK)) {
> +		*bad_wr = wr;
> +		return -EINVAL;
> +	}
> +
> +	for (; wr; wr = wr->next) {
> +		switch (qp->ibqp.qp_type) {
> +		case IB_QPT_UC:
> +		case IB_QPT_RC:
> +			err = ipath_post_rc_send(qp, wr);
> +			break;
> +
> +		case IB_QPT_SMI:
> +		case IB_QPT_GSI:
> +		case IB_QPT_UD:
> +			err = ipath_post_ud_send(qp, wr);
> +			break;
> +
> +		default:
> +			err = -EINVAL;
> +		}
> +		if (err) {
> +			*bad_wr = wr;
> +			break;
> +		}
> +	}
> +	return err;
> +}
> +
> +/*
> + * This may be called from interrupt context.
> + */
> +static int ipath_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
> +			      struct ib_recv_wr **bad_wr)
> +{
> +	struct ipath_qp *qp = to_iqp(ibqp);
> +	unsigned long flags;
> +
> +	/* Check that state is OK to post receive. */
> +	if (!(state_ops[qp->state] & IPATH_POST_RECV_OK)) {
> +		*bad_wr = wr;
> +		return -EINVAL;
> +	}
> +
> +	for (; wr; wr = wr->next) {
> +		struct ipath_rwqe *wqe;
> +		u32 next;
> +		int i, j;
> +
> +		if (wr->num_sge > qp->r_rq.max_sge) {
> +			*bad_wr = wr;
> +			return -ENOMEM;
> +		}
> +
> +		spin_lock_irqsave(&qp->r_rq.lock, flags);
> +		next = qp->r_rq.head + 1;
> +		if (next >= qp->r_rq.size)
> +			next = 0;
> +		if (next == qp->r_rq.tail) {
> +			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +			*bad_wr = wr;
> +			return -ENOMEM;
> +		}
> +
> +		wqe = get_rwqe_ptr(&qp->r_rq, qp->r_rq.head);
> +		wqe->wr_id = wr->wr_id;
> +		wqe->sg_list[0].mr = NULL;
> +		wqe->sg_list[0].vaddr = NULL;
> +		wqe->sg_list[0].length = 0;
> +		wqe->sg_list[0].sge_length = 0;
> +		wqe->length = 0;
> +		for (i = 0, j = 0; i < wr->num_sge; i++) {
> +			/* Check LKEY */
> +			if (to_ipd(qp->ibqp.pd)->user &&
> +			    wr->sg_list[i].lkey == 0) {
> +				spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +				*bad_wr = wr;
> +				return -EINVAL;
> +			}
> +			if (wr->sg_list[i].length == 0)
> +				continue;
> +			if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
> +					   &wqe->sg_list[j], &wr->sg_list[i],
> +					   IB_ACCESS_LOCAL_WRITE)) {
> +				spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +				*bad_wr = wr;
> +				return -EINVAL;
> +			}
> +			wqe->length += wr->sg_list[i].length;
> +			j++;
> +		}
> +		wqe->num_sge = j;
> +		qp->r_rq.head = next;
> +		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * This may be called from interrupt context.
> + */
> +static int ipath_post_srq_receive(struct ib_srq *ibsrq, struct ib_recv_wr *wr,
> +				  struct ib_recv_wr **bad_wr)
> +{
> +	struct ipath_srq *srq = to_isrq(ibsrq);
> +	struct ipath_ibdev *dev = to_idev(ibsrq->device);
> +	unsigned long flags;
> +
> +	for (; wr; wr = wr->next) {
> +		struct ipath_rwqe *wqe;
> +		u32 next;
> +		int i, j;
> +
> +		if (wr->num_sge > srq->rq.max_sge) {
> +			*bad_wr = wr;
> +			return -ENOMEM;
> +		}
> +
> +		spin_lock_irqsave(&srq->rq.lock, flags);
> +		next = srq->rq.head + 1;
> +		if (next >= srq->rq.size)
> +			next = 0;
> +		if (next == srq->rq.tail) {
> +			spin_unlock_irqrestore(&srq->rq.lock, flags);
> +			*bad_wr = wr;
> +			return -ENOMEM;
> +		}
> +
> +		wqe = get_rwqe_ptr(&srq->rq, srq->rq.head);
> +		wqe->wr_id = wr->wr_id;
> +		wqe->sg_list[0].mr = NULL;
> +		wqe->sg_list[0].vaddr = NULL;
> +		wqe->sg_list[0].length = 0;
> +		wqe->sg_list[0].sge_length = 0;
> +		wqe->length = 0;
> +		for (i = 0, j = 0; i < wr->num_sge; i++) {
> +			/* Check LKEY */
> +			if (to_ipd(srq->ibsrq.pd)->user &&
> +			    wr->sg_list[i].lkey == 0) {
> +				spin_unlock_irqrestore(&srq->rq.lock, flags);
> +				*bad_wr = wr;
> +				return -EINVAL;
> +			}
> +			if (wr->sg_list[i].length == 0)
> +				continue;
> +			if (!ipath_lkey_ok(&dev->lk_table,
> +					   &wqe->sg_list[j], &wr->sg_list[i],
> +					   IB_ACCESS_LOCAL_WRITE)) {
> +				spin_unlock_irqrestore(&srq->rq.lock, flags);
> +				*bad_wr = wr;
> +				return -EINVAL;
> +			}
> +			wqe->length += wr->sg_list[i].length;
> +			j++;
> +		}
> +		wqe->num_sge = j;
> +		srq->rq.head = next;
> +		spin_unlock_irqrestore(&srq->rq.lock, flags);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * This is called from ipath_qp_rcv() to process an incomming UD packet
> + * for the given QP.
> + * Called at interrupt level.
> + */
> +static void ipath_ud_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
> +			 int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
> +{
> +	struct ipath_other_headers *ohdr;
> +	int opcode;
> +	u32 hdrsize;
> +	u32 pad;
> +	unsigned long flags;
> +	struct ib_wc wc;
> +	u32 qkey;
> +	u32 src_qp;
> +	struct ipath_rq *rq;
> +	struct ipath_srq *srq;
> +	struct ipath_rwqe *wqe;
> +
> +	/* Check for GRH */
> +	if (!has_grh) {
> +		ohdr = &hdr->u.oth;
> +		hdrsize = 8 + 12 + 8;	/* LRH + BTH + DETH */
> +		qkey = be32_to_cpu(ohdr->u.ud.deth[0]);
> +		src_qp = be32_to_cpu(ohdr->u.ud.deth[1]);
> +	} else {
> +		ohdr = &hdr->u.l.oth;
> +		hdrsize = 8 + 40 + 12 + 8;	/* LRH + GRH + BTH + DETH */
> +		/*
> +		 * The header with GRH is 68 bytes and the
> +		 * core driver sets the eager header buffer
> +		 * size to 56 bytes so the last 12 bytes of
> +		 * the IB header is in the data buffer.
> +		 */
> +		qkey = be32_to_cpu(((u32 *) data)[1]);
> +		src_qp = be32_to_cpu(((u32 *) data)[2]);
> +		data += 12;
> +	}
> +	src_qp &= 0xFFFFFF;
> +
> +	/* Check that the qkey matches. */
> +	if (unlikely(qkey != qp->qkey)) {
> +		/* XXX OK to lose a count once in a while. */
> +		dev->qkey_violations++;
> +		dev->n_pkt_drops++;
> +		return;
> +	}
> +
> +	/* Get the number of bytes the message was padded by. */
> +	pad = (ohdr->bth[0] >> 12) & 3;
> +	if (unlikely(tlen < (hdrsize + pad + 4))) {
> +		/* Drop incomplete packets. */
> +		dev->n_pkt_drops++;
> +		return;
> +	}
> +
> +	/*
> +	 * A GRH is expected to preceed the data even if not
> +	 * present on the wire.
> +	 */
> +	wc.byte_len = tlen - (hdrsize + pad + 4) + sizeof(struct ib_grh);
> +
> +	/*
> +	 * The opcode is in the low byte when its in network order
> +	 * (top byte when in host order).
> +	 */
> +	opcode = *(u8 *) (&ohdr->bth[0]);
> +	if (opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
> +		if (has_grh) {
> +			wc.imm_data = *(u32 *) data;
> +			data += sizeof(u32);
> +		} else
> +			wc.imm_data = ohdr->u.ud.imm_data;
> +		wc.wc_flags = IB_WC_WITH_IMM;
> +		hdrsize += sizeof(u32);
> +	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
> +		wc.imm_data = 0;
> +		wc.wc_flags = 0;
> +	} else {
> +		dev->n_pkt_drops++;
> +		return;
> +	}
> +
> +	/*
> +	 * Get the next work request entry to find where to put the data.
> +	 * Note that it is safe to drop the lock after changing rq->tail
> +	 * since ipath_post_receive() won't fill the empty slot.
> +	 */
> +	if (qp->ibqp.srq) {
> +		srq = to_isrq(qp->ibqp.srq);
> +		rq = &srq->rq;
> +	} else {
> +		srq = NULL;
> +		rq = &qp->r_rq;
> +	}
> +	spin_lock_irqsave(&rq->lock, flags);
> +	if (rq->tail == rq->head) {
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +		dev->n_pkt_drops++;
> +		return;
> +	}
> +	/* Silently drop packets which are too big. */
> +	wqe = get_rwqe_ptr(rq, rq->tail);
> +	if (wc.byte_len > wqe->length) {
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +		dev->n_pkt_drops++;
> +		return;
> +	}
> +	wc.wr_id = wqe->wr_id;
> +	qp->r_sge.sge = wqe->sg_list[0];
> +	qp->r_sge.sg_list = wqe->sg_list + 1;
> +	qp->r_sge.num_sge = wqe->num_sge;
> +	if (++rq->tail >= rq->size)
> +		rq->tail = 0;
> +	if (srq && srq->ibsrq.event_handler) {
> +		u32 n;
> +
> +		if (rq->head < rq->tail)
> +			n = rq->size + rq->head - rq->tail;
> +		else
> +			n = rq->head - rq->tail;
> +		if (n < srq->limit) {
> +			struct ib_event ev;
> +
> +			srq->limit = 0;
> +			spin_unlock_irqrestore(&rq->lock, flags);
> +			ev.device = qp->ibqp.device;
> +			ev.element.srq = qp->ibqp.srq;
> +			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
> +			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
> +		} else
> +			spin_unlock_irqrestore(&rq->lock, flags);
> +	} else
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +	if (has_grh) {
> +		copy_sge(&qp->r_sge, &hdr->u.l.grh, sizeof(struct ib_grh));
> +		wc.wc_flags |= IB_WC_GRH;
> +	} else
> +		skip_sge(&qp->r_sge, sizeof(struct ib_grh));
> +	copy_sge(&qp->r_sge, data, wc.byte_len - sizeof(struct ib_grh));
> +	wc.status = IB_WC_SUCCESS;
> +	wc.opcode = IB_WC_RECV;
> +	wc.vendor_err = 0;
> +	wc.qp_num = qp->ibqp.qp_num;
> +	wc.src_qp = src_qp;
> +	/* XXX do we know which pkey matched? Only needed for GSI. */
> +	wc.pkey_index = 0;
> +	wc.slid = be16_to_cpu(hdr->lrh[3]);
> +	wc.sl = (be16_to_cpu(hdr->lrh[0]) >> 4) & 0xF;
> +	wc.dlid_path_bits = 0;
> +	/* Signal completion event if the solicited bit is set. */
> +	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
> +		       ohdr->bth[0] & __constant_cpu_to_be32(1 << 23));
> +}
> +
> +/*
> + * This is called from ipath_post_ud_send() to forward a WQE addressed
> + * to the same HCA.
> + */
> +static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
> +			      u32 length, struct ib_send_wr *wr,
> +			      struct ib_wc *wc)
> +{
> +	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
> +	struct ipath_qp *qp;
> +	struct ib_ah_attr *ah_attr;
> +	unsigned long flags;
> +	struct ipath_rq *rq;
> +	struct ipath_srq *srq;
> +	struct ipath_sge_state rsge;
> +	struct ipath_sge *sge;
> +	struct ipath_rwqe *wqe;
> +
> +	qp = ipath_lookup_qpn(&dev->qp_table, wr->wr.ud.remote_qpn);
> +	if (!qp)
> +		return;
> +
> +	/* Check that the qkey matches. */
> +	if (unlikely(wr->wr.ud.remote_qkey != qp->qkey)) {
> +		/* XXX OK to lose a count once in a while. */
> +		dev->qkey_violations++;
> +		dev->n_pkt_drops++;
> +		goto done;
> +	}
> +
> +	/*
> +	 * A GRH is expected to preceed the data even if not
> +	 * present on the wire.
> +	 */
> +	wc->byte_len = length + sizeof(struct ib_grh);
> +
> +	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
> +		wc->wc_flags = IB_WC_WITH_IMM;
> +		wc->imm_data = wr->imm_data;
> +	} else {
> +		wc->wc_flags = 0;
> +		wc->imm_data = 0;
> +	}
> +
> +	/*
> +	 * Get the next work request entry to find where to put the data.
> +	 * Note that it is safe to drop the lock after changing rq->tail
> +	 * since ipath_post_receive() won't fill the empty slot.
> +	 */
> +	if (qp->ibqp.srq) {
> +		srq = to_isrq(qp->ibqp.srq);
> +		rq = &srq->rq;
> +	} else {
> +		srq = NULL;
> +		rq = &qp->r_rq;
> +	}
> +	spin_lock_irqsave(&rq->lock, flags);
> +	if (rq->tail == rq->head) {
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +		dev->n_pkt_drops++;
> +		goto done;
> +	}
> +	/* Silently drop packets which are too big. */
> +	wqe = get_rwqe_ptr(rq, rq->tail);
> +	if (wc->byte_len > wqe->length) {
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +		dev->n_pkt_drops++;
> +		goto done;
> +	}
> +	wc->wr_id = wqe->wr_id;
> +	rsge.sge = wqe->sg_list[0];
> +	rsge.sg_list = wqe->sg_list + 1;
> +	rsge.num_sge = wqe->num_sge;
> +	if (++rq->tail >= rq->size)
> +		rq->tail = 0;
> +	if (srq && srq->ibsrq.event_handler) {
> +		u32 n;
> +
> +		if (rq->head < rq->tail)
> +			n = rq->size + rq->head - rq->tail;
> +		else
> +			n = rq->head - rq->tail;
> +		if (n < srq->limit) {
> +			struct ib_event ev;
> +
> +			srq->limit = 0;
> +			spin_unlock_irqrestore(&rq->lock, flags);
> +			ev.device = qp->ibqp.device;
> +			ev.element.srq = qp->ibqp.srq;
> +			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
> +			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
> +		} else
> +			spin_unlock_irqrestore(&rq->lock, flags);
> +	} else
> +		spin_unlock_irqrestore(&rq->lock, flags);
> +	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
> +	if (ah_attr->ah_flags & IB_AH_GRH) {
> +		copy_sge(&rsge, &ah_attr->grh, sizeof(struct ib_grh));
> +		wc->wc_flags |= IB_WC_GRH;
> +	} else
> +		skip_sge(&rsge, sizeof(struct ib_grh));
> +	sge = &ss->sge;
> +	while (length) {
> +		u32 len = sge->length;
> +
> +		if (len > length)
> +			len = length;
> +		BUG_ON(len == 0);
> +		copy_sge(&rsge, sge->vaddr, len);
> +		sge->vaddr += len;
> +		sge->length -= len;
> +		sge->sge_length -= len;
> +		if (sge->sge_length == 0) {
> +			if (--ss->num_sge)
> +				*sge = *ss->sg_list++;
> +		} else if (sge->length == 0 && sge->mr != NULL) {
> +			if (++sge->n >= IPATH_SEGSZ) {
> +				if (++sge->m >= sge->mr->mapsz)
> +					break;
> +				sge->n = 0;
> +			}
> +			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
> +			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
> +		}
> +		length -= len;
> +	}
> +	wc->status = IB_WC_SUCCESS;
> +	wc->opcode = IB_WC_RECV;
> +	wc->vendor_err = 0;
> +	wc->qp_num = qp->ibqp.qp_num;
> +	wc->src_qp = sqp->ibqp.qp_num;
> +	/* XXX do we know which pkey matched? Only needed for GSI. */
> +	wc->pkey_index = 0;
> +	wc->slid = ipath_layer_get_lid(dev->ib_unit);
> +	wc->sl = ah_attr->sl;
> +	wc->dlid_path_bits = 0;
> +	/* Signal completion event if the solicited bit is set. */
> +	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
> +		       wr->send_flags & IB_SEND_SOLICITED);
> +
> +done:
> +	if (atomic_dec_and_test(&qp->refcount))
> +		wake_up(&qp->wait);
> +}
> +
> +/*
> + * Copy the next RWQE into the QP's RWQE.
> + * Return zero if no RWQE is available.
> + * Called at interrupt level with the QP r_rq.lock held.
> + */
> +static int get_rwqe(struct ipath_qp *qp, int wr_id_only)
> +{
> +	struct ipath_rq *rq;
> +	struct ipath_srq *srq;
> +	struct ipath_rwqe *wqe;
> +
> +	if (!qp->ibqp.srq) {
> +		rq = &qp->r_rq;
> +		if (unlikely(rq->tail == rq->head))
> +			return 0;
> +		wqe = get_rwqe_ptr(rq, rq->tail);
> +		qp->r_wr_id = wqe->wr_id;
> +		if (!wr_id_only) {
> +			qp->r_sge.sge = wqe->sg_list[0];
> +			qp->r_sge.sg_list = wqe->sg_list + 1;
> +			qp->r_sge.num_sge = wqe->num_sge;
> +			qp->r_len = wqe->length;
> +		}
> +		if (++rq->tail >= rq->size)
> +			rq->tail = 0;
> +		return 1;
> +	}
> +
> +	srq = to_isrq(qp->ibqp.srq);
> +	rq = &srq->rq;
> +	spin_lock(&rq->lock);
> +	if (unlikely(rq->tail == rq->head)) {
> +		spin_unlock(&rq->lock);
> +		return 0;
> +	}
> +	wqe = get_rwqe_ptr(rq, rq->tail);
> +	qp->r_wr_id = wqe->wr_id;
> +	if (!wr_id_only) {
> +		qp->r_sge.sge = wqe->sg_list[0];
> +		qp->r_sge.sg_list = wqe->sg_list + 1;
> +		qp->r_sge.num_sge = wqe->num_sge;
> +		qp->r_len = wqe->length;
> +	}
> +	if (++rq->tail >= rq->size)
> +		rq->tail = 0;
> +	if (srq->ibsrq.event_handler) {
> +		struct ib_event ev;
> +		u32 n;
> +
> +		if (rq->head < rq->tail)
> +			n = rq->size + rq->head - rq->tail;
> +		else
> +			n = rq->head - rq->tail;
> +		if (n < srq->limit) {
> +			srq->limit = 0;
> +			spin_unlock(&rq->lock);
> +			ev.device = qp->ibqp.device;
> +			ev.element.srq = qp->ibqp.srq;
> +			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
> +			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
> +		} else
> +			spin_unlock(&rq->lock);
> +	} else
> +		spin_unlock(&rq->lock);
> +	return 1;
> +}
> -- 
> 0.99.9n
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
