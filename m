Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUECCYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUECCYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUECCYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:24:48 -0400
Received: from holomorphy.com ([207.189.100.168]:14724 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263484AbUECCXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:23:52 -0400
Date: Sun, 2 May 2004 19:23:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [0.5/2] scheduler caller profiling
Message-ID: <20040503022346.GG1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040503021709.GF1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503021709.GF1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 07:17:09PM -0700, William Lee Irwin III wrote:
> The thundering herd issue in waitqueue hashing has been seen in
> practice. In order to preserve the space footprint reduction while
> improving performance, I wrote "filtered wakeups", which discriminate
> between waiters based on a key.

This patch was used to collect the data on the offending callers into
the scheduler. It creates a profile buffer completely analogous to its
handling to /proc/profile, but registers profile ticks at calls to the
various scheduler entry points instead of during timer ticks and
rearranges scheduler code for this to be accounted properly. It does
not report meaningful statistics in the presence of CONFIG_PREEMPT.

Posting this patch is in order to disclose how I obtained the
scheduling statistics reported in the first post. This patch is not
intended for inclusion.


-- wli


Index: wli-2.6.6-rc3-mm1/include/linux/sched.h
===================================================================
--- wli-2.6.6-rc3-mm1.orig/include/linux/sched.h	2004-04-30 15:06:48.000000000 -0700
+++ wli-2.6.6-rc3-mm1/include/linux/sched.h	2004-04-30 15:55:34.000000000 -0700
@@ -189,7 +189,11 @@
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern signed long FASTCALL(__schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+asmlinkage void __schedule(void);
+void __sched_profile(void *);
+#define sched_profile()		__sched_profile(__builtin_return_address(0))
 
 struct namespace;
 
Index: wli-2.6.6-rc3-mm1/include/linux/profile.h
===================================================================
--- wli-2.6.6-rc3-mm1.orig/include/linux/profile.h	2004-04-03 19:37:06.000000000 -0800
+++ wli-2.6.6-rc3-mm1/include/linux/profile.h	2004-04-30 16:05:35.000000000 -0700
@@ -13,6 +13,7 @@
 
 /* init basic kernel profiler */
 void __init profile_init(void);
+void schedprof_init(void);
 
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
Index: wli-2.6.6-rc3-mm1/kernel/sched.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/kernel/sched.c	2004-04-30 15:06:49.000000000 -0700
+++ wli-2.6.6-rc3-mm1/kernel/sched.c	2004-05-01 11:48:46.000000000 -0700
@@ -2312,7 +2312,7 @@
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void __sched schedule(void)
+asmlinkage void __sched __schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -2451,6 +2451,11 @@
 		goto need_resched;
 }
 
+asmlinkage void __sched schedule(void)
+{
+	sched_profile();
+	__schedule();
+}
 EXPORT_SYMBOL(schedule);
 
 #ifdef CONFIG_PREEMPT
@@ -2472,7 +2477,8 @@
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
-	schedule();
+	sched_profile();
+	__schedule();
 	ti->preempt_count = 0;
 
 	/* we could miss a preemption opportunity between schedule and now */
@@ -2609,7 +2615,8 @@
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
-			schedule();
+			sched_profile();
+			__schedule();
 			spin_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
@@ -2641,7 +2648,8 @@
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
-	schedule();
+	sched_profile();
+	__schedule();
 	SLEEP_ON_TAIL
 }
 
@@ -2654,7 +2662,8 @@
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
-	timeout = schedule_timeout(timeout);
+	sched_profile();
+	timeout = __schedule_timeout(timeout);
 	SLEEP_ON_TAIL
 
 	return timeout;
@@ -2669,7 +2678,8 @@
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
-	schedule();
+	sched_profile();
+	__schedule();
 	SLEEP_ON_TAIL
 }
 
@@ -2682,7 +2692,8 @@
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
-	timeout = schedule_timeout(timeout);
+	sched_profile();
+	timeout = __schedule_timeout(timeout);
 	SLEEP_ON_TAIL
 
 	return timeout;
