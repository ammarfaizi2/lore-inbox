Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUA2T2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUA2T1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:27:55 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:52895 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S266303AbUA2T0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:26:20 -0500
Date: Thu, 29 Jan 2004 11:25:57 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       akpm@osld.org.sun.com, torvalds@osdl.org, rusty@rustcorp.com.au
Subject: PATCH - NGROUPS 2.6.2rc2 + fixups
Message-ID: <20040129192556.GM9155@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus, Andrew, 

Attached is a patch to remove the NGROUPS limit (again).  I've fixed up the
issues that people have pointed out this week.  It incorporates a fixed
limit which can be easily changed in a user wanted even more groups.  

This patch is against linux-2.6.2rc2.  If it is OK, I can make it bitkeeper
accessible.

What think?

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ngroups-2.6.2rc2-6.diff"

===== include/linux/sched.h 1.178 vs edited =====
--- 1.178/include/linux/sched.h	Mon Jan 19 15:38:15 2004
+++ edited/include/linux/sched.h	Wed Jan 28 15:22:30 2004
@@ -329,6 +329,33 @@
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
+#define NGROUPS_SMALL		32
+#define NGROUPS_PER_BLOCK	((int)(EXEC_PAGESIZE / sizeof(gid_t)))
+struct group_info {
+	int ngroups;
+	atomic_t usage;
+	gid_t small_block[NGROUPS_SMALL];
+	int nblocks;
+	gid_t *blocks[0];
+};
+
+#define get_group_info(group_info) do { \
+	atomic_inc(&(group_info)->usage); \
+} while (0)
+
+#define put_group_info(group_info) do { \
+	if (atomic_dec_and_test(&(group_info)->usage)) \
+		groups_free(group_info); \
+} while (0)
+
+struct group_info *groups_alloc(int gidsetsize);
+void groups_free(struct group_info *group_info);
+int set_current_groups(struct group_info *group_info);
+/* access the groups "array" with this macro */
+#define GROUP_AT(gi, i) \
+    ((gi)->blocks[(i)/NGROUPS_PER_BLOCK][(i)%NGROUPS_PER_BLOCK])
+
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -403,8 +430,7 @@
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
+	struct group_info *group_info;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
===== include/linux/init_task.h 1.27 vs edited =====
--- 1.27/include/linux/init_task.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/init_task.h	Tue Jan 27 12:40:02 2004
@@ -56,6 +56,8 @@
 	.siglock	= SPIN_LOCK_UNLOCKED, 		\
 }
 
+extern struct group_info init_groups;
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -87,6 +89,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.group_info	= &init_groups,					\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
===== include/linux/limits.h 1.3 vs edited =====
--- 1.3/include/linux/limits.h	Tue Feb  5 07:28:33 2002
+++ edited/include/linux/limits.h	Thu Jan 29 09:39:44 2004
@@ -3,7 +3,7 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
+#define NGROUPS_MAX    65536	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
===== kernel/sys.c 1.69 vs edited =====
--- 1.69/kernel/sys.c	Mon Jan 19 15:38:13 2004
+++ edited/kernel/sys.c	Thu Jan 29 10:03:50 2004
@@ -1091,10 +1091,171 @@
 /*
  * Supplementary group IDs
  */
-asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
+
+/* init to 2 - one for init_task, one to ensure it is never freed */
+struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+
+struct group_info *groups_alloc(int gidsetsize)
+{
+	struct group_info *group_info;
+	int nblocks;
+	int i;
+
+	nblocks = (gidsetsize/NGROUPS_PER_BLOCK) +
+	    (gidsetsize%NGROUPS_PER_BLOCK?1:0);
+	group_info = kmalloc(sizeof(*group_info) + nblocks*sizeof(gid_t *),
+	    GFP_USER);
+	if (!group_info)
+		return NULL;
+	group_info->ngroups = gidsetsize;
+	group_info->nblocks = nblocks;
+	atomic_set(&group_info->usage, 1);
+
+	if (gidsetsize <= NGROUPS_SMALL) {
+		group_info->blocks[0] = group_info->small_block;
+	} else {
+		for (i = 0; i < nblocks; i++) {
+			gid_t *b;
+			b = (void *)__get_free_page(GFP_USER);
+			if (!b)
+				goto out_undo_partial_alloc;
+			group_info->blocks[i] = b;
+		}
+	}
+	return group_info;
+
+out_undo_partial_alloc:
+	while (--i >= 0) {
+		free_page((unsigned long)group_info->blocks[i]);
+	}
+	kfree(group_info);
+	return NULL;
+}
+
+void groups_free(struct group_info *group_info)
 {
+	if (group_info->ngroups > NGROUPS_SMALL) {
+		int i;
+		for (i = 0; i < group_info->nblocks; i++)
+			free_page((unsigned long)group_info->blocks[i]);
+	}
+	kfree(group_info);
+}
+
+/* export the group_info to a user-space array */
+static int groups_to_user(gid_t __user *grouplist,
+    struct group_info *group_info)
+{
+	int i;
+	int count = group_info->ngroups;
+
+	for (i = 0; i < group_info->nblocks; i++) {
+		int cp_count = min(NGROUPS_PER_BLOCK, count);
+		int off = i * NGROUPS_PER_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+
+		if (copy_to_user(grouplist+off, group_info->blocks[i], len))
+			return -EFAULT;
+
+		count -= cp_count;
+	}
+	return 0;
+}
+
+/* fill a group_info from a user-space array - it must be allocated already */
+static int groups_from_user(struct group_info *group_info,
+    gid_t __user *grouplist)
+ {
 	int i;
-	
+	int count = group_info->ngroups;
+
+	for (i = 0; i < group_info->nblocks; i++) {
+		int cp_count = min(NGROUPS_PER_BLOCK, count);
+		int off = i * NGROUPS_PER_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+
+		if (copy_from_user(group_info->blocks[i], grouplist+off, len))
+			return -EFAULT;
+
+		count -= cp_count;
+	}
+	return 0;
+}
+
+/* a simple shell-metzner sort */
+static void groups_sort(struct group_info *group_info)
+{
+	int base, max, stride;
+	int gidsetsize = group_info->ngroups;
+
+	for (stride = 1; stride < gidsetsize; stride = 3 * stride + 1)
+		; /* nothing */
+	stride /= 3;
+
+	while (stride) {
+		max = gidsetsize - stride;
+		for (base = 0; base < max; base++) {
+			int left = base;
+			int right = left + stride;
+			gid_t tmp = GROUP_AT(group_info, right);
+
+			while (left >= 0 && GROUP_AT(group_info, left) > tmp) {
+				GROUP_AT(group_info, right) =
+				    GROUP_AT(group_info, left);
+				right = left;
+				left -= stride;
+			}
+			GROUP_AT(group_info, right) = tmp;
+		}
+		stride /= 3;
+	}
+}
+
+/* a simple bsearch */
+static int groups_search(struct group_info *group_info, gid_t grp)
+{
+	int left, right;
+
+	if (!group_info)
+		return 0;
+
+	left = 0;
+	right = group_info->ngroups;
+	while (left < right) {
+		int mid = (left+right)/2;
+		int cmp = grp - GROUP_AT(group_info, mid);
+		if (cmp > 0)
+			left = mid + 1;
+		else if (cmp < 0)
+			right = mid;
+		else
+			return 1;
+	}
+	return 0;
+}
+
+/* validate and set current->group_info */
+int set_current_groups(struct group_info *group_info)
+{
+	int retval;
+	struct group_info *old_info;
+
+	retval = security_task_setgroups(group_info);
+	if (retval)
+		return retval;
+
+	groups_sort(group_info);
+	old_info = current->group_info;
+	current->group_info = group_info;
+	put_group_info(old_info);
+
+	return 0;
+}
+
+asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
+{
+	int i = 0;
+
 	/*
 	 *	SMP: Nobody else can change our grouplist. Thus we are
 	 *	safe.
@@ -1102,54 +1263,53 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+
+	get_group_info(current->group_info);
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
-			return -EFAULT;
+		if (i > gidsetsize) {
+			i = -EINVAL;
+			goto out;
+		}
+		if (groups_to_user(grouplist, current->group_info)) {
+			i = -EFAULT;
+			goto out;
+		}
 	}
+out:
+	put_group_info(current->group_info);
 	return i;
 }
 
 /*
- *	SMP: Our groups are not shared. We can copy to/from them safely
+ *	SMP: Our groups are copy-on-write. We can set them safely
  *	without another task interfering.
  */
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
 {
-	gid_t groups[NGROUPS];
+	struct group_info *group_info;
 	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned)gidsetsize > NGROUPS_MAX)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
-	retval = security_task_setgroups(gidsetsize, groups);
-	if (retval)
+
+	group_info = groups_alloc(gidsetsize);
+	if (!group_info)
+		return -ENOMEM;
+	retval = groups_from_user(group_info, grouplist);
+	if (retval) {
+		put_group_info(group_info);
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
-}
+	}
 
