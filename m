Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWANPJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWANPJj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWANPJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:09:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53905 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751766AbWANPJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:09:38 -0500
Date: Sat, 14 Jan 2006 16:09:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       rolandd@cisco.com
Subject: [patch 2.6.15-mm4] sem2mutex: infiniband, #2
Message-ID: <20060114150949.GA24284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/infiniband/core/ucm.c                |   32 ++++++++++++------------
 drivers/infiniband/core/user_mad.c           |    2 -
 drivers/infiniband/hw/mthca/mthca_cmd.c      |    6 ++--
 drivers/infiniband/hw/mthca/mthca_dev.h      |   10 ++++---
 drivers/infiniband/hw/mthca/mthca_mcg.c      |   10 +++----
 drivers/infiniband/hw/mthca/mthca_memfree.c  |   36 +++++++++++++--------------
 drivers/infiniband/hw/mthca/mthca_memfree.h  |    8 +++---
 drivers/infiniband/hw/mthca/mthca_provider.c |    6 ++--
 drivers/infiniband/ulp/srp/ib_srp.c          |   14 +++++-----
 drivers/infiniband/ulp/srp/ib_srp.h          |    5 +--
 10 files changed, 66 insertions(+), 63 deletions(-)

Index: linux/drivers/infiniband/core/ucm.c
===================================================================
--- linux.orig/drivers/infiniband/core/ucm.c
+++ linux/drivers/infiniband/core/ucm.c
@@ -61,7 +61,7 @@ struct ib_ucm_device {
 };
 
 struct ib_ucm_file {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct file *filp;
 	struct ib_ucm_device *device;
 
@@ -150,7 +150,7 @@ static void ib_ucm_cleanup_events(struct
 {
 	struct ib_ucm_event *uevent;
 
-	down(&ctx->file->mutex);
+	mutex_lock(&ctx->file->mutex);
 	list_del(&ctx->file_list);
 	while (!list_empty(&ctx->events)) {
 
@@ -165,7 +165,7 @@ static void ib_ucm_cleanup_events(struct
 
 		kfree(uevent);
 	}
-	up(&ctx->file->mutex);
+	mutex_unlock(&ctx->file->mutex);
 }
 
 static struct ib_ucm_context *ib_ucm_ctx_alloc(struct ib_ucm_file *file)
@@ -400,11 +400,11 @@ static int ib_ucm_event_handler(struct i
 	if (result)
 		goto err2;
 
-	down(&ctx->file->mutex);
+	mutex_lock(&ctx->file->mutex);
 	list_add_tail(&uevent->file_list, &ctx->file->events);
 	list_add_tail(&uevent->ctx_list, &ctx->events);
 	wake_up_interruptible(&ctx->file->poll_wait);
-	up(&ctx->file->mutex);
+	mutex_unlock(&ctx->file->mutex);
 	return 0;
 
 err2:
@@ -430,7 +430,7 @@ static ssize_t ib_ucm_event(struct ib_uc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	down(&file->mutex);
+	mutex_lock(&file->mutex);
 	while (list_empty(&file->events)) {
 
 		if (file->filp->f_flags & O_NONBLOCK) {
@@ -445,9 +445,9 @@ static ssize_t ib_ucm_event(struct ib_uc
 
 		prepare_to_wait(&file->poll_wait, &wait, TASK_INTERRUPTIBLE);
 
-		up(&file->mutex);
+		mutex_unlock(&file->mutex);
 		schedule();
-		down(&file->mutex);
+		mutex_lock(&file->mutex);
 
 		finish_wait(&file->poll_wait, &wait);
 	}
@@ -507,7 +507,7 @@ static ssize_t ib_ucm_event(struct ib_uc
 	kfree(uevent->info);
 	kfree(uevent);
 done:
-	up(&file->mutex);
+	mutex_unlock(&file->mutex);
 	return result;
 }
 
@@ -526,9 +526,9 @@ static ssize_t ib_ucm_create_id(struct i
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	down(&file->mutex);
+	mutex_lock(&file->mutex);
 	ctx = ib_ucm_ctx_alloc(file);
-	up(&file->mutex);
+	mutex_unlock(&file->mutex);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -1261,7 +1261,7 @@ static int ib_ucm_open(struct inode *ino
 	INIT_LIST_HEAD(&file->ctxs);
 	init_waitqueue_head(&file->poll_wait);
 
-	init_MUTEX(&file->mutex);
+	mutex_init(&file->mutex);
 
 	filp->private_data = file;
 	file->filp = filp;
@@ -1275,11 +1275,11 @@ static int ib_ucm_close(struct inode *in
 	struct ib_ucm_file *file = filp->private_data;
 	struct ib_ucm_context *ctx;
 
-	down(&file->mutex);
+	mutex_lock(&file->mutex);
 	while (!list_empty(&file->ctxs)) {
 		ctx = list_entry(file->ctxs.next,
 				 struct ib_ucm_context, file_list);
-		up(&file->mutex);
+		mutex_unlock(&file->mutex);
 
 		mutex_lock(&ctx_id_mutex);
 		idr_remove(&ctx_id_table, ctx->id);
@@ -1289,9 +1289,9 @@ static int ib_ucm_close(struct inode *in
 		ib_ucm_cleanup_events(ctx);
 		kfree(ctx);
 
-		down(&file->mutex);
+		mutex_lock(&file->mutex);
 	}
-	up(&file->mutex);
+	mutex_unlock(&file->mutex);
 	kfree(file);
 	return 0;
 }
Index: linux/drivers/infiniband/core/user_mad.c
===================================================================
--- linux.orig/drivers/infiniband/core/user_mad.c
+++ linux/drivers/infiniband/core/user_mad.c
@@ -47,7 +47,7 @@
 #include <linux/kref.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_user_mad.h>
Index: linux/drivers/infiniband/hw/mthca/mthca_cmd.c
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ linux/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -199,7 +199,7 @@ static int mthca_cmd_post(struct mthca_d
 {
 	int err = 0;
 
-	if (down_interruptible(&dev->cmd.hcr_sem))
+	if (mutex_lock_interruptible(&dev->cmd.hcr_mutex))
 		return -EINTR;
 
 	if (event) {
@@ -238,7 +238,7 @@ static int mthca_cmd_post(struct mthca_d
 					       op),                       dev->hcr + 6 * 4);
 
 out:
-	up(&dev->cmd.hcr_sem);
+	mutex_unlock(&dev->cmd.hcr_mutex);
 	return err;
 }
 
@@ -438,7 +438,7 @@ static int mthca_cmd_imm(struct mthca_de
 
 int mthca_cmd_init(struct mthca_dev *dev)
 {
-	sema_init(&dev->cmd.hcr_sem, 1);
+	mutex_init(&dev->cmd.hcr_mutex);
 	sema_init(&dev->cmd.poll_sem, 1);
 	dev->cmd.use_events = 0;
 
Index: linux/drivers/infiniband/hw/mthca/mthca_dev.h
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -44,7 +44,9 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/timer.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
+#include <linux/mutex.h>
+
 
 #include "mthca_provider.h"
 #include "mthca_doorbell.h"
@@ -111,7 +113,7 @@ enum {
 struct mthca_cmd {
 	struct pci_pool          *pool;
 	int                       use_events;
-	struct semaphore          hcr_sem;
+	struct mutex              hcr_mutex;
 	struct semaphore 	  poll_sem;
 	struct semaphore 	  event_sem;
 	int              	  max_cmds;
@@ -256,7 +258,7 @@ struct mthca_av_table {
 };
 
 struct mthca_mcg_table {
-	struct semaphore   	sem;
+	struct mutex		mutex;
 	struct mthca_alloc 	alloc;
 	struct mthca_icm_table *table;
 };
@@ -301,7 +303,7 @@ struct mthca_dev {
 	u64              ddr_end;
 
 	MTHCA_DECLARE_DOORBELL_LOCK(doorbell_lock)
-	struct semaphore cap_mask_mutex;
+	struct mutex cap_mask_mutex;
 
 	void __iomem    *hcr;
 	void __iomem    *kar;
Index: linux/drivers/infiniband/hw/mthca/mthca_mcg.c
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ linux/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -154,7 +154,7 @@ int mthca_multicast_attach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem)) {
+	if (mutex_lock_interruptible(&dev->mcg_table.mutex)) {
 		err = -EINTR;
 		goto err_sem;
 	}
@@ -241,7 +241,7 @@ int mthca_multicast_attach(struct ib_qp 
 		BUG_ON(index < dev->limits.num_mgms);
 		mthca_free(&dev->mcg_table.alloc, index);
 	}
-	up(&dev->mcg_table.sem);
+	mutex_unlock(&dev->mcg_table.mutex);
  err_sem:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
@@ -263,7 +263,7 @@ int mthca_multicast_detach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem)) {
+	if (mutex_lock_interruptible(&dev->mcg_table.mutex)) {
 		err = -EINTR;
 		goto err_sem;
 	}
@@ -371,7 +371,7 @@ int mthca_multicast_detach(struct ib_qp 
 	}
 
  out:
-	up(&dev->mcg_table.sem);
+	mutex_unlock(&dev->mcg_table.mutex);
  err_sem:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
@@ -389,7 +389,7 @@ int __devinit mthca_init_mcg_table(struc
 	if (err)
 		return err;
 
-	init_MUTEX(&dev->mcg_table.sem);
+	mutex_init(&dev->mcg_table.mutex);
 
 	return 0;
 }
Index: linux/drivers/infiniband/hw/mthca/mthca_memfree.c
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -50,7 +50,7 @@ enum {
 };
 
 struct mthca_user_db_table {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct {
 		u64                uvirt;
 		struct scatterlist mem;
@@ -158,7 +158,7 @@ int mthca_table_get(struct mthca_dev *de
 	int ret = 0;
 	u8 status;
 
-	down(&table->mutex);
+	mutex_lock(&table->mutex);
 
 	if (table->icm[i]) {
 		++table->icm[i]->refcount;
@@ -184,7 +184,7 @@ int mthca_table_get(struct mthca_dev *de
 	++table->icm[i]->refcount;
 
 out:
-	up(&table->mutex);
+	mutex_unlock(&table->mutex);
 	return ret;
 }
 
@@ -198,7 +198,7 @@ void mthca_table_put(struct mthca_dev *d
 
 	i = (obj & (table->num_obj - 1)) * table->obj_size / MTHCA_TABLE_CHUNK_SIZE;
 
-	down(&table->mutex);
+	mutex_lock(&table->mutex);
 
 	if (--table->icm[i]->refcount == 0) {
 		mthca_UNMAP_ICM(dev, table->virt + i * MTHCA_TABLE_CHUNK_SIZE,
@@ -207,7 +207,7 @@ void mthca_table_put(struct mthca_dev *d
 		table->icm[i] = NULL;
 	}
 
-	up(&table->mutex);
+	mutex_unlock(&table->mutex);
 }
 
 void *mthca_table_find(struct mthca_icm_table *table, int obj)
@@ -220,7 +220,7 @@ void *mthca_table_find(struct mthca_icm_
 	if (!table->lowmem)
 		return NULL;
 
-	down(&table->mutex);
+	mutex_lock(&table->mutex);
 
 	idx = (obj & (table->num_obj - 1)) * table->obj_size;
 	icm = table->icm[idx / MTHCA_TABLE_CHUNK_SIZE];
@@ -240,7 +240,7 @@ void *mthca_table_find(struct mthca_icm_
 	}
 
 out:
-	up(&table->mutex);
+	mutex_unlock(&table->mutex);
 	return page ? lowmem_page_address(page) + offset : NULL;
 }
 
@@ -301,7 +301,7 @@ struct mthca_icm_table *mthca_alloc_icm_
 	table->num_obj  = nobj;
 	table->obj_size = obj_size;
 	table->lowmem   = use_lowmem;
-	init_MUTEX(&table->mutex);
+	mutex_init(&table->mutex);
 
 	for (i = 0; i < num_icm; ++i)
 		table->icm[i] = NULL;
@@ -380,7 +380,7 @@ int mthca_map_user_db(struct mthca_dev *
 	if (index < 0 || index > dev->uar_table.uarc_size / 8)
 		return -EINVAL;
 
-	down(&db_tab->mutex);
+	mutex_lock(&db_tab->mutex);
 
 	i = index / MTHCA_DB_REC_PER_PAGE;
 
@@ -424,7 +424,7 @@ int mthca_map_user_db(struct mthca_dev *
 	db_tab->page[i].refcount = 1;
 
 out:
-	up(&db_tab->mutex);
+	mutex_unlock(&db_tab->mutex);
 	return ret;
 }
 
@@ -439,11 +439,11 @@ void mthca_unmap_user_db(struct mthca_de
 	 * pages until we clean up the whole db table.
 	 */
 
-	down(&db_tab->mutex);
+	mutex_lock(&db_tab->mutex);
 
 	--db_tab->page[index / MTHCA_DB_REC_PER_PAGE].refcount;
 
-	up(&db_tab->mutex);
+	mutex_unlock(&db_tab->mutex);
 }
 
 struct mthca_user_db_table *mthca_init_user_db_tab(struct mthca_dev *dev)
@@ -460,7 +460,7 @@ struct mthca_user_db_table *mthca_init_u
 	if (!db_tab)
 		return ERR_PTR(-ENOMEM);
 
-	init_MUTEX(&db_tab->mutex);
+	mutex_init(&db_tab->mutex);
 	for (i = 0; i < npages; ++i) {
 		db_tab->page[i].refcount = 0;
 		db_tab->page[i].uvirt    = 0;
@@ -499,7 +499,7 @@ int mthca_alloc_db(struct mthca_dev *dev
 	int ret = 0;
 	u8 status;
 
-	down(&dev->db_tab->mutex);
+	mutex_lock(&dev->db_tab->mutex);
 
 	switch (type) {
 	case MTHCA_DB_TYPE_CQ_ARM:
@@ -585,7 +585,7 @@ found:
 	*db = (__be32 *) &page->db_rec[j];
 
 out:
-	up(&dev->db_tab->mutex);
+	mutex_unlock(&dev->db_tab->mutex);
 
 	return ret;
 }
@@ -601,7 +601,7 @@ void mthca_free_db(struct mthca_dev *dev
 
 	page = dev->db_tab->page + i;
 
-	down(&dev->db_tab->mutex);
+	mutex_lock(&dev->db_tab->mutex);
 
 	page->db_rec[j] = 0;
 	if (i >= dev->db_tab->min_group2)
@@ -624,7 +624,7 @@ void mthca_free_db(struct mthca_dev *dev
 			++dev->db_tab->min_group2;
 	}
 
-	up(&dev->db_tab->mutex);
+	mutex_unlock(&dev->db_tab->mutex);
 }
 
 int mthca_init_db_tab(struct mthca_dev *dev)
@@ -638,7 +638,7 @@ int mthca_init_db_tab(struct mthca_dev *
 	if (!dev->db_tab)
 		return -ENOMEM;
 
-	init_MUTEX(&dev->db_tab->mutex);
+	mutex_init(&dev->db_tab->mutex);
 
 	dev->db_tab->npages     = dev->uar_table.uarc_size / 4096;
 	dev->db_tab->max_group1 = 0;
Index: linux/drivers/infiniband/hw/mthca/mthca_memfree.h
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.h
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.h
@@ -40,7 +40,9 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
+#include <linux/mutex.h>
+
 
 #define MTHCA_ICM_CHUNK_LEN \
 	((256 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
@@ -64,7 +66,7 @@ struct mthca_icm_table {
 	int               num_obj;
 	int               obj_size;
 	int               lowmem;
-	struct semaphore  mutex;
+	struct mutex      mutex;
 	struct mthca_icm *icm[0];
 };
 
@@ -147,7 +149,7 @@ struct mthca_db_table {
 	int 	       	      max_group1;
 	int 	       	      min_group2;
 	struct mthca_db_page *page;
-	struct semaphore      mutex;
+	struct mutex          mutex;
 };
 
 enum mthca_db_type {
Index: linux/drivers/infiniband/hw/mthca/mthca_provider.c
===================================================================
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -185,7 +185,7 @@ static int mthca_modify_port(struct ib_d
 	int err;
 	u8 status;
 
-	if (down_interruptible(&to_mdev(ibdev)->cap_mask_mutex))
+	if (mutex_lock_interruptible(&to_mdev(ibdev)->cap_mask_mutex))
 		return -ERESTARTSYS;
 
 	err = mthca_query_port(ibdev, port, &attr);
@@ -207,7 +207,7 @@ static int mthca_modify_port(struct ib_d
 	}
 
 out:
-	up(&to_mdev(ibdev)->cap_mask_mutex);
+	mutex_unlock(&to_mdev(ibdev)->cap_mask_mutex);
 	return err;
 }
 
@@ -1185,7 +1185,7 @@ int mthca_register_device(struct mthca_d
 		dev->ib_dev.post_recv     = mthca_tavor_post_receive;
 	}
 
-	init_MUTEX(&dev->cap_mask_mutex);
+	mutex_init(&dev->cap_mask_mutex);
 
 	ret = ib_register_device(&dev->ib_dev);
 	if (ret)
Index: linux/drivers/infiniband/ulp/srp/ib_srp.c
===================================================================
--- linux.orig/drivers/infiniband/ulp/srp/ib_srp.c
+++ linux/drivers/infiniband/ulp/srp/ib_srp.c
@@ -357,9 +357,9 @@ static void srp_remove_work(void *target
 	target->state = SRP_TARGET_REMOVED;
 	spin_unlock_irq(target->scsi_host->host_lock);
 
-	down(&target->srp_host->target_mutex);
+	mutex_lock(&target->srp_host->target_mutex);
 	list_del(&target->list);
-	up(&target->srp_host->target_mutex);
+	mutex_unlock(&target->srp_host->target_mutex);
 
 	scsi_remove_host(target->scsi_host);
 	ib_destroy_cm_id(target->cm_id);
@@ -1254,9 +1254,9 @@ static int srp_add_target(struct srp_hos
 	if (scsi_add_host(target->scsi_host, host->dev->dma_device))
 		return -ENODEV;
 
-	down(&host->target_mutex);
+	mutex_lock(&host->target_mutex);
 	list_add_tail(&target->list, &host->target_list);
-	up(&host->target_mutex);
+	mutex_unlock(&host->target_mutex);
 
 	target->state = SRP_TARGET_LIVE;
 
@@ -1525,7 +1525,7 @@ static struct srp_host *srp_add_port(str
 		return NULL;
 
 	INIT_LIST_HEAD(&host->target_list);
-	init_MUTEX(&host->target_mutex);
+	mutex_init(&host->target_mutex);
 	init_completion(&host->released);
 	host->dev  = device;
 	host->port = port;
@@ -1626,7 +1626,7 @@ static void srp_remove_one(struct ib_dev
 		 * Mark all target ports as removed, so we stop queueing
 		 * commands and don't try to reconnect.
 		 */
-		down(&host->target_mutex);
+		mutex_lock(&host->target_mutex);
 		list_for_each_entry_safe(target, tmp_target,
 					 &host->target_list, list) {
 			spin_lock_irqsave(target->scsi_host->host_lock, flags);
@@ -1634,7 +1634,7 @@ static void srp_remove_one(struct ib_dev
 				target->state = SRP_TARGET_REMOVED;
 			spin_unlock_irqrestore(target->scsi_host->host_lock, flags);
 		}
-		up(&host->target_mutex);
+		mutex_unlock(&host->target_mutex);
 
 		/*
 		 * Wait for any reconnection tasks that may have
Index: linux/drivers/infiniband/ulp/srp/ib_srp.h
===================================================================
--- linux.orig/drivers/infiniband/ulp/srp/ib_srp.h
+++ linux/drivers/infiniband/ulp/srp/ib_srp.h
@@ -37,8 +37,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -85,7 +84,7 @@ struct srp_host {
 	struct ib_mr	       *mr;
 	struct class_device	class_dev;
 	struct list_head	target_list;
-	struct semaphore        target_mutex;
+	struct mutex            target_mutex;
 	struct completion	released;
 	struct list_head	list;
 };
