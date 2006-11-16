Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031107AbWKPD7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031107AbWKPD7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031109AbWKPD7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:59:07 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:39097 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1031107AbWKPD6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:58:37 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  02/13] Device Discovery and ULLD Linkage
Date: Wed, 15 Nov 2006 21:58:37 -0600
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-Id: <20061116035837.22635.13571.stgit@dell3.ogc.int>
In-Reply-To: <20061116035826.22635.61230.stgit@dell3.ogc.int>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code to discover all the T3 devices and register them 
with the T3 RDMA Core and the Linux RDMA Core.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/hw/cxgb3/iwch.c |  222 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/iwch.h |  134 ++++++++++++++++++++++
 2 files changed, 356 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch.c b/drivers/infiniband/hw/cxgb3/iwch.c
new file mode 100644
index 0000000..f45f005
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch.c
@@ -0,0 +1,222 @@
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
+static inline void *vzmalloc(int size)
+{
+	void *p = vmalloc(size);
+	memset(p, 0, size);
+	return p;
+}
+
+static int open_rnic_init(struct iwch_dev *rnicp)
+{
+	PDBG("%s iwch_dev %p\n", __FUNCTION__,  rnicp);
+	rnicp->pdid2ptr = vzmalloc(sizeof(void*) * T3_MAX_NUM_PD);
+	if (!rnicp->pdid2ptr)
+		goto pdid_err;
+	rnicp->cqid2ptr = vzmalloc(sizeof(void*) * T3_MAX_NUM_CQ);
+	if (!rnicp->cqid2ptr)
+		goto cqid_err;
+	rnicp->qpid2ptr = vzmalloc(sizeof(void*) * T3_MAX_NUM_QP);
+	if (!rnicp->qpid2ptr)
+		goto qpid_err;
+	rnicp->mmid2ptr = vzmalloc(sizeof(void*) * 
+				   cxio_num_stags(&rnicp->rdev));
+	if (!rnicp->mmid2ptr)
+		goto stag_err;
+
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
+	return 0;
+
+stag_err:
+	vfree(rnicp->qpid2ptr);
+qpid_err:
+	vfree(rnicp->cqid2ptr);
+cqid_err:
+	vfree(rnicp->pdid2ptr);
+pdid_err:
+	return -ENOMEM;
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
+	if (open_rnic_init(rnicp)) {
+		printk(KERN_ERR MOD "Unable to initialize device\n");
+		cxio_rdev_close(&rnicp->rdev);
+		ib_dealloc_device(&rnicp->ibdev);
+		return;
+	}
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
+			vfree(dev->pdid2ptr);
+			vfree(dev->cqid2ptr);
+			vfree(dev->mmid2ptr);
+			vfree(dev->qpid2ptr);
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
index 0000000..fe0a557
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch.h
@@ -0,0 +1,134 @@
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
+	struct iwch_pd **pdid2ptr;
+	struct iwch_cq **cqid2ptr;
+	struct iwch_qp **qpid2ptr;
+	struct iwch_mr **mmid2ptr;
+	spinlock_t lock;
+	struct list_head entry;
+};
+
+static inline struct iwch_dev *to_iwch_dev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct iwch_dev, ibdev);
+}
+
+static inline int t3b_device(struct iwch_dev *rhp)
+{
+	return (rhp->rdev.t3cdev_p->type == T3B);
+}
+
+static inline int t3a_device(struct iwch_dev *rhp)
+{
+	return (rhp->rdev.t3cdev_p->type == T3A);
+}
+
+extern struct cxgb3_client t3c_client;
+extern cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS];
+#endif
