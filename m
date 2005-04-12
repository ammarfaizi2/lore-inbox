Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVDLLvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVDLLvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVDLLeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:34:46 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:49763 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262350AbVDLL0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:26:47 -0400
Message-ID: <425BB073.8050308@yahoo.com.au>
Date: Tue, 12 Apr 2005 21:26:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>, Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504120803.j3C83tg06634@unix-os.sc.intel.com> <425BAC55.7020506@yahoo.com.au>
In-Reply-To: <425BAC55.7020506@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090405030303040409000100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405030303040409000100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Chen, Kenneth W wrote:

>> I like the patch a lot and already did bench it on our db setup.  
>> However,
>> I'm seeing a negative regression compare to a very very crappy patch (see
>> attached, you can laugh at me for doing things like that :-).
>>
> 
> OK - if we go that way, perhaps the following patch may be the
> way to do it.
> 

Here.

-- 
SUSE Labs, Novell Inc.

--------------090405030303040409000100
Content-Type: text/plain;
 name="blk-efficient2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-efficient2.patch"

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 21:03:01.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 21:03:45.000000000 +1000
@@ -1956,10 +1956,11 @@ out:
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
-	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	do {
+	rq = get_request(q, rw, GFP_NOIO);
+	while (!rq) {
+		DEFINE_WAIT(wait);
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,
@@ -1987,7 +1988,7 @@ static struct request *get_request_wait(
 			spin_lock_irq(q->queue_lock);
 		}
 		finish_wait(&rl->wait[rw], &wait);
-	} while (!rq);
+	}
 
 	return rq;
 }

--------------090405030303040409000100--

