Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUKEVm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUKEVm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUKEVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:42:58 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:23763 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S261155AbUKEVm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:42:56 -0500
Date: Fri, 5 Nov 2004 16:42:38 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: john cooper <john.cooper@timesys.com>, Mark_H_Johnson@raytheon.com,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041105214238.GA11075@yoda.timesys>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu> <418A7BFB.6020501@timesys.com> <20041104194416.GC10107@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104194416.GC10107@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 08:44:16PM +0100, Ingo Molnar wrote:
> 
> * john cooper <john.cooper@timesys.com> wrote:
> > 
> > This is a fairly gnarly problem to address.  The obvious solution is
> > to hold spinlocks in the mutexes as the dependency tree is atomically
> > traversed.  However this will deadlock under MP due to the
> > unpredictable order of mutexes traversed.  If the dependency chain is
> > not traversed (and semantics applied) atomically, races exist which
> > cause promotion decisions to be made on [now] stale data.
> 
> is the order of locks in the dependency chain really unpredictable? If
> two chain walkers get two locks in opposite order, doesnt that mean that
> the lock ordering (as attempted by the blocked tasks) is deadlock-prone
> already? I.e. this scenario should not happen.

It *shouldn't*, but bugs do happen, and it'd be nice if a mutex
deadlock didn't get promoted into a less debuggable spinlock
deadlock.  Plus, if there's any intention of ever exporting this
priority inheritance mechanism to userspace locks, we don't want to
promote a userspace deadlock into a kernel one.

Given how rarely contention should occur, I don't think that a single
lock would be a bottleneck except for obscenely large SMP machines.

-Scott
