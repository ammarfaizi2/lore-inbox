Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDDWtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDDWtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDDWtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:49:46 -0400
Received: from webmail.topspin.com ([12.162.17.3]:9259 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261462AbVDDWeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:34:23 -0400
Subject: [PATCH][RFC][3/4] IB: userspace verbs mthca changes
In-Reply-To: <200544159.3X7p8nZ87qWqA7cv@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 4 Apr 2005 15:09:00 -0700
Message-Id: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 04 Apr 2005 22:09:00.0710 (UTC) FILETIME=[E7B7FC60:01C53962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mellanox HCA-specific userspace verbs support to mthca.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-04 14:57:12.228756073 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-04 14:58:12.364679525 -0700
@@ -743,6 +743,7 @@
 }
 
 int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_ucontext *ctx, u32 pdn,
 		  struct mthca_cq *cq)
 {
 	int size = nent * MTHCA_CQ_ENTRY_SIZE;
@@ -754,30 +755,33 @@
 
 	might_sleep();
 
-	cq->ibcq.cqe = nent - 1;
+	cq->ibcq.cqe  = nent - 1;
+	cq->is_kernel = !ctx;
 
 	cq->cqn = mthca_alloc(&dev->cq_table.alloc);
 	if (cq->cqn == -1)
 		return -ENOMEM;
 
 	if (mthca_is_memfree(dev)) {
-		cq->arm_sn = 1;
-
 		err = mthca_table_get(dev, dev->cq_table.table, cq->cqn);
 		if (err)
 			goto err_out;
 
-		err = -ENOMEM;
+		if (cq->is_kernel) {
+			cq->arm_sn = 1;
+
+			err = -ENOMEM;
 
-		cq->set_ci_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_SET_CI,
-						     cq->cqn, &cq->set_ci_db);
-		if (cq->set_ci_db_index < 0)
-			goto err_out_icm;
-
-		cq->arm_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_ARM,
-						  cq->cqn, &cq->arm_db);
-		if (cq->arm_db_index < 0)
-			goto err_out_ci;
+			cq->set_ci_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_SET_CI,
+							     cq->cqn, &cq->set_ci_db);
+			if (cq->set_ci_db_index < 0)
+				goto err_out_icm;
+
+			cq->arm_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_ARM,
+							  cq->cqn, &cq->arm_db);
+			if (cq->arm_db_index < 0)
+				goto err_out_ci;
+		}
 	}
 
 	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
@@ -787,12 +791,14 @@
 
 	cq_context = MAILBOX_ALIGN(mailbox);
 
-	err = mthca_alloc_cq_buf(dev, size, cq);
-	if (err)
-		goto err_out_mailbox;
+	if (cq->is_kernel) {
+		err = mthca_alloc_cq_buf(dev, size, cq);
+		if (err)
+			goto err_out_mailbox;
 
-	for (i = 0; i < nent; ++i)
-		set_cqe_hw(get_cqe(cq, i));
+		for (i = 0; i < nent; ++i)
+			set_cqe_hw(get_cqe(cq, i));
+	}
 
 	spin_lock_init(&cq->lock);
 	atomic_set(&cq->refcount, 1);
@@ -803,11 +809,14 @@
 						  MTHCA_CQ_STATE_DISARMED |
 						  MTHCA_CQ_FLAG_TR);
 	cq_context->start           = cpu_to_be64(0);
-	cq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24 |
-						  dev->driver_uar.index);
+	cq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24);
+	if (ctx)
+		cq_context->logsize_usrpage |= cpu_to_be32(ctx->uar.index);
+	else
+		cq_context->logsize_usrpage |= cpu_to_be32(dev->driver_uar.index);
 	cq_context->error_eqn       = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_ASYNC].eqn);
 	cq_context->comp_eqn        = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_COMP].eqn);
-	cq_context->pd              = cpu_to_be32(dev->driver_pd.pd_num);
+	cq_context->pd              = cpu_to_be32(pdn);
 	cq_context->lkey            = cpu_to_be32(cq->mr.ibmr.lkey);
 	cq_context->cqn             = cpu_to_be32(cq->cqn);
 
@@ -845,17 +854,19 @@
 	return 0;
 
 err_out_free_mr:
-	mthca_free_mr(dev, &cq->mr);
-	mthca_free_cq_buf(dev, cq);
+	if (cq->is_kernel) {
+		mthca_free_mr(dev, &cq->mr);
+		mthca_free_cq_buf(dev, cq);
+	}
 
 err_out_mailbox:
 	kfree(mailbox);
 
-	if (mthca_is_memfree(dev))
+	if (cq->is_kernel && mthca_is_memfree(dev))
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
 err_out_ci:
-	if (mthca_is_memfree(dev))
+	if (cq->is_kernel)
 		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 
 err_out_icm:
@@ -895,7 +906,8 @@
 		int j;
 
 		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
