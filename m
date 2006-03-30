Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWC3C50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWC3C50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC3C50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:57:26 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:22189 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751222AbWC3C5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:57:25 -0500
Subject: 2.6.15.7 + 2.6.15-rt21: stack overflow?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Wed, 29 Mar 2006 18:57:09 -0800
Message-Id: <1143687429.5587.22.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The saga of the hung machine continues :-)

I changed the network driver from skge to sk98lin (that's one change I
had done not so long ago). No particular reason except suspicion and
wanting to undo as many changes as possible. 

So, I caught something else, this is from the serial console log after
the machine hangs:

host login: scsi: unknown opcode 0x01
BUG: do_IRQ: stack overflow: 452
 [<c0106514>] do_IRQ+0x84/0x86 (8)
 [<c0104c86>] common_interrupt+0x1a/0x20 (24)
 [<c0335494>] _raw_spin_unlock_irq+0x16/0x20 (44)
 [<c0332e96>] __schedule+0x306/0x9ac (12)
 [<c011e531>] pull_rt_tasks+0xe8/0x146 (4)
 [<c03336f5>] preempt_schedule_irq+0x3e/0x58 (76)
 [<c0104184>] need_resched+0x20/0x24 (20)
 [<f8945cba>] VpdKeys+0xe5/0x160 [sk98lin] (44)
 [<f893d4c8>] GetVpdKeyArr+0x5c/0x18e [sk98lin] (40)
 [<c011de85>] activate_task+0x9d/0xe7 (232)
 [<c011e3e7>] pick_rt_task+0xbf/0x121 (48)
 [<c011e3e7>] pick_rt_task+0xbf/0x121 (52)
 [<c011e531>] pull_rt_tasks+0xe8/0x146 (40)
 [<c03332a0>] __schedule+0x710/0x9ac (28)
 [<c011e3e7>] pick_rt_task+0xbf/0x121 (60)
 [<c03336f5>] preempt_schedule_irq+0x3e/0x58 (20)
 [<c0104184>] need_resched+0x20/0x24 (20)
 [<f8945d72>] VpdRead+0x3d/0x8d [sk98lin] (28)
 [<f8939195>] Vpd+0x31/0x9ef [sk98lin] (24)
 [<c0104c86>] common_interrupt+0x1a/0x20 (44)
 [<c01064e5>] do_IRQ+0x55/0x86 (8)
 [<c0104c86>] common_interrupt+0x1a/0x20 (24)
 [<c011e3e7>] pick_rt_task+0xbf/0x121 (840)
 [<c011e531>] pull_rt_tasks+0xe8/0x146 (40)
 [<c03332a0>] __schedule+0x710/0x9ac (28)
 [<f89376a4>] SkPnmiGetStruct+0x264/0x349 [sk98lin] (72)
 [<f892f834>] SkGeStats+0x1c9/0x1d5 [sk98lin] (728)
 [<c02da3d4>] rtnetlink_fill_ifinfo+0x3c5/0x4c3 (40)
 [<c02da53a>] rtnetlink_dump_ifinfo+0x68/0x88 (80)
 [<c02e7bac>] netlink_dump+0x40/0x1a2 (40)
 [<c02e7de7>] netlink_dump_start+0xd9/0x150 (48)
 [<c02dab31>] rtnetlink_rcv_msg+0x1b5/0x219 (24)
 [<c02da4d2>] rtnetlink_dump_ifinfo+0x0/0x88 (4)
 [<c02da97c>] rtnetlink_rcv_msg+0x0/0x219 (40)
 [<c02e8093>] netlink_rcv_skb+0x57/0xb0 (4)
 [<c02da97c>] rtnetlink_rcv_msg+0x0/0x219 (32)
 [<c02e811a>] netlink_run_queue+0x2e/0xcb (4)
 [<c02da960>] rtnetlink_rcv+0x21/0x3d (20)
 [<c02e79d7>] netlink_data_ready+0x12/0x5b (16)
 [<c02e6bf1>] netlink_sendskb+0x1c/0x38 (12)
 [<c02e768a>] netlink_sendmsg+0x281/0x35f (12)
 [<c02c7e93>] sock_sendmsg+0xde/0xf9 (80)
 [<c013a864>] autoremove_wake_function+0x0/0x37 (100)
 [<c016e200>] __kmalloc+0x8f/0xc1 (72)
 [<c014e21a>] audit_sockaddr+0x39/0x78 (20)
 [<c02c9304>] sys_sendto+0xf5/0x116 (24)
 [<c03336f5>] preempt_schedule_irq+0x3e/0x58 (32)
 [<c0104184>] need_resched+0x20/0x24 (20)
 [<c014cfaf>] audit_filter_syscall+0x39/0xae (48)
 [<c014cfaf>] audit_filter_syscall+0x39/0xae (4)
 [<c02c9bfa>] sys_socketcall+0x1b9/0x292 (84)
 [<c0104241>] syscall_call+0x7/0xb (60)

