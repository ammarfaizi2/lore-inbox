Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSHMQBD>; Tue, 13 Aug 2002 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318206AbSHMQBD>; Tue, 13 Aug 2002 12:01:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35214 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318205AbSHMQA6>;
	Tue, 13 Aug 2002 12:00:58 -0400
Date: Tue, 13 Aug 2002 18:01:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] kwaitd, 2.5.31-A1
Message-ID: <Pine.LNX.4.44.0208131755090.31234-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is the other half of making pthread_exit() a
single-syscall, low-overhead matter.

it implements a new clone flag, CLONE_DETACHED, over which the parent can
tell the kernel that it's not interested in parent notification signals.  
(new pthreads now does any such potential notification via the much lower
overhead futexes.)

(my first choice, 'exit notification signal 0' is an already existing
semantic detail that is being use by kmod and perhaps by userspace code as
well, so it had to be a clone flag. Besides, signal 0 notification still
creates some signal handling related overhead, which is absolutely
unncessery in the thread-exit case.)

the reaping of the thread is thus not done by the parent (or init), but by
per-CPU [kwaitd] kernel threads. The exiting thread queues itself always
to the CPU-local kwaitd queue, to maintain locality of reference and cheap
switching to kwaitd.

[ this new reaping method could also be used when reparenting to init -
but i'm unsure whether this would really work as expected - do some init
variants rely perhaps on getting all orphan tasks in the system? ]

i've tested this against the 2.5.31-BK + clone_startup()-patch +
exit_free()-patch kernel tree, it works as expected.

	Ingo

--- linux/include/linux/sched.h.orig	Tue Aug 13 17:32:35 2002
+++ linux/include/linux/sched.h	Tue Aug 13 17:36:24 2002
@@ -46,6 +46,7 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_STARTUP	0x00080000	/* create child state */
+#define CLONE_DETACHED	0x00100000	/* auto-reaped by kwaitd */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -297,6 +298,7 @@
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
 	struct list_head thread_group;
+	struct list_head zombie_list;
 
 	/* PID hash table linkage. */
 	struct task_struct *pidhash_next;
@@ -647,6 +649,8 @@
 extern void reparent_to_init(void);
 extern void daemonize(void);
 extern task_t *child_reaper;
+extern void reap_thread(task_t *p);
+extern void release_task(struct task_struct * p);
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
 extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
--- linux/include/linux/init_task.h.orig	Tue Aug 13 17:36:32 2002
+++ linux/include/linux/init_task.h	Tue Aug 13 17:36:47 2002
@@ -59,6 +59,7 @@
     children:		LIST_HEAD_INIT(tsk.children),			\
     sibling:		LIST_HEAD_INIT(tsk.sibling),			\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    zombie_list:	LIST_HEAD_INIT(tsk.zombie_list),		\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
--- linux/kernel/exit.c.orig	Tue Aug 13 17:29:05 2002
+++ linux/kernel/exit.c	Tue Aug 13 17:36:03 2002
@@ -54,9 +54,13 @@
 	}
 }
 
-static void release_task(struct task_struct * p)
+void release_task(struct task_struct * p)
 {
 	if (p == current)
+		BUG();
+	if (p->state != TASK_ZOMBIE)
+		BUG();
+	if (!list_empty(&p->zombie_list))
 		BUG();
 #ifdef CONFIG_SMP
 	wait_task_inactive(p);
--- linux/kernel/signal.c.orig	Tue Aug 13 17:29:36 2002
+++ linux/kernel/signal.c	Tue Aug 13 17:50:42 2002
@@ -16,6 +16,8 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -774,6 +776,12 @@
 	struct siginfo info;
 	int why, status;
 
+	/* is the thread detached? */
+	if (sig == -1) {
+		reap_thread(tsk);
+		return;
+	}
+
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_pid = tsk->pid;
@@ -1501,3 +1509,104 @@
 }
 
 #endif /* HAVE_ARCH_SYS_PAUSE */
