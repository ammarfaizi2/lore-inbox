Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264698AbUDUD7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264698AbUDUD7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 23:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUDUD7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 23:59:03 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:57330 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264698AbUDUD6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:12 -0400
Date: Tue, 20 Apr 2004 21:03:31 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 1/11: documentation files
Message-ID: <0404202103.BdpblbFbObEc7cVdTcFbFdYcCcNcudCb1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.Zbzc4dTagcfbnbya~accIbGbHcAcwbBb1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 fusyn.txt |  679 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 679 insertions(+)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ Documentation/fusyn.txt Tue Feb 3 00:56:52 2004
@@ -0,0 +1,679 @@
+
+FUSYN - Fast User SYNChronization primitives
+
+http://developer.osdl.org/dev/robustmutexes/
+
+I am calling these things FUSYNs to distinguish them from the original
+futexes they base on, as they behave kind of different (the naming
+sucks, you are welcome to suggest new names).
+
+This is my second big time attempt to implement real-time locking in
+the Linux kernel to solve the short comings of a locking system based
+on futexes, being mainly:
+
+   - no robustness support without kernel cooperation
+
+   - no priority inheritance/protection
+
+   - no real-time wake up (priority based, no priority inversion
+     holes, etc)
+
+   - No way to implement detection of complex deadlock scenarios.
+
+The main objects to implement are:
+
+  - fuqueues: Priority-sorted wait queues -- other than that, mostly
+    equal to futexes. Usable from kernel and user space.
+
+  - fulock: 
+
+    This is a full blown "mutex" implementation that can be used from
+    kernel and user space (with user-space fast [un]locking on
+    non-contended situations), robustness (if owner dies, ownership is
+    passed on), priority inheritance and (FUTURE) priority protection.
+
+    They are just a fuqueue that supports the ownership concept, to
+    allow for robustness and priority inheritace/protection.
+
+    It also supports serialized and non-serialized unlocks [see FAQ].
+  
+All the non-blocking calls (wake() and unlock() can be used from
+interrupt context; the data structures are protected by IRQ safe spin
+locks). This is heavier weight, but is needed to properly support
+priority change while waiting and priority inheritance. As well, it
+helps to avoid cache line bouncing of the spin locks that protect the
+structures.
+
+Released files:
+
+http://developer.osdl.org/dev/robustmutexes/
+
+fusyn-KERNEL-VERSION.PATCH-VERSION.patch   Patch file against Linus' tree
+fusyn-test-PATCH-VERSION.tar.gz      Sample test library and code
+
+
+Contents:
+---------
+
+- quick intro
+- vlocators
+- fuqueues
+- fulocks
+- issues/future work
+- FAQ [some definitions here, try wild search]
+
+
+QUICK INTRO
+-----------
+
+Fuqueues are more or less like waitqueues and like futexes (the user
+space one, ufuqueues), but they are priority sorted and if you change
+the priority of a waiter while blocked, it will update it's position
+in the wait list. 
+
+The priority sorting is O(N) in addition now, but I will change that
+sometime to be O(1) [actually, O(N) with N bounded to the max number
+of supported priorities, so O(1)].
+
+Fulocks build on top of fuqueues and just adds the concept of 'owner'
+plus some flags. A fulock can only be owned by a single task at the
+same time; a task contains a list of the fulocks it owns.
+
+This is for kernel space; for user space, each fu* structure has a
+ufu* counterpart that adds a vlocator--that is used to associate the
+user space address the kernel space pointer of the ufu* struct.. ufu*
+objects are allocated on demand; when noone is using them, they are
+released after a while (so we have caching) [use means somebody
+waiting on it to be woken up/acquire the lock or somebody owning the
+[u]fulock]. 
+
+To speed things up, there is a fast-mode (non-KCO) to lock/unlock
+fulocks in user-space without need for kernel intervention (just like
+NPTL's using futexes). To allow for robustness, priority inheritance
+and the like, we need to know who owns the lock, so we lock using the
+PID of the locking thread [more on this below].
+
+
+VLOCATORS
+---------
+
+This is an structure (struct vlocator) and the associated code to map
+a user space address to a kernel object that is kept in a hash
+table. As well, it provides and uses a reference count for the object,
+as well as a hash table cleanup function.
+
+It uses the 'struct futex_key' as done by Jamie Lokier; the code is in
+include/linux/vlocator.h and kernel/vlocator.c. 
+
+Two very simple operations: find an object in 'current's space by
+address and find-or-allocate (vl_find() and vl_locate()).
+
+The cleanup function (or garbage collector) runs periodically and
+releases items with a reference count of zero. This allows the get/put
+operations to be lockless.
+
+
+FUQUEUES
+--------
+
+Fuqueues are just wait-queues, like futexes; the differences are in
+the wake up process, as it is done not in a FIFO order but by
+priority. As well, if the task changes its priority while waiting, its
+position in the list is updated. The code is in include/linux/fuqueue.h
+and kernel/fuqueue.c.
+
+They consist of a 'struct fuqueue' which has a priority-sorted wait
+list and a lock to protect access to it. They can be used in
+kernel-space as a wait queue.
+
+Entry points:
+
+fuqueue_wait() -- wait on a fuqueue
+fuqueue_wake() -- wake N waiters from a fuqueue with code C.
+
+The code is split in various functions to allow fulocks to use the
+fuqueue stuff for integration. The wlist*_t thing is a reminder of
+something that will go away; it stands for 'wait list' and is setup
+with a #define based redirection to support different types of sorted
+wait list implementations (for example, one that is O(1) using a
+priority array -- that is huge). That is going to be deprecated in
+favor of a O(1) priority sorted list that is not as big (see FUTURE
+WORK).
+
+'struct ufuqueue' is a fuqueue plus the stuff to link it to a possibly
+shared user space address (a vfuqueue) (the vlocator), so that is the
+real futex equivalent. The code is in kernel/ufuqueue.c and just
+consists on the syscall wrappers to associate the proper ufuqueue to
+the vfuqueue and then call the fuqueue layer.
+
+Need to add more stuff to make fuqueues more of a waitqueue
+equivalent. 
+
+
+FULOCKS
+-------
+
+The mother of the whole thing. Fulocks are a full mutex
+implementation; it is basically the concept of an owner and a list of
+tasks waiting to own the mutex (implemented with a 'struct fuqueue'). 
+
+The 'struct fulock' holds all the fulock properties (most in the flags
+member). As well, there is an ownership list node, where all the
+fulocks that a task currently owns are linked to the task
+(task->fulock_olist).
+
+Properties of a fulock:
+
+- owner/state: locked or unlocked
+
+- mode of operation (encoded in the flags):
+
+  + pi xor pp: fulock is priority inheritance or protection (or
+    none). 
+
+  + deadlock detection: lock() checks for deadlocks before allowing
+    it.
+
+  + sun-mode robustness: do robustness not-so-flexibly
+
+  + KCO (no fast path) xor non-KCO (fast path allowed).
+
+  Robustness is always enabled as it is easy for user space to
+  simulate the hangs that happen when you don't have it.
+
+- priority:
+
+  + Priority Inheritance: the priority of a fulock is that of the
+    highest priority waiter on its wait list. If no waiters, then it
+    has minimal priority.
+
+  + Priority Protection: the priority of the fulock is its priority
+    ceiling. The priority ceiling is encoded in the flags too.
+
+  + Normal (no PI or PP): the priority is the minium one (this nops
+    everything in the PI/PP mechanisms).
+
+  This priority is assigned to the ownership list node so that the
+  fulocks in the ownership list are sorted. This is importante for
+  priority inheritance and protection.
+
+- health state: healthy, dead-owner or not-recoverable (see the FAQ
+  for the definitions). It is encoded in the flags.
+
+The entry points are [kernel/fulock.c, include/linux/fulock.h]:
+
+fulock_lock()
+fulock_unlock()
+fulock_consistency() [for manipulating the state]
+
+How PI/PP works is by always keeping the priorities of the
+waiters/fulocks around. The fulock has a prio that comes from the wait
+list (if PI), from the prio ceiling (if PP) or minimal (none). When
+anybody owns that fulock, the fulock is added to the ownership list by
+fulock prio order. The highest prio fulock determines the prio of the
+list, and that is what is called the "bost" priority, which is stored
+in task->boost_prio. I've hacked up the scheduler to, whenever it
+needs the prio of a task for activating it, to choose from the maximum
+prio from the real prio and the boost one. This way, when the boost is
+higher, the task is effectively boosted (see __prio_boost() in
+sched.c). The hack is still a wee hackish, need to make it more
+optimized so that we don't need to calculate the minimum everytime,
+but just once, when we change the boosting thingie.
+
+
+A user level fulock (struct ufulock) is a fulock that can be used from
+the user space--it is represented by a (potentially shared) memory
+address (a vfulock) in user space. A vlocator is used to track
+it. Implemented in kernel/ufulock.c.
+
+Now, depending on certain parameters (arch supporting atomiooic
+compare-and-exchange, anal-retentive robustness need and something
+else I can't remember) you might one to use fast-path mode (non-KCO)
+or KCO mode. KCO stands for Kernel Controlled Ownership. In this mode,
+every [un]lock() operation goes through the kernel, without user space
+optimizations for the low contention case.
+
+In non-KCO mode (fast-path), the vfulock may have different values
+that server to define the state of a lock:
+
+0                       Unlocked [can be fast-locked]
+PID (< VFULOCK_WP)      Fast-locked by PID, no waiters in the
+                        kernel. [can be fast-unlocked].
+VFULOCK_WP              Locked by someone, kernel knows who, waiters 
+                        in the kernel.
+VFULOCK_DEAD            Previous owner died (maybe unlocked or
+                        locked), the kernel keeps the status [this is
+                        effectively identical to KCO mode]).
+VFULOCK_NR              Not recoverable.
+
+In KCO mode locks, we just keep the health state of the lock in the
+vfulock (to account for the volatility of KCO ufulocks in kernel
+space; if a KCO ufulock is owned, it exists in userspace; if not, it
+will end up being released back to the kmem cache): 
+
+VFULOCK_HEALTHY (==VFULOCK_UNLOCKED)  Fulock is healthy, normal
+VFULOCK_DEAD                          Fulock owner died
+VFULOCK_NR                            Ditto ...
+
+Now, back to non-KCO mode (the complex case :), this is how it works: 
+
+When user space goes to lock a ufulock with a fast operation, it
+issues an atomic compare and swap on the vfulock of its PID against 0
+(VFULOCK_UNLOCKED); if it succeeds, its the owner, done; if not, it
+goes to the kernel (sys_ufulock_lock()), who will put it to wait [see
+test/src/include/kernel-lock.h:vfulock_lock() in the fusyn-test
+package] or do the lock() according to the rules for dead fulocks.
+
+Unlock is fairly similar: if the value is VFULOCK_{WP,DEAD}, go to the
+kernel, sys_ufulock_unlock(); if VFULOCK_NR, return error; if not, it
+is a PID and need to do an atomic compare and exchange of 0
+(VFULOCK_UNLOCKED) (unlock) against the PID [again, check
+vfulock_unlock()].
+
+The kernel will always maintain the value in the vfulock and the
+corresponding fulock in the 'struct ufulock' in sync [vfulock_sync()
+in kernel/ufulock.c], and will do that everytime we enter it through
+one of the fulock system calls (sys_ufulock_{[un]lock,consistency}().
+
+The kernel will use the PID set by the fast-locker to match who is the
+owner when he doesn't know about it [afterwards it will be registered
+in the kernel)--check __fulock_id_owner() for ideas on how to avoid
+collision due to PID reuse].
+
+Once that is done, what is left is a 'fulock' that can be handled by
+the fulock layer.
+
+Now [uv]fulocks support:
+
+    - Real time: the unlock procedure is realtime in the sense that it
+      is O(1) and the next owner is the highest priority one; as well,
+      the fulock (actually, the vfulock) is never unlocked in the
+      meantime, the ownership is transferred instead of unlocking the
+      lock, waking up the first waiter and waiting for it to acquire
+      it. This avoids priority inversions by lower priority threads
+      sneaking in from other processors at the worst time.
+
+      However, this has a cost: the convoy phenomenon. To avoid that,
+      the unlock can be performed in a non-serialized fashion, where
+      the fulock is unlocked and then the new owner-to-be woken up so
+      it contends for it. Check "What are the two kinds of unlock" in
+      the FAQ below.
+
+    - Deadlock checking: complex dead lock scenarios where a
+      ownership/wait chain [see definition in FAQ] is involved are
+      catched if FULOCK_FL_ERROR_CHK is set.
+
+    - Priority change support: when the priority of the waiting task
+      is changed, it's position in the list is updated. See below for
+      effects on priority inheritance.
+
+    - Robustness: when a task who is a fulock owner dies and the
+      kernel knew about it (ie: it was registered in the
+      task->fulock_list), then the fulock is made dead-owner, unlocked
+      and the next waiter gets ownership, with a -EDEADOWNER return
+      code. 
+
+      This is always enabled; user space can emulate the
+      hangs+timeouts that would happen if this were not detected.
+
+      If the kernel knew nothing about it (ie: it was fast-locked),
+      then __fulock_id_owner() will fail to map the PID in the vfulock
+      to an existing task; then the current claimer would be
+      considered the owner after marking the fulock dead-owner.
+
+      Note the comments in __fulock_id_owner() for ideas on how to
+      avoid collisions due to PID reuse.
+
+    - Priority protection: when the owner is set, it's priority is
+      raised to the priority ceiling of the fulock; when it unlocks,
+      its prio is driven back to what it was before (or if there are
+      any other boosts in effect, whichever is effective).
+
+    - Priority inheritance: when a waiter queues for a fulock that has
+      the FULOCK_FL_PI bit set and its priority is higher than that of
+      the owner, it will boost the owner's priority to its own; this
+      will propagate in an ownership/wait chain (if the owner was
+      waiting on for a fulock, etc). As well, priority changes will
+      also be propagated.
+
+      The guts of these have been explained above; I should work on
+      the order of the explanations...
+
+
+FUTURE WORK
+-----------
+  
+  - fucond: conditional variables; although they can be implemented
+    in user space + fuqueues, doing it in the kernel helps a lot in
+    atomicity issues (and the performance should be much better).
+
+    We tried doing that (see releases up to 1.12 in the website) and
+    generally  it sucked because of the code bloat in the kernel, so
+    we decided to extirpate it.
+  
+  - rw lock: only the first locker can do the fast operation; the
+    others go to the kernel to sign up. This way ownership is
+    supported. If a reader dies, nothing happens (after all, it is
+    supposed to be read-only access), but we need to keep track of
+    readers dying so they don't hold writers off. If a writer dies,
+    next locker (reader or writer) gets dead-owner.
+
+    These guys could also get, like this, PI and PP, as they would be
+    very similar to fulocks, but with two waiting lists. One for
+    writers, one for readers, and they allow many ownerships at the
+    same time (when there are readers).
+
+    Maybe different operation modes to primer writers over readers?
+    FIXME, need to explore.
+
+  - Spinlocks: they could be implemented as a trylock() on a fulock
+    for N loops, and after it'd degenerate into a mutex wait. This
+    wait they'd automagically support robustness, PI and PP.
+
+  - Barriers: futexes offer enough functionality for implementing
+    them, however wake up should be real-time (priority based). Not a
+    real issue though, as in barriers everybody is woken up. It can be
+    done also with fuqueues.
+
+  - Getting rid of the vlocator hash table and doing direct mapping
+    [so that we avoid the O(N) lookup] by storing in user space some
+    short of pointer to a in-kernel data struct. The pointer has to be
+    "validated", so that user space cannot have the kernel point to
+    some random or pontentially dangerous space. 
+
+    A way would be to store two values, the pointer itself plus a
+    kernel-crypted copy that the can be used to verify.
+
+    Need more research into this.
+
+  - O(1) priority list: current plist is not O(1) in addition, because
+    it has to locate the proper position in the list where to add. I
+    plan to modify the plist code to be O(N) where N is the number of
+    priority levels, and as it is fixed at compilation time, it is
+    effectively O(1). 
+
+    The idea is to have something similar to a priority array, but
+    instead of having N list heads, we have only the first node of
+    each priority being the list head, and the rest of the guys in
+    that prio hanging from him.
+
+  - Sun-mode robustness. Solaris implements robustness in a slightly
+    more restrictive way. We want to add an small compatibility layer
+    so both models can be used.
+
+  - That page pinning when waiting for a fulock...
+
+
+FAQ
+---
+
+This set of Q&A is what I use myself to track my ideas and concepts
+(and not to forget why did I decide anything).
+
+
+Q: What is PI?
+
+Priority Inheritance: when task A holds resource R and task B claims
+it, and prio (B) > prio (A), then B can force A to take its priority
+so it finishes sooner and B can take the resource ownership. The
+priority boost ends when A releases R.
+
+
+Q: What is PP?
+
+Priority Protection: resources have an associated priority ceiling;
+any task that acquires a resource will have its prio raised to that
+prioirty ceiling while holding it.
+
+
+Q: What is RM?
+
+Robust Mutex, or robustness, for short: when the owner of a resource
+dies, we want the next owner to know that somebody died while holding
+the resource, so s/he is able to determine if a cleanup is needed.
+
+
+Q: What is a healthy fulock?
+
+This is a fulock in its normal state, that is: initialized and not in
+dead-owner or not-recoverable states.
+
+
+Q: What is a dead-owner fulock?
+
+A fulock is in dead-owner state when it was locked (some task owned
+it) and the task died without unlocking it.
+
+
+Q: What is a not-recoverable fulock?
+
+A fulock is in not-recoverable state when it went into dead-owner
+state and some task that acquired it in dead-owner state decided that
+it had to be made not-recoverable.
+
+The rationale behind this is that normally you have some lock
+protecting access to some data. When the lock goes dead-owner, the
+task that owned it and died could have died in the middle of updating
+the data, and thus it can be inconsistent. Subsequent owners of the
+lock get it with the dead-owner state, so that they are aware of the
+situation. If any of them can fix it, it can move the lock back to
+healthy state and continue operating, but if there is no way to fix
+the data, it is moved to not-recoverable state.
+
+When moved, all the pending waiters are given an error code
+(ENOTRECOVERABLE) indicating the new state, so that they can bail out
+and report up to their managers for what to do. As well, new
+contenders that try to acquire the lock will get also the EBADR error
+code.
+
+The only way to make the fulock healthy again is to reinitialized it.
+
+
+Q: What is a dead-owner dead-lock?
+
+When some task that has to unlock a locked fulock dies and others are
+waiting for it to release the fulock.
+
+
+Q: What is a dead-owner recovery?
+
+When a lock owner dies, the next waiter or next guy who locks and gets
+ownership gets it with an special code that indicates that some
+previous owner died and that the state of the lock is "dead-owner",
+that recovery on the data structures protected by the lock must be
+done in order to ensure consistency.
+
+Once a fulock is in dead-owner state, it can be moved back to
+normal/healthy or made inconsistent (so only an initialization returns
+it to normal).
+
+
+Q: Why does the kernel have to set the value of the fulock?
+   Why cannot the value of the fulock after unlock be set by user
+   space?
+
+This applies only to non-KCO (fast-path) mode fulocks.
+
+There is a risk of overwritten values and missed waiters.
+
+For example, task B claims fulock F (locked by task A) so it goes to
+the kernel to wait; now the fulock value is VFULOCK_WP (waiters
+blocked in the kernel). Before it reaches the kernel, task C releases
+the fulock for task A; as there are no waiters, it returns UNLOCKED
+and task C has to set it to UNLOCKED, thus overwriting VFULOCK_WP; as
+_WP is overwritten, task B is going to be dead-locked in the kernel,
+waiting.
+
+Furthermore, it helps guaranteeing robustness. If the just-woken up
+task that has to set the value the kernel passes dies before being
+able to do it, you hit a dead-owner dead-lock because nobody wakes up
+the waiters until somebody tries to lock and realizes the fulock is
+dead.
+
+
+Q: What are the two kinds of unlock?
+
+The two kinds of unlock are serialized and non-serialized. Each one is
+explained in more detail in the next two Qs.
+
+You need both because the serialized one can be slower, as it might
+force a context switch.
+
+I thought initially that this would show only in synthetic benchmarks
+(very tight loop acquiring and releasing the lock against some other
+threads doing the same thing), but I was wrong. Max Hailperin pointed
+to me that what I was seeing was the "Convoy Phenomenon", documented
+by Mike Blasgen, Jim Gray, Mike Mitoma and Tom Price, in 1977
+[http://portal.acm.org/citation.cfm?id=850659&jmp=cit&dl=GUIDE&dl=ACM]
+when I was still poking in my nose and sucking my thumb.
+
+After thinking about it, I concluded it would mostly apply in the
+following conditions:
+
+- user space only [in kernel space the lock itself is the spinlock
+  that protects the 'struct fulock'; we spin and disable preemtion, so
+  there is no context switch].
+
+- non real-time environments/processes (where preemption is likely)
+
+- real-time SMP environments with non-KCO fulocks, where two tasks
+  might compete for a lock at the _same_ time (so to avoid it in this
+  case, it might be interesting to spin a wee bit in user space before
+  blocking).
+
+Now, in order to gain robustness you need serialization (*), so a
+userspace user is recommended to use serialized wake ups only when:
+
+- need *full* and complete robustness guarantee
+
+- needs real-time priority-inversion protection guarantee (in SMP, not
+  needed for UP).
+
+(*) See the next Q, but summarizing: Task A holds M, task B and C are
+waiting; A unlocks(), non-serialized, M is unlocked (in the kernel,
+the vfulock is still VFULOCK_WP), A is woken up. A goes back to user
+space and contends, sees VFULOCK_WP and goes to the kernel to lock,
+but before he gets there, it dies. Now B is stuck there because the
+fulock is unlocked and nobody knew he was waiting.
+
+A way to solve this could be to mark the task B and fulock M as B
+should lock M. If on the way of death (do_exit()) we see that, we mark
+M as dead and initiate recovery in the next waiter. FIXME: need to
+research. 
+
+
+Q: What is a non-serialized unlock?
+
+A non-serialized unlock works by setting the fulock to unlocked and
+waking up as many waiters as desired. The waiters then re-contend for
+the fulock, the winner owns it and the others go back to wait on it.
+
+This approach is not as heavy in forcing context switches, and thus
+can yield better performance, avoiding the convoy phenomenon.
+
+However, drawbacks are that you loose priority-inversion protection
+and the ability to guarantee robustness.
+  
+- Say we have a fulock with M guys waiting and we wake up N (1 < N <
+  M), a non-serialized wakeup. Thus, there are M - N guys still
+  waiting in the kernel.
+  
+  In order for the unlock to be non-serialized, the waker first sets
+  the lock to UNLOCKED.
+  
+  Now, how do the woken up processes know that there are still
+  processes in the kernel?
+  
+  A solution is to set the vfulock not to UNLOCKED, but to _WP; this
+  way, whowever tries to acquire will see that and go down to the
+  kernel to do the lock operation.
+  
+  However, it still does not solve the fact that when setting to _WP
+  and waking N, if those N die before locking, the waiters go into
+  dead-owner dead-lock.
+  
+  When somebody tries to lock that, the kernel should be able to
+  notice that there are waiters and it is unlocked and thus give
+  way to the first locker with dead-owner recover --it might be too late.
+  
+  Another option might be to tag the woken-up processes before they
+  exit the kernel, so that if they die, do_exit can trap it (but there
+  are many side issues to this, like how do I make sure that the N who
+  I woke up have gone through it, one has locked, the other N-1 have
+  gone to sleep, how do I clean it up and stuff like that--makes it
+  pretty ugly, not to talk about how many resources it'd need to tag it).
+  
+  Gosh, it is a mess -- I would say that robust mutexes have to
+  require serialized unlocks. Period.
+
+  Not even talk about adding a short timer to verify that the thing
+  was locked...shrivers
+
+  RESEARCH: tentative ownership: when we wake up some guys who are
+  supposed to go and try to lock again, tie the fulock they should
+  lock to their task_struct and on exit(), check they don't have it
+  there ... [many details need to be worked out].
+
+- It could also be solved by waking up _all_ the waiters; this way no
+  dead-owner dead-lock could ever happen; however, it is a sure recipe
+  for an scheduling storm some day.
+
+
+Q: What is a serialized unlock?
+
+A serialized unlock transfers the ownership of the fulock to the first
+waiter in the kernel. 
+
+- Only one waiter can be woken up at the same time with this method.
+
+- It prevents priority inversion (as the fulock stays locked during
+  the whole operation no low priority thread can acquire it in the
+  meantime).
+
+- dead-owner dead-lock is not possible, because the owner is always
+  known during the operation. As well, if the new owner dies on it's
+  way up to user space, its ownership is also known.
+
+Slower (still not proved seriously--postulated and proven in some
+very synthetic benchmarks) because it forces a context switch.
+
+
+Q: What is an vfulock?
+
+It is the address in user space associated to a fulock in kernel
+space. 
+
+
+Q: What is owner identification?
+
+Owner identification is a property that the KCO ufulocks have:
+basically, they can identify who is the owner based on the vfulock (in
+user space) or the internal kernel data structures that refer to it
+(if the vfulock is VFULOCK_KCO, that means that the kernel tracks the
+ownership); if vfulock < VFULOCK_KCO, it means that the ownership is
+tracked only in user space, and the vfulock is the PID of the owner.
+
+
+Q: What is a kernel-controlled-ownership fulock? (KCO)
+
+A fulock that has no fast-path; every operation is done through the
+kernel.  This happens when:
+
+     - The fulock is locked and there are waiters on the kernel
+     - The fulock is dead (and the ownership keeps track for it)
+     - The fulock is a priority protected fulock or called with
+       FULOCK_FL_CO in the flags.
+
+Basically it is a way to indicate that the fastpath for
+locking/unlocking cannot be taken.
+
+
+Q: What is an ownership/wait chain?
+
+The structure that is formed when task A owns lock F and is waiting
+for lock G, owned by task B that is waiting for lock H, that is owned
+be task C that is waiting for lock I ... etc. 
+
+When this chain is circular (eg: lock I is owned by A) then there is a
+deadlock. Priority protection propagates through this chains, as well
+as priority changes in any part of the chain.
