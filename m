Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTBIC1J>; Sat, 8 Feb 2003 21:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbTBIC1J>; Sat, 8 Feb 2003 21:27:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47632 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267145AbTBIC1H>; Sat, 8 Feb 2003 21:27:07 -0500
Date: Sat, 8 Feb 2003 18:33:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302081754340.5231-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302081826230.7675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Linus Torvalds wrote:
>
> And then the call trace would be very interesting indeed if the above bug 
> triggers.. (and unlike the do_exit() bug, the tri_to_wake_up() thing 
> should clearly pinpoint where the problem actually happens, knock wood).

Ok, let's assume it was the wake_up_process() in handle_stop_signal(), 
then hopefully this (totally untested) patch should fix it.

Roland, does this look sane to you? It makes the STOP wakeup be a 
SIGCONT-only thing, and makes the wakeup conditional on !PF_EXITING.

It also makes SIGKILL ignore the stopped status for delivery.

Does this make the gdb test-suite happy?

		Linus

---
===== kernel/signal.c 1.61 vs edited =====
--- 1.61/kernel/signal.c	Fri Feb  7 06:46:13 2003
+++ edited/kernel/signal.c	Sat Feb  8 18:29:11 2003
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
+	 && ((p)->state & mask)				\
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
+	 * Normally we only post signals to non-stopped threads,
+	 * bit SIGKILL will puch through that too..
+	 */
+	mask = TASK_RUNNING | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE;
+	if (sig == SIGKILL)
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

