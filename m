Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUHIT6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUHIT6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHIT6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:58:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8382 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267165AbUHITz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:55:27 -0400
Message-Id: <200408091951.i79JpbR20316@owlet.beaverton.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Adrian Bunk <bunk@fs.tum.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error 
In-reply-to: Your message of "Mon, 09 Aug 2004 15:46:19 EDT."
             <4117D48B.9000500@tmr.com> 
Date: Mon, 09 Aug 2004 12:51:18 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Solved it for me, although running SMP on a old slow PentiumII feels a 
    tad odd. Other than that the system is running very well, I have to try 
    a response test and see how it feels then.

Oh I agree, the right patch is not to run SMP, but it *is* a workaround. This
patch against rc3-mm1 should let you run it UP:

Signed-off-by: Rick Lindsley <ricklind@us.ibm.com>

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
