Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTBIDjK>; Sat, 8 Feb 2003 22:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTBIDjK>; Sat, 8 Feb 2003 22:39:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42662 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267160AbTBIDjI>; Sat, 8 Feb 2003 22:39:08 -0500
Date: Sat, 8 Feb 2003 19:48:38 -0800
Message-Id: <200302090348.h193mcn05216@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@digeo.com>, <arjanv@redhat.com>
X-Fcc: ~/Mail/linus
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Roland McGrath's message of  Saturday, 8 February 2003 19:33:49 -0800 <200302090333.h193Xnn04935@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Windows: simplicity made complex.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch vs 2.5.59-1.1007 that I am using now.  gdb seems happy.
I have not run a lot of other tests yet.


--- /home/roland/redhat/linux-2.5.59-1.1007/kernel/signal.c.~1~	Fri Feb  7 20:04:29 2003
+++ /home/roland/redhat/linux-2.5.59-1.1007/kernel/signal.c	Sat Feb  8 19:35:28 2003
@@ -120,9 +120,6 @@ int max_queued_signals = 1024;
 #define SIG_KERNEL_STOP_MASK (\
 	M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   )
 
-#define SIG_KERNEL_CONT_MASK (\
-	M(SIGCONT)   |  M(SIGKILL)   )
-
 #define SIG_KERNEL_COREDUMP_MASK (\
         M(SIGQUIT)   |  M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   | \
         M(SIGFPE)    |  M(SIGSEGV)   |  M(SIGBUS)    |  M(SIGSYS)    | \
@@ -139,8 +136,6 @@ int max_queued_signals = 1024;
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_IGNORE_MASK))
 #define sig_kernel_stop(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
-#define sig_kernel_cont(sig) \
-		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_CONT_MASK))
 
 #define sig_user_defined(t, signr) \
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
@@ -592,7 +587,7 @@ static void handle_stop_signal(int sig, 
 			t = next_thread(t);
 		} while (t != p);
 	}
-	else if (sig_kernel_cont(sig)) {
+	else if (sig == SIGCONT) {
 		/*
 		 * Remove all stop signals from all queues,
 		 * and wake all threads.
@@ -618,7 +613,8 @@ static void handle_stop_signal(int sig, 
 					p->group_leader,
 					p->group_leader->real_parent);
 		}
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
+		rm_from_queue(SIG_KERNEL_STOP_MASK,
+			      &p->signal->shared_pending);
 		t = p;
 		do {
 			rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
@@ -637,17 +633,13 @@ static void handle_stop_signal(int sig, 
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
+				if (!sigismember(&t->blocked, SIGCONT))
+					set_tsk_thread_flag(t, TIF_SIGPENDING);
+				wake_up_process(t);
+			}
 			t = next_thread(t);
 		} while (t != p);
 	}
@@ -782,23 +774,25 @@ force_sig_specific(int sig, struct task_
 }
 
 /*
- * Test if P wants to take SIG.  After we've checked all threads with this,
- * it's equivalent to finding no threads not blocking SIG.  Any threads not
- * blocking SIG were ruled out because they are not running and already
- * have pending signals.  Such threads will dequeue from the shared queue
- * as soon as they're available, so putting the signal on the shared queue
- * will be equivalent to sending it to one such thread.
- */
-#define wants_signal(sig, p)	(!sigismember(&(p)->blocked, sig) \
-				 && (p)->state < TASK_STOPPED \
-				 && !((p)->flags & PF_EXITING) \
-				 && (task_curr(p) || !signal_pending(p)))
+ * Test if P wants to take SIG.  MASK gives P->state bits that rule it out.
+ * After we've checked all threads with this, it's equivalent to finding no
+ * threads not blocking SIG.  Any threads not blocking SIG were ruled out
+ * because they are not running and already have pending signals.  Such
+ * threads will dequeue from the shared queue as soon as they're available,
+ * so putting the signal on the shared queue will be equivalent to sending
+ * it to one such thread.
+ */
+#define wants_signal(sig, p, mask)				\
+	(!sigismember(&(p)->blocked, sig) &&			\
+	 !((p)->state & (mask)) && !((p)->flags & PF_EXITING) &&\
+	 (task_curr(p) || !signal_pending(p)))
 
 static inline int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	struct task_struct *t;
 	int ret;
+	unsigned int mask;
 
 #if CONFIG_SMP
 	if (!spin_is_locked(&p->sighand->siglock))
@@ -824,12 +818,20 @@ __group_send_sig_info(int sig, struct si
 		return ret;
 
 	/*
+	 * Signals are only accepted by non-stopped processes.
+	 * SIGKILL is the exception: it acts on stopped processes too.
+	 */
+	mask = TASK_ZOMBIE | TASK_DEAD;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
 	 * If the main thread wants the signal, it gets first crack.
 	 * Probably the least surprising to the average bear.
 	 */
-	if (wants_signal(sig, p))
+	if (wants_signal(sig, p, mask))
 		t = p;
 	else if (thread_group_empty(p))
 		/*
@@ -847,7 +849,7 @@ __group_send_sig_info(int sig, struct si
 			t = p->signal->curr_target = p;
 		BUG_ON(t->tgid != p->tgid);
 
-		while (!wants_signal(sig, t)) {
+		while (!wants_signal(sig, t, mask)) {
 			t = next_thread(t);
 			if (t == p->signal->curr_target)
 				/*
