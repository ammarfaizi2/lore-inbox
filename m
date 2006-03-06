Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWCFS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWCFS7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWCFS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:59:13 -0500
Received: from fmr17.intel.com ([134.134.136.16]:17559 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751983AbWCFS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:59:10 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: [PATCH 1/6] IB: common handling for marshalling parameters to/from userspace
Date: Mon, 6 Mar 2006 10:59:07 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <adaslpz2l9p.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACOgpsQ
Message-ID: <ORSMSX401FRaqbC8wSA00000004@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 06 Mar 2006 18:59:08.0128 (UTC) FILETIME=[0C01EE00:01C64150]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Provide common handling for marshalling data between userspace clients
and kernel mode Infiniband drivers.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>

---

diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/Makefile 
linux-2.6.ib/drivers/infiniband/core/Makefile
--- linux-2.6.git/drivers/infiniband/core/Makefile	2006-01-16 10:25:27.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/Makefile	2006-01-16 15:34:15.000000000 -0800
@@ -16,4 +16,5 @@ ib_umad-y :=			user_mad.o
 
 ib_ucm-y :=			ucm.o
 
-ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_mem.o
+ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_mem.o \
+				uverbs_marshall.o
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/ucm.c 
linux-2.6.ib/drivers/infiniband/core/ucm.c
--- linux-2.6.git/drivers/infiniband/core/ucm.c	2006-01-16 10:25:26.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/ucm.c	2006-01-16 15:34:15.000000000 -0800
@@ -30,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ucm.c 2594 2005-06-13 19:46:02Z libor $
+ * $Id: ucm.c 4311 2005-12-05 18:42:01Z sean.hefty $
  */
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -48,6 +48,7 @@
 
 #include <rdma/ib_cm.h>
 #include <rdma/ib_user_cm.h>
+#include <rdma/ib_marshall.h>
 
 MODULE_AUTHOR("Libor Michalek");
 MODULE_DESCRIPTION("InfiniBand userspace Connection Manager access");
@@ -203,36 +204,6 @@ error:
 	return NULL;
 }
 
