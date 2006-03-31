Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWCaTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWCaTRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCaTR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:17:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24293 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751432AbWCaTR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:17:27 -0500
Date: Fri, 31 Mar 2006 21:14:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] PI-futex patchset: -V4
Message-ID: <20060331191445.GA2250@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu> <20060326231638.GA18395@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326231638.GA18395@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is version -V4 of the PI-futex patchset (ontop of current -mm2, 
which includes -V3.)

A clean queue of split-up patches can be found at:

  http://redhat.com/~mingo/PI-futex-patches/PI-futex-patches-V4.tar.gz

the -V4 codebase has been tested on the glibc code (all testcases pass) 
and under load as well. (The -V4 code is included in the 2.6.16-rt12 
code as well that i released earlier today.)

Changes since -V3:

 - added Esben Nielsen's PI locking code, Thomas Gleixner made it
   work in cornercases and under load. This is significantly simpler (it 
   removes 50 lines of code from rtmutex.c). The main difference is that 
   instead of holding all locks along a dependency chain, this code 
   propagates PI priorities (and detects deadlocks) by holding at most 
   two locks at once, and by being preemptible between such steps.

 - Jakub Jelinek did a detailed review of the new futex code and found
   some new races, which Thomas Gleixner fixed.

 - to fix a pthread_mutex_trylock() related race, FUTEX_TRYLOCK_PI has 
   been added (Thomas Gleixner)

 - documentation fixes based on feedback from Tim Bird

 - added Documentation/pi-futex.txt (in addition to rt-mutex.txt)

 - added the plist debugging patch (which was part of -rt but wasnt part
   of the pi-futex queue before). This caught a couple of SMP bugs in 
   the past.

 - implemented more scalable held-locks debugging - it's now a per-task 
   list of held locks, instead of a global list. This is similarly 
   effective to the global list, but much more scalable. (This approach 
   will also be added to the stock kernel/mutex.c code.)

 - do not fiddle with irq flags in rtmutex.c - it's not needed.

 - clone/fork fix: do not let parent's potential PI priority 'leak' into 
   child threads or processes.

 - added /proc/sys/kernel/max_lock_depth with a default limit of 1024, 
   to limit the amount of deadlock-checking the kernel will do.

 - small enhancement to the t3-l1-pi-signal.tst testcase.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--

 Documentation/rtmutex.txt                                 |   60 -
 linux-pi-futex.mm.q/Documentation/pi-futex.txt            |  121 +++
 linux-pi-futex.mm.q/Documentation/robust-futexes.txt      |    2 
 linux-pi-futex.mm.q/Documentation/rt-mutex.txt            |   74 +
 linux-pi-futex.mm.q/include/linux/futex.h                 |    1 
 linux-pi-futex.mm.q/include/linux/rtmutex.h               |   16 
 linux-pi-futex.mm.q/include/linux/sched.h                 |    9 
 linux-pi-futex.mm.q/include/linux/sysctl.h                |    1 
 linux-pi-futex.mm.q/kernel/fork.c                         |    8 
 linux-pi-futex.mm.q/kernel/futex.c                        |   88 +-
 linux-pi-futex.mm.q/kernel/rtmutex-debug.c                |  186 ++--
 linux-pi-futex.mm.q/kernel/rtmutex-debug.h                |    9 
 linux-pi-futex.mm.q/kernel/rtmutex.c                      |  560 +++++---------
 linux-pi-futex.mm.q/kernel/rtmutex.h                      |    3 
 linux-pi-futex.mm.q/kernel/sched.c                        |    8 
 linux-pi-futex.mm.q/kernel/sysctl.c                       |   15 
 linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-signal.tst |    3 
 17 files changed, 631 insertions(+), 533 deletions(-)

Index: linux-pi-futex.mm.q/Documentation/pi-futex.txt
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/Documentation/pi-futex.txt
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
Index: linux-pi-futex.mm.q/Documentation/robust-futexes.txt
===================================================================
--- linux-pi-futex.mm.q.orig/Documentation/robust-futexes.txt
+++ linux-pi-futex.mm.q/Documentation/robust-futexes.txt
@@ -95,7 +95,7 @@ comparison. If the thread has registered
 is empty. If the thread/process crashed or terminated in some incorrect
 way then the list might be non-empty: in this case the kernel carefully
 walks the list [not trusting it], and marks all locks that are owned by
-this thread with the FUTEX_OWNER_DEAD bit, and wakes up one waiter (if
+this thread with the FUTEX_OWNER_DIED bit, and wakes up one waiter (if
 any).
 
 The list is guaranteed to be private and per-thread at do_exit() time,
Index: linux-pi-futex.mm.q/Documentation/rt-mutex.txt
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/Documentation/rt-mutex.txt
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
Index: linux-pi-futex.mm.q/Documentation/rtmutex.txt
===================================================================
--- linux-pi-futex.mm.q.orig/Documentation/rtmutex.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-RT Mutex Subsystem with PI support
-
-RT Mutexes with priority inheritance are used to support pthread_mutexes
-with priority inheritance attributes.
-
-The basic technology was developed in the preempt-rt tree and
-streamlined for the pthread_mutex support.
-
-RT Mutexes extend the semantics of Mutexes by the priority inheritance
-protocol. Sharing code and data structures with the Mutex code is not
-feasible due to the extended requirements of RT Mutexes.
-
-Basic operation principle:
-
-A low priority owner of a rt_mutex inherits the priority of a higher
-priority waiter until the mutex is released. Is the temporary priority
-boosted owner blocked on a rt_mutex itself it propagates the priority
-boosting to the owner of the rt_mutex it is blocked on. The priority
-boosting is immidiately removed once the rt_mutex has been unlocked.
-This technology allows to shorten the blocking on mutexes which
-protect shared resources. Priority inheritance is not a magic bullet
-for poorly designed applications, but allows optimizations in cases
-where the protection of shared resources might affect critical parts
-of an high priority thread.
-
-The enqueueing of the waiters into the rtmutex waiter list is done in
-priority order. In case of the same priority FIFO order is chosen. Per
-rtmutex only the top priority waiter is enqueued into the owners
-priority waiters list. Also this list enqueues in priority
-order. Whenever the top priority waiter of a task is changed the
-priority of the task is readjusted. The priority enqueueing is handled
-by plists, see also include/linux/plist.h for further explanation.
-
-RT Mutexes are optimized for fastpath operations and have no runtime
-overhead in case of locking an uncontended mutex or unlocking a mutex
-without waiters. The optimized fathpath operations require cmpxchg
-support.
-
-The state of the rtmutex is tracked via the owner field of the
-rt_mutex structure:
-
-rt_mutex->owner holds the task_struct pointer of the owner. Bit 0 and
-1 are used to keep track of the "owner is pending" and "rtmutex has
-waiters" state.
-
-owner		bit1	bit0
-NULL		0	0	mutex is free (fast acquire possible)
-NULL		0	1	invalid state
-NULL		1	0	invalid state
-NULL		1	1	invalid state
-taskpointer	0	0	mutex is held (fast release possible)
-taskpointer	0	1	task is pending owner
-taskpointer	1	0	mutex is held and has waiters
-taskpointer	1	1	task is pending owner and mutex has more waiters
-
-Pending ownership is assigned to the first (highest priority) waiter
-of the mutex, when the mutex is released. The thread is woken up and
-can now acquire the mutex. Until the mutex is taken (bit 0 cleared) a
-competing higher priority thread can steal the mutex which puts the
-woken up thread back on the waiters list.
Index: linux-pi-futex.mm.q/include/linux/futex.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/futex.h
+++ linux-pi-futex.mm.q/include/linux/futex.h
@@ -14,6 +14,7 @@
 #define FUTEX_WAKE_OP		5
 #define FUTEX_LOCK_PI		6
 #define FUTEX_UNLOCK_PI		7
+#define FUTEX_TRYLOCK_PI	8
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
Index: linux-pi-futex.mm.q/include/linux/rtmutex.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/rtmutex.h
+++ linux-pi-futex.mm.q/include/linux/rtmutex.h
@@ -29,7 +29,7 @@ struct rt_mutex {
 	struct task_struct	*owner;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 	int			save_state;
-	struct list_head	held_list;
+	struct list_head	held_list_entry;
 	unsigned long		acquire_ip;
 	const char 		*name, *file;
 	int			line;
@@ -66,7 +66,7 @@ struct hrtimer_sleeper;
 
 #define __RT_MUTEX_INITIALIZER(mutexname) \
 	{ .wait_lock = SPIN_LOCK_UNLOCKED \
-	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list) \
+	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list, mutexname.wait_lock) \
 	, .owner = NULL \
 	__DEBUG_RT_MUTEX_INITIALIZER(mutexname)}
 
