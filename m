Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUJDDfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUJDDfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 23:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUJDDfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 23:35:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12980 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268357AbUJDDfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 23:35:50 -0400
Date: Sun, 3 Oct 2004 20:33:14 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, raybry@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003203314.04133167.pj@sgi.com>
In-Reply-To: <833710000.1096847229@[10.10.2.4]>
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
	<20041003090209.69b4b561.pj@sgi.com>
	<833710000.1096847229@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Rebalance!  
> Ooooh, CPU 3 over there looks heavily loaded, I'll steal something.
> That one. Try to migrate. Oops, no cpus_allowed bars me.
> ...
> Humpf. I give up.
> ... ad infinitum.
> 
> Desperately boring, and rather ineffective.

Well ... I don't mind unemployed CPUs being borish.  It's not that they
have much useful work to do.  But if they keep beating down the doors of
their neighbors trying to find work, that seems disruptive.  Won't CPU 3
in your example waste time and suffer increased lock contention,
responding to its deadbeat neighbor?


> > Likely your same concerns apply to the task->mems_allowed field that
> > I added, in the same fashion, in my cpuset patch of recent.
> 
> Mmm, I'm less concerned about that one, or at least I can't specifically
> see how it breaks.

Ray Bryant <raybry@sgi.com> is working this now.  There are ways to get
memory allocated that hurt on our big boxes - such as blowing out one
nodes memory with a disproportionate share of the systems page cache
pages, due to problems vaguely like the cpus_allowed ones.

The kernel allocator and numa placement policies don't really integrate
mems_allowed into their algorithms, but rather are just whacked upside
the head anytime they ask if they can allocate on a non-allowed node.
They can end up doing suboptimal placement on big boxes.

A common one is that the first node in a multiple-node cpuset gets a
bigger memory load from allocations initiated on nodes up stream of it,
that weren't allowed to roost closer to home (or something like this ...
not sure I said this one just right).

Ray is leaning on me to get some kind of memory policy in each cpuset.
I'm giving him a hard time back over details of what this policy
structure should look like, buying time while I try to make more sense
of this all.

I've added him to the cc list here - hopefully he will find my
characterization of our discussions amusing ;).


> > Somewhat like dual-channeled disks, having more than one
> > sched_domain apply at the same time to a given CPU leads to confusions
> > best avoided unless desparately needed. 
> 
> Agreed. The cpus_allowed mechanism doesn't seem well suited to heavy use
> anyway (I think John Hawkes had problems with it too).

The various problems Hawkes had were various race conditions using the
new (at the time) set_cpus_allowed() that Ingo (I believe) added as part
of the O(1) scheduler.  SGI was on the bleeding edge of using the
set_cpus_allowed() call in new and exciting ways, and there were various
race and lock conditions and issues with making sure the per-cpu
migration threads stayed home.

Other than reminding us that this stuff is hard, these problems Hawkes
dealt with don't, to my understanding, shed any light on the new issue
uncovered in this thread, that a simple per-task cpus_allowed mask,
heavily used to affect affinity policy, can interact poorly with
sophisticated schedulers trying to balance an entire system.

===

In sum, I am tending further in the direction of thinking we need to
have scheduler and allocation policies handled on a "per-domain" basis,
where these domains take the form of a partition of the system into
equivalence classes corresponding to subtrees of the cpuset hierarchy.

For example, just to throw out a wild and crazy idea, perhaps instead of
one global set of zonelists (one per node, each containing all nodes,
sorted in various numa friendly orders), rather there should be a set of
zonelists per memory-domain, containing just the nodes therein
(subsetted from the global zonelists, preserving order).

We'll have to be careful here.  I suspect that the tolerance of those
running normal sized systems for this kind of crap will be pretty low.

Moreover, the scheduler in particular, and the allocator somewhat as
well, are areas with a long history of intense technical development.
Our impact on these areas has to be simplistic, so that folks doing the
real work here can keep our multi-domain stuff working with almost no
mind to it at all.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
