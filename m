Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVC3AHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVC3AHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVC3AHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:07:44 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:29832 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261389AbVC3AHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:07:36 -0500
Message-ID: <4249EDC3.2080102@yahoo.com.au>
Date: Wed, 30 Mar 2005 10:07:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329131549.GV16636@suse.de>
In-Reply-To: <20050329131549.GV16636@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Mar 29 2005, Nick Piggin wrote:
> 
>>@@ -2577,19 +2577,18 @@ static int __make_request(request_queue_
>> 	spin_lock_prefetch(q->queue_lock);
>> 
>> 	barrier = bio_barrier(bio);
>>-	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
>>+	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
>> 		err = -EOPNOTSUPP;
>> 		goto end_io;
>> 	}
>> 
>>-again:
>> 	spin_lock_irq(q->queue_lock);
>> 
>> 	if (elv_queue_empty(q)) {
>> 		blk_plug_device(q);
>> 		goto get_rq;
>> 	}
> 
> 
> This should just goto get_rq, the plug should happen only at the end
> where you did add it:
> 

Yes I see. I'll fix that up.

> 
>>@@ -2693,10 +2675,11 @@ get_rq:
>> 	req->rq_disk = bio->bi_bdev->bd_disk;
>> 	req->start_time = jiffies;
>> 
>>+	spin_lock_irq(q->queue_lock);
>>+	if (elv_queue_empty(q))
>>+		blk_plug_device(q);
>> 	add_request(q, req);
>> out:
>>-	if (freereq)
>>-		__blk_put_request(q, freereq);
>> 	if (bio_sync(bio))
>> 		__generic_unplug_device(q);
>> 
> 
> 


