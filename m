Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUH3MTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUH3MTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUH3MTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:19:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56776 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267745AbUH3MTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:19:34 -0400
Subject: [PATCH] cpu hotplug fixes for dependent_sleeper and
	wake_sleeping_dependent
From: Nathan Lynch <nathanl@austin.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1093858876.11274.50.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 Aug 2004 04:41:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

I've reported this issue a couple of times and I think I've finally
tracked it down, though I don't know whether I've come up with the best
fix.

To recap, offlining a cpu with current bk results in the "Aiee, killing
interrupt handler!" panic from do_exit().  This seems to be triggered
only with CONFIG_PREEMPT and CONFIG_SCHED_SMT both enabled.  I believe
the problem is that when do_stop() calls schedule(), dependent_sleeper()
drops the "offline" cpu's rq->lock and never reacquires it.

The following seems to work (tested on ppc64).  Is there a better way?


Nathan

---

Return early from dependent_sleeper and wake_sleeping_dependent if
this_cpu is offline to avoid releasing this_cpu's rq->lock.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN kernel/sched.c~sched-smt-cpu-hotplug-fix kernel/sched.c
--- 2.6-bk/kernel/sched.c~sched-smt-cpu-hotplug-fix	2004-08-30 04:22:49.000000000 -0500
+++ 2.6-bk-nathanl/kernel/sched.c	2004-08-30 04:23:28.000000000 -0500
@@ -2502,7 +2502,7 @@ static inline void wake_sleeping_depende
 	cpumask_t sibling_map;
 	int i;
 
-	if (!(sd->flags & SD_SHARE_CPUPOWER))
+	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))
 		return;
 
 	/*
@@ -2549,7 +2549,7 @@ static inline int dependent_sleeper(int 
 	int ret = 0, i;
 	task_t *p;
 
-	if (!(sd->flags & SD_SHARE_CPUPOWER))
+	if (!(sd->flags & SD_SHARE_CPUPOWER) || cpu_is_offline(this_cpu))
 		return 0;
 
 	/*

_


