Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUKWQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUKWQmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUKWQmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:42:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:33663 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261336AbUKWQOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:49 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123814.xOcI2C4YpT1G9jQi@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:40 -0800
Message-Id: <20041123814.sBoIUxeLIDc9lo4V@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][5/21] Add InfiniBand MAD (management datagram) support
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:47.0084 (UTC) FILETIME=[8D0B06C0:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handling InfiniBand MADs (management datagrams),
including sending and receiving MADs as well as passing MADs on to
local agents.

This is required for an SM (subnet manager) to discover and configure
the host, since the SM's query MADs must be passed to the local SMA
(subnet management agent).  In addition, this support is used by upper
level protocols to send queries to and receive responses from the SM.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/infiniband/core/Makefile	2004-11-23 08:10:16.496130013 -0800
+++ linux-bk/drivers/infiniband/core/Makefile	2004-11-23 08:10:17.978911380 -0800
@@ -1,7 +1,8 @@
 EXTRA_CFLAGS += -Idrivers/infiniband/include
 
 obj-$(CONFIG_INFINIBAND) += \
-    ib_core.o
+    ib_core.o \
+    ib_mad.o
 
 ib_core-objs := \
     packer.o \
@@ -11,3 +12,8 @@
     device.o \
     fmr_pool.o \
     cache.o
+
+ib_mad-objs := \
+    mad.o \
+    smi.o \
+    agent.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/agent.c	2004-11-23 08:10:18.065898554 -0800
@@ -0,0 +1,390 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#include <linux/dma-mapping.h>
+
+#include <asm/bug.h>
+
+#include <ib_smi.h>
+
+#include "smi.h"
+#include "agent_priv.h"
+#include "mad_priv.h"
+
+
+spinlock_t ib_agent_port_list_lock;
+static LIST_HEAD(ib_agent_port_list);
+
+extern kmem_cache_t *ib_mad_cache;
+
+
+/*
+ * Caller must hold ib_agent_port_list_lock
+ */
+static inline struct ib_agent_port_private *
+__ib_get_agent_port(struct ib_device *device, int port_num,
+		    struct ib_mad_agent *mad_agent)
+{
+	struct ib_agent_port_private *entry;
+
+	BUG_ON(!(!!device ^ !!mad_agent));  /* Exactly one MUST be (!NULL) */
+
+	if (device) {
+		list_for_each_entry(entry, &ib_agent_port_list, port_list) {
+			if (entry->dr_smp_agent->device == device &&
+			    entry->port_num == port_num)
+				return entry;
+		}
+	} else {
+		list_for_each_entry(entry, &ib_agent_port_list, port_list) {
+			if ((entry->dr_smp_agent == mad_agent) ||
+			    (entry->lr_smp_agent == mad_agent) ||
+			    (entry->perf_mgmt_agent == mad_agent))
+				return entry;
+		}
+	}
+	return NULL;
+}
+
+static inline struct ib_agent_port_private *
+ib_get_agent_port(struct ib_device *device, int port_num,
+		  struct ib_mad_agent *mad_agent)
+{
+	struct ib_agent_port_private *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
+	entry = __ib_get_agent_port(device, port_num, mad_agent);
+	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
+
+	return entry;
+}
+
+int smi_check_local_dr_smp(struct ib_smp *smp,
+			   struct ib_device *device,
+			   int port_num)
+{
+	struct ib_agent_port_private *port_priv;
+
+	if (smp->mgmt_class != IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+		return 1;
+	port_priv = ib_get_agent_port(device, port_num, NULL);
+	if (!port_priv) {
+		printk(KERN_DEBUG SPFX "smi_check_local_dr_smp %s port %d "
+		       "not open\n",
+		       device->name, port_num);
+		return 1;
+	}
+
+	return smi_check_local_smp(port_priv->dr_smp_agent, smp);
+}
+
+static int agent_mad_send(struct ib_mad_agent *mad_agent,
+			  struct ib_agent_port_private *port_priv,
+			  struct ib_mad_private *mad,
+			  struct ib_grh *grh,
+			  struct ib_wc *wc)
+{
+	struct ib_agent_send_wr *agent_send_wr;
+	struct ib_sge gather_list;
+	struct ib_send_wr send_wr;
+	struct ib_send_wr *bad_send_wr;
+	struct ib_ah_attr ah_attr;
+	unsigned long flags;
+	int ret = 1;
+
+	agent_send_wr = kmalloc(sizeof(*agent_send_wr), GFP_KERNEL);
+	if (!agent_send_wr)
+		goto out;
+	agent_send_wr->mad = mad;
+
+	/* PCI mapping */
+	gather_list.addr = dma_map_single(mad_agent->device->dma_device,
+					  &mad->mad,
+					  sizeof(mad->mad),
+					  DMA_TO_DEVICE);
+	gather_list.length = sizeof(mad->mad);
+	gather_list.lkey = (*port_priv->mr).lkey;
+
+	send_wr.next = NULL;
+	send_wr.opcode = IB_WR_SEND;
+	send_wr.sg_list = &gather_list;
+	send_wr.num_sge = 1;
+	send_wr.wr.ud.remote_qpn = wc->src_qp; /* DQPN */
+	send_wr.wr.ud.timeout_ms = 0;
+	send_wr.send_flags = IB_SEND_SIGNALED | IB_SEND_SOLICITED;
+
+	ah_attr.dlid = wc->slid;
+	ah_attr.port_num = mad_agent->port_num;
+	ah_attr.src_path_bits = wc->dlid_path_bits;
+	ah_attr.sl = wc->sl;
+	ah_attr.static_rate = 0;
+	if (mad->mad.mad.mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT) {
+		if (wc->wc_flags & IB_WC_GRH) {
+			ah_attr.ah_flags = IB_AH_GRH;
+			/* Should sgid be looked up ? */
+			ah_attr.grh.sgid_index = 0;
+			ah_attr.grh.hop_limit = grh->hop_limit;
+			ah_attr.grh.flow_label = be32_to_cpup(
+				&grh->version_tclass_flow)  & 0xffff;
+			ah_attr.grh.traffic_class = (be32_to_cpup(
+				&grh->version_tclass_flow) >> 20) & 0xff;
+			memcpy(ah_attr.grh.dgid.raw,
+			       grh->sgid.raw,
+			       sizeof(struct ib_grh));
+		} else {
+			ah_attr.ah_flags = 0; /* No GRH for SM class */
+		}
+	} else {
+		/* Directed route or LID routed SM class */
+		ah_attr.ah_flags = 0; /* No GRH */
+	}
+
+	agent_send_wr->ah = ib_create_ah(mad_agent->qp->pd, &ah_attr);
+	if (IS_ERR(agent_send_wr->ah)) {
+		printk(KERN_ERR SPFX "No memory for address handle\n");
+		kfree(agent_send_wr);
+		goto out;
+	}
+
+	send_wr.wr.ud.ah = agent_send_wr->ah;
+	if (mad->mad.mad.mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT) {
+		send_wr.wr.ud.pkey_index = wc->pkey_index;
+		send_wr.wr.ud.remote_qkey = IB_QP1_QKEY;
+	} else {
+		send_wr.wr.ud.pkey_index = 0; /* Should only matter for GMPs */
+		send_wr.wr.ud.remote_qkey = 0; /* for SMPs */
+	}
+	send_wr.wr.ud.mad_hdr = &mad->mad.mad.mad_hdr;
+	send_wr.wr_id = (unsigned long)agent_send_wr;
+
+	pci_unmap_addr_set(agent_send_wr, mapping, gather_list.addr);
+
+	/* Send */
+	spin_lock_irqsave(&port_priv->send_list_lock, flags);
+	if (ib_post_send_mad(mad_agent, &send_wr, &bad_send_wr)) {
+		spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
+		dma_unmap_single(mad_agent->device->dma_device,
+				 pci_unmap_addr(agent_send_wr, mapping),
+				 sizeof(mad->mad),
+				 DMA_TO_DEVICE);
+		ib_destroy_ah(agent_send_wr->ah);
+		kfree(agent_send_wr);
+	} else {
+		list_add_tail(&agent_send_wr->send_list,
+			      &port_priv->send_posted_list);
+		spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
+		ret = 0;
+	}
+
+out:
+	return ret;
+}
+
+int agent_send(struct ib_mad_private *mad,
+	       struct ib_grh *grh,
+	       struct ib_wc *wc,
+	       struct ib_device *device,
+	       int port_num)
+{
+	struct ib_agent_port_private *port_priv;
+	struct ib_mad_agent *mad_agent;
+
+	port_priv = ib_get_agent_port(device, port_num, NULL);
+	if (!port_priv) {
+		printk(KERN_DEBUG SPFX "agent_send %s port %d not open\n",
+		       device->name, port_num);
+		return 1;
+	}
+
+	/* Get mad agent based on mgmt_class in MAD */
+	switch (mad->mad.mad.mad_hdr.mgmt_class) {
+		case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
+			mad_agent = port_priv->dr_smp_agent;
+			break;
+		case IB_MGMT_CLASS_SUBN_LID_ROUTED:
+			mad_agent = port_priv->lr_smp_agent;
+			break;
+		case IB_MGMT_CLASS_PERF_MGMT:
+			mad_agent = port_priv->perf_mgmt_agent;
+			break;
+		default:
+			return 1;
+	}
+
+	return agent_mad_send(mad_agent, port_priv, mad, grh, wc);
+}
+
+static void agent_send_handler(struct ib_mad_agent *mad_agent,
+			       struct ib_mad_send_wc *mad_send_wc)
+{
+	struct ib_agent_port_private	*port_priv;
+	struct ib_agent_send_wr		*agent_send_wr;
+	unsigned long			flags;
+
+	/* Find matching MAD agent */
+	port_priv = ib_get_agent_port(NULL, 0, mad_agent);
+	if (!port_priv) {
+		printk(KERN_ERR SPFX "agent_send_handler: no matching MAD "
+		       "agent %p\n", mad_agent);
+		return;
+	}
+
+	agent_send_wr = (struct ib_agent_send_wr *)(unsigned long)mad_send_wc->wr_id;
+	spin_lock_irqsave(&port_priv->send_list_lock, flags);
+	/* Remove completed send from posted send MAD list */
+	list_del(&agent_send_wr->send_list);
+	spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
+
+	/* Unmap PCI */
+	dma_unmap_single(mad_agent->device->dma_device,
+			 pci_unmap_addr(agent_send_wr, mapping),
+			 sizeof(agent_send_wr->mad->mad),
+			 DMA_TO_DEVICE);
+
+	ib_destroy_ah(agent_send_wr->ah);
+
+	/* Release allocated memory */
+	kmem_cache_free(ib_mad_cache, agent_send_wr->mad);
+	kfree(agent_send_wr);
+}
+
+int ib_agent_port_open(struct ib_device *device, int port_num)
+{
+	int ret;
+	struct ib_agent_port_private *port_priv;
+	struct ib_mad_reg_req reg_req;
+	unsigned long flags;
+
+	/* First, check if port already open for SMI */
+	port_priv = ib_get_agent_port(device, port_num, NULL);
+	if (port_priv) {
+		printk(KERN_DEBUG SPFX "%s port %d already open\n",
+		       device->name, port_num);
+		return 0;
+	}
+
+	/* Create new device info */
+	port_priv = kmalloc(sizeof *port_priv, GFP_KERNEL);
+	if (!port_priv) {
+		printk(KERN_ERR SPFX "No memory for ib_agent_port_private\n");
+		ret = -ENOMEM;
+		goto error1;
+	}
+
+	memset(port_priv, 0, sizeof *port_priv);
+	port_priv->port_num = port_num;
+	spin_lock_init(&port_priv->send_list_lock);
+	INIT_LIST_HEAD(&port_priv->send_posted_list);
+
+	/* Obtain MAD agent for directed route SM class */
+	reg_req.mgmt_class = IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE;
+	reg_req.mgmt_class_version = 1;
+
+	port_priv->dr_smp_agent = ib_register_mad_agent(device, port_num,
+							IB_QPT_SMI,
+							NULL, 0,
+						       &agent_send_handler,
+							NULL, NULL);
+
+	if (IS_ERR(port_priv->dr_smp_agent)) {
+		ret = PTR_ERR(port_priv->dr_smp_agent);
+		goto error2;
+	}
+
+	/* Obtain MAD agent for LID routed SM class */
+	reg_req.mgmt_class = IB_MGMT_CLASS_SUBN_LID_ROUTED;
+	port_priv->lr_smp_agent = ib_register_mad_agent(device, port_num,
+							IB_QPT_SMI,
+							NULL, 0,
+						       &agent_send_handler,
+							NULL, NULL);
+	if (IS_ERR(port_priv->lr_smp_agent)) {
+		ret = PTR_ERR(port_priv->lr_smp_agent);
+		goto error3;
+	}
+
+	/* Obtain MAD agent for PerfMgmt class */
+	reg_req.mgmt_class = IB_MGMT_CLASS_PERF_MGMT;
+	port_priv->perf_mgmt_agent = ib_register_mad_agent(device, port_num,
+							   IB_QPT_GSI,
+							   NULL, 0,
+							  &agent_send_handler,
+							   NULL, NULL);
+	if (IS_ERR(port_priv->perf_mgmt_agent)) {
+		ret = PTR_ERR(port_priv->perf_mgmt_agent);
+		goto error4;
+	}
+
+	port_priv->mr = ib_get_dma_mr(port_priv->dr_smp_agent->qp->pd,
+				      IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(port_priv->mr)) {
+		printk(KERN_ERR SPFX "Couldn't get DMA MR\n");
+		ret = PTR_ERR(port_priv->mr);
+		goto error5;
+	} 
+
+	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
+	list_add_tail(&port_priv->port_list, &ib_agent_port_list);
+	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
+
+	return 0;
+
+error5:
+	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
+error4:
+	ib_unregister_mad_agent(port_priv->lr_smp_agent);
+error3:
+	ib_unregister_mad_agent(port_priv->dr_smp_agent);
+error2:
+	kfree(port_priv);
+error1:
+	return ret;
+}
+
+int ib_agent_port_close(struct ib_device *device, int port_num)
+{
+	struct ib_agent_port_private *port_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
+	port_priv = __ib_get_agent_port(device, port_num, NULL);
+	if (port_priv == NULL) {
+		spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
+		printk(KERN_ERR SPFX "Port %d not found\n", port_num);
+		return -ENODEV;
+	}
+	list_del(&port_priv->port_list);
+	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
+
+	ib_dereg_mr(port_priv->mr);
+
+	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
+	ib_unregister_mad_agent(port_priv->lr_smp_agent);
+	ib_unregister_mad_agent(port_priv->dr_smp_agent);
+	kfree(port_priv);
+
+	return 0;
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/agent.h	2004-11-23 08:10:18.154885433 -0800
@@ -0,0 +1,42 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#ifndef __AGENT_H_
+#define __AGENT_H_
+
+extern spinlock_t ib_agent_port_list_lock;
+
+extern int ib_agent_port_open(struct ib_device *device,
+			      int port_num);
+
+extern int ib_agent_port_close(struct ib_device *device, int port_num);
+
+extern int agent_send(struct ib_mad_private *mad,
+		      struct ib_grh *grh,
+		      struct ib_wc *wc,
+		      struct ib_device *device,
+		      int port_num);
+
+#endif	/* __AGENT_H_ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/agent_priv.h	2004-11-23 08:10:18.178881895 -0800
@@ -0,0 +1,51 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#ifndef __IB_AGENT_PRIV_H__
+#define __IB_AGENT_PRIV_H__
+
+#include <linux/pci.h>
+
+#define SPFX "ib_agent: "
+
+struct ib_agent_send_wr {
+	struct list_head send_list;
+	struct ib_ah *ah;
+	struct ib_mad_private *mad;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+};
+
+struct ib_agent_port_private {
+	struct list_head port_list;
+	struct list_head send_posted_list;
+	spinlock_t send_list_lock;
+	int port_num;
+	struct ib_mad_agent *dr_smp_agent;    /* DR SM class */
+	struct ib_mad_agent *lr_smp_agent;    /* LR SM class */
+	struct ib_mad_agent *perf_mgmt_agent; /* PerfMgmt class */
+	struct ib_mr *mr;
+};
+
+#endif	/* __IB_AGENT_PRIV_H__ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/mad.c	2004-11-23 08:10:18.021905041 -0800
@@ -0,0 +1,2109 @@
+/*
+ * Copyright (c) 2004, Voltaire, Inc. All rights reserved.
+ * Maintained by: vtrmaint1@voltaire.com
+ *
+ * This program is intended for the purpose of Infiniband
+ * protocol stack for Linux Servers. 
+ *
+ * This software program is free software and you are free to modifyi
+ * and/or redistribute it under a choice of one of the following two
+ * licenses:
+ *
+ * 1) under either the GNU General Public License (GPL) Version 2, June 1991,
+ *    a copy of which is in the file LICENSE_GPL_V2.txt in the root directory.
+ *    This GPL license is also available from the Free Software Foundation,
+ *    Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA, or on the
+ *    web at http://www.fsf.org/copyleft/gpl.html
+ *
+ * OR
+ *
+ * 2) under the terms of the "The BSD License" a copy of which is in the file
+ *    LICENSE2.txt in the root directory. The license is also available from
+ *    the Open Source Initiative, on the web at
+ *    http://www.opensource.org/licenses/bsd-license.php.
+ *
+ *
+ *    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *
+ *
+ * To obtain a copy of these licenses, the source code to this software or
+ * for other questions, you may write to Voltaire, Inc.,
+ * Attention: Voltaire openSource maintainer, 
+ * Voltaire, Inc. 54 Middlesex Turnpike Bedford, MA 01730 or
+ * by Email: vtrmaint1@voltaire.com
+ *
+ * Licensee has the right to choose either one of the above two licenses.
+ *
+ * Redistributions of source code must retain both the above copyright
+ * notice and either one of the license notices.
+ *
+ * Redistributions in binary form must reproduce both the above copyright
+ * notice, either one of the license notices in the documentation
+ * and/or other materials provided with the distribution.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+
+#include <ib_mad.h>
+
+#include "mad_priv.h"
+#include "smi.h"
+#include "agent.h"
+
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("kernel IB MAD API");
+MODULE_AUTHOR("Hal Rosenstock");
+MODULE_AUTHOR("Sean Hefty");
+
+
+kmem_cache_t *ib_mad_cache;
+static struct list_head ib_mad_port_list;
+static u32 ib_mad_client_id = 0;
+
+/* Port list lock */
+static spinlock_t ib_mad_port_list_lock;
+
+
+/* Forward declarations */
+static int method_in_use(struct ib_mad_mgmt_method_table **method,
+			 struct ib_mad_reg_req *mad_reg_req);
+static int add_mad_reg_req(struct ib_mad_reg_req *mad_reg_req,
+			   struct ib_mad_agent_private *priv);
+static void remove_mad_reg_req(struct ib_mad_agent_private *priv); 
+static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
+				    struct ib_mad_private *mad);
+static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv);
+static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
+				    struct ib_mad_send_wc *mad_send_wc);
+static void timeout_sends(void *data);
+static int solicited_mad(struct ib_mad *mad);
+
+/*
+ * Returns a ib_mad_port_private structure or NULL for a device/port
+ * Assumes ib_mad_port_list_lock is being held
+ */
+static inline struct ib_mad_port_private *
+__ib_get_mad_port(struct ib_device *device, int port_num)
+{
+	struct ib_mad_port_private *entry;
+
+	list_for_each_entry(entry, &ib_mad_port_list, port_list) {
+		if (entry->device == device && entry->port_num == port_num)
+			return entry;
+	}
+	return NULL;
+}
+
+/*
+ * Wrapper function to return a ib_mad_port_private structure or NULL
+ * for a device/port
+ */
+static inline struct ib_mad_port_private *
+ib_get_mad_port(struct ib_device *device, int port_num)
+{
+	struct ib_mad_port_private *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ib_mad_port_list_lock, flags);
+	entry = __ib_get_mad_port(device, port_num);
+	spin_unlock_irqrestore(&ib_mad_port_list_lock, flags);
+
+	return entry;
+}
+
+static inline u8 convert_mgmt_class(u8 mgmt_class)
+{
+	/* Alias IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE to 0 */
+	return mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE ?
+		0 : mgmt_class;
+}
+
+static int get_spl_qp_index(enum ib_qp_type qp_type)
+{
+	switch (qp_type)
+	{
+	case IB_QPT_SMI:
+		return 0;
+	case IB_QPT_GSI:
+		return 1;
+	default:
+		return -1;
+	}
+}
+
+/*
+ * ib_register_mad_agent - Register to send/receive MADs
+ */
+struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
+					   u8 port_num,
+					   enum ib_qp_type qp_type,
+					   struct ib_mad_reg_req *mad_reg_req,
+					   u8 rmpp_version,
+					   ib_mad_send_handler send_handler,
+					   ib_mad_recv_handler recv_handler,
+					   void *context)
+{
+	struct ib_mad_port_private *port_priv;
+	struct ib_mad_agent *ret;
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_reg_req *reg_req = NULL;
+	struct ib_mad_mgmt_class_table *class;
+	struct ib_mad_mgmt_method_table *method;
+	int ret2, qpn;
+	unsigned long flags;
+	u8 mgmt_class;
+
+	/* Validate parameters */
+	qpn = get_spl_qp_index(qp_type);
+	if (qpn == -1) {
+		ret = ERR_PTR(-EINVAL);
+		goto error1;
+	}
+
+	if (rmpp_version) {
+		ret = ERR_PTR(-EINVAL);	/* XXX: until RMPP implemented */
+		goto error1;
+	}
+
+	/* Validate MAD registration request if supplied */
+	if (mad_reg_req) {
+		if (mad_reg_req->mgmt_class_version >= MAX_MGMT_VERSION) {
+			ret = ERR_PTR(-EINVAL);
+			goto error1;
+		}
+		if (!recv_handler) {
+			ret = ERR_PTR(-EINVAL);
+			goto error1;
+		}
+		if (mad_reg_req->mgmt_class >= MAX_MGMT_CLASS) {
+			/*
+			 * IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE is the only
+			 * one in this range currently allowed
+			 */
+			if (mad_reg_req->mgmt_class !=
+			    IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
+				ret = ERR_PTR(-EINVAL);
+				goto error1;
+			}
+		} else if (mad_reg_req->mgmt_class == 0) {
+			/* 
+			 * Class 0 is reserved in IBA and is used for 
+			 * aliasing of IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE
+			 */
+			ret = ERR_PTR(-EINVAL);
+			goto error1;
+		}
+	} else {
+		/* No registration request supplied */
+		if (!send_handler) {
+			ret = ERR_PTR(-EINVAL);
+			goto error1;
+		}
+	}
+
+	/* Validate device and port */
+	port_priv = ib_get_mad_port(device, port_num);
+	if (!port_priv) {
+		ret = ERR_PTR(-ENODEV);
+		goto error1;
+	}
+
+	/* Allocate structures */
+	mad_agent_priv = kmalloc(sizeof *mad_agent_priv, GFP_KERNEL);
+	if (!mad_agent_priv) { 
+		ret = ERR_PTR(-ENOMEM);
+		goto error1;
+	}
+
+	if (mad_reg_req) {
+		reg_req = kmalloc(sizeof *reg_req, GFP_KERNEL);
+		if (!reg_req) {
+			ret = ERR_PTR(-ENOMEM);
+			goto error2;
+		}
+		/* Make a copy of the MAD registration request */
+		memcpy(reg_req, mad_reg_req, sizeof *reg_req);
+	}
+ 
+	/* Now, fill in the various structures */
+	memset(mad_agent_priv, 0, sizeof *mad_agent_priv);
+	mad_agent_priv->qp_info = &port_priv->qp_info[qpn];
+	mad_agent_priv->reg_req = reg_req;
+	mad_agent_priv->rmpp_version = rmpp_version;
+	mad_agent_priv->agent.device = device;
+	mad_agent_priv->agent.recv_handler = recv_handler;
+	mad_agent_priv->agent.send_handler = send_handler;
+	mad_agent_priv->agent.context = context;
+	mad_agent_priv->agent.qp = port_priv->qp_info[qpn].qp;
+	mad_agent_priv->agent.port_num = port_num;
+
+	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	mad_agent_priv->agent.hi_tid = ++ib_mad_client_id;
+
+	/*
+	 * Make sure MAD registration (if supplied)
+	 * is non overlapping with any existing ones
+	 */
+	if (mad_reg_req) {
+		class = port_priv->version[mad_reg_req->mgmt_class_version];
+		if (class) {
+			mgmt_class = convert_mgmt_class(
+						mad_reg_req->mgmt_class);
+			method = class->method_table[mgmt_class];
+			if (method) {
+				if (method_in_use(&method, mad_reg_req)) {
+					ret = ERR_PTR(-EINVAL);
+					goto error3;
+				}
+			}
+		}
+	}
+
+	ret2 = add_mad_reg_req(mad_reg_req, mad_agent_priv);
+	if (ret2) {
+		ret = ERR_PTR(ret2);	
+		goto error3;	
+	}
+
+	/* Add mad agent into port's agent list */
+	list_add_tail(&mad_agent_priv->agent_list, &port_priv->agent_list);
+	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+
+	spin_lock_init(&mad_agent_priv->lock);
+	INIT_LIST_HEAD(&mad_agent_priv->send_list);
+	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
+	INIT_WORK(&mad_agent_priv->work, timeout_sends, mad_agent_priv);
+	atomic_set(&mad_agent_priv->refcount, 1);
+	init_waitqueue_head(&mad_agent_priv->wait);
+
+	return &mad_agent_priv->agent;
+
+error3:
+	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+	kfree(reg_req);
+error2:
+	kfree(mad_agent_priv);
+error1:
+	return ret;	
+}
+EXPORT_SYMBOL(ib_register_mad_agent);
+
+/*
+ * ib_unregister_mad_agent - Unregisters a client from using MAD services
+ */
+int ib_unregister_mad_agent(struct ib_mad_agent *mad_agent)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_port_private *port_priv;
+	unsigned long flags;
+
+	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
+				      agent);
+
+	/* Note that we could still be handling received MADs */
+
+	/*
+	 * Canceling all sends results in dropping received response
+	 * MADs, preventing us from queuing additional work
+	 */
+	cancel_mads(mad_agent_priv);
+
+	port_priv = mad_agent_priv->qp_info->port_priv;
+	cancel_delayed_work(&mad_agent_priv->work);
+	flush_workqueue(port_priv->wq);
+
+	spin_lock_irqsave(&port_priv->reg_lock, flags);
+	remove_mad_reg_req(mad_agent_priv);
+	list_del(&mad_agent_priv->agent_list);
+	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+
+	/* XXX: Cleanup pending RMPP receives for this agent */
+
+	atomic_dec(&mad_agent_priv->refcount);
+	wait_event(mad_agent_priv->wait,
+		   !atomic_read(&mad_agent_priv->refcount));
+
+	if (mad_agent_priv->reg_req)
+		kfree(mad_agent_priv->reg_req);
+	kfree(mad_agent_priv);
+	return 0;
+}
+EXPORT_SYMBOL(ib_unregister_mad_agent);
+
+static void dequeue_mad(struct ib_mad_list_head *mad_list)
+{
+	struct ib_mad_queue *mad_queue;
+	unsigned long flags;
+
+	BUG_ON(!mad_list->mad_queue);
+	mad_queue = mad_list->mad_queue;
+	spin_lock_irqsave(&mad_queue->lock, flags);
+	list_del(&mad_list->list);
+	mad_queue->count--;
+	spin_unlock_irqrestore(&mad_queue->lock, flags);
+}
+
+/*
+ * Return 0 if SMP is to be sent
+ * Return 1 if SMP was consumed locally (whether or not solicited)
+ * Return < 0 if error 
+ */
+static int handle_outgoing_smp(struct ib_mad_agent *mad_agent,
+			       struct ib_smp *smp,
+			       struct ib_send_wr *send_wr)
+{
+	int ret;
+
+	if (!smi_handle_dr_smp_send(smp,
+				    mad_agent->device->node_type,
+				    mad_agent->port_num)) {
+		ret = -EINVAL;
+		printk(KERN_ERR PFX "Invalid directed route\n");
+		goto error1;
+	}
+	if (smi_check_local_dr_smp(smp,
+				   mad_agent->device,
+				   mad_agent->port_num)) {
+		struct ib_mad_private *mad_priv;
+		struct ib_mad_agent_private *mad_agent_priv;
+		struct ib_mad_send_wc mad_send_wc;
+
+		mad_priv = kmem_cache_alloc(ib_mad_cache,
+					    (in_atomic() || irqs_disabled()) ?
+					    GFP_ATOMIC : GFP_KERNEL);
+		if (!mad_priv) {
+			ret = -ENOMEM;
+			printk(KERN_ERR PFX "No memory for local "
+			       "response MAD\n");
+			goto error1;
+		}
+
+		mad_agent_priv = container_of(mad_agent,
+					      struct ib_mad_agent_private,
+					      agent);
+
+		if (mad_agent->device->process_mad) {
+			ret = mad_agent->device->process_mad(
+					    mad_agent->device,
+					    0,
+					    mad_agent->port_num,
+					    smp->dr_slid, /* ? */
+					    (struct ib_mad *)smp,
+					    (struct ib_mad *)&mad_priv->mad);
+			if (ret & IB_MAD_RESULT_SUCCESS) {
+				if (ret & IB_MAD_RESULT_CONSUMED) {
+					ret = 1;
+					goto error1;
+				}
+				if (ret & IB_MAD_RESULT_REPLY) {
+					/*
+					 * See if response is solicited and
+					 * there is a recv handler
+					 */
+					if (solicited_mad(&mad_priv->mad.mad) && 
+					    mad_agent_priv->agent.recv_handler) {
+						struct ib_wc wc;
+
+						/*
+						 * Defined behavior is to
+						 * complete response before
+						 * request
+						 */
+						wc.wr_id = send_wr->wr_id;
+						wc.status = IB_WC_SUCCESS;
+						wc.opcode = IB_WC_RECV;
+						wc.vendor_err = 0;
+						wc.byte_len = sizeof(struct ib_mad);
+						wc.src_qp = 0;  /* IB_QPT_SMI ? */
+						wc.wc_flags = 0;
+						wc.pkey_index = 0;
+						wc.slid = IB_LID_PERMISSIVE;
+						wc.sl = 0;
+						wc.dlid_path_bits = 0;
+						mad_priv->header.recv_wc.wc = &wc;
+						mad_priv->header.recv_wc.mad_len =
+							sizeof(struct ib_mad);
+						INIT_LIST_HEAD(&mad_priv->header.recv_buf.list);
+						mad_priv->header.recv_buf.grh = NULL;
+						mad_priv->header.recv_buf.mad =
+							&mad_priv->mad.mad;
+						mad_priv->header.recv_wc.recv_buf =
+							&mad_priv->header.recv_buf;
+						mad_agent_priv->agent.recv_handler(
+							mad_agent,
+							&mad_priv->header.recv_wc);
+					} else
+						kmem_cache_free(ib_mad_cache, mad_priv);
+				} else
+					kmem_cache_free(ib_mad_cache, mad_priv);
+			} else
+				kmem_cache_free(ib_mad_cache, mad_priv);
+		}
+
+		if (mad_agent_priv->agent.send_handler) {
+			/* Now, complete send */
+			mad_send_wc.status = IB_WC_SUCCESS;
+			mad_send_wc.vendor_err = 0;
+			mad_send_wc.wr_id = send_wr->wr_id;
+			mad_agent_priv->agent.send_handler(
+						mad_agent,
+						&mad_send_wc);
+			ret = 1;
+		} else
+			ret = -EINVAL;
+	} else 
+		ret = 0;
+
+error1:
+	return ret;
+}
+
+static int ib_send_mad(struct ib_mad_agent_private *mad_agent_priv,
+		       struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_mad_qp_info *qp_info;
+	struct ib_send_wr *bad_send_wr;
+	unsigned long flags;
+	int ret;
+
+	/* Replace user's WR ID with our own to find WR upon completion */
+	qp_info = mad_agent_priv->qp_info;
+	mad_send_wr->wr_id = mad_send_wr->send_wr.wr_id;
+	mad_send_wr->send_wr.wr_id = (unsigned long)&mad_send_wr->mad_list;
+	mad_send_wr->mad_list.mad_queue = &qp_info->send_queue;
+
+	spin_lock_irqsave(&qp_info->send_queue.lock, flags);
+	if (qp_info->send_queue.count++ < qp_info->send_queue.max_active) {
+		list_add_tail(&mad_send_wr->mad_list.list,
+			      &qp_info->send_queue.list);
+		spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
+		ret = ib_post_send(mad_agent_priv->agent.qp, 
+				   &mad_send_wr->send_wr, &bad_send_wr);
+		if (ret) {
+			printk(KERN_ERR PFX "ib_post_send failed: %d\n", ret);
+			dequeue_mad(&mad_send_wr->mad_list);
+		}
+	} else {
+		list_add_tail(&mad_send_wr->mad_list.list,
+			      &qp_info->overflow_list);
+		spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
+		ret = 0;
+	}
+	return ret;
+}
+
+/*
+ * ib_post_send_mad - Posts MAD(s) to the send queue of the QP associated
+ *  with the registered client
+ */
+int ib_post_send_mad(struct ib_mad_agent *mad_agent,
+		     struct ib_send_wr *send_wr,
+		     struct ib_send_wr **bad_send_wr)
+{
+	int ret = -EINVAL;
+	struct ib_mad_agent_private *mad_agent_priv;
+
+	/* Validate supplied parameters */
+	if (!bad_send_wr)
+		goto error1;
+
+	if (!mad_agent || !send_wr)
+		goto error2;
+
+	if (!mad_agent->send_handler)
+		goto error2;
+
+	mad_agent_priv = container_of(mad_agent,
+				      struct ib_mad_agent_private,
+				      agent);
+
+	/* Walk list of send WRs and post each on send list */
+	while (send_wr) {
+		unsigned long			flags;
+		struct ib_send_wr		*next_send_wr;
+		struct ib_mad_send_wr_private	*mad_send_wr;
+		struct ib_smp			*smp;
+
+		/* Validate more parameters */
+		if (send_wr->num_sge > IB_MAD_SEND_REQ_MAX_SG)
+			goto error2;
+
+		if (send_wr->wr.ud.timeout_ms && !mad_agent->recv_handler)
+			goto error2;
+
+		if (!send_wr->wr.ud.mad_hdr) {
+			printk(KERN_ERR PFX "MAD header must be supplied "
+			       "in WR %p\n", send_wr);
+			goto error2;
+		}
+
+		/*
+		 * Save pointer to next work request to post in case the
+		 * current one completes, and the user modifies the work
+		 * request associated with the completion
+		 */
+		next_send_wr = (struct ib_send_wr *)send_wr->next;
+
+		smp = (struct ib_smp *)send_wr->wr.ud.mad_hdr;
+		if (smp->mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
+			ret = handle_outgoing_smp(mad_agent, smp, send_wr);
+			if (ret < 0)		/* error */
+				goto error2;
+			else if (ret == 1)	/* locally consumed */
+				goto next;
+		}
+
+		/* Allocate MAD send WR tracking structure */
+		mad_send_wr = kmalloc(sizeof *mad_send_wr, 
+				      (in_atomic() || irqs_disabled()) ?
+				      GFP_ATOMIC : GFP_KERNEL);
+		if (!mad_send_wr) {
+			printk(KERN_ERR PFX "No memory for "
+			       "ib_mad_send_wr_private\n");
+			ret = -ENOMEM;
+			goto error2;
+		}
+
+		mad_send_wr->send_wr = *send_wr;
+		mad_send_wr->send_wr.sg_list = mad_send_wr->sg_list;
+		memcpy(mad_send_wr->sg_list, send_wr->sg_list,
+		       sizeof *send_wr->sg_list * send_wr->num_sge);
+		mad_send_wr->send_wr.next = NULL;
+		mad_send_wr->tid = send_wr->wr.ud.mad_hdr->tid;
+		mad_send_wr->agent = mad_agent;
+		/* Timeout will be updated after send completes */
+		mad_send_wr->timeout = msecs_to_jiffies(send_wr->wr.
+							ud.timeout_ms);
+		mad_send_wr->retry = 0;
+		/* One reference for each work request to QP + response */
+		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
+		mad_send_wr->status = IB_WC_SUCCESS;
+
+		/* Reference MAD agent until send completes */
+		atomic_inc(&mad_agent_priv->refcount);
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_agent_priv->send_list);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		ret = ib_send_mad(mad_agent_priv, mad_send_wr);
+		if (ret) {
+			/* Fail send request */
+			spin_lock_irqsave(&mad_agent_priv->lock, flags);
+			list_del(&mad_send_wr->agent_list);
+			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+			atomic_dec(&mad_agent_priv->refcount);
+			goto error2;
+		}
+next:
+		send_wr = next_send_wr;
+	}
+	return 0;	
+
+error2:
+	*bad_send_wr = send_wr;
+error1:
+	return ret;
+}
+EXPORT_SYMBOL(ib_post_send_mad);
+
+/*
+ * ib_free_recv_mad - Returns data buffers used to receive
+ *  a MAD to the access layer
+ */
+void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct ib_mad_recv_buf *entry;
+	struct ib_mad_private_header *mad_priv_hdr;
+	struct ib_mad_private *priv;
+
+	mad_priv_hdr = container_of(mad_recv_wc,
+				    struct ib_mad_private_header,
+				    recv_wc);
+	priv = container_of(mad_priv_hdr, struct ib_mad_private, header);
+
+	/*
+	 * Walk receive buffer list associated with this WC
+	 * No need to remove them from list of receive buffers
+	 */
+	list_for_each_entry(entry, &mad_recv_wc->recv_buf->list, list) {
+		/* Free previous receive buffer */
+		kmem_cache_free(ib_mad_cache, priv);
+		mad_priv_hdr = container_of(entry, struct ib_mad_private_header,
+					    recv_buf);
+		priv = container_of(mad_priv_hdr, struct ib_mad_private,
+				    header);
+	}
+
+	/* Free last buffer */
+	kmem_cache_free(ib_mad_cache, priv);
+}
+EXPORT_SYMBOL(ib_free_recv_mad);
+
+void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc,
+			  void *buf)
+{
+	printk(KERN_ERR PFX "ib_coalesce_recv_mad() not implemented yet\n");
+}
+EXPORT_SYMBOL(ib_coalesce_recv_mad);
+
+struct ib_mad_agent *ib_redirect_mad_qp(struct ib_qp *qp,
+					u8 rmpp_version,
+					ib_mad_send_handler send_handler,
+					ib_mad_recv_handler recv_handler,
+					void *context)
+{
+	return ERR_PTR(-EINVAL);	/* XXX: for now */
+}
+EXPORT_SYMBOL(ib_redirect_mad_qp);
+
+int ib_process_mad_wc(struct ib_mad_agent *mad_agent,
+		      struct ib_wc *wc)
+{
+	printk(KERN_ERR PFX "ib_process_mad_wc() not implemented yet\n");
+	return 0;
+}
+EXPORT_SYMBOL(ib_process_mad_wc);
+
+static int method_in_use(struct ib_mad_mgmt_method_table **method,
+			 struct ib_mad_reg_req *mad_reg_req)
+{
+	int i;
+
+	for (i = find_first_bit(mad_reg_req->method_mask, IB_MGMT_MAX_METHODS);
+	     i < IB_MGMT_MAX_METHODS;
+	     i = find_next_bit(mad_reg_req->method_mask, IB_MGMT_MAX_METHODS,
+			       1+i)) {
+		if ((*method)->agent[i]) {
+			printk(KERN_ERR PFX "Method %d already in use\n", i);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int allocate_method_table(struct ib_mad_mgmt_method_table **method)
+{
+	/* Allocate management method table */
+	*method = kmalloc(sizeof **method, GFP_ATOMIC);
+	if (!*method) {
+		printk(KERN_ERR PFX "No memory for "
+		       "ib_mad_mgmt_method_table\n");
+		return -ENOMEM;
+	}
+	/* Clear management method table */
+	memset(*method, 0, sizeof **method);
+
+	return 0;
+}
+
+/*
+ * Check to see if there are any methods still in use
+ */
+static int check_method_table(struct ib_mad_mgmt_method_table *method)
+{
+	int i;
+
+	for (i = 0; i < IB_MGMT_MAX_METHODS; i++)
+		if (method->agent[i])
+			return 1;
+	return 0;
+}
+
+/*
+ * Check to see if there are any method tables for this class still in use
+ */
+static int check_class_table(struct ib_mad_mgmt_class_table *class)
+{
+	int i;
+
+	for (i = 0; i < MAX_MGMT_CLASS; i++)
+		if (class->method_table[i])
+			return 1;
+	return 0;
+}
+
+static void remove_methods_mad_agent(struct ib_mad_mgmt_method_table *method,
+				     struct ib_mad_agent_private *agent)
+{
+	int i;
+
+	/* Remove any methods for this mad agent */
+	for (i = 0; i < IB_MGMT_MAX_METHODS; i++) {
+		if (method->agent[i] == agent) {
+			method->agent[i] = NULL;
+		}
+	}
+}
+
+static int add_mad_reg_req(struct ib_mad_reg_req *mad_reg_req,
+			   struct ib_mad_agent_private *priv)
+{
+	struct ib_mad_port_private *private;
+	struct ib_mad_mgmt_class_table **class;
+	struct ib_mad_mgmt_method_table **method;
+
+	int i, ret;
+	u8 mgmt_class;
+
+	/* Make sure MAD registration request supplied */
+	if (!mad_reg_req)
+		return 0;
+
+	private = priv->qp_info->port_priv;
+	mgmt_class = convert_mgmt_class(mad_reg_req->mgmt_class);
+	class = &private->version[mad_reg_req->mgmt_class_version];
+	if (!*class) {
+		/* Allocate management class table for "new" class version */
+		*class = kmalloc(sizeof **class, GFP_ATOMIC);
+		if (!*class) {
+			printk(KERN_ERR PFX "No memory for "
+			       "ib_mad_mgmt_class_table\n");
+			ret = -ENOMEM;
+			goto error1;
+		}
+		/* Clear management class table for this class version */
+		memset((*class)->method_table, 0,
+		       sizeof((*class)->method_table));
+		/* Allocate method table for this management class */
+		method = &(*class)->method_table[mgmt_class];
+		if ((ret = allocate_method_table(method)))
+			goto error2;
+	} else {
+		method = &(*class)->method_table[mgmt_class];
+		if (!*method) {
+			/* Allocate method table for this management class */
+			if ((ret = allocate_method_table(method)))
+				goto error1;
+		}
+	}
+
+	/* Now, make sure methods are not already in use */
+	if (method_in_use(method, mad_reg_req))
+		goto error3;
+
+	/* Finally, add in methods being registered */
+	for (i = find_first_bit(mad_reg_req->method_mask,
+				IB_MGMT_MAX_METHODS); 
+	     i < IB_MGMT_MAX_METHODS;
+	     i = find_next_bit(mad_reg_req->method_mask, IB_MGMT_MAX_METHODS,
+			       1+i)) {
+		(*method)->agent[i] = priv;
+	}
+	return 0;
+
+error3:
+	/* Remove any methods for this mad agent */
+	remove_methods_mad_agent(*method, priv);
+	/* Now, check to see if there are any methods in use */
+	if (!check_method_table(*method)) {
+		/* If not, release management method table */
+		kfree(*method);
+		*method = NULL;
+	}
+	ret = -EINVAL;
+	goto error1;
+error2:
+	kfree(*class);
+	*class = NULL;
+error1:
+	return ret;
+}
+
+static void remove_mad_reg_req(struct ib_mad_agent_private *agent_priv)
+{
+	struct ib_mad_port_private *port_priv;
+	struct ib_mad_mgmt_class_table *class;
+	struct ib_mad_mgmt_method_table *method;
+	u8 mgmt_class;
+
+	/*
+	 * Was MAD registration request supplied
+	 * with original registration ?
+	 */
+	if (!agent_priv->reg_req) {
+		goto out;
+	}
+
+	port_priv = agent_priv->qp_info->port_priv;
+	class = port_priv->version[agent_priv->reg_req->mgmt_class_version];
+	if (!class) {
+		printk(KERN_ERR PFX "No class table yet MAD registration "
+		       "request supplied\n");
+		goto out;
+	}
+
+	mgmt_class = convert_mgmt_class(agent_priv->reg_req->mgmt_class);
+	method = class->method_table[mgmt_class];
+	if (method) {
+		/* Remove any methods for this mad agent */
+		remove_methods_mad_agent(method, agent_priv);
+		/* Now, check to see if there are any methods still in use */
+		if (!check_method_table(method)) {
+			/* If not, release management method table */
+			 kfree(method);
+			 class->method_table[mgmt_class] = NULL;
+			 /* Any management classes left ? */
+			if (!check_class_table(class)) {
+				/* If not, release management class table */
+				kfree(class);
+				port_priv->version[agent_priv->reg_req->
+						   mgmt_class_version]= NULL;
+			}
+		}
+	}
+
+out:
+	return;
+}
+
+static int response_mad(struct ib_mad *mad)
+{
+	/* Trap represses are responses although response bit is reset */
+	return ((mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS) || 
+		(mad->mad_hdr.method & IB_MGMT_METHOD_RESP));
+}
+
+static int solicited_mad(struct ib_mad *mad)
+{
+	/* CM MADs are never solicited */
+	if (mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_CM) {
+		return 0;
+	}
+
+	/* XXX: Determine whether MAD is using RMPP */
+
+	/* Not using RMPP */
+	/* Is this MAD a response to a previous MAD ? */
+	return response_mad(mad);
+}
+
+static struct ib_mad_agent_private *
+find_mad_agent(struct ib_mad_port_private *port_priv,
+	       struct ib_mad *mad,
+	       int solicited)
+{
+	struct ib_mad_agent_private *mad_agent = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port_priv->reg_lock, flags);
+
+	/*
+	 * Whether MAD was solicited determines type of routing to
+	 * MAD client.
+	 */
+	if (solicited) {
+		u32 hi_tid;
+		struct ib_mad_agent_private *entry;
+
+		/*
+		 * Routing is based on high 32 bits of transaction ID
+		 * of MAD.
+		 */
+		hi_tid = be64_to_cpu(mad->mad_hdr.tid) >> 32;
+		list_for_each_entry(entry, &port_priv->agent_list,
+				    agent_list) {
+			if (entry->agent.hi_tid == hi_tid) {
+				mad_agent = entry;
+				break;
+			}
+		}
+	} else {
+		struct ib_mad_mgmt_class_table *version;
+		struct ib_mad_mgmt_method_table *class;
+
+		/* Routing is based on version, class, and method */
+		if (mad->mad_hdr.class_version >= MAX_MGMT_VERSION)
+			goto out;
+		version = port_priv->version[mad->mad_hdr.class_version];
+		if (!version)
+			goto out;
+		class = version->method_table[convert_mgmt_class(
+						mad->mad_hdr.mgmt_class)];
+		if (class)
+			mad_agent = class->agent[mad->mad_hdr.method &
+						 ~IB_MGMT_METHOD_RESP];
+	}
+
+	if (mad_agent) {
+		if (mad_agent->agent.recv_handler)
+			atomic_inc(&mad_agent->refcount);
+		else {
+			printk(KERN_NOTICE PFX "No receive handler for client "
+			       "%p on port %d\n",
+			       &mad_agent->agent, port_priv->port_num);
+			mad_agent = NULL;
+		}
+	}
+out:
+	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
+
+	return mad_agent;
+}
+
+static int validate_mad(struct ib_mad *mad, u32 qp_num)
+{
+	int valid = 0;
+
+	/* Make sure MAD base version is understood */
+	if (mad->mad_hdr.base_version != IB_MGMT_BASE_VERSION) {
+		printk(KERN_ERR PFX "MAD received with unsupported base "
+		       "version %d\n", mad->mad_hdr.base_version);
+		goto out;
+	}
+
+	/* Filter SMI packets sent to other than QP0 */
+	if ((mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED) ||
+	    (mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)) {
+		if (qp_num == 0)
+			valid = 1;
+	} else {
+		/* Filter GSI packets sent to QP0 */
+		if (qp_num != 0)
+			valid = 1;	
+	}
+
+out:
+	return valid;
+}
+
+/*
+ * Return start of fully reassembled MAD, or NULL, if MAD isn't assembled yet
+ */
+static struct ib_mad_private *
+reassemble_recv(struct ib_mad_agent_private *mad_agent_priv,
+		struct ib_mad_private *recv)
+{
+	/* Until we have RMPP, all receives are reassembled!... */
+	INIT_LIST_HEAD(&recv->header.recv_buf.list);
+	return recv;
+}
+
+static struct ib_mad_send_wr_private*
+find_send_req(struct ib_mad_agent_private *mad_agent_priv,
+	      u64 tid)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+
+	list_for_each_entry(mad_send_wr, &mad_agent_priv->wait_list,
+			    agent_list) {
+		if (mad_send_wr->tid == tid)
+			return mad_send_wr;
+	}
+
+	/*
+	 * It's possible to receive the response before we've
+	 * been notified that the send has completed
+	 */
+	list_for_each_entry(mad_send_wr, &mad_agent_priv->send_list,
+			    agent_list) {
+		if (mad_send_wr->tid == tid && mad_send_wr->timeout) {
+			/* Verify request has not been canceled */
+			return (mad_send_wr->status == IB_WC_SUCCESS) ?
+				mad_send_wr : NULL;
+		}
+	}
+	return NULL;
+}
+
+static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
+				 struct ib_mad_private *recv,
+				 int solicited)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc;
+	unsigned long flags;
+
+	/* Fully reassemble receive before processing */
+	recv = reassemble_recv(mad_agent_priv, recv);
+	if (!recv) {
+		if (atomic_dec_and_test(&mad_agent_priv->refcount))
+			wake_up(&mad_agent_priv->wait);
+		return;
+	}
+
+	/* Complete corresponding request */
+	if (solicited) {
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		mad_send_wr = find_send_req(mad_agent_priv,
+					    recv->mad.mad.mad_hdr.tid);
+		if (!mad_send_wr) {
+			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+			ib_free_recv_mad(&recv->header.recv_wc);
+			if (atomic_dec_and_test(&mad_agent_priv->refcount))
+				wake_up(&mad_agent_priv->wait);
+			return;
+		}
+		/* Timeout = 0 means that we won't wait for a response */
+		mad_send_wr->timeout = 0;
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		/* Defined behavior is to complete response before request */
+		recv->header.recv_wc.wc->wr_id = mad_send_wr->wr_id;
+		mad_agent_priv->agent.recv_handler(
+						&mad_agent_priv->agent,
+						&recv->header.recv_wc);
+		atomic_dec(&mad_agent_priv->refcount);
+
+		mad_send_wc.status = IB_WC_SUCCESS;
+		mad_send_wc.vendor_err = 0;
+		mad_send_wc.wr_id = mad_send_wr->wr_id;
+		ib_mad_complete_send_wr(mad_send_wr, &mad_send_wc);
+	} else {
+		mad_agent_priv->agent.recv_handler(
+						&mad_agent_priv->agent,
+						&recv->header.recv_wc);
+		if (atomic_dec_and_test(&mad_agent_priv->refcount))
+			wake_up(&mad_agent_priv->wait);
+	}
+}
+
+static void ib_mad_recv_done_handler(struct ib_mad_port_private *port_priv,
+				     struct ib_wc *wc)
+{
+	struct ib_mad_qp_info *qp_info;
+	struct ib_mad_private_header *mad_priv_hdr;
+	struct ib_mad_private *recv, *response;
+	struct ib_mad_list_head *mad_list;
+	struct ib_mad_agent_private *mad_agent;
+	struct ib_smp *smp;
+	int solicited;
+
+	response = kmem_cache_alloc(ib_mad_cache, GFP_KERNEL);
+	if (!response)
+		printk(KERN_ERR PFX "ib_mad_recv_done_handler no memory "
+		       "for response buffer\n");
+
+	mad_list = (struct ib_mad_list_head *)(unsigned long)wc->wr_id;
+	qp_info = mad_list->mad_queue->qp_info;
+	dequeue_mad(mad_list);
+
+	mad_priv_hdr = container_of(mad_list, struct ib_mad_private_header,
+				    mad_list);
+	recv = container_of(mad_priv_hdr, struct ib_mad_private, header);
+	dma_unmap_single(port_priv->device->dma_device,
+			 pci_unmap_addr(&recv->header, mapping),
+			 sizeof(struct ib_mad_private) -
+			 sizeof(struct ib_mad_private_header),
+			 DMA_FROM_DEVICE);
+
+	/* Setup MAD receive work completion from "normal" work completion */
+	recv->header.recv_wc.wc = wc;
+	recv->header.recv_wc.mad_len = sizeof(struct ib_mad);
+	recv->header.recv_wc.recv_buf = &recv->header.recv_buf;
+	recv->header.recv_buf.mad = (struct ib_mad *)&recv->mad;
+	recv->header.recv_buf.grh = &recv->grh;
+
+	/* Validate MAD */
+	if (!validate_mad(recv->header.recv_buf.mad, qp_info->qp->qp_num))
+		goto out;
+
+	if (recv->header.recv_buf.mad->mad_hdr.mgmt_class ==
+	    IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
+		smp = (struct ib_smp *)recv->header.recv_buf.mad;
+		if (!smi_handle_dr_smp_recv(smp,
+					    port_priv->device->node_type,
+					    port_priv->port_num,
+					    port_priv->device->phys_port_cnt))
+			goto out;
+		if (!smi_check_forward_dr_smp(smp))
+			goto local;
+		if (!smi_handle_dr_smp_send(smp,
+					    port_priv->device->node_type,
+					    port_priv->port_num))
+			goto out;
+		if (!smi_check_local_dr_smp(smp,
+					    port_priv->device,
+					    port_priv->port_num))
+			goto out;
+	}
+
+local:
+	/* Give driver "right of first refusal" on incoming MAD */
+	if (port_priv->device->process_mad) {
+		int ret;
+
+		if (!response) {
+			printk(KERN_ERR PFX "No memory for response MAD\n");
+			/*
+			 * Is it better to assume that
+			 * it wouldn't be processed ?
+			 */
+			goto out;
+		}
+
+		ret = port_priv->device->process_mad(port_priv->device, 0,
+						     port_priv->port_num,
+						     wc->slid,
+						     recv->header.recv_buf.mad,
+						     &response->mad.mad);
+		if (ret & IB_MAD_RESULT_SUCCESS) {
+			if (ret & IB_MAD_RESULT_CONSUMED)
+				goto out;
+			if (ret & IB_MAD_RESULT_REPLY) {
+				/* Send response */
+				if (!agent_send(response, &recv->grh, wc,
+						port_priv->device,
+						port_priv->port_num))
+					response = NULL;
+				goto out;
+			}
+		} 
+	}
+
+	/* Determine corresponding MAD agent for incoming receive MAD */
+	solicited = solicited_mad(recv->header.recv_buf.mad);
+	mad_agent = find_mad_agent(port_priv, recv->header.recv_buf.mad,
+				   solicited);
+	if (mad_agent) {
+		ib_mad_complete_recv(mad_agent, recv, solicited);
+		/*
+		 * recv is freed up in error cases in ib_mad_complete_recv
+		 * or via recv_handler in ib_mad_complete_recv()
+		 */
+		recv = NULL;
+	}
+
+out:
+	/* Post another receive request for this QP */
+	if (response) {
+		ib_mad_post_receive_mads(qp_info, response);
+		if (recv)
+			kmem_cache_free(ib_mad_cache, recv);
+	} else
+		ib_mad_post_receive_mads(qp_info, recv);
+}
+
+static void adjust_timeout(struct ib_mad_agent_private *mad_agent_priv)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	unsigned long delay;
+
+	if (list_empty(&mad_agent_priv->wait_list)) {
+		cancel_delayed_work(&mad_agent_priv->work);
+	} else {
+		mad_send_wr = list_entry(mad_agent_priv->wait_list.next,
+					 struct ib_mad_send_wr_private,
+					 agent_list);
+
+		if (time_after(mad_agent_priv->timeout,
+			       mad_send_wr->timeout)) {
+			mad_agent_priv->timeout = mad_send_wr->timeout;
+			cancel_delayed_work(&mad_agent_priv->work);
+			delay = mad_send_wr->timeout - jiffies;
+			if ((long)delay <= 0)
+				delay = 1;
+			queue_delayed_work(mad_agent_priv->qp_info->
+					   port_priv->wq,
+					   &mad_agent_priv->work, delay);
+		}
+	}
+}
+
+static void wait_for_response(struct ib_mad_agent_private *mad_agent_priv,
+			      struct ib_mad_send_wr_private *mad_send_wr )
+{
+	struct ib_mad_send_wr_private *temp_mad_send_wr;
+	struct list_head *list_item;
+	unsigned long delay;
+
+	list_del(&mad_send_wr->agent_list);
+
+	delay = mad_send_wr->timeout;
+	mad_send_wr->timeout += jiffies;
+
+	list_for_each_prev(list_item, &mad_agent_priv->wait_list) {
+		temp_mad_send_wr = list_entry(list_item,
+					      struct ib_mad_send_wr_private,
+					      agent_list);
+		if (time_after(mad_send_wr->timeout,
+			       temp_mad_send_wr->timeout))
+			break;
+	}
+	list_add(&mad_send_wr->agent_list, list_item);
+
+	/* Reschedule a work item if we have a shorter timeout */
+	if (mad_agent_priv->wait_list.next == &mad_send_wr->agent_list) {
+		cancel_delayed_work(&mad_agent_priv->work);
+		queue_delayed_work(mad_agent_priv->qp_info->port_priv->wq,
+				   &mad_agent_priv->work, delay);
+	}
+}
+
+/*
+ * Process a send work completion
+ */
+static void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
+				    struct ib_mad_send_wc *mad_send_wc)
+{
+	struct ib_mad_agent_private	*mad_agent_priv;
+	unsigned long			flags;
+
+	mad_agent_priv = container_of(mad_send_wr->agent,
+				      struct ib_mad_agent_private, agent);
+
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	if (mad_send_wc->status != IB_WC_SUCCESS &&
+	    mad_send_wr->status == IB_WC_SUCCESS) {
+		mad_send_wr->status = mad_send_wc->status;
+		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
+	}
+
+	if (--mad_send_wr->refcount > 0) {
+		if (mad_send_wr->refcount == 1 && mad_send_wr->timeout &&
+		    mad_send_wr->status == IB_WC_SUCCESS) {
+			wait_for_response(mad_agent_priv, mad_send_wr);
+		}
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		return;
+	}
+
+	/* Remove send from MAD agent and notify client of completion */
+	list_del(&mad_send_wr->agent_list);
+	adjust_timeout(mad_agent_priv);
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+	
+	if (mad_send_wr->status != IB_WC_SUCCESS )
+		mad_send_wc->status = mad_send_wr->status;
+	mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+					    mad_send_wc);
+
+	/* Release reference on agent taken when sending */
+	if (atomic_dec_and_test(&mad_agent_priv->refcount))
+		wake_up(&mad_agent_priv->wait);
+
+	kfree(mad_send_wr);
+}
+
+static void ib_mad_send_done_handler(struct ib_mad_port_private *port_priv,
+				     struct ib_wc *wc)
+{
+	struct ib_mad_send_wr_private	*mad_send_wr, *queued_send_wr;
+	struct ib_mad_list_head		*mad_list;
+	struct ib_mad_qp_info		*qp_info;
+	struct ib_mad_queue		*send_queue;
+	struct ib_send_wr		*bad_send_wr;
+	unsigned long flags;
+	int ret;
+
+	mad_list = (struct ib_mad_list_head *)(unsigned long)wc->wr_id;
+	mad_send_wr = container_of(mad_list, struct ib_mad_send_wr_private,
+				   mad_list);
+	send_queue = mad_list->mad_queue;
+	qp_info = send_queue->qp_info;
+
+retry:
+	queued_send_wr = NULL;
+	spin_lock_irqsave(&send_queue->lock, flags);
+	list_del(&mad_list->list);
+
+	/* Move queued send to the send queue */
+	if (send_queue->count-- > send_queue->max_active) {
+		mad_list = container_of(qp_info->overflow_list.next,
+					struct ib_mad_list_head, list);
+		queued_send_wr = container_of(mad_list,
+					struct ib_mad_send_wr_private,
+					mad_list);
+		list_del(&mad_list->list);
+		list_add_tail(&mad_list->list, &send_queue->list);
+	}
+	spin_unlock_irqrestore(&send_queue->lock, flags);
+
+	/* Restore client wr_id in WC and complete send */
+	wc->wr_id = mad_send_wr->wr_id;
+	ib_mad_complete_send_wr(mad_send_wr, (struct ib_mad_send_wc*)wc);
+
+	if (queued_send_wr) {
+		ret = ib_post_send(qp_info->qp, &queued_send_wr->send_wr,
+				&bad_send_wr);
+		if (ret) {
+			printk(KERN_ERR PFX "ib_post_send failed: %d\n", ret);
+			mad_send_wr = queued_send_wr;
+			wc->status = IB_WC_LOC_QP_OP_ERR;
+			goto retry;
+		}
+	}
+}
+
+static void mark_sends_for_retry(struct ib_mad_qp_info *qp_info)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_list_head *mad_list;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qp_info->send_queue.lock, flags);
+	list_for_each_entry(mad_list, &qp_info->send_queue.list, list) {
+		mad_send_wr = container_of(mad_list,
+					   struct ib_mad_send_wr_private,
+					   mad_list);
+		mad_send_wr->retry = 1;
+	}
+	spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
+}
+
+static void mad_error_handler(struct ib_mad_port_private *port_priv,
+			      struct ib_wc *wc)
+{
+	struct ib_mad_list_head *mad_list;
+	struct ib_mad_qp_info *qp_info;
+	struct ib_mad_send_wr_private *mad_send_wr;
+	int ret;
+
+	/* Determine if failure was a send or receive */
+	mad_list = (struct ib_mad_list_head *)(unsigned long)wc->wr_id;
+	qp_info = mad_list->mad_queue->qp_info;
+	if (mad_list->mad_queue == &qp_info->recv_queue)
+		/*
+		 * Receive errors indicate that the QP has entered the error 
+		 * state - error handling/shutdown code will cleanup
+		 */
+		return;
+
+	/*
+	 * Send errors will transition the QP to SQE - move
+	 * QP to RTS and repost flushed work requests
+	 */
+	mad_send_wr = container_of(mad_list, struct ib_mad_send_wr_private,
+				   mad_list);
+	if (wc->status == IB_WC_WR_FLUSH_ERR) {
+		if (mad_send_wr->retry) {
+			/* Repost send */
+			struct ib_send_wr *bad_send_wr;
+
+			mad_send_wr->retry = 0;
+			ret = ib_post_send(qp_info->qp, &mad_send_wr->send_wr,
+					&bad_send_wr);
+			if (ret)
+				ib_mad_send_done_handler(port_priv, wc);
+		} else
+			ib_mad_send_done_handler(port_priv, wc);
+	} else {
+		struct ib_qp_attr *attr;
+
+		/* Transition QP to RTS and fail offending send */
+		attr = kmalloc(sizeof *attr, GFP_KERNEL);
+		if (attr) {
+			attr->qp_state = IB_QPS_RTS;
+			attr->cur_qp_state = IB_QPS_SQE;
+			ret = ib_modify_qp(qp_info->qp, attr,
+					   IB_QP_STATE | IB_QP_CUR_STATE);
+			kfree(attr);
+			if (ret)
+				printk(KERN_ERR PFX "mad_error_handler - "
+				       "ib_modify_qp to RTS : %d\n", ret);
+			else
+				mark_sends_for_retry(qp_info);
+		}
+		ib_mad_send_done_handler(port_priv, wc);
+	}
+}
+
+/*
+ * IB MAD completion callback
+ */
+static void ib_mad_completion_handler(void *data)
+{
+	struct ib_mad_port_private *port_priv;
+	struct ib_wc wc;
+
+	port_priv = (struct ib_mad_port_private *)data;
+	ib_req_notify_cq(port_priv->cq, IB_CQ_NEXT_COMP);
+	
+	while (ib_poll_cq(port_priv->cq, 1, &wc) == 1) {
+		if (wc.status == IB_WC_SUCCESS) {
+			switch (wc.opcode) {
+			case IB_WC_SEND:
+				ib_mad_send_done_handler(port_priv, &wc);
+				break;
+			case IB_WC_RECV:
+				ib_mad_recv_done_handler(port_priv, &wc);
+				break;
+			default:
+				BUG_ON(1);
+				break;
+			}
+		} else
+			mad_error_handler(port_priv, &wc);
+	}
+}
+
+static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
+{
+	unsigned long flags;
+	struct ib_mad_send_wr_private *mad_send_wr, *temp_mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc;
+	struct list_head cancel_list;
+
+	INIT_LIST_HEAD(&cancel_list);
+
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
+				 &mad_agent_priv->send_list, agent_list) {
+		if (mad_send_wr->status == IB_WC_SUCCESS) {
+ 			mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
+			mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
+		}
+	}
+
+	/* Empty wait list to prevent receives from finding a request */
+	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+	/* Report all cancelled requests */
+	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
+	mad_send_wc.vendor_err = 0;
+
+	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
+				 &cancel_list, agent_list) {
+		mad_send_wc.wr_id = mad_send_wr->wr_id;
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   &mad_send_wc);
+
+		list_del(&mad_send_wr->agent_list);
+		kfree(mad_send_wr);
+		atomic_dec(&mad_agent_priv->refcount);
+	}
+}
+
+static struct ib_mad_send_wr_private*
+find_send_by_wr_id(struct ib_mad_agent_private *mad_agent_priv,
+		   u64 wr_id)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+
+	list_for_each_entry(mad_send_wr, &mad_agent_priv->wait_list,
+			    agent_list) {
+		if (mad_send_wr->wr_id == wr_id)
+			return mad_send_wr;
+	}
+
+	list_for_each_entry(mad_send_wr, &mad_agent_priv->send_list,
+			    agent_list) {
+		if (mad_send_wr->wr_id == wr_id)
+			return mad_send_wr;
+	}
+	return NULL;
+}
+
+void ib_cancel_mad(struct ib_mad_agent *mad_agent,
+		  u64 wr_id)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc;
+	unsigned long flags;
+
+	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
+				      agent);
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	mad_send_wr = find_send_by_wr_id(mad_agent_priv, wr_id);
+	if (!mad_send_wr) {
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		goto out;
+	}
+
+	if (mad_send_wr->status == IB_WC_SUCCESS)
+		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
+
+	if (mad_send_wr->refcount != 0) {
+		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		goto out;
+	}
+
+	list_del(&mad_send_wr->agent_list);
+	adjust_timeout(mad_agent_priv);
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
+	mad_send_wc.vendor_err = 0;
+	mad_send_wc.wr_id = mad_send_wr->wr_id;
+	mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+					   &mad_send_wc);
+
+	kfree(mad_send_wr);
+	if (atomic_dec_and_test(&mad_agent_priv->refcount))
+		wake_up(&mad_agent_priv->wait);
+
+out:
+	return;
+}
+EXPORT_SYMBOL(ib_cancel_mad);
+
+static void timeout_sends(void *data)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc;
+	unsigned long flags, delay;
+
+	mad_agent_priv = (struct ib_mad_agent_private *)data;
+
+	mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
+	mad_send_wc.vendor_err = 0;
+
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	while (!list_empty(&mad_agent_priv->wait_list)) {
+		mad_send_wr = list_entry(mad_agent_priv->wait_list.next,
+					 struct ib_mad_send_wr_private,
+					 agent_list);
+
+		if (time_after(mad_send_wr->timeout, jiffies)) {
+			delay = mad_send_wr->timeout - jiffies;
+			if ((long)delay <= 0)
+				delay = 1;
+			queue_delayed_work(mad_agent_priv->qp_info->
+					   port_priv->wq,
+					   &mad_agent_priv->work, delay);
+			break;
+		}
+
+		list_del(&mad_send_wr->agent_list);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		mad_send_wc.wr_id = mad_send_wr->wr_id;
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   &mad_send_wc);
+
+		kfree(mad_send_wr);
+		atomic_dec(&mad_agent_priv->refcount);
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	}
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+}
+
+static void ib_mad_thread_completion_handler(struct ib_cq *cq)
+{
+	struct ib_mad_port_private *port_priv = cq->cq_context;
+	queue_work(port_priv->wq, &port_priv->work);
+}
+
+/*
+ * Allocate receive MADs and post receive WRs for them
+ */
+static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
+				    struct ib_mad_private *mad)
+{
+	unsigned long flags;
+	int post, ret;
+	struct ib_mad_private *mad_priv;
+	struct ib_sge sg_list;
+	struct ib_recv_wr recv_wr, *bad_recv_wr;
+	struct ib_mad_queue *recv_queue = &qp_info->recv_queue;
+
+	/* Initialize common scatter list fields */
+	sg_list.length = sizeof *mad_priv - sizeof mad_priv->header;
+	sg_list.lkey = (*qp_info->port_priv->mr).lkey;
+
+	/* Initialize common receive WR fields */
+	recv_wr.next = NULL;
+	recv_wr.sg_list = &sg_list;
+	recv_wr.num_sge = 1;
+	recv_wr.recv_flags = IB_RECV_SIGNALED;
+
+	do {
+		/* Allocate and map receive buffer */
+		if (mad) {
+			mad_priv = mad;
+			mad = NULL;
+		} else {
+			mad_priv = kmem_cache_alloc(ib_mad_cache, GFP_KERNEL);
+			if (!mad_priv) {
+				printk(KERN_ERR PFX "No memory for receive buffer\n");
+				ret = -ENOMEM;
+				break;
+			}
+		}
+		sg_list.addr = dma_map_single(qp_info->port_priv->
+						device->dma_device,
+					&mad_priv->grh,
+					sizeof *mad_priv -
+						sizeof mad_priv->header,
+					DMA_FROM_DEVICE);
+		pci_unmap_addr_set(&mad_priv->header, mapping, sg_list.addr);
+		recv_wr.wr_id = (unsigned long)&mad_priv->header.mad_list;
+		mad_priv->header.mad_list.mad_queue = recv_queue;
+
+		/* Post receive WR */
+		spin_lock_irqsave(&recv_queue->lock, flags);
+		post = (++recv_queue->count < recv_queue->max_active);
+		list_add_tail(&mad_priv->header.mad_list.list, &recv_queue->list);
+		spin_unlock_irqrestore(&recv_queue->lock, flags);
+		ret = ib_post_recv(qp_info->qp, &recv_wr, &bad_recv_wr);
+		if (ret) {
+			spin_lock_irqsave(&recv_queue->lock, flags);
+			list_del(&mad_priv->header.mad_list.list);
+			recv_queue->count--;
+			spin_unlock_irqrestore(&recv_queue->lock, flags);
+			dma_unmap_single(qp_info->port_priv->device->dma_device,
+					 pci_unmap_addr(&mad_priv->header,
+							mapping),
+					 sizeof *mad_priv -
+					   sizeof mad_priv->header,
+					 DMA_FROM_DEVICE);
+			kmem_cache_free(ib_mad_cache, mad_priv);
+			printk(KERN_ERR PFX "ib_post_recv failed: %d\n", ret);
+			break;
+		}
+	} while (post);
+
+	return ret;
+}
+
+/*
+ * Return all the posted receive MADs
+ */
+static void cleanup_recv_queue(struct ib_mad_qp_info *qp_info)
+{
+	struct ib_mad_private_header *mad_priv_hdr;
+	struct ib_mad_private *recv;
+	struct ib_mad_list_head *mad_list;
+
+	while (!list_empty(&qp_info->recv_queue.list)) {
+
+		mad_list = list_entry(qp_info->recv_queue.list.next,
+				      struct ib_mad_list_head, list);
+		mad_priv_hdr = container_of(mad_list,
+					    struct ib_mad_private_header,
+					    mad_list);
+		recv = container_of(mad_priv_hdr, struct ib_mad_private,
+				    header);
+
+		/* Remove from posted receive MAD list */
+		list_del(&mad_list->list);
+
+		/* Undo PCI mapping */
+		dma_unmap_single(qp_info->port_priv->device->dma_device,
+				 pci_unmap_addr(&recv->header, mapping),
+				 sizeof(struct ib_mad_private) -
+				 sizeof(struct ib_mad_private_header),
+				 DMA_FROM_DEVICE);
+		kmem_cache_free(ib_mad_cache, recv);
+	}
+
+	qp_info->recv_queue.count = 0;
+}
+
+/*
+ * Start the port
+ */
+static int ib_mad_port_start(struct ib_mad_port_private *port_priv)
+{
+	int ret, i;
+	struct ib_qp_attr *attr;
+	struct ib_qp *qp;
+
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+ 	if (!attr) {
+		printk(KERN_ERR PFX "Couldn't kmalloc ib_qp_attr\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < IB_MAD_QPS_CORE; i++) {
+		qp = port_priv->qp_info[i].qp;
+		/*
+		 * PKey index for QP1 is irrelevant but
+		 * one is needed for the Reset to Init transition
+		 */
+		attr->qp_state = IB_QPS_INIT;
+		attr->pkey_index = 0;
+		attr->qkey = (qp->qp_num == 0) ? 0 : IB_QP1_QKEY;
+		ret = ib_modify_qp(qp, attr, IB_QP_STATE |
+					     IB_QP_PKEY_INDEX | IB_QP_QKEY);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't change QP%d state to "
+			       "INIT: %d\n", i, ret);
+			goto out;
+		}
+
+		attr->qp_state = IB_QPS_RTR;
+		ret = ib_modify_qp(qp, attr, IB_QP_STATE);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't change QP%d state to "
+			       "RTR: %d\n", i, ret);
+			goto out;
+		}
+
+		attr->qp_state = IB_QPS_RTS;
+		attr->sq_psn = IB_MAD_SEND_Q_PSN;
+		ret = ib_modify_qp(qp, attr, IB_QP_STATE | IB_QP_SQ_PSN);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't change QP%d state to "
+			       "RTS: %d\n", i, ret);
+			goto out;
+		}
+	}
+
+	ret = ib_req_notify_cq(port_priv->cq, IB_CQ_NEXT_COMP);
+	if (ret) {
+		printk(KERN_ERR PFX "Failed to request completion "
+		       "notification: %d\n", ret);
+		goto out;
+	}
+
+	for (i = 0; i < IB_MAD_QPS_CORE; i++) {
+		ret = ib_mad_post_receive_mads(&port_priv->qp_info[i], NULL);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't post receive WRs\n");
+			goto out;
+		}
+	}
+out:
+	kfree(attr);
+	return ret;
+}
+
+static void qp_event_handler(struct ib_event *event, void *qp_context)
+{
+	struct ib_mad_qp_info	*qp_info = qp_context;
+
+	/* It's worse than that! He's dead, Jim! */
+	printk(KERN_ERR PFX "Fatal error (%d) on MAD QP (%d)\n",
+		event->event, qp_info->qp->qp_num);
+}
+
+static void init_mad_queue(struct ib_mad_qp_info *qp_info,
+			   struct ib_mad_queue *mad_queue)
+{
+	mad_queue->qp_info = qp_info;
+	mad_queue->count = 0;
+	spin_lock_init(&mad_queue->lock);
+	INIT_LIST_HEAD(&mad_queue->list);
+}
+
+static void init_mad_qp(struct ib_mad_port_private *port_priv,
+			struct ib_mad_qp_info *qp_info)
+{
+	qp_info->port_priv = port_priv;
+	init_mad_queue(qp_info, &qp_info->send_queue);
+	init_mad_queue(qp_info, &qp_info->recv_queue);
+	INIT_LIST_HEAD(&qp_info->overflow_list);
+}
+
+static int create_mad_qp(struct ib_mad_qp_info *qp_info,
+			 enum ib_qp_type qp_type)
+{
+	struct ib_qp_init_attr	qp_init_attr;
+	int ret;
+
+	memset(&qp_init_attr, 0, sizeof qp_init_attr);
+	qp_init_attr.send_cq = qp_info->port_priv->cq;
+	qp_init_attr.recv_cq = qp_info->port_priv->cq;
+	qp_init_attr.sq_sig_type = IB_SIGNAL_ALL_WR;
+	qp_init_attr.rq_sig_type = IB_SIGNAL_ALL_WR;
+	qp_init_attr.cap.max_send_wr = IB_MAD_QP_SEND_SIZE;
+	qp_init_attr.cap.max_recv_wr = IB_MAD_QP_RECV_SIZE;
+	qp_init_attr.cap.max_send_sge = IB_MAD_SEND_REQ_MAX_SG;
+	qp_init_attr.cap.max_recv_sge = IB_MAD_RECV_REQ_MAX_SG;
+	qp_init_attr.qp_type = qp_type;
+	qp_init_attr.port_num = qp_info->port_priv->port_num;
+	qp_init_attr.qp_context = qp_info;
+	qp_init_attr.event_handler = qp_event_handler;
+	qp_info->qp = ib_create_qp(qp_info->port_priv->pd, &qp_init_attr);
+	if (IS_ERR(qp_info->qp)) {
+		printk(KERN_ERR PFX "Couldn't create ib_mad QP%d\n",
+		       get_spl_qp_index(qp_type));
+		ret = PTR_ERR(qp_info->qp);
+		goto error;		
+	}
+	/* Use minimum queue sizes unless the CQ is resized */
+	qp_info->send_queue.max_active = IB_MAD_QP_SEND_SIZE;
+	qp_info->recv_queue.max_active = IB_MAD_QP_RECV_SIZE;
+	return 0;
+
+error:
+	return ret;
+}
+
+static void destroy_mad_qp(struct ib_mad_qp_info *qp_info)
+{
+	ib_destroy_qp(qp_info->qp);
+}
+
+/*
+ * Open the port
+ * Create the QP, PD, MR, and CQ if needed
+ */
+static int ib_mad_port_open(struct ib_device *device,
+			    int port_num)
+{
+	int ret, cq_size;
+	struct ib_mad_port_private *port_priv;
+	unsigned long flags;
+	char name[sizeof "ib_mad123"];
+
+	/* First, check if port already open at MAD layer */
+	port_priv = ib_get_mad_port(device, port_num);
+	if (port_priv) {
+		printk(KERN_DEBUG PFX "%s port %d already open\n",
+		       device->name, port_num);
+		return 0;
+	}
+
+	/* Create new device info */
+	port_priv = kmalloc(sizeof *port_priv, GFP_KERNEL);
+	if (!port_priv) {
+		printk(KERN_ERR PFX "No memory for ib_mad_port_private\n");
+		return -ENOMEM;
+	}
+	memset(port_priv, 0, sizeof *port_priv);
+	port_priv->device = device;
+	port_priv->port_num = port_num;
+	spin_lock_init(&port_priv->reg_lock);
+	INIT_LIST_HEAD(&port_priv->agent_list);
+	init_mad_qp(port_priv, &port_priv->qp_info[0]);
+	init_mad_qp(port_priv, &port_priv->qp_info[1]);
+
+	cq_size = (IB_MAD_QP_SEND_SIZE + IB_MAD_QP_RECV_SIZE) * 2;
+	port_priv->cq = ib_create_cq(port_priv->device,
+				     (ib_comp_handler)
+					ib_mad_thread_completion_handler,
+				     NULL, port_priv, cq_size);
+	if (IS_ERR(port_priv->cq)) {
+		printk(KERN_ERR PFX "Couldn't create ib_mad CQ\n");
+		ret = PTR_ERR(port_priv->cq);
+		goto error3;
+	}
+
+	port_priv->pd = ib_alloc_pd(device);
+	if (IS_ERR(port_priv->pd)) {
+		printk(KERN_ERR PFX "Couldn't create ib_mad PD\n");
+		ret = PTR_ERR(port_priv->pd);
+		goto error4;
+	}
+
+	port_priv->mr = ib_get_dma_mr(port_priv->pd, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(port_priv->mr)) {
+		printk(KERN_ERR PFX "Couldn't get ib_mad DMA MR\n");
+		ret = PTR_ERR(port_priv->mr);
+		goto error5;
+	}
+
+	ret = create_mad_qp(&port_priv->qp_info[0], IB_QPT_SMI);
+	if (ret)
+		goto error6;
+	ret = create_mad_qp(&port_priv->qp_info[1], IB_QPT_GSI);
+	if (ret)
+		goto error7;
+
+	snprintf(name, sizeof name, "ib_mad%d", port_num);
+	port_priv->wq = create_workqueue(name);
+	if (!port_priv->wq) {
+		ret = -ENOMEM;
+		goto error8;
+	}
+	INIT_WORK(&port_priv->work, ib_mad_completion_handler, port_priv);
+
+	ret = ib_mad_port_start(port_priv);
+	if (ret) {
+		printk(KERN_ERR PFX "Couldn't start port\n");
+		goto error9;
+	}
+
+	spin_lock_irqsave(&ib_mad_port_list_lock, flags);
+	list_add_tail(&port_priv->port_list, &ib_mad_port_list);
+	spin_unlock_irqrestore(&ib_mad_port_list_lock, flags);
+	return 0;
+
+error9:
+	destroy_workqueue(port_priv->wq);
+error8:
+	destroy_mad_qp(&port_priv->qp_info[1]);
+error7:
+	destroy_mad_qp(&port_priv->qp_info[0]);
+error6:
+	ib_dereg_mr(port_priv->mr);
+error5:
+	ib_dealloc_pd(port_priv->pd);
+error4:
+	ib_destroy_cq(port_priv->cq);
+	cleanup_recv_queue(&port_priv->qp_info[1]);
+	cleanup_recv_queue(&port_priv->qp_info[0]);
+error3:
+	kfree(port_priv);
+
+	return ret;
+}
+
+/*
+ * Close the port 
+ * If there are no classes using the port, free the port 
+ * resources (CQ, MR, PD, QP) and remove the port's info structure
+ */
+static int ib_mad_port_close(struct ib_device *device, int port_num)
+{
+	struct ib_mad_port_private *port_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ib_mad_port_list_lock, flags);
+	port_priv = __ib_get_mad_port(device, port_num);
+	if (port_priv == NULL) {
+		spin_unlock_irqrestore(&ib_mad_port_list_lock, flags);
+		printk(KERN_ERR PFX "Port %d not found\n", port_num);
+		return -ENODEV;
+	}
+	list_del(&port_priv->port_list);
+	spin_unlock_irqrestore(&ib_mad_port_list_lock, flags);
+
+	/* Stop processing completions. */
+	flush_workqueue(port_priv->wq);
+	destroy_workqueue(port_priv->wq);
+	destroy_mad_qp(&port_priv->qp_info[1]);
+	destroy_mad_qp(&port_priv->qp_info[0]);
+	ib_dereg_mr(port_priv->mr);
+	ib_dealloc_pd(port_priv->pd);
+	ib_destroy_cq(port_priv->cq);
+	cleanup_recv_queue(&port_priv->qp_info[1]);
+	cleanup_recv_queue(&port_priv->qp_info[0]);
+	/* XXX: Handle deallocation of MAD registration tables */
+
+	kfree(port_priv);
+
+	return 0;
+}
+
+static void ib_mad_init_device(struct ib_device *device)
+{
+	int ret, num_ports, cur_port, i, ret2;
+
+	if (device->node_type == IB_NODE_SWITCH) {
+		num_ports = 1;
+		cur_port = 0;
+	} else {
+		num_ports = device->phys_port_cnt;
+		cur_port = 1;
+	}
+	for (i = 0; i < num_ports; i++, cur_port++) {
+		ret = ib_mad_port_open(device, cur_port);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't open %s port %d\n",
+			       device->name, cur_port);
+			goto error_device_open;
+		}
+		ret = ib_agent_port_open(device, cur_port);
+		if (ret) {
+			printk(KERN_ERR PFX "Couldn't open %s port %d "
+			       "for agents\n",
+			       device->name, cur_port);
+			goto error_device_open;
+		}
+	}
+
+	goto error_device_query;
+
+error_device_open:
+	while (i > 0) {
+		cur_port--;
+		ret2 = ib_agent_port_close(device, cur_port);
+		if (ret2) {
+			printk(KERN_ERR PFX "Couldn't close %s port %d "
+			       "for agents\n",
+			       device->name, cur_port);
+		}
+		ret2 = ib_mad_port_close(device, cur_port);
+		if (ret2) {
+			printk(KERN_ERR PFX "Couldn't close %s port %d\n",
+			       device->name, cur_port);
+		}
+		i--;
+	}
+
+error_device_query:
+	return;
+}
+
+static void ib_mad_remove_device(struct ib_device *device)
+{
+	int ret = 0, i, num_ports, cur_port, ret2;
+
+	if (device->node_type == IB_NODE_SWITCH) {
+		num_ports = 1;
+		cur_port = 0;
+	} else {
+		num_ports = device->phys_port_cnt;
+		cur_port = 1;
+	}
+	for (i = 0; i < num_ports; i++, cur_port++) {
+		ret2 = ib_agent_port_close(device, cur_port);
+		if (ret2) {
+			printk(KERN_ERR PFX "Couldn't close %s port %d "
+			       "for agents\n",
+			       device->name, cur_port);
+			if (!ret)
+				ret = ret2;
+		}
+		ret2 = ib_mad_port_close(device, cur_port);
+		if (ret2) {
+			printk(KERN_ERR PFX "Couldn't close %s port %d\n",
+			       device->name, cur_port);
+			if (!ret)
+				ret = ret2;
+		}
+	}
+}
+
+static struct ib_client mad_client = {
+	.name   = "mad",
+	.add = ib_mad_init_device,
+	.remove = ib_mad_remove_device
+};
+
+static int __init ib_mad_init_module(void)
+{
+	int ret;
+
+	spin_lock_init(&ib_mad_port_list_lock);
+	spin_lock_init(&ib_agent_port_list_lock);
+
+	ib_mad_cache = kmem_cache_create("ib_mad",
+					 sizeof(struct ib_mad_private),
+					 0,
+					 SLAB_HWCACHE_ALIGN,
+					 NULL,
+					 NULL);
+	if (!ib_mad_cache) {
+		printk(KERN_ERR PFX "Couldn't create ib_mad cache\n");
+		ret = -ENOMEM;
+		goto error1;
+	}
+
+	INIT_LIST_HEAD(&ib_mad_port_list);
+
+	if (ib_register_client(&mad_client)) {
+		printk(KERN_ERR PFX "Couldn't register ib_mad client\n");
+		ret = -EINVAL;
+		goto error2;
+	}
+
+	return 0;
+
+error2:
+	kmem_cache_destroy(ib_mad_cache);
+error1:
+	return ret;
+}
+
+static void __exit ib_mad_cleanup_module(void)
+{
+	ib_unregister_client(&mad_client);
+
+	if (kmem_cache_destroy(ib_mad_cache)) {
+		printk(KERN_DEBUG PFX "Failed to destroy ib_mad cache\n");
+	}
+}
+
+module_init(ib_mad_init_module);
+module_exit(ib_mad_cleanup_module);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/mad_priv.h	2004-11-23 08:10:18.221875555 -0800
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2004, Voltaire, Inc. All rights reserved.
+ * Maintained by: vtrmaint1@voltaire.com
+ *
+ * This program is intended for the purpose of Infiniband
+ * protocol stack for Linux Servers. 
+ *
+ * This software program is free software and you are free to modifyi
+ * and/or redistribute it under a choice of one of the following two
+ * licenses:
+ *
+ * 1) under either the GNU General Public License (GPL) Version 2, June 1991,
+ *    a copy of which is in the file LICENSE_GPL_V2.txt in the root directory.
+ *    This GPL license is also available from the Free Software Foundation,
+ *    Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA, or on the
+ *    web at http://www.fsf.org/copyleft/gpl.html
+ *
+ * OR
+ *
+ * 2) under the terms of the "The BSD License" a copy of which is in the file
+ *    LICENSE2.txt in the root directory. The license is also available from
+ *    the Open Source Initiative, on the web at
+ *    http://www.opensource.org/licenses/bsd-license.php.
+ *
+ *
+ *    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *
+ *
+ * To obtain a copy of these licenses, the source code to this software or
+ * for other questions, you may write to Voltaire, Inc.,
+ * Attention: Voltaire openSource maintainer, 
+ * Voltaire, Inc. 54 Middlesex Turnpike Bedford, MA 01730 or
+ * by Email: vtrmaint1@voltaire.com
+ *
+ * Licensee has the right to choose either one of the above two licenses.
+ *
+ * Redistributions of source code must retain both the above copyright
+ * notice and either one of the license notices.
+ *
+ * Redistributions in binary form must reproduce both the above copyright
+ * notice, either one of the license notices in the documentation
+ * and/or other materials provided with the distribution.
+ */
+
+#ifndef __IB_MAD_PRIV_H__
+#define __IB_MAD_PRIV_H__
+
+#include <linux/pci.h>
+#include <linux/kthread.h>
+#include <linux/workqueue.h>
+#include <ib_mad.h>
+#include <ib_smi.h>
+
+
+#define PFX "ib_mad: "
+
+#define IB_MAD_QPS_CORE		2 /* Always QP0 and QP1 as a minimum */
+
+/* QP and CQ parameters */
+#define IB_MAD_QP_SEND_SIZE	2048
+#define IB_MAD_QP_RECV_SIZE	512
+#define IB_MAD_SEND_REQ_MAX_SG	2
+#define IB_MAD_RECV_REQ_MAX_SG	1
+
+#define IB_MAD_SEND_Q_PSN	0
+
+/* Registration table sizes */
+#define MAX_MGMT_CLASS		80	
+#define MAX_MGMT_VERSION	8
+
+struct ib_mad_list_head {
+	struct list_head list;
+	struct ib_mad_queue *mad_queue;
+};
+
+struct ib_mad_private_header {
+	struct ib_mad_list_head mad_list;
+	struct ib_mad_recv_wc recv_wc;
+	struct ib_mad_recv_buf recv_buf;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+} __attribute__ ((packed));
+
+struct ib_mad_private {
+	struct ib_mad_private_header header;
+	struct ib_grh grh;
+	union {
+		struct ib_mad mad;
+		struct ib_rmpp_mad rmpp_mad;
+		struct ib_smp smp;
+	} mad;
+} __attribute__ ((packed));
+
+struct ib_mad_agent_private {
+	struct list_head agent_list;
+	struct ib_mad_agent agent;
+	struct ib_mad_reg_req *reg_req;
+	struct ib_mad_qp_info *qp_info;
+
+	spinlock_t lock;
+	struct list_head send_list;
+	struct list_head wait_list;
+	struct work_struct work;
+	unsigned long timeout;
+
+	atomic_t refcount;
+	wait_queue_head_t wait;
+	u8 rmpp_version;
+};
+
+struct ib_mad_send_wr_private {
+	struct ib_mad_list_head mad_list;
+	struct list_head agent_list;
+	struct ib_mad_agent *agent;
+	struct ib_send_wr send_wr;
+	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
+	u64 wr_id;			/* client WR ID */
+	u64 tid;
+	unsigned long timeout;
+	int retry;
+	int refcount;
+	enum ib_wc_status status;
+};
+
+struct ib_mad_mgmt_method_table {
+	struct ib_mad_agent_private *agent[IB_MGMT_MAX_METHODS];
+};
+
+struct ib_mad_mgmt_class_table {
+	struct ib_mad_mgmt_method_table *method_table[MAX_MGMT_CLASS];
+};
+
+struct ib_mad_queue {
+	spinlock_t lock;
+	struct list_head list;
+	int count;
+	int max_active;
+	struct ib_mad_qp_info *qp_info;
+};
+
+struct ib_mad_qp_info {
+	struct ib_mad_port_private *port_priv;
+	struct ib_qp *qp;
+	struct ib_mad_queue send_queue;
+	struct ib_mad_queue recv_queue;
+	struct list_head overflow_list;
+};
+
+struct ib_mad_port_private {
+	struct list_head port_list;
+	struct ib_device *device;
+	int port_num;
+	struct ib_cq *cq;
+	struct ib_pd *pd;
+	struct ib_mr *mr;
+
+	spinlock_t reg_lock;
+	struct ib_mad_mgmt_class_table *version[MAX_MGMT_VERSION];
+	struct list_head agent_list;
+	struct workqueue_struct *wq;
+	struct work_struct work;
+	struct ib_mad_qp_info qp_info[IB_MAD_QPS_CORE];
+};
+
+#endif	/* __IB_MAD_PRIV_H__ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/smi.c	2004-11-23 08:10:18.110891920 -0800
@@ -0,0 +1,222 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#include <ib_smi.h>
+
+
+/*
+ * Fixup a directed route SMP for sending
+ * Return 0 if the SMP should be discarded
+ */
+int smi_handle_dr_smp_send(struct ib_smp *smp,
+			   u8 node_type,
+			   int port_num)
+{
+	u8 hop_ptr, hop_cnt;
+
+	hop_ptr = smp->hop_ptr;
+	hop_cnt = smp->hop_cnt;
+
+	/* See section 14.2.2.2, Vol 1 IB spec */
+	if (!ib_get_smp_direction(smp)) {
+		/* C14-9:1 */
+		if (hop_cnt && hop_ptr == 0) {
+			smp->hop_ptr++;
+			return (smp->initial_path[smp->hop_ptr] == 
+				port_num);
+		}
+
+		/* C14-9:2 */
+		if (hop_ptr && hop_ptr < hop_cnt) {
+			if (node_type != IB_NODE_SWITCH)
+				return 0;
+			
+			/* smp->return_path set when received */
+			smp->hop_ptr++;
+			return (smp->initial_path[smp->hop_ptr] == 
+				port_num);
+		}
+
+		/* C14-9:3 -- We're at the end of the DR segment of path */
+		if (hop_ptr == hop_cnt) {
+			/* smp->return_path set when received */
+			smp->hop_ptr++;
+			return (node_type == IB_NODE_SWITCH ||
+				smp->dr_dlid == IB_LID_PERMISSIVE);
+		}
+
+		/* C14-9:4 -- hop_ptr = hop_cnt + 1 -> give to SMA/SM */
+		/* C14-9:5 -- Fail unreasonable hop pointer */
+		return (hop_ptr == hop_cnt + 1);
+
+	} else {
+		/* C14-13:1 */
+		if (hop_cnt && hop_ptr == hop_cnt + 1) {
+			smp->hop_ptr--;
+			return (smp->return_path[smp->hop_ptr] == 
+				port_num);
+		}
+
+		/* C14-13:2 */
+		if (2 <= hop_ptr && hop_ptr <= hop_cnt) {
+			if (node_type != IB_NODE_SWITCH)
+				return 0;
+
+			smp->hop_ptr--;
+			return (smp->return_path[smp->hop_ptr] == 
+				port_num);
+		}
+
+		/* C14-13:3 -- at the end of the DR segment of path */
+		if (hop_ptr == 1) {
+			smp->hop_ptr--;
+			/* C14-13:3 -- SMPs destined for SM shouldn't be here */
+			return (node_type == IB_NODE_SWITCH ||
+				smp->dr_slid == IB_LID_PERMISSIVE);
+		}
+
+		/* C14-13:4 -- hop_ptr = 0 -> should have gone to SM */
+		if (hop_ptr == 0)
+			return 1;
+
+		/* C14-13:5 -- Check for unreasonable hop pointer */
+		return 0;
+	}
+}
+
+/*
+ * Adjust information for a received SMP
+ * Return 0 if the SMP should be dropped
+ */
+int smi_handle_dr_smp_recv(struct ib_smp *smp,
+			   u8 node_type,
+			   int port_num,
+			   int phys_port_cnt)
+{
+	u8 hop_ptr, hop_cnt;
+
+	hop_ptr = smp->hop_ptr;
+	hop_cnt = smp->hop_cnt;
+
+	/* See section 14.2.2.2, Vol 1 IB spec */
+	if (!ib_get_smp_direction(smp)) {
+		/* C14-9:1 -- sender should have incremented hop_ptr */
+		if (hop_cnt && hop_ptr == 0)
+			return 0;
+
+		/* C14-9:2 -- intermediate hop */
+		if (hop_ptr && hop_ptr < hop_cnt) {
+			if (node_type != IB_NODE_SWITCH)
+				return 0;
+
+			smp->return_path[hop_ptr] = port_num;
+			/* smp->hop_ptr updated when sending */
+			return (smp->initial_path[hop_ptr+1] <= phys_port_cnt);
+		}
+
+		/* C14-9:3 -- We're at the end of the DR segment of path */
+		if (hop_ptr == hop_cnt) {
+			if (hop_cnt)
+				smp->return_path[hop_ptr] = port_num;
+			/* smp->hop_ptr updated when sending */
+
+			return (node_type == IB_NODE_SWITCH ||
+				smp->dr_dlid == IB_LID_PERMISSIVE);
+		}
+		
+		/* C14-9:4 -- hop_ptr = hop_cnt + 1 -> give to SMA/SM */
+		/* C14-9:5 -- fail unreasonable hop pointer */
+		return (hop_ptr == hop_cnt + 1);
+
+	} else {
+
+		/* C14-13:1 */
+		if (hop_cnt && hop_ptr == hop_cnt + 1) {
+			smp->hop_ptr--;
+			return (smp->return_path[smp->hop_ptr] ==
+				port_num);
+		}
+
+		/* C14-13:2 */
+		if (2 <= hop_ptr && hop_ptr <= hop_cnt) {
+			if (node_type != IB_NODE_SWITCH)
+				return 0;
+
+			/* smp->hop_ptr updated when sending */
+			return (smp->return_path[hop_ptr-1] <= phys_port_cnt);
+		}
+
+		/* C14-13:3 -- We're at the end of the DR segment of path */
+		if (hop_ptr == 1) {
+			if (smp->dr_slid == IB_LID_PERMISSIVE) {
+				/* giving SMP to SM - update hop_ptr */
+				smp->hop_ptr--;
+				return 1;
+			}
+			/* smp->hop_ptr updated when sending */
+			return (node_type == IB_NODE_SWITCH);
+		}
+
+		/* C14-13:4 -- hop_ptr = 0 -> give to SM */
+		/* C14-13:5 -- Check for unreasonable hop pointer */
+		return (hop_ptr == 0);
+	}
+}
+
+/*
+ * Return 1 if the received DR SMP should be forwarded to the send queue
+ * Return 0 if the SMP should be completed up the stack
+ */
+int smi_check_forward_dr_smp(struct ib_smp *smp)
+{
+	u8 hop_ptr, hop_cnt;
+
+	hop_ptr = smp->hop_ptr;
+	hop_cnt = smp->hop_cnt;
+
+	if (!ib_get_smp_direction(smp)) {
+		/* C14-9:2 -- intermediate hop */
+		if (hop_ptr && hop_ptr < hop_cnt)
+			return 1;
+
+		/* C14-9:3 -- at the end of the DR segment of path */
+		if (hop_ptr == hop_cnt)
+			return (smp->dr_dlid == IB_LID_PERMISSIVE);
+
+		/* C14-9:4 -- hop_ptr = hop_cnt + 1 -> give to SMA/SM */
+		if (hop_ptr == hop_cnt + 1)
+			return 1;
+	} else {
+		/* C14-13:2 */
+		if (2 <= hop_ptr && hop_ptr <= hop_cnt)
+			return 1;
+
+		/* C14-13:3 -- at the end of the DR segment of path */
+		if (hop_ptr == 1)
+			return (smp->dr_slid != IB_LID_PERMISSIVE);
+	}
+	return 0;
+}
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/smi.h	2004-11-23 08:10:18.259869953 -0800
@@ -0,0 +1,54 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#ifndef __SMI_H_
+#define __SMI_H_
+
+int smi_handle_dr_smp_recv(struct ib_smp *smp,
+			   u8 node_type,
+			   int port_num,
+			   int phys_port_cnt);
+extern int smi_check_forward_dr_smp(struct ib_smp *smp);
+extern int smi_handle_dr_smp_send(struct ib_smp *smp,
+				  u8 node_type,
+				  int port_num);
+extern int smi_check_local_dr_smp(struct ib_smp *smp,
+				  struct ib_device *device,
+				  int port_num);
+
+/*
+ * Return 1 if the SMP should be handled by the local SMA/SM via process_mad
+ */
+static inline int smi_check_local_smp(struct ib_mad_agent *mad_agent,
+                         	      struct ib_smp *smp)
+{
+	/* C14-9:3 -- We're at the end of the DR segment of path */
+	/* C14-9:4 -- Hop Pointer = Hop Count + 1 -> give to SMA/SM */
+	return ((mad_agent->device->process_mad &&
+		!ib_get_smp_direction(smp) &&
+		(smp->hop_ptr == smp->hop_cnt + 1)));
+}
+
+#endif	/* __SMI_H_ */

