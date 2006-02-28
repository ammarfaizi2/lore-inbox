Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWB1Um2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWB1Um2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWB1Um2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:42:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:27534 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932112AbWB1Um1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:42:27 -0500
Date: Tue, 28 Feb 2006 21:40:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] buggy UART fix
Message-ID: <20060228204059.GA1825@elte.hu>
References: <Pine.LNX.4.58.0602270954520.26564@gandalf.stny.rr.com> <20060228194503.GB23453@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228194503.GB23453@elte.hu>
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


hm, i just got the deadlock below, most likely due to your serial fix.  
(never got this before) It's not 100% reproducible - booted the kernel a 
dozen times (with your patch applied, working on other stuff) before i 
got this deadlock.

	Ingo

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------
already locked:  [c1075ea0] {&port->lock}
.. ->owner: f24d48f2
.. held by:             IRQ 4: 2400 [f24d48f0,  57]
... acquired at:               serial8250_interrupt+0xe2/0x14a
-{current task's backtrace}----------------->
 [<c0103f86>] show_trace+0x18/0x1d (20)
 [<c0103fa6>] dump_stack+0x1b/0x1f (20)
 [<c013afda>] check_deadlock+0xf6/0x2b4 (24)
 [<c0130036>] task_blocks_on_lock+0x1f/0x231 (44)
 [<c02e77e9>] ___down_mutex+0x29a/0x3f3 (96)
 [<c02e8303>] _spin_lock+0x39/0x42 (24)
 [<c020f280>] serial8250_interrupt+0xe9/0x14a (36)
 [<c013cf8f>] handle_IRQ_event+0x50/0xbd (52)
 [<c013dcd1>] do_irqd+0x171/0x298 (32)
 [<c012cac3>] kthread+0xab/0xdc (36)
 [<c0100d71>] kernel_thread_helper+0x5/0xb (229810204)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02e87de>] .... _raw_spin_lock+0x12/0x26
.....[<c02e7575>] ..   ( <= ___down_mutex+0x26/0x3f3)


showing all tasks:
hm, tasklist_lock locked, retrying...  #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 ignoring it.
 locked it.
