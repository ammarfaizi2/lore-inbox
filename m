Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJKB3r>; Thu, 10 Oct 2002 21:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJKB3r>; Thu, 10 Oct 2002 21:29:47 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:62937 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S262266AbSJKB2M>; Thu, 10 Oct 2002 21:28:12 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210110133.g9B1Xlw18427@scl2.sfbay.sun.com>
Subject: [BK PATCH 2/4] fix NGROUPS hard limit
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 18:33:47 -0700 (PDT)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.739   -> 1.740  
#	include/linux/init_task.h	1.19    -> 1.20   
#	       kernel/fork.c	1.87    -> 1.88   
#	include/linux/sched.h	1.106   -> 1.107  
#	        kernel/sys.c	1.29    -> 1.30   
#	include/asm-i386/param.h	1.2     -> 1.3    
#	      kernel/uid16.c	1.2     -> 1.3    
#	     fs/proc/array.c	1.31    -> 1.32   
#	       kernel/exit.c	1.71    -> 1.72   
#	include/linux/limits.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	thockin@freakshow.cobalt.com	1.740
# Remove the limit of 32 groups.  We now have a per-task, dynamic array of
# groups, which is kept sorted and refcounted.
# 
# This ChangeSet incorporates all the core functionality. but does not fixup
# all the incorrect usages of groups.  That is in a seperate ChangeSet.
# --------------------------------------------
#
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Thu Oct 10 18:19:52 2002
+++ b/fs/proc/array.c	Thu Oct 10 18:19:52 2002
@@ -171,7 +171,7 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
+	for (g = 0; g < min(p->ngroups, OLD_NGROUPS); g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
diff -Nru a/include/asm-i386/param.h b/include/asm-i386/param.h
--- a/include/asm-i386/param.h	Thu Oct 10 18:19:52 2002
+++ b/include/asm-i386/param.h	Thu Oct 10 18:19:52 2002
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Thu Oct 10 18:19:52 2002
+++ b/include/linux/init_task.h	Thu Oct 10 18:19:52 2002
@@ -80,6 +80,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.ngroups	= 0,						\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -Nru a/include/linux/limits.h b/include/linux/limits.h
--- a/include/linux/limits.h	Thu Oct 10 18:19:52 2002
+++ b/include/linux/limits.h	Thu Oct 10 18:19:52 2002
@@ -3,7 +3,6 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
@@ -18,5 +17,7 @@
 #define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
 
 #define RTSIG_MAX	  32
+
+#define OLD_NGROUPS       32	/* old limit of supplemental group IDs */
 
 #endif
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Oct 10 18:19:52 2002
+++ b/include/linux/sched.h	Thu Oct 10 18:19:52 2002
@@ -353,7 +353,8 @@
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups;
+	atomic_t *groups_refcount;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Thu Oct 10 18:19:52 2002
+++ b/kernel/exit.c	Thu Oct 10 18:19:52 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
@@ -64,6 +65,12 @@
 		BUG();
 	if (p != current)
 		wait_task_inactive(p);
+
+	if (p->ngroups && atomic_dec_and_test(p->groups_refcount)) {
+		vfree(p->groups_refcount);
+		vfree(p->groups);
+	}
+
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Oct 10 18:19:52 2002
+++ b/kernel/fork.c	Thu Oct 10 18:19:52 2002
@@ -810,6 +810,10 @@
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 
+	/* increment the groups ref count */
+	if (p->ngroups)
+		atomic_inc(p->groups_refcount);
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Thu Oct 10 18:19:52 2002
+++ b/kernel/sys.c	Thu Oct 10 18:19:52 2002
@@ -20,6 +20,8 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1054,42 +1056,87 @@
 	return i;
 }
 
+static int gid_t_cmp(const void *a, const void *b)
+{
+	return *((gid_t *)a) - *((gid_t *)b);
+}
+
 /*
- *	SMP: Our groups are not shared. We can copy to/from them safely
+ *	SMP: Our groups are copy-on-write. We can set them safely
  *	without another task interfering.
  */
