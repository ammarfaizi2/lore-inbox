Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbULKN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbULKN4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 08:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbULKN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 08:56:39 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:33255 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261935AbULKN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 08:56:35 -0500
Message-ID: <41BAFC43.1040708@kolivas.org>
Date: Sun, 12 Dec 2004 00:55:15 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, linux <linux-kernel@vger.kernel.org>
Subject: Re: time slice cfq comments
References: <41BA2131.4040608@kolivas.org> <20041211091617.GA22901@elte.hu>
In-Reply-To: <20041211091617.GA22901@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>Hi Jens
>>
>>Just thought I'd make a few comments about some of the code in your
>>time sliced cfq.
> 
> 
> (this code was actually a quick hack from me.)

Heh I wondered why Jens was diddling with cpu scheduler code ;)

>>+	if (p->array)
>>+		return min(cpu_curr(task_cpu(p))->time_slice,
>>+					(unsigned int)MAX_SLEEP_AVG);
>>
>>MAX_SLEEP_AVG is basically 10 * the average time_slice so this will
>>always return task_cpu(p)->time_slice as the min value (except for the
>>race you described in your comments). What you probably want is
> 
> 
> the min() is there to not get ridiculous results due to the runqueue
> race, nothing else. Basically i didnt want to lock the runqueue to do
> something that is an estimation anyway, and rq->curr might be invalid. 
> This was a proof-of-concept thing i wrote for Jens, if it works out then
> i think we want to lock the runqueue nevertheless, to not dereference
> possibly deallocated tasks (and to not trip up things like
> DEBUG_PAGEALLOC).

I understood that. I just thought that DEF_TIMESLICE would be a better 
upper bound.

>>Further down you do:
>>+	/*
>>+	 * for blocked tasks, return half of the average sleep time.
>>+	 * (because this is the average sleep-time we'll see if we
>>+	 * sample the period randomly.)
>>+	 */
>>+	return NS_TO_JIFFIES(p->sleep_avg) / 2;
>>
>>unfortunately p->sleep_avg is a non-linear value (weighted upwards 
>>towards MAX_SLEEP_AVG). I suspect here you want
>>
>>+	return NS_TO_JIFFIES(p->sleep_avg) / MAX_BONUS;
> 
> 
> sleep_avg might be nonlinear, but nevertheless it's an estimation of the
> sleep time of a task. It's different if the task is interactive. We
> cannot know how much the task really will sleep, what we want is a good
> guess. I didnt want to complicate things too much, as long as the
> ballpark figure is right. (i.e. as long as the function returns '0' for
> on-runqueue tasks, returns a large value for long sleepers and returns
> something inbetween for short/medium sleepers.) We can later on
> complicate it with things like looking at p->timestamp to figure out how 
> long it has been sleeping (and thus the ->sleep_avg is perhaps not 
> authorative anymore), but i kept it simple & stupid for now.
> 
> 
>>I don't see any need for / 2.
> 
> 
> the need for /2 is this: ->sleep_avg tells us the average _full_ sleep
> period time (roughly). The CFQ IO-scheduler is sampling the task
> _sometime_ during that period, randomly. So on average the task will
> sleep another /2 of the sleep-average. Ok?

sleep_avg accumulates over time or can be gathered all within one sleep 
period so as well as being non-linear we have the situation of not 
knowing if it gradually accumulated or sleeps for > 1 second at a time. 
I still think it needs to be divided by the number of timeslices that 
fit into MAX_SLEEP_AVG, which by design is MAX_BONUS as the likely thing 
is it accumulates over time. Either way I think we'll be way out so it 
probably wont matter since this ends up being a weighting rather than an 
accurate measure.

I don't feel strongly about these values, I just originally thought it 
was Jens' interpretation of the values.

Cheers,
Con