-		       cq->cqn, cq->cons_index, !!next_cqe_sw(cq));
+		       cq->cqn, cq->cons_index,
+		       cq->is_kernel ? !!next_cqe_sw(cq) : 0);
 		for (j = 0; j < 16; ++j)
 			printk(KERN_ERR "[%2x] %08x\n", j * 4, be32_to_cpu(ctx[j]));
 	}
@@ -913,15 +925,17 @@
 	atomic_dec(&cq->refcount);
 	wait_event(cq->wait, !atomic_read(&cq->refcount));
 
-	mthca_free_mr(dev, &cq->mr);
-	mthca_free_cq_buf(dev, cq);
-
-	if (mthca_is_memfree(dev)) {
-		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
-		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
-		mthca_table_put(dev, dev->cq_table.table, cq->cqn);
+	if (cq->is_kernel) {
+		mthca_free_mr(dev, &cq->mr);
+		mthca_free_cq_buf(dev, cq);
+		if (mthca_is_memfree(dev)) {
+			mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
+			mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+		}
 	}
 
+	if (mthca_is_memfree(dev))
+		mthca_table_put(dev, dev->cq_table.table, cq->cqn);
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
 	kfree(mailbox);
 }
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-04 14:57:12.254750421 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-04 14:58:12.411669307 -0700
@@ -49,14 +49,6 @@
 #define DRV_VERSION	"0.06-pre"
 #define DRV_RELDATE	"November 8, 2004"
 
-/* XXX remove once SINAI defines make it into kernel.org */
-#ifndef PCI_DEVICE_ID_MELLANOX_SINAI_OLD
-#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
-#endif
-#ifndef PCI_DEVICE_ID_MELLANOX_SINAI
-#define PCI_DEVICE_ID_MELLANOX_SINAI 0x6274
-#endif
-
 enum {
 	MTHCA_FLAG_DDR_HIDDEN = 1 << 1,
 	MTHCA_FLAG_SRQ        = 1 << 2,
@@ -413,6 +405,7 @@
 int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
 int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
 int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_ucontext *ctx, u32 pdn,
 		  struct mthca_cq *cq);
 void mthca_free_cq(struct mthca_dev *dev,
 		   struct mthca_cq *cq);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-04 14:57:12.256749986 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-04 14:58:12.412669090 -0700
@@ -45,6 +45,15 @@
 	MTHCA_TABLE_CHUNK_SIZE = 1 << 18
 };
 
+struct mthca_user_db_table {
+	struct semaphore mutex;
+	struct {
+		u64                uvirt;
+		struct scatterlist mem;
+		int                refcount;
+	}                page[0];
+};
+
 void mthca_free_icm(struct mthca_dev *dev, struct mthca_icm *icm)
 {
 	struct mthca_icm_chunk *chunk, *tmp;
@@ -334,13 +343,132 @@
 	kfree(table);
 }
 
-static u64 mthca_uarc_virt(struct mthca_dev *dev, int page)
+static u64 mthca_uarc_virt(struct mthca_dev *dev, struct mthca_uar *uar, int page)
 {
 	return dev->uar_table.uarc_base +
-		dev->driver_uar.index * dev->uar_table.uarc_size +
+		uar->index * dev->uar_table.uarc_size +
 		page * 4096;
 }
 
+int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+		      struct mthca_user_db_table *db_tab, int index, u64 uaddr)
+{
+	int ret = 0;
+	u8 status;
+	int i;
+
+	if (!mthca_is_memfree(dev))
+		return 0;
+
+	if (index < 0 || index > dev->uar_table.uarc_size / 8)
+		return -EINVAL;
+
+	down(&db_tab->mutex);
+
+	i = index / MTHCA_DB_REC_PER_PAGE;
+
+	if ((db_tab->page[i].refcount >= MTHCA_DB_REC_PER_PAGE)       ||
+	    (db_tab->page[i].uvirt && db_tab->page[i].uvirt != uaddr) ||
+	    (uaddr & 4095)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (db_tab->page[i].refcount) {
+		++db_tab->page[i].refcount;
+		goto out;
+	}
+
+	ret = get_user_pages(current, current->mm, uaddr & PAGE_MASK, 1, 1, 0,
+			     &db_tab->page[i].mem.page, NULL);
+	if (ret < 0)
+		goto out;
+
+	db_tab->page[i].mem.offset = uaddr & ~PAGE_MASK;
+
+	ret = pci_map_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+	if (ret < 0) {
+		put_page(db_tab->page[i].mem.page);
+		goto out;
+	}
+
+	ret = mthca_MAP_ICM_page(dev, sg_dma_address(&db_tab->page[i].mem),
+				 mthca_uarc_virt(dev, uar, i), &status);
+	if (!ret && status)
+		ret = -EINVAL;
+	if (ret) {
+		pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+		put_page(db_tab->page[i].mem.page);
+		goto out;
+	}
+
+	db_tab->page[i].uvirt    = uaddr;
+	db_tab->page[i].refcount = 1;
+
+out:
+	up(&db_tab->mutex);
+	return ret;
+}
+
+void mthca_unmap_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+			 struct mthca_user_db_table *db_tab, int index)
+{
+	if (!mthca_is_memfree(dev))
+		return;
+
+	/*
+	 * To make our bookkeeping simpler, we don't unmap DB
+	 * pages until we clean up the whole db table.
+	 */
+
+	down(&db_tab->mutex);
+
+	--db_tab->page[index / MTHCA_DB_REC_PER_PAGE].refcount;
+
+	up(&db_tab->mutex);
+}
+
+struct mthca_user_db_table *mthca_init_user_db_tab(struct mthca_dev *dev)
+{
+	struct mthca_user_db_table *db_tab;
+	int npages;
+	int i;
+
+	if (!mthca_is_memfree(dev))
+		return NULL;
+
+	npages = dev->uar_table.uarc_size / 4096;
+	db_tab = kmalloc(sizeof *db_tab + npages * sizeof *db_tab->page, GFP_KERNEL);
+	if (!db_tab)
+		return ERR_PTR(-ENOMEM);
+
+	init_MUTEX(&db_tab->mutex);
+	for (i = 0; i < npages; ++i) {
+		db_tab->page[i].refcount = 0;
+		db_tab->page[i].uvirt    = 0;
+	}
+
+	return db_tab;
+}
+
+void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
+			       struct mthca_user_db_table *db_tab)
+{
+	int i;
+	u8 status;
+
+	if (!mthca_is_memfree(dev))
+		return;
+
+	for (i = 0; i < dev->uar_table.uarc_size / 4096; ++i) {
+		if (db_tab->page[i].uvirt) {
+			mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, uar, i), 1, &status);
+			pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
+			put_page(db_tab->page[i].mem.page);
+		}
+	}
+}
+
 int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db)
 {
 	int group;
@@ -397,7 +525,8 @@
 	}
 	memset(page->db_rec, 0, 4096);
 