-static int supplemental_group_member(gid_t grp)
-{
-	int i = current->ngroups;
+	retval = set_current_groups(group_info);
+	if (retval)
+		put_group_info(group_info);
 
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
-	}
-	return 0;
+	return retval;
 }
 
 /*
@@ -1158,8 +1318,11 @@
 int in_group_p(gid_t grp)
 {
 	int retval = 1;
-	if (grp != current->fsgid)
-		retval = supplemental_group_member(grp);
+	if (grp != current->fsgid) {
+		get_group_info(current->group_info);
+		retval = groups_search(current->group_info, grp);
+		put_group_info(current->group_info);
+	}
 	return retval;
 }
 
@@ -1168,8 +1331,11 @@
 int in_egroup_p(gid_t grp)
 {
 	int retval = 1;
-	if (grp != current->egid)
-		retval = supplemental_group_member(grp);
+	if (grp != current->egid) {
+		get_group_info(current->group_info);
+		retval = groups_search(current->group_info, grp);
+		put_group_info(current->group_info);
+	}
 	return retval;
 }
 
===== kernel/fork.c 1.154 vs edited =====
--- 1.154/kernel/fork.c	Mon Jan 19 15:38:15 2004
+++ edited/kernel/fork.c	Tue Jan 27 12:40:02 2004
@@ -86,6 +86,7 @@
 
 	security_task_free(tsk);
 	free_uid(tsk->user);
+	put_group_info(tsk->group_info);
 	free_task(tsk);
 }
 
@@ -878,6 +879,7 @@
 
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
+	get_group_info(p->group_info);
 
 	/*
 	 * If multiple threads are within copy_process(), then this check
@@ -1084,6 +1086,7 @@
 bad_fork_cleanup_put_domain:
 	module_put(p->thread_info->exec_domain->module);
 bad_fork_cleanup_count:
+	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
 bad_fork_free:
===== kernel/uid16.c 1.5 vs edited =====
--- 1.5/kernel/uid16.c	Wed Apr  9 20:51:27 2003
+++ edited/kernel/uid16.c	Thu Jan 29 10:04:01 2004
@@ -107,45 +107,96 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(old_gid_t __user *grouplist,
+    struct group_info *group_info)
+{
+	int i;
+	old_gid_t group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		group = (old_gid_t)GROUP_AT(group_info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *group_info,
+    old_gid_t __user *grouplist)
+{
+	int i;
+	old_gid_t group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_READ, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(group_info, i) = (gid_t)group;
+	}
+
+	return 0;
+}
+
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
-	int i,j;
+	int i = 0;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+
+	get_group_info(current->group_info);
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
-			return -EFAULT;
+		if (i > gidsetsize) {
+			i = -EINVAL;
+			goto out;
+		}
+		if (groups16_to_user(grouplist, current->group_info)) {
+			i = -EFAULT;
+			goto out;
+		}
 	}
+out:
+	put_group_info(current->group_info);
 	return i;
 }
 
 asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
-	gid_t new_groups[NGROUPS];
-	int i;
+	struct group_info *group_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned)gidsetsize > NGROUPS_MAX)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		new_groups[i] = (gid_t)groups[i];
-	i = security_task_setgroups(gidsetsize, new_groups);
-	if (i)
-		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+
+	group_info = groups_alloc(gidsetsize);
+	if (!group_info)
+		return -ENOMEM;
+	retval = groups16_from_user(group_info, grouplist);
+	if (retval) {
+		put_group_info(group_info);
+		return retval;
+	}
+
+	retval = set_current_groups(group_info);
+	if (retval)
+		put_group_info(group_info);
+
+	return retval;
 }
 
 asmlinkage long sys_getuid16(void)
===== fs/proc/array.c 1.55 vs edited =====
--- 1.55/fs/proc/array.c	Tue Oct 14 14:00:09 2003
+++ edited/fs/proc/array.c	Tue Jan 27 15:59:44 2004
@@ -176,8 +176,10 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
-		buffer += sprintf(buffer, "%d ", p->groups[g]);
+	get_group_info(p->group_info);
+	for (g = 0; g < min(p->group_info->ngroups,NGROUPS_SMALL); g++)
+		buffer += sprintf(buffer, "%d ", GROUP_AT(p->group_info,g));
+	put_group_info(p->group_info);
 
 	buffer += sprintf(buffer, "\n");
 	return buffer;
===== include/linux/sunrpc/auth.h 1.9 vs edited =====
--- 1.9/include/linux/sunrpc/auth.h	Wed Jun 11 19:22:40 2003
+++ edited/include/linux/sunrpc/auth.h	Tue Jan 27 12:40:02 2004
@@ -28,8 +28,7 @@
 struct auth_cred {
 	uid_t	uid;
 	gid_t	gid;
-	int	ngroups;
-	gid_t	*groups;
+	struct group_info *group_info;
 };
 
 /*
===== include/linux/sunrpc/svcauth.h 1.9 vs edited =====
--- 1.9/include/linux/sunrpc/svcauth.h	Fri Jan 10 17:55:15 2003
+++ edited/include/linux/sunrpc/svcauth.h	Tue Jan 27 12:40:02 2004
@@ -16,10 +16,11 @@
 #include <linux/sunrpc/cache.h>
 #include <linux/hash.h>
 
+#define SVC_CRED_NGROUPS	32
 struct svc_cred {
 	uid_t			cr_uid;
 	gid_t			cr_gid;
-	gid_t			cr_groups[NGROUPS];
+	gid_t			cr_groups[SVC_CRED_NGROUPS];
 };
 
 struct svc_rqst;		/* forward decl */
