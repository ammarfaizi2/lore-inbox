Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVJCSv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVJCSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVJCSv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:51:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60098 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932598AbVJCSv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:51:57 -0400
Date: Mon, 3 Oct 2005 13:51:55 -0500
From: Erik Jacobson <erikj@sgi.com>
To: pagg@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Process Notification / pnotify user: keyrings
Message-ID: <20051003185155.GB19106@sgi.com>
References: <20051003184644.GA19106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003184644.GA19106@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an example implementation showing keyrings using pnotify as
a proof of concecpt.  Not all the callouts that keyrings needs are
currently implemented in pnotify (but most could be if desired). 

Signed-off-by: Erik Jacobson <erikj@sgi.com>
---

 include/linux/key.h          |   21 +++++
 include/linux/sched.h        |    4 -
 kernel/exit.c                |    1
 kernel/fork.c                |    6 -
 security/keys/key.c          |   22 ++++++
 security/keys/keyctl.c       |   28 ++++++-
 security/keys/process_keys.c |  152 ++++++++++++++++++++++++++++++++++++-------
 security/keys/request_key.c  |   31 +++++++-
 8 files changed, 222 insertions(+), 43 deletions(-)


Index: linux/include/linux/key.h
===================================================================
--- linux.orig/include/linux/key.h	2005-09-19 22:00:41.000000000 -0500
+++ linux/include/linux/key.h	2005-09-27 09:46:07.501801117 -0500
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/rcupdate.h>
+#include <linux/pnotify.h>
 #include <asm/atomic.h>
 
 #ifdef __KERNEL__
@@ -262,9 +263,9 @@
 extern struct key root_user_keyring, root_session_keyring;
 extern int alloc_uid_keyring(struct user_struct *user);
 extern void switch_uid_keyring(struct user_struct *new_user);
-extern int copy_keys(unsigned long clone_flags, struct task_struct *tsk);
+extern int copy_keys(struct task_struct *tsk, struct pnotify_subscriber *sub, void *olddata);
 extern int copy_thread_group_keys(struct task_struct *tsk);
-extern void exit_keys(struct task_struct *tsk);
+extern void exit_keys(struct task_struct *task, struct pnotify_subscriber *sub);
 extern void exit_thread_group_keys(struct signal_struct *tg);
 extern int suid_keys(struct task_struct *tsk);
 extern int exec_keys(struct task_struct *tsk);
@@ -279,6 +280,22 @@
 	old_session;						\
 })
 
+/* pnotify subscriber service request */
+static struct pnotify_events key_events = {
+	.module = NULL,
+	.name = "key",
+	.data = NULL,
+	.entry = LIST_HEAD_INIT(key_events.entry),
+	.fork = copy_keys,
+	.exit = exit_keys,
+};
+
+/* key info associated with the task struct and managed by pnotify */
+struct key_task {
+	struct key *thread_keyring; /* keyring private to this thread */
+	unsigned char jit_keyring; /* default keyring to attach requested keys to */
+};
+
 #else /* CONFIG_KEYS */
 
 #define key_validate(k)			0
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2005-09-27 09:45:59.500655412 -0500
+++ linux/kernel/exit.c	2005-09-27 09:46:07.505706973 -0500
@@ -857,7 +857,6 @@
 	exit_namespace(tsk);
 	exit_thread();
 	cpuset_exit(tsk);
-	exit_keys(tsk);
 
 	if (group_dead && tsk->signal->leader)
 		disassociate_ctty(1);
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2005-09-27 09:40:40.824808451 -0500
+++ linux/kernel/fork.c	2005-09-27 09:46:07.506683436 -0500
@@ -1009,10 +1009,8 @@
 		goto bad_fork_cleanup_sighand;
 	if ((retval = copy_mm(clone_flags, p)))
 		goto bad_fork_cleanup_signal;
-	if ((retval = copy_keys(clone_flags, p)))
-		goto bad_fork_cleanup_mm;
 	if ((retval = copy_namespace(clone_flags, p)))
-		goto bad_fork_cleanup_keys;
+		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
@@ -1175,8 +1173,6 @@
 bad_fork_cleanup_namespace:
 	pnotify_exit(p);
 	exit_namespace(p);
