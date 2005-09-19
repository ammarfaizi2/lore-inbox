Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVISWZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVISWZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVISWZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:25:27 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:39251 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932709AbVISWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:25:25 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] utterly bogus userland API in infinibad
X-Message-Flag: Warning: May contain useful information
References: <20050916181132.GF19626@ftp.linux.org.uk>
	<52fys4lsh9.fsf@cisco.com> <20050916203724.GH19626@ftp.linux.org.uk>
	<52psr8k1qg.fsf@cisco.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 19 Sep 2005 15:25:11 -0700
In-Reply-To: <52psr8k1qg.fsf@cisco.com> (Roland Dreier's message of "Fri, 16
 Sep 2005 16:54:31 -0700")
Message-ID: <52r7bkelvc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 19 Sep 2005 22:25:12.0800 (UTC) FILETIME=[00872600:01C5BD69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that (I think) fixes all the exploitable holes that Al
pointed out.  I know it does still leak files if ib_uverbs_open()
fails halfway through, but I think the best way to fix that will
require breaking the ABI.

I would propose including this patch in 2.6.14 to close the worst
holes and then making ABI-breaking changes for 2.6.15.  I've thought
it over, and I can see a better design that always FDs directly from
the system call that creates and installs them, and always returns FDs
one by one.  This makes cleaning up on failure of a system much
simpler, and handles the case of a context being used in a different
process than the original opener.

However, this would leave intact the current write()-based interface.
I'd love to implement a better interface, but I don't see anything
that's a clear improvement.

Al, any further thoughts?

Thanks,
  Roland

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -69,6 +69,7 @@ struct ib_uverbs_event_file {
 
 struct ib_uverbs_file {
 	struct kref				ref;
+	struct semaphore			mutex;
 	struct ib_uverbs_device		       *device;
 	struct ib_ucontext		       *ucontext;
 	struct ib_event_handler			event_handler;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -76,8 +76,9 @@ ssize_t ib_uverbs_get_context(struct ib_
 	struct ib_uverbs_get_context_resp resp;
 	struct ib_udata                   udata;
 	struct ib_device                 *ibdev = file->device->ib_dev;
+	struct ib_ucontext		 *ucontext;
 	int i;
-	int ret = in_len;
+	int ret;
 
 	if (out_len < sizeof resp)
 		return -ENOSPC;
@@ -85,45 +86,56 @@ ssize_t ib_uverbs_get_context(struct ib_
 	if (copy_from_user(&cmd, buf, sizeof cmd))
 		return -EFAULT;
 
+	down(&file->mutex);
+
+	if (file->ucontext) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	INIT_UDATA(&udata, buf + sizeof cmd,
 		   (unsigned long) cmd.response + sizeof resp,
 		   in_len - sizeof cmd, out_len - sizeof resp);
 
-	file->ucontext = ibdev->alloc_ucontext(ibdev, &udata);
-	if (IS_ERR(file->ucontext)) {
-		ret = PTR_ERR(file->ucontext);
-		file->ucontext = NULL;
-		return ret;
-	}
-
-	file->ucontext->device = ibdev;
-	INIT_LIST_HEAD(&file->ucontext->pd_list);
-	INIT_LIST_HEAD(&file->ucontext->mr_list);
-	INIT_LIST_HEAD(&file->ucontext->mw_list);
-	INIT_LIST_HEAD(&file->ucontext->cq_list);
-	INIT_LIST_HEAD(&file->ucontext->qp_list);
-	INIT_LIST_HEAD(&file->ucontext->srq_list);
-	INIT_LIST_HEAD(&file->ucontext->ah_list);
-	spin_lock_init(&file->ucontext->lock);
+	ucontext = ibdev->alloc_ucontext(ibdev, &udata);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(file->ucontext);
+
+	ucontext->device = ibdev;
+	INIT_LIST_HEAD(&ucontext->pd_list);
+	INIT_LIST_HEAD(&ucontext->mr_list);
+	INIT_LIST_HEAD(&ucontext->mw_list);
+	INIT_LIST_HEAD(&ucontext->cq_list);
+	INIT_LIST_HEAD(&ucontext->qp_list);
+	INIT_LIST_HEAD(&ucontext->srq_list);
+	INIT_LIST_HEAD(&ucontext->ah_list);
 
 	resp.async_fd = file->async_file.fd;
 	for (i = 0; i < file->device->num_comp; ++i)
 		if (copy_to_user((void __user *) (unsigned long) cmd.cq_fd_tab +
 				 i * sizeof (__u32),
-				 &file->comp_file[i].fd, sizeof (__u32)))
-			goto err;
+				 &file->comp_file[i].fd, sizeof (__u32))) {
+			ret = -EFAULT;
+			goto err_free;
+		}
 
 	if (copy_to_user((void __user *) (unsigned long) cmd.response,
-			 &resp, sizeof resp))
-		goto err;
+			 &resp, sizeof resp)) {
+		ret = -EFAULT;
+		goto err_free;
+	}
+
+	file->ucontext = ucontext;
+	up(&file->mutex);
 
 	return in_len;
 
-err:
-	ibdev->dealloc_ucontext(file->ucontext);
-	file->ucontext = NULL;
+err_free:
+	ibdev->dealloc_ucontext(ucontext);
 
-	return -EFAULT;
+err:
+	up(&file->mutex);
+	return ret;
 }
 
 ssize_t ib_uverbs_query_device(struct ib_uverbs_file *file,
@@ -352,9 +364,9 @@ retry:
 	if (ret)
 		goto err_pd;
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_add_tail(&uobj->list, &file->ucontext->pd_list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	memset(&resp, 0, sizeof resp);
 	resp.pd_handle = uobj->id;
@@ -368,9 +380,9 @@ retry:
 	return in_len;
 
 err_list:
- 	spin_lock_irq(&file->ucontext->lock);
+ 	down(&file->mutex);
 	list_del(&uobj->list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	down(&ib_uverbs_idr_mutex);
 	idr_remove(&ib_uverbs_pd_idr, uobj->id);
@@ -410,9 +422,9 @@ ssize_t ib_uverbs_dealloc_pd(struct ib_u
 
 	idr_remove(&ib_uverbs_pd_idr, cmd.pd_handle);
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	kfree(uobj);
 
@@ -512,9 +524,9 @@ retry:
 
 	resp.mr_handle = obj->uobject.id;
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_add_tail(&obj->uobject.list, &file->ucontext->mr_list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	if (copy_to_user((void __user *) (unsigned long) cmd.response,
 			 &resp, sizeof resp)) {
@@ -527,9 +539,9 @@ retry:
 	return in_len;
 
 err_list:
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&obj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 err_unreg:
 	ib_dereg_mr(mr);
@@ -570,9 +582,9 @@ ssize_t ib_uverbs_dereg_mr(struct ib_uve
 
 	idr_remove(&ib_uverbs_mr_idr, cmd.mr_handle);
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&memobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	ib_umem_release(file->device->ib_dev, &memobj->umem);
 	kfree(memobj);
@@ -647,9 +659,9 @@ retry:
 	if (ret)
 		goto err_cq;
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_add_tail(&uobj->uobject.list, &file->ucontext->cq_list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	memset(&resp, 0, sizeof resp);
 	resp.cq_handle = uobj->uobject.id;
@@ -664,9 +676,9 @@ retry:
 	return in_len;
 
 err_list:
- 	spin_lock_irq(&file->ucontext->lock);
+ 	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	down(&ib_uverbs_idr_mutex);
 	idr_remove(&ib_uverbs_cq_idr, uobj->uobject.id);
@@ -712,9 +724,9 @@ ssize_t ib_uverbs_destroy_cq(struct ib_u
 
 	idr_remove(&ib_uverbs_cq_idr, cmd.cq_handle);
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	spin_lock_irq(&file->comp_file[0].lock);
 	list_for_each_entry_safe(evt, tmp, &uobj->comp_list, obj_list) {
@@ -847,9 +859,9 @@ retry:
 
 	resp.qp_handle = uobj->uobject.id;
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_add_tail(&uobj->uobject.list, &file->ucontext->qp_list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	if (copy_to_user((void __user *) (unsigned long) cmd.response,
 			 &resp, sizeof resp)) {
@@ -862,9 +874,9 @@ retry:
 	return in_len;
 
 err_list:
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 err_destroy:
 	ib_destroy_qp(qp);
@@ -989,9 +1001,9 @@ ssize_t ib_uverbs_destroy_qp(struct ib_u
 
 	idr_remove(&ib_uverbs_qp_idr, cmd.qp_handle);
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	spin_lock_irq(&file->async_file.lock);
 	list_for_each_entry_safe(evt, tmp, &uobj->event_list, obj_list) {
@@ -1136,9 +1148,9 @@ retry:
 
 	resp.srq_handle = uobj->uobject.id;
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_add_tail(&uobj->uobject.list, &file->ucontext->srq_list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	if (copy_to_user((void __user *) (unsigned long) cmd.response,
 			 &resp, sizeof resp)) {
@@ -1151,9 +1163,9 @@ retry:
 	return in_len;
 
 err_list:
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 err_destroy:
 	ib_destroy_srq(srq);
@@ -1227,9 +1239,9 @@ ssize_t ib_uverbs_destroy_srq(struct ib_
 
 	idr_remove(&ib_uverbs_srq_idr, cmd.srq_handle);
 
-	spin_lock_irq(&file->ucontext->lock);
+	down(&file->mutex);
 	list_del(&uobj->uobject.list);
-	spin_unlock_irq(&file->ucontext->lock);
+	up(&file->mutex);
 
 	spin_lock_irq(&file->async_file.lock);
 	list_for_each_entry_safe(evt, tmp, &uobj->event_list, obj_list) {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -484,27 +484,29 @@ static int ib_uverbs_open(struct inode *
 	file = kmalloc(sizeof *file +
 		       (dev->num_comp - 1) * sizeof (struct ib_uverbs_event_file),
 		       GFP_KERNEL);
-	if (!file)
-		return -ENOMEM;
+	if (!file) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	file->device = dev;
 	kref_init(&file->ref);
+	init_MUTEX(&file->mutex);
 
 	file->ucontext = NULL;
 
+	kref_get(&file->ref);
 	ret = ib_uverbs_event_init(&file->async_file, file);
 	if (ret)
-		goto err;
+		goto err_kref;
 
 	file->async_file.is_async = 1;
 
-	kref_get(&file->ref);
-
 	for (i = 0; i < dev->num_comp; ++i) {
+		kref_get(&file->ref);
 		ret = ib_uverbs_event_init(&file->comp_file[i], file);
 		if (ret)
 			goto err_async;
-		kref_get(&file->ref);
 		file->comp_file[i].is_async = 0;
 	}
 
@@ -524,9 +526,16 @@ err_async:
 
 	ib_uverbs_event_release(&file->async_file);
 
-err:
+err_kref:
+	/*
+	 * One extra kref_put() because we took a reference before the
+	 * event file creation that failed and got us here.
+	 */
+	kref_put(&file->ref, ib_uverbs_release_file);
 	kref_put(&file->ref, ib_uverbs_release_file);
 
+err:
+	module_put(dev->ib_dev->owner);
 	return ret;
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -665,7 +665,6 @@ struct ib_ucontext {
 	struct list_head	qp_list;
 	struct list_head	srq_list;
 	struct list_head	ah_list;
-	spinlock_t              lock;
 };
 
 struct ib_uobject {
