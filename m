Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCICF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCICF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVCICB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:01:58 -0500
Received: from fmr23.intel.com ([143.183.121.15]:54484 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262283AbVCIBvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:51:45 -0500
Message-Id: <200503090151.j291pag16426@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: Direct io on block device has performance regression on 2.6.x kernel - pseudo disk driver
Date: Tue, 8 Mar 2005 17:51:36 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkSNzKYDObGXK9SD6A7gSOX+GhIwAAWALA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pseudo disk driver that I used to stress the kernel I/O stack
(anything above block layer, AIO/DIO/BIO).

- Ken



diff -Nur zero/blknull.c blknull/blknull.c
--- zero/blknull.c	1969-12-31 16:00:00.000000000 -0800
+++ blknull/blknull.c	2005-03-03 19:04:07.000000000 -0800
@@ -0,0 +1,97 @@
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/blkpg.h>
+#include <linux/spinlock.h>
+
+#include <linux/blkdev.h>
+#include <linux/genhd.h>
+
+#define BLK_NULL_MAJOR	60
+#define BLK_NULL_NAME	"blknull"
+
+
+MODULE_AUTHOR("Ken Chen");
+MODULE_DESCRIPTION("null block driver");
+MODULE_LICENSE("GPL");
+
+
+spinlock_t driver_lock;
+struct request_queue *q;
+struct gendisk *disk;
+
+
+static int null_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int null_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static struct block_device_operations null_fops = {
+	.owner		= THIS_MODULE,
+	.open		= null_open,
+	.release	= null_release,
+};
+
+static void do_null_request(request_queue_t *q)
+{
+	struct request *req;
+
+	while (!blk_queue_plugged(q)) {
+		req = elv_next_request(q);
+		if (!req)
+			break;
+
+		blkdev_dequeue_request(req);
+
+		end_that_request_first(req, 1, req->nr_sectors);
+		end_that_request_last(req);
+	}
+}
+
+static int __init init_blk_null_module(void)
+{
+
+	if (register_blkdev(BLK_NULL_MAJOR, BLK_NULL_NAME)) {
+		printk(KERN_ERR "Unable to register null blk device\n");
+		return 0;
+	}
+
+	spin_lock_init(&driver_lock);
+	q = blk_init_queue(do_null_request, &driver_lock);
+	if (q) {
+		disk = alloc_disk(1);
+
+		if (disk) {
+			disk->major = BLK_NULL_MAJOR;
+			disk->first_minor = 0;
+			disk->fops = &null_fops;
+			disk->capacity = 1<<30;
+			disk->queue = q;
+			memcpy(disk->disk_name, BLK_NULL_NAME, sizeof(BLK_NULL_NAME));
+			add_disk(disk);
+			return 1;
+		}
+
+		blk_cleanup_queue(q);
+	}
+	unregister_blkdev(BLK_NULL_MAJOR, BLK_NULL_NAME);
+	return 0;
+}
+
+static void __exit exit_blk_null_module(void)
+{
+	del_gendisk(disk);
+	blk_cleanup_queue(q);
+	unregister_blkdev(BLK_NULL_MAJOR, BLK_NULL_NAME);
+}
+
+module_init(init_blk_null_module);
+module_exit(exit_blk_null_module);
diff -Nur zero/Makefile blknull/Makefile
--- zero/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ blknull/Makefile	2005-03-03 18:42:55.000000000 -0800
@@ -0,0 +1 @@
+obj-m := blknull.o



