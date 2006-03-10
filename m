Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWCJRPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWCJRPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCJRPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:15:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31638 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751468AbWCJRPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:15:53 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pidhash: Refactor the pid hash table.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 10 Mar 2006 10:14:53 -0700
Message-ID: <m1irqmi5ma.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This splits the current struct pid into two structures, struct pid and struct
pid_link, and reduces our number of hash tables from PIDTYPE_MAX to just one.
struct pid_link is the per process linkage into the hash tables and lives in
struct task_struct.  struct pid is given an indepedent lifetime, and holds
pointers to each of the pid types.

The independent life of struct pid simplifies attach_pid, and detach_pid,
because we are always manipulating the list of pids and not the hash table.
In addition in giving struct pid an indpendent life it makes the concept
much more powerful.

Kernel data structurs can now embed a struct pid * instead of a pid_t and
not suffer from pid wrap around problems or from keeping unnecessarily
large amounts of memory allocated.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

Andrew this patch is largely indepedent of previous work
but it does have a couple of dependencies.

Oleg's pids-kill-pidtype_tgid, pidhash-dont-count-idle-threads
My make-setsid-more-robust, and kill-switch_exec_pids

This patch conflicts with and obsoletes:

tref-fix-task_ref-reference-counting-ensure-the-references-is-always-on-the-first-task
tref-fix-task_ref-reference-counting-fix
tref-fix-task_ref-reference-counting
tref-implement-task-references-kill-init_tref
tref-implement-task-references

Sorry to for sending you a patch that falls in the middle of a stack
like this but it seems the only sane way to implement this.

 include/linux/pid.h   |   90 +++++++++++++++++----
 include/linux/sched.h |    4 -
 kernel/fork.c         |   16 ++--
 kernel/pid.c          |  213 ++++++++++++++++++++++++++++++++++---------------
 4 files changed, 233 insertions(+), 90 deletions(-)

f841047af05e375118496679f34cb5942a91a53e
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 5b9082c..8d64799 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/rcupdate.h>
+
 enum pid_type
 {
 	PIDTYPE_PID,
@@ -9,18 +11,61 @@ enum pid_type
 	PIDTYPE_MAX
 };
 
+/* What is struct pid?
+ * 
+ * A struct pid is the kernels internal notion of a process identier.
+ * It refers to individual tasks, process groups, and sessions.  While
+ * there are processes attached to it the struct pid lives in a hash
+ * table, so it and then the processes that it refers to it can be found
+ * quickly from the numeric pid value.  The attached processes may be
+ * quickly access by following pointers from struct pid.
+ *
+ * Storing pid_t values in the kernel and refering to them later has a
+ * problem.  The process originally with that pid may have exited the
+ * pid allocator wrapped, and another process could have come along
+ * and been assigned that pid.
+ *
+ * Refering to user space process by holding a reference to struct
+ * task_struct has a problem.  When the user space process exit
+ * the now useless task_struct still kept.  A task_struct plus a
+ * stack consumes around 10K of low kernel memory.  More precisely
+ * this is THREAD_SIZE + sizeof(struct task_struct).  By comparison
+ * a struct pid is about 64 bytes.
+ *
+ * Holding a reference to struct pid solves both of these problems.
+ * It is small so holding a reference does not consume a lot of
+ * resources, and since a new struct pid is allocated when the numeric
+ * pid value is reused when don't mistakenly refer to new process.
+ */
+
 struct pid
 {
+	atomic_t count;
 	/* Try to keep pid_chain in the same cacheline as nr for find_pid */
 	int nr;
 	struct hlist_node pid_chain;
-	/* list of pids with the same nr, only one of them is in the hash */
-	struct list_head pid_list;
+	/* lists of tasks that use this pid */
+	struct hlist_head tasks[PIDTYPE_MAX];
+	struct rcu_head rcu;
 };
 
-#define pid_task(elem, type) \
-	list_entry(elem, struct task_struct, pids[type].pid_list)
+struct pid_link
+{
+	struct hlist_node node;
+	struct pid *pid;
+};
 
+static inline struct pid *get_pid(struct pid *pid)
+{
+	if (pid)
+		atomic_inc(&pid->count);
+	return pid;
+}
+
+extern void FASTCALL(put_pid(struct pid *pid));
+extern struct task_struct *FASTCALL(pid_task(struct pid *pid, enum pid_type));
+extern struct task_struct *FASTCALL(get_pid_task(struct pid *pid, enum pid_type));
+  
 /*
  * attach_pid() and detach_pid() must be called with the tasklist_lock
  * write-held.
@@ -31,23 +76,40 @@ extern void FASTCALL(detach_pid(struct t
 
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
- * held.
+ * or rcu_read_lock() held.
  */
-extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+extern struct pid *FASTCALL(find_pid(int nr));
 
-extern int alloc_pidmap(void);
-extern void FASTCALL(free_pidmap(int));
+/*
+ * Lookup a PID in the hash table, and return with it's count elevated.
+ */
+extern struct pid *find_get_pid(int nr);
+
+extern struct pid *alloc_pid(void);
+extern void FASTCALL(free_pid(struct pid *pid));
+
+#define pid_next(task, type)					\
+	((task)->pids[(type)].node.next)
 
+#define pid_next_task(task, type) 				\
+	hlist_entry(pid_next(task, type), struct task_struct, pids[(type)].node)
+
+
+/* We could use hlist_for_each_entry_rcu here but it takes more arguments
+ * than the do_each_task_pid/while_each_task_pid.  So we roll our own
+ * to preserve the existing interface.
+ */
 #define do_each_task_pid(who, type, task)				\
 	if ((task = find_task_by_pid_type(type, who))) {		\
-		prefetch((task)->pids[type].pid_list.next);		\
+		prefetch(pid_next(task, type));				\
 		do {
 
 #define while_each_task_pid(who, type, task)				\
-		} while (task = pid_task((task)->pids[type].pid_list.next,\
-						type),			\
-			prefetch((task)->pids[type].pid_list.next),	\
-			hlist_unhashed(&(task)->pids[type].pid_chain));	\
-	}								\
+		} while (pid_next(task, type) &&  ({			\
+				task = pid_next_task(task, type);	\
+				rcu_dereference(task);			\
+				prefetch(pid_next(task, type));		\
+				1; }) );				\
+	}
 
 #endif /* _LINUX_PID_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index db26557..23e0309 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -764,7 +764,7 @@ struct task_struct {
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
-	struct pid pids[PIDTYPE_MAX];
+	struct pid_link pids[PIDTYPE_MAX];
 	struct list_head thread_group;
 
 	struct completion *vfork_done;		/* for vfork() */
@@ -902,7 +902,7 @@ static inline pid_t process_group(struct
  */
 static inline int pid_alive(struct task_struct *p)
 {
-	return p->pids[PIDTYPE_PID].nr != 0;
+	return p->pids[PIDTYPE_PID].pid != NULL;
 }
 
 extern void free_task(struct task_struct *tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 2ac5bd1..af3c5eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1304,17 +1304,19 @@ long do_fork(unsigned long clone_flags,
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap();
+	struct pid *pid = alloc_pid();
+	long nr;
 
-	if (pid < 0)
+	if (!pid)
 		return -EAGAIN;
+	nr = pid->nr;
 	if (unlikely(current->ptrace)) {
 		trace = fork_traceflag (clone_flags);
 		if (trace)
 			clone_flags |= CLONE_PTRACE;
 	}
 
-	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, pid);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, nr);
 	/*
 	 * Do this prior waking up the new thread - the thread pointer
 	 * might get invalid after that point, if the thread exits quickly.
@@ -1341,7 +1343,7 @@ long do_fork(unsigned long clone_flags,
 			p->state = TASK_STOPPED;
 
 		if (unlikely (trace)) {
-			current->ptrace_message = pid;
+			current->ptrace_message = nr;
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
@@ -1351,10 +1353,10 @@ long do_fork(unsigned long clone_flags,
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
 	} else {
-		free_pidmap(pid);
-		pid = PTR_ERR(p);
+		free_pid(pid);
+		nr = PTR_ERR(p);
 	}
-	return pid;
+	return nr;
 }
 
 #ifndef ARCH_MIN_MMSTRUCT_ALIGN
diff --git a/kernel/pid.c b/kernel/pid.c
index a9f2dfd..8d49f2c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -28,8 +28,9 @@
 #include <linux/hash.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
-static struct hlist_head *pid_hash[PIDTYPE_MAX];
+static struct hlist_head *pid_hash;
 static int pidhash_shift;
+static kmem_cache_t *pid_cachep;
 
 int pid_max = PID_MAX_DEFAULT;
 int last_pid;
@@ -60,9 +61,21 @@ typedef struct pidmap {
 static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
 	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
 
+/* Note: disable interrupts while the pidmap_lock is held as an
+ * interrupt might come in and do read_lock(&tasklist_lock).
+ *
+ * If we don't disable interrupts there is a nasty deadlock between
+ * detach_pid()->free_pid() and another cpu that does
+ * spin_lock(&pidmap_lock) followed by an interrupt routing that does
+ * read_lock(&tasklist_lock);
+ *
+ * After we clean up the tasklist_lock and know there are no
+ * irq handlers that take it we can leave the interrupts enabled.
+ * For now it is easier to be safe than to prove it can't happen.
+ */
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
-fastcall void free_pidmap(int pid)
+static fastcall void free_pidmap(int pid)
 {
 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
 	int offset = pid & BITS_PER_PAGE_MASK;
@@ -71,7 +84,7 @@ fastcall void free_pidmap(int pid)
 	atomic_inc(&map->nr_free);
 }
 
-int alloc_pidmap(void)
+static int alloc_pidmap(void)
 {
 	int i, offset, max_scan, pid, last = last_pid;
 	pidmap_t *map;
@@ -89,12 +102,12 @@ int alloc_pidmap(void)
 			 * Free the page if someone raced with us
 			 * installing it:
 			 */
-			spin_lock(&pidmap_lock);
+			spin_lock_irq(&pidmap_lock);
 			if (map->page)
 				free_page(page);
 			else
 				map->page = (void *)page;
-			spin_unlock(&pidmap_lock);
+			spin_unlock_irq(&pidmap_lock);
 			if (unlikely(!map->page))
 				break;
 		}
@@ -131,13 +144,73 @@ int alloc_pidmap(void)
 	return -1;
 }
 
