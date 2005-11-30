Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVK3A7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVK3A7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVK3A6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:58:01 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750752AbVK3A5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:36 -0500
Subject: [git patch review 8/8] IB/uverbs: track multicast group membership
	for userspace QPs
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245799-86be2f2daf6d00d2@cisco.com>
In-Reply-To: <1133312245799-fb80cd19aa5b232b@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0987 (UTC) FILETIME=[08DA5030:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uverbs needs to track which multicast groups is each qp
attached to, in order to properly detach when cleanup
is performed on device file close.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs.h      |   11 ++++
 drivers/infiniband/core/uverbs_cmd.c  |   90 ++++++++++++++++++++++++++-------
 drivers/infiniband/core/uverbs_main.c |   21 ++++++--
 3 files changed, 99 insertions(+), 23 deletions(-)

applies-to: 9896d3c1093ded78c62da6b9a52b71e282c763e0
f4e401562c11c7ca65592ebd749353cf0b19af7b
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
---
0.99.9k
