Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUCaBvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUCaBvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:51:52 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18686 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261568AbUCaBvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:51:44 -0500
Date: Tue, 30 Mar 2004 17:51:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: rddunlap@osdl.org, hari@in.ibm.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <276260000.1080697873@flay>
In-Reply-To: <20040330173620.6fa69482.akpm@osdl.org>
References: <006701c415a4$01df0770$d100000a@sbs2003.local><20040329162123.4c57734d.akpm@osdl.org><20040329162555.4227bc88.akpm@osdl.org><20040330132832.GA5552@in.ibm.com><20040330151729.1bd0c5d0.rddunlap@osdl.org><187940000.1080692555@flay><20040330163928.7cafae3d.akpm@osdl.org><270000000.1080694659@flay><20040330171104.752104a9.akpm@osdl.org><273320000.1080696246@flay> <20040330173620.6fa69482.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think we're assuming that we don't have to because the problem is fixed 
>> by the "cpus_and(tmp, cpumask, cpu_online_map)" in flush_tlb_others so we 
>> don't have to. Except it's racy, and doesn't work.
> 
> And it's a kludge, to work around dangling references to a CPU which has
> gone away.

Yes ;-)
 
>> It would seem to me that your suggestion would fix it. But isn't locking
>> cpu_online_map both simpler and (most importantly) more generic? I can't 
>> imagine that we don't use this elsewhere ... suppose for instance we took 
>> a timer interrupt, causing a scheduler rebalance, and moved a process to 
>> an offline CPU at that point? Isn't any user of smp_call_function also racy?
> 
> If we have to add any fastpath locking to cope with CPU removal or reboot
> then it's time to make CONFIG_HOTPLUG_CPU dependent upon CONFIG_BROKEN.

Yeah, but as we've proved, it's not just hotplug, it's shutdown. And I don't
think we can make that depend on CONFIG_BROKEN ;-) I don't see a *read*
side RCU lock as an impostion on the fastpath (for reading cpu_online_map),
and I don't care if writing to cpu_online_map is slower. A spinlock would
be crappy, yes ...

> yes, cpu_online_map should be viewed as a reference to the going-away CPU
> for smp_call_function purposes.  However the CPU takedown code appears to
> do the right thing: it removes the cpu from cpu_online_map first, then does
> the stop_machine() thing which should ensure that all other CPUs have
> completed any cross-CPU call which they were doing, yes?

Andy almost managed to convince me that the smp_call_function stuff is safe,
based on call_lock exclusion. Except that we count that cpu stuff outside
it ... but that's trivial to fix, we just move it inside the lock (patch
below - untested, but trivial).

He also pointed out that we could fairly easily fix the tlb stuff by 
taking the tlb lock before taking a cpu offline. Which still doesn't
make me desperately comfortable ... but then he's smarter than me ;-)
To me it comes down to ... do we want to lock the damned thing, or fix
all the callers to be really, really careful? 

diff -purN -X /home/mbligh/.diff.exclude virgin/arch/i386/kernel/smp.c smp_call_function/arch/i386/kernel/smp.c
--- virgin/arch/i386/kernel/smp.c	2004-03-11 14:33:36.000000000 -0800
+++ smp_call_function/arch/i386/kernel/smp.c	2004-03-30 17:43:34.000000000 -0800
@@ -514,10 +514,7 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	if (!cpus)
-		return 0;
+	int cpus;
 
 	data.func = func;
 	data.info = info;
@@ -527,6 +524,10 @@ int smp_call_function (void (*func) (voi
 		atomic_set(&data.finished, 0);
 
 	spin_lock(&call_lock);
+	cpus = num_online_cpus()-1;
+	if (!cpus)
+		return 0;
+
 	call_data = &data;
 	mb();
 	

