Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267931AbUHETO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267931AbUHETO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUHESba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:31:30 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10142 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267842AbUHESRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:17:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:16:42 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EC08D@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR6vyjAkGGUBqY7QyGiIAGwFJzuHgAWCvKg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       <rusty@rustcorp.com.au>, <mingo@elte.hu>, <jamie@shareable.org>
X-OriginalArrivalTime: 05 Aug 2004 18:16:57.0546 (UTC) FILETIME=[64E642A0:01C47B18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ulrich Drepper [mailto:drepper@redhat.com]


> Andrew Morton wrote:
> 
> > How large is the slowdown, and on what workloads?
> 
> The fast path for all locking primitives etc in nptl today is entirely
> at userlevel.  Normally just a single atomic operation with a dozen
> other instructions.  With the fusyn stuff each and every locking
> operation needs a system call to register/unregister the thread as it
> locks/unlocks mutex/rwlocks/etc.  Go figure how well this works.  We are
> talking about making the fast path of the locking primitives
> two/three/four orders of magnitude more expensive.  And this for
> absolutely no benefit for 99.999% of all the code which uses threads.

Just for the record, Ulrich. This is not correct--there is a fast path,
and you only need to use the kernel if 

a) there is contention
b) your architecture doesn't have the atomic cmpxchg for doing the fast-path

even in b), if you want fast-path, you can use the ufuqueue calls like
you would use futexes to do a fast-path, loosing the robustness and
advanced real-time thingies [you still get the scheduling-policy based
unlock/wakeup].

If one of those (b) arches wants the robustness and stuff, it then
_needs_ to go always through the kernel [slow]. 

Of course you don't want to penalize normal users, so it is easy to 
have a simple switch in user-space that will do it one way or the 
other depending on the attributes of the mutex they select [we haven't 
coded a proof-of-concept for  this yet, but we want to do it during fall].


> > Passing the lock to a non-rt task when there's an rt-task waiting for it
> > seems pretty poor form, too.
> 
> No no, that's not what is wanted.  Robust mutexes are a special kind of
> mutex and not related to rt issues.  Lockers of robust mutexes have to
> register with the kernel (i.e., the locking must actually be performed
> by the kernel) so that in case the thread goes away or the entire

Small point here--this only happens when there are waiters in the kernel
already. If there is no contention, the locker fast-locks in user space
only using his PID [this is weak, read the paper for some solutions to
avoid PID reusage collision]. If it dies, next time somebody tries to
lock sees the user space word (vfulock) locked and goes to the kernel.
The kernel looks it up, and if the PID doesn't exist, declares the mutex
dead and assigns 'current' ownership to it, back to user space.

 
> ... This is very useful for
> normal operations where mutexes are used inter-process.  This is the
> part which is independent from rt but it also must not be the default
> mode (i.e., normal pthread_mutex_t code must not be replaced) since it
> is significantly slower.

So even in the robustness case there is fast-path. It is not significantly
slower.

> The rest of the extensions like all the priority handling is not of
> general interest.  POSIX describes how a thread's priority would be
> temporarily raised if it holds a mutex which has a higher-priority
> waiter.  But this is all functionality of a realtime profile and widely
> not part of the normal implementation.

This is not what I am hearing from embedded and enterprise guys. I just
wish they were more vocal and not expressed themselves only in private
mails--I understand you need a proof though.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
