Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbQKREV7>; Fri, 17 Nov 2000 23:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130649AbQKREVu>; Fri, 17 Nov 2000 23:21:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:14746 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129806AbQKREVa>; Fri, 17 Nov 2000 23:21:30 -0500
Message-ID: <3A15FCBD.24A7175D@uow.edu.au>
Date: Sat, 18 Nov 2000 14:51:25 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] SMP race in exit()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

There is an SMP race on process exit.

The exitting process sets TASK_ZOMBIE and calles schedule().  The next
task to run clears the exitting tasks's task_struct.has_cpu in
__schedule_tail.  At this point in time the parent, which may be
spinning in fork.c:release() is free to go ahead and reap the child's
stack pages.  But __schedule_tail continues to play with the exitting
process's task_struct.  There is a window here where __schedule_tail is
reading and writing potentially free memory.

The fix is easy: make the parent synchronise on the exitting child's
alloc_lock, not the runqueue lock.



--- linux-2.4.0-test11-pre7/kernel/exit.c	Sat Nov 18 13:55:32 2000
+++ linux-akpm/kernel/exit.c	Sat Nov 18 14:35:25 2000
@@ -22,7 +22,7 @@
 
 int getrusage(struct task_struct *, int, struct rusage *);
 
-static void release(struct task_struct * p)
+static void release_task(struct task_struct * p)
 {
 	if (p != current) {
 #ifdef CONFIG_SMP
@@ -31,15 +31,15 @@
 		 * runqueue (active on some other CPU still)
 		 */
 		for (;;) {
-			spin_lock_irq(&runqueue_lock);
+			task_lock(p);
 			if (!p->has_cpu)
 				break;
-			spin_unlock_irq(&runqueue_lock);
+			task_unlock(p);
 			do {
 				barrier();
 			} while (p->has_cpu);
 		}
-		spin_unlock_irq(&runqueue_lock);
+		task_unlock(p);
 #endif
 		atomic_dec(&p->user->processes);
 		free_uid(p->user);
@@ -550,7 +550,7 @@
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
 				} else
-					release(p);
+					release_task(p);
 				goto end_wait4;
 			default:
 				continue;
--- linux-2.4.0-test11-pre7/kernel/sched.c	Sat Nov 18 13:55:32 2000
+++ linux-akpm/kernel/sched.c	Sat Nov 18 14:36:29 2000
@@ -197,7 +197,7 @@
 
 /*
  * This is ugly, but reschedule_idle() is very timing-critical.
- * We `are called with the runqueue spinlock held and we must
+ * We are called with the runqueue spinlock held and we must
  * not claim the tasklist_lock.
  */
 static FASTCALL(void reschedule_idle(struct task_struct * p));
@@ -452,7 +452,7 @@
 		goto needs_resched;
 
 out_unlock:
-	task_unlock(prev);
+	task_unlock(prev);	/* Synchronise here with release_task() if prev is TASK_ZOMBIE */
 	return;
 
 	/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
