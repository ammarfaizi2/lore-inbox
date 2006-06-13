Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWFMAZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWFMAZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWFMAZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:25:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:37513 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932681AbWFMAZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:25:10 -0400
Subject: [RFC][PATCH] Avoid race w/ posix-cpu-timer and exiting tasks
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 17:25:08 -0700
Message-Id: <1150158308.10006.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,
	We've occasionally come across OOPSes in posix-cpu-timer thread (as
well as tripping over the BUG_ON(tsk->exit_state there) where it appears
the task we're processing exits out on us while we're using it. 

Thus this fix tries to avoid running the posix-cpu-timers on a task that
is exiting.

I'm not sure if it is the proper fix, so I wanted some extra eyes to
look it over. We're testing it to see if we can still trigger any of the
OOPSes (the BUG_ON is removed, so that won't catch us anymore), but if
you have any thoughts I'd be interested in them.

thanks
-john

--- 2.6-rt/kernel/posix-cpu-timers.c	2006-06-11 15:38:58.000000000 -0500
+++ devrt/kernel/posix-cpu-timers.c	2006-06-12 10:52:20.000000000 -0500
@@ -1290,12 +1290,15 @@
 
 #undef	UNEXPIRED
 
-	BUG_ON(tsk->exit_state);
-
 	/*
 	 * Double-check with locks held.
 	 */
 	read_lock(&tasklist_lock);
+	/* Make sure the task doesn't exit under us. */
+	if(unlikely(tsk->exit_state)) {
+		read_unlock(&tasklist_lock);
+		return;
+	}
 	spin_lock(&tsk->sighand->siglock);
 
 	/*



