Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWAaAp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWAaAp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWAaApl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:45:41 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:27024 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965050AbWAaApj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:45:39 -0500
X-IronPort-AV: i="4.01,236,1136188800"; 
   d="scan'208"; a="252465877:sNHT33546048"
Subject: [git patch review 4/4] IB/mthca: Semaphore to mutex conversions
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 31 Jan 2006 00:45:32 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1138668332064-e487a8354298962c@cisco.com>
In-Reply-To: <1138668332064-ea39a6f0ffa0f630@cisco.com>
X-OriginalArrivalTime: 31 Jan 2006 00:45:36.0240 (UTC) FILETIME=[A63AD700:01C625FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert semaphores to mutexes in mthca.  Leave firmware command
interface poll_sem and event_sem as semaphores.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c      |    6 ++--
 drivers/infiniband/hw/mthca/mthca_dev.h      |    8 ++++--
 drivers/infiniband/hw/mthca/mthca_mcg.c      |   10 ++++---
 drivers/infiniband/hw/mthca/mthca_memfree.c  |   36 +++++++++++++-------------
 drivers/infiniband/hw/mthca/mthca_memfree.h  |    7 ++---
 drivers/infiniband/hw/mthca/mthca_provider.c |    6 ++--
 6 files changed, 37 insertions(+), 36 deletions(-)

fd9cfdd11be3b37b5c919b64b43990f14a1587bd
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 69128fe..f9b9b93 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -199,7 +199,7 @@ static int mthca_cmd_post(struct mthca_d
 {
 	int err = 0;
 
-	down(&dev->cmd.hcr_sem);
+	mutex_lock(&dev->cmd.hcr_mutex);
 
 	if (event) {
 		unsigned long end = jiffies + GO_BIT_TIMEOUT;
@@ -237,7 +237,7 @@ static int mthca_cmd_post(struct mthca_d
 					       op),                       dev->hcr + 6 * 4);
 
 out:
-	up(&dev->cmd.hcr_sem);
+	mutex_unlock(&dev->cmd.hcr_mutex);
 	return err;
 }
 
@@ -435,7 +435,7 @@ static int mthca_cmd_imm(struct mthca_de
 
 int mthca_cmd_init(struct mthca_dev *dev)
 {
-	sema_init(&dev->cmd.hcr_sem, 1);
+	mutex_init(&dev->cmd.hcr_mutex);
 	sema_init(&dev->cmd.poll_sem, 1);
 	dev->cmd.use_events = 0;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index a104ab0..2a165fd 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -44,6 +44,8 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/timer.h>
+#include <linux/mutex.h>
+
 #include <asm/semaphore.h>
 
 #include "mthca_provider.h"
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
diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
index 55ff5e5..321f11e 100644
--- a/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -154,7 +154,7 @@ int mthca_multicast_attach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	down(&dev->mcg_table.sem);
+	mutex_lock(&dev->mcg_table.mutex);
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -238,7 +238,7 @@ int mthca_multicast_attach(struct ib_qp 
 		BUG_ON(index < dev->limits.num_mgms);
 		mthca_free(&dev->mcg_table.alloc, index);
 	}
-	up(&dev->mcg_table.sem);
+	mutex_unlock(&dev->mcg_table.mutex);
 
 	mthca_free_mailbox(dev, mailbox);
 	return err;
@@ -260,7 +260,7 @@ int mthca_multicast_detach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	down(&dev->mcg_table.sem);
+	mutex_lock(&dev->mcg_table.mutex);
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -365,7 +365,7 @@ int mthca_multicast_detach(struct ib_qp 
 	}
 
  out:
-	up(&dev->mcg_table.sem);
+	mutex_unlock(&dev->mcg_table.mutex);
 
 	mthca_free_mailbox(dev, mailbox);
 	return err;
@@ -383,7 +383,7 @@ int __devinit mthca_init_mcg_table(struc
 	if (err)
 		return err;
 
-	init_MUTEX(&dev->mcg_table.sem);
+	mutex_init(&dev->mcg_table.mutex);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index 9fb985a..d709cb1 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
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
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.h b/drivers/infiniband/hw/mthca/mthca_memfree.h
index 4fdca26..36f1141 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.h
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.h
@@ -39,8 +39,7 @@
 
 #include <linux/list.h>
 #include <linux/pci.h>
-
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #define MTHCA_ICM_CHUNK_LEN \
 	((256 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
@@ -64,7 +63,7 @@ struct mthca_icm_table {
 	int               num_obj;
 	int               obj_size;
 	int               lowmem;
-	struct semaphore  mutex;
+	struct mutex      mutex;
 	struct mthca_icm *icm[0];
 };
 
@@ -147,7 +146,7 @@ struct mthca_db_table {
 	int 	       	      max_group1;
 	int 	       	      min_group2;
 	struct mthca_db_page *page;
-	struct semaphore      mutex;
+	struct mutex          mutex;
 };
 
 enum mthca_db_type {
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 484a7e6..e88e39a 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
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
-- 
1.1.3
