Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVLSBfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVLSBfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVLSBfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:35:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8423 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030216AbVLSBfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:35:12 -0500
Date: Mon, 19 Dec 2005 02:34:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219013415.GA27658@elte.hu>
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


The following patchset is a split-up and streamlined version of the 
generic mutex subsystem that we have in the -rt kernel, ported to the 
upstream kernel. (To reduce the confusion: this code is unrelated to the 
'simple mutex' code recently posted by David Howells.)

the patchset can also be found at:

  http://redhat.com/~mingo/generic-mutex-subsystem/

This patchset is intended to address most (and hopefully all) of the 
objections (and suggestions) raised here in last week's mutex 
discussion. Since there were many issues raised in that thread (and i 
really have read all of them), the answers are unfortunately quite 
extensive too. I think i have the right answer to each of them, embedded 
somewhere below, just be patient and bear with this long email before 
forming an opinion about the feasibility of this approach ;-)

QA status: this is prototype code that supports i386 and x86_64 (SMP and 
UP) at the moment - but it is what i believe could be ported to every 
architecture, and could be merged into the upstream kernel in due 
course. All suggestions to further improve it are welcome.

But firstly, i'd like to answer the most important question:

  "Why the hell do we need a new mutex subsystem, and what's wrong 
   with semaphores??"

This question is clearly nagging most of the doubters, so i'm listing my 
answers first, before fully explaining the patchset. (For more 
implementational details, see the subseqent sections.)

