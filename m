Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWCQNqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWCQNqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWCQNqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:46:12 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:1674 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750830AbWCQNqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:46:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JHppB7lCbbPu4H6S0wt+MuDfQ5x6aV9Qq+gRm5Vpw70oB3DwECNU4LQInd3kSHPdfRMqustiBOZhhKaa62Osyma6E81xfOVBbMvyVdGvdsoFcPAg31znpJ2uBG6LAYq1p1RyLLDeOtQt6Hp5IEx+MXuTUg8tb2sRZ8oq1vXVNZc=  ;
Message-ID: <441ABD9F.6060407@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:46:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
References: <200603081013.44678.kernel@kolivas.org> <200603172338.10107.kernel@kolivas.org> <441AB8FA.10609@yahoo.com.au> <200603180036.11326.kernel@kolivas.org>
In-Reply-To: <200603180036.11326.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 18 March 2006 00:26, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>-static inline void __activate_task(task_t *p, runqueue_t *rq)
>>>+static void __activate_task(task_t *p, runqueue_t *rq)
>>> {
>>>-	enqueue_task(p, rq->active);
>>>+	if (batch_task(p))
>>>+		enqueue_task(p, rq->expired);
>>>+	else
>>>+		enqueue_task(p, rq->active);
>>> 	inc_nr_running(p, rq);
>>> }
>>
>>I prefer:
>>
>>   prio_array_t *target = rq->active;
>>   if (batch_task(p))
>>     target = rq->expired;
>>   enqueue_task(p, target);
>>
>>Because gcc can use things like predicated instructions for it.
>>But perhaps it is smart enough these days to recognise this?
>>At least in the past I have seen it start using cmov after doing
>>such a conversion.
>>
>>At any rate, I think it looks nicer as well. IMO, of course.
> 
> 
> Well on my one boring architecture here is a before and after, gcc 4.1.0 with 
> optimise for size kernel config:

> I'm not attached to the style, just the feature. If you think it's warranted 
> I'll change it.
> 

I guess it isn't doing the cmov because it doesn't want to do the
extra load in the common case, which is fair enough (are you compiling
for a pentiumpro+, without generic x86 support? what about if you
turn off optimise for size?)

At least other archtectures might be able to make better use of it,
and I agree even for i386 the code looks better (and slightly smaller).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