===== net/sunrpc/auth.c 1.12 vs edited =====
--- 1.12/net/sunrpc/auth.c	Wed Jun 11 19:22:40 2003
+++ edited/net/sunrpc/auth.c	Wed Jan 28 15:20:10 2004
@@ -246,34 +246,41 @@
 struct rpc_cred *
 rpcauth_lookupcred(struct rpc_auth *auth, int taskflags)
 {
-	struct auth_cred acred = {
-		.uid = current->fsuid,
-		.gid = current->fsgid,
-		.ngroups = current->ngroups,
-		.groups = current->groups,
-	};
+	struct auth_cred acred;
+	struct rpc_cred *ret;
+
+	get_group_info(current->group_info);
+	acred.uid = current->fsuid;
+	acred.gid = current->fsgid;
+	acred.group_info = current->group_info;
+
 	dprintk("RPC:     looking up %s cred\n",
 		auth->au_ops->au_name);
-	return rpcauth_lookup_credcache(auth, &acred, taskflags);
+	ret = rpcauth_lookup_credcache(auth, &acred, taskflags);
+	put_group_info(current->group_info);
+	return ret;
 }
 
 struct rpc_cred *
 rpcauth_bindcred(struct rpc_task *task)
 {
 	struct rpc_auth *auth = task->tk_auth;
-	struct auth_cred acred = {
-		.uid = current->fsuid,
-		.gid = current->fsgid,
-		.ngroups = current->ngroups,
-		.groups = current->groups,
-	};
+	struct auth_cred acred;
+	struct rpc_cred *ret;
+
+	get_group_info(current->group_info);
+	acred.uid = current->fsuid;
+	acred.gid = current->fsgid;
+	acred.group_info = current->group_info;
 
 	dprintk("RPC: %4d looking up %s cred\n",
 		task->tk_pid, task->tk_auth->au_ops->au_name);
 	task->tk_msg.rpc_cred = rpcauth_lookup_credcache(auth, &acred, task->tk_flags);
 	if (task->tk_msg.rpc_cred == 0)
 		task->tk_status = -ENOMEM;
-	return task->tk_msg.rpc_cred;
+	ret = task->tk_msg.rpc_cred;
+	put_group_info(current->group_info);
+	return ret;
 }
 
 void
===== net/sunrpc/auth_unix.c 1.11 vs edited =====
--- 1.11/net/sunrpc/auth_unix.c	Mon Feb 24 08:08:37 2003
+++ edited/net/sunrpc/auth_unix.c	Tue Jan 27 12:40:02 2004
@@ -82,7 +82,7 @@
 		cred->uc_gid = cred->uc_pgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = acred->ngroups;
+		int groups = acred->group_info->ngroups;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 
@@ -91,7 +91,7 @@
 		cred->uc_puid = current->uid;
 		cred->uc_pgid = current->gid;
 		for (i = 0; i < groups; i++)
-			cred->uc_gids[i] = (gid_t) acred->groups[i];
+			cred->uc_gids[i] = GROUP_AT(acred->group_info, i);
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
@@ -126,11 +126,11 @@
 		 || cred->uc_pgid != current->gid)
 			return 0;
 
