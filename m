Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTHVX2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 19:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTHVX2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 19:28:35 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:38589 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261217AbTHVX15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 19:27:57 -0400
Date: Fri, 22 Aug 2003 16:27:51 -0700
From: Tim Hockin <th122948@sun.com>
To: linux-kernel@vger.kernel.org
Subject: NGROUPS (2.6.0-test3) again
Message-ID: <20030822162751.A27154@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is (yet another) form of a patch to remove the NGROUPS hard limit,
again.  As far as I know, this takes care of everyone's concerns (or at
least any concerns that have been conveyed to me).

There are a few things that could be tweaked, if people care.  Are there any
objections to this?  Maybe it's too late for 2.6.0, maybe not.  It's pretty
simple.

Arch code has not been done yet (simple) but will likely change this just a
bit to remove some duplicated code.

Also, fs/intermezzo will break with this.  It needs attention from
intermezzo people.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ngroups-2.6.0-test3.diff"

===== fs/nfsd/auth.c 1.2 vs edited =====
--- 1.2/fs/nfsd/auth.c	Tue Jun 17 16:31:29 2003
+++ edited/fs/nfsd/auth.c	Fri Aug 15 15:37:09 2003
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
===== fs/proc/array.c 1.47 vs edited =====
--- 1.47/fs/proc/array.c	Mon Apr 21 20:58:43 2003
+++ edited/fs/proc/array.c	Fri Aug 15 15:37:13 2003
@@ -173,8 +173,11 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
-		buffer += sprintf(buffer, "%d ", p->groups[g]);
+	if (p->group_info) {
+		for (g = 0; g < min(p->group_info->ngroups,NGROUPS_SMALL); g++)
+			buffer += sprintf(buffer, "%d ",
+			    GRP_AT(p->group_info,g));
+	}
 
 	buffer += sprintf(buffer, "\n");
 	return buffer;
===== include/asm-i386/param.h 1.2 vs edited =====
--- 1.2/include/asm-i386/param.h	Mon Jul  1 14:41:36 2002
+++ edited/include/asm-i386/param.h	Fri Aug 15 17:09:34 2003
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/linux/init_task.h 1.26 vs edited =====
--- 1.26/include/linux/init_task.h	Sat May 31 12:18:12 2003
+++ edited/include/linux/init_task.h	Fri Aug 15 15:35:35 2003
@@ -87,6 +87,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.group_info	= NULL,						\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
===== include/linux/limits.h 1.3 vs edited =====
--- 1.3/include/linux/limits.h	Tue Feb  5 07:28:33 2002
+++ edited/include/linux/limits.h	Fri Aug 15 17:09:41 2003
@@ -3,7 +3,6 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
===== include/linux/sched.h 1.160 vs edited =====
--- 1.160/include/linux/sched.h	Thu Aug 14 11:11:35 2003
+++ edited/include/linux/sched.h	Fri Aug 15 15:29:38 2003
@@ -325,6 +325,23 @@
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
+#define NGROUPS_SMALL		32
+#define NGROUPS_BLOCK		((int)(EXEC_PAGESIZE / sizeof(gid_t)))
+struct group_info {
+	int ngroups;
+	atomic_t refcount;
+	gid_t small_block[NGROUPS_SMALL];
+	int nblocks;
+	gid_t *blocks[0];
+};
+struct group_info *groups_alloc(int gidsetsize);
+void groups_free(struct group_info *info);
+int set_group_info(struct group_info *info);
+/* access the group array through this */
+#define GRP_AT(info, index) \
+	((info)->blocks[(index)/NGROUPS_BLOCK][(index)%NGROUPS_BLOCK])
+
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -396,8 +413,7 @@
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
+	struct group_info *group_info;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
===== include/linux/security.h 1.25 vs edited =====
--- 1.25/include/linux/security.h	Wed Jul  2 21:22:38 2003
+++ edited/include/linux/security.h	Fri Aug 15 15:35:46 2003
@@ -551,9 +551,8 @@
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
@@ -1097,7 +1096,7 @@
 	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
 	int (*task_getpgid) (struct task_struct * p);
 	int (*task_getsid) (struct task_struct * p);
-	int (*task_setgroups) (int gidsetsize, gid_t * grouplist);
+	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
 	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
@@ -1647,9 +1646,9 @@
 	return security_ops->task_getsid (p);
 }
 
