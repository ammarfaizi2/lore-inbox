Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVDWWgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVDWWgB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVDWWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:36:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61575 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262156AbVDWWeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:34:06 -0400
Date: Sat, 23 Apr 2005 15:30:59 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated
 cpusets
Message-Id: <20050423153059.0ab5fdc2.pj@sgi.com>
In-Reply-To: <20050421162738.GA4200@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<20050419093438.GB3963@in.ibm.com>
	<20050419102348.118005c1.pj@sgi.com>
	<20050420071606.GA3931@in.ibm.com>
	<20050420120946.145a5973.pj@sgi.com>
	<20050421162738.GA4200@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
>   cpuset               cpus       isolated   cpus_allowed   isolated_map
> top                 0-7               1           0             0-7

The top cpuset holds the kernel threads that are pinned to a particular
cpu or node.  It's not right that their cpusets cpus_allowed is empty,
which is what I guess the "0" in the cpus_allowed column above means.
(Even if the "0" means CPU 0, that still conflicts with kernel threads
on CPUs 1-7.)

We might get away with it on cpus, because we don't change the tasks
cpus_allowed to match the cpusets cpus_allowed (we don't call
set_cpus_allowed, from kernel/cpuset.c) _except_ when someone rebinds
that task to its cpuset by writing its pid into the cpuset tasks file.
So for as long as no one tries to rebind the per-cpu or per-node
kernel threads, no one will notice that they in a cpuset with an
empty cpus_allowed.

This won't even work that well on the memory side, where we resync
a task with its cpuset anytime that a task goes to allocate memory
(if it can WAIT and it is not in interrupt) and we notice that someone
has bumped the mems_generation for its cpuset.

In other words, I strongly suspect that:

 1) The top cpuset should allow all cpus, all memory nodes.
 2) The way to assure that one task can't have its cpu or memory stolen
    by another is to put the other tasks in cpusets that don't overlap.
 3) The wrong way to assure this is by refusing to have any other cpusets
    that have overlapping cpus_allowed or mems_allowed.
 4) There are some tasks that _do_ require to run on the same cpus as
    the tasks you would assign to isolated cpusets.  These kernel threads,
    such as for example the migration and ksoftirqd threads, must be setup
    well before user code is run that can configure job specific isolated
    cpusets, so these tasks need a cpuset to run in that can be created
    during the system boot, before init (pid == 1) starts up.  This cpuset
    is the top cpuset.

My users are successfully managing what tasks can use what cpu or memory
resources by controlling which tasks are in which cpusets.  They do not
require the ability to disable allowed cpus or memory nodes in other cpusets
to do this.  It is not entirely clear to me that they even require the
minimal cpu_exclusive/mem_exclusive facility that is there now.

I don't understand why what's there now isn't sufficient.  I don't see
that this patch provides any capability that you can't get just by
properly placing tasks in cpusets that have the desired cpus and nodes.
This patch leaves the per-cpu kernel threads with no cpuset that allows
what they need, and it complicates the semantics of things, in ways that
I still don't entirely understand.

Earlier you wrote:
> 1. I need a method to isolate a random set of cpus in such a way that
>    only the set of processes that are specifically assigned can
>    make use of these CPUs

I don't see why you need this.  Nor do I think it is possible.

You don't need to isolate a set of cpus; you need to isolate a set of
processes.  So long as you can create non-overlapping cpusets, and
assign processes to them, I don't see where it matters that you cannot
prohibit the creation of overlapping cpusets, or in the case of the top
cpuset, why it matters that you cannot _disallow_ allowed cpus
or memory nodes in existing cpusets.

And this is not possible because at least the kernel per-cpu threads
_do_ need to run on each cpu in the system, including those cpus you
would isolate.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
