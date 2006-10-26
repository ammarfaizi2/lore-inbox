Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423232AbWJZKsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423232AbWJZKsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWJZKsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:48:46 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:17608 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423232AbWJZKso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:48:44 -0400
Date: Thu, 26 Oct 2006 16:18:58 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [RFC 0/5] lock_cpu_hotplug: Redesign - A "lightweight" scalable version.
Message-ID: <20061026104858.GA11803@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

My previous attempt to redesign cpu_hotplug locking had raised certain issues 
like 
	- Setting right cpufreq's cpu_hotplug_locking.
	- Using per-subsystem locks instead of a global lock.
	- Scalability of a global lock.
	- Unfairness proving a potential drawback.

This patch set attempts to address these issues.

Setting right cpufreq's cpu_hotplug_locking
-------------------------------------------
lock_cpu_hotplug is required in cpufreq subsystem to prevent a hotplug
event from occuring while we are changing frequencies on a group of cpus.
The *ideal* place to have (un)lock_cpu_hotplug is around cpufreq_driver->target
inside __cpufreq_driver_target.

But unfortunately, __cpufreq_driver_target is called from so many different
places,
(http://gautham.shenoy.googlepages.com/cpufreq_driver_target_callers.txt)
including the hot-cpu-callback path, that it becomes impossible to 
have lock_cpu_hotplug inside __cpufreq_driver_target.

Which is why all the lock_cpu_hotplug calls had to be moved up the subsystem
to ensure that any code-path which might trigger cpu-frequency change would
take lock_cpu_hotplug.
The patch http://lkml.org/lkml/2006/7/26/140 by Arjan accomplishes this.

However, the problem of lock_cpu_hotplug being called from a hot-cpu-callback
path still remains unsolved. This patch-set attempts to free the callback path
of any calls to lock_cpu_hotplug.

Per-subsystem hotplug locks.
----------------------------
It *is* possible to go for per-subsytem locks as done in case of workqueue.c
using workqueue_mutex, and register the hot-cpu notifier with an appropriate
priority. 

I have tried this approach for kernel/sched.c and mm/slab.c. 
This seemed to be working fine, except for the false positives raised by 
lockdep which was because of holding these mutexes between
cpu_chain_mutex lock/unlock.

My big concern about this is the possible interdependency of subsystems
now to get locking order correct, which can be an ugly thing to solve by
itself at the compile time. Although I havent been able to find a concrete 
example for such a dependency (except of course the famous
cpufreq_ondemand-workqueue one), implicitly relying on the fact that such a
possibility will not arise is, IMHO, "not the right thing".

Which is why I feel lock_cpu_hotplug deserves one more chance (though
it seriously needs a better name to suit it's refcount implementation).

Scalability of the global lock.
------------------------------------------
The proposed locking schema is *extremely* lightweight in the reader-fast path.
This is achieved by using a per-cpu refcount which will be bumped up/down 
depending on the read_lock or read_unlock.

In the reader-slow path, which is extremely rare, the lock becomes a unfair
rw-sem i.e writers assume control *only* when there are no readers in the
system.

The writer, on arrival would just set the writer_flag and do a 
synchronize_sched() to allow all the pending readers to finish and prompt the
new readers to take the slowpath.Paul McKenney suggested this approach.

If there are readers in the system, the writer will sleep and will be
woken up by the last *reader*.

Unfairness-proving to be a problem.
------------------------------------
I could not find any system calls that would allow the users to exploit
unfairness. Hoping that I haven't missed out anything important, I have
decided to retain the unfair nature of lock_cpu_hotplug.

The patch set is as follows.
[patch 1/5]: 	cpufreq subsystem cleanup to fix coding style issues and other
		trivial issues. Hope this improves the readability of this code.

[patch 2/5]:	Eliminate lock_cpu_hotplug in cpufreq's hotcpu callback path.

[patch 3/5]:	Use (un)lock_cpu_hotplug instead of workqueue_mutex.
		This fixes the lockdep warnings, for holding workqueue_mutex
		between cpu_chain lock/unlock!

[patch 4/5]:	Proposed new design for cpu_hotplug lock.

[patch 5/5]:	Add lockdep support to the proposed cpu_hotplug lock.

These patches are against linux-2.6.19-rc2-mm2.

Looking forward to your feedback.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
