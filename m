Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWCXLHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWCXLHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWCXLHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:07:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:3506 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751487AbWCXLHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:07:01 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143198208.7741.8.camel@homer>
References: <1143198208.7741.8.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:07:39 +0100
Message-Id: <1143198459.7741.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 2/6

This patch just fixes a bug waiting for a place to happen.  If anyone
ever decides to use TASK_NONINTERACTIVE along with TASK_UNINTERRUPTIBLE,
bad things will happen.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/kernel/sched.c-1.timewarp	2006-03-23 15:04:42.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:07:08.000000000 +0100
@@ -1418,7 +1418,7 @@
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+	if (old_state & TASK_UNINTERRUPTIBLE) {
 		rq->nr_uninterruptible--;
 		/*
 		 * Tasks on involuntary sleep don't earn
@@ -3125,7 +3125,7 @@
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
-			if (prev->state == TASK_UNINTERRUPTIBLE)
+			if (prev->state & TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
 		}


