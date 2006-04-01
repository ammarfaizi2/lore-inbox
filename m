Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWDAIha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWDAIha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWDAIha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:37:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:28888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751497AbWDAIh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:37:29 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 2/9] sched throttle tree extract - fix
	potential task uninterruptible bug
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143880397.7617.10.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:38:03 +0200
Message-Id: <1143880683.7617.16.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug waiting for a place to happen should anyone ever
combine TASK_NONINTERACTIVE with TASK_UNINTERRUPTIBLE.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-1.timewarp	2006-03-23 15:04:42.000000000 +0100
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-23 15:07:08.000000000 +0100
@@ -1457,7 +1457,7 @@ out_set_cpu:
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks on involuntary sleep don't earn
@@ -3167,7 +3167,7 @@ need_resched_nonpreemptible:
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}


