Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVDLNbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVDLNbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDLNEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:04:40 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:59735 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262416AbVDLMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:50:22 -0400
Message-ID: <425BC406.4030203@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:50:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 5/9] blk: branch hints
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040708070703080808080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708070703080808080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/9

-- 
SUSE Labs, Novell Inc.

--------------040708070703080808080600
Content-Type: text/plain;
 name="blk-branch-hint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-branch-hint.patch"

Sprinkle around a few branch hints in the block layer.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 22:26:13.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 22:26:13.000000000 +1000
@@ -1450,7 +1450,7 @@ EXPORT_SYMBOL(blk_remove_plug);
  */
 void __generic_unplug_device(request_queue_t *q)
 {
-	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+	if (unlikely(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)))
 		return;
 
 	if (!blk_remove_plug(q))
@@ -1749,7 +1749,7 @@ EXPORT_SYMBOL(blk_init_queue);
 
 int blk_get_queue(request_queue_t *q)
 {
-	if (!test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)) {
+	if (likely(!test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))) {
 		atomic_inc(&q->refcnt);
 		return 0;
 	}
@@ -2577,7 +2577,7 @@ static int __make_request(request_queue_
 	spin_lock_prefetch(q->queue_lock);
 
 	barrier = bio_barrier(bio);
-	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
+	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
@@ -2678,7 +2678,7 @@ get_rq:
 	/*
 	 * REQ_BARRIER implies no merging, but lets make it explicit
 	 */
-	if (barrier)
+	if (unlikely(barrier))
 		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
 
 	req->errors = 0;
@@ -2802,7 +2802,7 @@ static inline void block_wait_queue_runn
 {
 	DEFINE_WAIT(wait);
 
-	while (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+	while (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))) {
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->drain, &wait,
@@ -2911,7 +2911,7 @@ end_io:
 			goto end_io;
 		}
 
-		if (test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))
+		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
 		block_wait_queue_running(q);

--------------040708070703080808080600--

