Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSIEJMt>; Thu, 5 Sep 2002 05:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSIEJMt>; Thu, 5 Sep 2002 05:12:49 -0400
Received: from holomorphy.com ([66.224.33.161]:7082 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317334AbSIEJMq>;
	Thu, 5 Sep 2002 05:12:46 -0400
Date: Thu, 5 Sep 2002 02:08:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] __write_lock_failed() oops
Message-ID: <20020905090830.GF888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020905080310.GF18800@holomorphy.com> <3D77190C.F4562547@zip.com.au> <20020905083240.GC888@holomorphy.com> <20020905084502.GD888@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020905084502.GD888@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 01:42:52AM -0700, Andrew Morton wrote:
>>> That's all the assembly hacks in the rwlock code not having proper
>>> stack frames.  You may have to ksymoops it.
>> At a guess: use-after-free bug against an address_space.  You may
>>> be able to catch it with slab poisoning.

> On Thu, Sep 05, 2002 at 01:32:40AM -0700, William Lee Irwin III wrote:
>> (gdb) p/x $eax
>> $25 = 0xc0331ca0
>> (gdb) p &tasklist_lock
>> $27 = (rwlock_t *) 0xc0331ca0

On Thu, Sep 05, 2002 at 01:45:02AM -0700, William Lee Irwin III wrote:
> The NMI oopser is going here as well (nmi_watchdog=2 for extra safety)
> so I suspect the tasklist_lock semantics are behaving badly. But it's
> not easily reproducible enough to test a quick attempt at a fix if it
> can't be recognized a priori.
> This is literally so difficult to reproduce it hasn't been seen in 2
> releases. kgdb is still going and dhowells is helping me fish stuff
> off the stack.

Here is the IRC log of the analysis. I'm leaving the machine untouched
so kgdb may be used later on if facts are called into question.

Cheers,
Bill

