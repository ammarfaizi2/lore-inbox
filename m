Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCQN0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCQN0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWCQN0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:26:22 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:28530 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750731AbWCQN0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:26:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=B/gu358sUUV6Dj05bqVwogcGjD+Q3H1A/oAJm52Cew9gFjoGfbL0TIZk6IZ40HAeSRYdy+axWKflLr6iq4iaTsu+XVkEpzprjLiKNTWg3NP1lWoeQjP6bCai2jByojHMKqHyUOFm+3qyyaWus97DmZi2QmEzGWgpoQdNZv59Ay4=  ;
Message-ID: <441AB8FA.10609@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:26:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
References: <200603081013.44678.kernel@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <200603172338.10107.kernel@kolivas.org>
In-Reply-To: <200603172338.10107.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> 
> Ok here's a patch that does exactly that. Without an "inline" hint, gcc 4.1.0
> chooses not to inline this function. I can't say I have a strong opinion
> about whether it should be inlined or not (93 bytes larger inlined), so I've
> decided not to given the current trend.
> 

Sigh, sacrifice for the common case! :P


> Index: linux-2.6.16-rc6-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-13 20:12:15.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-17 23:08:12.000000000 +1100
> @@ -737,9 +737,12 @@ static inline void dec_nr_running(task_t
>  /*
>   * __activate_task - move a task to the runqueue.
>   */
> -static inline void __activate_task(task_t *p, runqueue_t *rq)
> +static void __activate_task(task_t *p, runqueue_t *rq)
>  {
> -	enqueue_task(p, rq->active);
> +	if (batch_task(p))
> +		enqueue_task(p, rq->expired);
> +	else
> +		enqueue_task(p, rq->active);
>  	inc_nr_running(p, rq);
>  }
>  

I prefer:

   prio_array_t *target = rq->active;
   if (batch_task(p))
     target = rq->expired;
   enqueue_task(p, target);

Because gcc can use things like predicated instructions for it.
But perhaps it is smart enough these days to recognise this?
At least in the past I have seen it start using cmov after doing
such a conversion.

At any rate, I think it looks nicer as well. IMO, of course.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
