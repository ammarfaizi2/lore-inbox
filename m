Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWHPEZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWHPEZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWHPEZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:25:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5832 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750713AbWHPEZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:25:14 -0400
Date: Tue, 15 Aug 2006 21:24:55 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060815212455.c9fe1e34.pj@sgi.com>
In-Reply-To: <20060815175525.A2333@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the cleanup patch resend, Suresh.

> Resending the new patch. Before patch had some issues for Andy and hence
> dropped.
> 
> Andrew, Please add this to -mm. This patch is against 2.6.18-rc4.
> There might be a small conflict while applying to -mm. Let me know if you
> want a patch on top of -mm.
> 
> thanks,
> suresh
> 
> --

I found the above patch commentary frustrating to read, as it told me
very little, and teased me with reference to details that are left
unsaid.

Can we work on this patch's opening text a bit more?

Take a look at Andrew's "The perfect patch"
  http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

The above quoted material doesn't follow the recommendations
in the (4) Changelog section of Andrew's recommendations, especially
(4a), (4b), (4c) and (4d).

The above quoted material is stuff that will mean little to someone
looking at this changelog in the source history a year from now.  Heck,
it means little to me, now, and I supposedly have been trying to track
your sched domain cleanup work more closely than most people.

Just now I ran a grep over my lkml email archives for the last few
months, and apparently the "issue for Andy" refers to a thread that
includes a message dated "Mon, 03 Jul 2006" from Andy Whitcroft under
the generic Subject of "Re: 2.6.17-mm5", noticing a problem with a
panic on NUMA-Q due to a zero cpu_power.  Anyone besides Andy and
Suresh who knew that without poking around old lkml messages has way
too good a memory ;).


> Cleanup the sched group cpu_power setup code, by introducing
> child field and new domain flag in sched_domain.

I guess you meant the above two lines to be the actual Changelog
text, to be read by all who examine this change to Linux in the
source control history hereafteer.

But as explained in Andrew's recommendations, the recommended
changelog text should come first (after a possible "From:" line)
in the patch email, followed by "---" a line with just three
dashes, followed by the transient text that will mean little
in the future.

That is, you had:


  transient text

  --

  permanent changelog text (just the above 2 lines)

  Signed-off-by: ...

  diff ...


Andrew's recommendations would instead have:


  permanent changelog text (more than 2 lines, I hope,
  in this case)

  Signed-off-by: ...

  ---

  transient text

  diff ...


> + * cpu_power indicates the computing power of each sched group. This is
> + * used for distributing the load between different sched groups
> + * in a sched domain.

Thanks for explaining what cpu_power means.


> ... Typically cpu_power for all the groups in a
> + * sched domain will be same unless there are asymmetries in the topology.

Does the above mean that all groups in a domain have the same
number of CPUs?  Or perhaps my newbie ignorance of what 'group'
means is showing through, and my question makes no sense - sorry
if so.


+static void init_sched_groups_power(int cpu, struct sched_domain *sd)
+{
+	...
+
+	if (cpu != first_cpu(sd->groups->cpumask))
+		return;

I am a tad surprised that the above always works.  Is it ever possible
that init_sched_groups_power() is never called for the first cpu in a
group, and that hence the cpu_power of that group is not uninitialized?

If there is some explanation as to how this is not possible, and it is
guaranteed that init_sched_groups_power() is always called for the
first cpu in a group, then that might be worthy of a comment.

Is it possible to get the partition1 or partition2 in the calls:

    int partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
    {
	    ...
	    if (!cpus_empty(*partition1))
		    err = build_sched_domains(partition1);
	    if (!err && !cpus_empty(*partition2))
		    err = build_sched_domains(partition2);

so some group had some CPUs, but not the first CPU of groups->cpumask
in one of these partitions?


+	/*
+	 * For perf policy, if the groups in child domain share resources
+	 * (for example cores sharing some portions of the cache hierarchy
+	 * or SMT), then set this domain groups cpu_power such that each group
+	 * can handle only one task, when there are other idle groups in the
+	 * same sched domain.
+	 */

I am clearly still missing proper understanding here.  How is it that
the cpu_power of a group can be set so that it "can handle only one task?"


> +	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
> +		       (child->flags & SD_SHARE_CPUPOWER ||
> +			child->flags & SD_SHARE_PKG_RESOURCES))) {

Would this be equivalent to the following, which saves a few
machine instructions and a conditional jump as well:

	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
		       (child->flags &
				(SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES)
			)) {

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
