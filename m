Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWA2HXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWA2HXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWA2HXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:23:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13279 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750884AbWA2HXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:23:18 -0500
To: <linux-kernel@vger.kernel.org>
CC: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:22:34 -0700
In-Reply-To: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Sun, 29 Jan 2006 00:19:56 -0700")
Message-ID: <m1lkwza479.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Holding a reference to a task for purposes of possibly sending
it a signal later can potentially pin large amounts of memory.

Not holding a reference to a task but instead using pids can
result in the wrong task getting the signal.

struct task_ref and the associtated tref functions should get
around this problem.  It provides a 3 word reference counted
structure that can be pointed at instead of a task.  struct
task_ref then points at the task for you.  This structure is
updated whenever a task exits so that it is alwasy pointing
at a valid task or it is a NULL pointer.

In addition task_ref has a type field and is associated
with a type of pid.  This allows it to track process groups
and sessions as well as individual task structures.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/pid.h   |    2 +
 include/linux/sched.h |   27 ++++++++++++++++
 kernel/fork.c         |    8 +++++
 kernel/pid.c          |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 0 deletions(-)

29bb70ab97b015cb393aa13ee30cd179b755d1c1
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 5b2fcb1..e206149 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -17,6 +17,8 @@ struct pid
 	struct hlist_node pid_chain;
 	/* list of pids with the same nr, only one of them is in the hash */
 	struct list_head pid_list;
+	/* Does a weak references of this type exsit to the task struct? */
+	struct task_ref *ref;
 };
 
 #define pid_task(elem, type) \
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8645ae1..12f3cc5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -252,6 +252,33 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct mm_struct *, unsigned long);
 extern void arch_unmap_area_topdown(struct mm_struct *, unsigned long);
 
+struct task_ref
+{
+	atomic_t count;
+	enum pid_type type;
+	struct task_struct *task;
+};
+
+/* Note to read a usable value task value from struct task_ref
+ * the tasklist_lock must be held.  The atomic property of single
+ * word reads will keep any vaule you read consistent but it doesn't
+ * protect you from the race of the task exiting on another cpu and
+ * having it's task_struct freed or reused.  Holding the tasklist_lock
+ * prevents the task from going away as you derference the task pointer.
+ */
+
+extern struct task_ref init_tref;
+#define TASK_REF_INIT (&init_tref)
+#define TASK_REF(name) \
+	struct task_ref *name = TASK_REF_INIT
+
+extern void tref_put(struct task_ref *ref);
+extern struct task_ref *tref_get(struct task_ref *ref);
+extern struct task_ref *tref_get_by_task(task_t *task, enum pid_type type);
+extern struct task_ref *tref_get_by_pid(int who, enum pid_type type);
+extern void tref_set(struct task_ref **dst, struct task_ref *ref);
+extern void tref_clear(struct task_ref **dst);
+
 #if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
 /*
  * The mm counters are not protected by its page_table_lock,
diff --git a/kernel/fork.c b/kernel/fork.c
index 4ae8cfc..0b0df9c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -157,6 +157,7 @@ void __init fork_init(unsigned long memp
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
+	int type;
 	struct task_struct *tsk;
 	struct thread_info *ti;
 
@@ -179,6 +180,13 @@ static struct task_struct *dup_task_stru
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
+	
+	/* Initially there are no weak references to this task */
+	for(type = 0; type < PIDTYPE_MAX; type++) {
+		tsk->pids[type].nr = 0;
+		tsk->pids[type].ref = TASK_REF_INIT;
+	}
+
 	return tsk;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 7890867..7c40310 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -168,21 +168,31 @@ int fastcall attach_pid(task_t *task, en
 
 static fastcall int __detach_pid(task_t *task, enum pid_type type)
 {
+	task_t *task_next;
 	struct pid *pid, *pid_next;
+	struct task_ref *ref;
 	int nr = 0;
 
 	pid = &task->pids[type];
+	ref = pid->ref;
 	if (!pid->nr)
 		goto out;
 
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
@@ -223,6 +233,78 @@ task_t *find_task_by_pid_type(int type, 
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+struct task_ref init_tref = {
+	.count = ATOMIC_INIT(0),
+	.type  = PIDTYPE_PID,
+	.task  = NULL,
+};
+
+void tref_put(struct task_ref *ref)
+{
+	if (ref && (ref != &init_tref) && atomic_dec_and_test(&ref->count)) {
+		write_lock(&tasklist_lock);
+		if (ref->task)
+			ref->task->pids[ref->type].ref = &init_tref;
+		write_unlock(&tasklist_lock);
+		kfree(ref);
+	}
+}
+
+struct task_ref *tref_get(struct task_ref *ref)
+{
+	if (!ref)
+		ref = &init_tref;
+	if (ref != &init_tref)
+		atomic_inc(&ref->count);
+	return ref;
+}
+
+struct task_ref *tref_get_by_task(task_t *task, enum pid_type type)
+{
+	struct task_ref *ref;
+
+	write_lock(&tasklist_lock);
+	ref = &init_tref;
+	if (task && pid_alive(task)) {
+		ref = task->pids[type].ref;
+		if ((ref == &init_tref) && pid_alive(task)) {
+			struct task_ref *new_ref;
+			new_ref = kmalloc(sizeof(*new_ref), GFP_KERNEL);
+			if (new_ref) {
+				atomic_set(&new_ref->count, 0);
+				new_ref->type = type;
+				new_ref->task = task;
+				task->pids[type].ref = new_ref;
+				ref = new_ref;
+			}
+		}
+	}
+	ref = tref_get(ref);
+	write_unlock(&tasklist_lock);
+	return ref;
+}
+
+struct task_ref *tref_get_by_pid(int who, enum pid_type type)
+{
+	task_t *task;
+	task = find_task_by_pid_type(type, who);
+	return tref_get_by_task(task, type);
+}
+
+void tref_set(struct task_ref **dst, struct task_ref *ref)
+{
+	tref_put(*dst);
+	if (!ref)
+		ref = &init_tref;
+	*dst = ref;
+}
+
+void tref_clear(struct task_ref **dst)
+{
+	tref_put(*dst);
+	*dst = &init_tref;
+}
+
 /*
  * This function switches the PIDs if a non-leader thread calls
  * sys_execve() - this must be done without releasing the PID.
-- 
1.1.5.g3480

