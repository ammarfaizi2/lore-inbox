Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbQKNDsN>; Mon, 13 Nov 2000 22:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129869AbQKNDsD>; Mon, 13 Nov 2000 22:48:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34834 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129791AbQKNDrr>; Mon, 13 Nov 2000 22:47:47 -0500
Date: Tue, 14 Nov 2000 04:17:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: richardj_moore@uk.ibm.com, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001114041732.C14013@athlon.random>
In-Reply-To: <80256996.00264A4F.00@d06mta06.portsmouth.uk.ibm.com> <20001113113823.A24003@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001113113823.A24003@gruyere.muc.suse.de>; from ak@suse.de on Mon, Nov 13, 2000 at 11:38:23AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 11:38:23AM +0100, Andi Kleen wrote:
> notifier lists would be sufficient because dprobes does not hook into any 
> performance critical paths. 

Current dprobes patch adds branches in the the main page fault handler,
device_not_available exception at least. Those are _very_ hot paths.

I had a look at gkhi and infact my guess is that the main reason of
implementing gkhi in first place is probably because they had to remove the
branches from the fast paths when dprobes is inactive by using self modifying
code to only have some additional nop in the exception fast paths during
production, and while doing that they probably choosed to generalize the
lightweight self modifying hook interface instead of doing a magic inside the
dprobes patch.

But (unless I'm missing something in the code :) gkhi has absolutely _nothing_
new with respect to binary modules except being able to introduce less costly
hooks in term of performance _only_when_ the hooks are unregistered (= when
machine is in production). It's only a matter of performance as far I can see.
To introduce a new hook using gkhi it's necessary to change the kernel sources,
recompile the kernel just like for every other module registration hook that we
just have in 2.4.0-test11-pre2. The modules using gkhi interface needs the hook
details (were the self modifying code is placed) exported via /proc/ksyms
infact, just like for any other regular hook registered via the init_module
without using self modifying code.

So binary only modules using gkhi _can't_ have _any_ "binary level" advantage
compared to all other regular binary only modules for 2.2.x and 2.4.x that
doesn't use gkhi.

And even if they did the other way around - so having gkhi on top of dprobes -
they would not only been dependent on symbols, but they would depend on almost
everything including a recompile of the kernel that doesn't affect the symbols
and they would be still add branches in the exception handlers as current
dprobe patch is doing. Not to tell that the dprobes hooks are very inefficient
and unsuitable for productions if they're recalled at high frequency in fast
paths since there are all generating CPU exceptions that have the same latency
of an enter/exit kernel every time an hook triggers plus there's the
interpreter that must execute the hook.

I think gkhi is good idea to be able to implement lightweight hooks that are
unregistered during production as it avoid the cost of dereferencing pointers
in a linked list to know if we have any hook registered or not.  dprobes is
perfect user of the lightweight gkhi interface. However they're useful __only__
when the hook is unregistred all the time during production.  For example
replacing the binfmt chain with gkhi would decrease performance because
gkhi force the hook handling to happen out of line. I don't think there's any
hook in a hot path and unregistered all the time in the current kernels so I
think only point of merging gkhi would be only to merge a more efficient
implementation of dprobes.

I think gkhi should be renamed to something like "Fast Unregistered Kernel
Hook Interface" to avoid confusion and wrong usage of it that would otherwise
leads to lower performance.

I've a few comments about the implementation:

__asm__ volatile (".global GKHook"h"; 
		.global GKHook"h"_ret; 
		.global GKHook"h"_bp; 
		GKHook"h": jmp GKHook"h"_bp; /* nop; to activate */  
			   ^^^^^^^^^^^^^^^^
			push $0; 
			nop;nop;nop;nop;nop; /* jmp GKHook"h"_dsp when active*/
	 	GKHook"h"_ret: add $4,%%esp;   
		GKHook"h"_bp:;":::"%eax")
				   ^^^^

1)

It would be better to have only 5 nop instructions (instead of more
instructions and a jmp over them) and patch them at runtime as soon as somebody
registers the hook to generate a `call hook_handler_1'. This will also save
icache.

For the atomicity of the operation in SMP (of the update of the 5 nops to call
the dispatcher) we should probably have a fixup entry in place for the GKHook
address, so that we can fixup the 5th byte after lefting an invalid opcode at
the first byte.

2)

eax needs to be saved internally to the hook. We must only add the 5 nop
penality in the unregistered case and primarly on x86 with so few regs we
really want to have the fast path not having to save/restore eax on the stack
across every nop gkhi hook.

3)

gkhi apparently doesn't yet know the word "SMP" 8).

4)

gkh_iflush should be done with flush_icache_range that is infact implemented
wrong for IA32 and it should be implemented as regs trashing cpuid (the fact
it's wrongly implemented means that in theory modules can break in IA32
on 2.4.x 2.2.x even on UP).

5)

Current dprobes v1.1.1 against 2.2.16 cames with a syscall collision:
sys_dprobes collides with ugetrlimit (not implemented in 2.2.x). That's fine
for internal use and to show the code, but make _sure_ not to ship any binary
to anybody implementing ugetrlimit as sys_dprobes 8).

Richard please ask Linus to reserve a syscall for dprobes. I recommend to
allocate the syscall out of the way (I mean using syscall 255 or even better
enlarging the syscall table from 256 to 512 and using number 511) so we make
sure not to waste precious dcachelines for debugging stuff.

BTW, for things like lkcd there's no reason to use gkhi to make it completly
modular since lkcd gets recalled in a completly slow path.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
