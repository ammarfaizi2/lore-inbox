Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUCaCJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUCaCI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:08:59 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:2394 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261672AbUCaCIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:08:51 -0500
Message-ID: <406A2819.6020009@yahoo.com.au>
Date: Wed, 31 Mar 2004 12:08:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au> <200403301204.14303.efocht@hpce.nec.com>
In-Reply-To: <200403301204.14303.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> Hi Nick,
> 

Hi Erich,

> On Tuesday 30 March 2004 11:05, Nick Piggin wrote:
> 
>>I'm with Martin here, we are just about to merge all this
>>sched-domains stuff. So we should at least wait until after
>>that. And of course, *nothing* gets changed without at least
>>one benchmark that shows it improves something. So far
>>nobody has come up to the plate with that.
> 
> 
> I thought you're talking the whole time about STREAM. That is THE
> benchmark which shows you an impact of balancing at fork. At it is a
> VERY relevant benchmark. Though you shouldn't run it on historical
> machines like NUMAQ, no compute center in the western world will buy
> NUMAQs for high performance... Andy typically runs STREAM on all CPUs
> of a machine. Try on N/2 and N/4 and so on, you'll see the impact.
> 

Well yeah, but the immediate problem was that sched-domains was
*much* worse than 2.6's numasched, neither of which balance on
fork/clone. I didn't want to obscure the issue by implementing
balance on fork/clone until we worked out exactly the problem.

Anyway, once sched-domains goes in, you can basically do whatever
you like without impacting anyone else...

>>
>>There are other things, like java, ervers, etc that use threads.
> 
> 
> I'm just saying that you should have the choice. The default should be
> as before, balance at exec().
> 

Yeah well that is a very sane thing to do ;)

> 
>>The point is that we have never had this before, and nobody
>>(until now) has been asking for it. And there are as yet no
> 
> 
> ?? Sorry, I'm having balance at fork since 2001 in the NEC IA64 NUMA
> kernels and users use it intensively with OpenMP. Advertised it a lot,
> asked for it, atlked about it at the last OLS. Only IA64 was
> considered rare big iron. I understand that the issue gets hotter if
> the problem hurts on AMD64...
> 

Sorry I hadn't realised. I guess because you are happy with
your own stuff you don't make too much noise about it on the
list lately. I apologise.

I wonder though, why don't you just teach OpenMP to use
affinities as well? Surely that is better than relying on the
behaviour of the scheduler, even if it does balance on clone.

> 
>>convincing benchmarks that even show best case improvements. And
>>it could very easily have some bad cases.
> 
> 
> Again: I'm talking about having the choice. The user decides. Nothing
> protects you against user stupidity, but if they just have the choice
> of poor automatic initial scheduling, it's not enough. And: having the
> fork/clone initial balancing policy means: you don't need to make your
> code complicated and unportable by playing with setaffinity (which is
> just plainly unusable when you share the machine with other users).
> 

If you do it by hand, you know exactly what is going to happen,
and you can turn off the balance-on-clone flags and you don't
incur the hit of pulling in remote cachelines from every CPU at
clone time to do balancing. Surely an HPC application wouldn't
mind doing that? (I guess they probably don't call clone a lot
though).

> 
>>And finally, HPC
>>applications are the very ones that should be using CPU
>>affinities because they are usually tuned quite tightly to the
>>specific architecture.
> 
> 
> There are companies mainly selling NUMA machines for HPC (SGI?), so
> this is not a niche market. Clusters of big NUMA machines are not
> unusual, and they're typically not used for databases but for HPC
> apps. Unfortunately proprietary UNIX is still considered to have
> better features than Linux for such configurations.
> 

Well, SGI should be doing tests soon and tuning the scheduler
to their liking. Hopefully others will too, so we'll see what
happens.

> 
>>Let's just make sure we don't change defaults without any
>>reason...
> 
> 
> No reason? Aaarghh...   >;-)
> 

Sorry I mean evidence. I'm sure with a properly tuned
implementation, you could get really good speedups in lots
of places... I just want to *see* them. All I have seen so
far is Andi getting a bit better performance on something
where he can get *much* better performance by making a
trivial tweak instead.

I really don't have the software or hardware to test this
at all so I just have to sit and watch.
