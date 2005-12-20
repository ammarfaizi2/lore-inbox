Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVLTWnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVLTWnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLTWng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:43:36 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:34475 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750738AbVLTWnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:43:35 -0500
Date: Tue, 20 Dec 2005 23:43:04 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
Subject: Re: Recursion bug in -rt
In-Reply-To: <1135113617.13138.383.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10512202311480.1720-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Steven Rostedt wrote:

> On Tue, 2005-12-20 at 21:42 +0100, Esben Nielsen wrote:
> 
> > > 
> > This is ok for kernel mutexes, which are supposed not to cause deadlocks.
> > But user space deadlocks must not cause kernel deadlocks. Therefore the
> > robust futex code _must_ be fixed.
> 
> And it should be fixed in the futex side. Not in rt.c.
> 
> > 
> > > The benefit of this locking order is that we got rid of the global
> > > pi_lock, and that was worth the problems you face today.
> > >
> > 
> > I believe this problem can be solved in the pi_lock code - but it will
> > require quite a bit of recoding. I started on it a little while ago but
> > didn't at all get the time to get into anything to even compile :-(
> > I don't have time to finish any code at all but I guess I can plant an
> > the idea instead:
> 
> I removed the global pi_lock in two sleepless days, and it was all on
> the theory that the locks themselves would not deadlock.  That was the
> only sanity I was able to hang on to.  That was complex enough, and very
> scary to get right (scary since it _had_ to be done right). 
Gosh I wish I had such nights available.... :-( And then some equipment to
test the result on.

> And it was
> complex enough to keep a highly skilled programmer living in Hungary
> from doing it himself (not to say he couldn't do it, just complex enough
> for him to put it off for quite some time).  
My guess is that he focuses on other areas. The global pi_lock worked - it
just didn't scale.

> And one must also worry
> about the BKL which is a separate beast all together.

The BKL is the scary point from my point of view. The rest of it is really
not very Linux specific and is really just elaborating the textbook
implementations of mutexes.

> 
> So making it any more complex is IMO out of the question.

Well the lock grabbing was making it very complex, too :-)

> 
> > 
> > When resolving the mutex chain (task A locks mutex 1 owned by B blocked
> > on 2 owned by C etc) for PI boosting and also when finding deadlocks,
> > release _all_ locks before going to the next step in the chain. Use
> > get_task_struct on the next task in the chain, release the locks,
> > take the pi_locks in a fixed order (sort by address forinstance), do the
> > PI boosting, get_task_struct on the next lock, release all the locks, do
> > the put_task_struct() on the previous task etc.
> > This a lot more expensive approach as it involves double as many spinlock
> > operations and get/put_task_struct() calls , but it has the added benifit
> > of reducing the overall system latency for long locking chains as there
> > are spots where interrupts and preemption will be enabled for each step in
> > the chain. Remember also that deep locking chains should be considered an
> > exeption so the code doesn't have to be optimal wrt. performance. 
> 
> The long lock holding is only by the lock being grabbed and the owner
> grabbing it.  All other locks don't need to be held for long periods of
> time.  

Preemption is disabled all along because you always hold at least one
spinlock.

> There's lots of issues if you release these two locks. How do you
> deal with the mutex being released while going up the chain?
> 

You have to recheck your conditions again once you have retaken the
necesary locks. I do that in the code below.

> > 
> > I added my feeble attempts to implement this below. I have no chance of
> > ever getting time finish it :-(
> 
> I doubt they were feeble, but just proof that this approach is far too
> complex.  As I said, if you don't want futex to deadlock the kernel, the
> API for futex should have deadlocking checks, since the only way this
> can deadlock the system, is if two threads are in the kernel at the same
> time.

That that code needs to traverse the locks. The PI code need to traverse
the locks. It would be simpler to do it in one go... Ofcourse, all
robust futex calls could take one global mutex akin to the old pi_lock you
removed, to fix it now, but that is a hack.

> 
> Also, the ones who are paying me to help out the -rt kernel, don't care
> if we let the user side deadlock the system.  They deliver a complete
> package, kernel and user apps, and nothing else is to be running on the
> system.  This means that if the user app deadlocks, it doesn't matter if
> the kernel deadlocks or not, because the deadlocking of the user app
> means the system has failed.  And I have a feeling that a lot of other
> users of -rt feel the same way.

1) If PREEMPT_RT ever goes into the main line kernel this kind of aproach
will _not_ work. 
2) A for me  for using Linux 2.6-rt over some specialized RTOS would be
that I could have my RT task running without any risk of being destroyed
by even buggy normal tasks. 
What if you run, say apache, compiled with robust futexes and it
deadlocks? Normally I would simply restart apache. Customers could easily
accept that I restart apache once in a while - they wouldn't even notice.
But they can't accept that the system should reboot.

Esben

> 
> -- Steve
> 
> 


