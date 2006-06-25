Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752292AbWFXPTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWFXPTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbWFXPRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:17:30 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:36038 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752299AbWFXPR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:17:28 -0400
Message-ID: <351162245.15796@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625071729.342442894@localhost.localdomain>
References: <20060625071036.241325936@localhost.localdomain>
Date: Sun, 25 Jun 2006 15:10:38 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: [PATCH 2/7] iosched: introduce parameter deadline.reada_expire
Content-Disposition: inline; filename=iosched-reada-deadline.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce parameter reada_expire to the deadline elevator.

It avoids readahead requests contending with read requests,
and helps improve latency/throughput when there's many concurrent readers.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc6-mm2.orig/block/deadline-iosched.c
+++ linux-2.6.17-rc6-mm2/block/deadline-iosched.c
@@ -19,7 +19,8 @@
 /*
  * See Documentation/block/deadline-iosched.txt
  */
-static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
+static const int read_expire = HZ / 2;	/* max time before an _impending_ read is submitted. */
+static const int reada_expire = 60 * HZ;/* max time before a read-ahead is submitted. */
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
@@ -56,7 +57,7 @@ struct deadline_data {
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
-	int fifo_expire[2];
+	int fifo_expire[4];
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
@@ -711,7 +712,9 @@ static void *deadline_init_queue(request
 	dd->sort_list[READ] = RB_ROOT;
 	dd->sort_list[WRITE] = RB_ROOT;
 	dd->fifo_expire[READ] = read_expire;
+	dd->fifo_expire[READA] = reada_expire;
 	dd->fifo_expire[WRITE] = write_expire;
+	dd->fifo_expire[WRITEA] = write_expire;
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
 	dd->fifo_batch = fifo_batch;
@@ -780,6 +783,7 @@ static ssize_t __FUNC(elevator_t *e, cha
 	return deadline_var_show(__data, (page));			\
 }
 SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);
+SHOW_FUNCTION(deadline_reada_expire_show, dd->fifo_expire[READA], 1);
 SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);
 SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
 SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
@@ -803,6 +807,7 @@ static ssize_t __FUNC(elevator_t *e, con
 	return ret;							\
 }
 STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, INT_MAX, 1);
+STORE_FUNCTION(deadline_reada_expire_store, &dd->fifo_expire[READA], 0, INT_MAX, 1);
 STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], 0, INT_MAX, 1);
 STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX, 0);
 STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
@@ -815,6 +820,7 @@ STORE_FUNCTION(deadline_fifo_batch_store
 
 static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(read_expire),
+	DD_ATTR(reada_expire),
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),

--
