Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUINT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUINT0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUINTZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:25:12 -0400
Received: from holomorphy.com ([207.189.100.168]:58773 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269489AbUINTVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:21:13 -0400
Date: Tue, 14 Sep 2004 12:21:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@ximian.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914192104.GB9106@holomorphy.com>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095188569.23385.11.camel@betsy.boston.ximian.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 11:52 -0700, William Lee Irwin III wrote:
>> I'd vaguely prefer to clean up the BKL (ab)users... of course, this
>> involves working with some of the dirtiest code in the kernel that's
>> already discouraged most/all of those who work on reducing/eliminating
>> BKL use from touching it... maybe the latency trend is the final nail
>> in the coffin of resistance to cleaning that up, though I agree with
>> Alan that we have to be very careful about it, particularly since all
>> prior attempts failed to be sufficiently so.

On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
> I'd love to just throw away all the BKL users, too, William.  But
> pragmatism and my cautious sense of reality tells me that the BKL is not
> going anywhere anytime soon.  We might get it down to 1% of its previous
> usage, but it is awful intertwined in some places.  It will take some
> time.

Far from "just throw away" -- this is hard work! Very hard work, and a
number of people have already tried and failed.


On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
> What I think we can do is start looking at removing the special
> properties of the BKL, or at least better containing and documenting
> them.  The BKL has a few oddities over other spin locks:
> 	- you can safely call schedule() while holding it
> 	- you can grab it recursively
> 	- you cannot use it in interrupt handlers

The "safely call schedule() while holding it" needs quite a bit of
qualification; it's implicitly dropped during voluntary context
switches and reacquired when rescheduled, but it's not valid to force
such a task into an involuntary context switch and calling schedule()
implies dropping the lock, so it has to be done at the proper times.
This is a complex semantic that likely trips up numerous callers (as
well as attempts to explain it, though surely you know these things,
and merely wanted a shorter line for the bullet point).


On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
> Getting rid of these, or at least better delineating them, will move the
> BKL closer to being just a very granular lock.
> cond_resched_bkl() is a step toward that.
> I want the BKL gone, too; I think reducing its specialness is a good way
> to achieve that.  If you can also s/BKL/some other lock/ at the same
> time, rock that.

I'd actually like to go the opposite direction from Ingo: I'd like to
remove uses of the sleeping characteristic first, as in my mind that is
the most pernicious and causes the most subtleties. Afterward, the
recursion. Except it's unclear that I have the time/etc. resources to
address it apart from taking on small pieces of whatever auditing work
or sweeps others care to devolve to me, so I'll largely be using
whatever tactic whoever cares to drive all this (probably Alan) prefers.


-- wli
