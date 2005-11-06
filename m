Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVKFBzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVKFBzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVKFBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:55:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35614
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932279AbVKFBzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:55:46 -0500
Date: Sun, 6 Nov 2005 02:55:42 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051106015542.GE14064@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511051804.08306.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:04:08PM +0100, Andi Kleen wrote:
> But I promise you to complain about a patch to add setting it in the context 
> switch too :)

If we include the tsc disable, the performance counter disable will be
completely zerocost for the fast path, so you shouldn't complain about
that, and we can keep the focus only on the tsc part :)

This invalidates your argument that the tsc patch can be disabled
because the same info can be collected using performance counters: if
you are ok with the tsc patch, the performance counter problem will be
solved too at zero additional cost for the fast path.

> LSM was actually quite measurable on some systems, the indirect 
> calls really hurt on IA64 on some of the network benchmarks.

I can imagine that since they're executed during syscalls. But we're
talking about context switches here, so in average order of magnitude
less frequent than syscalls.

> > _especially_ this one in the context switch, 
> > context switches aren't as frequent as syscalls! It's only two
> > cachelines at every context switch, and they might be hot
> 
> If they're not hot for some reason (e.g. cache pig in userspace) you're 
> talking about 1000+ cycles.

What I meant is that we could try to be careful enough in ordering the
task struct so that no additional cacheline has to be read from the cpu,
so it doesn't matter what runs in userland.

I'm all for discussing how to possibly eliminate the additional two
cachelines of working set in the cpu.

If you have to touch a close area during the context switch, the
cacheline of the close area has to become hot, no matter what pigs runs
in userland. So our objective would be to store the seccomp bitflags in the same
cacheline that is required to become hot for the context switch to
execute. If we can achieve that objective we'll be doing the check
nearly at zerocost.

> The person talking about theory is you in my opinion with this basically
> theoretical attack.

But there is a great deal of difference in the impact of the two theories.

If my theory happens in practice, a ssh or ssl key can be stolen.

If your theory happens in practice, there will be a masurable but for
sure very tiny slowdown in the fast path.

So if I'm right, things might go bad.

If you're right, nothing will go wrong. If you're right, it basically
means we need a config option around my code, but we shouldn't remove it
since it still provides value to the CPUShare users (I'm sure they'll be
happy to risk your claimed microslowdown, to be sure there is no covert
channel possible with seccomp).

I can't fix what I don't know about. But this thing I know about it, and
I want to do all I can to guarantee it's impossible to trigger it. The
only way to guarantee it is to apply my patch.

For normal execution of tasks, disabling the tsc sounds not needed, as
said in the previous email, CPUShare is the only project out there that
runs untrusted bytecode at 100% cpu load for months, with the
administrator acknowledging it as the "normal safe load". So CPUShare is
the only thing that has to be careful about preventing covert channels.
For anything else, it is more an administration problem than a kernel
problem.

> Better to stamp out any such attempts in the roots.

I see your point, but OTOH I'd like math guarantee of preventing covert
channels. I know for myself, that I'll feel safer in running CPUShare on
my systems, knowing a cover channel is mathematically impossible.

If you don't use CPUShare, to know a cover channel is impossible, you
only have to run `top`! So you definitely don't need to disable the tsc
to feel safe, if you're not running untrusted bytecode under seccomp at
full cpu load.

Hope this clarifies my point of view ;).
