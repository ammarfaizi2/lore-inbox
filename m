Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTLMGns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 01:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTLMGnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 01:43:47 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:53378 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264484AbTLMGno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 01:43:44 -0500
Message-ID: <3FDAB517.4000309@cyberone.com.au>
Date: Sat, 13 Dec 2003 17:43:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031213022038.300B22C2C1@lists.samba.org>
In-Reply-To: <20031213022038.300B22C2C1@lists.samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>In message <3FD9679A.1020404@cyberone.com.au> you write:
>
>>Thanks for having a look Rusty. I'll try to convince you :)
>>
>>As you know, the domain classes is not just for HT, but can do multi levels
>>of NUMA, and it can be built by architecture specific code which is good
>>for Opteron, for example. It doesn't need CONFIG_SCHED_SMT either, of 
>>course,
>>or CONFIG_NUMA even: degenerate domains can just be collapsed (code isn't
>>there to do that now).
>>
>
>Yes, but this isn't what we really want.  I'm actually accusing you of
>lacking ambition 8)
>
>
>>Shared runqueues I find isn't so flexible. I think it perfectly describes
>>the P4 HT architecture, but what happens if (when) siblings get seperate
>>L1 caches? What about SMT, CMP, SMP and NUMA levels in the POWER5?
>>
>
>It describes every HyperThread implementation I am aware of today, so
>it suits us fine for the moment.  Runqueues may still be worth sharing
>even if L1 isn't, for example.
>

Possibly. But it restricts your load balancing to a specific case, it
eliminates any possibility of CPU affinity: 4 running threads on 1 HT
CPU for example, they'll ping pong from one cpu to the other happily.

I could get domains to do the same thing, but at the moment a CPU only looks
at its sibling's runqueue if they are unbalanced or is about to become idle.
I'm pretty sure domains can do anything shared runqueues can. I don't know
if you're disputing this or not?

>
>>The large SGI (and I imagine IBM's POWER5s) systems need things like
>>progressive balancing backoff and would probably benefit with a more
>>heirachical balancing scheme so all the balancing operations don't kill
>>the system.
>>
>
>But this is my point.  Scheduling is one part of the problem.  I want
>to be able to have the arch-specific code feed in a description of
>memory and cpu distances, bandwidths and whatever, and have the
>scheduler, slab allocator, per-cpu data allocation, page cache, page
>migrator and anything else which cares adjust itself based on that.
>
>Power 4 today has pairs of CPUs on a die, four dies on a board, and
>four boards in a machine.  I want one infrastructure to descibe it,
>not have to do program every infrastructure from arch-specific code.
>

(Plus two threads / siblings per CPU, right?)

I agree with you here. You know, we could rename struct sched_domain, add
a few fields to it and it becomes what you want. Its a _heirachical set_
of _sets of cpus sharing a certian property_ (underlining to aid grouping.

Uniform access to certian memory ranges could easily be one of these
properties. There is already some info about the amount of cache shared,
that also could be expanded on.

(Perhaps some exotic architecture  would like scheduling and memory a bit
more decoupled, but designing for *that* before hitting it would be over
engineering).

I'm not going to that because 2.6 doesn't need a generalised topology
because nothing makes use of it. Perhaps if something really good came up
in 2.7, there would be a case for backporting it. 2.6 does need improvements
to the scheduler though.

>
>>w26 does ALL this, while sched.o is 3K smaller than Ingo's shared runqueue
>>patch on NUMA and SMP, and 1K smaller on UP (although sched.c is 90 lines
>>longer). kernbench system time is down nearly 10% on the NUMAQ, so it isn't
>>hurting performance either.
>>
>
>Agreed, but Ingo's shared runqueue patch is poor implementation of a
>good idea: I've always disliked it.  I'm halfway through updating my
>patch, and I really think you'll like it better.  It's not
>incompatible with NUMA changes, in fact it's fairly non-invasive.
>

But if sched domains are accepted, there is no need for shared runqueues,
because as I said they can do anything sched domains can, so the code would
just be a redundant specialisation - unless you specifically wanted to share
locks & data with siblings.

I must admit I didn't look at your implementation. I look forward to it.
I'm not against shared runqueues. If my stuff doesn't get taken then of
course I'd rather shrq gets in than nothing at all, as I told Ingo. I
obviously just like sched domains better ;)


