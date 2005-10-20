Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbVJTPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbVJTPSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVJTPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:18:13 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37094 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751766AbVJTPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:18:12 -0400
Date: Thu, 20 Oct 2005 11:18:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510201031270.30996@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510201109170.30996@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.58.0510201031270.30996@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Steven Rostedt wrote:
>
> FYI, I just merged my changes with -rt13 and everything seems to be
> working very smoothly.  I've been running my kernel over an hour without
> showing the backward times. I haven't even added the change from cycle_t
> to be 64 bits.
>
>
> So, knock on wood, maybe one of the latest updates fixed the problem. Or
> maybe as soon as I hit send, the machine will crash.
>
> I'll keep you all posted.
>

Spoke too soon ;-)

About ten minutes after sending this, the clock went backwards, and once
again by 2 seconds.

now=5856:283756196 last_count=5858:436968526

Where now is 5856.283756196 seconds and last count is 5858.436968526.

I'll have to put this test in other places in Ingo's kernel to see if I
can trigger it there.

Also, after the machine rebooted into Ingo's -rt13 it hit a NMI watchdog
detected lockup on bootup.  This looks like a false positive since this
was spit out without any pause.

EXT3-fs: write access will be enabled during recovery.
NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 773, comm:               IRQ 14
EIP: 0060:[<c0143892>] CPU: 0
EIP is at trace_special_pid+0x52/0xb0
 EFLAGS: 00000002    Not tainted  (2.6.14-rc4-rt13)
EAX: 00000000 EBX: c03efb60 ECX: c030248d EDX: 00000000
ESI: 00000002 EDI: 00000000 EBP: df4e1dcc DS: 007b ES: 007b
CR0: 8005003b CR2: fffa7000 CR3: 003dc000 CR4: 000006d0
 [<c0101482>] show_regs+0x152/0x180 (36)
 [<c01155ba>] nmi_watchdog_tick+0x15a/0x220 (52)
 [<c01051c2>] default_do_nmi+0x72/0x180 (96)
 [<c0105330>] do_nmi+0x50/0x60 (24)
 [<c0103fe6>] nmi_stack_correct+0x1d/0x22 (104)
 [<c030248d>] __down_mutex+0x40d/0x920 (124)
 [<c0304dd8>] _spin_lock_irqsave+0x28/0x60 (28)
 [<c0128738>] lock_timer_base+0x28/0x50 (24)
 [<c012879e>] __mod_timer+0x3e/0xe0 (36)
 [<c028387d>] __ide_set_handler+0x4d/0x80 (32)
 [<c02838ea>] ide_set_handler+0x3a/0x50 (28)
 [<c0287d06>] task_in_intr+0x86/0x110 (36)
 [<c028203f>] ide_intr+0xdf/0x190 (40)
 [<c014f31c>] handle_IRQ_event+0x6c/0x110 (52)
 [<c01503e6>] thread_edge_irq+0x66/0x110 (36)
 [<c01504d7>] do_hardirq+0x47/0xc0 (20)
 [<c01505c7>] do_irqd+0x77/0xb0 (32)
 [<c013569e>] kthread+0xae/0xc0 (48)
 [<c01014b5>] kernel_thread_helper+0x5/0x10 (548528156)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c0145c1a>] .... add_preempt_count+0x1a/0x20
.....[<c030298c>] ..   ( <= __down_mutex+0x90c/0x920)
.. [<c0145c1a>] .... add_preempt_count+0x1a/0x20
.....[<c03020d6>] ..   ( <= __down_mutex+0x56/0x920)
.. [<c0145c1a>] .... add_preempt_count+0x1a/0x20
.....[<c03020e2>] ..   ( <= __down_mutex+0x62/0x920)
.. [<c0145c1a>] .... add_preempt_count+0x1a/0x20
.....[<c011558b>] ..   ( <= nmi_watchdog_tick+0x12b/0x220)

------------------------------
| showing all locks held by: |  (IRQ 14/773 [df4de7a0,  54]):
------------------------------

#001:             [c0373b40] {ide_lock}
... acquired at:               ide_set_handler+0x18/0x50


I'll look into this as well.

-- Steve
