Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVLLGLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVLLGLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVLLGLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:11:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63382 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751151AbVLLGLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:11:24 -0500
Date: Sun, 11 Dec 2005 22:11:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051211221110.f94ec92a.pj@sgi.com>
In-Reply-To: <20051212032902.GW11190@wotan.suse.de>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<20051212032902.GW11190@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks. But i guess it would be still a good idea to turn
> ia "check that there is no cpuset" test into an inline
> so that it can be done without a function call. 

Do you mean this check, in cpuset_update_task_memory_state()

        if (unlikely(!cs))
                return;

Inlining this check will -not- help systems not using cpusets.

Unlike mempolicies, which use NULL for the default case, tasks
almost always have non-NULL cpuset pointers (on any system with
CONFIG_CPUSET).

This unlikely check was here because during the early boot process,
there was a window during which the memory subsystem was healthy
enough to take calls, but the cpuset system was not initialized yet.

I can remove the above check entirely, by adding a "cpuset_init_early",
that fabricates enough of a valid cpuset for that init task to get
through this code without stumbling.

Yes - that works - patch forthcoming soon to remove the above check,
using a cpuset_init_early() call instead.

===

I have a different scheme in place to minimize the load on systems
with CONFIG_CPUSET enabled.  See the number_of_cpusets global kernel
counter, in the *-mm patch:

  cpuset_number_of_cpusets_optimization

It enables short circuiting with inline code the other key routine
on the memory allocation path: cpuset_zone_allowed().

However, looking at it just now, I realize that this number_of_cpusets
hack doesn't help with cpuset_update_task_memory_state().  Even though
the currently running system has only one cpuset, it might have had
more in the past, and some task that hasn't had to allocate memory
since the system went back down to one cpuset might still be pointing
at the old cpuset it had.

I'm still looking for a clean way to short circuit this call to
cpuset_update_task_memory_state() in the case that a system is compiled
with CONFIG_CPUSET, but no one has used cpusets.

Any other ideas?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
