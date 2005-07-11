Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVGKNzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVGKNzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGKNxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:53:00 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:30661 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261711AbVGKNwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:52:47 -0400
Subject: [PATCH 2/27] Update MAD client API
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089074.4389.4509.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 09:45:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically allocate a MR when registering a MAD agent. 
MAD clients are modified to use this updated API.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

--- 
 core/agent.c      |   16 +--
 core/agent_priv.h |    3 +--
 core/mad.c        |   31 +++++++++++++++++++--
 core/sa_query.c   |   15 ++--
 include/ib_mad.h  |    1 +
 5 files changed, 24 insertions(+), 42 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband1/core/agent.c linux-2.6.13-rc2-mm1/drivers/infiniband2/core/agent.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband1/core/agent.c	2005-07-08 14:12:17.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband2/core/agent.c	2005-07-09 13:22:55.000000000 -0400
@@ -129,13 +129,12 @@ static int agent_mad_send(struct ib_mad_
 		goto out;
 	agent_send_wr->mad = mad_priv;
 
-	/* PCI mapping */
 	gather_list.addr = dma_map_single(mad_agent->device->dma_device,
 					  &mad_priv->mad,
 					  sizeof(mad_priv->mad),
 					  DMA_TO_DEVICE);
 	gather_list.length = sizeof(mad_priv->mad);
-	gather_list.lkey = (*port_priv->mr).lkey;
+	gather_list.lkey = mad_agent->mr->lkey;
 
 	send_wr.next = NULL;
 	send_wr.opcode = IB_WR_SEND;
@@ -261,7 +260,6 @@ static void agent_send_handler(struct ib
 	list_del(&agent_send_wr->send_list);
 	spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
 
-	/* Unmap PCI */
 	dma_unmap_single(mad_agent->device->dma_device,
 			 pci_unmap_addr(agent_send_wr, mapping),
 			 sizeof(agent_send_wr->mad->mad),
@@ -324,22 +322,12 @@ int ib_agent_port_open(struct ib_device 
 		goto error3;
 	}
 
-	port_priv->mr = ib_get_dma_mr(port_priv->smp_agent->qp->pd,
-				      IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(port_priv->mr)) {
-		printk(KERN_ERR SPFX "Couldn't get DMA MR\n");
-		ret = PTR_ERR(port_priv->mr);
-		goto error4;
-	}
-
 	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
 	list_add_tail(&port_priv->port_list, &ib_agent_port_list);
 	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
 
 	return 0;
 
-error4:
-	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
 error3:
 	ib_unregister_mad_agent(port_priv->smp_agent);
 error2:
@@ -363,8 +351,6 @@ int ib_agent_port_close(struct ib_device
 	list_del(&port_priv->port_list);
 	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
 
-	ib_dereg_mr(port_priv->mr);
-
 	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
 	ib_unregister_mad_agent(port_priv->smp_agent);
 	kfree(port_priv);
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband1/core/agent_priv.h linux-2.6.13-rc2-mm1/drivers/infiniband2/core/agent_priv.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband1/core/agent_priv.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband2/core/agent_priv.h	2005-07-09 12:14:49.000000000 -0400
@@ -33,7 +33,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: agent_priv.h 1389 2004-12-27 22:56:47Z roland $
+ * $Id: agent_priv.h 1640 2005-01-24 22:39:02Z halr $
  */
 
 #ifndef __IB_AGENT_PRIV_H__
@@ -57,7 +57,6 @@ struct ib_agent_port_private {
 	int port_num;
 	struct ib_mad_agent *smp_agent;	      /* SM class */
 	struct ib_mad_agent *perf_mgmt_agent; /* PerfMgmt class */
-	struct ib_mr *mr;
 };
 
 #endif	/* __IB_AGENT_PRIV_H__ */
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband1/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband1/core/mad.c	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c	2005-07-09 12:58:23.000000000 -0400
@@ -261,19 +261,26 @@ struct ib_mad_agent *ib_register_mad_age
 		ret = ERR_PTR(-ENOMEM);
 		goto error1;
 	}
+	memset(mad_agent_priv, 0, sizeof *mad_agent_priv);
+
+	mad_agent_priv->agent.mr = ib_get_dma_mr(port_priv->qp_info[qpn].qp->pd,
+						 IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(mad_agent_priv->agent.mr)) {
+		ret = ERR_PTR(-ENOMEM);
+		goto error2;
+	}
 
 	if (mad_reg_req) {
 		reg_req = kmalloc(sizeof *reg_req, GFP_KERNEL);
 		if (!reg_req) {
 			ret = ERR_PTR(-ENOMEM);
-			goto error2;
+			goto error3;
 		}
 		/* Make a copy of the MAD registration request */
 		memcpy(reg_req, mad_reg_req, sizeof *reg_req);
 	}
 
 	/* Now, fill in the various structures */
-	memset(mad_agent_priv, 0, sizeof *mad_agent_priv);
 	mad_agent_priv->qp_info = &port_priv->qp_info[qpn];
 	mad_agent_priv->reg_req = reg_req;
 	mad_agent_priv->rmpp_version = rmpp_version;
@@ -301,7 +308,7 @@ struct ib_mad_agent *ib_register_mad_age
 				if (method) {
 					if (method_in_use(&method,
 							   mad_reg_req))
-						goto error3;
+						goto error4;
 				}
 			}
 			ret2 = add_nonoui_reg_req(mad_reg_req, mad_agent_priv,
@@ -317,14 +324,14 @@ struct ib_mad_agent *ib_register_mad_age
 					if (is_vendor_method_in_use(
 							vendor_class,
 							mad_reg_req))
-						goto error3;
+						goto error4;
 				}
 			}
 			ret2 = add_oui_reg_req(mad_reg_req, mad_agent_priv);
 		}
 		if (ret2) {
 			ret = ERR_PTR(ret2);
-			goto error3;
+			goto error4;
 		}
 	}
 
