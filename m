Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUKEWg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUKEWg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKEWg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:36:58 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:37638 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261213AbUKEWgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:36:55 -0500
Date: Fri, 5 Nov 2004 14:36:10 -0800
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, john cooper <john.cooper@timesys.com>,
       Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041105223610.GA3756@nietzsche.lynx.com>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu> <418A7BFB.6020501@timesys.com> <20041104194416.GC10107@elte.hu> <20041105214238.GA11075@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105214238.GA11075@yoda.timesys>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 04:42:38PM -0500, Scott Wood wrote:
> On Thu, Nov 04, 2004 at 08:44:16PM +0100, Ingo Molnar wrote:
> > is the order of locks in the dependency chain really unpredictable? If
> > two chain walkers get two locks in opposite order, doesnt that mean that
> > the lock ordering (as attempted by the blocked tasks) is deadlock-prone
> > already? I.e. this scenario should not happen.
> 
> It *shouldn't*, but bugs do happen, and it'd be nice if a mutex
> deadlock didn't get promoted into a less debuggable spinlock
> deadlock.  Plus, if there's any intention of ever exporting this
> priority inheritance mechanism to userspace locks, we don't want to
> promote a userspace deadlock into a kernel one.
> 
> Given how rarely contention should occur, I don't think that a single
> lock would be a bottleneck except for obscenely large SMP machines.

Places that are surround by rcu locks are possibilities that could
hit the kind of contention. There's numerous places in the kernel
that use it, but nothing can be said until there's stats on how these
things content against each other, dcache_lock, I believe and others.

I think of an RT kernel with N threads in terms where it's an SMP
machine with same N number of processors. If you have N threads
pounding on the same critical sections, it's effectively N physical
processors hitting as well.

Correct me if I'm wrong, vague, etc...  but that's how I understand
the problem and that's how I think it should be addressed. Ideally,
the kernel should be so efficient that these collision should never
happen and the use of priority propagation should be very shallow
to prevent irregularities with scheduling resulting from priority
boosting lock chains. Only a statically gathering of how this system
behaves will show the technical direction that this project should
direct itself.

BTW, we're working getting a single super-mutex that right now
internally that can possibly be used for proper priority propagation,
for all blocking type locks. Hopefully, with testing we'll see how
well it and the rest of the kernel performs with it. Correctness is
is the highest priority, but overall behavior of the system is very
important and should be next in ranking IMO.

bill

