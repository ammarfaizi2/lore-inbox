Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTBIDfC>; Sat, 8 Feb 2003 22:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTBIDfC>; Sat, 8 Feb 2003 22:35:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267159AbTBIDfA>; Sat, 8 Feb 2003 22:35:00 -0500
Date: Sat, 8 Feb 2003 19:40:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302081933380.7675-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302081940050.7675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Linus Torvalds wrote:
> 
> Oops. Indeed. TASK_RUNNING isn't a bit at all, it's a lack of sleep.

So it might work this way around..

		Linus

---
===== kernel/signal.c 1.61 vs edited =====
--- 1.61/kernel/signal.c	Fri Feb  7 06:46:13 2003
+++ edited/kernel/signal.c	Sat Feb  8 19:39:48 2003
@@ -591,8 +591,7 @@
 			rm_from_queue(sigmask(SIGCONT), &t->pending);
 			t = next_thread(t);
 		} while (t != p);
-	}
-	else if (sig_kernel_cont(sig)) {
+	} else if (sig == SIGCONT) {
 		/*
 		 * Remove all stop signals from all queues,
 		 * and wake all threads.
@@ -637,17 +636,12 @@
 			 * running the handler.  With the TIF_SIGPENDING
 			 * flag set, the thread will pause and acquire the
 			 * siglock that we hold now and until we've queued
-			 * the pending signal.  For SIGKILL, we likewise
-			 * don't want anybody doing anything but taking the
-			 * SIGKILL.  The only case in which a thread would
-			 * not already be in the signal dequeuing loop is
-			 * non-signal (e.g. syscall) ptrace tracing, so we
-			 * don't worry about an unnecessary trip through
-			 * the signal code and just keep this code path
-			 * simpler by unconditionally setting the flag.
+			 * the pending signal. 
 			 */
-			set_tsk_thread_flag(t, TIF_SIGPENDING);
-			wake_up_process(t);
+			if (!(t->flags & PF_EXITING)) {
+				set_tsk_thread_flag(t, TIF_SIGPENDING);
+				wake_up_process(t);
+			}
 			t = next_thread(t);
 		} while (t != p);
 	}
@@ -789,15 +783,17 @@
  * as soon as they're available, so putting the signal on the shared queue
  * will be equivalent to sending it to one such thread.
  */
-#define wants_signal(sig, p)	(!sigismember(&(p)->blocked, sig) \
-				 && (p)->state < TASK_STOPPED \
-				 && !((p)->flags & PF_EXITING) \
-				 && (task_curr(p) || !signal_pending(p)))
+#define wants_signal(sig, p, mask) 			\
+	(!sigismember(&(p)->blocked, sig)		\
+	 && !((p)->state & mask)			\
+	 && !((p)->flags & PF_EXITING)			\
+	 && (task_curr(p) || !signal_pending(p)))
 
 static inline int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	struct task_struct *t;
+	unsigned int mask;
 	int ret;
 
 #if CONFIG_SMP
@@ -815,6 +811,14 @@
 		return 0;
 
 	/*
+	 * Don't bother zombies and stopped tasks (but
+	 * SIGKILL will punch through stopped state)
+	 */
+	mask = TASK_DEAD | TASK_ZOMBIE;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
 	 * Put this signal on the shared-pending queue, or fail with EAGAIN.
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
@@ -829,7 +833,7 @@
 	 * If the main thread wants the signal, it gets first crack.
 	 * Probably the least surprising to the average bear.
 	 */
-	if (wants_signal(sig, p))
+	if (wants_signal(sig, p, mask))
 		t = p;
 	else if (thread_group_empty(p))
 		/*
@@ -847,7 +851,7 @@
 			t = p->signal->curr_target = p;
 		BUG_ON(t->tgid != p->tgid);
 
-		while (!wants_signal(sig, t)) {
+		while (!wants_signal(sig, t, mask)) {
 			t = next_thread(t);
 			if (t == p->signal->curr_target)
 				/*

