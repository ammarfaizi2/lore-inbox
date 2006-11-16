Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWKPD67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWKPD67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031115AbWKPD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:58:58 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:41401 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1031110AbWKPD6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:58:48 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  04/13] Connection Manager
Date: Wed, 15 Nov 2006 21:58:47 -0600
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-Id: <20061116035847.22635.87333.stgit@dell3.ogc.int>
In-Reply-To: <20061116035826.22635.61230.stgit@dell3.ogc.int>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code implements the iWARP CM provider methods for the Chelsio driver.
The Chelsio ULLD is used to setup and teardown TCP connections, and the
T3 RDMA Core is used to move the connections in and out of RDMA mode.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/hw/cxgb3/iwch_cm.c | 2121 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/iwch_cm.h |  223 +++
 2 files changed, 2344 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
new file mode 100644
index 0000000..5f1954d
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
@@ -0,0 +1,2121 @@
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
+#include <asm/atomic.h>
+#include <asm/delay.h>
+
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/skbuff.h>
+#include <linux/timer.h>
+#include <linux/notifier.h>
+
+#include <net/neighbour.h>
+#include <net/netevent.h>
+#include <net/route.h>
+
+#include "cxgb3_offload.h"
+#include "iwch.h"
+#include "iwch_provider.h"
+#include "iwch_cm.h"
+
+char *states[] = {
+	"idle",
+	"listen",
+	"connecting",
+	"mpa_wait_req",
+	"mpa_req_sent",
+	"mpa_req_rcvd",
+	"mpa_rep_sent",
+	"fpdu_mode",
+	"aborting",
+	"closing",
+	"moribund",
+	"dead",
+	NULL,
+};
+
+static int ep_timeout_secs = 10;
+module_param(ep_timeout_secs, int, 0444);
+MODULE_PARM_DESC(ep_timeout_secs, "CM Endpoint operation timeout "
+				   "in seconds (default=10)");
+
+static int mpa_rev = 1;
+module_param(mpa_rev, int, 0444);
+MODULE_PARM_DESC(mpa_rev, "MPA Revision, 0 supports amso1100, "
+		 "1 is spec compliant. (default=1)");
+
+static int markers_enabled = 0;
+module_param(markers_enabled, int, 0444);
+MODULE_PARM_DESC(markers_enabled, "Enable MPA MARKERS (default(0)=disabled)");
+
+static int crc_enabled = 1;
+module_param(crc_enabled, int, 0444);
+MODULE_PARM_DESC(crc_enabled, "Enable MPA CRC (default(1)=enabled)");
+
+static int rcv_win = 512 * 1024;
+module_param(rcv_win, int, 0444);
+MODULE_PARM_DESC(rcv_win, "TCP receive window in bytes (default=512KB)");
+
+static int snd_win = 512 * 1024;
+module_param(snd_win, int, 0444);
+MODULE_PARM_DESC(snd_win, "TCP send window in bytes (default=512KB)");
+
+static unsigned int nocong = 1;
+module_param(nocong, uint, 0444);
+MODULE_PARM_DESC(nocong, "Turn off congestion control (default=1)");
+
+static void process_work(void *ctx);
+static struct workqueue_struct *workq;
+DECLARE_WORK(skb_work, process_work, NULL);
+
+static struct sk_buff_head rxq;
+static cxgb3_cpl_handler_func work_handlers[NUM_CPL_CMDS];
+
+static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp);
+static void ep_timeout(unsigned long arg);
+static void connect_reply_upcall(struct iwch_ep *ep, int status);
+
+static void start_ep_timer(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	if (timer_pending(&ep->timer)) {
+		PDBG("%s stopped / restarted timer ep %p\n", __FUNCTION__, ep);
+		del_timer_sync(&ep->timer);
+	} else
+		ep_atomic_inc(&ep->com.refcnt);
+	ep->timer.expires = jiffies + ep_timeout_secs * HZ;
+	ep->timer.data = (unsigned long)ep;
+	ep->timer.function = ep_timeout;
+	add_timer(&ep->timer);
+}
+
+static void stop_ep_timer(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	del_timer_sync(&ep->timer);
+	free_ep(&ep->com);
+}
+
+static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
+{
+	struct cpl_tid_release *req;
+
+	skb = get_skb(skb, sizeof *req, GFP_KERNEL);
+	if (!skb) {
+		return;
+	}
+	req = (struct cpl_tid_release *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_TID_RELEASE, hwtid));
+	skb->priority = CPL_PRIORITY_SETUP;
+	tdev->send(tdev, skb);
+	return;
+}
+
+static int migrate_tid(struct iwch_ep *ep)
+{
+	struct cpl_set_tcb_field *req;
+	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+
+#if 1 	/* XXX - Waiting for HW/FW Resolution on this... */
+	return 0;
+#endif
+
+	if (!skb) {
+		return -ENOMEM;
+	}
+	req = (struct cpl_set_tcb_field *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_T_MIGRATION);
+	req->mask = cpu_to_be64(1ULL << S_TCB_T_MIGRATION);
+	req->val = cpu_to_be64(1 << S_TCB_T_MIGRATION);
+
+	skb->priority = CPL_PRIORITY_DATA;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+int iwch_quiesce_tid(struct iwch_ep *ep)
+{
+	struct cpl_set_tcb_field *req;
+	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+
+	if (!skb) {
+		return -ENOMEM;
+	}
+	req = (struct cpl_set_tcb_field *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_RX_QUIESCE);
+	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
+	req->val = cpu_to_be64(1 << S_TCB_RX_QUIESCE);
+
+	skb->priority = CPL_PRIORITY_DATA;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+int iwch_resume_tid(struct iwch_ep *ep)
+{
+	struct cpl_set_tcb_field *req;
+	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+
+	if (!skb) {
+		return -ENOMEM;
+	}
+	req = (struct cpl_set_tcb_field *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_RX_QUIESCE);
+	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
+	req->val = 0;
+
+	skb->priority = CPL_PRIORITY_DATA;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static void set_emss(struct iwch_ep *ep, u16 opt)
+{
+	PDBG("%s ep %p opt %u\n", __FUNCTION__, ep, opt);
+	ep->emss = T3C_DATA(ep->com.tdev)->mtus[G_TCPOPT_MSS(opt)] - 40;
+	if (G_TCPOPT_TSTAMP(opt)) {
+		ep->emss -= 12;
+	}
+	if (ep->emss < 128)
+		ep->emss = 128;
+	PDBG("emss=%d\n", ep->emss);
+}
+
+static int state_comp_exch(struct iwch_ep_common *epc,
+			   enum iwch_ep_state comp, 
+			   enum iwch_ep_state exch)
+{
+        unsigned long flags;
+        int ret;
+
+        spin_lock_irqsave(&epc->lock, flags);
+        ret = (epc->state == comp);
+        if (ret)
+                epc->state = exch;
+        spin_unlock_irqrestore(&epc->lock, flags);
+        return ret;
+}
+
+static enum iwch_ep_state state_read(struct iwch_ep_common *epc)
+{
+	unsigned long flags;
+	enum iwch_ep_state state;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	state = epc->state;
+	spin_unlock_irqrestore(&epc->lock, flags);
+	return state;
+}
+
+static void state_set(struct iwch_ep_common *epc, enum iwch_ep_state new)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	PDBG("%s - %s -> %s\n", __FUNCTION__, states[epc->state], 
+		states[new]);
+	epc->state = new;
+	spin_unlock_irqrestore(&epc->lock, flags);
+	return;
+}
+
+static void *alloc_ep(int size, gfp_t gfp)
+{
+	struct iwch_ep_common *epc;
+
+	epc = kmalloc(size, gfp);
+	if (epc) {
+		memset(epc, 0, size);
+		atomic_set(&epc->refcnt, 1);
+		spin_lock_init(&epc->lock);
+		init_waitqueue_head(&epc->waitq);
+	}
+	PDBG("%s alloc ep %p\n", __FUNCTION__, epc);
+	return (void *) epc;
+}
+
+void __free_ep(struct iwch_ep_common *epc)
+{
+	PDBG("%s ep %p, &refcnt %p state %s, refcnt %d\n",
+	     __FUNCTION__, epc, &epc->refcnt,
+	     states[state_read(epc)], atomic_read(&epc->refcnt));
+
+	if (atomic_read(&epc->refcnt) == 1) {
+		goto out;
+	}
+	if (!atomic_dec_and_test(&epc->refcnt)) {
+		return;
+	}
+out:
+	PDBG("free ep %p\n", epc);
+	kfree(epc);
+}
+
+static void release_ep_resources(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+	state_set(&ep->com, DEAD);
+	cxgb3_remove_tid(ep->com.tdev, (void *)ep, ep->hwtid);
+	dst_release(ep->dst);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	if (ep->com.tdev->type == T3B)
+		release_tid(ep->com.tdev, ep->hwtid, NULL);
+	free_ep(&ep->com);
+}
+
+static void process_work(void *ctx)
+{
+	struct sk_buff *skb = NULL;
+	void *ep;
+	struct t3cdev *tdev;
+	int ret;
+
+	while ((skb = skb_dequeue(&rxq))) {
+		ep = *((void **) (skb->cb));
+		tdev = *((struct t3cdev **) (skb->cb + sizeof(void *)));
+		ret = work_handlers[G_OPCODE(ntohl(skb->csum))]
+							(tdev, skb, ep);
+		if (ret & CPL_RET_BUF_DONE)
+			kfree_skb(skb);
+
+		/* 
+		 * ep was referenced in sched(), and is freed here.
+		 */
+		free_ep(ep);
+	}
+}
+
+static int status2errno(int status)
+{
+	switch (status) {
+	case CPL_ERR_NONE:
+		return 0;
+	case CPL_ERR_CONN_RESET:
+		return -ECONNRESET;
+	case CPL_ERR_ARP_MISS:
+		return -EHOSTUNREACH;
+	case CPL_ERR_CONN_TIMEDOUT:
+		return -ETIMEDOUT;
+	case CPL_ERR_TCAM_FULL:
+		return -ENOMEM;
+	case CPL_ERR_CONN_EXIST:
+		return -EADDRINUSE;
+	default:
+		return -EIO;
+	}
+}
+
+/*
+ * Try and reuse skbs already allocated...
+ */
+static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp)
+{
+	if (skb) {
+		BUG_ON(skb_cloned(skb));
+		skb_trim(skb, 0);
+		skb_get(skb);
+	} else {
+		skb = alloc_skb(len, gfp);
+	}
+	return skb;
+}
+
+static struct rtable *find_route(struct t3cdev *dev,
+				 u32 local_ip, u32 peer_ip, u16 local_port,
+				 u16 peer_port, u8 tos)
+{
+	struct rtable *rt;
+	struct flowi fl = {
+		.oif = 0,
+		.nl_u = {
+			 .ip4_u = {
+				   .daddr = peer_ip,
+				   .saddr = local_ip,
+				   .tos = tos}
+			 },
+		.proto = IPPROTO_TCP,
+		.uli_u = {
+			  .ports = {
+				    .sport = local_port,
+				    .dport = peer_port}
+			  }
+	};
+
+	if (ip_route_output_flow(&rt, &fl, NULL, 0)) {
+		return NULL;
+	}
+	return rt;
+}
+
+static unsigned int find_best_mtu(const struct t3c_data *d, unsigned short mtu)
+{
+	int i = 0;
+
+	while (i < d->nmtus - 1 && d->mtus[i + 1] <= mtu)
+		++i;
+	return i;
+}
+
+static void arp_failure_discard(struct t3cdev *dev, struct sk_buff *skb)
+{
+	PDBG("%s t3cdev %p\n", __FUNCTION__, dev);
+	kfree_skb(skb);
+}
+
+/*
+ * Handle an ARP failure for an active open.   
+ */
+static void act_open_req_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
+{
+	printk(KERN_ERR MOD "ARP failure duing connect\n");
+	kfree_skb(skb);
+}
+
+/*
+ * Handle an ARP failure for a CPL_ABORT_REQ.  Change it into a no RST variant
+ * and send it along.
+ */
+static void abort_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_abort_req *req = cplhdr(skb);
+
+	PDBG("%s t3cdev %p\n", __FUNCTION__, dev);
+	req->cmd = CPL_ABORT_NO_RST;
+	cxgb3_ofld_send(dev, skb);
+}
+
+static int send_halfclose(struct iwch_ep *ep, gfp_t gfp)
+{
+	struct cpl_close_con_req *req;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), gfp);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, arp_failure_discard);
+	req = (struct cpl_close_con_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_CLOSE_CON));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, ep->hwtid));
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_abort(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
+{
+	struct cpl_abort_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(skb, sizeof(*req), gfp);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, abort_arp_failure);
+	req = (struct cpl_abort_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_REQ));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ABORT_REQ, ep->hwtid));
+	req->cmd = CPL_ABORT_SEND_RST;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_connect(struct iwch_ep *ep)
+{
+	struct cpl_act_open_req *req;
+	struct sk_buff *skb;
+	u32 opt0h, opt0l, opt2;
+	unsigned int mtu_idx;
+	int wscale;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
+	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
+	wscale = compute_wscale(rcv_win);
+	opt0h = V_NAGLE(0) |
+	    V_NO_CONG(nocong) |
+	    V_KEEP_ALIVE(1) |
+	    F_TCAM_BYPASS |
+	    V_WND_SCALE(wscale) |
+	    V_MSS_IDX(mtu_idx) |
+	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
+	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
+	opt2 = V_FLAVORS_VALID(0) | V_CONG_CONTROL_FLAVOR(0);
+	skb->priority = CPL_PRIORITY_SETUP;
+	set_arp_failure_handler(skb, act_open_req_arp_failure);
+
+	req = (struct cpl_act_open_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, ep->atid));
+	req->local_port = ep->com.local_addr.sin_port;
+	req->peer_port = ep->com.remote_addr.sin_port;
+	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
+	req->peer_ip = ep->com.remote_addr.sin_addr.s_addr;
+	req->opt0h = htonl(opt0h);
+	req->opt0l = htonl(opt0l);
+	req->params = 0;
+	req->opt2 = htonl(opt2);
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static void send_mpa_req(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	int len;
+
+	PDBG("%s ep %p pd_len %d\n", __FUNCTION__, ep, ep->plen);
+
+	BUG_ON(skb_cloned(skb));
+
+	mpalen = sizeof(*mpa) + ep->plen;
+	if (skb->data + mpalen + sizeof(*req) > skb->end) {
+		kfree_skb(skb);
+		skb=alloc_skb(mpalen + sizeof(*req), GFP_KERNEL);
+		if (!skb) {
+			connect_reply_upcall(ep, -ENOMEM);
+			return;
+		}
+	}
+	skb_trim(skb, 0);
+	skb_reserve(skb, sizeof(*req));
+	skb_put(skb, mpalen);
+	skb->priority = CPL_PRIORITY_DATA;
+	mpa = (struct mpa_message *) skb->data;
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REQ, sizeof(mpa->key));
+	mpa->flags = (crc_enabled ? MPA_CRC : 0) | 
+		     (markers_enabled ? MPA_MARKERS : 0);
+	mpa->private_data_size = htons(ep->plen);
+	mpa->revision = mpa_rev;
+
+	if (ep->plen) {
+		memcpy(mpa->private_data, ep->mpa_pkt + sizeof(*mpa), ep->plen);
+	}
+
+	/* 
+	 * Reference the mpa skb.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.  
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	len = skb->len;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(len);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_IMM_ACK|F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	BUG_ON(ep->mpa_skb);
+	ep->mpa_skb = skb;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	start_ep_timer(ep);
+	state_set(&ep->com, MPA_REQ_SENT);
+	return;
+}
+
+static int send_mpa_reject(struct iwch_ep *ep, const void *pdata, u8 plen)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p plen %d\n", __FUNCTION__, ep, plen);
+
+	mpalen = sizeof(*mpa) + plen;
+
+	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - cannot alloc skb!\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb_reserve(skb, sizeof(*req));
+	mpa = (struct mpa_message *) skb_put(skb, mpalen);
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
+	mpa->flags = MPA_REJECT;
+	mpa->revision = mpa_rev;
+	mpa->private_data_size = htons(plen);
+	if (plen) {
+		memcpy(mpa->private_data, pdata, plen);
+	}
+
+	/* 
+	 * Reference the mpa skb again.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.  
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(mpalen);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_IMM_ACK|F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	BUG_ON(ep->mpa_skb);
+	ep->mpa_skb = skb;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_mpa_reply(struct iwch_ep *ep, const void *pdata, u8 plen)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	int len;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p plen %d\n", __FUNCTION__, ep, plen);
+
+	mpalen = sizeof(*mpa) + plen;
+
+	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - cannot alloc skb!\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	skb_reserve(skb, sizeof(*req));
+	mpa = (struct mpa_message *) skb_put(skb, mpalen);
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
+	mpa->flags = (ep->mpa_attr.crc_enabled ? MPA_CRC : 0) | 
+		     (markers_enabled ? MPA_MARKERS : 0);
+	mpa->revision = mpa_rev;
+	mpa->private_data_size = htons(plen);
+	if (plen) {
+		memcpy(mpa->private_data, pdata, plen);
+	}
+
+	/* 
+	 * Reference the mpa skb.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.  
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	len = skb->len;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(len);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_IMM_ACK|F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	ep->mpa_skb = skb;
+	state_set(&ep->com, MPA_REP_SENT);
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int act_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_act_establish *req = cplhdr(skb);
+	unsigned int tid = GET_TID(req);
+
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, tid);
+
+	dst_confirm(ep->dst);
+
+	/* setup the hwtid for this connection */
+	ep->hwtid = tid;
+	cxgb3_insert_tid(ep->com.tdev, &t3c_client, ep, tid);
+
+	ep->snd_seq = ntohl(req->snd_isn);
+
+	set_emss(ep, ntohs(req->tcp_opt));
+
+	/* dealloc the atid */
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+
+	/* start MPA negotiation */
+	send_mpa_req(ep, skb);
+
+	return 0;
+}
+
+static void abort_connection(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	PDBG("%s ep %p\n", __FILE__, ep);
+	state_set(&ep->com, ABORTING);
+	send_abort(ep, skb, GFP_KERNEL);
+}
+
+static void close_complete_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CLOSE;
+	if (ep->com.cm_id) {
+		PDBG("close complete delivered ep %p cm_id %p tid %d\n", 
+		     ep, ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void peer_close_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_DISCONNECT;
+	if (ep->com.cm_id) {
+		PDBG("peer close delivered ep %p cm_id %p tid %d\n", 
+		     ep, ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+}
+
+static void peer_abort_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CLOSE;
+	event.status = -ECONNRESET;
+	if (ep->com.cm_id) {
+		PDBG("abort delivered ep %p cm_id %p tid %d\n", ep,
+		     ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void connect_reply_upcall(struct iwch_ep *ep, int status)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p status %d\n", __FUNCTION__, ep, status);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CONNECT_REPLY;
+	event.status = status;
+	event.local_addr = ep->com.local_addr;
+	event.remote_addr = ep->com.remote_addr;
+
+	if ((status == 0) || (status == -ECONNREFUSED)) {
+		event.private_data_len = ep->plen;
+		event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
+	}
+	if (ep->com.cm_id) {
+		PDBG("%s ep %p tid %d status %d\n", __FUNCTION__, ep, 
+		     ep->hwtid, status);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+	if (status < 0) {
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void connect_request_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CONNECT_REQUEST;
+	event.local_addr = ep->com.local_addr;
+	event.remote_addr = ep->com.remote_addr;
+	event.private_data_len = ep->plen;
+	event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
+	event.provider_data = ep;
+	if (state_read(&ep->parent_ep->com) != DEAD)
+		ep->parent_ep->com.cm_id->event_handler(
+						ep->parent_ep->com.cm_id,
+						&event);
+	free_ep(&ep->parent_ep->com);
+	ep->parent_ep = NULL;
+}
+
+static void established_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_ESTABLISHED;
+	if (ep->com.cm_id) {
+		PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+}
+
+static int update_rx_credits(struct iwch_ep *ep, u32 credits)
+{
+	struct cpl_rx_data_ack *req;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p credits %u\n", __FUNCTION__, ep, credits);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "update_rx_credits - cannot alloc skb!\n");
+		return 0;
+	}
+
+	req = (struct cpl_rx_data_ack *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_RX_DATA_ACK, ep->hwtid));
+	req->credit_dack = htonl(V_RX_CREDITS(credits) | V_RX_FORCE_ACK(1));
+	skb->priority = CPL_PRIORITY_ACK;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return credits;
+}
+
+static void process_mpa_reply(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	struct mpa_message *mpa;
+	u16 plen;
+	struct iwch_qp_attributes attrs;
+	enum iwch_qp_attr_mask mask;
+	int err;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	/* 
+ 	 * Stop mpa timer.  If it expired, then the state is
+	 * CLOSING and we bail since ep_timeout already aborted 
+	 * the connection.
+	 */
+	stop_ep_timer(ep);
+	if (state_read(&ep->com) == CLOSING) {
+		return;
+	}
+	state_set(&ep->com, FPDU_MODE);
+
+	/* 
+	 * If we get more than the supported amount of private data
+	 * then we must fail this connection.
+	 */
+	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * copy the new data into our accumulation buffer.
+	 */
+	memcpy(&(ep->mpa_pkt[ep->mpa_pkt_len]), skb->data, skb->len);
+	ep->mpa_pkt_len += skb->len;
+
+	/* 
+	 * if we don't even have the mpa message, then bail. 
+	 */
+	if (ep->mpa_pkt_len < sizeof(*mpa)) {
+		return;
+	}
+	mpa = (struct mpa_message *) ep->mpa_pkt;
+
+	/* Validate MPA header. */
+	if (mpa->revision != mpa_rev) {
+		err = -EPROTO;
+		goto err;
+	}
+	if (memcmp(mpa->key, MPA_KEY_REP, sizeof(mpa->key))) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	plen = ntohs(mpa->private_data_size);
+
+	/* 
+	 * Fail if there's too much private data.
+	 */
+	if (plen > MPA_MAX_PRIVATE_DATA) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	/*
+	 * If plen does not account for pkt size
+	 */
+	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	ep->plen = (u8) plen;
+
+	/*
+	 * If we don't have all the pdata yet, then bail.
+	 * We'll continue process when more data arrives.
+	 */
+	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen)) {
+		return;
+	}
+
+	if (mpa->flags & MPA_REJECT) {
+		err = -ECONNREFUSED;
+		goto err;
+	}
+
+	/*
+	 * If we get here we have accumulated the entire mpa
+	 * start reply message including private data. And
+	 * the MPA header is valid.
+	 */
+
+	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
+	ep->mpa_attr.recv_marker_enabled = markers_enabled;
+	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
+	ep->mpa_attr.version = mpa_rev;
+	PDBG("%s - crc_enabled=%d, recv_marker_enabled=%d, "
+	     "xmit_marker_enabled=%d, version=%d\n", __FUNCTION__,
+	     ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
+	     ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
+
+	/* 
+	 * Quiesce the TID here.  The uP unquiesces the TID as
+	 * part of the rdma_init operation.
+	 */
+	err = migrate_tid(ep);
+	if (err) {
+		goto err;
+	}
+
+	attrs.mpa_attr = ep->mpa_attr;
+	attrs.max_ird = ep->ird;
+	attrs.max_ord = ep->ord;
+	attrs.llp_stream_handle = ep;
+	attrs.next_state = IWCH_QP_STATE_RTS;
+
+	mask = IWCH_QP_ATTR_NEXT_STATE |
+	    IWCH_QP_ATTR_LLP_STREAM_HANDLE | IWCH_QP_ATTR_MPA_ATTR |
+	    IWCH_QP_ATTR_MAX_IRD | IWCH_QP_ATTR_MAX_ORD;
+
+	/* bind QP and TID with INIT_WR */
+	err = iwch_modify_qp(ep->com.qp->rhp,
+			     ep->com.qp, mask, &attrs, 1);
+	if (!err) {
+		goto out;
+	}
+err:
+	abort_connection(ep, skb);
+out:
+	udelay(9000);
+	connect_reply_upcall(ep, err);
+	return;
+}
+
+static void process_mpa_request(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	struct mpa_message *mpa;
+	u16 plen;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	/* 
+ 	 * Stop mpa timer.  If it expired, then the state is
+	 * CLOSING and we bail since ep_timeout already aborted 
+	 * the connection.
+	 */
+	stop_ep_timer(ep);
+	if (state_read(&ep->com) == CLOSING) {
+		return;
+	}
+
+	/* 
+	 * If we get more than the supported amount of private data
+	 * then we must fail this connection.
+	 */
+	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
+		abort_connection(ep, skb);
+		return;
+	}
+
+	PDBG("%s enter (%s line %u)\n", __FUNCTION__, __FILE__, __LINE__);
+
+	/*
+	 * Copy the new data into our accumulation buffer.
+	 */
+	memcpy(&(ep->mpa_pkt[ep->mpa_pkt_len]), skb->data, skb->len);
+	ep->mpa_pkt_len += skb->len;
+
+	/* 
+	 * If we don't even have the mpa message, then bail. 
+	 * We'll continue process when more data arrives.
+	 */
+	if (ep->mpa_pkt_len < sizeof(*mpa)) {
+		return;
+	}
+	PDBG("%s enter (%s line %u)\n", __FUNCTION__, __FILE__, __LINE__);
+	mpa = (struct mpa_message *) ep->mpa_pkt;
+
+	/* 
+	 * Validate MPA Header.
+	 */
+	if (mpa->revision != mpa_rev) {
+		abort_connection(ep, skb);
+		return;
+	}
+
+	if (memcmp(mpa->key, MPA_KEY_REQ, sizeof(mpa->key))) {
+		abort_connection(ep, skb);
+		return;
+	}
+
+	plen = ntohs(mpa->private_data_size);
+
+	/* 
+	 * Fail if there's too much private data.
+	 */
+	if (plen > MPA_MAX_PRIVATE_DATA) {
+		abort_connection(ep, skb);
+		return;
+	}
+
+	/*
+	 * If plen does not account for pkt size
+	 */
+	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
+		abort_connection(ep, skb);
+		return;
+	}
+	ep->plen = (u8) plen;
+
+	/*
+	 * If we don't have all the pdata yet, then bail.
+	 */
+	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen)) {
+		return;
+	}
+
+	/*
+	 * If we get here we have accumulated the entire mpa
+	 * start reply message including private data.
+	 */
+	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
+	ep->mpa_attr.recv_marker_enabled = markers_enabled;
+	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
+	ep->mpa_attr.version = mpa_rev;
+	PDBG("%s - crc_enabled=%d, recv_marker_enabled=%d, "
+	     "xmit_marker_enabled=%d, version=%d\n", __FUNCTION__,
+	     ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
+	     ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
+
+	state_set(&ep->com, MPA_REQ_RCVD);
+
+	/* drive upcall */
+	connect_request_upcall(ep);
+	return;
+}
+
+static int rx_data(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_rx_data *hdr = cplhdr(skb);
+	unsigned int dlen = ntohs(hdr->len);
+
+	PDBG("%s ep %p dlen %u\n", __FUNCTION__, ep, dlen);
+
+	skb_pull(skb, sizeof(*hdr));
+	skb_trim(skb, dlen);
+
+	switch (state_read(&ep->com)) {
+	case MPA_REQ_SENT:
+		process_mpa_reply(ep, skb);
+		break;
+	case MPA_REQ_WAIT:
+		process_mpa_request(ep, skb);
+		break;
+	case MPA_REP_SENT:
+		break;
+	default:
+		printk(KERN_ERR MOD "%s Unexpected streaming data."
+		       " ep %p state %d tid %d\n",
+		       __FUNCTION__, ep, state_read(&ep->com), ep->hwtid);
+
+		/* 
+	 	 * The ep will timeout and inform the ULP of the failure.
+		 * See ep_timeout().
+	 	 */
+		break;
+	}
+
+	/* update RX credits */
+	update_rx_credits(ep, dlen);
+
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * Upcall from the adapter indicating data has been transmitted.
+ * For us its just the single MPA request or reply.  We can now free
+ * the skb holding the mpa message.
+ */
+static int tx_ack(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_wr_ack *hdr = cplhdr(skb);
+	unsigned int credits = ntohs(hdr->credits);
+	enum iwch_qp_attr_mask  mask;
+
+	PDBG("%s ep %p credits %u\n", __FUNCTION__, ep, credits);
+
+	if (credits == 0) {
+		return CPL_RET_BUF_DONE;
+	}
+	BUG_ON(credits != 1);
+	BUG_ON(ep->mpa_skb == NULL);
+	kfree_skb(ep->mpa_skb);
+	ep->mpa_skb = NULL;
+	dst_confirm(ep->dst);
+	if (state_read(&ep->com) == MPA_REP_SENT) {
+		struct iwch_qp_attributes attrs;
+
+		/* bind QP to EP and move to RTS */
+		attrs.mpa_attr = ep->mpa_attr;
+		attrs.max_ird = ep->ord;
+		attrs.max_ord = ep->ord;
+		attrs.llp_stream_handle = ep;
+		attrs.next_state = IWCH_QP_STATE_RTS;
+
+		/* bind QP and TID with INIT_WR */
+		mask = IWCH_QP_ATTR_NEXT_STATE |
+				     IWCH_QP_ATTR_LLP_STREAM_HANDLE | 
+				     IWCH_QP_ATTR_MPA_ATTR |
+				     IWCH_QP_ATTR_MAX_IRD |
+				     IWCH_QP_ATTR_MAX_ORD;
+
+		ep->com.rpl_err = iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, mask, &attrs, 1);
+
+		if (!ep->com.rpl_err) {
+			state_set(&ep->com, FPDU_MODE);
+			established_upcall(ep);
+		}
+
+		ep->com.rpl_done = 1;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static int abort_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	close_complete_upcall(ep);
+	release_ep_resources(ep);
+	return CPL_RET_BUF_DONE;
+}
+
+static int act_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_act_open_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	dst_release(ep->dst);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+	connect_reply_upcall(ep, status2errno(rpl->status));
+	free_ep(&ep->com);
+	return CPL_RET_BUF_DONE;
+}
+
+static int listen_start(struct iwch_listen_ep *ep)
+{
+	struct sk_buff *skb;
+	struct cpl_pass_open_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "t3c_listen_start failed to alloc skb!\n");
+		return -ENOMEM;
+	}
+
+	req = (struct cpl_pass_open_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_PASS_OPEN_REQ, ep->stid));
+	req->local_port = ep->com.local_addr.sin_port;
+	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
+	req->peer_port = 0;
+	req->peer_ip = 0;
+	req->peer_netmask = 0;
+	req->opt0h = htonl(F_DELACK | F_TCAM_BYPASS);
+	req->opt0l = htonl(V_RCV_BUFSIZ(rcv_win>>10));
+	req->opt1 = htonl(V_CONN_POLICY(CPL_CONN_POLICY_ASK));
+
+	skb->priority = 1;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static int pass_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_listen_ep *ep = ctx;
+	struct cpl_pass_open_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p status %d error %d\n", __FUNCTION__, ep, 
+	     rpl->status, status2errno(rpl->status));
+	ep->com.rpl_err = status2errno(rpl->status);
+	ep->com.rpl_done = 1;
+	wake_up(&ep->com.waitq);
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int listen_stop(struct iwch_listen_ep *ep)
+{
+	struct sk_buff *skb;
+	struct cpl_close_listserv_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	req = (struct cpl_close_listserv_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_LISTSRV_REQ, ep->stid));
+	skb->priority = 1;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static int close_listsrv_rpl(struct t3cdev *tdev, struct sk_buff *skb,
+			     void *ctx)
+{
+	struct iwch_listen_ep *ep = ctx;
+	struct cpl_close_listserv_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->com.rpl_err = status2errno(rpl->status);
+	ep->com.rpl_done = 1;
+	wake_up(&ep->com.waitq);
+	return CPL_RET_BUF_DONE;
+}
+
+static void accept_cr(struct iwch_ep *ep, u32 peer_ip, struct sk_buff *skb)
+{
+	struct cpl_pass_accept_rpl *rpl;
+	unsigned int mtu_idx;
+	u32 opt0h, opt0l, opt2;
+	int wscale;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	BUG_ON(skb_cloned(skb));
+	skb_trim(skb, sizeof(*rpl));
+	skb_get(skb);
+	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
+	wscale = compute_wscale(rcv_win);
+	opt0h = V_NAGLE(0) |
+	    V_NO_CONG(nocong) |
+	    V_KEEP_ALIVE(1) |
+	    F_TCAM_BYPASS |
+	    V_WND_SCALE(wscale) |
+	    V_MSS_IDX(mtu_idx) |
+	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
+	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
+	opt2 = V_FLAVORS_VALID(0) | V_CONG_CONTROL_FLAVOR(0);
+
+	rpl = cplhdr(skb);
+	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL, ep->hwtid));
+	rpl->peer_ip = peer_ip;
+	rpl->opt0h = htonl(opt0h);
+	rpl->opt0l_status = htonl(opt0l | CPL_PASS_OPEN_ACCEPT);
+	rpl->opt2 = htonl(opt2);
+	rpl->rsvd = rpl->opt2;	/* workaround for HW bug */
+	skb->priority = CPL_PRIORITY_SETUP;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+
+	return;
+}
+
+static void reject_cr(struct t3cdev *tdev, u32 hwtid, u32 peer_ip,
+		      struct sk_buff *skb)
+{
+	PDBG("%s t3cdev %p tid %u peer_ip %x\n", __FUNCTION__, tdev, hwtid, 
+	     peer_ip);
+	BUG_ON(skb_cloned(skb));
+	skb_trim(skb, sizeof(struct cpl_tid_release));
+	skb_get(skb);
+
+	if (tdev->type == T3B)
+		release_tid(tdev, hwtid, skb);
+	else {
+		struct cpl_pass_accept_rpl *rpl;
+
+		rpl = cplhdr(skb);
+		skb->priority = CPL_PRIORITY_SETUP;
+		rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+		OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL, 
+						      hwtid));
+		rpl->peer_ip = peer_ip;
+		rpl->opt0h = htonl(F_TCAM_BYPASS);
+		rpl->opt0l_status = htonl(CPL_PASS_OPEN_REJECT);
+		rpl->opt2 = 0;
+		rpl->rsvd = rpl->opt2;
+		tdev->send(tdev, skb);
+	}
+}
+
+static int pass_accept_req(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *child_ep, *parent_ep = ctx;
+	struct cpl_pass_accept_req *req = cplhdr(skb);
+	unsigned int hwtid = GET_TID(req);
+	struct dst_entry *dst;
+	struct l2t_entry *l2t;
+	struct rtable *rt;
+	struct iff_mac tim;
+
+	PDBG("%s parent ep %p tid %u\n", __FUNCTION__, parent_ep, hwtid);
+
+	if (state_read(&parent_ep->com) != LISTEN) {
+		printk(KERN_ERR "%s - listening ep not in LISTEN\n", 
+		       __FUNCTION__);
+		goto reject;
+	}
+
+	/*
+	 * Find the netdev for this connection request.
+	 */
+	tim.mac_addr = req->dst_mac;
+	tim.vlan_tag = ntohs(req->vlan_tag);
+	if (tdev->ctl(tdev, GET_IFF_FROM_MAC, &tim) < 0 || !tim.dev) {
+		printk(KERN_ERR 
+			"%s bad dst mac %02x %02x %02x %02x %02x %02x\n",
+			__FUNCTION__,
+			req->dst_mac[0],
+			req->dst_mac[1],
+			req->dst_mac[2],
+			req->dst_mac[3],
+			req->dst_mac[4],
+			req->dst_mac[5]);
+		goto reject;
+	}
+
+	/* Find output route */
+	rt = find_route(tdev,
+			req->local_ip,
+			req->peer_ip,
+			req->local_port,
+			req->peer_port, G_PASS_OPEN_TOS(ntohl(req->tos_tid)));
+	if (!rt) {
+		printk(KERN_ERR MOD "%s - failed to find dst entry!\n",
+		       __FUNCTION__);
+		goto reject;
+	}
+	dst = &rt->u.dst;
+	l2t = t3_l2t_get(tdev, dst->neighbour, dst->neighbour->dev->if_port);
+	if (!l2t) {
+		printk(KERN_ERR MOD "%s - failed to allocate l2t entry!\n",
+		       __FUNCTION__);
+		dst_release(dst);
+		goto reject;
+	}
+	child_ep = alloc_ep(sizeof(*child_ep), GFP_KERNEL);
+	if (!child_ep) {
+		printk(KERN_ERR MOD "%s - failed to allocate ep entry!\n",
+		       __FUNCTION__);
+		l2t_release(L2DATA(tdev), l2t);
+		dst_release(dst);
+		goto reject;
+	}
+	state_set(&child_ep->com, CONNECTING);
+	child_ep->com.tdev = tdev;
+	child_ep->com.cm_id = NULL;
+	child_ep->com.local_addr.sin_family = PF_INET;
+	child_ep->com.local_addr.sin_port = req->local_port;
+	child_ep->com.local_addr.sin_addr.s_addr = req->local_ip;
+	child_ep->com.remote_addr.sin_family = PF_INET;
+	child_ep->com.remote_addr.sin_port = req->peer_port;
+	child_ep->com.remote_addr.sin_addr.s_addr = req->peer_ip;
+	ep_atomic_inc(&parent_ep->com.refcnt);
+	child_ep->parent_ep = parent_ep;
+	child_ep->tos = G_PASS_OPEN_TOS(ntohl(req->tos_tid));
+	child_ep->l2t = l2t;
+	child_ep->dst = dst;
+	child_ep->hwtid = hwtid;
+	init_timer(&child_ep->timer);
+	cxgb3_insert_tid(tdev, &t3c_client, child_ep, hwtid);
+	accept_cr(child_ep, req->peer_ip, skb);
+	goto out;
+reject:
+	reject_cr(tdev, hwtid, req->peer_ip, skb);
+out:
+	return CPL_RET_BUF_DONE;
+}
+
+static int pass_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_pass_establish *req = cplhdr(skb);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->snd_seq = ntohl(req->snd_isn);
+
+	set_emss(ep, ntohs(req->tcp_opt));
+
+	dst_confirm(ep->dst);
+	state_set(&ep->com, MPA_REQ_WAIT);
+	start_ep_timer(ep);
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int peer_close(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct iwch_qp_attributes attrs;
+	int ret;
+	int abort = 0;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	dst_confirm(ep->dst);
+	switch (state_read(&ep->com)) {
+	case MPA_REQ_WAIT:
+		state_set(&ep->com, CLOSING);
+		break;
+	case MPA_REQ_SENT:
+		state_set(&ep->com, CLOSING);
+		connect_reply_upcall(ep, -ECONNRESET);
+		break;
+	case MPA_REQ_RCVD:
+
+		/* 
+		 * We're gonna mark this puppy DEAD, but keep
+		 * the reference on it until the ULP accepts or
+		 * rejects the CR.
+		 */
+		state_set(&ep->com, CLOSING);
+		ep_atomic_inc(&ep->com.refcnt);
+		break;
+	case MPA_REP_SENT:
+		state_set(&ep->com, CLOSING);
+		ep->com.rpl_done = 1;
+		ep->com.rpl_err = -ECONNRESET;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+		break;
+	case FPDU_MODE:
+		state_set(&ep->com, CLOSING);
+		peer_close_upcall(ep);
+		attrs.next_state = IWCH_QP_STATE_CLOSING;
+		ret = iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				     &attrs, 1);
+		if (ret) {
+			printk(KERN_ERR MOD "%s - qp <- closing err!\n",
+			       __FUNCTION__);
+			abort = 1;
+		}
+		break;
+	case ABORTING:
+		goto out;
+	case CLOSING:
+		start_ep_timer(ep);
+		state_set(&ep->com, MORIBUND);
+		goto out;
+	case MORIBUND:
+		stop_ep_timer(ep);
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_IDLE;
+			iwch_modify_qp(ep->com.qp->rhp,
+				       ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				       &attrs, 1);
+		}
+		close_complete_upcall(ep);
+		release_ep_resources(ep);
+		goto out;
+	case DEAD:
+		goto out;
+	default:
+		BUG_ON(1);
+	}
+	iwch_ep_disconnect(ep, abort, GFP_KERNEL);	
+out:
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * Returns whether an ABORT_REQ_RSS message is a negative advice.
+ */
+static inline int is_neg_adv_abort(unsigned int status)
+{
+        return status == CPL_ERR_RTX_NEG_ADVICE ||
+               status == CPL_ERR_PERSIST_NEG_ADVICE;
+}
+
+static int peer_abort(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct cpl_abort_req_rss *req = cplhdr(skb);
+	struct iwch_ep *ep = ctx;
+	struct cpl_abort_rpl *rpl;
+	struct sk_buff *rpl_skb;
+	struct iwch_qp_attributes attrs;
+	int ret;
+	int state;
+
+	if (is_neg_adv_abort(req->status)) {
+		PDBG("%s neg_adv_abort ep %p tid %d\n", __FUNCTION__, ep, 
+		     ep->hwtid);
+		t3_l2t_send_event(ep->com.tdev, ep->l2t);
+		return CPL_RET_BUF_DONE;
+	}
+
+	state = state_read(&ep->com);
+	PDBG("%s ep %p state %u\n", __FUNCTION__, ep, state);
+	switch (state) {
+	case CONNECTING:
+		break;
+	case MPA_REQ_WAIT:
+		break;
+	case MPA_REQ_SENT:
+		connect_reply_upcall(ep, -ECONNRESET);
+		break;
+	case MPA_REP_SENT:
+		ep->com.rpl_done = 1;
+		ep->com.rpl_err = -ECONNRESET;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+		break;
+	case MPA_REQ_RCVD:
+	
+		/* 
+		 * We're gonna mark this puppy DEAD, but keep
+		 * the reference on it until the ULP accepts or
+		 * rejects the CR.
+		 */
+		ep_atomic_inc(&ep->com.refcnt);
+		break;
+	case MORIBUND:
+		stop_ep_timer(ep);
+	case FPDU_MODE:
+	case CLOSING:
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_ERROR;
+			ret = iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				     &attrs, 1);
+			if (ret) {
+				printk(KERN_ERR MOD 
+				       "%s - qp <- error failed!\n",
+				       __FUNCTION__);
+			}
+		}
+		peer_abort_upcall(ep);
+		break;
+	case ABORTING:
+		break;
+	case DEAD:
+		PDBG("%s PEER_ABORT IN DEAD STATE!!!!\n", __FUNCTION__);
+		return CPL_RET_BUF_DONE;
+	default:
+		BUG_ON(1);
+		break;
+	}
+	dst_confirm(ep->dst);
+	
+	rpl_skb = get_skb(skb, sizeof(*rpl), GFP_KERNEL);
+	if (!rpl_skb) {
+		printk(KERN_ERR MOD "%s - cannot allocate skb!\n",
+		       __FUNCTION__);
+		dst_release(ep->dst);
+		l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+		free_ep(&ep->com);
+		return CPL_RET_BUF_DONE;
+	}
+	rpl_skb->priority = CPL_PRIORITY_DATA;
+	rpl = (struct cpl_abort_rpl *) skb_put(rpl_skb, sizeof(*rpl));
+	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_RPL));
+	rpl->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_ABORT_RPL, ep->hwtid));
+	rpl->cmd = CPL_ABORT_NO_RST;
+	ep->com.tdev->send(ep->com.tdev, rpl_skb);
+	if (state != ABORTING) {
+		release_ep_resources(ep);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static int close_con_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct iwch_qp_attributes attrs;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	BUG_ON(!ep);
+
+	/* The cm_id may be null if we failed to connect */
+	switch (state_read(&ep->com)) {
+	case CLOSING:
+		start_ep_timer(ep);
+		state_set(&ep->com, MORIBUND);
+		break;
+	case MORIBUND:
+		stop_ep_timer(ep);
+		if ((ep->com.cm_id) && (ep->com.qp)) {
+			attrs.next_state = IWCH_QP_STATE_IDLE;
+			iwch_modify_qp(ep->com.qp->rhp,
+					     ep->com.qp, 
+					     IWCH_QP_ATTR_NEXT_STATE,
+					     &attrs, 1);
+		}
+		close_complete_upcall(ep);
+		release_ep_resources(ep);
+		break;
+	case DEAD:
+	default:
+		BUG_ON(1);
+		break;
+	}
+	
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * T3A does 3 things when a TERM is received:
+ * 1) send up a CPL_RDMA_TERMINATE message with the TERM packet
+ * 2) generate an async event on the QP with the TERMINATE opcode
+ * 3) post a TERMINATE opcde cqe into the associated CQ.
+ *
+ * For (1), we save the message in the qp for later consumer consumption.
+ * For (2), we move the QP into TERMINATE, post a QP event and disconnect.
+ * For (3), we toss the CQE in cxio_poll_cq().
+ * 
+ * terminate() handles case (1)...
+ */
+static int terminate(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb_pull(skb, sizeof(struct cpl_rdma_terminate));
+	PDBG("%s saving %d bytes of term msg\n", __FUNCTION__, skb->len);
+	memcpy(ep->com.qp->attr.terminate_buffer, skb->data, skb->len);
+	ep->com.qp->attr.terminate_msg_len = skb->len;
+	ep->com.qp->attr.is_terminate_local = 0;
+	return CPL_RET_BUF_DONE;
+}
+
+static int ec_status(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct cpl_rdma_ec_status *rep = cplhdr(skb);
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p tid %u status %d\n", __FUNCTION__, ep, ep->hwtid, 
+	     rep->status);
+	if (rep->status) {
+		struct iwch_qp_attributes attrs;
+
+		printk(KERN_ERR MOD "%s BAD CLOSE - Aborting tid %u\n",
+		       __FUNCTION__, ep->hwtid);
+		attrs.next_state = IWCH_QP_STATE_ERROR;
+		iwch_modify_qp(ep->com.qp->rhp,
+			       ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+			       &attrs, 1);
+		abort_connection(ep, NULL);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static void ep_timeout(unsigned long arg)
+{
+	struct iwch_ep *ep = (struct iwch_ep *)arg;
+	struct iwch_qp_attributes attrs;
+
+	PDBG("%s ep %p tid %u\n", __FUNCTION__, ep, ep->hwtid);
+	if (state_comp_exch(&ep->com, MPA_REQ_SENT, CLOSING)) {
+		struct sk_buff *skb;
+
+		connect_reply_upcall(ep, -ETIMEDOUT);
+		skb = alloc_skb(sizeof(struct cpl_abort_req), GFP_ATOMIC);
+		if (skb) {
+			abort_connection(ep, skb);
+		}
+	}
+	if (state_comp_exch(&ep->com, MPA_REQ_WAIT, CLOSING)) {
+		struct sk_buff *skb;
+
+		skb = alloc_skb(sizeof(struct cpl_abort_req), GFP_ATOMIC);
+		if (skb) {
+			abort_connection(ep, skb);
+		}
+	}
+	if (state_comp_exch(&ep->com, MORIBUND, ABORTING)) {
+		struct sk_buff *skb;
+
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_ERROR;
+			iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				     &attrs, 1);
+		}
+		skb = alloc_skb(sizeof(struct cpl_abort_req), GFP_ATOMIC);
+		if (skb) {
+			abort_connection(ep, skb);
+		}
+	}
+	free_ep(&ep->com);
+}
+
+int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len)
+{
+	int err;
+	struct iwch_ep *ep = to_ep(cm_id);
+	PDBG("%s ep %p tid %u\n", __FUNCTION__, ep, ep->hwtid);
+
+	if (state_read(&ep->com) == DEAD) {
+		free_ep(&ep->com);
+		return -ECONNRESET;
+	}
+	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
+	state_set(&ep->com, CLOSING);
+	if (mpa_rev == 0) {
+		abort_connection(ep, NULL);
+	} else {
+		err = send_mpa_reject(ep, pdata, pdata_len);
+		err = send_halfclose(ep, GFP_KERNEL);
+	}
+	return 0;
+}
+
+int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
+{
+	int err;
+	struct iwch_ep *ep = to_ep(cm_id);
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_qp *qp = get_qhp(h, conn_param->qpn);
+
+	PDBG("%s ep %p tid %u\n", __FUNCTION__, ep, ep->hwtid);
+	if (state_read(&ep->com) == DEAD) {
+		free_ep(&ep->com);
+		return -ECONNRESET;
+	}
+	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
+
+	/* 
+	 * Quiesce the TID here.  The uP unquiesces the TID as
+	 * part of the rdma_init operation.
+	 */
+	err = migrate_tid(ep);
+	if (err) {
+		abort_connection(ep, NULL);
+		return err;
+	}
+
+	BUG_ON(!qp);
+	if ((conn_param->ord > qp->rhp->attr.max_rdma_read_qp_depth) ||
+	    (conn_param->ird > qp->rhp->attr.max_rdma_reads_per_qp)) {
+		abort_connection(ep, NULL);
+		return -EINVAL;
+	}
+
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->com.qp = qp;
+
+	ep->com.rpl_done = 0;
+	ep->com.rpl_err = 0;
+	ep->ird = conn_param->ird;
+	ep->ord = conn_param->ord;
+	PDBG("%s %d ird %d ord %d\n", __FUNCTION__, __LINE__, ep->ird, ep->ord);
+	ep_atomic_inc(&ep->com.refcnt);
+	err = send_mpa_reply(ep, conn_param->private_data, 
+			     conn_param->private_data_len);
+	if (err) {
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+		cm_id->rem_ref(cm_id);
+		abort_connection(ep, NULL);
+		free_ep(&ep->com);
+		return err;
+	}
+
+	/* wait until the MPA is transmitted. */
+	PDBG("sleeping on ep %p\n", ep);
+	wait_event(ep->com.waitq, ep->com.rpl_done);
+	PDBG("awakened on ep %p\n", ep);
+
+	err = ep->com.rpl_err;
+	if (err) {
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+		cm_id->rem_ref(cm_id);
+		abort_connection(ep, NULL);
+	}
+	free_ep(&ep->com);
+	return err;
+}
+
+int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
+{
+	int err = 0;
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_ep *ep;
+	struct rtable *rt;
+
+	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		printk(KERN_ERR MOD "%s - cannot alloc ep.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto out;
+	}
+	init_timer(&ep->timer);
+	ep->plen = conn_param->private_data_len;
+	if (ep->plen) {
+		memcpy(ep->mpa_pkt + sizeof(struct mpa_message), 
+		       conn_param->private_data, ep->plen);
+	}
+	ep->ird = conn_param->ird;
+	ep->ord = conn_param->ord;
+	ep->com.tdev = h->rdev.t3cdev_p;
+
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->com.qp = get_qhp(h, conn_param->qpn);
+	BUG_ON(!ep->com.qp);
+	PDBG("%s qpn 0x%x qp %p cm_id %p\n", __FUNCTION__, conn_param->qpn, 
+	     ep->com.qp, cm_id);
+
+	/* 
+	 * Allocate an active TID to initiate a TCP connection. 
+	 */
+	ep->atid = cxgb3_alloc_atid(h->rdev.t3cdev_p, &t3c_client, ep);
+	if (ep->atid == -1) {
+		printk(KERN_ERR MOD "%s - cannot alloc atid.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	/* find a route */
+	rt = find_route(h->rdev.t3cdev_p,
+			cm_id->local_addr.sin_addr.s_addr,
+			cm_id->remote_addr.sin_addr.s_addr,
+			cm_id->local_addr.sin_port,
+			cm_id->remote_addr.sin_port, IPTOS_LOWDELAY);
+	if (!rt) {
+		printk(KERN_ERR MOD "%s - cannot find route.\n", __FUNCTION__);
+		err = -EHOSTUNREACH;
+		goto fail3;
+	}
+	ep->dst = &rt->u.dst;
+
+	/* get a l2t entry */
+	ep->l2t = t3_l2t_get(ep->com.tdev,
+			     ep->dst->neighbour,
+			     ep->dst->neighbour->dev->if_port);
+	if (!ep->l2t) {
+		printk(KERN_ERR MOD "%s - cannot alloc l2e.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail4;
+	}
+
+	state_set(&ep->com, CONNECTING);
+	ep->tos = IPTOS_LOWDELAY;
+	ep->com.local_addr = cm_id->local_addr;
+	ep->com.remote_addr = cm_id->remote_addr;
+
+	/* send connect request to rnic */
+	err = send_connect(ep);
+	if (!err) {
+		goto out;
+	}
+
+	l2t_release(L2DATA(h->rdev.t3cdev_p), ep->l2t);
+fail4:
+	dst_release(ep->dst);
+fail3:
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+fail2:
+	free_ep(&ep->com);
+out:
+	return err;
+}
+
+int iwch_create_listen(struct iw_cm_id *cm_id, int backlog)
+{
+	int err = 0;
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_listen_ep *ep;
+
+
+	might_sleep();
+
+	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		printk(KERN_ERR MOD "%s - cannot alloc ep.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail1;
+	}
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->com.tdev = h->rdev.t3cdev_p;
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->backlog = backlog;
+	ep->com.local_addr = cm_id->local_addr;
+
+	/* 
+	 * Allocate a server TID.
+	 */
+	ep->stid = cxgb3_alloc_stid(h->rdev.t3cdev_p, &t3c_client, ep);
+	if (ep->stid == -1) {
+		printk(KERN_ERR MOD "%s - cannot alloc atid.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	state_set(&ep->com, LISTEN);
+	err = listen_start(ep);
+	if (err) {
+		goto fail3;
+	}
+
+	/* wait for pass_open_rpl */
+	wait_event(ep->com.waitq, ep->com.rpl_done);
+	err = ep->com.rpl_err;
+	if (!err) {
+		cm_id->provider_data = ep;
+		goto out;
+	}
+fail3:
+	cxgb3_free_stid(ep->com.tdev, ep->stid);
+fail2:
+	free_ep(&ep->com);
+fail1:
+out:
+	return err;
+}
+
+int iwch_destroy_listen(struct iw_cm_id *cm_id)
+{
+	int err;
+	struct iwch_listen_ep *ep = to_listen_ep(cm_id);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	might_sleep();
+	state_set(&ep->com, DEAD);
+	ep->com.rpl_done = 0;
+	ep->com.rpl_err = 0;
+	err = listen_stop(ep);
+	wait_event(ep->com.waitq, ep->com.rpl_done);
+	cxgb3_free_stid(ep->com.tdev, ep->stid);
+	err = ep->com.rpl_err;
+	cm_id->rem_ref(cm_id);
+	free_ep(&ep->com);
+	return err;
+}
+
+int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp)
+{
+	int ret=0;
+	int state;
+
+	
+	state = state_read(&ep->com);
+	PDBG("%s ep %p state %s, abrupt %d\n", __FUNCTION__, ep, 
+	     states[state], abrupt);
+	if (state == DEAD) {
+		PDBG("%s already dead ep %p\n", __FUNCTION__, ep);
+		return 0;
+	}
+	if (abrupt) {
+		if (state != ABORTING) {
+			state_set(&ep->com, ABORTING);
+			ret = send_abort(ep, NULL, gfp);
+		}
+	} else {
+
+		if (state != CLOSING) {
+			state_set(&ep->com, CLOSING);
+		} else {
+			start_ep_timer(ep);
+			state_set(&ep->com, MORIBUND);
+		}
+
+		ret = send_halfclose(ep, gfp);
+	}
+	return ret;
+}
+
+int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new, 
+		     struct l2t_entry *l2t)
+{
+	struct iwch_ep *ep = ctx;
+	
+	if (ep->dst != old)
+		return 0;
+
+	PDBG("%s ep %p redirect to dst %p l2t %p\n", __FUNCTION__, ep, new, 
+	     l2t);
+	dst_hold(new);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	ep->l2t = l2t;
+	dst_release(old);
+	ep->dst = new;
+	return 1;
+}
+
+/* 
+ * All the CM events are handled on a work queue to have a safe context.
+ */
+static int sched(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep_common *epc = ctx;
+
+	ep_atomic_inc(&epc->refcnt);
+
+	/*
+	 * Save ctx and tdev in the skb->cb area.
+	 */
+	*((void **) skb->cb) = ctx;
+	*((struct t3cdev **) (skb->cb + sizeof(void *))) = tdev;
+
+	/* 
+	 * Queue the skb and schedule the worker thread.
+	 */
+	skb_queue_tail(&rxq, skb);
+	queue_work(workq, &skb_work);
+	return 0;
+}
+
+int __init iwch_cm_init(void)
+{
+	skb_queue_head_init(&rxq);
+
+	workq = create_singlethread_workqueue("iw_cxgb3");
+	if (!workq)
+		return -ENOMEM;
+
+	/*
+	 * All upcalls from the T3 Core go to sched() to 
+	 * schedule the processing on a work queue.
+	 */
+	t3c_handlers[CPL_ACT_ESTABLISH] = sched;
+	t3c_handlers[CPL_ACT_OPEN_RPL] = sched;
+	t3c_handlers[CPL_RX_DATA] = sched;
+	t3c_handlers[CPL_TX_DMA_ACK] = sched;
+	t3c_handlers[CPL_ABORT_RPL_RSS] = sched;
+	t3c_handlers[CPL_ABORT_RPL] = sched;
+	t3c_handlers[CPL_PASS_OPEN_RPL] = sched;
+	t3c_handlers[CPL_CLOSE_LISTSRV_RPL] = sched;
+	t3c_handlers[CPL_PASS_ACCEPT_REQ] = sched;
+	t3c_handlers[CPL_PASS_ESTABLISH] = sched;
+	t3c_handlers[CPL_PEER_CLOSE] = sched;
+	t3c_handlers[CPL_CLOSE_CON_RPL] = sched;
+	t3c_handlers[CPL_ABORT_REQ_RSS] = sched;
+	t3c_handlers[CPL_RDMA_TERMINATE] = sched;
+	t3c_handlers[CPL_RDMA_EC_STATUS] = sched;
+
+	/*
+	 * These are the real handlers that are called from a 
+	 * work queue.
+	 */
+	work_handlers[CPL_ACT_ESTABLISH] = act_establish;
+	work_handlers[CPL_ACT_OPEN_RPL] = act_open_rpl;
+	work_handlers[CPL_RX_DATA] = rx_data;
+	work_handlers[CPL_TX_DMA_ACK] = tx_ack;
+	work_handlers[CPL_ABORT_RPL_RSS] = abort_rpl;
+	work_handlers[CPL_ABORT_RPL] = abort_rpl;
+	work_handlers[CPL_PASS_OPEN_RPL] = pass_open_rpl;
+	work_handlers[CPL_CLOSE_LISTSRV_RPL] = close_listsrv_rpl;
+	work_handlers[CPL_PASS_ACCEPT_REQ] = pass_accept_req;
+	work_handlers[CPL_PASS_ESTABLISH] = pass_establish;
+	work_handlers[CPL_PEER_CLOSE] = peer_close;
+	work_handlers[CPL_ABORT_REQ_RSS] = peer_abort;
+	work_handlers[CPL_CLOSE_CON_RPL] = close_con_rpl;
+	work_handlers[CPL_RDMA_TERMINATE] = terminate;
+	work_handlers[CPL_RDMA_EC_STATUS] = ec_status;
+	return 0;
+}
+
+void __exit iwch_cm_term(void)
+{
+	flush_workqueue(workq);
+	destroy_workqueue(workq);
+}
diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.h b/drivers/infiniband/hw/cxgb3/iwch_cm.h
new file mode 100644
index 0000000..cd3e36e
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.h
@@ -0,0 +1,223 @@
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
+#ifndef _IWCH_CM_H_
+#define _IWCH_CM_H_
+
+#include <linux/inet.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+
+#include <rdma/ib_verbs.h>
+#include <rdma/iw_cm.h>
+
+#include "cxgb3_offload.h"
+#include "iwch_provider.h"
+
+#define MPA_KEY_REQ "MPA ID Req Frame"
+#define MPA_KEY_REP "MPA ID Rep Frame"
+
+#define MPA_MAX_PRIVATE_DATA 	256
+#define MPA_REV 		0	/* XXX - amso1100 uses rev 0 ! */
+#define MPA_REJECT 		0x20
+#define MPA_CRC			0x40
+#define MPA_MARKERS		0x80
+#define MPA_FLAGS_MASK		0xE0
+
+#define free_ep(A) { \
+	PDBG("%s %d: Calling __free_ep\n",__FUNCTION__, __LINE__); \
+	__free_ep(A);  \
+}
+
+#define ep_atomic_inc(A) { \
+	PDBG("%s %u: ep_atomic_inc A %p, refcnt %d\n", \
+					__FUNCTION__, \
+					__LINE__, A, \
+					atomic_read(A)); \
+	atomic_inc(A);  \
+}
+
+struct mpa_message {
+	u8 key[16];
+	u8 flags;
+	u8 revision;
+	u16 private_data_size;
+	u8 private_data[0];
+};
+
+struct terminate_message {
+	u8 layer_etype;
+	u8 ecode;
+	u16 hdrct_rsvd;
+	u8 len_hdrs[0];
+};
+
+#define TERM_MAX_LENGTH (sizeof(struct terminate_message) + 2 + 18 + 28)
+
+enum iwch_layers_types {
+	LAYER_RDMAP 		= 0x00,
+	LAYER_DDP		= 0x10,
+	LAYER_MPA		= 0x20,
+	RDMAP_LOCAL_CATA	= 0x00,
+	RDMAP_REMOTE_PROT	= 0x01,
+	RDMAP_REMOTE_OP		= 0x02,
+	DDP_LOCAL_CATA		= 0x00,
+	DDP_TAGGED_ERR		= 0x01,
+	DDP_UNTAGGED_ERR	= 0x02,
+	DDP_LLP			= 0x03
+};
+
+enum iwch_rdma_ecodes {
+	RDMAP_INV_STAG		= 0x00,
+	RDMAP_BASE_BOUNDS	= 0x01,
+	RDMAP_ACC_VIOL		= 0x02,
+	RDMAP_STAG_NOT_ASSOC	= 0x03,
+	RDMAP_TO_WRAP		= 0x04,
+	RDMAP_INV_VERS		= 0x05,
+	RDMAP_INV_OPCODE	= 0x06,
+	RDMAP_STREAM_CATA	= 0x07,
+	RDMAP_GLOBAL_CATA	= 0x08,
+	RDMAP_CANT_INV_STAG	= 0x09,
+	RDMAP_UNSPECIFIED	= 0xff	
+};
+
+enum iwch_ddp_ecodes {
+	DDPT_INV_STAG		= 0x00,
+	DDPT_BASE_BOUNDS	= 0x01,
+	DDPT_STAG_NOT_ASSOC	= 0x02,
+	DDPT_TO_WRAP		= 0x03,
+	DDPT_INV_VERS		= 0x04,
+	DDPU_INV_QN		= 0x01,
+	DDPU_INV_MSN_NOBUF	= 0x02,
+	DDPU_INV_MSN_RANGE	= 0x03,
+	DDPU_INV_MO		= 0x04,
+	DDPU_MSG_TOOBIG		= 0x05,
+	DDPU_INV_VERS		= 0x06
+};
+
+enum iwch_mpa_ecodes {
+	MPA_CRC_ERR		= 0x02,
+	MPA_MARKER_ERR		= 0x03
+};
+
+enum iwch_ep_state {
+	IDLE = 0,
+	LISTEN,	
+	CONNECTING,
+	MPA_REQ_WAIT,
+	MPA_REQ_SENT,
+	MPA_REQ_RCVD,
+	MPA_REP_SENT,
+	FPDU_MODE,
+	ABORTING,
+	CLOSING,
+	MORIBUND,
+	DEAD,
+};
+
+struct iwch_ep_common {
+	struct iw_cm_id *cm_id;
+	struct iwch_qp *qp;
+	struct t3cdev *tdev;
+	enum iwch_ep_state state;
+	atomic_t refcnt;
+	spinlock_t lock;
+	struct sockaddr_in local_addr;
+	struct sockaddr_in remote_addr;
+	wait_queue_head_t waitq;
+	int rpl_done;
+	int rpl_err;
+};
+
+struct iwch_listen_ep {
+	struct iwch_ep_common com;
+	unsigned int stid;
+	int backlog;
+};
+
+struct iwch_ep {
+	struct iwch_ep_common com;
+	struct iwch_ep *parent_ep;
+	struct timer_list timer;
+	unsigned int atid;
+	u32 hwtid;
+	u32 snd_seq;
+	struct l2t_entry *l2t;
+	struct dst_entry *dst;
+	struct sk_buff *mpa_skb;
+	struct iwch_mpa_attributes mpa_attr;
+	unsigned int mpa_pkt_len;
+	u8 mpa_pkt[sizeof(struct mpa_message) + MPA_MAX_PRIVATE_DATA];
+	u8 tos;
+	u16 emss;
+	u16 plen;
+	u32 ird;
+	u32 ord;
+};
+
+static inline struct iwch_ep *to_ep(struct iw_cm_id *cm_id)
+{
+	return (struct iwch_ep *)cm_id->provider_data;
+}
+
+static inline struct iwch_listen_ep *to_listen_ep(struct iw_cm_id *cm_id)
+{
+	return (struct iwch_listen_ep *)cm_id->provider_data;
+}
+
+static inline int compute_wscale(int win)
+{
+	int wscale = 0;
+
+	while (wscale < 14 && (65535<<wscale) < win)
+		wscale++;
+	return wscale;
+}
+
+/* CM prototypes */
+
+int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
+int iwch_create_listen(struct iw_cm_id *cm_id, int backlog);
+int iwch_destroy_listen(struct iw_cm_id *cm_id);
+int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
+int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
+int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp);
+int iwch_quiesce_tid(struct iwch_ep *ep);
+int iwch_resume_tid(struct iwch_ep *ep);
+void __free_ep(struct iwch_ep_common *epc);
+void iwch_rearp(struct iwch_ep *ep);
+int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new, struct l2t_entry *l2t);
+
+int __init iwch_cm_init(void);
+void __exit iwch_cm_term(void);
+
+#endif				/* _IWCH_CM_H_ */
