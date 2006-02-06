Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWBFGED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWBFGED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWBFGEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:04:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37842 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751016AbWBFGEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:04:00 -0500
Date: Mon, 6 Feb 2006 07:02:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206060243.GA11918@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060205203711.2c855971.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205203711.2c855971.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Paul Jackson <pj@sgi.com> wrote:
> >
> > This policy can provide substantial improvements for jobs that
> >  need to place thread local data on the corresponding node, but
> >  that need to access large file system data sets that need to
> >  be spread across the several nodes in the jobs cpuset in order
> >  to fit.  Without this patch, especially for jobs that might
> >  have one thread reading in the data set, the memory allocation
> >  across the nodes in the jobs cpuset can become very uneven.
> 
> 
> It all seems rather ironic.  We do vast amounts of development to make 
> certain microbenchmarks look good, then run a real workload on the 
> thing, find that all those microbenchmark-inspired tweaks actually 
> deoptimised the real workload?  So now we need to add per-task knobs 
> to turn off the previously-added microbenchmark-tweaks.
> 
> What happens if one process does lots of filesystem activity and 
> another one (concurrent or subsequent) wants lots of thread-local 
> storage?  Won't the same thing happen?
> 
> IOW: this patch seems to be a highly specific bandaid which is 
> repairing an ill-advised problem of our own making, does it not?

i suspect it all depends whether the workload is 'global' or 'local'.  
Lets consider the hypothetical case of a 16-node box with 64 CPUs and 1 
TB of RAM, which could have two fundamental types of workloads:

- lots of per-CPU tasks which are highly independent and each does its
  own stuff. For this case we really want to allocate everything per-CPU
  and as close to the task as possible.

- 90% of the 1 TB of RAM is in a shared 'database' that is accessed by 
  all nodes in a nonpredictable pattern, from any CPU. For this case we 
  want to 'spread out' the pagecache as much as possible. If we dont 
  spread it out then one task - e.g. an initialization process - could 
  create a really bad distribution for the pagecache: big continuous 
  ranges allocated on the same node. If the workload has randomness but 
  also occasional "medium range" locality, an uneven portion of the 
  accesses could go to the same node, hosting some big continuous chunk 
  of the database. So we want to spread out in an as finegrained way as 
  possible. (perhaps not too finegrained though, to let block IO still 
  be reasonably batched.)

we normally optimize for the first case, and it works pretty well on 
both SMP and NUMA. We do pretty well with the second workload on SMP, 
but on NUMA, the non-spreadig can hurt. So it makes sense to 
artificially 'interleave' all the RAM that goes into the pagecache, to 
have a good statistical distribution of pages.

neither workload is broken, nor did we do any design mistake to optimize 
the SMP case for the first one - it is really the common thing on most 
boxes. But the second workload does happen too, and it conflicts with 
the first workload's needs. The difference between the workloads cannot 
be bridged by the kernel: it is two very different access patterns that 
results from the problem the application is trying to solve - the kernel 
cannot influence that.

I suspect there is no other way but to let the application tell the 
kernel which strategy it wants to be utilized.

	Ingo
