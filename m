Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKBXGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKBXGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKBW6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:58:14 -0500
Received: from fmr03.intel.com ([143.183.121.5]:53684 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262365AbUKBW4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:56:30 -0500
Message-Id: <200411022251.iA2Mpgq18929@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Theurer'" <habanero@us.ibm.com>, <kernel@kolivas.org>,
       <ricklind@us.ibm.com>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] sched: aggressive idle balance
Date: Tue, 2 Nov 2004 14:55:14 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTBGQamiIpc72EvSHmRPO0laO+SkAAEL6sAAAEsHTA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote on Tuesday, November 02, 2004 12:17 PM
>
> This patch allows more aggressive idle balances, reducing idle time in
> scenarios where should not be any, where nr_running > nr_cpus.  We have seen
> this in a couple of online transaction workloads.  Three areas are targeted:
>
> 1) In try_to_wake_up(), wake_idle() is called to move the task to a sibling if
> the task->cpu is busy and the sibling is idle.  This has been expanded to any
> idle cpu, but the closest idle cpu is picked first by starting with cpu->sd,
> then going up the domains as necessary.

Chen, Kenneth W wrote on Tuesday, November 02, 2004 2:35 PM
> It occurs to me that half of the patch only applicable to HT, like the change
> in wake_idle().  And also, do you really want to put that functionality in
> wake_idle()?  Seems defeating the original intention of that function, which
> only tries to wake up sibling cpu as far as how I understand the code.
>
> My setup is 4-way SMP, no HT (4-way itanium2 processor), sorry, I won't be able
> to tell you how this portion of the change affect online transaction workload.


Move that functionality into try_to_wake_up directly.  I'm going to try this
on my setup.


--- kernel/sched.c.orig	2004-11-02 13:35:33.000000000 -0800
+++ kernel/sched.c	2004-11-02 14:51:08.000000000 -0800
@@ -1059,13 +1059,21 @@ static int try_to_wake_up(task_t * p, un
 				schedstat_inc(sd, ttwu_wake_balance);
 				goto out_set_cpu;
 			}
+		} else if (sd->flags & SD_WAKE_IDLE) {
+			cpus_and(tmp, sd->span, cpu_online_map);
+			cpus_and(tmp, tmp, p->cpus_allowed);
+			for_each_cpu_mask(i, tmp) {
+				if (idle_cpu(i)) {
+					new_cpu = i;
+					goto out_set_cpu;
+				}
+			}
 		}
 	}

 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
 	schedstat_inc(rq, ttwu_attempts);
-	new_cpu = wake_idle(new_cpu, p);
 	if (new_cpu != cpu && cpu_isset(new_cpu, p->cpus_allowed)) {
 		schedstat_inc(rq, ttwu_moved);
 		set_task_cpu(p, new_cpu);