+int do_setgroups(int gidsetsize, gid_t *grouplist)
+{
+	atomic_t *newrefcnt = NULL;
+
+	BUG_ON(gidsetsize && !grouplist);
+	if (gidsetsize) {
+		newrefcnt = vmalloc(sizeof(*newrefcnt));
+		if (!newrefcnt) {
+			vfree(grouplist);
+			return -ENOMEM;
+		}
+
+		atomic_set(newrefcnt, 1);
+
+		/* sort the groupslist for faster searches */
+		qsort(grouplist, gidsetsize, sizeof(gid_t), gid_t_cmp);
+	}
+
+	/* disassociate ourselves from any shared group list */
+	if (current->ngroups
+	    && atomic_dec_and_test(current->groups_refcount)) {
+		vfree(current->groups_refcount);
+		vfree(current->groups);
+	}
+
+	current->groups = grouplist;
+	current->groups_refcount = newrefcnt;
+	current->ngroups = gidsetsize;
+
+	return 0;
+}
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
 {
-	gid_t groups[NGROUPS];
+	gid_t *groups = NULL;
 	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
+	if (gidsetsize) {
+		/*
+		 * make sure there is at least OLD_NGROUPS amount of space in
+		 * the group list for backwards compatiblity sake.
+		 */
+		int alloc_size = (gidsetsize > OLD_NGROUPS) ? 
+		    gidsetsize : OLD_NGROUPS;
+		groups = vmalloc(alloc_size * sizeof(gid_t));
+		if (!groups)
+			return -ENOMEM;
+
+		if (copy_from_user(groups, grouplist,
+		    gidsetsize * sizeof(gid_t))) {
+			vfree(groups);
+			return -EFAULT;
+		}
+	}
+
 	retval = security_ops->task_setgroups(gidsetsize, groups);
-	if (retval)
+	if (retval) {
+		if (groups)
+			vfree(groups);
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	}
+	return do_setgroups(gidsetsize, groups);
 }
 
 static int supplemental_group_member(gid_t grp)
 {
-	int i = current->ngroups;
-
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
+	if (current->ngroups) {
+		if (bsearch(&grp, current->groups, current->ngroups,
+		    sizeof(gid_t), gid_t_cmp))
+			return 1;
 	}
 	return 0;
 }
@@ -1382,3 +1429,4 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(sys_setgroups);
diff -Nru a/kernel/uid16.c b/kernel/uid16.c
--- a/kernel/uid16.c	Thu Oct 10 18:19:52 2002
+++ b/kernel/uid16.c	Thu Oct 10 18:19:52 2002
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 
@@ -27,6 +28,7 @@
 extern asmlinkage long sys_setresgid(gid_t, gid_t, gid_t);
 extern asmlinkage long sys_setfsuid(uid_t);
 extern asmlinkage long sys_setfsgid(gid_t);
+extern int do_setgroups(int gidsetsize, gid_t *grouplist);
  
 asmlinkage long sys_chown16(const char * filename, old_uid_t user, old_gid_t group)
 {
@@ -109,43 +111,74 @@
 
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t *grouplist)
 {
-	old_gid_t groups[NGROUPS];
+	old_gid_t *groups;
 	int i,j;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
 	i = current->ngroups;
-	if (gidsetsize) {
+	if (i && gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
+		groups = vmalloc(sizeof(old_gid_t) * i);
+		if (!groups)
+			return -ENOMEM;
 		for(j=0;j<i;j++)
 			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i)) {
+			vfree(groups);
 			return -EFAULT;
+		}
+		vfree(groups);
 	}
 	return i;
 }
 
 asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t *grouplist)
 {
-	old_gid_t groups[NGROUPS];
-	gid_t new_groups[NGROUPS];
+	old_gid_t *groups;
+	gid_t *new_groups = NULL;
 	int i;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		new_groups[i] = (gid_t)groups[i];
+	if (gidsetsize) {
+		/*
+		 * make sure there is at least OLD_NGROUPS amount of space in
+		 * the group list for backwards compatiblity sake.
+		 */
+		int alloc_size = (gidsetsize > OLD_NGROUPS) ? 
+		    gidsetsize : OLD_NGROUPS;
+
+		groups = vmalloc(sizeof(old_gid_t) * gidsetsize);
+		if (!groups)
+			return -ENOMEM;
+
+		if (copy_from_user(groups, grouplist,
+		    gidsetsize * sizeof(old_gid_t))) {
+			vfree(groups);
+			return -EFAULT;
+		}
+
+		if (!(new_groups = vmalloc(sizeof(gid_t) * alloc_size))) {
+			vfree(groups);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < gidsetsize; i++)
+			new_groups[i] = (gid_t)groups[i];
+
+		vfree(groups);
+	}
+
 	i = security_ops->task_setgroups(gidsetsize, new_groups);
-	if (i)
+	if (i) {
+		if (new_groups)
+			vfree(new_groups);
 		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	}
+	/* handles the vmalloc()ed new_groups */
+	return do_setgroups(gidsetsize, new_groups);
 }
 
 asmlinkage long sys_getuid16(void)
