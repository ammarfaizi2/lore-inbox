Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWA0EOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWA0EOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWA0EOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:14:03 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:58260 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751208AbWA0EOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:14:02 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Steven Rostedt <rostedt@goodmis.org>
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davids@webmaster.com, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <43D93FEA.3070305@symas.com>
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
	 <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au>
	 <43D93FEA.3070305@symas.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 23:13:52 -0500
Message-Id: <1138335232.7814.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 13:32 -0800, Howard Chu wrote:
> Nick Piggin wrote:
> > OK, you believe that the mutex *must* be granted to a blocking thread
> > at the time of the unlock. I don't think this is unreasonable from the
> > wording (because it does not seem to be completely unambiguous english),
> > however think about this -
> >
> > A realtime system with tasks A and B, A has an RT scheduling priority of
> > 1, and B is 2. A and B are both runnable, so A is running. A takes a 
> > mutex
> > then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
> > some point it drops the mutex and then tries to take it again.
> >
> > What happens?
> >
> > I haven't programmed realtime systems of any complexity, but I'd think it
> > would be undesirable if A were to block and allow B to run at this point.
> 
> But why does A take the mutex in the first place? Presumably because it 
> is about to execute a critical section. And also presumably, A will not 
> release the mutex until it no longer has anything critical to do; 
> certainly it could hold it longer if it needed to.

A while back I discovered that the -rt patch did just this with the
spin_lock to rt_mutexes. Here's the scenario that happened amazingly too
much.

Three tasks A, B, C:  A with highest  prio (say 3), B is middle (say 2)
and C is lowest (say 1).  And all this with PI (although without PI it
can happen even easier. see my explanation here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111165425915947&w=4 )

C grabs mutex X
B preempts C and tries to grab mutex X and blocks (C inherits from B)
A comes along and preempts C and blocks on X (C now inherits from A)
C lets go of mutex X and gives it to A.
A does some work then releases mutex X (B although not running aquires
it).
A needs to grab X again but B owns it. Since B has the lock, high
priority task A must give up the CPU for a lower priority task B.

I implemented a "lock stealing" for this very case and cut down
unnecessary schedules and latencies tremendously.  If A goes to grab X
again, but B has it (but hasn't woken up yet) it can "steal" it from B
and continue.

Hmm, this may still be under the POSIX if what you say is that a
"waiting" process must get the lock.  If A comes back before B wakes up,
A is now a waiting process and may take it. OK maybe I'm stretching it a
little, but that's what RT wants.

> 
> If A still needed the mutex, why release it and reacquire it, why not 
> just hold onto it? The fact that it is being released is significant.

There's several reasons.  Why hold a mutex when you don't need to. This
could be a SMP machine and B could grab the mutex in the small time that
A releases it.  Also locks are released and reaquired a lot to prevent
deadlocks.

It's good practice to always release a mutex (or any lock) when not
needed, even if you plan on grabbing it again right a way. For anything,
a higher priority process my be waiting to get it.

> 
> > Now this has nothing to do with PI or SCHED_OTHER, so behaviour is 
> > exactly
> > determined by our respective interpretations of what it means for "the
> > scheduling policy to decide which task gets the mutex".
> >
> > What have I proven? Nothing ;) but perhaps my question could be answered
> > by someone who knows a lot more about RT systems than I.
> 
> In the last RT work I did 12-13 years ago, there was only one high 
> priority producer task and it was never allowed to block. The consumers 
> just kept up as best they could (multi-proc machine of course). I've 
> seldom seen a need for many priority levels. Probably not much you can 
> generalzie from this though.

That seems to be a very simple system.  I usually deal with 4 or 5
priority levels and that can easily create headaches.

-- Steve



