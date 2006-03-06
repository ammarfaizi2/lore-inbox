Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWCFTVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWCFTVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWCFTVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:21:12 -0500
Received: from fmr17.intel.com ([134.134.136.16]:26267 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932341AbWCFTVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:21:07 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <netdev@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: <openib-general@openib.org>
Subject: [PATCH 6/6] IB: userspace support for RDMA connection manager
Date: Mon, 6 Mar 2006 11:21:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <adaslpz2l9p.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACPT0Rg
Message-ID: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 06 Mar 2006 19:21:04.0852 (UTC) FILETIME=[1CD61140:01C64153]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel component necessary to support the userspace RDMA connection management
library.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>

---

diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/Makefile 
linux-2.6.ib/drivers/infiniband/core/Makefile
--- linux-2.6.git/drivers/infiniband/core/Makefile	2006-01-16 16:58:58.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/Makefile	2006-01-16 16:55:25.000000000 -0800
@@ -1,5 +1,5 @@
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
-					ib_cm.o ib_addr.o rdma_cm.o
+					ib_cm.o ib_addr.o rdma_cm.o rdma_ucm.o
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
 obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o
 
@@ -14,6 +14,8 @@ ib_cm-y :=			cm.o
 
 rdma_cm-y :=			cma.o
 
+rdma_ucm-y :=			ucma.o
+
 ib_addr-y :=			addr.o
 
 ib_umad-y :=			user_mad.o
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/ucma.c 
linux-2.6.ib/drivers/infiniband/core/ucma.c
--- linux-2.6.git/drivers/infiniband/core/ucma.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/ucma.c	2006-01-16 16:54:31.000000000 -0800
@@ -0,0 +1,788 @@
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
+ *	copyright notice, this list of conditions and the following
+ *	disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *	copyright notice, this list of conditions and the following
+ *	disclaimer in the documentation and/or other materials
+ *	provided with the distribution.
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
+#include <linux/poll.h>
+#include <linux/idr.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/miscdevice.h>
+
+#include <rdma/rdma_user_cm.h>
+#include <rdma/ib_marshall.h>
+#include <rdma/rdma_cm.h>
+
+MODULE_AUTHOR("Sean Hefty");
+MODULE_DESCRIPTION("RDMA Userspace Connection Manager Access");
+MODULE_LICENSE("Dual BSD/GPL");
+
+enum {
+	UCMA_MAX_BACKLOG	= 128
+};
+
+struct ucma_file {
+	struct semaphore	mutex;
+	struct file		*filp;
+	struct list_head	ctxs;
+	struct list_head	events;
+	wait_queue_head_t	poll_wait;
+};
+
+struct ucma_context {
+	int			id;
+	wait_queue_head_t	wait;
+	atomic_t		ref;
+	int			events_reported;
+	int			backlog;
+
+	struct ucma_file	*file;
+	struct rdma_cm_id	*cm_id;
+	__u64			uid;
+
+	struct list_head	events;    /* list of pending events. */
+	struct list_head	file_list; /* member in file ctx list */
+};
+
+struct ucma_event {
+	struct ucma_context	*ctx;
+	struct list_head	file_list; /* member in file event list */
+	struct list_head	ctx_list;  /* member in ctx event list */
+	struct rdma_cm_id	*cm_id;
+	struct rdma_ucm_event_resp resp;
+};
+
+static DECLARE_MUTEX(ctx_mutex);
+static DEFINE_IDR(ctx_idr);
+
+static struct ucma_context* ucma_get_ctx(struct ucma_file *file, int id)
+{
+	struct ucma_context *ctx;
+
+	down(&ctx_mutex);
+	ctx = idr_find(&ctx_idr, id);
+	if (!ctx)
+		ctx = ERR_PTR(-ENOENT);
+	else if (ctx->file != file)
+		ctx = ERR_PTR(-EINVAL);
+	else
+		atomic_inc(&ctx->ref);
+	up(&ctx_mutex);
+
+	return ctx;
+}
+
+static void ucma_put_ctx(struct ucma_context *ctx)
+{
+	if (atomic_dec_and_test(&ctx->ref))
+		wake_up(&ctx->wait);
+}
+
+static void ucma_cleanup_events(struct ucma_context *ctx)
+{
+	struct ucma_event *uevent;
+
+	down(&ctx->file->mutex);
+	list_del(&ctx->file_list);
+	while (!list_empty(&ctx->events)) {
+
+		uevent = list_entry(ctx->events.next, struct ucma_event,
+				    ctx_list);
+		list_del(&uevent->file_list);
+		list_del(&uevent->ctx_list);
+
+		/* clear incoming connections. */
+		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST)
+			rdma_destroy_id(uevent->cm_id);
+
+		kfree(uevent);
+	}
+	up(&ctx->file->mutex);
+}
+
+static struct ucma_context* ucma_alloc_ctx(struct ucma_file *file)
+{
+	struct ucma_context *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	atomic_set(&ctx->ref, 1);
+	init_waitqueue_head(&ctx->wait);
+	ctx->file = file;
+	INIT_LIST_HEAD(&ctx->events);
+
+	do {
+		ret = idr_pre_get(&ctx_idr, GFP_KERNEL);
+		if (!ret)
+			goto error;
+
+		down(&ctx_mutex);
+		ret = idr_get_new(&ctx_idr, ctx, &ctx->id);
+		up(&ctx_mutex);
+	} while (ret == -EAGAIN);
+
+	if (ret)
+		goto error;
+
+	list_add_tail(&ctx->file_list, &file->ctxs);
+	return ctx;
+
+error:
+	kfree(ctx);
+	return NULL;
+}
+
+static int ucma_event_handler(struct rdma_cm_id *cm_id,
+			      struct rdma_cm_event *event)
+{
+	struct ucma_event *uevent;
+	struct ucma_context *ctx = cm_id->context;
+	int ret = 0;
+
+	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
+	if (!uevent)
+		return event->event == RDMA_CM_EVENT_CONNECT_REQUEST;
+
+	uevent->ctx = ctx;
+	uevent->cm_id = cm_id;
+	uevent->resp.uid = ctx->uid;
+	uevent->resp.id = ctx->id;
+	uevent->resp.event = event->event;
+	uevent->resp.status = event->status;
+	if ((uevent->resp.private_data_len = event->private_data_len))
+		memcpy(uevent->resp.private_data, event->private_data,
+		       event->private_data_len);
+
+	down(&ctx->file->mutex);
+	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
+		if (!ctx->backlog) {
+			ret = -EDQUOT;
+			goto out;
+		}
+		ctx->backlog--;
+	}
+	list_add_tail(&uevent->file_list, &ctx->file->events);
+	list_add_tail(&uevent->ctx_list, &ctx->events);
+	wake_up_interruptible(&ctx->file->poll_wait);
+out:
+	up(&ctx->file->mutex);
+	return ret;
+}
+
+static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
+			      int in_len, int out_len)
+{
+	struct ucma_context *ctx;
+	struct rdma_ucm_get_event cmd;
+	struct ucma_event *uevent;
+	int ret = 0;
+	DEFINE_WAIT(wait);
+
+	if (out_len < sizeof(struct rdma_ucm_event_resp))
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	down(&file->mutex);
+	while (list_empty(&file->events)) {
+		if (file->filp->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+
+		prepare_to_wait(&file->poll_wait, &wait, TASK_INTERRUPTIBLE);
+		up(&file->mutex);
+		schedule();
+		down(&file->mutex);
+		finish_wait(&file->poll_wait, &wait);
+	}
+
+	if (ret)
+		goto done;
+
+	uevent = list_entry(file->events.next, struct ucma_event, file_list);
+
+	if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST) {
+		ctx = ucma_alloc_ctx(file);
+		if (!ctx) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		uevent->ctx->backlog++;
+		ctx->cm_id = uevent->cm_id;
+		ctx->cm_id->context = ctx;
+		uevent->resp.id = ctx->id;
+	}
+
+	if (copy_to_user((void __user *)(unsigned long)cmd.response,
+			 &uevent->resp, sizeof(uevent->resp))) {
+		ret = -EFAULT;
+		goto done;
+	}
+
+	list_del(&uevent->file_list);
+	list_del(&uevent->ctx_list);
+	uevent->ctx->events_reported++;
+	kfree(uevent);
+done:
+	up(&file->mutex);
+	return ret;
+}
+
+static ssize_t ucma_create_id(struct ucma_file *file,
+				const char __user *inbuf,
+				int in_len, int out_len)
+{
+	struct rdma_ucm_create_id cmd;
+	struct rdma_ucm_create_id_resp resp;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (out_len < sizeof(resp))
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	down(&file->mutex);
+	ctx = ucma_alloc_ctx(file);
+	up(&file->mutex);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->uid = cmd.uid;
+	ctx->cm_id = rdma_create_id(ucma_event_handler, ctx, RDMA_PS_TCP);
+	if (IS_ERR(ctx->cm_id)) {
+		ret = PTR_ERR(ctx->cm_id);
+		goto err1;
+	}
+
+	resp.id = ctx->id;
+	if (copy_to_user((void __user *)(unsigned long)cmd.response,
+			 &resp, sizeof(resp))) {
+		ret = -EFAULT;
+		goto err2;
+	}
+	return 0;
+
+err2:
+	rdma_destroy_id(ctx->cm_id);
+err1:
+	down(&ctx_mutex);
+	idr_remove(&ctx_idr, ctx->id);
+	up(&ctx_mutex);
+	kfree(ctx);
+	return ret;
+}
+
+static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,
+			       int in_len, int out_len)
+{
+	struct rdma_ucm_destroy_id cmd;
+	struct rdma_ucm_destroy_id_resp resp;
+	struct ucma_context *ctx;
+	int ret = 0;
+
+	if (out_len < sizeof(resp))
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	down(&ctx_mutex);
+	ctx = idr_find(&ctx_idr, cmd.id);
+	if (!ctx)
+		ctx = ERR_PTR(-ENOENT);
+	else if (ctx->file != file)
+		ctx = ERR_PTR(-EINVAL);
+	else
+		idr_remove(&ctx_idr, ctx->id);
+	up(&ctx_mutex);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	atomic_dec(&ctx->ref);
+	wait_event(ctx->wait, !atomic_read(&ctx->ref));
+
+	/* No new events will be generated after destroying the id. */
+	rdma_destroy_id(ctx->cm_id);
+	/* Cleanup events not yet reported to the user. */
+	ucma_cleanup_events(ctx);
+
+	resp.events_reported = ctx->events_reported;
+	if (copy_to_user((void __user *)(unsigned long)cmd.response,
+			 &resp, sizeof(resp)))
+		ret = -EFAULT;
+
+	kfree(ctx);
+	return ret;
+}
+
+static ssize_t ucma_bind_addr(struct ucma_file *file, const char __user *inbuf,
+			      int in_len, int out_len)
+{
+	struct rdma_ucm_bind_addr cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = rdma_bind_addr(ctx->cm_id, (struct sockaddr *) &cmd.addr);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_resolve_addr(struct ucma_file *file,
+				 const char __user *inbuf,
+				 int in_len, int out_len)
+{
+	struct rdma_ucm_resolve_addr cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
+				(struct sockaddr *) &cmd.dst_addr,
+				cmd.timeout_ms);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_resolve_route(struct ucma_file *file,
+				  const char __user *inbuf,
+				  int in_len, int out_len)
+{
+	struct rdma_ucm_resolve_route cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = rdma_resolve_route(ctx->cm_id, cmd.timeout_ms);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static void ucma_copy_ib_route(struct rdma_ucm_query_route_resp *resp,
+			       struct rdma_route *route)
+{
+	struct rdma_dev_addr *dev_addr;
+
+	resp->num_paths = route->num_paths;
+	switch (route->num_paths) {
+	case 0:
+		dev_addr = &route->addr.dev_addr;
+		memcpy(&resp->ib_route[0].dgid, ib_addr_get_dgid(dev_addr),
+		       sizeof(union ib_gid));
+		memcpy(&resp->ib_route[0].sgid, ib_addr_get_sgid(dev_addr),
+		       sizeof(union ib_gid));
+		resp->ib_route[0].pkey = cpu_to_be16(ib_addr_get_pkey(dev_addr));
+		break;
+	case 2:
+		ib_copy_path_rec_to_user(&resp->ib_route[1],
+					 &route->path_rec[1]);
+		/* fall through */
+	case 1:
+		ib_copy_path_rec_to_user(&resp->ib_route[0],
+					 &route->path_rec[0]);
+		break;
+	default:
+		break;
+	}
+}
+
+static ssize_t ucma_query_route(struct ucma_file *file,
+				const char __user *inbuf,
+				int in_len, int out_len)
+{
+	struct rdma_ucm_query_route cmd;
+	struct rdma_ucm_query_route_resp resp;
+	struct ucma_context *ctx;
+	struct sockaddr *addr;
+	int ret = 0;
+
+	if (out_len < sizeof(resp))
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (!ctx->cm_id->device) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	addr = &ctx->cm_id->route.addr.src_addr;
+	memcpy(&resp.src_addr, addr, addr->sa_family == AF_INET ?
+				     sizeof(struct sockaddr_in) : 
+				     sizeof(struct sockaddr_in6));
+	addr = &ctx->cm_id->route.addr.dst_addr;
+	memcpy(&resp.dst_addr, addr, addr->sa_family == AF_INET ?
+				     sizeof(struct sockaddr_in) : 
+				     sizeof(struct sockaddr_in6));
+	resp.node_guid = ctx->cm_id->device->node_guid;
+	resp.port_num = ctx->cm_id->port_num;
+	switch (ctx->cm_id->device->node_type) {
+	case IB_NODE_CA:
+		ucma_copy_ib_route(&resp, &ctx->cm_id->route);
+	default:
+		break;
+	}
+
+	if (copy_to_user((void __user *)(unsigned long)cmd.response,
+			 &resp, sizeof(resp)))
+		ret = -EFAULT;
+
+out:
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static void ucma_copy_conn_param(struct rdma_conn_param *dst_conn,
+				 struct rdma_ucm_conn_param *src_conn)
+{
+	dst_conn->private_data = src_conn->private_data;
+	dst_conn->private_data_len = src_conn->private_data_len;
+	dst_conn->responder_resources =src_conn->responder_resources;
+	dst_conn->initiator_depth = src_conn->initiator_depth;
+	dst_conn->flow_control = src_conn->flow_control;
+	dst_conn->retry_count = src_conn->retry_count;
+	dst_conn->rnr_retry_count = src_conn->rnr_retry_count;
+	dst_conn->srq = src_conn->srq;
+	dst_conn->qp_num = src_conn->qp_num;
+	dst_conn->qp_type = src_conn->qp_type;
+}
+
+static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
+			    int in_len, int out_len)
+{
+	struct rdma_ucm_connect cmd;
+	struct rdma_conn_param conn_param;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	if (!cmd.conn_param.valid)
+		return -EINVAL;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ucma_copy_conn_param(&conn_param, &cmd.conn_param);
+	ret = rdma_connect(ctx->cm_id, &conn_param);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_listen(struct ucma_file *file, const char __user *inbuf,
+			   int in_len, int out_len)
+{
+	struct rdma_ucm_listen cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->backlog = cmd.backlog > 0 && cmd.backlog < UCMA_MAX_BACKLOG ?
+		       cmd.backlog : UCMA_MAX_BACKLOG;
+	ret = rdma_listen(ctx->cm_id, ctx->backlog);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
+			   int in_len, int out_len)
+{
+	struct rdma_ucm_accept cmd;
+	struct rdma_conn_param conn_param;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (cmd.conn_param.valid) {
+		ctx->uid = cmd.uid;
+		ucma_copy_conn_param(&conn_param, &cmd.conn_param);
+		ret = rdma_accept(ctx->cm_id, &conn_param);
+	} else
+		ret = rdma_accept(ctx->cm_id, NULL);
+
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_reject(struct ucma_file *file, const char __user *inbuf,
+			   int in_len, int out_len)
+{
+	struct rdma_ucm_reject cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = rdma_reject(ctx->cm_id, cmd.private_data, cmd.private_data_len);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_disconnect(struct ucma_file *file, const char __user *inbuf,
+			       int in_len, int out_len)
+{
+	struct rdma_ucm_disconnect cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = rdma_disconnect(ctx->cm_id);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t ucma_init_qp_attr(struct ucma_file *file,
+				 const char __user *inbuf,
+				 int in_len, int out_len)
+{
+	struct rdma_ucm_init_qp_attr cmd;
+	struct ib_uverbs_qp_attr resp;
+	struct ucma_context *ctx;
+	struct ib_qp_attr qp_attr;
+	int ret;
+
+	if (out_len < sizeof(resp))
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	resp.qp_attr_mask = 0;
+	memset(&qp_attr, 0, sizeof qp_attr);
+	qp_attr.qp_state = cmd.qp_state;
+	ret = rdma_init_qp_attr(ctx->cm_id, &qp_attr, &resp.qp_attr_mask);
+	if (ret)
+		goto out;
+
+	ib_copy_qp_attr_to_user(&resp, &qp_attr);
+	if (copy_to_user((void __user *)(unsigned long)cmd.response,
+			 &resp, sizeof(resp)))
+		ret = -EFAULT;
+
+out:
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
+static ssize_t (*ucma_cmd_table[])(struct ucma_file *file,
+				   const char __user *inbuf,
+				   int in_len, int out_len) = {
+	[RDMA_USER_CM_CMD_CREATE_ID]	= ucma_create_id,
+	[RDMA_USER_CM_CMD_DESTROY_ID]	= ucma_destroy_id,
+	[RDMA_USER_CM_CMD_BIND_ADDR]	= ucma_bind_addr,
+	[RDMA_USER_CM_CMD_RESOLVE_ADDR]	= ucma_resolve_addr,
+	[RDMA_USER_CM_CMD_RESOLVE_ROUTE]= ucma_resolve_route,
+	[RDMA_USER_CM_CMD_QUERY_ROUTE]	= ucma_query_route,
+	[RDMA_USER_CM_CMD_CONNECT]	= ucma_connect,
+	[RDMA_USER_CM_CMD_LISTEN]	= ucma_listen,
+	[RDMA_USER_CM_CMD_ACCEPT]	= ucma_accept,
+	[RDMA_USER_CM_CMD_REJECT]	= ucma_reject,
+	[RDMA_USER_CM_CMD_DISCONNECT]	= ucma_disconnect,
+	[RDMA_USER_CM_CMD_INIT_QP_ATTR]	= ucma_init_qp_attr,
+	[RDMA_USER_CM_CMD_GET_EVENT]	= ucma_get_event
+};
+
+static ssize_t ucma_write(struct file *filp, const char __user *buf,
+			  size_t len, loff_t *pos)
+{
+	struct ucma_file *file = filp->private_data;
+	struct rdma_ucm_cmd_hdr hdr;
+	ssize_t ret;
+
+	if (len < sizeof(hdr))
+		return -EINVAL;
+
+	if (copy_from_user(&hdr, buf, sizeof(hdr)))
+		return -EFAULT;
+
+	if (hdr.cmd < 0 || hdr.cmd >= ARRAY_SIZE(ucma_cmd_table))
+		return -EINVAL;
+
+	if (hdr.in + sizeof(hdr) > len)
+		return -EINVAL;
+
+	ret = ucma_cmd_table[hdr.cmd](file, buf + sizeof(hdr), hdr.in, hdr.out);
+	if (!ret)
+		ret = len;
+
+	return ret;
+}
+
+static unsigned int ucma_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	struct ucma_file *file = filp->private_data;
+	unsigned int mask = 0;
+
+	poll_wait(filp, &file->poll_wait, wait);
+
+	down(&file->mutex);
+	if (!list_empty(&file->events))
+		mask = POLLIN | POLLRDNORM;
+	up(&file->mutex);
+
+	return mask;
+}
+
+static int ucma_open(struct inode *inode, struct file *filp)
+{
+	struct ucma_file *file;
+
+	file = kmalloc(sizeof *file, GFP_KERNEL);
+	if (!file)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&file->events);
+	INIT_LIST_HEAD(&file->ctxs);
+	init_waitqueue_head(&file->poll_wait);
+	init_MUTEX(&file->mutex);
+
+	filp->private_data = file;
+	file->filp = filp;
+	return 0;
+}
+
+static int ucma_close(struct inode *inode, struct file *filp)
+{
+	struct ucma_file *file = filp->private_data;
+	struct ucma_context *ctx;
+
+	down(&file->mutex);
+	while (!list_empty(&file->ctxs)) {
+		ctx = list_entry(file->ctxs.next, struct ucma_context,
+				 file_list);
+		up(&file->mutex);
+
+		down(&ctx_mutex);
+		idr_remove(&ctx_idr, ctx->id);
+		up(&ctx_mutex);
+
+		rdma_destroy_id(ctx->cm_id);
+		ucma_cleanup_events(ctx);
+		kfree(ctx);
+
+		down(&file->mutex);
+	}
+	up(&file->mutex);
+	kfree(file);
+	return 0;
+}
+
+static struct file_operations ucma_fops = {
+	.owner 	 = THIS_MODULE,
+	.open 	 = ucma_open,
+	.release = ucma_close,
+	.write	 = ucma_write,
+	.poll    = ucma_poll,
+};
+
+static struct miscdevice ucma_misc = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "rdma_cm",
+	.fops	= &ucma_fops,
+};
+
+static int __init ucma_init(void)
+{
+	return misc_register(&ucma_misc);
+}
+
+static void __exit ucma_cleanup(void)
+{
+	misc_deregister(&ucma_misc);
+	idr_destroy(&ctx_idr);
+}
+
+module_init(ucma_init);
+module_exit(ucma_cleanup);
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/rdma_user_cm.h 
linux-2.6.ib/include/rdma/rdma_user_cm.h
--- linux-2.6.git/include/rdma/rdma_user_cm.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/include/rdma/rdma_user_cm.h	2006-01-16 16:54:55.000000000 -0800
@@ -0,0 +1,186 @@
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
+#ifndef RDMA_USER_CM_H
+#define RDMA_USER_CM_H
+
+#include <linux/types.h>
+#include <linux/in6.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_user_sa.h>
+
+#define RDMA_USER_CM_ABI_VERSION 1
+
+#define RDMA_MAX_PRIVATE_DATA		256
+
+enum {
+	RDMA_USER_CM_CMD_CREATE_ID,
+	RDMA_USER_CM_CMD_DESTROY_ID,
+	RDMA_USER_CM_CMD_BIND_ADDR,
+	RDMA_USER_CM_CMD_RESOLVE_ADDR,
+	RDMA_USER_CM_CMD_RESOLVE_ROUTE,
+	RDMA_USER_CM_CMD_QUERY_ROUTE,
+	RDMA_USER_CM_CMD_CONNECT,
+	RDMA_USER_CM_CMD_LISTEN,
+	RDMA_USER_CM_CMD_ACCEPT,
+	RDMA_USER_CM_CMD_REJECT,
+	RDMA_USER_CM_CMD_DISCONNECT,
+	RDMA_USER_CM_CMD_INIT_QP_ATTR,
+	RDMA_USER_CM_CMD_GET_EVENT
+};
+
+/*
+ * command ABI structures.
+ */
+struct rdma_ucm_cmd_hdr {
+	__u32 cmd;
+	__u16 in;
+	__u16 out;
+};
+
+struct rdma_ucm_create_id {
+	__u64 uid;
+	__u64 response;
+};
+
+struct rdma_ucm_create_id_resp {
+	__u32 id;
+};
+
+struct rdma_ucm_destroy_id {
+	__u64 response;
+	__u32 id;
+	__u32 reserved;
+};
+
+struct rdma_ucm_destroy_id_resp {
+	__u32 events_reported;
+};
+
+struct rdma_ucm_bind_addr {
+	__u64 response;
+	struct sockaddr_in6 addr;
+	__u32 id;
+};
+
+struct rdma_ucm_resolve_addr {
+	struct sockaddr_in6 src_addr;
+	struct sockaddr_in6 dst_addr;
+	__u32 id;
+	__u32 timeout_ms;
+};
+
+struct rdma_ucm_resolve_route {
+	__u32 id;
+	__u32 timeout_ms;
+};
+
+struct rdma_ucm_query_route {
+	__u64 response;
+	__u32 id;
+	__u32 reserved;
+};
+
+struct rdma_ucm_query_route_resp {
+	__u64 node_guid;
+	struct ib_user_path_rec ib_route[2];
+	struct sockaddr_in6 src_addr;
+	struct sockaddr_in6 dst_addr;
+	__u32 num_paths;
+	__u8 port_num;
+	__u8 reserved[3];
+};
+
+struct rdma_ucm_conn_param {
+	__u32 qp_num;
+	__u32 qp_type;
+	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
+	__u8  private_data_len;
+	__u8  srq;
+	__u8  responder_resources;
+	__u8  initiator_depth;
+	__u8  flow_control;
+	__u8  retry_count;
+	__u8  rnr_retry_count;
+	__u8  valid;
+};
+
+struct rdma_ucm_connect {
+	struct rdma_ucm_conn_param conn_param;
+	__u32 id;
+	__u32 reserved;
+};
+
+struct rdma_ucm_listen {
+	__u32 id;
+	__u32 backlog;
+};
+
+struct rdma_ucm_accept {
+	__u64 uid;
+	struct rdma_ucm_conn_param conn_param;
+	__u32 id;
+	__u32 reserved;
+};
+
+struct rdma_ucm_reject {
+	__u32 id;
+	__u8  private_data_len;
+	__u8  reserved[3];
+	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
+};
+
+struct rdma_ucm_disconnect {
+	__u32 id;
+};
+
+struct rdma_ucm_init_qp_attr {
+	__u64 response;
+	__u32 id;
+	__u32 qp_state;
+};
+
+struct rdma_ucm_get_event {
+	__u64 response;
+};
+
+struct rdma_ucm_event_resp {
+	__u64 uid;
+	__u32 id;
+	__u32 event;
+	__u32 status;
+	__u8  private_data_len;
+	__u8  reserved[3];
+	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
+};
+
+#endif /* RDMA_USER_CM_H */



