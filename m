Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbUJ1Jb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUJ1Jb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbUJ1Jb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:31:58 -0400
Received: from spectre.fbab.net ([212.214.165.139]:17057 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S262852AbUJ1JbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:31:12 -0400
Message-ID: <4180BC58.3040402@fbab.net>
Date: Thu, 28 Oct 2004 11:31:04 +0200
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu> <41801622.5040207@fbab.net> <20041028065523.GA10488@elte.hu>
In-Reply-To: <20041028065523.GA10488@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Magnus Naeslund(t) <mag@fbab.net> wrote:
> 
> 
>>I'm testing out this patch on an debian box. There seems to be a
>>problem with enable_irq in the e100 driver that makes the network to
>>b0rk.
> 
> 
> this e100 driver warning seems mostly harmless - i get it too and the
> device works just fine.
> 
> 

Well, this isn't my experience.
I can't even ping another box on the same net with e100 or eepro100 
driver. I'm running a UP p4 2.4 ghz box with 2.6.9-mm1-RT-V0.4.3.

After letting it ping a while, this turns up:

NETDEV WATCHDOG: eth0: transmit timed out
ksoftirqd/0/2: BUG in enable_irq at kernel/irq/manage.c:112
  [<c01384d9>] enable_irq+0xe1/0x122 (12)
  [<d08055ab>] e100_up+0x112/0x211 [e100] (48)
  [<c0247e37>] dev_watchdog+0x0/0xb6 (36)
  [<c0247eeb>] dev_watchdog+0xb4/0xb6 (12)
  [<c0124391>] run_timer_softirq+0x1c9/0x48b (20)
  [<c0111ac0>] mcount+0x14/0x18 (32)
  [<c012018e>] ___do_softirq+0x4e/0xd6 (20)
  [<c01202a0>] _do_softirq+0x8/0x22 (8)
  [<c012066a>] ksoftirqd+0xa5/0xeb (4)
  [<c01202b8>] _do_softirq+0x20/0x22 (28)
  [<c012066a>] ksoftirqd+0xa5/0xeb (8)
  [<c013015e>] kthread+0xa1/0xce (28)
  [<c01205c5>] ksoftirqd+0x0/0xeb (20)
  [<c01300bd>] kthread+0x0/0xce (12)
  [<c0104195>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: enable_irq+0x33/0x122 [<c013842b>] / (e100_up+0x112/0x211 
[e100] [<d08055ab>])
.. entry 2: print_traces+0x1b/0x55 [<c013243e>] / (dump_stack+0x23/0x25 
[<c0106eb8>])




Other latecy traces are:

(ksoftirqd/0/2/CPU#0): new 22 us maximum-latency critical section.
  => started at timestamp 116357664: <call_console_drivers+0x8c/0x163>
  =>   ended at timestamp 116357686: <__sched_text_start+0x30e/0x6c1>
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (4)
  [<c01319e9>] check_preempt_timing+0x20b/0x2da (8)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (8)
  [<c0106a10>] common_interrupt+0x18/0x20 (24)
  [<c013007b>] kthread_exit_files+0x14/0x56 (32)
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (20)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (8)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (20)
  [<c028a2aa>] schedule+0x29/0xd1 (84)
  [<c0111ac0>] mcount+0x14/0x18 (8)
  [<c01206ae>] ksoftirqd+0xe9/0xeb (28)
  [<c013015e>] kthread+0xa1/0xce (28)
  [<c01205c5>] ksoftirqd+0x0/0xeb (20)
  [<c01300bd>] kthread+0x0/0xce (12)
  [<c0104195>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x4e/0x6c1 [<c0289c0e>] / 
(schedule+0x29/0xd1 [<c028a2aa>])
.. entry 2: print_traces+0x1b/0x55 [<c013243e>] / (dump_stack+0x23/0x25 
[<c0106eb8>])

  =>   dump-end timestamp 116461059
(bash/1156/CPU#0): new 16 us maximum-latency critical section.
  => started at timestamp 227980588: <call_console_drivers+0x8c/0x163>
  =>   ended at timestamp 227980604: <irq_exit+0x3c/0x45>
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (4)
  [<c01319e9>] check_preempt_timing+0x20b/0x2da (8)
  [<c01380a1>] irq_exit+0x3c/0x45 (8)
  [<c0115f81>] try_to_wake_up+0x135/0x137 (28)
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (48)
  [<c01380a1>] irq_exit+0x3c/0x45 (8)
  [<c01380a1>] irq_exit+0x3c/0x45 (20)
  [<c0108784>] do_IRQ+0x5c/0x81 (12)
  [<c0106a10>] common_interrupt+0x18/0x20 (20)
  [<c0114ab3>] do_page_fault+0x8e/0x5e7 (44)
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (72)
  [<c013183a>] check_preempt_timing+0x5c/0x2da (16)
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (4)
  [<c01163ff>] schedule_tail+0x37/0x8f (4)
  [<c0114a25>] do_page_fault+0x0/0x5e7 (36)
  [<c0106acd>] error_code+0x2d/0x38 (8)
  [<c011007b>] set_fixed_ranges+0x62/0xd1 (40)
  [<c0116447>] schedule_tail+0x7f/0x8f (12)
  [<c0114a25>] do_page_fault+0x0/0x5e7 (20)
  [<c0106acd>] error_code+0x2d/0x38 (8)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __do_IRQ+0x104/0x196 [<c01382a6>] / (do_IRQ+0x57/0x81 
[<c010877f>])
.. entry 2: print_traces+0x1b/0x55 [<c013243e>] / (dump_stack+0x23/0x25 
[<c0106eb8>])

  =>   dump-end timestamp 228101445

(ksoftirqd/0/2/CPU#0): new 18 us maximum-latency critical section.
  => started at timestamp 228104930: <call_console_drivers+0x8c/0x163>
  =>   ended at timestamp 228104948: <__sched_text_start+0x30e/0x6c1>
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (4)
  [<c01319e9>] check_preempt_timing+0x20b/0x2da (8)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (8)
  [<c0106a10>] common_interrupt+0x18/0x20 (24)
  [<c013007b>] kthread_exit_files+0x14/0x56 (32)
  [<c0131d71>] sub_preempt_count+0x62/0xc5 (20)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (8)
  [<c0289ece>] __sched_text_start+0x30e/0x6c1 (20)
  [<c028a2aa>] schedule+0x29/0xd1 (84)
  [<c0111ac0>] mcount+0x14/0x18 (8)
  [<c01206ae>] ksoftirqd+0xe9/0xeb (28)
  [<c013015e>] kthread+0xa1/0xce (28)
  [<c01205c5>] ksoftirqd+0x0/0xeb (20)
  [<c01300bd>] kthread+0x0/0xce (12)
  [<c0104195>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x4e/0x6c1 [<c0289c0e>] / 
(schedule+0x29/0xd1 [<c028a2aa>])
.. entry 2: print_traces+0x1b/0x55 [<c013243e>] / (dump_stack+0x23/0x25 
[<c0106eb8>])

  =>   dump-end timestamp 228208260

