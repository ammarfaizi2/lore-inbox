Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWBWPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWBWPzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWBWPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:55:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54678 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751465AbWBWPzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:55:37 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 08:54:29 -0700
In-Reply-To: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Thu, 23 Feb 2006 08:52:59 -0700")
Message-ID: <m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Holding a reference to a task_struct pins about 10K of low memory even
after that task has exited.  Which seems to be at 1 or 2 orders of
mangnitude more memory than any other data structure in the kernel.
Not holding a reference to a task_struct and you risk problems with
pid wrap around.

Even worse because we allow session and process group leaders to exit
there is no task_struct you can hold onto to prevent pid wrap around
problems for those kinds of structures.

The task_ref is an small intermediate data structure that other
structures can point, that solves these problems.  A task_ref will
always point at the first user of a pid value or contain a NULL
pointer if there are no longer any users of that pid.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/pid.h      |    4 +
 include/linux/task_ref.h |   69 ++++++++++++++++++++++++
 kernel/Makefile          |    2 -
 kernel/fork.c            |    7 ++
 kernel/pid.c             |   12 ++++
 kernel/task_ref.c        |  131 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 224 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/task_ref.h
 create mode 100644 kernel/task_ref.c

8622b332e1e3c5ca2e451828f127e91729ae497f
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 099e70e..2849b7d 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+struct task_ref;
+
 enum pid_type
 {
 	PIDTYPE_PID,
@@ -17,6 +19,8 @@ struct pid
 	struct hlist_node pid_chain;
 	/* list of pids with the same nr, only one of them is in the hash */
 	struct list_head pid_list;
+	/* Does a weak reference of this type exist to the task struct? */
+	struct task_ref *ref;
 };
 
 #define pid_task(elem, type) \
