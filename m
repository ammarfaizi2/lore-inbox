Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbUKDAUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUKDAUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKDARj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:17:39 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:50161 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261971AbUKDAN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:13:26 -0500
Date: Wed, 3 Nov 2004 19:10:50 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: blk_queue_congestion_threshold()
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411031913_MC3-1-8DE3-3DC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Looking at this function in ll_rw_blk.c:


static void blk_queue_congestion_threshold(struct request_queue *q)
{
        int nr;

        nr = q->nr_requests - (q->nr_requests / 8) + 1;
        if (nr > q->nr_requests)
                nr = q->nr_requests;
        q->nr_congestion_on = nr;

        nr = q->nr_requests - (q->nr_requests / 8) - 1;
        if (nr < 1)
                nr = 1;
        q->nr_congestion_off = nr;
}


  Why are the "on" and "off" thresholds the same, i.e. shouldn't there be some
hysteresis?  Con Kolivas posted a patch that changed the "off" threshold to
"nr_requests - nr_requests/8 - nr_requests/16" and it was said to be better,
but it never made it into mainline (it also changed get_request_wait() and that
was never merged either):


--- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 12:25:09.798003278 +0200
+++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 12:25:42.959479479 +0200
@@ -100,7 +100,7 @@
                nr = q->nr_requests;
        q->nr_congestion_on = nr;
 
-       nr = q->nr_requests - (q->nr_requests / 8) - 1;
+       nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
        if (nr < 1)
                nr = 1;
        q->nr_congestion_off = nr;
@@ -1758,8 +1758,10 @@
 {
        DEFINE_WAIT(wait);
        struct request *rq;
+       struct io_context *ioc;
 
        generic_unplug_device(q);
+       ioc = get_io_context(GFP_NOIO);
        do {
                struct request_list *rl = &q->rq;
 
@@ -1769,7 +1771,6 @@
                rq = get_request(q, rw, GFP_NOIO);
 
                if (!rq) {
-                       struct io_context *ioc;
 
                        io_schedule();
 
@@ -1779,12 +1780,11 @@
                         * up to a big batch of them for a small period time.
                         * See ioc_batching, ioc_set_batching
                         */
-                       ioc = get_io_context(GFP_NOIO);
                        ioc_set_batching(q, ioc);
-                       put_io_context(ioc);
                }
                finish_wait(&rl->wait[rw], &wait);
        } while (!rq);
+       put_io_context(ioc);
 
        return rq;
 }



--Chuck Ebbert  03-Nov-04  19:58:53
