Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWH2RrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWH2RrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWH2RrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:47:00 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:29361 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S965058AbWH2Rq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:46:59 -0400
Subject: [Patch] blktrace: cleanup using on_each_cpu
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@kernel.dk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 19:46:52 +0200
Message-Id: <1156873612.2993.6.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills a few lines of code in blktrace by making use of
on_each_cpu().

Patch against 2.6.18-rc4-mm3.
(Tested with 2.6.17.11, though, as -rc4-mm3 refuses to come up on my
s390 guest.)

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 blktrace.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff -urp a/block/blktrace.c b/block/blktrace.c
--- a/block/blktrace.c	2006-08-29 18:10:51.000000000 +0200
+++ b/block/blktrace.c	2006-08-29 19:00:37.000000000 +0200
@@ -476,6 +476,9 @@ static void blk_check_time(unsigned long
 	*t -= (a + b) / 2;
 }
 
+/*
+ * calibrate our inter-CPU timings
+ */
 static void blk_trace_check_cpu_time(void *data)
 {
 	unsigned long long *t;
@@ -493,20 +496,6 @@ static void blk_trace_check_cpu_time(voi
 	put_cpu();
 }
 
-/*
- * Call blk_trace_check_cpu_time() on each CPU to calibrate our
inter-CPU
- * timings
- */
-static void blk_trace_calibrate_offsets(void)
-{
-	unsigned long flags;
-
-	smp_call_function(blk_trace_check_cpu_time, NULL, 1, 1);
-	local_irq_save(flags);
-	blk_trace_check_cpu_time(NULL);
-	local_irq_restore(flags);
-}
-
 static void blk_trace_set_ht_offsets(void)
 {
 #if defined(CONFIG_SCHED_SMT)
@@ -535,7 +524,7 @@ static void blk_trace_set_ht_offsets(voi
 static __init int blk_trace_init(void)
 {
 	mutex_init(&blk_tree_mutex);
-	blk_trace_calibrate_offsets();
+	on_each_cpu(blk_trace_check_cpu_time, NULL, 1, 1);
 	blk_trace_set_ht_offsets();
 
 	return 0;


