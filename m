Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVCCFq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVCCFq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVCCFhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:37:03 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261502AbVCCFb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/11] IB: fix vendor MAD deregistration
In-Reply-To: <2005322131.pkxanHLh4SQ8X31k@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.5pgryiWlkZPYdcE7@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0538 (UTC) FILETIME=[3C3FC8A0:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shahar Frank <shaharf@voltaire.com>

Fix bug when deregistering a vendor class MAD agent.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-03-02 20:26:03.185796628 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-03-02 20:26:10.980104746 -0800
@@ -41,7 +41,6 @@
 #include "smi.h"
 #include "agent.h"
 
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("kernel IB MAD API");
 MODULE_AUTHOR("Hal Rosenstock");
@@ -490,6 +489,7 @@
 	cancel_mads(mad_agent_priv);
 
 	port_priv = mad_agent_priv->qp_info->port_priv;
+
 	cancel_delayed_work(&mad_agent_priv->timed_work);
 	flush_workqueue(port_priv->wq);
 
@@ -1266,12 +1266,12 @@
 	}
 
 	port_priv = agent_priv->qp_info->port_priv;
+	mgmt_class = convert_mgmt_class(agent_priv->reg_req->mgmt_class);
 	class = port_priv->version[
 			agent_priv->reg_req->mgmt_class_version].class;
 	if (!class)
 		goto vendor_check;
 
-	mgmt_class = convert_mgmt_class(agent_priv->reg_req->mgmt_class);
 	method = class->method_table[mgmt_class];
 	if (method) {
 		/* Remove any methods for this mad agent */
@@ -1293,16 +1293,21 @@
 	}
 
 vendor_check:
+	if (!is_vendor_class(mgmt_class))
+		goto out;
+
+	/* normalize mgmt_class to vendor range 2 */
+	mgmt_class = vendor_class_index(agent_priv->reg_req->mgmt_class);
 	vendor = port_priv->version[
 			agent_priv->reg_req->mgmt_class_version].vendor;
+
 	if (!vendor)
 		goto out;
 
-	mgmt_class = vendor_class_index(agent_priv->reg_req->mgmt_class);
 	vendor_class = vendor->vendor_class[mgmt_class];
 	if (vendor_class) {
 		index = find_vendor_oui(vendor_class, agent_priv->reg_req->oui);
-		if (index == -1)
+		if (index < 0)
 			goto out;
 		method = vendor_class->method_table[index];
 		if (method) {
--- linux-export.orig/drivers/infiniband/core/mad_priv.h	2005-03-02 20:26:03.185796628 -0800
+++ linux-export/drivers/infiniband/core/mad_priv.h	2005-03-02 20:26:10.980104746 -0800
@@ -58,8 +58,8 @@
 #define MAX_MGMT_CLASS		80
 #define MAX_MGMT_VERSION	8
 #define MAX_MGMT_OUI		8
-#define MAX_MGMT_VENDOR_RANGE2	IB_MGMT_CLASS_VENDOR_RANGE2_END - \
-				IB_MGMT_CLASS_VENDOR_RANGE2_START + 1
+#define MAX_MGMT_VENDOR_RANGE2	(IB_MGMT_CLASS_VENDOR_RANGE2_END - \
+				IB_MGMT_CLASS_VENDOR_RANGE2_START + 1)
 
 struct ib_mad_list_head {
 	struct list_head list;