-	ret = mthca_MAP_ICM_page(dev, page->mapping, mthca_uarc_virt(dev, i), &status);
+	ret = mthca_MAP_ICM_page(dev, page->mapping,
+				 mthca_uarc_virt(dev, &dev->driver_uar, i), &status);
 	if (!ret && status)
 		ret = -EINVAL;
 	if (ret) {
@@ -451,7 +580,7 @@
 
 	if (bitmap_empty(page->used, MTHCA_DB_REC_PER_PAGE) &&
 	    i >= dev->db_tab->max_group1 - 1) {
-		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, &dev->driver_uar, i), 1, &status);
 		
 		dma_free_coherent(&dev->pdev->dev, 4096,
 				  page->db_rec, page->mapping);
@@ -520,7 +649,7 @@
 		if (!bitmap_empty(dev->db_tab->page[i].used, MTHCA_DB_REC_PER_PAGE))
 			mthca_warn(dev, "Kernel UARC page %d not empty\n", i);
 
-		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, i), 1, &status);
+		mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, &dev->driver_uar, i), 1, &status);
 		
 		dma_free_coherent(&dev->pdev->dev, 4096,
 				  dev->db_tab->page[i].db_rec,
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-04 14:57:12.256749986 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-04 14:58:12.413668872 -0700
@@ -148,7 +148,7 @@
 	struct semaphore      mutex;
 };
 
-enum {
+enum mthca_db_type {
 	MTHCA_DB_TYPE_INVALID   = 0x0,
 	MTHCA_DB_TYPE_CQ_SET_CI = 0x1,
 	MTHCA_DB_TYPE_CQ_ARM    = 0x2,
@@ -158,6 +158,17 @@
 	MTHCA_DB_TYPE_GROUP_SEP = 0x7
 };
 
+struct mthca_user_db_table;
+struct mthca_uar;
+
+int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+		      struct mthca_user_db_table *db_tab, int index, u64 uaddr);
+void mthca_unmap_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
+			 struct mthca_user_db_table *db_tab, int index);
+struct mthca_user_db_table *mthca_init_user_db_tab(struct mthca_dev *dev);
+void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
+			       struct mthca_user_db_table *db_tab);
+
 int mthca_init_db_tab(struct mthca_dev *dev);
 void mthca_cleanup_db_tab(struct mthca_dev *dev);
 int mthca_alloc_db(struct mthca_dev *dev, int type, u32 qn, u32 **db);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-04 14:57:12.286743464 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-04 14:58:12.444662133 -0700
@@ -29,13 +29,17 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: mthca_provider.c 2100 2005-03-31 20:43:01Z roland $
+ * $Id: mthca_provider.c 2109 2005-04-04 21:10:34Z roland $
  */
 
+#include <asm/uaccess.h>
+
 #include <ib_smi.h>
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_user.h"
+#include "mthca_memfree.h"
 
 static int mthca_query_device(struct ib_device *ibdev,
 			      struct ib_device_attr *props)
@@ -283,11 +287,78 @@
 	return err;
 }
 
