Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVCYPAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVCYPAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 10:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVCYPAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 10:00:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59817 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261669AbVCYO7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:59:41 -0500
Date: Fri, 25 Mar 2005 15:59:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
Message-ID: <20050325145908.GA7146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release fixes two bugs:

 - one affecting SMP systems & RCU (the missing smp_mb()s)

 - the other one in net/xfrm/xfrm_policy.c, affecting systems where 
   network interfaces (or pseudo-interfaces) are frequently 
   created/destroyed

i've also added a new debugging feature which is activated if 
RT_DEADLOCK_DETECT is enabled: the checking of active locks in freed 
memory.

This catches a dangerous category of bugs which the upstream kernel can 
silently ignore (because there locks are quite 'passive'), while the -RT 
kernel will often go down in flames sometime later (it has lists within 
the lock, etc.). This mechanism found the xfrm_policy.c bug:

 BUG: events/0/4, active lock [e94a8cdc(e94a8cd0-e94a90dc)] freed!
  [<c0103e31>] dump_stack+0x1e/0x20 (20)
  [<c0136fa2>] check_no_locks_freed+0x158/0x210 (60)
  [<c01477e9>] kfree+0x59/0x15a (48)
  [<c03638db>] xfrm_policy_gc_task+0x6f/0x7e (28)
  [<c012f3c7>] worker_thread+0x1c1/0x26c (132)
  [<c01333e9>] kthread+0x95/0xbd (48)
  [<c01012c9>] kernel_thread_helper+0x5/0xb (1039269908)

so i'd expect more such bugs to be found. If you had stability problems 
under PREEMPT_RT (hangs, crashes), please enable RT_DEADLOCK_DETECT and 
try to reproduce the problem and send me the resulting log messages.

to create a -V0.7.41-10 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.41-10

	Ingo
