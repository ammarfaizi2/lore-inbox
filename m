Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966595AbWKOHuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966595AbWKOHuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966593AbWKOHuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:50 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:48334 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755487AbWKOHur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:47 -0500
Message-ID: <363577026.14901@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075030.229339867@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:25 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 18/28] readahead: initial method - user recommended size
Content-Disposition: inline; filename=readahead-initial-method-user-recommended-size.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backing_dev_info.ra_pages0 is a user configurable parameter that controls
the readahead size on start-of-file.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/block/ll_rw_blk.c
+++ linux-2.6.19-rc5-mm2/block/ll_rw_blk.c
@@ -3795,6 +3795,24 @@ queue_ra_store(struct request_queue *q, 
 	return ret;
 }
 
+static ssize_t queue_initial_ra_show(struct request_queue *q, char *page)
+{
+	int kb = q->backing_dev_info.ra_pages0 << (PAGE_CACHE_SHIFT - 10);
+
+	return queue_var_show(kb, (page));
+}
+
+static ssize_t
+queue_initial_ra_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long kb;
+	ssize_t ret = queue_var_store(&kb, page, count);
+
+	q->backing_dev_info.ra_pages0 = kb >> (PAGE_CACHE_SHIFT - 10);
+
+	return ret;
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = q->max_sectors >> 1;
@@ -3852,6 +3870,12 @@ static struct queue_sysfs_entry queue_ra
 	.store = queue_ra_store,
 };
 
+static struct queue_sysfs_entry queue_initial_ra_entry = {
+	.attr = {.name = "initial_ra_kb", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_initial_ra_show,
+	.store = queue_initial_ra_store,
+};
+
 static struct queue_sysfs_entry queue_max_sectors_entry = {
 	.attr = {.name = "max_sectors_kb", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_max_sectors_show,
@@ -3872,6 +3896,7 @@ static struct queue_sysfs_entry queue_io
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_initial_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,

--
