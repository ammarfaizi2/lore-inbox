Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVBXHef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVBXHef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVBXHbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:31:02 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:61874 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261964AbVBXH2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:28:54 -0500
Subject: [PATCH 12/13] schedstats additions for sched-balance-fork
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109230087.5177.89.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
	 <1109229760.5177.81.camel@npiggin-nld.site>
	 <1109229867.5177.84.camel@npiggin-nld.site>
	 <1109229935.5177.85.camel@npiggin-nld.site>
	 <1109230031.5177.87.camel@npiggin-nld.site>
	 <1109230087.5177.89.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-ikgb4fR+cqqHf+wuev1A"
Date: Thu, 24 Feb 2005 18:28:45 +1100
Message-Id: <1109230125.5177.91.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ikgb4fR+cqqHf+wuev1A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

12/13


--=-ikgb4fR+cqqHf+wuev1A
Content-Disposition: attachment; filename=sched-stat-sbf.patch
Content-Type: text/x-patch; name=sched-stat-sbf.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add SCHEDSTAT statistics for sched-balance-fork.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-02-24 17:39:07.616911007 +1100
+++ linux-2.6/include/linux/sched.h	2005-02-24 17:39:07.819885956 +1100
@@ -480,10 +480,16 @@
 	unsigned long alb_failed;
 	unsigned long alb_pushed;
 
-	/* sched_balance_exec() stats */
-	unsigned long sbe_attempts;
+	/* SD_BALANCE_EXEC stats */
+	unsigned long sbe_cnt;
+	unsigned long sbe_balanced;
 	unsigned long sbe_pushed;
 
+	/* SD_BALANCE_FORK stats */
+	unsigned long sbf_cnt;
+	unsigned long sbf_balanced;
+	unsigned long sbf_pushed;
+
 	/* try_to_wake_up() stats */
 	unsigned long ttwu_wake_remote;
 	unsigned long ttwu_move_affine;
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:07.618910761 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:36.887683960 +1100
@@ -307,7 +307,7 @@
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 11
+#define SCHEDSTAT_VERSION 12
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -354,9 +354,10 @@
 				    sd->lb_nobusyq[itype],
 				    sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu\n",
+			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
-			    sd->sbe_pushed, sd->sbe_attempts,
+			    sd->sbe_cnt, sd->sbe_balanced, sd->sbe_pushed,
+			    sd->sbf_cnt, sd->sbf_balanced, sd->sbf_pushed,
 			    sd->ttwu_wake_remote, sd->ttwu_move_affine, sd->ttwu_move_balance);
 		}
 #endif
@@ -1262,24 +1263,34 @@
 			sd = tmp;
 
 	if (sd) {
+		int new_cpu;
 		struct sched_group *group;
 
+		schedstat_inc(sd, sbf_cnt);
 		cpu = task_cpu(p);
 		group = find_idlest_group(sd, p, cpu);
-		if (group) {
-			int new_cpu;
-			new_cpu = find_idlest_cpu(group, cpu);
-			if (new_cpu != -1 && new_cpu != cpu &&
-					cpu_isset(new_cpu, p->cpus_allowed)) {
-				set_task_cpu(p, new_cpu);
-				task_rq_unlock(rq, &flags);
-				rq = task_rq_lock(p, &flags);
-				cpu = task_cpu(p);
-			}
+		if (!group) {
+			schedstat_inc(sd, sbf_balanced);
+			goto no_forkbalance;
+		}
+
+		new_cpu = find_idlest_cpu(group, cpu);
+		if (new_cpu == -1 || new_cpu == cpu) {
+			schedstat_inc(sd, sbf_balanced);
+			goto no_forkbalance;
+		}
+
+		if (cpu_isset(new_cpu, p->cpus_allowed)) {
+			schedstat_inc(sd, sbf_pushed);
+			set_task_cpu(p, new_cpu);
+			task_rq_unlock(rq, &flags);
+			rq = task_rq_lock(p, &flags);
+			cpu = task_cpu(p);
 		}
 	}
-#endif
 
+no_forkbalance:
+#endif
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
@@ -1616,30 +1627,28 @@
 	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
 
-	/* Prefer the current CPU if there's only this task running */
-	if (this_rq()->nr_running <= 1)
-		goto out;
-
 	for_each_domain(this_cpu, tmp)
 		if (tmp->flags & SD_BALANCE_EXEC)
 			sd = tmp;
 
 	if (sd) {
 		struct sched_group *group;
-		schedstat_inc(sd, sbe_attempts);
+		schedstat_inc(sd, sbe_cnt);
 		group = find_idlest_group(sd, current, this_cpu);
-		if (!group)
+		if (!group) {
+			schedstat_inc(sd, sbe_balanced);
 			goto out;
+		}
 		new_cpu = find_idlest_cpu(group, this_cpu);
-		if (new_cpu == -1)
+		if (new_cpu == -1 || new_cpu == this_cpu) {
+			schedstat_inc(sd, sbe_balanced);
 			goto out;
-
-		if (new_cpu != this_cpu) {
-			schedstat_inc(sd, sbe_pushed);
-			put_cpu();
-			sched_migrate_task(current, new_cpu);
-			return;
 		}
+
+		schedstat_inc(sd, sbe_pushed);
+		put_cpu();
+		sched_migrate_task(current, new_cpu);
+		return;
 	}
 out:
 	put_cpu();

--=-ikgb4fR+cqqHf+wuev1A--


