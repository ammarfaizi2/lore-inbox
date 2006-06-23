Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932979AbWFWJ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979AbWFWJ26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932967AbWFWJ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:28:56 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:21404 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932960AbWFWJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:28:55 -0400
Date: Fri, 23 Jun 2006 05:28:45 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH -mm] bug if setscheduler is called from interrupt context.
In-Reply-To: <20060622190825.7da4eeae.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0606230522360.2272@gandalf.stny.rr.com>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
 <20060622082812.607857000@cruncher.tec.linutronix.de>
 <Pine.LNX.4.58.0606220959490.15236@gandalf.stny.rr.com>
 <20060622190825.7da4eeae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner is adding the call to a rtmutex function in setscheduler.
This call grabs a spin_lock that is not always protected by interrupts
disabled.  So this means that setscheduler cant be called from interrupt
context.

To prevent this from happening in the future, this patch adds a
BUG_ON(in_interrupt()) in that function.  (Thanks to akpm <aka. Andrew
Morton> for this suggestion).

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-mm1.orig/kernel/sched.c	2006-06-23 05:19:41.000000000 -0400
+++ linux-2.6.17-mm1/kernel/sched.c	2006-06-23 05:20:44.000000000 -0400
@@ -4034,6 +4034,8 @@ int sched_setscheduler(struct task_struc
 	unsigned long flags;
 	runqueue_t *rq;

+	/* may grab non-irq protected spin_locks */
+	BUG_ON(in_interrupt());
 recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0)

