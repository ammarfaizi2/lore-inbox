Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUJIGG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUJIGG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUJIGG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:06:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34803 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266519AbUJIFsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:48:33 -0400
Message-ID: <41677EA2.9070103@mvista.com>
Date: Fri, 08 Oct 2004 23:01:06 -0700
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ext-rt-dev@mvista.com
Subject: [ANNOUNCE] Linux 2.6 Real Time Kernel - 4 (Spinlock Patch 2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second of 2 spinlock patches to substitute
mutexes for kernel spinlocks.


  RT Prototype 2004 (C) MontaVista Software, Inc.
  This file is licensed under the terms of the GNU
  General Public License version 2. This program
  is licensed "as is" without any warranty of any kind,
  whether express or implied.

Please see the accompanying file:
Linux-2.6.9-rc3-RT_spinlock1.patch
for a description of this software.

Sign-off: Sven-Thorsten Dietrich (sdietrich@mvista.com)


diff -pruN a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	2004-08-14 09:36:32.000000000 +0400
+++ b/kernel/futex.c	2004-10-09 01:26:57.000000000 +0400
@@ -204,15 +204,15 @@ static int get_futex_key(unsigned long u
 	/*
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
-	spin_lock(&current->mm->page_table_lock);
+	_spin_lock(&current->mm->page_table_lock);
 	page = follow_page(mm, uaddr, 0);
 	if (likely(page != NULL)) {
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-		spin_unlock(&current->mm->page_table_lock);
+		_spin_unlock(&current->mm->page_table_lock);
 		return 0;
 	}
-	spin_unlock(&current->mm->page_table_lock);
+	_spin_unlock(&current->mm->page_table_lock);
 
 	/*
 	 * Do it the general way.
diff -pruN a/kernel/hardirq.c b/kernel/hardirq.c
--- a/kernel/hardirq.c	2004-10-09 00:36:39.000000000 +0400
+++ b/kernel/hardirq.c	2004-10-09 01:26:57.000000000 +0400
@@ -13,6 +13,8 @@
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>
 
+# include <linux/spin_undefs.h>
+
 #ifdef CONFIG_INGO_IRQ_THREADS
 extern struct irq_desc irq_desc[NR_IRQS];
 
diff -pruN a/kernel/irq.c b/kernel/irq.c
--- a/kernel/irq.c	2004-10-09 00:36:39.000000000 +0400
+++ b/kernel/irq.c	2004-10-09 01:26:57.000000000 +0400
@@ -37,6 +37,8 @@
 #include <asm/delay.h>
 #include <asm/irq.h>
 
+# include <linux/spin_undefs.h>
+
 
 #ifdef CONFIG_IRQ_THREADS
 static const int irq_prio = MAX_USER_RT_PRIO - 9;
diff -pruN a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/kmod.c	2004-10-09 01:26:57.000000000 +0400
@@ -157,11 +157,11 @@ static int ____call_usermodehelper(void 
 
 	/* Unblock all signals. */
 	flush_signals(current);
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	flush_signal_handlers(current, 1);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
diff -pruN a/kernel/posix-timers.c b/kernel/posix-timers.c
--- a/kernel/posix-timers.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/posix-timers.c	2004-10-09 01:26:57.000000000 +0400
@@ -649,16 +649,16 @@ sys_timer_create(clockid_t which_clock,
 			 * for us to die which means we can finish this
 			 * linkage with our last gasp. I.e. no code :)
 			 */
-			spin_lock_irqsave(&process->sighand->siglock, flags);
+			_spin_lock_irqsave(&process->sighand->siglock, flags);
 			if (!(process->flags & PF_EXITING)) {
 				new_timer->it_process = process;
 				list_add(&new_timer->list,
 					 &process->signal->posix_timers);
-				spin_unlock_irqrestore(&process->sighand->siglock, flags);
+				_spin_unlock_irqrestore(&process->sighand->siglock, flags);
 				if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
 					get_task_struct(process);
 			} else {
-				spin_unlock_irqrestore(&process->sighand->siglock, flags);
+				_spin_unlock_irqrestore(&process->sighand->siglock, flags);
 				process = NULL;
 			}
 		}
@@ -672,10 +672,10 @@ sys_timer_create(clockid_t which_clock,
 		new_timer->it_sigev_signo = SIGALRM;
 		new_timer->it_sigev_value.sival_int = new_timer->it_id;
 		process = current->group_leader;
-		spin_lock_irqsave(&process->sighand->siglock, flags);
+		_spin_lock_irqsave(&process->sighand->siglock, flags);
 		new_timer->it_process = process;
 		list_add(&new_timer->list, &process->signal->posix_timers);
-		spin_unlock_irqrestore(&process->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&process->sighand->siglock, flags);
 	}
 
  	/*
@@ -1098,9 +1098,9 @@ retry_delete:
 #else
 	p_timer_del(&posix_clocks[timer->it_clock], timer);
 #endif
-	spin_lock(&current->sighand->siglock);
+	_spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
-	spin_unlock(&current->sighand->siglock);
+	_spin_unlock(&current->sighand->siglock);
 	/*
 	 * This keeps any tasks waiting on the spin lock from thinking
 	 * they got something (see the lock code above).
diff -pruN a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/power/process.c	2004-10-09 01:26:57.000000000 +0400
@@ -43,9 +43,9 @@ void refrigerator(unsigned long flag)
 	printk("=");
 	current->flags &= ~PF_FREEZE;
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
@@ -78,9 +78,9 @@ int freeze_processes(void)
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
 			p->flags |= PF_FREEZE;
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			_spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			_spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
diff -pruN a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/printk.c	2004-10-09 01:26:58.000000000 +0400
@@ -77,7 +77,7 @@ static int console_locked;
  * It is also used in interesting ways to provide interlocking in
  * release_console_sem().
  */
-static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
+static _spinlock_t logbuf_lock = _SPIN_LOCK_UNLOCKED;
 
 static char __log_buf[__LOG_BUF_LEN];
 static char *log_buf = __log_buf;
@@ -204,7 +204,7 @@ static int __init log_buf_len_setup(char
 			goto out;
 		}
 
-		spin_lock_irqsave(&logbuf_lock, flags);
+		_spin_lock_irqsave(&logbuf_lock, flags);
 		log_buf_len = size;
 		log_buf = new_log_buf;
 
@@ -218,7 +218,7 @@ static int __init log_buf_len_setup(char
 		log_start -= offset;
 		con_start -= offset;
 		log_end -= offset;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 
 		printk("log_buf_len: %d\n", log_buf_len);
 	}
@@ -274,17 +274,17 @@ int do_syslog(int type, char __user * bu
 		if (error)
 			goto out;
 		i = 0;
-		spin_lock_irq(&logbuf_lock);
+		_spin_lock_irq(&logbuf_lock);
 		while (!error && (log_start != log_end) && i < len) {
 			c = LOG_BUF(log_start);
 			log_start++;
-			spin_unlock_irq(&logbuf_lock);
+			_spin_unlock_irq(&logbuf_lock);
 			error = __put_user(c,buf);
 			buf++;
 			i++;
-			spin_lock_irq(&logbuf_lock);
+			_spin_lock_irq(&logbuf_lock);
 		}
-		spin_unlock_irq(&logbuf_lock);
+		_spin_unlock_irq(&logbuf_lock);
 		if (!error)
 			error = i;
 		break;
@@ -304,7 +304,7 @@ int do_syslog(int type, char __user * bu
 		count = len;
 		if (count > log_buf_len)
 			count = log_buf_len;
-		spin_lock_irq(&logbuf_lock);
+		_spin_lock_irq(&logbuf_lock);
 		if (count > logged_chars)
 			count = logged_chars;
 		if (do_clear)
@@ -321,11 +321,11 @@ int do_syslog(int type, char __user * bu
 			if (j + log_buf_len < log_end)
 				break;
 			c = LOG_BUF(j);
-			spin_unlock_irq(&logbuf_lock);
+			_spin_unlock_irq(&logbuf_lock);
 			error = __put_user(c,&buf[count-1-i]);
-			spin_lock_irq(&logbuf_lock);
+			_spin_lock_irq(&logbuf_lock);
 		}
-		spin_unlock_irq(&logbuf_lock);
+		_spin_unlock_irq(&logbuf_lock);
 		if (error)
 			break;
 		error = i;
@@ -489,7 +489,7 @@ static void zap_locks(void)
 	oops_timestamp = jiffies;
 
 	/* If a crash is occurring, make sure we can't deadlock */
-	spin_lock_init(&logbuf_lock);
+	_spin_lock_init(&logbuf_lock);
 	/* And make sure that we print immediately */
 	init_MUTEX(&console_sem);
 }
@@ -531,7 +531,7 @@ asmlinkage int vprintk(const char *fmt, 
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
-	spin_lock_irqsave(&logbuf_lock, flags);
+	_spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -562,7 +562,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * CPU until it is officially up.  We shouldn't be calling into
 		 * random console drivers on a CPU which doesn't exist yet..
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 		goto out;
 	}
 	if (!down_trylock(&console_sem)) {
@@ -571,7 +571,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 		console_may_schedule = 0;
 		release_console_sem();
 	} else {
@@ -580,7 +580,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
 	return printed_len;
@@ -633,20 +633,20 @@ void release_console_sem(void)
 	unsigned long wake_klogd = 0;
 
 	for ( ; ; ) {
-		spin_lock_irqsave(&logbuf_lock, flags);
+		_spin_lock_irqsave(&logbuf_lock, flags);
 		wake_klogd |= log_start - log_end;
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 		call_console_drivers(_con_start, _log_end);
 	}
 	console_locked = 0;
 	console_may_schedule = 0;
 	up(&console_sem);
-	spin_unlock_irqrestore(&logbuf_lock, flags);
+	_spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
 }
@@ -804,9 +804,9 @@ void register_console(struct console * c
 		 * release_console_sem() will print out the buffered messages
 		 * for us.
 		 */
-		spin_lock_irqsave(&logbuf_lock, flags);
+		_spin_lock_irqsave(&logbuf_lock, flags);
 		con_start = log_start;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		_spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 	release_console_sem();
 }
diff -pruN a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/ptrace.c	2004-10-09 01:26:58.000000000 +0400
@@ -84,13 +84,13 @@ int ptrace_check_attach(struct task_stru
 	if ((child->ptrace & PT_PTRACED) && child->parent == current &&
 	    child->signal != NULL) {
 		ret = 0;
-		spin_lock_irq(&child->sighand->siglock);
+		_spin_lock_irq(&child->sighand->siglock);
 		if (child->state == TASK_STOPPED) {
 			child->state = TASK_TRACED;
 		} else if (child->state != TASK_TRACED && !kill) {
 			ret = -ESRCH;
 		}
-		spin_unlock_irq(&child->sighand->siglock);
+		_spin_unlock_irq(&child->sighand->siglock);
 	}
 	read_unlock(&tasklist_lock);
 
@@ -344,3 +344,4 @@ int ptrace_request(struct task_struct *c
 
 	return ret;
 }
+
diff -pruN a/kernel/rcupdate.c b/kernel/rcupdate.c
--- a/kernel/rcupdate.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/rcupdate.c	2004-10-09 01:26:58.000000000 +0400
@@ -72,6 +72,10 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10;
 
+#ifdef CONFIG_KRCU_LOCKS
+int rcu_write_disable = 0;
+#endif
+
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
diff -pruN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-10-09 01:23:21.000000000 +0400
+++ b/kernel/sched.c	2004-10-09 01:30:04.000000000 +0400
@@ -214,7 +214,7 @@ struct prio_array {
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct runqueue {
-	spinlock_t lock;
+	_spinlock_t lock;
 
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
@@ -436,7 +436,7 @@ struct sched_domain {
  */
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next)	do { } while (0)
-# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
+# define finish_arch_switch(rq, next)	_spin_unlock_irq(&(rq)->lock)
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
@@ -465,9 +465,9 @@ repeat_lock_task:
 
 	local_irq_save(*flags);
 	rq = task_rq(p);
-	spin_lock(&rq->lock);
+	_spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
-		spin_unlock_irqrestore(&rq->lock, *flags);
+		_spin_unlock_irqrestore(&rq->lock, *flags);
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -475,7 +475,7 @@ repeat_lock_task:
 
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
-	spin_unlock_irqrestore(&rq->lock, *flags);
+	_spin_unlock_irqrestore(&rq->lock, *flags);
 }
 
 #ifdef CONFIG_SCHEDSTATS
@@ -585,14 +585,14 @@ static runqueue_t *this_rq_lock(void)
 
 	local_irq_disable();
 	rq = this_rq();
-	spin_lock(&rq->lock);
+	_spin_lock(&rq->lock);
 
 	return rq;
 }
 
 static inline void rq_unlock(runqueue_t *rq)
 {
-	spin_unlock_irq(&rq->lock);
+	_spin_unlock_irq(&rq->lock);
 }
 
 #ifdef CONFIG_SCHEDSTATS
@@ -930,7 +930,7 @@ static void resched_task(task_t *p)
 {
 	int need_resched, nrpolling;
 
-	BUG_ON(!spin_is_locked(&task_rq(p)->lock));
+	BUG_ON(!_spin_is_locked(&task_rq(p)->lock));
 
 	/* minimise the chance of sending an interrupt to poll_idle() */
 	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
@@ -1600,14 +1600,14 @@ unsigned long nr_iowait(void)
 static void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	if (rq1 == rq2)
-		spin_lock(&rq1->lock);
+		_spin_lock(&rq1->lock);
 	else {
 		if (rq1 < rq2) {
-			spin_lock(&rq1->lock);
-			spin_lock(&rq2->lock);
+			_spin_lock(&rq1->lock);
+			_spin_lock(&rq2->lock);
 		} else {
-			spin_lock(&rq2->lock);
-			spin_lock(&rq1->lock);
+			_spin_lock(&rq2->lock);
+			_spin_lock(&rq1->lock);
 		}
 	}
 }
@@ -1620,9 +1620,9 @@ static void double_rq_lock(runqueue_t *r
  */
 static void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
 {
-	spin_unlock(&rq1->lock);
+	_spin_unlock(&rq1->lock);
 	if (rq1 != rq2)
-		spin_unlock(&rq2->lock);
+		_spin_unlock(&rq2->lock);
 }
 
 /*
@@ -1630,13 +1630,13 @@ static void double_rq_unlock(runqueue_t 
  */
 static void double_lock_balance(runqueue_t *this_rq, runqueue_t *busiest)
 {
-	if (unlikely(!spin_trylock(&busiest->lock))) {
+	if (unlikely(!_spin_trylock(&busiest->lock))) {
 		if (busiest < this_rq) {
-			spin_unlock(&this_rq->lock);
-			spin_lock(&busiest->lock);
-			spin_lock(&this_rq->lock);
+			_spin_unlock(&this_rq->lock);
+			_spin_lock(&busiest->lock);
+			_spin_lock(&this_rq->lock);
 		} else
-			spin_lock(&busiest->lock);
+			_spin_lock(&busiest->lock);
 	}
 }
 
@@ -2070,7 +2070,7 @@ static int load_balance(int this_cpu, ru
 	unsigned long imbalance;
 	int nr_moved;
 
-	spin_lock(&this_rq->lock);
+	_spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
 
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
@@ -2108,9 +2108,9 @@ static int load_balance(int this_cpu, ru
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 						imbalance, sd, idle);
-		spin_unlock(&busiest->lock);
+		_spin_unlock(&busiest->lock);
 	}
-	spin_unlock(&this_rq->lock);
+	_spin_unlock(&this_rq->lock);
 
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[idle]);
@@ -2119,13 +2119,13 @@ static int load_balance(int this_cpu, ru
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 			int wake = 0;
 
-			spin_lock(&busiest->lock);
+			_spin_lock(&busiest->lock);
 			if (!busiest->active_balance) {
 				busiest->active_balance = 1;
 				busiest->push_cpu = this_cpu;
 				wake = 1;
 			}
-			spin_unlock(&busiest->lock);
+			_spin_unlock(&busiest->lock);
 			if (wake)
 				wake_up_process(busiest->migration_thread);
 
@@ -2144,7 +2144,7 @@ static int load_balance(int this_cpu, ru
 	return nr_moved;
 
 out_balanced:
-	spin_unlock(&this_rq->lock);
+	_spin_unlock(&this_rq->lock);
 
 	/* tune up the balancing interval */
 	if (sd->balance_interval < sd->max_interval)
@@ -2190,7 +2190,7 @@ static int load_balance_newidle(int this
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 
-	spin_unlock(&busiest->lock);
+	_spin_unlock(&busiest->lock);
 
 out:
 	return nr_moved;
@@ -2279,7 +2279,7 @@ static void active_load_balance(runqueue
 		} else {
 			schedstat_inc(busiest, alb_failed);
 		}
-		spin_unlock(&rq->lock);
+		_spin_unlock(&rq->lock);
 next_group:
 		group = group->next;
 	} while (group != sd->groups);
@@ -2435,7 +2435,7 @@ void scheduler_tick(int user_ticks, int 
 		set_tsk_need_resched(p);
 		goto out;
 	}
-	spin_lock(&rq->lock);
+	_spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -2503,7 +2503,7 @@ void scheduler_tick(int user_ticks, int 
 		}
 	}
 out_unlock:
-	spin_unlock(&rq->lock);
+	_spin_unlock(&rq->lock);
 out:
 	rebalance_tick(cpu, rq, NOT_IDLE);
 }
@@ -2822,7 +2822,7 @@ need_resched:
 	if (HIGH_CREDIT(prev))
 		run_time /= (CURRENT_BONUS(prev) ? : 1);
 
-	spin_lock_irq(&rq->lock);
+	_spin_lock_irq(&rq->lock);
 
 	/*
 	 * if entering off of a kernel preemption go straight
@@ -2925,7 +2925,7 @@ switch_tasks:
 
 		finish_task_switch(prev);
 	} else
-		spin_unlock_irq(&rq->lock);
+		_spin_unlock_irq(&rq->lock);
 
 #ifdef CONFIG_INGO_BKL
 	reacquire_kernel_sem(current);
@@ -3030,9 +3030,9 @@ void fastcall __wake_up(wait_queue_head_
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	__wake_up_common(q, mode, nr_exclusive, 0, key);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(__wake_up);
@@ -3069,9 +3069,9 @@ void fastcall __wake_up_sync(wait_queue_
 	if (unlikely(!nr_exclusive))
 		sync = 0;
 
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	__wake_up_common(q, mode, nr_exclusive, sync, NULL);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
@@ -3079,11 +3079,11 @@ void fastcall complete(struct completion
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
 			 1, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
 
@@ -3091,18 +3091,18 @@ void fastcall complete_all(struct comple
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
 			 0, 0, NULL);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
 void fastcall __sched wait_for_completion(struct completion *x)
 {
 	might_sleep();
-	spin_lock_irq(&x->wait.lock);
+	_spin_lock_irq(&x->wait.lock);
 	if (!x->done) {
 		DECLARE_WAITQUEUE(wait, current);
 
@@ -3110,14 +3110,14 @@ void fastcall __sched wait_for_completio
 		__add_wait_queue_tail(&x->wait, &wait);
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&x->wait.lock);
+			_spin_unlock_irq(&x->wait.lock);
 			schedule();
-			spin_lock_irq(&x->wait.lock);
+			_spin_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
-	spin_unlock_irq(&x->wait.lock);
+	_spin_unlock_irq(&x->wait.lock);
 }
 EXPORT_SYMBOL(wait_for_completion);
 
@@ -3127,14 +3127,14 @@ EXPORT_SYMBOL(wait_for_completion);
 	init_waitqueue_entry(&wait, current);
 
 #define SLEEP_ON_HEAD					\
-	spin_lock_irqsave(&q->lock,flags);		\
+	_spin_lock_irqsave(&q->lock,flags);		\
 	__add_wait_queue(q, &wait);			\
-	spin_unlock(&q->lock);
+	_spin_unlock(&q->lock);
 
 #define	SLEEP_ON_TAIL					\
-	spin_lock_irq(&q->lock);			\
+	_spin_lock_irq(&q->lock);			\
 	__remove_wait_queue(q, &wait);			\
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 
 void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
 {
@@ -4000,10 +4000,10 @@ void __devinit init_idle(task_t *idle, i
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
 
-	spin_lock_irqsave(&rq->lock, flags);
+	_spin_lock_irqsave(&rq->lock, flags);
 	rq->curr = rq->idle = idle;
 	set_tsk_need_resched(idle);
-	spin_unlock_irqrestore(&rq->lock, flags);
+	_spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #if defined CONFIG_PREEMPT && !defined CONFIG_INGO_BKL
@@ -4159,10 +4159,10 @@ static int migration_thread(void * data)
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 
-		spin_lock_irq(&rq->lock);
+		_spin_lock_irq(&rq->lock);
 
 		if (cpu_is_offline(cpu)) {
-			spin_unlock_irq(&rq->lock);
+			_spin_unlock_irq(&rq->lock);
 			goto wait_to_die;
 		}
 
@@ -4174,7 +4174,7 @@ static int migration_thread(void * data)
 		head = &rq->migration_queue;
 
 		if (list_empty(head)) {
-			spin_unlock_irq(&rq->lock);
+			_spin_unlock_irq(&rq->lock);
 			schedule();
 			set_current_state(TASK_INTERRUPTIBLE);
 			continue;
@@ -4183,15 +4183,15 @@ static int migration_thread(void * data)
 		list_del_init(head->next);
 
 		if (req->type == REQ_MOVE_TASK) {
-			spin_unlock(&rq->lock);
+			_spin_unlock(&rq->lock);
 			__migrate_task(req->task, smp_processor_id(),
 					req->dest_cpu);
 			local_irq_enable();
 		} else if (req->type == REQ_SET_DOMAIN) {
 			rq->sd = req->sd;
-			spin_unlock_irq(&rq->lock);
+			_spin_unlock_irq(&rq->lock);
 		} else {
-			spin_unlock_irq(&rq->lock);
+			_spin_unlock_irq(&rq->lock);
 			WARN_ON(1);
 		}
 
@@ -4280,13 +4280,13 @@ void sched_idle_next(void)
 	/* Strictly not necessary since rest of the CPUs are stopped by now
 	 * and interrupts disabled on current cpu.
 	 */
-	spin_lock_irqsave(&rq->lock, flags);
+	_spin_lock_irqsave(&rq->lock, flags);
 
 	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
 	/* Add idle task to _front_ of it's priority queue */
 	__activate_idle_task(p, rq);
 
-	spin_unlock_irqrestore(&rq->lock, flags);
+	_spin_unlock_irqrestore(&rq->lock, flags);
 }
 
 static void migrate_dead(unsigned int dead_cpu, task_t *tsk)
@@ -4384,7 +4384,7 @@ static int migration_call(struct notifie
 		/* No need to migrate the tasks: it was best-effort if
 		 * they didn't do lock_cpu_hotplug().  Just wake up
 		 * the requestors. */
-		spin_lock_irq(&rq->lock);
+		_spin_lock_irq(&rq->lock);
 		while (!list_empty(&rq->migration_queue)) {
 			migration_req_t *req;
 			req = list_entry(rq->migration_queue.next,
@@ -4393,7 +4393,7 @@ static int migration_call(struct notifie
 			list_del_init(&req->list);
 			complete(&req->done);
 		}
-		spin_unlock_irq(&rq->lock);
+		_spin_unlock_irq(&rq->lock);
 		break;
 #endif
 	}
@@ -4432,7 +4432,7 @@ int __init migration_init(void)
  * Note: spinlock debugging needs this even on !CONFIG_SMP.
  */
 #if !defined(CONFIG_INGO_BKL) 
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+_spinlock_t kernel_flag __cacheline_aligned_in_smp = _SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(kernel_flag);
 #endif
 
@@ -4448,7 +4448,7 @@ static void cpu_attach_domain(struct sch
 
 	lock_cpu_hotplug();
 
-	spin_lock_irqsave(&rq->lock, flags);
+	_spin_lock_irqsave(&rq->lock, flags);
 
 	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
 		rq->sd = sd;
@@ -4460,7 +4460,7 @@ static void cpu_attach_domain(struct sch
 		local = 0;
 	}
 
-	spin_unlock_irqrestore(&rq->lock, flags);
+	_spin_unlock_irqrestore(&rq->lock, flags);
 
 	if (!local) {
 		wake_up_process(rq->migration_thread);
@@ -4933,7 +4933,7 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
-		spin_lock_init(&rq->lock);
+		_spin_lock_init(&rq->lock);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
@@ -5009,7 +5009,7 @@ EXPORT_SYMBOL(__might_sleep);
  * Called inside preempt_disable().
  */
 
-/* these functions are only called from inside spin_lock
+/* these functions are only called from inside _spin_lock
  * and old_write_lock therefore under spinlock substitution 
  * they will only be passed old spinlocks or old rwlocks as parameter 
  * there are no issues with modified mutex behavior here. */
diff -pruN a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/signal.c	2004-10-09 01:26:58.000000000 +0400
@@ -26,6 +26,8 @@
 #include <asm/unistd.h>
 #include <asm/siginfo.h>
 
+# include <linux/spin_undefs.h>
+
 extern void k_getrusage(struct task_struct *, int, struct rusage *);
 
 /*
diff -pruN a/kernel/spinlock.c b/kernel/spinlock.c
--- a/kernel/spinlock.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/spinlock.c	2004-10-09 01:26:58.000000000 +0400
@@ -11,6 +11,13 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
+/* the KMUTEX macro replaces the definition of spinlock.
+ * we don't want this to happen here */
+#ifdef CONFIG_KMUTEX
+# undef spinlock_t
+# define spinlock_t _spinlock_t
+#endif 
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
@@ -53,7 +60,7 @@ static inline void __preempt_spin_lock(s
 
 	do {
 		preempt_enable();
-		while (spin_is_locked(lock))
+		while (_spin_is_locked(lock))
 			cpu_relax();
 		preempt_disable();
 	} while (!_raw_spin_trylock(lock));
@@ -131,7 +138,7 @@ void __lockfunc _read_unlock(rwlock_t *l
 }
 EXPORT_SYMBOL(_read_unlock);
 
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+unsigned long __lockfunc __spin_lock_irqsave(spinlock_t *lock)
 {
 	unsigned long flags;
 
@@ -140,7 +147,7 @@ unsigned long __lockfunc _spin_lock_irqs
 	_raw_spin_lock_flags(lock, flags);
 	return flags;
 }
-EXPORT_SYMBOL(_spin_lock_irqsave);
+EXPORT_SYMBOL(__spin_lock_irqsave);
 
 void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
diff -pruN a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/sys.c	2004-10-09 01:26:58.000000000 +0400
@@ -969,10 +969,10 @@ asmlinkage long sys_times(struct tms __u
 		 * To make sure we always see that pair updated atomically,
 		 * we take the siglock around fetching them.
 		 */
-		spin_lock_irq(&tsk->sighand->siglock);
+		_spin_lock_irq(&tsk->sighand->siglock);
 		cutime = tsk->signal->cutime;
 		cstime = tsk->signal->cstime;
-		spin_unlock_irq(&tsk->sighand->siglock);
+		_spin_unlock_irq(&tsk->sighand->siglock);
 		read_unlock(&tasklist_lock);
 
 		tmp.tms_utime = jiffies_to_clock_t(utime);
@@ -1585,23 +1585,23 @@ void k_getrusage(struct task_struct *p, 
 
 	switch (who) {
 		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			_spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			_spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			jiffies_to_timeval(utime, &r->ru_utime);
 			jiffies_to_timeval(stime, &r->ru_stime);
 			break;
 		case RUSAGE_SELF:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			_spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = stime = 0;
 			goto sum_group;
 		case RUSAGE_BOTH:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			_spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
@@ -1625,7 +1625,7 @@ void k_getrusage(struct task_struct *p, 
 				r->ru_majflt += t->maj_flt;
 				t = next_thread(t);
 			} while (t != p);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			_spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			jiffies_to_timeval(utime, &r->ru_utime);
 			jiffies_to_timeval(stime, &r->ru_stime);
 			break;
diff -pruN a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/timer.c	2004-10-09 01:26:58.000000000 +0400
@@ -62,7 +62,7 @@ typedef struct tvec_root_s {
 } tvec_root_t;
 
 struct tvec_t_base_s {
-	spinlock_t lock;
+	_spinlock_t lock;
 	unsigned long timer_jiffies;
 	struct timer_list *running_timer;
 	tvec_root_t tv1;
@@ -83,7 +83,7 @@ static inline void set_running_timer(tve
 }
 
 /* Fake initialization */
-static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
+static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { _SPIN_LOCK_UNLOCKED };
 
 static void check_timer_failed(struct timer_list *timer)
 {
@@ -171,26 +171,49 @@ repeat:
 	 * Prevent deadlocks via ordering by old_base < new_base.
 	 */
 	if (old_base && (new_base != old_base)) {
+#ifdef CONFIG_KMUTEX
 		if (old_base < new_base) {
-			spin_lock(&new_base->lock);
-			spin_lock(&old_base->lock);
+			_spin_lock_irqsave(&new_base->lock, flags);
+			_spin_lock_irqsave(&old_base->lock, flags);
 		} else {
-			spin_lock(&old_base->lock);
-			spin_lock(&new_base->lock);
+			_spin_lock_irqsave(&old_base->lock, flags);
+			_spin_lock_irqsave(&new_base->lock, flags);
 		}
+#else
+		if (old_base < new_base) {
+			_spin_lock(&new_base->lock);
+			_spin_lock(&old_base->lock);
+		} else {
+			_spin_lock(&old_base->lock);
+			_spin_lock(&new_base->lock);
+		}
+#endif
 		/*
 		 * The timer base might have been cancelled while we were
 		 * trying to take the lock(s):
 		 */
 		if (timer->base != old_base) {
-			spin_unlock(&new_base->lock);
-			spin_unlock(&old_base->lock);
+#ifdef CONFIG_KMUTEX
+			_spin_unlock_irqrestore(&new_base->lock, flags);
+			_spin_unlock_irqrestore(&old_base->lock, flags);
+#else
+			_spin_unlock(&new_base->lock);
+			_spin_unlock(&old_base->lock);
+#endif
 			goto repeat;
 		}
 	} else {
-		spin_lock(&new_base->lock);
+#ifdef CONFIG_KMUTEX
+		_spin_lock_irqsave(&new_base->lock, flags);
+#else
+		_spin_lock(&new_base->lock);
+#endif
 		if (timer->base != old_base) {
-			spin_unlock(&new_base->lock);
+#ifdef CONFIG_KMUTEX
+			_spin_unlock_irqrestore(&new_base->lock, flags);
+#else
+			_spin_unlock(&new_base->lock);
+#endif
 			goto repeat;
 		}
 	}
@@ -208,8 +231,13 @@ repeat:
 	timer->base = new_base;
 
 	if (old_base && (new_base != old_base))
-		spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
+#ifdef CONFIG_KMUTEX
+		_spin_unlock_irqrestore(&old_base->lock, flags);
+	_spin_unlock_irqrestore(&new_base->lock, flags);
+#else
+		_spin_unlock(&old_base->lock);
+	_spin_unlock(&new_base->lock);
+#endif
 	spin_unlock_irqrestore(&timer->lock, flags);
 
 	return ret;
@@ -233,10 +261,10 @@ void add_timer_on(struct timer_list *tim
 
 	check_timer(timer);
 
-	spin_lock_irqsave(&base->lock, flags);
+	_spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
 	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
+	_spin_unlock_irqrestore(&base->lock, flags);
 }
 
 EXPORT_SYMBOL(add_timer_on);
@@ -301,14 +329,14 @@ repeat:
  	base = timer->base;
 	if (!base)
 		return 0;
-	spin_lock_irqsave(&base->lock, flags);
+	_spin_lock_irqsave(&base->lock, flags);
 	if (base != timer->base) {
-		spin_unlock_irqrestore(&base->lock, flags);
+		_spin_unlock_irqrestore(&base->lock, flags);
 		goto repeat;
 	}
 	list_del(&timer->entry);
 	timer->base = NULL;
-	spin_unlock_irqrestore(&base->lock, flags);
+	_spin_unlock_irqrestore(&base->lock, flags);
 
 	return 1;
 }
@@ -432,7 +460,7 @@ static inline void __run_timers(tvec_bas
 {
 	struct timer_list *timer;
 
-	spin_lock_irq(&base->lock);
+	_spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -461,14 +489,14 @@ repeat:
 			set_running_timer(base, timer);
 			smp_wmb();
 			timer->base = NULL;
-			spin_unlock_irq(&base->lock);
+			_spin_unlock_irq(&base->lock);
 			fn(data);
-			spin_lock_irq(&base->lock);
+			_spin_lock_irq(&base->lock);
 			goto repeat;
 		}
 	}
 	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->lock);
+	_spin_unlock_irq(&base->lock);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -487,7 +515,7 @@ unsigned long next_timer_interrupt(void)
 	int i, j;
 
 	base = &__get_cpu_var(tvec_bases);
-	spin_lock(&base->lock);
+	_spin_lock(&base->lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = 0;
 
@@ -535,7 +563,7 @@ found:
 				expires = nte->expires;
 		}
 	}
-	spin_unlock(&base->lock);
+	_spin_unlock(&base->lock);
 	return expires;
 }
 #endif
@@ -919,7 +947,7 @@ EXPORT_SYMBOL(xtime_lock);
 static void run_timer_softirq(struct softirq_action *h)
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
-
+	
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
@@ -947,7 +975,7 @@ static inline void update_times(void)
 	}
 	calc_load(ticks);
 }
-  
+ 
 /*
  * The 64-bit jiffies value is not atomic - you MUST NOT read it
  * without sampling the sequence number in xtime_lock.
@@ -965,6 +993,7 @@ void do_timer(struct pt_regs *regs)
 	update_times();
 }
 
+
 #ifdef __ARCH_WANT_SYS_ALARM
 
 /*
@@ -1325,7 +1354,7 @@ static void __devinit init_timers_cpu(in
 	tvec_base_t *base;
        
 	base = &per_cpu(tvec_bases, cpu);
-	spin_lock_init(&base->lock);
+	_spin_lock_init(&base->lock);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
 		INIT_LIST_HEAD(base->tv4.vec + j);
@@ -1371,11 +1400,11 @@ static void __devinit migrate_timers(int
 again:
 	/* Prevent deadlocks via ordering by old_base < new_base. */
 	if (old_base < new_base) {
-		spin_lock(&new_base->lock);
-		spin_lock(&old_base->lock);
+		_spin_lock(&new_base->lock);
+		_spin_lock(&old_base->lock);
 	} else {
-		spin_lock(&old_base->lock);
-		spin_lock(&new_base->lock);
+		_spin_lock(&old_base->lock);
+		_spin_lock(&new_base->lock);
 	}
 
 	if (old_base->running_timer)
@@ -1389,16 +1418,16 @@ again:
 		    || !migrate_timer_list(new_base, old_base->tv4.vec + i)
 		    || !migrate_timer_list(new_base, old_base->tv5.vec + i))
 			goto unlock_again;
-	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
+	_spin_unlock(&old_base->lock);
+	_spin_unlock(&new_base->lock);
 	local_irq_enable();
 	put_cpu_var(tvec_bases);
 	return;
 
 unlock_again:
 	/* Avoid deadlock with __mod_timer, by backing off. */
-	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
+	_spin_unlock(&old_base->lock);
+	_spin_unlock(&new_base->lock);
 	cpu_relax();
 	goto again;
 }
diff -pruN a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2004-10-08 22:40:49.000000000 +0400
+++ b/lib/Makefile	2004-10-09 01:26:58.000000000 +0400
@@ -23,8 +23,8 @@ obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
-hostprogs-y	:= gen_crc32table
-clean-files	:= crc32table.h
+hostprogs-y   := gen_crc32table
+clean-files   := crc32table.h
 
 $(obj)/crc32.o: $(obj)/crc32table.h
 
diff -pruN a/lib/rwsem.c b/lib/rwsem.c
--- a/lib/rwsem.c	2004-10-08 22:40:49.000000000 +0400
+++ b/lib/rwsem.c	2004-10-09 01:26:58.000000000 +0400
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+# include <linux/spin_undefs.h>
+
 struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
diff -pruN a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/filemap.c	2004-10-09 01:26:58.000000000 +0400
@@ -125,9 +125,9 @@ void remove_from_page_cache(struct page 
 	if (unlikely(!PageLocked(page)))
 		PAGE_BUG(page);
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 }
 
 static inline int sync_page(struct page *page)
@@ -322,7 +322,7 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
-		spin_lock_irq(&mapping->tree_lock);
+		_spin_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			page_cache_get(page);
@@ -332,7 +332,7 @@ int add_to_page_cache(struct page *page,
 			mapping->nrpages++;
 			pagecache_acct(1);
 		}
-		spin_unlock_irq(&mapping->tree_lock);
+		_spin_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -501,11 +501,11 @@ struct page * find_get_page(struct addre
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -518,11 +518,11 @@ struct page *find_trylock_page(struct ad
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page && TestSetPageLocked(page))
 		page = NULL;
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -544,15 +544,15 @@ struct page *find_lock_page(struct addre
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
-			spin_unlock_irq(&mapping->tree_lock);
+			_spin_unlock_irq(&mapping->tree_lock);
 			lock_page(page);
-			spin_lock_irq(&mapping->tree_lock);
+			_spin_lock_irq(&mapping->tree_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -562,7 +562,7 @@ repeat:
 			}
 		}
 	}
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -636,12 +636,12 @@ unsigned find_get_pages(struct address_s
 	unsigned int i;
 	unsigned int ret;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
@@ -655,14 +655,14 @@ unsigned find_get_pages_tag(struct addre
 	unsigned int i;
 	unsigned int ret;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
 				(void **)pages, *index, nr_pages, tag);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
 	if (ret)
 		*index = pages[ret - 1]->index + 1;
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
diff -pruN a/mm/fremap.c b/mm/fremap.c
--- a/mm/fremap.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/fremap.c	2004-10-09 01:26:58.000000000 +0400
@@ -64,7 +64,7 @@ int install_page(struct mm_struct *mm, s
 	pte_t pte_val;
 
 	pgd = pgd_offset(mm, addr);
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
@@ -96,7 +96,7 @@ int install_page(struct mm_struct *mm, s
 
 	err = 0;
 err_unlock:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return err;
 }
 EXPORT_SYMBOL(install_page);
@@ -116,7 +116,7 @@ int install_file_pte(struct mm_struct *m
 	pte_t pte_val;
 
 	pgd = pgd_offset(mm, addr);
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
@@ -132,11 +132,11 @@ int install_file_pte(struct mm_struct *m
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return 0;
 
 err_unlock:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return err;
 }
 
diff -pruN a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/hugetlb.c	2004-10-09 01:26:58.000000000 +0400
@@ -253,7 +253,7 @@ void zap_hugepage_range(struct vm_area_s
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	unmap_hugepage_range(vma, start, start + length);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 }
diff -pruN a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/memory.c	2004-10-09 01:26:58.000000000 +0400
@@ -158,9 +158,9 @@ pte_t fastcall * pte_alloc_map(struct mm
 	if (!pmd_present(*pmd)) {
 		struct page *new;
 
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		new = pte_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		if (!new)
 			return NULL;
 
@@ -184,9 +184,9 @@ pte_t fastcall * pte_alloc_kernel(struct
 	if (!pmd_present(*pmd)) {
 		pte_t *new;
 
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		new = pte_alloc_one_kernel(mm, address);
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		if (!new)
 			return NULL;
 
@@ -275,7 +275,7 @@ skip_copy_pte_range:
 			dst_pte = pte_alloc_map(dst, dst_pmd, address);
 			if (!dst_pte)
 				goto nomem;
-			spin_lock(&src->page_table_lock);	
+			_spin_lock(&src->page_table_lock);	
 			src_pte = pte_offset_map_nested(src_pmd, address);
 			do {
 				pte_t pte = *src_pte;
@@ -340,15 +340,15 @@ cont_copy_pte_range_noset:
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
-			spin_unlock(&src->page_table_lock);
-			cond_resched_lock(&dst->page_table_lock);
+			_spin_unlock(&src->page_table_lock);
+			_cond_resched_lock(&dst->page_table_lock);
 cont_copy_pmd_range:
 			src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
 	}
 out_unlock:
-	spin_unlock(&src->page_table_lock);
+	_spin_unlock(&src->page_table_lock);
 out:
 	return 0;
 nomem:
@@ -570,7 +570,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 			if (!atomic && need_resched()) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
-				cond_resched_lock(&mm->page_table_lock);
+				_cond_resched_lock(&mm->page_table_lock);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
@@ -601,11 +601,11 @@ void zap_page_range(struct vm_area_struc
 	}
 
 	lru_add_drain();
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 }
 
 /*
@@ -762,7 +762,7 @@ int get_user_pages(struct task_struct *t
 						&start, &len, i);
 			continue;
 		}
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
 			int lookup_write = write;
@@ -779,7 +779,7 @@ int get_user_pages(struct task_struct *t
 					map = ZERO_PAGE(start);
 					break;
 				}
-				spin_unlock(&mm->page_table_lock);
+				_spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
@@ -802,12 +802,12 @@ int get_user_pages(struct task_struct *t
 				 * we are forcing write access.
 				 */
 				lookup_write = write && !force;
-				spin_lock(&mm->page_table_lock);
+				_spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
 				pages[i] = get_page_map(map);
 				if (!pages[i]) {
-					spin_unlock(&mm->page_table_lock);
+					_spin_unlock(&mm->page_table_lock);
 					while (i--)
 						page_cache_release(pages[i]);
 					i = -EFAULT;
@@ -823,7 +823,7 @@ int get_user_pages(struct task_struct *t
 			start += PAGE_SIZE;
 			len--;
 		} while(len && start < vma->vm_end);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 	} while(len);
 out:
 	return i;
@@ -884,7 +884,7 @@ int zeromap_page_range(struct vm_area_st
 	if (address >= end)
 		BUG();
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(mm, dir, address);
 		error = -ENOMEM;
@@ -900,7 +900,7 @@ int zeromap_page_range(struct vm_area_st
 	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
 	 */
 	flush_tlb_range(vma, beg, end);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return error;
 }
 
@@ -968,7 +968,7 @@ int remap_page_range(struct vm_area_stru
 	if (from >= end)
 		BUG();
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(mm, dir, from);
 		error = -ENOMEM;
@@ -984,7 +984,7 @@ int remap_page_range(struct vm_area_stru
 	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
 	 */
 	flush_tlb_range(vma, beg, end);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return error;
 }
 
@@ -1054,7 +1054,7 @@ static int do_wp_page(struct mm_struct *
 		pte_unmap(page_table);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		return VM_FAULT_OOM;
 	}
 	old_page = pfn_to_page(pfn);
@@ -1069,7 +1069,7 @@ static int do_wp_page(struct mm_struct *
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			_spin_unlock(&mm->page_table_lock);
 			return VM_FAULT_MINOR;
 		}
 	}
@@ -1080,7 +1080,7 @@ static int do_wp_page(struct mm_struct *
 	 */
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
@@ -1092,7 +1092,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageReserved(old_page))
@@ -1109,7 +1109,7 @@ static int do_wp_page(struct mm_struct *
 	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 
 no_new_page:
@@ -1327,7 +1327,7 @@ static int do_swap_page(struct mm_struct
 	int ret = VM_FAULT_MINOR;
 
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1337,14 +1337,14 @@ static int do_swap_page(struct mm_struct
 			 * Back out if somebody else faulted in this pte while
 			 * we released the page table lock.
 			 */
-			spin_lock(&mm->page_table_lock);
+			_spin_lock(&mm->page_table_lock);
 			page_table = pte_offset_map(pmd, address);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
 			else
 				ret = VM_FAULT_MINOR;
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			_spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
 
@@ -1361,11 +1361,11 @@ static int do_swap_page(struct mm_struct
 	 * Back out if somebody else faulted in this pte while we
 	 * released the page table lock.
 	 */
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (unlikely(!pte_same(*page_table, orig_pte))) {
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
 		page_cache_release(page);
 		ret = VM_FAULT_MINOR;
@@ -1400,7 +1400,7 @@ static int do_swap_page(struct mm_struct
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
 }
@@ -1425,7 +1425,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
@@ -1434,13 +1434,13 @@ do_anonymous_page(struct mm_struct *mm, 
 			goto no_mem;
 		clear_user_highpage(page, addr);
 
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);
 
 		if (!pte_none(*page_table)) {
 			pte_unmap(page_table);
 			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
+			_spin_unlock(&mm->page_table_lock);
 			goto out;
 		}
 		mm->rss++;
@@ -1457,7 +1457,7 @@ do_anonymous_page(struct mm_struct *mm, 
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out:
 	return VM_FAULT_MINOR;
 no_mem:
@@ -1491,7 +1491,7 @@ do_no_page(struct mm_struct *mm, struct 
 		return do_anonymous_page(mm, vma, page_table,
 					pmd, write_access, address);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -1524,7 +1524,7 @@ retry:
 		anon = 1;
 	}
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	/*
 	 * For a file-backed vma, someone could have truncated or otherwise
 	 * invalidated this page.  If unmap_mapping_range got called,
@@ -1533,7 +1533,7 @@ retry:
 	if (mapping &&
 	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
 		sequence = atomic_read(&mapping->truncate_count);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
 		goto retry;
 	}
@@ -1568,13 +1568,13 @@ retry:
 		/* One of our sibling threads was faster, back out. */
 		pte_unmap(page_table);
 		page_cache_release(new_page);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 		goto out;
 	}
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
 oom:
@@ -1608,7 +1608,7 @@ static int do_file_page(struct mm_struct
 	pgoff = pte_to_pgoff(*pte);
 
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
 	if (err == -ENOMEM)
@@ -1669,7 +1669,7 @@ static inline int handle_pte_fault(struc
 	ptep_set_access_flags(vma, address, pte, entry, write_access);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
 }
 
@@ -1694,7 +1694,7 @@ int handle_mm_fault(struct mm_struct *mm
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
 	 */
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 
 	if (pmd) {
@@ -1702,7 +1702,7 @@ int handle_mm_fault(struct mm_struct *mm
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }
 
@@ -1719,9 +1719,9 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 {
 	pmd_t *new;
 
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	if (!new)
 		return NULL;
 
diff -pruN a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/mmap.c	2004-10-09 01:26:58.000000000 +0400
@@ -1707,9 +1707,9 @@ int do_munmap(struct mm_struct *mm, unsi
 	 * Remove the vma's, and unmap the actual pages
 	 */
 	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	unmap_region(mm, mpnt, prev, start, end);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
 	unmap_vma_list(mm, mpnt);
@@ -1830,7 +1830,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	lru_add_drain();
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 
 	tlb = tlb_gather_mmu(mm, 1);
 	flush_cache_mm(mm);
@@ -1849,7 +1849,7 @@ void exit_mmap(struct mm_struct *mm)
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	/*
 	 * Walk the list again, actually closing and freeing it
diff -pruN a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/mprotect.c	2004-10-09 01:26:58.000000000 +0400
@@ -97,14 +97,14 @@ change_protection(struct vm_area_struct 
 	flush_cache_range(vma, beg, end);
 	if (start >= end)
 		BUG();
-	spin_lock(&current->mm->page_table_lock);
+	_spin_lock(&current->mm->page_table_lock);
 	do {
 		change_pmd_range(dir, start, end - start, newprot);
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
 	flush_tlb_range(vma, beg, end);
-	spin_unlock(&current->mm->page_table_lock);
+	_spin_unlock(&current->mm->page_table_lock);
 	return;
 }
 
diff -pruN a/mm/mremap.c b/mm/mremap.c
--- a/mm/mremap.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/mremap.c	2004-10-09 01:26:58.000000000 +0400
@@ -98,7 +98,7 @@ move_one_page(struct vm_area_struct *vma
 		mapping = vma->vm_file->f_mapping;
 		spin_lock(&mapping->i_mmap_lock);
 	}
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 
 	src = get_one_pte_map_nested(mm, old_addr);
 	if (src) {
@@ -114,9 +114,9 @@ move_one_page(struct vm_area_struct *vma
 				spin_unlock(&mapping->i_mmap_lock);
 			dst = alloc_one_pte_map(mm, new_addr);
 			if (mapping && !spin_trylock(&mapping->i_mmap_lock)) {
-				spin_unlock(&mm->page_table_lock);
+				_spin_unlock(&mm->page_table_lock);
 				spin_lock(&mapping->i_mmap_lock);
-				spin_lock(&mm->page_table_lock);
+				_spin_lock(&mm->page_table_lock);
 			}
 			src = get_one_pte_map_nested(mm, old_addr);
 		}
@@ -136,7 +136,7 @@ move_one_page(struct vm_area_struct *vma
 		if (dst)
 			pte_unmap(dst);
 	}
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 	return error;
diff -pruN a/mm/msync.c b/mm/msync.c
--- a/mm/msync.c	2004-08-14 09:36:56.000000000 +0400
+++ b/mm/msync.c	2004-10-09 01:26:58.000000000 +0400
@@ -102,7 +102,7 @@ static int filemap_sync(struct vm_area_s
 	/* Aquire the lock early; it may be possible to avoid dropping
 	 * and reaquiring it repeatedly.
 	 */
-	spin_lock(&vma->vm_mm->page_table_lock);
+	_spin_lock(&vma->vm_mm->page_table_lock);
 
 	dir = pgd_offset(vma->vm_mm, address);
 	flush_cache_range(vma, address, end);
@@ -126,7 +126,7 @@ static int filemap_sync(struct vm_area_s
 	 */
 	flush_tlb_range(vma, end - size, end);
  out:
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	_spin_unlock(&vma->vm_mm->page_table_lock);
 
 	return error;
 }
diff -pruN a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/page_alloc.c	2004-10-09 01:26:58.000000000 +0400
@@ -1500,7 +1500,7 @@ static void __init free_area_init_core(s
 		zone->present_pages = realsize;
 		zone->name = zone_names[j];
 		spin_lock_init(&zone->lock);
-		spin_lock_init(&zone->lru_lock);
+		_spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
@@ -1908,7 +1908,7 @@ static void setup_per_zone_pages_min(voi
 	}
 
 	for_each_zone(zone) {
-		spin_lock_irqsave(&zone->lru_lock, flags);
+		_spin_lock_irqsave(&zone->lru_lock, flags);
 		if (is_highmem(zone)) {
 			/*
 			 * Often, highmem doesn't need to reserve any pages.
@@ -1934,7 +1934,7 @@ static void setup_per_zone_pages_min(voi
 
 		zone->pages_low = zone->pages_min * 2;
 		zone->pages_high = zone->pages_min * 3;
-		spin_unlock_irqrestore(&zone->lru_lock, flags);
+		_spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }
 
diff -pruN a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/page-writeback.c	2004-10-09 01:26:58.000000000 +0400
@@ -584,7 +584,7 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping = page_mapping(page);
 
 		if (mapping) {
-			spin_lock_irq(&mapping->tree_lock);
+			_spin_lock_irq(&mapping->tree_lock);
 			mapping = page_mapping(page);
 			if (page_mapping(page)) { /* Race with truncate? */
 				BUG_ON(page_mapping(page) != mapping);
@@ -593,7 +593,7 @@ int __set_page_dirty_nobuffers(struct pa
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
-			spin_unlock_irq(&mapping->tree_lock);
+			_spin_unlock_irq(&mapping->tree_lock);
 			if (mapping->host) {
 				/* !PageAnon && !swapper_space */
 				__mark_inode_dirty(mapping->host,
@@ -668,17 +668,17 @@ int test_clear_page_dirty(struct page *p
 	unsigned long flags;
 
 	if (mapping) {
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		_spin_lock_irqsave(&mapping->tree_lock, flags);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			spin_unlock_irqrestore(&mapping->tree_lock, flags);
+			_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 			if (!mapping->backing_dev_info->memory_backed)
 				dec_page_state(nr_dirty);
 			return 1;
 		}
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -725,15 +725,15 @@ int __clear_page_dirty(struct page *page
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		_spin_lock_irqsave(&mapping->tree_lock, flags);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			spin_unlock_irqrestore(&mapping->tree_lock, flags);
+			_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 			return 1;
 		}
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -747,13 +747,13 @@ int test_clear_page_writeback(struct pag
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		_spin_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestClearPageWriteback(page);
 		if (ret)
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
@@ -768,7 +768,7 @@ int test_set_page_writeback(struct page 
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		_spin_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
 		if (!ret)
 			radix_tree_tag_set(&mapping->page_tree,
@@ -778,7 +778,7 @@ int test_set_page_writeback(struct page 
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
@@ -796,9 +796,9 @@ int mapping_tagged(struct address_space 
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&mapping->tree_lock, flags);
+	_spin_lock_irqsave(&mapping->tree_lock, flags);
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
-	spin_unlock_irqrestore(&mapping->tree_lock, flags);
+	_spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(mapping_tagged);
diff -pruN a/mm/pdflush.c b/mm/pdflush.c
--- a/mm/pdflush.c	2004-08-14 09:38:11.000000000 +0400
+++ b/mm/pdflush.c	2004-10-09 01:26:59.000000000 +0400
@@ -45,6 +45,9 @@ static void start_one_pdflush_thread(voi
  * All the pdflush threads.  Protected by pdflush_lock
  */
 static LIST_HEAD(pdflush_list);
+
+# include <linux/spin_undefs.h>
+
 static spinlock_t pdflush_lock = SPIN_LOCK_UNLOCKED;
 
 /*
diff -pruN a/mm/readahead.c b/mm/readahead.c
--- a/mm/readahead.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/readahead.c	2004-10-09 01:26:59.000000000 +0400
@@ -233,7 +233,7 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
 		
@@ -244,16 +244,16 @@ __do_page_cache_readahead(struct address
 		if (page)
 			continue;
 
-		spin_unlock_irq(&mapping->tree_lock);
+		_spin_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		spin_lock_irq(&mapping->tree_lock);
+		_spin_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not
diff -pruN a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/rmap.c	2004-10-09 01:26:59.000000000 +0400
@@ -88,29 +88,30 @@ int anon_vma_prepare(struct vm_area_stru
 		struct anon_vma *allocated, *locked;
 
 		anon_vma = find_mergeable_anon_vma(vma);
-		if (anon_vma) {
-			allocated = NULL;
-			locked = anon_vma;
-			spin_lock(&locked->lock);
-		} else {
+               if (anon_vma) {
+                       allocated = NULL;
+                       locked = anon_vma;
+                       spin_lock(&locked->lock);
+               } else {
 			anon_vma = anon_vma_alloc();
 			if (unlikely(!anon_vma))
 				return -ENOMEM;
 			allocated = anon_vma;
-			locked = NULL;
+                        locked = NULL;
 		}
 
 		/* page_table_lock to protect against threads */
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		if (likely(!vma->anon_vma)) {
 			vma->anon_vma = anon_vma;
 			list_add(&vma->anon_vma_node, &anon_vma->head);
 			allocated = NULL;
 		}
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
+
+                if (locked)
+                       spin_unlock(&locked->lock);
 
-		if (locked)
-			spin_unlock(&locked->lock);
 		if (unlikely(allocated))
 			anon_vma_free(allocated);
 	}
@@ -268,7 +269,7 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	spin_lock(&mm->page_table_lock);
+        _spin_lock(&mm->page_table_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -296,7 +297,7 @@ static int page_referenced_one(struct pa
 out_unmap:
 	pte_unmap(pte);
 out_unlock:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out:
 	return referenced;
 }
@@ -511,7 +512,7 @@ static int try_to_unmap_one(struct page 
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	spin_lock(&mm->page_table_lock);
+        _spin_lock(&mm->page_table_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -587,7 +588,7 @@ static int try_to_unmap_one(struct page 
 out_unmap:
 	pte_unmap(pte);
 out_unlock:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
 }
@@ -631,7 +632,7 @@ static void try_to_unmap_cluster(unsigne
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	spin_lock(&mm->page_table_lock);
+        _spin_lock(&mm->page_table_lock);
 
 	address = (vma->vm_start + cursor) & CLUSTER_MASK;
 	end = address + CLUSTER_SIZE;
@@ -687,7 +688,7 @@ static void try_to_unmap_cluster(unsigne
 	pte_unmap(pte);
 
 out_unlock:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 }
 
 static int try_to_unmap_anon(struct page *page)
diff -pruN a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	2004-08-14 09:36:56.000000000 +0400
+++ b/mm/swap.c	2004-10-09 01:26:59.000000000 +0400
@@ -84,7 +84,7 @@ int rotate_reclaimable_page(struct page 
 		return 1;
 
 	zone = page_zone(page);
-	spin_lock_irqsave(&zone->lru_lock, flags);
+	_spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
 		list_add_tail(&page->lru, &zone->inactive_list);
@@ -92,7 +92,7 @@ int rotate_reclaimable_page(struct page 
 	}
 	if (!test_clear_page_writeback(page))
 		BUG();
-	spin_unlock_irqrestore(&zone->lru_lock, flags);
+	_spin_unlock_irqrestore(&zone->lru_lock, flags);
 	return 0;
 }
 
@@ -103,14 +103,14 @@ void fastcall activate_page(struct page 
 {
 	struct zone *zone = page_zone(page);
 
-	spin_lock_irq(&zone->lru_lock);
+	_spin_lock_irq(&zone->lru_lock);
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
 		inc_page_state(pgactivate);
 	}
-	spin_unlock_irq(&zone->lru_lock);
+	_spin_unlock_irq(&zone->lru_lock);
 }
 
 /*
@@ -180,12 +180,12 @@ void fastcall __page_cache_release(struc
 	unsigned long flags;
 	struct zone *zone = page_zone(page);
 
-	spin_lock_irqsave(&zone->lru_lock, flags);
+	_spin_lock_irqsave(&zone->lru_lock, flags);
 	if (TestClearPageLRU(page))
 		del_page_from_lru(zone, page);
 	if (page_count(page) != 0)
 		page = NULL;
-	spin_unlock_irqrestore(&zone->lru_lock, flags);
+	_spin_unlock_irqrestore(&zone->lru_lock, flags);
 	if (page)
 		free_hot_page(page);
 }
@@ -221,15 +221,15 @@ void release_pages(struct page **pages, 
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				_spin_unlock_irq(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			_spin_lock_irq(&zone->lru_lock);
 		}
 		if (TestClearPageLRU(page))
 			del_page_from_lru(zone, page);
 		if (page_count(page) == 0) {
 			if (!pagevec_add(&pages_to_free, page)) {
-				spin_unlock_irq(&zone->lru_lock);
+				_spin_unlock_irq(&zone->lru_lock);
 				__pagevec_free(&pages_to_free);
 				pagevec_reinit(&pages_to_free);
 				zone = NULL;	/* No lock is held */
@@ -237,7 +237,7 @@ void release_pages(struct page **pages, 
 		}
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		_spin_unlock_irq(&zone->lru_lock);
 
 	pagevec_free(&pages_to_free);
 }
@@ -297,16 +297,16 @@ void __pagevec_lru_add(struct pagevec *p
 
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				_spin_unlock_irq(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			_spin_lock_irq(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		_spin_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -324,9 +324,9 @@ void __pagevec_lru_add_active(struct pag
 
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				_spin_unlock_irq(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			_spin_lock_irq(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
@@ -335,7 +335,7 @@ void __pagevec_lru_add_active(struct pag
 		add_page_to_active_list(zone, page);
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		_spin_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
diff -pruN a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/swapfile.c	2004-10-09 01:26:59.000000000 +0400
@@ -290,10 +290,10 @@ static int exclusive_swap_page(struct pa
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[swp_offset(entry)] == 1) {
 			/* Recheck the page count with the swapcache lock held.. */
-			spin_lock_irq(&swapper_space.tree_lock);
+			_spin_lock_irq(&swapper_space.tree_lock);
 			if (page_count(page) == 2)
 				retval = 1;
-			spin_unlock_irq(&swapper_space.tree_lock);
+			_spin_unlock_irq(&swapper_space.tree_lock);
 		}
 		swap_info_put(p);
 	}
@@ -361,13 +361,13 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
-		spin_lock_irq(&swapper_space.tree_lock);
+		_spin_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		_spin_unlock_irq(&swapper_space.tree_lock);
 	}
 	swap_info_put(p);
 
@@ -391,12 +391,12 @@ void free_swap_and_cache(swp_entry_t ent
 	p = swap_info_get(entry);
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1) {
-			spin_lock_irq(&swapper_space.tree_lock);
+			_spin_lock_irq(&swapper_space.tree_lock);
 			page = radix_tree_lookup(&swapper_space.page_tree,
 				entry.val);
 			if (page && TestSetPageLocked(page))
 				page = NULL;
-			spin_unlock_irq(&swapper_space.tree_lock);
+			_spin_unlock_irq(&swapper_space.tree_lock);
 		}
 		swap_info_put(p);
 	}
@@ -567,7 +567,7 @@ static int unuse_process(struct mm_struc
 		down_read(&mm->mmap_sem);
 		lock_page(page);
 	}
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma->anon_vma) {
 			foundaddr = unuse_vma(vma, entry, page);
@@ -575,7 +575,7 @@ static int unuse_process(struct mm_struc
 				break;
 		}
 	}
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 	up_read(&mm->mmap_sem);
 	/*
 	 * Currently unuse_process cannot fail, but leave error handling
@@ -740,12 +740,12 @@ static int try_to_unuse(unsigned int typ
 
 			atomic_inc(&new_start_mm->mm_users);
 			atomic_inc(&prev_mm->mm_users);
-			spin_lock(&mmlist_lock);
+			_spin_lock(&mmlist_lock);
 			while (*swap_map > 1 && !retval &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
 				atomic_inc(&mm->mm_users);
-				spin_unlock(&mmlist_lock);
+				_spin_unlock(&mmlist_lock);
 				mmput(prev_mm);
 				prev_mm = mm;
 
@@ -765,9 +765,9 @@ static int try_to_unuse(unsigned int typ
 					new_start_mm = mm;
 					set_start_mm = 0;
 				}
-				spin_lock(&mmlist_lock);
+				_spin_lock(&mmlist_lock);
 			}
-			spin_unlock(&mmlist_lock);
+			_spin_unlock(&mmlist_lock);
 			mmput(prev_mm);
 			mmput(start_mm);
 			start_mm = new_start_mm;
diff -pruN a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/swap_state.c	2004-10-09 01:26:59.000000000 +0400
@@ -35,7 +35,7 @@ static struct backing_dev_info swap_back
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
-	.tree_lock	= SPIN_LOCK_UNLOCKED,
+	.tree_lock	= _SPIN_LOCK_UNLOCKED,
 	.a_ops		= &swap_aops,
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
@@ -74,7 +74,7 @@ static int __add_to_swap_cache(struct pa
 	BUG_ON(PagePrivate(page));
 	error = radix_tree_preload(gfp_mask);
 	if (!error) {
-		spin_lock_irq(&swapper_space.tree_lock);
+		_spin_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
@@ -85,7 +85,7 @@ static int __add_to_swap_cache(struct pa
 			total_swapcache_pages++;
 			pagecache_acct(1);
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		_spin_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -212,9 +212,9 @@ void delete_from_swap_cache(struct page 
   
 	entry.val = page->private;
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	_spin_lock_irq(&swapper_space.tree_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock_irq(&swapper_space.tree_lock);
+	_spin_unlock_irq(&swapper_space.tree_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
@@ -313,13 +313,13 @@ struct page * lookup_swap_cache(swp_entr
 {
 	struct page *page;
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	_spin_lock_irq(&swapper_space.tree_lock);
 	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
 	if (page) {
 		page_cache_get(page);
 		INC_CACHE_INFO(find_success);
 	}
-	spin_unlock_irq(&swapper_space.tree_lock);
+	_spin_unlock_irq(&swapper_space.tree_lock);
 	INC_CACHE_INFO(find_total);
 	return page;
 }
@@ -342,12 +342,12 @@ struct page *read_swap_cache_async(swp_e
 		 * called after lookup_swap_cache() failed, re-calling
 		 * that would confuse statistics.
 		 */
-		spin_lock_irq(&swapper_space.tree_lock);
+		_spin_lock_irq(&swapper_space.tree_lock);
 		found_page = radix_tree_lookup(&swapper_space.page_tree,
 						entry.val);
 		if (found_page)
 			page_cache_get(found_page);
-		spin_unlock_irq(&swapper_space.tree_lock);
+		_spin_unlock_irq(&swapper_space.tree_lock);
 		if (found_page)
 			break;
 
diff -pruN a/mm/truncate.c b/mm/truncate.c
--- a/mm/truncate.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/truncate.c	2004-10-09 01:26:59.000000000 +0400
@@ -74,13 +74,13 @@ invalidate_complete_page(struct address_
 	if (PagePrivate(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	spin_lock_irq(&mapping->tree_lock);
+	_spin_lock_irq(&mapping->tree_lock);
 	if (PageDirty(page)) {
-		spin_unlock_irq(&mapping->tree_lock);
+		_spin_unlock_irq(&mapping->tree_lock);
 		return 0;
 	}
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	_spin_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
diff -pruN a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/vmalloc.c	2004-10-09 01:26:59.000000000 +0400
@@ -158,7 +158,7 @@ int map_vm_area(struct vm_struct *area, 
 	int err = 0;
 
 	dir = pgd_offset_k(address);
-	spin_lock(&init_mm.page_table_lock);
+	_spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
 		if (!pmd) {
@@ -174,7 +174,7 @@ int map_vm_area(struct vm_struct *area, 
 		dir++;
 	} while (address && (address < end));
 
-	spin_unlock(&init_mm.page_table_lock);
+	_spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }
diff -pruN a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2004-10-08 22:40:49.000000000 +0400
+++ b/mm/vmscan.c	2004-10-09 01:26:59.000000000 +0400
@@ -474,7 +474,7 @@ static int shrink_list(struct list_head 
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
-		spin_lock_irq(&mapping->tree_lock);
+		_spin_lock_irq(&mapping->tree_lock);
 
 		/*
 		 * The non-racy check for busy page.  It is critical to check
@@ -482,7 +482,7 @@ static int shrink_list(struct list_head 
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
-			spin_unlock_irq(&mapping->tree_lock);
+			_spin_unlock_irq(&mapping->tree_lock);
 			goto keep_locked;
 		}
 
@@ -490,7 +490,7 @@ static int shrink_list(struct list_head 
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
-			spin_unlock_irq(&mapping->tree_lock);
+			_spin_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;
@@ -498,7 +498,7 @@ static int shrink_list(struct list_head 
 #endif /* CONFIG_SWAP */
 
 		__remove_from_page_cache(page);
-		spin_unlock_irq(&mapping->tree_lock);
+		_spin_unlock_irq(&mapping->tree_lock);
 		__put_page(page);
 
 free_it:
@@ -544,7 +544,7 @@ static void shrink_cache(struct zone *zo
 	pagevec_init(&pvec, 1);
 
 	lru_add_drain();
-	spin_lock_irq(&zone->lru_lock);
+	_spin_lock_irq(&zone->lru_lock);
 	while (max_scan > 0) {
 		struct page *page;
 		int nr_taken = 0;
@@ -575,7 +575,7 @@ static void shrink_cache(struct zone *zo
 		}
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_taken;
-		spin_unlock_irq(&zone->lru_lock);
+		_spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
 			goto done;
@@ -591,7 +591,7 @@ static void shrink_cache(struct zone *zo
 		mod_page_state_zone(zone, pgsteal, nr_freed);
 		sc->nr_to_reclaim -= nr_freed;
 
-		spin_lock_irq(&zone->lru_lock);
+		_spin_lock_irq(&zone->lru_lock);
 		/*
 		 * Put back any unfreeable pages.
 		 */
@@ -605,13 +605,13 @@ static void shrink_cache(struct zone *zo
 			else
 				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
-				spin_unlock_irq(&zone->lru_lock);
+				_spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
-				spin_lock_irq(&zone->lru_lock);
+				_spin_lock_irq(&zone->lru_lock);
 			}
 		}
   	}
-	spin_unlock_irq(&zone->lru_lock);
+	_spin_unlock_irq(&zone->lru_lock);
 done:
 	pagevec_release(&pvec);
 }
@@ -652,7 +652,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	lru_add_drain();
 	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
+	_spin_lock_irq(&zone->lru_lock);
 	while (pgscanned < nr_pages && !list_empty(&zone->active_list)) {
 		page = lru_to_page(&zone->active_list);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
@@ -676,7 +676,7 @@ refill_inactive_zone(struct zone *zone, 
 		pgscanned++;
 	}
 	zone->nr_active -= pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
+	_spin_unlock_irq(&zone->lru_lock);
 
 	/*
 	 * `distress' is a measure of how much trouble we're having reclaiming
@@ -725,7 +725,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	pagevec_init(&pvec, 1);
 	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
+	_spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
@@ -737,21 +737,21 @@ refill_inactive_zone(struct zone *zone, 
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
-			spin_unlock_irq(&zone->lru_lock);
+			_spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate += pgmoved;
 			pgmoved = 0;
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
+			_spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	zone->nr_inactive += pgmoved;
 	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
-		spin_unlock_irq(&zone->lru_lock);
+		_spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
-		spin_lock_irq(&zone->lru_lock);
+		_spin_lock_irq(&zone->lru_lock);
 	}
 
 	pgmoved = 0;
@@ -766,13 +766,13 @@ refill_inactive_zone(struct zone *zone, 
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_active += pgmoved;
 			pgmoved = 0;
-			spin_unlock_irq(&zone->lru_lock);
+			_spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
+			_spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	zone->nr_active += pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
+	_spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
 	mod_page_state_zone(zone, pgrefill, pgscanned);
diff -pruN a/net/ipv4/ipvs/ip_vs_sync.c b/net/ipv4/ipvs/ip_vs_sync.c
--- a/net/ipv4/ipvs/ip_vs_sync.c	2004-08-14 09:36:11.000000000 +0400
+++ b/net/ipv4/ipvs/ip_vs_sync.c	2004-10-09 01:26:59.000000000 +0400
@@ -5,7 +5,7 @@
  *              high-performance and highly available server based on a
  *              cluster of servers.
  *
- * Version:     $Id: ip_vs_sync.c,v 1.13 2003/06/08 09:31:19 wensong Exp $
+ * Version:     $Id$
  *
  * Authors:     Wensong Zhang <wensong@linuxvirtualserver.org>
  *
@@ -755,10 +755,10 @@ static int sync_thread(void *startup)
 	set_fs(KERNEL_DS);
 
 	/* Block all signals */
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked, 0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	/* set the maximum length of sync message */
 	set_sync_mesg_maxlen(state);
diff -pruN a/net/rxrpc/internal.h b/net/rxrpc/internal.h
--- a/net/rxrpc/internal.h	2004-08-14 09:36:32.000000000 +0400
+++ b/net/rxrpc/internal.h	2004-10-09 01:26:59.000000000 +0400
@@ -54,9 +54,9 @@ static inline void rxrpc_discard_my_sign
 	while (signal_pending(current)) {
 		siginfo_t sinfo;
 
-		spin_lock_irq(&current->sighand->siglock);
+		_spin_lock_irq(&current->sighand->siglock);
 		dequeue_signal(current, &current->blocked, &sinfo);
-		spin_unlock_irq(&current->sighand->siglock);
+		_spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
diff -pruN a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
--- a/net/sunrpc/clnt.c	2004-10-08 22:40:50.000000000 +0400
+++ b/net/sunrpc/clnt.c	2004-10-09 01:26:59.000000000 +0400
@@ -321,21 +321,21 @@ void rpc_clnt_sigmask(struct rpc_clnt *c
 		if (action[SIGQUIT-1].sa.sa_handler == SIG_DFL)
 			sigallow |= sigmask(SIGQUIT);
 	}
-	spin_lock_irqsave(&current->sighand->siglock, irqflags);
+	_spin_lock_irqsave(&current->sighand->siglock, irqflags);
 	*oldset = current->blocked;
 	siginitsetinv(&current->blocked, sigallow & ~oldset->sig[0]);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 }
 
 void rpc_clnt_sigunmask(struct rpc_clnt *clnt, sigset_t *oldset)
 {
 	unsigned long	irqflags;
 	
-	spin_lock_irqsave(&current->sighand->siglock, irqflags);
+	_spin_lock_irqsave(&current->sighand->siglock, irqflags);
 	current->blocked = *oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 }
 
 /*
diff -pruN a/net/sunrpc/sched.c b/net/sunrpc/sched.c
--- a/net/sunrpc/sched.c	2004-10-08 22:40:50.000000000 +0400
+++ b/net/sunrpc/sched.c	2004-10-09 01:26:59.000000000 +0400
@@ -1184,9 +1184,9 @@ rpciod_killall(void)
 		}
 	}
 
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 }
 
 /*
diff -pruN a/net/sunrpc/svc.c b/net/sunrpc/svc.c
--- a/net/sunrpc/svc.c	2004-10-08 22:40:50.000000000 +0400
+++ b/net/sunrpc/svc.c	2004-10-09 01:26:59.000000000 +0400
@@ -240,9 +240,9 @@ svc_register(struct svc_serv *serv, int 
 	}
 
 	if (!port) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
 	return error;
diff -pruN a/security/selinux/hooks.c b/security/selinux/hooks.c
--- a/security/selinux/hooks.c	2004-10-08 22:40:50.000000000 +0400
+++ b/security/selinux/hooks.c	2004-10-09 01:26:59.000000000 +0400
@@ -1888,11 +1888,11 @@ static void selinux_bprm_apply_creds(str
 			for (i = 0; i < 3; i++)
 				do_setitimer(i, &itimer, NULL);
 			flush_signals(current);
-			spin_lock_irq(&current->sighand->siglock);
+			_spin_lock_irq(&current->sighand->siglock);
 			flush_signal_handlers(current, 1);
 			sigemptyset(&current->blocked);
 			recalc_sigpending();
-			spin_unlock_irq(&current->sighand->siglock);
+			_spin_unlock_irq(&current->sighand->siglock);
 		}
 
 		/* Check whether the new SID can inherit resource limits


