Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757272AbWK1W5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbWK1W5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbWK1W5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:57:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:15776 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1755518AbWK1W5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:57:44 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,471,1157353200"; 
   d="scan'208"; a="167579549:sNHT6001870791"
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <openib-general@openib.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] for 2.6.20 infiniband/ib_cm: fix path migration support
Date: Tue, 28 Nov 2006 14:57:13 -0800
Message-ID: <000601c71340$8b5078d0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccTJfz8Kw1rbjQKQGGCzZaouQ7S5QAGVpVQ
In-Reply-To: <aday7pvtkxf.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-OriginalArrivalTime: 28 Nov 2006 22:57:14.0386 (UTC) FILETIME=[8B932720:01C71340]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues in the ib_cm regarding support for path migration over infiniband.

The ib_cm_establish() call is replaced with a more generic ib_cm_notify().
This routine is used to notify the CM that failover has occurred, so that
future CM messages (LAP, DREQ) reach the remote CM.  (Currently, we 
continue to use the original path.)  This bumps the userspace ABI.

New alternate path information is captured when a LAP message is sent or
received.  This allows QP attributes to be initialized for the user when a
new path is loaded after failover occurs.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
---
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1cf0d42..ed69573 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -147,12 +147,12 @@ struct cm_id_private {
 	__be32 rq_psn;
 	int timeout_ms;
 	enum ib_mtu path_mtu;
+	__be16 pkey;
 	u8 private_data_len;
 	u8 max_cm_retries;
 	u8 peer_to_peer;
 	u8 responder_resources;
 	u8 initiator_depth;
-	u8 local_ack_timeout;
 	u8 retry_count;
 	u8 rnr_retry_count;
 	u8 service_timeout;
@@ -691,7 +691,7 @@ static void cm_enter_timewait(struct cm_
 	 * timewait before notifying the user that we've exited timewait.
 	 */
 	cm_id_priv->id.state = IB_CM_TIMEWAIT;
-	wait_time = cm_convert_to_ms(cm_id_priv->local_ack_timeout);
+	wait_time = cm_convert_to_ms(cm_id_priv->av.packet_life_time + 1);
 	queue_delayed_work(cm.wq, &cm_id_priv->timewait_info->work.work,
 			   msecs_to_jiffies(wait_time));
 	cm_id_priv->timewait_info = NULL;
@@ -1010,6 +1010,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_i
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->retry_count = param->retry_count;
 	cm_id_priv->path_mtu = param->primary_path->mtu;
+	cm_id_priv->pkey = param->primary_path->pkey;
 	cm_id_priv->qp_type = param->qp_type;
 
 	ret = cm_alloc_msg(cm_id_priv, &cm_id_priv->msg);
@@ -1024,8 +1025,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_i
 
 	cm_id_priv->local_qpn = cm_req_get_local_qpn(req_msg);
 	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
-	cm_id_priv->local_ack_timeout =
-				cm_req_get_primary_local_ack_timeout(req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
@@ -1410,9 +1409,8 @@ static int cm_req_handler(struct cm_work
 	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
+	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
-	cm_id_priv->local_ack_timeout =
-				cm_req_get_primary_local_ack_timeout(req_msg);
 	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
@@ -1716,7 +1714,7 @@ static int cm_establish_handler(struct c
 	unsigned long flags;
 	int ret;
 
-	/* See comment in ib_cm_establish about lookup. */
+	/* See comment in cm_establish about lookup. */
 	cm_id_priv = cm_acquire_id(work->local_id, work->remote_id);
 	if (!cm_id_priv)
 		return -EINVAL;
@@ -2402,11 +2400,16 @@ int ib_send_cm_lap(struct ib_cm_id *cm_i
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_ESTABLISHED ||
-	    cm_id->lap_state != IB_CM_LAP_IDLE) {
+	    (cm_id->lap_state != IB_CM_LAP_UNINIT &&
+	     cm_id->lap_state != IB_CM_LAP_IDLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	ret = cm_init_av_by_path(alternate_path, &cm_id_priv->alt_av);
+	if (ret)
+		goto out;
+
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret)
 		goto out;
@@ -2431,7 +2434,8 @@ out:	spin_unlock_irqrestore(&cm_id_priv-
 }
 EXPORT_SYMBOL(ib_send_cm_lap);
 
-static void cm_format_path_from_lap(struct ib_sa_path_rec *path,
+static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
+				    struct ib_sa_path_rec *path,
 				    struct cm_lap_msg *lap_msg)
 {
 	memset(path, 0, sizeof *path);
@@ -2443,10 +2447,10 @@ static void cm_format_path_from_lap(stru
 	path->hop_limit = lap_msg->alt_hop_limit;
 	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
 	path->reversible = 1;
-	/* pkey is same as in REQ */
+	path->pkey = cm_id_priv->pkey;
 	path->sl = cm_lap_get_sl(lap_msg);
 	path->mtu_selector = IB_SA_EQ;
-	/* mtu is same as in REQ */
+	path->mtu = cm_id_priv->path_mtu;
 	path->rate_selector = IB_SA_EQ;
 	path->rate = cm_lap_get_packet_rate(lap_msg);
 	path->packet_life_time_selector = IB_SA_EQ;
@@ -2472,7 +2476,7 @@ static int cm_lap_handler(struct cm_work
 
 	param = &work->cm_event.param.lap_rcvd;
 	param->alternate_path = &work->path[0];
-	cm_format_path_from_lap(param->alternate_path, lap_msg);
+	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
 	work->cm_event.private_data = &lap_msg->private_data;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
@@ -2480,6 +2484,7 @@ static int cm_lap_handler(struct cm_work
 		goto unlock;
 
 	switch (cm_id_priv->id.lap_state) {
+	case IB_CM_LAP_UNINIT:
 	case IB_CM_LAP_IDLE:
 		break;
 	case IB_CM_MRA_LAP_SENT:
@@ -2502,6 +2507,10 @@ static int cm_lap_handler(struct cm_work
 
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
+	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				work->mad_recv_wc->recv_buf.grh,
+				&cm_id_priv->av);
+	cm_init_av_by_path(param->alternate_path, &cm_id_priv->alt_av);
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
 		list_add_tail(&work->list, &cm_id_priv->work_list);
@@ -3040,7 +3049,7 @@ static void cm_work_handler(void *data)
 		cm_free_work(work);
 }
 
-int ib_cm_establish(struct ib_cm_id *cm_id)
+static int cm_establish(struct ib_cm_id *cm_id)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
@@ -3088,7 +3097,44 @@ int ib_cm_establish(struct ib_cm_id *cm_
 out:
 	return ret;
 }
-EXPORT_SYMBOL(ib_cm_establish);
+
+static int cm_migrate(struct ib_cm_id *cm_id)
+{
+	struct cm_id_private *cm_id_priv;
+	unsigned long flags;
+	int ret = 0;
+
+	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id->state == IB_CM_ESTABLISHED &&
+	    (cm_id->lap_state == IB_CM_LAP_UNINIT ||
+	     cm_id->lap_state == IB_CM_LAP_IDLE)) {
+		cm_id->lap_state = IB_CM_LAP_IDLE;
+		cm_id_priv->av = cm_id_priv->alt_av;
+	} else
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+
+	return ret;
+}
+
+int ib_cm_notify(struct ib_cm_id *cm_id, enum ib_event_type event)
+{
+	int ret;
+
+	switch (event) {
+	case IB_EVENT_COMM_EST:
+		ret = cm_establish(cm_id);
+		break;
+	case IB_EVENT_PATH_MIG:
+		ret = cm_migrate(cm_id);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(ib_cm_notify);
 
 static void cm_recv_handler(struct ib_mad_agent *mad_agent,
 			    struct ib_mad_recv_wc *mad_recv_wc)
@@ -3221,6 +3267,9 @@ static int cm_init_qp_rtr_attr(struct cm
 		if (cm_id_priv->alt_av.ah_attr.dlid) {
 			*qp_attr_mask |= IB_QP_ALT_PATH;
 			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
+			qp_attr->alt_timeout =
+					cm_id_priv->alt_av.packet_life_time + 1;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
 		}
 		ret = 0;
@@ -3247,19 +3296,31 @@ static int cm_init_qp_rts_attr(struct cm
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
 	case IB_CM_ESTABLISHED:
-		*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
-		qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
-		if (cm_id_priv->qp_type == IB_QPT_RC) {
-			*qp_attr_mask |= IB_QP_TIMEOUT | IB_QP_RETRY_CNT |
-					 IB_QP_RNR_RETRY |
-					 IB_QP_MAX_QP_RD_ATOMIC;
-			qp_attr->timeout = cm_id_priv->local_ack_timeout;
-			qp_attr->retry_cnt = cm_id_priv->retry_count;
-			qp_attr->rnr_retry = cm_id_priv->rnr_retry_count;
-			qp_attr->max_rd_atomic = cm_id_priv->initiator_depth;
-		}
-		if (cm_id_priv->alt_av.ah_attr.dlid) {
-			*qp_attr_mask |= IB_QP_PATH_MIG_STATE;
+		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT) {
+			*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
+			qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
+			if (cm_id_priv->qp_type == IB_QPT_RC) {
+				*qp_attr_mask |= IB_QP_TIMEOUT | IB_QP_RETRY_CNT |
+						 IB_QP_RNR_RETRY |
+						 IB_QP_MAX_QP_RD_ATOMIC;
+				qp_attr->timeout =
+					cm_id_priv->av.packet_life_time + 1;
+				qp_attr->retry_cnt = cm_id_priv->retry_count;
+				qp_attr->rnr_retry = cm_id_priv->rnr_retry_count;
+				qp_attr->max_rd_atomic =
+					cm_id_priv->initiator_depth;
+			}
+			if (cm_id_priv->alt_av.ah_attr.dlid) {
+				*qp_attr_mask |= IB_QP_PATH_MIG_STATE;
+				qp_attr->path_mig_state = IB_MIG_REARM;
+			}
+		} else {
+			*qp_attr_mask = IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE;
+			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
+			qp_attr->alt_timeout =
+				cm_id_priv->alt_av.packet_life_time + 1;
+			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
 			qp_attr->path_mig_state = IB_MIG_REARM;
 		}
 		ret = 0;
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index ad4f4d5..e04f662 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -685,11 +685,11 @@ out:
 	return result;
 }
 
-static ssize_t ib_ucm_establish(struct ib_ucm_file *file,
-				const char __user *inbuf,
-				int in_len, int out_len)
+static ssize_t ib_ucm_notify(struct ib_ucm_file *file,
+			     const char __user *inbuf,
+			     int in_len, int out_len)
 {
-	struct ib_ucm_establish cmd;
+	struct ib_ucm_notify cmd;
 	struct ib_ucm_context *ctx;
 	int result;
 
@@ -700,7 +700,7 @@ static ssize_t ib_ucm_establish(struct i
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	result = ib_cm_establish(ctx->cm_id);
+	result = ib_cm_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
 	ib_ucm_ctx_put(ctx);
 	return result;
 }
@@ -1107,7 +1107,7 @@ static ssize_t (*ucm_cmd_table[])(struct
 	[IB_USER_CM_CMD_DESTROY_ID]    = ib_ucm_destroy_id,
 	[IB_USER_CM_CMD_ATTR_ID]       = ib_ucm_attr_id,
 	[IB_USER_CM_CMD_LISTEN]        = ib_ucm_listen,
-	[IB_USER_CM_CMD_ESTABLISH]     = ib_ucm_establish,
+	[IB_USER_CM_CMD_NOTIFY]        = ib_ucm_notify,
 	[IB_USER_CM_CMD_SEND_REQ]      = ib_ucm_send_req,
 	[IB_USER_CM_CMD_SEND_REP]      = ib_ucm_send_rep,
 	[IB_USER_CM_CMD_SEND_RTU]      = ib_ucm_send_rtu,
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index c9b4738..5c07017 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -60,6 +60,7 @@ enum ib_cm_state {
 };
 
 enum ib_cm_lap_state {
+	IB_CM_LAP_UNINIT,
 	IB_CM_LAP_IDLE,
 	IB_CM_LAP_SENT,
 	IB_CM_LAP_RCVD,
@@ -443,13 +444,20 @@ int ib_send_cm_drep(struct ib_cm_id *cm_
 		    u8 private_data_len);
 
 /**
- * ib_cm_establish - Forces a connection state to established.
+ * ib_cm_notify - Notifies the CM of an event reported to the consumer.
  * @cm_id: Connection identifier to transition to established.
+ * @event: Type of event.
  *
- * This routine should be invoked by users who receive messages on a
- * connected QP before an RTU has been received.
+ * This routine should be invoked by users to notify the CM of relevant
+ * communication events.  Events that should be reported to the CM and
+ * when to report them are:
+ *
+ * IB_EVENT_COMM_EST - Used when a message is received on a connected
+ *    QP before an RTU has been received.
+ * IB_EVENT_PATH_MIG - Notifies the CM that the connection has failed over
+ *   to the alternate path.
  */
-int ib_cm_establish(struct ib_cm_id *cm_id);
+int ib_cm_notify(struct ib_cm_id *cm_id, enum ib_event_type event);
 
 /**
  * ib_send_cm_rej - Sends a connection rejection message to the
diff --git a/include/rdma/ib_user_cm.h b/include/rdma/ib_user_cm.h
index 066c20b..37650af 100644
--- a/include/rdma/ib_user_cm.h
+++ b/include/rdma/ib_user_cm.h
@@ -38,7 +38,7 @@ #define IB_USER_CM_H
 
 #include <rdma/ib_user_sa.h>
 
-#define IB_USER_CM_ABI_VERSION 4
+#define IB_USER_CM_ABI_VERSION 5
 
 enum {
 	IB_USER_CM_CMD_CREATE_ID,
@@ -46,7 +46,7 @@ enum {
 	IB_USER_CM_CMD_ATTR_ID,
 
 	IB_USER_CM_CMD_LISTEN,
-	IB_USER_CM_CMD_ESTABLISH,
+	IB_USER_CM_CMD_NOTIFY,
 
 	IB_USER_CM_CMD_SEND_REQ,
 	IB_USER_CM_CMD_SEND_REP,
@@ -117,8 +117,9 @@ struct ib_ucm_listen {
 	__u32 reserved;
 };
 
-struct ib_ucm_establish {
+struct ib_ucm_notify {
 	__u32 id;
+	__u32 event;
 };
 
 struct ib_ucm_private_data {

