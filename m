Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVK3R15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVK3R15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVK3R15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:27:57 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:49950 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751470AbVK3R14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:27:56 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB fixes for 2.6.15
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 09:27:41 -0800
Message-ID: <52acfmrqpe.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Nov 2005 17:27:42.0999 (UTC) FILETIME=[5EF5AA70:01C5F5D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Jack Morgenstein:
      IB/uverbs: track multicast group membership for userspace QPs

Michael S. Tsirkin:
      IB/mthca: reset QP's last pointers when transitioning to reset state
      IB/umad: fix RMPP handling
      IPoIB: reinitialize mcast structs' completions for every query
      IPoIB: protect child list in ipoib_ib_dev_flush
      IB/mthca: fix posting of send lists of length >= 255 on mem-free HCAs

Roland Dreier:
      IPoIB: reinitialize path struct's completion for every query
      IPoIB: always set path->query to NULL when query finishes
      IPoIB: don't zero members after we allocate with kzalloc
      IPoIB: fix error handling in ipoib_open

 drivers/infiniband/core/user_mad.c             |   41 ++++++-----
 drivers/infiniband/core/uverbs.h               |   11 +++
 drivers/infiniband/core/uverbs_cmd.c           |   90 +++++++++++++++++++-----
 drivers/infiniband/core/uverbs_main.c          |   21 +++++-
 drivers/infiniband/hw/mthca/mthca_qp.c         |   34 +++++++++
 drivers/infiniband/hw/mthca/mthca_wqe.h        |    3 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    4 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   11 ++-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   10 +--
 9 files changed, 170 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index e73f81c..eb7f525 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -310,7 +310,7 @@ static ssize_t ib_umad_write(struct file
 	u8 method;
 	__be64 *tid;
 	int ret, length, hdr_len, copy_offset;
-	int rmpp_active = 0;
+	int rmpp_active, has_rmpp_header;
 
 	if (count < sizeof (struct ib_user_mad) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
@@ -360,28 +360,31 @@ static ssize_t ib_umad_write(struct file
 	}
 
 	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	if (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE) {
-		/* RMPP active */
-		if (!agent->rmpp_version) {
-			ret = -EINVAL;
-			goto err_ah;
-		}
-
-		/* Validate that the management class can support RMPP */
-		if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
-			hdr_len = IB_MGMT_SA_HDR;
-		} else if ((rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
-			    (rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END)) {
-				hdr_len = IB_MGMT_VENDOR_HDR;
-		} else {
-			ret = -EINVAL;
-			goto err_ah;
-		}
-		rmpp_active = 1;
+	if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
+		hdr_len = IB_MGMT_SA_HDR;
 		copy_offset = IB_MGMT_RMPP_HDR;
+		has_rmpp_header = 1;
+	} else if (rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START &&
+		   rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END) {
+			hdr_len = IB_MGMT_VENDOR_HDR;
+			copy_offset = IB_MGMT_RMPP_HDR;
+			has_rmpp_header = 1;
 	} else {
 		hdr_len = IB_MGMT_MAD_HDR;
 		copy_offset = IB_MGMT_MAD_HDR;
+		has_rmpp_header = 0;
+	}
+
+	if (has_rmpp_header)
+		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+			      IB_MGMT_RMPP_FLAG_ACTIVE;
+	else
+		rmpp_active = 0;
+
+	/* Validate that the management class can support RMPP */
+	if (rmpp_active && !agent->rmpp_version) {
+		ret = -EINVAL;
+		goto err_ah;
 	}
 
 	packet->msg = ib_create_send_mad(agent,
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index ecb8301..7114e3f 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -105,12 +105,23 @@ struct ib_uverbs_event {
 	u32				       *counter;
 };
 
+struct ib_uverbs_mcast_entry {
+	struct list_head	list;
+	union ib_gid 		gid;
+	u16 			lid;
+};
+
 struct ib_uevent_object {
 	struct ib_uobject	uobject;
 	struct list_head	event_list;
 	u32			events_reported;
 };
 
+struct ib_uqp_object {
+	struct ib_uevent_object	uevent;
+	struct list_head 	mcast_list;
+};
+
 struct ib_ucq_object {
 	struct ib_uobject	uobject;
 	struct ib_uverbs_file  *uverbs_file;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index ed45da8..a57d021 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -815,7 +815,7 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 	struct ib_uverbs_create_qp      cmd;
 	struct ib_uverbs_create_qp_resp resp;
 	struct ib_udata                 udata;
-	struct ib_uevent_object        *uobj;
+	struct ib_uqp_object           *uobj;
 	struct ib_pd                   *pd;
 	struct ib_cq                   *scq, *rcq;
 	struct ib_srq                  *srq;
@@ -866,10 +866,11 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 	attr.cap.max_recv_sge    = cmd.max_recv_sge;
 	attr.cap.max_inline_data = cmd.max_inline_data;
 
-	uobj->uobject.user_handle = cmd.user_handle;
-	uobj->uobject.context     = file->ucontext;
-	uobj->events_reported     = 0;
-	INIT_LIST_HEAD(&uobj->event_list);
+	uobj->uevent.uobject.user_handle = cmd.user_handle;
+	uobj->uevent.uobject.context     = file->ucontext;
+	uobj->uevent.events_reported     = 0;
+	INIT_LIST_HEAD(&uobj->uevent.event_list);
+	INIT_LIST_HEAD(&uobj->mcast_list);
 
 	qp = pd->device->create_qp(pd, &attr, &udata);
 	if (IS_ERR(qp)) {
@@ -882,7 +883,7 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 	qp->send_cq    	  = attr.send_cq;
 	qp->recv_cq    	  = attr.recv_cq;
 	qp->srq	       	  = attr.srq;
-	qp->uobject       = &uobj->uobject;
+	qp->uobject       = &uobj->uevent.uobject;
 	qp->event_handler = attr.event_handler;
 	qp->qp_context    = attr.qp_context;
 	qp->qp_type	  = attr.qp_type;
@@ -901,14 +902,14 @@ retry:
 		goto err_destroy;
 	}
 
-	ret = idr_get_new(&ib_uverbs_qp_idr, qp, &uobj->uobject.id);
+	ret = idr_get_new(&ib_uverbs_qp_idr, qp, &uobj->uevent.uobject.id);
 
 	if (ret == -EAGAIN)
 		goto retry;
 	if (ret)
 		goto err_destroy;
 
-	resp.qp_handle       = uobj->uobject.id;
+	resp.qp_handle       = uobj->uevent.uobject.id;
 	resp.max_recv_sge    = attr.cap.max_recv_sge;
 	resp.max_send_sge    = attr.cap.max_send_sge;
 	resp.max_recv_wr     = attr.cap.max_recv_wr;
@@ -922,7 +923,7 @@ retry:
 	}
 
 	down(&file->mutex);
-	list_add_tail(&uobj->uobject.list, &file->ucontext->qp_list);
+	list_add_tail(&uobj->uevent.uobject.list, &file->ucontext->qp_list);
 	up(&file->mutex);
 
 	up(&ib_uverbs_idr_mutex);
@@ -930,7 +931,7 @@ retry:
 	return in_len;
 
 err_idr:
-	idr_remove(&ib_uverbs_qp_idr, uobj->uobject.id);
+	idr_remove(&ib_uverbs_qp_idr, uobj->uevent.uobject.id);
 
 err_destroy:
 	ib_destroy_qp(qp);
@@ -1032,7 +1033,7 @@ ssize_t ib_uverbs_destroy_qp(struct ib_u
 	struct ib_uverbs_destroy_qp      cmd;
 	struct ib_uverbs_destroy_qp_resp resp;
 	struct ib_qp               	*qp;
-	struct ib_uevent_object        	*uobj;
+	struct ib_uqp_object        	*uobj;
 	int                        	 ret = -EINVAL;
 
 	if (copy_from_user(&cmd, buf, sizeof cmd))
@@ -1046,7 +1047,12 @@ ssize_t ib_uverbs_destroy_qp(struct ib_u
 	if (!qp || qp->uobject->context != file->ucontext)
 		goto out;
 
-	uobj = container_of(qp->uobject, struct ib_uevent_object, uobject);
+	uobj = container_of(qp->uobject, struct ib_uqp_object, uevent.uobject);
+
+	if (!list_empty(&uobj->mcast_list)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	ret = ib_destroy_qp(qp);
 	if (ret)
@@ -1055,12 +1061,12 @@ ssize_t ib_uverbs_destroy_qp(struct ib_u
 	idr_remove(&ib_uverbs_qp_idr, cmd.qp_handle);
 
 	down(&file->mutex);
-	list_del(&uobj->uobject.list);
+	list_del(&uobj->uevent.uobject.list);
 	up(&file->mutex);
 
-	ib_uverbs_release_uevent(file, uobj);
+	ib_uverbs_release_uevent(file, &uobj->uevent);
 
-	resp.events_reported = uobj->events_reported;
+	resp.events_reported = uobj->uevent.events_reported;
 
 	kfree(uobj);
 
@@ -1542,6 +1548,8 @@ ssize_t ib_uverbs_attach_mcast(struct ib
 {
 	struct ib_uverbs_attach_mcast cmd;
 	struct ib_qp                 *qp;
+	struct ib_uqp_object         *uobj;
+	struct ib_uverbs_mcast_entry *mcast;
 	int                           ret = -EINVAL;
 
 	if (copy_from_user(&cmd, buf, sizeof cmd))
@@ -1550,9 +1558,36 @@ ssize_t ib_uverbs_attach_mcast(struct ib
 	down(&ib_uverbs_idr_mutex);
 
 	qp = idr_find(&ib_uverbs_qp_idr, cmd.qp_handle);
-	if (qp && qp->uobject->context == file->ucontext)
-		ret = ib_attach_mcast(qp, (union ib_gid *) cmd.gid, cmd.mlid);
+	if (!qp || qp->uobject->context != file->ucontext)
+		goto out;
+
+	uobj = container_of(qp->uobject, struct ib_uqp_object, uevent.uobject);
+
+	list_for_each_entry(mcast, &uobj->mcast_list, list)
+		if (cmd.mlid == mcast->lid &&
+		    !memcmp(cmd.gid, mcast->gid.raw, sizeof mcast->gid.raw)) {
+			ret = 0;
+			goto out;
+		}
 
+	mcast = kmalloc(sizeof *mcast, GFP_KERNEL);
+	if (!mcast) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mcast->lid = cmd.mlid;
+	memcpy(mcast->gid.raw, cmd.gid, sizeof mcast->gid.raw);
+
+	ret = ib_attach_mcast(qp, &mcast->gid, cmd.mlid);
+	if (!ret) {
+		uobj = container_of(qp->uobject, struct ib_uqp_object,
+				    uevent.uobject);
+		list_add_tail(&mcast->list, &uobj->mcast_list);
+	} else
+		kfree(mcast);
+
+out:
 	up(&ib_uverbs_idr_mutex);
 
 	return ret ? ret : in_len;
@@ -1563,7 +1598,9 @@ ssize_t ib_uverbs_detach_mcast(struct ib
 			       int out_len)
 {
 	struct ib_uverbs_detach_mcast cmd;
+	struct ib_uqp_object         *uobj;
 	struct ib_qp                 *qp;
+	struct ib_uverbs_mcast_entry *mcast;
 	int                           ret = -EINVAL;
 
 	if (copy_from_user(&cmd, buf, sizeof cmd))
@@ -1572,9 +1609,24 @@ ssize_t ib_uverbs_detach_mcast(struct ib
 	down(&ib_uverbs_idr_mutex);
 
 	qp = idr_find(&ib_uverbs_qp_idr, cmd.qp_handle);
-	if (qp && qp->uobject->context == file->ucontext)
-		ret = ib_detach_mcast(qp, (union ib_gid *) cmd.gid, cmd.mlid);
+	if (!qp || qp->uobject->context != file->ucontext)
+		goto out;
+
+	ret = ib_detach_mcast(qp, (union ib_gid *) cmd.gid, cmd.mlid);
+	if (ret)
+		goto out;
 
+	uobj = container_of(qp->uobject, struct ib_uqp_object, uevent.uobject);
+
+	list_for_each_entry(mcast, &uobj->mcast_list, list)
+		if (cmd.mlid == mcast->lid &&
+		    !memcmp(cmd.gid, mcast->gid.raw, sizeof mcast->gid.raw)) {
+			list_del(&mcast->list);
+			kfree(mcast);
+			break;
+		}
+
+out:
 	up(&ib_uverbs_idr_mutex);
 
 	return ret ? ret : in_len;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index de6581d..81737bd 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -160,6 +160,18 @@ void ib_uverbs_release_uevent(struct ib_
 	spin_unlock_irq(&file->async_file->lock);
 }
 
+static void ib_uverbs_detach_umcast(struct ib_qp *qp,
+				    struct ib_uqp_object *uobj)
+{
+	struct ib_uverbs_mcast_entry *mcast, *tmp;
+
+	list_for_each_entry_safe(mcast, tmp, &uobj->mcast_list, list) {
+		ib_detach_mcast(qp, &mcast->gid, mcast->lid);
+		list_del(&mcast->list);
+		kfree(mcast);
+	}
+}
+
 static int ib_uverbs_cleanup_ucontext(struct ib_uverbs_file *file,
 				      struct ib_ucontext *context)
 {
@@ -180,13 +192,14 @@ static int ib_uverbs_cleanup_ucontext(st
 
 	list_for_each_entry_safe(uobj, tmp, &context->qp_list, list) {
 		struct ib_qp *qp = idr_find(&ib_uverbs_qp_idr, uobj->id);
-		struct ib_uevent_object *uevent =
-			container_of(uobj, struct ib_uevent_object, uobject);
+		struct ib_uqp_object *uqp =
+			container_of(uobj, struct ib_uqp_object, uevent.uobject);
 		idr_remove(&ib_uverbs_qp_idr, uobj->id);
+		ib_uverbs_detach_umcast(qp, uqp);
 		ib_destroy_qp(qp);
 		list_del(&uobj->list);
-		ib_uverbs_release_uevent(file, uevent);
-		kfree(uevent);
+		ib_uverbs_release_uevent(file, &uqp->uevent);
+		kfree(uqp);
 	}
 
 	list_for_each_entry_safe(uobj, tmp, &context->cq_list, list) {
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index dd4e133..7450550 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -871,7 +871,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
 		mthca_wq_init(&qp->sq);
+		qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
+
 		mthca_wq_init(&qp->rq);
+		qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
 
 		if (mthca_is_memfree(dev)) {
 			*qp->sq.db = 0;
@@ -1819,6 +1822,7 @@ int mthca_arbel_post_send(struct ib_qp *
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
+	__be32 doorbell[2];
 	void *wqe;
 	void *prev_wqe;
 	unsigned long flags;
@@ -1838,6 +1842,34 @@ int mthca_arbel_post_send(struct ib_qp *
 	ind = qp->sq.head & (qp->sq.max - 1);
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(nreq == MTHCA_ARBEL_MAX_WQES_PER_SEND_DB)) {
+			nreq = 0;
+
+			doorbell[0] = cpu_to_be32((MTHCA_ARBEL_MAX_WQES_PER_SEND_DB << 24) |
+						  ((qp->sq.head & 0xffff) << 8) |
+						  f0 | op0);
+			doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
+
+			qp->sq.head += MTHCA_ARBEL_MAX_WQES_PER_SEND_DB;
+			size0 = 0;
+
+			/*
+			 * Make sure that descriptors are written before
+			 * doorbell record.
+			 */
+			wmb();
+			*qp->sq.db = cpu_to_be32(qp->sq.head & 0xffff);
+
+			/*
+			 * Make sure doorbell record is written before we
+			 * write MMIO send doorbell.
+			 */
+			wmb();
+			mthca_write64(doorbell,
+				      dev->kar + MTHCA_SEND_DOORBELL,
+				      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		}
+
 		if (mthca_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)) {
 			mthca_err(dev, "SQ %06x full (%u head, %u tail,"
 					" %d max, %d nreq)\n", qp->qpn,
@@ -2014,8 +2046,6 @@ int mthca_arbel_post_send(struct ib_qp *
 
 out:
 	if (likely(nreq)) {
-		__be32 doorbell[2];
-
 		doorbell[0] = cpu_to_be32((nreq << 24)                  |
 					  ((qp->sq.head & 0xffff) << 8) |
 					  f0 | op0);
diff --git a/drivers/infiniband/hw/mthca/mthca_wqe.h b/drivers/infiniband/hw/mthca/mthca_wqe.h
index 73f1c0b..e7d2c1e 100644
--- a/drivers/infiniband/hw/mthca/mthca_wqe.h
+++ b/drivers/infiniband/hw/mthca/mthca_wqe.h
@@ -50,7 +50,8 @@ enum {
 
 enum {
 	MTHCA_INVAL_LKEY			= 0x100,
-	MTHCA_TAVOR_MAX_WQES_PER_RECV_DB	= 256
+	MTHCA_TAVOR_MAX_WQES_PER_RECV_DB	= 256,
+	MTHCA_ARBEL_MAX_WQES_PER_SEND_DB	= 255
 };
 
 struct mthca_next_seg {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 54ef2fe..2388580 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -608,9 +608,13 @@ void ipoib_ib_dev_flush(void *_dev)
 	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
 		ipoib_ib_dev_up(dev);
 
+	down(&priv->vlan_mutex);
+
 	/* Flush any child interfaces too */
 	list_for_each_entry(cpriv, &priv->child_intfs, list)
 		ipoib_ib_dev_flush(&cpriv->dev);
+
+	up(&priv->vlan_mutex);
 }
 
 void ipoib_ib_dev_cleanup(struct net_device *dev)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 2fa3075..475d98f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -94,8 +94,10 @@ int ipoib_open(struct net_device *dev)
 	if (ipoib_ib_dev_open(dev))
 		return -EINVAL;
 
-	if (ipoib_ib_dev_up(dev))
+	if (ipoib_ib_dev_up(dev)) {
+		ipoib_ib_dev_stop(dev);
 		return -EINVAL;
+	}
 
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
 		struct ipoib_dev_priv *cpriv;
@@ -398,9 +400,9 @@ static void path_rec_completion(int stat
 			while ((skb = __skb_dequeue(&neigh->queue)))
 				__skb_queue_tail(&skqueue, skb);
 		}
-	} else
-		path->query = NULL;
+	}
 
+	path->query = NULL;
 	complete(&path->done);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -428,7 +430,6 @@ static struct ipoib_path *path_rec_creat
 	skb_queue_head_init(&path->queue);
 
 	INIT_LIST_HEAD(&path->neigh_list);
-	init_completion(&path->done);
 
 	memcpy(path->pathrec.dgid.raw, gid->raw, sizeof (union ib_gid));
 	path->pathrec.sgid      = priv->local_gid;
@@ -446,6 +447,8 @@ static int path_rec_start(struct net_dev
 	ipoib_dbg(priv, "Start path record lookup for " IPOIB_GID_FMT "\n",
 		  IPOIB_GID_ARG(path->pathrec.dgid));
 
+	init_completion(&path->done);
+
 	path->query_id =
 		ib_sa_path_rec_get(priv->ca, priv->port,
 				   &path->pathrec,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index c33ed87..ef3ee03 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -135,20 +135,14 @@ static struct ipoib_mcast *ipoib_mcast_a
 	if (!mcast)
 		return NULL;
 
-	init_completion(&mcast->done);
-
 	mcast->dev = dev;
 	mcast->created = jiffies;
 	mcast->backoff = 1;
-	mcast->logcount = 0;
 
 	INIT_LIST_HEAD(&mcast->list);
 	INIT_LIST_HEAD(&mcast->neigh_list);
 	skb_queue_head_init(&mcast->pkt_queue);
 
-	mcast->ah    = NULL;
-	mcast->query = NULL;
-
 	return mcast;
 }
 
@@ -350,6 +344,8 @@ static int ipoib_mcast_sendonly_join(str
 	rec.port_gid = priv->local_gid;
 	rec.pkey     = cpu_to_be16(priv->pkey);
 
+	init_completion(&mcast->done);
+
 	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec,
 				     IB_SA_MCMEMBER_REC_MGID		|
 				     IB_SA_MCMEMBER_REC_PORT_GID	|
@@ -469,6 +465,8 @@ static void ipoib_mcast_join(struct net_
 		rec.traffic_class = priv->broadcast->mcmember.traffic_class;
 	}
 
+	init_completion(&mcast->done);
+
 	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec, comp_mask,
 				     mcast->backoff * 1000, GFP_ATOMIC,
 				     ipoib_mcast_join_complete,
