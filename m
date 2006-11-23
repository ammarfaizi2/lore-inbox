Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757349AbWKWLsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbWKWLsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757341AbWKWLsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:48:17 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27268 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757331AbWKWLsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:48:14 -0500
Date: Thu, 23 Nov 2006 11:52:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Kevent POSIX timers support.
Message-ID: <20061123085243.GA11575@2ka.mipt.ru>
References: <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061122104416.GD11480@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (relay.2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 14:42:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:44:16PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> That what I implemented.
> But in this case it will be impossible to have SIGEV_THREAD and SIGEV_KEVENT
> at the same time, it will be just the same as SIGEV_SIGNAL but with
> different delivery mechanism. Is is what you expect for that?

Something like this morning hack (compile tested only).
If my thoughts are correct, I will create some simple application and
test if it works.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index a7dd38f..4b9deb4 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/kevent_storage.h>
 
 union cpu_time_count {
 	cputime_t cpu;
@@ -49,6 +50,9 @@ struct k_itimer {
 	sigval_t it_sigev_value;	/* value word of sigevent struct */
 	struct task_struct *it_process;	/* process to send signal to */
 	struct sigqueue *sigq;		/* signal queue entry. */
+#ifdef CONFIG_KEVENT_TIMER
+	struct kevent_storage st;
+#endif
 	union {
 		struct {
 			struct hrtimer timer;
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index e5ebcc1..148a9f9 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -48,6 +48,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/module.h>
+#include <linux/kevent.h>
+#include <linux/file.h>
 
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
@@ -224,6 +226,95 @@ static int posix_ktime_get_ts(clockid_t
 	return 0;
 }
 
+#ifdef CONFIG_KEVENT_TIMER
+static int posix_kevent_enqueue(struct kevent *k)
+{
+	struct k_itimer *tmr = k->event.ptr;
+	return kevent_storage_enqueue(&tmr->st, k);
+}
+static int posix_kevent_dequeue(struct kevent *k)
+{
+	struct k_itimer *tmr = k->event.ptr;
+	kevent_storage_dequeue(&tmr->st, k);
+	return 0;
+}
+static int posix_kevent_callback(struct kevent *k)
+{
+	return 1;
+}
+static int posix_kevent_init(void)
+{
+	struct kevent_callbacks tc = {
+		.callback = &posix_kevent_callback,
+		.enqueue = &posix_kevent_enqueue,
+		.dequeue = &posix_kevent_dequeue};
+
+	return kevent_add_callbacks(&tc, KEVENT_POSIX_TIMER);
+}
+
+extern struct file_operations kevent_user_fops;
+
+static int posix_kevent_init_timer(struct k_itimer *tmr, int fd)
+{
+	struct ukevent uk;
+	struct file *file;
+	struct kevent_user *u;
+	int err;
+
+	file = fget(fd);
+	if (!file) {
+		err = -EBADF;
+		goto err_out;
+	}
+
+	if (file->f_op != &kevent_user_fops) {
+		err = -EINVAL;
+		goto err_out_fput;
+	}
+
+	u = file->private_data;
+
+	memset(&uk, 0, sizeof(struct ukevent));
+
+	uk.type = KEVENT_POSIX_TIMER;
+	uk.id.raw_u64 = (unsigned long)(tmr); /* Just cast to something unique */
+	uk.ptr = tmr;
+
+	tmr->it_sigev_value.sival_ptr = file;
+
+	err = kevent_user_add_ukevent(&uk, u);
+	if (err)
+		goto err_out_fput;
+
+	fput(file);
+
+	return 0;
+
+err_out_fput:
+	fput(file);
+err_out:
+	return err;
+}
+
+static void posix_kevent_fini_timer(struct k_itimer *tmr)
+{
+	kevent_storage_fini(&tmr->st);
+}
+#else
+static int posix_kevent_init_timer(struct k_itimer *tmr, int fd)
+{
+	return -ENOSYS;
+}
+static int posix_kevent_init(void)
+{
+	return 0;
+}
+static void posix_kevent_fini_timer(struct k_itimer *tmr)
+{
+}
+#endif
+
+
 /*
  * Initialize everything, well, just everything in Posix clocks/timers ;)
  */
@@ -241,6 +332,11 @@ static __init int init_posix_timers(void
 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
 
+	if (posix_kevent_init()) {
+		printk(KERN_ERR "Failed to initialize kevent posix timers.\n");
+		BUG();
+	}
+
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
 	idr_init(&posix_timers_id);
@@ -343,23 +439,27 @@ static int posix_timer_fn(struct hrtimer
 
 	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
+	
+	if (timr->it_sigev_notify & SIGEV_KEVENT) {
+		kevent_storage_ready(&timr->st, NULL, KEVENT_MASK_ALL);
+	} else {
+		if (timr->it.real.interval.tv64 != 0)
+			si_private = ++timr->it_requeue_pending;
 
-	if (timr->it.real.interval.tv64 != 0)
-		si_private = ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
-		/*
-		 * signal was not sent because of sig_ignor
-		 * we will not get a call back to restart it AND
-		 * it should be restarted.
-		 */
-		if (timr->it.real.interval.tv64 != 0) {
-			timr->it_overrun +=
-				hrtimer_forward(timer,
-						timer->base->softirq_time,
-						timr->it.real.interval);
-			ret = HRTIMER_RESTART;
-			++timr->it_requeue_pending;
+		if (posix_timer_event(timr, si_private)) {
+			/*
+			 * signal was not sent because of sig_ignor
+			 * we will not get a call back to restart it AND
+			 * it should be restarted.
+			 */
+			if (timr->it.real.interval.tv64 != 0) {
+				timr->it_overrun +=
+					hrtimer_forward(timer,
+							timer->base->softirq_time,
+							timr->it.real.interval);
+				ret = HRTIMER_RESTART;
+				++timr->it_requeue_pending;
+			}
 		}
 	}
 
@@ -407,6 +507,9 @@ static struct k_itimer * alloc_posix_tim
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = NULL;
 	}
+#ifdef CONFIG_KEVENT_TIMER
+	kevent_storage_init(tmr, &tmr->st);
+#endif
 	return tmr;
 }
 
@@ -424,6 +527,7 @@ static void release_posix_timer(struct k
 	if (unlikely(tmr->it_process) &&
 	    tmr->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
 		put_task_struct(tmr->it_process);
+	posix_kevent_fini_timer(tmr);
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
@@ -496,40 +600,52 @@ sys_timer_create(const clockid_t which_c
 		new_timer->it_sigev_signo = event.sigev_signo;
 		new_timer->it_sigev_value = event.sigev_value;
 
-		read_lock(&tasklist_lock);
-		if ((process = good_sigevent(&event))) {
-			/*
-			 * We may be setting up this process for another
-			 * thread.  It may be exiting.  To catch this
-			 * case the we check the PF_EXITING flag.  If
-			 * the flag is not set, the siglock will catch
-			 * him before it is too late (in exit_itimers).
-			 *
-			 * The exec case is a bit more invloved but easy
-			 * to code.  If the process is in our thread
-			 * group (and it must be or we would not allow
-			 * it here) and is doing an exec, it will cause
-			 * us to be killed.  In this case it will wait
-			 * for us to die which means we can finish this
-			 * linkage with our last gasp. I.e. no code :)
-			 */
+		if (event.sigev_notify & SIGEV_KEVENT) {
+			error = posix_kevent_init_timer(new_timer, event._sigev_un.kevent_fd);
+			if (error)
+				goto out;
+
+			process = current->group_leader;
 			spin_lock_irqsave(&process->sighand->siglock, flags);
-			if (!(process->flags & PF_EXITING)) {
-				new_timer->it_process = process;
-				list_add(&new_timer->list,
-					 &process->signal->posix_timers);
-				spin_unlock_irqrestore(&process->sighand->siglock, flags);
-				if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
-					get_task_struct(process);
-			} else {
-				spin_unlock_irqrestore(&process->sighand->siglock, flags);
-				process = NULL;
+			new_timer->it_process = process;
+			list_add(&new_timer->list, &process->signal->posix_timers);
+			spin_unlock_irqrestore(&process->sighand->siglock, flags);
+		} else {
+			read_lock(&tasklist_lock);
+			if ((process = good_sigevent(&event))) {
+				/*
+				 * We may be setting up this process for another
+				 * thread.  It may be exiting.  To catch this
+				 * case the we check the PF_EXITING flag.  If
+				 * the flag is not set, the siglock will catch
+				 * him before it is too late (in exit_itimers).
+				 *
+				 * The exec case is a bit more invloved but easy
+				 * to code.  If the process is in our thread
+				 * group (and it must be or we would not allow
+				 * it here) and is doing an exec, it will cause
+				 * us to be killed.  In this case it will wait
+				 * for us to die which means we can finish this
+				 * linkage with our last gasp. I.e. no code :)
+				 */
+				spin_lock_irqsave(&process->sighand->siglock, flags);
+				if (!(process->flags & PF_EXITING)) {
+					new_timer->it_process = process;
+					list_add(&new_timer->list,
+						 &process->signal->posix_timers);
+					spin_unlock_irqrestore(&process->sighand->siglock, flags);
+					if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+						get_task_struct(process);
+				} else {
+					spin_unlock_irqrestore(&process->sighand->siglock, flags);
+					process = NULL;
+				}
+			}
+			read_unlock(&tasklist_lock);
+			if (!process) {
+				error = -EINVAL;
+				goto out;
 			}
-		}
-		read_unlock(&tasklist_lock);
-		if (!process) {
-			error = -EINVAL;
-			goto out;
 		}
 	} else {
 		new_timer->it_sigev_notify = SIGEV_SIGNAL;
 

-- 
	Evgeniy Polyakov