-static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev)
+static struct ib_ucontext *mthca_alloc_ucontext(struct ib_device *ibdev,
+						const void __user *udata, int udatalen)
+{
+	struct mthca_alloc_ucontext      ucmd;
+	struct mthca_alloc_ucontext_resp uresp;
+	struct mthca_ucontext           *context;
+	int                              err;
+
+	if (copy_from_user(&ucmd, udata, sizeof ucmd))
+		return ERR_PTR(-EFAULT);
+
+	uresp.qp_tab_size = to_mdev(ibdev)->limits.num_qps;
+	if (mthca_is_memfree(to_mdev(ibdev)))
+		uresp.uarc_size = to_mdev(ibdev)->uar_table.uarc_size;
+	else
+		uresp.uarc_size = 0;
+
+	context = kmalloc(sizeof *context, GFP_KERNEL);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	err = mthca_uar_alloc(to_mdev(ibdev), &context->uar);
+	if (err) {
+		kfree(context);
+		return ERR_PTR(err);
+	}
+
+	context->db_tab = mthca_init_user_db_tab(to_mdev(ibdev));
+	if (IS_ERR(context->db_tab)) {
+		err = PTR_ERR(context->db_tab);
+		mthca_uar_free(to_mdev(ibdev), &context->uar);
+		kfree(context);
+		return ERR_PTR(err);
+	}
+
+	if (copy_to_user((void __user *) (unsigned long) ucmd.respbuf,
+			 &uresp, sizeof uresp)) {
+		mthca_cleanup_user_db_tab(to_mdev(ibdev), &context->uar, context->db_tab);
+		mthca_uar_free(to_mdev(ibdev), &context->uar);
+		kfree(context);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return &context->ibucontext;
+}
+
+static int mthca_dealloc_ucontext(struct ib_ucontext *context)
 {
+	mthca_cleanup_user_db_tab(to_mdev(context->device), &to_mucontext(context)->uar,
+				  to_mucontext(context)->db_tab);
+	mthca_uar_free(to_mdev(context->device), &to_mucontext(context)->uar);
+	kfree(to_mucontext(context));
+
+	return 0;
+}
+
+static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev,
+				    struct ib_ucontext *context,
+				    const void __user *udata, int udatalen)
+{
+	struct mthca_alloc_pd ucmd;
 	struct mthca_pd *pd;
 	int err;
 
+	if (context) {
+		if (udatalen != sizeof ucmd)
+			return ERR_PTR(-EINVAL);
+
+		if (copy_from_user(&ucmd, udata, sizeof ucmd))
+			return ERR_PTR(-EFAULT);
+	}
+
 	pd = kmalloc(sizeof *pd, GFP_KERNEL);
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
@@ -298,6 +369,14 @@
 		return ERR_PTR(err);
 	}
 
+	if (context) {
+		if (put_user(pd->pd_num, (u32 __user *) (unsigned long) ucmd.pdnbuf)) {
+			mthca_pd_free(to_mdev(ibdev), pd);
+			kfree(pd);
+			return ERR_PTR(-EFAULT);
+		}
+	}
+
 	return &pd->ibpd;
 }
 
@@ -337,8 +416,10 @@
 }
 
 static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
-				     struct ib_qp_init_attr *init_attr)
+				     struct ib_qp_init_attr *init_attr,
+				     const void __user *udata, int udatalen)
 {
+	struct mthca_create_qp ucmd;
 	struct mthca_qp *qp;
 	int err;
 
@@ -347,10 +428,48 @@
 	case IB_QPT_UC:
 	case IB_QPT_UD:
 	{
+		struct mthca_ucontext *context;
+
 		qp = kmalloc(sizeof *qp, GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
 
+		if (pd->uobject) {
+			context = to_mucontext(pd->uobject->context);
+
+			if (udatalen != sizeof ucmd)
+				return ERR_PTR(-EINVAL);
+
+			if (copy_from_user(&ucmd, udata, sizeof ucmd))
+				return ERR_PTR(-EFAULT);
+
+			err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
+						context->db_tab,
+						ucmd.sq_db_index, ucmd.sq_db_page);
+			if (err) {
+				kfree(qp);
+				return ERR_PTR(err);
+			}
+
+			err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
+						context->db_tab,
+						ucmd.rq_db_index, ucmd.rq_db_page);
+			if (err) {
+				mthca_unmap_user_db(to_mdev(pd->device),
+						    &context->uar,
+						    context->db_tab,
+						    ucmd.sq_db_index);
+				kfree(qp);
+				return ERR_PTR(err);
+			}
+		}
+
+		if (pd->uobject) {
+			qp->mr.ibmr.lkey = ucmd.lkey;
+			qp->sq.db_index  = ucmd.sq_db_index;
+			qp->rq.db_index  = ucmd.rq_db_index;
+		}
+
 		qp->sq.max    = init_attr->cap.max_send_wr;
 		qp->rq.max    = init_attr->cap.max_recv_wr;
 		qp->sq.max_gs = init_attr->cap.max_send_sge;
@@ -361,12 +480,30 @@
 				     to_mcq(init_attr->recv_cq),
 				     init_attr->qp_type, init_attr->sq_sig_type,
 				     qp);
