Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTI2HVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTI2HVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:21:52 -0400
Received: from dp.samba.org ([66.70.73.150]:53664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262855AbTI2HU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:20:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, braam@clusterfs.com, neilb@cse.unsw.edu.au
Subject: [PATCH] Many groups patch.
Date: Mon, 29 Sep 2003 17:19:50 +1000
Message-Id: <20030929072027.903AC2C07F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As stated before, SAMBA customers want > 200 groups.  Special thanks
to Tim Hockin for feedback based on his patch.

This version drops the internal groups array (it's so often shared
that it's not worth it, and the logic becomes a bit neater), and does
vmalloc fallback in case someone has massive number of groups.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Dynamic Allocation of Groups Array When Required: With Refcounting
Author: Rusty Russell
Status: Tested on 2.6.0-test6
Depends: Misc/qemu-page-offset.patch.gz

D: This patch allows the maximum number of groups to be varied using
D: sysctl.  Since sharing is so common, we use a refcounted external
D: array for groups.
D: 
D: Changes:
D: 1) Remove the NGROUPS define from archs.
D: 2) Fixup the few places which declare [NGROUPS] arrays on the stack.
D: 3) The ia64, s390 and sparc64 ports have their own setgroups/getgroups
D:    implementations: unify them on the ia64 one, which calls the core
D:    functions.
D: 4) Change the task_struct's groups to a pointer to inside a refcounted
D:    external array, fix up fork() to inc refcount.
D: 5) Introduce max_groups and use it instead of NGROUPS.
D: 6) Add a sysctl to vary max_groups.
D: 
D: This patch scars nfs: artificially restrict the groups there to 
D: SVC_CRED_NGROUPS (32), which is probably wrong, but won't break if
D: they don't change the default.
D: 
D: This patch breaks intermezzo: I'm not sure how they want to deal
D: with it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/ia64/ia32/sys_ia32.c .12070-2.6.0-test6-more_groups_refcount/arch/ia64/ia32/sys_ia32.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/ia64/ia32/sys_ia32.c	2003-09-29 10:25:17.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/ia64/ia32/sys_ia32.c	2003-09-29 17:18:46.000000000 +1000
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/mips/kernel/sysirix.c .12070-2.6.0-test6-more_groups_refcount/arch/mips/kernel/sysirix.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/mips/kernel/sysirix.c	2003-09-29 10:25:18.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/mips/kernel/sysirix.c	2003-09-29 17:18:46.000000000 +1000
@@ -368,7 +368,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 			retval = HZ;
 			goto out;
 		case 4:
-			retval = NGROUPS;
+			retval = max_groups;
 			goto out;
 		case 5:
 			retval = NR_OPEN;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/s390/kernel/compat_linux.c .12070-2.6.0-test6-more_groups_refcount/arch/s390/kernel/compat_linux.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/s390/kernel/compat_linux.c	2003-09-29 10:25:21.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/s390/kernel/compat_linux.c	2003-09-29 17:18:46.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc/kernel/sys_sunos.c .12070-2.6.0-test6-more_groups_refcount/arch/sparc/kernel/sys_sunos.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc/kernel/sys_sunos.c	2003-09-22 10:27:56.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/sparc/kernel/sys_sunos.c	2003-09-29 17:18:46.000000000 +1000
