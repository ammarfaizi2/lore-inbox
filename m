Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVHRCo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVHRCo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVHRCo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:44:28 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:35482 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932096AbVHRCo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:44:27 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124323379.5186.18.camel@localhost.localdomain>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 22:44:10 -0400
Message-Id: <1124333050.5186.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 20:02 -0400, Steven Rostedt wrote:

> So I went back to the laptop's original config, and did one change. I
> disabled CONFIG_SCHED_SMT, rebooted, and the system booted up.  It
> hasn't locked up after four boots.  It did once get into some crazy bug
> with scheduling while atomic, but it just spit out so many of them that
> I couldn't see what caused it. I'll turn back on netconsole to see if I
> can capture that bug, but it seems to be related to someting different.
> 
> So I think something's wrong with the scheduling for hyper threading.

Spoke too soon.  I added netconsole and booted a couple of more times,
and I got a crash again.  So it seems to happen less often with
CONFIG_SCHED_SMT, (don't know why) but it is not the problem.

Here's the latest dump. May be due to having HR timers configured.  I'll
add my logger and do some more in depth debugging tomorrow.

(the bug happened same place, same time, but not all the time)

-- Steve

Freeing unused kernel memory: 296k freed
softirq-timer/0/4[CPU#0]: BUG in set_new_owner at kernel/rt.c:916
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 14, comm:      softirq-timer/1
EIP: 0060:[<c032ea3f>] CPU: 1
EIP is at __down_mutex+0xdf/0x5d0
 EFLAGS: 00000082    Not tainted  (2.6.13-rc6-rt8)
EAX: c1831884 EBX: 00000000 ECX: 00000000 EDX: cf6bdeec
ESI: cf6ba7c0 EDI: cf6bdefc EBP: c1831870 DS: 007b ES: 007b
CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006d0
 [<c0141d44>] check_wakeup_timing+0xd4/0x170 (20)
 [<c0141db8>] check_wakeup_timing+0x148/0x170 (12)
 [<c0141c0a>] sub_preempt_count+0x1a/0x20 (64)
 [<c011bd5e>] __wake_up+0x1e/0x80 (12)
 [<c0330813>] _spin_lock_irqsave+0x23/0x60 (12)
 [<c011bd5e>] __wake_up+0x1e/0x80 (8)
 [<c0141a67>] add_preempt_count_ti+0x27/0x100 (4)
 [<c011bd5e>] __wake_up+0x1e/0x80 (12)
 [<c0141b5a>] add_preempt_count+0x1a/0x20 (16)
 [<c012ba65>] run_timer_softirq+0x2b5/0x470 (32)
 [<c0127680>] ksoftirqd+0xf0/0x170 (56)
 [<c0127590>] ksoftirqd+0x0/0x170 (32)
 [<c013979a>] kthread+0xba/0xc0 (4)
 [<c01396e0>] kthread+0x0/0xc0 (28)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0141b5a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (softirq-timer/1/14 [cf6ba7c0,  98]):
------------------------------

NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 4, comm:      softirq-timer/0
EIP: 0060:[<c013ea5f>] CPU: 0
EIP is at __down_trylock+0x9f/0x330
 EFLAGS: 00000082    Not tainted  (2.6.13-rc6-rt8)
EAX: c0392238 EBX: 00000000 ECX: 00008000 EDX: 00004773
ESI: c0392224 EDI: cf69c000 EBP: 00000086 DS: 007b ES: 007b
CR0: 8005003b CR2: fff3f000 CR3: 00474000 CR4: 000006d0
 [<c0140b73>] rt_down_trylock+0x33/0x480 (44)
 [<c01218f2>] vprintk+0x162/0x240 (8)
 [<c02092cb>] vscnprintf+0x2b/0x40 (8)
 [<c01218f2>] vprintk+0x162/0x240 (24)
 [<c0141a67>] add_preempt_count_ti+0x27/0x100 (64)
 [<c0141b5a>] add_preempt_count+0x1a/0x20 (28)
 [<c0121787>] printk+0x17/0x20 (20)
 [<c01220c7>] __WARN_ON+0x67/0x90 (12)
 [<c032ec5a>] __down_mutex+0x2fa/0x5d0 (48)
 [<c0331152>] _raw_spin_unlock+0x12/0x30 (100)
 [<c011bd5e>] __wake_up+0x1e/0x80 (8)
 [<c0330813>] _spin_lock_irqsave+0x23/0x60 (12)
 [<c011bd5e>] __wake_up+0x1e/0x80 (8)
 [<c0141a67>] add_preempt_count_ti+0x27/0x100 (4)
 [<c011bd5e>] __wake_up+0x1e/0x80 (12)
 [<c0141b5a>] add_preempt_count+0x1a/0x20 (16)
 [<c012ba65>] run_timer_softirq+0x2b5/0x470 (32)
 [<c0127680>] ksoftirqd+0xf0/0x170 (56)
 [<c0127590>] ksoftirqd+0x0/0x170 (32)
 [<c013979a>] kthread+0xba/0xc0 (4)
 [<c01396e0>] kthread+0x0/0xc0 (28)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c0141b5a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)
.. [<c0141b5a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)
.. [<c0141b5a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [cf697840,  98]):
------------------------------



