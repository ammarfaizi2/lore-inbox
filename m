Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWJQVoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWJQVoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWJQVoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:44:22 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:39176 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750822AbWJQVoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:44:21 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 17 Oct 2006 14:44:19 -0700
Message-ID: <adahcy2sjm4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Oct 2006 21:44:20.0690 (UTC) FILETIME=[674C9B20:01C6F235]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes various fixes found since 2.6.19-rc2:

Adrian Bunk:
      RDMA/amso1100: Fix a NULL dereference in error path

Arthur Kepner:
      IB/mthca: Use mmiowb after doorbell ring

Henrik Kretzschmar:
      RDMA/amso1100: pci_module_init() conversion

Robert Walsh:
      IB/ipath: Initialize diagpkt file on device init only

 drivers/infiniband/hw/amso1100/c2.c        |    2 -
 drivers/infiniband/hw/amso1100/c2_rnic.c   |    4 +-
 drivers/infiniband/hw/ipath/ipath_diag.c   |   65 ++++++++++++++++------------
 drivers/infiniband/hw/ipath/ipath_driver.c |   10 ----
 drivers/infiniband/hw/ipath/ipath_kernel.h |    3 -
 drivers/infiniband/hw/mthca/mthca_cq.c     |    7 +++
 drivers/infiniband/hw/mthca/mthca_qp.c     |   19 ++++++++
 drivers/infiniband/hw/mthca/mthca_srq.c    |    8 +++
 8 files changed, 75 insertions(+), 43 deletions(-)


diff --git a/drivers/infiniband/hw/amso1100/c2.c b/drivers/infiniband/hw/amso1100/c2.c
index dc1ebea..9e7bd94 100644
--- a/drivers/infiniband/hw/amso1100/c2.c
+++ b/drivers/infiniband/hw/amso1100/c2.c
@@ -1243,7 +1243,7 @@ static struct pci_driver c2_pci_driver =
 
 static int __init c2_init_module(void)
 {
-	return pci_module_init(&c2_pci_driver);
+	return pci_register_driver(&c2_pci_driver);
 }
 
 static void __exit c2_exit_module(void)
diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
index e37c568..30409e1 100644
--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -150,8 +150,8 @@ static int c2_rnic_query(struct c2_dev *
 	    (struct c2wr_rnic_query_rep *) (unsigned long) (vq_req->reply_msg);
 	if (!reply)
 		err = -ENOMEM;
-
-	err = c2_errno(reply);
+	else
+		err = c2_errno(reply);
 	if (err)
 		goto bail2;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
index 29958b6..28c087b 100644
--- a/drivers/infiniband/hw/ipath/ipath_diag.c
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c
@@ -67,19 +67,54 @@ static struct file_operations diag_file_
 	.release = ipath_diag_release
 };
 
+static ssize_t ipath_diagpkt_write(struct file *fp,
+				   const char __user *data,
+				   size_t count, loff_t *off);
+
+static struct file_operations diagpkt_file_ops = {
+	.owner = THIS_MODULE,
+	.write = ipath_diagpkt_write,
+};
+
+static atomic_t diagpkt_count = ATOMIC_INIT(0);
+static struct cdev *diagpkt_cdev;
+static struct class_device *diagpkt_class_dev;
+
 int ipath_diag_add(struct ipath_devdata *dd)
 {
 	char name[16];
+	int ret = 0;
+
+	if (atomic_inc_return(&diagpkt_count) == 1) {
+		ret = ipath_cdev_init(IPATH_DIAGPKT_MINOR,
+				      "ipath_diagpkt", &diagpkt_file_ops,
+				      &diagpkt_cdev, &diagpkt_class_dev);
+
+		if (ret) {
+			ipath_dev_err(dd, "Couldn't create ipath_diagpkt "
+				      "device: %d", ret);
+			goto done;
+		}
+	}
 
 	snprintf(name, sizeof(name), "ipath_diag%d", dd->ipath_unit);
 
-	return ipath_cdev_init(IPATH_DIAG_MINOR_BASE + dd->ipath_unit, name,
-			       &diag_file_ops, &dd->diag_cdev,
-			       &dd->diag_class_dev);
+	ret = ipath_cdev_init(IPATH_DIAG_MINOR_BASE + dd->ipath_unit, name,
+			      &diag_file_ops, &dd->diag_cdev,
+			      &dd->diag_class_dev);
+	if (ret)
+		ipath_dev_err(dd, "Couldn't create %s device: %d",
+			      name, ret);
+
+done:
+	return ret;
 }
 
 void ipath_diag_remove(struct ipath_devdata *dd)
 {
+	if (atomic_dec_and_test(&diagpkt_count))
+		ipath_cdev_cleanup(&diagpkt_cdev, &diagpkt_class_dev);
+
 	ipath_cdev_cleanup(&dd->diag_cdev, &dd->diag_class_dev);
 }
 
