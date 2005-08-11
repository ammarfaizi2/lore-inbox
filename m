Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVHKDK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVHKDK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 23:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVHKDK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 23:10:57 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:18042 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932238AbVHKDK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 23:10:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer;
  b=tMA05Il6kMEYFkViboNmjdVsK75CM+y1YRFFZNeoSs+ozgph6sm2hxLwD0hORwjFWIvfUqVpxPUsUkldh5FXog+fClOPnofp9rbS64RjE0zHo1y5T4XrhtQTiRuMRsI1XZiTzlaWTgidcMd3Y/S2A1YOF5D1WHHNUlP3O59/3Tk=  ;
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch]
	don't kick ALB in the presence of pinned task)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
In-Reply-To: <20050809190352.D1938@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com>
	 <20050802092717.GB20978@elte.hu>
	 <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au>
	 <20050809190352.D1938@unix-os.sc.intel.com>
Content-Type: multipart/mixed; boundary="=-BojmvTexWfp6nvxmaW1I"
Date: Thu, 11 Aug 2005 13:09:10 +1000
Message-Id: <1123729750.5188.13.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BojmvTexWfp6nvxmaW1I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-08-09 at 19:03 -0700, Siddha, Suresh B wrote:
> On Wed, Aug 10, 2005 at 10:27:44AM +1000, Nick Piggin wrote:
> > Yeah this makes sense. Thanks.
> > 
> > I think we'll only need your first line change to fix this, though.
> > 
> > Your second change will break situations where a single group is very
> > loaded, but it is in a domain with lots of cpu_power
> > (total_load <= total_power).
> 
> In that case, we will move the excess load from that group to some
> other group which is below its capacity. Instead of bringing everyone
> to avg load, we make sure that everyone is at or below its cpu_power.
> This will minimize the movements between the nodes.
> 
> For example, Let us assume sched groups node-0, node-1 each has 
> 4*SCHED_LOAD_SCALE as its cpu_power.
> 
> And with 6 tasks on node-0 and 0 on node-1, current load balance 
> will move 3 tasks from node-0 to 1. But with my patch, it will move only 
> 2 tasks to node-1. Is this what you are referring to as breakage?
> 

No, I had thought it was possible to get into a situation where
one queue could be very loaded but not have anyone to pull from
it if total_load <= total_pwr.

I see that shouldn't happen though.

I have a variation on the 2nd part of your patch which I think
I would prefer. IMO it kind of generalises the current imbalance
calculation to handle this case rather than introducing a new
special case.

Untested as yet, but I'll queue it to send to Andrew after it
gets some testing - unless you have any objections that is.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.



--=-BojmvTexWfp6nvxmaW1I
Content-Disposition: attachment; filename=sched-fix-fbg.patch
Content-Type: text/x-patch; name=sched-fix-fbg.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Don't pull tasks from a group if that would cause the
group's total load to drop below its total cpu_power
(ie. cause the group to start going idle).

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-08-11 12:10:10.199651212 +1000
+++ linux-2.6/kernel/sched.c	2005-08-11 12:53:15.361971195 +1000
@@ -1886,6 +1886,7 @@
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
+	unsigned long max_pull;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
@@ -1932,7 +1933,7 @@
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load)
+	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
@@ -1952,8 +1953,12 @@
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
+
+	/* Don't want to pull so many tasks that a group would go idle */
+	max_pull = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+	
 	/* How much load to actually move to equalise the imbalance */
-	*imbalance = min((max_load - avg_load) * busiest->cpu_power,
+	*imbalance = min(max_pull * busiest->cpu_power,
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 

--=-BojmvTexWfp6nvxmaW1I--

Send instant messages to your online friends http://au.messenger.yahoo.com 
