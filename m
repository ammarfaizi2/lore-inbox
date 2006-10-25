Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWJYTl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWJYTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJYTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:41:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10988 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932268AbWJYTlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:41:25 -0400
Date: Wed, 25 Oct 2006 12:40:40 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061025124040.c347cc34.pj@sgi.com>
In-Reply-To: <20061023195011.GB1542@in.ibm.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061023195011.GB1542@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinikar wrote:
> I really think all we need is to have a new flag (say sched_domain)
> that can be used by the admin to create a sched domain. ...
> 
> I am testing this patch currently and will post it shortly for review

Are you still working on this patch?  I'm still figuring that this, or
my 'cpu_must_load_balance' variation, will be our best choice.

The other avenue of pursuit, Nick's suggestion to partition based on
the individual task cpus_allowed masks, is blowing up on me.  Details
below, if it matters to anyone ...

===

A couple days ago, I wrote:
> 
> I can imagine an algorithm, along the lines Nick suggested yesterday,
> to extract partitions from the cpus_allowed masks of all the tasks:
> 
>     It would scan each byte of each cpus_allowed mask (it could do
>     bits, but bytes provide sufficient granularity and are faster.)
> 
>     It would have an intermediate array of counters, one per cpumask_t
>     byte (that is, NR_CPUS/8 counters.)
> 
>     For each task, it would note the lowest non-zero byte in that
>     tasks cpus_allowed, and increment the corresponding counter.
>     Then it also note the highest non-zero byte in that cpus_allowed,
>     and decrement the corresponding counter.
> 
>     Then after this scan of all task cpus_allowed, it would make
>     a single pass over the counter array, summing the counts in a
>     running total.  Anytime during that pass that the running total
>     was zero, a partition could be placed.
> 
>     This resembles the algorithm used to scan parenthesized expressions
>     (Lisp, anyone?) to be sure that the parentheses are balanced
>     (count doesn't go negative) and closed (count ends back at zero.)
>     During such a scan, one increments a count on each open parenthesis,
>     and decrements it on each close.
> 
> But I'm going to be surprised if such an algorithm actually finds good
> sched domain partitions, without at least manual intervention by the
> sysadmin to remove tasks from all of the large cpusets.


This is a terrible algorithm.  It does a really poor job of finding
optimum (minimum size) sched domain partitions.

For example, if we pinned every task in the system so that it is
either running on the even numbered CPUs, or on the odd numbered CPUs,
this algorithm would miss the obvious partitioning, into even and
odd numbered CPUs.

Or for a more flagrant example, lets say we pinned every single task
but one to a single CPU, and then pinned that last task to a pair of
CPUs, the lowest numbered and the highest numbered CPUs.  Ideally we
would only have a single sched domain partition in the entire system
that needed balancing - a two CPU partition for that last task.
The above algorithm would lump all the CPUs in the system into a
partition, because they are numbered in the range of CPUs covered
by that last task, into a single sched domain partition covering the
entire system.

If people only selected cpus_allowed masks allowing adjacent CPUs, then
this algorithm worked just fine.  That's not a realistic constraint.

A deterministic algorithm for this might be NP-complete, I don't know.
Whether or not a useful approximation exists, I don't know.  And even
if we found one, whether or not it would adequately meet the needs
of high CPU count systems anywhere nearly as well as simply marking
cpusets with flag to indicate which ones define sched domains,
or which ones don't need to be load balanced ... I don't know, but
I'm skeptical.



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
