Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966331AbWKNUdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966331AbWKNUdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966332AbWKNUdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55733 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966331AbWKNUdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:20 -0500
Date: Tue, 14 Nov 2006 12:33:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061114203306.12761.54020.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/8] Remove staggering of load balancing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove load staggering.

Timer interrupts already are staggered. We do not need an additional
layer of time staggering for short load balancing actions that take a
reasonably small portion of the time slice.

For load balancing on large sched_domains we will add a serialization
later that avoids concurrent load balance operations and thus has
the same effect as load staggering.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-10 22:47:56.305271903 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-10 22:48:09.002647332 -0600
@@ -2844,16 +2844,10 @@ static void active_load_balance(struct r
  * Balancing parameters are set up in arch_init_sched_domains.
  */
 
-/* Don't have all balancing operations going off at once: */
-static inline unsigned long cpu_offset(int cpu)
-{
-	return jiffies + cpu * HZ / NR_CPUS;
-}
-
 static void
 rebalance_tick(int this_cpu, struct rq *this_rq, enum idle_type idle)
 {
-	unsigned long this_load, interval, j = cpu_offset(this_cpu);
+	unsigned long this_load, interval;
 	struct sched_domain *sd;
 	int i, scale;
 
@@ -2888,7 +2882,7 @@ rebalance_tick(int this_cpu, struct rq *
 		if (unlikely(!interval))
 			interval = 1;
 
-		if (j - sd->last_balance >= interval) {
+		if (jiffies - sd->last_balance >= interval) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
