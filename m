Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVLVXGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVLVXGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVLVXGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:06:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63381 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030360AbVLVXGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:06:12 -0500
Date: Fri, 23 Dec 2005 00:05:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 5/8] mutex subsystem, documentation
Message-ID: <20051222230510.GF13302@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add mutex-design.txt.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----
 Documentation/mutex-design.txt |  126 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+)

Index: linux/Documentation/mutex-design.txt
===================================================================
--- /dev/null
+++ linux/Documentation/mutex-design.txt
@@ -0,0 +1,126 @@
+
+Generic Mutex Subsystem
+
+started by Ingo Molnar <mingo@redhat.com>
+
+  "Why on earth do we need a new mutex subsystem, and what's wrong
+   with semaphores?"
+
+firstly, there's nothing wrong with semaphores. But if the simpler
+mutex semantics are sufficient for your code, then there are a couple
+of advantages of mutexes:
+
+ - 'struct mutex' is smaller: on x86, 'struct semaphore' is 20 bytes,
+   'struct mutex' is 16 bytes. A smaller structure size means less RAM
+   footprint, and better CPU-cache utilization.
+
+ - tighter code. On x86 i get the following .text sizes when
+   switching all mutex-alike semaphores in the kernel to the mutex
+   subsystem:
+
+        text    data     bss     dec     hex filename
+     3280380  868188  396860 4545428  455b94 vmlinux-semaphore
+     3255329  865296  396732 4517357  44eded vmlinux-mutex
+
+   that's 25051 bytes of code saved, or a 0.76% win - off the hottest
+   codepaths of the kernel. (The .data savings are 2892 bytes, or 0.33%)
+   Smaller code means better icache footprint, which is one of the
+   major optimization goals in the Linux kernel currently.
+
+ - the mutex subsystem is slightly faster and has better scalability for
+   contented workloads. On an 8-way x86 system, running a mutex-based
+   kernel and testing creat+unlink+close (of separate, per-task files)
+   in /tmp with 16 parallel tasks, the average number of ops/sec is:
+
+    Semaphores:                        Mutexes:
+
+    $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
+    8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
+    checking VFS performance.          checking VFS performance.
+    avg loops/sec:      34713          avg loops/sec:      84153
+    CPU utilization:    63%            CPU utilization:    22%
+
+   i.e. in this workload, the mutex based kernel was 2.4 times faster
+   than the semaphore based kernel, _and_ it also had 2.8 times less CPU
+   utilization. (In terms of 'ops per CPU cycle', the semaphore kernel
+   performed 551 ops/sec per 1% of CPU time used, while the mutex kernel
+   performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times
+   more efficient.)
+
+   the scalability difference is visible even on a 2-way P4 HT box:
+
+    Semaphores:                        Mutexes:
+
+    $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
+    4 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
+    checking VFS performance.          checking VFS performance.
+    avg loops/sec:      127659         avg loops/sec:      181082
+    CPU utilization:    100%           CPU utilization:    34%
+
+   (the straight performance advantage of mutexes is 41%, the per-cycle
+    efficiency of mutexes is 4.1 times better.)
+
+ - there are no fastpath tradeoffs, the mutex fastpath is just as tight
+   as the semaphore fastpath. On x86, the locking fastpath is 2
+   instructions:
+
+    c0377ccb <mutex_lock>:
+    c0377ccb:       f0 ff 08                lock decl (%eax)
+    c0377cce:       78 0e                   js     c0377cde <.text.lock.mutex>
+    c0377cd0:       c3                      ret
+
+   the unlocking fastpath is equally tight:
+
+    c0377cd1 <mutex_unlock>:
+    c0377cd1:       f0 ff 00                lock incl (%eax)
+    c0377cd4:       7e 0f                   jle    c0377ce5 <.text.lock.mutex+0x7>
+    c0377cd6:       c3                      ret
+
+ - 'struct mutex' semantics are well-defined and are enforced if
+   CONFIG_DEBUG_MUTEXES is turned on. Semaphores on the other hand have
+   virtually no debugging code or instrumentation. The mutex subsystem
+   checks and enforces the following rules:
+
+   * - only one task can hold the mutex at a time
+   * - only the owner can unlock the mutex
+   * - multiple unlocks are not permitted
+   * - recursive locking is not permitted
+   * - a mutex object must be initialized via the API
+   * - a mutex object must not be initialized via memset or copying
+   * - task may not exit with mutex held
+   * - memory areas where held locks reside must not be freed
+   * - held mutexes must not be reinitialized
+   * - mutexes may not be used in irq contexts
+
+   furthermore, there are also convenience features in the debugging
+   code:
+
+   * - uses symbolic names of mutexes, whenever they are printed in debug output
+   * - point-of-acquire tracking, symbolic lookup of function names
+   * - list of all locks held in the system, printout of them
+   * - owner tracking
+   * - detects self-recursing locks and prints out all relevant info
+   * - detects multi-task circular deadlocks and prints out all affected
+   *   locks and tasks (and only those tasks)
+
+Implementation of mutexes
+-------------------------
+
+'struct mutex' is the new mutex type, defined in include/linux/mutex.h
+and implemented in kernel/mutex.c. It is a counter-based mutex with a
+spinlock and a wait-list. The counter has 3 states: 1 for "unlocked",
+0 for "locked" and negative numbers (usually -1) for "locked, potential
+waiters queued".
+
+the APIs of 'struct mutex' have been streamlined:
+
+ DEFINE_MUTEX(name);
+
+ mutex_init(mutex);
+
+ void mutex_lock(struct mutex *lock);
+ int  mutex_lock_interruptible(struct mutex *lock);
+ int  mutex_trylock(struct mutex *lock);
+ void mutex_unlock(struct mutex *lock);
+ int  mutex_is_locked(struct mutex *lock);
+
