Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWFNAAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWFNAAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFNAAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:00:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43649 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964815AbWFNAAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:00:37 -0400
Subject: [PATCH 01/11] Task watchers:  Task Watchers
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Hellwig <hch@lst.de>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:53:30 -0700
Message-Id: <1150242810.21787.140.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a notifier chain to inform watchers that a task is forking, execing,
changing an id, or exiting. This allows watchers to monitor these paths without
adding their own code directly to the paths.

Adding a watcher is likely to be much more maintainable when it is insensitive
to the order it is added to the chain. This means watchers should avoid
setting the priority field of the notifier blocks they are registering.
If ordering is necessary then adding calls directly in the paths in question
is probably a better idea.

WATCH_TASK_INIT is called before fork/clone complete. WATCH_TASK_CLONE is
called just before completion for fork/clone. Watchers may prevent a 
WATCH_TASK_CLONE from succeeding by returning with NOTIFY_STOP_MASK set.
However watchers are strongly discouraged from returning with NOTIFY_STOP_MASK
set from WATCH_TASK_INIT -- it may interfere with the operation of other
watchers.

WATCH_TASK_EXEC is called just before successfully returning from the exec
system call.

WATCH_TASK_UID is called every time a task's real or effective user id change.

WATCH_TASK_GID is called every time a task's real or effective group id change.

WATCH_TASK_EXIT is called at the beginning of do_exit when a task is exiting
for any reason. WATCH_TASK_FREE is called before critical task structures like
the mm_struct become inaccessible and the task is subsequently freed. Watchers
must never return NOTIFY_STOP_MASK in response to WATCH_TASK_FREE. Doing so
will prevent other watchers from cleaning up and could cause a wide variety of 
"bad things" to happen.

For every WATCH_TASK_INIT and WATCH_TASK_CLONE, a corresponding
WATCH_TASK_FREE is guaranteed.

Because fork/clone may be failed by another watcher, a watcher may see a
WATCH_TASK_FREE without a preceding WATCH_TASK_INIT or WATCH_TASK_CLONE.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Jes Sorensen <jes@sgi.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
--

ChangeLog:
        Added ability to cause fork to fail with NOTIFY_STOP_MASK
        Added WARN_ON() when watchers cause WATCH_TASK_FREE to stop early
        Moved fork invocation
        Moved exec invocation
        Added current as argument to exec invocation
        Moved exit code assignment
        Added id change invocations

 fs/exec.c                |    2 ++
 include/linux/notifier.h |   14 ++++++++++++++
 include/linux/sched.h    |    1 +
 kernel/exit.c            |    8 +++++++-
 kernel/fork.c            |   18 +++++++++++++++---
 kernel/sys.c             |   31 +++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc6-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc6-mm2/kernel/exit.c
