Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKCAdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKCAdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUKBWXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:23:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10652 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262027AbUKBWRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:17:36 -0500
Date: Tue, 2 Nov 2004 16:17:21 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <40740000.1099414515@[10.10.2.4]>
Message-ID: <Pine.SGI.4.58.0411021613300.79056@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
 <14340000.1099410418@[10.10.2.4]> <20041102155507.GA323@wotan.suse.de>
 <40740000.1099414515@[10.10.2.4]>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Martin J. Bligh wrote:

> --Andi Kleen <ak@suse.de> wrote (on Tuesday, November 02, 2004 16:55:07 +0100):
>
> > On Tue, Nov 02, 2004 at 07:46:59AM -0800, Martin J. Bligh wrote:
> >> > This patch causes memory allocation for tmpfs files to be distributed
> >> > evenly across NUMA machines.  In most circumstances today, tmpfs files
> >> > will be allocated on the same node as the task writing to the file.
> >> > In many cases, particularly when large files are created, or a large
> >> > number of files are created by a single task, this leads to a severe
> >> > imbalance in free memory amongst nodes.  This patch corrects that
> >> > situation.
> >>
> >> Yeah, but it also ruins your locality of reference (in a NUMA sense).
> >> Not convinced that's a good idea. You're guaranteeing universally consistent
> >> worse-case performance for everyone. And you're only looking at a situation
> >> where there's one allocator on the system, and that's imbalanced.
> >>
> >> You WANT your data to be local. That's the whole idea.
> >
> > I think it depends on how you use tmpfs. When you use it for read/write
> > it's a good idea because you likely don't care about a bit of additional
> > latency and it's better to not fill up your local nodes with temporary
> > files.
> >
> > If you use it with mmap then you likely want local policy.

Yeah, what Andi said. :)

I fully agree with Martin's statement "You WANT your data to be local."
However, it can become non-local in two different manners, each of
which wants tmpfs to behave differently.  (The next two paragraphs are
simply to summarize, no position is being taken.)

The manner I'm concerned about is when a long-lived file (long-lived
meaning at least for the duration of the run of a large multithreaded app)
is placed in memory as an accidental artifact of the CPU which happened
to create the file.  Imagine, for instance, an application startup
script copying a large file into a tmpfs filesystem before spawning
the actual computation application itself.  There is a large class of
HPC applications which are tightly synchronized, and which require nearly
all of the system memory (i.e. almost all the memory on each node).
In this case the "victim" node will be forced to go off-node for the
bulk of its memory accesses, destroying locality, and slowing down
the entire application.  This problem is alleviated if the tmpfs file
is fairly well distributed across the nodes.

But I do understand the opposite situation.  If a lightly-threaded
application wants to access the file data, or the application does
not require large amounts of additional memory (i.e. nearly all the
memory on each node) getting the file itself allocated close to the
processor is more beneficial.  In this case the distribution of tmpfs
pages is non-ideal (though I'm not sure it's worst-case).

> > But that's a big ugly to distingush, that is why I suggested the sysctl.
>
> As long as it defaults to off, I guess I don't really care. Though I'm still
> wholly unconvinced it makes much sense. I think we're just papering over the
> underlying problem - that we don't do good balancing between nodes under
> mem pressure.

It's a tough situation, as shown above.  The HPC workload I mentioned
would much prefer the tmpfs file to be distributed.  A non-HPC workload
would prefer the tmpfs files be local.  Short of a sysctl I'm not sure
how the system could make an intelligent decision about what to do under
memory pressure -- it simply isn't knowledge the kernel can have.

I've got a new patch including Andi's suggested sysctl ready to go.
But I've seen one vote for defaulting to on, and one for defaulting
to off.  I'd vote for on, but then again I'm biased. :)  Who arbitrates
this one, Hugh Dickins (it's a tmpfs change, after all)?  From SGI's
perspective we can live with it either way; we'll simply need to
document our recommendations for our customers.

As soon as I know whether this should default on or off, I'll post
the new patch, including the sysctl.

Thanks,
Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
