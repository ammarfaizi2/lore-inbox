Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVGKUS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVGKUS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVGKUQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:16:16 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:57036 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262561AbVGKUOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:14:49 -0400
Subject: [PATCH 10/29v2] Add automatic retries to MAD layer
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110298.4389.5004.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:07:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add automatic retries to MAD layer. 
Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 9/29.

--
 core/mad.c         |   26 +++++++++++++++++++++++++-
 core/mad_priv.h    |    2 ++
 core/sa_query.c    |    3 ++-
 core/user_mad.c    |    1 +
 include/ib_verbs.h |    1 +
 5 files changed, 31 insertions(+), 2 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/mad.c	2005-07-11 13:37:10.000000000 -0400
+++ linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad.c	2005-07-11 13:37:54.000000000 -0400
@@ -954,7 +954,7 @@ int ib_post_send_mad(struct ib_mad_agent
 		/* Timeout will be updated after send completes */
 		mad_send_wr->timeout = msecs_to_jiffies(send_wr->wr.
 							ud.timeout_ms);
-		mad_send_wr->retry = 0;
+		mad_send_wr->retries = mad_send_wr->send_wr.wr.ud.retries;
 		/* One reference for each work request to QP + response */
 		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
 		mad_send_wr->status = IB_WC_SUCCESS;
@@ -2174,6 +2174,27 @@ local_send_completion:
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 }
 
+static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	int ret;
+
+	if (!mad_send_wr->retries--)
+		return -ETIMEDOUT;
+
+	mad_send_wr->timeout = msecs_to_jiffies(mad_send_wr->send_wr.
+						wr.ud.timeout_ms);
+
+	ret = ib_send_mad(mad_send_wr);
+
+	if (!ret) {
+		mad_send_wr->refcount++;
+		list_del(&mad_send_wr->agent_list);
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_send_wr->mad_agent_priv->send_list);
+	}
+	return ret;
+}
+
 static void timeout_sends(void *data)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
@@ -2202,6 +2223,9 @@ static void timeout_sends(void *data)
 			break;
 		}
 
+		if (!retry_send(mad_send_wr))
+			continue;
+
 		list_del(&mad_send_wr->agent_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
diff -uprN linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/mad_priv.h linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad_priv.h
-- linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/mad_priv.h	2005-07-09 16:48:05.000000000 -0400
+++ linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/mad_priv.h	2005-07-09 17:15:40.000000000 -0400
@@ -123,6 +123,7 @@ struct ib_mad_send_wr_private {
 	u64 wr_id;			/* client WR ID */
 	u64 tid;
 	unsigned long timeout;
+	int retries;
 	int retry;
 	int refcount;
 	enum ib_wc_status status;
@@ -136,6 +137,7 @@ struct ib_mad_local_private {
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	u64 wr_id;			/* client WR ID */
 	u64 tid;
+	int retries;
 };
 
 struct ib_mad_mgmt_method_table {
diff -uprN linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/sa_query.c linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/sa_query.c
-- linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/sa_query.c	2005-07-10 16:21:55.000000000 -0400
+++ linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/sa_query.c	2005-07-10 16:22:13.000000000 -0400
@@ -462,7 +462,8 @@ static int send_mad(struct ib_sa_query *
 				 .mad_hdr     = &query->mad->mad_hdr,
 				 .remote_qpn  = 1,
 				 .remote_qkey = IB_QP1_QKEY,
-				 .timeout_ms  = timeout_ms
+				 .timeout_ms  = timeout_ms,
+				 .retries     = 0 
 			 }
 		 }
 	};
diff -uprN linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/user_mad.c linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/user_mad.c
-- linux-2.6.13-rc2-mm1-9/drivers/infiniband/core/user_mad.c	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1-10/drivers/infiniband/core/user_mad.c	2005-07-09 17:14:46.000000000 -0400
@@ -322,6 +322,7 @@ static ssize_t ib_umad_write(struct file
 	wr.wr.ud.remote_qpn  = be32_to_cpu(packet->mad.qpn);
 	wr.wr.ud.remote_qkey = be32_to_cpu(packet->mad.qkey);
 	wr.wr.ud.timeout_ms  = packet->mad.timeout_ms;
+	wr.wr.ud.retries     = 0;
 
 	wr.wr_id            = (unsigned long) packet;
 
diff -uprN linux-2.6.13-rc2-mm1-9/drivers/infiniband/include/ib_verbs.h linux-2.6.13-rc2-mm1-10/drivers/infiniband/include/ib_verbs.h
-- linux-2.6.13-rc2-mm1-9/drivers/infiniband/include/ib_verbs.h	2005-07-10 11:11:43.000000000 -0400
+++ linux-2.6.13-rc2-mm1-10/drivers/infiniband/include/ib_verbs.h	2005-07-10 10:55:59.000000000 -0400
@@ -566,6 +566,7 @@ struct ib_send_wr {
 			u32	remote_qpn;
 			u32	remote_qkey;
 			int	timeout_ms; /* valid for MADs only */
+			int	retries;    /* valid for MADs only */
 			u16	pkey_index; /* valid for GSI only */
 			u8	port_num;   /* valid for DR SMPs on switch only */
 		} ud;


