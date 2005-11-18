Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbVKRNOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbVKRNOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbVKRNOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:14:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24220 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030601AbVKRNOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:14:11 -0500
Date: Fri, 18 Nov 2005 18:51:37 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051118132137.GA5639@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118092909.GC4858@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 10:29:09AM +0100, Ingo Molnar wrote:
> 
> * David Singleton <dsingleton@mvista.com> wrote:
> 
> > >I was testing PI support in the -rt tree (-rt13) when I hit the BUG
> > >below. I am using the BULL/Montavista glibc patches. However I would
> > >think this can be reproduced using just plain FUTEX_WAKE/WAIT_ROBUST
> > >APIs as well, though I havent tried.  I can send out the test code
> > >if anybody is interested. I have attached the .config below.
> > > 
> > >
> 
> >    If I make the lock in the timer_base_s struct a raw spinlock this 
> > BUG goes away.
> 
> that most likely just papers over the real bug. Given task-reference 
> count bug i fixed in the robust/PI-futexes code (see the patch below) i 
> suspect some more races and/or plain incorrect code.
> 
> [this patch below also converts the robust/PI-futex code to use RCU 
> instead of the tasklist_lock - which should remove a major latency 
> source from the futex code].
> 

[snip patch]


Ingo, Thanks for providing the fix. However I still hit the same bug
even with your changes

	-Dinakar


testpi-1/1153[CPU#1]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c01337a9>] pi_setprio+0xa1/0x642 (104)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0380d7d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0122796>] lock_timer_base+0x19/0x33 (16)
 [<c01227e8>] __mod_timer+0x38/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (8)
 [<c0134ba6>] process_timeout+0x0/0x9 (36)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c013affe>] add_preempt_count_ti+0x1e/0xc6 (100)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (44)
 [<c013d06e>] do_futex+0x96/0xfc (24)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-1/1153 [f7bd2730,  69]):
------------------------------

#001:             [c3878fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33

testpi-1/1153[CPU#2]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (100)
 [<c0122838>] __mod_timer+0x88/0xdf (12)
 [<c0380c3d>] __lock_text_start+0x1d/0x41 (12)
 [<c0122838>] __mod_timer+0x88/0xdf (8)
 [<c0122838>] __mod_timer+0x88/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (8)
 [<c0134ba6>] process_timeout+0x0/0x9 (36)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c013affe>] add_preempt_count_ti+0x1e/0xc6 (100)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (44)
 [<c013d06e>] do_futex+0x96/0xfc (24)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-1/1153 [f7bd2730,  69]):
------------------------------

#001:             [c3888fe0] {&base->t_base.lock}
... acquired at:               __mod_timer+0x88/0xdf

testpi-1/1155[CPU#0]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c01337a9>] pi_setprio+0xa1/0x642 (104)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0380d7d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0122796>] lock_timer_base+0x19/0x33 (16)
 [<c01227e8>] __mod_timer+0x38/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c0134ba6>] process_timeout+0x0/0x9 (44)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (76)
 [<c0380c3d>] __lock_text_start+0x1d/0x41 (24)
 [<c013d06e>] do_futex+0x96/0xfc (68)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-1/1155 [f6fb8730,   0]):
------------------------------

#001:             [c3868fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33


===================================================================


Different testcase, similar result


testpi-2/1159[CPU#1]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c01337a9>] pi_setprio+0xa1/0x642 (104)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0380d7d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0122796>] lock_timer_base+0x19/0x33 (16)
 [<c01227e8>] __mod_timer+0x38/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (8)
 [<c0134ba6>] process_timeout+0x0/0x9 (36)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c013affe>] add_preempt_count_ti+0x1e/0xc6 (100)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (44)
 [<c013d06e>] do_futex+0x96/0xfc (24)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-2/1159 [f6650020,  69]):
------------------------------
#001:             [c3878fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33

testpi-2/1160[CPU#1]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c01337a9>] pi_setprio+0xa1/0x642 (104)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0380d7d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0122796>] lock_timer_base+0x19/0x33 (16)
 [<c01227e8>] __mod_timer+0x38/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c0134ba6>] process_timeout+0x0/0x9 (44)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (76)
 [<c013d06e>] do_futex+0x96/0xfc (92)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-2/1160 [f6f58830,  59]):
------------------------------
#001:             [c3878fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33

testpi-2/1161[CPU#2]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011a700>] __WARN_ON+0x60/0x80 (8)
 [<c037e97e>] __down_mutex+0x4fe/0x7fd (48)
 [<c01337a9>] pi_setprio+0xa1/0x642 (104)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0380d7d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122796>] lock_timer_base+0x19/0x33 (8)
 [<c0122796>] lock_timer_base+0x19/0x33 (16)
 [<c01227e8>] __mod_timer+0x38/0xdf (16)
 [<c013b15b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03806dd>] __down_interruptible+0x923/0xb2b (20)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (16)
 [<c0134ba6>] process_timeout+0x0/0x9 (44)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (64)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (24)
 [<c0138270>] down_futex+0x66/0xab (8)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (12)
 [<c013c8cd>] futex_wait_robust+0x151/0x25b (20)
 [<c03813b4>] _raw_spin_unlock+0x12/0x2c (76)
 [<c0380c3d>] __lock_text_start+0x1d/0x41 (24)
 [<c013d06e>] do_futex+0x96/0xfc (68)
 [<c013d1cc>] sys_futex+0xf8/0x104 (40)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b0c0>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-2/1161 [f6c08120,   0]):
------------------------------
#001:             [c3888fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33


