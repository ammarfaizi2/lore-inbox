Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVJTOT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVJTOT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVJTOT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:19:26 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:14555 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932169AbVJTOT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:19:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ugkMpdPPoVmhS/WcSzjC+8AmscvCSd5pUvz+GGQsQOaJ4cXyu/68fnab7ihItYWHSUh91Eqn1BUs1YxU6D/kOqha+pkuF8tbcRqfPHZcHA6hngYbNH/YOjYvpzDYCYSSXPFjVZUUyx0xVdV9/FNCPwMfsqPKQv5xkvPkaaYHLnE=
Message-ID: <4357A764.7040301@gmail.com>
Date: Thu, 20 Oct 2005 23:19:16 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 01/05] blk: implement generic dispatch
 queue
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.1D0A2F29@htj.dyndns.org> <20051020100003.GB2811@suse.de> <20051020134515.GA26004@htj.dyndns.org> <20051020140421.GM2811@suse.de>
In-Reply-To: <20051020140421.GM2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Oct 20 2005, Tejun Heo wrote:
> 
>> Hi, Jens.
>>
>>On Thu, Oct 20, 2005 at 12:00:03PM +0200, Jens Axboe wrote:
>>
>>>On Wed, Oct 19 2005, Tejun Heo wrote:
>>>
>>>>@@ -40,6 +40,11 @@
>>>> static DEFINE_SPINLOCK(elv_list_lock);
>>>> static LIST_HEAD(elv_list);
>>>> 
>>>>+static inline sector_t rq_last_sector(struct request *rq)
>>>>+{
>>>>+	return rq->sector + rq->nr_sectors;
>>>>+}
>>>
>>>Slightly misnamed, since it's really the sector after the last sector
>>>:-)
>>>
>>>I've renamed that to rq_end_sector() instead.
>>
>> Maybe rename request_queue->last_sector too?
> 
> 
> Yeah agree.
> 
> 
>>>>+/*
>>>>+ * Insert rq into dispatch queue of q.  Queue lock must be held on
>>>>+ * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
>>>>+ * appended to the dispatch queue.  To be used by specific elevators.
>>>>+ */
>>>>+void elv_dispatch_insert(request_queue_t *q, struct request *rq, int sort)
>>>>+{
>>>>+	sector_t boundary;
>>>>+	unsigned max_back;
>>>>+	struct list_head *entry;
>>>>+
>>>>+	if (!sort) {
>>>>+		/* Specific elevator is performing sort.  Step away. */
>>>>+		q->last_sector = rq_last_sector(rq);
>>>>+		q->boundary_rq = rq;
>>>>+		list_add_tail(&rq->queuelist, &q->queue_head);
>>>>+		return;
>>>>+	}
>>>>+
>>>>+	boundary = q->last_sector;
>>>>+	max_back = q->max_back_kb * 2;
>>>>+	boundary = boundary > max_back ? boundary - max_back : 0;
>>>
>>>This looks really strange, what are you doing with boundary here?
>>>
>>
>> Taking backward seeking into account.  I reasonsed that if specific
>>elevator chooses the next request with backward seeking,
>>elv_dispatch_insert() shouldn't change the order because that may
>>result in less efficient seek pattern.  At the second thought,
>>specific elevators always perform sorting by itself in such cases, so
>>this seems unnecessary.  I think we can strip this thing out.
> 
> 
> It wasn't so much the actual action as the logic. You overwrite boundary
> right away and it seems really strange to complare the absolute rq
> location with the max_back_in_sectors offset?
> 
> But lets just kill it, care to send a patch when I have pushed this
> stuff out?
> 

  Sure.

> 
>>>> 		if (rq == q->last_merge)
>>>> 			q->last_merge = NULL;
>>>> 
>>>>+		if (!q->boundary_rq || q->boundary_rq == rq) {
>>>>+			q->last_sector = rq_last_sector(rq);
>>>>+			q->boundary_rq = NULL;
>>>>+		}
>>>
>>>This seems to be the only place where you clear ->boundary_rq, that
>>>can't be right. What about rq-to-rq merging, ->boundary_rq could be
>>>freed and you wont notice. Generally I don't really like keeping
>>>pointers to rqs around, it's given us problems in the past with the
>>>last_merge bits even. For now I've added a clear of this in
>>>__blk_put_request() as well.
>>
>> Oh, please don't do that.  Now, it's guaranteed that there are only
>>three paths a request can travel.
>>
>> set_req_fn ->
>>
>> i.   add_req_fn -> (merged_fn ->)* -> dispatch_fn -> activate_req_fn ->
>>      (deactivate_req_fn -> activate_req_fn ->)* -> completed_req_fn
>> ii.  add_req_fn -> (merged_fn ->)* -> merge_req_fn
>> iii. [none]
>>
>> -> put_req_fn
>>
>> These three are the only paths a request can travel.  Also note that
>>dispatched requests don't get merged.  So, after dispatched, the only
>>way out is via elevator_complete_req_fn and that's why that's the only
>>place ->boundary_rq is cleared.  I've also documented above in biodoc
>>so that we can simplify codes knowing above information.
> 
> 
> Ah, it's my mistake, you only set it on dispatch. I was thinking it had
> an earlier life time, so there's no bug there at all. Thanks for
> clearing that up.
> 

  Thanks.

-- 
tejun
