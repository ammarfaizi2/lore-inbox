Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTIYEAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTIYEAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:00:32 -0400
Received: from dp.samba.org ([66.70.73.150]:48357 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261700AbTIYD7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 23:59:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>
Cc: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl-controlled number of groups.
Date: Thu, 25 Sep 2003 13:21:01 +1000
Message-Id: <20030925035943.AE41C2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a client (using SAMBA) who has people in 190 groups.  Since NT
has hierarchical groups, this is not all that rare.

What do people think of this patch?

Name: Dynamic Allocation of Groups Array When Required: With Refcounting
Author: Rusty Russell
Status: Tested on 2.6.0-test5-bk5
Depends: Misc/qemu-page-offset.patch.gz

D: This patch allows the maximum number of groups can be varied using
D: sysctl.  To do this, we use a separate group allocation if >
D: NGROUPS_INTERNAL, which we reference count (sharing being
D: v. v. common).
D: 
D: Changes:
D: 1) Remove the NGROUPS define from archs.
D: 2) Fixup the few places which declare [NGROUPS] arrays on the stack.
D: 3) The ia64, s390 and sparc64 ports have their own setgroups/getgroups
D:    implementations: unify them on the ia64 one, which calls the core
D:    functions.
D: 4) Change the task_struct to have an [NGROUPS_INTERNAL] array and
D:    a pointer (not convinced this is worth it at all, might skip it
D:    and always use external).
D: 5) Use a reference counted external array, fix up fork() to deal.
D: 6) Introduce max_groups and use it instead of NGROUPS.
D: 7) Add a sysctl to vary max_groups.
D: 
D: This patch scars nfs: artificially restrict the groups there to 
D: SVC_CRED_NGROUPS (32), which is probably wrong, but won't break if
D: they don't change the default.
D: 
D: This patch breaks intermezzo: I'm not sure how they want to deal
D: with it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/ia64/ia32/sys_ia32.c .13015-linux-2.6.0-test5-bk11.updated/arch/ia64/ia32/sys_ia32.c
--- .13015-linux-2.6.0-test5-bk11/arch/ia64/ia32/sys_ia32.c	2003-09-25 09:56:18.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/ia64/ia32/sys_ia32.c	2003-09-25 13:08:28.000000000 +1000
@@ -2432,17 +2432,24 @@ asmlinkage long
 sys32_getgroups16 (int gidsetsize, short *grouplist)
 {
 	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
+	gid_t *gl;
 	int ret, i;
 
+	gl = kmalloc(sizeof(gl[0]) * current->ngroups, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
+
 	set_fs(KERNEL_DS);
 	ret = sys_getgroups(gidsetsize, gl);
 	set_fs(old_fs);
 
-	if (gidsetsize && ret > 0 && ret <= NGROUPS)
+	if (gidsetsize && ret > 0)
 		for (i = 0; i < ret; i++, grouplist++)
-			if (put_user(gl[i], grouplist))
-				return -EFAULT;
+			if (put_user(gl[i], grouplist)) {
+				ret = -EFAULT;
+				break;
+			}
+	kfree(gl);
 	return ret;
 }
 
@@ -2452,17 +2459,23 @@ asmlinkage long
 sys32_setgroups16 (int gidsetsize, short *grouplist)
 {
 	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
+	gid_t *gl;
 	int ret, i;
 
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned) gidsetsize > max_groups)
 		return -EINVAL;
