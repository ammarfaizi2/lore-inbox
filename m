Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUJYKkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUJYKkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUJYKkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:40:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19130 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261750AbUJYKjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:39:18 -0400
Date: Mon, 25 Oct 2004 12:40:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025104023.GA1960@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022175633.GA1864@elte.hu>
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


i have released the -V0 Real-Time Preemption patch, which can be
downloaded from:

  http://redhat.com/~mingo/realtime-preempt/

NOTE: this is a highly experimental release, a more experimental one
than -U10.3.

the big change in the '-V' series of the patchset is that i have
converted the last couple of non-preemptible kernel subsystems to
fully-preemptible mutex-based locking. These subsystems are:

 - the SLAB allocator
 - the buddy page allocator
 - waitqueue handling
 - soft-timer subsystem
 - security/selinux
 - workqueues
 - the random driver

this is probably the last 'big leap forward' in terms of the scope of
the patch. (having reached the ultimate scope: it now encompasses
everything ;)

But as an inevitable result of this big leap it will likely break in a
couple of places. Unfortunately these subsystems were largely
interdependent so it's an all-or-nothing step with not much middle
ground between the locking done in -U10.3 and in -V0.

another result of these changes is that the number of critical sections
in -V0 is roughly 30% of that in -U10.3. Now we only have the scheduler
and very lowlevel IRQ-hardware locks as raw spinlocks. (plus the lone
holdout vga_lock - which i will probably make a mutex too in the near
future)

[ NOTE: there's one known bug in this release: selinux on one of my
testsystems broke, it hangs during bootup. With CONFIG_SECURITY disabled
it works fine. I'm working on the fix. So please keep CONFIG_SECURITY
disabled for the time being. ]

other changes in -V0:

 - build fixes: more driver fixes from Thomas Gleixner

 - crash fix: fixed a bug found by Thomas Gleixner: rwsem runtime
   initialization was racy.

 - deadlock fix: fixed lockup bug caused by __schedule clearing
   PREEMPT_ACTIVE. The need_resched loop is now outside of __schedule(). 
   This might solve lockups/slowdowns reported by some people.

 - latency fix: made keventd SCHED_FIFO - this could fix the mouse
   related delays reported by a number of people.

 - latency fix: fixed SMP lock-break mechanism of mutexes.

 - usability feature: hard-interrupts get decreasing SCHED_FIFO priority
   starting at prio 49 and stopping at prio 25. This should give a good
   default.

 - debug feature: implemented SysRq-D to show the list of tasks with
   locks blocked on, if RW_SEM_DEADLOCK_DETECTION is enabled.

to create a -V0 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-V0

	Ingo
