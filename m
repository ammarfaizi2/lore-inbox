Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbUKALkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUKALkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUKALkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:40:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41130 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261754AbUKALkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:40:24 -0500
Date: Mon, 1 Nov 2004 12:41:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Message-ID: <20041101114124.GA31458@elte.hu>
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031233313.GB6909@elf.ucw.cz>
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


* Pavel Machek <pavel@ucw.cz> wrote:

> You are changing 
> 
> some_functions()
> 
> into
> 
> something->function()
> 
> no? I do not think that is 0 overhead...

my main worry with this approach is not really overhead but the impact
on scheduler development. Right now there is a Linux scheduler that
every developer (small-workload and large-workload people) tries to make
as good as possible. Historically and fundamentally, scheduler
development and feedback has always been a 'scarce resource' - the
feedback cycle is (necessarily) long and there are alot of specialized
cases to take care of, which slowly dribble in with time.

firstly, if someone wants a different or specialized scheduler there's
no problem even under the current model, and it has happened before. We
made the scheduler itself easily 'rip-out-able' in 2.6 by decreasing the
junction points between the scheduler and the rest of the system. Also,
the current scheduler is no way cast into stone, we could easily end up
having a different interactivity code within the scheduler, as a result
of the various 'get rid of the two arrays' efforts currently underway.
But i very much do not support making the 'junction points' at the wrong
place.

But more importantly, in the current model, people who care about
'fringe' workloads (embedded and high-end) are 'forced' to improve the
core scheduler if they want to see their problems solved by mainline.
They are forced to think about issues, to generalize problems and to
solve them so that the large picture is still right. This worked pretty
well in the past and works well today. It is painful in terms of getting
stuff integrated but it works.

Scheduler domains was and is a prime example of this concept in the
works: load-balancing was a difficult issue that kept (some of) us
uneasy for years and then a nice generic framework came along that
replaced the old code, made both small boxes and large boxes possible.
As a bonus it also solved the 'HT scheduling' issue almost for free.
Sched-domains is nice for both the low-end and the high-end - it enables
512 CPU single-system-image systems supported by (almost-) vanilla 2.6
kernel. What more can we ask for?

I am 100% sure that we'd not have sched-domains today had we gone for a
'plugin' model say 2-3 years ago. It's always hard to predict 'what if'
scenarios but here's my guess: we'd have a NUMA scheduler, a separate
SMP scheduler, a number of UP schedulers and embedded schedulers, and
say HT would be supported in different ways by the SMP and NUMA
schedulers.

or to give another example: we emphatically do not allow 'dynamic
syscalls' in Linux, albeit for years we've been hammered with how
enterprise-ready Linux would be from them. In reality, without 'dynamic
syscalls' all the 'fringe functionality' people have to think harder and
have to integrate their stuff into the current
syscalls/drivers/subsystems.

the process scheduler is i think a similar piece of technology: we want
to make it _harder_ for specialized workloads to be handled in some
'specialized' way, because those precise workloads do show up in other
workloads too, in a different manner. A fix made for NUMA or real-time
purposes can easily make a difference for desktop workloads. Often
'specialized' is an excluse for a 'fundamentally broken, limited hack',
especially in the scheduler world.

I believe that by compartmenting in the wrong way [*] we kill the
natural integration effects. We'd end up with 5 (or 20) bad generic
schedulers that happen to work in one precise workload only, but there
would not be enough push to build one good generic scheduler, because
the people who are now forced to care about the Linux scheduler would be
content about their specialized schedulers. Yes, it would be easier to
make a specialized scheduler work well in that precise workload (because
the developer can make the 'this is only for this parcticular workload'
excuse), and this approach may satisfy the embedded and high-end needs
in a quicker way. So i consider scheduler plugins as the STREAMS
equivalent of scheduling and i am not very positive about it. Just like
STREAMS, i consider 'scheduler plugins' as the easy but deceptive and
wrong way out of current problems, which will create much worse problems
than the ones it tries to solve.

	Ingo

( [*] how is this different from say the IO scheduler plugin
architecture?  Just compare the two, it's two very different things.
Firstly, the timescale is very different - the process scheduler cares
about microseconds, the IO scheduler's domain is milliseconds. Also, IO
scheduling is fundamentally per-device and often there is good
per-device workload isolation so picking an IO scheduler per queue makes
much more sense than say picking a scheduler per CPU ... There are other
differences too, such as complexity and isolation from the rest of the
system. )