-bad_fork_cleanup_keys:
-	exit_keys(p);
 bad_fork_cleanup_mm:
 	if (p->mm)
 		mmput(p->mm);
Index: linux/security/keys/key.c
===================================================================
--- linux.orig/security/keys/key.c	2005-09-19 22:00:41.000000000 -0500
+++ linux/security/keys/key.c	2005-09-27 09:46:07.511565756 -0500
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
+#include <linux/pnotify.h>
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
@@ -1009,6 +1010,9 @@
  */
 void __init key_init(void)
 {
+	struct key_task *kt;
+	struct pnotify_subscriber *sub;
+
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
@@ -1039,4 +1043,22 @@
 	/* link the two root keyrings together */
 	key_link(&root_session_keyring, &root_user_keyring);
 
+	/* Allocate memory for task assocated key_task structure */
+	kt = (struct key_task *)kmalloc(sizeof(struct key_task),GFP_KERNEL);
+	if (!kt) {
+		printk(KERN_ERR "Insufficient memory to allocate key_task structure"
+		  " in key_init function.\n");
+		return;
+   }
+	kt->thread_keyring = NULL;
+
+	/* subscribe this kernel entity to the subscriber list for current task */
+	sub = pnotify_subscribe(current, &key_events);
+	if (!sub) {
+		printk(KERN_ERR "Insufficient memory to add to subscriber list structure"
+		  " in key_init function.\n");
+	}
+	/* Associate the kt structure with this task via pnotify subscriber */
+	sub->data = (void *)kt;
+
 } /* end key_init() */
Index: linux/security/keys/process_keys.c
===================================================================
--- linux.orig/security/keys/process_keys.c	2005-09-19 22:00:41.000000000 -0500
+++ linux/security/keys/process_keys.c	2005-09-27 09:46:07.513518684 -0500
@@ -16,6 +16,7 @@
 #include <linux/keyctl.h>
 #include <linux/fs.h>
 #include <linux/err.h>
+#include <linux/pnotify.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
@@ -137,6 +138,8 @@
 int install_thread_keyring(struct task_struct *tsk)
 {
 	struct key *keyring, *old;
+	struct key_task *kt;
+	struct pnotify_subscriber *sub;
 	char buf[20];
 	int ret;
 
@@ -149,9 +152,21 @@
 	}
 
 	task_lock(tsk);
-	old = tsk->thread_keyring;
-	tsk->thread_keyring = keyring;
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(tsk, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "install_thread_keyring pnotify subscriber or data ptr null, task: %d\n", tsk->pid);
+		task_unlock(tsk);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		ret = PTR_ERR(sub);
+		goto error;
+	}
+	kt = (struct key_task *)sub->data;
+
+	old = kt->thread_keyring;
+	kt->thread_keyring = keyring;
 	task_unlock(tsk);
+	up_write(&tsk->pnotify_subscriber_list_sem);
 
 	ret = 0;
 
@@ -267,13 +282,25 @@
 /*
  * copy the keys for fork
  */
-int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
+int copy_keys(struct task_struct *tsk, struct pnotify_subscriber *sub, void *olddata)
 {
-	key_check(tsk->thread_keyring);
+	struct key_task *kt = ((struct key_task *)(sub->data));
+
+	/* Allocate memory for task-associated key_task structure */
+	kt = (struct key_task *)kmalloc(sizeof(struct key_task),GFP_KERNEL);
+	if (!kt) {
+		printk(KERN_ERR "Insufficient memory to allocate key_task structure"
+		  " in copy_keys function.  Task was: %d", tsk->pid);
+		return PNOTIFY_ERROR;
+	}
+	/* Associate key_task structure with the new child via pnotify subscriber */
+	sub->data = (void *)kt;
+
+	key_check(kt->thread_keyring);
 
 	/* no thread keyring yet */
-	tsk->thread_keyring = NULL;
-	return 0;
+	kt->thread_keyring = NULL;
+	return PNOTIFY_OK;
 
 } /* end copy_keys() */
 