@@ -98,11 +98,19 @@ extern int rt_mutex_trylock(struct rt_mu
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
 
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# define INIT_RT_MUTEX_DEBUG(tsk)					\
+	.held_list_head	= LIST_HEAD_INIT(tsk.held_list_head),		\
+	.held_list_lock	= SPIN_LOCK_UNLOCKED
+#else
+# define INIT_RT_MUTEX_DEBUG(tsk)
+#endif
+
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
-	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters),		\
+	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
-	.pi_lock_chain	= LIST_HEAD_INIT(tsk.pi_lock_chain),
+	INIT_RT_MUTEX_DEBUG(tsk)
 #else
 # define INIT_RT_MUTEXES(tsk)
 #endif
Index: linux-pi-futex.mm.q/include/linux/sched.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sched.h
+++ linux-pi-futex.mm.q/include/linux/sched.h
@@ -865,9 +865,10 @@ struct task_struct {
 	struct plist_head pi_waiters;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
-	/* PI locking helpers */
-	struct task_struct *pi_locked_by;
-	struct list_head pi_lock_chain;
+# ifdef CONFIG_DEBUG_RT_MUTEXES
+	spinlock_t held_list_lock;
+	struct list_head held_list_head;
+# endif
 #endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -984,7 +985,7 @@ static inline void put_task_struct(struc
 #define PF_SPREAD_PAGE	0x04000000	/* Spread page cache over cpuset */
 #define PF_SPREAD_SLAB	0x08000000	/* Spread some slab caches over cpuset */
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
-#define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
+#define PF_MUTEX_TESTER	0x02000000	/* Thread belongs to the rt mutex tester */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-pi-futex.mm.q/include/linux/sysctl.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sysctl.h
+++ linux-pi-futex.mm.q/include/linux/sysctl.h
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_MAX_LOCK_DEPTH=73
 };
 
 
Index: linux-pi-futex.mm.q/kernel/fork.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/fork.c
+++ linux-pi-futex.mm.q/kernel/fork.c
@@ -926,10 +926,12 @@ static inline void rt_mutex_init_task(st
 {
 #ifdef CONFIG_RT_MUTEXES
 	spin_lock_init(&p->pi_lock);
-	plist_head_init(&p->pi_waiters);
+	plist_head_init(&p->pi_waiters, &p->pi_lock);
 	p->pi_blocked_on = NULL;
-	p->pi_locked_by = NULL;
-	INIT_LIST_HEAD(&p->pi_lock_chain);
+# ifdef CONFIG_DEBUG_RT_MUTEXES
+	spin_lock_init(&p->held_list_lock);
+	INIT_LIST_HEAD(&p->held_list_head);
+# endif
 #endif
 }
 
Index: linux-pi-futex.mm.q/kernel/futex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/futex.c
+++ linux-pi-futex.mm.q/kernel/futex.c
@@ -480,6 +480,7 @@ lookup_pi_state(u32 uval, struct futex_h
 			return 0;
 		}
 	}
