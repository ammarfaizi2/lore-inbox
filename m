Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWAaTnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWAaTnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWAaTnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:43:42 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51449 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751411AbWAaTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:43:42 -0500
Subject: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 14:43:29 -0500
Message-Id: <1138736609.7088.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this in the -rt kernel.  While running "hackbench 20" I hit
latencies of over 1.5 ms.  That is huge!  This latency was created by
the move_tasks function in sched.c to rebalance the queues over CPUS.  

There currently isn't any check in this function to see if it should
stop, thus a large number of tasks can drive the latency high.

With the below patch, (tested on -rt with latency tracing), the latency
caused by hackbench disappeared below my notice threshold (100 usecs).

I'm not convinced that this bail out is in the right location, but it
worked where it is.  Comments are welcome.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rc1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc1.orig/kernel/sched.c	2006-01-19 15:58:52.000000000 -0500
+++ linux-2.6.16-rc1/kernel/sched.c	2006-01-31 14:27:17.000000000 -0500
@@ -1983,6 +1983,10 @@
 
 	curr = curr->prev;
 
+	/* bail if someone else woke up */
+	if (need_resched())
+		goto out;
+
 	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;


