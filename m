Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVBYNq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVBYNq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 08:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVBYNq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 08:46:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262666AbVBYNqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 08:46:32 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, kwc@citi.umich.edu
cc: linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: [PATCH] Properly share process and session keyrings with CLONE_THREAD
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 25 Feb 2005 13:46:12 +0000
Message-ID: <25723.1109339172@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch causes process and session keyrings to be shared properly
when CLONE_THREAD is in force. It does this by moving the keyring pointers
into struct signal_struct[*].

[*] I have a patch to rename this to struct thread_group that I'll revisit
after the advent of 2.6.11.

Furthermore, once this patch is applied, process keyrings will no longer be
allocated at fork, but will instead only be allocated when needed. Allocating
them at fork was a way of half getting around the sharing across threads
problem, but that's no longer necessary.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-task-2611rc4.diff 
 include/linux/key.h          |    5 +
 include/linux/sched.h        |   12 ++-
 init/main.c                  |    2 
 kernel/fork.c                |    8 ++
 kernel/signal.c              |    1 
 security/keys/process_keys.c |  157 +++++++++++++++++++++++++------------------
 security/keys/request_key.c  |   45 +++++++++---
 7 files changed, 150 insertions(+), 80 deletions(-)

diff -uNr linux-2.6.11-rc4/include/linux/key.h linux-2.6.11-rc4-keys-task/include/linux/key.h
--- linux-2.6.11-rc4/include/linux/key.h	2005-01-04 11:13:54.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/include/linux/key.h	2005-02-23 14:34:10.000000000 +0000
@@ -58,6 +58,7 @@
 
 struct seq_file;
 struct user_struct;
+struct signal_struct;
 
 struct key_type;
 struct key_owner;
@@ -258,7 +259,9 @@
 extern int alloc_uid_keyring(struct user_struct *user);
 extern void switch_uid_keyring(struct user_struct *new_user);
 extern int copy_keys(unsigned long clone_flags, struct task_struct *tsk);
+extern int copy_thread_group_keys(struct task_struct *tsk);
 extern void exit_keys(struct task_struct *tsk);
+extern void exit_thread_group_keys(struct signal_struct *tg);
 extern int suid_keys(struct task_struct *tsk);
 extern int exec_keys(struct task_struct *tsk);
 extern void key_fsuid_changed(struct task_struct *tsk);
@@ -274,7 +277,9 @@
 #define alloc_uid_keyring(u)		0
 #define switch_uid_keyring(u)		do { } while(0)
 #define copy_keys(f,t)			0
+#define copy_thread_group_keys(t)	0
 #define exit_keys(t)			do { } while(0)
+#define exit_thread_group_keys(tg)	do { } while(0)
 #define suid_keys(t)			do { } while(0)
 #define exec_keys(t)			do { } while(0)
 #define key_fsuid_changed(t)		do { } while(0)
diff -uNr linux-2.6.11-rc4/include/linux/sched.h linux-2.6.11-rc4-keys-task/include/linux/sched.h
--- linux-2.6.11-rc4/include/linux/sched.h	2005-02-14 12:19:02.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/include/linux/sched.h	2005-02-23 14:27:29.000000000 +0000
@@ -329,8 +329,18 @@
 	 * have no need to disable irqs.
 	 */
 	struct rlimit rlim[RLIM_NLIMITS];
+
+	/* keep the process-shared keyrings here so that they do the right
+	 * thing in threads created with CLONE_THREAD */
+#ifdef CONFIG_KEYS
+	struct key *session_keyring;	/* keyring inherited over fork */
+	struct key *process_keyring;	/* keyring private to this process */
+#endif
 };
 
+#define thread_group_lock(tsk, flags)	spin_lock_irqsave(&(tsk)->sighand->siglock, flags)
+#define thread_group_unlock(tsk, flags)	spin_unlock_irqrestore(&(tsk)->sighand->siglock, flags);
+
 /*
  * Bits in flags field of signal_struct.
  */
@@ -610,8 +620,6 @@
 	unsigned keep_capabilities:1;
 	struct user_struct *user;
 #ifdef CONFIG_KEYS
-	struct key *session_keyring;	/* keyring inherited over fork */
-	struct key *process_keyring;	/* keyring private to this process (CLONE_THREAD) */
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
diff -uNr linux-2.6.11-rc4/init/main.c linux-2.6.11-rc4-keys-task/init/main.c
--- linux-2.6.11-rc4/init/main.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/init/main.c	2005-02-23 16:09:47.000000000 +0000
@@ -497,6 +497,7 @@
 	proc_caches_init();
 	buffer_init();
 	unnamed_dev_init();