I saw this two more times when the machine hangs. 
Another one:

BUG: do_IRQ: stack overflow: 484
 [<c0106514>] do_IRQ+0x84/0x86o4> [<c03365fd>] do_page_fault+0x21d/0x650
(56)
 [<c03363e0>] do_page_fault+0x0/0x650 (76)
 [<c0104ddf>] error_code+0x4f/0x54 (8)
 [<c0105000>] show_trace+0x21/0x86 (44)
 [<c010514c>] dump_stack+0x13/0x17 (36)
 [<c0125e9c>] panic+0x51/0x190 (8)
 [<c0129332>] do_exit+0x497/0x4e8 ( dump_stack+0x13/0x17 (36)
 [<c0125e9c>] panic+0x51/0x190 (8)
 [<c0129332>] do_exit+0x497/0x4e8 (24)
 [<c0126851>] printk+0x1c/0x44 (8)
 [<c0105617>] do_divide_error+0x0/0xa8 (32)
 [<c0126851>] printk+0x1c/0x44 (36)
 [<c03365fd>] do_page_fault+0x21d/0x650 (20)
 [<c03363e0>] d> [<c0126851>] printk+0x1c/0x44 (36)
 [<c03365fd>] do_page_fault+0x21d/0x650 (20)
 [<c03363e0>] do_page_fault+0x0/0x650 (76)
 [<c0104ddf>] error_code+0x4f/0x54 (8)
 [<c0105000>] show_trace+0x21/0x86 (44)
 [<c01050ee>] show_stack+0x89/0xd4 (36)
 [<c01052bd>] show_registers+0xack+0x89/0xd4 (36)
 [<c01052bd>] show_registers+0x16d/0x29f (28)
 [<c0105583>] die+0x111/0x1a5 (56)
 [<c03365fd>] do_page_fault+0x21d/0x650 (56)
 =======================
 [<c03363e0>] do_page_fault+0x0/0x650 (40)
 [<c0104ddf>] error_code+0x4f/0x54 (8)
 [<c0336145>] kprobe_excepti>] vprintk+0x2e5/0x2ea (20)
 [<c0126b5e>] vprintk+0x2e5/0x2ea (12)
 [<c0118f3d>] smp_apic_timer_interrupt+0x3c/0x42 (76)
 [<c0126851>] printk+0x1c/0x44 (20)
 [<c0125e97>] panic+0x4c/0x190 (20)
 [<c010560d>] die+0x19b/0x1a5 (24)
 [<c0126851>] printk+0x1c/0x44 (36)
 [<c03365fd>]4> [<c01052bd>] show_registers+0x16d/0x29f (28)
 [<c0105583>] die+0x111/0x1a5 (56)
 [<c03365fd>] do_page_fault+0x21d/0x650 (56)
 [<c03363e0>] do_page_fault+0x0/0x650 (76)
 [<c0104ddf>] error_code+0x4f/0x54 (8)
 [<c0105000>] show_trace+0x21/0x86 (44)
 [<c01050ee>] show_stack+0xdf>] error_code+0x4f/0x54 (8)
 [<c0105000>] show_trace+0x21/0x86 (44)
 [<c01050ee>] show_stack+0x89/0xd4 (36)
 [<c01052bd>] show_registers+0x16d/0x29f (28)
 [<c0105583>] die+0x111/0x1a5 (56)
 [<c03365fd>] do_page_fault+0x21d/0x650 (56)
 [<c03363e0>] do_page_fault+0x0/0x650 (1/0x1a5 (56)
 [<c03365fd>] do_page_fault+0x21d/0x650 (56)
 [<c03363e0>] do_page_fault+0x0/0x650 (76)
 [<c0104ddf>] error_code+0x4f/0x54 (8)
 [<c0105000>] show_trace+0x21/0x86 (44)
 [<c010514c>] dump_stack+0x13/0x17 (36)
 [<c0125e9c>] panic+0x51/0x190 (8)
 [<c0129332>] do_exit+0x4c010514c>] dump_stack+0x13/0x17 (36)
 [<c0125e9c>] panic+0x51/0x190 (8)
 [<c0129332>] do_exit+0x497/0x4e8 (24)
 [<c0126851>] printk+0x1c/0x44 (8)
 [<c0105617>] do_divide_error+0x0/0xa8 (32)
 [<c0126851>] printk+0x1c/0x44 (36)
 [<c03365fd>] do_page_fault+0x21d/0x650 (20)
[MUNCH... a very long list follows]

There's a lot more stuff in the logs after that but this is what seems
to trigger everything else. I can send the whole thing or post it if it
would help [50Kb gzipped, 1M+ text]. Let me know...

-- Fernando


