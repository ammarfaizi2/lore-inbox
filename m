Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWDAInq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWDAInq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWDAInq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:43:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751502AbWDAInq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:43:46 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 3/9] sched throttle tree extract - remove IO
	priority barrier
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143880683.7617.16.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:44:18 +0200
Message-Id: <1143881058.7617.24.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the barrier preventing IO bound tasks from competing
against highly interactive tasks for cpu time.  This barrier has been
demonstrated to cause starvation of IO bound tasks, and in testing, I've
found it to now be unnecessary in any case.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-2.fix_uninterruptible	2006-03-31 13:34:04.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-04-01 08:57:40.000000000 +0200
@@ -880,21 +880,6 @@ static int recalc_task_prio(task_t *p, u
 					p->sleep_avg = ceiling;
 		} else {
 			/*
-			 * Tasks waking from uninterruptible sleep are
-			 * limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
-			 */
-			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
-			}
-
-			/*
 			 * This code gives a bonus to interactive tasks.
 			 *
 			 * The boost works by updating the 'average sleep time'


