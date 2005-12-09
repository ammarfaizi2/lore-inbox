Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVLIVv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVLIVv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVLIVvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:51:55 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:33320 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932453AbVLIVvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:51:54 -0500
X-IronPort-AV: i="3.99,235,1131350400"; 
   d="scan'208"; a="239406836:sNHT33273292"
Subject: [git patch review 2/5] IB/cm: correct reported reject code
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Dec 2005 21:51:50 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134165110300-7a2e27ea7ca96ec0@cisco.com>
In-Reply-To: <1134165110300-0a7b2146d584150e@cisco.com>
X-OriginalArrivalTime: 09 Dec 2005 21:51:51.0398 (UTC) FILETIME=[C30F3060:01C5FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change reject code from TIMEOUT to CONSUMER_REJECT when destroying a
cm_id in the process of connecting.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/cm.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

227eca83690da7dcbd698d3268e29402e0571723
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 02110e0..1fe2186 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -684,6 +684,13 @@ retest:
 		cm_reject_sidr_req(cm_id_priv, IB_SIDR_REJECT);
 		break;
 	case IB_CM_REQ_SENT:
+		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		ib_send_cm_rej(cm_id, IB_CM_REJ_TIMEOUT,
+			       &cm_id_priv->av.port->cm_dev->ca_guid,
+			       sizeof cm_id_priv->av.port->cm_dev->ca_guid,
+			       NULL, 0);
+		break;
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
@@ -694,10 +701,8 @@ retest:
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		ib_send_cm_rej(cm_id, IB_CM_REJ_TIMEOUT,
-			       &cm_id_priv->av.port->cm_dev->ca_guid,
-			       sizeof cm_id_priv->av.port->cm_dev->ca_guid,
-			       NULL, 0);
+		ib_send_cm_rej(cm_id, IB_CM_REJ_CONSUMER_DEFINED,
+			       NULL, 0, NULL, 0);
 		break;
 	case IB_CM_ESTABLISHED:
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-- 
0.99.9l
