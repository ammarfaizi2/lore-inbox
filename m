Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbTCJMcT>; Mon, 10 Mar 2003 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTCJMcS>; Mon, 10 Mar 2003 07:32:18 -0500
Received: from tomts26-srv.bellnexxia.net ([209.226.175.189]:5285 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261304AbTCJMcI>; Mon, 10 Mar 2003 07:32:08 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.64-mm2->4 hangs on contest
To: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Reply-To: tomlins@cam.org
Date: Mon, 10 Mar 2003 07:43:00 -0500
References: <fa.ie98jja.2hkdj6@ifi.uio.no> <fa.j59micm.1fhqe9k@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030310124300.87756D1E@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

> At 09:31 PM 3/10/2003 +1100, Con Kolivas wrote:
>>On Mon, 10 Mar 2003 21:31, Mike Galbraith wrote:
>> > Ahem.  Attached this time.
>>
>>I assume this is against bk? I'll massage it into 2.5.64-mm4

Suspect that the interactivity changes have make the problem that my
ptg patch is designed to fix easier to hit.  Con where is the latest
contest (a quick google does not help)?  Mike what version of irman
are you using?  The one I have has problems parsing /proc/mem in mm.

Here is the ptg patch for 64-mm4.  To apply it reverse the 
schedule-tunables-fix and schedule-tuneables and then apply
the ptg and update tuneables patch.

Ed Tomlinson

----------- ptg-D3-mm2 (applies to mm4) ----------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#                  ChangeSet    1.1087  -> 1.1088 
#       include/linux/sched.h   1.137   -> 1.138  
#              kernel/fork.c    1.112   -> 1.113  
#              kernel/user.c    1.6     -> 1.7    
#             kernel/sched.c    1.163   -> 1.164  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/07      ed@oscar.et.ca  1.1088
# Add user and thread group governors to prevent either from monoplizing
# the system.  The governors work by limiting the sum of the timeslices
# of active tasks in a group to <n> timeslices.  The defaults set <n> to
# 1.5 for thread groups and to 10 for user tasks.
# 
# For numa systems the governors are per node.  Idealy the storage
# should also be local to the node however, we do not have dynamic per
# node storage yet...
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h     Sat Mar  8 14:18:48 2003
+++ b/include/linux/sched.h     Sat Mar  8 14:18:48 2003
@@ -178,6 +178,11 @@
 
 #include <linux/aio.h>
 
+struct ptg_struct {            /* pseudo thread groups */
+       atomic_t active[MAX_NUMNODES];
+        atomic_t count;         /* number of refs */
+};
+
 struct mm_struct {
        struct vm_area_struct * mmap;           /* list of VMAs */
        struct rb_root mm_rb;
@@ -278,6 +283,7 @@
 struct user_struct {
        atomic_t __count;       /* reference count */
        atomic_t processes;     /* How many processes does this user have? */
+       atomic_t active[MAX_NUMNODES];
        atomic_t files;         /* How many open files does this user have? */
 
        /* Hash table maintenance information */
@@ -344,6 +350,8 @@
        struct list_head ptrace_list;
 
        struct mm_struct *mm, *active_mm;
+       struct ptg_struct * ptgroup;            /* pseudo thread group for this task */
+       atomic_t *governor;                     /* the atomic_t that governs this task */
 
 /* task state */
        struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c     Sat Mar  8 14:18:48 2003
+++ b/kernel/fork.c     Sat Mar  8 14:18:48 2003
@@ -96,12 +96,24 @@
        }
 }
 
+void free_ptgroup(struct task_struct *tsk)
+{
+       if (tsk->ptgroup && atomic_sub_and_test(1,&tsk->ptgroup->count)) {
+                kfree(tsk->ptgroup);
+                tsk->ptgroup = NULL;
+                tsk->governor = &tsk->user->active[cpu_to_node(task_cpu(tsk))];
+                if (tsk == current)
+                        atomic_inc(tsk->governor);
+        }
+}
+
 void __put_task_struct(struct task_struct *tsk)
 {
        WARN_ON(!(tsk->state & (TASK_DEAD | TASK_ZOMBIE)));
        WARN_ON(atomic_read(&tsk->usage));
        WARN_ON(tsk == current);
 
+       free_ptgroup(tsk);
        security_task_free(tsk);
        free_uid(tsk->user);
        free_task_struct(tsk);
@@ -469,6 +481,7 @@
 
        tsk->mm = NULL;
        tsk->active_mm = NULL;
+       tsk->ptgroup = NULL;
 
        /*
         * Are we cloning a kernel thread?
@@ -734,6 +747,32 @@
        p->flags = new_flags;
 }
 
+static inline int setup_governor(unsigned long clone_flags, struct task_struct *p)
+{
+       if ( ((clone_flags & CLONE_VM) && (clone_flags & CLONE_FILES)) ||
+            (clone_flags & CLONE_THREAD)) {
+               if (current->ptgroup)
+                       atomic_inc(&current->ptgroup->count);
+               else {
+                       int i;
+                       current->ptgroup = kmalloc(sizeof(struct ptg_struct), GFP_ATOMIC);
+                       if (!current->ptgroup)
+                               return 1;
+                       /* printk(KERN_INFO "ptgroup - pid %u\n",current->pid); */
+                       atomic_set(&current->ptgroup->count,2);
+                       for(i=0; i < MAX_NUMNODES; i++)
+                               atomic_set(&current->ptgroup->active[i], 0);
+                       atomic_set(&current->ptgroup->active[numa_node_id()], 1);
+                       atomic_dec(current->governor);
+                       current->governor = &current->ptgroup->active[numa_node_id()];
+               }
+               p->ptgroup = current->ptgroup;
+               p->governor = &p->ptgroup->active[numa_node_id()];
+       } else
+               p->governor = &p->user->active[numa_node_id()];
+       return 0;
+}
+
 asmlinkage int sys_set_tid_address(int *tidptr)
 {
        current->clear_child_tid = tidptr;
@@ -876,6 +915,12 @@
                goto bad_fork_cleanup_mm;
        retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
        if (retval)
+               goto bad_fork_cleanup_namespace;
+       /*
+        * Setup the governor pointer for the new process, allocating a new ptg as
+        * required if the process is a thread. 
+        */
+       if (setup_governor(clone_flags, p))
                goto bad_fork_cleanup_namespace;
 
        if (clone_flags & CLONE_CHILD_SETTID)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c    Sat Mar  8 14:18:48 2003
+++ b/kernel/sched.c    Sat Mar  8 14:18:48 2003
@@ -68,6 +68,9 @@
 #define MAX_SLEEP_AVG          (10*HZ)
 #define STARVATION_LIMIT       (10*HZ)
 #define NODE_THRESHOLD         125
+#define THREAD_GOVERNOR                15      /* allow threads groups 1.5 full timeslices */
+#define USER_GOVERNOR          100     /* allow user 10 full timeslices */
+
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -123,7 +126,26 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-       return BASE_TIMESLICE(p);
+       int slice = BASE_TIMESLICE(p);
+       int threads = atomic_read(p->governor) * 10;
+       int govern = threads;
+       if (p->user->uid)
+               govern = (p->ptgroup) ? THREAD_GOVERNOR : USER_GOVERNOR;
+       if (threads > govern) {
+               slice = (slice * govern) / threads;
+               slice = (slice > MIN_TIMESLICE) ? slice : MIN_TIMESLICE;
+       }
+#if 1
+       {
+               static int next;
+               if (time_after(jiffies, next)) {
+                       printk(KERN_INFO "uid %d pid %d nod %d ptg %x gov %x threads %d lim %d slice %d\n",
+                         p->uid, p->pid, numa_node_id(), p->ptgroup, p->governor, threads/10, govern, slice);
+                       next = jiffies + HZ*300;
+               }
+       }
+#endif
+       return slice;
 }
 
 /*
@@ -197,16 +219,18 @@
        rq->node_nr_running = &node_nr_running[0];
 }
 
-static inline void nr_running_inc(runqueue_t *rq)
+static inline void nr_running_inc(task_t *p, runqueue_t *rq)
 {
        atomic_inc(rq->node_nr_running);
        rq->nr_running++;
+       atomic_inc(p->governor);
 }
 
-static inline void nr_running_dec(runqueue_t *rq)
+static inline void nr_running_dec(task_t *p, runqueue_t *rq)
 {
        atomic_dec(rq->node_nr_running);
        rq->nr_running--;
+       atomic_dec(p->governor);
 }
 
 __init void node_nr_running_init(void)
@@ -220,8 +244,8 @@
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(p, rq)    do { (rq)->nr_running++; atomic_inc((p)->governor); } while (0)
+# define nr_running_dec(p, rq)    do { (rq)->nr_running--; atomic_dec((p)->governor); } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -326,7 +350,7 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
        enqueue_task(p, rq->active);
-       nr_running_inc(rq);
+       nr_running_inc(p, rq);
 }
 
 /*
@@ -387,7 +411,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-       nr_running_dec(rq);
+       nr_running_dec(p, rq);
        if (p->state == TASK_UNINTERRUPTIBLE)
                rq->nr_uninterruptible++;
        dequeue_task(p, p->array);
@@ -586,7 +610,7 @@
                list_add_tail(&p->run_list, &current->run_list);
                p->array = current->array;
                p->array->nr_active++;
-               nr_running_inc(rq);
+               nr_running_inc(p, rq);
        }
        task_rq_unlock(rq, &flags);
 }
@@ -1004,9 +1028,15 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
        dequeue_task(p, src_array);
-       nr_running_dec(src_rq);
+       nr_running_dec(p, src_rq);
        set_task_cpu(p, this_cpu);
-       nr_running_inc(this_rq);
+#ifdef CONFIG_NUMA
+        if (p->ptgroup)
+                p->governor = &p->ptgroup->active[cpu_to_node(this_cpu)];
+        else
+                p->governor = &p->user->active[cpu_to_node(this_cpu)];
+#endif
+       nr_running_inc(p, this_rq);
        enqueue_task(p, this_rq->active);
        /*
         * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2521,6 +2551,8 @@
        rq->curr = current;
        rq->idle = current;
        set_task_cpu(current, smp_processor_id());
+        current->governor = &current->user->active[numa_node_id()];
+       atomic_inc(current->governor);
        wake_up_forked_process(current);
        current->prio = MAX_PRIO;
 
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c     Sat Mar  8 14:18:48 2003
+++ b/kernel/user.c     Sat Mar  8 14:18:48 2003
@@ -30,6 +30,7 @@
 struct user_struct root_user = {
        .__count        = ATOMIC_INIT(1),
        .processes      = ATOMIC_INIT(1),
+       .active         = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)},
        .files          = ATOMIC_INIT(0)
 };
 
@@ -89,6 +90,7 @@
 
        if (!up) {
                struct user_struct *new;
+               int i;
 
                new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
                if (!new)
@@ -96,6 +98,8 @@
                new->uid = uid;
                atomic_set(&new->__count, 1);
                atomic_set(&new->processes, 0);
+               for(i=0; i < MAX_NUMNODES; i++)
+                       atomic_set(&new->active[i], 0);
                atomic_set(&new->files, 0);
 
                /*
@@ -130,6 +134,11 @@
        atomic_inc(&new_user->processes);
        atomic_dec(&old_user->processes);
        current->user = new_user;
+       if (!current->ptgroup) {
+               atomic_dec(current->governor);
+               current->governor = &current->user->active[numa_node_id()];
+               atomic_inc(current->governor);
+       }
        free_uid(old_user);
 }
 
----------- schedule-tunables for ptg -------------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#                  ChangeSet    1.1088  -> 1.1089 
#            kernel/sysctl.c    1.39    -> 1.40   
#       Documentation/filesystems/proc.txt      1.14    -> 1.15   
#       include/linux/sysctl.h  1.42    -> 1.43   
#             kernel/sched.c    1.164   -> 1.165  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/07      ed@oscar.et.ca  1.1089
# + schedule tunables for ptg
# --------------------------------------------
#
diff -Nru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt        Sat Mar  8 14:19:12 2003
+++ b/Documentation/filesystems/proc.txt        Sat Mar  8 14:19:12 2003
@@ -37,6 +37,7 @@
   2.8  /proc/sys/net/ipv4 - IPV4 settings
   2.9  Appletalk
   2.10 IPX
+  2.11  /proc/sys/sched - scheduler tunables
 
 ------------------------------------------------------------------------------
 Preface
@@ -1666,6 +1667,113 @@
 The /proc/net/ipx_route  table  holds  a list of IPX routes. For each route it
 gives the  destination  network, the router node (or Directly) and the network
 address of the router (or Connected) for internal networks.
+
+2.11 /proc/sys/sched - scheduler tunables
+-----------------------------------------
+
+Useful knobs for tuning the scheduler live in /proc/sys/sched.
+
+child_penalty
+-------------
+
+Percentage of the parent's sleep_avg that children inherit.  sleep_avg is
+a running average of the time a process spends sleeping.  Tasks with high
+sleep_avg values are considered interactive and given a higher dynamic
+priority and a larger timeslice.  You typically want this some value just
+under 100.
+
+exit_weight
+-----------
+
+When a CPU hog task exits, its parent's sleep_avg is reduced by a factor of
+exit_weight against the exiting task's sleep_avg.
+
+interactive_delta
+-----------------
+
+If a task is "interactive" it is reinserted into the active array after it
+has expired its timeslice, instead of being inserted into the expired array.
+How "interactive" a task must be in order to be deemed interactive is a
+function of its nice value.  This interactive limit is scaled linearly by nice
+value and is offset by the interactive_delta.
+
+max_sleep_avg
+-------------
+
+max_sleep_avg is the largest value (in ms) stored for a task's running sleep
+average.  The larger this value, the longer a task needs to sleep to be
+considered interactive (maximum interactive bonus is a function of
+max_sleep_avg).
+
+max_timeslice
+-------------
+
+Maximum timeslice, in milliseconds.  This is the value given to tasks of the
+highest dynamic priority.
+
+min_timeslice
+-------------
+
+Minimum timeslice, in milliseconds.  This is the value given to tasks of the
+lowest dynamic priority.  Every task gets at least this slice of the processor
+per array switch.
+
+parent_penalty
+--------------
+
+Percentage of the parent's sleep_avg that it retains across a fork().
+sleep_avg is a running average of the time a process spends sleeping.  Tasks
+with high sleep_avg values are considered interactive and given a higher
+dynamic priority and a larger timeslice.  Normally, this value is 100 and thus
+task's retain their sleep_avg on fork.  If you want to punish interactive
+tasks for forking, set this below 100.
+
+prio_bonus_ratio
+----------------
+
+Middle percentage of the priority range that tasks can receive as a dynamic
+priority.  The default value of 25% ensures that nice values at the
+extremes are still enforced.  For example, nice +19 interactive tasks will
+never be able to preempt a nice 0 CPU hog.  Setting this higher will increase
+the size of the priority range the tasks can receive as a bonus.  Setting
+this lower will decrease this range, making the interactivity bonus less
+apparent and user nice values more applicable.
+
+starvation_limit
+----------------
+
+Sufficiently interactive tasks are reinserted into the active array when they
+run out of timeslice.  Normally, tasks are inserted into the expired array.
+Reinserting interactive tasks into the active array allows them to remain
+runnable, which is important to interactive performance.  This could starve
+expired tasks, however, since the interactive task could prevent the array
+switch.  To prevent starving the tasks on the expired array for too long. the
+starvation_limit is the longest (in ms) we will let the expired array starve
+at the expense of reinserting interactive tasks back into active.  Higher
+values here give more preferance to running interactive tasks, at the expense
+of expired tasks.  Lower values provide more fair scheduling behavior, at the
+expense of interactivity.  The units are in milliseconds.
+
+thread_governor
+---------------
+
+When the number of active threads in a threadgroup exceeds the limit reduce the   
+timeslices of active members by thread_governor / active_threads_in_group.  In
+the NUMA case the limits are per node.  The thread_governor is applied before
+the user_governor.  Units are number of threads times 10.
+
+user_governor
+-------------
+
+When the number of active threads of user exceeds the limit reduce the timeslices
+of the user's active processes by user_governor / active_threads_of_user. In the
+NUMA case the limits are per node.  Units are number of threads times 10.
+
+node_threshold
+--------------
+
+Consider NUMA nodes imbalanced when there is a difference of more than this
+percentage.
 
 ------------------------------------------------------------------------------
 Summary
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h    Sat Mar  8 14:19:12 2003
+++ b/include/linux/sysctl.h    Sat Mar  8 14:19:12 2003
@@ -66,7 +66,8 @@
        CTL_DEV=7,              /* Devices */
        CTL_BUS=8,              /* Busses */
        CTL_ABI=9,              /* Binary emulation */
