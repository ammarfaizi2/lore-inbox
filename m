Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSDRX2r>; Thu, 18 Apr 2002 19:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314497AbSDRX2q>; Thu, 18 Apr 2002 19:28:46 -0400
Received: from holomorphy.com ([66.224.33.161]:41119 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314496AbSDRX2o>;
	Thu, 18 Apr 2002 19:28:44 -0400
Date: Thu, 18 Apr 2002 16:27:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <focht@ess.nec.de>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
Subject: Re: [PATCH] migration thread fix
Message-ID: <20020418232753.GP23767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <focht@ess.nec.de>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	torvalds@transmeta.com
In-Reply-To: <1019166066.5395.99.camel@phantasy> <Pine.LNX.4.44.0204182358450.3004-100000@beast.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 12:24:14AM +0200, Erich Focht wrote:
> Bill,
> thanks for sending me your patch. No, I didn't see it before.

No trouble at all.

On Fri, Apr 19, 2002 at 12:24:14AM +0200, Erich Focht wrote:
> Hmm, as far as I can see, it probably fixes the problems but keeps the
> original philosophy of depending on the load balancer to get the
> migration tasks scheduled on every CPU.

It does keep the original philosophy, and it's not too complicated:

	(1) Keeping the bound migration_thread in busywait prevents
		the idle task from not being able to migrate an unbound
		task from a cpu where task is bound already because the
		task it wants to migrate is already running -- basically
		the state of busywait locks the cpu

	(2) Putting migration_init() to sleep on a completion to free
		up the cpu it's running on and waking it up when every
		migration_thread has made it home to opens up the cpu
		migration_init() was running on quite safely, and that
		that progress is tracked by an atomic counter

	(3) Getting rid of the timeouts, they lead to livelocks (or
		very long waits) when the window while something's
		awake is always when it can't get anything done

It's really a very conservative algorithm.


On Fri, Apr 19, 2002 at 12:24:14AM +0200, Erich Focht wrote:
> The first thread starts up on the boot cpu with cpus_allowed mask set
> to the boot cpu. It will write itself into cpu_rq(0)->migration_thread
> and be fully functional because all other existing threads (and
> migration_init) will call yield() or schedule(). The other
> migration_threads can also run only on cpu#0 and will do so when
> migration_CPU0 was completely initialized. Then they move themselves
> to their designated CPU by calling set_cpus_allowed(). Their initial
> CPU mask beeing 1<<0, they will call migration_CPU0, which is fully
> functional at this time and only does the job it was designed
> for. There is no dependency on the load balancer any more.

I'm not sure set_cpus_allowed() is safe to call at this stage. OTOH
setting task->cpus_allowed one way or the other from the argument will
ensure that the only idle task to steal it is the one from the cpu it's
destined for. Basically, it's whether you pick your cpu before or after
you land on it. The idle task will bring you home either way. An extra
push from cpu0 probably doesn't hurt either. =)

The only bit that really scares me is that I know my own patch works
and I don't really truly know that yours does (and never will until I
run it a number of times). And I'll bet you're in a similar position
yourself. The side issues are non-issues to me; I just want kernels that
do a little more than hang at boot so I can hack on other parts of it.
I'll get around to testing it soon, but it's kind of a pain, because
failed attempts didn't fail every time, and the machines where it fails
are not swift to boot... though I imagine you're in a similar position
wrt. testing being a hassle. =)

Let me get some other things out of the way and I'll make time for it.
Though we may have duplicated effort, I do appreciate your work.


Thanks,
Bill
