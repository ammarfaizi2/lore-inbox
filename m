Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTHaXaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTHaXaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:30:52 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11277
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263050AbTHaXau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:30:50 -0400
Subject: Re: [SHED] Questions.
From: Robert Love <rml@tech9.net>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062369684.9959.166.camel@big.pomac.com>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
	 <1062369684.9959.166.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1062373274.1313.28.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 19:41:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 18:41, Ian Kumlien wrote:

> hummm, I assume that a high pri process can preempt a low pri process...
> The rest sounds sane to me =), Please tell me what i'm missing.. =)

No no.  The rule is "the highest priority process with timeslice
remaining runs" not just "the highest priority process runs."

Otherwise, timeslice wouldn't matter much!

When a process exhausts its timeslice, it is moved to the "expired"
list.  When all currently running tasks expire their timeslice, the
scheduler begins servicing from the "expired" list (which then becomes
the "active" list, and the old active list becomes the expired).

This implies that a high priority, which has exhausted its timeslice,
will not be allowed to run again until _all_ other runnable tasks
exhaust their timeslice (this ignores the reinsertion into the active
array of interactive tasks, but that is an optimization that just
complicates this discussion).

If timeslices did not play a role, then high priority tasks would always
monopolize the system.

This is a classic priority-based round-robin scheduler.

> > Once a task exhausts its timeslice, it cannot run until all other tasks
> > exhaust their timeslice.  If this were not the case, high priority tasks
> > could monopolize the system.
> 
> All other? including sleeping?... How many tasks can be assumed to run
> on the cpu at a time?....

I wasn't clear: all other _runnable_ tasks.

Once a task "expires" (exhausts its timeslice), it will not run again
until all other tasks, even those of a lower priority, exhaust their
timeslice.

This is a major difference between normal tasks and real-time tasks.

> Should preempt send the new quantum value to all "low pri, high quantum"
> processes?

I don't follow this?

> Damn thats a tough cookie, i still think that the priority inversion is
> bad. Don't know enough about this to actually provide a solution... 
> Any one else that has a view point?

Priority inversion is bad, but the priority inversion in this case is
intended.  Higher priority tasks cannot starve lower ones.  It is a
classic Unix philosophy that 'all tasks make some forward progress'

If you need to guarantee that a task always runs when runnable, you want
real-time.

If you just want to give a scheduling boost, to ensure greater
runnability, lower latency, and larger timeslices... nice values
suffice.

> Hummm, the skips in xmms tells me that something is bad.. 
> (esp since it works perfectly on the previus scheduler)

A lot of this is just the interactivity estimator making the wrong
estimate.

> Since it's rescheduled after a short runtime or, might be.
> From someones mail i saw (afair), there was much more context switches
> in 2.6 than in 2.4. And each schedule consumes time and cycles.

Context switches (as in process to process changes) should be about the
same?

Interrupt frequency has gone up in x86 (1000 vs 100).  Maybe that is
what they are seeing.

> Oh yes, but otoh, if you are really keen on the latency then you'll do
> realtime =)

Agreed.  But at the same time, not every "interactive" task should be
real-time.  In fact, nearly all should not.  I do not want my text
editor or mailer to be RT, for example.

They just need a scheduling boost.

	Robert Love


