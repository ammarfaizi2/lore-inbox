Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWHSPIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWHSPIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWHSPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:08:17 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:28318 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751131AbWHSPIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:08:16 -0400
Date: Sat, 19 Aug 2006 23:32:15 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] introduce is_rt_policy() helper
Message-ID: <20060819193215.GA8420@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imho, makes the code a bit easier to read.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/include/linux/sched.h~3_is_rt	2006-08-19 17:50:56.000000000 +0400
+++ 2.6.18-rc4/include/linux/sched.h	2006-08-19 21:41:36.000000000 +0400
@@ -504,8 +504,8 @@ struct signal_struct {
 #define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
 #define rt_task(p)		rt_prio((p)->prio)
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
-#define has_rt_policy(p) \
-	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
+#define is_rt_policy(p)		((p) != SCHED_NORMAL && (p) != SCHED_BATCH)
+#define has_rt_policy(p)	unlikely(is_rt_policy((p)->policy))
 
 /*
  * Some day this will be a full-fledged user tracking system..
--- 2.6.18-rc4/kernel/sched.c~3_is_rt	2006-08-19 21:14:19.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-19 22:03:26.000000000 +0400
@@ -4072,8 +4072,7 @@ recheck:
 	    (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
 	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
-	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH)
-					!= (param->sched_priority == 0))
+	if (is_rt_policy(policy) != (param->sched_priority != 0))
 		return -EINVAL;
 
 	/*
@@ -4097,7 +4096,7 @@ recheck:
 				!rlim_rtprio)
 			return -EPERM;
 		/* can't increase priority */
-		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH) &&
+		if (is_rt_policy(policy) &&
 		    param->sched_priority > p->rt_priority &&
 		    param->sched_priority > rlim_rtprio)
 			return -EPERM;

