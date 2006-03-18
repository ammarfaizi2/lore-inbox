Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWCREkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCREkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 23:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCREkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 23:40:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:33221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751239AbWCREkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 23:40:00 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] smp fix for recalc_task_prio()
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1142656637.8262.9.camel@homer>
References: <1142656637.8262.9.camel@homer>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 05:41:40 +0100
Message-Id: <1142656901.8262.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 05:37 +0100, Mike Galbraith wrote:
> Greetings,
> 
> The patchlet below fixes an smp buglet where a task goes to sleep on one
> cpu and wakes up on another, causing recalc_task_prio() to be called
> with now < p->timestamp.
> 
> If this isn't 2.6.16 material, and I can respin against mm.

Sigh.  Forgot sob line.

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-rc6/kernel/sched.c.org	2006-03-17 14:48:35.000000000 +0100
+++ linux-2.6.16-rc6/kernel/sched.c	2006-03-18 05:22:21.000000000 +0100
@@ -685,6 +685,16 @@
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
+	/*
+	 * On SMP systems, a task can go to sleep on one CPU and
+	 * wake up on another.  When this happens, the timestamp
+	 * is rounded to the nearest tick, which can lead to now
+	 * being less than p->timestamp for short sleeps. Ignore
+	 * these, they're insignificant.
+	 */
+	if (unlikely(now < p->timestamp))
+		__sleep_time = 0ULL;
+
 	if (unlikely(p->policy == SCHED_BATCH))
 		sleep_time = 0;
 	else {