+	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
@@ -574,7 +575,6 @@
 	/* drivers will send hotplug events */
 	init_workqueues();
 	usermodehelper_init();
-	key_init();
 	driver_init();
 
 #ifdef CONFIG_SYSCTL
diff -uNr linux-2.6.11-rc4/kernel/fork.c linux-2.6.11-rc4-keys-task/kernel/fork.c
--- linux-2.6.11-rc4/kernel/fork.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/kernel/fork.c	2005-02-23 14:38:27.000000000 +0000
@@ -719,6 +719,7 @@
 static inline int copy_signal(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct signal_struct *sig;
+	int ret;
 
 	if (clone_flags & CLONE_THREAD) {
 		atomic_inc(&current->signal->count);
@@ -729,6 +730,13 @@
 	tsk->signal = sig;
 	if (!sig)
 		return -ENOMEM;
+
+	ret = copy_thread_group_keys(tsk);
+	if (ret < 0) {
+		kmem_cache_free(signal_cachep, sig);
+		return ret;
+	}
+
 	atomic_set(&sig->count, 1);
 	atomic_set(&sig->live, 1);
 	init_waitqueue_head(&sig->wait_chldexit);
diff -uNr linux-2.6.11-rc4/kernel/signal.c linux-2.6.11-rc4-keys-task/kernel/signal.c
--- linux-2.6.11-rc4/kernel/signal.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/kernel/signal.c	2005-02-23 14:40:39.000000000 +0000
@@ -402,6 +402,7 @@
 		 * signals are constrained to threads inside the group.
 		 */
 		exit_itimers(sig);
+		exit_thread_group_keys(sig);
 		kmem_cache_free(signal_cachep, sig);
 	}
 }
diff -uNr linux-2.6.11-rc4/security/keys/process_keys.c linux-2.6.11-rc4-keys-task/security/keys/process_keys.c
--- linux-2.6.11-rc4/security/keys/process_keys.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/security/keys/process_keys.c	2005-02-24 17:35:45.000000000 +0000
@@ -169,6 +169,7 @@
  */
 static int install_process_keyring(struct task_struct *tsk)
 {
+	unsigned long flags;
 	struct key *keyring, *old;
 	char buf[20];
 	int ret;
@@ -181,10 +182,10 @@
 		goto error;
 	}
 
-	task_lock(tsk);
-	old = tsk->process_keyring;
-	tsk->process_keyring = keyring;
-	task_unlock(tsk);
+	thread_group_lock(tsk, flags);
+	old = tsk->signal->process_keyring;
+	tsk->signal->process_keyring = keyring;
+	thread_group_unlock(tsk, flags);
 
 	ret = 0;
 
@@ -202,6 +203,7 @@
 static int install_session_keyring(struct task_struct *tsk,
 				   struct key *keyring)
 {
+	unsigned long flags;
 	struct key *old;
 	char buf[20];
 	int ret;
@@ -221,10 +223,10 @@
 	}
 
 	/* install the keyring */
-	task_lock(tsk);
-	old = tsk->session_keyring;
-	tsk->session_keyring = keyring;
-	task_unlock(tsk);
+	thread_group_lock(tsk, flags);
+	old = tsk->signal->session_keyring;
+	tsk->signal->session_keyring = keyring;
+	thread_group_unlock(tsk, flags);
 
 	ret = 0;
 
@@ -236,42 +238,59 @@
 
 /*****************************************************************************/
 /*
- * copy the keys for fork
+ * copy the keys in a thread group for fork without CLONE_THREAD
  */
-int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
+int copy_thread_group_keys(struct task_struct *tsk)
 {
-	int ret = 0;
+	unsigned long flags;
 
-	key_check(tsk->session_keyring);
-	key_check(tsk->process_keyring);
-	key_check(tsk->thread_keyring);
+	key_check(current->thread_group->session_keyring);
+	key_check(current->thread_group->process_keyring);
 
-	if (tsk->session_keyring)
-		atomic_inc(&tsk->session_keyring->usage);
+	/* no process keyring yet */
+	tsk->signal->process_keyring = NULL;
 
-	if (tsk->process_keyring) {
-		if (clone_flags & CLONE_THREAD) {
-			atomic_inc(&tsk->process_keyring->usage);
-		}
-		else {
-			tsk->process_keyring = NULL;
-			ret = install_process_keyring(tsk);
-		}
-	}
+	/* same session keyring */
+	thread_group_lock(current, flags);
+	tsk->signal->session_keyring =
+		key_get(current->signal->session_keyring);
+	thread_group_unlock(current, flags);
+
+	return 0;
+
+} /* end copy_thread_group_keys() */
+
+/*****************************************************************************/
+/*
+ * copy the keys for fork
+ */
+int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
+{
+	key_check(tsk->thread_keyring);
 
+	/* no thread keyring yet */
 	tsk->thread_keyring = NULL;
-	return ret;
+	return 0;
 
 } /* end copy_keys() */
 
 /*****************************************************************************/
 /*
- * dispose of keys upon exit
+ * dispose of thread group keys upon thread group destruction
+ */
+void exit_thread_group_keys(struct signal_struct *tg)
+{
+	key_put(tg->session_keyring);
+	key_put(tg->process_keyring);
+
+} /* end exit_thread_group_keys() */
+
+/*****************************************************************************/
+/*
+ * dispose of keys upon thread exit
  */
 void exit_keys(struct task_struct *tsk)
 {
-	key_put(tsk->session_keyring);
-	key_put(tsk->process_keyring);
 	key_put(tsk->thread_keyring);
 
 } /* end exit_keys() */
