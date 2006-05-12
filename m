Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWELXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWELXpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWELXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:54 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63401 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932288AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 44 of 53] ipath - allow diags on any unit
X-Mercurial-Node: 28d938eb04630e0d1c415c3695132466fa1de5f6
Message-Id: <28d938eb04630e0d1c41.1147477409@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:29 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we hardwired all diags to unit 0.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 7634b2f0fc40 -r 28d938eb0463 drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Fri May 12 15:55:29 2006 -0700
@@ -66,18 +66,20 @@ static struct file_operations diag_file_
 	.release = ipath_diag_release
 };
 
-static struct cdev *diag_cdev;
-static struct class_device *diag_class_dev;
-
-int ipath_diag_init(void)
-{
-	return ipath_cdev_init(IPATH_DIAG_MINOR, "ipath_diag",
-			       &diag_file_ops, &diag_cdev, &diag_class_dev);
-}
-
-void ipath_diag_cleanup(void)
-{
-	ipath_cdev_cleanup(&diag_cdev, &diag_class_dev);
+int ipath_diag_add(struct ipath_devdata *dd)
+{
+	char name[16];
+
+	snprintf(name, sizeof(name), "ipath_diag%d", dd->ipath_unit);
+
+	return ipath_cdev_init(IPATH_DIAG_MINOR_BASE + dd->ipath_unit, name,
+			       &diag_file_ops, &dd->diag_cdev,
+			       &dd->diag_class_dev);
+}
+
+void ipath_diag_remove(struct ipath_devdata *dd)
+{
+	ipath_cdev_cleanup(&dd->diag_cdev, &dd->diag_class_dev);
 }
 
 /**
@@ -101,8 +103,7 @@ static int ipath_read_umem64(struct ipat
 	int ret;
 
 	/* not very efficient, but it works for now */
-	if (reg_addr < dd->ipath_kregbase ||
-	    reg_end > dd->ipath_kregend) {
+	if (reg_addr < dd->ipath_kregbase || reg_end > dd->ipath_kregend) {
 		ret = -EINVAL;
 		goto bail;
 	}
@@ -139,8 +140,7 @@ static int ipath_write_umem64(struct ipa
 	int ret;
 
 	/* not very efficient, but it works for now */
-	if (reg_addr < dd->ipath_kregbase ||
-	    reg_end > dd->ipath_kregend) {
+	if (reg_addr < dd->ipath_kregbase || reg_end > dd->ipath_kregend) {
 		ret = -EINVAL;
 		goto bail;
 	}
@@ -240,59 +240,45 @@ bail:
 
 static int ipath_diag_open(struct inode *in, struct file *fp)
 {
+	int unit = iminor(in) - IPATH_DIAG_MINOR_BASE;
 	struct ipath_devdata *dd;
-	int unit = 0; /* XXX this is bogus */
-	unsigned long flags;
-	int ret;
-
-	dd = ipath_lookup(unit);
+	int ret;
 
 	mutex_lock(&ipath_mutex);
-	spin_lock_irqsave(&ipath_devs_lock, flags);
 
 	if (ipath_diag_inuse) {
 		ret = -EBUSY;
 		goto bail;
 	}
 
-	list_for_each_entry(dd, &ipath_dev_list, ipath_list) {
-		/*
-		 * we need at least one infinipath device to be present
-		 * (don't use INITTED, because we want to be able to open
-		 * even if device is in freeze mode, which cleared INITTED).
-		 * There is a small amount of risk to this, which is why we
-		 * also verify kregbase is set.
-		 */
-
-		if (!(dd->ipath_flags & IPATH_PRESENT) ||
-		    !dd->ipath_kregbase)
-			continue;
-
-		ipath_diag_inuse = 1;
-		diag_set_link = 0;
-		ret = 0;
-		goto bail;
-	}
-
-	ret = -ENODEV;
-
-bail:
-	spin_unlock_irqrestore(&ipath_devs_lock, flags);
+	dd = ipath_lookup(unit);
+
+	if (dd == NULL || !(dd->ipath_flags & IPATH_PRESENT) ||
+	    !dd->ipath_kregbase) {
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	fp->private_data = dd;
+	ipath_diag_inuse = 1;
+	diag_set_link = 0;
+	ret = 0;
 
 	/* Only expose a way to reset the device if we
 	   make it into diag mode. */
-	if (ret == 0)
-		ipath_expose_reset(&dd->pcidev->dev);
-
+	ipath_expose_reset(&dd->pcidev->dev);
+
+bail:
 	mutex_unlock(&ipath_mutex);
 
 	return ret;
 }
 
-static int ipath_diag_release(struct inode *i, struct file *f)
+static int ipath_diag_release(struct inode *in, struct file *fp)
 {
 	mutex_lock(&ipath_mutex);
 	ipath_diag_inuse = 0;
+	fp->private_data = NULL;
 	mutex_unlock(&ipath_mutex);
 	return 0;
 }
@@ -300,16 +286,9 @@ static ssize_t ipath_diag_read(struct fi
 static ssize_t ipath_diag_read(struct file *fp, char __user *data,
 			       size_t count, loff_t *off)
 {
-	int unit = 0; /* XXX provide for reads on other units some day */
-	struct ipath_devdata *dd;
+	struct ipath_devdata *dd = fp->private_data;
 	void __iomem *kreg_base;
 	ssize_t ret;
-
-	dd = ipath_lookup(unit);
-	if (!dd) {
-		ret = -ENODEV;
-		goto bail;
-	}
 
 	kreg_base = dd->ipath_kregbase;
 
@@ -329,23 +308,16 @@ static ssize_t ipath_diag_read(struct fi
 		ret = count;
 	}
 
-bail:
 	return ret;
 }
 
 static ssize_t ipath_diag_write(struct file *fp, const char __user *data,
 				size_t count, loff_t *off)
 {
-	int unit = 0; /* XXX this is bogus */
-	struct ipath_devdata *dd;
+	struct ipath_devdata *dd = fp->private_data;
 	void __iomem *kreg_base;
 	ssize_t ret;
 
-	dd = ipath_lookup(unit);
-	if (!dd) {
-		ret = -ENODEV;
-		goto bail;
-	}
 	kreg_base = dd->ipath_kregbase;
 
 	if (count == 0)
@@ -364,6 +336,6 @@ static ssize_t ipath_diag_write(struct f
 		ret = count;
 	}
 
-bail:
-	return ret;
-}
+	return ret;
+}
+
diff -r 7634b2f0fc40 -r 28d938eb0463 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
@@ -488,6 +488,7 @@ static int __devinit ipath_init_one(stru
 	ipath_device_create_group(&pdev->dev, dd);
 	ipathfs_add_device(dd);
 	ipath_user_add(dd);
+	ipath_diag_add(dd);
 	ipath_layer_add(dd);
 
 	goto bail;
@@ -517,8 +518,9 @@ static void __devexit ipath_remove_one(s
 		return;
 
 	dd = pci_get_drvdata(pdev);
-	ipath_layer_del(dd);
-	ipath_user_del(dd);
+	ipath_layer_remove(dd);
+	ipath_diag_remove(dd);
+	ipath_user_remove(dd);
 	ipathfs_remove_device(dd);
 	ipath_device_remove_group(&pdev->dev, dd);
 	ipath_cdbg(VERBOSE, "Releasing pci memory regions, dd %p, "
diff -r 7634b2f0fc40 -r 28d938eb0463 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:29 2006 -0700
@@ -1390,16 +1390,16 @@ done:
 
 static int ipath_open(struct inode *in, struct file *fp)
 {
-	int ret, minor;
+	int ret, user_minor;
 
 	mutex_lock(&ipath_mutex);
 
-	minor = iminor(in);
+	user_minor = iminor(in) - IPATH_USER_MINOR_BASE;
 	ipath_cdbg(VERBOSE, "open on dev %lx (minor %d)\n",
-		   (long)in->i_rdev, minor);
-
-	if (minor)
-		ret = find_free_port(minor - 1, fp);
+		   (long)in->i_rdev, user_minor);
+
+	if (user_minor)
+		ret = find_free_port(user_minor - 1, fp);
 	else
 		ret = find_best_unit(fp);
 
@@ -1799,19 +1799,13 @@ int ipath_user_add(struct ipath_devdata 
 				      "error %d\n", -ret);
 			goto bail;
 		}
-		ret = ipath_diag_init();
-		if (ret < 0) {
-			ipath_dev_err(dd, "Unable to set up diag support: "
-				      "error %d\n", -ret);
-			goto bail_sma;
-		}
 
 		ret = init_cdev(0, "ipath", &ipath_file_ops, &wildcard_cdev,
 				&wildcard_class_dev);
 		if (ret < 0) {
 			ipath_dev_err(dd, "Could not create wildcard "
 				      "minor: error %d\n", -ret);
-			goto bail_diag;
+			goto bail_sma;
 		}
 
 		atomic_set(&user_setup, 1);
@@ -1820,31 +1814,28 @@ int ipath_user_add(struct ipath_devdata 
 	snprintf(name, sizeof(name), "ipath%d", dd->ipath_unit);
 
 	ret = init_cdev(dd->ipath_unit + 1, name, &ipath_file_ops,
-			&dd->cdev, &dd->class_dev);
+			&dd->user_cdev, &dd->user_class_dev);
 	if (ret < 0)
 		ipath_dev_err(dd, "Could not create user minor %d, %s\n",
 			      dd->ipath_unit + 1, name);
 
 	goto bail;
 
-bail_diag:
-	ipath_diag_cleanup();
 bail_sma:
 	user_cleanup();
 bail:
 	return ret;
 }
 
-void ipath_user_del(struct ipath_devdata *dd)
-{
-	cleanup_cdev(&dd->cdev, &dd->class_dev);
+void ipath_user_remove(struct ipath_devdata *dd)
+{
+	cleanup_cdev(&dd->user_cdev, &dd->user_class_dev);
 
 	if (atomic_dec_return(&user_count) == 0) {
 		if (atomic_read(&user_setup) == 0)
 			goto bail;
 
 		cleanup_cdev(&wildcard_cdev, &wildcard_class_dev);
-		ipath_diag_cleanup();
 		user_cleanup();
 
 		atomic_set(&user_setup, 0);
diff -r 7634b2f0fc40 -r 28d938eb0463 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:29 2006 -0700
@@ -347,8 +347,10 @@ struct ipath_devdata {
 	char *ipath_freezemsg;
 	/* pci access data structure */
 	struct pci_dev *pcidev;
-	struct cdev *cdev;
-	struct class_device *class_dev;
+	struct cdev *user_cdev;
+	struct cdev *diag_cdev;
+	struct class_device *user_class_dev;
+	struct class_device *diag_class_dev;
 	/* timer used to prevent stats overflow, error throttling, etc. */
 	struct timer_list ipath_stats_timer;
 	/* check for stale messages in rcv queue */
@@ -531,7 +533,7 @@ extern int __ipath_verbs_rcv(struct ipat
 extern int __ipath_verbs_rcv(struct ipath_devdata *, void *, void *, u32);
 
 void ipath_layer_add(struct ipath_devdata *);
-void ipath_layer_del(struct ipath_devdata *);
+void ipath_layer_remove(struct ipath_devdata *);
 
 int ipath_init_chip(struct ipath_devdata *, int);
 int ipath_enable_wc(struct ipath_devdata *dd);
@@ -545,14 +547,14 @@ void ipath_cdev_cleanup(struct cdev **cd
 void ipath_cdev_cleanup(struct cdev **cdevp,
 			struct class_device **class_devp);
 
-int ipath_diag_init(void);
-void ipath_diag_cleanup(void);
+int ipath_diag_add(struct ipath_devdata *);
+void ipath_diag_remove(struct ipath_devdata *);
 void ipath_diag_bringup_link(struct ipath_devdata *);
 
 extern wait_queue_head_t ipath_sma_state_wait;
 
 int ipath_user_add(struct ipath_devdata *dd);
-void ipath_user_del(struct ipath_devdata *dd);
+void ipath_user_remove(struct ipath_devdata *dd);
 
 struct sk_buff *ipath_alloc_skb(struct ipath_devdata *dd, gfp_t);
 
@@ -831,9 +833,10 @@ extern struct mutex ipath_mutex;
 
 #define IPATH_DRV_NAME		"ipath_core"
 #define IPATH_MAJOR		233
+#define IPATH_USER_MINOR_BASE	0
 #define IPATH_SMA_MINOR		128
-#define IPATH_DIAG_MINOR	129
-#define IPATH_NMINORS		130
+#define IPATH_DIAG_MINOR_BASE	129
+#define IPATH_NMINORS		255
 
 #define ipath_dev_err(dd,fmt,...) \
 	do { \
diff -r 7634b2f0fc40 -r 28d938eb0463 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:29 2006 -0700
@@ -402,7 +402,7 @@ void ipath_layer_add(struct ipath_devdat
 	mutex_unlock(&ipath_layer_mutex);
 }
 
-void ipath_layer_del(struct ipath_devdata *dd)
+void ipath_layer_remove(struct ipath_devdata *dd)
 {
 	mutex_lock(&ipath_layer_mutex);
 
