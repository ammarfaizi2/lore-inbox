Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVBXH3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVBXH3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVBXH1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:27:02 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:62897 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVBXHZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:25:39 -0500
Subject: [PATCH 9/13] less affine wakups
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229867.5177.84.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
	 <1109229760.5177.81.camel@npiggin-nld.site>
	 <1109229867.5177.84.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-0lnK3lY4CAVZIIRv887H"
Date: Thu, 24 Feb 2005 18:25:35 +1100
Message-Id: <1109229935.5177.85.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0lnK3lY4CAVZIIRv887H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

9/13


--=-0lnK3lY4CAVZIIRv887H
Content-Disposition: attachment; filename=sched-tweak-wakeaffine.patch
Content-Type: text/x-patch; name=sched-tweak-wakeaffine.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Do less affine wakeups. We're trying to reduce dbt2-pgsql idle time
regressions here... make sure we don't don't move tasks the wrong way
in an imbalance condition. Also, remove the cache coldness requirement
from the calculation - this seems to induce sharp cutoff points where
behaviour will suddenly change on some workloads if the load creeps
slightly over or under some point. It is good for periodic balancing
because in that case have otherwise have no other context to determine
what task to move.

But also make a minor tweak to "wake balancing" - the imbalance
tolerance is now set at half the domain's imbalance, so we get the
opportunity to do wake balancing before the more random periodic
rebalancing gets preformed.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:06.808010844 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:37.734579478 +1100
@@ -1014,38 +1014,45 @@
 		int idx = this_sd->wake_idx;
 		unsigned int imbalance;
 
+		imbalance = 100 + (this_sd->imbalance_pct - 100) / 2;
+
 		load = source_load(cpu, idx);
 		this_load = target_load(this_cpu, idx);
 
-		/*
-		 * If sync wakeup then subtract the (maximum possible) effect of
-		 * the currently running task from the load of the current CPU:
-		 */
-		if (sync)
-			this_load -= SCHED_LOAD_SCALE;
-
-		 /* Don't pull the task off an idle CPU to a busy one */
-		if (load < SCHED_LOAD_SCALE/2 && this_load > SCHED_LOAD_SCALE/2)
-			goto out_set_cpu;
-
 		new_cpu = this_cpu; /* Wake to this CPU if we can */
 
-		if ((this_sd->flags & SD_WAKE_AFFINE) &&
-			!task_hot(p, rq->timestamp_last_tick, this_sd)) {
-			/*
-			 * This domain has SD_WAKE_AFFINE and p is cache cold
-			 * in this domain.
-			 */
-			schedstat_inc(this_sd, ttwu_move_affine);
-			goto out_set_cpu;
-		} else if ((this_sd->flags & SD_WAKE_BALANCE) &&
-				imbalance*this_load <= 100*load) {
+		if (this_sd->flags & SD_WAKE_AFFINE) {
+			unsigned long tl = this_load;
 			/*
-			 * This domain has SD_WAKE_BALANCE and there is
-			 * an imbalance.
+			 * If sync wakeup then subtract the (maximum possible)
+			 * effect of the currently running task from the load
+			 * of the current CPU:
 			 */
-			schedstat_inc(this_sd, ttwu_move_balance);
-			goto out_set_cpu;
+			if (sync)
+				tl -= SCHED_LOAD_SCALE;
+
+			if ((tl <= load &&
+				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
+				100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
+				/*
+				 * This domain has SD_WAKE_AFFINE and
+				 * p is cache cold in this domain, and
+				 * there is no bad imbalance.
+				 */
+				schedstat_inc(this_sd, ttwu_move_affine);
+				goto out_set_cpu;
+			}
+		}
+
+		/*
+		 * Start passive balancing when half the imbalance_pct
+		 * limit is reached.
+		 */
+		if (this_sd->flags & SD_WAKE_BALANCE) {
+			if (imbalance*this_load <= 100*load) {
+				schedstat_inc(this_sd, ttwu_move_balance);
+				goto out_set_cpu;
+			}
 		}
 	}
 

--=-0lnK3lY4CAVZIIRv887H--