<wli> $3 = 0xc0331ca0
<wli> (gdb) p/x *(unsigned long *)$eax
<wli> $4 = 0xffffff
<dhowells> unless the code itself is corrupted
<dhowells> it looks reasonable
<wli> what else should I look for?
<wli> Could the NMI oopser possibly oops it in this situation?
<dhowells> what's the oops say at the beginning?
<dhowells> ad which insn did it oops on?
<dhowells> s/ad/and/
<wli> dhowells: I was running kgdb:
<wli> Program received signal SIGSEGV, Segmentation fault.
--> tkks (~kes@rrcs-se-24-129-177-178.biz.rr.com) has joined #kernel
<wli> 0xc0106693 in __write_lock_failed () at semaphore.c:176
<wli> 176     semaphore.c: No such file or directory.
<wli>         in semaphore.c
<wli> 0xc0106693 <__write_lock_failed+15>:    
<wli>     jne    0xc010668b <__write_lock_failed+7>
<dhowells> it oopsed on _jne_?
<wli> dhowells: NFI -- this is all I see.
<wli> dhowells: I've stared at this several times in the past.
<dhowells> load the vmlinux file into gdb and do "disas 0xc0106693"
<wli> dhowells: it matches
--> benh (~benh@m86.net195-132-236.noos.fr) has joined #kernel
<dhowells> do you still have kgdb attached to the dying box?
<-- daniel has quit (Ping timeout: 604 seconds)
<dhowells> if so, dump the bytes at that address, and make sure they're the same as in the vmlinux file
<wli> dhowells: that's where it got it from in the first place -- it's preloaded into gdb 
<wli> (gdb) p/x (unsigned char [4])0xc0106693
<wli> $10 = {0x93, 0x66, 0x10, 0xc0}
<wli> dhowells: yes
<dhowells> that didn't work
<dhowells> those four bytes are the address
<wli> (gdb) p/x (unsigned char [4])0xc0106693
<wli> $1 = {0x93, 0x66, 0x10, 0xc0}
<dhowells>  p/x (unsigned char [4])*(char*)0xc0106693
<dhowells> or just p/x *(int*)0xc0106693
<wli> kgdb:
<wli> (gdb) p/x (unsigned char [4])*(char*)0xc0106693
<wli> $11 = {0x75, 0xf6, 0xf0, 0x81}
<wli> vmlinux:
<wli> (gdb) p/x (unsigned char [4])*(char*)0xc0106693
<wli> $2 = {0x75, 0xf6, 0xf0, 0x81}
<dhowells> guess so then
<dhowells> hmmm... on mine, I see:
<dhowells> (gdb) p/x (char[4])*(char*)0xc01067c8
<dhowells> $2 = {0xf, 0x85, 0xe2, 0xff}
<dhowells> which should also be a jne:-/
<wli> this is for the jne is __write_lock_failed()?
<dhowells> yes
<wli> What does mine reassemble to?
* dhowells fires up his I386 insn pdf
<dhowells> yours is right
* viro looks at axboe
<wli> ugh
<wli> dhowells: what are the odds it's an NMI oops?
<dhowells> and so is mine
<dhowells> can you access the printk buffer?
<wli> dhowells: (gdb) p log_buf
<wli> $3 = '\0' <repeats 65535 times>
<dhowells> the difference between your disas and mine are JNE rel8 vs JNE rel32
--- dwmw2_gone is now known as dwmw2
<dhowells> wli: p (char*)&log_buf
<dhowells> is that what you did?
<wli> (gdb) p (char*)&log_buf
<wli> $4 = 0xc034cb40 ""
<wli> (no
<wli> What are the odds it's the NMI oopser?
<dhowells> try p (char[256])log_buf
<dhowells> it might be an NMI, I'm just wondering how to tell
<dhowells> wli: what you need to do is to examine the irq_stat[] array
<wli> (gdb) p log_buf
<wli> p/x log_buf
<wli> $12 = "01 (tiotest).\n<3>Out of Memory: Killed process 8902 (tiotest).\n<3>Out of Memory: Killed process 8916 (tiotest).\n<3>Out of Memory: Killed process 8917 (tiotest).\n<3>Out of Memory: Killed process 8918 ("...
<dhowells> or that might be the problem
<dhowells> p/x (unsigned[5])irq_stat
<wli> (gdb) p/x irq_stat[((struct thread_info *)((unsigned long)$esp & ~8191UL))->cpu]
<wli> $19 = {__softirq_pending = 0x0, __syscall_count = 0x0, 
<wli>   __ksoftirqd_task = 0xcd1adaa0, idle_timestamp = 0xe1ef9f, 
<wli>   __nmi_count = 0xacd8c3}
<dhowells> did you compile with -g?
<wli> yes
<wli> kgdb implies -g and frame pointers
<dhowells> what about p irq_stat[0]
<wli> (gdb) p irq_stat[0]
<wli> $20 = {__softirq_pending = 0, __syscall_count = 0, 
<wli>   __ksoftirqd_task = 0xcd1df460, idle_timestamp = 14807014, 
<wli>   __nmi_count = 12196773}
<dhowells> and again?
<wli> again for what?
<dhowells> do the command again (and watch __nmi_count)
<wli> (gdb) 
<wli> $21 = {__softirq_pending = 0, __syscall_count = 0, 
<wli>   __ksoftirqd_task = 0xcd1df460, idle_timestamp = 14807014, 
<wli>   __nmi_count = 12196773}
<dhowells> how many CPUs do you have?
<wli> dhowells: it oopsed on cpu 7
<wli> dhowells: 16
* dhowells hates wli
<wli> dhowells: 32 doesn't boot yet, the ioredtbl's are FITH
<wli> dhowells: 48 is beyond my power by several orders of magnitude.
--> kai_ (~kai@pppoe79.swhBachemerstr.Uni-Koeln.DE) has joined #kernel
<wli> dhowells: 64 and I have to borrow quads from another group and figure out the APIC ID remapping trick.
<dhowells> the value in __nmi_count looks weird
* dhowells really hates wli
<wli> dhowells: I will be your testmonkey if you care to debug. =)
* dhowells grins
<dhowells> what's the __nmi_count on cpu7?
<wli> dhowells: 32 can be brought up in 15 minutes or so, maybe 30, depending on how slow the console is.
<wli> (gdb) p irq_stat[7]
<wli> $24 = {__softirq_pending = 0, __syscall_count = 0, 
<wli>   __ksoftirqd_task = 0xcd1adaa0, idle_timestamp = 14806943, 
<wli>   __nmi_count = 11327683}
<dhowells> what's p log_end-(u_long)&log_bug
<wli> (gdb) p/x $eax
<wli> $25 = 0xc0331ca0
<wli> (gdb) p &tasklist_lock
<wli> $27 = (rwlock_t *) 0xc0331ca0
<dhowells> you could try p (char[256])*(char*)(log_end-256)
<wli> (gdb) p (char[256])*(char*)(log_end-256)
<wli> Cannot access memory at address 0x284d9
<dhowells> try p log_end
<wli> #kernel> dhowells: 32 doesn't boot yet, the ioredtbl's are FITH
<wli> #kernel> dhowells: 48 is beyond my power by several orders of magnitude.
<wli> *** kai_ (~kai@pppoe79.swhBachemerstr.Uni-Koeln.DE) has joined channel #kernel
<wli> #kernel> dhowells: 64 and I have to borrow quads from another group and figure
<wli> +out the APIC ID remapping trick.
<wli> <dhowells:#kernel> the value in __nmi_count looks weird
<wli> * dhowells:#kernel really hates wli
<wli> #kernel> dhowells: I will be your testmonkey if you care to debug. =)
<wli> * dhowells:#kernel grins
<wli> <dhowells:#kernel> what's the __nmi_count on cpu7?
<wli> argh
<dhowells> try p (char[256])*(char*)(log_buf+log_end-256)
<wli> sorry
<wli> (gdb) p log_end
<wli> $28 = 165337
<wli> (gdb) p (char[256])*(char*)(log_buf+log_end-256)
<wli> $29 = '\0' <repeats 255 times>
<dhowells> try p (char[256])*(char*)(log_buf+(log_end&65535)-256)
<dhowells> log_end needs masking
<wli> (gdb) p (char[256])*(char*)(log_buf+(log_end&65535)-256)
<wli> $30 = "(tiotest).\n<3>Out of Memory: Killed process 9741 (tiotest).\n<3>Out of Memory: Killed process 9743 (tiotest).\n<3>Out of Memory: Killed process 9744 (tiotest).\n<3>Out of Memory: Killed process 9745 (tio"...
<dhowells> hmmm
<dhowells> no obvious oops... but it may have been overwritten
<dhowells> :-/
<wli> tasklist_lock smells of NMI oopsing.
<wli> tasklist_lock hold/wait times are beyond ridiculous and into the realm of flat-out bugginess.
<dhowells> yeah... I think I have to agree
<wli> The tasklist_lock is basically a bug.
<dhowells> can you use some sort of serial console or net console?
<wli> I am using a serial console.
<dhowells> well, if there was an oops, you should've seen it fly past on that
<wli> dhowells: kgdb traps the oops before it comes out there -- this is very difficult to reproduce, so...
<wli> it's more or less "take the one shot we've got or wait a month before it happens again"
<dhowells> so the oops is still pending?
<wli> dhowells: it's been pending since NUMA-Q starting booting again around 2.5.20.
<dhowells> I mean in your current kgdb session
<wli> yes

