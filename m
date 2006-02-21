Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWBUP5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWBUP5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWBUP5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:57:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52933 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161234AbWBUP5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:57:50 -0500
Date: Tue, 21 Feb 2006 16:55:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.15-rt17
Message-ID: <20060221155548.GA30146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

i have released the 2.6.15-rt17 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

lots of changes all across the map. There are several bigger changes:

the biggest change is the new PI code from Esben Nielsen, Thomas 
Gleixner and Steven Rostedt. This big rework simplifies and streamlines 
the PI code, and fixes a couple of bugs and races:

  - only the top priority waiter on a lock is enqueued into the pi_list
    of the task which holds the lock. No more pi list walking in the
    boost case.

  - simpler locking rules

  - fast Atomic acquire for the non contended case and atomic release 
    for non waiter case is fully functional now

  - use task_t references instead of thread_info pointers

  - BKL handling for semaphore style locks changed so that BKL is
    dropped before the scheduler is entered and reaquired in the return
    path. This solves a possible deadlock situation in the BKL reacquire
    path of the scheduler.

another change is the reworking of the SLAB code: it now closely matches 
the upstream SLAB code, and it should now work on NUMA systems too 
(untested though).

the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
fix was to rework the tasklet code to get rid of the 'retrigger 
softirqs' approach.

other changes: various hrtimers fixes, latency tracer enhancements - and 
more. (Robust-futexes are not expected to work in this release.)

please report any new breakages, and re-report any old breakages as 
well.

to build a 2.6.15-rt17 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17

	Ingo
