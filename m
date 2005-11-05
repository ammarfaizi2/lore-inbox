Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVKEH1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVKEH1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVKEH1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:27:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19670 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751331AbVKEH1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:27:34 -0500
Date: Fri, 4 Nov 2005 23:27:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 5/5] cpuset: memory reclaim rate meter
Message-Id: <20051104232719.6243ee0f.pj@sgi.com>
In-Reply-To: <20051104053153.549.83350.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053153.549.83350.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> Provide a simple per-cpuset metric of memory stress, tracking the
> -rate- that the tasks in a cpuset call try_to_free_pages(), the
> synchronous (direct) memory reclaim code.

On another thread
	[PATCH 0/7] Fragmentation Avoidance V19" (Mel Gorman's)
Andrew rejected this memory reclaim meter patch, for several reasons.

I hope the other 4 patches in this set will go into *-mm, and be
considered for 2.6.15:

    [PATCH 1/5] cpuset: better bitmap remap defaults
    [PATCH 2/5] cpuset: rebind numa vma mempolicy
    [PATCH 3/5] cpuset: change marker for relative numbering
    [PATCH 4/5] cpuset: mempolicy one more nodemask conversion

(Well - I see 2/5, and its fix 6/5, is raising issues in my inbox ;)

I am about to resubmit this 5/5 memory reclaim rate, with a change
to make it essentially zero cost (test a global flag) on systems that
don't use it.

We continue to have a critical need on large systems under batch
management for the batch manager to detect, economically and quickly,
when a job is applying significant memory pressure to its cpuset.

Per-task or per-mm statistics can provide more detail, on a variety
of specific metrics.  But batch managers on big systems neither want,
nor can afford, these statistics.

To access some attribute of each task in a cpuset first requires
reading the cpusets 'tasks' file, to list the tasks in the cpuset.
This scans the task list to see which tasks reference that cpuset.
Since the tasks in a cpuset may change frequently, a batch manager
would have to relist the tasks each time it examined that cpuset for
memory pressure.  Frequent task list scans and accessing a file
per-task gets expensive.

>From what I can tell, the direct reclaim code, try_to_free_pages(),
is not called at a high rate.  In my simple tests, it was called 10 to
20 times per second, by the threads in a cpuset allocating memory as
fast as they can, past what fit easily.  I suspect that it is rate
limited by disk speeds, to a rough approximation.

Experience on prior systems, and my simple tests now, show that
watching for entry into direct reclaim provides a good indication
of memory pressure.  Certainly other events happen under pressure as
well; batch managers really don't care.  They just want to know when
a job is trying to blow out of its memory confinement.

There may well be a need for more specific memory management counters
on a per-task or per-mm basis.  I don't have the expertise, experience
or franchise to drive that effort.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