here are the top 10 reasons of why i think the generic mutex code should 
be considered for upstream integration:

 - 'struct mutex' is smaller: on x86, 'struct semaphore' is 20 bytes, 
   'struct mutex' is 16 bytes. A smaller structure size means less RAM 
   footprint, and better CPU-cache utilization.

 - tighter code. On x86 i get the following .text sizes when 
   switching all mutex-alike semaphores in the kernel to the mutex 
   subsystem:

        text    data     bss     dec     hex filename
     3280380  868188  396860 4545428  455b94 vmlinux-semaphore
     3255329  865296  396732 4517357  44eded vmlinux-mutex

   that's 25051 bytes of code saved, or a 0.76% win - off the hottest 
   codepaths of the kernel. (The .data savings are 2892 bytes, or 0.33%) 
   Smaller code means better icache footprint, which is one of the 
   major optimization goals in the Linux kernel currently.

 - the mutex subsystem is faster and has superior scalability for 
   contented workloads. On an 8-way x86 system, running a mutex-based 
   kernel and testing creat+unlink+close (of separate, per-task files)
   in /tmp with 16 parallel tasks, the average number of ops/sec is:

    Semaphores:                        Mutexes:

    $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
    8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
    checking VFS performance.          checking VFS performance.
    avg loops/sec:      34713          avg loops/sec:      84153
    CPU utilization:    63%            CPU utilization:    22%

   i.e. in this workload, the mutex based kernel was 2.4 times faster 
   than the semaphore based kernel, _and_ it also had 2.8 times less CPU 
   utilization. (In terms of 'ops per CPU cycle', the semaphore kernel 
   performed 551 ops/sec per 1% of CPU time used, while the mutex kernel 
   performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times 
   more efficient.)

   the scalability difference is visible even on a 2-way P4 HT box:

    Semaphores:                        Mutexes:

    $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
    4 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
    checking VFS performance.          checking VFS performance.
    avg loops/sec:      127659         avg loops/sec:      181082
    CPU utilization:    100%           CPU utilization:    34%

   (the straight performance advantage of mutexes is 41%, the per-cycle 
    efficiency of mutexes is 4.1 times better.)

 - there are no fastpath tradeoffs, the mutex fastpath is just as tight 
   as the semaphore fastpath. On x86, the locking fastpath is 2 
   instructions:

    c0377ccb <mutex_lock>:
    c0377ccb:       f0 ff 08                lock decl (%eax)
    c0377cce:       78 0e                   js     c0377cde <.text.lock.mutex>
    c0377cd0:       c3                      ret

   the unlocking fastpath is equally tight:

    c0377cd1 <mutex_unlock>:
    c0377cd1:       f0 ff 00                lock incl (%eax)
    c0377cd4:       7e 0f                   jle    c0377ce5 <.text.lock.mutex+0x7>
    c0377cd6:       c3                      ret

 - the per-call-site inlining cost of the slowpath is cheaper and 
   smaller than that of semaphores, by one instruction, because the 
   mutex trampoline code does not do a "lea %0,%%eax" that the semaphore 
   code does before calling __down_failed. The mutex subsystem uses out 
   of line code currently so this makes only a small difference in .text
   size, but in case we want to inline mutexes, they will be cheaper 
   than semaphores.

 - No wholesale or dangerous migration path. The migration to mutexes is 
   fundamentally opt-in, safe and easy: multiple type-based and .config 
   based migration helpers are provided to make the migration to mutexes 
   easy. Migration is as finegrained as it gets, so robustness of the 
   kernel or out-of-tree code should not be jeopardized at any stage.  
   The migration helpers can be eliminated once migration is completed, 
   once the kernel has been separated into 'mutex users' and 'semaphore 
   users'. Out-of-tree code automatically defaults to semaphore 
   semantics, mutexes are not forced upon anyone, at any stage of the 
   migration.

 - 'struct mutex' semantics are well-defined and are enforced if
   CONFIG_DEBUG_MUTEXES is turned on. Semaphores on the other hand have 
   virtually no debugging code or instrumentation. The mutex subsystem 
   checks and enforces the following rules:

   * - only one task can hold the mutex at a time
   * - only the owner can unlock the mutex
   * - multiple unlocks are not permitted
   * - recursive locking is not permitted
   * - a mutex object must be initialized via the API
   * - a mutex object must not be initialized via memset or copying
   * - task may not exit with mutex held
   * - memory areas where held locks reside must not be freed

   furthermore, there are also convenience features in the debugging 
   code:

   * - uses symbolic names of mutexes, whenever they are printed in debug output
   * - point-of-acquire tracking, symbolic lookup of function names
   * - list of all locks held in the system, printout of them
   * - owner tracking
   * - detects self-recursing locks and prints out all relevant info
   * - detects multi-task circular deadlocks and prints out all affected
   *   locks and tasks (and only those tasks)

   we have extensive experience with the mutex debugging code in the -rt
   kernel, and it eases the debugging of mutex related bugs 
   considerably. A handful of upstream bugs were found as well this
   way, and were contributed back to the vanilla kernel. We do believe 
   that improved debugging code is an important tool in improving the 
   fast-paced upstream kernel's quality.

   a side-effect of the strict semantics is that mutexes are much easier 
   to analyze on a static level. E.g. Sparse could check the correctness 
   of mutex users, further improving the kernel's quality. Also, the
   highest-level security and reliability validation techniques (and 
   certification processes) involve static code analysis.

 - kernel/mutex.c is generic, and has minimal per-arch needs. No new 
   primitives have to be implemented to support spinlock-based generic 
   mutexes. Only 2 new atomic primitives have to be implemented for an 
   architecture to support optimized, lockless generic mutexes. In 
   contrast, to implement semaphores on a new architecture, hundreds of 
   lines of nontrivial (often assembly) code has to be written and 
   debugged.

 - kernel/mutex.c is highly hackable. New locking features can be 
   implemented in C, and they carry over to every architecture.  
   Extensive self-consistency debugging checks of the mutex
   implementation are done if CONFIG_DEBUG_MUTEXES is turned on. I do 
   think that hackability is the most important property of 
   kernel code.

 - the generic mutex subsystem is also one more step towards enabling 
   the fully preemptable -rt kernel. Ok, this shouldnt bother the 
   upstream kernel too much at the moment, but it's a personal driving
   force for me nevertheless ;-)

   (NOTE: i consciously did not list 'Priority Inheritance' amongst the 
    reasons, because priority inheritance for blocking kernel locks 
    would be a misguided reason at best, and flat out wrong at worst.)


Implementation of mutexes
-------------------------

there are two central data types:

  - 'struct mutex'
  - 'struct arch_semaphore'

'struct mutex' is the new mutex type, defined in include/linux/mutex.h 
and implemented in kernel/mutex.c. It is a counter-based mutex with a 
spinlock and a wait-list.

'struct arch_semaphore' is the 'struct semaphore' type and 
implementation, defined and implemented in include/asm-*/semaphore.h and 
in various other arch-level files.

NOTE: the patchset does _NO_ wholesale renaming of 'struct semaphore' to 
'struct arch_semaphore'. The limited renaming of 'struct semaphore' to 
'struct arch_semaphore' is only technical, and affects only a limited 
amount of architecture-level code. It does _not_ spread out into the 
generic kernel itself. The reason for this renaming is to make migration 
to mutexes safer and easier.

the APIs of 'struct mutex' have been streamlined:

 DEFINE_MUTEX(name);

 mutex_init(mutex);
 
 void mutex_lock(struct mutex *lock);
 int  mutex_lock_interruptible(struct mutex *lock);
 int  mutex_trylock(struct mutex *lock);
 void mutex_unlock(struct mutex *lock);
 int  mutex_is_locked(struct mutex *lock);