@@ -38,10 +38,11 @@
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -847,12 +848,15 @@ static void exit_notify(struct task_stru
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
 	struct taskstats *tidstats, *tgidstats;
 	int group_dead;
+	int notify_result;
 
 	profile_task_exit(tsk);
+	tsk->exit_code = code;
+	notify_result = notify_watchers(WATCH_TASK_EXIT, tsk);
 
 	WARN_ON(atomic_read(&tsk->fs_excl));
 
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
@@ -913,13 +917,16 @@ fastcall NORET_TYPE void do_exit(long co
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
 	if (unlikely(tsk->audit_context))
 		audit_free(tsk);
+	tsk->exit_code = code;
 	taskstats_exit_send(tsk, tidstats, tgidstats);
 	taskstats_exit_free(tidstats, tgidstats);
 	delayacct_tsk_exit(tsk);
+	notify_result = notify_watchers(WATCH_TASK_FREE, tsk);
+	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 
 	exit_mm(tsk);
 
 	exit_sem(tsk);
 	__exit_files(tsk);
@@ -934,11 +941,10 @@ fastcall NORET_TYPE void do_exit(long co
 
 	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
-	tsk->exit_code = code;
 	proc_exit_connector(tsk);
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
Index: linux-2.6.17-rc6-mm2/kernel/fork.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/fork.c
+++ linux-2.6.17-rc6-mm2/kernel/fork.c
@@ -44,10 +44,11 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
+#include <linux/notifier.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -942,10 +943,11 @@ static task_t *copy_process(unsigned lon
 				 int __user *parent_tidptr,
 				 int __user *child_tidptr,
 				 int pid)
 {
 	int retval;
+	int notify_result;
 	struct task_struct *p = NULL;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
@@ -1040,10 +1042,18 @@ static task_t *copy_process(unsigned lon
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
+
+	p->tgid = p->pid;
+	if (clone_flags & CLONE_THREAD)
+		p->tgid = current->tgid;
+
+	notify_result = notify_watchers(WATCH_TASK_INIT, p);
+	if (notify_result & NOTIFY_STOP_MASK)
+		goto bad_fork_cleanup;
 	cpuset_fork(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
  		retval = PTR_ERR(p->mempolicy);
@@ -1076,13 +1086,10 @@ static task_t *copy_process(unsigned lon
 	p->softirq_disable_ip = 0;
 	p->softirq_disable_event = 0;
 	p->hardirq_context = 0;
 	p->softirq_context = 0;
 #endif
-	p->tgid = p->pid;
-	if (clone_flags & CLONE_THREAD)
-		p->tgid = current->tgid;
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
 	if ((retval = audit_alloc(p)))
 		goto bad_fork_cleanup_security;
@@ -1243,10 +1250,13 @@ static task_t *copy_process(unsigned lon
 	}
 
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	notify_result = notify_watchers(WATCH_TASK_CLONE, p);
+	if (notify_result & NOTIFY_STOP_MASK)
+		goto bad_fork_cleanup_namespaces;
 	proc_fork_connector(p);
 	return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
@@ -1267,10 +1277,12 @@ bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_audit:
 	audit_free(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
+	notify_result = notify_watchers(WATCH_TASK_FREE, p);
+	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
 	mpol_free(p->mempolicy);
 bad_fork_cleanup_cpuset:
 #endif
Index: linux-2.6.17-rc6-mm2/fs/exec.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/exec.c
+++ linux-2.6.17-rc6-mm2/fs/exec.c
@@ -48,10 +48,11 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
 #ifdef CONFIG_KMOD
@@ -1095,10 +1096,11 @@ int search_binary_handler(struct linux_b
 				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
 				current->did_exec = 1;
+				notify_watchers(WATCH_TASK_EXEC, current);
 				proc_exec_connector(current);
 				return retval;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
Index: linux-2.6.17-rc6-mm2/include/linux/notifier.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/notifier.h
+++ linux-2.6.17-rc6-mm2/include/linux/notifier.h
@@ -152,7 +152,21 @@ extern int raw_notifier_call_chain(struc
 #define CPU_UP_CANCELED		0x0004 /* CPU (unsigned)v NOT coming up */
 #define CPU_DOWN_PREPARE	0x0005 /* CPU (unsigned)v going down */
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
 
+extern int register_task_watcher(struct notifier_block *nb);
+extern int unregister_task_watcher(struct notifier_block *nb);
+#define WATCH_FLAGS_MASK		((-1) ^ 0x0FFFFUL)
+#define get_watch_event(v)		({ ((v) & ~WATCH_FLAGS_MASK); })
+#define get_watch_flags(v) 		({ ((v) & WATCH_FLAGS_MASK); })
+
+#define WATCH_TASK_INIT			0x00000001 /* initialize task_struct */
+#define WATCH_TASK_CLONE		0x00000002 /* "after" clone */
+#define WATCH_TASK_EXEC			0x00000003
+#define WATCH_TASK_UID			0x00000004  /* [re]uid changed */
+#define WATCH_TASK_GID			0x00000005  /* [re]gid changed */
+#define WATCH_TASK_EXIT			0x0000FFFE
+#define WATCH_TASK_FREE			0x0000FFFF
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
Index: linux-2.6.17-rc6-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/sched.h
+++ linux-2.6.17-rc6-mm2/include/linux/sched.h
@@ -210,10 +210,11 @@ long io_schedule_timeout(long timeout);
 
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
+extern int notify_watchers(unsigned long, void *);
 
 #ifdef CONFIG_DETECT_SOFTLOCKUP
 extern void softlockup_tick(void);
 extern void spawn_softlockup_task(void);
 extern void touch_softlockup_watchdog(void);
Index: linux-2.6.17-rc6-mm2/kernel/sys.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
+++ linux-2.6.17-rc6-mm2/kernel/sys.c
@@ -433,10 +433,33 @@ int unregister_reboot_notifier(struct no
 	return blocking_notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
+/* task watchers notifier chain */
+static ATOMIC_NOTIFIER_HEAD(task_watchers);
+
+int register_task_watcher(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&task_watchers, nb);
+}
+
+EXPORT_SYMBOL_GPL(register_task_watcher);
+
+int unregister_task_watcher(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&task_watchers, nb);
+}
+
+EXPORT_SYMBOL_GPL(unregister_task_watcher);
+
+int notify_watchers(unsigned long val, void *v)
+{
+	return atomic_notifier_call_chain(&task_watchers, val, v);
+}
+
+
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;
 
 	if (p->uid != current->euid &&
@@ -838,10 +861,11 @@ asmlinkage long sys_setregid(gid_t rgid,
 		current->sgid = new_egid;
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
+	notify_watchers(WATCH_TASK_GID, current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 /*
@@ -878,10 +902,11 @@ asmlinkage long sys_setgid(gid_t gid)
 	}
 	else
 		return -EPERM;
 
 	key_fsgid_changed(current);
+	notify_watchers(WATCH_TASK_GID, current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
@@ -968,10 +993,11 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
 	key_fsuid_changed(current);
+	notify_watchers(WATCH_TASK_UID, current);
 	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -1016,10 +1042,11 @@ asmlinkage long sys_setuid(uid_t uid)
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
 	key_fsuid_changed(current);
+	notify_watchers(WATCH_TASK_UID, current);
 	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -1065,10 +1092,11 @@ asmlinkage long sys_setresuid(uid_t ruid
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
 	key_fsuid_changed(current);
+	notify_watchers(WATCH_TASK_UID, current);
 	proc_id_connector(current, PROC_EVENT_UID);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -1118,10 +1146,11 @@ asmlinkage long sys_setresgid(gid_t rgid
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
 	key_fsgid_changed(current);
+	notify_watchers(WATCH_TASK_GID, current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	return 0;
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
@@ -1161,10 +1190,11 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		}
 		current->fsuid = uid;
 	}
 
 	key_fsuid_changed(current);
+	notify_watchers(WATCH_TASK_UID, current);
 	proc_id_connector(current, PROC_EVENT_UID);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
@@ -1190,10 +1220,11 @@ asmlinkage long sys_setfsgid(gid_t gid)
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
+		notify_watchers(WATCH_TASK_GID, current);
 		proc_id_connector(current, PROC_EVENT_GID);
 	}
 	return old_fsgid;
 }
 

--