-       CTL_CPU=10              /* CPU stuff (speed scaling, etc) */
+       CTL_CPU=10,             /* CPU stuff (speed scaling, etc) */
+       CTL_SCHED=11,           /* scheduler tunables */
 };
 
 /* CTL_BUS names: */
@@ -157,6 +158,21 @@
        VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 };
 
+/* Tunable scheduler parameters in /proc/sys/sched/ */
+enum {
+       SCHED_MIN_TIMESLICE=1,          /* minimum process timeslice */
+       SCHED_MAX_TIMESLICE=2,          /* maximum process timeslice */
+       SCHED_CHILD_PENALTY=3,          /* penalty on fork to child */
+       SCHED_PARENT_PENALTY=4,         /* penalty on fork to parent */
+       SCHED_EXIT_WEIGHT=5,            /* penalty to parent of CPU hog child */
+       SCHED_PRIO_BONUS_RATIO=6,       /* percent of max prio given as bonus */
+       SCHED_INTERACTIVE_DELTA=7,      /* delta used to scale interactivity */
+       SCHED_MAX_SLEEP_AVG=8,          /* maximum sleep avg attainable */
+       SCHED_STARVATION_LIMIT=9,       /* no re-active if expired is starved */
+       SCHED_NODE_THRESHOLD=10,        /* NUMA imbalance threshold */
+       SCHED_THREAD_GOVERNOR=11,       /* govern threadgroups when needed */
+       SCHED_USER_GOVERNOR=12,         /* govern users when needed  */
+};
 
 /* CTL_NET names: */
 enum
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c    Sat Mar  8 14:19:12 2003
+++ b/kernel/sched.c    Sat Mar  8 14:19:12 2003
@@ -57,19 +57,35 @@
  * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
  * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
