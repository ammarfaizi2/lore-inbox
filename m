Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUHEHjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUHEHjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHEHjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:39:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267600AbUHEHiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:38:15 -0400
Message-ID: <4111E3B5.1070608@redhat.com>
Date: Thu, 05 Aug 2004 00:37:25 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org, rusty@rustcorp.com.au, mingo@elte.hu,
       jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>	<20040804232123.3906dab6.akpm@osdl.org>	<4111DC8C.7050504@redhat.com> <20040805001737.78afb0d6.akpm@osdl.org>
In-Reply-To: <20040805001737.78afb0d6.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> How large is the slowdown, and on what workloads?

The fast path for all locking primitives etc in nptl today is entirely
at userlevel.  Normally just a single atomic operation with a dozen
other instructions.  With the fusyn stuff each and every locking
operation needs a system call to register/unregister the thread as it
locks/unlocks mutex/rwlocks/etc.  Go figure how well this works.  We are
talking about making the fast path of the locking primitives
two/three/four orders of magnitude more expensive.  And this for
absolutely no benefit for 99.999% of all the code which uses threads.


> Passing the lock to a non-rt task when there's an rt-task waiting for it
> seems pretty poor form, too.

No no, that's not what is wanted.  Robust mutexes are a special kind of
mutex and not related to rt issues.  Lockers of robust mutexes have to
register with the kernel (i.e., the locking must actually be performed
by the kernel) so that in case the thread goes away or the entire
process dies, the mutex is unlocked and other waiters (other threads, in
the same or other processes) can get the lock.  This is very useful for
normal operations where mutexes are used inter-process.  This is the
part which is independent from rt but it also must not be the default
mode (i.e., normal pthread_mutex_t code must not be replaced) since it
is significantly slower.


The rest of the extensions like all the priority handling is not of
general interest.  POSIX describes how a thread's priority would be
temporarily raised if it holds a mutex which has a higher-priority
waiter.  But this is all functionality of a realtime profile and widely
not part of the normal implementation.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
