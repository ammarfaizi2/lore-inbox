Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVC2JuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVC2JuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVC2JuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:50:18 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:58991 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262289AbVC2JuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:50:05 -0500
Message-ID: <424924C8.1000608@yahoo.com.au>
Date: Tue, 29 Mar 2005 19:50:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de>
In-Reply-To: <20050329092819.GK16636@suse.de>
Content-Type: multipart/mixed;
 boundary="------------040403020003030803020602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403020003030803020602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> Looks good, I've been toying with something very similar for a long time
> myself.
> 
> The unplug change is a no-brainer.

Yep - I may have even stolen it from you (or someone) from a patch
which had been forgotten. I can't remember for sure, but it is trivial
enough that anyone could come up with it if they noticed, so I won't
worry about attribution ;)

> The retry stuff i __make_request()
> will make no real difference on 'typical' hardware, when it was
> introduced in 2.4.x it was very useful on slower devices like dvd-rams.
> The batch wakeups should take care of this.
> 

OK cool, that was the main thing I was unsure of.

> The atomic-vs-blocking allocation should be tested. I'd really like it
> to be a "don't dive into the vm very much, just wait on the mempool"
> type allocation, so we are not at the mercy of long vm reclaim times
> hurting the latencies here.
> 

Ahh yes I forgot it was backing it with a mempool. The problem I see
with that is that GFP_ATOMIC allocations eat into the mm's "atomic
reserve" pool (main use: networking), which would be nice not to.

So long as we are sure that we'll *eventually* fall back to the mempool,
it should be OK (but I still agree should have testing) - that isn't
entirely clear though, because the page allocator infinitely loops on
small allocations unless __GFP_NORETRY is set.

Andrew - tell me I'm missing something?

--------------040403020003030803020602
Content-Type: text/plain;
 name="mempool-can-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool-can-fail.patch"




---

 linux-2.6-npiggin/mm/mempool.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN mm/mempool.c~mempool-can-fail mm/mempool.c
--- linux-2.6/mm/mempool.c~mempool-can-fail	2005-03-29 19:45:02.000000000 +1000
+++ linux-2.6-npiggin/mm/mempool.c	2005-03-29 19:48:05.000000000 +1000
@@ -198,7 +198,10 @@ void * mempool_alloc(mempool_t *pool, in
 	void *element;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
-	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
+	int gfp_nowait;
+	
+	gfp_mask |= __GFP_NORETRY; /* don't loop in __alloc_pages */
+	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
 
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 repeat_alloc:

_

--------------040403020003030803020602--

