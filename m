Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCCFk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCCFk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVCCFie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:38:34 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261475AbVCCFbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:25 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/11] IB: simplify MAD code
In-Reply-To: <2005322131.J5dPz9nJYwSlaHs6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.pkxanHLh4SQ8X31k@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0491 (UTC) FILETIME=[3C389CB0:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

Remove unneeded MAD agent registration by using a single agent for
both directed-route and LID-routed MADs.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/agent.c	2005-03-02 20:26:03.280776011 -0800
+++ linux-export/drivers/infiniband/core/agent.c	2005-03-02 20:26:10.599187430 -0800
@@ -66,14 +66,13 @@
 
 	if (device) {
 		list_for_each_entry(entry, &ib_agent_port_list, port_list) {
-			if (entry->dr_smp_agent->device == device &&
+			if (entry->smp_agent->device == device &&
 			    entry->port_num == port_num)
 				return entry;
 		}
 	} else {
 		list_for_each_entry(entry, &ib_agent_port_list, port_list) {
-			if ((entry->dr_smp_agent == mad_agent) ||
-			    (entry->lr_smp_agent == mad_agent) ||
+			if ((entry->smp_agent == mad_agent) ||
 			    (entry->perf_mgmt_agent == mad_agent))
 				return entry;
 		}
@@ -111,7 +110,7 @@
 		return 1;
 	}
 
-	return smi_check_local_smp(port_priv->dr_smp_agent, smp);
+	return smi_check_local_smp(port_priv->smp_agent, smp);
 }
 
 static int agent_mad_send(struct ib_mad_agent *mad_agent,
@@ -231,10 +230,8 @@
 	/* Get mad agent based on mgmt_class in MAD */
 	switch (mad->mad.mad.mad_hdr.mgmt_class) {
 		case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
-			mad_agent = port_priv->dr_smp_agent;
-			break;
 		case IB_MGMT_CLASS_SUBN_LID_ROUTED:
-			mad_agent = port_priv->lr_smp_agent;
+			mad_agent = port_priv->smp_agent;
 			break;
 		case IB_MGMT_CLASS_PERF_MGMT:
 			mad_agent = port_priv->perf_mgmt_agent;
@@ -284,7 +281,6 @@
 {
 	int ret;
 	struct ib_agent_port_private *port_priv;
-	struct ib_mad_reg_req reg_req;
 	unsigned long flags;
 
 	/* First, check if port already open for SMI */
@@ -308,35 +304,19 @@
 	spin_lock_init(&port_priv->send_list_lock);
 	INIT_LIST_HEAD(&port_priv->send_posted_list);
 
-	/* Obtain MAD agent for directed route SM class */
-	reg_req.mgmt_class = IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE;
-	reg_req.mgmt_class_version = 1;
-
-	port_priv->dr_smp_agent = ib_register_mad_agent(device, port_num,
-							IB_QPT_SMI,
-							NULL, 0,
-						       &agent_send_handler,
-							NULL, NULL);
+	/* Obtain send only MAD agent for SM class (SMI QP) */
+	port_priv->smp_agent = ib_register_mad_agent(device, port_num,
+						     IB_QPT_SMI,
+						     NULL, 0,
+						    &agent_send_handler,
+						     NULL, NULL);
 
-	if (IS_ERR(port_priv->dr_smp_agent)) {
-		ret = PTR_ERR(port_priv->dr_smp_agent);
+	if (IS_ERR(port_priv->smp_agent)) {
+		ret = PTR_ERR(port_priv->smp_agent);
 		goto error2;
 	}
 
-	/* Obtain MAD agent for LID routed SM class */
-	reg_req.mgmt_class = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	port_priv->lr_smp_agent = ib_register_mad_agent(device, port_num,
-							IB_QPT_SMI,
-							NULL, 0,
-						       &agent_send_handler,
-							NULL, NULL);
-	if (IS_ERR(port_priv->lr_smp_agent)) {
-		ret = PTR_ERR(port_priv->lr_smp_agent);
-		goto error3;
-	}
-
-	/* Obtain MAD agent for PerfMgmt class */
-	reg_req.mgmt_class = IB_MGMT_CLASS_PERF_MGMT;
+	/* Obtain send only MAD agent for PerfMgmt class (GSI QP) */
 	port_priv->perf_mgmt_agent = ib_register_mad_agent(device, port_num,
 							   IB_QPT_GSI,
 							   NULL, 0,
@@ -344,15 +324,15 @@
 							   NULL, NULL);
 	if (IS_ERR(port_priv->perf_mgmt_agent)) {
 		ret = PTR_ERR(port_priv->perf_mgmt_agent);
-		goto error4;
+		goto error3;
 	}
 
-	port_priv->mr = ib_get_dma_mr(port_priv->dr_smp_agent->qp->pd,
+	port_priv->mr = ib_get_dma_mr(port_priv->smp_agent->qp->pd,
 				      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(port_priv->mr)) {
 		printk(KERN_ERR SPFX "Couldn't get DMA MR\n");
 		ret = PTR_ERR(port_priv->mr);
-		goto error5;
+		goto error4;
 	}
 
 	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
@@ -361,12 +341,10 @@
 
 	return 0;
 
-error5:
-	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
 error4:
-	ib_unregister_mad_agent(port_priv->lr_smp_agent);
+	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
 error3:
-	ib_unregister_mad_agent(port_priv->dr_smp_agent);
+	ib_unregister_mad_agent(port_priv->smp_agent);
 error2:
 	kfree(port_priv);
 error1:
@@ -391,8 +369,7 @@
 	ib_dereg_mr(port_priv->mr);
 
 	ib_unregister_mad_agent(port_priv->perf_mgmt_agent);
-	ib_unregister_mad_agent(port_priv->lr_smp_agent);
-	ib_unregister_mad_agent(port_priv->dr_smp_agent);
+	ib_unregister_mad_agent(port_priv->smp_agent);
 	kfree(port_priv);
 
 	return 0;
--- linux-export.orig/drivers/infiniband/core/agent_priv.h	2005-03-02 20:26:03.280776011 -0800
+++ linux-export/drivers/infiniband/core/agent_priv.h	2005-03-02 20:26:10.599187430 -0800
@@ -55,8 +55,7 @@
 	struct list_head send_posted_list;
 	spinlock_t send_list_lock;
 	int port_num;
-	struct ib_mad_agent *dr_smp_agent;    /* DR SM class */
-	struct ib_mad_agent *lr_smp_agent;    /* LR SM class */
+	struct ib_mad_agent *smp_agent;	      /* SM class */
 	struct ib_mad_agent *perf_mgmt_agent; /* PerfMgmt class */
 	struct ib_mr *mr;
 };

