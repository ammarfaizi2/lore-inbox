Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUHETUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUHETUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUHETSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:18:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18599 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267873AbUHETQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:16:16 -0400
Message-Id: <200408051915.i75JFN616956@owlet.beaverton.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error 
In-reply-to: Your message of "Thu, 05 Aug 2004 20:20:39 +0200."
             <20040805182039.GN2746@fs.tum.de> 
Date: Thu, 05 Aug 2004 12:15:23 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > This looks like it could happen if you compile without CONFIG_SMP ...
    > which admittedly I have not tried since the sched-domain code was
    > introduced.  Adrian, was this the situation in your case?
    
    Yes.

Ok.  Please try this patch (applied to rc3-mm1).

Rick

diff -rup linux-2.6.8-rc3-mm1/Documentation/sched-stats.txt linux-2.6.8-rc3-mm1-ss/Documentation/sched-stats.txt
--- linux-2.6.8-rc3-mm1/Documentation/sched-stats.txt	Thu Aug  5 11:05:40 2004
+++ linux-2.6.8-rc3-mm1-ss/Documentation/sched-stats.txt	Thu Aug  5 11:37:53 2004
@@ -1,6 +1,8 @@
 Version 9 of schedstats introduces support for sched_domains, which
 hit the mainline kernel in 2.6.7.  Some counters make more sense to be
-per-runqueue; other to be per-domain.
+per-runqueue; other to be per-domain.  Note that domains (and their associated
+information) will only be pertinent and available on machines utilizing
+CONFIG_SMP.
 
 In version 9 of schedstat, there is at least one level of domain
 statistics for each cpu listed, and there may well be more than one
@@ -83,7 +85,9 @@ The last six are statistics dealing with
 
 Domain statistics
 -----------------
-One of these is produced per domain for each cpu described.
+One of these is produced per domain for each cpu described. (Note that if
+CONFIG_SMP is not defined, *no* domains are utilized and these lines
+will not appear in the output.)
 
 domain<N> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
 
diff -rup linux-2.6.8-rc3-mm1/kernel/sched.c linux-2.6.8-rc3-mm1-ss/kernel/sched.c
--- linux-2.6.8-rc3-mm1/kernel/sched.c	Thu Aug  5 11:06:23 2004
+++ linux-2.6.8-rc3-mm1-ss/kernel/sched.c	Thu Aug  5 12:13:51 2004
@@ -342,10 +342,11 @@ static int show_schedstat(struct seq_fil
 	seq_printf(seq, "timestamp %lu\n", jiffies);
 	for_each_online_cpu (cpu) {
 
-		int dcnt = 0;
-
 		runqueue_t *rq = cpu_rq(cpu);
+#ifdef CONFIG_SMP
+		int dcnt = 0;
 		struct sched_domain *sd;
+#endif
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
@@ -368,6 +369,7 @@ static int show_schedstat(struct seq_fil
 
 		seq_printf(seq, "\n");
 
+#ifdef CONFIG_SMP
 		/* domain-specific stats */
 		for_each_domain(cpu, sd) {
 			char mask_str[NR_CPUS];
@@ -387,6 +389,7 @@ static int show_schedstat(struct seq_fil
 			    sd->sbe_pushed, sd->sbe_attempts,
 			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
 		}
+#endif
 	}
 	return 0;
 }
