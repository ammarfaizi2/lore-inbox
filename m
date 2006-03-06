Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752404AbWCFTEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbWCFTEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbWCFTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:04:29 -0500
Received: from fmr19.intel.com ([134.134.136.18]:19930 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751231AbWCFTE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:04:28 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: [PATCH 2/6] IB: match connection requests based on private data
Date: Mon, 6 Mar 2006 11:04:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <adaslpz2l9p.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACOopXw
Message-ID: <ORSMSX401FRaqbC8wSA00000005@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 06 Mar 2006 19:04:09.0291 (UTC) FILETIME=[BF83C1B0:01C64150]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend matching connection requests to listens in the Infiniband CM to include
private data checks.

This allows applications to listen on the same service identifier, with private
data directing the request to the appropriate application.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>

---

diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/cm.c 
linux-2.6.ib/drivers/infiniband/core/cm.c
--- linux-2.6.git/drivers/infiniband/core/cm.c	2006-01-16 10:25:26.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/cm.c	2006-01-16 16:03:35.000000000 -0800
@@ -32,7 +32,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: cm.c 2821 2005-07-08 17:07:28Z sean.hefty $
+ * $Id: cm.c 4311 2005-12-05 18:42:01Z sean.hefty $
  */
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -130,6 +130,7 @@ struct cm_id_private {
 	/* todo: use alternate port on send failure */
 	struct cm_av av;
 	struct cm_av alt_av;
+	struct ib_cm_private_data_compare *compare_data;
 
 	void *private_data;
 	__be64 tid;
@@ -355,6 +356,40 @@ static struct cm_id_private * cm_acquire
 	return cm_id_priv;
 }
 
+static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)
+{
+	int i;
+
+	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE; i++)
+		dst[i] = src[i] & mask[i];
+}
+
+static int cm_compare_data(struct ib_cm_private_data_compare *src_data,
+			   struct ib_cm_private_data_compare *dst_data)
+{
+	u8 src[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
+	u8 dst[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
+
+	if (!src_data || !dst_data)
+		return 0;
+	
+	cm_mask_compare_data(src, src_data->data, dst_data->mask);
+	cm_mask_compare_data(dst, dst_data->data, src_data->mask);
+	return memcmp(src, dst, IB_CM_PRIVATE_DATA_COMPARE_SIZE);
+}
+
+static int cm_compare_private_data(u8 *private_data,
+				   struct ib_cm_private_data_compare *dst_data)
+{
+	u8 src[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
+
+	if (!dst_data)
+		return 0;
+	
+	cm_mask_compare_data(src, private_data, dst_data->mask);
+	return memcmp(src, dst_data->data, IB_CM_PRIVATE_DATA_COMPARE_SIZE);
+}
+
 static struct cm_id_private * cm_insert_listen(struct cm_id_private *cm_id_priv)
 {
 	struct rb_node **link = &cm.listen_service_table.rb_node;
@@ -362,14 +397,18 @@ static struct cm_id_private * cm_insert_
 	struct cm_id_private *cur_cm_id_priv;
 	__be64 service_id = cm_id_priv->id.service_id;
 	__be64 service_mask = cm_id_priv->id.service_mask;
+	int data_cmp;
 
 	while (*link) {
 		parent = *link;
 		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
 					  service_node);
+		data_cmp = cm_compare_data(cm_id_priv->compare_data,
+					   cur_cm_id_priv->compare_data);
 		if ((cur_cm_id_priv->id.service_mask & service_id) ==
 		    (service_mask & cur_cm_id_priv->id.service_id) &&
-		    (cm_id_priv->id.device == cur_cm_id_priv->id.device))
+		    (cm_id_priv->id.device == cur_cm_id_priv->id.device) &&
+		    !data_cmp)
 			return cur_cm_id_priv;
 
 		if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
@@ -378,6 +417,10 @@ static struct cm_id_private * cm_insert_
 			link = &(*link)->rb_right;
 		else if (service_id < cur_cm_id_priv->id.service_id)
 			link = &(*link)->rb_left;
+		else if (service_id > cur_cm_id_priv->id.service_id)
+			link = &(*link)->rb_right;
+		else if (data_cmp < 0)
+			link = &(*link)->rb_left;
 		else
 			link = &(*link)->rb_right;
 	}
@@ -387,16 +430,20 @@ static struct cm_id_private * cm_insert_
 }
 
 static struct cm_id_private * cm_find_listen(struct ib_device *device,
-					     __be64 service_id)
+					     __be64 service_id,
+					     u8 *private_data)
 {
 	struct rb_node *node = cm.listen_service_table.rb_node;
 	struct cm_id_private *cm_id_priv;
+	int data_cmp;
 
 	while (node) {
 		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
+		data_cmp = cm_compare_private_data(private_data,
+						   cm_id_priv->compare_data);
 		if ((cm_id_priv->id.service_mask & service_id) ==
 		     cm_id_priv->id.service_id &&
-		    (cm_id_priv->id.device == device))
+		    (cm_id_priv->id.device == device) && !data_cmp)
 			return cm_id_priv;
 
 		if (device < cm_id_priv->id.device)
@@ -405,6 +452,10 @@ static struct cm_id_private * cm_find_li
 			node = node->rb_right;
 		else if (service_id < cm_id_priv->id.service_id)
 			node = node->rb_left;
+		else if (service_id > cm_id_priv->id.service_id)
+			node = node->rb_right;
+		else if (data_cmp < 0)
+			node = node->rb_left;
 		else
 			node = node->rb_right;
 	}
@@ -728,15 +779,14 @@ retest:
 	wait_event(cm_id_priv->wait, !atomic_read(&cm_id_priv->refcount));
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
-	if (cm_id_priv->private_data && cm_id_priv->private_data_len)
-		kfree(cm_id_priv->private_data);
+	kfree(cm_id_priv->compare_data);
+	kfree(cm_id_priv->private_data);
 	kfree(cm_id_priv);
 }
 EXPORT_SYMBOL(ib_destroy_cm_id);
 
-int ib_cm_listen(struct ib_cm_id *cm_id,
-		 __be64 service_id,
-		 __be64 service_mask)
+int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask,
+		 struct ib_cm_private_data_compare *compare_data)
 {
 	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
 	unsigned long flags;
@@ -750,7 +800,19 @@ int ib_cm_listen(struct ib_cm_id *cm_id,
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	BUG_ON(cm_id->state != IB_CM_IDLE);
+	if (cm_id->state != IB_CM_IDLE)
+		return -EINVAL;
+
+	if (compare_data) {
+		cm_id_priv->compare_data = kzalloc(sizeof *compare_data,
+						   GFP_KERNEL);
+		if (!cm_id_priv->compare_data)
+			return -ENOMEM;
+		cm_mask_compare_data(cm_id_priv->compare_data->data,
+				     compare_data->data, compare_data->mask);
+		memcpy(cm_id_priv->compare_data->mask, compare_data->mask,
+		       IB_CM_PRIVATE_DATA_COMPARE_SIZE);
+	}
 
 	cm_id->state = IB_CM_LISTEN;
 
@@ -767,6 +829,8 @@ int ib_cm_listen(struct ib_cm_id *cm_id,
 
 	if (cur_cm_id_priv) {
 		cm_id->state = IB_CM_IDLE;
+		kfree(cm_id_priv->compare_data);
+		cm_id_priv->compare_data = NULL;
 		ret = -EBUSY;
 	}
 	return ret;
@@ -1239,7 +1303,8 @@ static struct cm_id_private * cm_match_r
 
 	/* Find matching listen request. */
 	listen_cm_id_priv = cm_find_listen(cm_id_priv->id.device,
-					   req_msg->service_id);
+					   req_msg->service_id,
+					   req_msg->private_data);
 	if (!listen_cm_id_priv) {
 		spin_unlock_irqrestore(&cm.lock, flags);
 		cm_issue_rej(work->port, work->mad_recv_wc,
@@ -2646,7 +2711,8 @@ static int cm_sidr_req_handler(struct cm
 		goto out; /* Duplicate message. */
 	}
 	cur_cm_id_priv = cm_find_listen(cm_id->device,
-					sidr_req_msg->service_id);
+					sidr_req_msg->service_id,
+					sidr_req_msg->private_data);
 	if (!cur_cm_id_priv) {
 		rb_erase(&cm_id_priv->sidr_id_node, &cm.remote_sidr_table);
 		spin_unlock_irqrestore(&cm.lock, flags);
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/ucm.c 
linux-2.6.ib/drivers/infiniband/core/ucm.c
--- linux-2.6.git/drivers/infiniband/core/ucm.c	2006-01-16 16:03:08.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/ucm.c	2006-01-16 16:03:35.000000000 -0800
@@ -646,6 +646,17 @@ out:
 	return result;
 }
 
+static int ucm_validate_listen(__be64 service_id, __be64 service_mask)
+{
+	service_id &= service_mask;
+
+	if (((service_id & IB_CMA_SERVICE_ID_MASK) == IB_CMA_SERVICE_ID) ||
+	    ((service_id & IB_SDP_SERVICE_ID_MASK) == IB_SDP_SERVICE_ID))
+		return -EINVAL;
+
+	return 0;
+}
+
 static ssize_t ib_ucm_listen(struct ib_ucm_file *file,
 			     const char __user *inbuf,
 			     int in_len, int out_len)
@@ -661,7 +672,13 @@ static ssize_t ib_ucm_listen(struct ib_u
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	result = ib_cm_listen(ctx->cm_id, cmd.service_id, cmd.service_mask);
+	result = ucm_validate_listen(cmd.service_id, cmd.service_mask);
+	if (result)
+		goto out;
+
+	result = ib_cm_listen(ctx->cm_id, cmd.service_id, cmd.service_mask,
+			      NULL);
+out:
 	ib_ucm_ctx_put(ctx);
 	return result;
 }
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_cm.h 
linux-2.6.ib/include/rdma/ib_cm.h
--- linux-2.6.git/include/rdma/ib_cm.h	2006-01-16 10:26:47.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_cm.h	2006-01-16 16:03:35.000000000 -0800
@@ -32,7 +32,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_cm.h 2730 2005-06-28 16:43:03Z sean.hefty $
+ * $Id: ib_cm.h 4311 2005-12-05 18:42:01Z sean.hefty $
  */
 #if !defined(IB_CM_H)
 #define IB_CM_H
@@ -102,7 +102,8 @@ enum ib_cm_data_size {
 	IB_CM_APR_INFO_LENGTH		 = 72,
 	IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE = 216,
 	IB_CM_SIDR_REP_PRIVATE_DATA_SIZE = 136,
-	IB_CM_SIDR_REP_INFO_LENGTH	 = 72
+	IB_CM_SIDR_REP_INFO_LENGTH	 = 72,
+	IB_CM_PRIVATE_DATA_COMPARE_SIZE	 = 64
 };
 
 struct ib_cm_id;
@@ -238,7 +239,6 @@ struct ib_cm_sidr_rep_event_param {
 	u32			qpn;
 	void			*info;
 	u8			info_len;
-
 };
 
 struct ib_cm_event {
@@ -317,6 +317,15 @@ void ib_destroy_cm_id(struct ib_cm_id *c
 
 #define IB_SERVICE_ID_AGN_MASK	__constant_cpu_to_be64(0xFF00000000000000ULL)
 #define IB_CM_ASSIGN_SERVICE_ID __constant_cpu_to_be64(0x0200000000000000ULL)
+#define IB_CMA_SERVICE_ID	__constant_cpu_to_be64(0x0000000001000000ULL)
+#define IB_CMA_SERVICE_ID_MASK	__constant_cpu_to_be64(0xFFFFFFFFFF000000ULL)
+#define IB_SDP_SERVICE_ID	__constant_cpu_to_be64(0x0000000000010000ULL)
+#define IB_SDP_SERVICE_ID_MASK	__constant_cpu_to_be64(0xFFFFFFFFFFFF0000ULL)
+
+struct ib_cm_private_data_compare {
+	u8  data[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
+	u8  mask[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
+};
 
 /**
  * ib_cm_listen - Initiates listening on the specified service ID for
@@ -330,10 +339,12 @@ void ib_destroy_cm_id(struct ib_cm_id *c
  *   range of service IDs.  If set to 0, the service ID is matched
  *   exactly.  This parameter is ignored if %service_id is set to
  *   IB_CM_ASSIGN_SERVICE_ID.
+ * @compare_data: This parameter is optional.  It specifies data that must
+ *   appear in the private data of a connection request for the specified
+ *   listen request.
  */
-int ib_cm_listen(struct ib_cm_id *cm_id,
-		 __be64 service_id,
-		 __be64 service_mask);
+int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask,
+		 struct ib_cm_private_data_compare *compare_data);
 
 struct ib_cm_req_param {
 	struct ib_sa_path_rec	*primary_path;



