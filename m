Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVGKOyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVGKOyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGKOwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:52:01 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:9415 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261891AbVGKOut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:50:49 -0400
Subject: [PATCH 20/27] Add Service Record support to SA client
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089173.4389.4545.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:43:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Service Record support to SA client

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 19/27.

-- 
 core/sa_query.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/ib_sa.h |   75 ++++++++++++++++++++++++-
 2 files changed, 236 insertions(+), 5 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband19/core/sa_query.c linux-2.6.13-rc2-mm1/drivers/infiniband20/core/sa_query.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband19/core/sa_query.c	2005-07-10 16:22:18.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband20/core/sa_query.c	2005-07-10 16:41:32.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Voltaire, Inc.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: sa_query.c 1389 2004-12-27 22:56:47Z roland $
+ * $Id: sa_query.c 2811 2005-07-06 18:11:43Z halr $
  */
 
 #include <linux/module.h>
@@ -79,6 +80,12 @@ struct ib_sa_query {
 	int                 id;
 };
 
+struct ib_sa_service_query {
+	void (*callback)(int, struct ib_sa_service_rec *, void *);
+	void *context;
+	struct ib_sa_query sa_query;
+};
+
 struct ib_sa_path_query {
 	void (*callback)(int, struct ib_sa_path_rec *, void *);
 	void *context;
@@ -320,6 +327,54 @@ static const struct ib_field mcmember_re
 	  .size_bits    = 23 },
 };
 
+#define SERVICE_REC_FIELD(field) \
+	.struct_offset_bytes = offsetof(struct ib_sa_service_rec, field),	\
+	.struct_size_bytes   = sizeof ((struct ib_sa_service_rec *) 0)->field,	\
+	.field_name          = "sa_service_rec:" #field
+
+static const struct ib_field service_rec_table[] = {
+	{ SERVICE_REC_FIELD(id),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 64 },
+	{ SERVICE_REC_FIELD(gid),
+	  .offset_words = 2,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(pkey),
+	  .offset_words = 6,
+	  .offset_bits  = 0,
+	  .size_bits    = 16 },
+	{ SERVICE_REC_FIELD(lease),
+	  .offset_words = 7,
+	  .offset_bits  = 0,
+	  .size_bits    = 32 },
+	{ SERVICE_REC_FIELD(key),
+	  .offset_words = 8,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(name),
+	  .offset_words = 12,
+	  .offset_bits  = 0,
+	  .size_bits    = 64*8 },
+	{ SERVICE_REC_FIELD(data8),
+	  .offset_words = 28,
+	  .offset_bits  = 0,
+	  .size_bits    = 16*8 },
+	{ SERVICE_REC_FIELD(data16),
+	  .offset_words = 32,
+	  .offset_bits  = 0,
+	  .size_bits    = 8*16 },
+	{ SERVICE_REC_FIELD(data32),
+	  .offset_words = 36,
+	  .offset_bits  = 0,
+	  .size_bits    = 4*32 },
+	{ SERVICE_REC_FIELD(data64),
+	  .offset_words = 40,
+	  .offset_bits  = 0,
+	  .size_bits    = 2*64 },
+};
+
 static void free_sm_ah(struct kref *kref)
 {
 	struct ib_sa_sm_ah *sm_ah = container_of(kref, struct ib_sa_sm_ah, ref);
@@ -443,7 +498,6 @@ static int send_mad(struct ib_sa_query *
 				 .remote_qpn  = 1,
 				 .remote_qkey = IB_QP1_QKEY,
 				 .timeout_ms  = timeout_ms,
-				 .retries     = 0 
 			 }
 		 }
 	};
@@ -596,6 +650,114 @@ int ib_sa_path_rec_get(struct ib_device 
 }
 EXPORT_SYMBOL(ib_sa_path_rec_get);
 
