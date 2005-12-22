Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVLVNJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVLVNJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVLVNJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:09:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965015AbVLVNJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:09:07 -0500
Date: Thu, 22 Dec 2005 05:07:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051222050701.41b308f9.akpm@osdl.org>
In-Reply-To: <20051222122011.GA20789@elte.hu>
References: <20051222114147.GA18878@elte.hu>
	<20051222035443.19a4b24e.akpm@osdl.org>
	<20051222122011.GA20789@elte.hu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> ... 
>
> here are the top 10 reasons of why i think the generic mutex code should 
> be considered for upstream integration:

Appropriate for the changelog, please.

>  - 'struct mutex' is smaller: on x86, 'struct semaphore' is 20 bytes, 
>    'struct mutex' is 16 bytes. A smaller structure size means less RAM 
>    footprint, and better CPU-cache utilization.

Because of the .sleepers thing.  Perhaps a revamped semaphore wouldn't need
thsat field?

>  - tighter code. On x86 i get the following .text sizes when 
>    switching all mutex-alike semaphores in the kernel to the mutex 
>    subsystem:
> 
>         text    data     bss     dec     hex filename
>      3280380  868188  396860 4545428  455b94 vmlinux-semaphore
>      3255329  865296  396732 4517357  44eded vmlinux-mutex
> 
>    that's 25051 bytes of code saved, or a 0.76% win - off the hottest 
>    codepaths of the kernel. (The .data savings are 2892 bytes, or 0.33%) 
>    Smaller code means better icache footprint, which is one of the 
>    major optimization goals in the Linux kernel currently.

Why is the mutex-using kernel any smaller?  IOW: from where do these
savings come?

>  - the mutex subsystem is faster and has superior scalability for 
>    contented workloads. On an 8-way x86 system, running a mutex-based 
>    kernel and testing creat+unlink+close (of separate, per-task files)
>    in /tmp with 16 parallel tasks, the average number of ops/sec is:
> 
>     Semaphores:                        Mutexes:
> 
>     $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
>     8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
>     checking VFS performance.          checking VFS performance.
>     avg loops/sec:      34713          avg loops/sec:      84153
>     CPU utilization:    63%            CPU utilization:    22%
> 
>    i.e. in this workload, the mutex based kernel was 2.4 times faster 
>    than the semaphore based kernel, _and_ it also had 2.8 times less CPU 
>    utilization. (In terms of 'ops per CPU cycle', the semaphore kernel 
>    performed 551 ops/sec per 1% of CPU time used, while the mutex kernel 
>    performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times 
>    more efficient.)
> 
>    the scalability difference is visible even on a 2-way P4 HT box:
> 
>     Semaphores:                        Mutexes:
> 
>     $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
>     4 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
>     checking VFS performance.          checking VFS performance.
>     avg loops/sec:      127659         avg loops/sec:      181082
>     CPU utilization:    100%           CPU utilization:    34%
> 
>    (the straight performance advantage of mutexes is 41%, the per-cycle 
>     efficiency of mutexes is 4.1 times better.)

Why is the mutex-using kernel more scalable?

Can semaphores be tuned to offer the same scalability improvements?

> ...
>
>  - the per-call-site inlining cost of the slowpath is cheaper and 
>    smaller than that of semaphores, by one instruction, because the 
>    mutex trampoline code does not do a "lea %0,%%eax" that the semaphore 
>    code does before calling __down_failed. The mutex subsystem uses out 
>    of line code currently so this makes only a small difference in .text
>    size, but in case we want to inline mutexes, they will be cheaper 
>    than semaphores.

Cannot the semaphore code be improved in the same manner?

>  - No wholesale or dangerous migration path. The migration to mutexes is 
>    fundamentally opt-in, safe and easy: multiple type-based and .config 
>    based migration helpers are provided to make the migration to mutexes 
>    easy. Migration is as finegrained as it gets, so robustness of the 
>    kernel or out-of-tree code should not be jeopardized at any stage.  
>    The migration helpers can be eliminated once migration is completed, 
>    once the kernel has been separated into 'mutex users' and 'semaphore 
>    users'. Out-of-tree code automatically defaults to semaphore 
>    semantics, mutexes are not forced upon anyone, at any stage of the 
>    migration.

IOW: a complete PITA, sorry.

>  - 'struct mutex' semantics are well-defined and are enforced if
>    CONFIG_DEBUG_MUTEXES is turned on. Semaphores on the other hand have 
>    virtually no debugging code or instrumentation. The mutex subsystem 
>    checks and enforces the following rules:
> 
>    * - only one task can hold the mutex at a time
>    * - only the owner can unlock the mutex
>    * - multiple unlocks are not permitted
>    * - recursive locking is not permitted
>    * - a mutex object must be initialized via the API
>    * - a mutex object must not be initialized via memset or copying
>    * - task may not exit with mutex held
>    * - memory areas where held locks reside must not be freed

Pretty much all of that could be added to semaphores-when-used-as-mutexes. 
Without introducing a whole new locking mechanism.

>    furthermore, there are also convenience features in the debugging 
>    code:
> 
>    * - uses symbolic names of mutexes, whenever they are printed in debug output
>    * - point-of-acquire tracking, symbolic lookup of function names
>    * - list of all locks held in the system, printout of them
>    * - owner tracking
>    * - detects self-recursing locks and prints out all relevant info
>    * - detects multi-task circular deadlocks and prints out all affected
>    *   locks and tasks (and only those tasks)

Ditto, I expect.

>  - the generic mutex subsystem is also one more step towards enabling 
>    the fully preemptable -rt kernel. Ok, this shouldnt bother the 
>    upstream kernel too much at the moment, but it's a personal driving
>    force for me nevertheless ;-)

Actually that's the only compelling reason I've yet seen, sorry.

What is it about these mutexes which is useful to RT and why cannot that
feature be provided by semaphores?


Ingo, there appear to be quite a few straw-man arguments here.  You're
comparing a subsystem (semaphores) which obviously could do with a lot of
fixing and enhancing with something new which has had a lot of recent
feature work out into it.

I'd prefer to see mutexes compared with semaphores after you've put as much
work into improving semaphores as you have into developing mutexes.
