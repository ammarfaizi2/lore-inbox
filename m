Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbTABTDN>; Thu, 2 Jan 2003 14:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTABTDM>; Thu, 2 Jan 2003 14:03:12 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:13283 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S266359AbTABTDL>;
	Thu, 2 Jan 2003 14:03:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Fix CPU bitmask truncation (1 of 2)
Date: Thu, 2 Jan 2003 12:11:40 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301021211.40155.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The consensus is that this fixes a real bug in 2.4.20.  The
rationale is (in Linus' words):

>         1 << cpu

> is clearly an int, and as such will have undefined behaviour for cpu >
> bits-of-int.

> The promotion to unsigned long happens _after_ the shift has already
> happened as an int, since nothing in the sub-expression needs promotion
> per se.

I'll send the initialization patch separately, in case you don't
want that one.

diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Dec 16 11:58:42 2002
+++ b/kernel/sched.c	Mon Dec 16 11:58:42 2002
@@ -116,7 +116,7 @@
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
 #define can_schedule(p,cpu) \
-	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+	((p)->cpus_runnable & (p)->cpus_allowed & (1UL << cpu))
 
 #else
 
@@ -359,7 +359,7 @@
 	if (task_on_runqueue(p))
 		goto out;
 	add_to_runqueue(p);
-	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
+	if (!synchronous || !(p->cpus_allowed & (1UL << smp_processor_id())))
 		reschedule_idle(p);
 	success = 1;
 out:



