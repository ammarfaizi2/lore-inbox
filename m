Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVCVHaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVCVHaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVCVH1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:27:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2506 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262195AbVCVHYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:24:38 -0500
Date: Tue, 22 Mar 2005 08:24:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322072413.GA6149@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322054345.GB1296@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> > it includes the latest round of RCU fixes - but doesnt solve the SMP
> > bootup crash.
> 
> Hello, Ingo,
> 
> Does the following help with the SMP problem?  This fix and the
> earlier one make my old patch survive a few rounds of kernbench on a
> 4-CPU x86 box. [...]

does not seem to fix my testbox (see the crash log below). I've uploaded
the 40-02 patch with both of your fixes (maybe i mismerged something
somewhere). Does it boot on your box with PREEMPT_RT enabled? The patch
order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.41-02

	Ingo

NET: Registered protocol family 16
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0131bcc
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0131bcc>]    Not tainted VLI
EFLAGS: 00010297   (2.6.12-rc1-RT-V0.7.41-01) 
EIP is at rcu_advance_callbacks+0x3c/0x80
eax: 00000000   ebx: c050f280   ecx: c12191e0   edx: 00000000
esi: c1341c64   edi: c1341be4   ebp: c1355dd0   esp: c1355dc8
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process khelper (pid: 17, threadinfo=c1354000 task=c13538d0)
Stack: 00000001 c12191e0 c1355de4 c0131c47 00000001 c1341bdc c13004d8 c1355e00 
       c017e529 c1341bdc c04d6e80 c1358006 fffffffe c1355e54 c1355e70 c0174aac 
       c1341bdc c1355e50 c1355e4c c1355e54 c1358001 c1341bdc c04cf920 00000286 
Call Trace:
 [<c010412f>] show_stack+0x7f/0xa0 (28)
 [<c01042da>] show_registers+0x16a/0x1e0 (56)
 [<c0104511>] die+0x101/0x190 (64)
 [<c0115862>] do_page_fault+0x442/0x680 (216)
 [<c0103d9b>] error_code+0x2b/0x30 (68)
 [<c0131c47>] call_rcu+0x37/0x70 (20)
 [<c017e529>] dput+0x139/0x210 (28)
 [<c0174aac>] __link_path_walk+0x9fc/0xf80 (112)
 [<c017507a>] link_path_walk+0x4a/0x130 (100)
 [<c017546e>] path_lookup+0x9e/0x1c0 (32)
 [<c01708c8>] open_exec+0x28/0x100 (100)
 [<c0171ae4>] do_execve+0x44/0x220 (36)
 [<c0101da2>] sys_execve+0x42/0xa0 (36)
 [<c0103315>] syscall_call+0x7/0xb (-8096)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c0131c2f>] .... call_rcu+0x1f/0x70
.....[<c017e529>] ..   ( <= dput+0x139/0x210)
.. [<c0131ba3>] .... rcu_advance_callbacks+0x13/0x80
.....[<c0131c47>] ..   ( <= call_rcu+0x37/0x70)
.. [<c03ddeaa>] .... _raw_spin_lock_irqsave+0x1a/0xa0
.....[<c010444f>] ..   ( <= die+0x3f/0x190)
.. [<c013bac6>] .... print_traces+0x16/0x50
.....[<c010412f>] ..   ( <= show_stack+0x7f/0xa0)

Code: 00 00 e8 78 2d 0a 00 8b 0c 85 20 20 51 c0 bb 80 f2 50 c0 01 d9 f0 83 44 24 00 00 a1 88 19 52 c0 39 41 40 74 23 8b 41 44 8b 51 50 <89> 02 8b 41 48 c7 41 44 00 00 00 00 89 41 50 8d 41 44 89 41 48 

(gdb) list *0xc0131bcc
0xc0131bcc is in rcu_advance_callbacks (kernel/rcupdate.c:586).
581             struct rcu_data *rdp;
582
583             rdp = &get_cpu_var(rcu_data);
584             smp_mb();       /* prevent sampling batch # before list removal. */
585             if (rdp->batch != rcu_ctrlblk.batch) {
586                     *rdp->donetail = rdp->waitlist;
587                     rdp->donetail = rdp->waittail;
588                     rdp->waitlist = NULL;
589                     rdp->waittail = &rdp->waitlist;
590                     rdp->batch = rcu_ctrlblk.batch;
(gdb)

