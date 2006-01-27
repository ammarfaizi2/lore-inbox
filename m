Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWA0Eit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWA0Eit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWA0Eit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:38:49 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29847 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932352AbWA0Eis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:38:48 -0500
Subject: Re: [RT] possible bug in trace_start_sched_wakeup
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1138327022.7814.8.camel@localhost.localdomain>
References: <1138327022.7814.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 23:38:38 -0500
Message-Id: <1138336718.7814.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I'm assuming that this was a bug, so I'm patching it.  I made it now
test to see if the new process is realtime and higher priority than the
current tracing process to continue.

I'll analyze it more tomorrow (after a few hours of sleep) to see if
this makes sense, as well as hope that you have a comment or two saying
it does, or if it doesn't, to enlighten me to why.

Thanks,

-- Steve


Index: linux-2.6.15-rt15/kernel/latency.c
===================================================================
--- linux-2.6.15-rt15.orig/kernel/latency.c	2006-01-25 17:02:26.000000000 -0500
+++ linux-2.6.15-rt15/kernel/latency.c	2006-01-26 21:03:30.000000000 -0500
@@ -1908,7 +1908,7 @@
 		return;
 
 	spin_lock(&sch.trace_lock);
-	if (sch.task && (sch.task->prio >= p->prio))
+	if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
 		goto out_unlock;
 
 	/*
@@ -1974,7 +1974,7 @@
 	} else {
 		if (sch.task)
 			trace_special_pid(sch.task->pid, sch.task->prio, p->prio);
-		if (sch.task && (sch.task->prio >= p->prio))
+		if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
 			sch.task = NULL;
 		spin_unlock(&sch.trace_lock);
 	}


