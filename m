Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVERFyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVERFyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVERFyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:54:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:433 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262101AbVERFym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:54:42 -0400
Date: Tue, 17 May 2005 22:53:54 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [RFT PATCH] Dynamic sched domains (v0.6)
Message-Id: <20050517225354.025c3cca.pj@sgi.com>
In-Reply-To: <20050517041031.GA4596@in.ibm.com>
References: <20050517041031.GA4596@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking good.  Some minor comments on these three patches ...

 * The name 'nodemask' for the cpumask_t of CPUs that are siblings to CPU i
   is a bit confusing (yes, that name was already there).  How about
   something like 'siblings' ?

 * I suspect that the following two lines:

	cpus_complement(cpu_default_map, cpu_isolated_map);
	cpus_and(cpu_default_map, cpu_default_map, *cpu_map);

   can be replaced with the one line:

	cpus_andnot(cpu_default_map, *cpu_map, cpu_isolated_map);

 * You have 'cpu-exclusive' in some places in the Documentation.
   I would mildly prefer to always spell this 'cpu_exclusive' (with
   underscore, not hyphen).

 * I like how this design came out, as described in:
	A cpuset that is cpu exclusive has a sched domain associated with it.
	The sched domain consists of all cpus in the current cpuset that are not 
	part of any exclusive child cpusets.
   Good work.

 * Question - any idea how much of a performance hiccup a system will feel
   whenever someone changes the cpu_exclusive cpusets?  Could this lead
   to a denial-of-service attack, if say some untrusted user were allowed
   modify privileges on some small cpuset that was cpu_exclusive, and they
   abused that privilege by turning on and off the cpu_exclusive property
   on their little cpuset (or creating/destroying an exclusive child):

	cd /dev/cpuset/$(cat /proc/self/cpuset)
	while true
	do
		for i in 0 1
		do
			echo $i > cpu_exclusive
		done
	done

   If so, perhaps we should recommend that shared systems with untrusted
   users avoid allowing a cpu_exclusive cpuset to be modifiable, or to have
   a cpu_exclusive flag modifiable, by those untrusted users.

 * The cpuset 'oldcs' in update_flag() seems to only be used for its
   cpu_exclusive flag.  We could save some stack space on my favorite
   big honkin NUMA iron by just having a local variable for this
   'old_cpu_exclusive' value, instead of the entire cpuset.

 * Similarly, though with a bit less savings, one could replace 'oldcs'
   in update_cpumask() with just the old_cpus_allowed mask.
   Or, skip even that, and compute a boolean flag:
	cpus_changed = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
   before copying over the trialcs, so we only need one word of stack
   for the boolean, not possibly many words for a cpumask.

 * Non-traditional code style:
	}
	else {
   should be instead:
	} else {

 * Is it the case that update_cpu_domains() is called with cpuset_sem held?
   Would it be a good idea to note in the comment for that routine:
	 * Call with cpuset_sem held.  May nest a call to the
	 * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
   I didn't callout the cpuset_sem lock precondition on many routines,
   but since this one can nest the cpu_hotplug lock, it might be worth
   calling it out, for the benefit of engineers who are passing through,
   needing to know how the hotplug lock nests with other semaphores.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
