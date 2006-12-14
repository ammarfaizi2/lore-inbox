Return-Path: <linux-kernel-owner+w=401wt.eu-S932763AbWLNOT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWLNOT3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLNOT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:19:29 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46391 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932744AbWLNOT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:19:27 -0500
X-Greylist: delayed 1612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 09:19:26 EST
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v4 02/13] Device Discovery and ULLD Linkage
Date: Thu, 14 Dec 2006 07:53:35 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061214135335.21159.79371.stgit@dell3.ogc.int>
In-Reply-To: <20061214135233.21159.78613.stgit@dell3.ogc.int>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code to discover all the T3 devices and register them 
with the T3 RDMA Core and the Linux RDMA Core.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/hw/cxgb3/iwch.c |  189 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/iwch.h |  175 +++++++++++++++++++++++++++++++++
 2 files changed, 364 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch.c b/drivers/infiniband/hw/cxgb3/iwch.c
new file mode 100644
index 0000000..acbe449
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
+ * Copyright (c) 2006 Open Grid Computing, Inc. All rights reserved.
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "cxgb3_offload.h"
+#include "iwch_provider.h"
+#include "iwch_user.h"
+#include "iwch.h"
+#include "iwch_cm.h"
+
+#define DRV_VERSION "1.1"
+
+MODULE_AUTHOR("Boyd Faulkner, Steve Wise");
+MODULE_DESCRIPTION("Chelsio T3 RDMA Driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION(DRV_VERSION);
+
+cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS];
+
+static void open_rnic_dev(struct t3cdev *);
+static void close_rnic_dev(struct t3cdev *);
+
+struct cxgb3_client t3c_client = {
+	.name = "iw_cxgb3",
+	.add = open_rnic_dev,
+	.remove = close_rnic_dev,
+	.handlers = t3c_handlers,
+	.redirect = iwch_ep_redirect
+};
+
+static LIST_HEAD(dev_list);
+static DEFINE_MUTEX(dev_mutex);
+
+static void rnic_init(struct iwch_dev *rnicp)
+{
+	PDBG("%s iwch_dev %p\n", __FUNCTION__,  rnicp);
+	idr_init(&rnicp->cqidr);
+	idr_init(&rnicp->qpidr);
+	idr_init(&rnicp->mmidr);
+	spin_lock_init(&rnicp->lock);
+
+	rnicp->attr.vendor_id = 0x168;
+	rnicp->attr.vendor_part_id = 7;
+	rnicp->attr.max_qps = T3_MAX_NUM_QP - 32;
+	rnicp->attr.max_wrs = (1UL << 24) - 1;
+	rnicp->attr.max_sge_per_wr = T3_MAX_SGE;
+	rnicp->attr.max_sge_per_rdma_write_wr = T3_MAX_SGE;
+	rnicp->attr.max_cqs = T3_MAX_NUM_CQ - 1;
+	rnicp->attr.max_cqes_per_cq = (1UL << 24) - 1;
+	rnicp->attr.max_mem_regs = cxio_num_stags(&rnicp->rdev);
+	rnicp->attr.max_phys_buf_entries = T3_MAX_PBL_SIZE;
+	rnicp->attr.max_pds = T3_MAX_NUM_PD - 1;
+	rnicp->attr.mem_pgsizes_bitmask = 0x7FFF;	/* 4KB-128MB */
+	rnicp->attr.can_resize_wq = 0;
+	rnicp->attr.max_rdma_reads_per_qp = 8;
+	rnicp->attr.max_rdma_read_resources =
+	    rnicp->attr.max_rdma_reads_per_qp * rnicp->attr.max_qps;
+	rnicp->attr.max_rdma_read_qp_depth = 8;	/* IRD */
+	rnicp->attr.max_rdma_read_depth =
+	    rnicp->attr.max_rdma_read_qp_depth * rnicp->attr.max_qps;
+	rnicp->attr.rq_overflow_handled = 0;
+	rnicp->attr.can_modify_ird = 0;
+	rnicp->attr.can_modify_ord = 0;
+	rnicp->attr.max_mem_windows = rnicp->attr.max_mem_regs - 1;
+	rnicp->attr.stag0_value = 1;
+	rnicp->attr.zbva_support = 1;
+	rnicp->attr.local_invalidate_fence = 1;
+	rnicp->attr.cq_overflow_detection = 1;
+	return;
+}
+
+static void open_rnic_dev(struct t3cdev *tdev)
+{
+	struct iwch_dev *rnicp;
+	static int vers_printed;
+
+	PDBG("%s t3cdev %p\n", __FUNCTION__,  tdev);
+	if (!vers_printed++) 
+		printk(KERN_INFO MOD "Chelsio T3 RDMA Driver - version %s\n",
+		       DRV_VERSION);
+	rnicp = (struct iwch_dev *)ib_alloc_device(sizeof(*rnicp));
+	if (!rnicp) {
+		printk(KERN_ERR MOD "Cannot allocate ib device\n");
+		return;
+	}
+	rnicp->rdev.ulp = rnicp;
+	rnicp->rdev.t3cdev_p = tdev;
+
+	if (cxio_rdev_open(&rnicp->rdev)) {
+		printk(KERN_ERR MOD "Unable to open CXIO rdev\n");
+		ib_dealloc_device(&rnicp->ibdev);
+		return;
+	}
+
+	rnic_init(rnicp);
+
+	mutex_lock(&dev_mutex);
+	list_add_tail(&rnicp->entry, &dev_list);
+	mutex_unlock(&dev_mutex);
+
+	if (iwch_register_device(rnicp)) {
+		printk(KERN_ERR MOD "Unable to register device\n");
+		close_rnic_dev(tdev);
+	}
+	printk(KERN_INFO MOD "Initialized device %s\n",
+	       pci_name(rnicp->rdev.rnic_info.pdev));
+	return;
+}
+
+static void close_rnic_dev(struct t3cdev *tdev)
+{
+	struct iwch_dev *dev, *tmp;
+	PDBG("%s t3cdev %p\n", __FUNCTION__,  tdev);
+	mutex_lock(&dev_mutex);
+	list_for_each_entry_safe(dev, tmp, &dev_list, entry) {
+		if (dev->rdev.t3cdev_p == tdev) {
+			list_del(&dev->entry);
+			iwch_unregister_device(dev);
+			cxio_rdev_close(&dev->rdev);
+			idr_destroy(&dev->cqidr);
+			idr_destroy(&dev->qpidr);
+			idr_destroy(&dev->mmidr);
+			ib_dealloc_device(&dev->ibdev);
+			break;
+		}
+	}
+	mutex_unlock(&dev_mutex);
+}
+
+extern void iwch_ev_dispatch(struct cxio_rdev *rdev_p, struct sk_buff *skb);
+
+static int __init iwch_init_module(void)
+{
+	int err;
+
+	err = cxio_hal_init();
+	if (err) 
+		return err;
+	err = iwch_cm_init();
+	if (err) 
+		return err;
+	cxio_register_ev_cb(iwch_ev_dispatch);
+	cxgb3_register_client(&t3c_client);
+	return 0;
+}
+
+static void __exit iwch_exit_module(void)
+{
+	cxgb3_unregister_client(&t3c_client);
+	cxio_unregister_ev_cb(iwch_ev_dispatch);
+	iwch_cm_term();
+	cxio_hal_exit();
+}
+
+module_init(iwch_init_module);
+module_exit(iwch_exit_module);
diff --git a/drivers/infiniband/hw/cxgb3/iwch.h b/drivers/infiniband/hw/cxgb3/iwch.h
new file mode 100644
index 0000000..752b6ad
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch.h
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
+ * Copyright (c) 2006 Open Grid Computing, Inc. All rights reserved.
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
+#ifndef __IWCH_H__
+#define __IWCH_H__
+
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "cxio_hal.h"
+#include "cxgb3_offload.h"
+
+struct iwch_pd;
+struct iwch_cq;
+struct iwch_qp;
+struct iwch_mr;
+
+struct iwch_rnic_attributes {
+	u32 vendor_id;
+	u32 vendor_part_id;
+	u32 max_qps;
+	u32 max_wrs;				/* Max for any SQ/RQ */
+	u32 max_sge_per_wr;
+	u32 max_sge_per_rdma_write_wr;	/* for RDMA Write WR */
+	u32 max_cqs;
+	u32 max_cqes_per_cq;
+	u32 max_mem_regs;
+	u32 max_phys_buf_entries;		/* for phys buf list */
+	u32 max_pds;
+
+	/* 
+	 * The memory page sizes supported by this RNIC.
+	 * Bit position i in bitmap indicates page of
+	 * size (4k)^i.  Phys block list mode unsupported. 
+	 */
+	u32 mem_pgsizes_bitmask;
+	u8 can_resize_wq;
+
+	/*
+	 * The maximum number of RDMA Reads that can be outstanding 
+	 * per QP with this RNIC as the target. 
+	 */
+	u32 max_rdma_reads_per_qp;
+
+	/*
+	 * The maximum number of resources used for RDMA Reads
+	 * by this RNIC with this RNIC as the target. 
+	 */
+	u32 max_rdma_read_resources;
+
+	/*
+	 * The max depth per QP for initiation of RDMA Read
+	 * by this RNIC.  
+	 */
+	u32 max_rdma_read_qp_depth;
+
+	/*
+	 * The maximum depth for initiation of RDMA Read 
+	 * operations by this RNIC on all QPs 
+	 */
+	u32 max_rdma_read_depth;
+	u8 rq_overflow_handled;
+	u32 can_modify_ird;
+	u32 can_modify_ord;
+	u32 max_mem_windows;
+	u32 stag0_value;
+	u8 zbva_support;
+	u8 local_invalidate_fence;
+	u32 cq_overflow_detection;
+};
+
+struct iwch_dev {
+	struct ib_device ibdev;
+	struct cxio_rdev rdev;
+	u32 device_cap_flags;
+	struct iwch_rnic_attributes attr;
+	struct idr cqidr;
+	struct idr qpidr;
+	struct idr mmidr;
+	spinlock_t lock;
+	struct list_head entry;
+};
+
+static inline struct iwch_dev *to_iwch_dev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct iwch_dev, ibdev);
+}
+
+static inline int t3b_device(const struct iwch_dev *rhp)
+{
+	return (rhp->rdev.t3cdev_p->type == T3B);
+}
+
+static inline int t3a_device(const struct iwch_dev *rhp)
+{
+	return (rhp->rdev.t3cdev_p->type == T3A);
+}
+
+static inline struct iwch_cq *get_chp(struct iwch_dev *rhp, u32 cqid)
+{
+	return idr_find(&rhp->cqidr, cqid);
+}
+
+static inline struct iwch_qp *get_qhp(struct iwch_dev *rhp, u32 qpid)
+{
+	return idr_find(&rhp->qpidr, qpid);
+}
+
+static inline struct iwch_mr *get_mhp(struct iwch_dev *rhp, u32 mmid)
+{
+	return idr_find(&rhp->mmidr, mmid);
+}
+
+static inline int insert_handle(struct iwch_dev *rhp, struct idr *idr, 
+				void *handle, u32 id)
+{
+	int ret;
+	u32 newid;
+
+	do {
+		if (!idr_pre_get(idr, GFP_KERNEL)) {
+			return -ENOMEM;
+		}
+		spin_lock_irq(&rhp->lock);
+		ret = idr_get_new_above(idr, handle, id, &newid);
+		BUG_ON(newid != id);
+		spin_unlock_irq(&rhp->lock);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+static inline void remove_handle(struct iwch_dev *rhp, struct idr *idr, u32 id)
+{
+	spin_lock_irq(&rhp->lock);
+	idr_remove(idr, id);
+	spin_unlock_irq(&rhp->lock);
+}
+
+extern struct cxgb3_client t3c_client;
+extern cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS];
+#endif
