Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbSIXRPC>; Tue, 24 Sep 2002 13:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbSIXRPC>; Tue, 24 Sep 2002 13:15:02 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60396 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261709AbSIXRO6>; Tue, 24 Sep 2002 13:14:58 -0400
Date: Tue, 24 Sep 2002 14:19:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: linux-kernel@vger.kernel.org
Subject: [PATCH] per user scheduling for 2.4.19
Message-ID: <Pine.LNX.4.44L.0209241417520.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch implements per user scheduling for 2.4.19,
it's not sophisticated but kept as simple as possible.  I'm
still thinking of a nice way to implement this for the O(1)
scheduler...

Tested on UP and SMP, don't forget to enable CONFIG_FAIRSCHED.

have fun,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/


--- linux/kernel/sched.c.fair	2002-09-20 10:58:49.000000000 -0300
+++ linux/kernel/sched.c	2002-09-24 13:29:01.000000000 -0300
@@ -45,31 +45,33 @@

 extern void mem_use(void);

+#ifdef CONFIG_FAIRSCHED
+/* Toggle the per-user fair scheduler on/off */
+int fairsched = 1;
+
+/* Move a task to the tail of the tasklist */
+static inline void move_last_tasklist(struct task_struct * p)
+{
+	/* list_del */
+	p->next_task->prev_task = p->prev_task;
+	p->prev_task->next_task = p->next_task;
+
+	/* list_add_tail */
+	p->next_task = &init_task;
+	p->prev_task = init_task.prev_task;
+	init_task.prev_task->next_task = p;
+	init_task.prev_task = p;
+}
+
 /*
- * Scheduling quanta.
- *
- * NOTE! The unix "nice" value influences how long a process
- * gets. The nice value ranges from -20 to +19, where a -20
- * is a "high-priority" task, and a "+10" is a low-priority
- * task.
- *
- * We want the time-slice to be around 50ms or so, so this
- * calculation depends on the value of HZ.
+ * Remember p->next, in case we call move_last_tasklist(p) in the
+ * fairsched recalculation code.
  */
-#if HZ < 200
-#define TICK_SCALE(x)	((x) >> 2)
-#elif HZ < 400
-#define TICK_SCALE(x)	((x) >> 1)
-#elif HZ < 800
-#define TICK_SCALE(x)	(x)
-#elif HZ < 1600
-#define TICK_SCALE(x)	((x) << 1)
-#else
-#define TICK_SCALE(x)	((x) << 2)
-#endif
-
-#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)
+#define safe_for_each_task(p) \
+	for (p = init_task.next_task, next = p->next_task ; p != &init_task ; \
+			p = next, next = p->next_task)

+#endif /* CONFIG_FAIRSCHED */

 /*
  *	Init task must be ok at boot for the ix86 as we will check its signals
@@ -616,6 +618,40 @@

 	/* Do we need to re-calculate counters? */
 	if (unlikely(!c)) {
+#ifdef CONFIG_FAIRSCHED
+ 	    if (fairsched) {
+		struct task_struct *p, *next;
+		struct user_struct *up;
+		long oldcounter, newcounter;
+
+		spin_unlock_irq(&runqueue_lock);
+
+		recalculate_peruser_cputicks();
+
+		write_lock_irq(&tasklist_lock);
+		safe_for_each_task(p) {
+		    up = p->user;
+		    if (up->cpu_ticks > 0) {
+			oldcounter = p->counter;
+			newcounter = (oldcounter >> 1) + NICE_TO_TICKS(p->nice);
+			up->cpu_ticks += oldcounter;
+			up->cpu_ticks -= newcounter;
+			/*
+			 * If a user is very busy, only some processes can
+			 * get CPU time. We move those processes out of the
+			 * way to prevent starvation of others.
+			 */
+			if (oldcounter != newcounter) {
+				p->counter = newcounter;
+				move_last_tasklist(p);
+			}
+		    }
+		}
+		write_unlock_irq(&tasklist_lock);
+		spin_lock_irq(&runqueue_lock);
+	    } else
+#endif /* CONFIG_FAIRSCHED */
+	    {
 		struct task_struct *p;

 		spin_unlock_irq(&runqueue_lock);
@@ -624,7 +660,8 @@
 			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
 		read_unlock(&tasklist_lock);
 		spin_lock_irq(&runqueue_lock);
-		goto repeat_schedule;
+	    }
+	    goto repeat_schedule;
 	}

 	/*
--- linux/kernel/user.c.fair	2002-09-20 11:50:56.000000000 -0300
+++ linux/kernel/user.c	2002-09-23 16:03:38.000000000 -0300
@@ -29,9 +29,13 @@
 struct user_struct root_user = {
 	__count:	ATOMIC_INIT(1),
 	processes:	ATOMIC_INIT(1),
-	files:		ATOMIC_INIT(0)
+	files:		ATOMIC_INIT(0),
+	l_prev:		&root_user,
+	l_next:		&root_user,
+	cpu_ticks:	NICE_TO_TICKS(0)
 };

+
 /*
  * These routines must be called with the uidhash spinlock held!
  */
