Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWBFW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWBFW7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWBFW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:59:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50580 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932414AbWBFW73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:59:29 -0500
Date: Mon, 6 Feb 2006 14:59:22 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
Message-Id: <20060206145922.3eb3c404.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> There are situations in which memory allocations are restricted by policy, 
> by a cpuset or by type of allocation. 
> 
> I propose that we need different OOM behavior for the cases in which the
> user has imposed a limit on what type of memory to be allocated. In that 
> case the application should be terminate with OOM. The OOM killer should 
> not run.

I'll duck the discussion that followed your post as to whether some
sort of error or null return would be better than killing something.

If it is the case that some code path leads to the OOM killer, then
I don't agree that memory restrictions such as cpuset constraints
should mean we avoid the OOM killer.

I've already changed the OOM killer to only go after tasks in or
overlapping with the same cpuset.

static struct task_struct *select_bad_process(unsigned long *ppoints)
{
	...
	do_each_thread(g, p) {
		...
		/* If p's nodes don't overlap ours, it won't help to kill p. */
		if (!cpuset_excl_nodes_overlap(p))
			continue;
                                                    
I am guessing (you don't say) that your concern is that it seems
unfair for some app in some small cpuset to be able to trigger the
system-wide OOM killer.  The basic problem that this caused, that
of killing unrelated processes in entirely non-overlapping cpusets,
which was of no use in reducing the memory stress in the faulting
cpuset, is no longer a problem.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
