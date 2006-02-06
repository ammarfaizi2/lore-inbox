Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWBFJco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBFJco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBFJco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:32:44 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37790 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750852AbWBFJcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:32:43 -0500
Date: Mon, 6 Feb 2006 01:32:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206013227.2407cf8c.pj@sgi.com>
In-Reply-To: <20060205230816.4ae6b6e2.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
	<20060205225629.5d887661.pj@sgi.com>
	<20060205230816.4ae6b6e2.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Well I agree.

Good.


> And I think that the only way we'll get peak performance for
> an acceptaly broad range of applications is to provide many fine-grained
> controls and the appropriate documentation and instrumentation to help
> developers and administrators use those controls.
> 
> We're all on the same page here.  I'm questioning whether slab and
> pagecache should be inextricably lumped together though.

They certainly don't need to be lumped.  I just don't go about
creating additional mechanism or apparatus until I smell the need.
(Well, sometimes I do -- too much fun. ;)

When Andrew Morton, who has far more history with this code than I,
recommends such additional mechanism, that's all the smelling I need.

How fine grained would you recommend, Andrew?

Is page vs slab cache the appropriate level of granularity?



> Is it possible to integrate the slab and pagecache allocation policies more
> cleanly into a process's mempolicy?  Right now, MPOL_* are disjoint.
> 
> (Why is the spreading policy part of cpusets at all?  Shouldn't it be part
> of the mempolicy layer?)

The NUMA mempolicy code handles per-task, task internal memory placement
policy, and the cpuset code handles cpuset-wide cpu and memory placement
policy.

In actual usage, spreading the kernel caches of a job is very much a
decision that is made per-job(*), by the system administrator or batch
scheduler, not by the application coder.  The application code may well
be -very- awary of the placement of their data pages in user address
space, and to manage this will use calls such as mbind and
set_mempolicy, in addition to using node-local placement (arranging to
fault in each page from a thread running on the node that is to receive
that page).  The application has no interest in micromanaging the
kernels placement of page and slab caches, other than choosing between
node-local and cpuset spread strategies.

(*) Actually, made per-cpuset, not per-job.  But where this matters,
    that tends to be the same thing.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
