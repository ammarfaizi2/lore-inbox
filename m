Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316977AbSFQUYh>; Mon, 17 Jun 2002 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316978AbSFQUYg>; Mon, 17 Jun 2002 16:24:36 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:43677 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316977AbSFQUYb>;
	Mon, 17 Jun 2002 16:24:31 -0400
Subject: [PATCH] 2.5.22: dasd patches.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2002 00:23:15 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17K4u3-0000Jq-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
three small dasd changes:
1) Replace is_read_only with bdev_read_only. The last user of is_read_only
   is gone...
2) Remove alloc & free of the label array in dasd_genhd. This is needed for
   the label array extension but this is a patch of its own.
3) Maintain the old behaviour of /proc/dasd/devices. Its is possible again
   to use "add <devno>" instead of "add device <devno>" or "add range=<devno>".

blue skies,
  Martin.

diff -urN linux-2.5.22/drivers/s390/block/dasd.c linux-2.5.22-s390/drivers/s390/block/dasd.c
--- linux-2.5.22/drivers/s390/block/dasd.c	Mon Jun 17 17:10:02 2002
+++ linux-2.5.22-s390/drivers/s390/block/dasd.c	Mon Jun 17 17:23:41 2002
@@ -1573,6 +1573,7 @@
 static inline void
 __dasd_process_blk_queue(dasd_device_t * device)
 {
+	struct block_device *bdev;
 	request_queue_t *queue;
 	struct list_head *l;
 	struct request *req;
@@ -1601,11 +1602,14 @@
 		if (cqr->status == DASD_CQR_QUEUED)
 			nr_queued++;
 	}
+	bdev = bdget(kdev_t_to_nr(device->kdev));
+	if (!bdev)
+		return;
 	while (!blk_queue_plugged(queue) &&
 	       !blk_queue_empty(queue) &&
 		nr_queued < DASD_CHANQ_MAX_SIZE) {
 		req = elv_next_request(queue);
-		if (is_read_only(device->kdev) && rq_data_dir(req) == WRITE) {
+		if (bdev_read_only(bdev) && rq_data_dir(req) == WRITE) {
 			DBF_EVENT(DBF_ERR,
 				  "(%04x) Rejecting write request %p",
 				  device->devinfo.devno, req);
@@ -1632,6 +1636,7 @@
 		dasd_profile_start(device, cqr, req);
 		nr_queued++;
 	}
+	bdput(bdev);
 }
 
 /*
diff -urN linux-2.5.22/drivers/s390/block/dasd_genhd.c linux-2.5.22-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.22/drivers/s390/block/dasd_genhd.c	Mon Jun 17 04:31:35 2002
+++ linux-2.5.22-s390/drivers/s390/block/dasd_genhd.c	Mon Jun 17 17:24:08 2002
@@ -65,7 +65,7 @@
 {
 	struct major_info *mi;
 	struct hd_struct *gd_part;
-	devfs_handle_t *gd_de_arr, *gd_label_arr;
+	devfs_handle_t *gd_de_arr;
 	int *gd_sizes;
 	char *gd_flags;
 	int new_major, rc;
@@ -78,14 +78,12 @@
 	gd_de_arr = kmalloc(DASD_PER_MAJOR * sizeof(devfs_handle_t),
 			    GFP_KERNEL);
 	gd_flags = kmalloc(DASD_PER_MAJOR * sizeof(char), GFP_KERNEL);
-	gd_label_arr = kmalloc(DASD_PER_MAJOR * sizeof(devfs_handle_t),
-			       GFP_KERNEL);
 	gd_part = kmalloc(sizeof (struct hd_struct) << MINORBITS, GFP_ATOMIC);
 	gd_sizes = kmalloc(sizeof(int) << MINORBITS, GFP_ATOMIC);
 
 	/* Check if one of the allocations failed. */
 	if (mi == NULL || gd_de_arr == NULL || gd_flags == NULL ||
-	    gd_label_arr == NULL || gd_part == NULL || gd_sizes == NULL) {
+	    gd_part == NULL || gd_sizes == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"Cannot get memory to allocate another "
 			"major number");
@@ -114,14 +112,12 @@
 	mi->gendisk.fops = &dasd_device_operations;
 	mi->gendisk.de_arr = gd_de_arr;
 	mi->gendisk.flags = gd_flags;
-	mi->gendisk.label_arr = gd_label_arr;
 	mi->gendisk.part = gd_part;
 	mi->gendisk.sizes = gd_sizes;
 
 	/* Initialize the gendisk arrays. */
 	memset(gd_de_arr, 0, DASD_PER_MAJOR * sizeof(devfs_handle_t));
 	memset(gd_flags, 0, DASD_PER_MAJOR * sizeof (char));
-	memset(gd_label_arr, 0, DASD_PER_MAJOR * sizeof(devfs_handle_t));
 	memset(gd_part, 0, sizeof (struct hd_struct) << MINORBITS);
 	memset(gd_sizes, 0, sizeof(int) << MINORBITS);
 
@@ -143,7 +139,6 @@
 	/* We rely on kfree to do the != NULL check. */
 	kfree(gd_sizes);
 	kfree(gd_part);
-	kfree(gd_label_arr);
 	kfree(gd_flags);
 	kfree(gd_de_arr);
 	kfree(mi);
@@ -182,7 +177,6 @@
 	/* Free memory. */
 	kfree(bs);
 	kfree(mi->gendisk.part);
-	kfree(mi->gendisk.label_arr);
 	kfree(mi->gendisk.flags);
 	kfree(mi->gendisk.de_arr);
 	kfree(mi);
diff -urN linux-2.5.22/drivers/s390/block/dasd_proc.c linux-2.5.22-s390/drivers/s390/block/dasd_proc.c
--- linux-2.5.22/drivers/s390/block/dasd_proc.c	Mon Jun 17 17:10:02 2002
+++ linux-2.5.22-s390/drivers/s390/block/dasd_proc.c	Mon Jun 17 17:23:41 2002
@@ -93,7 +93,7 @@
 		   size_t user_len, loff_t * offset)
 {
 	char *buffer, *str;
-	int add_or_set, device_or_range;
+	int add_or_set;
 	int from, to, features;
 
 	buffer = dasd_get_user_string(user_buf, user_len);
@@ -109,15 +109,11 @@
 		goto out_error;
 	for (str = str + 4; isspace(*str); str++);
 
-	/* Scan for "device " or "range=". */
-	if (strncmp(str, "device", 6) == 0 && isspace(str[6])) {
-		device_or_range = 0;
+	/* Scan for "device " and "range=" and ignore it. This is sick. */
+	if (strncmp(str, "device", 6) == 0 && isspace(str[6]))
+		for (str = str + 6; isspace(*str); str++);
+	if (strncmp(str, "range=", 6) == 0) 
 		for (str = str + 6; isspace(*str); str++);
-	} else if (strncmp(str, "range=", 6) == 0) {
-		device_or_range = 1;
-		str = str + 6;
-	} else
-		goto out_error;
 
 	/* Scan device number range and feature string. */
 	to = from = dasd_devno(str, &str);
