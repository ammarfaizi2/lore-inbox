Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUBTPjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUBTPhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:37:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6312 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261293AbUBTPdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:33:12 -0500
Date: Fri, 20 Feb 2004 15:36:15 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 4/6] dm: default queue limits
Message-ID: <20040220153615.GR27549@reti>
References: <20040220153145.GN27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220153145.GN27549@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audit for list_for_each_*entry*
--- diff/drivers/md/dm-ioctl.c	2004-02-18 15:23:23.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2004-02-18 15:34:04.000000000 +0000
@@ -88,30 +88,24 @@ static unsigned int hash_str(const char 
  *---------------------------------------------------------------*/
 static struct hash_cell *__get_name_cell(const char *str)
 {
-	struct list_head *tmp;
 	struct hash_cell *hc;
 	unsigned int h = hash_str(str);
 
-	list_for_each (tmp, _name_buckets + h) {
-		hc = list_entry(tmp, struct hash_cell, name_list);
+	list_for_each_entry (hc, _name_buckets + h, name_list)
 		if (!strcmp(hc->name, str))
 			return hc;
-	}
 
 	return NULL;
 }
 
 static struct hash_cell *__get_uuid_cell(const char *str)
 {
-	struct list_head *tmp;
 	struct hash_cell *hc;
 	unsigned int h = hash_str(str);
 
-	list_for_each (tmp, _uuid_buckets + h) {
-		hc = list_entry(tmp, struct hash_cell, uuid_list);
+	list_for_each_entry (hc, _uuid_buckets + h, uuid_list)
 		if (!strcmp(hc->uuid, str))
 			return hc;
-	}
 
 	return NULL;
 }
@@ -935,6 +929,7 @@ static void retrieve_deps(struct dm_tabl
 	unsigned int count = 0;
 	struct list_head *tmp;
 	size_t len, needed;
+	struct dm_dev *dd;
 	struct dm_target_deps *deps;
 
 	deps = get_result_buffer(param, param_size, &len);
@@ -942,7 +937,7 @@ static void retrieve_deps(struct dm_tabl
 	/*
 	 * Count the devices.
 	 */
-	list_for_each(tmp, dm_table_get_devices(table))
+	list_for_each (tmp, dm_table_get_devices(table))
 		count++;
 
 	/*
@@ -959,10 +954,8 @@ static void retrieve_deps(struct dm_tabl
 	 */
 	deps->count = count;
 	count = 0;
-	list_for_each(tmp, dm_table_get_devices(table)) {
-		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+	list_for_each_entry (dd, dm_table_get_devices(table), list)
 		deps->dev[count++] = huge_encode_dev(dd->bdev->bd_dev);
-	}
 
 	param->data_size = param->data_start + needed;
 }
--- diff/drivers/md/dm-table.c	2004-02-18 15:15:13.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-02-18 15:38:06.000000000 +0000
@@ -329,13 +329,11 @@ static int lookup_device(const char *pat
  */
 static struct dm_dev *find_device(struct list_head *l, dev_t dev)
 {
-	struct list_head *tmp;
+	struct dm_dev *dd;
 
-	list_for_each(tmp, l) {
-		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+	list_for_each_entry (dd, l, list)
 		if (dd->bdev->bd_dev == dev)
 			return dd;
-	}
 
 	return NULL;
 }
--- diff/drivers/md/dm-target.c	2004-02-18 15:16:23.000000000 +0000
+++ source/drivers/md/dm-target.c	2004-02-18 15:38:06.000000000 +0000
@@ -25,15 +25,11 @@ static DECLARE_RWSEM(_lock);
 
 static inline struct tt_internal *__find_target_type(const char *name)
 {
-	struct list_head *tih;
 	struct tt_internal *ti;
 
-	list_for_each(tih, &_targets) {
-		ti = list_entry(tih, struct tt_internal, list);
-
+	list_for_each_entry (ti, &_targets, list)
 		if (!strcmp(name, ti->tt.name))
 			return ti;
-	}
 
 	return NULL;
 }
