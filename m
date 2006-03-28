Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWC1UwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWC1UwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWC1UwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:52:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42373 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932146AbWC1UwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:52:18 -0500
Date: Tue, 28 Mar 2006 22:49:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Simon Derr <simon.derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
Message-ID: <20060328204944.GA1217@elte.hu>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk> <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603281142410.17504@apollon>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4997]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Simon Derr <simon.derr@bull.net> wrote:

> On Mon, 27 Mar 2006, Ingo Molnar wrote:
> 
> > i've released -rt10
> 
> Is anyone working on a port of this patch to the IA64 architecture ?

not that i know of. If someone wants to do that, take a look at the 
x86_64 changes (or ppc/mips/i386 changes) to get an idea. These are the 
rough steps needed:

 - do the raw_spinlock_t/rwlock_t -> __raw_spinlock_t/rwlock_t rename

 - change the APIs in asm-ia64/semaphore.h (and arch files) to
   compat_up()/down()/etc.

 - in the arch Kconfig, turn off RWSEM_XCHGADD_ALGORITHM if PREEMPT_RT.

 - add the TID_NEED_RESCHED_DELAYED logic to thread_info.h and the entry
   assembly code.

 - change most/all spinlocks in arch/ia64 to raw_spinlock / RAW_SPINLOCK

 - change most/all seqlocks to raw_seqlock / RAW_SEQLOCK

 - add smp_send_reschedule_allbutself().

 - take a good look at the arch/x86_64/kernel/process.c changes and port
   the need_resched_delayed() and __schedule() changes.

that should be at least 95% of what's needed. (the x86_64 port does a 
couple of other things too, like latency tracing support, etc., but you 
dont need those for the initial ia64 port.)

	Ingo
