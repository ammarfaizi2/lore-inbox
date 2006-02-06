Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWBFHXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBFHXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWBFHXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:23:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60319 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750704AbWBFHXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:23:12 -0500
Date: Sun, 5 Feb 2006 23:22:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205232253.ddbf02d7.pj@sgi.com>
In-Reply-To: <20060206061743.GA14679@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wondering whether it would be 
> enough to simply extend madvise and fadvise to 'task' scope as well, and 
> change the pagecache allocation pattern to 'spread out' pages on NUMA, 
> if POSIX_FADV_RANDOM / MADV_RANDOM is specified.

This would not seem to work, at least for the needs I am aware of.

The tasks we are talking about do -not- want a default RANDOM
policy.  They want node-local allocation for per-thread data
(data and stack for example), and at the same time spread
allocation for kernel space (page and slab cache).

For another thing, memory spreading is not the same as RANDOM
policies.  RANDOM policies apply to page read ahead and retention
strategies, not to page placement (what node they are faulted into)
policies.

For a third thing, madvise takes a virtual address range, which
is irrelevant for specifying kernel address space page and slab
cache pages.

But the biggest difficulty, from my perspective, would be that
this strategy is normally selected per-cpuset, not per-task.

We are managing memory placement across the cpuset, on a per-job
basis.  It's the system administrator or batch scheduler, not the
individual application coder, who will likely want to enforce this
alternative memory placement strategy.

The madvise and posix_fadvise calls have no provision for one task
to affect another.  They just apply to the current task.  As Andrew
noted, it doesn't make much sense for different tasks in the same
cpuset to disagree on this placement policy choice.  We need a cpuset
wide policy choice, and a cpuset wide mechanism for making the choice,
not a per-task task internal mechanism.

Or at the very least, an attribute that is inherited across fork
and exec, so that a job grandfather (founding father) task can
set the policy, for all descendents.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