-struct pid * fastcall find_pid(enum pid_type type, int nr)
+fastcall void put_pid(struct pid *pid)
+{
+	if (!pid)
+		return;
+	if ((atomic_read(&pid->count) == 1) ||
+	     atomic_dec_and_test(&pid->count))
+		kmem_cache_free(pid_cachep, pid);
+}
+
+static void delayed_put_pid(struct rcu_head *rhp)
+{
+	struct pid *pid = container_of(rhp, struct pid, rcu);
+	put_pid(pid);
+}
+
+fastcall void free_pid(struct pid *pid)
+{
+	/* We can be called with write_lock_irq(&tasklist_lock) held */
+	unsigned long flags;
+
+	spin_lock_irqsave(&pidmap_lock, flags);
+	hlist_del_rcu(&pid->pid_chain);
+	spin_unlock_irqrestore(&pidmap_lock, flags);
+
+	free_pidmap(pid->nr);
+	call_rcu(&pid->rcu, delayed_put_pid);
+}
+
+struct pid *alloc_pid(void)
+{
+	struct pid *pid;
+	enum pid_type type;
+	int nr = -1;
+
+	pid = kmem_cache_alloc(pid_cachep, GFP_KERNEL);
+	if (!pid)
+		goto out;
+	
+	nr = alloc_pidmap();
+	if (nr < 0)
+		goto out_free;
+
+	atomic_set(&pid->count, 1);
+	pid->nr = nr;
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		INIT_HLIST_HEAD(&pid->tasks[type]);
+
+	spin_lock_irq(&pidmap_lock);
+	hlist_add_head_rcu(&pid->pid_chain, &pid_hash[pid_hashfn(pid->nr)]);
+	spin_unlock_irq(&pidmap_lock);
+
+out:
+	return pid;
+
+out_free:
+	kmem_cache_free(pid_cachep, pid);
+	pid = NULL;
+	goto out;
+}
+
+struct pid * fastcall find_pid(int nr)
 {
 	struct hlist_node *elem;
 	struct pid *pid;
 
 	hlist_for_each_entry_rcu(pid, elem,
-			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
+			&pid_hash[pid_hashfn(nr)], pid_chain) {
 		if (pid->nr == nr)
 			return pid;
 	}
@@ -146,77 +219,82 @@ struct pid * fastcall find_pid(enum pid_
 
 int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
 {
-	struct pid *pid, *task_pid;
-
-	task_pid = &task->pids[type];
-	pid = find_pid(type, nr);
-	task_pid->nr = nr;
-	if (pid == NULL) {
-		INIT_LIST_HEAD(&task_pid->pid_list);
-		hlist_add_head_rcu(&task_pid->pid_chain,
-				   &pid_hash[type][pid_hashfn(nr)]);
-	} else {
-		INIT_HLIST_NODE(&task_pid->pid_chain);
-		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
-	}
-
-	return 0;
-}
-
-static fastcall int __detach_pid(task_t *task, enum pid_type type)
-{
-	struct pid *pid, *pid_next;
-	int nr = 0;
+	struct pid_link *link;
+	struct pid *pid;
 
-	pid = &task->pids[type];
-	if (!hlist_unhashed(&pid->pid_chain)) {
+	WARN_ON(!task->pid); /* to be removed soon */
+	WARN_ON(!nr); /* to be removed soon */
 
-		if (list_empty(&pid->pid_list)) {
-			nr = pid->nr;
-			hlist_del_rcu(&pid->pid_chain);
-		} else {
-			pid_next = list_entry(pid->pid_list.next,
-						struct pid, pid_list);
-			/* insert next pid from pid_list to hash */
-			hlist_replace_rcu(&pid->pid_chain,
-					  &pid_next->pid_chain);
-		}
-	}
-
-	list_del_rcu(&pid->pid_list);
-	pid->nr = 0;
+	link = &task->pids[type];
+	link->pid = pid = find_pid(nr);
+	hlist_add_head_rcu(&link->node, &pid->tasks[type]);
 
-	return nr;
+	return 0;
 }
 
 void fastcall detach_pid(task_t *task, enum pid_type type)
 {
-	int tmp, nr;
+	struct pid_link *link;
+	struct pid *pid;
+	int tmp;
 
-	nr = __detach_pid(task, type);
-	if (!nr)
-		return;
+	link = &task->pids[type];
+	pid = link->pid;
+	
+	hlist_del_rcu(&link->node);
+	link->pid = NULL;
 
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
-		if (tmp != type && find_pid(tmp, nr))
+		if (!hlist_empty(&pid->tasks[tmp]))
 			return;
 
-	free_pidmap(nr);
+	free_pid(pid);
 }
 
+struct task_struct * fastcall pid_task(struct pid *pid, enum pid_type type)
+{
+	struct task_struct *result = NULL;
+	if (pid) {
+		struct hlist_node *first;
+		first = rcu_dereference(pid->tasks[type].first);
+		if (first)
+			result = hlist_entry(first, struct task_struct, pids[(type)].node);
+	}
+	return result;
+}
+  
+/*
+ * Must be called under rcu_read_lock() or with tasklist_lock read-held.
+ */
 task_t *find_task_by_pid_type(int type, int nr)
 {
-	struct pid *pid;
+	return pid_task(find_pid(nr), type);
+}
 
-	pid = find_pid(type, nr);
-	if (!pid)
-		return NULL;
+EXPORT_SYMBOL(find_task_by_pid_type);
 
-	return pid_task(&pid->pid_list, type);
+struct task_struct *fastcall get_pid_task(struct pid *pid, enum pid_type type)
+{
+	struct task_struct *result;
+	rcu_read_lock();
+	result = pid_task(pid, type);
+	if (result)
+		get_task_struct(result);
+	rcu_read_unlock();
+	return result;
 }
 
-EXPORT_SYMBOL(find_task_by_pid_type);
+struct pid *find_get_pid(pid_t nr)
+{
+	struct pid *pid;
+
+	rcu_read_lock();
+	pid = get_pid(find_pid(nr));
+	rcu_read_unlock();
 
+	return pid;
+}
+  
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
@@ -224,7 +302,7 @@ EXPORT_SYMBOL(find_task_by_pid_type);
  */
 void __init pidhash_init(void)
 {
-	int i, j, pidhash_size;
+	int i, pidhash_size;
 	unsigned long megabytes = nr_kernel_pages >> (20 - PAGE_SHIFT);
 
 	pidhash_shift = max(4, fls(megabytes * 4));
@@ -233,16 +311,13 @@ void __init pidhash_init(void)
 
 	printk("PID hash table entries: %d (order: %d, %Zd bytes)\n",
 		pidhash_size, pidhash_shift,
-		PIDTYPE_MAX * pidhash_size * sizeof(struct hlist_head));
+		pidhash_size * sizeof(struct hlist_head));
 
-	for (i = 0; i < PIDTYPE_MAX; i++) {
-		pid_hash[i] = alloc_bootmem(pidhash_size *
-					sizeof(*(pid_hash[i])));
-		if (!pid_hash[i])
-			panic("Could not alloc pidhash!\n");
-		for (j = 0; j < pidhash_size; j++)
-			INIT_HLIST_HEAD(&pid_hash[i][j]);
-	}
+	pid_hash = alloc_bootmem(pidhash_size *	sizeof(*(pid_hash)));
+	if (!pid_hash)
+		panic("Could not alloc pidhash!\n");
+	for (i = 0; i < pidhash_size; i++)
+		INIT_HLIST_HEAD(&pid_hash[i]);
 }
 
 void __init pidmap_init(void)
@@ -251,4 +326,8 @@ void __init pidmap_init(void)
 	/* Reserve PID 0. We never call free_pidmap(0) */
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);
+
+	pid_cachep = kmem_cache_create("pid", sizeof(struct pid),
+					__alignof__(struct pid),
+					SLAB_PANIC, NULL, NULL);
 }
-- 
1.2.2.g709a-dirty

