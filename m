Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVI1EBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVI1EBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 00:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVI1EBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 00:01:55 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:20125 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751178AbVI1EBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 00:01:54 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand fixes for 2.6.14
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 27 Sep 2005 21:01:45 -0700
Message-ID: <524q85on6e.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Sep 2005 04:01:47.0085 (UTC) FILETIME=[58907FD0:01C5C3E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This will pull the following changes (full patch below):

Jack Morgenstein:
  [IB] mthca: fix hw_ver value returned from mthca_query_device

Michael S. Tsirkin:
  [IB] mthca: fix off by one in clr_int calculation
  [IB] mthca: Fix off by one bug in mthca_map_cmd
  [IB] mthca: Round up number of slots in HCA context memory table

Roland Dreier:
  [IB] mthca: Fix doorbell record resource leak
  [IB] uverbs: Close some exploitable races

 drivers/infiniband/core/uverbs.h             |    1 
 drivers/infiniband/core/uverbs_cmd.c         |  122 ++++++++++++++------------
 drivers/infiniband/core/uverbs_main.c        |   27 ++++--
 drivers/infiniband/hw/mthca/mthca_cmd.c      |    4 -
 drivers/infiniband/hw/mthca/mthca_eq.c       |    2 
 drivers/infiniband/hw/mthca/mthca_memfree.c  |   19 +++-
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 
 include/rdma/ib_verbs.h                      |    1 
 8 files changed, 105 insertions(+), 73 deletions(-)


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
@@ -448,7 +448,9 @@ static ssize_t ib_uverbs_write(struct fi
 	if (hdr.in_words * 4 != count)
 		return -EINVAL;
 
-	if (hdr.command < 0 || hdr.command >= ARRAY_SIZE(uverbs_cmd_table))
+	if (hdr.command < 0				||
+	    hdr.command >= ARRAY_SIZE(uverbs_cmd_table) ||
+	    !uverbs_cmd_table[hdr.command])
 		return -EINVAL;
 
 	if (!file->ucontext                               &&
@@ -484,27 +486,29 @@ static int ib_uverbs_open(struct inode *
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
 
@@ -524,9 +528,16 @@ err_async:
 
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
 
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -605,7 +605,7 @@ static int mthca_map_cmd(struct mthca_de
 			err = -EINVAL;
 			goto out;
 		}
-		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i, ++nent) {
+		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i) {
 			if (virt != -1) {
 				pages[nent * 2] = cpu_to_be64(virt);
 				virt += 1 << lg;
@@ -616,7 +616,7 @@ static int mthca_map_cmd(struct mthca_de
 			ts += 1 << (lg - 10);
 			++tc;
 
-			if (nent == MTHCA_MAILBOX_SIZE / 16) {
+			if (++nent == MTHCA_MAILBOX_SIZE / 16) {
 				err = mthca_cmd(dev, mailbox->dma, nent, 0, op,
 						CMD_TIME_CLASS_B, status);
 				if (err || *status)
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -836,7 +836,7 @@ int __devinit mthca_init_eq_table(struct
 		dev->eq_table.clr_mask =
 			swab32(1 << (dev->eq_table.inta_pin & 31));
 		dev->eq_table.clr_int  = dev->clr_base +
-			(dev->eq_table.inta_pin < 31 ? 4 : 0);
+			(dev->eq_table.inta_pin < 32 ? 4 : 0);
 	}
 
 	dev->eq_table.arm_mask = 0;
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -290,7 +290,7 @@ struct mthca_icm_table *mthca_alloc_icm_
 	int i;
 	u8 status;
 
-	num_icm = obj_size * nobj / MTHCA_TABLE_CHUNK_SIZE;
+	num_icm = (obj_size * nobj + MTHCA_TABLE_CHUNK_SIZE - 1) / MTHCA_TABLE_CHUNK_SIZE;
 
 	table = kmalloc(sizeof *table + num_icm * sizeof *table->icm, GFP_KERNEL);
 	if (!table)
@@ -529,12 +529,25 @@ int mthca_alloc_db(struct mthca_dev *dev
 			goto found;
 		}
 
+	for (i = start; i != end; i += dir)
+		if (!dev->db_tab->page[i].db_rec) {
+			page = dev->db_tab->page + i;
+			goto alloc;
+		}
+
 	if (dev->db_tab->max_group1 >= dev->db_tab->min_group2 - 1) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	if (group == 0)
+		++dev->db_tab->max_group1;
+	else
+		--dev->db_tab->min_group2;
+
 	page = dev->db_tab->page + end;
+
+alloc:
 	page->db_rec = dma_alloc_coherent(&dev->pdev->dev, 4096,
 					  &page->mapping, GFP_KERNEL);
 	if (!page->db_rec) {
@@ -554,10 +567,6 @@ int mthca_alloc_db(struct mthca_dev *dev
 	}
 
 	bitmap_zero(page->used, MTHCA_DB_REC_PER_PAGE);
-	if (group == 0)
-		++dev->db_tab->max_group1;
-	else
-		--dev->db_tab->min_group2;
 
 found:
 	j = find_first_zero_bit(page->used, MTHCA_DB_REC_PER_PAGE);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -84,7 +84,7 @@ static int mthca_query_device(struct ib_
 	props->vendor_id           = be32_to_cpup((__be32 *) (out_mad->data + 36)) &
 		0xffffff;
 	props->vendor_part_id      = be16_to_cpup((__be16 *) (out_mad->data + 30));
-	props->hw_ver              = be16_to_cpup((__be16 *) (out_mad->data + 32));
+	props->hw_ver              = be32_to_cpup((__be32 *) (out_mad->data + 32));
 	memcpy(&props->sys_image_guid, out_mad->data +  4, 8);
 	memcpy(&props->node_guid,      out_mad->data + 12, 8);
 
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