@@ -282,6 +301,7 @@
  */
 int exec_keys(struct task_struct *tsk)
 {
+	unsigned long flags;
 	struct key *old;
 
 	/* newly exec'd tasks don't get a thread keyring */
@@ -292,8 +312,15 @@
 
 	key_put(old);
 
-	/* newly exec'd tasks get a fresh process keyring */
-	return install_process_keyring(tsk);
+	/* discard the process keyring from a newly exec'd task */
+	thread_group_lock(tsk, flags);
+	old = tsk->signal->process_keyring;
+	tsk->signal->process_keyring = NULL;
+	thread_group_unlock(tsk, flags);
+
+	key_put(old);
+
+	return 0;
 
 } /* end exec_keys() */
 
@@ -314,15 +341,6 @@
  */
 void key_fsuid_changed(struct task_struct *tsk)
 {
-	/* update the ownership of the process keyring */
-	if (tsk->process_keyring) {
-		down_write(&tsk->process_keyring->sem);
-		write_lock(&tsk->process_keyring->lock);
-		tsk->process_keyring->uid = tsk->fsuid;
-		write_unlock(&tsk->process_keyring->lock);
-		up_write(&tsk->process_keyring->sem);
-	}
-
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
@@ -340,15 +358,6 @@
  */
 void key_fsgid_changed(struct task_struct *tsk)
 {
-	/* update the ownership of the process keyring */
-	if (tsk->process_keyring) {
-		down_write(&tsk->process_keyring->sem);
-		write_lock(&tsk->process_keyring->lock);
-		tsk->process_keyring->gid = tsk->fsgid;
-		write_unlock(&tsk->process_keyring->lock);
-		up_write(&tsk->process_keyring->sem);
-	}
-
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
@@ -373,7 +382,8 @@
 					key_match_func_t match)
 {
 	struct task_struct *tsk = current;
-	struct key *key, *ret, *err, *session;
+	unsigned long flags;
+	struct key *key, *ret, *err, *tmp;
 
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
@@ -407,9 +417,14 @@
 	}
 
 	/* search the process keyring second */
-	if (tsk->process_keyring) {
-		key = keyring_search_aux(tsk->process_keyring, type,
-					 description, match);
+	if (tsk->signal->process_keyring) {
+		thread_group_lock(tsk, flags);
+		tmp = tsk->signal->process_keyring;
+		atomic_inc(&tmp->usage);
+		thread_group_unlock(tsk, flags);
+
+		key = keyring_search_aux(tmp, type, description, match);
+		key_put(tmp);
 		if (!IS_ERR(key))
 			goto found;
 
@@ -427,12 +442,17 @@
 	}
 
 	/* search the session keyring last */
-	session = tsk->session_keyring;
-	if (!session)
-		session = tsk->user->session_keyring;
+	thread_group_lock(current, flags);
+
+	tmp = tsk->signal->session_keyring;
+	if (!tmp)
+		tmp = tsk->user->session_keyring;
+	atomic_inc(&tmp->usage);
 
-	key = keyring_search_aux(session, type,
-				 description, match);
+	thread_group_unlock(current, flags);
+
+	key = keyring_search_aux(tmp, type, description, match);
+	key_put(tmp);
 	if (!IS_ERR(key))
 		goto found;
 
@@ -479,6 +499,7 @@
 			    key_perm_t perm)
 {
 	struct task_struct *tsk = current;
+	unsigned long flags;
 	struct key *key;
 	int ret;
 
@@ -502,7 +523,7 @@
 		break;
 
 	case KEY_SPEC_PROCESS_KEYRING:
-		if (!tsk->process_keyring) {
+		if (!tsk->signal->process_keyring) {
 			if (!create)
 				goto error;
 
@@ -513,12 +534,14 @@
 			}
 		}
 
-		key = tsk->process_keyring;
+		thread_group_lock(tsk, flags);
+		key = tsk->signal->process_keyring;
 		atomic_inc(&key->usage);
+		thread_group_unlock(tsk, flags);
 		break;
 
 	case KEY_SPEC_SESSION_KEYRING:
-		if (!tsk->session_keyring) {
+		if (!tsk->signal->session_keyring) {
 			/* always install a session keyring upon access if one
 			 * doesn't exist yet */
 			ret = install_session_keyring(
@@ -527,8 +550,10 @@
 				goto error;
 		}
 
-		key = tsk->session_keyring;
+		thread_group_lock(tsk, flags);
+		key = tsk->signal->session_keyring;
 		atomic_inc(&key->usage);
+		thread_group_unlock(tsk, flags);
 		break;
 
 	case KEY_SPEC_USER_KEYRING:
@@ -592,6 +617,7 @@
 long join_session_keyring(const char *name)
 {
 	struct task_struct *tsk = current;
+	unsigned long flags;
 	struct key *keyring;
 	long ret;
 
@@ -601,7 +627,9 @@
 		if (ret < 0)
 			goto error;
 
-		ret = tsk->session_keyring->serial;
+		thread_group_lock(tsk, flags);
+		ret = tsk->signal->session_keyring->serial;
+		thread_group_unlock(tsk, flags);
 		goto error;
 	}
 
@@ -628,10 +656,9 @@
 	if (ret < 0)
 		goto error2;
 
+	ret = keyring->serial;
 	key_put(keyring);
 
-	ret = tsk->session_keyring->serial;
-
  error2:
 	up(&key_session_sem);
  error:
diff -uNr linux-2.6.11-rc4/security/keys/request_key.c linux-2.6.11-rc4-keys-task/security/keys/request_key.c
--- linux-2.6.11-rc4/security/keys/request_key.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/security/keys/request_key.c	2005-02-24 18:06:11.000000000 +0000
@@ -34,6 +34,8 @@
 			    const char *callout_info)
 {
 	struct task_struct *tsk = current;
+	unsigned long flags;
+	key_serial_t prkey, sskey;
 	char *argv[10], *envp[3], uid_str[12], gid_str[12];
 	char key_str[12], keyring_str[3][12];
 	int i;
@@ -46,16 +48,24 @@
 	sprintf(key_str, "%d", key->serial);
 
 	/* we specify the process's default keyrings */
-	task_lock(current);
 	sprintf(keyring_str[0], "%d",
 		tsk->thread_keyring ? tsk->thread_keyring->serial : 0);
-	sprintf(keyring_str[1], "%d",
-		tsk->process_keyring ? tsk->process_keyring->serial : 0);
-	sprintf(keyring_str[2], "%d",
-		(tsk->session_keyring ?
-		 tsk->session_keyring->serial :
-		 tsk->user->session_keyring->serial));
-	task_unlock(tsk);
+
+	prkey = 0;
+	sskey = 0;
+
+	thread_group_lock(tsk, flags);
+	if (tsk->signal->process_keyring)
+		prkey = tsk->signal->process_keyring->serial;
+	if (tsk->signal->session_keyring)
+		sskey = tsk->signal->session_keyring->serial;
+	thread_group_unlock(tsk, flags);
+
+	if (!sskey)
+		sskey = tsk->user->session_keyring->serial;
+
+	sprintf(keyring_str[1], "%d", prkey);
+	sprintf(keyring_str[2], "%d", sskey);
 
 	/* set up a minimal environment */
 	i = 0;
@@ -166,8 +176,19 @@
 	now = current_kernel_time();
 	key->expiry = now.tv_sec + key_negative_timeout;
 
-	if (current->session_keyring)
-		key_link(current->session_keyring, key);
+	if (current->signal->session_keyring) {
+		unsigned long flags;
+		struct key *keyring;
+
+		thread_group_lock(current, flags);
+		keyring = current->signal->session_keyring;
+		atomic_inc(&keyring->usage);
+		thread_group_unlock(current, flags);
+
+		key_link(keyring, key);
+		key_put(keyring);
+	}
+
 	key_put(key);
 
 	/* notify anyone who was waiting */
@@ -274,8 +295,8 @@
 
 		/* - get hold of the user's construction queue */
 		user = key_user_lookup(current->fsuid);
-		if (IS_ERR(user)) {
-			key = ERR_PTR(PTR_ERR(user));
+		if (!user) {
+			key = ERR_PTR(-ENOMEM);
 			goto error;
 		}
 
