Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVDDWio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDDWio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVDDWio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:38:44 -0400
Received: from webmail.topspin.com ([12.162.17.3]:9259 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261353AbVDDWeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:34:22 -0400
Subject: [PATCH][RFC][1/4] IB: core changes for userspace verbs
In-Reply-To: <200544159.Ahk9l0puXy39U6u6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 4 Apr 2005 15:09:00 -0700
Message-Id: <200544159.Qg0tUfQc4xGRabsc@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 04 Apr 2005 22:09:00.0460 (UTC) FILETIME=[E791D6C0:01C53962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new structs and struct members required by userspace verbs to IB core.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/core/verbs.c	2005-01-11 09:35:27.046388000 -0800
+++ linux-export/drivers/infiniband/core/verbs.c	2005-04-04 14:50:59.579791210 -0700
@@ -47,10 +47,11 @@
 {
 	struct ib_pd *pd;
 
-	pd = device->alloc_pd(device);
+	pd = device->alloc_pd(device, NULL, NULL, 0);
 
 	if (!IS_ERR(pd)) {
-		pd->device = device;
+		pd->device  = device;
+		pd->uobject = NULL;
 		atomic_set(&pd->usecnt, 0);
 	}
 
@@ -76,8 +77,9 @@
 	ah = pd->device->create_ah(pd, ah_attr);
 
 	if (!IS_ERR(ah)) {
-		ah->device = pd->device;
-		ah->pd     = pd;
+		ah->device  = pd->device;
+		ah->pd      = pd;
+		ah->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 	}
 
@@ -122,7 +124,7 @@
 {
 	struct ib_qp *qp;
 
-	qp = pd->device->create_qp(pd, qp_init_attr);
+	qp = pd->device->create_qp(pd, qp_init_attr, NULL, 0);
 
 	if (!IS_ERR(qp)) {
 		qp->device     	  = pd->device;
@@ -130,6 +132,7 @@
 		qp->send_cq    	  = qp_init_attr->send_cq;
 		qp->recv_cq    	  = qp_init_attr->recv_cq;
 		qp->srq	       	  = qp_init_attr->srq;
+		qp->uobject       = NULL;
 		qp->event_handler = qp_init_attr->event_handler;
 		qp->qp_context    = qp_init_attr->qp_context;
 		qp->qp_type	  = qp_init_attr->qp_type;
@@ -197,10 +200,11 @@
 {
 	struct ib_cq *cq;
 
-	cq = device->create_cq(device, cqe);
+	cq = device->create_cq(device, cqe, NULL, NULL, 0);
 
 	if (!IS_ERR(cq)) {
 		cq->device        = device;
+		cq->uobject       = NULL;
 		cq->comp_handler  = comp_handler;
 		cq->event_handler = event_handler;
 		cq->cq_context    = cq_context;
@@ -245,8 +249,9 @@
 	mr = pd->device->get_dma_mr(pd, mr_access_flags);
 
 	if (!IS_ERR(mr)) {
-		mr->device = pd->device;
-		mr->pd     = pd;
+		mr->device  = pd->device;
+		mr->pd      = pd;
+		mr->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 		atomic_set(&mr->usecnt, 0);
 	}
@@ -267,8 +272,9 @@
 				     mr_access_flags, iova_start);
 
 	if (!IS_ERR(mr)) {
-		mr->device = pd->device;
-		mr->pd     = pd;
+		mr->device  = pd->device;
+		mr->pd      = pd;
+		mr->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 		atomic_set(&mr->usecnt, 0);
 	}
@@ -344,8 +350,9 @@
 
 	mw = pd->device->alloc_mw(pd);
 	if (!IS_ERR(mw)) {
-		mw->device = pd->device;
-		mw->pd     = pd;
+		mw->device  = pd->device;
+		mw->pd      = pd;
+		mw->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 	}
 
--- linux-export.orig/drivers/infiniband/include/ib_verbs.h	2005-02-22 10:14:06.623746000 -0800
+++ linux-export/drivers/infiniband/include/ib_verbs.h	2005-04-04 14:50:42.054602327 -0700
@@ -41,7 +41,9 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+
 #include <asm/atomic.h>
+#include <asm/scatterlist.h>
 
 union ib_gid {
 	u8	raw[16];
@@ -618,29 +620,78 @@
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
+	struct ib_uobject      *uobject;
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
@@ -652,6 +703,7 @@
 	struct ib_cq	       *send_cq;
 	struct ib_cq	       *recv_cq;
 	struct ib_srq	       *srq;
+	struct ib_uobject      *uobject;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void		       *qp_context;
 	u32			qp_num;
@@ -659,16 +711,18 @@
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
 
@@ -737,7 +791,12 @@
 	int		           (*modify_port)(struct ib_device *device,
 						  u8 port_num, int port_modify_mask,
 						  struct ib_port_modify *port_modify);
-	struct ib_pd *             (*alloc_pd)(struct ib_device *device);
+	struct ib_ucontext *       (*alloc_ucontext)(struct ib_device *device,
+						     const void __user *udata, int udatalen);
+	int                        (*dealloc_ucontext)(struct ib_ucontext *context);
+	struct ib_pd *             (*alloc_pd)(struct ib_device *device,
+					       struct ib_ucontext *context,
+					       const void __user *udata, int udatalen);
 	int                        (*dealloc_pd)(struct ib_pd *pd);
 	struct ib_ah *             (*create_ah)(struct ib_pd *pd,
 						struct ib_ah_attr *ah_attr);
@@ -747,7 +806,8 @@
 					       struct ib_ah_attr *ah_attr);
 	int                        (*destroy_ah)(struct ib_ah *ah);
 	struct ib_qp *             (*create_qp)(struct ib_pd *pd,
-						struct ib_qp_init_attr *qp_init_attr);
+						struct ib_qp_init_attr *qp_init_attr,
+						const void __user *udata, int udatalen);
 	int                        (*modify_qp)(struct ib_qp *qp,
 						struct ib_qp_attr *qp_attr,
 						int qp_attr_mask);
@@ -762,8 +822,9 @@
 	int                        (*post_recv)(struct ib_qp *qp,
 						struct ib_recv_wr *recv_wr,
 						struct ib_recv_wr **bad_recv_wr);
-	struct ib_cq *             (*create_cq)(struct ib_device *device,
-						int cqe);
+	struct ib_cq *             (*create_cq)(struct ib_device *device, int cqe,
+						struct ib_ucontext *context,
+						const void __user *udata, int udatalen);
 	int                        (*destroy_cq)(struct ib_cq *cq);
 	int                        (*resize_cq)(struct ib_cq *cq, int *cqe);
 	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
@@ -780,6 +841,11 @@
 						  int num_phys_buf,
 						  int mr_access_flags,
 						  u64 *iova_start);
+	struct ib_mr *             (*reg_user_mr)(struct ib_pd *pd,
+						  struct ib_umem *region,
+						  int mr_access_flags,
+						  const void __user *udata,
+						  int udatalen);
 	int                        (*query_mr)(struct ib_mr *mr,
 					       struct ib_mr_attr *mr_attr);
 	int                        (*dereg_mr)(struct ib_mr *mr);
@@ -816,7 +882,10 @@
 						  struct ib_grh *in_grh,
 						  struct ib_mad *in_mad,
 						  struct ib_mad *out_mad);
+	int                        (*mmap)(struct ib_ucontext *context,
+					   struct vm_area_struct *vma);
 
+	struct module               *owner;
 	struct class_device          class_dev;
 	struct kobject               ports_parent;
 	struct list_head             port_list;

