Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVGEUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGEUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGEUq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:46:57 -0400
Received: from unused.mind.net ([69.9.134.98]:61388 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261747AbVGEUpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:45:00 -0400
Date: Tue, 5 Jul 2005 13:43:56 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <20050703181229.GA32741@elte.hu>
Message-ID: <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Ingo Molnar wrote:
> 
> i've uploaded the -50-45 patch, can you under this kernel trigger a 
> 'meltdown' on your SMT box?

Hi Ingo,

Here's the results of trying out everything from -50-45 through -51-01 on
the SMT box:

-50-47 looks better.  4x burnP6 + wmcube doesn't bring the box to a halt
anymore.  Running VLC along with a kernel compile brought all running
processes to a halt.  SysRq-I couldn't recover the system (unless I just
wasn't patient enough), but SysRq-S + SysRq-U + SysRq-B was able to sync,
unmount, and reboot.  -50-45 and -50-46 seemed to have similar behavior.

-50-48 won't boot:

softirq-timer/0/4[CPU#0]: BUG in __up_mutex at kernel/rt.c:1485
 [<c0103ec7>] dump_stack+0x23/0x25 (20)
 [<c0121580>] __WARN_ON+0x66/0x86 (52)
 [<c013bd49>] __up_mutex+0x14e/0x304 (40)
 [<c013c4a3>] up_mutex+0x39/0xe3 (28)
 [<c0131aca>] delayed_work_timer_fn+0x3a/0x41 (24)
 [<c012a7f6>] run_timer_softirq+0x208/0x46d (60)
 [<c0126833>] ksoftirqd+0xee/0x1ad (36)
 [<c0136786>] kthread+0xb6/0xba (44)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (554565660)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c012153b>] ..   ( <= __WARN_ON+0x21/0x86)
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c013ffc4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [def10030,  98]):
------------------------------

ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
khelper/163[CPU#1]: BUG in set_new_owner at kernel/rt.c:822
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 163, comm:              khelper
EIP: 0060:[<c013b7c4>] CPU: 1
EIP is at __down_trylock+0x88/0x369
 EFLAGS: 00000082    Not tainted  (2.6.12-RT-V0.7.50-48-debug)
EAX: c03da258 EBX: c03da244 ECX: c03da250 EDX: c03da268
ESI: c03da268 EDI: 00000000 EBP: dec69d1c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000000 CR3: 004f8000 CR4: 000006d0
 [<c01010b6>] show_regs+0x164/0x16e (36)
 [<c0112f94>] nmi_watchdog_tick+0x189/0x2b7 (52)
 [<c0104e80>] default_do_nmi+0x7a/0x18a (52)
 [<c0104ff4>] do_nmi+0x5d/0x6f (24)
 [<c0103b52>] nmi_stack_correct+0x1d/0x22 (92)
 [<c013c84f>] rt_down_trylock+0x29/0x179 (36)
 [<c0120e42>] vprintk+0x22e/0x2c3 (116)
 [<c0120c12>] printk+0x20/0x22 (20)
 [<c012157b>] __WARN_ON+0x61/0x86 (52)
 [<c037173b>] __down_mutex+0x4e2/0x689 (108)
 [<c037258b>] _spin_lock_irqsave+0x24/0x89 (32)
 [<c0129ccf>] lock_timer_base+0x1f/0x3a (20)
 [<c0129fa5>] try_to_del_timer_sync+0x1f/0x5f (28)
 [<c012a00f>] del_timer_sync+0x2a/0xb1 (44)
 [<c0135d06>] exit_itimers+0x117/0x1a9 (56)
 [<c012b66a>] __exit_signal+0xfd/0x1c8 (32)
 [<c012210e>] release_task+0x81/0x16a (40)
 [<c01232a8>] exit_notify+0x64f/0x972 (60)
 [<c0123816>] do_exit+0x24b/0x40d (44)
 [<c013178b>] wait_for_helper+0x0/0xb0 (24)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (557408284)
---------------------------
| preempt count: 00010004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c012153b>] ..   ( <= __WARN_ON+0x21/0x86)
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c0120c3a>] ..   ( <= vprintk+0x26/0x2c3)
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c0112f5f>] ..   ( <= nmi_watchdog_tick+0x154/0x2b7)
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c013ffc4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (khelper/163 [dec67930, 115]):
------------------------------

NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 22, comm:              khelper
EIP: 0060:[<c0371315>] CPU: 0
EIP is at __down_mutex+0xbc/0x689
 EFLAGS: 00000082    Not tainted  (2.6.12-RT-V0.7.50-48-debug)
EAX: c14cde94 EBX: 00000000 ECX: 00000000 EDX: c14cdde8
ESI: c14cde80 EDI: c14cdea4 EBP: c14cde04 DS: 007b ES: 007b
CR0: 8005003b CR2: fffdf000 CR3: 004f8000 CR4: 000006d0
 [<c01010b6>] show_regs+0x164/0x16e (36)
 [<c0112f94>] nmi_watchdog_tick+0x189/0x2b7 (52)
 [<c0104e80>] default_do_nmi+0x7a/0x18a (52)
 [<c0104ff4>] do_nmi+0x5d/0x6f (24)
 [<c0103b52>] nmi_stack_correct+0x1d/0x22 (160)
 [<c03724cc>] _spin_lock_irq+0x24/0x7b (28)
 [<c03701aa>] wait_for_completion+0xa6/0xdb (48)
 [<c011f7a4>] do_fork+0xf1/0x1e2 (132)
 [<c0101151>] kernel_thread+0x86/0x8c (96)
 [<c01318a1>] __call_usermodehelper+0x66/0x68 (24)
 [<c0131d2f>] worker_thread+0x1a1/0x266 (108)
 [<c0136786>] kthread+0xb6/0xba (44)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (1051926556)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c0112f5f>] ..   ( <= nmi_watchdog_tick+0x154/0x2b7)
.. [<c013efaa>] .... add_preempt_count+0x1c/0x1e
.....[<c013ffc4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (khelper/22 [c14c32f0, 114]):
------------------------------


-50-49 through -50-51 won't compile on my SMT debug config:

	arch/i386/kernel/vm86.c:701: error: syntax error before ',' token

-51-01 won't boot:

softirq-timer/1/13[CPU#1]: BUG in ____up_mutex at kernel/rt.c:1302
 [<c0103ea7>] dump_stack+0x23/0x25 (20)
 [<c0121410>] __WARN_ON+0x66/0x86 (52)
 [<c013ca44>] up_mutex+0x160/0x3b6 (36)
 [<c013195a>] delayed_work_timer_fn+0x3a/0x41 (24)
 [<c012a686>] run_timer_softirq+0x208/0x46d (60)
 [<c01266c3>] ksoftirqd+0xee/0x1ad (36)
 [<c0136616>] kthread+0xb6/0xba (44)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (1052131356)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c01402ca>] .... add_preempt_count+0x1c/0x1e
.....[<c01213cb>] ..   ( <= __WARN_ON+0x21/0x86)
.. [<c01402ca>] .... add_preempt_count+0x1c/0x1e
.....[<c01412e4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (softirq-timer/1/13 [c1490670,  98]):
------------------------------

ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
khelper/22[CPU#1]: BUG in set_new_owner at kernel/rt.c:869
NMI watchdog detected lockup on CPU#1 (50000/50000)


BTW, -50-44 through -50-51 wouldn't compile on the UP Athlon box.  -50-43
appears to be rock-solid under the UP non-debug config.  After hammering
on it all weekend, Maximum wakeup latency was 14us (from running JACK, 
phasex, burnK7, dd, and switching from X to text console all at once).


--ww

