Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWBPAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWBPAji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBPAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:39:37 -0500
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:27203 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751294AbWBPAjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:39:37 -0500
Message-ID: <43F3C9C6.5080606@bigpond.net.au>
Date: Thu, 16 Feb 2006 11:39:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, npiggin@suse.de,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: [PATCH] Fix smpnice high priority task hopping problem
Content-Type: multipart/mixed;
 boundary="------------010201090002030004050900"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 16 Feb 2006 00:39:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201090002030004050900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Suresh B. Siddha has reported:

"on a lightly loaded system, this will result in higher priority job 
hopping around from one processor to another processor.. This is because 
of the code in find_busiest_group() which assumes that SCHED_LOAD_SCALE 
represents a unit process load and with nice_to_bias calculations this 
is no longer true (in the presence of non nice-0 tasks)"

Analysis of this problem as revealed that the smpnice code results in 
the weighted load being larger than 1 and this triggers the active load 
balancing code.  However, in active_load_balance(), the migration thread 
fails to take into account itself when deciding if there are any tasks 
to be migrated from its run queue. I.e. even if there is only one other 
task on the run queue other than itself it will still migrate that other 
task.

The attached patch fixes that anomaly.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------010201090002030004050900
Content-Type: text/plain;
 name="fix-smpnice-task-hopping-problem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-smpnice-task-hopping-problem"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-16 10:51:52.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-16 11:02:45.000000000 +1100
@@ -2406,7 +2406,7 @@ static void active_load_balance(runqueue
 	runqueue_t *target_rq;
 	int target_cpu = busiest_rq->push_cpu;
 
-	if (busiest_rq->nr_running <= 1)
+	if (busiest_rq->nr_running <= 2)
 		/* no task to move */
 		return;
 

--------------010201090002030004050900--
