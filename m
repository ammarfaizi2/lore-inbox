Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVINTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVINTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:47:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29857 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932392AbVINTrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:47:07 -0400
Date: Wed, 14 Sep 2005 12:46:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050914124642.1b19dd73.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0509141446590.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman wrote:
> I don't think a per-cpuset spinlock will be necessary ...

Arghh.  I'm still playing 'pin the tail on the donkey' guessing games
here, trying to guess what you think is necessary.

So, if a per-cpuset spinlock isn't necessary, then are you saying that
going from one global local to two global locks (where the second one
might be a spinlock) might work?  Or are you saying just the current
one global semaphore should work?  I'm guessing the former, as you can
see from my further replies below.

Could you please be a little more verbose?  Thanks.

And could you answer a couple of my previous questions, on the same
area:

Question 1:

    Roman: This means you have to take the second lock ...

    Paul: By "second lock", did you mean what you described in your
	  earlier message as:
    	  > low-level lock (maybe even a spinlock) which manages the
	  > state of an active cpuset.

    [Aside - note your phrase 'manages the state of an active cpuset'.
	It doesn't surprise me that I thought from this you had in
	mind a per-cpuset lock, not just a second global lock.]

Question 2:

    Roman: There may be a subtle problem with cpuset_fork()

    Paul: Hmmm ... interesting.  I will think about this some more.

    Roman:
    > The only (simple) solution I see is to do this:
    > 
    > 	lock();
    > 	tsk->cpuset = current->cpuset;
    > 	atomic_inc(&tsk->cpuset->count);
    > 	unlock();

    Paul: What "lock()" and "unlock()" is this?  Your "second lock",
    	  aka "low-level lock (maybe even a spinlock)" ?

Back to new comments ...

Roman wrote:
> The complete active condition is actually (atomic_read(&cs->count) || 
> !list_empty(&cs->children)). These means if any child is possibly active 
> so is the parent. 

Yes - agreed.


Roman wrote:
> Modifications in the cpuset hierarchy require the cpuset_sem and an 
> inactive cpuset, (de)activating a cpuset requires the cpuset_sem and 
> (let's call it) cpuset_tasklock.

Is this 'cpuset_tasklock' the same as the earlier 'second lock'
and the 'lock()/unlock()'?  My current guess is yes - same.

I suspect, though I haven't gotten it clear enough yet in my
mind to be confident, that something like I guess you're describing
would be sufficient to keep a cpuset from evaporating out from under
us.

And from this last comment of yours, I am guessing that 'cpuset_tasklock'
is one global lock, not per cpuset, and that the answer to my first
question above is that you are suggesting going from one global lock
to two global locks.

But I don't see what, in your proposal, ensures that it is safe to
read out the mems_allowed vector (multi-word, perhaps).  I need to
do more than make sure cpusets don't evaporate out from under me
at inopportune times.  I also need to freeze their values, so I
can do non atomic reads of multiple distinct values, or of multiword
values, out of them.  What does that?

And I am also still confused as to how this second cpuset_tasklock
works, though that might be more due to my stupidity than any lack of
clarity in your explanations.  I'll probably need a little more
tutorial there, before we're done.

I'm also inclined, if I see that it is within reach, to prefer a
per-cpuset lock, rather than just global locks.  If I could get
the locks that are required by the callbacks, such as from beneath
__alloc_pages(), to only need per-cpuset locks, then this would reduce
the risk that these turn into performance and scalability issues
someday on really large systems.  I've got a nice hierarchy to the
cpusets, so imposing the partial order on per-cpuset locks necessary
to avoid deadlock should be easy enough.


Roman wrote [modified to reinsert some ellided code - pj]:
> You're right, it should better look like this:
> 
> 	tsk->cpuset = NULL;
> 	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {
>                 char *pathbuf = NULL;
> 
>                 cpuset_down(&cpuset_sem);
>                 if (atomic_dec_and_test(&cs->count))
>                         check_for_release(cs, &pathbuf);
>                 cpuset_up(&cpuset_sem);
>                 cpuset_release_agent(pathbuf);
> 	}
> 	atomic_dec(&cs->count);
> 
> This way it only may happen that two notifaction are sent.

I don't think that works at all.  Consider the following sequence:
	1) The first 'atomic_read' returns 2
	2) [ The other task holding a reference drops out. ]
		(so count is 1 now)
	3) The atomic_dec() moves the count from 1 to 0.
	4) Oops - we just missed doing a release.

Your comment "This way it only may happen that two notifaction are
sent." went whizzing right past me ...


==> I suspect that I am actually close to understanding what you're
    suggesting, and having an informal agreement with you on what
    to do.

    When I get to that point, I will need to put this aside for a
    week, and spend more time on another task my manager needs.

    Then I should be able to return to this, and code up a polished
    version of what we agreed to, and present it for review.

Once again, thanks for you assistance.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