+
 	/*
 	 * We are the first waiter - try to look up the real owner and
 	 * attach the new pi_state to it:
@@ -930,9 +931,7 @@ static int unqueue_me(struct futex_q *q)
 		WARN_ON(list_empty(&q->list));
 		list_del(&q->list);
 
-		if (q->pi_state)
-			free_pi_state(q->pi_state);
-		q->pi_state = NULL;
+		BUG_ON(q->pi_state);
 
 		spin_unlock(lock_ptr);
 		ret = 1;
@@ -942,6 +941,24 @@ static int unqueue_me(struct futex_q *q)
 	return ret;
 }
 
+/*
+ * PI futexes can not be requeued and must remove themself from the
+ * hash bucket. The hash bucket lock is held on entry and dropped here.
+ */
+static void unqueue_me_pi(struct futex_q *q, struct futex_hash_bucket *hb)
+{
+	WARN_ON(list_empty(&q->list));
+	list_del(&q->list);
+
+	BUG_ON(!q->pi_state);
+	free_pi_state(q->pi_state);
+	q->pi_state = NULL;
+
+	spin_unlock(&hb->lock);
+
+	drop_key_refs(&q->key);
+}
+
 static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
 {
 	struct task_struct *curr = current;
@@ -1062,7 +1079,7 @@ static int futex_wait(u32 __user *uaddr,
  * races the kernel might see a 0 value of the futex too.)
  */
 static int futex_lock_pi(u32 __user *uaddr, int detect,
-			 unsigned long sec, long nsec)
+			 unsigned long sec, long nsec, int trylock)
 {
 	struct task_struct *curr = current;
 	struct futex_hash_bucket *hb;
@@ -1138,8 +1155,32 @@ static int futex_lock_pi(u32 __user *uad
 	 * we are the first waiter):
 	 */
 	ret = lookup_pi_state(uval, hb, &q);
-	if (unlikely(ret))
+
+	if (unlikely(ret)) {
+		/*
+		 * There were no waiters and the owner task lookup
+		 * failed. When the OWNER_DIED bit is set, then we
+		 * know that this is a robust futex and we actually
+		 * take the lock. This is safe as we are protected by
+		 * the hash bucket lock.
+		 */
+		if (curval & FUTEX_OWNER_DIED) {
+			uval = newval;
+			newval = current->pid | FUTEX_OWNER_DIED;
+
+			inc_preempt_count();
+			curval = futex_atomic_cmpxchg_inatomic(uaddr,
+							       uval, newval);
+			dec_preempt_count();
+
+			if (unlikely(curval == -EFAULT))
+				goto uaddr_faulted;
+			if (unlikely(curval != uval))
+				goto retry_locked;
+			ret = 0;
+		}
 		goto out_unlock_release_sem;
+	}
 
 	/*
 	 * Only actually queue now that the atomic ops are done:
@@ -1156,7 +1197,16 @@ static int futex_lock_pi(u32 __user *uad
 	/*
 	 * Block on the PI mutex:
 	 */
-	ret = rt_mutex_timed_lock(&q.pi_state->pi_mutex, to, 1);
+	if (!trylock)
+		ret = rt_mutex_timed_lock(&q.pi_state->pi_mutex, to, 1);
+	else {
+		ret = rt_mutex_trylock(&q.pi_state->pi_mutex);
+		/* Fixup the trylock return value: */
+		ret = ret ? 0 : -EWOULDBLOCK;
+	}
+
+	down_read(&curr->mm->mmap_sem);
+	hb = queue_lock(&q, -1, NULL);
 
 	/*
 	 * Got the lock. We might not be the anticipated owner if we
@@ -1165,9 +1215,6 @@ static int futex_lock_pi(u32 __user *uad
 	if (!ret && q.pi_state->owner != curr) {
 		u32 newtid = current->pid | FUTEX_WAITERS;
 
-		down_read(&curr->mm->mmap_sem);
-		hb = queue_lock(&q, -1, NULL);
-
 		/* Owner died? */
 		if (q.pi_state->owner != NULL) {
 			spin_lock(&q.pi_state->owner->pi_lock);
@@ -1182,7 +1229,8 @@ static int futex_lock_pi(u32 __user *uad
 		list_add(&q.pi_state->list, &current->pi_state_list);
 		spin_unlock(&current->pi_lock);
 
-		queue_unlock(&q, hb);
+		/* Unqueue and drop the lock */
+		unqueue_me_pi(&q, hb);
 		up_read(&curr->mm->mmap_sem);
 		/*
 		 * We own it, so we have to replace the pending owner
@@ -1200,10 +1248,21 @@ static int futex_lock_pi(u32 __user *uad
 				break;
 			uval = curval;
 		}
+	} else {
+		/*
+		 * Catch the rare case, where the lock was released
+		 * when we were on the way back before we locked
+		 * the hash bucket.
+		 */
+		if (ret && q.pi_state->owner == curr) {
+			if (rt_mutex_trylock(&q.pi_state->pi_mutex))
+				ret = 0;
+		}
+		/* Unqueue and drop the lock */
+		unqueue_me_pi(&q, hb);
+		up_read(&curr->mm->mmap_sem);
 	}
 
-	unqueue_me(&q);
-
 	if (!detect && ret == -EDEADLK && 0)
 		force_sig(SIGKILL, current);
 
@@ -1652,11 +1711,14 @@ long do_futex(u32 __user *uaddr, int op,
 		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
 		break;
 	case FUTEX_LOCK_PI:
-		ret = futex_lock_pi(uaddr, val, timeout, val2);
+		ret = futex_lock_pi(uaddr, val, timeout, val2, 0);
 		break;
 	case FUTEX_UNLOCK_PI:
 		ret = futex_unlock_pi(uaddr);
 		break;
+	case FUTEX_TRYLOCK_PI:
+		ret = futex_lock_pi(uaddr, 0, timeout, val2, 1);
+		break;
 	default:
 		ret = -ENOSYS;
 	}
Index: linux-pi-futex.mm.q/kernel/rtmutex-debug.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex-debug.c
+++ linux-pi-futex.mm.q/kernel/rtmutex-debug.c
@@ -45,7 +45,8 @@ do {								\
 		console_verbose();				\
 		if (spin_is_locked(&current->pi_lock))		\
 			spin_unlock(&current->pi_lock);		\
-		spin_unlock(&tracelock);			\
+		if (spin_is_locked(&current->held_list_lock))	\
+			spin_unlock(&current->held_list_lock);	\
 	}							\
 } while (0)
 
@@ -83,14 +84,6 @@ do {						\
 # define SMP_TRACE_BUG_ON_LOCKED(c)	do { } while (0)
 #endif
 
-
-/*
- * We need a global lock when we walk through the multi-process
- * lock tree...
- */
-static spinlock_t tracelock = SPIN_LOCK_UNLOCKED;
-static LIST_HEAD(held_locks);
-
 /*
  * deadlock detection flag. We turn it off when we detect
  * the first problem because we dont want to recurse back
@@ -183,7 +176,7 @@ static void show_task_locks(task_t *p)
 		printk(" (not blocked)\n");
 }
 
-void rt_mutex_show_held_locks(task_t *filter)
+void rt_mutex_show_held_locks(task_t *task, int verbose)
 {
 	struct list_head *curr, *cursor = NULL;
 	struct rt_mutex *lock;
@@ -194,41 +187,32 @@ void rt_mutex_show_held_locks(task_t *fi
 	if (!rt_trace_on)
 		return;
 
-	if (filter) {
+	if (verbose) {
 		printk("------------------------------\n");
 		printk("| showing all locks held by: |  (");
-		printk_task_short(filter);
+		printk_task_short(task);
 		printk("):\n");
 		printk("------------------------------\n");
-	} else {
-		printk("---------------------------\n");
-		printk("| showing all locks held: |\n");
-		printk("---------------------------\n");
 	}
 
-	/*
-	 * Play safe and acquire the global trace lock. We
-	 * cannot printk with that lock held so we iterate
-	 * very carefully:
-	 */
 next:
-	spin_lock_irqsave(&tracelock, flags);
-	list_for_each(curr, &held_locks) {
+	spin_lock_irqsave(&task->held_list_lock, flags);
+	list_for_each(curr, &task->held_list_head) {
 		if (cursor && curr != cursor)
 			continue;
-		lock = list_entry(curr, struct rt_mutex, held_list);
+		lock = list_entry(curr, struct rt_mutex, held_list_entry);
 		t = rt_mutex_owner(lock);
-		if (filter && (t != filter))
-			continue;
+		WARN_ON(t != task);
 		count++;
 		cursor = curr->next;
-		spin_unlock_irqrestore(&tracelock, flags);
+		spin_unlock_irqrestore(&task->held_list_lock, flags);
 
 		printk("\n#%03d:            ", count);
-		printk_lock(lock, filter ? 0 : 1);
+		printk_lock(lock, 0);
 		goto next;
 	}
-	spin_unlock_irqrestore(&tracelock, flags);
+	spin_unlock_irqrestore(&task->held_list_lock, flags);
+
 	printk("\n");
 }
 
@@ -238,7 +222,10 @@ void rt_mutex_show_all_locks(void)
 	int count = 10;
 	int unlock = 1;
 
-	printk("\nshowing all tasks:\n");
+	printk("\n");
+	printk("----------------------\n");
+	printk("| showing all tasks: |\n");
+	printk("----------------------\n");
 
 	/*
 	 * Here we try to get the tasklist_lock as hard as possible,
@@ -270,7 +257,19 @@ retry:
 	} while_each_thread(g, p);
 
 	printk("\n");
-	rt_mutex_show_held_locks(NULL);
+
+	printk("-----------------------------------------\n");
+	printk("| showing all locks held in the system: |\n");
+	printk("-----------------------------------------\n");
+
+	do_each_thread(g, p) {
+		rt_mutex_show_held_locks(p, 0);
+		if (!unlock)
+			if (read_trylock(&tasklist_lock))
+				unlock = 1;
+	} while_each_thread(g, p);
+
+
 	printk("=============================================\n\n");
 
 	if (unlock)
@@ -279,10 +278,9 @@ retry:
 
 void rt_mutex_debug_check_no_locks_held(task_t *task)
 {
-	struct list_head *curr, *next, *cursor = NULL;
-	struct rt_mutex *lock;
 	struct rt_mutex_waiter *w;
-	unsigned long flags;
+	struct list_head *curr;
+	struct rt_mutex *lock;
 
 	if (!rt_trace_on)
 		return;
@@ -291,25 +289,9 @@ void rt_mutex_debug_check_no_locks_held(
 		printk_task(task);
 		printk("\n");
 	}
-restart:
-	spin_lock_irqsave(&tracelock, flags);
-	list_for_each_safe(curr, next, &held_locks) {
-		if (cursor && curr != cursor)
-			continue;
-		lock = list_entry(curr, struct rt_mutex, held_list);
-		if(task != rt_mutex_owner(lock))
-			continue;
-		cursor = next;
-		list_del_init(curr);
-		spin_unlock_irqrestore(&tracelock, flags);
+	if (list_empty(&task->held_list_head))
+		return;
 
-		printk("BUG: %s/%d, lock held at task exit time!\n",
-		       task->comm, task->pid);
-		printk_lock(lock, 1);
-		if (rt_mutex_owner(lock) != task)
-			printk("exiting task is not even the owner??\n");
-		goto restart;
-	}
 	spin_lock(&task->pi_lock);
 	plist_for_each_entry(w, &task->pi_waiters, pi_list_entry) {
 		TRACE_OFF();
@@ -320,33 +302,36 @@ restart:
 		return;
 	}
 	spin_unlock(&task->pi_lock);
-	spin_unlock_irqrestore(&tracelock, flags);
+
+	list_for_each(curr, &task->held_list_head) {
+		lock = list_entry(curr, struct rt_mutex, held_list_entry);
+
+		printk("BUG: %s/%d, lock held at task exit time!\n",
+		       task->comm, task->pid);
+		printk_lock(lock, 1);
+		if (rt_mutex_owner(lock) != task)
+			printk("exiting task is not even the owner??\n");
+	}
 }
 
 int rt_mutex_debug_check_no_locks_freed(const void *from, unsigned long len)
 {
-	struct list_head *curr, *next, *cursor = NULL;
 	const void *to = from + len;
+	struct list_head *curr;
 	struct rt_mutex *lock;
 	unsigned long flags;
 	void *lock_addr;
-	int err = 0;
 
 	if (!rt_trace_on)
-		return err;
-restart:
-	spin_lock_irqsave(&tracelock, flags);
-	list_for_each_safe(curr, next, &held_locks) {
-		if (cursor && curr != cursor)
-			continue;
-		lock = list_entry(curr, struct rt_mutex, held_list);
+		return 0;
+
+	spin_lock_irqsave(&current->held_list_lock, flags);
+	list_for_each(curr, &current->held_list_head) {
+		lock = list_entry(curr, struct rt_mutex, held_list_entry);
 		lock_addr = lock;
 		if (lock_addr < from || lock_addr >= to)
 			continue;
-		cursor = next;
-		list_del_init(curr);
 		TRACE_OFF();
-		err = 1;
 
 		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
 			current->comm, current->pid, lock, from, to);
@@ -354,19 +339,17 @@ restart:
 		printk_lock(lock, 1);
 		if (rt_mutex_owner(lock) != current)
 			printk("freeing task is not even the owner??\n");
-		goto restart;
+		return 1;
 	}
-	spin_unlock_irqrestore(&tracelock, flags);
+	spin_unlock_irqrestore(&current->held_list_lock, flags);
 
-	return err;
+	return 0;
 }
 
-void rt_mutex_debug_task_free(struct task_struct *tsk)
+void rt_mutex_debug_task_free(struct task_struct *task)
 {
-	WARN_ON(!plist_head_empty(&tsk->pi_waiters));
-	WARN_ON(!list_empty(&tsk->pi_lock_chain));
-	WARN_ON(tsk->pi_blocked_on);
-	WARN_ON(tsk->pi_locked_by);
+	WARN_ON(!plist_head_empty(&task->pi_waiters));
+	WARN_ON(task->pi_blocked_on);
 }
 
 /*
@@ -383,9 +366,10 @@ void debug_rt_mutex_deadlock(int detect,
 		return;
 
 	task = rt_mutex_owner(act_waiter->lock);
-
-	act_waiter->deadlock_task_pid = task->pid;
-	act_waiter->deadlock_lock = lock;
+	if (task && task != current) {
+		act_waiter->deadlock_task_pid = task->pid;
+		act_waiter->deadlock_lock = lock;
+	}
 }
 
 void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
@@ -417,8 +401,8 @@ void debug_rt_mutex_print_deadlock(struc
 	printk("\n2) %s/%d is blocked on this lock:\n", task->comm, task->pid);
 	printk_lock(waiter->deadlock_lock, 1);
 
-	rt_mutex_show_held_locks(current);
-	rt_mutex_show_held_locks(task);
+	rt_mutex_show_held_locks(current, 1);
+	rt_mutex_show_held_locks(task, 1);
 
 	printk("\n%s/%d's [blocked] stackdump:\n\n", task->comm, task->pid);
 	show_stack(task, NULL);
@@ -436,11 +420,11 @@ void debug_rt_mutex_lock(struct rt_mutex
 	unsigned long flags;
 
 	if (rt_trace_on) {
-		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list));
+		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list_entry));
 
-		spin_lock_irqsave(&tracelock, flags);
-		list_add_tail(&lock->held_list, &held_locks);
-		spin_unlock_irqrestore(&tracelock, flags);
+		spin_lock_irqsave(&current->held_list_lock, flags);
+		list_add_tail(&lock->held_list_entry, &current->held_list_head);
+		spin_unlock_irqrestore(&current->held_list_lock, flags);
 
 		lock->acquire_ip = ip;
 	}
@@ -452,11 +436,27 @@ void debug_rt_mutex_unlock(struct rt_mut
 
 	if (rt_trace_on) {
 		TRACE_WARN_ON_LOCKED(rt_mutex_owner(lock) != current);
-		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list));
+		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list_entry));
 
-		spin_lock_irqsave(&tracelock, flags);
-		list_del_init(&lock->held_list);
-		spin_unlock_irqrestore(&tracelock, flags);
+		spin_lock_irqsave(&current->held_list_lock, flags);
+		list_del_init(&lock->held_list_entry);
+		spin_unlock_irqrestore(&current->held_list_lock, flags);
+	}
+}
+
+void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
+			       struct task_struct *powner __IP_DECL__)
+{
+	unsigned long flags;
+
+	if (rt_trace_on) {
+		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list_entry));
+
+		spin_lock_irqsave(&powner->held_list_lock, flags);
+		list_add_tail(&lock->held_list_entry, &powner->held_list_head);
+		spin_unlock_irqrestore(&powner->held_list_lock, flags);
+
+		lock->acquire_ip = ip;
 	}
 }
 
@@ -465,12 +465,14 @@ void debug_rt_mutex_proxy_unlock(struct 
 	unsigned long flags;
 
 	if (rt_trace_on) {
-		TRACE_WARN_ON_LOCKED(!rt_mutex_owner(lock));
-		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list));
+		struct task_struct *owner = rt_mutex_owner(lock);
+
+		TRACE_WARN_ON_LOCKED(!owner);
+		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list_entry));
 
-		spin_lock_irqsave(&tracelock, flags);
-		list_del_init(&lock->held_list);
-		spin_unlock_irqrestore(&tracelock, flags);
+		spin_lock_irqsave(&owner->held_list_lock, flags);
+		list_del_init(&lock->held_list_entry);
+		spin_unlock_irqrestore(&owner->held_list_lock, flags);
 	}
 }
 
@@ -496,7 +498,7 @@ void debug_rt_mutex_init(struct rt_mutex
 	if (rt_trace_on) {
 		rt_mutex_debug_check_no_locks_freed(addr,
 						    sizeof(struct rt_mutex));
-		INIT_LIST_HEAD(&lock->held_list);
+		INIT_LIST_HEAD(&lock->held_list_entry);
 		lock->name = name;
 	}
 }
Index: linux-pi-futex.mm.q/kernel/rtmutex-debug.h
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex-debug.h
+++ linux-pi-futex.mm.q/kernel/rtmutex-debug.h
@@ -21,10 +21,17 @@ extern void debug_rt_mutex_free_waiter(s
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name);
 extern void debug_rt_mutex_lock(struct rt_mutex *lock __IP_DECL__);
 extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
+extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
+				      struct task_struct *powner __IP_DECL__);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
 extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
-# define debug_rt_mutex_detect_deadlock(d)		(1)
 # define debug_rt_mutex_reset_waiter(w)			\
 	do { (w)->deadlock_lock = NULL; } while (0)
+
+static inline int debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
+						 int detect)
+{
+	return (waiter != NULL);
+}
Index: linux-pi-futex.mm.q/kernel/rtmutex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex.c
+++ linux-pi-futex.mm.q/kernel/rtmutex.c
@@ -1,11 +1,12 @@
 /*
  * RT-Mutexes: simple blocking mutual exclusion locks with PI support
  *
- * started by Ingo Molnar and Thomas Gleixner:
+ * started by Ingo Molnar and Thomas Gleixner.
  *
  *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
+ *  Copyright (C) 2006 Esben Nielsen
  */
 #include <linux/spinlock.h>
 #include <linux/module.h>
@@ -133,211 +134,148 @@ static void __rt_mutex_adjust_prio(struc
  */
 static void rt_mutex_adjust_prio(struct task_struct *task)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&task->pi_lock, flags);
+	spin_lock(&task->pi_lock);
 	__rt_mutex_adjust_prio(task);
-	spin_unlock_irqrestore(&task->pi_lock, flags);
+	spin_unlock(&task->pi_lock);
 }
 
 /*
- * PI-locking: we lock PI-dependencies opportunistically via trylock.
- *
- * In the overwhelming majority of cases the 'PI chain' is empty or at
- * most 1-2 entries long, for which the trylock is sufficient,
- * scalability-wise. The locking might look a bit scary, for which we
- * apologize in advance :-)
- *
- * If any of the trylocks fails then we back out, task the global
- * pi_conflicts_lock and take the locks again. This ensures deadlock-free
- * but still scalable locking in the dependency graph, combined with
- * the ability to reliably (and cheaply) detect user-space deadlocks.
+ * Max number of times we'll walk the boosting chain:
  */
-static DEFINE_SPINLOCK(pi_conflicts_lock);
+int max_lock_depth = 1024;
 
 /*
- * Lock the full boosting chain.
- *
- * If 'try' is set, we have to backout if we hit a owner who is
- * running its own pi chain operation. We go back and take the slow
- * path via the pi_conflicts_lock.
- *
- * We put all held locks into a list, via ->pi_lock_chain, and walk
- * this list at unlock_pi_chain() time.
- */
-static int lock_pi_chain(struct rt_mutex *act_lock,
-			 struct rt_mutex_waiter *waiter,
-			 struct list_head *lock_chain,
-			 int try, int detect_deadlock)
-{
-	struct task_struct *owner;
-	struct rt_mutex *nextlock, *lock = act_lock;
-	struct rt_mutex_waiter *nextwaiter;
-	int deadlock_detect;
+ * Adjust the priority chain. Also used for deadlock detection.
+ * Decreases task's usage by one - may thus free the task.
+ * Returns 0 or -EDEADLK.
+ */
+static int rt_mutex_adjust_prio_chain(task_t *task,
+				      int deadlock_detect,
+				      struct rt_mutex *orig_lock,
+				      struct rt_mutex_waiter *orig_waiter
+				      __IP_DECL__)
+{
+	struct rt_mutex *lock;
+	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
+	int detect_deadlock, ret = 0, depth = 0;
+
+	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
+							 deadlock_detect);
 
 	/*
-	 * Debugging might turn deadlock detection on, unconditionally:
+	 * The (de)boosting is a step by step approach with a lot of
+	 * pitfalls. We want this to be preemptible and we want hold a
+	 * maximum of two locks per step. So we have to check
+	 * carefully whether things change under us.
 	 */
-	deadlock_detect = debug_rt_mutex_detect_deadlock(detect_deadlock);
-
-	for (;;) {
-		owner = rt_mutex_owner(lock);
-
-		/* Check for circular dependencies */
-		if (unlikely(owner->pi_locked_by == current)) {
-			debug_rt_mutex_deadlock(detect_deadlock, waiter, lock);
-			return detect_deadlock ? -EDEADLK : 1;
-		}
-
-		while (!spin_trylock(&owner->pi_lock)) {
-			/*
-			 * Owner runs its own chain. Go back and take
-			 * the slow path
-			 */
-			if (try && owner->pi_locked_by == owner)
-				return -EBUSY;
-			cpu_relax();
-		}
-
-		BUG_ON(owner->pi_locked_by);
-		owner->pi_locked_by = current;
-		BUG_ON(!list_empty(&owner->pi_lock_chain));
-		list_add(&owner->pi_lock_chain, lock_chain);
+ again:
+	if (++depth > max_lock_depth) {
+		static int prev_max;
 
 		/*
-		 * When the owner is blocked on a lock, try to take
-		 * the lock:
+		 * Print this only once. If the admin changes the limit,
+		 * print a new message when reaching the limit again.
 		 */
-		nextwaiter = owner->pi_blocked_on;
-
-		/* End of chain? */
-		if (!nextwaiter)
-			return 1;
-
-		nextlock = nextwaiter->lock;
-
-		/* Check for circular dependencies: */
-		if (unlikely(nextlock == act_lock ||
-			     rt_mutex_owner(nextlock) == current)) {
-			debug_rt_mutex_deadlock(detect_deadlock, waiter,
-						nextlock);
-			list_del_init(&owner->pi_lock_chain);
-			owner->pi_locked_by = NULL;
-			spin_unlock(&owner->pi_lock);
-			return detect_deadlock ? -EDEADLK : 1;
+		if (prev_max != max_lock_depth) {
+			prev_max = max_lock_depth;
+			printk(KERN_WARNING "Maximum lock depth %d reached "
+			       "task: %s (%d)\n", max_lock_depth,
+			       task->comm, task->pid);
 		}
+		put_task_struct(task);
 
-		/* Try to get nextlock->wait_lock: */
-		if (unlikely(!spin_trylock(&nextlock->wait_lock))) {
-			list_del_init(&owner->pi_lock_chain);
-			owner->pi_locked_by = NULL;
-			spin_unlock(&owner->pi_lock);
-			cpu_relax();
-			continue;
-		}
-
-		lock = nextlock;
+		return deadlock_detect ? -EDEADLK : 0;
+	}
+ retry:
+	/*
+	 * Task can not go away as we did a get_task() before !
+	 */
+	spin_lock(&task->pi_lock);
 
-		/*
-		 * If deadlock detection is done (or has to be done, as
-		 * for userspace locks), we have to walk the full chain
-		 * unconditionally.
-		 */
-		if (deadlock_detect)
-			continue;
+	waiter = task->pi_blocked_on;
+	/*
+	 * Check whether the end of the boosting chain has been
+	 * reached or the state of the chain has changed while we
+	 * dropped the locks.
+	 */
+	if (!waiter || !waiter->task)
+		goto out_unlock_pi;
 
-		/*
-		 * Optimization: we only have to continue up to the point
-		 * where boosting/unboosting still has to be done:
-		 */
+	if (top_waiter && (!task_has_pi_waiters(task) ||
+			   top_waiter != task_top_pi_waiter(task)))
+		goto out_unlock_pi;
 
-		/* Boost or unboost? */
-		if (waiter) {
-			/* If the top waiter has higher priority, stop: */
-			if (rt_mutex_top_waiter(lock)->list_entry.prio <=
-			    waiter->list_entry.prio)
-				return 1;
-		} else {
-			/* If nextwaiter is not the top waiter, stop: */
-			if (rt_mutex_top_waiter(lock) != nextwaiter)
-				return 1;
-		}
+	/*
+	 * When deadlock detection is off then we check, if further
+	 * priority adjustment is necessary.
+	 */
+	if (!detect_deadlock && waiter->list_entry.prio == task->prio) {
+		BUG_ON(waiter->pi_list_entry.prio != waiter->list_entry.prio);
+		goto out_unlock_pi;
 	}
-}
-
-/*
- * Unlock the pi_chain:
- */
-static void unlock_pi_chain(struct list_head *lock_chain)
-{
-	struct task_struct *owner, *tmp;
 
-	list_for_each_entry_safe(owner, tmp, lock_chain, pi_lock_chain) {
-		struct rt_mutex_waiter *waiter = owner->pi_blocked_on;
-
-		list_del_init(&owner->pi_lock_chain);
-		BUG_ON(!owner->pi_locked_by);
-		owner->pi_locked_by = NULL;
-		if (waiter)
-			spin_unlock(&waiter->lock->wait_lock);
-		spin_unlock(&owner->pi_lock);
+	lock = waiter->lock;
+	if (!spin_trylock(&lock->wait_lock)) {
+		spin_unlock(&task->pi_lock);
+		cpu_relax();
+		goto retry;
 	}
-}
 
-/*
- * Do the priority (un)boosting along the chain:
- */
-static void adjust_pi_chain(struct rt_mutex *lock,
-			    struct rt_mutex_waiter *waiter,
-			    struct rt_mutex_waiter *top_waiter,
-			    struct list_head *lock_chain)
-{
-	struct task_struct *owner = rt_mutex_owner(lock);
-	struct list_head *curr = lock_chain->prev;
+	/* Deadlock detection */
+	if (lock == orig_lock || rt_mutex_owner(lock) == current) {
+		debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
+		spin_unlock(&lock->wait_lock);
+		ret = deadlock_detect ? -EDEADLK : 0;
+		goto out_unlock_pi;
+	}
 
-	for (;;) {
-		if (top_waiter)
-			plist_del(&top_waiter->pi_list_entry,
-				  &owner->pi_waiters);
+	top_waiter = rt_mutex_top_waiter(lock);
 
-		if (waiter)
-			waiter->pi_list_entry.prio = waiter->task->prio;
+	/* Requeue the waiter */
+	plist_del(&waiter->list_entry, &lock->wait_list);
+	waiter->list_entry.prio = task->prio;
+	plist_add(&waiter->list_entry, &lock->wait_list);
 
-		if (rt_mutex_has_waiters(lock)) {
-			top_waiter = rt_mutex_top_waiter(lock);
-			plist_add(&top_waiter->pi_list_entry,
-				  &owner->pi_waiters);
-		}
+	/* Release the task */
+	spin_unlock(&task->pi_lock);
+	put_task_struct(task);
+
+	/* Grab the next task */
+	task = rt_mutex_owner(lock);
+	spin_lock(&task->pi_lock);
+
+	if (waiter == rt_mutex_top_waiter(lock)) {
+		/* Boost the owner */
+		plist_del(&top_waiter->pi_list_entry, &task->pi_waiters);
+		waiter->pi_list_entry.prio = waiter->list_entry.prio;
+		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		__rt_mutex_adjust_prio(task);
+
+	} else if (top_waiter == waiter) {
+		/* Deboost the owner */
+		plist_del(&waiter->pi_list_entry, &task->pi_waiters);
+		waiter = rt_mutex_top_waiter(lock);
+		waiter->pi_list_entry.prio = waiter->list_entry.prio;
+		plist_add(&waiter->pi_list_entry, &task->pi_waiters);
+		__rt_mutex_adjust_prio(task);
+	}
 
-		__rt_mutex_adjust_prio(owner);
+	get_task_struct(task);
+	spin_unlock(&task->pi_lock);
 
-		waiter = owner->pi_blocked_on;
-		if (!waiter || curr->prev == lock_chain)
-			return;
-
-		curr = curr->prev;
-		lock = waiter->lock;
-		owner = rt_mutex_owner(lock);
-		top_waiter = rt_mutex_top_waiter(lock);
+	top_waiter = rt_mutex_top_waiter(lock);
+	spin_unlock(&lock->wait_lock);
 
-		plist_del(&waiter->list_entry, &lock->wait_list);
-		waiter->list_entry.prio = waiter->task->prio;
-		plist_add(&waiter->list_entry, &lock->wait_list);
+	if (!detect_deadlock && waiter != top_waiter)
+		goto out_put_task;
 
-		/*
-		 * We can stop here, if the waiter is/was not the top
-		 * priority waiter:
-		 */
-		if (top_waiter != waiter &&
-				waiter != rt_mutex_top_waiter(lock))
-			return;
+	goto again;
 
-		/*
-		 * Note: waiter is not necessarily the new top
-		 * waiter!
-		 */
-		waiter = rt_mutex_top_waiter(lock);
-	}
+ out_unlock_pi:
+	spin_unlock(&task->pi_lock);
+ out_put_task:
+	put_task_struct(task);
+	return ret;
 }
 
 /*
@@ -448,111 +386,65 @@ static int try_to_take_rt_mutex(struct r
 /*
  * Task blocks on lock.
  *
- * Prepare waiter and potentially propagate our priority into the pi chain.
+ * Prepare waiter and propagate pi chain
  *
  * This must be called with lock->wait_lock held.
- * return values: 1: waiter queued, 0: got the lock,
- *		  -EDEADLK: deadlock detected.
  */
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
-				   int detect_deadlock __IP_DECL__)
+				   int detect_deadlock
+				   __IP_DECL__)
 {
 	struct rt_mutex_waiter *top_waiter = waiter;
-	LIST_HEAD(lock_chain);
-	int res = 1;
+	task_t *owner = rt_mutex_owner(lock);
+	int boost = 0, res;
 
+	spin_lock(&current->pi_lock);
+	__rt_mutex_adjust_prio(current);
 	waiter->task = current;
 	waiter->lock = lock;
-	debug_rt_mutex_reset_waiter(waiter);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
 	plist_node_init(&waiter->list_entry, current->prio);
 	plist_node_init(&waiter->pi_list_entry, current->prio);
 
-	/* Get the top priority waiter of the lock: */
+	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
 		top_waiter = rt_mutex_top_waiter(lock);
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
 	current->pi_blocked_on = waiter;
 
-	/*
-	 * Call adjust_prio_chain, when waiter is the new top waiter
-	 * or when deadlock detection is requested:
-	 */
-	if (waiter != rt_mutex_top_waiter(lock) &&
-	    !debug_rt_mutex_detect_deadlock(detect_deadlock))
-		goto out_unlock_pi;
-
-	/* Try to lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 1, detect_deadlock);
-
-	if (likely(res == 1))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
-
-	/* Common case: we managed to lock it: */
-	if (res != -EBUSY)
-		goto out_unlock_chain_pi;
-
-	/* Rare case: we hit some other task running a pi chain operation: */
-	unlock_pi_chain(&lock_chain);
-
-	plist_del(&waiter->list_entry, &lock->wait_list);
-	current->pi_blocked_on = NULL;
-	current->pi_locked_by = NULL;
 	spin_unlock(&current->pi_lock);
-	fixup_rt_mutex_waiters(lock);
-
-	spin_unlock(&lock->wait_lock);
 
-	/*
-	 * Here we have dropped all locks, and take the global
-	 * pi_conflicts_lock. We have to redo all the work, no
-	 * previous information about the lock is valid anymore:
-	 */
-	spin_lock(&pi_conflicts_lock);
+	if (waiter == rt_mutex_top_waiter(lock)) {
+		spin_lock(&owner->pi_lock);
+		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
+		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
-	spin_lock(&lock->wait_lock);
-	if (try_to_take_rt_mutex(lock __IP__)) {
-		/*
-		 * Rare race: against all odds we got the lock.
-		 */
-		res = 0;
-		goto out;
+		__rt_mutex_adjust_prio(owner);
+		if (owner->pi_blocked_on) {
+			boost = 1;
+			get_task_struct(owner);
+		}
+		spin_unlock(&owner->pi_lock);
 	}
+	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
+		spin_lock(&owner->pi_lock);
+		if (owner->pi_blocked_on) {
+			boost = 1;
+			get_task_struct(owner);
+		}
+		spin_unlock(&owner->pi_lock);
+	}
+	if (!boost)
+		return 0;
 
-	WARN_ON(!rt_mutex_owner(lock) || rt_mutex_owner(lock) == current);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
-
-	plist_node_init(&waiter->list_entry, current->prio);
-	plist_node_init(&waiter->pi_list_entry, current->prio);
-
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		top_waiter = rt_mutex_top_waiter(lock);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-
-	current->pi_blocked_on = waiter;
-
-	/* Lock the full chain: */
-	res = lock_pi_chain(lock, waiter, &lock_chain, 0, detect_deadlock);
+	spin_unlock(&lock->wait_lock);
 
-	/* Drop the conflicts lock before adjusting: */
-	spin_unlock(&pi_conflicts_lock);
+	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
+					 waiter __IP__);
 
-	if (likely(res == 1))
-		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
+	spin_lock(&lock->wait_lock);
 
- out_unlock_chain_pi:
-	unlock_pi_chain(&lock_chain);
- out_unlock_pi:
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
- out:
 	return res;
 }
 
@@ -569,6 +461,8 @@ static void wakeup_next_waiter(struct rt
 	struct rt_mutex_waiter *waiter;
 	struct task_struct *pendowner;
 
+	spin_lock(&current->pi_lock);
+
 	waiter = rt_mutex_top_waiter(lock);
 	plist_del(&waiter->list_entry, &lock->wait_list);
 
@@ -578,15 +472,14 @@ static void wakeup_next_waiter(struct rt
 	 * boosted mode and go back to normal after releasing
 	 * lock->wait_lock.
 	 */
-	spin_lock(&current->pi_lock);
 	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
-	spin_unlock(&current->pi_lock);
-
 	pendowner = waiter->task;
 	waiter->task = NULL;
 
 	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);
 
+	spin_unlock(&current->pi_lock);
+
 	/*
 	 * Clear the pi_blocked_on variable and enqueue a possible
 	 * waiter into the pi_waiters list of the pending owner. This
@@ -616,87 +509,52 @@ static void wakeup_next_waiter(struct rt
 /*
  * Remove a waiter from a lock
  *
- * Must be called with lock->wait_lock held.
+ * Must be called with lock->wait_lock held
  */
-static int remove_waiter(struct rt_mutex *lock,
-			 struct rt_mutex_waiter *waiter __IP_DECL__)
+static void remove_waiter(struct rt_mutex *lock,
+			  struct rt_mutex_waiter *waiter  __IP_DECL__)
 {
-	struct rt_mutex_waiter *next_waiter = NULL,
-				*top_waiter = rt_mutex_top_waiter(lock);
-	LIST_HEAD(lock_chain);
-	int res;
-
-	plist_del(&waiter->list_entry, &lock->wait_list);
+	int first = (waiter == rt_mutex_top_waiter(lock));
+	int boost = 0;
+	task_t *owner = rt_mutex_owner(lock);
 
 	spin_lock(&current->pi_lock);
-
-	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
-		goto out;
-
-	current->pi_locked_by = current;
-
-	if (rt_mutex_has_waiters(lock))
-		next_waiter = rt_mutex_top_waiter(lock);
-
-	/* Try to lock the full chain: */
-	res = lock_pi_chain(lock, next_waiter, &lock_chain, 1, 0);
-
-	if (likely(res != -EBUSY)) {
-		adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
-		goto out_unlock;
-	}
-
-	/* We hit some other task running a pi chain operation: */
-	unlock_pi_chain(&lock_chain);
-	plist_add(&waiter->list_entry, &lock->wait_list);
-	current->pi_blocked_on = waiter;
-	current->pi_locked_by = NULL;
+	plist_del(&waiter->list_entry, &lock->wait_list);
+	waiter->task = NULL;
+	current->pi_blocked_on = NULL;
 	spin_unlock(&current->pi_lock);
-	spin_unlock(&lock->wait_lock);
-
-	spin_lock(&pi_conflicts_lock);
-
-	spin_lock(&lock->wait_lock);
-
-	spin_lock(&current->pi_lock);
-	current->pi_locked_by = current;
 
-	/* We might have been woken up: */
-	if (!waiter->task) {
-		spin_unlock(&pi_conflicts_lock);
-		goto out;
-	}
+	if (first && owner != current) {
 
-	top_waiter = rt_mutex_top_waiter(lock);
+		spin_lock(&owner->pi_lock);
 
-	plist_del(&waiter->list_entry, &lock->wait_list);
+		plist_del(&waiter->pi_list_entry, &owner->pi_waiters);
 
-	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
-		goto out;
+		if (rt_mutex_has_waiters(lock)) {
+			struct rt_mutex_waiter *next;
 
-	/* Get the top priority waiter of the lock: */
-	if (rt_mutex_has_waiters(lock))
-		next_waiter = rt_mutex_top_waiter(lock);
+			next = rt_mutex_top_waiter(lock);
+			plist_add(&next->pi_list_entry, &owner->pi_waiters);
+		}
+		__rt_mutex_adjust_prio(owner);
 
-	/* Lock the full chain: */
-	lock_pi_chain(lock, next_waiter, &lock_chain, 0, 0);
+		if (owner->pi_blocked_on) {
+			boost = 1;
+			get_task_struct(owner);
+		}
+		spin_unlock(&owner->pi_lock);
+	}
 
-	/* Drop the conflicts lock: */
-	spin_unlock(&pi_conflicts_lock);
+	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
 
-	adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
+	if (!boost)
+		return;
 
- out_unlock:
-	unlock_pi_chain(&lock_chain);
- out:
-	current->pi_blocked_on = NULL;
-	waiter->task = NULL;
-	current->pi_locked_by = NULL;
-	spin_unlock(&current->pi_lock);
+	spin_unlock(&lock->wait_lock);
 
-	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
+	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL __IP__);
 
-	return 0;
+	spin_lock(&lock->wait_lock);
 }
 
 /*
@@ -709,21 +567,18 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 {
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
-	unsigned long flags;
 
 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
 
-	spin_lock_irqsave(&lock->wait_lock, flags);
+	spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock __IP__)) {
-		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		spin_unlock(&lock->wait_lock);
 		return 0;
 	}
 
-	BUG_ON(rt_mutex_owner(lock) == current);
-
 	set_current_state(state);
 
 	/* Setup the timer, when timeout != NULL */
@@ -753,25 +608,30 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		/*
 		 * waiter.task is NULL the first time we come here and
 		 * when we have been woken up by the previous owner
-		 * but the lock got stolen by an higher prio task.
+		 * but the lock got stolen by a higher prio task.
 		 */
 		if (!waiter.task) {
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
-			/* got the lock or deadlock: */
-			if (ret == 0 || ret == -EDEADLK)
+			/*
+			 * If we got woken up by the owner then start loop
+			 * all over without going into schedule to try
+			 * to get the lock now:
+			 */
+			if (unlikely(!waiter.task))
+				continue;
+
+			if (unlikely(ret))
 				break;
-			ret = 0;
 		}
-
-		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		spin_unlock(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
 		if (waiter.task)
 			schedule_rt_mutex(lock);
 
-		spin_lock_irqsave(&lock->wait_lock, flags);
+		spin_lock(&lock->wait_lock);
 		set_current_state(state);
 	}
 
@@ -786,10 +646,10 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	spin_unlock_irqrestore(&lock->wait_lock, flags);
+	spin_unlock(&lock->wait_lock);
 
 	/* Remove pending timer: */
-	if (unlikely(timeout && timeout->task))
+	if (unlikely(timeout))
 		hrtimer_cancel(&timeout->timer);
 
 	/*
@@ -811,10 +671,9 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 static inline int
 rt_mutex_slowtrylock(struct rt_mutex *lock __IP_DECL__)
 {
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&lock->wait_lock, flags);
+	spin_lock(&lock->wait_lock);
 
 	if (likely(rt_mutex_owner(lock) != current)) {
 
@@ -826,7 +685,7 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 		fixup_rt_mutex_waiters(lock);
 	}
 
-	spin_unlock_irqrestore(&lock->wait_lock, flags);
+	spin_unlock(&lock->wait_lock);
 
 	return ret;
 }
@@ -837,9 +696,7 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 static void __sched
 rt_mutex_slowunlock(struct rt_mutex *lock)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&lock->wait_lock, flags);
+	spin_lock(&lock->wait_lock);
 
 	debug_rt_mutex_unlock(lock);
 
@@ -847,13 +704,13 @@ rt_mutex_slowunlock(struct rt_mutex *loc
 
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
-		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		spin_unlock(&lock->wait_lock);
 		return;
 	}
 
 	wakeup_next_waiter(lock);
 
-	spin_unlock_irqrestore(&lock->wait_lock, flags);
+	spin_unlock(&lock->wait_lock);
 
 	/* Undo pi boosting if necessary: */
 	rt_mutex_adjust_prio(current);
@@ -869,8 +726,8 @@ static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
 		  int detect_deadlock,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
-					 struct hrtimer_sleeper *timeout,
-					 int detect_deadlock __IP_DECL__))
+				struct hrtimer_sleeper *timeout,
+				int detect_deadlock __IP_DECL__))
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
@@ -883,8 +740,8 @@ static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			struct hrtimer_sleeper *timeout, int detect_deadlock,
 			int (*slowfn)(struct rt_mutex *lock, int state,
-					       struct hrtimer_sleeper *timeout,
-					       int detect_deadlock __IP_DECL__))
+				      struct hrtimer_sleeper *timeout,
+				      int detect_deadlock __IP_DECL__))
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
@@ -974,7 +831,6 @@ rt_mutex_timed_lock(struct rt_mutex *loc
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 
-
 /**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
@@ -1030,7 +886,7 @@ void __rt_mutex_init(struct rt_mutex *lo
 {
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
-	plist_head_init(&lock->wait_list);
+	plist_head_init(&lock->wait_list, &lock->wait_lock);
 
 	debug_rt_mutex_init(lock, name);
 }
@@ -1050,7 +906,7 @@ void rt_mutex_init_proxy_locked(struct r
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL);
-	debug_rt_mutex_lock(lock __RET_IP__);
+	debug_rt_mutex_proxy_lock(lock, proxy_owner __RET_IP__);
 	rt_mutex_set_owner(lock, proxy_owner, 0);
 	rt_mutex_deadlock_account_lock(lock, proxy_owner);
 }
Index: linux-pi-futex.mm.q/kernel/rtmutex.h
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex.h
+++ linux-pi-futex.mm.q/kernel/rtmutex.h
@@ -19,10 +19,11 @@
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
 #define debug_rt_mutex_lock(l)				do { } while (0)
+#define debug_rt_mutex_proxy_lock(l,p)			do { } while (0)
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n)			do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-#define debug_rt_mutex_detect_deadlock(d)		(d)
+#define debug_rt_mutex_detect_deadlock(w,d)		(d)
 #define debug_rt_mutex_reset_waiter(w)			do { } while (0)
Index: linux-pi-futex.mm.q/kernel/sched.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/sched.c
+++ linux-pi-futex.mm.q/kernel/sched.c
@@ -1522,6 +1522,12 @@ void fastcall sched_fork(task_t *p, int 
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
 	p->state = TASK_RUNNING;
+
+	/*
+	 * Make sure we do not leak PI boosting priority to the child:
+	 */
+	p->prio = current->normal_prio;
+
 	INIT_LIST_HEAD(&p->run_list);
 	p->array = NULL;
 #ifdef CONFIG_SCHEDSTATS
@@ -3893,7 +3899,6 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-
 	p->normal_prio = normal_prio(p);
 	/* we are holding p->pi_lock already */
 	p->prio = rt_mutex_getprio(p);
@@ -3902,7 +3907,6 @@ static void __setscheduler(struct task_s
 	 */
 	if (policy == SCHED_BATCH)
 		p->sleep_avg = 0;
-
 	set_load_weight(p);
 }
 
Index: linux-pi-futex.mm.q/kernel/sysctl.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/sysctl.c
+++ linux-pi-futex.mm.q/kernel/sysctl.c
@@ -132,6 +132,10 @@ extern int acct_parm[];
 extern int no_unaligned_warning;
 #endif
 
+#ifdef CONFIG_RT_MUTEXES
+extern int max_lock_depth;
+#endif
+
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -684,6 +688,17 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_RT_MUTEXES
+	{
+		.ctl_name	= KERN_MAX_LOCK_DEPTH,
+		.procname	= "max_lock_depth",
+		.data		= &max_lock_depth,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+
 	{ .ctl_name = 0 }
 };
 
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- linux-pi-futex.mm.q.orig/scripts/rt-tester/t3-l1-pi-signal.tst
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-signal.tst
@@ -69,15 +69,18 @@ W: locked:		0: 	0
 C: locknowait:		1: 	0
 W: blocked:		1: 	0
 T: prioeq:		0:	80
+T: prioeq:		1:	80
 
 # T2 lock L0 interruptible, no wait in the wakeup path
 C: lockintnowait:	2:	0
 W: blocked:		2: 	0
 T: prioeq:		0:	81
+T: prioeq:		1:	80
 
 # Interrupt T2
 C: signal:		2:	2
 W: unlocked:		2:	0
+T: prioeq:		1:	80
 T: prioeq:		0:	80
 
 T: locked:		0:	0
