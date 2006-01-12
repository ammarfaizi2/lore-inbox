Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWALT0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWALT0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWALT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:26:47 -0500
Received: from tornado.reub.net ([202.89.145.182]:16035 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161203AbWALT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:26:46 -0500
Message-ID: <43C6AD72.2010101@reub.net>
Date: Fri, 13 Jan 2006 08:26:42 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Ric Wheeler <ric@emc.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org> <43C645ED.40905@reub.net> <43C64C3B.5070704@emc.com> <43C64DF6.7060604@reub.net> <20060112135533.GA29675@htj.dyndns.org>
In-Reply-To: <20060112135533.GA29675@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/01/2006 2:55 a.m., Tejun Heo wrote:
> Hello, again.
> 
> On Fri, Jan 13, 2006 at 01:39:18AM +1300, Reuben Farrelly wrote:
>>
>> On 13/01/2006 1:31 a.m., Ric Wheeler wrote:
>>> Reuben Farrelly wrote:
>>>> On 13/01/2006 12:18 a.m., Tejun Heo wrote:
>>>>> On Thu, Jan 12, 2006 at 09:38:48PM +1300, Reuben Farrelly wrote:
>>>>> [--snip--]
>>>>>
>>>>>> [start_ordered       ] f7e8a708 -> c1b028fc,c1b029a4,c1b02a4c infl=1
>>>>>> [start_ordered       ] f74b0e00 0 48869571 8 8 1 1 c1ba9000
>>>>>> [start_ordered       ] BIO f74b0e00 48869571 4096
>>>>>> [start_ordered       ] ordered=31 in_flight=1
>>>>>> [blk_do_ordered      ] start_ordered f7e8a708->00000000
>>>>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>>>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>>>
>>>>> Yeap, this one is the offending one.  0xf74ccd98 got requeued in front
>>>>> of pre-flush while draining and when it finished it didn't complete
>>>>> draining thus hanging the queue.  It seems like it's some kind of
>>>>> special request which probably fails and got retried.  Are you using
>>>>> SMART or something which issues special commands to drives?
>>>>
>>>> No SMART, although I should be (rebuilt the system a few months 
>>>> ago..and must
>>>> have missed it).
>>>>
>>>> Are there any other things which could be contributing to this?  
>>>> <scratches head>
>>>>
>>> Could this be hdparm or something tweaking the drive write cache 
>>> settings, etc?
>> hdparm isn't configured on the box by me or called by initscripts in Fedora 
>> either, AFAIK.
>>
> 
> This is the offending part of your new log.
> 
> [02 start_ordered           ] c1b36120 -> c1b35904,c1b359ac,c1b35a54 ordcolor=1 infl=1
> [02 start_ordered           ] f7eb91c0 0 68436682 8 8 1 1 f7dc0000
> [02 start_ordered           ] BIO f7eb91c0 68436682 4096
> [02 start_ordered           ] ordered=31 in_flight=1
> [02 blk_do_ordered          ] start_ordered c1b36120->00000000
> [02 blk_do_ordered          ] seq=02 f7e53660->f7e53660 (flags=0x32888)
> [02 elv_completed_request   ] seq=01 rq=f7dd7ba0 (flags=0x2000b44) infl=0
> [02 blk_do_ordered          ] seq=02 f7e53660->f7e53660 (flags=0x32b88)
> [02 blk_do_ordered          ] seq=02 c1b35904->00000000 (flags=0x0)
> [na flush_dry_bio_endio     ] BIO c19c7580 48869579 4096
> [na end_that_request_last   ] !ELVPRIV c1b3526c 000003d9
> [02 blk_do_ordered          ] seq=02 c1b35904->00000000 (flags=0x0)
> [02 elv_completed_request   ] seq=01 unacc f7e53660 (flags=0x32b88) infl=0
> [na end_that_request_last   ] !ELVPRIV c1b35314 02002318
> [02 blk_do_ordered          ] seq=02 c1b35904->00000000 (flags=0x0)
> 
> And I was wrong, it wasn't special command being requeued.  What
> happens here is....
> 
> 1. fs requests are happily being processed
> 
> 2. barrier request comes at the head of the queue
> 
> 3. ordered code interprets it into three request sequence, a fs
>    request is still in flight, so it wait for the queue to be drained.
> 
> 4. a REQ_SPECIAL | REQ_BLOCK_PC | REQ_QUIET request gets queued at
>    the head of the queue.  (I have no idea where this comes from.  sd
>    driver doesn't even handle PC requests.  It will be just failed.
>    Some kind of hardware management stuff trying to probe MMC
>    devices?)
> 
> 5. the in-flight fs request finishes, in_flight is now zero but the
>    head of queue is not the ordered sequence.  It determines draining
>    isn't complete yet.
> 
> 6. the special request from #4 got issued and completed, but due to
>    my stupid mistake, special requests don't check for draining
>    completion condition.
> 
> 7. The queue is stuck now.  SORRY.  My apologies.
> 
> Reuben, can you please test the following patch?  It's against -mm2
> but should apply to -mm3 too.  If you confirm this one, I'll submit to
> Jens & Andrew with proper explanations and stuff.  Thanks a lot for
> all your time and trouble.
> 
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 1b5b5d9..f905e47 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -615,23 +615,23 @@ void elv_completed_request(request_queue
>  	 * request is released from the driver, io must be done
>  	 */
>  	if (blk_account_rq(rq)) {
> -		struct request *first_rq = list_entry_rq(q->queue_head.next);
> -
>  		q->in_flight--;
> +		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
> +			e->ops->elevator_completed_req_fn(q, rq);
> +	}
>  
> -		/*
> -		 * Check if the queue is waiting for fs requests to be
> -		 * drained for flush sequence.
> -		 */
> -		if (q->ordseq && q->in_flight == 0 &&
> +	/*
> +	 * Check if the queue is waiting for fs requests to be
> +	 * drained for flush sequence.
> +	 */
> +	if (unlikely(q->ordseq)) {
> +		struct request *first_rq = list_entry_rq(q->queue_head.next);
> +		if (q->in_flight == 0 &&
>  		    blk_ordered_cur_seq(q) == QUEUE_ORDSEQ_DRAIN &&
>  		    blk_ordered_req_seq(first_rq) > QUEUE_ORDSEQ_DRAIN) {
>  			blk_ordered_complete_seq(q, QUEUE_ORDSEQ_DRAIN, 0);
>  			q->request_fn(q);
>  		}
> -
> -		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
> -			e->ops->elevator_completed_req_fn(q, rq);
>  	}
>  }

Indeed that seems to fix it.  I've just booted -mm3 and it came up with no 
problems at all.

Many thanks for the fix Tejun :)

reuben
