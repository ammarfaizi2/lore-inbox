Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWI2CNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWI2CNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWI2CNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14800 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751356AbWI2CNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:04 -0400
Message-Id: <20060929021301.951244000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:41 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>,
       David Howells <dhowells@redhat.com>
Subject: [RFC][PATCH 09/10] Task watchers v2 Register process keyrings task watcher
Content-Disposition: inline; filename=task-watchers-register-keys
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the keyring code use a task watcher to initialize and free per-task data.

NOTE:
We can't make copy_thread_group_keys() in copy_signal() a task watcher because it needs the task's signal field (struct signal_struct).

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>
---
 include/linux/key.h          |    8 --------
 kernel/exit.c                |    2 --
 kernel/fork.c                |    6 +-----
 kernel/sys.c                 |    8 --------
 security/keys/process_keys.c |   19 ++++++++++++-------
 5 files changed, 13 insertions(+), 30 deletions(-)

Index: linux-2.6.18-mm1/include/linux/key.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/key.h
+++ linux-2.6.18-mm1/include/linux/key.h
@@ -335,18 +335,14 @@ extern void keyring_replace_payload(stru
  */
 extern struct key root_user_keyring, root_session_keyring;
 extern int alloc_uid_keyring(struct user_struct *user,
 			     struct task_struct *ctx);
 extern void switch_uid_keyring(struct user_struct *new_user);
-extern int copy_keys(unsigned long clone_flags, struct task_struct *tsk);
 extern int copy_thread_group_keys(struct task_struct *tsk);
-extern void exit_keys(struct task_struct *tsk);
 extern void exit_thread_group_keys(struct signal_struct *tg);
 extern int suid_keys(struct task_struct *tsk);
 extern int exec_keys(struct task_struct *tsk);
-extern void key_fsuid_changed(struct task_struct *tsk);
-extern void key_fsgid_changed(struct task_struct *tsk);
 extern void key_init(void);
 
 #define __install_session_keyring(tsk, keyring)			\
 ({								\
 	struct key *old_session = tsk->signal->session_keyring;	\
@@ -365,18 +361,14 @@ extern void key_init(void);
 #define key_ref_to_ptr(k)		({ NULL; })
 #define is_key_possessed(k)		0
 #define alloc_uid_keyring(u,c)		0
 #define switch_uid_keyring(u)		do { } while(0)
 #define __install_session_keyring(t, k)	({ NULL; })
-#define copy_keys(f,t)			0
 #define copy_thread_group_keys(t)	0
-#define exit_keys(t)			do { } while(0)
 #define exit_thread_group_keys(tg)	do { } while(0)
 #define suid_keys(t)			do { } while(0)
 #define exec_keys(t)			do { } while(0)
-#define key_fsuid_changed(t)		do { } while(0)
-#define key_fsgid_changed(t)		do { } while(0)
 #define key_init()			do { } while(0)
 
 /* Initial keyrings */
 extern struct key root_user_keyring;
 extern struct key root_session_keyring;
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -1078,14 +1078,12 @@ static struct task_struct *copy_process(
 		goto bad_fork_cleanup_fs;
 	if ((retval = copy_signal(clone_flags, p)))
 		goto bad_fork_cleanup_sighand;
 	if ((retval = copy_mm(clone_flags, p)))
 		goto bad_fork_cleanup_signal;
-	if ((retval = copy_keys(clone_flags, p)))
-		goto bad_fork_cleanup_mm;
 	if ((retval = copy_namespaces(clone_flags, p)))
-		goto bad_fork_cleanup_keys;
+		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
 
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
@@ -1227,12 +1225,10 @@ static struct task_struct *copy_process(
 	proc_fork_connector(p);
 	return p;
 
 bad_fork_cleanup_namespaces:
 	exit_task_namespaces(p);
-bad_fork_cleanup_keys:
-	exit_keys(p);
 bad_fork_cleanup_mm:
 	if (p->mm)
 		mmput(p->mm);
 bad_fork_cleanup_signal:
 	cleanup_signal(p);
Index: linux-2.6.18-mm1/security/keys/process_keys.c
===================================================================
--- linux-2.6.18-mm1.orig/security/keys/process_keys.c
+++ linux-2.6.18-mm1/security/keys/process_keys.c
@@ -15,10 +15,11 @@
 #include <linux/slab.h>
 #include <linux/keyctl.h>
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/task_watchers.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
 /* session keyring create vs join semaphore */
 static DEFINE_MUTEX(key_session_mutex);
@@ -276,11 +277,11 @@ int copy_thread_group_keys(struct task_s
 
 /*****************************************************************************/
 /*
  * copy the keys for fork
  */
-int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
 {
 	key_check(tsk->thread_keyring);
 	key_check(tsk->request_key_auth);
 
 	/* no thread keyring yet */
@@ -290,10 +291,11 @@ int copy_keys(unsigned long clone_flags,
 	key_get(tsk->request_key_auth);
 
 	return 0;
 
 } /* end copy_keys() */
+task_watcher_func(init, copy_keys);
 
 /*****************************************************************************/
 /*
  * dispose of thread group keys upon thread group destruction
  */
@@ -306,16 +308,17 @@ void exit_thread_group_keys(struct signa
 
 /*****************************************************************************/
 /*
  * dispose of per-thread keys upon thread exit
  */
-void exit_keys(struct task_struct *tsk)
+static int exit_keys(unsigned long exit_code, struct task_struct *tsk)
 {
 	key_put(tsk->thread_keyring);
 	key_put(tsk->request_key_auth);
-
+	return 0;
 } /* end exit_keys() */
+task_watcher_func(free, exit_keys);
 
 /*****************************************************************************/
 /*
  * deal with execve()
  */
@@ -356,35 +359,37 @@ int suid_keys(struct task_struct *tsk)
 
 /*****************************************************************************/
 /*
  * the filesystem user ID changed
  */
-void key_fsuid_changed(struct task_struct *tsk)
+static int key_fsuid_changed(unsigned long ignored, struct task_struct *tsk)
 {
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
 		tsk->thread_keyring->uid = tsk->fsuid;
 		up_write(&tsk->thread_keyring->sem);
 	}
-
+	return 0;
 } /* end key_fsuid_changed() */
+task_watcher_func(uid, key_fsuid_changed);
 
 /*****************************************************************************/
 /*
  * the filesystem group ID changed
  */
-void key_fsgid_changed(struct task_struct *tsk)
+static int key_fsgid_changed(unsigned long ignored, struct task_struct *tsk)
 {
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
 		tsk->thread_keyring->gid = tsk->fsgid;
 		up_write(&tsk->thread_keyring->sem);
 	}
-
+	return 0;
 } /* end key_fsgid_changed() */
+task_watcher_func(gid, key_fsgid_changed);
 
 /*****************************************************************************/
 /*
  * search the process keyrings for the first matching key
  * - we use the supplied match function to see if the description (or other
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -12,11 +12,10 @@
 #include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/namespace.h>
-#include <linux/key.h>
 #include <linux/security.h>
 #include <linux/cpu.h>
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
 #include <linux/file.h>
@@ -917,11 +916,10 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead)
 		acct_process();
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_thread();
-	exit_keys(tsk);
 
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
 
 	module_put(task_thread_info(tsk)->exec_domain->module);
Index: linux-2.6.18-mm1/kernel/sys.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/sys.c
+++ linux-2.6.18-mm1/kernel/sys.c
@@ -956,11 +956,10 @@ asmlinkage long sys_setregid(gid_t rgid,
 	    (egid != (gid_t) -1 && egid != old_rgid))
 		current->sgid = new_egid;
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
-	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
@@ -992,11 +991,10 @@ asmlinkage long sys_setgid(gid_t gid)
 		current->egid = current->fsgid = gid;
 	}
 	else
 		return -EPERM;
 
-	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
   
@@ -1081,11 +1079,10 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
@@ -1129,11 +1126,10 @@ asmlinkage long sys_setuid(uid_t uid)
 		smp_wmb();
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
@@ -1178,11 +1174,10 @@ asmlinkage long sys_setresuid(uid_t ruid
 	}
 	current->fsuid = current->euid;
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
@@ -1231,11 +1226,10 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (rgid != (gid_t) -1)
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
 
-	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
 	notify_task_watchers(WATCH_TASK_GID, 0, current);
 	return 0;
 }
 
@@ -1273,11 +1267,10 @@ asmlinkage long sys_setfsuid(uid_t uid)
 			smp_wmb();
 		}
 		current->fsuid = uid;
 	}
 
-	key_fsuid_changed(current);
 	proc_id_connector(current, PROC_EVENT_UID);
 	notify_task_watchers(WATCH_TASK_UID, 0, current);
 
 	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
@@ -1301,11 +1294,10 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		if (gid != old_fsgid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
 		current->fsgid = gid;
-		key_fsgid_changed(current);
 		proc_id_connector(current, PROC_EVENT_GID);
 		notify_task_watchers(WATCH_TASK_GID, 0, current);
 	}
 	return old_fsgid;
 }

--