@@ -896,7 +896,7 @@ extern asmlinkage long sunos_sysconf (in
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = max_groups;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc64/kernel/sys_sparc32.c .12070-2.6.0-test6-more_groups_refcount/arch/sparc64/kernel/sys_sparc32.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc64/kernel/sys_sparc32.c	2003-09-29 10:25:22.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/sparc64/kernel/sys_sparc32.c	2003-09-29 17:18:46.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc64/kernel/sys_sunos32.c .12070-2.6.0-test6-more_groups_refcount/arch/sparc64/kernel/sys_sunos32.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/arch/sparc64/kernel/sys_sunos32.c	2003-09-22 10:27:56.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/arch/sparc64/kernel/sys_sunos32.c	2003-09-29 17:18:46.000000000 +1000
@@ -859,7 +859,7 @@ extern asmlinkage s32 sunos_sysconf (int
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = max_groups;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/auth.c .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/auth.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/auth.c	2003-09-22 10:21:34.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/auth.c	2003-09-29 17:18:46.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/nfs4state.c .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/nfs4state.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/nfs4state.c	2003-09-29 10:25:52.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/nfs4state.c	2003-09-29 17:18:46.000000000 +1000
@@ -244,7 +244,7 @@ copy_cred(struct svc_cred *target, struc
 
 	target->cr_uid = source->cr_uid;
 	target->cr_gid = source->cr_gid;
-	for(i = 0; i < NGROUPS; i++)
+	for(i = 0; i < SVC_CREDS_NGROUPS; i++)
 		target->cr_groups[i] = source->cr_groups[i];
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/nfssvc.c .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/nfssvc.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/fs/nfsd/nfssvc.c	2003-09-22 10:26:12.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/fs/nfsd/nfssvc.c	2003-09-29 17:18:46.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-alpha/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-alpha/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-alpha/param.h	2003-09-21 17:27:17.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-alpha/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -19,10 +19,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-arm/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-arm/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-arm/param.h	2003-09-22 10:28:10.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-arm/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -26,10 +26,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-arm26/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-arm26/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-arm26/param.h	2003-09-22 10:09:07.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-arm26/param.h	2003-09-29 17:18:46.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-cris/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-cris/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-cris/param.h	2003-09-22 10:23:13.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-cris/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-h8300/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-h8300/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-h8300/param.h	2003-09-22 10:07:04.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-h8300/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-i386/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-i386/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-i386/param.h	2003-09-29 17:18:46.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-i386/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ia64/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-ia64/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ia64/param.h	2003-09-29 10:25:58.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-ia64/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -10,10 +10,6 @@
 
 #define EXEC_PAGESIZE	65536
 
-#ifndef NGROUPS
-# define NGROUPS	32
-#endif
-
 #ifndef NOGROUP
 # define NOGROUP	(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-m68k/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-m68k/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-m68k/param.h	2003-09-21 17:26:43.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-m68k/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	8192
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-m68knommu/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-m68knommu/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-m68knommu/param.h	2003-09-21 17:31:31.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-m68knommu/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -44,10 +44,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-mips/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-mips/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-mips/param.h	2003-09-22 10:22:44.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-mips/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -33,10 +33,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-parisc/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-parisc/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-parisc/param.h	2003-09-21 17:31:10.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-parisc/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -17,10 +17,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ppc/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-ppc/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ppc/param.h	2003-09-22 09:47:27.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-ppc/param.h	2003-09-29 17:18:46.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ppc64/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-ppc64/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-ppc64/param.h	2003-09-21 17:26:44.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-ppc64/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -20,10 +20,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-s390/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-s390/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-s390/param.h	2003-09-21 17:29:29.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-s390/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -21,10 +21,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sh/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-sh/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sh/param.h	2003-09-22 10:23:00.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-sh/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -17,10 +17,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sparc/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-sparc/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sparc/param.h	2003-09-21 17:26:18.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-sparc/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sparc64/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-sparc64/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-sparc64/param.h	2003-09-21 17:26:18.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-sparc64/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -14,10 +14,6 @@
 
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-um/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-um/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-um/param.h	2003-09-21 17:28:16.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-um/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -3,10 +3,6 @@
 
 #define EXEC_PAGESIZE   4096
 
-#ifndef NGROUPS
-#define NGROUPS         32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP         (-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-v850/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-v850/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-v850/param.h	2003-09-21 17:31:32.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-v850/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -18,10 +18,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-x86_64/param.h .12070-2.6.0-test6-more_groups_refcount/include/asm-x86_64/param.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/asm-x86_64/param.h	2003-09-21 17:30:30.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/asm-x86_64/param.h	2003-09-29 17:18:47.000000000 +1000
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/init_task.h .12070-2.6.0-test6-more_groups_refcount/include/linux/init_task.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/init_task.h	2003-09-22 10:27:37.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/linux/init_task.h	2003-09-29 17:18:47.000000000 +1000
@@ -56,6 +56,8 @@
 	.siglock	= SPIN_LOCK_UNLOCKED, 		\
 }
 
+extern struct task_groups init_groups;
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -108,6 +110,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.groups		= init_groups.groups,				\
 }
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sched.h .12070-2.6.0-test6-more_groups_refcount/include/linux/sched.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sched.h	2003-09-29 10:26:05.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/linux/sched.h	2003-09-29 17:18:47.000000000 +1000
@@ -328,6 +328,16 @@ struct k_itimer {
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
+/* Size is determined by task_struct's ngroups. */
+struct task_groups
+{
+	atomic_t usage;
+	void (*free)(const void *);
+	gid_t groups[0];
+};
+
+extern int max_groups;
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -403,7 +413,7 @@ struct task_struct {
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	int ngroups;
-	gid_t	groups[NGROUPS];
+	gid_t *groups; /* task_groups->groups */
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
@@ -602,6 +612,12 @@ extern int send_group_sigqueue(int, stru
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
@@ -678,6 +694,10 @@ extern int do_execve(char *, char __user
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
 
+/* Copy-on-write current groups to this size, if possible.  0 or -err. */
+extern int cow_current_groups(unsigned int ngroups);
+extern void release_groups(gid_t *groups);
+
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sunrpc/svcauth.h .12070-2.6.0-test6-more_groups_refcount/include/linux/sunrpc/svcauth.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sunrpc/svcauth.h	2003-09-22 09:47:41.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/linux/sunrpc/svcauth.h	2003-09-29 17:18:47.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sysctl.h .12070-2.6.0-test6-more_groups_refcount/include/linux/sysctl.h
--- .12070-2.6.0-test6-more_groups_refcount.pre/include/linux/sysctl.h	2003-09-22 10:28:13.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/include/linux/sysctl.h	2003-09-29 17:18:47.000000000 +1000
@@ -127,6 +127,7 @@ enum
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
 	KERN_HPPA_PWRSW=58,	/* int: hppa soft-power enable */
 	KERN_HPPA_UNALIGNED=59,	/* int: hppa unaligned-trap enable */
+	KERN_MAX_GROUPS=60,	/* int: setgroups limit */
 };
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/init/main.c .12070-2.6.0-test6-more_groups_refcount/init/main.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/init/main.c	2003-09-29 10:26:06.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/init/main.c	2003-09-29 17:18:47.000000000 +1000
@@ -594,7 +594,6 @@ static int init(void * unused)
 	 * The Bourne shell can be used instead of init if we are 
 	 * trying to recover a really broken machine.
 	 */
-
 	if (execute_command)
 		run_init_process(execute_command);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/kernel/fork.c .12070-2.6.0-test6-more_groups_refcount/kernel/fork.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/kernel/fork.c	2003-09-29 10:26:06.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/kernel/fork.c	2003-09-29 17:18:47.000000000 +1000
@@ -85,6 +85,7 @@ void __put_task_struct(struct task_struc
 
 	security_task_free(tsk);
 	free_uid(tsk->user);
+	release_groups(tsk->groups);
 	free_task(tsk);
 }
 
@@ -817,6 +818,7 @@ struct task_struct *copy_process(unsigne
 
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
+	atomic_inc(&task_groups(p->groups)->usage);
 
 	/*
 	 * If multiple threads are within copy_process(), then this check
@@ -1063,6 +1065,7 @@ bad_fork_cleanup_put_domain:
 bad_fork_cleanup_count:
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
+	release_groups(p->groups);
 bad_fork_free:
 	free_task(p);
 	goto fork_out;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/kernel/sys.c .12070-2.6.0-test6-more_groups_refcount/kernel/sys.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/kernel/sys.c	2003-09-29 10:26:06.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/kernel/sys.c	2003-09-29 17:18:47.000000000 +1000
@@ -1069,6 +1069,62 @@ out:
 	return err;
 }
 
+/* Never freed */
+struct task_groups init_groups = { .usage = ATOMIC_INIT(2) };
+
+int max_groups = 32;
+
+void release_groups(gid_t *groups)
+{
+	struct task_groups *tgrp = task_groups(groups);
+
+	if (atomic_dec_and_test(&tgrp->usage))
+		tgrp->free(tgrp);
+}
+
+/* This does the actual copy and changeover.  Caller sets
+ * current->ngroups and changes group array if everything else goes ok. */
+static inline int alloc_new_groups(unsigned int ngroups)
+{
+	struct task_groups *tgrp;
+	unsigned int size;
+
+	if (ngroups < current->ngroups)
+		ngroups = current->ngroups;
+	size = sizeof(*tgrp) + sizeof(tgrp->groups[0])*ngroups;
+	
+	if (!(tgrp = kmalloc(size, GFP_KERNEL))) {
+		if (!(tgrp = vmalloc(size)))
+			return -ENOMEM;
+		tgrp->free = (void (*)(const void *))vfree;
+	} else
+		tgrp->free = kfree;
+	atomic_set(&tgrp->usage, 1);
+
+	memcpy(tgrp->groups, current->groups,
+	       sizeof(tgrp->groups[0]) * current->ngroups);
+
+	release_groups(current->groups);
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
+	printk("cow to %u groups\n", ngroups);
+	/* Shared, or needs expansion? */
+	if (atomic_read(&task_groups(current->groups)->usage) > 1
+	    || ngroups > current->ngroups)
+		return alloc_new_groups(ngroups);
+
+	return 0;
+}
+
 /*
  * Supplementary group IDs
  */
@@ -1094,27 +1150,36 @@ asmlinkage long sys_getgroups(int gidset
 }
 
 /*
- *	SMP: Our groups are not shared. We can copy to/from them safely
+ *	SMP: Our groups are copy-on-write. We can copy to/from them safely
  *	without another task interfering.
  */
  
 asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
 {
-	gid_t groups[NGROUPS];
+	gid_t *groups;
 	int retval;
 
+	printk("sys_setgroups %u groups\n", gidsetsize);
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
@@ -1434,6 +1499,7 @@ asmlinkage long sys_prctl(int option, un
 	return error;
 }
 
+EXPORT_SYMBOL(cow_current_groups);
 EXPORT_SYMBOL(notifier_chain_register);
 EXPORT_SYMBOL(notifier_chain_unregister);
 EXPORT_SYMBOL(notifier_call_chain);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/kernel/sysctl.c .12070-2.6.0-test6-more_groups_refcount/kernel/sysctl.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/kernel/sysctl.c	2003-09-29 10:26:06.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/kernel/sysctl.c	2003-09-29 17:18:47.000000000 +1000
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/kernel/uid16.c .12070-2.6.0-test6-more_groups_refcount/kernel/uid16.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/kernel/uid16.c	2003-09-22 10:07:19.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/kernel/uid16.c	2003-09-29 17:18:47.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12070-2.6.0-test6-more_groups_refcount.pre/net/sunrpc/svcauth_unix.c .12070-2.6.0-test6-more_groups_refcount/net/sunrpc/svcauth_unix.c
--- .12070-2.6.0-test6-more_groups_refcount.pre/net/sunrpc/svcauth_unix.c	2003-09-22 10:23:05.000000000 +1000
+++ .12070-2.6.0-test6-more_groups_refcount/net/sunrpc/svcauth_unix.c	2003-09-29 17:18:47.000000000 +1000
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
