Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSJQV0i>; Thu, 17 Oct 2002 17:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262162AbSJQV0i>; Thu, 17 Oct 2002 17:26:38 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52750 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262159AbSJQVZF>;
	Thu, 17 Oct 2002 17:25:05 -0400
Date: Thu, 17 Oct 2002 14:30:43 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017213043.GG1125@kroah.com>
References: <20021017212620.GA1125@kroah.com> <20021017212809.GB1125@kroah.com> <20021017212839.GC1125@kroah.com> <20021017212924.GD1125@kroah.com> <20021017212958.GE1125@kroah.com> <20021017213019.GF1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017213019.GF1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.803, 2002/10/17 14:08:43-07:00, greg@kroah.com

LSM: convert over the remaining security calls to the new format.


diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Thu Oct 17 14:18:57 2002
+++ b/ipc/msg.c	Thu Oct 17 14:18:57 2002
@@ -101,15 +101,14 @@
 	msq->q_perm.key = key;
 
 	msq->q_perm.security = NULL;
-	retval = security_ops->msg_queue_alloc_security(msq);
-	if (retval) {
+	if ((retval = security_msg_queue_alloc(msq))) {
 		kfree(msq);
 		return retval;
 	}
 
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
-		security_ops->msg_queue_free_security(msq);
+		security_msg_queue_free(msq);
 		kfree(msq);
 		return -ENOSPC;
 	}
@@ -281,7 +280,7 @@
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &msg_bytes);
-	security_ops->msg_queue_free_security(msq);
+	security_msg_queue_free(msq);
 	kfree(msq);
 }
 
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Thu Oct 17 14:18:57 2002
+++ b/ipc/sem.c	Thu Oct 17 14:18:57 2002
@@ -136,15 +136,14 @@
 	sma->sem_perm.key = key;
 
 	sma->sem_perm.security = NULL;
-	retval = security_ops->sem_alloc_security(sma);
-	if (retval) {
+	if ((retval = security_sem_alloc(sma))) {
 		ipc_free(sma, size);
 		return retval;
 	}
 
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
-		security_ops->sem_free_security(sma);
+		security_sem_free(sma);
 		ipc_free(sma, size);
 		return -ENOSPC;
 	}
@@ -427,7 +426,7 @@
 
 	used_sems -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
-	security_ops->sem_free_security(sma);
+	security_sem_free(sma);
 	ipc_free(sma, size);
 }
 
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Thu Oct 17 14:18:57 2002
+++ b/ipc/shm.c	Thu Oct 17 14:18:57 2002
@@ -116,7 +116,7 @@
 	shm_unlock(shp->id);
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
-	security_ops->shm_free_security(shp);
+	security_shm_free(shp);
 	kfree (shp);
 }
 
@@ -188,8 +188,7 @@
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
 	shp->shm_perm.security = NULL;
-	error = security_ops->shm_alloc_security(shp);
-	if (error) {
+	if ((error = security_shm_alloc(shp))) {
 		kfree(shp);
 		return error;
 	}
@@ -222,7 +221,7 @@
 no_id:
 	fput(file);
 no_file:
-	security_ops->shm_free_security(shp);
+	security_shm_free(shp);
 	kfree(shp);
 	return error;
 }
diff -Nru a/ipc/util.c b/ipc/util.c
--- a/ipc/util.c	Thu Oct 17 14:18:57 2002
+++ b/ipc/util.c	Thu Oct 17 14:18:57 2002
@@ -264,7 +264,7 @@
 	    !capable(CAP_IPC_OWNER))
 		return -1;
 
-	return security_ops->ipc_permission(ipcp, flag);
+	return security_ipc_permission(ipcp, flag);
 }
 
 /*
diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/acct.c	Thu Oct 17 14:18:57 2002
@@ -223,8 +223,7 @@
 		}
 	}
 
-	error = security_ops->acct(file);
-	if (error)
+	if ((error = security_acct(file)))
 		return error;
 
 	spin_lock(&acct_globals.lock);
diff -Nru a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/capability.c	Thu Oct 17 14:18:57 2002
@@ -64,7 +64,7 @@
      data.permitted = cap_t(target->cap_permitted);
      data.inheritable = cap_t(target->cap_inheritable); 
      data.effective = cap_t(target->cap_effective);
-     ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
+     ret = security_capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
      read_unlock(&tasklist_lock); 
@@ -89,7 +89,7 @@
      do_each_thread(g, target) {
              if (target->pgrp != pgrp)
                      continue;
-	     security_ops->capset_set(target, effective, inheritable, permitted);
+	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
 
@@ -106,7 +106,7 @@
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
-	     security_ops->capset_set(target, effective, inheritable, permitted);
+	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
 
@@ -164,7 +164,7 @@
 
      ret = -EPERM;
 
-     if (security_ops->capset_check(target, &effective, &inheritable, &permitted))
+     if (security_capset_check(target, &effective, &inheritable, &permitted))
 	     goto out;
 
      if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
@@ -191,7 +191,7 @@
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
      } else {
-	     security_ops->capset_set(target, &effective, &inheritable, &permitted);
+	     security_capset_set(target, &effective, &inheritable, &permitted);
      }
 
 out:
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/exit.c	Thu Oct 17 14:18:57 2002
@@ -67,7 +67,7 @@
 		wait_task_inactive(p);
 
 	atomic_dec(&p->user->processes);
-	security_ops->task_free_security(p);
+	security_task_free(p);
 	free_uid(p->user);
 	write_lock_irq(&tasklist_lock);
 	if (unlikely(p->ptrace))
@@ -248,7 +248,7 @@
 	/* cpus_allowed? */
 	/* rt_priority? */
 	/* signals? */