-		groups = acred->ngroups;
+		groups = acred->group_info->ngroups;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 		for (i = 0; i < groups ; i++)
-			if (cred->uc_gids[i] != (gid_t) acred->groups[i])
+			if (cred->uc_gids[i] != GROUP_AT(acred->group_info, i))
 				return 0;
 		return 1;
 	}
===== net/sunrpc/svcauth_unix.c 1.20 vs edited =====
--- 1.20/net/sunrpc/svcauth_unix.c	Thu Jun 26 21:21:42 2003
+++ edited/net/sunrpc/svcauth_unix.c	Tue Jan 27 12:40:02 2004
@@ -434,11 +434,11 @@
 	if (slen > 16 || (len -= (slen + 2)*4) < 0)
 		goto badcred;
 	for (i = 0; i < slen; i++)
-		if (i < NGROUPS)
+		if (i < SVC_CRED_NGROUPS)
 			cred->cr_groups[i] = ntohl(svc_getu32(argv));
 		else
 			svc_getu32(argv);
-	if (i < NGROUPS)
+	if (i < SVC_CRED_NGROUPS)
 		cred->cr_groups[i] = NOGROUP;
 
 	if (svc_getu32(argv) != RPC_AUTH_NULL || svc_getu32(argv) != 0) {
===== fs/nfsd/auth.c 1.2 vs edited =====
--- 1.2/fs/nfsd/auth.c	Tue Jun 17 16:31:29 2003
+++ edited/fs/nfsd/auth.c	Tue Jan 27 12:40:02 2004
@@ -10,12 +10,15 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
 
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
 void
 nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	int		i;
+	gid_t		groups[SVC_CRED_NGROUPS];
 
 	if (exp->ex_flags & NFSEXP_ALLSQUASH) {
 		cred->cr_uid = exp->ex_anon_uid;
@@ -26,7 +29,7 @@
 			cred->cr_uid = exp->ex_anon_uid;
 		if (!cred->cr_gid)
 			cred->cr_gid = exp->ex_anon_gid;
-		for (i = 0; i < NGROUPS; i++)
+		for (i = 0; i < SVC_CRED_NGROUPS; i++)
 			if (!cred->cr_groups[i])
 				cred->cr_groups[i] = exp->ex_anon_gid;
 	}
@@ -39,13 +42,13 @@
 		current->fsgid = cred->cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
-	for (i = 0; i < NGROUPS; i++) {
+	for (i = 0; i < SVC_CRED_NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		current->groups[i] = group;
+		groups[i] = group;
 	}
-	current->ngroups = i;
+	sys_setgroups(i, groups);
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
===== fs/nfsd/nfs4state.c 1.21 vs edited =====
--- 1.21/fs/nfsd/nfs4state.c	Tue Oct  7 17:52:28 2003
+++ edited/fs/nfsd/nfs4state.c	Tue Jan 27 12:40:02 2004
@@ -244,7 +244,7 @@
 
 	target->cr_uid = source->cr_uid;
 	target->cr_gid = source->cr_gid;
-	for(i = 0; i < NGROUPS; i++)
+	for(i = 0; i < SVC_CRED_NGROUPS; i++)
 		target->cr_groups[i] = source->cr_groups[i];
 }
 
===== include/linux/security.h 1.28 vs edited =====
--- 1.28/include/linux/security.h	Tue Jan 20 17:58:48 2004
+++ edited/include/linux/security.h	Tue Jan 27 12:40:02 2004
@@ -554,9 +554,8 @@
  *	Return 0 if permission is granted.
  * @task_setgroups:
  *	Check permission before setting the supplementary group set of the
- *	current process to @grouplist.
- *	@gidsetsize contains the number of elements in @grouplist.
- *	@grouplist contains the array of gids.
+ *	current process.
+ *	@group_info contains the new group information.
  *	Return 0 if permission is granted.
  * @task_setnice:
  *	Check permission before setting the nice value of @p to @nice.
@@ -1116,7 +1115,7 @@
 	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
 	int (*task_getpgid) (struct task_struct * p);
 	int (*task_getsid) (struct task_struct * p);
-	int (*task_setgroups) (int gidsetsize, gid_t * grouplist);
+	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
 	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
@@ -1670,9 +1669,9 @@
 	return security_ops->task_getsid (p);
 }
 
-static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+static inline int security_task_setgroups (struct group_info *group_info)
 {
-	return security_ops->task_setgroups (gidsetsize, grouplist);
+	return security_ops->task_setgroups (group_info);
 }
 
 static inline int security_task_setnice (struct task_struct *p, int nice)
