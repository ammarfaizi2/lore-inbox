Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWKGTRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWKGTRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKGTRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:17:44 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50387 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750724AbWKGTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:17:43 -0500
Date: Tue, 7 Nov 2006 11:17:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061107095049.B3262@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611071113390.4582@schroedinger.engr.sgi.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
 <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
 <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
 <20061107095049.B3262@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets are scheduled on the same cpu that triggered the tasklet. They 
are just moved to other processors if the processor goes down. So that 
aspect is fine. We just need a tasklet struct per cpu.



User a per cpu tasklet to schedule rebalancing

Turns out that tasklets have a flag that only allows one instance to run
on all processors. So we need a tasklet structure for each processor.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-06 13:58:38.000000000 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-07 13:05:56.236343144 -0600
@@ -2918,7 +2918,8 @@ static void rebalance_domains(unsigned l
 	this_rq->next_balance = next_balance;
 }
 
-DECLARE_TASKLET(rebalance, &rebalance_domains, 0L);
+static DEFINE_PER_CPU(struct tasklet_struct, rebalance) =
+		{ NULL, 0, ATOMIC_INIT(0), rebalance_domains, 0L };
 #else
 /*
  * on UP we do not need to balance between CPUs:
@@ -3171,7 +3172,7 @@ void scheduler_tick(void)
 #ifdef CONFIG_SMP
 	update_load(rq);
 	if (time_after_eq(jiffies, rq->next_balance))
-		tasklet_schedule(&rebalance);
+		tasklet_schedule(&__get_cpu_var(rebalance));
 #endif
 }
 