@@ -275,30 +310,6 @@ bail:
 	return ret;
 }
 
-static ssize_t ipath_diagpkt_write(struct file *fp,
-				   const char __user *data,
-				   size_t count, loff_t *off);
-
-static struct file_operations diagpkt_file_ops = {
-	.owner = THIS_MODULE,
-	.write = ipath_diagpkt_write,
-};
-
-static struct cdev *diagpkt_cdev;
-static struct class_device *diagpkt_class_dev;
-
-int __init ipath_diagpkt_add(void)
-{
-	return ipath_cdev_init(IPATH_DIAGPKT_MINOR,
-			       "ipath_diagpkt", &diagpkt_file_ops,
-			       &diagpkt_cdev, &diagpkt_class_dev);
-}
-
-void __exit ipath_diagpkt_remove(void)
-{
-	ipath_cdev_cleanup(&diagpkt_cdev, &diagpkt_class_dev);
-}
-
 /**
  * ipath_diagpkt_write - write an IB packet
  * @fp: the diag data device file pointer
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 12cefa6..b4ffaa7 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -2005,18 +2005,8 @@ static int __init infinipath_init(void)
 		goto bail_group;
 	}
 
-	ret = ipath_diagpkt_add();
-	if (ret < 0) {
-		printk(KERN_ERR IPATH_DRV_NAME ": Unable to create "
-		       "diag data device: error %d\n", -ret);
-		goto bail_ipathfs;
-	}
-
 	goto bail;
 
-bail_ipathfs:
-	ipath_exit_ipathfs();
-
 bail_group:
 	ipath_driver_remove_group(&ipath_driver.driver);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
index 7c43669..06d5020 100644
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -869,9 +869,6 @@ int ipath_device_create_group(struct dev
 void ipath_device_remove_group(struct device *, struct ipath_devdata *);
 int ipath_expose_reset(struct device *);
 
-int ipath_diagpkt_add(void);
-void ipath_diagpkt_remove(void);
-
 int ipath_init_ipathfs(void);
 void ipath_exit_ipathfs(void);
 int ipathfs_add_device(struct ipath_devdata *);
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index e393681..149b369 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -39,6 +39,8 @@
 #include <linux/init.h>
 #include <linux/hardirq.h>
 
+#include <asm/io.h>
+
 #include <rdma/ib_pack.h>
 
 #include "mthca_dev.h"
@@ -210,6 +212,11 @@ static inline void update_cons_index(str
 		mthca_write64(doorbell,
 			      dev->kar + MTHCA_CQ_DOORBELL,
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		/*
+		 * Make sure doorbells don't leak out of CQ spinlock
+		 * and reach the HCA out of order:
+		 */
+		mmiowb();
 	}
 }
 
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 5e5c58b..6a7822e 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -39,6 +39,8 @@ #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
+#include <asm/io.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_pack.h>
@@ -1732,6 +1734,11 @@ out:
 		mthca_write64(doorbell,
 			      dev->kar + MTHCA_SEND_DOORBELL,
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		/*
+		 * Make sure doorbells don't leak out of SQ spinlock
+		 * and reach the HCA out of order:
+		 */
+		mmiowb();
 	}
 
 	qp->sq.next_ind = ind;
@@ -1851,6 +1858,12 @@ out:
 	qp->rq.next_ind = ind;
 	qp->rq.head    += nreq;
 
+	/*
+	 * Make sure doorbells don't leak out of RQ spinlock and reach
+	 * the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&qp->rq.lock, flags);
 	return err;
 }
@@ -2112,6 +2125,12 @@ out:
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
+	/*
+	 * Make sure doorbells don't leak out of SQ spinlock and reach
+	 * the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
 	return err;
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 92a72f5..f5d7677 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -35,6 +35,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include <asm/io.h>
+
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
 #include "mthca_memfree.h"
@@ -595,6 +597,12 @@ int mthca_tavor_post_srq_recv(struct ib_
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
+	/*
+	 * Make sure doorbells don't leak out of SRQ spinlock and
+	 * reach the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&srq->lock, flags);
 	return err;
 }
