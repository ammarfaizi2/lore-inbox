Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUJDU2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUJDU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJDU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:28:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59794 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268323AbUJDU2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:28:18 -0400
Date: Mon, 4 Oct 2004 13:25:51 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041004132551.551c9fd3.pj@sgi.com>
In-Reply-To: <118120000.1096913871@flay>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<20041004085327.727191bf.pj@sgi.com>
	<118120000.1096913871@flay>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Mmm. Looks like you're trying to do multiple CKRMs, one inside each cpuset,
> right? Not sure that's the way I'd go, but maybe it makes sense.

No - I was just reflecting my lack of adequate understanding of CKRM.

You guys were trying to get certain semantics out of cpusets to meet
your needs, putting words in my mouth as to what things like "exclusive"
meant, and I was pushing back, trying to get a fair, implementation
neutral statement of just what it was that CKRM needed out of cpusets,
by in part phrasing things in terms of what I thought you were trying to
have CKRM do with cpusets.  Turns out I speak CKRM substantially worse
than you guys speak cpusets. <grin>

So nevermind what I was trying to do, which was, as you guessed:
> 
> Looks like you're trying to do multiple CKRMs, one inside each cpuset,

Let me try again to see if I can figure out what you're trying to do.

You write:
>
> The way I'm looking at it, which is probably wholly insufficient, if not
> downright wrong, we have multiple process groups, each of which gets some 
> set of resources. Those resources may be dedicated to that class (a la 
> cpusets) or not. One could view this as a set of resource groupings, and
> set of process groupings, where one or more process groupings is bound to
> a resource grouping.
> 
> The resources are cpus & memory, mainly, in my mind (though I guess IO,
> etc fit too). The resource sets are more like cpusets, and the process
> groups a bit more like CKRM, except they seem to overlap (to me) when
> the sets in cpusets are non-exclusive, or when CKRM wants harder performance
> guarantees.

I can understand it far enough to see groups of processes using groups
of resources (cpus & memory, like cpusets).  Both of the phrases
containing "CKRM" in them go right past ... whizz.  And I'm a little
fuzzy on what are the sets, invariants, relations, domains, ranges,
operations, pre and post conditions and such that could be modeled in a
more precise manner.

Keep talking ...  Perhaps an example, along the lines of my "use case
scenarios", would help.  When we start losing each other trying to
generalize too fast, it can help to make up an overly concrete example,
to get things grounded again.


> Whatever we call it, the resource management system definitely needs the 
> ability to isolate a set of resources (CPUs, RAM) totally dedicated to
> one class or group of processes.

Not always "totally isolated and dedicated".

Here's a scenario that shows up some uses for "non-exclusive" cpusts.

Let's take my big 256 CPU system, divided into portions of 128, 64 and
64. At this level, these are three, mutually exclusive cpusets, and
interaction between them is minimized.  In the first two portions, the
128 and the first 64, a couple of "company jewel" applications run.
These are highly tuned, highly parallel applications that are sucking up
99% of every CPU cycle, bus cycle, cache line and memory page available,
for hours on end, in a closely synchronized dance.  They cannot tolerate
anything else interfering in their area.  Frankly, they have little use
for CKRM, fancy schedulers or sophisticated allocators.  They know
what's there, it's all their's, and they know exactly what they want to
do with it.  Get out of the way and let them do their job.  Industrial
strength computing at its finest.

Ok that much is as before.

Now the last portion, the second 64, is more of a general use area. It
is less fully utilized, and it's job mix more varied and less tightly
administered.  There's some 64-thread background application that puts a
fairly light load on things, running day and night (maybe the V.P. of
the MIS shop is a fan of SETI).

Since this is a parallel programming shop, people show up with at random
hours with smaller parallel jobs, carve off temporary cpusets of the
appropriate size, and run an application in them.  Their threads and
memory within their temporary cpuset are carefully placed, relative to
their cpuset, but they are not fully utilizing the nodes on which they
are running and they tolerate other things happening on the same nodes. 
Perhaps the other stuff doesn't impact their performance much, or
perhaps they are too poor to pay for dedicated nodes (grad students
still looking for a grant?) ... whatever.

They may well make good use of a batch manager, to which they submit
jobs of a specified size (cpus and memory) so that the batch manager can
smooth out the load. and avoid periods of excess idling or thrashing. 
The implementation of the batch manager relies heavily on the underlying
cpuset facility to manage various subsets of CPU and Memory Nodes.  The
batch manager might own the first 192 CPUs on the system too, but most
users never get to see that part of the system.

Within that last 64 portion the current mechanisms, including the per
task cpus_allowed and mems_allowed, and the current schedulers and
allocators, may well be doing a pretty good job.  Sure, there is an
element of chaos and things aren't perfect.  It's the "usual" timeshare
environment with a varied load mix.

The enforced placement within the smaller nested non-exclusive cpusets
probably surprises the scheduler and allocator at times, leading to
unfair inbalances.  I imagine that if CKRM just had that last 64 portion
to manage, and this was just a 64 CPU system, not a 256, then CKRM could
do a pretty good job of managing the systems resources.

Enough of this story ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