@@ -346,11 +353,13 @@ struct ib_mad_agent *ib_register_mad_age
 
 	return &mad_agent_priv->agent;
 
-error3:
+error4:
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 	kfree(reg_req);
-error2:
+error3:
 	kfree(mad_agent_priv);
+error2:
+	ib_dereg_mr(mad_agent_priv->agent.mr);
 error1:
 	return ret;
 }
@@ -487,18 +496,15 @@ static void unregister_mad_agent(struct 
 	 * MADs, preventing us from queuing additional work
 	 */
 	cancel_mads(mad_agent_priv);
-
 	port_priv = mad_agent_priv->qp_info->port_priv;
-
 	cancel_delayed_work(&mad_agent_priv->timed_work);
-	flush_workqueue(port_priv->wq);
 
 	spin_lock_irqsave(&port_priv->reg_lock, flags);
 	remove_mad_reg_req(mad_agent_priv);
 	list_del(&mad_agent_priv->agent_list);
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 
-	/* XXX: Cleanup pending RMPP receives for this agent */
+	flush_workqueue(port_priv->wq);
 
 	atomic_dec(&mad_agent_priv->refcount);
 	wait_event(mad_agent_priv->wait,
@@ -506,6 +512,7 @@ static void unregister_mad_agent(struct 
 
 	if (mad_agent_priv->reg_req)
 		kfree(mad_agent_priv->reg_req);
+	ib_dereg_mr(mad_agent_priv->agent.mr);
 	kfree(mad_agent_priv);
 }
 
@@ -750,7 +757,7 @@ static int handle_outgoing_dr_smp(struct
 	list_add_tail(&local->completion_list, &mad_agent_priv->local_list);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 	queue_work(mad_agent_priv->qp_info->port_priv->wq,
-		  &mad_agent_priv->local_work);
+		   &mad_agent_priv->local_work);
 	ret = 1;
 out:
 	return ret;
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband1/core/sa_query.c linux-2.6.13-rc2-mm1/drivers/infiniband2/core/sa_query.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband1/core/sa_query.c	2005-07-10 16:21:40.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband2/core/sa_query.c	2005-07-10 16:21:55.000000000 -0400
@@ -77,7 +77,6 @@ struct ib_sa_sm_ah {
 
 struct ib_sa_port {
 	struct ib_mad_agent *agent;
-	struct ib_mr        *mr;
 	struct ib_sa_sm_ah  *sm_ah;
 	struct work_struct   update_task;
 	spinlock_t           ah_lock;
@@ -492,7 +491,7 @@ retry:
 					    sizeof (struct ib_sa_mad),
 					    DMA_TO_DEVICE);
 	gather_list.length = sizeof (struct ib_sa_mad);
-	gather_list.lkey   = port->mr->lkey;
+	gather_list.lkey   = port->agent->mr->lkey;
 	pci_unmap_addr_set(query, mapping, gather_list.addr);
 
 	ret = ib_post_send_mad(port->agent, &wr, &bad_wr);
@@ -780,7 +779,6 @@ static void ib_sa_add_one(struct ib_devi
 	sa_dev->end_port   = e;
 
 	for (i = 0; i <= e - s; ++i) {
-		sa_dev->port[i].mr       = NULL;
 		sa_dev->port[i].sm_ah    = NULL;
 		sa_dev->port[i].port_num = i + s;
 		spin_lock_init(&sa_dev->port[i].ah_lock);
@@ -792,13 +790,6 @@ static void ib_sa_add_one(struct ib_devi
 		if (IS_ERR(sa_dev->port[i].agent))
 			goto err;
 
-		sa_dev->port[i].mr = ib_get_dma_mr(sa_dev->port[i].agent->qp->pd,
-						   IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(sa_dev->port[i].mr)) {
-			ib_unregister_mad_agent(sa_dev->port[i].agent);
-			goto err;
-		}
-
 		INIT_WORK(&sa_dev->port[i].update_task,
 			  update_sm_ah, &sa_dev->port[i]);
 	}
@@ -822,10 +813,8 @@ static void ib_sa_add_one(struct ib_devi
 	return;
 
 err:
-	while (--i >= 0) {
-		ib_dereg_mr(sa_dev->port[i].mr);
+	while (--i >= 0)
 		ib_unregister_mad_agent(sa_dev->port[i].agent);
-	}
 
 	kfree(sa_dev);
 
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband1/include/ib_mad.h linux-2.6.13-rc2-mm1/drivers/infiniband2/include/ib_mad.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband1/include/ib_mad.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband2/include/ib_mad.h	2005-07-09 12:06:49.000000000 -0400
@@ -180,6 +180,7 @@ typedef void (*ib_mad_recv_handler)(stru
 struct ib_mad_agent {
 	struct ib_device	*device;
 	struct ib_qp		*qp;
+	struct ib_mr		*mr;
 	ib_mad_recv_handler	recv_handler;
 	ib_mad_send_handler	send_handler;
 	ib_mad_snoop_handler	snoop_handler;


