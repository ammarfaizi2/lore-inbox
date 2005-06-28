Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVF2CXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVF2CXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVF1Xlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:41:36 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:54439 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262222AbVF1XDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:52 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037095:sNHT30267132"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 01/16] IB uverbs: core API extensions
In-Reply-To: <2005628163.H103BaveG8tYGzYQ@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.dSvxYW7XXf2cvPdt@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the ib_verbs.h header file with changes required for InfiniBand
userspace verbs support.  We add a few structures to keep track of
userspace context, and extend the driver API so that low-level drivers
know when they're creating resources that will be used from userspace.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/include/ib_verbs.h |  124 +++++++++++++++++++++++++++++-----
 1 files changed, 106 insertions(+), 18 deletions(-)



--- linux.orig/drivers/infiniband/include/ib_verbs.h	2005-06-28 15:19:55.956779699 -0700
+++ linux/drivers/infiniband/include/ib_verbs.h	2005-06-28 15:19:57.390470064 -0700
@@ -4,6 +4,7 @@
  * Copyright (c) 2004 Intel Corporation.  All rights reserved.
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
  * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -41,7 +42,10 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+
 #include <asm/atomic.h>
+#include <asm/scatterlist.h>
+#include <asm/uaccess.h>
 
 union ib_gid {
 	u8	raw[16];
@@ -544,7 +548,7 @@ struct ib_send_wr {
 	int			num_sge;
 	enum ib_wr_opcode	opcode;
 	int			send_flags;
-	u32			imm_data;
+	__be32			imm_data;
 	union {
 		struct {
 			u64	remote_addr;
@@ -618,29 +622,86 @@ struct ib_fmr_attr {
 	u8	page_size;
 };
 
+struct ib_ucontext {
+	struct ib_device       *device;
+	struct list_head	pd_list;
+	struct list_head	mr_list;
+	struct list_head	mw_list;
+	struct list_head	cq_list;
+	struct list_head	qp_list;
+	struct list_head	srq_list;
+	struct list_head	ah_list;
+	spinlock_t              lock;
+};
+
+struct ib_uobject {
+	u64			user_handle;	/* handle given to us by userspace */
+	struct ib_ucontext     *context;	/* associated user context */
+	struct list_head	list;		/* link to context's list */
+	u32			id;		/* index into kernel idr */
+};
+
+struct ib_umem {
+	unsigned long		user_base;
+	unsigned long		virt_base;
+	size_t			length;
+	int			offset;
+	int			page_size;
+	int                     writable;
+	struct list_head	chunk_list;
+};
+
+struct ib_umem_chunk {
+	struct list_head	list;
+	int                     nents;
+	int                     nmap;
+	struct scatterlist      page_list[0];
+};
+
+struct ib_udata {
+	void __user *inbuf;
+	void __user *outbuf;
+	size_t       inlen;
+	size_t       outlen;
+};
+
+#define IB_UMEM_MAX_PAGE_CHUNK						\
+	((PAGE_SIZE - offsetof(struct ib_umem_chunk, page_list)) /	\
+	 ((void *) &((struct ib_umem_chunk *) 0)->page_list[1] -	\
+	  (void *) &((struct ib_umem_chunk *) 0)->page_list[0]))
+
+struct ib_umem_object {
+	struct ib_uobject	uobject;
+	struct ib_umem		umem;
+};
+
 struct ib_pd {
-	struct ib_device *device;
-	atomic_t          usecnt; /* count all resources */
+	struct ib_device       *device;
+	struct ib_uobject      *uobject;
+	atomic_t          	usecnt; /* count all resources */
 };
 
 struct ib_ah {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
+	struct ib_uobject	*uobject;
 };
 
 typedef void (*ib_comp_handler)(struct ib_cq *cq, void *cq_context);
 
 struct ib_cq {
-	struct ib_device *device;
-	ib_comp_handler   comp_handler;
-	void             (*event_handler)(struct ib_event *, void *);
-	void *            cq_context;
-	int               cqe;
-	atomic_t          usecnt; /* count number of work queues */
+	struct ib_device       *device;
+	struct ib_uobject      *uobject;
+	ib_comp_handler   	comp_handler;
+	void                  (*event_handler)(struct ib_event *, void *);
+	void *            	cq_context;
+	int               	cqe;
+	atomic_t          	usecnt; /* count number of work queues */
 };
 
 struct ib_srq {
 	struct ib_device	*device;
+	struct ib_uobject	*uobject;
 	struct ib_pd		*pd;
 	void			*srq_context;
 	atomic_t		usecnt;
@@ -652,6 +713,7 @@ struct ib_qp {
 	struct ib_cq	       *send_cq;
 	struct ib_cq	       *recv_cq;
 	struct ib_srq	       *srq;
+	struct ib_uobject      *uobject;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void		       *qp_context;
 	u32			qp_num;
@@ -659,16 +721,18 @@ struct ib_qp {
 };
 
 struct ib_mr {
-	struct ib_device *device;
-	struct ib_pd     *pd;
-	u32		  lkey;
-	u32		  rkey;
-	atomic_t          usecnt; /* count number of MWs */
+	struct ib_device  *device;
+	struct ib_pd	  *pd;
+	struct ib_uobject *uobject;
+	u32		   lkey;
+	u32		   rkey;
+	atomic_t	   usecnt; /* count number of MWs */
 };
 
 struct ib_mw {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
+	struct ib_uobject	*uobject;
 	u32			rkey;
 };
 
@@ -737,7 +801,14 @@ struct ib_device {
 	int		           (*modify_port)(struct ib_device *device,
 						  u8 port_num, int port_modify_mask,
 						  struct ib_port_modify *port_modify);
-	struct ib_pd *             (*alloc_pd)(struct ib_device *device);
+	struct ib_ucontext *       (*alloc_ucontext)(struct ib_device *device,
+						     struct ib_udata *udata);
+	int                        (*dealloc_ucontext)(struct ib_ucontext *context);
+	int                        (*mmap)(struct ib_ucontext *context,
+					   struct vm_area_struct *vma);
+	struct ib_pd *             (*alloc_pd)(struct ib_device *device,
+					       struct ib_ucontext *context,
+					       struct ib_udata *udata);
 	int                        (*dealloc_pd)(struct ib_pd *pd);
 	struct ib_ah *             (*create_ah)(struct ib_pd *pd,
 						struct ib_ah_attr *ah_attr);
@@ -747,7 +818,8 @@ struct ib_device {
 					       struct ib_ah_attr *ah_attr);
 	int                        (*destroy_ah)(struct ib_ah *ah);
 	struct ib_qp *             (*create_qp)(struct ib_pd *pd,
-						struct ib_qp_init_attr *qp_init_attr);
+						struct ib_qp_init_attr *qp_init_attr,
+						struct ib_udata *udata);
 	int                        (*modify_qp)(struct ib_qp *qp,
 						struct ib_qp_attr *qp_attr,
 						int qp_attr_mask);
@@ -762,8 +834,9 @@ struct ib_device {
 	int                        (*post_recv)(struct ib_qp *qp,
 						struct ib_recv_wr *recv_wr,
 						struct ib_recv_wr **bad_recv_wr);
-	struct ib_cq *             (*create_cq)(struct ib_device *device,
-						int cqe);
+	struct ib_cq *             (*create_cq)(struct ib_device *device, int cqe,
+						struct ib_ucontext *context,
+						struct ib_udata *udata);
 	int                        (*destroy_cq)(struct ib_cq *cq);
 	int                        (*resize_cq)(struct ib_cq *cq, int *cqe);
 	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
@@ -780,6 +853,10 @@ struct ib_device {
 						  int num_phys_buf,
 						  int mr_access_flags,
 						  u64 *iova_start);
+	struct ib_mr *             (*reg_user_mr)(struct ib_pd *pd,
+						  struct ib_umem *region,
+						  int mr_access_flags,
+						  struct ib_udata *udata);
 	int                        (*query_mr)(struct ib_mr *mr,
 					       struct ib_mr_attr *mr_attr);
 	int                        (*dereg_mr)(struct ib_mr *mr);
@@ -817,6 +894,7 @@ struct ib_device {
 						  struct ib_mad *in_mad,
 						  struct ib_mad *out_mad);
 
+	struct module               *owner;
 	struct class_device          class_dev;
 	struct kobject               ports_parent;
 	struct list_head             port_list;
@@ -852,6 +930,16 @@ void *ib_get_client_data(struct ib_devic
 void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 			 void *data);
 
+static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
+{
+	return copy_from_user(dest, udata->inbuf, len) ? -EFAULT : 0;
+}
+
+static inline int ib_copy_to_udata(struct ib_udata *udata, void *src, size_t len)
+{
+	return copy_to_user(udata->outbuf, src, len) ? -EFAULT : 0;
+}
+
 int ib_register_event_handler  (struct ib_event_handler *event_handler);
 int ib_unregister_event_handler(struct ib_event_handler *event_handler);
 void ib_dispatch_event(struct ib_event *event);
