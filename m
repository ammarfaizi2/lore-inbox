Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVHIXIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVHIXIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVHIXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:08:34 -0400
Received: from fmr24.intel.com ([143.183.121.16]:41415 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750962AbVHIXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:08:33 -0400
Date: Tue, 9 Aug 2005 16:08:13 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com,
       dvhltc@us.ibm.com, mbligh@mbligh.org
Subject: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050809160813.B1938@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050802092717.GB20978@elte.hu>; from mingo@elte.hu on Tue, Aug 02, 2005 at 11:27:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 11:27:17AM +0200, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > Jack Steiner brought this issue at my OLS talk.
> > 
> > Take a scenario where two tasks are pinned to two HT threads in a physical
> > package. Idle packages in the system will keep kicking migration_thread
> > on the busy package with out any success.
> > 
> > We will run into similar scenarios in the presence of CMP/NUMA.
> > 
> > Patch appended.
> > 
> > Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> nice catch!
> 
> fine for -mm, but i dont think we need this fix in 2.6.13, as the effect 
> of the bug is an extra context-switch per 'CPU goes idle' event, in this 
> very specific (and arguably broken) task binding scenario.

No. This is not a broken scenario. Its possible in NUMA case aswell.

For example, lets take two nodes each having two physical packages. And
assume that there are two tasks and both of them are on (may or may n't be
pinned) two packages in node-0

Todays load balance will detect that there is an imbalance between the
two nodes and will try to distribute the load between the nodes.

In general, we should allow the load of a group to grow upto its cpu_power
and stop preventing these costly movements.

Appended patch will fix this. I have done limited testing of this patch.
Guys with big NUMA boxes, please give this patch a try. 

--

When the system is lightly loaded, don't bother about the average load.
In this case, allow the load of a sched group to grow upto its cpu_power.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.13-rc5/kernel/sched.c~	2005-08-09 13:30:19.067072328 -0700
+++ linux-2.6.13-rc5/kernel/sched.c	2005-08-09 14:39:08.363323880 -0700
@@ -1932,9 +1932,23 @@
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load)
+	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
 		goto out_balanced;
 
+	/* When the system is lightly loaded, don't bother about
+	 * the average load. Just make sure all the sched groups
+	 * are with in their capacities (i.e., load <= group's cpu_power)
+	 */
+	if (total_load <= total_pwr) {
+		if (this_load >= SCHED_LOAD_SCALE)
+			goto out_balanced;
+
+		*imbalance = min((max_load - SCHED_LOAD_SCALE) * busiest->cpu_power,
+				 (SCHED_LOAD_SCALE - this_load) * this->cpu_power) / SCHED_LOAD_SCALE;
+
+		goto fix_imbalance;
+	}
+
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
 
 	if (this_load >= avg_load ||
@@ -1957,6 +1971,7 @@
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
+fix_imbalance:
 	if (*imbalance < SCHED_LOAD_SCALE) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
