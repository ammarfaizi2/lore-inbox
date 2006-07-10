Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWGJSNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWGJSNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWGJSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:13:39 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:58756 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1422743AbWGJSNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:13:37 -0400
Date: Mon, 10 Jul 2006 21:14:06 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] IB/cm: drop REQ when out of memory
Message-ID: <20060710181406.GC29641@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 18:18:43.0546 (UTC) FILETIME=[46E493A0:01C6A44D]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew!
Could you please drop the following in -mm and on to Linus?

---

If a user of the IB CM returns -ENOMEM from their connection callback,
simply drop the incoming REQ - do not attempt to send a reject. This should
allow the sender to retry the request.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Sean Hefty <sean.hefty@intel.com>

Index: l/drivers/infiniband/core/cm.c
===================================================================
--- l/drivers/infiniband/core/cm.c	(revision 8224)
+++ l/drivers/infiniband/core/cm.c	(working copy)
@@ -702,7 +702,7 @@ static void cm_reset_to_idle(struct cm_i
 	}
 }
 
-void ib_destroy_cm_id(struct ib_cm_id *cm_id)
+static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
@@ -736,12 +736,22 @@ retest:
 			       sizeof cm_id_priv->av.port->cm_dev->ca_guid,
 			       NULL, 0);
 		break;
+	case IB_CM_REQ_RCVD:
+		if (err == -ENOMEM) {
+			/* Do not reject to allow future retries. */
+			cm_reset_to_idle(cm_id_priv);
+			spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		} else {
+			spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+			ib_send_cm_rej(cm_id, IB_CM_REJ_CONSUMER_DEFINED,
+				       NULL, 0, NULL, 0);
+		}
+		break;
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
 		/* Fall through */
-	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
@@ -776,6 +786,11 @@ retest:
 	kfree(cm_id_priv->private_data);
 	kfree(cm_id_priv);
 }
+
+void ib_destroy_cm_id(struct ib_cm_id *cm_id)
+{
+	cm_destroy_id(cm_id, 0);
+}
 EXPORT_SYMBOL(ib_destroy_cm_id);
 
 int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask,
@@ -1164,7 +1179,7 @@ static void cm_process_work(struct cm_id
 	}
 	cm_deref_id(cm_id_priv);
 	if (ret)
-		ib_destroy_cm_id(&cm_id_priv->id);
+		cm_destroy_id(&cm_id_priv->id, ret);
 }
 
 static void cm_format_mra(struct cm_mra_msg *mra_msg,

-- 
MST

_______________________________________________
openib-general mailing list
openib-general@openib.org
http://openib.org/mailman/listinfo/openib-general

To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

----- End forwarded message -----

-- 
MST
