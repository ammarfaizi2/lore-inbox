Return-Path: <linux-kernel-owner+w=401wt.eu-S965042AbWLTMoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWLTMoG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWLTMnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:43:55 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:21004 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbWLTMnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:43:31 -0500
From: Divy Le Ray <None@chelsio.com>
Subject: [PATCH 8/10] cxgb3 - offload capabilities
Date: Wed, 20 Dec 2006 04:43:18 -0800
To: jeff@garzik.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Message-Id: <20061220124318.6378.14407.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divy Le Ray <divy@chelsio.com>

This patch implements the offload capabilities of the
Chelsio network adapter's driver.

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---

 drivers/net/cxgb3/cxgb3_offload.c | 1222 +++++++++++++++++++++++++++++++++++++
 drivers/net/cxgb3/l2t.c           |  450 ++++++++++++++
 2 files changed, 1672 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cxgb3/cxgb3_offload.c b/drivers/net/cxgb3/cxgb3_offload.c
new file mode 100755
index 0000000..3abd4d2
--- /dev/null
+++ b/drivers/net/cxgb3/cxgb3_offload.c
@@ -0,0 +1,1222 @@
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
+
+#include <linux/list.h>
+#include <net/neighbour.h>
+#include <linux/notifier.h>
+#include <asm/atomic.h>
+#include <linux/proc_fs.h>
+#include <linux/if_vlan.h>
+#include <net/netevent.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+
+#include "common.h"
+#include "regs.h"
+#include "cxgb3_ioctl.h"
+#include "cxgb3_ctl_defs.h"
+#include "cxgb3_defs.h"
+#include "l2t.h"
+#include "firmware_exports.h"
+#include "cxgb3_offload.h"
+
+static LIST_HEAD(client_list);
+static LIST_HEAD(ofld_dev_list);
+static DEFINE_MUTEX(cxgb3_db_lock);
+
+static DEFINE_RWLOCK(adapter_list_lock);
+static LIST_HEAD(adapter_list);
+
+static const unsigned int MAX_ATIDS = 64 * 1024;
+static const unsigned int ATID_BASE = 0x100000;
+
+static inline int offload_activated(struct t3cdev *tdev)
+{
+	const struct adapter *adapter = tdev2adap(tdev);
+
+	return (test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map));
+}
+
+/**
+ *	cxgb3_register_client - register an offload client
+ *	@client: the client
+ *
+ *	Add the client to the client list,
+ *	and call backs the client for each activated offload device
+ */
+void cxgb3_register_client(struct cxgb3_client *client)
+{
+	struct t3cdev *tdev;
+
+	mutex_lock(&cxgb3_db_lock);
+	list_add_tail(&client->client_list, &client_list);
+
+	if (client->add) {
+		list_for_each_entry(tdev, &ofld_dev_list, ofld_dev_list) {
+			if (offload_activated(tdev))
+				client->add(tdev);
+		}
+	}
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+EXPORT_SYMBOL(cxgb3_register_client);
+
+/**
+ *	cxgb3_unregister_client - unregister an offload client
+ *	@client: the client
+ *
+ *	Remove the client to the client list,
+ *	and call backs the client for each activated offload device.
+ */
+void cxgb3_unregister_client(struct cxgb3_client *client)
+{
+	struct t3cdev *tdev;
+
+	mutex_lock(&cxgb3_db_lock);
+	list_del(&client->client_list);
+
+	if (client->remove) {
+		list_for_each_entry(tdev, &ofld_dev_list, ofld_dev_list) {
+			if (offload_activated(tdev))
+				client->remove(tdev);
+		}
+	}
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+EXPORT_SYMBOL(cxgb3_unregister_client);
+
+/**
+ *	cxgb3_add_clients - activate registered clients for an offload device
+ *	@tdev: the offload device
+ *
+ *	Call backs all registered clients once a offload device is activated
+ */
+void cxgb3_add_clients(struct t3cdev *tdev)
+{
+	struct cxgb3_client *client;
+
+	mutex_lock(&cxgb3_db_lock);
+	list_for_each_entry(client, &client_list, client_list) {
+		if (client->add)
+			client->add(tdev);
+	}
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+/**
+ *	cxgb3_remove_clients - deactivates registered clients
+ *			       for an offload device
+ *	@tdev: the offload device
+ *
+ *	Call backs all registered clients once a offload device is deactivated
+ */
+void cxgb3_remove_clients(struct t3cdev *tdev)
+{
+	struct cxgb3_client *client;
+
+	mutex_lock(&cxgb3_db_lock);
+	list_for_each_entry(client, &client_list, client_list) {
+		if (client->remove)
+			client->remove(tdev);
+	}
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+static struct net_device *get_iff_from_mac(struct adapter *adapter,
+					   const unsigned char *mac,
+					   unsigned int vlan)
+{
+	int i;
+
+	for_each_port(adapter, i) {
+		const struct vlan_group *grp;
+		struct net_device *dev = adapter->port[i];
+		const struct port_info *p = netdev_priv(dev);
+
+		if (!memcmp(dev->dev_addr, mac, ETH_ALEN)) {
+			if (vlan && vlan != VLAN_VID_MASK) {
+				grp = p->vlan_grp;
+				dev = grp ? grp->vlan_devices[vlan] : NULL;
+			} else
+				while (dev->master)
+					dev = dev->master;
+			return dev;
+		}
+	}
+	return NULL;
+}
+
+static int cxgb_ulp_iscsi_ctl(struct adapter *adapter, unsigned int req,
+			      void *data)
+{
+	int ret = 0;
+	struct ulp_iscsi_info *uiip = data;
+
+	switch (req) {
+	case ULP_ISCSI_GET_PARAMS:
+		uiip->pdev = adapter->pdev;
+		uiip->llimit = t3_read_reg(adapter, A_ULPRX_ISCSI_LLIMIT);
+		uiip->ulimit = t3_read_reg(adapter, A_ULPRX_ISCSI_ULIMIT);
+		uiip->tagmask = t3_read_reg(adapter, A_ULPRX_ISCSI_TAGMASK);
+		/*
+		 * On tx, the iscsi pdu has to be <= tx page size and has to
+		 * fit into the Tx PM FIFO.
+		 */
+		uiip->max_txsz = min(adapter->params.tp.tx_pg_size,
+				     t3_read_reg(adapter, A_PM1_TX_CFG) >> 17);
+		/* on rx, the iscsi pdu has to be < rx page size and the
+		   whole pdu + cpl headers has to fit into one sge buffer */
+		uiip->max_rxsz = min_t(unsigned int,
+				       adapter->params.tp.rx_pg_size,
+				       (adapter->sge.qs[0].fl[1].buf_size -
+					sizeof(struct cpl_rx_data) * 2 -
+					sizeof(struct cpl_rx_data_ddp)));
+		break;
+	case ULP_ISCSI_SET_PARAMS:
+		t3_write_reg(adapter, A_ULPRX_ISCSI_TAGMASK, uiip->tagmask);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+	return ret;
+}
+
+/* Response queue used for RDMA events. */
+#define ASYNC_NOTIF_RSPQ 0
+
+static int cxgb_rdma_ctl(struct adapter *adapter, unsigned int req, void *data)
+{
+	int ret = 0;
+
+	switch (req) {
+	case RDMA_GET_PARAMS:{
+		struct rdma_info *req = data;
+		struct pci_dev *pdev = adapter->pdev;
+
+		req->udbell_physbase = pci_resource_start(pdev, 2);
+		req->udbell_len = pci_resource_len(pdev, 2);
+		req->tpt_base =
+			t3_read_reg(adapter, A_ULPTX_TPT_LLIMIT);
+		req->tpt_top = t3_read_reg(adapter, A_ULPTX_TPT_ULIMIT);
+		req->pbl_base =
+			t3_read_reg(adapter, A_ULPTX_PBL_LLIMIT);
+		req->pbl_top = t3_read_reg(adapter, A_ULPTX_PBL_ULIMIT);
+		req->rqt_base = t3_read_reg(adapter, A_ULPRX_RQ_LLIMIT);
+		req->rqt_top = t3_read_reg(adapter, A_ULPRX_RQ_ULIMIT);
+		req->kdb_addr = adapter->regs + A_SG_KDOORBELL;
+		req->pdev = pdev;
+		break;
+	}
+	case RDMA_CQ_OP:{
+		unsigned long flags;
+		struct rdma_cq_op *req = data;
+
+		/* may be called in any context */
+		spin_lock_irqsave(&adapter->sge.reg_lock, flags);
+		ret = t3_sge_cqcntxt_op(adapter, req->id, req->op,
+					req->credits);
+		spin_unlock_irqrestore(&adapter->sge.reg_lock, flags);
+		break;
+	}
+	case RDMA_GET_MEM:{
+		struct ch_mem_range *t = data;
+		struct mc7 *mem;
+
+		if ((t->addr & 7) || (t->len & 7))
+			return -EINVAL;
+		if (t->mem_id == MEM_CM)
+			mem = &adapter->cm;
+		else if (t->mem_id == MEM_PMRX)
+			mem = &adapter->pmrx;
+		else if (t->mem_id == MEM_PMTX)
+			mem = &adapter->pmtx;
+		else
+			return -EINVAL;
+
+		ret =
+			t3_mc7_bd_read(mem, t->addr / 8, t->len / 8,
+					(u64 *) t->buf);
+		if (ret)
+			return ret;
+		break;
+	}
+	case RDMA_CQ_SETUP:{
+		struct rdma_cq_setup *req = data;
+
+		spin_lock_irq(&adapter->sge.reg_lock);
+		ret =
+			t3_sge_init_cqcntxt(adapter, req->id,
+					req->base_addr, req->size,
+					ASYNC_NOTIF_RSPQ,
+					req->ovfl_mode, req->credits,
+					req->credit_thres);
+		spin_unlock_irq(&adapter->sge.reg_lock);
+		break;
+	}
+	case RDMA_CQ_DISABLE:
+		spin_lock_irq(&adapter->sge.reg_lock);
+		ret = t3_sge_disable_cqcntxt(adapter, *(unsigned int *)data);
+		spin_unlock_irq(&adapter->sge.reg_lock);
+		break;
+	case RDMA_CTRL_QP_SETUP:{
+		struct rdma_ctrlqp_setup *req = data;
+
+		spin_lock_irq(&adapter->sge.reg_lock);
+		ret = t3_sge_init_ecntxt(adapter, FW_RI_SGEEC_START, 0,
+						SGE_CNTXT_RDMA,
+						ASYNC_NOTIF_RSPQ,
+						req->base_addr, req->size,
+						FW_RI_TID_START, 1, 0);
+		spin_unlock_irq(&adapter->sge.reg_lock);
+		break;
+	}
+	default:
+		ret = -EOPNOTSUPP;
+	}
+	return ret;
+}
+
+static int cxgb_offload_ctl(struct t3cdev *tdev, unsigned int req, void *data)
+{
+	struct adapter *adapter = tdev2adap(tdev);
+	struct tid_range *tid;
+	struct mtutab *mtup;
+	struct iff_mac *iffmacp;
+	struct ddp_params *ddpp;
+	struct adap_ports *ports;
+	int i;
+
+	switch (req) {
+	case GET_MAX_OUTSTANDING_WR:
+		*(unsigned int *)data = FW_WR_NUM;
+		break;
+	case GET_WR_LEN:
+		*(unsigned int *)data = WR_FLITS;
+		break;
+	case GET_TX_MAX_CHUNK:
+		*(unsigned int *)data = 1 << 20;	/* 1MB */
+		break;
+	case GET_TID_RANGE:
+		tid = data;
+		tid->num = t3_mc5_size(&adapter->mc5) -
+		    adapter->params.mc5.nroutes -
+		    adapter->params.mc5.nfilters - adapter->params.mc5.nservers;
+		tid->base = 0;
+		break;
+	case GET_STID_RANGE:
+		tid = data;
+		tid->num = adapter->params.mc5.nservers;
+		tid->base = t3_mc5_size(&adapter->mc5) - tid->num -
+		    adapter->params.mc5.nfilters - adapter->params.mc5.nroutes;
+		break;
+	case GET_L2T_CAPACITY:
+		*(unsigned int *)data = 2048;
+		break;
+	case GET_MTUS:
+		mtup = data;
+		mtup->size = NMTUS;
+		mtup->mtus = adapter->params.mtus;
+		break;
+	case GET_IFF_FROM_MAC:
+		iffmacp = data;
+		iffmacp->dev = get_iff_from_mac(adapter, iffmacp->mac_addr,
+						iffmacp->vlan_tag &
+						VLAN_VID_MASK);
+		break;
+	case GET_DDP_PARAMS:
+		ddpp = data;
+		ddpp->llimit = t3_read_reg(adapter, A_ULPRX_TDDP_LLIMIT);
+		ddpp->ulimit = t3_read_reg(adapter, A_ULPRX_TDDP_ULIMIT);
+		ddpp->tag_mask = t3_read_reg(adapter, A_ULPRX_TDDP_TAGMASK);
+		break;
+	case GET_PORTS:
+		ports = data;
+		ports->nports = adapter->params.nports;
+		for_each_port(adapter, i)
+			ports->lldevs[i] = adapter->port[i];
+		break;
+	case ULP_ISCSI_GET_PARAMS:
+	case ULP_ISCSI_SET_PARAMS:
+		if (!offload_running(adapter))
+			return -EAGAIN;
+		return cxgb_ulp_iscsi_ctl(adapter, req, data);
+	case RDMA_GET_PARAMS:
+	case RDMA_CQ_OP:
+	case RDMA_CQ_SETUP:
+	case RDMA_CQ_DISABLE:
+	case RDMA_CTRL_QP_SETUP:
+	case RDMA_GET_MEM:
+		if (!offload_running(adapter))
+			return -EAGAIN;
+		return cxgb_rdma_ctl(adapter, req, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+/*
+ * Dummy handler for Rx offload packets in case we get an offload packet before
+ * proper processing is setup.  This complains and drops the packet as it isn't
+ * normal to get offload packets at this stage.
+ */
+static int rx_offload_blackhole(struct t3cdev *dev, struct sk_buff **skbs,
+				int n)
+{
+	CH_ERR(tdev2adap(dev), "%d unexpected offload packets, first data %u\n",
+	       n, ntohl(*(u32 *)skbs[0]->data));
+	while (n--)
+		dev_kfree_skb_any(skbs[n]);
+	return 0;
+}
+
+static void dummy_neigh_update(struct t3cdev *dev, struct neighbour *neigh)
+{
+}
+
+void cxgb3_set_dummy_ops(struct t3cdev *dev)
+{
+	dev->recv = rx_offload_blackhole;
+	dev->neigh_update = dummy_neigh_update;
+}
+
+/*
+ * Free an active-open TID.
+ */
+void *cxgb3_free_atid(struct t3cdev *tdev, int atid)
+{
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+	union active_open_entry *p = atid2entry(t, atid);
+	void *ctx = p->t3c_tid.ctx;
+
+	spin_lock_bh(&t->atid_lock);
+	p->next = t->afree;
+	t->afree = p;
+	t->atids_in_use--;
+	spin_unlock_bh(&t->atid_lock);
+
+	return ctx;
+}
+
+EXPORT_SYMBOL(cxgb3_free_atid);
+
+/*
+ * Free a server TID and return it to the free pool.
+ */
+void cxgb3_free_stid(struct t3cdev *tdev, int stid)
+{
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+	union listen_entry *p = stid2entry(t, stid);
+
+	spin_lock_bh(&t->stid_lock);
+	p->next = t->sfree;
+	t->sfree = p;
+	t->stids_in_use--;
+	spin_unlock_bh(&t->stid_lock);
+}
+
+EXPORT_SYMBOL(cxgb3_free_stid);
+
+void cxgb3_insert_tid(struct t3cdev *tdev, struct cxgb3_client *client,
+		      void *ctx, unsigned int tid)
+{
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+
+	t->tid_tab[tid].client = client;
+	t->tid_tab[tid].ctx = ctx;
+	atomic_inc(&t->tids_in_use);
+}
+
+EXPORT_SYMBOL(cxgb3_insert_tid);
+
+/*
+ * Populate a TID_RELEASE WR.  The skb must be already propely sized.
+ */
+static inline void mk_tid_release(struct sk_buff *skb, unsigned int tid)
+{
+	struct cpl_tid_release *req;
+
+	skb->priority = CPL_PRIORITY_SETUP;
+	req = (struct cpl_tid_release *)__skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_TID_RELEASE, tid));
+}
+
+static void t3_process_tid_release_list(struct work_struct *work)
+{
+	struct t3c_data *td = container_of(work, struct t3c_data,
+					   tid_release_task);
+	struct sk_buff *skb;
+	struct t3cdev *tdev = td->dev;
+	
+
+	spin_lock_bh(&td->tid_release_lock);
+	while (td->tid_release_list) {
+		struct t3c_tid_entry *p = td->tid_release_list;
+
+		td->tid_release_list = (struct t3c_tid_entry *)p->ctx;
+		spin_unlock_bh(&td->tid_release_lock);
+
+		skb = alloc_skb(sizeof(struct cpl_tid_release),
+				GFP_KERNEL | __GFP_NOFAIL);
+		mk_tid_release(skb, p - td->tid_maps.tid_tab);
+		cxgb3_ofld_send(tdev, skb);
+		p->ctx = NULL;
+		spin_lock_bh(&td->tid_release_lock);
+	}
+	spin_unlock_bh(&td->tid_release_lock);
+}
+
+/* use ctx as a next pointer in the tid release list */
+void cxgb3_queue_tid_release(struct t3cdev *tdev, unsigned int tid)
+{
+	struct t3c_data *td = T3C_DATA(tdev);
+	struct t3c_tid_entry *p = &td->tid_maps.tid_tab[tid];
+
+	spin_lock_bh(&td->tid_release_lock);
+	p->ctx = (void *)td->tid_release_list;
+	td->tid_release_list = p;
+	if (!p->ctx)
+		schedule_work(&td->tid_release_task);
+	spin_unlock_bh(&td->tid_release_lock);
+}
+
+EXPORT_SYMBOL(cxgb3_queue_tid_release);
+
+/*
+ * Remove a tid from the TID table.  A client may defer processing its last
+ * CPL message if it is locked at the time it arrives, and while the message
+ * sits in the client's backlog the TID may be reused for another connection.
+ * To handle this we atomically switch the TID association if it still points
+ * to the original client context.
+ */
+void cxgb3_remove_tid(struct t3cdev *tdev, void *ctx, unsigned int tid)
+{
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+
+	BUG_ON(tid >= t->ntids);
+	if (tdev->type == T3A)
+		(void)cmpxchg(&t->tid_tab[tid].ctx, ctx, NULL);
+	else {
+		struct sk_buff *skb;
+
+		skb = alloc_skb(sizeof(struct cpl_tid_release), GFP_ATOMIC);
+		if (likely(skb)) {
+			mk_tid_release(skb, tid);
+			cxgb3_ofld_send(tdev, skb);
+			t->tid_tab[tid].ctx = NULL;
+		} else
+			cxgb3_queue_tid_release(tdev, tid);
+	}
+	atomic_dec(&t->tids_in_use);
+}
+
+EXPORT_SYMBOL(cxgb3_remove_tid);
+
+int cxgb3_alloc_atid(struct t3cdev *tdev, struct cxgb3_client *client,
+		     void *ctx)
+{
+	int atid = -1;
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+
+	spin_lock_bh(&t->atid_lock);
+	if (t->afree) {
+		union active_open_entry *p = t->afree;
+
+		atid = (p - t->atid_tab) + t->atid_base;
+		t->afree = p->next;
+		p->t3c_tid.ctx = ctx;
+		p->t3c_tid.client = client;
+		t->atids_in_use++;
+	}
+	spin_unlock_bh(&t->atid_lock);
+	return atid;
+}
+
+EXPORT_SYMBOL(cxgb3_alloc_atid);
+
+int cxgb3_alloc_stid(struct t3cdev *tdev, struct cxgb3_client *client,
+		     void *ctx)
+{
+	int stid = -1;
+	struct tid_info *t = &(T3C_DATA(tdev))->tid_maps;
+
+	spin_lock_bh(&t->stid_lock);
+	if (t->sfree) {
+		union listen_entry *p = t->sfree;
+
+		stid = (p - t->stid_tab) + t->stid_base;
+		t->sfree = p->next;
+		p->t3c_tid.ctx = ctx;
+		p->t3c_tid.client = client;
+		t->stids_in_use++;
+	}
+	spin_unlock_bh(&t->stid_lock);
+	return stid;
+}
+
+EXPORT_SYMBOL(cxgb3_alloc_stid);
+
+static int do_smt_write_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_smt_write_rpl *rpl = cplhdr(skb);
+
+	if (rpl->status != CPL_ERR_NONE)
+		printk(KERN_ERR
+		       "Unexpected SMT_WRITE_RPL status %u for entry %u\n",
+		       rpl->status, GET_TID(rpl));
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int do_l2t_write_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_l2t_write_rpl *rpl = cplhdr(skb);
+
+	if (rpl->status != CPL_ERR_NONE)
+		printk(KERN_ERR
+		       "Unexpected L2T_WRITE_RPL status %u for entry %u\n",
+		       rpl->status, GET_TID(rpl));
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int do_act_open_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_act_open_rpl *rpl = cplhdr(skb);
+	unsigned int atid = G_TID(ntohl(rpl->atid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_atid(&(T3C_DATA(dev))->tid_maps, atid);
+	if (t3c_tid->ctx && t3c_tid->client && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[CPL_ACT_OPEN_RPL]) {
+		return t3c_tid->client->handlers[CPL_ACT_OPEN_RPL] (dev, skb,
+								    t3c_tid->
+								    ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, CPL_ACT_OPEN_RPL);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int do_stid_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	union opcode_tid *p = cplhdr(skb);
+	unsigned int stid = G_TID(ntohl(p->opcode_tid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_stid(&(T3C_DATA(dev))->tid_maps, stid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[p->opcode]) {
+		return t3c_tid->client->handlers[p->opcode] (dev, skb,
+							     t3c_tid->ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, p->opcode);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int do_hwtid_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	union opcode_tid *p = cplhdr(skb);
+	unsigned int hwtid = G_TID(ntohl(p->opcode_tid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_tid(&(T3C_DATA(dev))->tid_maps, hwtid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[p->opcode]) {
+		return t3c_tid->client->handlers[p->opcode]
+		    (dev, skb, t3c_tid->ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, p->opcode);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int do_cr(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_pass_accept_req *req = cplhdr(skb);
+	unsigned int stid = G_PASS_OPEN_TID(ntohl(req->tos_tid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_stid(&(T3C_DATA(dev))->tid_maps, stid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[CPL_PASS_ACCEPT_REQ]) {
+		return t3c_tid->client->handlers[CPL_PASS_ACCEPT_REQ]
+		    (dev, skb, t3c_tid->ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, CPL_PASS_ACCEPT_REQ);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int do_abort_req_rss(struct t3cdev *dev, struct sk_buff *skb)
+{
+	union opcode_tid *p = cplhdr(skb);
+	unsigned int hwtid = G_TID(ntohl(p->opcode_tid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_tid(&(T3C_DATA(dev))->tid_maps, hwtid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[p->opcode]) {
+		return t3c_tid->client->handlers[p->opcode]
+		    (dev, skb, t3c_tid->ctx);
+	} else {
+		struct cpl_abort_req_rss *req = cplhdr(skb);
+		struct cpl_abort_rpl *rpl;
+
+		struct sk_buff *skb =
+		    alloc_skb(sizeof(struct cpl_abort_rpl), GFP_ATOMIC);
+		if (!skb) {
+			printk("do_abort_req_rss: couldn't get skb!\n");
+			goto out;
+		}
+		skb->priority = CPL_PRIORITY_DATA;
+		__skb_put(skb, sizeof(struct cpl_abort_rpl));
+		rpl = cplhdr(skb);
+		rpl->wr.wr_hi =
+		    htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_RPL));
+		rpl->wr.wr_lo = htonl(V_WR_TID(GET_TID(req)));
+		OPCODE_TID(rpl) =
+		    htonl(MK_OPCODE_TID(CPL_ABORT_RPL, GET_TID(req)));
+		rpl->cmd = req->status;
+		cxgb3_ofld_send(dev, skb);
+out:
+		return CPL_RET_BUF_DONE;
+	}
+}
+
+static int do_act_establish(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_act_establish *req = cplhdr(skb);
+	unsigned int atid = G_PASS_OPEN_TID(ntohl(req->tos_tid));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_atid(&(T3C_DATA(dev))->tid_maps, atid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[CPL_ACT_ESTABLISH]) {
+		return t3c_tid->client->handlers[CPL_ACT_ESTABLISH]
+		    (dev, skb, t3c_tid->ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, CPL_PASS_ACCEPT_REQ);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int do_set_tcb_rpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_set_tcb_rpl *rpl = cplhdr(skb);
+
+	if (rpl->status != CPL_ERR_NONE)
+		printk(KERN_ERR
+		       "Unexpected SET_TCB_RPL status %u for tid %u\n",
+		       rpl->status, GET_TID(rpl));
+	return CPL_RET_BUF_DONE;
+}
+
+static int do_trace(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_trace_pkt *p = cplhdr(skb);
+
+	skb->protocol = 0xffff;
+	skb->dev = dev->lldev;
+	skb_pull(skb, sizeof(*p));
+	skb->mac.raw = skb->data;
+	netif_receive_skb(skb);
+	return 0;
+}
+
+static int do_term(struct t3cdev *dev, struct sk_buff *skb)
+{
+	unsigned int hwtid = ntohl(skb->priority) >> 8 & 0xfffff;
+	unsigned int opcode = G_OPCODE(ntohl(skb->csum));
+	struct t3c_tid_entry *t3c_tid;
+
+	t3c_tid = lookup_tid(&(T3C_DATA(dev))->tid_maps, hwtid);
+	if (t3c_tid->ctx && t3c_tid->client->handlers &&
+	    t3c_tid->client->handlers[opcode]) {
+		return t3c_tid->client->handlers[opcode] (dev, skb,
+							  t3c_tid->ctx);
+	} else {
+		printk(KERN_ERR "%s: received clientless CPL command 0x%x\n",
+		       dev->name, opcode);
+		return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+	}
+}
+
+static int nb_callback(struct notifier_block *self, unsigned long event,
+		       void *ctx)
+{
+	switch (event) {
+	case (NETEVENT_NEIGH_UPDATE):{
+		cxgb_neigh_update((struct neighbour *)ctx);
+		break;
+	}
+	case (NETEVENT_PMTU_UPDATE):
+		break;
+	case (NETEVENT_REDIRECT):{
+		struct netevent_redirect *nr = ctx;
+		cxgb_redirect(nr->old, nr->new);
+		cxgb_neigh_update(nr->new->neighbour);
+		break;
+	}
+	default:
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block nb = {
+	.notifier_call = nb_callback
+};
+
+/*
+ * Process a received packet with an unknown/unexpected CPL opcode.
+ */
+static int do_bad_cpl(struct t3cdev *dev, struct sk_buff *skb)
+{
+	printk(KERN_ERR "%s: received bad CPL command 0x%x\n", dev->name,
+	       *skb->data);
+	return CPL_RET_BUF_DONE | CPL_RET_BAD_MSG;
+}
+
+/*
+ * Handlers for each CPL opcode
+ */
+static cpl_handler_func cpl_handlers[NUM_CPL_CMDS];
+
+/*
+ * Add a new handler to the CPL dispatch table.  A NULL handler may be supplied
+ * to unregister an existing handler.
+ */
+void t3_register_cpl_handler(unsigned int opcode, cpl_handler_func h)
+{
+	if (opcode < NUM_CPL_CMDS)
+		cpl_handlers[opcode] = h ? h : do_bad_cpl;
+	else
+		printk(KERN_ERR "T3C: handler registration for "
+		       "opcode %x failed\n", opcode);
+}
+
+EXPORT_SYMBOL(t3_register_cpl_handler);
+
+/*
+ * T3CDEV's receive method.
+ */
+int process_rx(struct t3cdev *dev, struct sk_buff **skbs, int n)
+{
+	while (n--) {
+		struct sk_buff *skb = *skbs++;
+		unsigned int opcode = G_OPCODE(ntohl(skb->csum));
+		int ret = cpl_handlers[opcode] (dev, skb);
+
+#if VALIDATE_TID
+		if (ret & CPL_RET_UNKNOWN_TID) {
+			union opcode_tid *p = cplhdr(skb);
+
+			printk(KERN_ERR "%s: CPL message (opcode %u) had "
+			       "unknown TID %u\n", dev->name, opcode,
+			       G_TID(ntohl(p->opcode_tid)));
+		}
+#endif
+		if (ret & CPL_RET_BUF_DONE)
+			kfree_skb(skb);
+	}
+	return 0;
+}
+
+/*
+ * Sends an sk_buff to a T3C driver after dealing with any active network taps.
+ */
+int cxgb3_ofld_send(struct t3cdev *dev, struct sk_buff *skb)
+{
+	int r;
+
+	local_bh_disable();
+	r = dev->send(dev, skb);
+	local_bh_enable();
+	return r;
+}
+
+EXPORT_SYMBOL(cxgb3_ofld_send);
+
+static int is_offloading(struct net_device *dev)
+{
+	struct adapter *adapter;
+	int i;
+
+	read_lock_bh(&adapter_list_lock);
+	list_for_each_entry(adapter, &adapter_list, adapter_list) {
+		for_each_port(adapter, i) {
+			if (dev == adapter->port[i]) {
+				read_unlock_bh(&adapter_list_lock);
+				return 1;
+			}
+		}
+	}
+	read_unlock_bh(&adapter_list_lock);
+	return 0;
+}
+
+void cxgb_neigh_update(struct neighbour *neigh)
+{
+	struct net_device *dev = neigh->dev;
+
+	if (dev && (is_offloading(dev))) {
+		struct t3cdev *tdev = T3CDEV(dev);
+
+		BUG_ON(!tdev);
+		t3_l2t_update(tdev, neigh);
+	}
+}
+
+static void set_l2t_ix(struct t3cdev *tdev, u32 tid, struct l2t_entry *e)
+{
+	struct sk_buff *skb;
+	struct cpl_set_tcb_field *req;
+
+	skb = alloc_skb(sizeof(*req), GFP_ATOMIC);
+	if (!skb) {
+		printk(KERN_ERR "%s: cannot allocate skb!\n", __FUNCTION__);
+		return;
+	}
+	skb->priority = CPL_PRIORITY_CONTROL;
+	req = (struct cpl_set_tcb_field *)skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, tid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_L2T_IX);
+	req->mask = cpu_to_be64(V_TCB_L2T_IX(M_TCB_L2T_IX));
+	req->val = cpu_to_be64(V_TCB_L2T_IX(e->idx));
+	tdev->send(tdev, skb);
+}
+
+void cxgb_redirect(struct dst_entry *old, struct dst_entry *new)
+{
+	struct net_device *olddev, *newdev;
+	struct tid_info *ti;
+	struct t3cdev *tdev;
+	u32 tid;
+	int update_tcb;
+	struct l2t_entry *e;
+	struct t3c_tid_entry *te;
+
+	olddev = old->neighbour->dev;
+	newdev = new->neighbour->dev;
+	if (!is_offloading(olddev))
+		return;
+	if (!is_offloading(newdev)) {
+		printk(KERN_WARNING "%s: Redirect to non-offload"
+		       "device ignored.\n", __FUNCTION__);
+		return;
+	}
+	tdev = T3CDEV(olddev);
+	BUG_ON(!tdev);
+	if (tdev != T3CDEV(newdev)) {
+		printk(KERN_WARNING "%s: Redirect to different "
+		       "offload device ignored.\n", __FUNCTION__);
+		return;
+	}
+
+	/* Add new L2T entry */
+	e = t3_l2t_get(tdev, new->neighbour, newdev);
+	if (!e) {
+		printk(KERN_ERR "%s: couldn't allocate new l2t entry!\n",
+		       __FUNCTION__);
+		return;
+	}
+
+	/* Walk tid table and notify clients of dst change. */
+	ti = &(T3C_DATA(tdev))->tid_maps;
+	for (tid = 0; tid < ti->ntids; tid++) {
+		te = lookup_tid(ti, tid);
+		BUG_ON(!te);
+		if (te->ctx && te->client && te->client->redirect) {
+			update_tcb = te->client->redirect(te->ctx, old, new, e);
+			if (update_tcb) {
+				l2t_hold(L2DATA(tdev), e);
+				set_l2t_ix(tdev, tid, e);
+			}
+		}
+	}
+	l2t_release(L2DATA(tdev), e);
+}
+
+/*
+ * Allocate a chunk of memory using kmalloc or, if that fails, vmalloc.
+ * The allocated memory is cleared.
+ */
+void *cxgb_alloc_mem(unsigned long size)
+{
+	void *p = kmalloc(size, GFP_KERNEL);
+
+	if (!p)
+		p = vmalloc(size);
+	if (p)
+		memset(p, 0, size);
+	return p;
+}
+
+/*
+ * Free memory allocated through t3_alloc_mem().
+ */
+void cxgb_free_mem(void *addr)
+{
+	unsigned long p = (unsigned long)addr;
+
+	if (p >= VMALLOC_START && p < VMALLOC_END)
+		vfree(addr);
+	else
+		kfree(addr);
+}
+
+/*
+ * Allocate and initialize the TID tables.  Returns 0 on success.
+ */
+static int init_tid_tabs(struct tid_info *t, unsigned int ntids,
+			 unsigned int natids, unsigned int nstids,
+			 unsigned int atid_base, unsigned int stid_base)
+{
+	unsigned long size = ntids * sizeof(*t->tid_tab) +
+	    natids * sizeof(*t->atid_tab) + nstids * sizeof(*t->stid_tab);
+
+	t->tid_tab = cxgb_alloc_mem(size);
+	if (!t->tid_tab)
+		return -ENOMEM;
+
+	t->stid_tab = (union listen_entry *)&t->tid_tab[ntids];
+	t->atid_tab = (union active_open_entry *)&t->stid_tab[nstids];
+	t->ntids = ntids;
+	t->nstids = nstids;
+	t->stid_base = stid_base;
+	t->sfree = NULL;
+	t->natids = natids;
+	t->atid_base = atid_base;
+	t->afree = NULL;
+	t->stids_in_use = t->atids_in_use = 0;
+	atomic_set(&t->tids_in_use, 0);
+	spin_lock_init(&t->stid_lock);
+	spin_lock_init(&t->atid_lock);
+
+	/*
+	 * Setup the free lists for stid_tab and atid_tab.
+	 */
+	if (nstids) {
+		while (--nstids)
+			t->stid_tab[nstids - 1].next = &t->stid_tab[nstids];
+		t->sfree = t->stid_tab;
+	}
+	if (natids) {
+		while (--natids)
+			t->atid_tab[natids - 1].next = &t->atid_tab[natids];
+		t->afree = t->atid_tab;
+	}
+	return 0;
+}
+
+static void free_tid_maps(struct tid_info *t)
+{
+	cxgb_free_mem(t->tid_tab);
+}
+
+static inline void add_adapter(struct adapter *adap)
+{
+	write_lock_bh(&adapter_list_lock);
+	list_add_tail(&adap->adapter_list, &adapter_list);
+	write_unlock_bh(&adapter_list_lock);
+}
+
+static inline void remove_adapter(struct adapter *adap)
+{
+	write_lock_bh(&adapter_list_lock);
+	list_del(&adap->adapter_list);
+	write_unlock_bh(&adapter_list_lock);
+}
+
+int cxgb3_offload_activate(struct adapter *adapter)
+{
+	struct t3cdev *dev = &adapter->tdev;
+	int natids, err;
+	struct t3c_data *t;
+	struct tid_range stid_range, tid_range;
+	struct mtutab mtutab;
+	unsigned int l2t_capacity;
+
+	t = kcalloc(1, sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	err = -EOPNOTSUPP;
+	if (dev->ctl(dev, GET_TX_MAX_CHUNK, &t->tx_max_chunk) < 0 ||
+	    dev->ctl(dev, GET_MAX_OUTSTANDING_WR, &t->max_wrs) < 0 ||
+	    dev->ctl(dev, GET_L2T_CAPACITY, &l2t_capacity) < 0 ||
+	    dev->ctl(dev, GET_MTUS, &mtutab) < 0 ||
+	    dev->ctl(dev, GET_TID_RANGE, &tid_range) < 0 ||
+	    dev->ctl(dev, GET_STID_RANGE, &stid_range) < 0)
+		goto out_free;
+
+	err = -ENOMEM;
+	L2DATA(dev) = t3_init_l2t(l2t_capacity);
+	if (!L2DATA(dev))
+		goto out_free;
+
+	natids = min(tid_range.num / 2, MAX_ATIDS);
+	err = init_tid_tabs(&t->tid_maps, tid_range.num, natids,
+			    stid_range.num, ATID_BASE, stid_range.base);
+	if (err)
+		goto out_free_l2t;
+
+	t->mtus = mtutab.mtus;
+	t->nmtus = mtutab.size;
+
+	INIT_WORK(&t->tid_release_task, t3_process_tid_release_list);
+	spin_lock_init(&t->tid_release_lock);
+	INIT_LIST_HEAD(&t->list_node);
+	t->dev = dev;
+
+	T3C_DATA(dev) = t;
+	dev->recv = process_rx;
+	dev->neigh_update = t3_l2t_update;
+
+	/* Register netevent handler once */
+	if (list_empty(&adapter_list))
+		register_netevent_notifier(&nb);
+
+	add_adapter(adapter);
+	return 0;
+
+out_free_l2t:
+	t3_free_l2t(L2DATA(dev));
+	L2DATA(dev) = NULL;
+out_free:
+	kfree(t);
+	return err;
+}
+
+void cxgb3_offload_deactivate(struct adapter *adapter)
+{
+	struct t3cdev *tdev = &adapter->tdev;
+	struct t3c_data *t = T3C_DATA(tdev);
+
+	remove_adapter(adapter);
+	if (list_empty(&adapter_list))
+		unregister_netevent_notifier(&nb);
+
+	free_tid_maps(&t->tid_maps);
+	T3C_DATA(tdev) = NULL;
+	t3_free_l2t(L2DATA(tdev));
+	L2DATA(tdev) = NULL;
+	kfree(t);
+}
+
+static inline void register_tdev(struct t3cdev *tdev)
+{
+	static int unit;
+
+	mutex_lock(&cxgb3_db_lock);
+	snprintf(tdev->name, sizeof(tdev->name), "ofld_dev%d", unit++);
+	list_add_tail(&tdev->ofld_dev_list, &ofld_dev_list);
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+static inline void unregister_tdev(struct t3cdev *tdev)
+{
+	mutex_lock(&cxgb3_db_lock);
+	list_del(&tdev->ofld_dev_list);
+	mutex_unlock(&cxgb3_db_lock);
+}
+
+void __devinit cxgb3_adapter_ofld(struct adapter *adapter)
+{
+	struct t3cdev *tdev = &adapter->tdev;
+
+	INIT_LIST_HEAD(&tdev->ofld_dev_list);
+
+	cxgb3_set_dummy_ops(tdev);
+	tdev->send = t3_offload_tx;
+	tdev->ctl = cxgb_offload_ctl;
+	tdev->type = adapter->params.rev == 0 ? T3A : T3B;
+
+	register_tdev(tdev);
+}
+
+void __devexit cxgb3_adapter_unofld(struct adapter *adapter)
+{
+	struct t3cdev *tdev = &adapter->tdev;
+
+	tdev->recv = NULL;
+	tdev->neigh_update = NULL;
+
+	unregister_tdev(tdev);
+}
+
+void __init cxgb3_offload_init(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_CPL_CMDS; ++i)
+		cpl_handlers[i] = do_bad_cpl;
+
+	t3_register_cpl_handler(CPL_SMT_WRITE_RPL, do_smt_write_rpl);
+	t3_register_cpl_handler(CPL_L2T_WRITE_RPL, do_l2t_write_rpl);
+	t3_register_cpl_handler(CPL_PASS_OPEN_RPL, do_stid_rpl);
+	t3_register_cpl_handler(CPL_CLOSE_LISTSRV_RPL, do_stid_rpl);
+	t3_register_cpl_handler(CPL_PASS_ACCEPT_REQ, do_cr);
+	t3_register_cpl_handler(CPL_PASS_ESTABLISH, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_ABORT_RPL_RSS, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_ABORT_RPL, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_RX_URG_NOTIFY, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_RX_DATA, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_TX_DATA_ACK, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_TX_DMA_ACK, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_ACT_OPEN_RPL, do_act_open_rpl);
+	t3_register_cpl_handler(CPL_PEER_CLOSE, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_CLOSE_CON_RPL, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_ABORT_REQ_RSS, do_abort_req_rss);
+	t3_register_cpl_handler(CPL_ACT_ESTABLISH, do_act_establish);
+	t3_register_cpl_handler(CPL_SET_TCB_RPL, do_set_tcb_rpl);
+	t3_register_cpl_handler(CPL_RDMA_TERMINATE, do_term);
+	t3_register_cpl_handler(CPL_RDMA_EC_STATUS, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_TRACE_PKT, do_trace);
+	t3_register_cpl_handler(CPL_RX_DATA_DDP, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_RX_DDP_COMPLETE, do_hwtid_rpl);
+	t3_register_cpl_handler(CPL_ISCSI_HDR, do_hwtid_rpl);
+}
diff --git a/drivers/net/cxgb3/l2t.c b/drivers/net/cxgb3/l2t.c
new file mode 100755
index 0000000..9997138
--- /dev/null
+++ b/drivers/net/cxgb3/l2t.c
@@ -0,0 +1,450 @@
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
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/if.h>
+#include <linux/if_vlan.h>
+#include <linux/jhash.h>
+#include <net/neighbour.h>
+#include "common.h"
+#include "t3cdev.h"
+#include "cxgb3_defs.h"
+#include "l2t.h"
+#include "t3_cpl.h"
+#include "firmware_exports.h"
+
+#define VLAN_NONE 0xfff
+
+/*
+ * Module locking notes:  There is a RW lock protecting the L2 table as a
+ * whole plus a spinlock per L2T entry.  Entry lookups and allocations happen
+ * under the protection of the table lock, individual entry changes happen
+ * while holding that entry's spinlock.  The table lock nests outside the
+ * entry locks.  Allocations of new entries take the table lock as writers so
+ * no other lookups can happen while allocating new entries.  Entry updates
+ * take the table lock as readers so multiple entries can be updated in
+ * parallel.  An L2T entry can be dropped by decrementing its reference count
+ * and therefore can happen in parallel with entry allocation but no entry
+ * can change state or increment its ref count during allocation as both of
+ * these perform lookups.
+ */
+
+static inline unsigned int vlan_prio(const struct l2t_entry *e)
+{
+	return e->vlan >> 13;
+}
+
+static inline unsigned int arp_hash(u32 key, int ifindex,
+				    const struct l2t_data *d)
+{
+	return jhash_2words(key, ifindex, 0) & (d->nentries - 1);
+}
+
+static inline void neigh_replace(struct l2t_entry *e, struct neighbour *n)
+{
+	neigh_hold(n);
+	if (e->neigh)
+		neigh_release(e->neigh);
+	e->neigh = n;
+}
+
+/*
+ * Set up an L2T entry and send any packets waiting in the arp queue.  The
+ * supplied skb is used for the CPL_L2T_WRITE_REQ.  Must be called with the
+ * entry locked.
+ */
+static int setup_l2e_send_pending(struct t3cdev *dev, struct sk_buff *skb,
+				  struct l2t_entry *e)
+{
+	struct cpl_l2t_write_req *req;
+
+	if (!skb) {
+		skb = alloc_skb(sizeof(*req), GFP_ATOMIC);
+		if (!skb)
+			return -ENOMEM;
+	}
+
+	req = (struct cpl_l2t_write_req *)__skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_L2T_WRITE_REQ, e->idx));
+	req->params = htonl(V_L2T_W_IDX(e->idx) | V_L2T_W_IFF(e->smt_idx) |
+			    V_L2T_W_VLAN(e->vlan & VLAN_VID_MASK) |
+			    V_L2T_W_PRIO(vlan_prio(e)));
+	memcpy(e->dmac, e->neigh->ha, sizeof(e->dmac));
+	memcpy(req->dst_mac, e->dmac, sizeof(req->dst_mac));
+	skb->priority = CPL_PRIORITY_CONTROL;
+	cxgb3_ofld_send(dev, skb);
+	while (e->arpq_head) {
+		skb = e->arpq_head;
+		e->arpq_head = skb->next;
+		skb->next = NULL;
+		cxgb3_ofld_send(dev, skb);
+	}
+	e->arpq_tail = NULL;
+	e->state = L2T_STATE_VALID;
+
+	return 0;
+}
+
+/*
+ * Add a packet to the an L2T entry's queue of packets awaiting resolution.
+ * Must be called with the entry's lock held.
+ */
+static inline void arpq_enqueue(struct l2t_entry *e, struct sk_buff *skb)
+{
+	skb->next = NULL;
+	if (e->arpq_head)
+		e->arpq_tail->next = skb;
+	else
+		e->arpq_head = skb;
+	e->arpq_tail = skb;
+}
+
+int t3_l2t_send_slow(struct t3cdev *dev, struct sk_buff *skb,
+		     struct l2t_entry *e)
+{
+again:
+	switch (e->state) {
+	case L2T_STATE_STALE:	/* entry is stale, kick off revalidation */
+		neigh_event_send(e->neigh, NULL);
+		spin_lock_bh(&e->lock);
+		if (e->state == L2T_STATE_STALE)
+			e->state = L2T_STATE_VALID;
+		spin_unlock_bh(&e->lock);
+	case L2T_STATE_VALID:	/* fast-path, send the packet on */
+		return cxgb3_ofld_send(dev, skb);
+	case L2T_STATE_RESOLVING:
+		spin_lock_bh(&e->lock);
+		if (e->state != L2T_STATE_RESOLVING) {
+			/* ARP already completed */
+			spin_unlock_bh(&e->lock);
+			goto again;
+		}
+		arpq_enqueue(e, skb);
+		spin_unlock_bh(&e->lock);
+
+		/*
+		 * Only the first packet added to the arpq should kick off
+		 * resolution.  However, because the alloc_skb below can fail,
+		 * we allow each packet added to the arpq to retry resolution
+		 * as a way of recovering from transient memory exhaustion.
+		 * A better way would be to use a work request to retry L2T
+		 * entries when there's no memory.
+		 */
+		if (!neigh_event_send(e->neigh, NULL)) {
+			skb = alloc_skb(sizeof(struct cpl_l2t_write_req),
+					GFP_ATOMIC);
+			if (!skb)
+				break;
+
+			spin_lock_bh(&e->lock);
+			if (e->arpq_head)
+				setup_l2e_send_pending(dev, skb, e);
+			else	/* we lost the race */
+				__kfree_skb(skb);
+			spin_unlock_bh(&e->lock);
+		}
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(t3_l2t_send_slow);
+
+void t3_l2t_send_event(struct t3cdev *dev, struct l2t_entry *e)
+{
+again:
+	switch (e->state) {
+	case L2T_STATE_STALE:	/* entry is stale, kick off revalidation */
+		neigh_event_send(e->neigh, NULL);
+		spin_lock_bh(&e->lock);
+		if (e->state == L2T_STATE_STALE) {
+			e->state = L2T_STATE_VALID;
+		}
+		spin_unlock_bh(&e->lock);
+		return;
+	case L2T_STATE_VALID:	/* fast-path, send the packet on */
+		return;
+	case L2T_STATE_RESOLVING:
+		spin_lock_bh(&e->lock);
+		if (e->state != L2T_STATE_RESOLVING) {
+			/* ARP already completed */
+			spin_unlock_bh(&e->lock);
+			goto again;
+		}
+		spin_unlock_bh(&e->lock);
+
+		/*
+		 * Only the first packet added to the arpq should kick off
+		 * resolution.  However, because the alloc_skb below can fail,
+		 * we allow each packet added to the arpq to retry resolution
+		 * as a way of recovering from transient memory exhaustion.
+		 * A better way would be to use a work request to retry L2T
+		 * entries when there's no memory.
+		 */
+		neigh_event_send(e->neigh, NULL);
+	}
+	return;
+}
+
+EXPORT_SYMBOL(t3_l2t_send_event);
+
+/*
+ * Allocate a free L2T entry.  Must be called with l2t_data.lock held.
+ */
+static struct l2t_entry *alloc_l2e(struct l2t_data *d)
+{
+	struct l2t_entry *end, *e, **p;
+
+	if (!atomic_read(&d->nfree))
+		return NULL;
+
+	/* there's definitely a free entry */
+	for (e = d->rover, end = &d->l2tab[d->nentries]; e != end; ++e)
+		if (atomic_read(&e->refcnt) == 0)
+			goto found;
+
+	for (e = &d->l2tab[1]; atomic_read(&e->refcnt); ++e) ;
+found:
+	d->rover = e + 1;
+	atomic_dec(&d->nfree);
+
+	/*
+	 * The entry we found may be an inactive entry that is
+	 * presently in the hash table.  We need to remove it.
+	 */
+	if (e->state != L2T_STATE_UNUSED) {
+		int hash = arp_hash(e->addr, e->ifindex, d);
+
+		for (p = &d->l2tab[hash].first; *p; p = &(*p)->next)
+			if (*p == e) {
+				*p = e->next;
+				break;
+			}
+		e->state = L2T_STATE_UNUSED;
+	}
+	return e;
+}
+
+/*
+ * Called when an L2T entry has no more users.  The entry is left in the hash
+ * table since it is likely to be reused but we also bump nfree to indicate
+ * that the entry can be reallocated for a different neighbor.  We also drop
+ * the existing neighbor reference in case the neighbor is going away and is
+ * waiting on our reference.
+ *
+ * Because entries can be reallocated to other neighbors once their ref count
+ * drops to 0 we need to take the entry's lock to avoid races with a new
+ * incarnation.
+ */
+void t3_l2e_free(struct l2t_data *d, struct l2t_entry *e)
+{
+	spin_lock_bh(&e->lock);
+	if (atomic_read(&e->refcnt) == 0) {	/* hasn't been recycled */
+		if (e->neigh) {
+			neigh_release(e->neigh);
+			e->neigh = NULL;
+		}
+	}
+	spin_unlock_bh(&e->lock);
+	atomic_inc(&d->nfree);
+}
+
+EXPORT_SYMBOL(t3_l2e_free);
+
+/*
+ * Update an L2T entry that was previously used for the same next hop as neigh.
+ * Must be called with softirqs disabled.
+ */
+static inline void reuse_entry(struct l2t_entry *e, struct neighbour *neigh)
+{
+	unsigned int nud_state;
+
+	spin_lock(&e->lock);	/* avoid race with t3_l2t_free */
+
+	if (neigh != e->neigh)
+		neigh_replace(e, neigh);
+	nud_state = neigh->nud_state;
+	if (memcmp(e->dmac, neigh->ha, sizeof(e->dmac)) ||
+	    !(nud_state & NUD_VALID))
+		e->state = L2T_STATE_RESOLVING;
+	else if (nud_state & NUD_CONNECTED)
+		e->state = L2T_STATE_VALID;
+	else
+		e->state = L2T_STATE_STALE;
+	spin_unlock(&e->lock);
+}
+
+struct l2t_entry *t3_l2t_get(struct t3cdev *cdev, struct neighbour *neigh,
+			     struct net_device *dev)
+{
+	struct l2t_entry *e;
+	struct l2t_data *d = L2DATA(cdev);
+	u32 addr = *(u32 *) neigh->primary_key;
+	int ifidx = neigh->dev->ifindex;
+	int hash = arp_hash(addr, ifidx, d);
+	struct port_info *p = netdev_priv(dev);
+	int smt_idx = p->port_id;
+
+	write_lock_bh(&d->lock);
+	for (e = d->l2tab[hash].first; e; e = e->next)
+		if (e->addr == addr && e->ifindex == ifidx &&
+		    e->smt_idx == smt_idx) {
+			l2t_hold(d, e);
+			if (atomic_read(&e->refcnt) == 1)
+				reuse_entry(e, neigh);
+			goto done;
+		}
+
+	/* Need to allocate a new entry */
+	e = alloc_l2e(d);
+	if (e) {
+		spin_lock(&e->lock);	/* avoid race with t3_l2t_free */
+		e->next = d->l2tab[hash].first;
+		d->l2tab[hash].first = e;
+		e->state = L2T_STATE_RESOLVING;
+		e->addr = addr;
+		e->ifindex = ifidx;
+		e->smt_idx = smt_idx;
+		atomic_set(&e->refcnt, 1);
+		neigh_replace(e, neigh);
+		if (neigh->dev->priv_flags & IFF_802_1Q_VLAN)
+			e->vlan = VLAN_DEV_INFO(neigh->dev)->vlan_id;
+		else
+			e->vlan = VLAN_NONE;
+		spin_unlock(&e->lock);
+	}
+done:
+	write_unlock_bh(&d->lock);
+	return e;
+}
+
+EXPORT_SYMBOL(t3_l2t_get);
+
+/*
+ * Called when address resolution fails for an L2T entry to handle packets
+ * on the arpq head.  If a packet specifies a failure handler it is invoked,
+ * otherwise the packets is sent to the offload device.
+ *
+ * XXX: maybe we should abandon the latter behavior and just require a failure
+ * handler.
+ */
+static void handle_failed_resolution(struct t3cdev *dev, struct sk_buff *arpq)
+{
+	while (arpq) {
+		struct sk_buff *skb = arpq;
+		struct l2t_skb_cb *cb = L2T_SKB_CB(skb);
+
+		arpq = skb->next;
+		skb->next = NULL;
+		if (cb->arp_failure_handler)
+			cb->arp_failure_handler(dev, skb);
+		else
+			cxgb3_ofld_send(dev, skb);
+	}
+}
+
+/*
+ * Called when the host's ARP layer makes a change to some entry that is
+ * loaded into the HW L2 table.
+ */
+void t3_l2t_update(struct t3cdev *dev, struct neighbour *neigh)
+{
+	struct l2t_entry *e;
+	struct sk_buff *arpq = NULL;
+	struct l2t_data *d = L2DATA(dev);
+	u32 addr = *(u32 *) neigh->primary_key;
+	int ifidx = neigh->dev->ifindex;
+	int hash = arp_hash(addr, ifidx, d);
+
+	read_lock_bh(&d->lock);
+	for (e = d->l2tab[hash].first; e; e = e->next)
+		if (e->addr == addr && e->ifindex == ifidx) {
+			spin_lock(&e->lock);
+			goto found;
+		}
+	read_unlock_bh(&d->lock);
+	return;
+
+found:
+	read_unlock(&d->lock);
+	if (atomic_read(&e->refcnt)) {
+		if (neigh != e->neigh)
+			neigh_replace(e, neigh);
+
+		if (e->state == L2T_STATE_RESOLVING) {
+			if (neigh->nud_state & NUD_FAILED) {
+				arpq = e->arpq_head;
+				e->arpq_head = e->arpq_tail = NULL;
+			} else if (neigh_is_connected(neigh))
+				setup_l2e_send_pending(dev, NULL, e);
+		} else {
+			e->state = neigh_is_connected(neigh) ?
+			    L2T_STATE_VALID : L2T_STATE_STALE;
+			if (memcmp(e->dmac, neigh->ha, 6))
+				setup_l2e_send_pending(dev, NULL, e);
+		}
+	}
+	spin_unlock_bh(&e->lock);
+
+	if (arpq)
+		handle_failed_resolution(dev, arpq);
+}
+
+struct l2t_data *t3_init_l2t(unsigned int l2t_capacity)
+{
+	struct l2t_data *d;
+	int i, size = sizeof(*d) + l2t_capacity * sizeof(struct l2t_entry);
+
+	d = cxgb_alloc_mem(size);
+	if (!d)
+		return NULL;
+
+	d->nentries = l2t_capacity;
+	d->rover = &d->l2tab[1];	/* entry 0 is not used */
+	atomic_set(&d->nfree, l2t_capacity - 1);
+	rwlock_init(&d->lock);
+
+	for (i = 0; i < l2t_capacity; ++i) {
+		d->l2tab[i].idx = i;
+		d->l2tab[i].state = L2T_STATE_UNUSED;
+		spin_lock_init(&d->l2tab[i].lock);
+		atomic_set(&d->l2tab[i].refcnt, 0);
+	}
+	return d;
+}
+
+void t3_free_l2t(struct l2t_data *d)
+{
+	cxgb_free_mem(d);
+}
+
