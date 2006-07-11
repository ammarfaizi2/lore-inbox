Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWGKEPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWGKEPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWGKEPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:15:41 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:39318
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S965129AbWGKEPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:15:40 -0400
Date: Tue, 11 Jul 2006 06:16:00 +0200
From: andrea@cpushare.com
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: Lee Revell <rlrevell@joe-job.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711041600.GC7192@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151679780.32444.21.camel@mindpipe> <20060708092313.GD5135@opteron.random> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 10, 2006 at 09:59:09PM -0400, Andrew James Wade wrote:
> It's probably not worth the complication, but I suppose that could be
> reduced to one cacheline by lazily enabling the TSC access.

Yep, OTOH lazily enabling means generating exception faults and
enter/exit kernels that takes order of magnitude more time and stall the
pipeline unlike the two cacheline touches. So that may be ok on x86
(well modulo a few apps that I know do a flood of rdtsc and infact
you've to disable them on numa), but x86-64 may be using it more
frequently through vgettimeofday in some UP configuration, making the
optimization dubious.

I already tried to reduce the number of cacheline touches to zero and
without risking exception faults by relocating the seccomp_t in the
task_t, but I removed that part from the last patch just to make it 100%
strightforward.

> I disagree with this wording. First, for most users the worry isn't so
> much covert channels, as it is side channels. In other words, the
> worry is not so much that data is sent to the SECCOMP process
> secretly, as that the data could be sensitive. Second, the feature

Well, this comes as a news because with covert channel I always meant
your "side channel" and only in timing context. Perhaps it was just me
misunderstanding ;).  But we obviously agree, I meant your side channel
if you're the one right about the wording.

> closes one only one type of side-channel; others may still exist. It's
> quite possible for cpu bugs or undefined behaviour to reveal internal

Well math guarantees and unpredictable hardware issues don't go well
together. If there are cpu bugs the least thing anybody (not just the
seccomp users) can care about is the covert channel.

> cpu state (possibly affected by another process) without otherwise
> being security risks. (In my uninformed opinion). I wouldn't worry

Any bug that affects seccomp security is always a security bug for
everyone else too (in terms of multiuser security of course).

I'll also give you the perfect example of a side channel not related to
timing attacks if that's what you meant (I thought covert channels were
only about timing attacks): see the mmx example that I can quote here
taken out of a webpage of my site (pathname /technical):

	The most severe attack possible I'm aware of is the mmx
	incorrect initialization caused by the MMX capable cpus not being
	backwards compatible with previous Pentium cpus. No computer could have
	been permanently compromised by such an attack and a simple kernel
	upgrade would have fixed the problem.

That was affecting all multiuser systems, and it wasn't really a cpu
bug (though it's hard to call it a "feature" ;), it was just the newer
cpus not being "security" backwards compatible.

f00f was a real cpu bug instead and it lead to a DoS.

The opposite isn't true, a security bug for everyone, is pratically
never a bug for seccomp. Historically backtesting seccomp, the only
exceptions I'm aware of have been the above mmx data leak,
the f00f and some fdiv bug in the kernel (not a cpu bug) also were
dosable. But we never even got close to exploitability as far as I can
remember, and that's after all the most important thing.

Running linux seccomp under the vista virtualization will be even more
secure than running it on top of the bare hardware, because if there are
_kernel_ bugs that makes seccomp expoitable, things will be still secure
and no reinstall will be necessary since the iso will be mounted
readonly and there will be no access to any filesystem or harddisk (it
all runs in ramfs).

> about such side channels myself, but they do likely exist.

Nothing can be guaranteed perfect, and if something I'm more worried
about kernel bugs than about cpu bugs. It's all a matter of probability,
if it's more likely that you're being hit by an asteroid, then that your
CPU has a bug that allows an attacker to execute code outside seccomp, I
think you should be fine ;). Though it's probably more likely that the
CPU has a bug than we are hit by an asteroid (or at least I hope so).

>From another POV if any seccomp related usage really can save energy, I
suppose that's less risky than producing the saved energy with fission
(we could argue about oil).

> Suggested wording as a patch against 2.6.18-rc1-mm1:
> ------
> 
> Change help text for SECCOMP_DISABLE_TSC to warn about
> side channels (the larger concern) instead of covert channels.
> 
> signed-off-by: Andrew Wade <andrew.j.wade@gmail.com>
Acked-by: Andrea Arcangeli <andrea@cpushare.com>
