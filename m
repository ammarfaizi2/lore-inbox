Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293244AbSCOU4a>; Fri, 15 Mar 2002 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSCOU4W>; Fri, 15 Mar 2002 15:56:22 -0500
Received: from users.ccur.com ([208.248.32.211]:25704 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293238AbSCOU4K>;
	Fri, 15 Mar 2002 15:56:10 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203152054.UAA27581@rudolph.ccur.com>
Subject: [PATCH] 2.4.18 scheduler bugs
To: marcelo@conectiva.com.br
Date: Fri, 15 Mar 2002 15:54:39 -0500 (EST)
Cc: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo et all,
 The following fixes some rather straightforward bugs in the old
(pre-O(1)) scheduler that I discovered while exercising it with
custom instrumentation written in.  These may be worth fixing, given
that it may be a long time before the new O(1) scheduler officially
shows up in a production tree.

Joe

- ksoftirqd() - change daemon nice(2) value from 19 to -19.

    SoftIRQ servicing was less important than the most lowly of batch
    tasks.  This patch makes it more important than all but the realtime
    tasks.

- reschedule_idle() - smp_send_reschedule when setting idle's need_resched

    Idle tasks nowdays don't spin waiting for need->resched to change,
    they sleep on a halt insn instead.  Therefore any setting of
    need->resched on an idle task running on a remote CPU should be
    accompanied by a cross-processor interrupt.

diff -Nur linux-2.4.18-base/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.18-base/kernel/sched.c	Fri Dec 21 12:42:04 2001
+++ linux/kernel/sched.c	Fri Mar 15 14:57:21 2002
@@ -225,16 +225,9 @@
 	if (can_schedule(p, best_cpu)) {
 		tsk = idle_task(best_cpu);
 		if (cpu_curr(best_cpu) == tsk) {
-			int need_resched;
 send_now_idle:
-			/*
-			 * If need_resched == -1 then we can skip sending
-			 * the IPI altogether, tsk->need_resched is
-			 * actively watched by the idle thread.
-			 */
-			need_resched = tsk->need_resched;
 			tsk->need_resched = 1;
-			if ((best_cpu != this_cpu) && !need_resched)
+			if (best_cpu != this_cpu)
 				smp_send_reschedule(best_cpu);
 			return;
 		}
diff -Nur linux-2.4.18-base/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.4.18-base/kernel/softirq.c	Wed Oct 31 13:26:02 2001
+++ linux/kernel/softirq.c	Fri Mar 15 14:55:38 2002
@@ -365,7 +365,7 @@
 	int cpu = cpu_logical_map(bind_cpu);
 
 	daemonize();
-	current->nice = 19;
+	current->nice = -19;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */

