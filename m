Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317659AbSFRWF2>; Tue, 18 Jun 2002 18:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSFRWF1>; Tue, 18 Jun 2002 18:05:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46042 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317659AbSFRWFU>;
	Tue, 18 Jun 2002 18:05:20 -0400
Date: Wed, 19 Jun 2002 00:03:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Robert Love <rml@tech9.net>,
       <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KPMG-0003oZ-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206182353270.22985-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Rusty Russell wrote:

> This is the NUMA "I want to be in this group" problem.  If you're
> serious about this, you'll go for a sys_sched_groupaffinity call, or add
> an extra arg to sys_sched_setaffinity, or simply use the top 16 bits of
> the cpu arg.

the reason why i picked a linear cpu bitmask for the first patches to do
affinity syscalls (which ultimately found their way into 2.5) was very
simple: we do *NOT* want to deal with cache hierarchies in the kernel, at
this point.

enumerating CPUs and giving processes the ability to bind themselves to an
arbitrary set of CPUs is enough. *IF* user-space wants to do more then
they can get and use whatever NUMA information they want. There could even
be separate sets of syscalls perhaps to get the exact CPU cache hierarchy
of the system, although that would have to be done really well to be truly
generic and long-living.

so in this case the simplest approach that scales well to a reasonable
number of CPUs (thousands, at least) won.

> You will also add /proc/cpugroups or something to export this
> information to users so there's a point.

and this might not even be enough. Cache hierarchies can be pretty
non-trivial, and it's not necesserily a distinct group of CPUs, it could
be a hierarchy of multiple levels, or it could even be an assymetric
distribution of caches. In fact it might not be even expressable in
'group' categories - caches could be interconnected in a 2D or even 3D
topology. Or multiprocessing CPUs could have dynamic caches in the future
- 'cache on demand' allocated to a cache-happy CPU, while another CPU with
a smaller working set will use less cache space. [obviously the technology
is not available today.]

one thing i was *very* sure about, we frankly dont have the slightest clue
about how the really big systems will look like in 10 or 20 years. So
hardcoding anything like 'group affinity' or some of today's NUMA
hierarchies would be pretty shortsighted. I'm convinced that the 'opaque'
solution, the simple but generic setaffinity system call is the right
choice.

	Ingo

