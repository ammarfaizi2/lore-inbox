Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262268AbSIPPhX>; Mon, 16 Sep 2002 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSIPPhX>; Mon, 16 Sep 2002 11:37:23 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16240 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262268AbSIPPhV>; Mon, 16 Sep 2002 11:37:21 -0400
Date: Mon, 16 Sep 2002 17:42:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Oops in sched.c on PPro SMP
Message-ID: <20020916154233.GH11605@dualathlon.random>
References: <174178B9-C980-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174178B9-C980-11D6-8873-00039387C942@mac.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 04:25:03PM +0200, Peter Waechtler wrote:
> Process setiathome (pid: 2035, stackpage=c45d3000)
	  ^^^^^^^^^^ stress the cpu

>      651:   81 f9 00 00 00 00       cmp    $0x0,%ecx
				      ^^^^^^^^^^^^^^^^^
>      657:   74 26                   je     67f <schedule+0x26f>
>      659:   bb 14 00 00 00          mov    $0x14,%ebx
>      65e:   89 f6                   mov    %esi,%esi
>             p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
>      660:   8b 51 20                mov    0x20(%ecx),%edx  <= CRASH
>      663:   d1 fa                   sar    %edx
>      665:   89 d8                   mov    %ebx,%eax
>      667:   2b 41 24                sub    0x24(%ecx),%eax
>      66a:   c1 f8 02                sar    $0x2,%eax
>      66d:   8d 54 10 01             lea    0x1(%eax,%edx,1),%edx
>      671:   89 51 20                mov    %edx,0x20(%ecx)
>      674:   8b 49 48                mov    0x48(%ecx),%ecx
>      677:   81 f9 00 00 00 00       cmp    $0x0,%ecx
				      ^^^^^^^^^^^^^^^^
>      67d:   75 e1                   jne    660 <schedule+0x250>
>         read_unlock(&tasklist_lock);
>      67f:   f0 ff 05 00 00 00 00    lock incl 0x0
>         spin_lock_irq(&runqueue_lock);
>      686:   fa                      cli

as you said apparently ecx cannot be zero. But I bet the 0x00 really is
waiting relocation at link time. that shouldn't be zero infact, it
should be the address of the init_task (&init_task). 

Can you disassemble the .o object using objdump -Dr or can you disassemble such
piece of code from the vmlinux instead of compiling with the -S flag to
verify that to verify that? If it really checks against zero then it's a
miscompilation, it should check against &init_task as said above.

> First I thought the readlocks were broken by the compiler, due
> to syntax changes. But staring at the code I wondered how
> %ecx can become zero at 660: - from this code it's impossible!
> But wait: we allowed interrupts again...
> 
> So my explanation is as follows: the scheduler is interrupted
> and entry.S calls:

interrupts cannot clobber %ecx or change the tasklist, if they clobber
%ecx or modify the tasklist that would be the real bug.

> So there are 2 possibilities: the spin_unlock_irq(&runqueue_lock)
> is wrong in the scheduler, but this should be noted by more SMP
> users then, or the CONFIG_X86_PPRO_FENCE does not work as expected.

the PPRO_FENCE is strictier than the non FENCE one. However here the
corruption you notice is in the tasklist, and the read/write locks are
not affected by the FENCE option, so FENCE isn't likely to explain it.

If something I would suspect something wrong in the read/write
spinlocks, to rule out such possibility you could for example try to
replace all the read_lock and write_lock around the tasklist with
spin_lock_irqsave/spin_lock_irqrestore. So that you would use the FENCE
xchg functionality around the tasklist too and you would also make sure
that no irq can happen in between, just to be 100% sure that if it
crashes it's because the memory is corrupted somehow. But really, the
read/write locks just use the lock on the bus when they modify the
spinlock value so I'd be *very* surprised if that doesn't work on ppro.
The non-FENCE case of recent cpus is used to skip the lock on the bus
during the unlock operation to exploit the release semantics of all
writes to memory in writeback cache mode of the recent x86 (that allows
unrelated speculative reads outside the critical section to enter
inside).

I really suspect an hardware fault here, if you could reproduce easily
you could try to drop a dimm of ram and retest, you can also try memtst
from cerberus testsuite or/and memtest86 from the lilo menu.

the tasklist walking very likely is triggering very quick cacheline
bouncing and lots of ram I/O, 99% of hardware bugs triggers while
walking lists because of the cpu-dcache trashing and the ram cannot cope
with it. Probably the O1 scheduler would hide the problem because it
drops such tight loop. Note that the 2.4.18 SuSE kernel scheduler
algorithm is O(N) where N is always the number of running tasks, never the
total number of tasks in the system, while in mainline the scheduler is
O(N) where N is the total number of tasks in the system, this mean
normally in mainline you can walk a list with 100/500 elements, while
with the SuSE kernel you'll walk a list of always around 2/3 elements,
depends on the workload of course. The O1 scheduler included in 8.1
reduces N to a constant 1.  So if you cannot reproduce with the SuSE 8.0
kernel could be simply because you've lots of tasks in your system but
only a few of them runs at the same time. That's a dramatic optimization
in the SuSE kernel but it's not a bugfix, it only hides the corruption
in your case methinks, like the O1 scheduler in 8.1 will hide it even
better, even if you have lots of tasks running at the same time ;). It
is true to walk the runqueue we need the runqueue_lock that needs irq
disabled, but regardless irqs must not screwup anything in the tasklist.

So I would say, it's either an hardware issue, or random memory
corruption generated by some driver. Just some guesses. And if it's the
irq clobbering the %ecx or the tasklist then something is very wrong in
the irq code or in the hardware (I'd exclude such possibility, but you
can try adding _irq to the read_lock/read_unlock of the tasklist_lock to
disable irq and see if you can still reproduce). If %ecx is checked
against zero as well something is very wrong, but in the compiler, and
that would explain things too (you're recommended to use either 2.95 or
3.2).

Hope this helps,

Andrea