+
+/*
+ * kwaitd per-CPU threads help freeing exit()ed threads:
+ */
+typedef struct {
+	spinlock_t lock;
+	list_t queue;
+	task_t *task;
+} kwait_t;
+
+static kwait_t kwait_threads[NR_CPUS] __cacheline_aligned;
+
+void reap_thread(task_t *p)
+{
+	kwait_t *kwait = kwait_threads + smp_processor_id();
+
+
+	if (p->parent == kwait->task) {
+		printk("hm, %s(%d) reaped already.\n", p->comm, p->pid);
+		return;
+	}
+	REMOVE_LINKS(p);
+	p->parent = kwait->task;
+	p->real_parent = kwait->task;
+	SET_LINKS(p);
+
+	spin_lock(&kwait->lock);
+	if (!list_empty(&p->zombie_list))
+		BUG();
+	list_add_tail(&p->zombie_list, &kwait->queue);
+	spin_unlock(&kwait->lock);
+	wake_up_process(kwait->task);
+}
+
+static int kwaitd(void * __cpu)
+{
+	int cpu = (long) __cpu;
+	kwait_t *kwait = kwait_threads + cpu;
+	list_t *tmp;
+	task_t *p;
+
+	daemonize();
+	set_cpus_allowed(current, 1UL << cpu);
+	printk("[kwaitd_CPU%d] started up.\n", cpu);
+
+	spin_lock_init(&kwait->lock);
+	INIT_LIST_HEAD(&kwait->queue);
+	kwait->task = current;
+	
+	set_user_nice(current, -20);
+	sigfillset(&current->blocked);
+	sprintf(current->comm, "kwaitd_CPU%d", cpu);
+
+	for (;;) {
+		spin_lock(&kwait->lock);
+		tmp = kwait->queue.next;
+		if (list_empty(tmp)) {
+			current->state = TASK_INTERRUPTIBLE;
+			spin_unlock(&kwait->lock);
+
+			schedule();
+			current->state = TASK_RUNNING;
+			continue;
+		}
+		list_del_init(tmp);
+		spin_unlock(&kwait->lock);
+
+		p = list_entry(tmp, task_t, zombie_list);
+
+
+		release_task(p);
+	}
+}
+
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				unsigned long action, void *hcpu)
+{
+	int cpu = (long)hcpu;
+
+        if (action == CPU_ONLINE) {
+		if (kernel_thread(kwaitd, hcpu,
+				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0) {
+			printk("start_kwaitd() failed for cpu %d\n", cpu);
+			return NOTIFY_BAD;
+		}
+		while (!kwait_threads[cpu].task)
+			yield();
+		return NOTIFY_OK;
+        }
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
+
+__init int start_kwaitd(void)
+{
+	cpu_callback(&cpu_nfb, CPU_ONLINE, (void *)(long)smp_processor_id());
+	register_cpu_notifier(&cpu_nfb);
+	return 0;
+}
+
--- linux/kernel/fork.c.orig	Tue Aug 13 17:34:54 2002
+++ linux/kernel/fork.c	Tue Aug 13 17:35:29 2002
@@ -737,7 +737,11 @@
 
 	/* ok, now we should be set up.. */
 	p->swappable = 1;
-	p->exit_signal = clone_flags & CSIGNAL;
+	if (clone_flags & CLONE_DETACHED)
+		p->exit_signal = -1;
+	else
+		p->exit_signal = clone_flags & CSIGNAL;
+        INIT_LIST_HEAD(&p->zombie_list);
 	p->pdeath_signal = 0;
 
 	/*
--- linux/init/main.c.orig	Tue Aug 13 17:50:55 2002
+++ linux/init/main.c	Tue Aug 13 17:51:23 2002
@@ -527,12 +527,14 @@
 static void do_pre_smp_initcalls(void)
 {
 	extern int spawn_ksoftirqd(void);
+	extern int start_kwaitd(void);
 #ifdef CONFIG_SMP
 	extern int migration_init(void);
 
 	migration_init();
 #endif
 	spawn_ksoftirqd();
+	start_kwaitd();
 }
 
 extern void prepare_namespace(void);

