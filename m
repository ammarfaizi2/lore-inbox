Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWFPL6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWFPL6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFPL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:58:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27299 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751171AbWFPL6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:58:52 -0400
Message-ID: <44929CE6.4@sgi.com>
Date: Fri, 16 Jun 2006 13:58:30 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de> <44928FB1.5070107@sgi.com> <200606161317.19296.ak@suse.de>
In-Reply-To: <200606161317.19296.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> The current affinity 
>> support simply isn't sufficient for that. Placement has to be targetted
>> at launch time since thread implementations can change the layout etc.
> 
> I'm not sure how that's related to vgetcpu, but ok ...
> 
> In general if you want to affect placement below the process / shared memory
> segment level you should change the application.

That would be great, except that a lot of these applications are
'standard' applications which people they don't write themselves.
Sometimes the sourcecode is no longer available. We could argue that
people should just rewrite their applications, but in reality this isn't
whats happening.

> It will improve their malloc(). They don't know anything about NUMA,
> but getting local memory will help them. They already get local
> memory now from the kernel when they use big allocations, but
> for smaller allocations it doesn't work because the kernel can't
> give out anything smaller than a page. This would be solved
> by a NUMA aware malloc, but it needs vgetcpu() for this if it 
> should work without fixed CPU affinity. 

I really don't see the benefit here. malloc already gets pages handed
down from the kernel which are node local due to them being assigned at
a first touch basis. I am not sure about glibc's malloc internals, but
rather rely on a vgetcpu() call, all it really needs to do is to keep
a thread local pool which will automatically get it's thing locally
through first touch usage.

I don't see how a new syscall is going to provide anything to malloc
that it doesn't already have. What am I missing?

> Basically it is just for extending the existing already used proven etc.
> default local policy to sub pages. Also there might be other uses
> of it too (like per CPU data), although I expect most use of that
> in user space can be already done using TLS.

The thread libraries already have their own thread local area which
should be allocated on the thread's own node if done right, which I
assume it is.

> JVM and databases will use it too, but since they often use their
> own allocators they will need to be modified.

I would assume the real databases to be smart enough to benefit from
things being first touch already. JVMs .... well who knows, can't say
I have a lot of faith in anything running in a JVM :)

>> If you expect application vendors to 
>> code for it, that means few users will benefit.
> 
> Most applications use malloc()

Which doesn't need the vgetcpu() call as far as I can see.

>> This is another area where the kernel could do better by possibly using
>> the cpumask to determine where it will allocate memory.
> 
> Modify fallback lists based on cpu affinity?

It's a hint, not guaranteed placement. You have the same problem if you
try to allocate memory on a node and there's nothing left there.

> But cpusets already does this kind of, even though it has a quite
> bad impact on fast paths.
>  Also what happens if the affinity mask is modified later?
> From the high semantics point it is also a little dubious to mesh
> them together. My feeling is that as a heuristic it is probably
> dubious.

If you migrate your app elsewhere, you should migrate the pages with it,
or not expect things to run with the local effect.

> The gamble is already there in the local policy. No change at all.
> When you already got local memory you can use it better with
> vgetcpu() though.
> 
> From our experience it works out in most cases though - in general
> most benchmarks show better performance with simple local NUMA
> policy than SMP mode or no policy.

Could you share some information about the type of benchmarks?

>> I just use scientific users since thats where I have the most recent
>> detailed data from. Databases could well benefit from what I mentioned,
>> though the serious ones would want to look into using affinity support
>> explicitly in their code.
> 
> No exactly not - i got requests from "serious" databases to offer
> vgetcpu() because affinity is too complicated to configure and manage.
> 
> It sounds like you want to solve NUMA world hunger here, not
> concentrate on the specific small incremental improvement vgetcpu is trying 
> to offer.

I don't really see the point in solving something half way when it can
be done better. Maybe the "serious" databases should open up and let us
know what the problem is they are hitting.

> I'm sure there is much research that could be done in the general NUMA
> tuning area, but I would suggest making it research with numbers first
> before trying to hack like this anything into the kernel without
> a clear understanding first.

Well I did spend a good chunk of time looking at some of this some time
ago and did speek a lot to one of my colleagues who actually runs
benchmarks using some of these tools to understand the impact. If
anything it seems that vgetcpu is the issue that is still in the
research stage.

Cheers,
Jes
