Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVBXHie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVBXHie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVBXHiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:38:20 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:52087 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVBXH1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:27:18 -0500
Subject: [PATCH 10/13] remove aggressive idle balancing
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229935.5177.85.camel@npiggin-nld.site>
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
Content-Type: multipart/mixed; boundary="=-98A8TN0NTlotziajdQEK"
Date: Thu, 24 Feb 2005 18:27:11 +1100
Message-Id: <1109230031.5177.87.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-98A8TN0NTlotziajdQEK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

10/13

--=-98A8TN0NTlotziajdQEK
Content-Disposition: attachment; filename=sched-noaggressive-idle.patch
Content-Type: text/x-patch; name=sched-noaggressive-idle.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the very aggressive idle stuff that has recently gone into
2.6 - it is going against the direction we are trying to go. Hopefully
we can regain performance through other methods.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/include/asm-i386/topology.h
===================================================================
--- linux-2.6.orig/include/asm-i386/topology.h	2005-02-24 17:39:06.805011214 +1100
+++ linux-2.6/include/asm-i386/topology.h	2005-02-24 17:39:07.320947536 +1100
@@ -85,7 +85,6 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_NEWIDLE	\
-				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
Index: linux-2.6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/topology.h	2005-02-24 17:39:06.805011214 +1100
+++ linux-2.6/include/asm-x86_64/topology.h	2005-02-24 17:43:37.503607973 +1100
@@ -58,7 +58,6 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
-				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
Index: linux-2.6/include/linux/topology.h
===================================================================
--- linux-2.6.orig/include/linux/topology.h	2005-02-24 17:39:06.806011090 +1100
+++ linux-2.6/include/linux/topology.h	2005-02-24 17:43:37.503607973 +1100
@@ -124,7 +124,6 @@
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
-				| SD_WAKE_IDLE		\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:07.057979992 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:37.504607850 +1100
@@ -412,22 +412,6 @@
 	return rq;
 }
 
-#ifdef CONFIG_SCHED_SMT
-static int cpu_and_siblings_are_idle(int cpu)
-{
-	int sib;
-	for_each_cpu_mask(sib, cpu_sibling_map[cpu]) {
-		if (idle_cpu(sib))
-			continue;
-		return 0;
-	}
-
-	return 1;
-}
-#else
-#define cpu_and_siblings_are_idle(A) idle_cpu(A)
-#endif
-
 #ifdef CONFIG_SCHEDSTATS
 /*
  * Called when a process is dequeued from the active array and given
@@ -1650,16 +1634,15 @@
 
 	/*
 	 * Aggressive migration if:
-	 * 1) the [whole] cpu is idle, or
+	 * 1) task is cache cold, or
 	 * 2) too many balance attempts have failed.
 	 */
 
-	if (cpu_and_siblings_are_idle(this_cpu) || \
-			sd->nr_balance_failed > sd->cache_nice_tries)
+	if (sd->nr_balance_failed > sd->cache_nice_tries)
 		return 1;
 
 	if (task_hot(p, rq->timestamp_last_tick, sd))
-			return 0;
+		return 0;
 	return 1;
 }
 
@@ -2131,7 +2114,7 @@
 				if (cpu_isset(cpu, visited_cpus))
 					continue;
 				cpu_set(cpu, visited_cpus);
-				if (!cpu_and_siblings_are_idle(cpu) || cpu == busiest_cpu)
+				if (cpu == busiest_cpu)
 					continue;
 
 				target_rq = cpu_rq(cpu);

--=-98A8TN0NTlotziajdQEK--

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
