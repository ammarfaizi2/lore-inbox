Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWDAJ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWDAJ0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWDAJ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:26:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:45230 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750887AbWDAJ0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:26:13 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 8/9] sched throttle tree extract - maximize
	timeslice accounting
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143883385.7617.66.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
	 <1143882731.7617.55.camel@homer>  <1143883385.7617.66.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 11:26:47 +0200
Message-Id: <1143883607.7617.71.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch maximizes time slice accounting.  A task which receives too
much CPU time due to missing the timer interrupt will have the excess
deducted from it's next slice.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-7.implement_throttle	2006-03-24 09:36:08.000000000 +0100
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-24 09:40:33.000000000 +0100
@@ -2966,13 +2966,28 @@ static void refresh_timeslice(task_t *p)
 	unsigned int slice = last_slice(p);
 	unsigned int slice_avg, cpu, idle;
 	long run_time = -1 * p->slice_time_ns;
+	long slice_time_ns = task_timeslice_ns(p);
 	int w = MAX_BONUS, delta, bonus;
 
 	/*
-	 * Update time_slice.
+	 * Update time_slice.  Account for unused fragment,
+	 * or excess time received due to missed tick.
 	 */
-	p->slice_time_ns = task_timeslice_ns(p);
-	p->time_slice = task_timeslice(p);
+	p->slice_time_ns += slice_time_ns;
+	/*
+	 * Not common, but this does happen on SMP systems.
+	 * Timeslice theft of this magnitude has never been
+	 * observed in the wild, so assume that this is BS,
+	 * and give the poor task it's full slice.  Theory:
+	 * mostly idle task migrates between CPUs numerous
+	 * times during it's slice, timestamp rounding leads
+	 * to wildly inaccurate calculation.  Rounding has
+	 * maximum effect on those who stretch their slice,
+	 * but is also fairly meaningless, so ignore it.
+	 */
+	if (unlikely(p->slice_time_ns < NS_TICK))
+		p->slice_time_ns = slice_time_ns;
+	p->time_slice = NS_TO_JIFFIES(p->slice_time_ns);
 	set_last_slice(p, p->time_slice);
 
 	/*


