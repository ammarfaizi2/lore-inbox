Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWCXLYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWCXLYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWCXLYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:24:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:36578 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751661AbWCXLYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:24:10 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143199295.7741.29.camel@homer>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
	 <1143198964.7741.23.camel@homer>  <1143199295.7741.29.camel@homer>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:24:52 +0100
Message-Id: <1143199493.7741.32.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 5/6

This patch tightens timeslice accounting the rest of the way, such that
a task which has received more than it's slice due to missing with the
timer interrupt will have the excess deducted from their next slice.

signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/kernel/sched.c-4.throttle	2006-03-24 09:36:08.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-24 09:40:33.000000000 +0100
@@ -2924,13 +2924,28 @@
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