+
+		if (err && pd->uobject) {
+			context = to_mucontext(pd->uobject->context);
+
+			mthca_unmap_user_db(to_mdev(pd->device),
+					    &context->uar,
+					    context->db_tab,
+					    ucmd.sq_db_index);
+			mthca_unmap_user_db(to_mdev(pd->device),
+					    &context->uar,
+					    context->db_tab,
+					    ucmd.rq_db_index);
+		}
+
 		qp->ibqp.qp_num = qp->qpn;
 		break;
 	}
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	{
+		/* Don't allow userspace to create special QPs */
+		if (pd->uobject)
+			return ERR_PTR(-EINVAL);
+
 		qp = kmalloc(sizeof (struct mthca_sqp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
@@ -396,42 +533,116 @@
 		return ERR_PTR(err);
 	}
 
-        init_attr->cap.max_inline_data = 0;
+	init_attr->cap.max_inline_data = 0;
+	init_attr->cap.max_send_wr     = qp->sq.max;
+	init_attr->cap.max_recv_wr     = qp->rq.max;
 
 	return &qp->ibqp;
 }
 
 static int mthca_destroy_qp(struct ib_qp *qp)
 {
+	if (qp->uobject) {
+		mthca_unmap_user_db(to_mdev(qp->device),
+				    &to_mucontext(qp->uobject->context)->uar,
+				    to_mucontext(qp->uobject->context)->db_tab,
+				    to_mqp(qp)->sq.db_index);
+		mthca_unmap_user_db(to_mdev(qp->device),
+				    &to_mucontext(qp->uobject->context)->uar,
+				    to_mucontext(qp->uobject->context)->db_tab,
+				    to_mqp(qp)->rq.db_index);
+	}
 	mthca_free_qp(to_mdev(qp->device), to_mqp(qp));
 	kfree(qp);
 	return 0;
 }
 
-static struct ib_cq *mthca_create_cq(struct ib_device *ibdev, int entries)
+static struct ib_cq *mthca_create_cq(struct ib_device *ibdev, int entries,
+				     struct ib_ucontext *context,
+				     const void __user *udata, int udatalen)
 {
+	struct mthca_create_cq ucmd;
 	struct mthca_cq *cq;
 	int nent;
 	int err;
 
+	if (context) {
+		if (udatalen != sizeof ucmd)
+			return ERR_PTR(-EINVAL);
+
+		if (copy_from_user(&ucmd, udata, sizeof ucmd))
+			return ERR_PTR(-EFAULT);
+
+		err = mthca_map_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+					to_mucontext(context)->db_tab,
+					ucmd.set_db_index, ucmd.set_db_page);
+		if (err)
+			return ERR_PTR(err);
+
+		err = mthca_map_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+					to_mucontext(context)->db_tab,
+					ucmd.arm_db_index, ucmd.arm_db_page);
+		if (err)
+			goto err_unmap_set;
+	}
+
 	cq = kmalloc(sizeof *cq, GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
+	if (!cq) {
+		err = -ENOMEM;
+		goto err_unmap_arm;
+	}
+
+	if (context) {
+		cq->mr.ibmr.lkey    = ucmd.lkey;
+		cq->set_ci_db_index = ucmd.set_db_index;
+		cq->arm_db_index    = ucmd.arm_db_index;
+	}
 
 	for (nent = 1; nent <= entries; nent <<= 1)
 		; /* nothing */
 
-	err = mthca_init_cq(to_mdev(ibdev), nent, cq);
-	if (err) {
-		kfree(cq);
-		cq = ERR_PTR(err);
+	err = mthca_init_cq(to_mdev(ibdev), nent, 
+			    context ? to_mucontext(context) : NULL,
+			    context ? ucmd.pdn : to_mdev(ibdev)->driver_pd.pd_num,
+			    cq);
+	if (err)
+		goto err_free;
+
+	if (context && put_user(cq->cqn, (u32 __user *) (unsigned long) ucmd.cqnbuf)) {
+		mthca_free_cq(to_mdev(ibdev), cq);
+		goto err_free;
 	}
 
 	return &cq->ibcq;
+
+err_free:
+	kfree(cq);
+
+err_unmap_arm:
+	if (context)
+		mthca_unmap_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+				    to_mucontext(context)->db_tab, ucmd.arm_db_index);
+
+err_unmap_set:
+	if (context)
+		mthca_unmap_user_db(to_mdev(ibdev), &to_mucontext(context)->uar,
+				    to_mucontext(context)->db_tab, ucmd.set_db_index);
+
+	return ERR_PTR(err);
 }
 
 static int mthca_destroy_cq(struct ib_cq *cq)
 {
+	if (cq->uobject) {
+		mthca_unmap_user_db(to_mdev(cq->device),
+				    &to_mucontext(cq->uobject->context)->uar,
+				    to_mucontext(cq->uobject->context)->db_tab,
+				    to_mcq(cq)->arm_db_index);
+		mthca_unmap_user_db(to_mdev(cq->device),
+				    &to_mucontext(cq->uobject->context)->uar,
+				    to_mucontext(cq->uobject->context)->db_tab,
+				    to_mcq(cq)->set_ci_db_index);
+	}
 	mthca_free_cq(to_mdev(cq->device), to_mcq(cq));
 	kfree(cq);
 
@@ -558,6 +769,57 @@
 				  convert_access(acc), mr);
 
 	if (err) {
+		kfree(page_list);
+		kfree(mr);
+		return ERR_PTR(err);
+	}
+
+	kfree(page_list);
+	return &mr->ibmr;
+}
+
+static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, struct ib_umem *region,
+				       int acc, const void __user *udata, int udatalen)
+{
+	struct ib_umem_chunk *chunk;
+	int npages = 0;
+	u64 *page_list;
+	struct mthca_mr *mr;
+	int shift;
+	int i, j, k;
+	int err;
+
+	shift = ffs(region->page_size) - 1;
+
+	mr = kmalloc(sizeof *mr, GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+	
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		npages += chunk->nents;
+
+	page_list = kmalloc(npages * sizeof *page_list, GFP_KERNEL);
+	if (!page_list) {
+		kfree(mr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	i = 0;
+
+	list_for_each_entry(chunk, &region->chunk_list, list)
+		for (j = 0; j < chunk->nmap; ++j)
+			for (k = 0; k < sg_dma_len(&chunk->page_list[j]) >> shift; ++k)
+				page_list[i++] = sg_dma_address(&chunk->page_list[j]) +
+					region->page_size * k;
+
+	err = mthca_mr_alloc_phys(to_mdev(pd->device),
+				  to_mpd(pd)->pd_num,
+				  page_list, shift, npages,
+				  region->virt_base, region->length,
+				  convert_access(acc), mr);
+
+	if (err) {
+		kfree(page_list);
 		kfree(mr);
 		return ERR_PTR(err);
 	}
@@ -574,6 +836,22 @@
 	return 0;
 }
 
+static int mthca_mmap_uar(struct ib_ucontext *context,
+			  struct vm_area_struct *vma)
+{
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (remap_pfn_range(vma, vma->vm_start,
+			    to_mucontext(context)->uar.pfn,
+			    PAGE_SIZE, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
 static struct ib_fmr *mthca_alloc_fmr(struct ib_pd *pd, int mr_access_flags,
 				      struct ib_fmr_attr *fmr_attr)
 {
@@ -690,6 +968,8 @@
 	int i;
 
 	strlcpy(dev->ib_dev.name, "mthca%d", IB_DEVICE_NAME_MAX);
+	dev->ib_dev.owner                = THIS_MODULE;
+
 	dev->ib_dev.node_type            = IB_NODE_CA;
 	dev->ib_dev.phys_port_cnt        = dev->limits.num_ports;
 	dev->ib_dev.dma_device           = &dev->pdev->dev;
@@ -699,6 +979,8 @@
 	dev->ib_dev.modify_port          = mthca_modify_port;
 	dev->ib_dev.query_pkey           = mthca_query_pkey;
 	dev->ib_dev.query_gid            = mthca_query_gid;
+	dev->ib_dev.alloc_ucontext       = mthca_alloc_ucontext;
+	dev->ib_dev.dealloc_ucontext     = mthca_dealloc_ucontext;
 	dev->ib_dev.alloc_pd             = mthca_alloc_pd;
 	dev->ib_dev.dealloc_pd           = mthca_dealloc_pd;
 	dev->ib_dev.create_ah            = mthca_ah_create;
@@ -711,6 +993,7 @@
 	dev->ib_dev.poll_cq              = mthca_poll_cq;
 	dev->ib_dev.get_dma_mr           = mthca_get_dma_mr;
 	dev->ib_dev.reg_phys_mr          = mthca_reg_phys_mr;
+	dev->ib_dev.reg_user_mr          = mthca_reg_user_mr;
 	dev->ib_dev.dereg_mr             = mthca_dereg_mr;
 
 	if (dev->mthca_flags & MTHCA_FLAG_FMR) {
@@ -726,6 +1009,7 @@
 	dev->ib_dev.attach_mcast         = mthca_multicast_attach;
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
+	dev->ib_dev.mmap                 = mthca_mmap_uar;
 
 	if (mthca_is_memfree(dev)) {
 		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-04-04 14:57:12.287743246 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-04-04 14:58:12.445661916 -0700
@@ -54,6 +54,14 @@
 	int           index;
 };
 
+struct mthca_user_db_table;
+
+struct mthca_ucontext {
+	struct ib_ucontext          ibucontext;
+	struct mthca_uar            uar;
+	struct mthca_user_db_table *db_tab;
+};
+
 struct mthca_mr {
 	struct ib_mr ibmr;
 	int order;
@@ -167,6 +175,7 @@
 	int                    cqn;
 	u32                    cons_index;
 	int                    is_direct;
+	int                    is_kernel;
 
 	/* Next fields are Arbel only */
 	int                    set_ci_db_index;
@@ -236,6 +245,11 @@
 	dma_addr_t      header_dma;
 };
 
+static inline struct mthca_ucontext *to_mucontext(struct ib_ucontext *ibucontext)
+{
+	return container_of(ibucontext, struct mthca_ucontext, ibucontext);
+}
+
 static inline struct mthca_fmr *to_mfmr(struct ib_fmr *ibmr)
 {
 	return container_of(ibmr, struct mthca_fmr, ibmr);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-04 14:57:12.320736072 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-04 14:58:12.491651915 -0700
@@ -652,7 +652,11 @@
 
 	/* leave arbel_sched_queue as 0 */
 
-	qp_context->usr_page   = cpu_to_be32(dev->driver_uar.index);
+	if (qp->ibqp.uobject)
+		qp_context->usr_page =
+			cpu_to_be32(to_mucontext(qp->ibqp.uobject->context)->uar.index);
+	else
+		qp_context->usr_page = cpu_to_be32(dev->driver_uar.index);
 	qp_context->local_qpn  = cpu_to_be32(qp->qpn);
 	if (attr_mask & IB_QP_DEST_QPN) {
 		qp_context->remote_qpn = cpu_to_be32(attr->dest_qp_num);
@@ -917,6 +921,15 @@
 
 	qp->send_wqe_offset = ALIGN(qp->rq.max << qp->rq.wqe_shift,
 				    1 << qp->sq.wqe_shift);
+
+	/*
+	 * If this is a userspace QP, we don't actually have to
+	 * allocate anything.  All we need is to calculate the WQE
+	 * sizes and the send_wqe_offset, so we're done now.
+	 */
+	if (pd->ibpd.uobject)
+		return 0;
+
 	size = PAGE_ALIGN(qp->send_wqe_offset +
 			  (qp->sq.max << qp->sq.wqe_shift));
 
@@ -1015,10 +1028,33 @@
 	return err;
 }
 
-static int mthca_alloc_memfree(struct mthca_dev *dev,
+static void mthca_free_wqe_buf(struct mthca_dev *dev,
 			       struct mthca_qp *qp)
 {
-	int ret = 0;
+	int i;
+	int size = PAGE_ALIGN(qp->send_wqe_offset +
+			      (qp->sq.max << qp->sq.wqe_shift));
+
+	if (qp->is_direct) {
+		pci_free_consistent(dev->pdev, size,
+				    qp->queue.direct.buf,
+				    pci_unmap_addr(&qp->queue.direct, mapping));
+	} else {
+		for (i = 0; i < size / PAGE_SIZE; ++i) {
+			pci_free_consistent(dev->pdev, PAGE_SIZE,
+					    qp->queue.page_list[i].buf,
+					    pci_unmap_addr(&qp->queue.page_list[i],
+							   mapping));
+		}
+	}
+
+	kfree(qp->wrid);
+}
+
+static int mthca_map_memfree(struct mthca_dev *dev,
+			     struct mthca_qp *qp)
+{
+	int ret;
 
 	if (mthca_is_memfree(dev)) {
 		ret = mthca_table_get(dev, dev->qp_table.qp_table, qp->qpn);
@@ -1029,35 +1065,15 @@
 		if (ret)
 			goto err_qpc;
 
-		ret = mthca_table_get(dev, dev->qp_table.rdb_table,
-				      qp->qpn << dev->qp_table.rdb_shift);
-		if (ret)
-			goto err_eqpc;
-
-		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
-						 qp->qpn, &qp->rq.db);
-		if (qp->rq.db_index < 0) {
-			ret = -ENOMEM;
-			goto err_rdb;
-		}
+ 		ret = mthca_table_get(dev, dev->qp_table.rdb_table,
+ 				      qp->qpn << dev->qp_table.rdb_shift);
+ 		if (ret)
+ 			goto err_eqpc;
 
-		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
-						 qp->qpn, &qp->sq.db);
-		if (qp->sq.db_index < 0) {
-			ret = -ENOMEM;
-			goto err_rq_db;
-		}
 	}
 
 	return 0;
 
-err_rq_db:
-	mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
-
-err_rdb:
-	mthca_table_put(dev, dev->qp_table.rdb_table,
-			qp->qpn << dev->qp_table.rdb_shift);
-
 err_eqpc:
 	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 
@@ -1067,16 +1083,43 @@
 	return ret;
 }
 
+static void mthca_unmap_memfree(struct mthca_dev *dev,
+				struct mthca_qp *qp)
+{
+	if (mthca_is_memfree(dev)) {
+ 		mthca_table_put(dev, dev->qp_table.rdb_table,
+ 				qp->qpn << dev->qp_table.rdb_shift);
+		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
+		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
+	}
+}
+
+static int mthca_alloc_memfree(struct mthca_dev *dev,
+			       struct mthca_qp *qp)
+{
+	int ret = 0;
+
+	if (mthca_is_memfree(dev)) {
+		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
+						 qp->qpn, &qp->rq.db);
+		if (qp->rq.db_index < 0)
+			return ret;
+
+		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
+						 qp->qpn, &qp->sq.db);
+		if (qp->sq.db_index < 0)
+			mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+	}
+
+	return ret;
+}
+
 static void mthca_free_memfree(struct mthca_dev *dev,
 			       struct mthca_qp *qp)
 {
 	if (mthca_is_memfree(dev)) {
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
-		mthca_table_put(dev, dev->qp_table.rdb_table,
-				qp->qpn << dev->qp_table.rdb_shift);
-		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
-		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 	}
 }
 
@@ -1108,13 +1151,28 @@
 	mthca_wq_init(&qp->sq);
 	mthca_wq_init(&qp->rq);
 
-	ret = mthca_alloc_memfree(dev, qp);
+	ret = mthca_map_memfree(dev, qp);
 	if (ret)
 		return ret;
 
 	ret = mthca_alloc_wqe_buf(dev, pd, qp);
 	if (ret) {
-		mthca_free_memfree(dev, qp);
+		mthca_unmap_memfree(dev, qp);
+		return ret;
+	}
+
+	/*
+	 * If this is a userspace QP, we're done now.  The doorbells
+	 * will be allocated and buffers will be initialized in
+	 * userspace.
+	 */
+	if (pd->ibpd.uobject)
+		return 0;
+
+	ret = mthca_alloc_memfree(dev, qp);
+	if (ret) {
+		mthca_free_wqe_buf(dev, qp);
+		mthca_unmap_memfree(dev, qp);
 		return ret;
 	}
 
@@ -1274,8 +1332,6 @@
 		   struct mthca_qp *qp)
 {
 	u8 status;
-	int size;
-	int i;
 	struct mthca_cq *send_cq;
 	struct mthca_cq *recv_cq;
 
@@ -1305,31 +1361,22 @@
 	if (qp->state != IB_QPS_RESET)
 		mthca_MODIFY_QP(dev, MTHCA_TRANS_ANY2RST, qp->qpn, 0, NULL, 0, &status);
 
-	mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn);
-	if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
-		mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn);
-
-	mthca_free_mr(dev, &qp->mr);
-
-	size = PAGE_ALIGN(qp->send_wqe_offset +
-			  (qp->sq.max << qp->sq.wqe_shift));
+	/*
+	 * If this is a userspace QP, the buffers, MR, CQs and so on
+	 * will be cleaned up in userspace, so all we have to do is
+	 * unref the mem-free tables and free the QPN in our table.
+	 */
+	if (!qp->ibqp.uobject) {
+		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn);
+		if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
+			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn);
 
-	if (qp->is_direct) {
-		pci_free_consistent(dev->pdev, size,
-				    qp->queue.direct.buf,
-				    pci_unmap_addr(&qp->queue.direct, mapping));
-	} else {
-		for (i = 0; i < size / PAGE_SIZE; ++i) {
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
-					    qp->queue.page_list[i].buf,
-					    pci_unmap_addr(&qp->queue.page_list[i],
-							   mapping));
-		}
+		mthca_free_mr(dev, &qp->mr);
+		mthca_free_memfree(dev, qp);
+		mthca_free_wqe_buf(dev, qp);
 	}
 
-	kfree(qp->wrid);
-
-	mthca_free_memfree(dev, qp);
+	mthca_unmap_memfree(dev, qp);
 
 	if (is_sqp(dev, qp)) {
 		atomic_dec(&(to_mpd(qp->ibqp.pd)->sqp_count));
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/hw/mthca/mthca_user.h	2005-04-04 14:58:12.491651915 -0700
@@ -0,0 +1,89 @@
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
+ */
+
+#ifndef MTHCA_USER_H
+#define MTHCA_USER_H
+
+#include <linux/types.h>
+
+/*
+ * Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ * In particular do not use pointer types -- pass pointers in __u64
+ * instead.
+ */
+
+struct mthca_alloc_ucontext {
+	__u64 respbuf;
+};
+
+struct mthca_alloc_ucontext_resp {
+	__u32 qp_tab_size;
+	__u32 uarc_size;
+};
+
+struct mthca_alloc_pd {
+	__u64 pdnbuf;
+};
+
+struct mthca_alloc_pd_resp {
+	__u32 pdn;
+	__u32 reserved;
+};
+
+struct mthca_create_cq {
+	__u64 cqnbuf;
+	__u32 lkey;
+	__u32 pdn;
+	__u64 arm_db_page;
+	__u64 set_db_page;
+	__u32 arm_db_index;
+	__u32 set_db_index;
+};
+
+struct mthca_create_cq_resp {
+	__u32 cqn;
+	__u32 reserved;
+};
+
+struct mthca_create_qp {
+	__u32 lkey;
+	__u32 reserved;
+	__u64 sq_db_page;
+	__u64 rq_db_page;
+	__u32 sq_db_index;
+	__u32 rq_db_index;
+};
+
+#endif /* MTHCA_USER_H */

