Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVJTPAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVJTPAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVJTPAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:00:38 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:6217 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751245AbVJTPAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:00:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ILMO563UENFOt/F0JKqNm4lf3oDIPGuuHdX8DxaNdVeyeriaVUIqK0oHNd54N3bBnzcy0pLfXsTdSA7K5ce5nVsMro4J/trLcnXrKll30NM4zbIxlfyrsE04clwz6e2+8xqR4HA1chbvZcxEpHaAEFsMY4e0fueAeIf3Z04UFbE=
Message-ID: <4357B10E.7010608@gmail.com>
Date: Fri, 21 Oct 2005 00:00:30 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 02/05] blk: update ioscheds to
 use generic dispatch queue
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.D377069C@htj.dyndns.org> <20051020112109.GC2811@suse.de> <20051020135124.GB26004@htj.dyndns.org> <20051020141104.GQ2811@suse.de> <4357AB3F.1050004@gmail.com> <20051020144108.GR2811@suse.de>
In-Reply-To: <20051020144108.GR2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Oct 20 2005, Tejun Heo wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Thu, Oct 20 2005, Tejun Heo wrote:
>>>
>>>
>>>>On Thu, Oct 20, 2005 at 01:21:09PM +0200, Jens Axboe wrote:
>>>>
>>>>
>>>>>On Wed, Oct 19 2005, Tejun Heo wrote:
>>>>>
>>>>>
>>>>>>02_blk_generic-dispatch-queue-update-for-ioscheds.patch
>>>>>>
>>>>>>	This patch updates all four ioscheds to use generic dispatch
>>>>>>	queue.  There's one behavior change in as-iosched.
>>>>>>
>>>>>>	* In as-iosched, when force dispatching
>>>>>>	  (ELEVATOR_INSERT_BACK), batch_data_dir is reset to REQ_SYNC
>>>>>>	  and changed_batch and new_batch are cleared to zero.  This
>>>>>>	  prevernts AS from doing incorrect update_write_batch after
>>>>>>	  the forced dispatched requests are finished.
>>>>>>
>>>>>>	* In cfq-iosched, cfqd->rq_in_driver currently counts the
>>>>>>	  number of activated (removed) requests to determine
>>>>>>	  whether queue-kicking is needed and cfq_max_depth has been
>>>>>>	  reached.  With generic dispatch queue, I think counting
>>>>>>	  the number of dispatched requests would be more appropriate.
>>>>>>
>>>>>>	* cfq_max_depth can be lowered to 1 again.
>>>>>
>>>>>I applied this one as well, with some minor changes. The biggest one is
>>>>>a cleanup of the 'force' logic, it seems to be a little mixed up in this
>>>>>patch. You use it for forcing dispatch, which is fine. But then it also
>>>>>doubles as whether you want to sort insert on the generic queue or just
>>>>>add to the tail?
>>>>
>>>>When forced dispatch occurs, all requests in a elevator get dumped
>>>>into the dispatch queue.  Specific elevators are free to dump in any
>>>>order and it's likely that specific elevators don't dump in the
>>>>optimal order - e.g. for cfq, it will dump each cfqq's in order which
>>>>results in unnecessary seeks.  That's why all the current ioscheds
>>>>tells elv_dispatch_insert() to perform global dispatch queue sorting
>>>>when they dump requests due to force argument.  Maybe add comments to
>>>>explain this?
>>>
>>>
>>>But why would you ever want non-sorted dispatch adding of requests,
>>>except for the cases where you absolutely need it to go at the back? I
>>>don't see what dispatch forcing has to do with this at all?
>>>
>>
>> For example, let's assume iosched is cfq.
>>
>> cfqq#0			cfqq#1
>>
>> 4 5 8 9		3 6 7
>>
>> While operating normally, cfqq may dispatch 4, 5 for cfqq#0 and then 
>>(possibly after idle delay) 3, 6, 7 for cfqq#1.  In these cases, iosched 
>>is performing sort so it tells elv_dispatch_insert() to just append to 
>>the dispatch queue by setting @sort to zero.
>>
>> But, let's say a barrier request gets queued.  Core elevator code asks 
>>iosched to dump all requests it has.  For cfqq, it results in the 
>>following sequence.
>>
>> 4 5 8 9 3 6 7 barrier
>>
>> Which isn't optimal.  As iosched's dispatching criteria also includes 
>>stuff like fairness / timing which can't be accounted for when forced 
>>dumping occurs, keeping the dumping order isn't very meaningful.  By 
>>setting @sort to 1 for forced dumps, we get,
>>
>> 3 4 5 6 7 8 9 barrier
>>
>> Does this make sense to you?
> 
> 
> That was the case before and I agree it's better to sort everything.
> What I'm asking is when do you ever want to _not_ sort, unless you are
> explicitly told to do INSERT_BACK? I don't mean the existing
> list_add_tail() that got converted, those are clearly a win. And since
> the _BACK handling is now generic, I don't see a need to pass in 'force'
> for any other purpose than 'we really need to force requests out, don't
> idle or anticipate, return what you have'.
> 
> Am I more clear now?
> 

  Yeap, I should have paid more attention to 'non-'. :-)

  I think we're currently talking about two issues.

  1. Is @sort=0 case useful?

  Currently all ioscheds dispatch requests in sorted order.  I was 
afraid that sorting again might result in less efficient seek pattern 
although I'm not quite sure whether or how that will happen.  That's why 
I added the @sort argument to elv_dispatch_insert().  If sorting cannot 
hurt in any case, we might sort unconditionally and remove @sort 
argument from elv_dispatch_insert().

  2. Why @force is used to turn on @sort?

  The reasoning was that, when a iosched is forced dispatched, it 
doesn't have control over many aspects of IO scheduling, so it cannot 
produce good ordering of dumped requests, which actually is true for 
cfq.  That's why @sort is turned on while force-dispatching requests.

  Maybe just removing @sort argument from elv_dispatch_insert() and 
sorting always is the way to go?

-- 
tejun
