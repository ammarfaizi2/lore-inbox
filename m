Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVDEXry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVDEXry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVDEXry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:47:54 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:35948 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261991AbVDEXqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:46:17 -0400
Message-ID: <42532346.5050308@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:46:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [patch 3/5] sched: multilevel sbe and sbf
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au>
In-Reply-To: <42532317.5000901@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030306030302050607080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306030302050607080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/5

--------------030306030302050607080707
Content-Type: text/plain;
 name="sched-multilevel-sbe-sbf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-multilevel-sbe-sbf.patch"

The fundamental problem that Suresh has with balance on exec and fork
is that it only tries to balance the top level domain with the flag
set.

This was worked around by removing degenerate domains, but is still a
problem if people want to start using more complex sched-domains, especially
multilevel NUMA that ia64 is already using.

This patch makes balance on fork and exec try balancing over not just the
top most domain with the flag set, but all the way down the domain tree.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-05 16:38:53.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-05 18:39:07.000000000 +1000
@@ -1320,21 +1320,24 @@ void fastcall wake_up_new_task(task_t * 
 			sd = tmp;
 
 	if (sd) {
+		cpumask_t span;
 		int new_cpu;
 		struct sched_group *group;
 
+again:
 		schedstat_inc(sd, sbf_cnt);
+		span = sd->span;
 		cpu = task_cpu(p);
 		group = find_idlest_group(sd, p, cpu);
 		if (!group) {
 			schedstat_inc(sd, sbf_balanced);
-			goto no_forkbalance;
+			goto nextlevel;
 		}
 
 		new_cpu = find_idlest_cpu(group, cpu);
 		if (new_cpu == -1 || new_cpu == cpu) {
 			schedstat_inc(sd, sbf_balanced);
-			goto no_forkbalance;
+			goto nextlevel;
 		}
 
 		if (cpu_isset(new_cpu, p->cpus_allowed)) {
@@ -1344,9 +1347,21 @@ void fastcall wake_up_new_task(task_t * 
 			rq = task_rq_lock(p, &flags);
 			cpu = task_cpu(p);
 		}
+
+		/* Now try balancing at a lower domain level */
+nextlevel:
+		sd = NULL;
+		for_each_domain(cpu, tmp) {
+			if (cpus_subset(span, tmp->span))
+				break;
+			if (tmp->flags & SD_BALANCE_FORK)
+				sd = tmp;
+		}
+
+		if (sd)
+			goto again;
 	}
 
-no_forkbalance:
 #endif
 	/*
 	 * We decrease the sleep average of forking parents
@@ -1712,25 +1727,41 @@ void sched_exec(void)
 			sd = tmp;
 
 	if (sd) {
+		cpumask_t span;
 		struct sched_group *group;
+again:
 		schedstat_inc(sd, sbe_cnt);
+		span = sd->span;
 		group = find_idlest_group(sd, current, this_cpu);
 		if (!group) {
 			schedstat_inc(sd, sbe_balanced);
-			goto out;
+			goto nextlevel;
 		}
 		new_cpu = find_idlest_cpu(group, this_cpu);
 		if (new_cpu == -1 || new_cpu == this_cpu) {
 			schedstat_inc(sd, sbe_balanced);
-			goto out;
+			goto nextlevel;
 		}
 
 		schedstat_inc(sd, sbe_pushed);
 		put_cpu();
 		sched_migrate_task(current, new_cpu);
-		return;
+		
+		/* Now try balancing at a lower domain level */
+		this_cpu = get_cpu();
+nextlevel:
+		sd = NULL;
+		for_each_domain(this_cpu, tmp) {
+			if (cpus_subset(span, tmp->span))
+				break;
+			if (tmp->flags & SD_BALANCE_EXEC)
+				sd = tmp;
+		}
+
+		if (sd)
+			goto again;
 	}
-out:
+
 	put_cpu();
 }
 

--------------030306030302050607080707--

