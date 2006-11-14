Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965563AbWKNMwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965563AbWKNMwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965569AbWKNMwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:52:18 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:63483 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965563AbWKNMwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:52:16 -0500
Date: Tue, 14 Nov 2006 17:48:32 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com, dipankar@in.ibm.com,
       davej@redhat.com, mingo@elte.hu, kiran@scalex86.org
Subject: [RFC 0/4] Cpu-Hotplug: Use per subsystem hot-cpu mutexes.
Message-ID: <20061114121832.GA31787@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Since 2.6.18-something, the community has been bugged by the problem to
provide a clean and a stable mechanism to postpone a cpu-hotplug event
as lock_cpu_hotplug was badly broken.

This is another proposal towards solving that problem. This one is 
along the lines of the solution provided in kernel/workqueue.c

Instead of having a global mechanism like lock_cpu_hotplug, 
we allow the subsytems to define their own per-subsystem hot cpu
mutexes. These would be taken(released) where ever we are currently 
calling lock_cpu_hotplug(unlock_cpu_hotplug).

Also, in the per-subsystem hotcpu callback function,we take
this mutex before we handle any pre-cpu-hotplug events and release
it once we finish handling the post-cpu-hotplug events. A standard
means for doing this has been provided in [PATCH 2/4] and demonstrated
in [PATCH 3/4].

The ordering of these per-subsystem mutexes might still prove to be a
problem, but hopefully lockdep should help us get out of that muddle.

The patch set to be applied against linux-2.6.19-rc5 is as follows:

[PATCH 1/4] :	Extend notifier_call_chain with an option to specify the
		number of notifications to be sent and also count the
		number of notifications actually sent.
		
[PATCH 2/4] :	Define events CPU_LOCK_ACQUIRE and CPU_LOCK_RELEASE
		and send out notifications for these in _cpu_up and
		_cpu_down. This would help us standardise the acquire and
		release of the subsystem locks in the hotcpu 
		callback functions of these subsystems.
		
[PATCH 3/4] :	Eliminate lock_cpu_hotplug from kernel/sched.c.
		
[PATCH 4/4] :	In workqueue_cpu_callback function, acquire(release) the
		workqueue_mutex while handling 
		CPU_LOCK_ACQUIRE(CPU_LOCK_RELEASE).

If the per-subsystem-locking approach survives the test of time,
we can expect a slow phasing out of lock_cpu_hotplug, which has not
yet been eliminated in these patches :)

Awaiting your feedback.

Thanks,
gautham.

PS: These patches are intended for post 2.6.19, since most of the warnings
with respect to cpu_hotplug_locking (including the cpufreq ones) seem to 
have disappeared in 2.6.19-rc5.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
