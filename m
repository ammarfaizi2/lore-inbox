Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTERJ3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTERJ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:29:00 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:60062 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261845AbTERJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:28:57 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org,
       monnier+gnu/emacs@rum.cs.yale.edu
Subject: Re: Scheduling problem with 2.4?
References: <20030517235048.GB1429@dualathlon.random>
	<MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
	<20030518010621.GC1429@dualathlon.random>
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 18 May 2003 11:41:32 +0200
In-Reply-To: <20030518010621.GC1429@dualathlon.random>
Message-ID: <x5fznc4mnn.fsf@lola.goethe.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sat, May 17, 2003 at 05:16:33PM -0700, David Schwartz wrote:
> > 
> > 	This is the danger of pre-emption based upon dynamic
> > priorities. You can get cases where two processes each are
> > permitted to make a very small amount of progress in
> > alternation. This can happen just as well with large writes as
> > small ones, the amount of data is irrelevent, it's the amount of
> > CPU time that's important, or to put it another way, it's how far
> > a process can get without suffering a context switch.
> > 
> > 	I suggest that a process be permitted to use up at least some
> > portion of its timeslice exempt from any pre-emption based solely
> > on dynamic priorities.
> 
> that's the issue yes. but then when a multithreaded app sends a
> signal to another process it can take up to this "x" timeslice
> portion before the signal will run (I mean in UP). Same goes for
> mouse clicks etc..  1msec for mouse clicks should not be noticeable
> though. And over all I don't see a real big issue in the current
> code.

Well, the problem that we have is excessive synchronous context
switching, so the solution might be to simply throttle on that.  It's
no problem the first few times round, but after some time the
scheduler should recognize the pattern and clamp down.  So I'd propose
that we give a process that yields synchronously while it could be
ready to run an accumulating priority boost that gets wasted pretty
fast when the process does a full wait (aka the pipe is full) or is
preempted.

That is, have the scheduler penalize/throttle application-visible
context switches between runnable processes.  On particular if the
processes are dependent on one another, like in the case of the pipe.
We can proud ourselves to optimize the kernel to make a context switch
in 1us, but if each context switch occurs 2ms of avoidable overhead in
our application, the bottom line to the user will remain ugly.

> To try it probably the simpler way to add a need_resched_timeout
> along to need_resched, and to honour the need_resched only when the
> timeout triggers, immediate need_resched will set the timeout = jiffies
> so it'll trigger immediatly, the timer interrupt will check it. The
> reschedule_idle on a non idle cpu will be the only one to set the
> timeout. Effectively I'm curious to see what will happen. Not all archs
> would need to check against it (the entry.S code is the main reader of
> need_resched), it'll be an hint only and idle() for sure must not check
> it at all. this would guarantee minimal timeslice reserved up to 1/HZ by
> setting the timeout to jiffies + 2 (jiffies + 1 would return a mean of
> 1/HZ/2 but the worst case would be ~0, in practice even + 1 would be
> enough) Does anybody think this could have a value? If yes I can make a
> quick hack to see what happens.

We probably need not immediate action.  A good test case is an xterm,
I guess, and I noticed that od has an option for limiting its length.

So I propose that comparing the output of

time od -vN 100k /dev/zero

to that of

time od -vN 100k /dev/zero|dd obs=16k

in an xterm should provide some idea about _typical_ overhead occured
in an _application_ due to excessive context switching.

If you want to get really nasty, you can compare to
time od -vN 100k /dev/zero|dd obs=1

Note that in all of these cases, it is by far the xterm that is
wasting the lion's share of the processing time (and so you need to
take a look at the _real_ time expended, since xterm will not be
measured in the time command), the kernel people and the generating
processes will wash their hands off any guilt: "_we_ do our work
efficiently and give xterm all the time of the world to be able to
empty the pipe, and let it take all the time it needs to without
pushing it".  Only that xterm could work much more efficiently if one
pushed it by piling things into the pipe.

Another silly exercise is the following:

time od -v /dev/zero|dd obs=1

in an xterm.  Keep it running.  Now in a different term, enter

while true;do :;done

The above xterm will freeze while the interactive shell still has its
bonus, and then will start working again, at a much higher speed than
when it has an idle CPU at its disposal.

Kill off the busy loop, and the xterm gets slow again.

Come to think of it, I have witnessed the phenomenon of "slow start
xterms" that get ragingly more efficient after several screenfulls
when they _can't_ keep up on a busy system for years on a large
variety of Unices with single CPU.  It is some of those quirks one
does not think about too much.

So I repeat: I should think a fast accumulating scheduling malus for a
synchronous context switch to a process woken by an event from a still
runnable process should be appropriate.  If anybody can think of a
scheme that magically converges to a good tradeoff between average
fill level of a pipe and estimated processing overhead by the
application at the receiving end, of course this would be appreciated.

The aim would be that running an additional

  while true;do :;done

should not usually be able to speed up the _real_ time performance of
an unrelated task.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