@@ -44,6 +48,11 @@
 		next->pprev = &up->next;
 	up->pprev = hashent;
 	*hashent = up;
+
+	up->l_next = root_user.l_next;
+	up->l_prev = &root_user;
+	root_user.l_next->l_prev = up;
+	root_user.l_next = up;
 }

 static inline void uid_hash_remove(struct user_struct *up)
@@ -54,6 +63,9 @@
 	if (next)
 		next->pprev = pprev;
 	*pprev = next;
+
+	up->l_prev->l_next = up->l_next;
+	up->l_next->l_prev = up->l_prev;
 }

 static inline struct user_struct *uid_hash_find(uid_t uid, struct user_struct **hashent)
@@ -101,6 +113,7 @@
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		new->cpu_ticks = NICE_TO_TICKS(0);

 		/*
 		 * Before adding this, check whether we raced
@@ -120,6 +133,18 @@
 	return up;
 }

+/* Fair scheduler, recalculate the per user cpu time cap. */
+void recalculate_peruser_cputicks(void)
+{
+	struct user_struct * up;
+
+	spin_lock(&uidhash_lock);
+	root_user.cpu_ticks = root_user.cpu_ticks / 2 + NICE_TO_TICKS(0);
+	for (up = &root_user ; (up = up->l_next) != &root_user ; ) {
+		up->cpu_ticks = (up->cpu_ticks / 2) + NICE_TO_TICKS(0);
+	}
+	spin_unlock(&uidhash_lock);
+}

 static int __init uid_cache_init(void)
 {
--- linux/kernel/sysctl.c.fair	2002-09-21 00:00:36.000000000 -0300
+++ linux/kernel/sysctl.c	2002-09-21 20:40:49.000000000 -0300
@@ -50,6 +50,7 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
+extern int fairsched;

 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -256,6 +257,10 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+#ifdef CONFIG_FAIRSCHED
+	{KERN_FAIRSCHED, "fairsched", &fairsched, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+#endif
 	{0}
 };

--- linux/include/linux/sched.h.fair	2002-09-20 10:59:03.000000000 -0300
+++ linux/include/linux/sched.h	2002-09-21 20:57:22.000000000 -0300
@@ -275,6 +275,10 @@
 	/* Hash table maintenance information */
 	struct user_struct *next, **pprev;
 	uid_t uid;
+
+	/* Linked list for for_each_user */
+	struct user_struct *l_next, *l_prev;
+	long cpu_ticks;
 };

 #define get_current_user() ({ 				\
@@ -282,6 +286,7 @@
 	atomic_inc(&__user->__count);			\
 	__user; })

+extern void recalculate_peruser_cputicks(void);
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)

@@ -422,6 +427,31 @@
 };

 /*
+ * Scheduling quanta.
+ *
+ * NOTE! The unix "nice" value influences how long a process
+ * gets. The nice value ranges from -20 to +19, where a -20
+ * is a "high-priority" task, and a "+10" is a low-priority
+ * task.
+ *
+ * We want the time-slice to be around 50ms or so, so this
+ * calculation depends on the value of HZ.
+ */
+#if HZ < 200
+#define TICK_SCALE(x)	((x) >> 2)
+#elif HZ < 400
+#define TICK_SCALE(x)	((x) >> 1)
+#elif HZ < 800
+#define TICK_SCALE(x)	(x)
+#elif HZ < 1600
+#define TICK_SCALE(x)	((x) << 1)
+#else
+#define TICK_SCALE(x)	((x) << 2)
+#endif
+
+#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)
+
+/*
  * Per process flags
  */
 #define PF_ALIGNWARN	0x00000001	/* Print alignment warning msgs */
--- linux/include/linux/sysctl.h.fair	2002-09-21 20:41:18.000000000 -0300
+++ linux/include/linux/sysctl.h	2002-09-21 20:41:43.000000000 -0300
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_FAIRSCHED=55,	/* int: turn fair scheduler on/off */
 };


--- linux/arch/i386/config.in.fair	2002-09-21 20:42:06.000000000 -0300
+++ linux/arch/i386/config.in	2002-09-21 20:42:35.000000000 -0300
@@ -261,6 +261,9 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ] ; then
+   bool 'Fair scheduler' CONFIG_FAIRSCHED
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
--- linux/arch/alpha/config.in.fair	2002-08-02 21:39:42.000000000 -0300
+++ linux/arch/alpha/config.in	2002-09-21 20:43:21.000000000 -0300
@@ -273,6 +273,9 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ] ; then
+   bool 'Fair scheduler' CONFIG_FAIRSCHED
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\

