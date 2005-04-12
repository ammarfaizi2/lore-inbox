Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVDLNTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVDLNTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVDLNEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:04:54 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:19897 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262413AbVDLMtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:49:53 -0400
Message-ID: <425BC3ED.9050202@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:49:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 4/9] blk: no memory barrier
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050604070906030108020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604070906030108020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/9

-- 
SUSE Labs, Novell Inc.

--------------050604070906030108020808
Content-Type: text/plain;
 name="blk-no-mb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-no-mb.patch"

This memory barrier is not needed because the waitqueue will only get
waiters on it in the following situations:

rq->count has exceeded the threshold - however all manipulations of ->count
are performed under the runqueue lock, and so we will correctly pick up any
waiter.

Memory allocation for the request fails. In this case, there is no additional
help provided by the memory barrier. We are guaranteed to eventually wake
up waiters because the request allocation mempool guarantees that if the mem
allocation for a request fails, there must be some requests in flight. They
will wake up waiters when they are retired.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 22:26:13.000000000 +1000
@@ -1828,7 +1828,6 @@ static void __freed_request(request_queu
 		clear_queue_congested(q, rw);
 
 	if (rl->count[rw] + 1 <= q->nr_requests) {
-		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
 

--------------050604070906030108020808--

