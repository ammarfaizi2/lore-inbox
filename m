Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUKSEjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUKSEjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKSEjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:39:10 -0500
Received: from peabody.ximian.com ([130.57.169.10]:10921 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261252AbUKSEiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:38:07 -0500
Subject: [patch] no need to recalculate rq
From: Robert Love <rml@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1100837616.4051.17.camel@localhost.localdomain>
References: <1100837616.4051.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 23:39:06 -0500
Message-Id: <1100839146.20622.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 23:13 -0500, Steven Rostedt wrote:

> On lines 3325 and 3330 with the calls to deactivate_task and
> __activate_task respectively. The runqueue is locked at 3316. Can the
> runqueue returned by task_rq change in this setup? If not, what is the
> need for the call to task_rq. Can't rq just be used instead, or is this
> just some extra paranoia? 

I don't see any reason that it is needed.  The runqueue is locked and
the task is not going anywhere.  There is no need to recalculate the
runqueue.

Patch below uses the cached runqueue, rq, saving a few instructions.

	Robert Love


no need to call task_rq in setscheduler; just use rq

Signed-Off-By: Robert Love <rml@novell.com>

 kernel/sched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6.10-rc2/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.10-rc2/kernel/sched.c	2004-11-18 23:32:54.189696376 -0500
+++ linux/kernel/sched.c	2004-11-18 23:35:54.309314032 -0500
@@ -3144,12 +3144,12 @@
 	}
 	array = p->array;
 	if (array)
-		deactivate_task(p, task_rq(p));
+		deactivate_task(p, rq);
 	retval = 0;
 	oldprio = p->prio;
 	__setscheduler(p, policy, lp.sched_priority);
 	if (array) {
-		__activate_task(p, task_rq(p));
+		__activate_task(p, rq);
 		/*
 		 * Reschedule if we are currently running on this runqueue and
 		 * our priority decreased, or if we are not currently running on


