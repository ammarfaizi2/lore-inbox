Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVC2JWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVC2JWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVC2JWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:22:30 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:41302 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262230AbVC2JVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:21:51 -0500
Message-ID: <42491E2C.2070702@yahoo.com.au>
Date: Tue, 29 Mar 2005 19:21:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au>
In-Reply-To: <42491DBE.6020303@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080707080503080008020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707080503080008020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> I haven't used a big disk array (or tried any simulation), but I'll
> attach the patch if you're looking into that area.
> 

Oh, and this one removes a memory barrier. I think we (Jens and I)
agreed this is valid. Whether or not you'll notice a difference is
another story ;)


--------------080707080503080008020607
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



---

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/block/ll_rw_blk.c~blk-no-mb drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-no-mb	2005-03-29 18:58:19.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2005-03-29 19:20:10.000000000 +1000
@@ -1828,7 +1828,6 @@ static void __freed_request(request_queu
 		clear_queue_congested(q, rw);
 
 	if (rl->count[rw] + 1 <= q->nr_requests) {
-		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
 

_

--------------080707080503080008020607--

