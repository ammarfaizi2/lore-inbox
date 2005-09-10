Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVIJDCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVIJDCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJDCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:02:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbVIJDCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:02:07 -0400
Date: Fri, 9 Sep 2005 20:01:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, stable@kernel.org
Subject: Re: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Message-ID: <20050910030127.GE7762@shell0.pdx.osdl.net>
References: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Paul.  As Randy mentioned, please send these to stable@kernel.org
in the future.

* Paul Jackson (pj@sgi.com) wrote:
> Code reading uncovered a potential deadlock on the global cpuset
> semaphore, cpuset_sem.

Another 'by inspection' patch, perhaps we'll need to update the stable
rules, since these can be quite valid fixes, yet typically trigger
review replies asking if it's necessary for -stable.

> ==> This patch is only useful in the 2.6.13-stable series.
> 
>     (It's harmless, and useless, in the pre 2.6.14 fork)
> 
> The pre-2.6.14 fork has already diverged, with an additional patch
> that further aggrevated this problem, and a more thorough overhaul
> of the cpuset locking, to fix the problems.
> 
> All code paths in kernel/cpuset.c (2.6.13 or earlier) that first
> grab cpuset_sem and then allocate memory _must_ call the routine
> 'refresh_mems()', after getting cpuset_sem, before any possible
> allocation.
> 
> If this refresh_mems() call is not done, then there is a risk that one
> of the cpuset_zone_allowed() calls made from within the page allocator
> (__alloc_pages) will find that the mems_generation of the current task
> doesn't match that of its cpuset, causing it to try to grab cpuset_sem.
> Since it already held cpuset_sem, this deadlocks that task, and any
> subsequent task wanting cpuset_sem.
> 
> ==> The code paths leading to the kmalloc in check_for_release(), from
>     cpuset_exit, cpuset_rmdir and attach_task (for the detached cpuset),
>     fail to invoke refresh_mems() as required.
> 
>     The fix is easy enough - add the requisite refresh_mems() call.
> 
> Unless someone is rapidly creating, modifying and destroying cpusets,
> they are unlikely to have any chance of encountering this deadlock.
> And even then, it is apparently difficult to do so.

How unlikely?  So unlikely that it's more a theoreitical race, or did
you find ways to trigger?  If it's purely theoretical then it's not a
good candidiate for -stable.

> In the case we got here from cpuset_exit(), we have already torn
> down the tasks connection to this cpuset and current->cpuset is NULL.
> Don't call refresh_mems() in that case - it oops the kernel.

Is this one well-tested, since the fix diverges from upstream?  And one
minor nit, let's just do a real forward declaration of refresh_mems() 
instead of local to check_for_release().

thanks,
-chris