+	gl = kmalloc(sizeof(gl[0]) * gidsetsize, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
 	for (i = 0; i < gidsetsize; i++, grouplist++)
-		if (get_user(gl[i], grouplist))
+		if (get_user(gl[i], grouplist)) {
+			kfree(gl);
 			return -EFAULT;
+		}
 	set_fs(KERNEL_DS);
 	ret = sys_setgroups(gidsetsize, gl);
 	set_fs(old_fs);
+	kfree(gl);
 	return ret;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/mips/kernel/sysirix.c .13015-linux-2.6.0-test5-bk11.updated/arch/mips/kernel/sysirix.c
--- .13015-linux-2.6.0-test5-bk11/arch/mips/kernel/sysirix.c	2003-09-25 09:56:19.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/mips/kernel/sysirix.c	2003-09-25 12:58:43.000000000 +1000
@@ -368,7 +368,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 			retval = HZ;
 			goto out;
 		case 4:
-			retval = NGROUPS;
+			retval = max_groups;
 			goto out;
 		case 5:
 			retval = NR_OPEN;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/s390/kernel/compat_linux.c .13015-linux-2.6.0-test5-bk11.updated/arch/s390/kernel/compat_linux.c
--- .13015-linux-2.6.0-test5-bk11/arch/s390/kernel/compat_linux.c	2003-09-25 09:56:22.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/s390/kernel/compat_linux.c	2003-09-25 13:08:21.000000000 +1000
@@ -189,40 +189,57 @@ asmlinkage long sys32_setfsgid16(u16 gid
 	return sys_setfsgid((gid_t)gid);
 }
 
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
+extern asmlinkage long sys_getgroups (int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+sys32_getgroups16 (int gidsetsize, short *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i,j;
+	mm_segment_t old_fs = get_fs();
+	gid_t *gl;
+	int ret, i;
 
-	if (gidsetsize < 0)
-		return -EINVAL;
-	i = current->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
-			return -EFAULT;
-	}
-	return i;
+	gl = kmalloc(sizeof(gl[0]) * current->ngroups, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
+
+	set_fs(KERNEL_DS);
+	ret = sys_getgroups(gidsetsize, gl);
+	set_fs(old_fs);
+
+	if (gidsetsize && ret > 0)
+		for (i = 0; i < ret; i++, grouplist++)
+			if (put_user(gl[i], grouplist)) {
+				ret = -EFAULT;
+				break;
+			}
+	kfree(gl);
+	return ret;
 }
 
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
+extern asmlinkage long sys_setgroups (int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+sys32_setgroups16 (int gidsetsize, short *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	mm_segment_t old_fs = get_fs();
+	gid_t *gl;
+	int ret, i;
 
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned) gidsetsize > max_groups)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	gl = kmalloc(sizeof(gl[0]) * gidsetsize, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
+	for (i = 0; i < gidsetsize; i++, grouplist++)
+		if (get_user(gl[i], grouplist)) {
+			kfree(gl);
+			return -EFAULT;
+		}
+	set_fs(KERNEL_DS);
+	ret = sys_setgroups(gidsetsize, gl);
+	set_fs(old_fs);
+	kfree(gl);
+	return ret;
 }
 
 asmlinkage long sys32_getuid16(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/sparc/kernel/sys_sunos.c .13015-linux-2.6.0-test5-bk11.updated/arch/sparc/kernel/sys_sunos.c
--- .13015-linux-2.6.0-test5-bk11/arch/sparc/kernel/sys_sunos.c	2003-09-22 10:27:56.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/sparc/kernel/sys_sunos.c	2003-09-25 12:58:43.000000000 +1000
@@ -896,7 +896,7 @@ extern asmlinkage long sunos_sysconf (in
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = max_groups;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/sparc64/kernel/sys_sparc32.c .13015-linux-2.6.0-test5-bk11.updated/arch/sparc64/kernel/sys_sparc32.c
--- .13015-linux-2.6.0-test5-bk11/arch/sparc64/kernel/sys_sparc32.c	2003-09-25 09:56:22.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/sparc64/kernel/sys_sparc32.c	2003-09-25 13:08:15.000000000 +1000
@@ -206,40 +206,57 @@ asmlinkage long sys32_setfsgid16(u16 gid
 	return sys_setfsgid((gid_t)gid);
 }
 
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
+extern asmlinkage long sys_getgroups (int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+sys32_getgroups16 (int gidsetsize, short *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i,j;
+	mm_segment_t old_fs = get_fs();
+	gid_t *gl;
+	int ret, i;
 
-	if (gidsetsize < 0)
-		return -EINVAL;
-	i = current->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
-			return -EFAULT;
-	}
-	return i;
+	gl = kmalloc(sizeof(gl[0]) * current->ngroups, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
+
+	set_fs(KERNEL_DS);
+	ret = sys_getgroups(gidsetsize, gl);
+	set_fs(old_fs);
+
+	if (gidsetsize && ret > 0)
+		for (i = 0; i < ret; i++, grouplist++)
+			if (put_user(gl[i], grouplist)) {
+				ret = -EFAULT;
+				break;
+			}
+	kfree(gl);
+	return ret;
 }
 
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
+extern asmlinkage long sys_setgroups (int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+sys32_setgroups16 (int gidsetsize, short *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	mm_segment_t old_fs = get_fs();
+	gid_t *gl;
+	int ret, i;
 
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
+	if ((unsigned) gidsetsize > max_groups)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	gl = kmalloc(sizeof(gl[0]) * gidsetsize, GFP_KERNEL);
+	if (!gl)
+		return -ENOMEM;
+	for (i = 0; i < gidsetsize; i++, grouplist++)
+		if (get_user(gl[i], grouplist)) {
+			kfree(gl);
+			return -EFAULT;
+		}
+	set_fs(KERNEL_DS);
+	ret = sys_setgroups(gidsetsize, gl);
+	set_fs(old_fs);
+	kfree(gl);
+	return ret;
 }
 
 asmlinkage long sys32_getuid16(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/arch/sparc64/kernel/sys_sunos32.c .13015-linux-2.6.0-test5-bk11.updated/arch/sparc64/kernel/sys_sunos32.c
--- .13015-linux-2.6.0-test5-bk11/arch/sparc64/kernel/sys_sunos32.c	2003-09-22 10:27:56.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/arch/sparc64/kernel/sys_sunos32.c	2003-09-25 12:58:43.000000000 +1000
@@ -859,7 +859,7 @@ extern asmlinkage s32 sunos_sysconf (int
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = max_groups;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/fs/nfsd/auth.c .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/auth.c
--- .13015-linux-2.6.0-test5-bk11/fs/nfsd/auth.c	2003-09-22 10:21:34.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/auth.c	2003-09-25 12:58:43.000000000 +1000
@@ -26,7 +26,7 @@ nfsd_setuser(struct svc_rqst *rqstp, str
 			cred->cr_uid = exp->ex_anon_uid;
 		if (!cred->cr_gid)
 			cred->cr_gid = exp->ex_anon_gid;
-		for (i = 0; i < NGROUPS; i++)
+		for (i = 0; i < SVC_CRED_NGROUPS; i++)
 			if (!cred->cr_groups[i])
 				cred->cr_groups[i] = exp->ex_anon_gid;
 	}
@@ -39,7 +39,9 @@ nfsd_setuser(struct svc_rqst *rqstp, str
 		current->fsgid = cred->cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
-	for (i = 0; i < NGROUPS; i++) {
+
+	/* We can do this because cow_current_groups() was done at birth. */
+	for (i = 0; i < SVC_CRED_NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/fs/nfsd/nfs4state.c .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/nfs4state.c
--- .13015-linux-2.6.0-test5-bk11/fs/nfsd/nfs4state.c	2003-09-25 09:56:32.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/nfs4state.c	2003-09-25 12:58:43.000000000 +1000
@@ -244,7 +244,7 @@ copy_cred(struct svc_cred *target, struc
 
 	target->cr_uid = source->cr_uid;
 	target->cr_gid = source->cr_gid;
-	for(i = 0; i < NGROUPS; i++)
+	for(i = 0; i < SVC_CREDS_NGROUPS; i++)
 		target->cr_groups[i] = source->cr_groups[i];
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/fs/nfsd/nfssvc.c .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/nfssvc.c
--- .13015-linux-2.6.0-test5-bk11/fs/nfsd/nfssvc.c	2003-09-22 10:26:12.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/fs/nfsd/nfssvc.c	2003-09-25 12:58:43.000000000 +1000
@@ -182,6 +182,11 @@ nfsd(struct svc_rqst *rqstp)
 	daemonize("nfsd");
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 
+	if (cow_current_groups(SVC_CRED_NGROUPS) < 0) {
+		printk("Unable to start nfsd thread: can't set groups\n");
+		goto out;
+	}
+
 	/* After daemonize() this kernel thread shares current->fs
 	 * with the init process. We need to create files with a
 	 * umask of 0 instead of init's umask. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-alpha/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-alpha/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-alpha/param.h	2003-09-21 17:27:17.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-alpha/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -19,10 +19,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-arm/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-arm/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-arm/param.h	2003-09-22 10:28:10.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-arm/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -26,10 +26,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-arm26/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-arm26/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-arm26/param.h	2003-09-22 10:09:07.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-arm26/param.h	2003-09-25 12:58:43.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-cris/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-cris/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-cris/param.h	2003-09-22 10:23:13.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-cris/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-h8300/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-h8300/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-h8300/param.h	2003-09-22 10:07:04.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-h8300/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-i386/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-i386/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-i386/param.h	2003-09-25 12:58:41.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-i386/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-ia64/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-ia64/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-ia64/param.h	2003-09-25 09:56:35.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-ia64/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -10,10 +10,6 @@
 
 #define EXEC_PAGESIZE	65536
 
-#ifndef NGROUPS
-# define NGROUPS	32
-#endif
-
 #ifndef NOGROUP
 # define NOGROUP	(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-m68k/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-m68k/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-m68k/param.h	2003-09-21 17:26:43.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-m68k/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-m68knommu/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-m68knommu/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-m68knommu/param.h	2003-09-21 17:31:31.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-m68knommu/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -44,10 +44,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-mips/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-mips/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-mips/param.h	2003-09-22 10:22:44.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-mips/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -33,10 +33,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-parisc/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-parisc/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-parisc/param.h	2003-09-21 17:31:10.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-parisc/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -17,10 +17,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-ppc/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-ppc/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-ppc/param.h	2003-09-22 09:47:27.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-ppc/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-ppc64/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-ppc64/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-ppc64/param.h	2003-09-21 17:26:44.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-ppc64/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -20,10 +20,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-s390/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-s390/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-s390/param.h	2003-09-21 17:29:29.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-s390/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -21,10 +21,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-sh/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-sh/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-sh/param.h	2003-09-22 10:23:00.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-sh/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -17,10 +17,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-sparc/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-sparc/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-sparc/param.h	2003-09-21 17:26:18.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-sparc/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-sparc64/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-sparc64/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-sparc64/param.h	2003-09-21 17:26:18.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-sparc64/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-um/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-um/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-um/param.h	2003-09-21 17:28:16.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-um/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -3,10 +3,6 @@
 
 #define EXEC_PAGESIZE   4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-v850/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-v850/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-v850/param.h	2003-09-21 17:31:32.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-v850/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/asm-x86_64/param.h .13015-linux-2.6.0-test5-bk11.updated/include/asm-x86_64/param.h
--- .13015-linux-2.6.0-test5-bk11/include/asm-x86_64/param.h	2003-09-21 17:30:30.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/asm-x86_64/param.h	2003-09-25 12:58:43.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/linux/init_task.h .13015-linux-2.6.0-test5-bk11.updated/include/linux/init_task.h
--- .13015-linux-2.6.0-test5-bk11/include/linux/init_task.h	2003-09-22 10:27:37.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/linux/init_task.h	2003-09-25 12:58:43.000000000 +1000
@@ -108,6 +108,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.groups		= &(tsk).internal_groups,			\
 }
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/linux/sched.h .13015-linux-2.6.0-test5-bk11.updated/include/linux/sched.h
--- .13015-linux-2.6.0-test5-bk11/include/linux/sched.h	2003-09-25 09:56:38.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/linux/sched.h	2003-09-25 12:58:43.000000000 +1000
@@ -328,6 +328,17 @@ struct k_itimer {
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
+/* Size is determined by task_struct's ngroups. */
+struct task_groups
+{
+	atomic_t usage;
+	gid_t groups[0];
+};
+
+extern int max_groups;
+
+#define NGROUPS_INTERNAL 1 /* For testing. */
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -403,7 +414,8 @@ struct task_struct {
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups; /* == internal_groups, or task_groups->groups */
+	gid_t internal_groups[NGROUPS_INTERNAL];
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
@@ -602,6 +614,12 @@ extern int send_group_sigqueue(int, stru
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
+/* container_of doesn't like arrays. */
+static inline struct task_groups *task_groups(gid_t *groups)
+{
+	return (void *)groups - offsetof(struct task_groups, groups);
+}
+
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct siginfo *) 0)
 #define SEND_SIG_PRIV	((struct siginfo *) 1)
@@ -678,6 +696,10 @@ extern int do_execve(char *, char __user
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 
+/* Copy-on-write current groups to this size, if possible.  0 or -err. */
+extern int cow_current_groups(unsigned int ngroups);
+extern void release_groups(gid_t *groups);
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/linux/sunrpc/svcauth.h .13015-linux-2.6.0-test5-bk11.updated/include/linux/sunrpc/svcauth.h
--- .13015-linux-2.6.0-test5-bk11/include/linux/sunrpc/svcauth.h	2003-09-22 09:47:41.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/linux/sunrpc/svcauth.h	2003-09-25 12:58:43.000000000 +1000
@@ -16,10 +16,12 @@
 #include <linux/sunrpc/cache.h>
 #include <linux/hash.h>
 
+#define SVC_CRED_NGROUPS	32
+
 struct svc_cred {
 	uid_t			cr_uid;
 	gid_t			cr_gid;
-	gid_t			cr_groups[NGROUPS];
+	gid_t			cr_groups[SVC_CRED_NGROUPS];
 };
 
 struct svc_rqst;		/* forward decl */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/include/linux/sysctl.h .13015-linux-2.6.0-test5-bk11.updated/include/linux/sysctl.h
--- .13015-linux-2.6.0-test5-bk11/include/linux/sysctl.h	2003-09-22 10:28:13.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/include/linux/sysctl.h	2003-09-25 12:58:43.000000000 +1000
@@ -127,6 +127,7 @@ enum
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
 	KERN_HPPA_PWRSW=58,	/* int: hppa soft-power enable */
 	KERN_HPPA_UNALIGNED=59,	/* int: hppa unaligned-trap enable */
+	KERN_MAX_GROUPS=60,	/* int: setgroups limit */
 };
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/kernel/fork.c .13015-linux-2.6.0-test5-bk11.updated/kernel/fork.c
--- .13015-linux-2.6.0-test5-bk11/kernel/fork.c	2003-09-25 09:56:39.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/kernel/fork.c	2003-09-25 12:58:43.000000000 +1000
@@ -73,6 +73,8 @@ static kmem_cache_t *task_struct_cachep;
 
 static void free_task(struct task_struct *tsk)
 {
+	if (unlikely(tsk->groups != tsk->internal_groups))
+		release_groups(tsk->groups);
 	free_thread_info(tsk->thread_info);
 	free_task_struct(tsk);
 }
@@ -213,6 +215,11 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	if (unlikely(orig->groups != orig->internal_groups))
+		atomic_inc(&task_groups(orig->groups)->usage);
+	else
+		tsk->groups = tsk->internal_groups;
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/kernel/sys.c .13015-linux-2.6.0-test5-bk11.updated/kernel/sys.c
--- .13015-linux-2.6.0-test5-bk11/kernel/sys.c	2003-09-25 09:56:39.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/kernel/sys.c	2003-09-25 12:58:43.000000000 +1000
@@ -1066,6 +1066,67 @@ out:
 	return err;
 }
 
+int max_groups = 32;
+
+/* Caller checks that groups != current->internal_groups */
+void release_groups(gid_t *groups)
+{
+	struct task_groups *tgrp = task_groups(groups);
+
+	if (atomic_dec_and_test(&tgrp->usage))
+		kfree(tgrp);
+}
+
+/* This does the actual copy and changeover.  Caller sets
+ * current->ngroups, once copy is successful. */
+static int alloc_new_groups(unsigned int ngroups)
+{
+	struct task_groups *tgrp;
+
+	if (ngroups < current->ngroups)
+		ngroups = current->ngroups;
+
+	tgrp = kmalloc(sizeof(*tgrp) + sizeof(tgrp->groups[0])*ngroups,
+		       GFP_KERNEL);
+	if (!tgrp)
+		return -ENOMEM;
+	atomic_set(&tgrp->usage, 1);
+
+	memcpy(tgrp->groups, current->groups,
+	       sizeof(tgrp->groups[0]) * current->ngroups);
+
+	if (current->groups != current->internal_groups)
+		release_groups(current->groups);
+
+	current->groups = tgrp->groups;
+	return 0;
+}
+
+/* Unshare and maybe enlarge current groups to this size, if possible.
+ * 0 or -err. */
+int cow_current_groups(unsigned int ngroups)
+{
+	if (ngroups > max_groups)
+		return -EINVAL;
+
+	/* Currently external? */
+	if (unlikely(current->ngroups > NGROUPS_INTERNAL)) {
+		/* Shared? */
+		if (atomic_read(&task_groups(current->groups)->usage) > 1)
+			return alloc_new_groups(ngroups);
+		/* Want more? */
+		if (ngroups > current->ngroups)
+			return alloc_new_groups(ngroups);
+		return 0;
+	}
+
+	/* Internal.  Maybe new one will be too big? */
+	if (ngroups > NGROUPS_INTERNAL)
+		return alloc_new_groups(ngroups);
+
+	return 0;
+}
+
 /*
  * Supplementary group IDs
  */
@@ -1097,21 +1158,29 @@ asmlinkage long sys_getgroups(int gidset
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
 {
-	gid_t groups[NGROUPS];
+	gid_t *groups;
 	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
-		return -EFAULT;
+	retval = cow_current_groups(gidsetsize);
+	if (retval < 0)
+		return retval;
+	groups = kmalloc(sizeof(groups[0]) * gidsetsize, GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t))) {
+		retval = -EFAULT;
+		goto out;
+	}
 	retval = security_task_setgroups(gidsetsize, groups);
 	if (retval)
-		return retval;
+		goto out;
 	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
-	return 0;
+out:
+	kfree(groups);
+	return retval;
 }
 
 static int supplemental_group_member(gid_t grp)
@@ -1431,6 +1500,7 @@ asmlinkage long sys_prctl(int option, un
 	return error;
 }
 
+EXPORT_SYMBOL(cow_current_groups);
 EXPORT_SYMBOL(notifier_chain_register);
 EXPORT_SYMBOL(notifier_chain_unregister);
 EXPORT_SYMBOL(notifier_call_chain);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/kernel/sysctl.c .13015-linux-2.6.0-test5-bk11.updated/kernel/sysctl.c
--- .13015-linux-2.6.0-test5-bk11/kernel/sysctl.c	2003-09-25 09:56:39.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/kernel/sysctl.c	2003-09-25 12:58:43.000000000 +1000
@@ -581,6 +581,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_MAX_GROUPS,
+		.procname	= "max_groups",
+		.data		= &max_groups,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/kernel/uid16.c .13015-linux-2.6.0-test5-bk11.updated/kernel/uid16.c
--- .13015-linux-2.6.0-test5-bk11/kernel/uid16.c	2003-09-22 10:07:19.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/kernel/uid16.c	2003-09-25 12:58:43.000000000 +1000
@@ -109,7 +109,6 @@ asmlinkage long sys_setfsgid16(old_gid_t
 
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
 	int i,j;
 
 	if (gidsetsize < 0)
@@ -118,34 +117,48 @@ asmlinkage long sys_getgroups16(int gids
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+		if (!access_ok(VERIFY_WRITE, grouplist, sizeof(old_gid_t)*i))
 			return -EFAULT;
+		for(j=0;j<i;j++) {
+			old_gid_t group;
+			group = current->groups[j];
+			if (copy_to_user(grouplist+j, &group, sizeof(group)))
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
+	old_gid_t *groups;
+	gid_t *new_groups;
+	int i, ret;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
+
+	if ((ret = cow_current_groups(gidsetsize)) < 0)
+		return ret;
+	ret = -ENOMEM;
+	groups = kmalloc(sizeof(groups[0]) * gidsetsize, GFP_KERNEL);
+	new_groups = kmalloc(sizeof(new_groups[0]) * gidsetsize, GFP_KERNEL);
+	if (!groups || !new_groups)
+		goto out;
+	ret = -EFAULT;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
-		return -EFAULT;
+		goto out;
 	for (i = 0 ; i < gidsetsize ; i++)
 		new_groups[i] = (gid_t)groups[i];
-	i = security_task_setgroups(gidsetsize, new_groups);
-	if (i)
-		return i;
+	ret = security_task_setgroups(gidsetsize, new_groups);
+	if (ret)
+		goto out;
 	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
-	return 0;
+out:
+	kfree(groups);
+	kfree(groups);
+	return ret;
 }
 
 asmlinkage long sys_getuid16(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13015-linux-2.6.0-test5-bk11/net/sunrpc/svcauth_unix.c .13015-linux-2.6.0-test5-bk11.updated/net/sunrpc/svcauth_unix.c
--- .13015-linux-2.6.0-test5-bk11/net/sunrpc/svcauth_unix.c	2003-09-22 10:23:05.000000000 +1000
+++ .13015-linux-2.6.0-test5-bk11.updated/net/sunrpc/svcauth_unix.c	2003-09-25 12:58:43.000000000 +1000
@@ -434,11 +434,11 @@ svcauth_unix_accept(struct svc_rqst *rqs
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
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