@@ -3127,7 +3138,7 @@
  * to the expired array. If there are no other threads running on this
  * CPU then this function will return.
  */
-asmlinkage long sys_sched_yield(void)
+static long sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
 	prio_array_t *array = current->array;
@@ -3154,15 +3165,22 @@
 	_raw_spin_unlock(&rq->lock);
 	preempt_enable_no_resched();
 
-	schedule();
+	__schedule();
 
 	return 0;
 }
 
+asmlinkage long sys_sched_yield(void)
+{
+	__sched_profile(sys_sched_yield);
+	return sched_yield();
+}
+
 void __sched __cond_resched(void)
 {
 	set_current_state(TASK_RUNNING);
-	schedule();
+	sched_profile();
+	__schedule();
 }
 
 EXPORT_SYMBOL(__cond_resched);
@@ -3176,7 +3194,8 @@
 void __sched yield(void)
 {
 	set_current_state(TASK_RUNNING);
-	sys_sched_yield();
+	sched_profile();
+	sched_yield();
 }
 
 EXPORT_SYMBOL(yield);
@@ -3193,7 +3212,8 @@
 	struct runqueue *rq = this_rq();
 
 	atomic_inc(&rq->nr_iowait);
-	schedule();
+	sched_profile();
+	__schedule();
 	atomic_dec(&rq->nr_iowait);
 }
 
@@ -3205,7 +3225,8 @@
 	long ret;
 
 	atomic_inc(&rq->nr_iowait);
-	ret = schedule_timeout(timeout);
+	sched_profile();
+	ret = __schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
 	return ret;
 }
@@ -4161,3 +4182,93 @@
 
 EXPORT_SYMBOL(__preempt_write_lock);
 #endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
+
+static atomic_t *schedprof_buf;
+static int sched_profiling;
+static unsigned long schedprof_len;
+
+#include <linux/bootmem.h>
+#include <asm/sections.h>
+
+void __sched_profile(void *__pc)
+{
+	if (schedprof_buf) {
+		unsigned long pc = (unsigned long)__pc;
+		pc -= min(pc, (unsigned long)_stext);
+		atomic_inc(&schedprof_buf[min(pc, schedprof_len)]);
+	}
+}
+
+static int __init schedprof_setup(char *s)
+{
+	int n;
+	if (get_option(&s, &n))
+		sched_profiling = 1;
+	return 1;
+}
+__setup("schedprof=", schedprof_setup);
+
+void __init schedprof_init(void)
+{
+	if (!sched_profiling)
+		return;
+	schedprof_len = (unsigned long)(_etext - _stext) + 1;
+	schedprof_buf = alloc_bootmem(schedprof_len*sizeof(atomic_t));
+	printk(KERN_INFO "Scheduler call profiling enabled\n");
+}
+
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+
+static ssize_t
+read_sched_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	ssize_t read;
+	char * pnt;
+	unsigned int sample_step = 1;
+
+	if (p >= (schedprof_len+1)*sizeof(atomic_t))
+		return 0;
+	if (count > (schedprof_len+1)*sizeof(atomic_t) - p)
+		count = (schedprof_len+1)*sizeof(atomic_t) - p;
+	read = 0;
+
+	while (p < sizeof(atomic_t) && count > 0) {
+		put_user(*((char *)(&sample_step)+p),buf);
+		buf++; p++; count--; read++;
+	}
+	pnt = (char *)schedprof_buf + p - sizeof(atomic_t);
+	if (copy_to_user(buf,(void *)pnt,count))
+		return -EFAULT;
+	read += count;
+	*ppos += read;
+	return read;
+}
+
+static ssize_t write_sched_profile(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	memset(schedprof_buf, 0, sizeof(atomic_t)*schedprof_len);
+	return count;
+}
+
+static struct file_operations sched_profile_operations = {
+	.read		= read_sched_profile,
+	.write		= write_sched_profile,
+};
+
+static int proc_schedprof_init(void)
+{
+	struct proc_dir_entry *entry;
+	if (!sched_profiling)
+		return 1;
+	entry = create_proc_entry("schedprof", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &sched_profile_operations;
+		entry->size = sizeof(atomic_t)*(schedprof_len + 1);
+	}
+	return !!entry;
+}
+module_init(proc_schedprof_init);
+#endif
Index: wli-2.6.6-rc3-mm1/kernel/timer.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/kernel/timer.c	2004-04-30 15:05:53.000000000 -0700
+++ wli-2.6.6-rc3-mm1/kernel/timer.c	2004-04-30 17:35:43.000000000 -0700
@@ -1065,7 +1065,7 @@
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
-fastcall signed long __sched schedule_timeout(signed long timeout)
+fastcall signed long __sched __schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
 	unsigned long expire;
