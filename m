Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUKPHAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUKPHAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUKPHAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:00:39 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:25767 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261921AbUKPHAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:00:32 -0500
Message-Id: <200411160700.iAG70pbu018464@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: colpatch@us.ibm.com, Darren Hart <dvhltc@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] scheduler: rebalance_tick interval update 
In-reply-to: Your message of "Tue, 16 Nov 2004 13:17:55 +1100."
             <41996353.1060604@cyberone.com.au> 
Date: Mon, 15 Nov 2004 23:00:51 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Yes, but if you balance n ticks since the last _rebalance_, then things will
    be able to drift. Let's say 2 CPUs, they balance at 10 jiffies intervals,
    5 jiffies apart:

[example deleted]

First, why wasn't the rebalance run when it was supposed to be run?

The answer isn't really all that important.  Regardless of the answer,
if this can happen once, I presume it can happen more than once.  Despite
our best efforts, rebalancing ran in the "wrong timeslot". Aside from the
CPU_OFFSET math, it would seem to me that this inexplicable delay, itself,
introduces enough variance to make any hope of keeping the cpus strictly
unsynchronized (!!) something of a pipe dream.  We start them out of sync, and
know that they'll drift.  We can correct them, but they'll drift again.
Why not just acknowledge that behavior, instead of putting effort into
(unsuccessfully) countering it?

Second, it's of marginal usefulness anyway when you consider that
rebalance_tick() is only called with HZ granularity, except for
unpredictable times from fork().  You're going to be doubling up no matter
what you do once you get more than 16 siblings (see SD_SIBLING_INIT:
busy_factor * max_interval).

Lastly, why do we care?  To turn the question around, were we seeing load
balancing colliding without this attempt at forced spacing?  And if so,
what was the effect (and patterns) of those collisions?  Having a variable
named last_balance which represents when we last *would have liked to
have* balanced seems far less useful than knowing when we really did.

Rick
