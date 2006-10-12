Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWJLHoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWJLHoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWJLHnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:51 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422795AbWJLHnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=KFULtj+4xnh+z1BLHhQa/GQEVi1DQ2Fr8TL5XqTFLRR9xukyjgnPukdsEa6QCCmpDVvVKI9SGZjl06U3NQ+sVsHDEXzi0zqFGiyiIuhcb2bVQsce8su/kxICp+zH45cF99WaHONTbUigWES7bUCtHzVOFcHNeNVlqXZg/DvmqaQ=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:10 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Jens Axboe <axboe@suse.de>
Subject: [patch 5/7] fault-injection capability for disk IO
Content-Disposition: inline; filename=fail_make_request.patch
Message-ID: <452df232.7451e919.6dde.ffff9127@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides fault-injection capability for disk IO.

Boot option:

fail_make_request=<probability>,<interval>,<space>,<times>

	<interval> -- specifies the interval of failures.

	<probability> -- specifies how often it should fail in percent.

	<space> -- specifies the size of free space where disk IO can be issued
		   safely in bytes.

	<times> -- specifies how many times failures may happen at most.

Debugfs:

/debug/fail_make_request/interval
/debug/fail_make_request/probability
/debug/fail_make_request/specifies
/debug/fail_make_request/times

Example:

	fail_make_request=10,100,0,-1
	echo 1 > /sys/blocks/hda/hda1/make-it-fail

generic_make_request() on /dev/hda1 fails once per 10 times.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 block/genhd.c         |   31 +++++++++++++++++++++++++++++++
 block/ll_rw_blk.c     |   43 +++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/check.c |   27 +++++++++++++++++++++++++++
 include/linux/genhd.h |    4 ++++
 lib/Kconfig.debug     |    7 +++++++
 5 files changed, 112 insertions(+)

Index: work-fault-inject/block/ll_rw_blk.c
===================================================================
--- work-fault-inject.orig/block/ll_rw_blk.c
+++ work-fault-inject/block/ll_rw_blk.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
+#include <linux/fault-inject.h>
 
 /*
  * for max sense size
@@ -3050,6 +3051,45 @@ static void handle_bad_sector(struct bio
 	set_bit(BIO_EOF, &bio->bi_flags);
 }
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+
+static DEFINE_FAULT_ATTR(fail_make_request);
+
+static int __init setup_fail_make_request(char *str)
+{
+	should_fail_srandom(jiffies);
+
+	return setup_fault_attr(&fail_make_request, str);
+}
+__setup("fail_make_request=", setup_fail_make_request);
+
+static int should_fail_request(struct bio *bio)
+{
+	if ((bio->bi_bdev->bd_disk->flags & GENHD_FL_FAIL) ||
+	    (bio->bi_bdev->bd_part && bio->bi_bdev->bd_part->make_it_fail))
+		return should_fail(&fail_make_request, bio->bi_size);
+
+	return 0;
+}
+
+static int __init fail_make_request_debugfs(void)
+{
+	should_fail_srandom(jiffies);
+
+	return init_fault_attr_entries(&fail_make_request, "fail_make_request");
+}
+
+late_initcall(fail_make_request_debugfs);
+
+#else /* CONFIG_FAIL_MAKE_REQUEST */
+
+static inline int should_fail_request(struct bio *bio)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FAIL_MAKE_REQUEST */
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -3134,6 +3174,9 @@ end_io:
 		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
+		if (should_fail_request(bio))
+			goto end_io;
+
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -487,6 +487,13 @@ config FAIL_PAGE_ALLOC
 	help
 	  This option provides fault-injection capabilitiy for alloc_pages().
 
+config FAIL_MAKE_REQUEST
+	bool "fault-injection capabilitiy for disk IO"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION 
+	help
+	  This option provides fault-injection capabilitiy to disk IO.
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS
Index: work-fault-inject/block/genhd.c
===================================================================
--- work-fault-inject.orig/block/genhd.c
+++ work-fault-inject/block/genhd.c
@@ -417,6 +417,34 @@ static struct disk_attribute disk_attr_s
 	.show	= disk_stats_read
 };
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+
+static ssize_t disk_fail_store(struct gendisk * disk,
+			       const char *buf, size_t count)
+{
+	int i;
+
+	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
+		if (i == 0)
+			disk->flags &= ~GENHD_FL_FAIL;
+		else
+			disk->flags |= GENHD_FL_FAIL;
+	}
+
+	return count;
+}
+static ssize_t disk_fail_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%d\n", disk->flags & GENHD_FL_FAIL ? 1 : 0);
+}
+static struct disk_attribute disk_attr_fail = {
+	.attr = {.name = "make-it-fail", .mode = S_IRUGO | S_IWUSR },
+	.store	= disk_fail_store,
+	.show	= disk_fail_read
+};
+
+#endif
+
 static struct attribute * default_attrs[] = {
 	&disk_attr_uevent.attr,
 	&disk_attr_dev.attr,
@@ -424,6 +452,9 @@ static struct attribute * default_attrs[
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	&disk_attr_fail.attr,
+#endif
 	NULL,
 };
 
Index: work-fault-inject/include/linux/genhd.h
===================================================================
--- work-fault-inject.orig/include/linux/genhd.h
+++ work-fault-inject/include/linux/genhd.h
@@ -83,6 +83,9 @@ struct hd_struct {
 	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
 	int policy, partno;
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	int make_it_fail;
+#endif
 };
 
 #define GENHD_FL_REMOVABLE			1
@@ -90,6 +93,7 @@ struct hd_struct {
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
+#define GENHD_FL_FAIL				64
 
 struct disk_stats {
 	unsigned long sectors[2];	/* READs and WRITEs */
Index: work-fault-inject/fs/partitions/check.c
===================================================================
--- work-fault-inject.orig/fs/partitions/check.c
+++ work-fault-inject/fs/partitions/check.c
@@ -276,12 +276,39 @@ static struct part_attribute part_attr_s
 	.show	= part_stat_read
 };
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+
+static ssize_t part_fail_store(struct hd_struct * p,
+			       const char *buf, size_t count)
+{
+	int i;
+
+	if (count > 0 && sscanf(buf, "%d", &i) > 0)
+		p->make_it_fail = (i == 0) ? 0 : 1;
+
+	return count;
+}
+static ssize_t part_fail_read(struct hd_struct * p, char *page)
+{
+	return sprintf(page, "%d\n", p->make_it_fail);
+}
+static struct part_attribute part_attr_fail = {
+	.attr = {.name = "make-it-fail", .mode = S_IRUGO | S_IWUSR },
+	.store	= part_fail_store,
+	.show	= part_fail_read
+};
+
+#endif
+
 static struct attribute * default_attrs[] = {
 	&part_attr_uevent.attr,
 	&part_attr_dev.attr,
 	&part_attr_start.attr,
 	&part_attr_size.attr,
 	&part_attr_stat.attr,
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	&part_attr_fail.attr,
+#endif
 	NULL,
 };
 

--
