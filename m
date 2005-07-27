Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVG0WKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVG0WKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVG0WKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:10:07 -0400
Received: from fmr23.intel.com ([143.183.121.15]:38060 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261183AbVG0WHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:07:47 -0400
Message-Id: <200507272207.j6RM7fg18695@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: Add prefetch switch stack hook in scheduler function
Date: Wed, 27 Jul 2005 15:07:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWS95rNpDOL0jx6R1CksMWeS6FV5Q==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to propose adding a prefetch switch stack hook in
the scheduler function.  For architecture like ia64, the switch
stack structure is fairly large (currently 528 bytes).  For context
switch intensive application, we found that significant amount of
cache misses occurs in switch_to() function.  The following patch
adds a hook in the schedule() function to prefetch switch stack
structure as soon as 'next' task is determined.  This allows maximum
overlap in prefetch cache lines for that structure.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.12/include/linux/sched.h.orig	2005-07-27 14:43:49.321986290 -0700
+++ linux-2.6.12/include/linux/sched.h	2005-07-27 14:44:03.390345492 -0700
@@ -622,6 +622,11 @@ extern int groups_search(struct group_in
 #define GROUP_AT(gi, i) \
     ((gi)->blocks[(i)/NGROUPS_PER_BLOCK][(i)%NGROUPS_PER_BLOCK])
 
+#ifdef ARCH_HAS_PREFETCH_SWITCH_STACK
+extern void prefetch_switch_stack(struct task_struct*);
+#else
+#define prefetch_switch_stack(task)	do { } while (0)
+#endif
 
 struct audit_context;		/* See audit.c */
 struct mempolicy;
--- linux-2.6.12/kernel/sched.c.orig	2005-07-27 14:43:49.391322226 -0700
+++ linux-2.6.12/kernel/sched.c	2005-07-27 14:44:03.394251742 -0700
@@ -3044,6 +3044,7 @@ switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
 	prefetch(next);
+	prefetch_switch_stack(next);
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 

