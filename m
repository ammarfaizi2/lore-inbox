Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWC2JPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWC2JPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWC2JPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:15:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35279 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750818AbWC2JO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:14:59 -0500
Date: Wed, 29 Mar 2006 11:12:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 06/10] PI-futex: rt-mutex docs
Message-ID: <20060329091216.GA1542@elte.hu>
References: <20060325184620.GG16724@elte.hu> <44299BE5.6040308@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44299BE5.6040308@am.sony.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_95 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	3.0 BAYES_95               BODY: Bayesian spam probability is 95 to 99%
	[score: 0.9850]
	-0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Bird <tim.bird@am.sony.com> wrote:

> Some minor nits.

thanks, i've updated the documentation with these fixes - and i also 
rewrote and extended the whole Documentation/rtmutex.txt text and added 
an additional Documentation/pi-futex.txt explanation. Find the updated 
patch below.  Can you see more problems in the updated text?

	Ingo

--------
Subject: rt-mutex docs
From: Ingo Molnar <mingo@elte.hu>

add rt-mutex documentation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Spelling fixes from Tim Bird <tim.bird@am.sony.com>

----

 Documentation/pi-futex.txt       |  121 +++++++++++++++++++++++++++++++++++++++
 Documentation/robust-futexes.txt |    2 
 Documentation/rt-mutex.txt       |   74 +++++++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)

Index: linux/Documentation/pi-futex.txt
===================================================================
--- /dev/null
+++ linux/Documentation/pi-futex.txt
@@ -0,0 +1,121 @@
+Lightweight PI-futexes
+----------------------
+
+We are calling them lightweight for 3 reasons:
+
+ - in the user-space fastpath a PI-enabled futex involves no kernel work
+   (or any other PI complexity) at all. No registration, no extra kernel
+   calls - just pure fast atomic ops in userspace.
+
+ - even in the slowpath, the system call and scheduling pattern is very
+   similar to normal futexes.
+
+ - the in-kernel PI implementation is streamlined around the mutex
+   abstraction, with strict rules that keep the implementation
+   relatively simple: only a single owner may own a lock (i.e. no
+   read-write lock support), only the owner may unlock a lock, no
+   recursive locking, etc.
+
+Priority Inheritance - why?
+---------------------------
+
+The short reply: user-space PI helps achieving/improving determinism for
+user-space applications. In the best-case, it can help achieve
+determinism and well-bound latencies. Even in the worst-case, PI will
+improve the statistical distribution of locking related application
+delays.
+
+The longer reply:
+-----------------
+
+Firstly, sharing locks between multiple tasks is a common programming
+technique that often cannot be replaced with lockless algorithms. As we
+can see it in the kernel [which is a quite complex program in itself],
+lockless structures are rather the exception than the norm - the current
+ratio of lockless vs. locky code for shared data structures is somewhere
+between 1:10 and 1:100. Lockless is hard, and the complexity of lockless
+algorithms often endangers to ability to do robust reviews of said code.
+I.e. critical RT apps often choose lock structures to protect critical
+data structures, instead of lockless algorithms. Furthermore, there are
+cases (like shared hardware, or other resource limits) where lockless
+access is mathematically impossible.
+
+Media players (such as Jack) are an example of reasonable application
+design with multiple tasks (with multiple priority levels) sharing
+short-held locks: for example, a highprio audio playback thread is
+combined with medium-prio construct-audio-data threads and low-prio
+display-colory-stuff threads. Add video and decoding to the mix and
+we've got even more priority levels.
+
+So once we accept that synchronization objects (locks) are an
+unavoidable fact of life, and once we accept that multi-task userspace
+apps have a very fair expectation of being able to use locks, we've got
+to think about how to offer the option of a deterministic locking
+implementation to user-space.
+
+Most of the technical counter-arguments against doing priority
+inheritance only apply to kernel-space locks. But user-space locks are
+different, there we cannot disable interrupts or make the task
+non-preemptible in a critical section, so the 'use spinlocks' argument
+does not apply (user-space spinlocks have the same priority inversion
+problems as other user-space locking constructs). Fact is, pretty much
+the only technique that currently enables good determinism for userspace
+locks (such as futex-based pthread mutexes) is priority inheritance:
+
+Currently (without PI), if a high-prio and a low-prio task shares a lock
+[this is a quite common scenario for most non-trivial RT applications],
+even if all critical sections are coded carefully to be deterministic
+(i.e. all critical sections are short in duration and only execute a
+limited number of instructions), the kernel cannot guarantee any
+deterministic execution of the high-prio task: any medium-priority task
+could preempt the low-prio task while it holds the shared lock and
+executes the critical section, and could delay it indefinitely.
+
+Implementation:
+---------------
+
+As mentioned before, the userspace fastpath of PI-enabled pthread
+mutexes involves no kernel work at all - they behave quite similarly to
+normal futex-based locks: a 0 value means unlocked, and a value==TID
+means locked. (This is the same method as used by list-based robust
+futexes.) Userspace uses atomic ops to lock/unlock these mutexes without
+entering the kernel.
+
+To handle the slowpath, we have added two new futex ops:
+
+  FUTEX_LOCK_PI
+  FUTEX_UNLOCK_PI
+
+If the lock-acquire fastpath fails, [i.e. an atomic transition from 0 to
+TID fails], then FUTEX_LOCK_PI is called. The kernel does all the
+remaining work: if there is no futex-queue attached to the futex address
+yet then the code looks up the task that owns the futex [it has put its
+own TID into the futex value], and attaches a 'PI state' structure to
+the futex-queue. The pi_state includes an rt-mutex, which is a PI-aware,
+kernel-based synchronization object. The 'other' task is made the owner
+of the rt-mutex, and the FUTEX_WAITERS bit is atomically set in the
+futex value. Then this task tries to lock the rt-mutex, on which it
+blocks. Once it returns, it has the mutex acquired, and it sets the
+futex value to its own TID and returns. Userspace has no other work to
+perform - it now owns the lock, and futex value contains
+FUTEX_WAITERS|TID.
+
+If the unlock side fastpath succeeds, [i.e. userspace manages to do a
+TID -> 0 atomic transition of the futex value], then no kernel work is
+triggered.
+
+If the unlock fastpath fails (because the FUTEX_WAITERS bit is set),
+then FUTEX_UNLOCK_PI is called, and the kernel unlocks the futex on the
+behalf of userspace - and it also unlocks the attached
+pi_state->rt_mutex and thus wakes up any potential waiters.
+
+Note that under this approach, contrary to previous PI-futex approaches,
+there is no prior 'registration' of a PI-futex. [which is not quite
+possible anyway, due to existing ABI properties of pthread mutexes.]
+
+Also, under this scheme, 'robustness' and 'PI' are two orthogonal
+properties of futexes, and all four combinations are possible: futex,
+robust-futex, PI-futex, robust+PI-futex.
+
+More details about priority inheritance can be found in
+Documentation/rtmutex.txt.
Index: linux/Documentation/robust-futexes.txt
===================================================================
--- linux.orig/Documentation/robust-futexes.txt
+++ linux/Documentation/robust-futexes.txt
@@ -95,7 +95,7 @@ comparison. If the thread has registered
 is empty. If the thread/process crashed or terminated in some incorrect
 way then the list might be non-empty: in this case the kernel carefully
 walks the list [not trusting it], and marks all locks that are owned by
