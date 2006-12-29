Return-Path: <linux-kernel-owner+w=401wt.eu-S1752532AbWL2M0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWL2M0s (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbWL2M0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:26:46 -0500
Received: from dea.vocord.ru ([217.67.177.50]:40704 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752334AbWL2M0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:26:41 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Ingo Molnar <mingo@elte.hu>
Subject: [take30 8/9] kevent: Kevent posix timer notifications.
In-Reply-To: <1167395158642@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Fri, 29 Dec 2006 15:25:58 +0300
Message-Id: <11673951583526@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevent posix timer notifications.

Simple extensions to POSIX timers which allows
to deliver notification of the timer expiration
through kevent queue.

Example application posix_timer.c can be found
in archive on project homepage.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>


diff --git a/include/asm-generic/siginfo.h b/include/asm-generic/siginfo.h
index 8786e01..3768746 100644
--- a/include/asm-generic/siginfo.h
+++ b/include/asm-generic/siginfo.h
@@ -235,6 +235,7 @@ typedef struct siginfo {
 #define SIGEV_NONE	1	/* other notification: meaningless */
 #define SIGEV_THREAD	2	/* deliver via thread creation */
 #define SIGEV_THREAD_ID 4	/* deliver to thread */
+#define SIGEV_KEVENT	8	/* deliver through kevent queue */
 
 /*
  * This works because the alignment is ok on all current architectures
@@ -260,6 +261,8 @@ typedef struct sigevent {
 			void (*_function)(sigval_t);
 			void *_attribute;	/* really pthread_attr_t */
 		} _sigev_thread;
+
+		int kevent_fd;
 	} _sigev_un;
 } sigevent_t;
 
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
index 5fe87de..5ec805e 100644
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
@@ -224,6 +226,100 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec *tp)
 	return 0;
 }
 
+#ifdef CONFIG_KEVENT_TIMER
+static int posix_kevent_enqueue(struct kevent *k)
+{
+	/*
+	 * It is not ugly - there is no pointer in the id field union, 
+	 * but its size is 64bits, which is ok for any known pointer size.
+	 */
+	struct k_itimer *tmr = (struct k_itimer *)(unsigned long)k->event.id.raw_u64;
+	return kevent_storage_enqueue(&tmr->st, k);
+}
+static int posix_kevent_dequeue(struct kevent *k)
+{
+	struct k_itimer *tmr = (struct k_itimer *)(unsigned long)k->event.id.raw_u64;
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
+		.dequeue = &posix_kevent_dequeue,
+		.flags = KEVENT_CALLBACKS_KERNELONLY};
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
+	uk.event = KEVENT_MASK_ALL;
+	uk.type = KEVENT_POSIX_TIMER;
+	uk.id.raw_u64 = (unsigned long)(tmr); /* Just cast to something unique */
+	uk.req_flags = KEVENT_REQ_ONESHOT | KEVENT_REQ_ALWAYS_QUEUE;
+	uk.ptr = tmr->it_sigev_value.sival_ptr;
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
@@ -241,6 +337,11 @@ static __init int init_posix_timers(void)
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
@@ -343,23 +444,29 @@ static int posix_timer_fn(struct hrtimer *timer)
 
 	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
+	
+	if (timr->it_sigev_notify == SIGEV_KEVENT) {
+#ifdef CONFIG_KEVENT_TIMER
+		kevent_storage_ready(&timr->st, NULL, KEVENT_MASK_ALL);
+#endif
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
 
@@ -407,6 +514,9 @@ static struct k_itimer * alloc_posix_timer(void)
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = NULL;
 	}
+#ifdef CONFIG_KEVENT_TIMER
+	kevent_storage_init(tmr, &tmr->st);
+#endif
 	return tmr;
 }
 
@@ -424,6 +534,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	if (unlikely(tmr->it_process) &&
 	    tmr->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
 		put_task_struct(tmr->it_process);
+	posix_kevent_fini_timer(tmr);
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
@@ -496,40 +607,52 @@ sys_timer_create(const clockid_t which_clock,
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
+		if (event.sigev_notify == SIGEV_KEVENT) {
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

