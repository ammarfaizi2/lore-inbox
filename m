Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWBFG4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWBFG4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWBFG4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:56:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751032AbWBFG4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:56:47 -0500
Date: Sun, 5 Feb 2006 22:56:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205225629.5d887661.pj@sgi.com>
In-Reply-To: <20060205203711.2c855971.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> IOW: this patch seems to be a highly specific bandaid which is repairing an
> ill-advised problem of our own making, does it not?


I am mystified.  I am unable to imagine how you see this memory
spreading patchset as a response to some damage caused by previous
work.

Nothing we have ever done has deprived us of the ability to run a
job in a cpuset, where the application code of that job manages the
per-node placement of thread local storage, while the kernel evenly
distributes the placement of file system activity.

We never had that ability, in the mainline Linux kernel.

Ingo describes one alternative workload, where this alternative
strategy is useful.

What Ingo described involved a particular job on a 64 CPU, 1 TB system.
We have systems with multiple cpusets of such sizes, each running
such a job, all on the same system, at once.

Big shared systems, running performance critical jobs simultaneously,
present different challenges than seen on embeddeds, workstations or
smaller multi-use servers.

The driving force here is not our prior kernel design decisions.

The driving force is the economics of big systems, paid for by larger
organizations for use across multiple divisions or departments or
universities or commands whatever unit.  Systems obtained for running
performance critical, highly parallel, data and computationally
intensive applications.  They require job isolation of cpu and memory,
application management of memory use for thread local storage, and
uniform behaviour across the cpuset of kernel memory usage.

Each such job -may- require this alternative page and slab cache
memory spreading strategy, which is why it's a per-cpuset choice.

> What happens if one process does lots of filesystem activity and another
> one (concurrent or subsequent) wants lots of thread-local storage?  Won't
> the same thing happen?

Don't run two jobs in the same cpuset that have conflicting
memory requirements.

We're talking dedicated cpusets, with dedicated cpus and memory
nodes, for a given job.  Or, in Ingo's example, essentially a
single cpuset, covering the entire system, running one job.

In either case, some workloads require a different strategy for
such kernel memory placement, which would be the wrong default for most
uses.

So, the user must tell the kernel it needs this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
