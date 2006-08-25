Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWHYS3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWHYS3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWHYSZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:28 -0400
Received: from mx.pathscale.com ([64.160.42.68]:43138 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422759AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 23] IB/ipath - add new minor device to allow sending of
	diag packets
X-Mercurial-Node: 8743e6ee09c51e799f0f2332d82c3637c06dd0f0
Message-Id: <8743e6ee09c51e799f0f.1156530276@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:36 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_common.h b/drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Fri Aug 25 11:19:45 2006 -0700
@@ -461,6 +461,13 @@ struct __ipath_sendpkt {
 	__u32 sps_cnt;		/* number of entries to use in sps_iov */
 	/* array of iov's describing packet. TEMPORARY */
 	struct ipath_iovec sps_iov[4];
+};
+
+/* Passed into diag data special file's ->write method. */
+struct ipath_diag_pkt {
+	__u32 unit;
+	__u64 data;
+	__u32 len;
 };
 
 /*
diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Fri Aug 25 11:19:45 2006 -0700
@@ -41,6 +41,7 @@
  * through the /sys/bus/pci resource mmap interface.
  */
 
+#include <linux/io.h>
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
@@ -273,6 +274,158 @@ bail:
 	return ret;
 }
 
+static ssize_t ipath_diagpkt_write(struct file *fp,
+				   const char __user *data,
+				   size_t count, loff_t *off);
+
+static struct file_operations diagpkt_file_ops = {
+	.owner = THIS_MODULE,
+	.write = ipath_diagpkt_write,
+};
+
+static struct cdev *diagpkt_cdev;
+static struct class_device *diagpkt_class_dev;
+
+int __init ipath_diagpkt_add(void)
+{
+	return ipath_cdev_init(IPATH_DIAGPKT_MINOR,
+			       "ipath_diagpkt", &diagpkt_file_ops,
+			       &diagpkt_cdev, &diagpkt_class_dev);
+}
+
+void __exit ipath_diagpkt_remove(void)
+{
+	ipath_cdev_cleanup(&diagpkt_cdev, &diagpkt_class_dev);
+}
+
+/**
+ * ipath_diagpkt_write - write an IB packet
+ * @fp: the diag data device file pointer
+ * @data: ipath_diag_pkt structure saying where to get the packet
+ * @count: size of data to write
+ * @off: unused by this code
+ */
+static ssize_t ipath_diagpkt_write(struct file *fp,
+				   const char __user *data,
+				   size_t count, loff_t *off)
+{
+	u32 __iomem *piobuf;
+	u32 plen, clen, pbufn;
+	struct ipath_diag_pkt dp;
+	u32 *tmpbuf = NULL;
+	struct ipath_devdata *dd;
+	ssize_t ret = 0;
+	u64 val;
+
+	if (count < sizeof(dp)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (copy_from_user(&dp, data, sizeof(dp))) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	/* send count must be an exact number of dwords */
+	if (dp.len & 3) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	clen = dp.len >> 2;
+
+	dd = ipath_lookup(dp.unit);
+	if (!dd || !(dd->ipath_flags & IPATH_PRESENT) ||
+	    !dd->ipath_kregbase) {
+		ipath_cdbg(VERBOSE, "illegal unit %u for diag data send\n",
+			   dp.unit);
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	if (ipath_diag_inuse && !diag_set_link &&
+	    !(dd->ipath_flags & IPATH_LINKACTIVE)) {
+		diag_set_link = 1;
+		ipath_cdbg(VERBOSE, "Trying to set to set link active for "
+			   "diag pkt\n");
+		ipath_set_linkstate(dd, IPATH_IB_LINKARM);
+		ipath_set_linkstate(dd, IPATH_IB_LINKACTIVE);
+	}
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		ipath_cdbg(VERBOSE, "unit %u not usable\n", dd->ipath_unit);
+		ret = -ENODEV;
+		goto bail;
+	}
+	val = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
+	if (val != IPATH_IBSTATE_INIT && val != IPATH_IBSTATE_ARM &&
+	    val != IPATH_IBSTATE_ACTIVE) {
+		ipath_cdbg(VERBOSE, "unit %u not ready (state %llx)\n",
+			   dd->ipath_unit, (unsigned long long) val);
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	/* need total length before first word written */
+	/* +1 word is for the qword padding */
+	plen = sizeof(u32) + dp.len;
+
+	if ((plen + 4) > dd->ipath_ibmaxlen) {
+		ipath_dbg("Pkt len 0x%x > ibmaxlen %x\n",
+			  plen - 4, dd->ipath_ibmaxlen);
+		ret = -EINVAL;
+		goto bail;	/* before writing pbc */
+	}
+	tmpbuf = vmalloc(plen);
+	if (!tmpbuf) {
+		dev_info(&dd->pcidev->dev, "Unable to allocate tmp buffer, "
+			 "failing\n");
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	if (copy_from_user(tmpbuf,
+			   (const void __user *) (unsigned long) dp.data,
+			   dp.len)) {
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	piobuf = ipath_getpiobuf(dd, &pbufn);
+	if (!piobuf) {
+		ipath_cdbg(VERBOSE, "No PIO buffers avail unit for %u\n",
+			   dd->ipath_unit);
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	plen >>= 2;		/* in dwords */
+
+	if (ipath_debug & __IPATH_PKTDBG)
+		ipath_cdbg(VERBOSE, "unit %u 0x%x+1w pio%d\n",
+			   dd->ipath_unit, plen - 1, pbufn);
+
+	/* we have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order */
+	writeq(plen, piobuf);
+	ipath_flush_wc();
+	/* copy all by the trigger word, then flush, so it's written
+	 * to chip before trigger word, then write trigger word, then
+	 * flush again, so packet is sent. */
+	__iowrite32_copy(piobuf + 2, tmpbuf, clen - 1);
+	ipath_flush_wc();
+	__raw_writel(tmpbuf[clen - 1], piobuf + clen + 1);
+	ipath_flush_wc();
+
+	ret = sizeof(dp);
+
+bail:
+	vfree(tmpbuf);
+	return ret;
+}
+
 static int ipath_diag_release(struct inode *in, struct file *fp)
 {
 	mutex_lock(&ipath_mutex);
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -1881,7 +1881,17 @@ static int __init infinipath_init(void)
 		goto bail_group;
 	}
 
+	ret = ipath_diagpkt_add();
+	if (ret < 0) {
+		printk(KERN_ERR IPATH_DRV_NAME ": Unable to create "
+		       "diag data device: error %d\n", -ret);
+		goto bail_ipathfs;
+	}
+ 
 	goto bail;
+
+bail_ipathfs:
+	ipath_exit_ipathfs();
 
 bail_group:
 	ipath_driver_remove_group(&ipath_driver.driver);
@@ -1993,6 +2003,8 @@ static void __exit infinipath_cleanup(vo
 	struct ipath_devdata *dd, *tmp;
 	unsigned long flags;
 
+	ipath_diagpkt_remove();
+
 	ipath_exit_ipathfs();
 
 	ipath_driver_remove_group(&ipath_driver.driver);
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -789,6 +789,9 @@ void ipath_device_remove_group(struct de
 void ipath_device_remove_group(struct device *, struct ipath_devdata *);
 int ipath_expose_reset(struct device *);
 
+int ipath_diagpkt_add(void);
+void ipath_diagpkt_remove(void);
+
 int ipath_init_ipathfs(void);
 void ipath_exit_ipathfs(void);
 int ipathfs_add_device(struct ipath_devdata *);
@@ -813,6 +816,7 @@ extern struct mutex ipath_mutex;
 #define IPATH_DRV_NAME		"ib_ipath"
 #define IPATH_MAJOR		233
 #define IPATH_USER_MINOR_BASE	0
+#define IPATH_DIAGPKT_MINOR	127
 #define IPATH_DIAG_MINOR_BASE	129
 #define IPATH_NMINORS		255
 
