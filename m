Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945932AbWBRBDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945932AbWBRBDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWBRA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:17 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:34083 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751843AbWBRA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:58:04 -0500
X-IronPort-AV: i="4.02,125,1139212800"; 
   d="scan'208"; a="256299666:sNHT42918636"
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 21/22] ehca main file
Date: Fri, 17 Feb 2006 16:57:59 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005759.13620.10968.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:59.0836 (UTC) FILETIME=[5CE215C0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

What is ehca_show_flightrecorder() trying to do that snprintf() is
not fast enough?  If you need to pass a binary structure back to
userspace (with a kernel address in it??) then sysfs is not the right
place to put it.  Look at debugfs; or relayfs might make the most
sense for your flightrecorder stuff.
---

 drivers/infiniband/hw/ehca/ehca_main.c | 1032 ++++++++++++++++++++++++++++++++
 1 files changed, 1032 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
new file mode 100644
index 0000000..2e2be06
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -0,0 +1,1032 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  module start stop, hca detection
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_main.c,v 1.137 2006/02/06 16:20:38 schickhj Exp $
+ */
+
+#define DEB_PREFIX "shca"
+
+#include "ehca_kernel.h"
+#include "ehca_tools.h"
+#include "ehca_classes.h"
+#include "ehca_iverbs.h"
+#include "ehca_eq.h"
+#include "ehca_mrmw.h"
+
+#include "hcp_sense.h"		/* TODO: later via hipz_* header file */
+#include "hcp_if.h"		/* TODO: later via hipz_* header file */
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
+MODULE_DESCRIPTION("IBM eServer HCA Driver");
+MODULE_VERSION("EHCA2_0047");
+
+#ifdef EHCA_USERDRIVER
+int ehca_open_aqp1     = 1;
+#else
+int ehca_open_aqp1     = 0;
+#endif
+int ehca_tracelevel    = -1;
+int ehca_hw_level      = 0;
+int ehca_nr_ports      = 2;
+int ehca_use_hp_mr     = 0;
+int ehca_port_act_time = 30;
+int ehca_poll_all_eqs  = 1;
+int ehca_static_rate   = -1;
+
+module_param_named(open_aqp1,     ehca_open_aqp1,     int, 0);
+module_param_named(tracelevel,    ehca_tracelevel,    int, 0);
+module_param_named(hw_level,      ehca_hw_level,      int, 0);
+module_param_named(nr_ports,      ehca_nr_ports,      int, 0);
+module_param_named(use_hp_mr,     ehca_use_hp_mr,     int, 0);
+module_param_named(port_act_time, ehca_port_act_time, int, 0);
+module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  int, 0);
+module_param_named(static_rate,   ehca_static_rate,   int, 0);
+
+MODULE_PARM_DESC(open_aqp1,     "0 no define AQP1 on startup (default),"
+			        "1 define AQP1 on startup");
+MODULE_PARM_DESC(tracelevel,    "0 maximum performance (no messages),"
+		                "9 maximum messages (no performance)");
+MODULE_PARM_DESC(hw_level,      "0 autosensing,"
+				"1 v. 0.20,"
+				"2 v. 0.21");
+MODULE_PARM_DESC(nr_ports,	"number of connected ports (default: 2)");
+MODULE_PARM_DESC(use_hp_mr,	"use high performance MRs,"
+				"0 no (default),"
+				"1 yes");
+MODULE_PARM_DESC(port_act_time, "time to wait for port activation"
+				"(default: 30 sec.)");
+MODULE_PARM_DESC(poll_all_eqs,	"polls all event queues periodically"
+				"0 no,"
+				"1 yes (default)");
+MODULE_PARM_DESC(static_rate,	"set permanent static rate (default: disabled)");
+
+/* This external trace mask controls what will end up in the
+ * kernel ring buffer. Number 6 means, that everything between
+ * 0 and 5 will be stored.
+ */
+u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE]={6,6,6,6,
+					      6,6,6,6,
+					      6,6,6,6,
+					      6,6,6,6,
+					      6,6,6,6,
+					      6,6,6,6,
+					      6,6,6,6,
+					      6,6,1,0};
+		     /* offset 0x1e is flightrecorder */
+EXPORT_SYMBOL(ehca_edeb_mask);
+
+atomic_t ehca_flightrecorder_index = ATOMIC_INIT(1);
+unsigned long ehca_flightrecorder[EHCA_FLIGHTRECORDER_SIZE];
+EXPORT_SYMBOL(ehca_flightrecorder_index);
+EXPORT_SYMBOL(ehca_flightrecorder);
+
+DECLARE_RWSEM(ehca_qp_idr_sem);
+DECLARE_RWSEM(ehca_cq_idr_sem);
+DEFINE_IDR(ehca_qp_idr);
+DEFINE_IDR(ehca_cq_idr);
+
+struct ehca_module ehca_module;
+struct workqueue_struct *ehca_wq;
+struct task_struct  *ehca_kthread_eq;
+
+/**
+ * ehca_init_trace - TODO
+ */
+void ehca_init_trace(void)
+{
+	EDEB_EN(7, "");
+
+	if (ehca_tracelevel != -1) {
+		int i;
+		for (i = 0; i < EHCA_EDEB_TRACE_MASK_SIZE; i++)
+			ehca_edeb_mask[i] = ehca_tracelevel;
+	}
+
+	EDEB_EX(7, "");
+}
+
+/**
+ * ehca_init_flight - TODO
+ */
+void ehca_init_flight(void)
+{
+	EDEB_EN(7, "");
+
+	memset(ehca_flightrecorder, 0xFA,
+	       sizeof(unsigned long) * EHCA_FLIGHTRECORDER_SIZE);
+	atomic_set(&ehca_flightrecorder_index, 0);
+	ehca_flightrecorder[0] = 0x12345678abcdef0;
+
+	EDEB_EX(7, "");
+}
+
+/**
+ * ehca_flight_to_printk - TODO
+ */
+void ehca_flight_to_printk(void)
+{
+	int cur_offset = atomic_read(&ehca_flightrecorder_index);
+	int new_offset = cur_offset - (EHCA_FLIGHTRECORDER_BACKLOG * 4);
+	u32 flight_offset;
+	int i;
+
+	if (new_offset < 0)
+		new_offset = EHCA_FLIGHTRECORDER_SIZE + new_offset - 4;
+
+	printk(KERN_ERR
+	       "EHCA ----- flight recorder begin "
+	       "-------------------------------------------\n");
+
+	for (i = 0; i < EHCA_FLIGHTRECORDER_BACKLOG; i++) {
+		new_offset += 4;
+		flight_offset = (u32) new_offset % EHCA_FLIGHTRECORDER_SIZE;
+
+		printk(KERN_ERR "EHCA %02d: %.16lX %.16lX %.16lX %.16lX\n",
+		       i + 1,
+		       ehca_flightrecorder[flight_offset],
+		       ehca_flightrecorder[flight_offset + 1],
+		       ehca_flightrecorder[flight_offset + 2],
+		       ehca_flightrecorder[flight_offset + 3]);
+	}
+
+	printk(KERN_ERR
+	       "EHCA ----- flight recorder end "
+	       "---------------------------------------------\n");
+}
+
+#define EHCA_CACHE_CREATE(name)                                   \
+	ehca_module->cache_##name =                               \
+		kmem_cache_create("ehca_cache_"#name,             \
+				  sizeof(struct ehca_##name),     \
+				  0, SLAB_HWCACHE_ALIGN,          \
+				  NULL, NULL);                    \
+	if (ehca_module->cache_##name == NULL) {                  \
+		EDEB_ERR(4, "Cannot create "#name" SLAB cache."); \
+		return -ENOMEM;                                   \
+	}                                                         \
+
+/**
+ * ehca_caches_create: TODO
+ */
+int ehca_caches_create(struct ehca_module *ehca_module)
+{
+	EDEB_EN(7, "");
+
+	EHCA_CACHE_CREATE(pd);
+	EHCA_CACHE_CREATE(cq);
+	EHCA_CACHE_CREATE(qp);
+	EHCA_CACHE_CREATE(av);
+	EHCA_CACHE_CREATE(mw);
+	EHCA_CACHE_CREATE(mr);
+
+	EDEB_EX(7, "");
+
+	return 0;
+}
+
+#define EHCA_CACHE_DESTROY(name)                                               \
+	ret = kmem_cache_destroy(ehca_module->cache_##name);                   \
+	if (ret != 0) {                                                        \
+		EDEB_ERR(4, "Cannot destroy "#name" SLAB cache. ret=%x", ret); \
+		return ret;                                                    \
+	}                                                                      \
+
+/**
+ * ehca_caches_destroy - TODO
+ */
+int ehca_caches_destroy(struct ehca_module *ehca_module)
+{
+	int ret;
+
+	EDEB_EN(7, "");
+
+	EHCA_CACHE_DESTROY(pd);
+	EHCA_CACHE_DESTROY(cq);
+	EHCA_CACHE_DESTROY(qp);
+	EHCA_CACHE_DESTROY(av);
+	EHCA_CACHE_DESTROY(mw);
+	EHCA_CACHE_DESTROY(mr);
+
+	EDEB_EX(7, "");
+
+	return 0;
+}
+
+#define EHCA_HCAAVER  EHCA_BMASK_IBM(32,39)
+#define EHCA_REVID    EHCA_BMASK_IBM(40,63)
+
+/**
+ * ehca_num_ports - TODO
+ */
+int ehca_sense_attributes(struct ehca_shca *shca)
+{
+	int ret = -EINVAL;
+	u64 rc = H_Success;
+	struct query_hca_rblock *rblock;
+
+	EDEB_EN(7, "shca=%p", shca);
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4, "Cannot allocate rblock memory.");
+		ret = -ENOMEM;
+		goto num_ports0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	rc = hipz_h_query_hca(shca->ipz_hca_handle, rblock);
+	if (rc != H_Success) {
+		EDEB_ERR(4, "Cannot query device properties.rc=%lx", rc);
+		ret = -EPERM;
+		goto num_ports1;
+	}
+
+	if (ehca_nr_ports == 1)
+		shca->num_ports = 1;
+	else
+		shca->num_ports = (u8) rblock->num_ports;
+
+	EDEB(6, " ... found %x ports", rblock->num_ports);
+
+	if (ehca_hw_level == 0) {
+		u32 hcaaver;
+		u32 revid;
+
+		hcaaver = EHCA_BMASK_GET(EHCA_HCAAVER, rblock->hw_ver);
+		revid   = EHCA_BMASK_GET(EHCA_REVID, rblock->hw_ver);
+
+		EDEB(6, " ... hardware version=%x:%x",
+		     hcaaver, revid);
+
+		if ((hcaaver == 1) && (revid == 0))
+			shca->hw_level = 0;
+		else if ((hcaaver == 1) && (revid == 1))
+			shca->hw_level = 1;
+		else if ((hcaaver == 1) && (revid == 2))
+			shca->hw_level = 2;
+	}
+	EDEB(6, " ... hardware level=%x", shca->hw_level);
+
+	ret = 0;
+
+      num_ports1:
+	kfree(rblock);
+
+      num_ports0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+static int init_node_guid(struct ehca_shca* shca)
+{
+	int ret = 0;
+	struct query_hca_rblock *rblock;
+
+	EDEB_EN(7, "");
+
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (rblock == NULL) {
+		EDEB_ERR(4, "Can't allocate rblock memory.");
+		ret = -ENOMEM;
+		goto init_node_guid0;
+	}
+
+	memset(rblock, 0, PAGE_SIZE);
+
+	if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_Success) {
+		EDEB_ERR(4, "Can't query device properties");
+		ret = -EINVAL;
+		goto init_node_guid1;
+	}
+
+	memcpy(&shca->ib_device.node_guid, &rblock->node_guid, (sizeof(u64)));
+
+ init_node_guid1:
+	kfree(rblock);
+
+ init_node_guid0:
+	EDEB_EX(7, "node_guid=%lx ret=%x", shca->ib_device.node_guid, ret);
+
+	return ret;
+}
+
+int ehca_register_device(struct ehca_shca *shca)
+{
+	int ret = 0;
+
+	EDEB_EN(7, "shca=%p", shca);
+
+	ret = init_node_guid(shca);
+	if (ret != 0)
+		return ret;
+
+	strlcpy(shca->ib_device.name, "ehca%d", IB_DEVICE_NAME_MAX);
+	shca->ib_device.owner               = THIS_MODULE;
+
+	/* TODO: ABI ver later with define */
+	shca->ib_device.uverbs_abi_ver	    = 1;
+	shca->ib_device.uverbs_cmd_mask	    =
+		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
+		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
+		(1ull << IB_USER_VERBS_CMD_QUERY_PORT)		|
+		(1ull << IB_USER_VERBS_CMD_ALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_DEALLOC_PD)		|
+		(1ull << IB_USER_VERBS_CMD_REG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_DEREG_MR)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)	|
+		(1ull << IB_USER_VERBS_CMD_CREATE_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_CQ)		|
+		(1ull << IB_USER_VERBS_CMD_CREATE_QP)		|
+		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
+		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
+		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
+
+	shca->ib_device.node_type           = RDMA_NODE_IB_CA;
+	shca->ib_device.phys_port_cnt       = shca->num_ports;
+	shca->ib_device.dma_device          = &shca->ibmebus_dev->ofdev.dev;
+	shca->ib_device.query_device        = ehca_query_device;
+	shca->ib_device.query_port          = ehca_query_port;
+	shca->ib_device.query_gid           = ehca_query_gid;
+	shca->ib_device.query_pkey          = ehca_query_pkey;
+	/* shca->in_device.modify_device    = ehca_modify_device    */
+	shca->ib_device.modify_port         = ehca_modify_port;
+	shca->ib_device.alloc_ucontext      = ehca_alloc_ucontext;
+	shca->ib_device.dealloc_ucontext    = ehca_dealloc_ucontext;
+	shca->ib_device.alloc_pd            = ehca_alloc_pd;
+	shca->ib_device.dealloc_pd          = ehca_dealloc_pd;
+	shca->ib_device.create_ah	    = ehca_create_ah;
+	/* shca->ib_device.modify_ah	    = ehca_modify_ah;	    */
+	shca->ib_device.query_ah	    = ehca_query_ah;
+	shca->ib_device.destroy_ah	    = ehca_destroy_ah;
+	shca->ib_device.create_qp	    = ehca_create_qp;
+	shca->ib_device.modify_qp	    = ehca_modify_qp;
+	shca->ib_device.query_qp	    = ehca_query_qp;
+	shca->ib_device.destroy_qp	    = ehca_destroy_qp;
+	shca->ib_device.post_send	    = ehca_post_send;
+	shca->ib_device.post_recv	    = ehca_post_recv;
+	shca->ib_device.create_cq	    = ehca_create_cq;
+	shca->ib_device.destroy_cq	    = ehca_destroy_cq;
+
+	/* TODO: disabled due to func signature conflict */
+	/* shca->ib_device.resize_cq	    = ehca_resize_cq;	    */
+
+	shca->ib_device.poll_cq		    = ehca_poll_cq;
+	/* shca->ib_device.peek_cq	    = ehca_peek_cq;	    */
+	shca->ib_device.req_notify_cq	    = ehca_req_notify_cq;
+	/* shca->ib_device.req_ncomp_notif  = ehca_req_ncomp_notif; */
+	shca->ib_device.get_dma_mr	    = ehca_get_dma_mr;
+	shca->ib_device.reg_phys_mr	    = ehca_reg_phys_mr;
+	shca->ib_device.reg_user_mr	    = ehca_reg_user_mr;
+	shca->ib_device.query_mr	    = ehca_query_mr;
+	shca->ib_device.dereg_mr	    = ehca_dereg_mr;
+	shca->ib_device.rereg_phys_mr	    = ehca_rereg_phys_mr;
+	shca->ib_device.alloc_mw	    = ehca_alloc_mw;
+	shca->ib_device.bind_mw		    = ehca_bind_mw;
+	shca->ib_device.dealloc_mw	    = ehca_dealloc_mw;
+	shca->ib_device.alloc_fmr	    = ehca_alloc_fmr;
+	shca->ib_device.map_phys_fmr	    = ehca_map_phys_fmr;
+	shca->ib_device.unmap_fmr	    = ehca_unmap_fmr;
+	shca->ib_device.dealloc_fmr	    = ehca_dealloc_fmr;
+	shca->ib_device.attach_mcast	    = ehca_attach_mcast;
+	shca->ib_device.detach_mcast	    = ehca_detach_mcast;
+	/* shca->ib_device.process_mad	    = ehca_process_mad;	    */
+	shca->ib_device.mmap		    = ehca_mmap;
+
+	ret = ib_register_device(&shca->ib_device);
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+/**
+ * ehca_create_aqp1 - TODO
+ *
+ * @shca: TODO
+ */
+static int ehca_create_aqp1(struct ehca_shca *shca, u32 port)
+{
+	struct ehca_sport *sport;
+	struct ib_cq *ibcq;
+	struct ib_qp *ibqp;
+	struct ib_qp_init_attr qp_init_attr;
+	int ret = 0;
+
+	EDEB_EN(7, "shca=%p port=%x", shca, port);
+
+	sport = &shca->sport[port - 1];
+
+	if (sport->ibcq_aqp1 != NULL) {
+		EDEB_ERR(4, "AQP1 CQ is already created.");
+		return -EPERM;
+	}
+
+	ibcq = ib_create_cq(&shca->ib_device, NULL, NULL, (void*)(-1), 10);
+	if (IS_ERR(ibcq)) {
+		EDEB_ERR(4, "Cannot create AQP1 CQ.");
+		return PTR_ERR(ibcq);
+	}
+	sport->ibcq_aqp1 = ibcq;
+
+	if (sport->ibqp_aqp1 != NULL) {
+		EDEB_ERR(4, "AQP1 QP is already created.");
+		ret = -EPERM;
+		goto create_aqp1;
+	}
+
+	memset(&qp_init_attr, 0, sizeof(struct ib_qp_init_attr));
+	qp_init_attr.send_cq          = ibcq;
+	qp_init_attr.recv_cq          = ibcq;
+	qp_init_attr.sq_sig_type      = IB_SIGNAL_ALL_WR;
+	qp_init_attr.cap.max_send_wr  = 100;
+	qp_init_attr.cap.max_recv_wr  = 100;
+	qp_init_attr.cap.max_send_sge = 2;
+	qp_init_attr.cap.max_recv_sge = 1;
+	qp_init_attr.qp_type          = IB_QPT_GSI;
+	qp_init_attr.port_num         = port;
+	qp_init_attr.qp_context       = NULL;
+	qp_init_attr.event_handler    = NULL;
+	qp_init_attr.srq              = NULL;
+
+	ibqp = ib_create_qp(&shca->pd->ib_pd, &qp_init_attr);
+	if (IS_ERR(ibqp)) {
+		EDEB_ERR(4, "Cannot create AQP1 QP.");
+		ret = PTR_ERR(ibqp);
+		goto create_aqp1;
+	}
+	sport->ibqp_aqp1 = ibqp;
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+
+      create_aqp1:
+	ib_destroy_cq(sport->ibcq_aqp1);
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+/**
+ * ehca_destroy_aqp1 - TODO
+ */
+static int ehca_destroy_aqp1(struct ehca_sport *sport)
+{
+	int ret = 0;
+
+	EDEB_EN(7, "sport=%p", sport);
+
+	ret = ib_destroy_qp(sport->ibqp_aqp1);
+	if (ret != 0) {
+		EDEB_ERR(4, "Cannot destroy AQP1 QP. ret=%x", ret);
+		goto destroy_aqp1;
+	}
+
+	ret = ib_destroy_cq(sport->ibcq_aqp1);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy AQP1 CQ. ret=%x", ret);
+
+      destroy_aqp1:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+static ssize_t ehca_show_debug_level(struct device_driver *ddp, char *buf)
+{
+	int f;
+	int total = 0;
+	total += snprintf(buf + total, PAGE_SIZE - total, "%d",
+			  ehca_edeb_mask[0]);
+	for (f = 1; f < EHCA_EDEB_TRACE_MASK_SIZE; f++) {
+		total += snprintf(buf + total, PAGE_SIZE - total, ",%d",
+				  ehca_edeb_mask[f]);
+	}
+
+	total += snprintf(buf + total, PAGE_SIZE - total, "\n");
+
+	return total;
+}
+
+static ssize_t ehca_store_debug_level(struct device_driver *ddp,
+				      const char *buf, size_t count)
+{
+	int f;
+	for (f = 0; f < EHCA_EDEB_TRACE_MASK_SIZE; f++) {
+		char value = buf[f * 2] - '0';
+		if ((value <= 9) && (count >= f * 2)) {
+			ehca_edeb_mask[f] = value;
+		}
+	}
+	return count;
+}
+DRIVER_ATTR(debug_level, S_IRUSR | S_IWUSR,
+	    ehca_show_debug_level, ehca_store_debug_level);
+
+static ssize_t ehca_show_flightrecorder(struct device_driver *ddp,
+					char *buf)
+{
+	/* this is not style compliant, but snprintf is not fast enough */
+	u64 *lbuf = (u64 *) buf;
+	lbuf[0] = (u64) & ehca_flightrecorder;
+	lbuf[1] = EHCA_FLIGHTRECORDER_SIZE;
+	lbuf[2] = atomic_read(&ehca_flightrecorder_index);
+	return sizeof(u64) * 3;
+}
+DRIVER_ATTR(flightrecorder, S_IRUSR, ehca_show_flightrecorder, 0);
+
+void ehca_create_driver_sysfs(struct ibmebus_driver *drv)
+{
+	driver_create_file(&drv->driver, &driver_attr_debug_level);
+	driver_create_file(&drv->driver, &driver_attr_flightrecorder);
+}
+
+void ehca_remove_driver_sysfs(struct ibmebus_driver *drv)
+{
+	driver_remove_file(&drv->driver, &driver_attr_debug_level);
+	driver_remove_file(&drv->driver, &driver_attr_flightrecorder);
+}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12)
+#define EHCA_RESOURCE_ATTR_H(name)                                         \
+static ssize_t  ehca_show_##name(struct device *dev,                       \
+				 struct device_attribute *attr,            \
+				 char *buf)
+#else
+#define EHCA_RESOURCE_ATTR_H(name)                                         \
+static ssize_t  ehca_show_##name(struct device *dev,                       \
+				 char *buf)
+#endif
+
+#define EHCA_RESOURCE_ATTR(name)                                           \
+EHCA_RESOURCE_ATTR_H(name)                                                 \
+{									   \
+	struct ehca_shca *shca;						   \
+	struct query_hca_rblock *rblock;				   \
+	int len;							   \
+									   \
+	shca = dev->driver_data;					   \
+									   \
+	rblock = kmalloc(PAGE_SIZE, GFP_KERNEL);			   \
+	if (rblock == NULL) {						   \
+		EDEB_ERR(4, "Can't allocate rblock memory.");		   \
+		return 0;						   \
+	}								   \
+									   \
+	memset(rblock, 0, PAGE_SIZE);					   \
+									   \
+	if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_Success) { \
+			EDEB_ERR(4, "Can't query device properties");	   \
+			kfree(rblock);					   \
+			return 0;					   \
+	}								   \
+									   \
+	if ((strcmp(#name, "num_ports") == 0) && (ehca_nr_ports == 1))	   \
+		len = snprintf(buf, 256, "1");				   \
+	else								   \
+		len = snprintf(buf, 256, "%d", rblock->name);		   \
+									   \
+	if (len < 0)							   \
+		return 0;						   \
+	buf[len] = '\n';						   \
+	buf[len+1] = 0;							   \
+									   \
+	kfree(rblock);							   \
+									   \
+	return len+1;							   \
+}									   \
+static DEVICE_ATTR(name, S_IRUGO, ehca_show_##name, NULL);
+
+EHCA_RESOURCE_ATTR(num_ports);
+EHCA_RESOURCE_ATTR(hw_ver);
+EHCA_RESOURCE_ATTR(max_eq);
+EHCA_RESOURCE_ATTR(cur_eq);
+EHCA_RESOURCE_ATTR(max_cq);
+EHCA_RESOURCE_ATTR(cur_cq);
+EHCA_RESOURCE_ATTR(max_qp);
+EHCA_RESOURCE_ATTR(cur_qp);
+EHCA_RESOURCE_ATTR(max_mr);
+EHCA_RESOURCE_ATTR(cur_mr);
+EHCA_RESOURCE_ATTR(max_mw);
+EHCA_RESOURCE_ATTR(cur_mw);
+EHCA_RESOURCE_ATTR(max_pd);
+EHCA_RESOURCE_ATTR(max_ah);
+
+static ssize_t ehca_show_adapter_handle(struct device *dev,
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12)
+					struct device_attribute *attr,
+#endif
+					char *buf)
+{
+	struct ehca_shca *shca = dev->driver_data;
+
+	return sprintf(buf, "%lx\n", shca->ipz_hca_handle.handle);
+
+}
+static DEVICE_ATTR(adapter_handle, S_IRUGO, ehca_show_adapter_handle, NULL);
+
+
+
+void ehca_create_device_sysfs(struct ibmebus_dev *dev)
+{
+	device_create_file(&dev->ofdev.dev, &dev_attr_adapter_handle);
+	device_create_file(&dev->ofdev.dev, &dev_attr_num_ports);
+	device_create_file(&dev->ofdev.dev, &dev_attr_hw_ver);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_eq);
+	device_create_file(&dev->ofdev.dev, &dev_attr_cur_eq);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_cq);
+	device_create_file(&dev->ofdev.dev, &dev_attr_cur_cq);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_qp);
+	device_create_file(&dev->ofdev.dev, &dev_attr_cur_qp);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_mr);
+	device_create_file(&dev->ofdev.dev, &dev_attr_cur_mr);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_mw);
+	device_create_file(&dev->ofdev.dev, &dev_attr_cur_mw);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_pd);
+	device_create_file(&dev->ofdev.dev, &dev_attr_max_ah);
+}
+
+void ehca_remove_device_sysfs(struct ibmebus_dev *dev)
+{
+	device_remove_file(&dev->ofdev.dev, &dev_attr_adapter_handle);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_num_ports);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_hw_ver);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_eq);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_cur_eq);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_cq);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_cur_cq);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_qp);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_cur_qp);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_mr);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_cur_mr);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_mw);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_cur_mw);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_pd);
+	device_remove_file(&dev->ofdev.dev, &dev_attr_max_ah);
+}
+
+/**
+ * ehca_probe - TODO
+ */
+static int __devinit ehca_probe(struct ibmebus_dev *dev,
+				const struct of_device_id *id)
+{
+	struct ehca_shca *shca;
+	u64 *handle;
+	struct ib_pd *ibpd;
+	int ret = 0;
+
+	EDEB_EN(7, "name=%s", dev->name);
+
+	handle = (u64 *)get_property(dev->ofdev.node, "ibm,hca-handle", NULL);
+	if (!handle) {
+		EDEB_ERR(4, "Cannot get eHCA handle for adapter: %s.",
+			 dev->ofdev.node->full_name);
+		return -ENODEV;
+	}
+
+	if (!(*handle)) {
+		EDEB_ERR(4, "Wrong eHCA handle for adapter: %s.",
+			 dev->ofdev.node->full_name);
+		return -ENODEV;
+	}
+
+	shca = (struct ehca_shca *)ib_alloc_device(sizeof(*shca));
+	if (shca == NULL) {
+		EDEB_ERR(4, "Cannot allocate shca memory.");
+		return -ENOMEM;
+	}
+
+	shca->ibmebus_dev = dev;
+	shca->ipz_hca_handle.handle = *handle;
+	dev->ofdev.dev.driver_data = shca;
+
+	ret = ehca_sense_attributes(shca);
+	if (ret < 0) {
+		EDEB_ERR(4, "Cannot sense eHCA attributes.");
+		goto probe1;
+	}
+
+	/* create event queues */
+	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
+	if (ret != 0) {
+		EDEB_ERR(4, "Cannot create EQ.");
+		goto probe1;
+	}
+
+	ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
+	if (ret != 0) {
+		EDEB_ERR(4, "Cannot create NEQ.");
+		goto probe2;
+	}
+
+	/* create internal protection domain */
+	ibpd = ehca_alloc_pd(&shca->ib_device, (void*)(-1), 0);
+	if (IS_ERR(ibpd)) {
+		EDEB_ERR(4, "Cannot create internal PD.");
+		ret = PTR_ERR(ibpd);
+		goto probe3;
+	}
+
+	shca->pd = container_of(ibpd, struct ehca_pd, ib_pd);
+	shca->pd->ib_pd.device = &shca->ib_device;
+
+	/* create internal max MR */
+	if (shca->maxmr == 0) {
+		struct ehca_mr *e_maxmr = 0;
+		ret = ehca_reg_internal_maxmr(shca, shca->pd, &e_maxmr);
+		if (ret != 0) {
+			EDEB_ERR(4, "Cannot create internal MR. ret=%x", ret);
+			goto probe4;
+		}
+		shca->maxmr = e_maxmr;
+	}
+
+	ret = ehca_register_device(shca);
+	if (ret != 0) {
+		EDEB_ERR(4, "Cannot register Infiniband device.");
+		goto probe5;
+	}
+
+	/* create AQP1 for port 1 */
+	if (ehca_open_aqp1 == 1) {
+		shca->sport[0].port_state = IB_PORT_DOWN;
+		ret = ehca_create_aqp1(shca, 1);
+		if (ret != 0) {
+			EDEB_ERR(4, "Cannot create AQP1 for port 1.");
+			goto probe6;
+		}
+	}
+
+	/* create AQP1 for port 2 */
+	if ((ehca_open_aqp1 == 1) && (shca->num_ports == 2)) {
+		shca->sport[1].port_state = IB_PORT_DOWN;
+		ret = ehca_create_aqp1(shca, 2);
+		if (ret != 0) {
+			EDEB_ERR(4, "Cannot create AQP1 for port 2.");
+			goto probe7;
+		}
+	}
+
+	ehca_create_device_sysfs(dev);
+
+	spin_lock(&ehca_module.shca_lock);
+	list_add(&shca->shca_list, &ehca_module.shca_list);
+	spin_unlock(&ehca_module.shca_lock);
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return 0;
+
+ probe7:
+	ret = ehca_destroy_aqp1(&shca->sport[0]);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy AQP1 for port 1. ret=%x", ret);
+
+ probe6:
+	ib_unregister_device(&shca->ib_device);
+
+ probe5:
+	ret = ehca_dereg_internal_maxmr(shca);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy internal MR. ret=%x", ret);
+
+ probe4:
+	ret = ehca_dealloc_pd(&shca->pd->ib_pd);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy internal PD. ret=%x", ret);
+
+ probe3:
+	ret = ehca_destroy_eq(shca, &shca->neq);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy NEQ. ret=%x", ret);
+
+ probe2:
+	ret = ehca_destroy_eq(shca, &shca->eq);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy EQ. ret=%x", ret);
+
+ probe1:
+	ib_dealloc_device(&shca->ib_device);
+
+	EDEB_EX(4, "ret=%x", ret);
+
+	return -EINVAL;
+}
+
+static int __devexit ehca_remove(struct ibmebus_dev *dev)
+{
+	struct ehca_shca *shca = dev->ofdev.dev.driver_data;
+	int ret;
+
+	EDEB_EN(7, "shca=%p", shca);
+
+	ehca_remove_device_sysfs(dev);
+
+	if (ehca_open_aqp1 == 1) {
+		int i;
+
+		for (i = 0; i < shca->num_ports; i++) {
+			ret = ehca_destroy_aqp1(&shca->sport[i]);
+			if (ret != 0)
+				EDEB_ERR(4, "Cannot destroy AQP1 for port %x."
+					 " ret=%x", ret, i);
+		}
+	}
+
+	ib_unregister_device(&shca->ib_device);
+
+	ret = ehca_dereg_internal_maxmr(shca);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy internal MR. ret=%x", ret);
+
+	ret = ehca_dealloc_pd(&shca->pd->ib_pd);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy internal PD. ret=%x", ret);
+
+	ret = ehca_destroy_eq(shca, &shca->eq);
+	if (ret != 0)
+		EDEB_ERR(4, "Cannot destroy EQ. ret=%x", ret);
+
+	ret = ehca_destroy_eq(shca, &shca->neq);
+	if (ret != 0)
+		EDEB_ERR(4, "Canot destroy NEQ. ret=%x", ret);
+
+	ib_dealloc_device(&shca->ib_device);
+
+	spin_lock(&ehca_module.shca_lock);
+	list_del(&shca->shca_list);
+	spin_unlock(&ehca_module.shca_lock);
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+}
+
+static struct of_device_id ehca_device_table[] =
+{
+	{
+		.name       = "lhca",
+		.compatible = "IBM,lhca",
+	},
+	{},
+};
+
+static struct ibmebus_driver ehca_driver = {
+	.name     = "ehca",
+	.id_table = ehca_device_table,
+	.probe    = ehca_probe,
+	.remove   = ehca_remove,
+};
+
+/**
+ * ehca_module_init - eHCA initialization routine.
+ */
+int __init ehca_module_init(void)
+{
+	int ret = 0;
+
+	printk(KERN_INFO "eHCA Infiniband Device Driver "
+	                 "(Rel.: EHCA2_0047)\n");
+	EDEB_EN(7, "");
+
+	idr_init(&ehca_qp_idr);
+	idr_init(&ehca_cq_idr);
+
+	INIT_LIST_HEAD(&ehca_module.shca_list);
+	spin_lock_init(&ehca_module.shca_lock);
+
+	ehca_init_trace();
+	ehca_init_flight();
+
+	ehca_wq = create_workqueue("ehca");
+	if (ehca_wq == NULL) {
+		EDEB_ERR(4, "Cannot create workqueue.");
+		ret = -ENOMEM;
+		goto module_init0;
+	}
+
+	if ((ret = ehca_caches_create(&ehca_module)) != 0) {
+		ehca_catastrophic("Cannot create SLAB caches");
+		ret = -ENOMEM;
+		goto module_init1;
+	}
+
+	if ((ret = ibmebus_register_driver(&ehca_driver)) != 0) {
+		ehca_catastrophic("Cannot register eHCA device driver");
+		ret = -EINVAL;
+		goto module_init2;
+	}
+
+	ehca_create_driver_sysfs(&ehca_driver);
+
+	if (ehca_poll_all_eqs != 1) {
+		EDEB_ERR(4, "WARNING!!!");
+		EDEB_ERR(4, "It is possible to lose interrupts.");
+
+		return 0;
+	}
+
+	ehca_kthread_eq = kthread_create(ehca_poll_eqs, &ehca_module,
+					 "ehca_poll_eqs");
+	if (IS_ERR(ehca_kthread_eq)) {
+		EDEB_ERR(4, "Cannot create kthread_eq");
+		ret = PTR_ERR(ehca_kthread_eq);
+		goto module_init3;
+	}
+
+	wake_up_process(ehca_kthread_eq);
+
+	EDEB_EX(7, "ret=%x", ret);
+
+	return 0;
+
+ module_init3:
+	ehca_remove_driver_sysfs(&ehca_driver);
+	ibmebus_unregister_driver(&ehca_driver);
+
+ module_init2:
+	ehca_caches_destroy(&ehca_module);
+
+ module_init1:
+	destroy_workqueue(ehca_wq);
+
+ module_init0:
+	EDEB_EX(7, "ret=%x", ret);
+
+	return ret;
+};
+
+/**
+ * ehca_module_exit - eHCA exit routine.
+ */
+void __exit ehca_module_exit(void)
+{
+	EDEB_EN(7, "");
+
+	if (ehca_poll_all_eqs == 1)
+		kthread_stop(ehca_kthread_eq);
+
+	ehca_remove_driver_sysfs(&ehca_driver);
+	ibmebus_unregister_driver(&ehca_driver);
+
+	if (ehca_caches_destroy(&ehca_module) != 0)
+		ehca_catastrophic("Cannot destroy SLAB caches");
+
+	destroy_workqueue(ehca_wq);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15)
+	idr_destroy_ext(&ehca_cq_idr);
+	idr_destroy_ext(&ehca_qp_idr);
+#else
+	idr_destroy(&ehca_cq_idr);
+	idr_destroy(&ehca_qp_idr);
+#endif
+
+	EDEB_EX(7, "");
+};
+
+module_init(ehca_module_init);
+module_exit(ehca_module_exit);
