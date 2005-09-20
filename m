Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVITOzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVITOzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVITOzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:55:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51085 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965023AbVITOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:55:15 -0400
Date: Tue, 20 Sep 2005 09:54:49 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Robin Holt <holt@sgi.com>, zippel@linux-m68k.org, akpm@osdl.org,
       torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-ID: <20050920145449.GA31461@lnx-holt.americas.sgi.com>
References: <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home> <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com> <20050920120523.GC21435@lnx-holt.americas.sgi.com> <20050920072255.0096f1bb.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920072255.0096f1bb.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 07:22:55AM -0700, Paul Jackson wrote:
> Robin asked:
> Let's say we have the following notify_on_release cpusets,
> each with exactly one task in them:
> 
> 	/dev/cpuset/A		task1
> 	/dev/cpuset/A/B		task2
> 	/dev/cpuset/A/B/C	task3
> 
> Lets further say that tasks 1, 2 and 3, exit, in that
> order, task1 first.
> 
> When task1 exits, no cpusets are removed.
> 
> When task2 exits, no cpusets are removed.
> 
> When task3 exits, cpuset A/B/C needs to be removed. That in
> turn triggers removing A/B.  That in turn triggers removing A.
> 
> I was confident that I could do these three removals safely
> by doing three rmdir(2) system calls, one at a time, in order,
> working from the bottom up.
> 
> I had no clue how to do these three removals safely, working
> from the bottom up, while in the kernel exit code for task3.

This makes things even easier!!!

When you create a cpuset, set the refcount to 0.  The root
cpuset is the exception and has a refcount of 1.

When tasks are added to the cpuset, increment the refcount.

When child cpusets are created, increment the refcount.  Each
cpuset has a list of children that is protected by a single
lock.

Whenever you are decrementing the cpuset's refcount, use
atomic_dec_and_lock on the parents child list lock.  If the
notify_on_release property is set, you remove the child from
the list.

When the vfs code is traversing the list, you need to ensure
that it does not iterate unless the child list lock is held.
I have not looked at how you implemented the vfs stuff, but
that should be easily accomplished.

Where are the holes?

Thanks,
Robin
