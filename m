Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUJDWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUJDWuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJDWuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:50:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57575 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268662AbUJDWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:49:47 -0400
Date: Mon, 4 Oct 2004 15:46:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: mbligh@aracnet.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041004154657.4a02d0f4.pj@sgi.com>
In-Reply-To: <200410041146.i94Bi54h012775@owlet.beaverton.ibm.com>
References: <20041003174539.1652ea2b.pj@sgi.com>
	<200410041146.i94Bi54h012775@owlet.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good questions - thanks.

Rick wrote:
> So the examples you gave before were rather oversimplified, then?

Yes - they were.  Quite intentionally.

> some portion of that must be reserved for the "bootcpuset".  Would this
> be enforced by the kernel, or the administrator?

It's administrative.  You don't have to run your system this way.  The
kernel threads (both per-cpu and system-wide), as well as init and the
classic Unix daemons, can be left running in the root cpuset (see below
for what that is).  The kernel doesn't care.

It was the additional request for a CKRM friendly setup that led me to
point out that system-wide kernel threads could be confined to a
"bootcpuset".  Since bootcpuset is user level stuff, I hadn't mentioned
it before, on the kernel mailing list.

The more common reason for confining such kthreads and Unix daemons to a
bootcpuset are to minimize interactions between such tasks and important
applications.

> I might suggest a simpler approach.  As a matter of policy, at least one
> cpu must remain outside of cpusets so that system processes like init,
> getty, lpd, etc. have a place to run.

This is the same thing, in different words.  In my current cpuset
implemenation, _every_ task is attached to a cpuset.

What you call a cpu that "remains outside of cpusets" is the bootcpuset,
in my terms.

>     The tasks whose cpus_allowed is a strict _subset_ of cpus_online_map
>     need to be where they are.  These are things like the migration
>     helper threads, one for each cpu.  They get a license to violate
>     cpuset boundaries.
> 
> Literally, or figuratively?  (How do we recognize these tasks?)

I stated one critical word too vaguely.  Let me restate (s/tasks/kernel
threads/), then translate.


>     The kernel threads whose cpus_allowed is a strict _subset_ of cpus_online_map
>     need to be where they are.  These are things like the migration
>     helper threads, one for each cpu.  They get a license to violate
>     cpuset boundaries.

> Literally, or figuratively?  (How do we recognize these tasks?)

Literally.  The early (_very_ early) user level code that sets up the
bootcpuset, as requested by a configuration file in /etc, moves the
kthreads with a cpus_allowed >= what's online to the bootcpuset, but
leaves the kthreads with a cpus_allowed < online where they are, in the
root cpuset.

If you do a "ps -efl", look for the tasks early in the list whose
command names in something like "/2" (printf format "/%u").  These
are the kthreads that usually need to be pinned on a CPU.

But you don't need to do that - an early boot user utility does it
as part of setting up the bootcpuset.

> Will cpus in exclusive cpusets be asked to service interrupts?

The current cpuset implementation makes no effort to manage interrupts. 
To manage interrupts in relation to cpusets today, you'd have to use
some other means to control or determine where interrupts were going,
and then place your cpusets with that in mind.

>     So with my bootcpuset, the problem is reduced, to a few tasks
>     per CPU, such as the migration threads, which must remain pinned
>     on their one CPU (or perhaps on just the CPUs local to one Memory
>     Node).  These tasks remain in the root cpuset, which by the scheme
>     we're contemplating, doesn't get a sched_domain in the fancier
>     configurations.
> 
> You just confused me on many different levels:
> 
>     * what is the root cpuset? Is this the same as the "bootcpuset" you
>       made mention of?

Not the same.

The root cpuset is the all encompassing cpuset representing the entire
system, from which all other cpusets are formed.  The root cpuset always
contains all CPUs and all Memory Nodes.

The bootcpuset is typically a small cpuset, a direct child of the root
cpuset, containing what would be in your terms the one or a few cpus
that are reserved for the classic Unix system processes like init,
getty, lpd, etc.

>    * so where *do* these tasks go in the "fancier configurations"?

Er eh - in the root cpuset ;).  Hmmm ... guess that's not your question.

In this fancy configuration, I had the few kthreads that could _not_
be moved to the bootcpuset, because they had to remain pinned on
specific CPUs (e.g. the migration threads), remain in the root cpuset.

When the exclusive child cpusets were formed, and each given their own
special scheduler domain, I rebound the scheduler domain to use for
these per-cpu kthreads to which ever scheduler domain managed the cpu
that thread lived on.  The thread remained in the root cpuset, but
hitched a ride on the scheduler that had assumed control of the cpu that
the thread lived on.  Everything in this paragraphy is something I
invented in the last two days, in response to various requests from
others for setups that provided a clear boundary of control to
schedulers.

>     If we just wrote the code, and quit trying to find a grand unifying
>     theory to explain it consistently with the rest of our design,
>     it would probably work just fine.
> 
> I'll assume we're missing a smiley here.

Not really.  The per-cpu kthreads are a wart that doesn't fit the
particular design being discussed here very well.  Warts happen.

> When you "remove a cpuset" you just or in the right bits in everybody's
> cpus_allowed fields and they start migrating over.
> 
> To me, this all works for the cpu-intensive, gotta have it with 1% runtime
> variation example you gave.  Doesn't it?  And it seems to work for the
> department-needs-8-cpus-to-do-as-they-please example too, doesn't it?

What you're saying is rather like saying I don't need a file system
on my floppy disk.  Well, originally, I didn't.  I wrote the bytes
to my tape casette, I read them back.  What's the problem.  If I
wanted to name the bytes, I stuck a label on the cassette and wrote
a note on the label.

Yes, that works.  As systems get bigger, and as we add batch managers
and such to handle a more complicated set of jobs, we need to be able
to do things like:
   * name sets of CPUs/Memory, in a way consistent across the system
   * create and destroy a set
   * control who can query, modify and attach a set
   * change which set a task is attached to
   * list which tasks are currently attached to a set
   * query, set and change which CPUs and Memory are in a set.

This is like needing a FAT file system for your floppy.  Cpusets
join the collection of "first class, kernel managed" objects,
and are no longer just the implied attributes of each task.

Batch managers and sysadmins of more complex, dynamically changing
configurations, sometimes on very large systems that are shared across
several departments or divisions, depend on this ability to treat
cpusets as first class name, kernel managed objects.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
