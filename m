Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270004AbRHJUGw>; Fri, 10 Aug 2001 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270011AbRHJUGq>; Fri, 10 Aug 2001 16:06:46 -0400
Received: from fep03.swip.net ([130.244.199.131]:10131 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S270004AbRHJUFu>; Fri, 10 Aug 2001 16:05:50 -0400
Date: Fri, 10 Aug 2001 22:04:56 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Too many disk writes in 2.4.8-pre8
Message-ID: <Pine.LNX.4.33.0108102143340.1543-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem in sync_old_buffers() in kernel 2.4.8-pre8.
write_some_buffers() is always called at least once, which means that
under low/moderate I/O load, b_flushtime doesn't have any effect.
Everything is flushed to disk as soon as possible.

The result is unnecessary I/O and slowdown in a lot of cases. For example,
while configuring gcc, the system is paging out 400-500Kb/s constantly,
while in previous kernels the pageout rate was more like 10-20Kb/s.

The patch below fixes this problem:

--- linux/fs/buffer.c.orig	Fri Aug 10 21:42:52 2001
+++ linux/fs/buffer.c	Fri Aug 10 21:34:47 2001
@@ -2601,20 +2601,20 @@
 	sync_supers(0);
 	unlock_kernel();

-	spin_lock(&lru_list_lock);
 	for (;;) {
-		if (write_some_buffers(NODEV)) {
-			struct buffer_head *bh;
+		struct buffer_head *bh;

-			spin_lock(&lru_list_lock);
-			bh = lru_list[BUF_DIRTY];
-			if (bh && !time_before(jiffies, bh->b_flushtime))
-				continue;
+		spin_lock(&lru_list_lock);
+		bh = lru_list[BUF_DIRTY];
+		if (!bh || time_before(jiffies, bh->b_flushtime)) {
 			spin_unlock(&lru_list_lock);
+			break;
 		}
-		run_task_queue(&tq_disk);
-		return 0;
+		if (!write_some_buffers(NODEV))
+			break;
 	}
+	run_task_queue(&tq_disk);
+	return 0;
 }

 int block_sync_page(struct page *page)

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


