Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWA0XHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWA0XHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWA0XHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:07:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43428 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751454AbWA0XHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:07:06 -0500
Date: Fri, 27 Jan 2006 17:06:59 -0600
From: Jack Steiner <steiner@sgi.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060127230659.GA4752@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears if CONFIG_HOTPLUG_CPU is enabled, then all possible
cpus (0 .. NR_CPUS-1) are set in the cpu_possible_map on IA64.

	void __init
	smp_build_cpu_map (void)
	{
	...
        	for (cpu = 0; cpu < NR_CPUS; cpu++) {
                	ia64_cpu_to_sapicid[cpu] = -1;
	#ifdef CONFIG_HOTPLUG_CPU				<<<<
                	cpu_set(cpu, cpu_possible_map);		<<<<
	#endif							<<<<
        	}


sched_getaffinity() returns the cpu_possible_map and'd with the current
task p->cpus_allowed. The default cpus_allowed is all ones.

This is causing problems for apps that use sched_get_sched_affinity()
to determine which cpus that they are allowed to run on.
The call to sched_getaffinity returns:

	(from strace on a 2 cpu system with NR_CPUS = 512)
	sched_getaffinity(0, 1024,  { ffffffffffffffff, ffffff ...



The man page for sched_getaffinity() is ambiguous. It says:
	- A set bit corresponds to a legally  schedulable  CPU

But it also says:
	- Usually, all bits in the mask are set.


Should the following change be made to sched_getaffinity(). 

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
+++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
@@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
 		goto out_unlock;
 
 	retval = 0;
-	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
+	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:
 	read_unlock(&tasklist_lock);

-- 
Thanks

Jack Steiner (steiner@sgi.com)