@@ -1080,7 +1080,7 @@
 		 * but I' d like to return a valid offset (>=0) to allow
 		 * the caller to do everything it want with the retval.
 		 */
-		schedule();
+		__schedule();
 		goto out;
 	default:
 		/*
@@ -1108,7 +1108,7 @@
 	timer.function = process_timeout;
 
 	add_timer(&timer);
-	schedule();
+	__schedule();
 	del_timer_sync(&timer);
 
 	timeout = expire - jiffies;
@@ -1117,6 +1117,11 @@
 	return timeout < 0 ? 0 : timeout;
 }
 
+fastcall signed long __sched schedule_timeout(signed long timeout)
+{
+	sched_profile();
+	return __schedule_timeout(timeout);
+}
 EXPORT_SYMBOL(schedule_timeout);
 
 /* Thread ID - the internal kernel "pid" */
Index: wli-2.6.6-rc3-mm1/arch/alpha/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/alpha/kernel/semaphore.c	2004-04-30 15:05:31.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/alpha/kernel/semaphore.c	2004-04-30 15:14:54.000000000 -0700
@@ -66,7 +66,6 @@
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
 	       tsk->comm, tsk->pid, sem);
@@ -83,7 +82,8 @@
 	 * that we are asleep, and then sleep.
 	 */
 	while (__sem_update_count(sem, -1) <= 0) {
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 	remove_wait_queue(&sem->wait, &wait);
@@ -108,7 +108,6 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 	long ret = 0;
-
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down failed(%p)\n",
 	       tsk->comm, tsk->pid, sem);
@@ -129,7 +128,8 @@
 			ret = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_INTERRUPTIBLE);
 	}
 
Index: wli-2.6.6-rc3-mm1/arch/arm/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/arm/kernel/semaphore.c	2004-04-30 15:05:31.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/arm/kernel/semaphore.c	2004-04-30 15:15:12.000000000 -0700
@@ -77,8 +77,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
@@ -127,8 +127,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
Index: wli-2.6.6-rc3-mm1/arch/arm26/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/arm26/kernel/semaphore.c	2004-04-30 15:05:31.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/arm26/kernel/semaphore.c	2004-04-30 15:15:22.000000000 -0700
@@ -79,8 +79,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
@@ -129,8 +129,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
Index: wli-2.6.6-rc3-mm1/arch/cris/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/cris/kernel/semaphore.c	2004-04-30 15:05:31.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/cris/kernel/semaphore.c	2004-04-30 15:15:34.000000000 -0700
@@ -101,7 +101,8 @@
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
 	if (waking_non_zero(sem))
 		break;
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
@@ -119,7 +120,8 @@
 			ret = 0;
 		break;
 	}
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_INTERRUPTIBLE)
 	return ret;
 }
Index: wli-2.6.6-rc3-mm1/arch/h8300/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/h8300/kernel/semaphore.c	2004-04-30 15:05:31.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/h8300/kernel/semaphore.c	2004-04-30 15:15:42.000000000 -0700
@@ -103,7 +103,8 @@
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
 	if (waking_non_zero(sem))
 		break;
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
@@ -122,7 +123,8 @@
 			ret = 0;
 		break;
 	}
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_INTERRUPTIBLE)
 	return ret;
 }
