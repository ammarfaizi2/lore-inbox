Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUCaWXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCaWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:23:33 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:18607 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262078AbUCaWX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:23:27 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Thu, 1 Apr 2004 00:23:05 +0200
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403301204.14303.efocht@hpce.nec.com> <406A2819.6020009@yahoo.com.au>
In-Reply-To: <406A2819.6020009@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404010023.05642.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 04:08, Nick Piggin wrote:
> >>I'm with Martin here, we are just about to merge all this
> >>sched-domains stuff. So we should at least wait until after
> >>that. And of course, *nothing* gets changed without at least
> >>one benchmark that shows it improves something. So far
> >>nobody has come up to the plate with that.
> >
> > I thought you're talking the whole time about STREAM. That is THE
> > benchmark which shows you an impact of balancing at fork. At it is a
> > VERY relevant benchmark. Though you shouldn't run it on historical
> > machines like NUMAQ, no compute center in the western world will buy
> > NUMAQs for high performance... Andy typically runs STREAM on all CPUs
> > of a machine. Try on N/2 and N/4 and so on, you'll see the impact.
>
> Well yeah, but the immediate problem was that sched-domains was
> *much* worse than 2.6's numasched, neither of which balance on
> fork/clone. I didn't want to obscure the issue by implementing
> balance on fork/clone until we worked out exactly the problem.

I had the feeling that solving the performance issue reported by Andi
would ease the integration into the baseline...

> >>The point is that we have never had this before, and nobody
> >>(until now) has been asking for it. And there are as yet no
> >
> > ?? Sorry, I'm having balance at fork since 2001 in the NEC IA64 NUMA
> > kernels and users use it intensively with OpenMP. Advertised it a lot,
> > asked for it, atlked about it at the last OLS. Only IA64 was
> > considered rare big iron. I understand that the issue gets hotter if
> > the problem hurts on AMD64...
>
> Sorry I hadn't realised. I guess because you are happy with
> your own stuff you don't make too much noise about it on the
> list lately. I apologise.

The usual excuse: busy with other stuff...

> I wonder though, why don't you just teach OpenMP to use
> affinities as well? Surely that is better than relying on the
> behaviour of the scheduler, even if it does balance on clone.

You mean in the compiler? I don't think this is a good idea, that way you
loose flexibility in resource overcomitment. And performance when overselling
the machine's CPUs.

> > Again: I'm talking about having the choice. The user decides. Nothing
> > protects you against user stupidity, but if they just have the choice
> > of poor automatic initial scheduling, it's not enough. And: having the
> > fork/clone initial balancing policy means: you don't need to make your
> > code complicated and unportable by playing with setaffinity (which is
> > just plainly unusable when you share the machine with other users).
>
> If you do it by hand, you know exactly what is going to happen,
> and you can turn off the balance-on-clone flags and you don't
> incur the hit of pulling in remote cachelines from every CPU at
> clone time to do balancing. Surely an HPC application wouldn't
> mind doing that? (I guess they probably don't call clone a lot
> though).

OpenMP is implemented with clone. MPI parallel applications just exec,
they're fine. IMO the static affinity/cpumask handling should be done
externally by some resource manager which has a good overview on the
long-term load of the machine. It's a different issue, nothing for the
scheduler. I wouldn't leave it to the program, too unflexible and
unportable across machines and OSes.

> > There are companies mainly selling NUMA machines for HPC (SGI?), so
> > this is not a niche market. Clusters of big NUMA machines are not
> > unusual, and they're typically not used for databases but for HPC
> > apps. Unfortunately proprietary UNIX is still considered to have
> > better features than Linux for such configurations.
>
> Well, SGI should be doing tests soon and tuning the scheduler
> to their liking. Hopefully others will too, so we'll see what
> happens.

Maybe they are happy with their stuff, too. They have the cpumemsets
and some external affinity control, AFAIK.

> >>Let's just make sure we don't change defaults without any
> >>reason...
> >
> > No reason? Aaarghh...   >;-)
>
> Sorry I mean evidence. I'm sure with a properly tuned
> implementation, you could get really good speedups in lots
> of places... I just want to *see* them. All I have seen so
> far is Andi getting a bit better performance on something
> where he can get *much* better performance by making a
> trivial tweak instead.

I get the feeling that Andi's simple OpenMP job is already complex
enough to lead to wrong initial scheduling with the current aproach.
I suppose the reason are the 1-2 helper threads which are started
together with the worker threads (depending on the used compiler).
On small machines (and 4 cpus is small) they significantly disturb
the initial task distribution. For example with the Intel compiler
and 4 worker threads you get 6 tasks. The helper tasks are typically
runnable when the code starts so you get (in order of creation)
   CPU   Task   Role
    1     1     worker
    2     2     helper
    3     3     helper
    4     4     worker
    1-4   5     worker
    1-4   6     worker

So the difficulty is to find out which task will do real work and
which task is just spoiling the statistics. I think...

Regards,
Erich

