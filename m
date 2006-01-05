Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWAEJrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWAEJrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWAEJrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:47:21 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:34948 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750768AbWAEJrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:47:21 -0500
Date: Thu, 5 Jan 2006 10:43:26 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: david singleton <dsingleton@mvista.com>
cc: dino@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
Subject: Re: Recursion bug in -rt
In-Reply-To: <10843D42-7D91-11DA-AC71-000A959BB91E@mvista.com>
Message-ID: <Pine.LNX.4.44L0.0601051008010.24043-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jan 2006, david singleton wrote:

> Dinakar,
> 	I've got a more complete patch for deadlock detection for robust
> futexes.
>
> 	The patch is at
> http://source.mvista.com/~dsingleton/patch-2.6.15-rc7-rt3-rf2
>
> 	This patch handles pthread_mutex deadlocks in two ways:
>
> 1) POSIX states that non-recursive pthread_mutexes hang if locked twice.
> This patch hangs the deadlocking thread on a waitqueue.  It releases
> all other kernel locks, like the mmap_sem and robust_sem before waiting
> on the waitqueue so as not to hang the kernel.
>
> 2) pthread_mutexes that are only robust, not PRIO_INHERIT,  do not
> hang.  They have a new error code returned to them,  -EWOULDDEADLOCK.
> Since there is no POSIX specification for robust pthread_mutexes yet,
> returning EWOULDDEADLOCK to a robust mutex is more in the spirit
> of robustness.  For robust pthread_mutexes we clean up if the holding
> thread dies and we return EWOULDDEADLOCK to inform the
> application that it is trying to deadlock itself.
>
> 	The patch handles both simple and circular deadlocks.  This is
> something I've been wanting to do for a while, export deadlock
> detection to all flavors of kernels.   The patch provides the correct
> deadlock behavior while not hanging the system.


Have you tested this on SMP - without CONFIG_DEBUG_DEADLOCKS? As far as I
can see check_futex_deadlock() can easily crash the system as there are
_no_ spinlocks protecting access to task->blocked_on,
task->blocked_on->lock etc. As far as I can see the tasks and locks
structures can be freed at any point while you are in
check_futex_deadlock().

Furthermore, check_futex_deadlock is recursive. You can easily from
userspace trick the system into a kernel stack overflow by making a many
nested  futexes.

I am working on a new way to do priority inheritance for nested locks in
rt_mutex such you do not risc deadlocking the system on raw-spinlocks
when you have a rt_mutex deadlock. But it wont have deadlock detection without
CONFIG_DEBUG_DEADLOCKS. On the other hand it would be possible to make a
deadlock scanner finding deadlocks in the system after they have happened.
With a suitable /proc interface it could even be done in userspace.

My patch to the rt_mutex is far from finished. I haven't even compiled a
kernel with it yet. I spend the little time I have between my
family goes to bed and I simply have to go to bed myself writing a
unittest framework for the  rt_mutex and have both the original and the
patched rt_mutex parsing all my tests. But I need more tests to hammer
out the details about task->state forinstance. If anyone is interrested I
would be happy to send what I got right now.

Esben

>
> 	It's also easier to see if a POSIX compliant app has deadlocked itself.
> the 'ps' command will show that the wait channel of a deadlocked
> application is waiting at 'futex_deadlock'.
>
> 	Let me know if it passes all your tests.
>
> David
>
>
>
>
> On Dec 20, 2005, at 7:50 AM, Dinakar Guniguntala wrote:
>
> > On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
> >>
> >> hm, i'm looking at -rf4 - these changes look fishy:
> >>
> >> -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> >> +       if (current != lock_owner(lock)->task)
> >> +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> >>
> >> why is this done?
> >>
> >
> > Ingo, this is to prevent a kernel hang due to application error.
> >
> > Basically when an application does a pthread_mutex_lock twice on a
> > _nonrecursive_ mutex with robust/PI attributes the whole system hangs.
> > Ofcourse the application clearly should not be doing anything like
> > that, but it should not end up hanging the system either
> >
> > 	-Dinakar
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

