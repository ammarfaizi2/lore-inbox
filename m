Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWCYGSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWCYGSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWCYGSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:18:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:8599 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751084AbWCYGSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:18:03 -0500
X-Authenticated: #14349625
Subject: [2.6.16-mm1 patch] ignore timewarps
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1143263172.7930.15.camel@homer>
References: <1143198208.7741.8.camel@homer>
	 <200603242237.38100.kernel@kolivas.org>  <44248DE7.80001@bigpond.net.au>
	 <1143263172.7930.15.camel@homer>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 07:18:50 +0100
Message-Id: <1143267530.9804.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The patch below is a correction to patch 1 of my throttling tree series.

The only thing that really matters is that timewarps are ignored,
whatever the cause.  This patch does that, and only that.

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/kernel/sched.c.org	2006-03-23 15:01:41.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:02:25.000000000 +0100
@@ -805,6 +805,15 @@
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


