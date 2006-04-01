Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWDAIco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWDAIco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWDAIco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:32:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:26319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751461AbWDAIcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:32:43 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 1/9] sched throttle tree extract - ignore
	invalid timestamps
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143880124.7617.5.camel@homer>
References: <1143880124.7617.5.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:33:17 +0200
Message-Id: <1143880397.7617.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an SMP system, a task can awaken on a different cpu from where it
went to sleep.  Timestamp inaccuracies can result from the attempt to
compensate for clock drift.  Ignore resulting timewarps.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-0.fix_rt	2006-03-23 15:01:41.000000000 +0100
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-23 15:02:25.000000000 +0100
@@ -845,6 +845,15 @@ static int recalc_task_prio(task_t *p, u
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
+	/*
+	 * On SMP systems, a task can go to sleep on one CPU
+	 * and wake up on another.  When this happens, now can
+	 * end up being less than p->timestamp for short sleeps.
+	 * Ignore these, they're insignificant.
+	 */
+	if (unlikely(now < p->timestamp))
+		__sleep_time = 0;
+
 	if (batch_task(p))
 		sleep_time = 0;
 	else {