@@ -2299,7 +2298,7 @@
 	return 0;
 }
 
-static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+static inline int security_task_setgroups (struct group_info *group_info)
 {
 	return 0;
 }
===== security/dummy.c 1.30 vs edited =====
--- 1.30/security/dummy.c	Tue Jan 20 17:58:48 2004
+++ edited/security/dummy.c	Tue Jan 27 12:40:02 2004
@@ -539,7 +539,7 @@
 	return 0;
 }
 
-static int dummy_task_setgroups (int gidsetsize, gid_t * grouplist)
+static int dummy_task_setgroups (struct group_info *group_info)
 {
 	return 0;
 }
===== security/selinux/hooks.c 1.20 vs edited =====
--- 1.20/security/selinux/hooks.c	Tue Jan 20 17:58:48 2004
+++ edited/security/selinux/hooks.c	Tue Jan 27 15:04:53 2004
@@ -2265,7 +2265,7 @@
 	return task_has_perm(current, p, PROCESS__GETSESSION);
 }
 
-static int selinux_task_setgroups(int gidsetsize, gid_t *grouplist)
+static int selinux_task_setgroups(struct group_info *group_info)
 {
 	/* See the comment for setuid above. */
 	return 0;
===== arch/ia64/ia32/sys_ia32.c 1.87 vs edited =====
--- 1.87/arch/ia64/ia32/sys_ia32.c	Mon Jan 12 16:31:14 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Thu Jan 29 10:04:48 2004
@@ -2413,44 +2413,98 @@
 	return sys_lseek(fd, offset, whence);
 }
 
-extern asmlinkage long sys_getgroups (int gidsetsize, gid_t *grouplist);
+static int
+groups16_to_user(short *grouplist, struct group_info *group_info)
+{
+	int i;
+	short group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		group = (short)GROUP_AT(group_info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+groups16_from_user(struct group_info *group_info, short *grouplist)
+{
+	int i;
+	short group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_READ, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(group_info, i) = (gid_t)group;
+	}
+
+	return 0;
+}
 
 asmlinkage long
 sys32_getgroups16 (int gidsetsize, short *grouplist)
 {
-	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
-	int ret, i;
-
-	set_fs(KERNEL_DS);
-	ret = sys_getgroups(gidsetsize, gl);
-	set_fs(old_fs);
-
-	if (gidsetsize && ret > 0 && ret <= NGROUPS)
-		for (i = 0; i < ret; i++, grouplist++)
-			if (put_user(gl[i], grouplist))
-				return -EFAULT;
-	return ret;
-}
+	int i;
+
+	if (gidsetsize < 0)
+		return -EINVAL;
 
-extern asmlinkage long sys_setgroups (int gidsetsize, gid_t *grouplist);
+	get_group_info(current->group_info);
+	i = current->group_info->ngroups;
+	if (gidsetsize) {
+		if (i > gidsetsize) {
+			i = -EINVAL;
+			goto out;
+		}
+		if (groups16_to_user(grouplist, current->group_info)) {
+			i = -EFAULT;
+			goto out;
+		}
+	}
+out:
+	put_group_info(current->group_info);
+	return i;
+}
 
 asmlinkage long
 sys32_setgroups16 (int gidsetsize, short *grouplist)
 {
-	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
-	int ret, i;
+	struct group_info *group_info;
+	int retval;
 
-	if ((unsigned) gidsetsize > NGROUPS)
+	if (!capable(CAP_SETGID))
+		return -EPERM;
+	if ((unsigned)gidsetsize > NGROUPS_MAX)
 		return -EINVAL;
-	for (i = 0; i < gidsetsize; i++, grouplist++)
-		if (get_user(gl[i], grouplist))
-			return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_setgroups(gidsetsize, gl);
-	set_fs(old_fs);
-	return ret;
+
+	group_info = groups_alloc(gidsetsize);
+	if (!group_info)
+		return -ENOMEM;
+	retval = groups16_from_user(group_info, grouplist);
+	if (retval) {
+		put_group_info(group_info);
+		return retval;
+	}
+
+	retval = set_current_groups(group_info);
+	if (retval)
+		put_group_info(group_info);
+
+	return retval;
 }
 
 asmlinkage long
===== arch/mips/kernel/sysirix.c 1.18 vs edited =====
--- 1.18/arch/mips/kernel/sysirix.c	Tue Sep 23 19:34:27 2003
+++ edited/arch/mips/kernel/sysirix.c	Thu Jan 29 09:41:15 2004
@@ -368,7 +368,7 @@
 			retval = HZ;
 			goto out;
 		case 4:
-			retval = NGROUPS;
+			retval = NGROUPS_MAX;
 			goto out;
 		case 5:
 			retval = NR_OPEN;
===== arch/s390/kernel/compat_linux.c 1.10 vs edited =====
--- 1.10/arch/s390/kernel/compat_linux.c	Sun Jan 18 22:35:58 2004
+++ edited/arch/s390/kernel/compat_linux.c	Thu Jan 29 10:06:26 2004
@@ -190,40 +190,94 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(u16 *grouplist, struct group_info *group_info)
+{
+	int i;
+	u16 group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		group = (u16)GROUP_AT(group_info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *group_info, u16 *grouplist)
+{
+	int i;
+	u16 group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_READ, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(group_info, i) = (gid_t)group;
+	}
+
+	return 0;
+}
+
 asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i,j;
+	int i;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+
+	get_group_info(current->group_info);
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
-			return -EFAULT;
+		if (i > gidsetsize) {
+			i = -EINVAL;
+			goto out;
+		}
+		if (groups16_to_user(grouplist, current->group_info))
+			i = -EFAULT;
+			goto out;
+		}
 	}
+out:
+	put_group_info(current->group_info);
 	return i;
 }
 
 asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	struct group_info *group_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned)gidsetsize > NGROUPS_MAX)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+
+	group_info = groups_alloc(gidsetsize);
+	if (!group_info)
+		return -ENOMEM;
+	retval = groups16_from_user(group_info, grouplist);
+	if (retval) {
+		put_group_info(group_info);
+		return retval;
+	}
+
+	retval = set_current_groups(group_info);
+	if (retval)
+		put_group_info(group_info);
+
+	return retval;
 }
 
 asmlinkage long sys32_getuid16(void)
===== arch/sparc64/kernel/sys_sparc32.c 1.86 vs edited =====
--- 1.86/arch/sparc64/kernel/sys_sparc32.c	Wed Jan 21 22:25:38 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Thu Jan 29 10:07:41 2004
@@ -179,40 +179,94 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(u16 *grouplist, struct group_info *group_info)
+{
+	int i;
+	u16 group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		group = (u16)GROUP_AT(group_info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *group_info, u16 *grouplist)
+{
+	int i;
+	u16 group;
+
+	if (group_info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_READ, grouplist,
+	    group_info->ngroups * sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < group_info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(group_info, i) = (gid_t)group;
+	}
+
+	return 0;
+}
+
 asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i,j;
+	int i;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+
+	get_group_info(current->group_info);
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
-			return -EFAULT;
+		if (i > gidsetsize) {
+			i = -EINVAL;
+			goto out;
+		}
+		if (groups16_to_user(grouplist, current->group_info)) {
+			i = -EFAULT;
+			goto out;
+		}
 	}
+out:
+	put_group_info(current->group_info);
 	return i;
 }
 
 asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	struct group_info *group_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned)gidsetsize > NGROUPS_MAX)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+
+	group_info = groups_alloc(gidsetsize);
+	if (!group_info)
+		return -ENOMEM;
+	retval = groups16_from_user(group_info, grouplist);
+	if (retval) {
+		put_group_info(group_info);
+		return retval;
+	}
+
+	retval = set_current_groups(group_info);
+	if (retval)
+		put_group_info(group_info);
+
+	return retval;
 }
 
 asmlinkage long sys32_getuid16(void)
===== include/asm-alpha/param.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/param.h	Thu Aug  8 12:28:02 2002
+++ edited/include/asm-alpha/param.h	Tue Jan 27 12:40:02 2004
@@ -19,10 +19,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-arm/param.h 1.5 vs edited =====
--- 1.5/include/asm-arm/param.h	Wed Sep  3 10:17:57 2003
+++ edited/include/asm-arm/param.h	Tue Jan 27 12:40:02 2004
@@ -26,10 +26,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
===== include/asm-arm26/param.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/param.h	Wed Jun  4 04:14:10 2003
+++ edited/include/asm-arm26/param.h	Tue Jan 27 12:40:02 2004
@@ -22,10 +22,6 @@
 # define HZ		100
 #endif
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
===== include/asm-cris/param.h 1.2 vs edited =====
--- 1.2/include/asm-cris/param.h	Thu Nov  7 01:29:17 2002
+++ edited/include/asm-cris/param.h	Tue Jan 27 12:40:02 2004
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-h8300/param.h 1.1 vs edited =====
--- 1.1/include/asm-h8300/param.h	Sun Feb 16 16:01:58 2003
+++ edited/include/asm-h8300/param.h	Tue Jan 27 12:40:02 2004
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-i386/param.h 1.2 vs edited =====
--- 1.2/include/asm-i386/param.h	Mon Jul  1 14:41:36 2002
+++ edited/include/asm-i386/param.h	Tue Jan 27 12:40:02 2004
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-ia64/param.h 1.5 vs edited =====
--- 1.5/include/asm-ia64/param.h	Fri Jan 23 10:52:25 2004
+++ edited/include/asm-ia64/param.h	Tue Jan 27 12:40:02 2004
@@ -12,10 +12,6 @@
 
 #define EXEC_PAGESIZE	65536
 
