Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLVMVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLVMVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVLVMVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:21:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6284 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932125AbVLVMVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:21:02 -0500
Date: Thu, 22 Dec 2005 13:20:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222122011.GA20789@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222035443.19a4b24e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222035443.19a4b24e.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> I've only been following this with half an eye, with the apparently 
> erroneous expectation that future versions of the patchset would come 
> with some explanation of why on earth we'd want to merge all this 
> stuff into the kernel.

in my initial announcement i listed 10 good reasons to do so, and they 
are still true:

http://people.redhat.com/mingo/generic-mutex-subsystem/mutex-announce.txt
[...]

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
