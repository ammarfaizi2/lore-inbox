Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUC3KEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 05:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUC3KEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 05:04:42 -0500
Received: from [193.141.139.228] ([193.141.139.228]:32666 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S263595AbUC3KEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 05:04:30 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Tue, 30 Mar 2004 12:04:13 +0200
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au>
In-Reply-To: <4069384B.9070108@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301204.14303.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tuesday 30 March 2004 11:05, Nick Piggin wrote:
> >exec(), and maybe use a syscall for saying: balance all children a
> >particular process is going to fork/clone at creation time. Everybody
> >reached the insight that we can't foresee what's optimal, so there is
> >only one solution: control the behavior. Give the user a tool to
> >improve the performance. Just a small inheritable variable in the task
> >structure is enough. Whether you give the hint at or before run-time
> >or even at compile-time is not really the point...
> >
> >I don't think it's worth to wait and hope that somebody shows up with
> >a magic algorithm which balances every kind of job optimally.
>
> I'm with Martin here, we are just about to merge all this
> sched-domains stuff. So we should at least wait until after
> that. And of course, *nothing* gets changed without at least
> one benchmark that shows it improves something. So far
> nobody has come up to the plate with that.

I thought you're talking the whole time about STREAM. That is THE
benchmark which shows you an impact of balancing at fork. At it is a
VERY relevant benchmark. Though you shouldn't run it on historical
machines like NUMAQ, no compute center in the western world will buy
NUMAQs for high performance... Andy typically runs STREAM on all CPUs
of a machine. Try on N/2 and N/4 and so on, you'll see the impact.

> >>Clone is a much more interesting case, though at the time, I consciously
> >>decided NOT to do that, as we really mostly want threads on the same
> >>node.
> >
> >That is not true in the case of HPC applications. And if someone uses
> >OpenMP he is just doing that kind of stuff. I consider STREAM a good
> >benchmark because it shows exactly the problem of HPC applications:
> >they need a lot of memory bandwidth, they don't run in cache and the
> >tasks live really long. Spreading those tasks across the nodes gives
> >me more bandwidth per task and I accumulate the positive effect
> >because the tasks run for hours or days. It's a simple and clear case
> >where the scheduler should be improved.
> >
> >Benchmarks simulating "user work" like SPECsdet, kernel compile, AIM7
> >are not relevant for HPC. In a compute center it actually doesn't
> >matter much whether some shell command returns 10% faster, it just
> >shouldn't disturb my super simulation code for which I bought an
> >expensive NUMA box.
>
> There are other things, like java, ervers, etc that use threads.

I'm just saying that you should have the choice. The default should be
as before, balance at exec().

> The point is that we have never had this before, and nobody
> (until now) has been asking for it. And there are as yet no

?? Sorry, I'm having balance at fork since 2001 in the NEC IA64 NUMA
kernels and users use it intensively with OpenMP. Advertised it a lot,
asked for it, atlked about it at the last OLS. Only IA64 was
considered rare big iron. I understand that the issue gets hotter if
the problem hurts on AMD64...

> convincing benchmarks that even show best case improvements. And
> it could very easily have some bad cases.

Again: I'm talking about having the choice. The user decides. Nothing
protects you against user stupidity, but if they just have the choice
of poor automatic initial scheduling, it's not enough. And: having the
fork/clone initial balancing policy means: you don't need to make your
code complicated and unportable by playing with setaffinity (which is
just plainly unusable when you share the machine with other users).

> And finally, HPC
> applications are the very ones that should be using CPU
> affinities because they are usually tuned quite tightly to the
> specific architecture.

There are companies mainly selling NUMA machines for HPC (SGI?), so
this is not a niche market. Clusters of big NUMA machines are not
unusual, and they're typically not used for databases but for HPC
apps. Unfortunately proprietary UNIX is still considered to have
better features than Linux for such configurations.

> Let's just make sure we don't change defaults without any
> reason...

No reason? Aaarghh...   >;-)

Erich


