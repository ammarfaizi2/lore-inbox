Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDDWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDDWpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVDDWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:45:42 -0400
Received: from webmail.topspin.com ([12.162.17.3]:9259 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261458AbVDDWeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:34:23 -0400
Subject: [PATCH][RFC][2/4] IB: userspace verbs main module
In-Reply-To: <200544159.Qg0tUfQc4xGRabsc@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 4 Apr 2005 15:09:00 -0700
Message-Id: <200544159.3X7p8nZ87qWqA7cv@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 04 Apr 2005 22:09:00.0569 (UTC) FILETIME=[E7A27890:01C53962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-independent userspace verbs support (ib_uverbs module).

Signed-off-by: Roland Dreier <roland@topspin.com>

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/core/uverbs.h	2005-04-04 14:55:10.496227053 -0700
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
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
+ *
+ * $Id: uverbs.h 2001 2005-03-16 04:15:41Z roland $
+ */
+
+#ifndef UVERBS_H
+#define UVERBS_H
+
+/* Include device.h and fs.h until cdev.h is self-sufficient */
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/kref.h>
+#include <linux/idr.h>
+
+#include <ib_verbs.h>
+#include <ib_user_verbs.h>
+
+struct ib_uverbs_device {
+	int                 devnum;
+	struct cdev         dev;
+	struct class_device class_dev;
+	struct ib_device   *ib_dev;
+	int                 num_comp;
+};
+
+struct ib_uverbs_event_file {
+	struct ib_uverbs_file *uverbs_file;
+	spinlock_t             lock;
+	int                    fd;
+	int                    is_async;
+	wait_queue_head_t      poll_wait;
+	struct list_head       event_list;
+};
+
+struct ib_uverbs_file {
+	struct kref                 ref;
+	struct ib_uverbs_device    *device;
+	struct ib_ucontext         *ucontext;
+	struct ib_event_handler     event_handler;
+	struct ib_uverbs_event_file async_file; 
+	struct ib_uverbs_event_file comp_file[1]; 
+};
+
+struct ib_uverbs_async_event {
+	struct ib_uverbs_async_event_desc desc;
+	struct list_head                  list;
+};
+
+struct ib_uverbs_comp_event {
+	struct ib_uverbs_comp_event_desc desc;
+	struct list_head                 list;
+};
+
+struct ib_uobject_mr {
+	struct ib_uobject   uobj;
+	struct page        *page_list;
+	struct scatterlist *sg_list;
+};
+
+extern struct semaphore ib_uverbs_idr_mutex;
+extern struct idr ib_uverbs_pd_idr;
+extern struct idr ib_uverbs_mr_idr;
+extern struct idr ib_uverbs_mw_idr;
+extern struct idr ib_uverbs_ah_idr;
+extern struct idr ib_uverbs_cq_idr;
+extern struct idr ib_uverbs_qp_idr;
+
+void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context);
+void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr);
+void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr);
+
+int ib_umem_get(struct ib_device *dev, struct ib_umem *mem,
+		void *addr, size_t size);
+void ib_umem_release(struct ib_device *dev, struct ib_umem *umem);
+
+#define IB_UVERBS_DECLARE_CMD(name)					\
+	ssize_t ib_uverbs_##name(struct ib_uverbs_file *file,		\
+				 const char __user *buf, int in_len,	\
+				 int out_len)
+
+IB_UVERBS_DECLARE_CMD(query_params);
+IB_UVERBS_DECLARE_CMD(get_context);
+IB_UVERBS_DECLARE_CMD(query_port);
+IB_UVERBS_DECLARE_CMD(alloc_pd);
+IB_UVERBS_DECLARE_CMD(dealloc_pd);
+IB_UVERBS_DECLARE_CMD(reg_mr);
+IB_UVERBS_DECLARE_CMD(dereg_mr);
+IB_UVERBS_DECLARE_CMD(create_cq);
+IB_UVERBS_DECLARE_CMD(destroy_cq);
+IB_UVERBS_DECLARE_CMD(create_qp);
+IB_UVERBS_DECLARE_CMD(modify_qp);
+IB_UVERBS_DECLARE_CMD(destroy_qp);
+
+#endif /* UVERBS_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/core/uverbs_cmd.c	2005-04-04 14:53:12.136965074 -0700
@@ -0,0 +1,790 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
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
+ *
+ * $Id: uverbs_cmd.c 1995 2005-03-15 19:25:10Z roland $
+ */
+
+#include <asm/uaccess.h>
+
+#include "uverbs.h"
+
+ssize_t ib_uverbs_query_params(struct ib_uverbs_file *file,
+			       const char __user *buf,
+			       int in_len, int out_len)
+{
+	struct ib_uverbs_query_params      cmd;
+	struct ib_uverbs_query_params_resp resp;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	resp.num_cq_events = file->device->num_comp;
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response, &resp, sizeof resp))
+	    return -EFAULT;
+
+	return in_len;
+}
+
+ssize_t ib_uverbs_get_context(struct ib_uverbs_file *file,
+			      const char __user *buf,
+			      int in_len, int out_len)
+{
+	struct ib_uverbs_get_context       cmd;
+	struct ib_uverbs_get_context_resp *resp;
+	struct ib_device                  *ibdev = file->device->ib_dev;
+	int outsz;
+	int i;
+	int ret = in_len;
+
+	outsz = sizeof *resp + (file->device->num_comp - 1) * sizeof (__u32);
+
+	if (out_len < outsz)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	resp = kmalloc(outsz, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	file->ucontext = ibdev->alloc_ucontext(ibdev, buf + sizeof cmd,
+					       in_len - sizeof cmd -
+					       sizeof (struct ib_uverbs_cmd_hdr));
+	if (IS_ERR(file->ucontext)) {
+		ret = PTR_ERR(file->ucontext);
+		file->ucontext = NULL;
+		kfree(resp);
+		return ret;
+	}
+
+	file->ucontext->device = ibdev;
+	INIT_LIST_HEAD(&file->ucontext->pd_list);
+	INIT_LIST_HEAD(&file->ucontext->mr_list);
+	INIT_LIST_HEAD(&file->ucontext->mw_list);
+	INIT_LIST_HEAD(&file->ucontext->cq_list);
+	INIT_LIST_HEAD(&file->ucontext->qp_list);
+	INIT_LIST_HEAD(&file->ucontext->srq_list);
+	INIT_LIST_HEAD(&file->ucontext->ah_list);
+	spin_lock_init(&file->ucontext->lock);
+
+	resp->async_fd  = file->async_file.fd;
+	for (i = 0; i < file->device->num_comp; ++i)
+		resp->cq_fd[i] = file->comp_file[i].fd;
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response, resp, outsz)) {
+		ibdev->dealloc_ucontext(file->ucontext);
+		file->ucontext = NULL;
+		ret = -EFAULT;
+	}
+
+	kfree(resp);
+	return ret;
+}
+
+ssize_t ib_uverbs_query_port(struct ib_uverbs_file *file,
+			     const char __user *buf,
+			     int in_len, int out_len)
+{
+	struct ib_uverbs_query_port      cmd;
+	struct ib_uverbs_query_port_resp resp;
+	struct ib_port_attr              attr;
+	int                              ret;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	ret = ib_query_port(file->device->ib_dev, cmd.port_num, &attr);
+	if (ret)
+		return ret;
+
+	resp.state 	     = attr.state;
+	resp.max_mtu 	     = attr.max_mtu;
+	resp.active_mtu      = attr.active_mtu;
+	resp.gid_tbl_len     = attr.gid_tbl_len;
+	resp.port_cap_flags  = attr.port_cap_flags;
+	resp.max_msg_sz      = attr.max_msg_sz;
+	resp.bad_pkey_cntr   = attr.bad_pkey_cntr;
+	resp.qkey_viol_cntr  = attr.qkey_viol_cntr;
+	resp.pkey_tbl_len    = attr.pkey_tbl_len;
+	resp.lid 	     = attr.lid;
+	resp.sm_lid 	     = attr.sm_lid;
+	resp.lmc 	     = attr.lmc;
+	resp.max_vl_num      = attr.max_vl_num;
+	resp.sm_sl 	     = attr.sm_sl;
+	resp.subnet_timeout  = attr.subnet_timeout;
+	resp.init_type_reply = attr.init_type_reply;
+	resp.active_width    = attr.active_width;
+	resp.active_speed    = attr.active_speed;
+	resp.phys_state      = attr.phys_state;
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response,
+			 &resp, sizeof resp))
+		return -EFAULT;
+
+	return in_len;
+}
+
+ssize_t ib_uverbs_alloc_pd(struct ib_uverbs_file *file,
+			   const char __user *buf,
+			   int in_len, int out_len)
+{
+	struct ib_uverbs_alloc_pd      cmd;
+	struct ib_uverbs_alloc_pd_resp resp;
+	struct ib_uobject             *uobj;
+	struct ib_pd                  *pd;
+	int                            ret;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	uobj = kmalloc(sizeof *uobj, GFP_KERNEL);
+	if (!uobj)
+		return -ENOMEM;
+
+	uobj->context = file->ucontext;
+
+	pd = file->device->ib_dev->alloc_pd(file->device->ib_dev,
+					    file->ucontext, buf + sizeof cmd,
+					    in_len - sizeof cmd -
+					    sizeof (struct ib_uverbs_cmd_hdr));
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
+		goto err;
+	}
+
+	pd->device  = file->device->ib_dev;
+	pd->uobject = uobj;
+	atomic_set(&pd->usecnt, 0);
+
+retry:
+	if (!idr_pre_get(&ib_uverbs_pd_idr, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_pd;
+	}
+
+	down(&ib_uverbs_idr_mutex);
+	ret = idr_get_new(&ib_uverbs_pd_idr, pd, &uobj->id);
+	up(&ib_uverbs_idr_mutex);
+
+	if (ret == -EAGAIN)
+		goto retry;
+	if (ret)
+		goto err_pd;
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_add_tail(&uobj->list, &file->ucontext->pd_list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	resp.pd_handle = uobj->id;
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response,
+			 &resp, sizeof resp)) {
+		ret = -EFAULT;
+		goto err_list;
+	}
+
+	return in_len;
+
+err_list:
+ 	spin_lock_irq(&file->ucontext->lock);
+	list_del(&uobj->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	down(&ib_uverbs_idr_mutex);
+	idr_remove(&ib_uverbs_pd_idr, uobj->id);
+	up(&ib_uverbs_idr_mutex);
+
+err_pd:
+	ib_dealloc_pd(pd);
+
+err:
+	kfree(uobj);
+	return ret;
+}
+
+ssize_t ib_uverbs_dealloc_pd(struct ib_uverbs_file *file,
+			     const char __user *buf,
+			     int in_len, int out_len)
+{
+	struct ib_uverbs_dealloc_pd cmd;
+	struct ib_pd               *pd;
+	int                         ret = -EINVAL;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	down(&ib_uverbs_idr_mutex);
+
+	pd = idr_find(&ib_uverbs_pd_idr, cmd.pd_handle);
+	if (!pd || pd->uobject->context != file->ucontext)
+		goto out;
+
+	ret = ib_dealloc_pd(pd);
+	if (ret)
+		goto out;
+
+	idr_remove(&ib_uverbs_pd_idr, cmd.pd_handle);
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&pd->uobject->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	kfree(pd->uobject);
+
+out:
+	up(&ib_uverbs_idr_mutex);
+
+	return ret ? ret : in_len;
+}
+
+ssize_t ib_uverbs_reg_mr(struct ib_uverbs_file *file,
+			 const char __user *buf, int in_len,
+			 int out_len)
+{
+	struct ib_uverbs_reg_mr      cmd;
+	struct ib_uverbs_reg_mr_resp resp;
+	struct ib_umem_object       *obj;
+	struct ib_pd                *pd;
+	struct ib_mr                *mr;
+	int                          ret;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
+		return -EINVAL;
+
+	obj = kmalloc(sizeof *obj, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	obj->uobject.context = file->ucontext;
+
+	ret = ib_umem_get(file->device->ib_dev, &obj->umem,
+			  (void *) (unsigned long) cmd.start,
+			  cmd.length);
+	if (ret)
+		goto err_free;
+
+	obj->umem.virt_base = cmd.hca_va;
+
+	down(&ib_uverbs_idr_mutex);
+
+	pd = idr_find(&ib_uverbs_pd_idr, cmd.pd_handle);
+	if (!pd || pd->uobject->context != file->ucontext) {
+		ret = -EINVAL;
+		goto err_up;
+	}
+
+	if (!pd->device->reg_user_mr) {
+		ret = -ENOSYS;
+		goto err_up;
+	}
+
+	mr = pd->device->reg_user_mr(pd, &obj->umem,
+				     cmd.access_flags,
+				     buf + sizeof cmd,
+				     in_len - sizeof cmd -
+				     sizeof (struct ib_uverbs_cmd_hdr));
+	if (IS_ERR(mr)) {
+		ret = PTR_ERR(mr);
+		goto err_up;
+	}
+
+	mr->device  = pd->device;
+	mr->pd      = pd;
+	mr->uobject = &obj->uobject;
+	atomic_inc(&pd->usecnt);
+	atomic_set(&mr->usecnt, 0);
+
+	resp.lkey = mr->lkey;
+	resp.rkey = mr->rkey;
+
+retry:
+	if (!idr_pre_get(&ib_uverbs_mr_idr, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_unreg;
+	}
+
+	ret = idr_get_new(&ib_uverbs_mr_idr, mr, &obj->uobject.id);
+
+	if (ret == -EAGAIN)
+		goto retry;
+	if (ret)
+		goto err_unreg;
+
+	resp.mr_handle = obj->uobject.id;
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_add_tail(&obj->uobject.list, &file->ucontext->mr_list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response,
+			 &resp, sizeof resp)) {
+		ret = -EFAULT;
+		goto err_list;
+	}
+
+	up(&ib_uverbs_idr_mutex);
+
+	return in_len;
+
+err_list:
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&obj->uobject.list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+err_unreg:
+	ib_dereg_mr(mr);
+
+err_up:
+	up(&ib_uverbs_idr_mutex);
+
+	ib_umem_release(file->device->ib_dev, &obj->umem);
+
+err_free:
+	kfree(obj);
+	return ret;
+}
+
+ssize_t ib_uverbs_dereg_mr(struct ib_uverbs_file *file,
+			   const char __user *buf, int in_len,
+			   int out_len)
+{
+	struct ib_uverbs_dereg_mr cmd;
+	struct ib_mr             *mr;
+	struct ib_umem_object    *memobj;
+	int                       ret = -EINVAL;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	down(&ib_uverbs_idr_mutex);
+
+	mr = idr_find(&ib_uverbs_mr_idr, cmd.mr_handle);
+	if (!mr || mr->uobject->context != file->ucontext)
+		goto out;
+	
+	ret = ib_dereg_mr(mr);
+	if (ret)
+		goto out;
+
+	idr_remove(&ib_uverbs_mr_idr, cmd.mr_handle);
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&mr->uobject->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	memobj = container_of(mr->uobject, struct ib_umem_object, uobject);
+	ib_umem_release(file->device->ib_dev, &memobj->umem);
+	kfree(memobj);
+
+out:
+	up(&ib_uverbs_idr_mutex);
+
+	return ret ? ret : in_len;
+}
+
+ssize_t ib_uverbs_create_cq(struct ib_uverbs_file *file,
+			    const char __user *buf, int in_len,
+			    int out_len)
+{
+	struct ib_uverbs_create_cq      cmd;
+	struct ib_uverbs_create_cq_resp resp;
+	struct ib_uobject              *uobj;
+	struct ib_cq                   *cq;
+	int                             ret;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	uobj = kmalloc(sizeof *uobj, GFP_KERNEL);
+	if (!uobj)
+		return -ENOMEM;
+
+	uobj->user_handle = cmd.user_handle;
+	uobj->context     = file->ucontext;
+
+	cq = file->device->ib_dev->create_cq(file->device->ib_dev, cmd.cqe,
+					     file->ucontext, buf + sizeof cmd,
+					     in_len - sizeof cmd -
+					     sizeof (struct ib_uverbs_cmd_hdr));
+	if (IS_ERR(cq)) {
+		ret = PTR_ERR(cq);
+		goto err;
+	}
+
+	cq->device        = file->device->ib_dev;
+	cq->uobject       = uobj;
+	cq->comp_handler  = ib_uverbs_comp_handler;
+	cq->event_handler = ib_uverbs_cq_event_handler;
+	cq->cq_context    = file;
+	atomic_set(&cq->usecnt, 0);
+
+retry:
+	if (!idr_pre_get(&ib_uverbs_cq_idr, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_cq;
+	}
+
+	down(&ib_uverbs_idr_mutex);
+	ret = idr_get_new(&ib_uverbs_cq_idr, cq, &uobj->id);
+	up(&ib_uverbs_idr_mutex);
+
+	if (ret == -EAGAIN)
+		goto retry;
+	if (ret)
+		goto err_cq;
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_add_tail(&uobj->list, &file->ucontext->cq_list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	resp.cq_handle = uobj->id;
+	resp.cqe       = cq->cqe;
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response,
+			 &resp, sizeof resp)) {
+		ret = -EFAULT;
+		goto err_list;
+	}
+
+	return in_len;
+
+err_list:
+ 	spin_lock_irq(&file->ucontext->lock);
+	list_del(&uobj->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	down(&ib_uverbs_idr_mutex);
+	idr_remove(&ib_uverbs_cq_idr, uobj->id);
+	up(&ib_uverbs_idr_mutex);
+
+err_cq:
+	ib_destroy_cq(cq);
+
+err:
+	kfree(uobj);
+	return ret;
+}
+
+ssize_t ib_uverbs_destroy_cq(struct ib_uverbs_file *file,
+			     const char __user *buf, int in_len,
+			     int out_len)
+{
+	struct ib_uverbs_destroy_cq cmd;
+	struct ib_cq               *cq;
+	int                         ret = -EINVAL;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	down(&ib_uverbs_idr_mutex);
+
+	cq = idr_find(&ib_uverbs_cq_idr, cmd.cq_handle);
+	if (!cq || cq->uobject->context != file->ucontext)
+		goto out;
+
+	ret = ib_destroy_cq(cq);
+	if (ret)
+		goto out;
+
+	idr_remove(&ib_uverbs_cq_idr, cmd.cq_handle);
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&cq->uobject->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	kfree(cq->uobject);
+
+out:
+	up(&ib_uverbs_idr_mutex);
+
+	return ret ? ret : in_len;
+}
+
+ssize_t ib_uverbs_create_qp(struct ib_uverbs_file *file,
+			    const char __user *buf, int in_len,
+			    int out_len)
+{
+	struct ib_uverbs_create_qp      cmd;
+	struct ib_uverbs_create_qp_resp resp;
+	struct ib_uobject              *uobj;
+	struct ib_pd                   *pd;
+	struct ib_cq                   *scq, *rcq;
+	struct ib_qp                   *qp;
+	struct ib_qp_init_attr          attr;
+	int ret;
+
+	if (out_len < sizeof resp)
+		return -ENOSPC;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	uobj = kmalloc(sizeof *uobj, GFP_KERNEL);
+	if (!uobj)
+		return -ENOMEM;
+
+	down(&ib_uverbs_idr_mutex);
+
+	pd  = idr_find(&ib_uverbs_pd_idr, cmd.pd_handle);
+	scq = idr_find(&ib_uverbs_cq_idr, cmd.send_cq_handle);
+	rcq = idr_find(&ib_uverbs_cq_idr, cmd.recv_cq_handle);
+
+	if (!pd  || pd->uobject->context  != file->ucontext ||
+	    !scq || scq->uobject->context != file->ucontext ||
+	    !rcq || rcq->uobject->context != file->ucontext) {
+		ret = -EINVAL;
+		goto err_up;
+	}
+
+	attr.event_handler = ib_uverbs_qp_event_handler;
+	attr.qp_context    = file;
+	attr.send_cq       = scq;
+	attr.recv_cq       = rcq;
+	attr.srq           = NULL;
+	attr.sq_sig_type   = cmd.sq_sig_all ? IB_SIGNAL_ALL_WR : IB_SIGNAL_REQ_WR;
+	attr.qp_type       = cmd.qp_type;
+
+	attr.cap.max_send_wr     = cmd.max_send_wr;
+	attr.cap.max_recv_wr     = cmd.max_recv_wr;
+	attr.cap.max_send_sge    = cmd.max_send_sge;
+	attr.cap.max_recv_sge    = cmd.max_recv_sge;
+	attr.cap.max_inline_data = cmd.max_inline_data;
+
+	uobj->user_handle = cmd.user_handle;
+	uobj->context     = file->ucontext;
+
+	qp = pd->device->create_qp(pd, &attr, buf + sizeof cmd,
+				   in_len - sizeof cmd -
+				   sizeof (struct ib_uverbs_cmd_hdr));
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
+		goto err_up;
+	}
+
+	qp->device     	  = pd->device;
+	qp->pd         	  = pd;
+	qp->send_cq    	  = attr.send_cq;
+	qp->recv_cq    	  = attr.recv_cq;
+	qp->srq	       	  = attr.srq;
+	qp->uobject       = uobj;
+	qp->event_handler = attr.event_handler;
+	qp->qp_context    = attr.qp_context;
+	qp->qp_type	  = attr.qp_type;
+	atomic_inc(&pd->usecnt);
+	atomic_inc(&attr.send_cq->usecnt);
+	atomic_inc(&attr.recv_cq->usecnt);
+	if (attr.srq)
+		atomic_inc(&attr.srq->usecnt);
+
+	resp.qpn = qp->qp_num;
+
+retry:
+	if (!idr_pre_get(&ib_uverbs_qp_idr, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_destroy;
+	}
+
+	ret = idr_get_new(&ib_uverbs_qp_idr, qp, &uobj->id);
+
+	if (ret == -EAGAIN)
+		goto retry;
+	if (ret)
+		goto err_destroy;
+
+	resp.qp_handle = uobj->id;
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_add_tail(&uobj->list, &file->ucontext->qp_list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	if (copy_to_user((void __user *) (unsigned long) cmd.response,
+			 &resp, sizeof resp)) {
+		ret = -EFAULT;
+		goto err_list;
+	}
+
+	up(&ib_uverbs_idr_mutex);
+
+	return in_len;
+
+err_list:
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&uobj->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+err_destroy:
+	ib_destroy_qp(qp);
+
+err_up:
+	up(&ib_uverbs_idr_mutex);
+
+	kfree(uobj);
+	return ret;
+}
+
+ssize_t ib_uverbs_modify_qp(struct ib_uverbs_file *file,
+			    const char __user *buf, int in_len,
+			    int out_len)
+{
+	struct ib_uverbs_modify_qp cmd;
+	struct ib_qp              *qp;
+	struct ib_qp_attr         *attr;
+	int                        ret;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	down(&ib_uverbs_idr_mutex);
+
+	qp = idr_find(&ib_uverbs_qp_idr, cmd.qp_handle);
+	if (!qp || qp->uobject->context != file->ucontext) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	attr->qp_state 		  = cmd.qp_state;
+	attr->cur_qp_state 	  = cmd.cur_qp_state;
+	attr->path_mtu 		  = cmd.path_mtu;
+	attr->path_mig_state 	  = cmd.path_mig_state;
+	attr->qkey 		  = cmd.qkey;
+	attr->rq_psn 		  = cmd.rq_psn;
+	attr->sq_psn 		  = cmd.sq_psn;
+	attr->dest_qp_num 	  = cmd.dest_qp_num;
+	attr->qp_access_flags 	  = cmd.qp_access_flags;
+	attr->pkey_index 	  = cmd.pkey_index;
+	attr->alt_pkey_index 	  = cmd.pkey_index;
+	attr->en_sqd_async_notify = cmd.en_sqd_async_notify;
+	attr->max_rd_atomic 	  = cmd.max_rd_atomic;
+	attr->max_dest_rd_atomic  = cmd.max_dest_rd_atomic;
+	attr->min_rnr_timer 	  = cmd.min_rnr_timer;
+	attr->port_num 		  = cmd.port_num;
+	attr->timeout 		  = cmd.timeout;
+	attr->retry_cnt 	  = cmd.retry_cnt;
+	attr->rnr_retry 	  = cmd.rnr_retry;
+	attr->alt_port_num 	  = cmd.alt_port_num;
+	attr->alt_timeout 	  = cmd.alt_timeout;
+
+	memcpy(attr->ah_attr.grh.dgid.raw, cmd.dest.dgid, 16);
+	attr->ah_attr.grh.flow_label        = cmd.dest.flow_label;
+	attr->ah_attr.grh.sgid_index        = cmd.dest.sgid_index;
+	attr->ah_attr.grh.hop_limit         = cmd.dest.hop_limit;
+	attr->ah_attr.grh.traffic_class     = cmd.dest.traffic_class;
+	attr->ah_attr.dlid 	    	    = cmd.dest.dlid;
+	attr->ah_attr.sl   	    	    = cmd.dest.sl;
+	attr->ah_attr.src_path_bits 	    = cmd.dest.src_path_bits;
+	attr->ah_attr.static_rate   	    = cmd.dest.static_rate;
+	attr->ah_attr.ah_flags 	    	    = cmd.dest.is_global ? IB_AH_GRH : 0;
+	attr->ah_attr.port_num 	    	    = cmd.dest.port_num;
+
+	memcpy(attr->alt_ah_attr.grh.dgid.raw, cmd.alt_dest.dgid, 16);
+	attr->alt_ah_attr.grh.flow_label    = cmd.alt_dest.flow_label;
+	attr->alt_ah_attr.grh.sgid_index    = cmd.alt_dest.sgid_index;
+	attr->alt_ah_attr.grh.hop_limit     = cmd.alt_dest.hop_limit;
+	attr->alt_ah_attr.grh.traffic_class = cmd.alt_dest.traffic_class;
+	attr->alt_ah_attr.dlid 	    	    = cmd.alt_dest.dlid;
+	attr->alt_ah_attr.sl   	    	    = cmd.alt_dest.sl;
+	attr->alt_ah_attr.src_path_bits     = cmd.alt_dest.src_path_bits;
+	attr->alt_ah_attr.static_rate       = cmd.alt_dest.static_rate;
+	attr->alt_ah_attr.ah_flags 	    = cmd.alt_dest.is_global ? IB_AH_GRH : 0;
+	attr->alt_ah_attr.port_num 	    = cmd.alt_dest.port_num;
+
+	ret = ib_modify_qp(qp, attr, cmd.attr_mask);
+	if (ret)
+		goto out;
+
+	ret = in_len;
+
+out:
+	up(&ib_uverbs_idr_mutex);
+	kfree(attr);
+
+	return ret;
+}
+
+ssize_t ib_uverbs_destroy_qp(struct ib_uverbs_file *file,
+			     const char __user *buf, int in_len,
+			     int out_len)
+{
+	struct ib_uverbs_destroy_qp cmd;
+	struct ib_qp               *qp;
+	int                         ret = -EINVAL;
+
+	if (copy_from_user(&cmd, buf, sizeof cmd))
+		return -EFAULT;
+
+	down(&ib_uverbs_idr_mutex);
+
+	qp = idr_find(&ib_uverbs_qp_idr, cmd.qp_handle);
+	if (!qp || qp->uobject->context != file->ucontext)
+		goto out;
+
+	ret = ib_destroy_qp(qp);
+	if (ret)
+		goto out;
+
+	idr_remove(&ib_uverbs_qp_idr, cmd.qp_handle);
+
+	spin_lock_irq(&file->ucontext->lock);
+	list_del(&qp->uobject->list);
+	spin_unlock_irq(&file->ucontext->lock);
+
+	kfree(qp->uobject);
+
+out:
+	up(&ib_uverbs_idr_mutex);
+
+	return ret ? ret : in_len;
+}
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/core/uverbs_main.c	2005-04-04 14:53:17.824728218 -0700
@@ -0,0 +1,688 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
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
+ *
+ * $Id: uverbs_main.c 2109 2005-04-04 21:10:34Z roland $
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+
+#include <asm/uaccess.h>
+
+#include "uverbs.h"
+
+MODULE_AUTHOR("Roland Dreier");
+MODULE_DESCRIPTION("InfiniBand userspace verbs access");
+MODULE_LICENSE("Dual BSD/GPL");
+
+#define INFINIBANDEVENTFS_MAGIC	0x49426576	/* "IBev" */
+
+enum {
+	IB_UVERBS_MAJOR       = 231,
+	IB_UVERBS_BASE_MINOR  = 128,
+	IB_UVERBS_MAX_DEVICES = 32
+};
+
+#define IB_UVERBS_BASE_DEV	MKDEV(IB_UVERBS_MAJOR, IB_UVERBS_BASE_MINOR)
+
+DECLARE_MUTEX(ib_uverbs_idr_mutex);
+DEFINE_IDR(ib_uverbs_pd_idr);
+DEFINE_IDR(ib_uverbs_mr_idr);
+DEFINE_IDR(ib_uverbs_mw_idr);
+DEFINE_IDR(ib_uverbs_ah_idr);
+DEFINE_IDR(ib_uverbs_cq_idr);
+DEFINE_IDR(ib_uverbs_qp_idr);
+
+static spinlock_t map_lock;
+static DECLARE_BITMAP(dev_map, IB_UVERBS_MAX_DEVICES);
+
+static ssize_t (*uverbs_cmd_table[])(struct ib_uverbs_file *file,
+				     const char __user *buf, int in_len,
+				     int out_len) = {
+	[IB_USER_VERBS_CMD_QUERY_PARAMS]  = ib_uverbs_query_params,
+	[IB_USER_VERBS_CMD_GET_CONTEXT]   = ib_uverbs_get_context,
+	[IB_USER_VERBS_CMD_QUERY_PORT]    = ib_uverbs_query_port,
+	[IB_USER_VERBS_CMD_ALLOC_PD]      = ib_uverbs_alloc_pd,
+	[IB_USER_VERBS_CMD_DEALLOC_PD]    = ib_uverbs_dealloc_pd,
+	[IB_USER_VERBS_CMD_REG_MR]        = ib_uverbs_reg_mr,
+	[IB_USER_VERBS_CMD_DEREG_MR]      = ib_uverbs_dereg_mr,
+	[IB_USER_VERBS_CMD_CREATE_CQ]     = ib_uverbs_create_cq,
+	[IB_USER_VERBS_CMD_DESTROY_CQ]    = ib_uverbs_destroy_cq,
+	[IB_USER_VERBS_CMD_CREATE_QP]     = ib_uverbs_create_qp,
+	[IB_USER_VERBS_CMD_MODIFY_QP]     = ib_uverbs_modify_qp,
+	[IB_USER_VERBS_CMD_DESTROY_QP]    = ib_uverbs_destroy_qp,
+};
+
+static struct vfsmount *uverbs_event_mnt;
+
+static void ib_uverbs_add_one(struct ib_device *device);
+static void ib_uverbs_remove_one(struct ib_device *device);
+
+static int ib_dealloc_ucontext(struct ib_ucontext *context)
+{
+	struct ib_uobject *uobj, *tmp;
+
+	if (!context)
+		return 0;
+
+	/* Free AHs */
+
+	list_for_each_entry_safe(uobj, tmp, &context->qp_list, list) {
+		struct ib_qp *qp = idr_find(&ib_uverbs_qp_idr, uobj->id);
+		idr_remove(&ib_uverbs_qp_idr, uobj->id);
+		ib_destroy_qp(qp);
+		list_del(&uobj->list);
+		kfree(uobj);
+	}
+
+	list_for_each_entry_safe(uobj, tmp, &context->cq_list, list) {
+		struct ib_cq *cq = idr_find(&ib_uverbs_cq_idr, uobj->id);
+		idr_remove(&ib_uverbs_cq_idr, uobj->id);
+		ib_destroy_cq(cq);
+		list_del(&uobj->list);
+		kfree(uobj);
+	}
+
+	/* XXX Free SRQs */
+	/* XXX Free MWs */
+
+	list_for_each_entry_safe(uobj, tmp, &context->mr_list, list) {
+		struct ib_mr *mr = idr_find(&ib_uverbs_mr_idr, uobj->id);
+		struct ib_umem_object *memobj;
+
+		memobj = container_of(uobj, struct ib_umem_object, uobject);
+		ib_umem_release(mr->device, &memobj->umem);
+
+		idr_remove(&ib_uverbs_mr_idr, uobj->id);
+		ib_dereg_mr(mr);
+		list_del(&uobj->list);
+		kfree(memobj);
+	}
+
+	list_for_each_entry_safe(uobj, tmp, &context->pd_list, list) {
+		struct ib_pd *pd = idr_find(&ib_uverbs_pd_idr, uobj->id);
+		idr_remove(&ib_uverbs_pd_idr, uobj->id);
+		ib_dealloc_pd(pd);
+		list_del(&uobj->list);
+		kfree(uobj);
+	}
+
+	return context->device->dealloc_ucontext(context);
+}
+
+static void ib_uverbs_release_file(struct kref *ref)
+{
+	struct ib_uverbs_file *file = 
+		container_of(ref, struct ib_uverbs_file, ref);
+
+	module_put(file->device->ib_dev->owner);
+	kfree(file);
+}
+
+static ssize_t ib_uverbs_event_read(struct file *filp, char __user *buf,
+				    size_t count, loff_t *pos)
+{
+	struct ib_uverbs_event_file *file = filp->private_data;
+	void *event;
+	int eventsz;
+	int ret = 0;
+
+	spin_lock_irq(&file->lock);
+
+	while (list_empty(&file->event_list) && file->fd >= 0) {
+		spin_unlock_irq(&file->lock);
+
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		if (wait_event_interruptible(file->poll_wait,
+					     !list_empty(&file->event_list) ||
+					     file->fd < 0))
+			return -ERESTARTSYS;
+
+		spin_lock_irq(&file->lock);
+	}
+
+	if (file->fd < 0) {
+		spin_unlock_irq(&file->lock);
+		return -ENODEV;
+	}
+
+	if (file->is_async) {
+		event   = list_entry(file->event_list.next,
+				     struct ib_uverbs_async_event, list);
+		eventsz = sizeof (struct ib_uverbs_async_event_desc);
+	} else {
+		event   = list_entry(file->event_list.next,
+				     struct ib_uverbs_comp_event, list);
+		eventsz = sizeof (struct ib_uverbs_comp_event_desc);
+	}
+
+	if (eventsz > count) {
+		ret   = -EINVAL;
+		event = NULL;
+	} else
+		list_del(file->event_list.next);
+
+	spin_unlock_irq(&file->lock);
+
+	if (event) {
+		if (copy_to_user(buf, event, eventsz))
+			ret = -EFAULT;
+		else
+			ret = eventsz;
+	}
+
+	kfree(event);
+
+	return ret;
+}
+
+static unsigned int ib_uverbs_event_poll(struct file *filp,
+					 struct poll_table_struct *wait)
+{
+	unsigned int pollflags = 0;
+	struct ib_uverbs_event_file *file = filp->private_data;
+
+	poll_wait(filp, &file->poll_wait, wait);
+
+	spin_lock_irq(&file->lock);
+	if (file->fd < 0)
+		pollflags = POLLERR;
+	else if (!list_empty(&file->event_list))
+		pollflags = POLLIN | POLLRDNORM;
+	spin_unlock_irq(&file->lock);
+
+	return pollflags;
+}
+
+static void ib_uverbs_event_release(struct ib_uverbs_event_file *file)
+{
+	struct list_head *entry, *tmp;
+	int put = 0;
+
+	spin_lock_irq(&file->lock);
+	if (file->fd != -1) {
+		put      = 1;
+		file->fd = -1;
+		list_for_each_safe(entry, tmp, &file->event_list)
+			if (file->is_async)
+				kfree(list_entry(entry, struct ib_uverbs_async_event, list));
+			else
+				kfree(list_entry(entry, struct ib_uverbs_comp_event, list));
+	}
+	spin_unlock_irq(&file->lock);
+
+	if (put)
+		kref_put(&file->uverbs_file->ref, ib_uverbs_release_file);
+
+}
+
+static int ib_uverbs_event_close(struct inode *inode, struct file *filp)
+{
+	struct ib_uverbs_event_file *file = filp->private_data;
+
+	ib_uverbs_event_release(file);
+
+	return 0;
+}
+
+static struct file_operations uverbs_event_fops = {
+	/*
+	 * No .owner field since we artificially create event files,
+	 * so there is no increment to the module reference count in
+	 * the open path.  All event files come from a uverbs command
+	 * file, which already takes a module reference, so this is OK.
+	 */
+	.read 	 = ib_uverbs_event_read,
+	.poll    = ib_uverbs_event_poll,
+	.release = ib_uverbs_event_close
+};
+
+void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
+{
+	struct ib_uverbs_file       *file = cq_context;
+	struct ib_uverbs_comp_event *entry;
+	unsigned long                flags;
+
+	entry = kmalloc(sizeof *entry, GFP_ATOMIC);
+	if (!entry)
+		return;
+
+	entry->desc.cq_handle = cq->uobject->user_handle;
+
+	spin_lock_irqsave(&file->comp_file[0].lock, flags);
+	list_add_tail(&entry->list, &file->comp_file[0].event_list);
+	spin_unlock_irqrestore(&file->comp_file[0].lock, flags);
+
+	wake_up_interruptible(&file->comp_file[0].poll_wait);
+}
+
+void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
+{
+
+}
+
+void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr)
+{
+
+}
+
+static void ib_uverbs_event_handler(struct ib_event_handler *handler,
+				    struct ib_event *event)
+{
+	struct ib_uverbs_file *file =
+		container_of(handler, struct ib_uverbs_file, event_handler);
+	struct ib_uverbs_async_event *entry;
+	unsigned long flags;
+
+	entry = kmalloc(sizeof *entry, GFP_ATOMIC);
+	if (!entry)
+		return;
+
+	entry->desc.event_type = event->event;
+	entry->desc.element    = event->element.port_num;
+
+	spin_lock_irqsave(&file->async_file.lock, flags);
+	list_add_tail(&entry->list, &file->async_file.event_list);
+	spin_unlock_irqrestore(&file->async_file.lock, flags);
+
+	wake_up_interruptible(&file->async_file.poll_wait);
+}
+
+static int ib_uverbs_event_init(struct ib_uverbs_event_file *file,
+				struct ib_uverbs_file *uverbs_file)
+{
+	struct file *filp;
+
+	spin_lock_init(&file->lock);
+	INIT_LIST_HEAD(&file->event_list);
+	init_waitqueue_head(&file->poll_wait);
+	file->uverbs_file = uverbs_file;
+
+	file->fd = get_unused_fd();
+	if (file->fd < 0)
+		return file->fd;
+
+	filp = get_empty_filp();
+	if (!filp) {
+		put_unused_fd(file->fd);
+		return -ENFILE;
+	}
+
+	filp->f_op 	   = &uverbs_event_fops;
+	filp->f_vfsmnt 	   = mntget(uverbs_event_mnt);
+	filp->f_dentry 	   = dget(uverbs_event_mnt->mnt_root);
+	filp->f_mapping    = filp->f_dentry->d_inode->i_mapping;
+	filp->f_flags      = O_RDONLY;
+	filp->f_mode       = FMODE_READ;
+	filp->private_data = file;
+
+	fd_install(file->fd, filp);
+
+	return 0;
+}
+
+static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
+			     size_t count, loff_t *pos)
+{
+	struct ib_uverbs_file *file = filp->private_data;
+	struct ib_uverbs_cmd_hdr hdr;
+
+	if (count < sizeof hdr)
+		return -EINVAL;
+
+	if (copy_from_user(&hdr, buf, sizeof hdr))
+		return -EFAULT;
+
+	if (hdr.in_words * 4 != count)
+		return -EINVAL;
+
+	if (hdr.command < 0 || hdr.command >= ARRAY_SIZE(uverbs_cmd_table))
+		return -EINVAL;
+
+	if (!file->ucontext                               &&
+	    hdr.command != IB_USER_VERBS_CMD_QUERY_PARAMS &&
+	    hdr.command != IB_USER_VERBS_CMD_GET_CONTEXT)
+		return -EINVAL;
+
+	return uverbs_cmd_table[hdr.command](file, buf + sizeof hdr,
+					     hdr.in_words * 4, hdr.out_words * 4);
+}
+
+static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ib_uverbs_file *file = filp->private_data;
+
+	return file->device->ib_dev->mmap(file->ucontext, vma);
+}
+
+static int ib_uverbs_open(struct inode *inode, struct file *filp)
+{
+	struct ib_uverbs_device *dev =
+		container_of(inode->i_cdev, struct ib_uverbs_device, dev);
+	struct ib_uverbs_file *file;
+	int i = 0;
+	int ret;
+
+	if (!try_module_get(dev->ib_dev->owner))
+		return -ENODEV;
+
+	file = kmalloc(sizeof *file +
+		       (dev->num_comp - 1) * sizeof (struct ib_uverbs_event_file),
+		       GFP_KERNEL);
+	if (!file)
+		return -ENOMEM;
+
+	file->device = dev;
+	kref_init(&file->ref);
+
+	file->ucontext = NULL;
+
+	ret = ib_uverbs_event_init(&file->async_file, file);
+	if (ret)
+		goto err;
+
+	file->async_file.is_async = 1;
+
+	kref_get(&file->ref);
+
+	for (i = 0; i < dev->num_comp; ++i) {
+		ret = ib_uverbs_event_init(&file->comp_file[i], file);
+		if (ret)
+			goto err_async;
+		kref_get(&file->ref);
+		file->comp_file[i].is_async = 0;
+	}
+
+
+	filp->private_data = file;
+
+	INIT_IB_EVENT_HANDLER(&file->event_handler, dev->ib_dev,
+			      ib_uverbs_event_handler);
+	if (ib_register_event_handler(&file->event_handler))
+		goto err_async;
+
+	return 0;
+
+err_async:
+	while (i--)
+		ib_uverbs_event_release(&file->comp_file[i]);
+
+	ib_uverbs_event_release(&file->async_file);
+
+err:
+	kref_put(&file->ref, ib_uverbs_release_file);
+
+	return ret;
+}
+
+static int ib_uverbs_close(struct inode *inode, struct file *filp)
+{
+	struct ib_uverbs_file *file = filp->private_data;
+	int i;
+
+	ib_unregister_event_handler(&file->event_handler);
+	ib_uverbs_event_release(&file->async_file);
+	ib_dealloc_ucontext(file->ucontext);
+
+	for (i = 0; i < file->device->num_comp; ++i)
+		ib_uverbs_event_release(&file->comp_file[i]);
+
+	kref_put(&file->ref, ib_uverbs_release_file);
+
+	return 0;
+}
+
+static struct file_operations uverbs_fops = {
+	.owner 	 = THIS_MODULE,
+	.write 	 = ib_uverbs_write,
+	.open 	 = ib_uverbs_open,
+	.release = ib_uverbs_close
+};
+
+static struct file_operations uverbs_mmap_fops = {
+	.owner 	 = THIS_MODULE,
+	.write 	 = ib_uverbs_write,
+	.mmap    = ib_uverbs_mmap,
+	.open 	 = ib_uverbs_open,
+	.release = ib_uverbs_close
+};
+
+static struct ib_client uverbs_client = {
+	.name   = "uverbs",
+	.add    = ib_uverbs_add_one,
+	.remove = ib_uverbs_remove_one
+};
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct ib_uverbs_device *dev =
+		container_of(class_dev, struct ib_uverbs_device, class_dev);
+
+	return print_dev_t(buf, dev->dev.dev);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
+{
+	struct ib_uverbs_device *dev =
+		container_of(class_dev, struct ib_uverbs_device, class_dev);
+
+	return sprintf(buf, "%s\n", dev->ib_dev->name);
+}
+static CLASS_DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
+
+static void ib_uverbs_release_class_dev(struct class_device *class_dev)
+{
+	struct ib_uverbs_device *dev =
+		container_of(class_dev, struct ib_uverbs_device, class_dev);
+
+	cdev_del(&dev->dev);
+	clear_bit(dev->devnum, dev_map);
+	kfree(dev);
+}
+
+static struct class uverbs_class = {
+	.name    = "infiniband_verbs",
+	.release = ib_uverbs_release_class_dev
+};
+
+static ssize_t show_abi_version(struct class *class, char *buf)
+{
+	return sprintf(buf, "%d\n", IB_USER_VERBS_ABI_VERSION);
+}
+static CLASS_ATTR(abi_version, S_IRUGO, show_abi_version, NULL);
+
+static void ib_uverbs_add_one(struct ib_device *device)
+{
+	struct ib_uverbs_device *uverbs_dev;
+
+	if (!device->alloc_ucontext)
+		return;
+
+	uverbs_dev = kmalloc(sizeof *uverbs_dev, GFP_KERNEL);
+	if (!uverbs_dev)
+		return;
+
+	memset(uverbs_dev, 0, sizeof *uverbs_dev);
+
+	spin_lock(&map_lock);
+	uverbs_dev->devnum = find_first_zero_bit(dev_map, IB_UVERBS_MAX_DEVICES);
+	if (uverbs_dev->devnum >= IB_UVERBS_MAX_DEVICES) {
+		spin_unlock(&map_lock);
+		goto err;
+	}
+	set_bit(uverbs_dev->devnum, dev_map);
+	spin_unlock(&map_lock);
+
+	uverbs_dev->ib_dev   = device;
+	uverbs_dev->num_comp = 1;
+
+	if (device->mmap)
+		cdev_init(&uverbs_dev->dev, &uverbs_mmap_fops);
+	else
+		cdev_init(&uverbs_dev->dev, &uverbs_fops);
+	uverbs_dev->dev.owner = THIS_MODULE;
+	kobject_set_name(&uverbs_dev->dev.kobj, "uverbs%d", uverbs_dev->devnum);
+	if (cdev_add(&uverbs_dev->dev, IB_UVERBS_BASE_DEV + uverbs_dev->devnum, 1))
+		goto err;
+
+	uverbs_dev->class_dev.class = &uverbs_class;
+	uverbs_dev->class_dev.dev   = device->dma_device;
+	snprintf(uverbs_dev->class_dev.class_id, BUS_ID_SIZE, "uverbs%d", uverbs_dev->devnum);
+	if (class_device_register(&uverbs_dev->class_dev))
+		goto err_cdev;
+
+	if (class_device_create_file(&uverbs_dev->class_dev, &class_device_attr_dev))
+		goto err_class;
+	if (class_device_create_file(&uverbs_dev->class_dev, &class_device_attr_ibdev))
+		goto err_class;
+
+	ib_set_client_data(device, &uverbs_client, uverbs_dev);
+
+	return;
+
+err_class:
+	class_device_unregister(&uverbs_dev->class_dev);
+
+err_cdev:
+	cdev_del(&uverbs_dev->dev);
+	clear_bit(uverbs_dev->devnum, dev_map);
+
+err:
+	kfree(uverbs_dev);
+	return;
+}
+
+static void ib_uverbs_remove_one(struct ib_device *device)
+{
+	struct ib_uverbs_device *uverbs_dev = ib_get_client_data(device, &uverbs_client);
+
+	if (!uverbs_dev)
+		return;
+
+	class_device_unregister(&uverbs_dev->class_dev);
+}
+
+static struct super_block *uverbs_event_get_sb(struct file_system_type *fs_type, int flags,
+					       const char *dev_name, void *data)
+{
+	return get_sb_pseudo(fs_type, "infinibandevent:", NULL,
+			     INFINIBANDEVENTFS_MAGIC);
+}
+
+static struct file_system_type uverbs_event_fs = {
+	/* No owner field so module can be unloaded */
+	.name    = "infinibandeventfs",
+	.get_sb  = uverbs_event_get_sb,
+	.kill_sb = kill_litter_super
+};
+
+static int __init ib_uverbs_init(void)
+{
+	int ret;
+
+	spin_lock_init(&map_lock);
+
+	ret = register_chrdev_region(IB_UVERBS_BASE_DEV, IB_UVERBS_MAX_DEVICES,
+				     "infiniband_verbs");
+	if (ret) {
+		printk(KERN_ERR "user_verbs: couldn't register device number\n");
+		goto out;
+	}
+
+	ret = class_register(&uverbs_class);
+	if (ret) {
+		printk(KERN_ERR "user_verbs: couldn't create class infiniband_verbs\n");
+		goto out_chrdev;
+	}
+
+	ret = class_create_file(&uverbs_class, &class_attr_abi_version);
+	if (ret) {
+		printk(KERN_ERR "user_verbs: couldn't create abi_version attribute\n");
+		goto out_class;
+	}
+
+	ret = register_filesystem(&uverbs_event_fs);
+	if (ret) {
+		printk(KERN_ERR "user_verbs: couldn't register infinibandeventfs\n");
+		goto out_class;
+	}
+
+	uverbs_event_mnt = kern_mount(&uverbs_event_fs);
+	if (IS_ERR(uverbs_event_mnt)) {
+		ret = PTR_ERR(uverbs_event_mnt);
+		printk(KERN_ERR "user_verbs: couldn't mount infinibandeventfs\n");
+		goto out_fs;
+	}
+
+	ret = ib_register_client(&uverbs_client);
+	if (ret) {
+		printk(KERN_ERR "user_verbs: couldn't register client\n");
+		goto out_mnt;
+	}
+
+	return 0;
+
+out_mnt:
+	mntput(uverbs_event_mnt);
+
+out_fs:
+	unregister_filesystem(&uverbs_event_fs);
+
+out_class:
+	class_unregister(&uverbs_class);
+
+out_chrdev:
+	unregister_chrdev_region(IB_UVERBS_BASE_DEV, IB_UVERBS_MAX_DEVICES);
+
+out:
+	return ret;
+}
+
+static void __exit ib_uverbs_cleanup(void)
+{
+	ib_unregister_client(&uverbs_client);
+	unregister_filesystem(&uverbs_event_fs);
+	mntput(uverbs_event_mnt);
+	class_unregister(&uverbs_class);
+	unregister_chrdev_region(IB_UVERBS_BASE_DEV, IB_UVERBS_MAX_DEVICES);
+}
+
+module_init(ib_uverbs_init);
+module_exit(ib_uverbs_cleanup);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/core/uverbs_mem.c	2005-04-04 14:53:17.825728001 -0700
@@ -0,0 +1,202 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
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
+ *
+ * $Id: uverbs_mem.c 1979 2005-03-11 21:17:00Z roland $
+ */
+
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+
+#include "uverbs.h"
+
+static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem)
+{
+	struct ib_umem_chunk *chunk, *tmp;
+	int i;
+
+	list_for_each_entry_safe(chunk, tmp, &umem->chunk_list, list) {
+		dma_unmap_sg(dev->dma_device, chunk->page_list,
+			     chunk->nents, DMA_BIDIRECTIONAL);
+		for (i = 0; i < chunk->nents; ++i) {
+			set_page_dirty_lock(chunk->page_list[i].page);
+			put_page(chunk->page_list[i].page);
+		}
+
+		kfree(chunk);
+	}
+}
+
+static void __ib_umem_unmark(struct ib_umem *umem, struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	unsigned long cur_base;
+
+	vma = find_vma(mm, umem->user_base);
+
+	for (cur_base = umem->user_base;
+	     cur_base < umem->user_base + umem->length;
+	     cur_base = vma->vm_end) {
+		if (!vma || vma->vm_start > umem->user_base + umem->length)
+			break;
+
+		if (!(vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+			vma->vm_flags &= ~VM_DONTCOPY;
+
+		vma = vma->vm_next;
+	}
+}
+
+int ib_umem_get(struct ib_device *dev, struct ib_umem *mem,
+		void *addr, size_t size)
+{
+	struct page **page_list;
+	struct vm_area_struct *vma;
+	struct ib_umem_chunk *chunk;
+	unsigned long cur_base;
+	int npages;
+	int ret = 0;
+	int off;
+	int i;
+
+	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+	if (!page_list)
+		return -ENOMEM;
+
+	mem->user_base = (unsigned long) addr;
+	mem->length    = size;
+	mem->offset    = (unsigned long) addr & ~PAGE_MASK;
+	mem->page_size = PAGE_SIZE;
+
+	INIT_LIST_HEAD(&mem->chunk_list);
+
+	npages   = PAGE_ALIGN(size + mem->offset) >> PAGE_SHIFT;
+
+	down_write(&current->mm->mmap_sem);
+
+	vma = find_vma(current->mm, mem->user_base);
+
+	for (cur_base = mem->user_base;
+	     cur_base < mem->user_base + size;
+	     cur_base = vma->vm_end) {
+		if (!vma || vma->vm_start > cur_base) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (!(vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+			vma->vm_flags |= VM_DONTCOPY;
+
+		vma = vma->vm_next;
+	}
+
+	cur_base = (unsigned long) addr & PAGE_MASK;
+
+	while (npages) {
+		ret = get_user_pages(current, current->mm, cur_base,
+				     min_t(int, npages,
+					   PAGE_SIZE / sizeof (struct page *)),
+				     1, 0, page_list, NULL);
+
+		if (ret < 0)
+			goto out;
+
+		cur_base += ret * PAGE_SIZE;
+		npages   -= ret;
+
+		off = 0;
+
+		while (ret) {
+			chunk = kmalloc(sizeof *chunk + sizeof (struct scatterlist) *
+					min_t(int, ret, IB_UMEM_MAX_PAGE_CHUNK),
+					GFP_KERNEL);
+			if (!chunk) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			chunk->nents = min_t(int, ret, IB_UMEM_MAX_PAGE_CHUNK);
+			for (i = 0; i < chunk->nents; ++i) {
+				chunk->page_list[i].page   = page_list[i + off];
+				chunk->page_list[i].offset = 0;
+				chunk->page_list[i].length = PAGE_SIZE;
+			}
+
+			chunk->nmap = dma_map_sg(dev->dma_device,
+						 &chunk->page_list[0],
+						 chunk->nents,
+						 DMA_BIDIRECTIONAL);
+			if (chunk->nmap <= 0) {
+				for (i = 0; i < chunk->nents; ++i)
+					put_page(chunk->page_list[i].page);
+				kfree(chunk);
+
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			ret -= chunk->nents;
+			off += chunk->nents;
+			list_add_tail(&chunk->list, &mem->chunk_list);
+		}
+
+		ret = 0;
+	}
+
+out:
+	if (ret < 0) {
+		__ib_umem_unmark(mem, current->mm);
+		__ib_umem_release(dev, mem);
+	}
+
+	up_write(&current->mm->mmap_sem);
+	free_page((unsigned long) page_list);
+
+	return ret;
+}
+
+void ib_umem_release(struct ib_device *dev, struct ib_umem *umem)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+
+	if (mm) {
+		down_write(&mm->mmap_sem);
+		__ib_umem_unmark(umem, mm);
+	}
+
+	__ib_umem_release(dev, umem);
+
+	if (mm) {
+		up_write(&current->mm->mmap_sem);
+		mmput(mm);
+	}
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/include/ib_user_verbs.h	2005-04-04 14:55:47.946083444 -0700
@@ -0,0 +1,275 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
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
+ *
+ * $Id: ib_user_verbs.h 2001 2005-03-16 04:15:41Z roland $
+ */
+
+#ifndef IB_USER_VERBS_H
+#define IB_USER_VERBS_H
+
+#include <linux/types.h>
+
+/*
+ * Increment this value if any changes that break userspace ABI
+ * compatibility are made.
+ */
+#define IB_USER_VERBS_ABI_VERSION	1
+
+enum {
+	IB_USER_VERBS_CMD_QUERY_PARAMS,
+	IB_USER_VERBS_CMD_GET_CONTEXT,
+	IB_USER_VERBS_CMD_QUERY_PORT,
+	IB_USER_VERBS_CMD_ALLOC_PD,
+	IB_USER_VERBS_CMD_DEALLOC_PD,
+	IB_USER_VERBS_CMD_REG_MR,
+	IB_USER_VERBS_CMD_DEREG_MR,
+	IB_USER_VERBS_CMD_CREATE_CQ,
+	IB_USER_VERBS_CMD_DESTROY_CQ,
+	IB_USER_VERBS_CMD_CREATE_QP,
+	IB_USER_VERBS_CMD_MODIFY_QP,
+	IB_USER_VERBS_CMD_DESTROY_QP,
+};
+
+/*
+ * Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ * In particular do not use pointer types -- pass pointers in __u64
+ * instead.
+ */
+
+struct ib_uverbs_async_event_desc {
+	__u64 element;
+	__u32 event_type;	/* enum ib_event_type */
+	__u32 reserved;
+};
+
+struct ib_uverbs_comp_event_desc {
+	__u64 cq_handle;
+};
+
+/*
+ * All commands from userspace should start with a __u32 command field
+ * followed by __u16 in_words and out_words fields (which give the
+ * length of the command block and response buffer if any in 32-bit
+ * words).  The kernel driver will read these fields first and read
+ * the rest of the command struct based on these value.
+ */
+
+struct ib_uverbs_cmd_hdr {
+	__u32 command;
+	__u16 in_words;
+	__u16 out_words;
+};
+
+/*
+ * No driver_data for "query params" command, since this is intended
+ * to be a core function with no possible device dependence.
+ */
+struct ib_uverbs_query_params {
+	__u64 response;
+};
+
+struct ib_uverbs_query_params_resp {
+	__u32 num_cq_events;
+};
+
+struct ib_uverbs_get_context {
+	__u64 response;
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_get_context_resp {
+	__u32 async_fd;
+	__u32 cq_fd[1];
+};
+
+struct ib_uverbs_query_port {
+	__u64 response;
+	__u8  port_num;
+	__u8  reserved[7];
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_query_port_resp {
+	__u32 port_cap_flags;
+	__u32 max_msg_sz;
+	__u32 bad_pkey_cntr;
+	__u32 qkey_viol_cntr;
+	__u32 gid_tbl_len;
+	__u16 pkey_tbl_len;
+	__u16 lid;
+	__u16 sm_lid;
+	__u8  state;
+	__u8  max_mtu;
+	__u8  active_mtu;
+	__u8  lmc;
+	__u8  max_vl_num;
+	__u8  sm_sl;
+	__u8  subnet_timeout;
+	__u8  init_type_reply;
+	__u8  active_width;
+	__u8  active_speed;
+	__u8  phys_state;
+	__u8  reserved[3];
+};
+
+struct ib_uverbs_alloc_pd {
+	__u64 response;
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_alloc_pd_resp {
+	__u32 pd_handle;
+};
+
+struct ib_uverbs_dealloc_pd {
+	__u32 pd_handle;
+};
+
+struct ib_uverbs_reg_mr {
+	__u64 response;
+	__u64 start;
+	__u64 length;
+	__u64 hca_va;
+	__u32 pd_handle;
+	__u32 access_flags;
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_reg_mr_resp {
+	__u32 mr_handle;
+	__u32 lkey;
+	__u32 rkey;
+};
+
+struct ib_uverbs_dereg_mr {
+	__u32 mr_handle;
+};
+
+struct ib_uverbs_create_cq {
+	__u64 response;
+	__u64 user_handle;
+	__u32 cqe;
+	__u32 reserved;
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_create_cq_resp {
+	__u32 cq_handle;
+	__u32 cqe;
+};
+
+struct ib_uverbs_destroy_cq {
+	__u32 cq_handle;
+};
+
+struct ib_uverbs_create_qp {
+	__u64 response;
+	__u64 user_handle;
+	__u32 pd_handle;
+	__u32 send_cq_handle;
+	__u32 recv_cq_handle;
+	__u32 srq_handle;
+	__u32 max_send_wr;
+	__u32 max_recv_wr;
+	__u32 max_send_sge;
+	__u32 max_recv_sge;
+	__u32 max_inline_data;
+	__u8  sq_sig_all;
+	__u8  qp_type;
+	__u8  is_srq;
+	__u8  reserved;
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_create_qp_resp {
+	__u32 qp_handle;
+	__u32 qpn;
+};
+
+/*
+ * This struct needs to remain a multiple of 8 bytes to keep the
+ * alignment of the modify QP parameters.
+ */
+struct ib_uverbs_qp_dest {
+	__u8  dgid[16];
+	__u32 flow_label;
+	__u16 dlid;
+	__u16 reserved;
+	__u8  sgid_index;
+	__u8  hop_limit;
+	__u8  traffic_class;
+	__u8  sl;
+	__u8  src_path_bits;
+	__u8  static_rate;
+	__u8  is_global;
+	__u8  port_num;
+};
+
+struct ib_uverbs_modify_qp {
+	struct ib_uverbs_qp_dest dest;
+	struct ib_uverbs_qp_dest alt_dest;
+	__u32 qp_handle;
+	__u32 attr_mask;
+	__u32 qkey;
+	__u32 rq_psn;
+	__u32 sq_psn;
+	__u32 dest_qp_num;
+	__u32 qp_access_flags;
+	__u16 pkey_index;
+	__u16 alt_pkey_index;
+	__u8  qp_state;
+	__u8  cur_qp_state;
+	__u8  path_mtu;
+	__u8  path_mig_state;
+	__u8  en_sqd_async_notify;
+	__u8  max_rd_atomic;
+	__u8  max_dest_rd_atomic;
+	__u8  min_rnr_timer;
+	__u8  port_num;
+	__u8  timeout;
+	__u8  retry_cnt;
+	__u8  rnr_retry;
+	__u8  alt_port_num;
+	__u8  alt_timeout;
+	__u8  reserved[2];
+	__u64 driver_data[0];
+};
+
+struct ib_uverbs_modify_qp_resp {
+};
+
+struct ib_uverbs_destroy_qp {
+	__u32 qp_handle;
+};
+
+#endif /* IB_USER_VERBS_H */

