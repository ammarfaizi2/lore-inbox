Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUIHIJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUIHIJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268933AbUIHIJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:09:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:22261 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268916AbUIHIJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:09:49 -0400
Message-Id: <200409080809.i8889ih29276@owlet.beaverton.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] schedstats additions 
In-reply-to: Your message of "Sat, 04 Sep 2004 15:07:05 +1000."
             <41394D79.40205@yahoo.com.au> 
Date: Wed, 08 Sep 2004 01:09:44 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I have a patch here to provide more useful statistics for me. Basically
    it moves a lot more of the balancing information into the domains instead
    of the runqueue, where it is nearly useless on multi-domain setups (eg.
    SMT+SMP, SMP+NUMA).
    
    It requires a version number bump, but that isn't much of an issue because
    I think we're about the only two using it at the moment. But your tools
    will need a little bit of work.
    
    What do you think?

The idea of moving some counters from runqueues to domains is fine in
general, but I've some questions about a couple of specific changes in
your patch.

    It looks to me like there are some changes in try_to_wake_up() that
	aren't schedstats related, although schedstats code is among some
	that is moved around.  Is there some code there that should be
	broken out separately?

    alb_cnt
	by moving this, we won't get an accurate look at the number of
	times we called active_load_balance and returned immediately
	because nr_running had slipped to 0 or 1.  how about we add
	another counter to count that too, and/or change the name of
	this one?

    lb_balanced
	are you sure lb_balanced[idle] can't be deduced from lb_cnt[idle]
	and lb_failed[idle]?

    ttwu_attempts
    ttwu_moved
	removing these makes it harder to determine how successful
	try_to_wake_up() was at moving a process.  What counters would
	I use to get this information if these were removed?

    ttwu_remote
    ttwu_wake_remote
	so what's the one line description of what these count now?

    smt_cnt
    sbe_cnt
	how might I see how often sched_migrate_task() and sched_exec()
	were called if these were deleted?

    lb_pulled
	Rather than add another counter here, would it be as effective
	to make pt_gained a domain counter? Looks like you're collecting
	the same information.  pt_lost would have to remain a runqueue
	counter, though, since losing a task has nothing to do with a
	particular domain.

Rick
