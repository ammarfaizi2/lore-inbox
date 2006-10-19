Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946102AbWJSP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbWJSP3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946105AbWJSP3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:29:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26560 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946102AbWJSP3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:29:04 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061018172139.3a77a927.akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
	 <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018154402.ef49874a.akpm@osdl.org>
	 <1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018162507.efa7b91a.akpm@osdl.org>
	 <1161216479.18117.45.camel@dyn9047017100.beaverton.ibm.com>
	 <20061018172139.3a77a927.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:28:52 -0700
Message-Id: <1161271732.26843.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 17:21 -0700, Andrew Morton wrote: 
> On Wed, 18 Oct 2006 17:07:59 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > > What does it say in /proc/interrupts?
> > > 
> > > The x86_64 nmi watchdog handling looks rather complex.
> > > 
> > > <checks a couple of x86-64 machines>
> > > 
> > > The /proc/interrutps NMI count seems to be going up by about
> > > one-per-minute.  How odd.   Maybe you just need to wait longer.
> > 
> > 
> > While the soft lock up messages are getting printed..
> > (waited for 5 min for these messages)..
> > 
> > # while :; do grep NMI /proc/interrupts; sleep 30; done
> > NMI:        265         73         41         47
> > NMI:        265         81         62         47
> > NMI:        265         81         71         69
> > NMI:        265         81         93         77
> > NMI:        265         81        101         99
> > NMI:        288         82        101        107
> > NMI:        296         82        131        129
> > NMI:        296         82        153        137
> > NMI:        296         82        161        160
> > NMI:        296        105        161        167
> > NMI:        296        112        184        167
> > 
> > Looking at the messages, I don't think trace all cpus
> > is working ..
> 
> nfi what's going on there.  On my Conroe machine each CPU's NMI count goes
> up by what apepars to be one-per-second when the CPUs are flat out busy,
> but the count increases by random small amounts (like yours) when the
> machine is idle.
> 
> Did you try setting nmi_watchdog=?

Yes. I did try that and its the same result..

I realized that we are on a wrong path. The messages I am getting
are from softlock code (not spinlock debug code). There is no
call to trigger_all_cpu_backtrace() from softlock detection code.
Just for experiment, I added the call and it tried to show the
stacks of other CPUs - but CPU2 itself took an NMI and ran into
hardlock up panic.I guess other CPUs didn't get time to
dump their stacks :(

BTW, other problem is stack traces are useless (thanks to 
CONFIG_UNWIND_STACK) ..

Thanks,
Badari

BUG: soft lockup detected on CPU#2!

Call Trace:
[<ffffffff8020b481>] show_trace+0x41/0x70
[<ffffffff8020b4c2>] dump_stack+0x12/0x20
[<ffffffff8024bbca>] softlockup_tick+0xfa/0x140
[<ffffffff802322e7>] update_process_times+0x57/0x90
[<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
[<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
[<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
[<0000000000000010>]

NMI backtrace for cpu 2

Call Trace:
[<ffffffff8020b481>] show_trace+0x41/0x70
[<ffffffff8020b4c2>] dump_stack+0x12/0x20
[<ffffffff8021946c>] nmi_watchdog_tick+0xec/0x2a0
[<ffffffff8020c911>] default_do_nmi+0x91/0x200
[<ffffffff80219645>] do_nmi+0x25/0x40
[<ffffffff80481b3f>] nmi+0x7f/0x90
[<ffffffff8032856a>] __delay+0xa/0x20
[<ffffffff80218af7>] __trigger_all_cpu_backtrace+0x27/0x40
[<ffffffff802322e7>] update_process_times+0x57/0x90
[<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
[<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
[<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
[<0000000000000010>]

NMI Watchdog detected LOCKUP on CPU 2
CPU 2
Modules linked in: thermal processor fan button loop dm_mod md_mod
Pid: 3724, comm: writev01 Not tainted 2.6.19-rc2-mm1 #8
RIP: 0010:[<ffffffff80328566>]  [<ffffffff80328566>] __delay+0x6/0x20
RSP: 0018:ffff8101dfcd7f50  EFLAGS: 00000093
RAX: 00000000000f6c99 RBX: 0000000000001a10 RCX: 00000000e37f89c7
RDX: 000000000000004d RSI: 0000000000000046 RDI: 00000000001554eb
RBP: 0000000000000002 R08: 0000000000003b71 R09: 000000000000000e
R10: 0000000000000006 R11: ffffffff80335f10 R12: 0000000000000000
R13: ffff8101dba9aec0 R14: 0000000000000000 R15: ffff8101d71b39f8
FS:  00002ad6d94526d0(0000) GS:ffff8101dfc80cc0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002ad6d9121000 CR3: 00000001d4d8d000 CR4: 00000000000006e0
Process writev01 (pid: 3724, threadinfo ffff8101d71b2000, task
ffff8101dc68c300)
Stack:  ffffffff80218af7 ffff8101dc68c300 ffffffff802322e7
ffffffff8069dd70
ffff8101d71b3870 0000000000000000 ffffffff80218104 0000000000000000
ffffffff8021885b 0000000000000001 0000000000000001 ffff8101dba9af20
Call Trace:
[<ffffffff80218af7>] __trigger_all_cpu_backtrace+0x27/0x40
[<ffffffff802322e7>] update_process_times+0x57/0x90
[<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
[<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
[<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
[<0000000000000010>]


Code: 0f 31 29 c8 48 39 f8 72 f5 f3 c3 66 66 66 90 66 66 66 90 66
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!




