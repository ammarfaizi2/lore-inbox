Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWGCGNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWGCGNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWGCGNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:13:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61080 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750748AbWGCGNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:13:13 -0400
Date: Mon, 3 Jul 2006 08:08:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060703060832.GA15940@elte.hu>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org> <20060703060320.GA15782@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703060320.GA15782@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Did you work out which divide is getting the div-by-zero?  I started 
> > at it a bit and wasn't sure - am getting wildly different code 
> > generation over here.
> 
> my bet is on sched-group-cpu-power-setup-cleanup.patch.

in particular, we dont seem to initialize ->cpu_power properly. Martin, 
does the patch below solve your crash?

	Ingo

-------------->
Subject: sched: group cpu power setup cleanup, fix
From: Ingo Molnar <mingo@elte.hu>

- fix missing initialization of ->cpu_power
- clean up the cleanup

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/sched.h |    2 +-
 kernel/sched.c        |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -636,7 +636,7 @@ enum idle_type
 	((sched_mc_power_savings || sched_smt_power_savings) ?	\
 					SD_POWERSAVINGS_BALANCE : 0)
 
-#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
+#define test_sd_flag(sd, flag)	((sd && (sd->flags & flag)) ? 1 : 0)
 
 
 struct sched_group {
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1292,7 +1292,7 @@ static int sched_balance_self(int cpu, i
 		cpu = new_cpu;
 nextlevel:
 		sd = sd->child;
-		if (sd && sd->flags & flag)
+		if (test_sd_flag(sd, flag))
 			goto nextlevel;
 		/* while loop will break here if sd == NULL */
 	}
@@ -6224,6 +6224,7 @@ static int cpu_to_allnodes_group(int cpu
 {
 	return cpu_to_node(cpu);
 }
+
 static void init_numa_sched_groups_power(struct sched_group *group_head)
 {
 	struct sched_group *sg = group_head;
@@ -6314,8 +6315,12 @@ static void init_sched_groups_power(int 
 	struct sched_domain *child;
 	struct sched_group *group;
 
-	if (!sd || !sd->groups || (cpu != first_cpu(sd->groups->cpumask)))
+	WARN_ON(!sd || !sd->groups);
+
+	if (cpu != first_cpu(sd->groups->cpumask)) {
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
 		return;
+	}
 
 	child = sd->child;
 
