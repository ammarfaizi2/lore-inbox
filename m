Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269209AbUIIADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269209AbUIIADH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbUIHX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:59:46 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:20610 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269221AbUIHX6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:58:34 -0400
Message-ID: <413F8E38.2030308@yahoo.com.au>
Date: Thu, 09 Sep 2004 08:56:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] schedstats additions
References: <200409080809.i8889ih29276@owlet.beaverton.ibm.com>
In-Reply-To: <200409080809.i8889ih29276@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
>     I have a patch here to provide more useful statistics for me. Basically
>     it moves a lot more of the balancing information into the domains instead
>     of the runqueue, where it is nearly useless on multi-domain setups (eg.
>     SMT+SMP, SMP+NUMA).
>     
>     It requires a version number bump, but that isn't much of an issue because
>     I think we're about the only two using it at the moment. But your tools
>     will need a little bit of work.
>     
>     What do you think?
> 
> The idea of moving some counters from runqueues to domains is fine in
> general, but I've some questions about a couple of specific changes in
> your patch.
> 
>     It looks to me like there are some changes in try_to_wake_up() that
> 	aren't schedstats related, although schedstats code is among some
> 	that is moved around.  Is there some code there that should be
> 	broken out separately?
> 

There is, yes. I'll be sure to seperate it.

>     alb_cnt
> 	by moving this, we won't get an accurate look at the number of
> 	times we called active_load_balance and returned immediately
> 	because nr_running had slipped to 0 or 1.  how about we add
> 	another counter to count that too, and/or change the name of
> 	this one?
> 

OK.

>     lb_balanced
> 	are you sure lb_balanced[idle] can't be deduced from lb_cnt[idle]
> 	and lb_failed[idle]?
> 

I don't think so, because you also have the success case, which is
!balanced && !failed.

>     ttwu_attempts
>     ttwu_moved
> 	removing these makes it harder to determine how successful
> 	try_to_wake_up() was at moving a process.  What counters would
> 	I use to get this information if these were removed?
> 

ttwu_cnt in the rq stats, and ttwu_wake_affine / ttwu_wake_balance
in the domain stats.

>     ttwu_remote
>     ttwu_wake_remote
> 	so what's the one line description of what these count now?
> 

ttwu_remote/ttwu_wake_remote are the number of times a runqueue has
woken a remote task / a remote task within that domain, respectively.
Regardless of whether or not it gets pulled onto the local CPU.

>     smt_cnt
>     sbe_cnt
> 	how might I see how often sched_migrate_task() and sched_exec()
> 	were called if these were deleted?
> 

sbe_pushed should basically be the same as smt_cnt, barring rare
races with the cpus_allowed mask. I guess sbe_cnt doesn't have to
go.

>     lb_pulled
> 	Rather than add another counter here, would it be as effective
> 	to make pt_gained a domain counter? Looks like you're collecting

Yeah removing the runqueue counters for these would be good.

> 	the same information.  pt_lost would have to remain a runqueue
> 	counter, though, since losing a task has nothing to do with a
> 	particular domain.


Whatever domain that the pulling CPU was in, is also a fair candidate
for pt_lost. Remember, all the domains are per-CPU so any information
you can get from a per-runqueue counter you can also get from a domain
counter.

I'll make a few changes and give you another look. Thanks for the comments.