@@ -292,9 +319,16 @@
 /*
  * dispose of keys upon thread exit
  */
-void exit_keys(struct task_struct *tsk)
+void exit_keys(struct task_struct *task, struct pnotify_subscriber *sub)
 {
-	key_put(tsk->thread_keyring);
+	struct key_task *kt = ((struct key_task *)(sub->data));
+	if (kt == NULL) { /* shouldn't ever happen */
+		printk(KERN_ERR "exit_keys pnotify subscriber data ptr null, task: %d\n", task->pid);
+		return;
+	}
+	key_put(kt->thread_keyring);
+	kfree(kt); /* Free pnotify subscriber data for this task */
+	sub->data = NULL;
 
 } /* end exit_keys() */
 
@@ -306,12 +340,28 @@
 {
 	unsigned long flags;
 	struct key *old;
+	struct key_task *kt;
+	struct pnotify_subscriber *sub;
 
-	/* newly exec'd tasks don't get a thread keyring */
 	task_lock(tsk);
-	old = tsk->thread_keyring;
-	tsk->thread_keyring = NULL;
+	/* pnotify doesn't have a compute_creds event at this time, so we
+	 * need to retrieve the data */
+
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(tsk, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "exec_keys pnotify subscriber or data ptr null, task: %d\n", tsk->pid);
+		task_unlock(tsk);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		return PNOTIFY_OK; /* key structures not populated yet */
+	}
+	kt = (struct key_task *)sub->data;
+
+	/* newly exec'd tasks don't get a thread keyring */
+	old = kt->thread_keyring;
+	kt->thread_keyring = NULL;
 	task_unlock(tsk);
+	up_write(&tsk->pnotify_subscriber_list_sem);
 
 	key_put(old);
 
@@ -344,12 +394,26 @@
  */
 void key_fsuid_changed(struct task_struct *tsk)
 {
+	struct key_task *kt;
+	struct pnotify_subscriber *sub;
+
+	/* no pnotify event for this, so we need to grab the data */
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(tsk, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "key_fsuid_changed pnotify subscriber or data ptr null, task: %d\n", tsk->pid);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		return;
+	}
+	kt = (struct key_task *)sub->data;
+
 	/* update the ownership of the thread keyring */
-	if (tsk->thread_keyring) {
-		down_write(&tsk->thread_keyring->sem);
-		tsk->thread_keyring->uid = tsk->fsuid;
-		up_write(&tsk->thread_keyring->sem);
+	if (kt->thread_keyring) {
+		down_write(&kt->thread_keyring->sem);
+		kt->thread_keyring->uid = tsk->fsuid;
+		up_write(&kt->thread_keyring->sem);
 	}
+	up_write(&tsk->pnotify_subscriber_list_sem);
 
 } /* end key_fsuid_changed() */
 
@@ -359,12 +423,26 @@
  */
 void key_fsgid_changed(struct task_struct *tsk)
 {
+	struct key_task *kt;
+	struct pnotify_subscriber *sub;
+
+	/* pnotify doesn't have an event for this, so we need to grab the data */
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(tsk, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "key_fsgid_changed pnotify subscriber or data ptr was null, task: %d\n", tsk->pid);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		return;
+	}
+	kt = (struct key_task *)sub->data;
+
 	/* update the ownership of the thread keyring */
-	if (tsk->thread_keyring) {
-		down_write(&tsk->thread_keyring->sem);
-		tsk->thread_keyring->gid = tsk->fsgid;
-		up_write(&tsk->thread_keyring->sem);
+	if (kt->thread_keyring) {
+		down_write(&kt->thread_keyring->sem);
+		kt->thread_keyring->gid = tsk->fsgid;
+		up_write(&kt->thread_keyring->sem);
 	}
+	up_write(&tsk->pnotify_subscriber_list_sem);
 
 } /* end key_fsgid_changed() */
 
