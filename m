Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272541AbTHSSE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272607AbTHSSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:00:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20745
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272435AbTHSRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:51:09 -0400
Date: Tue, 19 Aug 2003 10:51:05 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030819175105.GA19465@matchmail.com>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	Eric St-Laurent <ericstl34@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F419449.4070104@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 01:06:49PM +1000, Nick Piggin wrote:
> Its done this way because this is really how the priorities are
> enforced. With some complicated exceptions, every task will be
> allowed to complete 1 timeslice before any task completes 2
> (assuming they don't block).
> 
> So higher priority tasks need bigger timeslices.
> 
> >
> >also, i think dynamic priority should be used for timeslice calculation
> >instead of static priority. the reason is, if a low priority task get a
> >priority boost (to prevent starvation, for example) it should use the
> >small timeslice corresponding to it's new priority level, instead of
> >using it's original large timeslice that can ruin the interactive feel.
> >
> 
> Among other things, yes, I think this is a good idea too. I'll be
> addressing both these issues in my scheduler fork.
> 
> I do have dynamic timeslices, but currently high priority tasks
> still get big timeslices.

TS = Time Slice

What needs to be changed is the 1TS per pass through the active array
concept. 

Devide the time slice into smaller Time Units, so that you can add one unit
per priority level.

TU = Time Units

Then you account these TUs instead of slices.

so, if nice -19 has 1 TU, and nice -19 has 40 TUs (maybe ranging from 1ms -
200ms with a TU of 5ms).

So nice -19 can have a long time slice and run until it expires if it
doesn't get preempted.

The more I think this through, the harder it gets to take this concept to
completion, but the basic idea is to have multiple TSes per slice, and to
account on TSes as well as slices.  That way, you have longer slices for
nicer tasks, but I'm not sure how it would fit into the two array scheduler
we have now.  You'd have to have another list for the processes that are
have used up their slice, but haven't waited long enough for them to get
another slice (because you want to give more total CPU percentage to the
higher priorities, while still giving them smaller slices).

Anyway, if anyone can take this idea and make it into a working scheduler,
I'd be most interested in the results...
