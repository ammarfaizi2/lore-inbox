Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143435AbRA1Q0e>; Sun, 28 Jan 2001 11:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143496AbRA1Q0Y>; Sun, 28 Jan 2001 11:26:24 -0500
Received: from colorfullife.com ([216.156.138.34]:53258 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S143435AbRA1Q0L>;
	Sun, 28 Jan 2001 11:26:11 -0500
Message-ID: <3A744820.2C4C94F6@colorfullife.com>
Date: Sun, 28 Jan 2001 17:26:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dwmw2@redhat.com, andrewm@uow.edu.au
CC: linux-kernel@vger.kernel.org
Subject: flush_scheduled_tasks() question
Content-Type: multipart/mixed;
 boundary="------------08C01DDEE8FEAE4089CF4EF1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------08C01DDEE8FEAE4089CF4EF1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Is is intentional that tummy_task is not initialized?
Ok, it won't crash because the current __run_task_queue() implementation
doesn't call tq->routine if it's NULL, but IMHO it's ugly.

Additionally I don't like the loop in flush_scheduled_tasks(), what
about replacing it with a locked semaphore (same idea as vfork)?

I've attched an untested patch.

--
	Manfred
--------------08C01DDEE8FEAE4089CF4EF1
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- context.c.orig	Sun Jan 28 17:02:35 2001
+++ context.c	Sun Jan 28 17:09:24 2001
@@ -22,7 +22,6 @@
 
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
-static DECLARE_WAIT_QUEUE_HEAD(context_task_done);
 static int keventd_running;
 static struct task_struct *keventd_task;
 
@@ -97,7 +96,6 @@
 		schedule();
 		remove_wait_queue(&context_task_wq, &wait);
 		run_task_queue(&tq_context);
-		wake_up(&context_task_done);
 		if (signal_pending(curtask)) {
 			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
 				;
@@ -119,31 +117,24 @@
  * The caller should hold no spinlocks and should hold no semaphores which could
  * cause the scheduled tasks to block.
  */
-static struct tq_struct dummy_task;
 
-void flush_scheduled_tasks(void)
+static void up_semaphore(void* sem)
 {
-	int count;
-	DECLARE_WAITQUEUE(wait, current);
+	up((struct semaphore*)sem);
+}
 
-	/*
-	 * Do it twice. It's possible, albeit highly unlikely, that
-	 * the caller queued a task immediately before calling us,
-	 * and that the eventd thread was already past the run_task_queue()
-	 * but not yet into wake_up(), so it woke us up before completing
-	 * the caller's queued task or our new dummy task.
-	 */
-	add_wait_queue(&context_task_done, &wait);
-	for (count = 0; count < 2; count++) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+void flush_scheduled_tasks(void)
+{
+	DECLARE_MUTEX_LOCKED(sem);
+	struct tq_struct wakeup_task;
 
-		/* Queue a dummy task to make sure we get kicked */
-		schedule_task(&dummy_task);
+	wakeup_task.routine = up_semaphore;
+	wakeup_task.data = &sem;
+	/* Queue a dummy task to make sure we get kicked */
+	schedule_task(&dummy_task);
 
-		/* Wait for it to complete */
-		schedule();
-	}
-	remove_wait_queue(&context_task_done, &wait);
+	/* Wait for it to complete */
+	down(&sem);
 }
 	
 int start_context_thread(void)


--------------08C01DDEE8FEAE4089CF4EF1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