-	security_ops->task_reparent_to_init(current);
+	security_task_reparent_to_init(current);
 	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
 	current->user = INIT_USER;
 
@@ -774,7 +774,7 @@
 	if (current->tgid != p->tgid && delay_group_leader(p))
 		return 2;
 
-	if (security_ops->task_wait(p))
+	if (security_task_wait(p))
 		return 0;
 
 	return 1;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/fork.c	Thu Oct 17 14:18:57 2002
@@ -682,8 +682,7 @@
 	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
 		return ERR_PTR(-EINVAL);
 
-	retval = security_ops->task_create(clone_flags);
-	if (retval)
+	if ((retval = security_task_create(clone_flags)))
 		goto fork_out;
 
 	retval = -ENOMEM;
@@ -772,7 +771,7 @@
 	INIT_LIST_HEAD(&p->local_pages);
 
 	retval = -ENOMEM;
-	if (security_ops->task_alloc_security(p))
+	if (security_task_alloc(p))
 		goto bad_fork_cleanup;
 	/* copy all the process information */
 	if (copy_semundo(clone_flags, p))
@@ -922,7 +921,7 @@
 bad_fork_cleanup_semundo:
 	exit_semundo(p);
 bad_fork_cleanup_security:
-	security_ops->task_free_security(p);
+	security_task_free(p);
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/kmod.c	Thu Oct 17 14:18:57 2002
@@ -135,7 +135,7 @@
 	/* Give kmod all effective privileges.. */
 	curtask->euid = curtask->fsuid = 0;
 	curtask->egid = curtask->fsgid = 0;
-	security_ops->task_kmod_set_label();
+	security_task_kmod_set_label();
 
 	/* Allow execve args to be in kernel space. */
 	set_fs(KERNEL_DS);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/sched.c	Thu Oct 17 14:18:57 2002
@@ -1329,8 +1329,7 @@
 	if (nice > 19)
 		nice = 19;
 
-	retval = security_ops->task_setnice(current, nice);
-	if (retval)
+	if ((retval = security_task_setnice(current, nice)))
 		return retval;
 
 	set_user_nice(current, nice);
@@ -1451,8 +1450,7 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	retval = security_ops->task_setscheduler(p, policy, &lp);
-	if (retval)
+	if ((retval = security_task_setscheduler(p, policy, &lp)))
 		goto out_unlock;
 
 	array = p->array;
@@ -1515,8 +1513,7 @@
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
 	if (p) {
-		retval = security_ops->task_getscheduler(p);
-		if (!retval)
+		if (!(retval = security_task_getscheduler(p)))
 			retval = p->policy;
 	}
 	read_unlock(&tasklist_lock);
@@ -1545,8 +1542,7 @@
 	if (!p)
 		goto out_unlock;
 
-	retval = security_ops->task_getscheduler(p);
-	if (retval)
+	if ((retval = security_task_getscheduler(p)))
 		goto out_unlock;
 
 	lp.sched_priority = p->rt_priority;
@@ -1778,8 +1774,7 @@
 	if (!p)
 		goto out_unlock;
 
-	retval = security_ops->task_getscheduler(p);
-	if (retval)
+	if ((retval = security_task_getscheduler(p)))
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/signal.c	Thu Oct 17 14:18:57 2002
@@ -707,8 +707,7 @@
 	ret = -EPERM;
 	if (bad_signal(sig, info, t))
 		goto out;
