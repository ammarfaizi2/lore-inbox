Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVBPFa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVBPFa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVBPFa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:30:57 -0500
Received: from fsmlabs.com ([168.103.115.128]:64174 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261991AbVBPFat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:30:49 -0500
Date: Tue, 15 Feb 2005 22:31:24 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: [PATCH] Run softirqs on proper processor on offline
In-Reply-To: <20050216020628.GA25596@otto>
Message-ID: <Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
 <20050214215948.GA22304@otto> <20050215070217.GB13568@elte.hu>
 <20050216020628.GA25596@otto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that we only offline the processor when it's safe and never run 
softirqs in another processor's ksoftirqd context. This also gets rid of 
the warnings in ksoftirqd on cpu offline.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.11-rc3-mm2/kernel/softirq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc3-mm2/kernel/softirq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 softirq.c
--- linux-2.6.11-rc3-mm2/kernel/softirq.c	11 Feb 2005 05:14:57 -0000	1.1.1.1
+++ linux-2.6.11-rc3-mm2/kernel/softirq.c	12 Feb 2005 18:24:54 -0000
@@ -355,8 +355,12 @@ static int ksoftirqd(void * __bind_cpu)
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
-		if (!local_softirq_pending())
+		preempt_disable();
+		if (!local_softirq_pending()) {
+			preempt_enable_no_resched();
 			schedule();
+			preempt_disable();
+		}
 
 		__set_current_state(TASK_RUNNING);
 
@@ -364,14 +368,14 @@ static int ksoftirqd(void * __bind_cpu)
 			/* Preempt disable stops cpu going offline.
 			   If already offline, we'll be on wrong CPU:
 			   don't process */
-			preempt_disable();
 			if (cpu_is_offline((long)__bind_cpu))
 				goto wait_to_die;
 			do_softirq();
-			preempt_enable();
+			preempt_enable_no_resched();
 			cond_resched();
+			preempt_disable();
 		}
-
+		preempt_enable();
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
