Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVHKSOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVHKSOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVHKSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:14:24 -0400
Received: from fmr23.intel.com ([143.183.121.15]:48609 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932341AbVHKSOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:14:23 -0400
Date: Thu, 11 Aug 2005 11:14:11 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050811111411.A581@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au> <20050809190352.D1938@unix-os.sc.intel.com> <1123729750.5188.13.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1123729750.5188.13.camel@npiggin-nld.site>; from nickpiggin@yahoo.com.au on Thu, Aug 11, 2005 at 01:09:10PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 01:09:10PM +1000, Nick Piggin wrote:
> I have a variation on the 2nd part of your patch which I think
> I would prefer. IMO it kind of generalises the current imbalance
> calculation to handle this case rather than introducing a new
> special case.

There is a difference between our changes. 

When the system is lightly loaded, my patch minimizes the number of 
groups picking up that load. This will help in power savings for 
example in the context of CMP. There are more changes required
(user or kernel) for complete power savings, but this is a direction 
towards that.

How about this patch?
--

Don't pull tasks from a group if that would cause the
group's total load to drop below its total cpu_power
(ie. cause the group to start going idle).

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Nick Piggin <npiggin@suse.de>

--- linux-2.6.13-rc5/kernel/sched.c~	2005-08-09 13:30:19.067072328 -0700
+++ linux-2.6.13-rc5/kernel/sched.c	2005-08-11 09:29:55.937128384 -0700
@@ -1886,6 +1886,7 @@
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
+	unsigned long excess_load, max_pull;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
@@ -1932,7 +1933,7 @@
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load)
+	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
@@ -1952,9 +1953,19 @@
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
+
+	/* Don't want to pull so many tasks that a group would go idle */
+	excess_load = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+
+	if (this_load < SCHED_LOAD_SCALE)
+		/* pull as many tasks so that this group is fully utilized */
+		max_pull = max(avg_load - this_load, SCHED_LOAD_SCALE - this_load);
+	else 
+		max_pull = avg_load - this_load;
+	
 	/* How much load to actually move to equalise the imbalance */
-	*imbalance = min((max_load - avg_load) * busiest->cpu_power,
-				(avg_load - this_load) * this->cpu_power)
+	*imbalance = min(excess_load * busiest->cpu_power,
+				max_pull * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
 	if (*imbalance < SCHED_LOAD_SCALE) {
