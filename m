Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWBTWg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWBTWg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBTWg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:27 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:54175 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932684AbWBTWf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:35:57 -0500
Message-ID: <43FA444B.20903@bigpond.net.au>
Date: Tue, 21 Feb 2006 09:35:55 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Consolidated and improved smpnice patch
References: <43F94D71.1040109@bigpond.net.au> <200602202102.14003.kernel@kolivas.org>
In-Reply-To: <200602202102.14003.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 20 Feb 2006 22:35:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Monday 20 February 2006 16:02, Peter Williams wrote:
> [snip description]
> 
> Hi peter, I've had a good look and have just a couple of comments:
> 
> ---
>  #endif
>         int prio, static_prio;
> +#ifdef CONFIG_SMP
> +       int load_weight;        /* for load balancing purposes */
> +#endif
> ---
> 
> Can this be moved up to be part of the other ifdef CONFIG_SMP? Not highly 
> significant since it's in a .h file but looks a tiny bit nicer.

I originally put it where it is to be near prio and static_prio which 
are referenced at the same time as it BUT that doesn't happen often 
enough to justify it anymore so I guess it can be moved.

> 
> ---
> +/*
> + * Priority weight for load balancing ranges from 1/20 (nice==19) to 459/20 
> (RT
> + * priority of 100).
> + */
> +#define NICE_TO_LOAD_PRIO(nice) \
> +       ((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
> +#define LOAD_WEIGHT(lp) \
> +       (((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
> +#define NICE_TO_LOAD_WEIGHT(nice)      LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))
> +#define PRIO_TO_LOAD_WEIGHT(prio)      
> NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
> +#define RTPRIO_TO_LOAD_WEIGHT(rp) \
> +       LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
> ---
> 
> The weighting seems not related to anything in particular apart from saying 
> that -nice values are more heavily weighted.

The idea (for the change from the earlier model) was to actually give 
equal weight to negative and positive nices.  Under the old (purely 
linear) model a nice=19 task has 1/20th the weight of a nice==0 task but 
a nice==-20 task only has twice the weight of a nice==0 so that system 
is heavily weighted against negative nices.  With this new mapping a 
nice=19 has 1/20th and a nice==-19 has 20 times the weight of a nice==0 
task and to me that is symmetric.  Does that make sense to you?

Should I add a comment to explain the mapping?

> Since you only do this when 
> setting the priority of tasks can you link it to the scale of (SCHED_NORMAL) 
> tasks' timeslice instead even though that will take a fraction more 
> calculation? RTPRIO_TO_LOAD_WEIGHT is fine since there isn't any obvious cpu 
> proportion relationship to rt_prio level.

Interesting idea.  I'll look at this more closely.

> 
> Otherwise, good work, thanks!
> 
> 
>>Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> Cheers,
> Con

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
