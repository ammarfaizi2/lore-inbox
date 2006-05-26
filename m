Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWEZLyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWEZLyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWEZLxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:42 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39898 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932414AbWEZLxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:10 -0400
Message-ID: <348644385.05317@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115310.948231030@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 21/33] readahead: initial method - user recommended size
Content-Disposition: inline; filename=readahead-method-initial-size-recommend.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backing_dev_info.ra_pages0 is a user configurable parameter that controls
the readahead size on start-of-file.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 block/ll_rw_blk.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/block/ll_rw_blk.c
+++ linux-2.6.17-rc4-mm3/block/ll_rw_blk.c
@@ -3811,6 +3811,29 @@ queue_ra_store(struct request_queue *q, 
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
+	unsigned long kb, ra;
+	ssize_t ret = queue_var_store(&kb, page, count);
+
+	ra = kb >> (PAGE_CACHE_SHIFT - 10);
+	q->backing_dev_info.ra_pages0 = ra;
+
+	ra = kb * 1024;
+	if (q->backing_dev_info.ra_expect_bytes > ra)
+		q->backing_dev_info.ra_expect_bytes = ra;
+
+	return ret;
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = q->max_sectors >> 1;
@@ -3868,6 +3891,12 @@ static struct queue_sysfs_entry queue_ra
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
@@ -3888,6 +3917,7 @@ static struct queue_sysfs_entry queue_io
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
+	&queue_initial_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,

--
