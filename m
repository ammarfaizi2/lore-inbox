Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVLTW5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVLTW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLTW5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:57:24 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:23212 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932151AbVLTW5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:57:23 -0500
Date: Tue, 20 Dec 2005 23:56:57 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: david singleton <dsingleton@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Recursion bug in -rt
In-Reply-To: <50B4645E-71A3-11DA-8A59-000A959BB91E@mvista.com>
Message-Id: <Pine.OSF.4.05.10512202344470.1720-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, david singleton wrote:

> 
> On Dec 20, 2005, at 1:20 PM, Steven Rostedt wrote:
> 
> > On Tue, 2005-12-20 at 21:42 +0100, Esben Nielsen wrote:
> >
> >>>
> >> This is ok for kernel mutexes, which are supposed not to cause 
> >> deadlocks.
> >> But user space deadlocks must not cause kernel deadlocks. Therefore 
> >> the
> >> robust futex code _must_ be fixed.
> >
> > And it should be fixed in the futex side. Not in rt.c.
> 
> Yes.  I believe you are right about this.   The bad news is POSIX 
> specifies
> that an app that calls lock_mutex twice on the same mutex hangs.
> EINVAL or EWOULDBLOCK are not POSIX compliant.
> 
> Let me think on this a while and see if I can come up with an idea that
> will let the app hang itself (and be POSIX compliant) and not hang the
> kernel.
> 
> Perhaps I'll just detect it and hang them on a waitqueue waiting
> for the user to get impatient and hit control C . . . .
> 

The same lock taken twice is just a special case of deadlocking. It would
be very hard to check for the general case in the futex code without
"fixing" the rt_mutex. Not that the rt_mutex code is broken - it just
doesn't handle deadlocks very well as it wasn't supposed to. But as the
futex indirectly exposes the rt_mutex to userspace it becomes a problem.

The only _hack_ I can see is to force all robust futex calls to go through
one global lock to prevent the futex deadlocks becomming rt_mutex 
deadlocks which again can turn into spin-lock deadlocks.

I instead argue for altering the premisses for the rt_mutex such
they can handle deadlocks without turning them into spin-lock deadlocks
blocking the whole system. Then a futex deadlock will become a rt_mutex
deadlock which can be handled.

Esben

> 
> 
> David
> 
> >
> >>
> >>> The benefit of this locking order is that we got rid of the global
> >>> pi_lock, and that was worth the problems you face today.
> >>>
> >>
> >> I believe this problem can be solved in the pi_lock code - but it will
> >> require quite a bit of recoding. I started on it a little while ago 
> >> but
> >> didn't at all get the time to get into anything to even compile :-(
> >> I don't have time to finish any code at all but I guess I can plant an
> >> the idea instead:
> >
> > I removed the global pi_lock in two sleepless days, and it was all on
> > the theory that the locks themselves would not deadlock.  That was the
> > only sanity I was able to hang on to.  That was complex enough, and 
> > very
> > scary to get right (scary since it _had_ to be done right).  And it was
> > complex enough to keep a highly skilled programmer living in Hungary
> > from doing it himself (not to say he couldn't do it, just complex 
> > enough
> > for him to put it off for quite some time).  And one must also worry
> > about the BKL which is a separate beast all together.
> >
> > So making it any more complex is IMO out of the question.
> >
> >>
> >> When resolving the mutex chain (task A locks mutex 1 owned by B 
> >> blocked
> >> on 2 owned by C etc) for PI boosting and also when finding deadlocks,
> >> release _all_ locks before going to the next step in the chain. Use
> >> get_task_struct on the next task in the chain, release the locks,
> >> take the pi_locks in a fixed order (sort by address forinstance), do 
> >> the
> >> PI boosting, get_task_struct on the next lock, release all the locks, 
> >> do
> >> the put_task_struct() on the previous task etc.
> >> This a lot more expensive approach as it involves double as many 
> >> spinlock
> >> operations and get/put_task_struct() calls , but it has the added 
> >> benifit
> >> of reducing the overall system latency for long locking chains as 
> >> there
> >> are spots where interrupts and preemption will be enabled for each 
> >> step in
> >> the chain. Remember also that deep locking chains should be 
> >> considered an
> >> exeption so the code doesn't have to be optimal wrt. performance.
> >
> > The long lock holding is only by the lock being grabbed and the owner
> > grabbing it.  All other locks don't need to be held for long periods of
> > time.  There's lots of issues if you release these two locks. How do 
> > you
> > deal with the mutex being released while going up the chain?
> >
> >>
> >> I added my feeble attempts to implement this below. I have no chance 
> >> of
> >> ever getting time finish it :-(
> >
> > I doubt they were feeble, but just proof that this approach is far too
> > complex.  As I said, if you don't want futex to deadlock the kernel, 
> > the
> > API for futex should have deadlocking checks, since the only way this
> > can deadlock the system, is if two threads are in the kernel at the 
> > same
> > time.
> >
> > Also, the ones who are paying me to help out the -rt kernel, don't care
> > if we let the user side deadlock the system.  They deliver a complete
> > package, kernel and user apps, and nothing else is to be running on the
> > system.  This means that if the user app deadlocks, it doesn't matter 
> > if
> > the kernel deadlocks or not, because the deadlocking of the user app
> > means the system has failed.  And I have a feeling that a lot of other
> > users of -rt feel the same way.
> >
> > -- Steve
> >
> >
> > _______________________________________________
> > robustmutexes mailing list
> > robustmutexes@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/robustmutexes
> 

