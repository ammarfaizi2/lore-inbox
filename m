Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270079AbUJHRqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270079AbUJHRqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270060AbUJHRld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:41:33 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11953 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270032AbUJHRiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:38:25 -0400
Date: Fri, 8 Oct 2004 19:38:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/12): dcss changes.
Message-ID: <20041008173816.GF7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: dcss changes.

From: Gerald Schaefer <geraldsc@de.ibm.com>

DCSS block device driver changes:
 - Add module/kernel parameter for loading segments.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dcssblk.c |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+)

diff -urN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2004-10-08 19:19:12.000000000 +0200
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -19,6 +20,7 @@
 //#define DCSSBLK_DEBUG		/* Debug messages on/off */
 #define DCSSBLK_NAME "dcssblk"
 #define DCSSBLK_MINORS_PER_DISK 1
+#define DCSSBLK_PARM_LEN 400
 
 #ifdef DCSSBLK_DEBUG
 #define PRINT_DEBUG(x...) printk(KERN_DEBUG DCSSBLK_NAME " debug: " x)
@@ -34,6 +36,8 @@
 static int dcssblk_release(struct inode *inode, struct file *filp);
 static int dcssblk_make_request(struct request_queue *q, struct bio *bio);
 
+static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
+
 static int dcssblk_major;
 static struct block_device_operations dcssblk_devops = {
 	.owner   = THIS_MODULE,
@@ -641,6 +645,47 @@
 	return 0;
 }
 
+static void
+dcssblk_check_params(void)
+{
+	int rc, i, j, k;
+	char buf[9];
+	struct dcssblk_dev_info *dev_info;
+
+	for (i = 0; (i < DCSSBLK_PARM_LEN) && (dcssblk_segments[i] != '\0');
+	     i++) {
+		for (j = i; (dcssblk_segments[j] != ',')  &&
+			    (dcssblk_segments[j] != '\0') &&
+			    (dcssblk_segments[j] != '(')  &&
+			    (j - i) < 8; j++)
+		{
+			buf[j-i] = dcssblk_segments[j];
+		}
+		buf[j-i] = '\0';
+		rc = dcssblk_add_store(dcssblk_root_dev, buf, j-i);
+		if ((rc >= 0) && (dcssblk_segments[j] == '(')) {
+			for (k = 0; buf[k] != '\0'; k++)
+				buf[k] = toupper(buf[k]);
+			if (!strncmp(&dcssblk_segments[j], "(local)", 7)) {
+				down_read(&dcssblk_devices_sem);
+				dev_info = dcssblk_get_device_by_name(buf);
+				up_read(&dcssblk_devices_sem);
+				if (dev_info)
+					dcssblk_shared_store(&dev_info->dev,
+							     "0\n", 2);
+			}
+		}
+		while ((dcssblk_segments[j] != ',') &&
+		       (dcssblk_segments[j] != '\0'))
+		{
+			j++;
+		}
+		if (dcssblk_segments[j] == '\0')
+			break;
+		i = j;
+	}
+}
+
 /*
  * The init/exit functions.
  */
@@ -689,6 +734,9 @@
 	}
 	dcssblk_major = rc;
 	init_rwsem(&dcssblk_devices_sem);
+
+	dcssblk_check_params();
+
 	PRINT_DEBUG("...finished!\n");
 	return 0;
 }
@@ -696,4 +744,12 @@
 module_init(dcssblk_init);
 module_exit(dcssblk_exit);
 
+module_param_string(segments, dcssblk_segments, DCSSBLK_PARM_LEN, 0444);
+MODULE_PARM_DESC(segments, "Name of DCSS segment(s) to be loaded, "
+		 "comma-separated list, each name max. 8 chars.\n"
+		 "Adding \"(local)\" to segment name equals echoing 0 to "
+		 "/sys/devices/dcssblk/<segment name>/shared after loading "
+		 "the segment - \n"
+		 "e.g. segments=\"mydcss1,mydcss2,mydcss3(local)\"");
+
 MODULE_LICENSE("GPL");