-static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+static inline int security_task_setgroups (struct group_info *group_info)
 {
-	return security_ops->task_setgroups (gidsetsize, grouplist);
+	return security_ops->task_setgroups (group_info);
 }
 
 static inline int security_task_setnice (struct task_struct *p, int nice)
@@ -2275,7 +2274,7 @@
 	return 0;
 }
 
-static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+static inline int security_task_setgroups (struct group_info *group_info)
 {
 	return 0;
 }
===== include/linux/sunrpc/auth.h 1.9 vs edited =====
--- 1.9/include/linux/sunrpc/auth.h	Wed Jun 11 19:22:40 2003
+++ edited/include/linux/sunrpc/auth.h	Fri Aug 15 15:35:57 2003
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
+++ edited/include/linux/sunrpc/svcauth.h	Fri Aug 15 15:36:02 2003
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
===== kernel/exit.c 1.111 vs edited =====
--- 1.111/kernel/exit.c	Tue Aug  5 23:04:02 2003
+++ edited/kernel/exit.c	Fri Aug 15 15:27:43 2003
@@ -54,6 +54,9 @@
  
 	BUG_ON(p->state < TASK_ZOMBIE);
  
+	if (p->group_info && atomic_dec_and_test(&p->group_info->refcount))
+		groups_free(p->group_info);
+
 	atomic_dec(&p->user->processes);
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
===== kernel/fork.c 1.135 vs edited =====
--- 1.135/kernel/fork.c	Thu Aug 14 11:11:35 2003
+++ edited/kernel/fork.c	Fri Aug 15 15:27:39 2003
@@ -885,6 +885,10 @@
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 
+	/* increment the groups ref count */
+	if (p->group_info)
+		atomic_inc(&p->group_info->refcount);
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
===== kernel/sys.c 1.52 vs edited =====
--- 1.52/kernel/sys.c	Fri Jul 18 09:49:56 2003
+++ edited/kernel/sys.c	Fri Aug 15 15:27:14 2003
@@ -1071,9 +1071,161 @@
 /*
  * Supplementary group IDs
  */
-asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
+struct group_info *groups_alloc(int gidsetsize)
+{
+	struct group_info *info;
+	int nblocks;
+
+	nblocks = (gidsetsize/NGROUPS_BLOCK) + (gidsetsize%NGROUPS_BLOCK?1:0);
+	info = kmalloc(sizeof(*info) + nblocks*sizeof(gid_t *), GFP_USER);
+	if (!info)
+		return NULL;
+	info->ngroups = gidsetsize;
+	info->nblocks = nblocks;
+	atomic_set(&info->refcount, 1);
+
+	if (gidsetsize <= NGROUPS_SMALL) {
+		info->blocks[0] = info->small_block;
+	} else {
+		int i;
+		for (i = 0; i < nblocks; i++) {
+			gid_t *b;
+			b = (void *)__get_free_page(GFP_USER);
+			if (!b) {
+				int j;
+				for (j = 0; j < i; j++)
+					free_page((unsigned long)info->blocks[j]);
+				kfree(info);
+				return NULL;
+			}
+			info->blocks[i] = b;
+		}
+	}
+	return info;
+}
+
+void groups_free(struct group_info *info)
+{
+	if (info->ngroups > NGROUPS_SMALL) {
+		int i;
+		for (i = 0; i < info->nblocks; i++)
+			free_page((unsigned long)info->blocks[i]);
+	}
+	kfree(info);
+}
+
+/* export the group_info to a user-space array */
+static int groups_to_user(gid_t *grouplist, struct group_info __user *info)
 {
 	int i;
+	int count = info->ngroups;
+
+	for (i = 0; i < info->nblocks; i++) {
+		int cp_count = min(NGROUPS_BLOCK, count);
+		int off = i * NGROUPS_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+
+		if (copy_to_user(grouplist+off, info->blocks[i], len))
+			return -EFAULT;
+
+		count -= cp_count;
+	}
+	return 0;
+}
+
+/* fill a group_info from a user-space array - it must be allocated already */
+static int groups_from_user(struct group_info *info, gid_t __user *grouplist)
+ {
+	int i;
+	int count = info->ngroups;
+
+	for (i = 0; i < info->nblocks; i++) {
+		int cp_count = min(NGROUPS_BLOCK, count);
+		int off = i * NGROUPS_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+
+		if (copy_from_user(info->blocks[i], grouplist+off, len))
+			return -EFAULT;
+
+		count -= cp_count;
+	}
+	return 0;
+}
+
+/* a simple shell-metzner sort */
+static void groups_sort(struct group_info *info)
+{
+	int base, max, stride;
+	int gidsetsize = info->ngroups;
+
+	for (stride = 1; stride < gidsetsize; stride = 3 * stride + 1)
+		; /* nothing */
+	stride /= 3;
+
+	while (stride) {
+		max = gidsetsize - stride;
+		for (base = 0; base < max; base++) {
+			int left = base;
+			gid_t tmp = GRP_AT(info, base + stride);
+			while (left >= 0 && tmp < GRP_AT(info, left)) {
+				GRP_AT(info, left) = GRP_AT(info, left+stride);
+				left -= stride;
+			}
+			GRP_AT(info, left + stride) = tmp;
+		}
+		stride /= 3;
+	}
+}
+
+/* a simple bsearch */
+static int groups_search(struct group_info *info, gid_t grp)
+{
+	int left, right;
+
+	if (!info)
+		return 0;
+
+	left = 0;
+	right = info->ngroups;
+	while (left < right) {
+		int mid = (left+right)/2;
+		int cmp = grp - GRP_AT(info, mid);
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
+int set_group_info(struct group_info *info)
+{
+	int retval;
+
+	retval = security_task_setgroups(info);
+	if (retval)
+		goto out;
+
+	if (current->group_info &&
+	    atomic_dec_and_test(&current->group_info->refcount))
+		groups_free(current->group_info);
+
+	groups_sort(info);
+	current->group_info = info;
+
+	return 0;
+
+out:
+	groups_free(info);
+	return retval;
+}
+
+asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
+{
+	int i = 0;
 	
 	/*
 	 *	SMP: Nobody else can change our grouplist. Thus we are
@@ -1082,54 +1234,41 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
-			return -EFAULT;
+	if (current->group_info) {
+		i = current->group_info->ngroups;
+		if (gidsetsize) {
+			if (i > gidsetsize)
+				return -EINVAL;
+			if (groups_to_user(grouplist, current->group_info))
+				return -EFAULT;
+		}
 	}
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
+	struct group_info *new_info;
 	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
-	retval = security_task_setgroups(gidsetsize, groups);
-	if (retval)
-		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
-}
-
-static int supplemental_group_member(gid_t grp)
-{
-	int i = current->ngroups;
 
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
+	new_info = groups_alloc(gidsetsize);
+	if (!new_info)
+		return -ENOMEM;
+	retval = groups_from_user(new_info, grouplist);
+	if (retval) {
+		groups_free(new_info);
+		return retval;
 	}
-	return 0;
+
+	return set_group_info(new_info);
 }
 
 /*
@@ -1139,7 +1278,7 @@
 {
 	int retval = 1;
 	if (grp != current->fsgid)
-		retval = supplemental_group_member(grp);
+		retval = groups_search(current->group_info, grp);
 	return retval;
 }
 
@@ -1147,7 +1286,7 @@
 {
 	int retval = 1;
 	if (grp != current->egid)
-		retval = supplemental_group_member(grp);
+		retval = groups_search(current->group_info, grp);
 	return retval;
 }
 
===== kernel/uid16.c 1.5 vs edited =====
--- 1.5/kernel/uid16.c	Wed Apr  9 20:51:27 2003
+++ edited/kernel/uid16.c	Fri Aug 15 15:28:01 2003
@@ -107,45 +107,107 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(old_gid_t __user *grouplist,
+    struct group_info *info)
+{
+	int i;
+	int count = info->ngroups;
+	old_gid_t *groups;
+	int ret = 0;
+
+	/* too large for the stack? */
+	groups = kmalloc(NGROUPS_BLOCK * sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for (i = 0; i < info->nblocks; i++) {
+		int cp_count = min(NGROUPS_BLOCK, count);
+		int off = i * NGROUPS_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+		int j;
+
+		for (j = 0; j < cp_count; j++)
+			groups[j] = (old_gid_t)GRP_AT(info, i*NGROUPS_BLOCK+j);
+		if (copy_to_user(grouplist+off, groups, len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		count -= cp_count;
+	}
+out:
+	kfree(groups);
+	return ret;
+}
+
+static int groups16_from_user(struct group_info *info,
+    old_gid_t __user *grouplist)
+{
+	int i;
+	int count = info->ngroups;
+	old_gid_t *groups;
+	int ret = 0;
+
+	/* too large for the stack? */
+	groups = kmalloc(NGROUPS_BLOCK * sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for (i = 0; i < info->nblocks; i++) {
+		int cp_count = min(NGROUPS_BLOCK, count);
+		int off = i * NGROUPS_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+		int j;
+
+		if (copy_from_user(groups, grouplist+off, len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		for (j = 0; j < cp_count; j++)
+			GRP_AT(info, i*NGROUPS_BLOCK+j) = (gid_t)groups[j];
+
+		count -= cp_count;
+	}
+out:
+	kfree(groups);
+	return ret;
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
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
-			return -EFAULT;
+	if (current->group_info) {
+		i = current->group_info->ngroups;
+		if (gidsetsize) {
+			if (i > gidsetsize)
+				return -EINVAL;
+			if (groups16_to_user(grouplist, current->group_info))
+				return -EFAULT;
+		}
 	}
 	return i;
 }
 
 asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
-	gid_t new_groups[NGROUPS];
-	int i;
+	struct group_info *new_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
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
+	new_info = groups_alloc(gidsetsize);
+	if (!new_info)
+		return -ENOMEM;
+	retval = groups16_from_user(new_info, grouplist);
+	if (retval) {
+		groups_free(new_info);
+		return retval;
+	}
+
+	return set_group_info(new_info);
 }
 
 asmlinkage long sys_getuid16(void)
===== net/sunrpc/auth.c 1.12 vs edited =====
--- 1.12/net/sunrpc/auth.c	Wed Jun 11 19:22:40 2003
+++ edited/net/sunrpc/auth.c	Fri Aug 15 15:37:25 2003
@@ -249,8 +249,7 @@
 	struct auth_cred acred = {
 		.uid = current->fsuid,
 		.gid = current->fsgid,
-		.ngroups = current->ngroups,
-		.groups = current->groups,
+		.group_info = current->group_info,
 	};
 	dprintk("RPC:     looking up %s cred\n",
 		auth->au_ops->au_name);
@@ -264,8 +263,7 @@
 	struct auth_cred acred = {
 		.uid = current->fsuid,
 		.gid = current->fsgid,
-		.ngroups = current->ngroups,
-		.groups = current->groups,
+		.group_info = current->group_info,
 	};
 
 	dprintk("RPC: %4d looking up %s cred\n",
===== net/sunrpc/auth_unix.c 1.11 vs edited =====
--- 1.11/net/sunrpc/auth_unix.c	Mon Feb 24 08:08:37 2003
+++ edited/net/sunrpc/auth_unix.c	Fri Aug 15 15:37:31 2003
@@ -82,7 +82,7 @@
 		cred->uc_gid = cred->uc_pgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = acred->ngroups;
+		int groups = acred->group_info ? acred->group_info->ngroups : 0;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 
@@ -91,7 +91,7 @@
 		cred->uc_puid = current->uid;
 		cred->uc_pgid = current->gid;
 		for (i = 0; i < groups; i++)
-			cred->uc_gids[i] = (gid_t) acred->groups[i];
+			cred->uc_gids[i] = GRP_AT(acred->group_info, i);
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
@@ -126,11 +126,11 @@
 		 || cred->uc_pgid != current->gid)
 			return 0;
 
-		groups = acred->ngroups;
+		groups = acred->group_info ? acred->group_info->ngroups : 0;
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 		for (i = 0; i < groups ; i++)
-			if (cred->uc_gids[i] != (gid_t) acred->groups[i])
+			if (cred->uc_gids[i] != GRP_AT(acred->group_info, i))
 				return 0;
 		return 1;
 	}
===== net/sunrpc/svcauth_unix.c 1.20 vs edited =====
--- 1.20/net/sunrpc/svcauth_unix.c	Thu Jun 26 21:21:42 2003
+++ edited/net/sunrpc/svcauth_unix.c	Fri Aug 15 15:37:38 2003
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
===== security/dummy.c 1.27 vs edited =====
--- 1.27/security/dummy.c	Wed Jul  2 21:22:38 2003
+++ edited/security/dummy.c	Fri Aug 15 15:37:43 2003
@@ -530,7 +530,7 @@
 	return 0;
 }
 
-static int dummy_task_setgroups (int gidsetsize, gid_t * grouplist)
+static int dummy_task_setgroups (struct group_info *group_info)
 {
 	return 0;
 }

--zYM0uCDKw75PZbzx--