Index: wli-2.6.6-rc3-mm1/arch/i386/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/i386/kernel/semaphore.c	2004-04-30 15:05:32.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/i386/kernel/semaphore.c	2004-04-30 15:16:52.000000000 -0700
@@ -79,8 +79,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
@@ -132,8 +132,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
Index: wli-2.6.6-rc3-mm1/arch/ia64/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/ia64/kernel/semaphore.c	2004-04-30 15:05:32.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/ia64/kernel/semaphore.c	2004-04-30 15:16:58.000000000 -0700
@@ -70,8 +70,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
@@ -123,8 +123,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
Index: wli-2.6.6-rc3-mm1/arch/m68k/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/m68k/kernel/semaphore.c	2004-04-30 15:05:32.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/m68k/kernel/semaphore.c	2004-04-30 15:17:09.000000000 -0700
@@ -103,7 +103,8 @@
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
 	if (waking_non_zero(sem))
 		break;
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
@@ -122,7 +123,8 @@
 			ret = 0;
 		break;
 	}
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_INTERRUPTIBLE)
 	return ret;
 }
Index: wli-2.6.6-rc3-mm1/arch/m68knommu/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/m68knommu/kernel/semaphore.c	2004-04-30 15:05:32.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/m68knommu/kernel/semaphore.c	2004-04-30 15:17:13.000000000 -0700
@@ -104,7 +104,8 @@
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
 	if (waking_non_zero(sem))
 		break;
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
@@ -123,7 +124,8 @@
 			ret = 0;
 		break;
 	}
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_INTERRUPTIBLE)
 	return ret;
 }
Index: wli-2.6.6-rc3-mm1/arch/mips/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/mips/kernel/semaphore.c	2004-04-30 15:05:33.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/mips/kernel/semaphore.c	2004-04-30 15:17:25.000000000 -0700
@@ -132,7 +132,8 @@
 	for (;;) {
 		if (waking_non_zero(sem))
 			break;
-		schedule();
+		sched_profile();
+		__schedule();
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -261,7 +262,8 @@
 				ret = 0;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
Index: wli-2.6.6-rc3-mm1/arch/parisc/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/parisc/kernel/semaphore.c	2004-04-30 15:05:34.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/parisc/kernel/semaphore.c	2004-04-30 15:17:31.000000000 -0700
@@ -68,7 +68,8 @@
 		/* we can _read_ this without the sentry */
 		if (sem->count != -1)
 			break;
- 		schedule();
+		sched_profile();
+ 		__schedule();
  	}
 
 	DOWN_TAIL
@@ -89,7 +90,8 @@
 			ret = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 	}
 
 	DOWN_TAIL
Index: wli-2.6.6-rc3-mm1/arch/ppc/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/ppc/kernel/semaphore.c	2004-04-30 15:05:34.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/ppc/kernel/semaphore.c	2004-04-30 15:17:36.000000000 -0700
@@ -86,7 +86,8 @@
 	 * that we are asleep, and then sleep.
 	 */
 	while (__sem_update_count(sem, -1) <= 0) {
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
 	remove_wait_queue(&sem->wait, &wait);
@@ -121,7 +122,8 @@
 			retval = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
 	tsk->state = TASK_RUNNING;
Index: wli-2.6.6-rc3-mm1/arch/ppc64/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/ppc64/kernel/semaphore.c	2004-04-30 15:05:34.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/ppc64/kernel/semaphore.c	2004-04-30 15:17:40.000000000 -0700
@@ -86,7 +86,8 @@
 	 * that we are asleep, and then sleep.
 	 */
 	while (__sem_update_count(sem, -1) <= 0) {
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 	remove_wait_queue(&sem->wait, &wait);
@@ -120,7 +121,8 @@
 			retval = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_INTERRUPTIBLE);
 	}
 	remove_wait_queue(&sem->wait, &wait);