diff --git a/include/linux/task_ref.h b/include/linux/task_ref.h
new file mode 100644
index 0000000..e8446bd
--- /dev/null
+++ b/include/linux/task_ref.h
@@ -0,0 +1,69 @@
+#ifndef _LINUX_TASK_REF_H
+#define _LINUX_TASK_REF_H
+
+/* What is a task_ref?
+ *
+ * A task_ref is a structure that holds a pointer to a task_struct, but
+ * instead of holding a reference count to the task_struct a backwards
+ * pointer from the task_struct to the task_ref is maintained.  When
+ * the task exits that references is broken and the task_struct
+ * pointer in the task_ref is cleared to NULL.
+ *
+ * This allows tracking a task_struct without pinning it in memory.  A
+ * task_struct plus a stack consumes around 10K of low kernel memory.
+ * More precisely this is THREAD_SIZE + sizeof(struct task_struct).
+ * By comparision a task_ref is between 16 and 20 bytes.
+ *
+ * The task_ref allows tracking not individual pids but also any pid_type.
+ * This means we can stop using individual pids in kernel data
+ * structures and directly track the processes those pids refer to.
+ * This advantage is that this allows the kernel to avoid pid wrap
+ * problems with it's internal references.
+ *
+ *
+ * Using a pointer to a pointer can be awkward, especially if you
+ * always must test to see if that pointer is NULL before using it.
+ *
+ * I simply things by including having the init_tref member
+ * and the tref_init, tref_set, tref_reset, and tref_fini functions
+ * for manipulating a task_ref pointer.  They take care of reference
+ * counting and ensuring that a task_ref pointer will point to
+ * init_task_ref if it does not have something useful to point to.
+ *
+ */
+
+struct task_struct;
+enum pid_type;
+
+struct task_ref
+{
+	atomic_t count;
+	enum pid_type type;
+	pid_t pid;
+	struct task_struct *task;
+};
+
+/* Note to read a usable value task value from struct task_ref
+ * the tasklist_lock must be held.  The atomic property of single
+ * word reads will keep any value you read consistent but it doesn't
+ * protect you from the race of the task exiting on another cpu and
+ * having it's task_struct freed or reused.  Holding the tasklist_lock
+ * prevents the task from going away as you dereference the task pointer.
+ */
+
+extern struct task_ref init_tref;
+
+extern void tref_put(struct task_ref *ref);
+extern struct task_ref *tref_get(struct task_ref *ref);
+extern struct task_ref *tref_get_by_task(task_t *task, enum pid_type type);
+extern struct task_ref *tref_get_by_pid(int pid, enum pid_type type);
+
+extern void tref_init(struct task_ref **dst);
+extern void tref_set(struct task_ref **dst, struct task_ref *ref);
+extern void tref_reset(struct task_ref **dst);
+extern void tref_fini(struct task_ref **dst);
+
+extern struct task_struct *get_tref_task(const struct task_ref *tref);
+
+
+#endif /* _LINUX_TASK_REF_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ae0fbd..d8c0970 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -5,7 +5,7 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o pid.o \
+	    signal.o sys.o kmod.o workqueue.o pid.o task_ref.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o
diff --git a/kernel/fork.c b/kernel/fork.c
index fbea12d..3f56d5a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -157,6 +157,7 @@ void __init fork_init(unsigned long memp
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
+	int type;
 	struct task_struct *tsk;
 	struct thread_info *ti;
 
@@ -179,6 +180,12 @@ static struct task_struct *dup_task_stru
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
+
+	/* Initially there are no weak references to this task */
+	for (type = 0; type < PIDTYPE_MAX; type++) {
+		tsk->pids[type].nr = 0;
+		tsk->pids[type].ref = NULL;
+	}
 	return tsk;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 7781d99..f365dbb 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/hash.h>
+#include <linux/task_ref.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
 static struct hlist_head *pid_hash[PIDTYPE_MAX];
@@ -151,6 +152,7 @@ int fastcall attach_pid(task_t *task, en
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	task_pid->nr = nr;
+	task_pid->ref = NULL;
 	if (pid == NULL) {
 		INIT_LIST_HEAD(&task_pid->pid_list);
 		hlist_add_head_rcu(&task_pid->pid_chain,
@@ -165,18 +167,28 @@ int fastcall attach_pid(task_t *task, en
 
 static fastcall int __detach_pid(task_t *task, enum pid_type type)
 {
+	task_t *task_next;
 	struct pid *pid, *pid_next;
+	struct task_ref *ref;
 	int nr = 0;
 
 	pid = &task->pids[type];
+	ref = pid->ref;
 	if (!hlist_unhashed(&pid->pid_chain)) {
 
 		if (list_empty(&pid->pid_list)) {
+			if (ref)
+				ref->task = NULL;
 			nr = pid->nr;
 			hlist_del_rcu(&pid->pid_chain);
 		} else {
+			task_next = pid_task(pid->pid_list.next, type);
 			pid_next = list_entry(pid->pid_list.next,
 						struct pid, pid_list);
+			/* Update the reference to point at the next task */
+			if (ref)
+				ref->task = task_next;
+			pid_next->ref = ref;
 			/* insert next pid from pid_list to hash */
 			hlist_replace_rcu(&pid->pid_chain,
 					  &pid_next->pid_chain);
diff --git a/kernel/task_ref.c b/kernel/task_ref.c
new file mode 100644
index 0000000..2f0a880
--- /dev/null
+++ b/kernel/task_ref.c
@@ -0,0 +1,131 @@
+#include <linux/sched.h>
+#include <linux/task_ref.h>
+
+struct task_ref init_tref = {
+	.count = ATOMIC_INIT(1),
+	.type  = PIDTYPE_PID,
+	.pid   = 0,
+	.task  = NULL,
+};
+
+void tref_put(struct task_ref *ref)
+{
+	might_sleep();
+	if (atomic_dec_and_test(&ref->count)) {
+		struct task_struct *task;
+		BUG_ON(ref == &init_tref);
+		/* Carefully serialize against __detach_pid and tref_get_by_pid */
+		write_lock_irq(&tasklist_lock);
+		task = ref->task;
+		if (task)
+			task->pids[ref->type].ref = NULL;
+		write_unlock_irq(&tasklist_lock);
+		kfree(ref);
+	}
+}
+
+struct task_ref *tref_get(struct task_ref *ref)
+{
+	atomic_inc(&ref->count);
+	return ref;
+}
+
+struct task_ref *tref_get_by_task(struct task_struct *task, enum pid_type type)
+{
+	struct task_ref *new_ref, *ref = NULL;
+	struct pid *pid;
+	might_sleep();
+	
+	/* Get the pid hash table entry */
+	pid = &task->pids[type];
+
+	/* Safely get the an existing reference */
+	read_lock(&tasklist_lock);
+	ref = pid->ref;
+	if (ref)
+		tref_get(ref);
+	read_unlock(&tasklist_lock);
+	if (ref)
+		goto out;
+
+	/* There was not an existing task ref so allocate one */
+	new_ref = kmalloc(sizeof(*new_ref), GFP_KERNEL);
+	if (new_ref) {
+		/* Carefully serialize against __detach_pid and tref_put */
+		write_lock_irq(&tasklist_lock);
+		ref = pid->ref;
+		if (ref)
+			tref_get(ref);
+		else if (pid->nr) {
+			atomic_set(&new_ref->count, 1);
+			new_ref->type = type;
+			new_ref->pid  = pid->nr;
+			new_ref->task = task;
+			pid->ref = ref = new_ref;
+		}
+		write_unlock_irq(&tasklist_lock);
+		if (ref != new_ref)
+			kfree(new_ref);
+	}
+out:
+	if (!ref)
+		ref = tref_get(&init_tref);
+	return ref;
+}
+
+struct task_ref *tref_get_by_pid(int pid, enum pid_type type)
+{
+	struct task_struct *task;
+	struct task_ref *tref;
+
+	/* Lookup the and pin the task */
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid_type(type, pid);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+
+	/* Now get the tref */
+	if (task) {
+		tref = tref_get_by_task(task, type);
+		put_task_struct(task);
+	}
+	else
+		tref = tref_get(&init_tref);
+	return tref;
+}
+
+void tref_init(struct task_ref **dst)
+{
+	*dst = tref_get(&init_tref);
+}
+
+void tref_set(struct task_ref **dst, struct task_ref *ref)
+{
+	tref_put(*dst);
+	*dst = ref;
+}
+
+void tref_reset(struct task_ref **dst)
+{
+	tref_put(*dst);
+	*dst = tref_get(&init_tref);
+}
+
+void tref_fini(struct task_ref **dst)
+{
+	tref_put(*dst);
+	*dst = NULL;
+}
+
+
+struct task_struct *get_tref_task(const struct task_ref *tref)
+{
+	struct task_struct *task;
+	read_lock(&tasklist_lock);
+	task = tref->task;
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
+	return task;
+}
-- 
1.2.2.g709a

