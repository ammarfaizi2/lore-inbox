Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270057AbUJTJ4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270057AbUJTJ4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270121AbUJTJvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:51:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61142 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270308AbUJTJpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:45:49 -0400
Date: Wed, 20 Oct 2004 11:45:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020094508.GA29080@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019180059.GA23113@elte.hu>
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


i have released the -U8 Real-Time Preemption patch:

  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8

this too is a fixes-only release. It includes the many semaphore-abuse
and sleep_on() fixes/improvements from Thomas Gleixner, and it also
includes a couple of semaphore related fixes.

I believe the semaphore fixes should resolve a number of the deadlocks
reported for -U7.

In particular it seems the only sane and reliable way to convert RCU
locking was to allow the following semantics for rwsems: allow reads to
nest, and allow self-read-recursion of a self-write-held semaphore. My
current implementation for this allows semaphore unfairness, but that
can be fixed later on. Most importantly, the RCU to RT-locking
conversions are much more automatic now and map nicely to what the code
is doing upstream. Most of the time they involve a conversion of a
spinlock or semaphore into a rwlock or rwsem. The old code maps to new
code almost automatically, the only manual work needed was to associate
the rcu_read_lock() with the writers-lock that it excludes against,
which is a pretty clear (but not automatic, and hence not automatable)
decision. This way i could convert some more networking code, and
simplify the older changes and hopefully get rid of some deadlocks. The
locking API is still not in its final form, but it's getting closer.

Changes since -U7:

 - deadlock fix: sysfs/driver-base semaphore fixes from Thomas Gleixner

 - deadlock fix: scsi semaphore fixes from Thomas Gleixner

 - NFS sleep_on() fixes from Thomas Gleixner

 - rawmidid.c sleep_on() fix from Thomas Gleixner

 - [ i've added more wait_for_completion_*() primitives, to ease 
     conversion of other semaphore-(ab-)using code. ]

 - make rwsems self-recursive

 - RCU lock conversion: convert rtnl_sem RCU use.

 - netfilter deadlock fix - clean up RCU locking.

to create a -U8 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8

	Ingo