Index: wli-2.6.6-rc3-mm1/arch/s390/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/s390/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/s390/kernel/semaphore.c	2004-04-30 15:17:43.000000000 -0700
@@ -69,7 +69,8 @@
 	__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	add_wait_queue_exclusive(&sem->wait, &wait);
 	while (__sem_update_count(sem, -1) <= 0) {
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 	remove_wait_queue(&sem->wait, &wait);
@@ -97,7 +98,8 @@
 			retval = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		set_task_state(tsk, TASK_INTERRUPTIBLE);
 	}
 	remove_wait_queue(&sem->wait, &wait);
Index: wli-2.6.6-rc3-mm1/arch/sh/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/sh/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/sh/kernel/semaphore.c	2004-04-30 15:17:52.000000000 -0700
@@ -110,7 +110,8 @@
 	DOWN_HEAD(TASK_UNINTERRUPTIBLE)
 	if (waking_non_zero(sem))
 		break;
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_UNINTERRUPTIBLE)
 }
 
@@ -128,7 +129,8 @@
 			ret = 0;
 		break;
 	}
-	schedule();
+	sched_profile();
+	__schedule();
 	DOWN_TAIL(TASK_INTERRUPTIBLE)
 	return ret;
 }
Index: wli-2.6.6-rc3-mm1/arch/sparc/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/sparc/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/sparc/kernel/semaphore.c	2004-04-30 15:18:02.000000000 -0700
@@ -68,8 +68,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
@@ -118,8 +118,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
Index: wli-2.6.6-rc3-mm1/arch/sparc64/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/sparc64/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/sparc64/kernel/semaphore.c	2004-04-30 15:18:10.000000000 -0700
@@ -100,7 +100,8 @@
 	add_wait_queue_exclusive(&sem->wait, &wait);
 
 	while (__sem_update_count(sem, -1) <= 0) {
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
 	remove_wait_queue(&sem->wait, &wait);
@@ -208,7 +209,8 @@
 			retval = -EINTR;
 			break;
 		}
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
 	tsk->state = TASK_RUNNING;
Index: wli-2.6.6-rc3-mm1/arch/v850/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/v850/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/v850/kernel/semaphore.c	2004-04-30 15:18:21.000000000 -0700
@@ -79,8 +79,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
@@ -129,8 +129,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irq(&semaphore_lock);
-
-		schedule();
+		sched_profile();
+		__schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 		spin_lock_irq(&semaphore_lock);
 	}
Index: wli-2.6.6-rc3-mm1/arch/x86_64/kernel/semaphore.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/arch/x86_64/kernel/semaphore.c	2004-04-30 15:05:35.000000000 -0700
+++ wli-2.6.6-rc3-mm1/arch/x86_64/kernel/semaphore.c	2004-04-30 15:18:28.000000000 -0700
@@ -80,8 +80,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
@@ -133,8 +133,8 @@
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
+		sched_profile();
+		__schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
Index: wli-2.6.6-rc3-mm1/lib/rwsem.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/lib/rwsem.c	2004-04-30 15:06:49.000000000 -0700
+++ wli-2.6.6-rc3-mm1/lib/rwsem.c	2004-04-30 15:13:46.000000000 -0700
@@ -150,7 +150,7 @@
 	for (;;) {
 		if (!waiter->flags)
 			break;
-		schedule();
+		__schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 
@@ -165,7 +165,7 @@
 struct rw_semaphore fastcall __sched *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
-
+	sched_profile();
 	rwsemtrace(sem,"Entering rwsem_down_read_failed");
 
 	waiter.flags = RWSEM_WAITING_FOR_READ;
@@ -181,7 +181,7 @@
 struct rw_semaphore fastcall __sched *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
-
+	sched_profile();
 	rwsemtrace(sem,"Entering rwsem_down_write_failed");
 
 	waiter.flags = RWSEM_WAITING_FOR_WRITE;
Index: wli-2.6.6-rc3-mm1/init/main.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/init/main.c	2004-04-30 15:06:48.000000000 -0700
+++ wli-2.6.6-rc3-mm1/init/main.c	2004-04-30 16:04:58.000000000 -0700
@@ -486,6 +486,7 @@
 	if (panic_later)
 		panic(panic_later, panic_param);
 	profile_init();
+	schedprof_init();
 	local_irq_enable();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
