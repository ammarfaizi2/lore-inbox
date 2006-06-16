Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWFPLR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWFPLR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFPLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:17:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751060AbWFPLR0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:17:26 -0400
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 13:17:19 +0200
User-Agent: KMail/1.9.3
Cc: Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de> <44928FB1.5070107@sgi.com>
In-Reply-To: <44928FB1.5070107@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200606161317.19296.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The current affinity 
> support simply isn't sufficient for that. Placement has to be targetted
> at launch time since thread implementations can change the layout etc.

I'm not sure how that's related to vgetcpu, but ok ...

In general if you want to affect placement below the process / shared memory
segment level you should change the application.

Anything else just results in a big messy and unreliable and fragile user
command line interface - a quick look at the respective Irix manpage should
make that clear.
 
> > Number one applications currently are databases and JVMs. I hope with 
> > Wolfam's malloc work it will be useful for more applications too. 
> 
> If you want this to work for general purpose applications, then how is
> this new syscall going to help? 

It will improve their malloc(). They don't know anything about NUMA,
but getting local memory will help them. They already get local
memory now from the kernel when they use big allocations, but
for smaller allocations it doesn't work because the kernel can't
give out anything smaller than a page. This would be solved
by a NUMA aware malloc, but it needs vgetcpu() for this if it 
should work without fixed CPU affinity. 

Basically it is just for extending the existing already used proven etc.
default local policy to sub pages. Also there might be other uses
of it too (like per CPU data), although I expect most use of that
in user space can be already done using TLS.

JVM and databases will use it too, but since they often use their
own allocators they will need to be modified.

> If you expect application vendors to 
> code for it, that means few users will benefit.

Most applications use malloc()
 
> >> I really don't think this approach is going to solve the problem. As
> >> Tony also points out, tasks will eventually migrate.
> > 
> > Currently we don't solve this problem with the standard heuristics.
> > It can be solved with manual tuning (mempolicy, explicit CPU affinity)
> > but if you're doing that you're already out side the primary use 
> > case of vgetcpu().
> 
> This is another area where the kernel could do better by possibly using
> the cpumask to determine where it will allocate memory.

Modify fallback lists based on cpu affinity?

Would get messy in the code because you couldn't easily precompute
them anymore.


But cpusets already does this kind of, even though it has a quite
bad impact on fast paths.
 Also what happens if the affinity mask is modified later?
>From the high semantics point it is also a little dubious to mesh
them together. My feeling is that as a heuristic it is probably
dubious.

Also when you set cpu affinity you can as well set memory
policy iit.


> 
> > vgetcpu() is only trying to be a incremental improvement of the current
> > simple default local policy.
> 
> As Tony rightfully pointed out, tasks do migrate. By making this guess
> initially

The gamble is already there in the local policy. No change at all.
When you already got local memory you can use it better with
vgetcpu() though.

>From our experience it works out in most cases though - in general
most benchmarks show better performance with simple local NUMA
policy than SMP mode or no policy.

In the cases where it doesn't you have to either eat the slow
down or use manual tuning.

> I just use scientific users since thats where I have the most recent
> detailed data from. Databases could well benefit from what I mentioned,
> though the serious ones would want to look into using affinity support
> explicitly in their code.

No exactly not - i got requests from "serious" databases to offer
vgetcpu() because affinity is too complicated to configure and manage.

It sounds like you want to solve NUMA world hunger here, not
concentrate on the specific small incremental improvement vgetcpu is trying 
to offer.

I'm sure there is much research that could be done in the general NUMA
tuning area, but I would suggest making it research with numbers first
before trying to hack like this anything into the kernel without
a clear understanding first.

-Andi

