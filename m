Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSJTFfI>; Sun, 20 Oct 2002 01:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265780AbSJTFfI>; Sun, 20 Oct 2002 01:35:08 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:32899 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265777AbSJTFfG>;
	Sun, 20 Oct 2002 01:35:06 -0400
Date: Sun, 20 Oct 2002 01:40:49 -0400
Message-Id: <200210200540.g9K5enl08075@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: ak@suse.de, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: POSIX clocks & timers - more choices
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi, George


> > > +     if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)
> The typeof() cast looks weird. I had to think twice to make sense of it.

I looked this again today.  When I wrote this I was trying to compare
the effect of different ID_BITS value.  Normally I would use 
(1 << ID_BITS)-1 to generate a mask but I think this breaks for 
32 bits.  I completely forgot doing this.

I have been working on solving the issue of locking around the 
find_task_by_pid().  I'm attaching a first cut at a patch.  It is
against George's version of the driver.  I'm closing the race
between one thread creating a timer for another and that thread
exiting.  It took a change to exit_itimers() so that I decide that
the process is exiting even though it has not yet unlinked its self
from the pid hash.  If the exiting process has already called
exit_itimers() we need to fail the timer create.

This is a something like this should work patch.  I have been
debugging an equivalent patch for my version and it still doesn't work
yet.

Jim Houston - Concurrent Computer Corp.

diff -urN x1.old/kernel/posix-timers.c x1.new/kernel/posix-timers.c
--- x1.old/kernel/posix-timers.c	Sat Oct 19 16:04:47 2002
+++ x1.new/kernel/posix-timers.c	Sat Oct 19 17:05:38 2002
@@ -535,7 +535,7 @@
 	int error = 0;
 	struct k_itimer *new_timer = NULL;
 	int new_timer_id;
-	struct task_struct * process = current;
+	struct task_struct * process = 0;
 	sigevent_t event;
 
 	/* Right now, we only support CLOCK_REALTIME for timers. */
@@ -547,13 +547,42 @@
 
 	spin_lock_init(&new_timer->it_lock);
 	IF_ABS_TIME_ADJ(INIT_LIST_HEAD(&new_timer->abs_list));
+	/*
+	 * return the timer_id now.  The next step is hard to 
+	 * back out.
+	 */
+	new_timer_id = new_timer->it_id;
+	if (copy_to_user(created_timer_id, 
+			 &new_timer_id, 
+			 sizeof(new_timer_id))) {
+		error = -EFAULT;
+		goto out;
+	}
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec,
 				   sizeof(event))) {
 			error = -EFAULT;
 			goto out;
 		}
-		if ((process = good_sigevent(&event)) == NULL) {
+		read_lock(&tasklist_lock);
+		if ((process = good_sigevent(&event))) {
+			/*
+			 * We may be setting up this process for another
+			 * thread.  It may be exitiing.  To catch this
+			 * case the we clear posix_timers.next in 
+			 * exit_itimers.
+			 */
+			spin_lock(&process->alloc_lock);
+			if (!process->posix_timers.next) {
+				list_add(&new_timer->list, &process->posix_timers);
+				spin_unlock(&process->alloc_lock);
+			} else {
+				spin_unlock(&process->alloc_lock);
+				process = 0;
+			}
+		}
+		read_unlock(&tasklist_lock);
+		if (!process) {
 			error = -EINVAL;
 			goto out;
 		}
@@ -565,6 +594,10 @@
 		new_timer->it_sigev_notify = SIGEV_SIGNAL;
 		new_timer->it_sigev_signo = SIGALRM;
 		new_timer->it_sigev_value.sival_int = new_timer->it_id;
+		process = current;
+		spin_lock(&process->alloc_lock);
+		list_add(&new_timer->list, &process->posix_timers);
+		spin_unlock(&process->alloc_lock);
 	}
 
 	new_timer->it_clock = which_clock;
@@ -576,18 +609,6 @@
 	new_timer->it_timer.function = posix_timer_fn;
 	set_timer_inactive(new_timer);
 
-	new_timer_id = new_timer->it_id;
-
-	if (copy_to_user(created_timer_id, 
-			 &new_timer_id, 
-			 sizeof(new_timer_id))) {
-		error = -EFAULT;
-		goto out;
-	}
-	spin_lock(&process->alloc_lock);
-	list_add(&new_timer->list, &process->posix_timers);
-
-	spin_unlock(&process->alloc_lock);
 	/*
 	 * Once we set the process, it can be found so do it last...
 	 */
@@ -600,6 +621,24 @@
 	return error;
 }
 
+
+inline void exit_itimers(struct task_struct *tsk)
+{
+	struct	k_itimer *tmr;
+
+	/* exit_itimers - can only be called once? */
+	if (!tsk->posix_timers.next)
+		BUG():
+	spin_lock(&tsk->alloc_lock);
+	while (tsk->posix_timers.next != &tsk->posix_timers){
+		spin_unlock(&tsk->alloc_lock);
+		 tmr = list_entry(tsk->posix_timers.next,struct k_itimer,list);
+		itimer_delete(tmr);
+		spin_lock(&tsk->alloc_lock);
+	}
+	tsk->posix_timers.next = 0;
+	spin_unlock(&tsk->alloc_lock);
+}
 
 /* good_timespec
  *
