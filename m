Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWHaKJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWHaKJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHaKI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:57 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:10516 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751434AbWHaKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:46 -0400
Message-Id: <20060831100821.064076268@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:08:00 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org, Jens Axboe <axboe@suse.de>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 4/6] fault-injection capability for disk IO
Content-Disposition: inline; filename=fail_make_request.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fault-injection capability for disk IO.

Boot option:

	fail_make_request=<probability>,<interval>,<times>,<space>

	<probability>

		specifies how often it should fail in percent.

	<interval>

		specifies the interval of failures.

	<times>

		specifies how many times failures may happen at most.

	<space>

		specifies the size of free space where disk IO can be issued
		safely in bytes.

Example:

	fail_make_request=100,10,-1,0
	echo 1 > /sys/blocks/hda/hda1/make-it-fail

generic_make_request() on /dev/hda1 fails once per 10 times.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 block/genhd.c               |   31 +++++++++++++++++++++++++++++++
 block/ll_rw_blk.c           |   32 ++++++++++++++++++++++++++++++++
 fs/partitions/check.c       |   27 +++++++++++++++++++++++++++
 include/linux/genhd.h       |    4 ++++
 include/linux/should_fail.h |    4 ++++
 lib/Kconfig.debug           |    7 +++++++
 6 files changed, 105 insertions(+)

Index: work-shouldfail/block/ll_rw_blk.c
===================================================================
--- work-shouldfail.orig/block/ll_rw_blk.c
+++ work-shouldfail/block/ll_rw_blk.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
+#include <linux/should_fail.h>
 
 /*
  * for max sense size
@@ -2993,6 +2994,34 @@ static void handle_bad_sector(struct bio
 	set_bit(BIO_EOF, &bio->bi_flags);
 }
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+
+static DEFINE_SHOULD_FAIL(fail_make_request_data);
+
+static int __init setup_fail_make_request(char *str)
+{
+	should_fail_srandom(jiffies);
+	return setup_should_fail(&fail_make_request_data, str);
+}
+__setup("fail_make_request=", setup_fail_make_request);
+
+struct should_fail_data *fail_make_request = &fail_make_request_data;
+EXPORT_SYMBOL_GPL(fail_make_request);
+
+static int should_fail_request(struct should_fail_data *data, struct bio *bio)
+{
+	if ((bio->bi_bdev->bd_disk->flags & GENHD_FL_FAIL) ||
+	    (bio->bi_bdev->bd_part && bio->bi_bdev->bd_part->make_it_fail))
+		return should_fail(data, bio->bi_size);
+
+	return 0;
+}
+#else
+
+#define should_fail_request(data, bio)	(0)
+
+#endif
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -3077,6 +3106,9 @@ end_io:
 		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
+		if (should_fail_request(fail_make_request, bio))
+			goto end_io;
+
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -386,3 +386,10 @@ config FAIL_PAGE_ALLOC
 	help
 	  This option provides fault-injection capabilitiy for alloc_pages().
 
+config FAIL_MAKE_REQUEST
+	bool "fault-injection capabilitiy for disk IO"
+	depends on DEBUG_KERNEL
+	select SHOULD_FAIL
+	help
+	  This option provides fault-injection capabilitiy to disk IO.
+
Index: work-shouldfail/include/linux/should_fail.h
===================================================================
--- work-shouldfail.orig/include/linux/should_fail.h
+++ work-shouldfail/include/linux/should_fail.h
@@ -44,6 +44,10 @@ extern struct should_fail_data *failslab
 extern struct should_fail_data *fail_page_alloc;
 #endif
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+extern struct should_fail_data *fail_make_request;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)
Index: work-shouldfail/block/genhd.c
===================================================================
--- work-shouldfail.orig/block/genhd.c
+++ work-shouldfail/block/genhd.c
@@ -412,6 +412,34 @@ static struct disk_attribute disk_attr_s
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
@@ -419,6 +447,9 @@ static struct attribute * default_attrs[
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	&disk_attr_fail.attr,
+#endif
 	NULL,
 };
 
Index: work-shouldfail/include/linux/genhd.h
===================================================================
--- work-shouldfail.orig/include/linux/genhd.h
+++ work-shouldfail/include/linux/genhd.h
@@ -81,6 +81,9 @@ struct hd_struct {
 	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
 	int policy, partno;
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	int make_it_fail;
+#endif
 };
 
 #define GENHD_FL_REMOVABLE			1
@@ -88,6 +91,7 @@ struct hd_struct {
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
+#define GENHD_FL_FAIL				64
 
 struct disk_stats {
 	unsigned long sectors[2];	/* READs and WRITEs */
Index: work-shouldfail/fs/partitions/check.c
===================================================================
--- work-shouldfail.orig/fs/partitions/check.c
+++ work-shouldfail/fs/partitions/check.c
@@ -265,12 +265,39 @@ static struct part_attribute part_attr_s
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
