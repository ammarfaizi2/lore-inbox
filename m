Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVLMVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVLMVFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVLMVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:05:41 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:16100 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030227AbVLMVFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:05:40 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 16:05:27 -0500
Message-Id: <1134507927.18921.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas and Ingo,

I found a bug in 2.6.15-rc5-rt1 that was due to a race in the hrtimers
code.  This bug is most likely in the vanilla hrtimers code as well.

I added a HRTIMER_RUNNING state because there's a moment in the
run_hrtimer_queues that turns interrupts on and releases the base lock.
In this time, a remove_hrtimer can be called while the state is still
HRTIMER_PENDING_CALLBACK, but it has been removed off the list.  The
remove_hrtimer will then try to remove this again.

Since I couldn't think of which state to use, I created the
HRTIMER_RUNNING, and used that instead.

I have a program (a simple jitter test) that, with out the patch,
reliably crashes the 2.6.15-rc5-rt1 on a slow UP machine.  With the
patch, it runs solidly, so I know this is the reason for the crash.

-- Steve

Index: linux-2.6.15-rc5-rt1/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5-rt1.orig/kernel/hrtimer.c	2005-12-13 15:51:52.000000000 -0500
+++ linux-2.6.15-rc5-rt1/kernel/hrtimer.c	2005-12-13 15:53:36.000000000 -0500
@@ -846,6 +846,7 @@
 		data = timer->data;
 		set_curr_timer(base, timer);
 		list_del(&timer->list);
+		timer->state = HRTIMER_RUNNING;
 		spin_unlock_irq(&base->lock);
 
 		/*
@@ -904,6 +905,7 @@
 		data = timer->data;
 		set_curr_timer(base, timer);
 		__remove_hrtimer(timer, base);
+		timer->state = HRTIMER_RUNNING;
 		spin_unlock_irq(&base->lock);
 
 		/*
Index: linux-2.6.15-rc5-rt1/include/linux/hrtimer.h
===================================================================
--- linux-2.6.15-rc5-rt1.orig/include/linux/hrtimer.h	2005-12-13 15:51:40.000000000 -0500
+++ linux-2.6.15-rc5-rt1/include/linux/hrtimer.h	2005-12-13 15:55:21.000000000 -0500
@@ -41,6 +41,7 @@
 enum hrtimer_state {
 	HRTIMER_INACTIVE,		/* Timer is inactive */
 	HRTIMER_EXPIRED,		/* Timer is expired */
+	HRTIMER_RUNNING,		/* Timer is currently running */
 	HRTIMER_PENDING,		/* Timer is pending */
 	HRTIMER_PENDING_CALLBACK,	/* Timer is expired, callback pending */
 };