-#ifndef NGROUPS
-# define NGROUPS	32
-#endif
-
 #ifndef NOGROUP
 # define NOGROUP	(-1)
 #endif
===== include/asm-m68k/param.h 1.2 vs edited =====
--- 1.2/include/asm-m68k/param.h	Mon Jul  8 05:53:12 2002
+++ edited/include/asm-m68k/param.h	Tue Jan 27 12:40:02 2004
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-m68knommu/param.h 1.1 vs edited =====
--- 1.1/include/asm-m68knommu/param.h	Fri Nov  1 08:37:46 2002
+++ edited/include/asm-m68knommu/param.h	Tue Jan 27 12:40:02 2004
@@ -44,10 +44,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-mips/param.h 1.3 vs edited =====
--- 1.3/include/asm-mips/param.h	Mon Apr 14 20:10:06 2003
+++ edited/include/asm-mips/param.h	Tue Jan 27 12:40:02 2004
@@ -33,10 +33,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-parisc/param.h 1.3 vs edited =====
--- 1.3/include/asm-parisc/param.h	Sat Sep 27 14:43:45 2003
+++ edited/include/asm-parisc/param.h	Tue Jan 27 12:40:02 2004
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-ppc/param.h 1.6 vs edited =====
--- 1.6/include/asm-ppc/param.h	Tue Jan  7 11:45:19 2003
+++ edited/include/asm-ppc/param.h	Tue Jan 27 12:40:02 2004
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-ppc64/param.h 1.2 vs edited =====
--- 1.2/include/asm-ppc64/param.h	Wed Jul 17 23:18:40 2002
+++ edited/include/asm-ppc64/param.h	Tue Jan 27 12:40:02 2004
@@ -20,10 +20,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-s390/param.h 1.3 vs edited =====
--- 1.3/include/asm-s390/param.h	Fri Oct  4 09:14:42 2002
+++ edited/include/asm-s390/param.h	Tue Jan 27 12:40:02 2004
@@ -21,10 +21,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-sh/param.h 1.2 vs edited =====
--- 1.2/include/asm-sh/param.h	Tue May 27 15:48:59 2003
+++ edited/include/asm-sh/param.h	Tue Jan 27 12:40:02 2004
@@ -17,10 +17,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-sparc/param.h 1.2 vs edited =====
--- 1.2/include/asm-sparc/param.h	Fri Jul 12 15:54:40 2002
+++ edited/include/asm-sparc/param.h	Tue Jan 27 12:40:02 2004
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-sparc64/param.h 1.2 vs edited =====
--- 1.2/include/asm-sparc64/param.h	Fri Jul 12 15:54:40 2002
+++ edited/include/asm-sparc64/param.h	Tue Jan 27 12:40:02 2004
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-um/param.h 1.1 vs edited =====
--- 1.1/include/asm-um/param.h	Fri Sep  6 10:29:29 2002
+++ edited/include/asm-um/param.h	Tue Jan 27 12:40:02 2004
@@ -3,10 +3,6 @@
 
 #define EXEC_PAGESIZE   4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
===== include/asm-v850/param.h 1.1 vs edited =====
--- 1.1/include/asm-v850/param.h	Fri Nov  1 08:38:12 2002
+++ edited/include/asm-v850/param.h	Tue Jan 27 12:40:02 2004
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-x86_64/param.h 1.3 vs edited =====
--- 1.3/include/asm-x86_64/param.h	Fri Oct 18 18:36:59 2002
+++ edited/include/asm-x86_64/param.h	Tue Jan 27 12:40:02 2004
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif

--EP0wieDxd4TSJjHq--
