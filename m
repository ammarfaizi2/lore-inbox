Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317634AbSGJVkF>; Wed, 10 Jul 2002 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317635AbSGJVkE>; Wed, 10 Jul 2002 17:40:04 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15652 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317634AbSGJVkD>; Wed, 10 Jul 2002 17:40:03 -0400
Date: Wed, 10 Jul 2002 23:41:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       Andrew Morton <akpm@zip.com.au>, bob <bob@watson.ibm.com>,
       linux-kernel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
       mjbligh@linux.ibm.com, John Levon <moz@compsoc.man.ac.uk>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
Message-ID: <20020710214157.GD1342@dualathlon.random>
References: <OFF41DACAC.FEED90BA-ON80256BF2.004DC147@portsmouth.uk.ibm.com> <3D2C9972.BB3DA772@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2C9972.BB3DA772@opersys.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 04:30:42PM -0400, Karim Yaghmour wrote:
> 
> Richard J Moore wrote:
> > Some level of tracing (along with other complementary PD tools e.g. crash
> > dump) needs to be readiliy available to deal with those types of problem we
> > see with mature systems employed in the production environment. Typically
> > such problems are not readily recreatable nor even prictable. I've often
> > had to solve problems which impact a business environment severely, where
> > one server out of 2000 gets hit each day, but its a different one each day.
> > Its under those circumstances that trace along without other automated data
> > capturing problem determination tools become invaluable. And its a fact of
> > life that only those types of difficult problem remain once we've beaten a
> > system to death in developments and test. Being able to use a common set of
> > tools whatever the componets under investigation greatly eases problem
> > determination. This is especially so where you have the ability to use
> > dprobes with LTT to provide ad hoc tracepoints that were not originally
> > included by the developers.
> 
> I definitely agree.
> 
> One case which perfectly illustrates how extreme these situations can be is
> the Mars Pathfinder. The folks at the Jet Propulsion Lab used a tracing tool
> very similar to LTT to locate the priority inversion problem the Pathfinder
> had while it was on Mars.

btw, on the topic, with our semaphores there's no way to handle priority
inversion with SCHED_RR tasks, if there's more than one task that runs
in RT priority we may fall into starvation of RT tasks too the same way.

No starvation can happen of course if all tasks in the systems belongs
to the same scheduler policy (nice levels can have effects but they're
not indefinite delays).

The fix Ingo used for SCHED_IDLE is to have a special call to the
scheduler while returning to userspace, so in the only place where we
know the kernel isn't holding any lock. But while it's going to only
generate some minor unexpected cpu load with SCHED_IDLE, generalizing
that hack to make all tasks scheduling inside the kernel running with RT
priority isn't going to provide a nice/fair behaviour (some task infact could
run way too much if it's very system-hungry, in particular with
-preempt, which could again generate starvation of userspace, even if
not anymore because of kernel locks). Maybe I'm overlooking something
simple but I guess it's not going to be easy to fix it, for the
semaphores it isn't too bad, they could learn how to raise priority of a
special holder when needed, but for any semaphore-by-hand (for example
spinlock based) it would require some major auditing.

Andrea