-static void ib_ucm_event_path_get(struct ib_ucm_path_rec *upath,
-				  struct ib_sa_path_rec	 *kpath)
-{
-	if (!kpath || !upath)
-		return;
-
-	memcpy(upath->dgid, kpath->dgid.raw, sizeof *upath->dgid);
-	memcpy(upath->sgid, kpath->sgid.raw, sizeof *upath->sgid);
-
-	upath->dlid             = kpath->dlid;
-	upath->slid             = kpath->slid;
-	upath->raw_traffic      = kpath->raw_traffic;
-	upath->flow_label       = kpath->flow_label;
-	upath->hop_limit        = kpath->hop_limit;
-	upath->traffic_class    = kpath->traffic_class;
-	upath->reversible       = kpath->reversible;
-	upath->numb_path        = kpath->numb_path;
-	upath->pkey             = kpath->pkey;
-	upath->sl	        = kpath->sl;
-	upath->mtu_selector     = kpath->mtu_selector;
-	upath->mtu              = kpath->mtu;
-	upath->rate_selector    = kpath->rate_selector;
-	upath->rate             = kpath->rate;
-	upath->packet_life_time = kpath->packet_life_time;
-	upath->preference       = kpath->preference;
-
-	upath->packet_life_time_selector =
-		kpath->packet_life_time_selector;
-}
-
 static void ib_ucm_event_req_get(struct ib_ucm_req_event_resp *ureq,
 				 struct ib_cm_req_event_param *kreq)
 {
@@ -251,8 +222,10 @@ static void ib_ucm_event_req_get(struct 
 	ureq->srq                        = kreq->srq;
 	ureq->port			 = kreq->port;
 
-	ib_ucm_event_path_get(&ureq->primary_path, kreq->primary_path);
-	ib_ucm_event_path_get(&ureq->alternate_path, kreq->alternate_path);
+	ib_copy_path_rec_to_user(&ureq->primary_path, kreq->primary_path);
+	if (kreq->alternate_path)
+		ib_copy_path_rec_to_user(&ureq->alternate_path,
+					 kreq->alternate_path);
 }
 
 static void ib_ucm_event_rep_get(struct ib_ucm_rep_event_resp *urep,
@@ -322,8 +295,8 @@ static int ib_ucm_event_process(struct i
 		info	      = evt->param.rej_rcvd.ari;
 		break;
 	case IB_CM_LAP_RECEIVED:
-		ib_ucm_event_path_get(&uvt->resp.u.lap_resp.path,
-				      evt->param.lap_rcvd.alternate_path);
+		ib_copy_path_rec_to_user(&uvt->resp.u.lap_resp.path,
+					 evt->param.lap_rcvd.alternate_path);
 		uvt->data_len = IB_CM_LAP_PRIVATE_DATA_SIZE;
 		uvt->resp.present = IB_UCM_PRES_ALTERNATE;
 		break;
@@ -635,65 +608,11 @@ static ssize_t ib_ucm_attr_id(struct ib_
 	return result;
 }
 
-static void ib_ucm_copy_ah_attr(struct ib_ucm_ah_attr *dest_attr,
-				struct ib_ah_attr *src_attr)
-{
-	memcpy(dest_attr->grh_dgid, src_attr->grh.dgid.raw,
-	       sizeof src_attr->grh.dgid);
-	dest_attr->grh_flow_label = src_attr->grh.flow_label;
-	dest_attr->grh_sgid_index = src_attr->grh.sgid_index;
-	dest_attr->grh_hop_limit = src_attr->grh.hop_limit;
-	dest_attr->grh_traffic_class = src_attr->grh.traffic_class;
-
-	dest_attr->dlid = src_attr->dlid;
-	dest_attr->sl = src_attr->sl;
-	dest_attr->src_path_bits = src_attr->src_path_bits;
-	dest_attr->static_rate = src_attr->static_rate;
-	dest_attr->is_global = (src_attr->ah_flags & IB_AH_GRH);
-	dest_attr->port_num = src_attr->port_num;
-}
-
-static void ib_ucm_copy_qp_attr(struct ib_ucm_init_qp_attr_resp *dest_attr,
-				struct ib_qp_attr *src_attr)
-{
-	dest_attr->cur_qp_state = src_attr->cur_qp_state;
-	dest_attr->path_mtu = src_attr->path_mtu;
-	dest_attr->path_mig_state = src_attr->path_mig_state;
-	dest_attr->qkey = src_attr->qkey;
-	dest_attr->rq_psn = src_attr->rq_psn;
-	dest_attr->sq_psn = src_attr->sq_psn;
-	dest_attr->dest_qp_num = src_attr->dest_qp_num;
-	dest_attr->qp_access_flags = src_attr->qp_access_flags;
-
-	dest_attr->max_send_wr = src_attr->cap.max_send_wr;
-	dest_attr->max_recv_wr = src_attr->cap.max_recv_wr;
-	dest_attr->max_send_sge = src_attr->cap.max_send_sge;
-	dest_attr->max_recv_sge = src_attr->cap.max_recv_sge;
-	dest_attr->max_inline_data = src_attr->cap.max_inline_data;
-
-	ib_ucm_copy_ah_attr(&dest_attr->ah_attr, &src_attr->ah_attr);
-	ib_ucm_copy_ah_attr(&dest_attr->alt_ah_attr, &src_attr->alt_ah_attr);
-
-	dest_attr->pkey_index = src_attr->pkey_index;
-	dest_attr->alt_pkey_index = src_attr->alt_pkey_index;
-	dest_attr->en_sqd_async_notify = src_attr->en_sqd_async_notify;
-	dest_attr->sq_draining = src_attr->sq_draining;
-	dest_attr->max_rd_atomic = src_attr->max_rd_atomic;
-	dest_attr->max_dest_rd_atomic = src_attr->max_dest_rd_atomic;
-	dest_attr->min_rnr_timer = src_attr->min_rnr_timer;
-	dest_attr->port_num = src_attr->port_num;
-	dest_attr->timeout = src_attr->timeout;
-	dest_attr->retry_cnt = src_attr->retry_cnt;
-	dest_attr->rnr_retry = src_attr->rnr_retry;
-	dest_attr->alt_port_num = src_attr->alt_port_num;
-	dest_attr->alt_timeout = src_attr->alt_timeout;
-}
-
 static ssize_t ib_ucm_init_qp_attr(struct ib_ucm_file *file,
 				   const char __user *inbuf,
 				   int in_len, int out_len)
 {
-	struct ib_ucm_init_qp_attr_resp resp;
+	struct ib_uverbs_qp_attr resp;
 	struct ib_ucm_init_qp_attr cmd;
 	struct ib_ucm_context *ctx;
 	struct ib_qp_attr qp_attr;
@@ -716,7 +635,7 @@ static ssize_t ib_ucm_init_qp_attr(struc
 	if (result)
 		goto out;
 
-	ib_ucm_copy_qp_attr(&resp, &qp_attr);
+	ib_copy_qp_attr_to_user(&resp, &qp_attr);
 
 	if (copy_to_user((void __user *)(unsigned long)cmd.response,
 			 &resp, sizeof(resp)))
@@ -791,7 +710,7 @@ static int ib_ucm_alloc_data(const void 
 
 static int ib_ucm_path_get(struct ib_sa_path_rec **path, u64 src)
 {
-	struct ib_ucm_path_rec ucm_path;
+	struct ib_user_path_rec upath;
 	struct ib_sa_path_rec  *sa_path;
 
 	*path = NULL;
@@ -803,36 +722,14 @@ static int ib_ucm_path_get(struct ib_sa_
 	if (!sa_path)
 		return -ENOMEM;
 
-	if (copy_from_user(&ucm_path, (void __user *)(unsigned long)src,
-			   sizeof(ucm_path))) {
+	if (copy_from_user(&upath, (void __user *)(unsigned long)src,
+			   sizeof(upath))) {
 
 		kfree(sa_path);
 		return -EFAULT;
 	}
 
-	memcpy(sa_path->dgid.raw, ucm_path.dgid, sizeof sa_path->dgid);
-	memcpy(sa_path->sgid.raw, ucm_path.sgid, sizeof sa_path->sgid);
-
-	sa_path->dlid	          = ucm_path.dlid;
-	sa_path->slid	          = ucm_path.slid;
-	sa_path->raw_traffic      = ucm_path.raw_traffic;
-	sa_path->flow_label       = ucm_path.flow_label;
-	sa_path->hop_limit        = ucm_path.hop_limit;
-	sa_path->traffic_class    = ucm_path.traffic_class;
-	sa_path->reversible       = ucm_path.reversible;
-	sa_path->numb_path        = ucm_path.numb_path;
-	sa_path->pkey             = ucm_path.pkey;
-	sa_path->sl               = ucm_path.sl;
-	sa_path->mtu_selector     = ucm_path.mtu_selector;
-	sa_path->mtu              = ucm_path.mtu;
-	sa_path->rate_selector    = ucm_path.rate_selector;
-	sa_path->rate             = ucm_path.rate;
-	sa_path->packet_life_time = ucm_path.packet_life_time;
-	sa_path->preference       = ucm_path.preference;
-
-	sa_path->packet_life_time_selector =
-		ucm_path.packet_life_time_selector;
-
+	ib_copy_path_rec_from_user(sa_path, &upath);
 	*path = sa_path;
 	return 0;
 }
@@ -1243,8 +1140,10 @@ static unsigned int ib_ucm_poll(struct f
 
 	poll_wait(filp, &file->poll_wait, wait);
 
+	down(&file->mutex);
 	if (!list_empty(&file->events))
 		mask = POLLIN | POLLRDNORM;
+	up(&file->mutex);
 
 	return mask;
 }
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/uverbs_marshall.c 
linux-2.6.ib/drivers/infiniband/core/uverbs_marshall.c
--- linux-2.6.git/drivers/infiniband/core/uverbs_marshall.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/uverbs_marshall.c	2006-01-16 15:34:15.000000000 -0800
@@ -0,0 +1,138 @@
+/*
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
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
+
+#include <rdma/ib_marshall.h>
+
+static void ib_copy_ah_attr_to_user(struct ib_uverbs_ah_attr *dst,
+				    struct ib_ah_attr *src)
+{
+	memcpy(dst->grh.dgid, src->grh.dgid.raw, sizeof src->grh.dgid);
+	dst->grh.flow_label        = src->grh.flow_label;
+	dst->grh.sgid_index        = src->grh.sgid_index;
+	dst->grh.hop_limit         = src->grh.hop_limit;
+	dst->grh.traffic_class     = src->grh.traffic_class;
+	dst->dlid 	    	   = src->dlid;
+	dst->sl   	    	   = src->sl;
+	dst->src_path_bits 	   = src->src_path_bits;
+	dst->static_rate   	   = src->static_rate;
+	dst->is_global             = src->ah_flags & IB_AH_GRH ? 1 : 0;
+	dst->port_num 	    	   = src->port_num;
+}
+
+void ib_copy_qp_attr_to_user(struct ib_uverbs_qp_attr *dst,
+			     struct ib_qp_attr *src)
+{
+	dst->cur_qp_state	= src->cur_qp_state;
+	dst->path_mtu		= src->path_mtu;
+	dst->path_mig_state	= src->path_mig_state;
+	dst->qkey		= src->qkey;
+	dst->rq_psn		= src->rq_psn;
+	dst->sq_psn		= src->sq_psn;
+	dst->dest_qp_num	= src->dest_qp_num;
+	dst->qp_access_flags	= src->qp_access_flags;
+
+	dst->max_send_wr	= src->cap.max_send_wr;
+	dst->max_recv_wr	= src->cap.max_recv_wr;
+	dst->max_send_sge	= src->cap.max_send_sge;
+	dst->max_recv_sge	= src->cap.max_recv_sge;
+	dst->max_inline_data	= src->cap.max_inline_data;
+
+	ib_copy_ah_attr_to_user(&dst->ah_attr, &src->ah_attr);
+	ib_copy_ah_attr_to_user(&dst->alt_ah_attr, &src->alt_ah_attr);
+
+	dst->pkey_index		= src->pkey_index;
+	dst->alt_pkey_index	= src->alt_pkey_index;
+	dst->en_sqd_async_notify = src->en_sqd_async_notify;
+	dst->sq_draining	= src->sq_draining;
+	dst->max_rd_atomic	= src->max_rd_atomic;
+	dst->max_dest_rd_atomic	= src->max_dest_rd_atomic;
+	dst->min_rnr_timer	= src->min_rnr_timer;
+	dst->port_num		= src->port_num;
+	dst->timeout		= src->timeout;
+	dst->retry_cnt		= src->retry_cnt;
+	dst->rnr_retry		= src->rnr_retry;
+	dst->alt_port_num	= src->alt_port_num;
+	dst->alt_timeout	= src->alt_timeout;
+}
+EXPORT_SYMBOL(ib_copy_qp_attr_to_user);
+
+void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
+			      struct ib_sa_path_rec *src)
+{
+	memcpy(dst->dgid, src->dgid.raw, sizeof src->dgid);
+	memcpy(dst->sgid, src->sgid.raw, sizeof src->sgid);
+
+	dst->dlid		= src->dlid;
+	dst->slid		= src->slid;
+	dst->raw_traffic	= src->raw_traffic;
+	dst->flow_label		= src->flow_label;
+	dst->hop_limit		= src->hop_limit;
+	dst->traffic_class	= src->traffic_class;
+	dst->reversible		= src->reversible;
+	dst->numb_path		= src->numb_path;
+	dst->pkey		= src->pkey;
+	dst->sl			= src->sl;
+	dst->mtu_selector	= src->mtu_selector;
+	dst->mtu		= src->mtu;
+	dst->rate_selector	= src->rate_selector;
+	dst->rate		= src->rate;
+	dst->packet_life_time	= src->packet_life_time;
+	dst->preference		= src->preference;
+	dst->packet_life_time_selector = src->packet_life_time_selector;
+}
+EXPORT_SYMBOL(ib_copy_path_rec_to_user);
+
+void ib_copy_path_rec_from_user(struct ib_sa_path_rec *dst,
+				struct ib_user_path_rec *src)
+{
+	memcpy(dst->dgid.raw, src->dgid, sizeof dst->dgid);
+	memcpy(dst->sgid.raw, src->sgid, sizeof dst->sgid);
+
+	dst->dlid		= src->dlid;
+	dst->slid		= src->slid;
+	dst->raw_traffic	= src->raw_traffic;
+	dst->flow_label		= src->flow_label;
+	dst->hop_limit		= src->hop_limit;
+	dst->traffic_class	= src->traffic_class;
+	dst->reversible		= src->reversible;
+	dst->numb_path		= src->numb_path;
+	dst->pkey		= src->pkey;
+	dst->sl			= src->sl;
+	dst->mtu_selector	= src->mtu_selector;
+	dst->mtu		= src->mtu;
+	dst->rate_selector	= src->rate_selector;
+	dst->rate		= src->rate;
+	dst->packet_life_time	= src->packet_life_time;
+	dst->preference		= src->preference;
+	dst->packet_life_time_selector = src->packet_life_time_selector;
+}
+EXPORT_SYMBOL(ib_copy_path_rec_from_user);
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_marshall.h 
linux-2.6.ib/include/rdma/ib_marshall.h
--- linux-2.6.git/include/rdma/ib_marshall.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_marshall.h	2006-01-16 15:34:15.000000000 -0800
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
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
+
+#if !defined(IB_USER_MARSHALL_H)
+#define IB_USER_MARSHALL_H
+
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_sa.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_user_sa.h>
+
+void ib_copy_qp_attr_to_user(struct ib_uverbs_qp_attr *dst,
+			     struct ib_qp_attr *src);
+
+void ib_copy_path_rec_to_user(struct ib_user_path_rec *dst,
+			      struct ib_sa_path_rec *src);
+
+void ib_copy_path_rec_from_user(struct ib_sa_path_rec *dst,
+				struct ib_user_path_rec *src);
+
+#endif /* IB_USER_MARSHALL_H */
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_user_cm.h 
linux-2.6.ib/include/rdma/ib_user_cm.h
--- linux-2.6.git/include/rdma/ib_user_cm.h	2006-01-16 10:26:47.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_user_cm.h	2006-01-16 15:34:15.000000000 -0800
@@ -30,13 +30,13 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_user_cm.h 2576 2005-06-09 17:00:30Z libor $
+ * $Id: ib_user_cm.h 4019 2005-11-11 00:33:09Z sean.hefty $
  */
 
 #ifndef IB_USER_CM_H
 #define IB_USER_CM_H
 
-#include <linux/types.h>
+#include <rdma/ib_user_sa.h>
 
 #define IB_USER_CM_ABI_VERSION 4
 
@@ -110,58 +110,6 @@ struct ib_ucm_init_qp_attr {
 	__u32 qp_state;
 };
 
-struct ib_ucm_ah_attr {
-	__u8	grh_dgid[16];
-	__u32	grh_flow_label;
-	__u16	dlid;
-	__u16	reserved;
-	__u8	grh_sgid_index;
-	__u8	grh_hop_limit;
-	__u8	grh_traffic_class;
-	__u8	sl;
-	__u8	src_path_bits;
-	__u8	static_rate;
-	__u8	is_global;
-	__u8	port_num;
-};
-
-struct ib_ucm_init_qp_attr_resp {
-	__u32	qp_attr_mask;
-	__u32	qp_state;
-	__u32	cur_qp_state;
-	__u32	path_mtu;
-	__u32	path_mig_state;
-	__u32	qkey;
-	__u32	rq_psn;
-	__u32	sq_psn;
-	__u32	dest_qp_num;
-	__u32	qp_access_flags;
-
-	struct ib_ucm_ah_attr	ah_attr;
-	struct ib_ucm_ah_attr	alt_ah_attr;
-
-	/* ib_qp_cap */
-	__u32	max_send_wr;
-	__u32	max_recv_wr;
-	__u32	max_send_sge;
-	__u32	max_recv_sge;
-	__u32	max_inline_data;
-
-	__u16	pkey_index;
-	__u16	alt_pkey_index;
-	__u8	en_sqd_async_notify;
-	__u8	sq_draining;
-	__u8	max_rd_atomic;
-	__u8	max_dest_rd_atomic;
-	__u8	min_rnr_timer;
-	__u8	port_num;
-	__u8	timeout;
-	__u8	retry_cnt;
-	__u8	rnr_retry;
-	__u8	alt_port_num;
-	__u8	alt_timeout;
-};
-
 struct ib_ucm_listen {
 	__be64 service_id;
 	__be64 service_mask;
@@ -180,28 +128,6 @@ struct ib_ucm_private_data {
 	__u8  reserved[3];
 };
 
-struct ib_ucm_path_rec {
-	__u8  dgid[16];
-	__u8  sgid[16];
-	__be16 dlid;
-	__be16 slid;
-	__u32 raw_traffic;
-	__be32 flow_label;
-	__u32 reversible;
-	__u32 mtu;
-	__be16 pkey;
-	__u8  hop_limit;
-	__u8  traffic_class;
-	__u8  numb_path;
-	__u8  sl;
-	__u8  mtu_selector;
-	__u8  rate_selector;
-	__u8  rate;
-	__u8  packet_life_time_selector;
-	__u8  packet_life_time;
-	__u8  preference;
-};
-
 struct ib_ucm_req {
 	__u32 id;
 	__u32 qpn;
@@ -304,8 +230,8 @@ struct ib_ucm_event_get {
 };
 
 struct ib_ucm_req_event_resp {
-	struct ib_ucm_path_rec primary_path;
-	struct ib_ucm_path_rec alternate_path;
+	struct ib_user_path_rec primary_path;
+	struct ib_user_path_rec alternate_path;
 	__be64                 remote_ca_guid;
 	__u32                  remote_qkey;
 	__u32                  remote_qpn;
@@ -349,7 +275,7 @@ struct ib_ucm_mra_event_resp {
 };
 
 struct ib_ucm_lap_event_resp {
-	struct ib_ucm_path_rec path;
+	struct ib_user_path_rec path;
 };
 
 struct ib_ucm_apr_event_resp {
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_user_sa.h 
linux-2.6.ib/include/rdma/ib_user_sa.h
--- linux-2.6.git/include/rdma/ib_user_sa.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_user_sa.h	2006-01-16 15:34:15.000000000 -0800
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
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
+
+#ifndef IB_USER_SA_H
+#define IB_USER_SA_H
+
+#include <linux/types.h>
+
+struct ib_user_path_rec {
+	__u8	dgid[16];
+	__u8	sgid[16];
+	__be16	dlid;
+	__be16	slid;
+	__u32	raw_traffic;
+	__be32	flow_label;
+	__u32	reversible;
+	__u32	mtu;
+	__be16	pkey;
+	__u8	hop_limit;
+	__u8	traffic_class;
+	__u8	numb_path;
+	__u8	sl;
+	__u8	mtu_selector;
+	__u8	rate_selector;
+	__u8	rate;
+	__u8	packet_life_time_selector;
+	__u8	packet_life_time;
+	__u8	preference;
+};
+
+#endif /* IB_USER_SA_H */
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_user_verbs.h 
linux-2.6.ib/include/rdma/ib_user_verbs.h
--- linux-2.6.git/include/rdma/ib_user_verbs.h	2006-01-16 10:26:47.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_user_verbs.h	2006-01-16 15:34:15.000000000 -0800
@@ -31,7 +31,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: ib_user_verbs.h 2708 2005-06-24 17:27:21Z roland $
+ * $Id: ib_user_verbs.h 4019 2005-11-11 00:33:09Z sean.hefty $
  */
 
 #ifndef IB_USER_VERBS_H
@@ -311,6 +311,64 @@ struct ib_uverbs_destroy_cq_resp {
 	__u32 async_events_reported;
 };
 
+struct ib_uverbs_global_route {
+	__u8  dgid[16];
+	__u32 flow_label;    
+	__u8  sgid_index;
+	__u8  hop_limit;
+	__u8  traffic_class;
+	__u8  reserved;
+};
+
+struct ib_uverbs_ah_attr {
+	struct ib_uverbs_global_route grh;
+	__u16 dlid;
+	__u8  sl;
+	__u8  src_path_bits;
+	__u8  static_rate;
+	__u8  is_global;
+	__u8  port_num;
+	__u8  reserved;
+};
+
+struct ib_uverbs_qp_attr {
+	__u32	qp_attr_mask;
+	__u32	qp_state;
+	__u32	cur_qp_state;
+	__u32	path_mtu;
+	__u32	path_mig_state;
+	__u32	qkey;
+	__u32	rq_psn;
+	__u32	sq_psn;
+	__u32	dest_qp_num;
+	__u32	qp_access_flags;
+
+	struct ib_uverbs_ah_attr ah_attr;
+	struct ib_uverbs_ah_attr alt_ah_attr;
+
+	/* ib_qp_cap */
+	__u32	max_send_wr;
+	__u32	max_recv_wr;
+	__u32	max_send_sge;
+	__u32	max_recv_sge;
+	__u32	max_inline_data;
+
+	__u16	pkey_index;
+	__u16	alt_pkey_index;
+	__u8	en_sqd_async_notify;
+	__u8	sq_draining;
+	__u8	max_rd_atomic;
+	__u8	max_dest_rd_atomic;
+	__u8	min_rnr_timer;
+	__u8	port_num;
+	__u8	timeout;
+	__u8	retry_cnt;
+	__u8	rnr_retry;
+	__u8	alt_port_num;
+	__u8	alt_timeout;
+	__u8	reserved[5];
+};
+
 struct ib_uverbs_create_qp {
 	__u64 response;
 	__u64 user_handle;
@@ -487,26 +545,6 @@ struct ib_uverbs_post_srq_recv_resp {
 	__u32 bad_wr;
 };
 
-struct ib_uverbs_global_route {
-	__u8  dgid[16];
-	__u32 flow_label;    
-	__u8  sgid_index;
-	__u8  hop_limit;
-	__u8  traffic_class;
-	__u8  reserved;
-};
-
-struct ib_uverbs_ah_attr {
-	struct ib_uverbs_global_route grh;
-	__u16 dlid;
-	__u8  sl;
-	__u8  src_path_bits;
-	__u8  static_rate;
-	__u8  is_global;
-	__u8  port_num;
-	__u8  reserved;
-};
-
 struct ib_uverbs_create_ah {
 	__u64 response;
 	__u64 user_handle;



