Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWHYS23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWHYS23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWHYSZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:32 -0400
Received: from mx.pathscale.com ([64.160.42.68]:45698 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422778AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired within
	one minute
X-Mercurial-Node: 1a41dc627c5a1bc2f7e9d75af0a7806039541342
Message-Id: <1a41dc627c5a1bc2f7e9.1156530287@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:47 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:46 2006 -0700
@@ -114,6 +114,13 @@ static int __devinit ipath_init_one(stru
 #define PCI_DEVICE_ID_INFINIPATH_HT 0xd
 #define PCI_DEVICE_ID_INFINIPATH_PE800 0x10
 
+/*
+ * Number of seconds before we complain about not getting a LID
+ * assignment.
+ */
+
+#define LID_TIMEOUT 60
+
 static const struct pci_device_id ipath_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_INFINIPATH_HT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_INFINIPATH_PE800) },
@@ -129,6 +136,29 @@ static struct pci_driver ipath_driver = 
 	.id_table = ipath_pci_tbl,
 };
 
+
+static void check_link_status(void *data)
+{
+	struct ipath_devdata *dd = data;
+
+	/*
+	 * If we're in the NOCABLE state, try again in another minute.
+	 */
+
+	if (dd->ipath_flags & IPATH_STATUS_IB_NOCABLE) {
+		schedule_delayed_work(&dd->link_task, HZ * LID_TIMEOUT);
+		return;
+	}
+
+	/*
+	 * If we don't have a LID, let the user know and don't bother
+	 * checking again.
+	 */
+
+	if (dd->ipath_lid == 0)
+		dev_info(&dd->pcidev->dev,
+			 "We don't have a LID yet (no subnet manager?)");
+}
 
 static inline void read_bars(struct ipath_devdata *dd, struct pci_dev *dev,
 			     u32 *bar0, u32 *bar1)
@@ -196,6 +226,8 @@ static struct ipath_devdata *ipath_alloc
 
 	dd->pcidev = pdev;
 	pci_set_drvdata(pdev, dd);
+
+	INIT_WORK(&dd->link_task, check_link_status, dd);
 
 	list_add(&dd->ipath_list, &ipath_dev_list);
 
@@ -509,6 +541,9 @@ static int __devinit ipath_init_one(stru
 	ipath_diag_add(dd);
 	ipath_register_ib_device(dd);
 
+	/* Check that we have a LID in LID_TIMEOUT seconds. */
+	schedule_delayed_work(&dd->link_task, HZ * LID_TIMEOUT);
+
 	goto bail;
 
 bail_iounmap:
@@ -536,6 +571,9 @@ static void __devexit ipath_remove_one(s
 		return;
 
 	dd = pci_get_drvdata(pdev);
+
+	cancel_delayed_work(&dd->link_task);
+
 	ipath_unregister_ib_device(dd->verbs_dev);
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
@@ -1644,6 +1682,8 @@ int ipath_set_lid(struct ipath_devdata *
 	dd->ipath_lid = arg;
 	dd->ipath_lmc = lmc;
 
+	dev_info(&dd->pcidev->dev, "We got a lid: %u\n", arg);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:46 2006 -0700
@@ -508,6 +508,9 @@ struct ipath_devdata {
 	u32 ipath_lli_counter;
 	/* local link integrity errors */
 	u32 ipath_lli_errors;
+
+	/* Link status check work */
+	struct work_struct link_task;
 };
 
 extern struct list_head ipath_dev_list;