+ *
+ * They are configurable via /proc/sys/sched
  */
-#define MIN_TIMESLICE          ( 10 * HZ / 1000)
-#define MAX_TIMESLICE          (200 * HZ / 1000)
-#define CHILD_PENALTY          50
-#define PARENT_PENALTY         100
-#define EXIT_WEIGHT            3
-#define PRIO_BONUS_RATIO       25
-#define INTERACTIVE_DELTA      2
-#define MAX_SLEEP_AVG          (10*HZ)
-#define STARVATION_LIMIT       (10*HZ)
-#define NODE_THRESHOLD         125
-#define THREAD_GOVERNOR                15      /* allow threads groups 1.5 full timeslices */
-#define USER_GOVERNOR          100     /* allow user 10 full timeslices */
+
+int min_timeslice = (10 * HZ) / 1000;
+int max_timeslice = (200 * HZ) / 1000;
+int child_penalty = 50;
+int parent_penalty = 100;
+int exit_weight = 3;
+int prio_bonus_ratio = 25;
+int interactive_delta = 2;
+int max_sleep_avg = 10 * HZ;
+int starvation_limit = 10 * HZ;
+int node_threshold = 125;
+int thread_governor = 15;
+int user_governor = 100;
+
+#define MIN_TIMESLICE          (min_timeslice)
+#define MAX_TIMESLICE          (max_timeslice)
+#define CHILD_PENALTY          (child_penalty)
+#define PARENT_PENALTY         (parent_penalty)
+#define EXIT_WEIGHT            (exit_weight)
+#define PRIO_BONUS_RATIO       (prio_bonus_ratio)
+#define INTERACTIVE_DELTA      (interactive_delta)
+#define MAX_SLEEP_AVG          (max_sleep_avg)
+#define STARVATION_LIMIT       (starvation_limit)
+#define NODE_THRESHOLD         (node_threshold)
+#define THREAD_GOVERNOR                (thread_governor)
+#define USER_GOVERNOR          (user_governor)
 
 
 /*
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c   Sat Mar  8 14:19:12 2003
+++ b/kernel/sysctl.c   Sat Mar  8 14:19:12 2003
@@ -55,6 +55,18 @@
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int min_timeslice;
+extern int max_timeslice;
+extern int child_penalty;
+extern int parent_penalty;
+extern int exit_weight;
+extern int prio_bonus_ratio;
+extern int interactive_delta;
+extern int max_sleep_avg;
+extern int starvation_limit;
+extern int node_threshold;
+extern int thread_governor;
+extern int user_governor;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -112,6 +124,7 @@
 
 static ctl_table kern_table[];
 static ctl_table vm_table[];
+static ctl_table sched_table[];
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -156,6 +169,7 @@
        {CTL_FS, "fs", NULL, 0, 0555, fs_table},
        {CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+       {CTL_SCHED, "sched", NULL, 0, 0555, sched_table},
        {0}
 };
 
@@ -358,7 +372,47 @@
 
 static ctl_table dev_table[] = {
        {0}
-};  
+};
+
+static ctl_table sched_table[] = {
+       {SCHED_MAX_TIMESLICE, "max_timeslice", &max_timeslice,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &one, NULL},
+       {SCHED_MIN_TIMESLICE, "min_timeslice", &min_timeslice,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &one, NULL},
+       {SCHED_CHILD_PENALTY, "child_penalty", &child_penalty,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_PARENT_PENALTY, "parent_penalty", &parent_penalty,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_EXIT_WEIGHT, "exit_weight", &exit_weight,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_PRIO_BONUS_RATIO, "prio_bonus_ratio", &prio_bonus_ratio,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_INTERACTIVE_DELTA, "interactive_delta", &interactive_delta,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_MAX_SLEEP_AVG, "max_sleep_avg", &max_sleep_avg,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &one, NULL},
+       {SCHED_STARVATION_LIMIT, "starvation_limit", &starvation_limit,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_NODE_THRESHOLD, "node_threshold", &node_threshold,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_THREAD_GOVERNOR, "thread_governor", &thread_governor,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {SCHED_USER_GOVERNOR, "user_governor", &user_governor,
+        sizeof(int), 0644, NULL, &proc_dointvec_minmax,
+        &sysctl_intvec, NULL, &zero, NULL},
+       {0}
+};
 
 extern void init_irq_proc (void);
 
-----------