****

<dhowells> then you should be able to track back up the stack and locate it
<wli> dhowells: I'
<dhowells> do_nmi+N ought to be on the stack
<wli> dhowells: I'm enough sheets to the wind it might take me a few tries to get it right. Can you give me a gdb command to dump out?
<dhowells> do you know what ESP is on the dead task/CPU?
<wli> dhowells: $esp produces what appears to be a proper result.
<dhowells> p $ESP
<wli> (gdb) p $esp
<wli> $38 = (void *) 0xe3dfbf54
<dhowells> (gdb) p/x (0xe3dfbf54 & 0xffffe000) + 0x2000 - 0xe3dfbf54
<dhowells> $4 = 0xac
<dhowells> that's how much stack space is used
<wli> Is that good or bad?
--> andre (~andre@astound-64-85-224-253.ca.astound.net) has joined #kernel
<dhowells> wait
<dhowells> p (void*[0xac/4])*(void**)$esp
<wli> Got a stack-dumping command for me?
<wli> (gdb) p (void*[0xac/4])*(void**)$esp
<wli> A parse error in expression, near `4])*(void**)$esp'.
<dhowells> p (void*[43])*(void**)$esp
<wli> (gdb) p (void*[43])*(void**)$esp
<wli> $39 = {0xc0119011, 0xb89ffbf8, 0xf21, 0xb89ffd24, 0xfffffff2, 0xe3dfbfa0, 
<wli>   0xc0118e95, 0xf21, 0xb89ffbf8, 0xe3dfbfc4, 0x0, 0xb89ffc00, 0xe3dfa000, 0x0, 
<wli>   0x100070, 0xe3dfa000, 0xb8800000, 0x200000, 0xe3dfa000, 0xe3dfbfbc, 
<wli>   0xc0105e39, 0xf21, 0xb89ffbf8, 0xe3dfbfc4, 0x0, 0xb89ffc00, 0x805e2ac, 
<wli>   0xc010788f, 0xf21, 0xb89ffbf8, 0xb89ffc00, 0x0, 0xb89ffd24, 0x805e2ac, 0x78, 
<wli>   0xc010002b, 0x2b, 0x78, 0x400fa8de, 0x23, 0x292, 0x805e25c, 0x2b}
<dhowells> p do_nmi
<wli> (gdb) p do_nmi
<wli> $40 = {void (struct pt_regs *, long int)} 0xc01090d0 <do_nmi>
<dhowells> i sym 0xc0119011
<dhowells> i sym 0xc0118e95
<dhowells> i sym 0xc0105e39
<wli> (gdb) i sym 0xc0118e95
<wli> do_fork + 33 in section .text
<hch> morning
<dhowells> i sym 0xc010788f
<wli> (gdb) i sym 0xc0119011
<wli> Letext + 191 in section .text
<dhowells> i sym 0xc010002b
<dhowells> hch: morning
<wli> (gdb) i sym 0xc0105e39
<wli> sys_clone + 37 in section .text
<wli> (gdb) i sym 0xc010788f
<wli> syscall_call + 7 in section .text
<dhowells> wli: okay... the exception hasn't appeared on the stack there... it's the other side of the $esp value
<wli> (gdb) i sym 0xc010002b
<wli> startup_32 + 43 in section .text
<wli> dhowells: anything you can tell me is good
<dhowells> p (void*[43])*(void**)($esp-0xac)
<wli> (gdb) p (void*[43])*(void**)($esp-0xac)
<wli> $41 = {0xe3dfbf54, 0xe3dfbf68, 0xf21, 0xb89ffd24, 0xc0106693, 0x87, 0x60, 
<wli>   0x68, 0xc0110068, 0x68, 0xffff, 0xffff, 0xe3dfbefc, 0xc0111cb0, 0x2, 0xb, 
<wli>   0x0, 0xe3dfbf20, 0xc0d06425, 0xe3dfbf20, 0xb89ffd24, 0xe3dfbf10, 0xc010911b, 
<wli>   0xe3dfbf20, 0xc0d06400, 0xf21, 0xe3dfbf68, 0xc0108356, 0xe3dfbf20, 0x0, 
<wli>   0xc0d06400, 0x0, 0xe3dfa000, 0xf21, 0xb89ffd24, 0xe3dfbf68, 0xc0331ca0, 
<wli>   0xc0110068, 0x68, 0xc0331ca0, 0xc0106693, 0x60, 0x87}
<dhowells> i sym 0xc010911b
<wli> (gdb) i sym 0xc010911b
<wli> do_nmi + 75 in section .text
* dhowells grins
<dhowells> disas 0xc010911b
<dhowells> what's that instruction? a call somewhere?
<wli> 0xc0109116 <do_nmi+70>: call   0xc0111bc4 <nmi_watchdog_tick>
<wli> 0xc010911b <do_nmi+75>: jmp    0xc01091b2 <do_nmi+226>
<wli> 0xc0109120 <do_nmi+80>: push   %esi
<wli> 0xc0109121 <do_nmi+81>: movzbl %bl,%eax
<wli> 0xc0109124 <do_nmi+84>: push   %eax
<dhowells> does that answer your questions?
<wli> 0xc01091b0 <do_nmi+224>:        in     $0x71,%al
<wli> 0xc01091b2 <do_nmi+226>:        lea    0xfffffff8(%ebp),%esp
<wli> 0xc01091b5 <do_nmi+229>:        pop    %ebx
<wli> It's an NMI oops.
<dhowells> NMI went off whilst do_fork was spinning on the tasklist_lock
<dhowells> wli: you might also want to note the technique I used for finding it
<wli> dhowells: noted
<dhowells> wli: have fun
<wli> dhowells: I will FTSO the tasklist_lock and the bloody fscking tasklist to boot.
* dhowells grins
<hch> hmm, I should have stayed up longer yesterday
<wli> dhowells: Have you logged it?
<hch> and sent linus the patch
<dhowells> I thought I'd leave that to you
<dhowells> why, do you want me to?
<wli> dhowells: I'm too many sheets to the wind, can you mail me the log?
<dhowells> the log of the xchat session?
<wli> dhowells: I'll settle for that sure.