@@ -383,6 +461,8 @@
 {
 	struct request_key_auth *rka;
 	struct key *key, *ret, *err, *instkey;
+	struct pnotify_subscriber *sub;
+	struct key_task *kt;
 
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
@@ -395,12 +475,23 @@
 	ret = NULL;
 	err = ERR_PTR(-EAGAIN);
 
+	down_write(&context->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(context, key_events.name);
+	if (sub == NULL || sub->data == NULL) {
+		printk(KERN_ERR "search_process_keyrings pnotify subscriber or data ptr null, task: %d\n", context->pid);
+		up_write(&context->pnotify_subscriber_list_sem);
+		return (struct key *)-EFAULT;
+	}
+	kt = (struct key_task *)sub->data;
+
 	/* search the thread keyring first */
-	if (context->thread_keyring) {
-		key = keyring_search_aux(context->thread_keyring,
+	if (kt->thread_keyring) {
+		key = keyring_search_aux(kt->thread_keyring,
 					 context, type, description, match);
-		if (!IS_ERR(key))
+		if (!IS_ERR(key)) {
+			up_write(&context->pnotify_subscriber_list_sem);
 			goto found;
+		}
 
 		switch (PTR_ERR(key)) {
 		case -EAGAIN: /* no key */
@@ -414,6 +505,7 @@
 			break;
 		}
 	}
+	up_write(&context->pnotify_subscriber_list_sem);
 
 	/* search the process keyring second */
 	if (context->signal->process_keyring) {
@@ -535,15 +627,26 @@
 {
 	struct key *key;
 	int ret;
+	struct pnotify_subscriber *sub;
+	struct key_task *kt;
 
 	if (!context)
 		context = current;
 
 	key = ERR_PTR(-ENOKEY);
 
+	down_write(&context->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(context, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "search_process_keyrings pnotify subscriber or data ptr null, task: %d\n", context->pid);
+		up_write(&context->pnotify_subscriber_list_sem);
+		return (struct key *)-EFAULT;
+	}
+	kt = (struct key_task *)sub->data;
+
 	switch (id) {
 	case KEY_SPEC_THREAD_KEYRING:
-		if (!context->thread_keyring) {
+		if (!kt->thread_keyring) {
 			if (!create)
 				goto error;
 
@@ -554,7 +657,7 @@
 			}
 		}
 
-		key = context->thread_keyring;
+		key = kt->thread_keyring;
 		atomic_inc(&key->usage);
 		break;
 
@@ -634,6 +737,7 @@
 		goto invalid_key;
 
  error:
+	up_write(&context->pnotify_subscriber_list_sem);
 	return key;
 
  invalid_key:
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2005-09-27 09:40:40.817973203 -0500
+++ linux/include/linux/sched.h	2005-09-27 09:46:07.515471612 -0500
@@ -718,10 +718,6 @@
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	unsigned keep_capabilities:1;
 	struct user_struct *user;
-#ifdef CONFIG_KEYS
-	struct key *thread_keyring;	/* keyring private to this thread */
-	unsigned char jit_keyring;	/* default keyring to attach requested keys to */
-#endif
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
 	char comm[TASK_COMM_LEN]; /* executable name excluding path
 				     - access with [gs]et_task_comm (which lock
Index: linux/security/keys/keyctl.c
===================================================================
--- linux.orig/security/keys/keyctl.c	2005-09-19 22:00:41.000000000 -0500
+++ linux/security/keys/keyctl.c	2005-09-27 09:46:07.517424540 -0500
@@ -931,31 +931,51 @@
 long keyctl_set_reqkey_keyring(int reqkey_defl)
 {
 	int ret;
+	unsigned char jit_return;
+	struct pnotify_subscriber *sub;
+	struct key_task *kt;
+
+	down_write(&current->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(current, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "keyctl_set_reqkey_keyring pnotify subscriber or data ptr null, task: %d\n", current->pid);
+		up_write(&current->pnotify_subscriber_list_sem);
+		return -EFAULT;
+	}
+	kt = (struct key_task *)sub->data;
 
 	switch (reqkey_defl) {
 	case KEY_REQKEY_DEFL_THREAD_KEYRING:
 		ret = install_thread_keyring(current);
-		if (ret < 0)
+		if (ret < 0) {
+			up_write(&current->pnotify_subscriber_list_sem);
 			return ret;
+		}
 		goto set;
 
 	case KEY_REQKEY_DEFL_PROCESS_KEYRING:
 		ret = install_process_keyring(current);
-		if (ret < 0)
+		if (ret < 0) {
+			up_write(&current->pnotify_subscriber_list_sem);
 			return ret;
+		}
 
 	case KEY_REQKEY_DEFL_DEFAULT:
 	case KEY_REQKEY_DEFL_SESSION_KEYRING:
 	case KEY_REQKEY_DEFL_USER_KEYRING:
 	case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
 	set:
-		current->jit_keyring = reqkey_defl;
+
+		kt->jit_keyring = reqkey_defl;
 
 	case KEY_REQKEY_DEFL_NO_CHANGE:
-		return current->jit_keyring;
+		jit_return = kt->jit_keyring;
+		up_write(&current->pnotify_subscriber_list_sem);
+		return jit_return;
 
 	case KEY_REQKEY_DEFL_GROUP_KEYRING:
 	default:
+		up_write(&current->pnotify_subscriber_list_sem);
 		return -EINVAL;
 	}
 
Index: linux/security/keys/request_key.c
===================================================================
--- linux.orig/security/keys/request_key.c	2005-09-19 22:00:41.000000000 -0500
+++ linux/security/keys/request_key.c	2005-09-27 09:46:07.517424540 -0500
@@ -14,6 +14,7 @@
 #include <linux/kmod.h>
 #include <linux/err.h>
 #include <linux/keyctl.h>
+#include <linux/pnotify.h>
 #include "internal.h"
 
 struct key_construction {
@@ -39,6 +40,17 @@
 	char *argv[10], *envp[3], uid_str[12], gid_str[12];
 	char key_str[12], keyring_str[3][12];
 	int ret, i;
+	struct pnotify_subscriber *sub;
+	struct key_task *kt;
+
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(current, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "call_request_key pnotify subscriber or data ptr null, task: %d\n", tsk->pid);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		return -EFAULT;
+	}
+	kt = (struct key_task *)sub->data;
 
 	kenter("{%d},%s,%s", key->serial, op, callout_info);
 
@@ -58,7 +70,7 @@
 
 	/* we specify the process's default keyrings */
 	sprintf(keyring_str[0], "%d",
-		tsk->thread_keyring ? tsk->thread_keyring->serial : 0);
+		kt->thread_keyring ? kt->thread_keyring->serial : 0);
 
 	prkey = 0;
 	if (tsk->signal->process_keyring)
@@ -105,6 +117,7 @@
 	key_put(session_keyring);
 
  error:
+	up_write(&tsk->pnotify_subscriber_list_sem);
 	kleave(" = %d", ret);
 	return ret;
 
@@ -300,15 +313,26 @@
 {
 	struct task_struct *tsk = current;
 	struct key *drop = NULL;
+	struct pnotify_subscriber *sub;
+	struct key_task *kt;
+
+	down_write(&tsk->pnotify_subscriber_list_sem);
+	sub = pnotify_get_subscriber(current, key_events.name);
+	if (sub == NULL || sub->data == NULL) { /* shouldn't happen */
+		printk(KERN_ERR "request_key_link pnotify subscriber or data ptr null, task: %d\n", tsk->pid);
+		up_write(&tsk->pnotify_subscriber_list_sem);
+		return;
+	}
+	kt = (struct key_task *)sub->data;
 
 	kenter("{%d},%p", key->serial, dest_keyring);
 
 	/* find the appropriate keyring */
 	if (!dest_keyring) {
-		switch (tsk->jit_keyring) {
+		switch (kt->jit_keyring) {
 		case KEY_REQKEY_DEFL_DEFAULT:
 		case KEY_REQKEY_DEFL_THREAD_KEYRING:
-			dest_keyring = tsk->thread_keyring;
+			dest_keyring = kt->thread_keyring;
 			if (dest_keyring)
 				break;
 
@@ -347,6 +371,7 @@
 	key_put(drop);
 
 	kleave("");
+	down_write(&tsk->pnotify_subscriber_list_sem);
 
 } /* end request_key_link() */
 
