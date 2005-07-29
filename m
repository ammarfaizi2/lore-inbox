Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVG2OOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVG2OOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVG2OOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:14:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9953 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262583AbVG2OOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:14:15 -0400
Date: Fri, 29 Jul 2005 16:13:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [sched, patch] better wake-balancing
Message-ID: <20050729141311.GA4154@elte.hu>
References: <42E98DEA.9090606@yahoo.com.au> <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <20050729114822.GA25249@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729114822.GA25249@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another approach would be the patch below, to do wakeup-balancing only 
if the wakeup CPU or the task CPU is idle.

I've measured half-loaded tbench and unless total wakeup-balancing 
removal it does not degrade with this patch applied, while fully loaded 
tbench and other workloads clearly improve.

Ken, could you give this one a try? (It's against the current scheduler 
queue in -mm, but also applies fine to current Linus trees.)

	Ingo

---

do wakeup-balancing only if the wakeup-CPU or the task-CPU is idle.

this prevents excessive wakeup-balancing while the system is highly
loaded, but helps spread out the workload on partly idle systems.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: linux-sched-curr/kernel/sched.c
===================================================================
--- linux-sched-curr.orig/kernel/sched.c
+++ linux-sched-curr/kernel/sched.c
@@ -1252,7 +1252,13 @@ static int try_to_wake_up(task_t *p, uns
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
+	/*
+	 * If neither this CPU, nor the previous CPU the task was
+	 * running on is idle then skip wakeup-balancing:
+	 */
 	new_cpu = cpu;
+	if (!idle_cpu(this_cpu) && !idle_cpu(cpu))
+		goto out_set_cpu;
 
 	schedstat_inc(rq, ttwu_cnt);
 	if (cpu == this_cpu) {
