Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSK1Aa6>; Wed, 27 Nov 2002 19:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSK1Aaw>; Wed, 27 Nov 2002 19:30:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11525 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264990AbSK1A3T>;
	Wed, 27 Nov 2002 19:29:19 -0500
Date: Wed, 27 Nov 2002 16:28:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] More LSM changes for 2.5.49
Message-ID: <20021128002833.GG7187@kroah.com>
References: <20021127230626.GB7187@kroah.com> <20021128002638.GD7187@kroah.com> <20021128002730.GE7187@kroah.com> <20021128002805.GF7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128002805.GF7187@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.928, 2002/11/27 15:13:40-08:00, greg@kroah.com

LSM: change if statements into something more readable for the kernel.* files.


diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/acct.c	Wed Nov 27 15:17:58 2002
@@ -223,7 +223,8 @@
 		}
 	}
 
-	if ((error = security_acct(file)))
+	error = security_acct(file);
+	if (error)
 		return error;
 
 	spin_lock(&acct_globals.lock);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/fork.c	Wed Nov 27 15:17:58 2002
@@ -717,7 +717,8 @@
 	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
 		return ERR_PTR(-EINVAL);
 
-	if ((retval = security_task_create(clone_flags)))
+	retval = security_task_create(clone_flags);
+	if (retval)
 		goto fork_out;
 
 	retval = -ENOMEM;
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/ptrace.c	Wed Nov 27 15:17:58 2002
@@ -101,7 +101,8 @@
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
-	if ((retval = security_ptrace(current, task)))
+	retval = security_ptrace(current, task);
+	if (retval)
 		goto bad;
 
 	/* Go */
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/sched.c	Wed Nov 27 15:17:58 2002
@@ -1348,7 +1348,8 @@
 	if (nice > 19)
 		nice = 19;
 
-	if ((retval = security_task_setnice(current, nice)))
+	retval = security_task_setnice(current, nice);
+	if (retval)
 		return retval;
 
 	set_user_nice(current, nice);
@@ -1469,7 +1470,8 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	if ((retval = security_task_setscheduler(p, policy, &lp)))
+	retval = security_task_setscheduler(p, policy, &lp);
+	if (retval)
 		goto out_unlock;
 
 	array = p->array;
@@ -1532,7 +1534,8 @@
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
 	if (p) {
-		if (!(retval = security_task_getscheduler(p)))
+		retval = security_task_getscheduler(p);
+		if (!retval)
 			retval = p->policy;
 	}
 	read_unlock(&tasklist_lock);
@@ -1561,7 +1564,8 @@
 	if (!p)
 		goto out_unlock;
 
-	if ((retval = security_task_getscheduler(p)))
+	retval = security_task_getscheduler(p);
+	if (retval)
 		goto out_unlock;
 
 	lp.sched_priority = p->rt_priority;
@@ -1820,7 +1824,8 @@
 	if (!p)
 		goto out_unlock;
 
-	if ((retval = security_task_getscheduler(p)))
+	retval = security_task_getscheduler(p);
+	if (retval)
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/signal.c	Wed Nov 27 15:17:58 2002
@@ -739,7 +739,8 @@
 	ret = -EPERM;
 	if (bad_signal(sig, info, t))
 		goto out;
-	if ((ret = security_task_kill(t, info, sig)))
+	ret = security_task_kill(t, info, sig);
+	if (ret)
 		goto out;
 
 	/* The null signal is a permissions and process existence probe.
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/sys.c	Wed Nov 27 15:17:58 2002
@@ -485,7 +485,8 @@
 	int new_egid = old_egid;
 	int retval;
 
-	if ((retval = security_task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE)))
+	retval = security_task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE);
+	if (retval)
 		return retval;
 
 	if (rgid != (gid_t) -1) {
@@ -530,7 +531,8 @@
 	int old_egid = current->egid;
 	int retval;
 
-	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID)))
+	retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
+	if (retval)
 		return retval;
 
 	if (capable(CAP_SETGID))
@@ -603,7 +605,8 @@
 	int old_ruid, old_euid, old_suid, new_ruid, new_euid;
 	int retval;
 
-	if ((retval = security_task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE)))
+	retval = security_task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE);
+	if (retval)
 		return retval;
 
 	new_ruid = old_ruid = current->uid;
@@ -663,7 +666,8 @@
 	int old_ruid, old_suid, new_ruid, new_suid;
 	int retval;
 
-	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID)))
+	retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
+	if (retval)
 		return retval;
 
 	old_ruid = new_ruid = current->uid;
@@ -700,7 +704,8 @@
 	int old_suid = current->suid;
 	int retval;
 
-	if ((retval = security_task_setuid(ruid, euid, suid, LSM_SETID_RES)))
+	retval = security_task_setuid(ruid, euid, suid, LSM_SETID_RES);
+	if (retval)
 		return retval;
 
 	if (!capable(CAP_SETUID)) {
@@ -751,7 +756,8 @@
 {
 	int retval;
 
-	if ((retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES)))
+	retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES);
+	if (retval)
 		return retval;
 
 	if (!capable(CAP_SETGID)) {
@@ -804,7 +810,8 @@
 	int old_fsuid;
 	int retval;
 
-	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
+	retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
+	if (retval)
 		return retval;
 
 	old_fsuid = current->fsuid;
@@ -820,7 +827,8 @@
 		current->fsuid = uid;
 	}
 
-	if ((retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
+	retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
+	if (retval)
 		return retval;
 
 	return old_fsuid;
@@ -834,7 +842,8 @@
 	int old_fsgid;
 	int retval;
 
-	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS)))
+	retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
+	if (retval)
 		return retval;
 
 	old_fsgid = current->fsgid;
@@ -959,7 +968,8 @@
 
 		retval = -ESRCH;
 		if (p) {
-			if (!(retval = security_task_getpgid(p)))
+			retval = security_task_getpgid(p);
+			if (!retval)
 				retval = p->pgrp;
 		}
 		read_unlock(&tasklist_lock);
@@ -986,7 +996,8 @@
 
 		retval = -ESRCH;
 		if(p) {
-			if (!(retval = security_task_getsid(p)))
+			retval = security_task_getsid(p);
+			if (!retval)
 				retval = p->session;
 		}
 		read_unlock(&tasklist_lock);
@@ -1067,7 +1078,8 @@
 		return -EINVAL;
 	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
 		return -EFAULT;
-	if ((retval = security_task_setgroups(gidsetsize, groups)))
+	retval = security_task_setgroups(gidsetsize, groups);
+	if (retval)
 		return retval;
 	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
@@ -1230,7 +1242,8 @@
 			return -EPERM;
 	}
 
-	if ((retval = security_task_setrlimit(resource, &new_rlim)))
+	retval = security_task_setrlimit(resource, &new_rlim);
+	if (retval)
 		return retval;
 
 	*old_rlim = new_rlim;
@@ -1304,7 +1317,8 @@
 	int error = 0;
 	int sig;
 
-	if ((error = security_task_prctl(option, arg2, arg3, arg4, arg5)))
+	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
+	if (error)
 		return error;
 
 	switch (option) {
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Wed Nov 27 15:17:58 2002
+++ b/kernel/uid16.c	Wed Nov 27 15:17:58 2002
@@ -140,7 +140,8 @@
 		return -EFAULT;
 	for (i = 0 ; i < gidsetsize ; i++)
 		new_groups[i] = (gid_t)groups[i];
-	if ((i = security_task_setgroups(gidsetsize, new_groups)))
+	i = security_task_setgroups(gidsetsize, new_groups);
+	if (i)
 		return i;
 	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
