Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVCUIyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVCUIyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVCUIyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:54:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16606 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261696AbVCUIyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:54:35 -0500
Date: Mon, 21 Mar 2005 09:53:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Message-ID: <20050321085332.GA7163@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320174508.GA3902@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


got this early-bootup crash on an SMP box:

BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0131aec
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0131aec>]    Not tainted VLI
EFLAGS: 00010293   (2.6.12-rc1-RT-V0.7.41-00) 
EIP is at rcu_advance_callbacks+0x3c/0x80
eax: 00000000   ebx: c050f280   ecx: c12191e0   edx: 00000000
esi: cfd2e560   edi: cfd2e4e0   ebp: cfd31dd0   esp: cfd31dc8
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process khelper (pid: 60, threadinfo=cfd30000 task=cfd106a0)
Stack: 00000001 c12191e0 cfd31de4 c0131b67 00000001 cfd2e4d8 c13004d8 cfd31e00 
       c017e449 cfd2e4d8 c04d6e80 cfd32006 fffffffe cfd31e54 cfd31e70 c01749cc 
       cfd2e4d8 cfd31e50 cfd31e4c 00000001 cfd32001 cfd2e4d8 c03dd41f c04cf920 
Call Trace:
 [<c010412f>] show_stack+0x7f/0xa0 (28)
 [<c01042da>] show_registers+0x16a/0x1e0 (56)
 [<c0104511>] die+0x101/0x190 (64)
 [<c0115862>] do_page_fault+0x442/0x680 (216)
 [<c0103d9b>] error_code+0x2b/0x30 (68)
 [<c0131b67>] call_rcu+0x37/0x70 (20)
 [<c017e449>] dput+0x139/0x210 (28)
 [<c01749cc>] __link_path_walk+0x9fc/0xf80 (112)
 [<c0174f9a>] link_path_walk+0x4a/0x130 (100)
 [<c017538e>] path_lookup+0x9e/0x1c0 (32)
 [<c01707e8>] open_exec+0x28/0x100 (100)
 [<c0171a04>] do_execve+0x44/0x220 (36)
 [<c0101da2>] sys_execve+0x42/0xa0 (36)
 [<c0103315>] syscall_call+0x7/0xb (-8096)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c0131b4f>] .... call_rcu+0x1f/0x70
.....[<c017e449>] ..   ( <= dput+0x139/0x210)
.. [<c0131ac3>] .... rcu_advance_callbacks+0x13/0x80
.....[<c0131b67>] ..   ( <= call_rcu+0x37/0x70)
.. [<c03dddca>] .... _raw_spin_lock_irqsave+0x1a/0xa0
.....[<c010444f>] ..   ( <= die+0x3f/0x190)
.. [<c013b9e6>] .... print_traces+0x16/0x50
.....[<c010412f>] ..   ( <= show_stack+0x7f/0xa0)

Code: 00 00 e8 78 2d 0a 00 8b 0c 85 20 20 51 c0 bb 80 f2 50 c0 01 d9 f0 83 44 24 00 00 a1 88 19 52 c0 39 41 40 74 23 8b 41 44 8b 51 50 <89> 02 8b 41 48 c7 41 44 00 00 00 00 89 41 50 8d 41 44 89 41 48 
 <6>note: khelper[60] exited with preempt_count 2

(gdb) list *0xc0131aec
0xc0131aec is in rcu_advance_callbacks (kernel/rcupdate.c:558).

553             struct rcu_data *rdp;
554
555             rdp = &get_cpu_var(rcu_data);
556             smp_mb();       /* prevent sampling batch # before list removal. */
557             if (rdp->batch != rcu_ctrlblk.batch) {
558                     *rdp->donetail = rdp->waitlist;
559                     rdp->donetail = rdp->waittail;
560                     rdp->waitlist = NULL;
561                     rdp->waittail = &rdp->waitlist;
562                     rdp->batch = rcu_ctrlblk.batch;
(gdb)
