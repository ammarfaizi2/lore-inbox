Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVERR6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVERR6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVERR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:58:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38879 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262229AbVERR5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:57:23 -0400
Date: Wed, 18 May 2005 23:36:52 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [Lse-tech] Re: [RFT PATCH] Dynamic sched domains (v0.6)
Message-ID: <20050518180652.GA4293@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050517041031.GA4596@in.ibm.com> <20050517225354.025c3cca.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517225354.025c3cca.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 10:53:54PM -0700, Paul Jackson wrote:
> Looking good.  Some minor comments on these three patches ...
> 
>  * The name 'nodemask' for the cpumask_t of CPUs that are siblings to CPU i
>    is a bit confusing (yes, that name was already there).  How about
>    something like 'siblings' ?

Not sure which code you are referring to here ?? I dont see any nodemask
referring to SMT siblings ? 

>    can be replaced with the one line:
> 
> 	cpus_andnot(cpu_default_map, *cpu_map, cpu_isolated_map);

yeah, ok

>    I would mildly prefer to always spell this 'cpu_exclusive' (with
>    underscore, not hyphen).

fine

>    Good work.

Thanks !

> 
>  * Question - any idea how much of a performance hiccup a system will feel
>    whenever someone changes the cpu_exclusive cpusets?  Could this lead
>    to a denial-of-service attack, if say some untrusted user were allowed
>    modify privileges on some small cpuset that was cpu_exclusive, and they
>    abused that privilege by turning on and off the cpu_exclusive property
>    on their little cpuset (or creating/destroying an exclusive child):
> 

I tried your script and see that it makes absolutely no impact on top.
The CPU on which it is running is mostly 100% idle. However I'll run
more tests to confirm that it has no impact


> 
>  * The cpuset 'oldcs' in update_flag() seems to only be used for its
>    cpu_exclusive flag.  We could save some stack space on my favorite
>    big honkin NUMA iron by just having a local variable for this
>    'old_cpu_exclusive' value, instead of the entire cpuset.
> 
>  * Similarly, though with a bit less savings, one could replace 'oldcs'
>    in update_cpumask() with just the old_cpus_allowed mask.
>    Or, skip even that, and compute a boolean flag:
> 	cpus_changed = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
>    before copying over the trialcs, so we only need one word of stack
>    for the boolean, not possibly many words for a cpumask.

ok for both

> 
>  * Non-traditional code style:
> 	}
> 	else {
>    should be instead:
> 	} else {

I dont know how that snuck back in, I'll change that

> 
>  * Is it the case that update_cpu_domains() is called with cpuset_sem held?
>    Would it be a good idea to note in the comment for that routine:
> 	 * Call with cpuset_sem held.  May nest a call to the
> 	 * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
>    I didn't callout the cpuset_sem lock precondition on many routines,
>    but since this one can nest the cpu_hotplug lock, it might be worth
>    calling it out, for the benefit of engineers who are passing through,
>    needing to know how the hotplug lock nests with other semaphores.

ok 

I do feel with the above updates the patches can go into -mm.
Appreciate all the review comments from everyone, Thanks


	-Dinakar
