Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbULKJQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbULKJQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 04:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbULKJQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 04:16:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34484 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261921AbULKJQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 04:16:27 -0500
Date: Sat, 11 Dec 2004 10:16:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Jens Axboe <axboe@suse.de>, linux <linux-kernel@vger.kernel.org>
Subject: Re: time slice cfq comments
Message-ID: <20041211091617.GA22901@elte.hu>
References: <41BA2131.4040608@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA2131.4040608@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Hi Jens
> 
> Just thought I'd make a few comments about some of the code in your
> time sliced cfq.

(this code was actually a quick hack from me.)

> +	if (p->array)
> +		return min(cpu_curr(task_cpu(p))->time_slice,
> +					(unsigned int)MAX_SLEEP_AVG);
> 
> MAX_SLEEP_AVG is basically 10 * the average time_slice so this will
> always return task_cpu(p)->time_slice as the min value (except for the
> race you described in your comments). What you probably want is

the min() is there to not get ridiculous results due to the runqueue
race, nothing else. Basically i didnt want to lock the runqueue to do
something that is an estimation anyway, and rq->curr might be invalid. 
This was a proof-of-concept thing i wrote for Jens, if it works out then
i think we want to lock the runqueue nevertheless, to not dereference
possibly deallocated tasks (and to not trip up things like
DEBUG_PAGEALLOC).

> Further down you do:
> +	/*
> +	 * for blocked tasks, return half of the average sleep time.
> +	 * (because this is the average sleep-time we'll see if we
> +	 * sample the period randomly.)
> +	 */
> +	return NS_TO_JIFFIES(p->sleep_avg) / 2;
> 
> unfortunately p->sleep_avg is a non-linear value (weighted upwards 
> towards MAX_SLEEP_AVG). I suspect here you want
> 
> +	return NS_TO_JIFFIES(p->sleep_avg) / MAX_BONUS;

sleep_avg might be nonlinear, but nevertheless it's an estimation of the
sleep time of a task. It's different if the task is interactive. We
cannot know how much the task really will sleep, what we want is a good
guess. I didnt want to complicate things too much, as long as the
ballpark figure is right. (i.e. as long as the function returns '0' for
on-runqueue tasks, returns a large value for long sleepers and returns
something inbetween for short/medium sleepers.) We can later on
complicate it with things like looking at p->timestamp to figure out how 
long it has been sleeping (and thus the ->sleep_avg is perhaps not 
authorative anymore), but i kept it simple & stupid for now.

> I don't see any need for / 2.

the need for /2 is this: ->sleep_avg tells us the average _full_ sleep
period time (roughly). The CFQ IO-scheduler is sampling the task
_sometime_ during that period, randomly. So on average the task will
sleep another /2 of the sleep-average. Ok?

	Ingo