-this thread with the FUTEX_OWNER_DEAD bit, and wakes up one waiter (if
+this thread with the FUTEX_OWNER_DIED bit, and wakes up one waiter (if
 any).
 
 The list is guaranteed to be private and per-thread at do_exit() time,
Index: linux/Documentation/rt-mutex.txt
===================================================================
--- /dev/null
+++ linux/Documentation/rt-mutex.txt
@@ -0,0 +1,74 @@
+RT-mutex subsystem with PI support
+----------------------------------
+
+RT-mutexes with priority inheritance are used to support PI-futexes,
+which enable pthread_mutex_t priority inheritance attributes
+(PTHREAD_PRIO_INHERIT). [See Documentation/pi-futex.txt for more details
+about PI-futexes.]
+
+This technology was developed in the -rt tree and streamlined for
+pthread_mutex support.
+
+Basic principles:
+-----------------
+
+RT-mutexes extend the semantics of simple mutexes by the priority
+inheritance protocol.
+
+A low priority owner of a rt-mutex inherits the priority of a higher
+priority waiter until the rt-mutex is released. If the temporarily
+boosted owner blocks on a rt-mutex itself it propagates the priority
+boosting to the owner of the other rt_mutex it gets blocked on. The
+priority boosting is immediately removed once the rt_mutex has been
+unlocked.
+
+This approach allows us to shorten the block of high-prio tasks on
+mutexes which protect shared resources. Priority inheritance is not a
+magic bullet for poorly designed applications, but it allows
+well-designed applications to use userspace locks in critical parts of
+an high priority thread, without losing determinism.
+
+The enqueueing of the waiters into the rtmutex waiter list is done in
+priority order. For same priorities FIFO order is chosen. For each
+rtmutex, only the top priority waiter is enqueued into the owner's
+priority waiters list. This list too queues in priority order. Whenever
+the top priority waiter of a task changes (for example it timed out or
+got a signal), the priority of the owner task is readjusted. [The
+priority enqueueing is handled by "plists", see include/linux/plist.h
+for more details.]
+
+RT-mutexes are optimized for fastpath operations and have no internal
+locking overhead when locking an uncontended mutex or unlocking a mutex
+without waiters. The optimized fastpath operations require cmpxchg
+support. [If that is not available then the rt-mutex internal spinlock
+is used]
+
+The state of the rt-mutex is tracked via the owner field of the rt-mutex
+structure:
+
+rt_mutex->owner holds the task_struct pointer of the owner. Bit 0 and 1
+are used to keep track of the "owner is pending" and "rtmutex has
+waiters" state.
+
+ owner		bit1	bit0
+ NULL		0	0	mutex is free (fast acquire possible)
+ NULL		0	1	invalid state
+ NULL		1	0	invalid state
+ NULL		1	1	invalid state
+ taskpointer	0	0	mutex is held (fast release possible)
+ taskpointer	0	1	task is pending owner
+ taskpointer	1	0	mutex is held and has waiters
+ taskpointer	1	1	task is pending owner and mutex has waiters
+
+Pending-ownership handling is a performance optimization:
+pending-ownership is assigned to the first (highest priority) waiter of
+the mutex, when the mutex is released. The thread is woken up and once
+it starts executing it can acquire the mutex. Until the mutex is taken
+by it (bit 0 is cleared) a competing higher priority thread can "steal"
+the mutex which puts the woken up thread back on the waiters list.
+
+The pending-ownership optimization is especially important for the
+uninterrupted workflow of high-prio tasks which repeatedly
+takes/releases locks that have lower-prio waiters. Without this
+optimization the higher-prio thread would ping-pong to the lower-prio
+task [because at unlock time we always assign a new owner].