-	ret = security_ops->task_kill(t, info, sig);
-	if (ret)
+	if ((ret = security_task_kill(t, info, sig)))
 		goto out;
 
 	/* The null signal is a permissions and process existence probe.
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/sys.c	Thu Oct 17 14:18:57 2002
@@ -204,6 +204,7 @@
 cond_syscall(sys_quotactl)
 cond_syscall(sys_acct)
 cond_syscall(sys_lookup_dcookie)
+cond_syscall(sys_security)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
@@ -479,8 +480,7 @@
 	int new_egid = old_egid;
 	int retval;
 
-	retval = security_ops->task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE);
-	if (retval)
+	if ((retval = security_task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE)))
 		return retval;
 
 	if (rgid != (gid_t) -1) {
@@ -525,8 +525,7 @@
 	int old_egid = current->egid;
 	int retval;
 
-	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
-	if (retval)
+	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID)))
 		return retval;
 
 	if (capable(CAP_SETGID))
@@ -599,8 +598,7 @@
 	int old_ruid, old_euid, old_suid, new_ruid, new_euid;
 	int retval;
 
-	retval = security_ops->task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE);
-	if (retval)
+	if ((retval = security_task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE)))
 		return retval;
 
 	new_ruid = old_ruid = current->uid;
@@ -638,7 +636,7 @@
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
 
@@ -660,8 +658,7 @@
 	int old_ruid, old_suid, new_ruid, new_suid;
 	int retval;
 
-	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
-	if (retval)
+	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID)))
 		return retval;
 
 	old_ruid = new_ruid = current->uid;
@@ -683,7 +680,7 @@
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
 
@@ -698,8 +695,7 @@
 	int old_suid = current->suid;
 	int retval;
 
-	retval = security_ops->task_setuid(ruid, euid, suid, LSM_SETID_RES);
-	if (retval)
+	if ((retval = security_task_setuid(ruid, euid, suid, LSM_SETID_RES)))
 		return retval;
 
 	if (!capable(CAP_SETUID)) {
@@ -729,7 +725,7 @@
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t *ruid, uid_t *euid, uid_t *suid)
@@ -750,8 +746,7 @@
 {
 	int retval;
 
-	retval = security_ops->task_setgid(rgid, egid, sgid, LSM_SETID_RES);
-	if (retval)
+	if ((retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES)))
 		return retval;
 
 	if (!capable(CAP_SETGID)) {
@@ -804,8 +799,7 @@
 	int old_fsuid;
 	int retval;
 
-	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	old_fsuid = current->fsuid;
@@ -821,8 +815,7 @@
 		current->fsuid = uid;
 	}
 
-	retval = security_ops->task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	return old_fsuid;
@@ -836,8 +829,7 @@
 	int old_fsgid;
 	int retval;
 
-	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	old_fsgid = current->fsgid;
@@ -962,8 +954,7 @@
 
 		retval = -ESRCH;
 		if (p) {
-			retval = security_ops->task_getpgid(p);
-			if (!retval)
+			if (!(retval = security_task_getpgid(p)))
 				retval = p->pgrp;
 		}
 		read_unlock(&tasklist_lock);
@@ -990,8 +981,7 @@
 
 		retval = -ESRCH;
 		if(p) {
-			retval = security_ops->task_getsid(p);
-			if (!retval)
+			if (!(retval = security_task_getsid(p)))
 				retval = p->session;
 		}
 		read_unlock(&tasklist_lock);
@@ -1072,8 +1062,7 @@
 		return -EINVAL;
 	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
 		return -EFAULT;
-	retval = security_ops->task_setgroups(gidsetsize, groups);
-	if (retval)
+	if ((retval = security_task_setgroups(gidsetsize, groups)))
 		return retval;
 	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
@@ -1236,8 +1225,7 @@
 			return -EPERM;
 	}
 
-	retval = security_ops->task_setrlimit(resource, &new_rlim);
-	if (retval)
+	if ((retval = security_task_setrlimit(resource, &new_rlim)))
 		return retval;
 
 	*old_rlim = new_rlim;
@@ -1311,8 +1299,7 @@
 	int error = 0;
 	int sig;
 
-	error = security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
-	if (error)
+	if ((error = security_task_prctl(option, arg2, arg3, arg4, arg5)))
 		return error;
 
 	switch (option) {
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Thu Oct 17 14:18:57 2002
+++ b/kernel/uid16.c	Thu Oct 17 14:18:57 2002
@@ -140,8 +140,7 @@
 		return -EFAULT;
 	for (i = 0 ; i < gidsetsize ; i++)
 		new_groups[i] = (gid_t)groups[i];
-	i = security_ops->task_setgroups(gidsetsize, new_groups);
-	if (i)
+	if ((i = security_task_setgroups(gidsetsize, new_groups)))
 		return i;
 	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
diff -Nru a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
--- a/net/decnet/af_decnet.c	Thu Oct 17 14:18:57 2002
+++ b/net/decnet/af_decnet.c	Thu Oct 17 14:18:57 2002
@@ -794,7 +794,7 @@
 	 * dn_prot_sock ? Would be nice if the capable call would go there
 	 * too.
 	 */
-	if (security_ops->dn_prot_sock(saddr) &&
+	if (security_dn_prot_sock(saddr) &&
 	    !capable(CAP_NET_BIND_SERVICE) || 
 	    saddr->sdn_objnum || (saddr->sdn_flags & SDF_WILD))
 		return -EACCES;