S            init:    1 [c2db78f0, 120] (not blocked)
S     migration/0:    2 [c2dbb8f0,   0] (not blocked)
S  softirq-high/0:    3 [c2dbf8f0,  98] (not blocked)
S softirq-timer/0:    4 [c2dc38f0,  98] (not blocked)
S softirq-net-tx/:    5 [c2dc78f0,  98] (not blocked)
S softirq-net-rx/:    6 [c2dcb8f0,  98] (not blocked)
S softirq-block/0:    7 [c2dcf8f0,  98] (not blocked)
S softirq-tasklet:    8 [c2dd38f0,  98] (not blocked)
S      watchdog/0:    9 [c2dd78f0,   0] (not blocked)
S       desched/0:   10 [c2ddb8f0, 105] (not blocked)
S        events/0:   11 [c2df88f0,  98] (not blocked)
S         khelper:   12 [c2dfd8f0, 111] (not blocked)
S         kthread:   13 [c2e1f8f0, 111] (not blocked)
S       kblockd/0:   15 [c2e4e8f0, 110] (not blocked)
S          kacpid:   16 [f7ea18f0, 112] (not blocked)
S           IRQ 9:   17 [f7ea88f0,  50] (not blocked)
S         pdflush:  186 [f7ec18f0, 117] (not blocked)
S         pdflush:  187 [f796f8f0, 115] (not blocked)
S           aio/0:  189 [f7ec88f0, 112] (not blocked)
S         kswapd0:  188 [f7ed18f0, 125] (not blocked)
S           IRQ 8:  772 [f7a0b8f0,  51] (not blocked)
S         kseriod:  776 [f79fb8f0, 110] (not blocked)
S          IRQ 12:  779 [f71398f0,  52] (not blocked)
S          IRQ 14:  816 [f715d8f0,  53] (not blocked)
S          IRQ 15:  817 [f7a128f0,  54] (not blocked)
S           IRQ 1:  834 [f721e8f0,  55] (not blocked)
S       kjournald:  838 [f71348f0, 115] (not blocked)
S       kjournald: 1833 [f676b8f0, 123] (not blocked)
S           udevd: 1836 [f61978f0, 112] (not blocked)
S          IRQ 16: 2114 [f650a8f0,  56] (not blocked)
S         portmap: 2214 [f666c8f0, 119] (not blocked)
S           acpid: 2247 [f60268f0, 116] (not blocked)
S            sshd: 2257 [f71f98f0, 118] (not blocked)
M         distccd: 2287 [f60068f0, 120] (not blocked)
S         distccd: 2288 [f63078f0, 125] (not blocked)
S             gpm: 2296 [f60808f0, 116] (not blocked)
S           crond: 2304 [f60b08f0, 119] (not blocked)
S         distccd: 2319 [f63c18f0, 121] (not blocked)
S         distccd: 2320 [f63348f0, 121] (not blocked)
S             xfs: 2327 [f60c78f0, 118] (not blocked)
S             atd: 2342 [f62b18f0, 119] (not blocked)
S         distccd: 2350 [f63928f0, 121] (not blocked)
S     dbus-daemon: 2351 [f63628f0, 116] (not blocked)
S            hald: 2359 [f2cd98f0, 115] (not blocked)
S         distccd: 2364 [f284e8f0, 121] (not blocked)
S hald-addon-acpi: 2365 [f2a328f0, 118] (not blocked)
S         distccd: 2373 [f2ac38f0, 121] (not blocked)
S              su: 2381 [f61228f0, 118] (not blocked)
S          agetty: 2386 [f60f38f0, 116] (not blocked)
S        mingetty: 2387 [f66708f0, 118] (not blocked)
R        mingetty: 2388 [f2b4e8f0, 118] (not blocked)
S        mingetty: 2389 [f29a38f0, 118] (not blocked)
S        mingetty: 2390 [f242c8f0, 118] (not blocked)
S        mingetty: 2391 [f24478f0, 118] (not blocked)
R        mingetty: 2392 [f24618f0, 118] (not blocked)
S            bash: 2399 [f24c38f0, 118] (not blocked)
D           IRQ 4: 2400 [f24d48f0,  57] (not blocked)
R            udev: 2403 [f25468f0, 116] (not blocked)
S            udev: 2418 [f26318f0, 117] (not blocked)
R default.hotplug: 2434 [f20008f0, 119] (not blocked)
S            udev: 2438 [f255a8f0, 116] (not blocked)
R default.hotplug: 2442 [f21e98f0, 119] (not blocked)
M           udevd: 2452 [f20f38f0, 119] (not blocked)
S            udev: 2464 [f26758f0, 118] (not blocked)
S            udev: 2472 [f20648f0, 116] (not blocked)
R 05-pam_console.: 2473 [f25428f0, 118] (not blocked)
D default.hotplug: 2475 [f24cf8f0, 118] blocked on: [c03565a4] {drivers/char/tty_io.c:133}
.. ->owner: f2b4e8f2
.. held by:          mingetty: 2388 [f2b4e8f0, 118]
... acquired at:               release_dev+0x1f1/0x671
R           egrep: 2478 [f23178f0, 118] (not blocked)
D        udevsend: 2479 [f23198f0, 113] blocked on: [c03cd2c0] {kernel/fork.c:67}
.. ->owner: f1ca38f2
.. held by:             udevd: 2482 [f1ca38f0, 116]
... acquired at:               sys_setpriority+0x4c/0x1c3
S            udev: 2480 [f24c68f0, 115] (not blocked)
R 05-pam_console.: 2481 [f27c98f0, 118] (not blocked)
R           udevd: 2482 [f1ca38f0, 116] (not blocked)

=============================================

[ turning off deadlock detection.Please report this trace. ]