the APIs of 'struct arch_semaphore' are the well-known semaphore APIs:

 DECLARE_ARCH_MUTEX(name)
 DECLARE_ARCH_MUTEX_LOCKED(name)

 void arch_sema_init(struct arch_semaphore *sem, int val);
 void arch_init_MUTEX(struct arch_semaphore *sem);
 void arch_init_MUTEX_LOCKED(struct arch_semaphore *sem);
 void arch_down(struct arch_semaphore * sem);
 int arch_down_interruptible(struct arch_semaphore * sem);
 int arch_down_trylock(struct arch_semaphore * sem);
 void arch_up(struct arch_semaphore * sem);
 int arch_sem_is_locked(struct arch_semaphore *sem);
 arch_sema_count(sem)

NOTE: no non-mutex subsystem will ever make use of these arch_-prefixed 
API calls - they are all hidden within type-switching macros. So no 
wholesale migration of the semaphore APIs is done.


The migratio path to mutexes
----------------------------

there are two other sub-types implemented as well, to ease migration and 
to enable debugging. They are:

  - 'struct semaphore'
  - 'struct mutex_debug'

'Break The World' approaches are unacceptable. By default, 'struct 
semaphore' is mapped to the plain semaphore implementation of the 
architecture - bit for bit equivalent and compatible. The APIs are the 
well-know down()/up()/etc. APIs, and they are bit for bit equivalent to 
the vanilla kernel's semaphore implementation. This property is crutial 
to be able to introduce the mutex subsystem in the stable kernel series.  
Doing anything else would be a non-starter.

'struct mutex_debug' is a debugging variant of mutexes: it can be used 
with both sets of APIs, both with the semaphore APIs and with the mutex 
APIs. E.g.:

	struct mutex_debug sem;

	down(&sem);
	...
	up(&sem);
	...
	down(&sem);
	...
	up(&sem);

will be mapped by the kernel to mutex_lock() and mutex_unlock(). The 
code can be changed back to a semaphore by changing the 'struct 
mutex_debug sem' line to 'struct semaphore sem'. The actual down()/up() 
calls in the code do not have to be modified for this type of migration.

thus 'struct mutex_debug' is the natural starting point for migrating a 
kernel subsystem or driver over to mutexes: just change the 'struct 
semaphore' data definition to 'struct mutex_debug', and rebuild the 
kernel - the whole subsystem will use mutexes from that point on. If 
there are any problems with the migration, switch the data type back to 
'struct semaphore' and forget about mutexes. If the migration proves to 
be successful, change the data type to 'struct mutex' and fix up all the 
API uses to use the mutex variants.

there are .config debugging options that change the meaning of 'struct 
semaphore': e.g. CONFIG_DEBUG_MUTEX_FULL switches all semaphores over to 
mutexes. All semaphores, except the ones that have been marked 
arch_semaphore. (see the arch-semaphores.patch sub-patch) The 
DEBUG_MUTEX_FULL debugging mode is fully functional on all of my 
testsystems, but since it's equivalent to a wholesale conversion to 
mutexes, it cannot be guaranteed to be safe. But it is a nice debugging 
option nevertheless, and can be used to verify the mutex subsystem.

so to summarize, these types enable the finegrained and robust 
separation of the kernel's semaphores into 3 categories:

- mutexes (first 'struct mutex_debug', then 'struct mutex')

- counting semaphores (first 'struct semaphore', then
                       'struct arch_semaphore'

- unknown, unreviewed ('struct semaphores')

the 'mutex conversion' process would act on the 'unknown' pool, and 
would move semaphores into one of the two groups, one by one.

out-of-tree semaphore users are safe by default in this scheme: they get 
into the 'unknown' pool and are hence conservatively assumed to be full 
semaphores.

once all semaphores have been safely categorized and converted to one 
group or another, and all out-of-tree codebases are fixed and a 
deprecation period has passed, we can rename arch_semaphores back to 
'struct semaphore'.


Status of the patch-queue
-------------------------

the patch-series currently builds and boots on i386 and x86_64. It 
consists of 15 finegrained patches:

  add-atomic-xchg-i386.patch
  add-atomic-xchg-x86_64.patch
  add-atomic-call-func-i386.patch
  add-atomic-call-func-x86_64.patch

  mutex-core.patch

  mutex-debug.patch
  mutex-debug-more.patch

  mutex-migration-helper-i386.patch
  mutex-migration-helper-x86_64.patch
  mutex-migration-helper-core.patch

  sx8-sem2completions.patch
  cpu5wdt-sem2completions.patch
  ide-gendev-sem-to-completion.patch
  loop-to-completions.patch

  arch-semaphores.patch

these patches, ontop of Linus' current -git tree, build and boot at all 
of these stages, and the mutex-kernel is fully functional with all 
patches applied, in both debug and non-debug mode.

reports, suggestions, fixes are welcome.

	Ingo
