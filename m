Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUJ0APJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUJ0APJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUJ0API
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:15:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34690 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261604AbUJ0AOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:14:41 -0400
Date: Wed, 27 Oct 2004 02:15:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
Message-ID: <20041027001542.GA29295@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025104023.GA1960@elte.hu>
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


i have released the -V0.3 Real-Time Preemption patch, which can be
downloaded from:

	http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release, but still experimental.

this release should fix a number of bugs that were reported for the V0
series: the futex.c assert, the lockups and the 'slowdown problem'.

The slowdown problem was an architectural issue that surfaced sometime
around U10 and increased in prominence as the the number of mutexes
increased and the number of spinlocks decreased. The futex.c assert was
related to this architectural issue as well, and most of the lockups
reported were i believe livelocks caused by the same issue. Also, the
scheduler path had an easy-to-trigger deadlock that often just silently
locked up.

some of the networking lockups might be related to this issue too, but i
think PREEMPT_REALTIME still has separate lock odering issues within the
networking code. Please re-report any deadlock-tracer asserts that you
might encounter.

Changes since -V0.2:

 - HEAP_SIZE fix from Karsten Wiese

 - fix hdparm-triggered debugging message reported by Mark H Johnson

 - fixed mutex related preemption to not impact the task state, just 
   like a normal spinlock does. This necessiated the introduction of
   TASK_RUNNING_MUTEX handling and related kernel infrastructure. This 
   framework avoids spurious wakeups done by mutex handling by isolating
   the state changes done by normal wakeups vs. the state changes caused
   by the mutex code.

 - added per-CPU deschedule threads. This fixes a deadlock scenario and
   it is also much faster than keventd.

 - fix debugging message upon console unblanking

to create a -V0.3 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-V0.3

	Ingo