+static void ib_sa_service_rec_callback(struct ib_sa_query *sa_query,
+				    int status,
+				    struct ib_sa_mad *mad)
+{
+	struct ib_sa_service_query *query =
+		container_of(sa_query, struct ib_sa_service_query, sa_query);
+
+	if (mad) {
+		struct ib_sa_service_rec rec;
+
+		ib_unpack(service_rec_table, ARRAY_SIZE(service_rec_table),
+			  mad->data, &rec);
+		query->callback(status, &rec, query->context);
+	} else
+		query->callback(status, NULL, query->context);
+}
+
+static void ib_sa_service_rec_release(struct ib_sa_query *sa_query)
+{
+	kfree(sa_query->mad);
+	kfree(container_of(sa_query, struct ib_sa_service_query, sa_query));
+}
+
+/**
+ * ib_sa_service_rec_query - Start Service Record operation
+ * @device:device to send request on
+ * @port_num: port number to send request on
+ * @method:SA method - should be get, set, or delete
+ * @rec:Service Record to send in request
+ * @comp_mask:component mask to send in request
+ * @timeout_ms:time to wait for response
+ * @gfp_mask:GFP mask to use for internal allocations
+ * @callback:function called when request completes, times out or is
+ * canceled
+ * @context:opaque user context passed to callback
+ * @sa_query:request context, used to cancel request
+ *
+ * Send a Service Record set/get/delete to the SA to register,
+ * unregister or query a service record.
+ * The callback function will be called when the request completes (or
+ * fails); status is 0 for a successful response, -EINTR if the query
+ * is canceled, -ETIMEDOUT is the query timed out, or -EIO if an error
+ * occurred sending the query.  The resp parameter of the callback is
+ * only valid if status is 0.
+ *
+ * If the return value of ib_sa_service_rec_query() is negative, it is an
+ * error code.  Otherwise it is a request ID that can be used to cancel
+ * the query.
+ */
+int ib_sa_service_rec_query(struct ib_device *device, u8 port_num, u8 method,
+			    struct ib_sa_service_rec *rec,
+			    ib_sa_comp_mask comp_mask,
+			    int timeout_ms, int gfp_mask,
+			    void (*callback)(int status,
+					     struct ib_sa_service_rec *resp,
+					     void *context),
+			    void *context,
+			    struct ib_sa_query **sa_query)
+{
+	struct ib_sa_service_query *query;
+	struct ib_sa_device *sa_dev = ib_get_client_data(device, &sa_client);
+	struct ib_sa_port   *port   = &sa_dev->port[port_num - sa_dev->start_port];
+	struct ib_mad_agent *agent  = port->agent;
+	int ret;
+
+	if (method != IB_MGMT_METHOD_GET &&
+	    method != IB_MGMT_METHOD_SET &&
+	    method != IB_SA_METHOD_DELETE)
+		return -EINVAL;
+
+	query = kmalloc(sizeof *query, gfp_mask);
+	if (!query)
+		return -ENOMEM;
+	query->sa_query.mad = kmalloc(sizeof *query->sa_query.mad, gfp_mask);
+	if (!query->sa_query.mad) {
+		kfree(query);
+		return -ENOMEM;
+	}
+
+	query->callback = callback;
+	query->context  = context;
+
+	init_mad(query->sa_query.mad, agent);
+
+	query->sa_query.callback              = callback ? ib_sa_service_rec_callback : NULL;
+	query->sa_query.release               = ib_sa_service_rec_release;
+	query->sa_query.port                  = port;
+	query->sa_query.mad->mad_hdr.method   = method;
+	query->sa_query.mad->mad_hdr.attr_id  =
+				cpu_to_be16(IB_SA_ATTR_SERVICE_REC);
+	query->sa_query.mad->sa_hdr.comp_mask = comp_mask;
+
+	ib_pack(service_rec_table, ARRAY_SIZE(service_rec_table),
+		rec, query->sa_query.mad->data);
+
+	*sa_query = &query->sa_query;
+
+	ret = send_mad(&query->sa_query, timeout_ms);
+	if (ret < 0) {
+		*sa_query = NULL;
+		kfree(query->sa_query.mad);
+		kfree(query);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_sa_service_rec_query);
+
 static void ib_sa_mcmember_rec_callback(struct ib_sa_query *sa_query,
 					int status,
 					struct ib_sa_mad *mad)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband19/include/ib_sa.h linux-2.6.13-rc2-mm1/drivers/infiniband20/include/ib_sa.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband19/include/ib_sa.h	2005-07-10 12:07:41.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband20/include/ib_sa.h	2005-07-10 16:40:43.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Voltaire, Inc.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_sa.h 1389 2004-12-27 22:56:47Z roland $
+ * $Id: ib_sa.h 2811 2005-07-06 18:11:43Z halr $
  */
 
 #ifndef IB_SA_H
@@ -41,9 +42,11 @@
 #include <ib_mad.h>
 
 enum {
-	IB_SA_CLASS_VERSION	= 2,	/* IB spec version 1.1/1.2 */
+	IB_SA_CLASS_VERSION		= 2,	/* IB spec version 1.1/1.2 */
 
-	IB_SA_METHOD_DELETE	= 0x15
+	IB_SA_METHOD_GET_TABLE		= 0x12,
+	IB_SA_METHOD_GET_TABLE_RESP	= 0x92,
+	IB_SA_METHOD_DELETE		= 0x15
 };
 
 enum ib_sa_selector {
@@ -191,6 +194,61 @@ struct ib_sa_mcmember_rec {
 	int          proxy_join;
 };
 
+/* Service Record Component Mask Sec 15.2.5.14 Ver 1.1	*/
+#define IB_SA_SERVICE_REC_SERVICE_ID			IB_SA_COMP_MASK( 0)
+#define IB_SA_SERVICE_REC_SERVICE_GID			IB_SA_COMP_MASK( 1)
+#define IB_SA_SERVICE_REC_SERVICE_PKEY			IB_SA_COMP_MASK( 2)
+/* reserved:								 3 */
+#define IB_SA_SERVICE_REC_SERVICE_LEASE			IB_SA_COMP_MASK( 4)
+#define IB_SA_SERVICE_REC_SERVICE_KEY			IB_SA_COMP_MASK( 5)
+#define IB_SA_SERVICE_REC_SERVICE_NAME			IB_SA_COMP_MASK( 6)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_0		IB_SA_COMP_MASK( 7)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_1		IB_SA_COMP_MASK( 8)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_2		IB_SA_COMP_MASK( 9)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_3		IB_SA_COMP_MASK(10)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_4		IB_SA_COMP_MASK(11)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_5		IB_SA_COMP_MASK(12)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_6		IB_SA_COMP_MASK(13)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_7		IB_SA_COMP_MASK(14)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_8		IB_SA_COMP_MASK(15)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_9		IB_SA_COMP_MASK(16)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_10		IB_SA_COMP_MASK(17)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_11		IB_SA_COMP_MASK(18)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_12		IB_SA_COMP_MASK(19)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_13		IB_SA_COMP_MASK(20)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_14		IB_SA_COMP_MASK(21)
+#define IB_SA_SERVICE_REC_SERVICE_DATA8_15		IB_SA_COMP_MASK(22)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_0		IB_SA_COMP_MASK(23)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_1		IB_SA_COMP_MASK(24)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_2		IB_SA_COMP_MASK(25)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_3		IB_SA_COMP_MASK(26)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_4		IB_SA_COMP_MASK(27)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_5		IB_SA_COMP_MASK(28)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_6		IB_SA_COMP_MASK(29)
+#define IB_SA_SERVICE_REC_SERVICE_DATA16_7		IB_SA_COMP_MASK(30)
+#define IB_SA_SERVICE_REC_SERVICE_DATA32_0		IB_SA_COMP_MASK(31)
+#define IB_SA_SERVICE_REC_SERVICE_DATA32_1		IB_SA_COMP_MASK(32)
+#define IB_SA_SERVICE_REC_SERVICE_DATA32_2		IB_SA_COMP_MASK(33)
+#define IB_SA_SERVICE_REC_SERVICE_DATA32_3		IB_SA_COMP_MASK(34)
+#define IB_SA_SERVICE_REC_SERVICE_DATA64_0		IB_SA_COMP_MASK(35)
+#define IB_SA_SERVICE_REC_SERVICE_DATA64_1		IB_SA_COMP_MASK(36)
+
+#define IB_DEFAULT_SERVICE_LEASE 	0xFFFFFFFF
+
+struct ib_sa_service_rec {
+	u64		id;
+	union ib_gid	gid;		
+	u16 		pkey;
+	/* reserved */
+	u32		lease;
+	u8		key[16];
+	u8		name[64];
+	u8		data8[16];
+	u16		data16[8];
+	u32		data32[4];
+	u64		data64[2];
+};
+
 struct ib_sa_query;
 
 void ib_sa_cancel_query(int id, struct ib_sa_query *query);
@@ -216,6 +274,17 @@ int ib_sa_mcmember_rec_query(struct ib_d
 			     void *context,
 			     struct ib_sa_query **query);
 
+int ib_sa_service_rec_query(struct ib_device *device, u8 port_num,
+			 u8 method,
+			 struct ib_sa_service_rec *rec,
+			 ib_sa_comp_mask comp_mask,
+			 int timeout_ms, int gfp_mask,
+			 void (*callback)(int status,
+					  struct ib_sa_service_rec *resp,
+					  void *context),
+			 void *context,
+			 struct ib_sa_query **sa_query);
+
 /**
  * ib_sa_mcmember_rec_set - Start an MCMember set query
  * @device:device to send query on


