Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWJBXWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWJBXWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965526AbWJBXWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:22:39 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:27095 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965521AbWJBXVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:30 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <20061002232130.18827.97855.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH take2 2/5] dio: call blk_run_address_space() once per op
Date: Mon,  2 Oct 2006 16:21:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: call blk_run_address_space() once per op

We only need to call blk_run_address_space() once after all the bios for the
direct IO op have been submitted.  This removes the chance of calling
blk_run_address_space() after spurious wake ups as the sync path waits for bios
to drain.  It's also one less difference betwen the sync and async paths.

In the process we remove a redundant dio_bio_submit() that its caller had
already performed. 

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/direct-io.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: 2.6.18-rc6-dio-cleanup/fs/direct-io.c
===================================================================
--- 2.6.18-rc6-dio-cleanup.orig/fs/direct-io.c
+++ 2.6.18-rc6-dio-cleanup/fs/direct-io.c
@@ -403,7 +403,6 @@ static struct bio *dio_await_one(struct 
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			blk_run_address_space(dio->inode->i_mapping);
 			io_schedule();
 			spin_lock_irqsave(&dio->bio_lock, flags);
 			dio->waiter = NULL;
@@ -449,9 +448,6 @@ static int dio_bio_complete(struct dio *
  */
 static void dio_await_completion(struct dio *dio)
 {
-	if (dio->bio)
-		dio_bio_submit(dio);
-
 	/*
 	 * The bio_lock is not held for the read of bio_count.
 	 * This is ok since it is the dio_bio_complete() that changes
@@ -1077,6 +1073,9 @@ direct_io_worker(int rw, struct kiocb *i
 	if (dio->bio)
 		dio_bio_submit(dio);
 
+	/* All IO is now issued, send it on its way */
+	blk_run_address_space(inode->i_mapping);
+
 	/*
 	 * It is possible that, we return short IO due to end of file.
 	 * In that case, we need to release all the pages we got hold on.
@@ -1105,7 +1104,6 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
-		blk_run_address_space(inode->i_mapping);
 		if (should_wait) {
 			unsigned long flags;
 			/*
