Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTACKOc>; Fri, 3 Jan 2003 05:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTACKOc>; Fri, 3 Jan 2003 05:14:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:3556 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267340AbTACKOa>;
	Fri, 3 Jan 2003 05:14:30 -0500
Message-ID: <3E15647E.EE0C1477@digeo.com>
Date: Fri, 03 Jan 2003 02:22:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Aniruddha M Marathe <aniruddha.marathe@wipro.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <3E155903.F8C22286@digeo.com> <1041589477.9242.5.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 10:22:54.0765 (UTC) FILETIME=[14174DD0:01C2B312]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> On Fri, 2003-01-03 at 01:33, Andrew Morton wrote:
> > I'm sorry, but all you are doing with these tests is discrediting
> > lmbench, AIM9, tiobench and unixbench.
>  ...
> > Possibly, it is all caused by cache colouring effects - the physical
> > addresses at which critical kernel and userspace text and data
> > happen to end up.
>  ...
> > The teeny little microbenchmarks are telling us that the rmap overhead
> > hurts, that the uninlining of copy_*_user may have been a bad idea, that
> > the addition of AIO has cost a little and that the complexity which
> > yielded large improvements in readv(), writev() and SMP throughput were
> > not free.  All of this is already known.
> 
> I think if anything, you are stating the true value of the
> microbenchmarks.  They are showing us how the kernel is getting
> more and more complex, causing basic operations to take longer
> and longer.  That's bad. :-)

Yup.  But these things are already known about.

> Last time I brought up an issue like this (a "nobody but weirdos use
> feature which is costing us cycles everywhere"), it got redone until
> it did cost nothing for people who don't use the feature.  See the
> whole security layer fiasco for example.

There would be some small benefit in disabling the per-cpu-pages
pools on uniprocessor, and probably the deferred lru-addition queues.

That's fairly simple to do but I didn't do it because it would mean
that SMP and UP are running significantly different codepaths.  Benching
this is on my todo list somewhere.
 
> I truly wish I could config out AIO for example, the overhead is just
> stupid.  I know that if some thought is put into it, the cost could
> be consumed completely.

hm.  Its cost in filesystem/VFS land is quite small.  I assume you're
referring to networking here?

> People who don't see the true value of researching even minor jitters
> in lmbench results (and fixing the causes or backing out the guilty
> patch) aren't kernel developers in my opinion. :-)

But the statistically significant differences _are_ researched, and are
well understood.

We should't lose sight of large optimisations which happen to not be
covered by these tests.  eg: SMP scalability.

To cite an extreme case, the readv/writev changes sped up O_SYNC and
O_DIRECT writev() by up to 300x and buffered writev() by 3x.  But it cost
us a few percent on write(fd, buf, 1).

quad:/usr/src> grep -r writev lmbench
quad:/usr/src> grep -r writev aim9
quad:/usr/src> grep -r writev tiobench 
quad:/usr/src> grep -r writev unixbench-4.1.0-971022 
quad:/usr/src> 


The big, big one here is the reverse map.  I still don't believe that
its benefit has been shown to exceed its speed and space costs.
