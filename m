Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWFGVBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWFGVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWFGVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:01:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:63439 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932418AbWFGVBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:01:14 -0400
Subject: [BUG -rt] softlockup via do_page_fault/kunmap_high
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 14:01:08 -0700
Message-Id: <1149714068.6335.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,
	This was seen w/ 2.6.16-rt22 (I know, its a little stale) while running
the pounder stress tests (recently included in ltp, i believe). 

thanks
-john


 BUG: soft lockup detected on CPU#0!
 [<c010383a>] show_trace+0x13/0x15 (20)
 [<c0103914>] dump_stack+0x16/0x18 (20)
 [<c0140e59>] softlockup_tick+0x9a/0xae (32)
 [<c012a7b3>] run_local_timers+0x12/0x14 (8)
 [<c012a75c>] update_process_times+0x3e/0x65 (20)
 [<c013b567>] handle_update+0x16/0x18 (12)
 [<c013b5dd>] handle_nextevent_update+0x14/0x17 (12)
 [<c0113139>] smp_apic_timer_interrupt+0x46/0x51 (16)
 [<c01034bc>] apic_timer_interrupt+0x1c/0x24 (64)
 [<c041edb0>] rt_lock_slowlock+0x131/0x1ac (116)
 [<c041f4ab>] __lock_text_start+0xb/0xd (8)
 [<c014c8a9>] kunmap_high+0x10/0xb7 (12)
 [<c0118371>] kunmap+0x55/0x5a (12)
 [<c01183b3>] kunmap_virt+0x3d/0x3f (12)
 [<c015000c>] do_no_page+0x27c/0x294 (72)
 [<c015020e>] __handle_mm_fault+0x134/0x21c (60)
 [<c0116fb8>] do_page_fault+0x170/0x518 (104)
 [<c0103563>] error_code+0x4f/0x54 (-364407804)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c041f8c3>] .... _raw_spin_lock+0xd/0x21
.....[<c0141509>] ..   ( <= __do_IRQ+0xad/0x100)
.. [<c041f8c3>] .... _raw_spin_lock+0xd/0x21
.....[<c0140e49>] ..   ( <= softlockup_tick+0x8a/0xae)

------------------------------
| showing all locks held by: |  (10-udev.hotplug/27302 [c7992870, 114]):
------------------------------

#001:             [f698c3f4] {(struct rw_semaphore *)(&mm->mmap_sem)}
... acquired at:               rt_down_read_trylock+0x40/0x45

BUG: soft lockup detected on CPU#0!
 [<c010383a>] show_trace+0x13/0x15 (20)
 [<c0103914>] dump_stack+0x16/0x18 (20)
 [<c0140e59>] softlockup_tick+0x9a/0xae (32)
 [<c012a7b3>] run_local_timers+0x12/0x14 (8)
 [<c012a75c>] update_process_times+0x3e/0x65 (20)
 [<c013b567>] handle_update+0x16/0x18 (12)
 [<c013b5dd>] handle_nextevent_update+0x14/0x17 (12)
 [<c0113139>] smp_apic_timer_interrupt+0x46/0x51 (16)
 [<c01034bc>] apic_timer_interrupt+0x1c/0x24 (64)
 [<c041edb0>] rt_lock_slowlock+0x131/0x1ac (116)
 [<c041f4ab>] __lock_text_start+0xb/0xd (8)
 [<c014c8a9>] kunmap_high+0x10/0xb7 (12)
 [<c0118371>] kunmap+0x55/0x5a (12)
 [<c01183b3>] kunmap_virt+0x3d/0x3f (12)
 [<c015000c>] do_no_page+0x27c/0x294 (72)
 [<c015020e>] __handle_mm_fault+0x134/0x21c (60)
 [<c0116fb8>] do_page_fault+0x170/0x518 (104)
 [<c0103563>] error_code+0x4f/0x54 (-364407804)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c041f8c3>] .... _raw_spin_lock+0xd/0x21
.....[<c0141509>] ..   ( <= __do_IRQ+0xad/0x100)
.. [<c041f8c3>] .... _raw_spin_lock+0xd/0x21
.....[<c0140e49>] ..   ( <= softlockup_tick+0x8a/0xae)

------------------------------
| showing all locks held by: |  (10-udev.hotplug/27302 [c7992870, 114]):
------------------------------

#001:             [f698c3f4] {(struct rw_semaphore *)(&mm->mmap_sem)}
... acquired at:               rt_down_read_trylock+0x40/0x45






Another variant reported:
BUG: soft lockup detected on CPU#3!
 [<c013dd41>] softlockup_tick+0x9a/0xab (8)
 [<c01250c2>] update_process_times+0x39/0x5c (28)
 [<c011060b>] smp_apic_timer_interrupt+0x46/0x4c (16)
 [<c0103284>] apic_timer_interrupt+0x1c/0x24 (8)
 [<c0311168>] _raw_spin_lock+0x11/0x19 (44)
 [<c031078e>] rt_lock_slowlock+0xd9/0x139 (12)
 [<c0310e2d>] __lock_text_start+0x1d/0x1e (72)
 [<c0148e7d>] kmap_high+0x21/0x1ca (4)
 [<c0144243>] __mod_page_state_offset+0x28/0x45 (48)
 [<c0144296>] mod_page_state_offset+0x36/0x5a (24)
 [<c014c90b>] __handle_mm_fault+0xdf/0x24c (16)
 [<c031211b>] do_page_fault+0x17a/0x528 (48)
 [<c0311fa1>] do_page_fault+0x0/0x528 (80)
 [<c010332b>] error_code+0x4f/0x54 (8)



