Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbQKGMy6>; Tue, 7 Nov 2000 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQKGMys>; Tue, 7 Nov 2000 07:54:48 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:57222 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130642AbQKGMym>; Tue, 7 Nov 2000 07:54:42 -0500
Message-ID: <3A07FB88.E73D0D2D@uow.edu.au>
Date: Tue, 07 Nov 2000 23:54:32 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <3A06C007.99EE3746@uow.edu.au> <Pine.LNX.4.10.10011060941070.7955-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 7 Nov 2000, Andrew Morton wrote:
> 
> > Alan Cox wrote:
> > >
> > > > Even 2.2.x can be fixed to do the wake-one for accept(), if required.
> > >
> > > Do we really want to retrofit wake_one to 2.2. I know Im not terribly keen to
> > > try and backport all the mechanism. I think for 2.2 using the semaphore is a
> > > good approach. Its a hack to fix an old OS kernel. For 2.4 its not needed
> >
> > It's a 16-liner!  I'll cheerfully admit that this patch
> > may be completely broken, but hey, it's free.  I suggest
> > that _something_ has to be done for 2.2 now, because
> > Apache has switched to unserialised accept().
> 
> This is why I'd love to _not_ see silly work-arounds in apache: we
> obviously _can_ fix the places where our performance sucks, but only if we
> don't have other band-aids hiding the true issues.
> 
> For example, with a file-locking apache, we'd have to fix the (noticeably
> harder) file locking thing to be wake-one instead, and even then we'd
> never be able to do as well as something that gets the same wake-one thing
> without the two extra system calls.
> 
> The patch looks superficially fine to me, although it does seem to add
> another cache-line to the wakeup setup - it migth be worth-while to have
> the exclusive state closer. But maybe I just didn't count right.

Your counting's fine.  But I figured the third cachline was OK
because we're going to need that in add_to_runqueue() a few
cycles later.

Anyway, version 2 below uses LIFO for the accept() wakeups.  This
appears to be a 5%-10% win for Apache.  The browsing loop for
exclusive tasks will now pull in cachelines 0 and 2, rather
than the previous 0 and 1.

--- linux-2.2.18-pre19/include/linux/sched.h	Sun Nov  5 11:46:54 2000
+++ linux-akpm/include/linux/sched.h	Tue Nov  7 20:20:13 2000
@@ -79,6 +79,7 @@
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
 #define TASK_SWAPPING		16
+#define TASK_EXCLUSIVE		32
 
 /*
  * Scheduling policies
@@ -251,6 +252,7 @@
 	struct task_struct *next_task, *prev_task;
 	struct task_struct *next_run,  *prev_run;
 
+	unsigned int task_exclusive;	/* task wants wake-one semantics in __wake_up() */
 /* task state */
 	struct linux_binfmt *binfmt;
 	int exit_code, exit_signal;
@@ -370,6 +372,7 @@
 /* counter */	DEF_PRIORITY,DEF_PRIORITY,0, \
 /* SMP */	0,0,0,-1, \
 /* schedlink */	&init_task,&init_task, &init_task, &init_task, \
+/* task_exclusive */ 0, \
 /* binfmt */	NULL, \
 /* ec,brk... */	0,0,0,0,0,0, \
 /* pid etc.. */	0,0,0,0,0, \
@@ -496,8 +499,8 @@
 						    signed long timeout));
 extern void FASTCALL(wake_up_process(struct task_struct * tsk));
 
-#define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
-#define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE)
+#define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE | TASK_EXCLUSIVE)
+#define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE | TASK_EXCLUSIVE)
 
 #define __set_current_state(state_value)	do { current->state = state_value; } while (0)
 #ifdef __SMP__
--- linux-2.2.18-pre19/kernel/sched.c	Sun Nov  5 11:46:54 2000
+++ linux-akpm/kernel/sched.c	Tue Nov  7 20:23:25 2000
@@ -890,8 +890,9 @@
  */
 void __wake_up(struct wait_queue **q, unsigned int mode)
 {
-	struct task_struct *p;
+	struct task_struct *p, *last_exclusive;
 	struct wait_queue *head, *next;
+	unsigned int done_exclusive, do_exclusive;
 
         if (!q)
 		goto out;
@@ -906,10 +907,17 @@
 	if (!next)
 		goto out_unlock;
 
+	last_exclusive = NULL;
+	do_exclusive = mode & TASK_EXCLUSIVE;
 	while (next != head) {
 		p = next->task;
 		next = next->next;
 		if (p->state & mode) {
+			if (do_exclusive && p->task_exclusive) {
+				last_exclusive = p;
+				continue;
+			}
+
 			/*
 			 * We can drop the read-lock early if this
 			 * is the only/last process.
@@ -922,6 +930,8 @@
 			wake_up_process(p);
 		}
 	}
+	if (last_exclusive)
+		wake_up_process(last_exclusive);
 out_unlock:
 	read_unlock(&waitqueue_lock);
 out:
--- linux-2.2.18-pre19/net/ipv4/tcp.c	Sun Nov  5 11:46:54 2000
+++ linux-akpm/net/ipv4/tcp.c	Tue Nov  7 20:20:13 2000
@@ -1619,6 +1619,7 @@
 	struct wait_queue wait = { current, NULL };
 	struct open_request *req;
 
+	current->task_exclusive = 1;
 	add_wait_queue(sk->sleep, &wait);
 	for (;;) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -1632,6 +1633,8 @@
 			break;
 	}
 	current->state = TASK_RUNNING;
+	wmb();
+	current->task_exclusive = 0;
 	remove_wait_queue(sk->sleep, &wait);
 	return req;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
