Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWAEPmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWAEPmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWAEPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:38:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61421 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932100AbWAEPiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:38:09 -0500
Date: Thu, 5 Jan 2006 16:37:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 09/21] mutex subsystem, documentation
Message-ID: <20060105153757.GJ31013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


Add mutex design related documentation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 Documentation/DocBook/kernel-locking.tmpl |   22 +++-
 Documentation/mutex-design.txt            |  135 ++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 8 deletions(-)

Index: linux/Documentation/DocBook/kernel-locking.tmpl
===================================================================
--- linux.orig/Documentation/DocBook/kernel-locking.tmpl
+++ linux/Documentation/DocBook/kernel-locking.tmpl
@@ -222,7 +222,7 @@
    <title>Two Main Types of Kernel Locks: Spinlocks and Semaphores</title>
 
    <para>
-     There are two main types of kernel locks.  The fundamental type
+     There are three main types of kernel locks.  The fundamental type
      is the spinlock 
      (<filename class="headerfile">include/asm/spinlock.h</filename>),
      which is a very simple single-holder lock: if you can't get the 
@@ -230,16 +230,22 @@
      very small and fast, and can be used anywhere.
    </para>
    <para>
-     The second type is a semaphore
+     The second type is a mutex
+     (<filename class="headerfile">include/linux/mutex.h</filename>): it
+     is like a spinlock, but you may block holding a mutex.
+     If you can't lock a mutex, your task will suspend itself, and be woken
+     up when the mutex is released.  This means the CPU can do something
+     else while you are waiting.  There are many cases when you simply
+     can't sleep (see <xref linkend="sleeping-things"/>), and so have to
+     use a spinlock instead.
+   </para>
+   <para>
+     The third type is a semaphore
      (<filename class="headerfile">include/asm/semaphore.h</filename>): it
      can have more than one holder at any time (the number decided at
      initialization time), although it is most commonly used as a
-     single-holder lock (a mutex).  If you can't get a semaphore,
-     your task will put itself on the queue, and be woken up when the
-     semaphore is released.  This means the CPU will do something
-     else while you are waiting, but there are many cases when you
-     simply can't sleep (see <xref linkend="sleeping-things"/>), and so
-     have to use a spinlock instead.
+     single-holder lock (a mutex).  If you can't get a semaphore, your
+     task will be suspended and later on woken up - just like for mutexes.
    </para>
    <para>
      Neither type of lock is recursive: see
Index: linux/Documentation/mutex-design.txt
===================================================================
--- /dev/null
+++ linux/Documentation/mutex-design.txt
@@ -0,0 +1,135 @@
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
+ - 'struct mutex' is smaller on most architectures: .e.g on x86,
+   'struct semaphore' is 20 bytes, 'struct mutex' is 16 bytes.
+   A smaller structure size means less RAM footprint, and better
+   CPU-cache utilization.
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
+   contended workloads. On an 8-way x86 system, running a mutex-based
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
+Disadvantages
+-------------
+
+The stricter mutex API means you cannot use mutexes the same way you
+can use semaphores: e.g. they cannot be used from an interrupt context,
+nor can they be unlocked from a different context that which acquired
+it. [ I'm not aware of any other (e.g. performance) disadvantages from
+using mutexes at the moment, please let me know if you find any. ]
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
