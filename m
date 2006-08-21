Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWHUUm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWHUUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHUUm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:42:59 -0400
Received: from rune.pobox.com ([208.210.124.79]:54465 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751044AbWHUUm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:42:59 -0400
Date: Mon, 21 Aug 2006 15:42:51 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Anton Blanchard <anton@samba.org>
Cc: Paul Jackson <pj@sgi.com>, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] cpuset code prevents binding tasks to new cpus
Message-ID: <20060821204251.GB9828@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821192133.GC8499@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> Hi,
> 
> > Your query confuses me, about 4 different ways ...
> > 
> > 1) What does sched_setaffinity have to do with this part of cpusets?
> 
> long sched_setaffinity(pid_t pid, cpumask_t new_mask)
> {
> ...
> 	cpus_allowed = cpuset_cpus_allowed(p);
> 	cpus_and(new_mask, new_mask, cpus_allowed);
> 	retval = set_cpus_allowed(p, new_mask);
> 
> If cpuset_cpus_allowed doesnt return the current online mask and we want
> to schedule on a cpu that has been added since boot it looks like we
> will fail.
> 
> > 2) What did you mean by "statically assigned"?  At boot, whatever cpus
> >    and memory nodes are online are copied to the top_cpuset's settings.
> >    As Simon suggests, it would be up to the hotplug/hotunplug folks to
> >    update these top_cpuset settings, as cpus and nodes come and go.
> 
> Its up to the cpusets code to register a hotplug notifier to update the
> top_cpuset maps.

I think a notifier is overkill, the top_cpuset mask should just be a
copy of cpu_possible_map, which doesn't change after boot so we don't
have to worry about keeping it in sync.  cpuset_cpus_allowed already
guarantees online cpus in the returned mask.


> > 3) I don't understand what you thought was suspicious here.
> > 4) I don't understand what you expected to see instead here.
> 
> If the top level cpuset pointed to cpu_online_map instead of a boot time
> copy we wouldnt need any hotplug gunk in the cpusets code.
> 
> Maybe the notifier is the right way to go, but it seems strange to
> create two copies of cpu_online_map (with the associated possibiliy of
> the two getting out of sync).

Agreed.

Here's a patch:

We have this code in sched_setaffinity:

	cpus_allowed = cpuset_cpus_allowed(p);
	cpus_and(new_mask, new_mask, cpus_allowed);
	retval = set_cpus_allowed(p, new_mask);

In the default case (the task belongs to the default toplevel cpuset),
cpuset_cpus_allowed always returns a copy of whatever cpu_online_map
was at boot.  When a new cpu is added to the system, the user is
unable to bind tasks to the new cpu -- in the code above we wind up
passing an empty cpumask to set_cpus_allowed and get -EINVAL.

Since cpuset_cpus_allowed already ensures that the cpumask it returns
reflects only online cpus, setting the default cpuset's cpus_allowed
mask to cpu_possible_map (which never changes) ensures correct
behavior.


Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
+++ cpuhp-sched_setaffinity/kernel/cpuset.c
@@ -2041,7 +2041,7 @@ out:
 
 void __init cpuset_init_smp(void)
 {
-	top_cpuset.cpus_allowed = cpu_online_map;
+	top_cpuset.cpus_allowed = cpu_possible_map;
 	top_cpuset.mems_allowed = node_online_map;
 }
 

