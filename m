Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJAV2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTJAV2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:28:49 -0400
Received: from hockin.org ([66.35.79.110]:30473 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262617AbTJAV1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:27:50 -0400
Date: Wed, 1 Oct 2003 14:16:42 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031001211642.GA32054@hockin.org>
References: <20031001202910.GA30014@hockin.org> <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

forgot the patch again.  Bad week for me.

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ngroups-2.6.0-test6-3.diff"

===== arch/ia64/ia32/sys_ia32.c 1.78 vs edited =====
--- 1.78/arch/ia64/ia32/sys_ia32.c	Mon Sep 22 21:16:30 2003
+++ edited/arch/ia64/ia32/sys_ia32.c	Wed Oct  1 13:58:23 2003
@@ -2426,44 +2426,85 @@
 	return sys_lseek(fd, offset, whence);
 }
 
-extern asmlinkage long sys_getgroups (int gidsetsize, gid_t *grouplist);
+static int
+groups16_to_user(short *grouplist, struct group_info *info)
+{
+	int i;
+	short group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		group = (short)GROUP_AT(info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+groups16_from_user(struct group_info *info, short *grouplist)
+{
+	int i;
+	short group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(info, i) = (gid_t)group;
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
 
-extern asmlinkage long sys_setgroups (int gidsetsize, gid_t *grouplist);
+	if (gidsetsize < 0)
+		return -EINVAL;
+	i = current->group_info->ngroups;
+	if (gidsetsize) {
+		if (i > gidsetsize)
+			return -EINVAL;
+		if (groups16_to_user(grouplist, current->group_info))
+			return -EFAULT;
+	}
+	return i;
+}
 
 asmlinkage long
 sys32_setgroups16 (int gidsetsize, short *grouplist)
 {
-	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
-	int ret, i;
+	struct group_info *new_info;
+	int retval;
 
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	for (i = 0; i < gidsetsize; i++, grouplist++)
-		if (get_user(gl[i], grouplist))
-			return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_setgroups(gidsetsize, gl);
-	set_fs(old_fs);
-	return ret;
+	if (!capable(CAP_SETGID))
+		return -EPERM;
+	new_info = groups_alloc(gidsetsize);
+	if (!new_info)
+		return -ENOMEM;
+	retval = groups16_from_user(new_info, grouplist);
+	if (retval) {
+		groups_free(new_info);
+		return retval;
+	}
+
+	retval = set_current_groups(new_info);
+	if (retval)
+		groups_free(new_info);
+
+	return retval;
 }
 
 asmlinkage long
===== arch/mips/kernel/sysirix.c 1.18 vs edited =====
--- 1.18/arch/mips/kernel/sysirix.c	Tue Sep 23 19:34:27 2003
+++ edited/arch/mips/kernel/sysirix.c	Tue Sep 30 18:32:00 2003
@@ -368,7 +368,7 @@
 			retval = HZ;
 			goto out;
 		case 4:
-			retval = NGROUPS;
+			retval = INT_MAX;
 			goto out;
 		case 5:
 			retval = NR_OPEN;
===== arch/s390/kernel/compat_linux.c 1.9 vs edited =====
--- 1.9/arch/s390/kernel/compat_linux.c	Thu Sep 25 11:33:23 2003
+++ edited/arch/s390/kernel/compat_linux.c	Wed Oct  1 13:58:28 2003
@@ -189,20 +189,55 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(u16 *grouplist, struct group_info *info)
+{
+	int i;
+	u16 group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		group = (u16)GROUP_AT(info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *info, u16 *grouplist)
+{
+	int i;
+	u16 group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(info, i) = (gid_t)group;
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
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
+		if (groups16_to_user(grouplist, current->group_info))
 			return -EFAULT;
 	}
 	return i;
@@ -210,19 +245,25 @@
 
 asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	struct group_info *new_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
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
+	retval = set_current_groups(new_info);
+	if (retval)
+		groups_free(new_info);
+
+	return retval;
 }
 
 asmlinkage long sys32_getuid16(void)
===== arch/sparc/kernel/sys_sunos.c 1.26 vs edited =====
--- 1.26/arch/sparc/kernel/sys_sunos.c	Tue Aug 26 09:25:41 2003
+++ edited/arch/sparc/kernel/sys_sunos.c	Tue Sep 30 18:32:00 2003
@@ -896,7 +896,7 @@
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = INT_MAX;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
===== arch/sparc64/kernel/sys_sparc32.c 1.83 vs edited =====
--- 1.83/arch/sparc64/kernel/sys_sparc32.c	Mon Sep 22 21:16:30 2003
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Wed Oct  1 13:58:32 2003
@@ -206,20 +206,55 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(u16 *grouplist, struct group_info *info)
+{
+	int i;
+	u16 group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		group = (u16)GROUP_AT(info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *info, u16 *grouplist)
+{
+	int i;
+	u16 group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(info, i) = (gid_t)group;
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
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
+		if (groups16_to_user(grouplist, current->group_info))
 			return -EFAULT;
 	}
 	return i;
@@ -227,19 +262,25 @@
 
 asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
 {
-	u16 groups[NGROUPS];
-	int i;
+	struct group_info *new_info;
+	int retval;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
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
+	retval = set_current_groups(new_info);
+	if (retval)
+		groups_free(new_info);
+
+	return retval;
 }
 
 asmlinkage long sys32_getuid16(void)
===== arch/sparc64/kernel/sys_sunos32.c 1.35 vs edited =====
--- 1.35/arch/sparc64/kernel/sys_sunos32.c	Tue Aug 26 09:25:41 2003
+++ edited/arch/sparc64/kernel/sys_sunos32.c	Tue Sep 30 18:32:00 2003
@@ -859,7 +859,7 @@
 		ret = HZ;
 		break;
 	case _SC_NGROUPS_MAX:
-		ret = NGROUPS_MAX;
+		ret = INT_MAX;
 		break;
 	case _SC_OPEN_MAX:
 		ret = OPEN_MAX;
===== arch/sparc64/solaris/misc.c 1.18 vs edited =====
--- 1.18/arch/sparc64/solaris/misc.c	Sun Sep 21 14:49:52 2003
+++ edited/arch/sparc64/solaris/misc.c	Tue Sep 30 18:32:00 2003
@@ -341,7 +341,7 @@
 asmlinkage int solaris_sysconf(int id)
 {
 	switch (id) {
-	case SOLARIS_CONFIG_NGROUPS:	return NGROUPS_MAX;
+	case SOLARIS_CONFIG_NGROUPS:	return INT_MAX;
 	case SOLARIS_CONFIG_CHILD_MAX:	return CHILD_MAX;
 	case SOLARIS_CONFIG_OPEN_FILES:	return OPEN_MAX;
 	case SOLARIS_CONFIG_POSIX_VER:	return 199309;
===== fs/nfsd/auth.c 1.2 vs edited =====
--- 1.2/fs/nfsd/auth.c	Tue Jun 17 16:31:29 2003
+++ edited/fs/nfsd/auth.c	Tue Sep 30 18:32:00 2003
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
===== fs/nfsd/nfs4state.c 1.20 vs edited =====
--- 1.20/fs/nfsd/nfs4state.c	Mon Sep 22 16:11:52 2003
+++ edited/fs/nfsd/nfs4state.c	Tue Sep 30 18:32:00 2003
@@ -244,7 +244,7 @@
 
 	target->cr_uid = source->cr_uid;
 	target->cr_gid = source->cr_gid;
-	for(i = 0; i < NGROUPS; i++)
+	for(i = 0; i < SVC_CRED_NGROUPS; i++)
 		target->cr_groups[i] = source->cr_groups[i];
 }
 
===== fs/proc/array.c 1.52 vs edited =====
--- 1.52/fs/proc/array.c	Tue Sep 23 18:39:53 2003
+++ edited/fs/proc/array.c	Wed Oct  1 13:58:37 2003
@@ -176,8 +176,8 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
-		buffer += sprintf(buffer, "%d ", p->groups[g]);
+	for (g = 0; g < min(p->group_info->ngroups,NGROUPS_SMALL); g++)
+		buffer += sprintf(buffer, "%d ", GROUP_AT(p->group_info,g));
 
 	buffer += sprintf(buffer, "\n");
 	return buffer;
===== include/asm-alpha/param.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/param.h	Thu Aug  8 12:28:02 2002
+++ edited/include/asm-alpha/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-arm/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-arm26/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-cris/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-h8300/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-i386/param.h	Tue Sep 30 18:32:00 2003
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-ia64/param.h 1.4 vs edited =====
--- 1.4/include/asm-ia64/param.h	Wed Sep 17 18:59:37 2003
+++ edited/include/asm-ia64/param.h	Tue Sep 30 18:32:00 2003
@@ -10,10 +10,6 @@
 
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
+++ edited/include/asm-m68k/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-m68knommu/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-mips/param.h	Tue Sep 30 18:32:00 2003
@@ -33,10 +33,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/asm-parisc/param.h 1.2 vs edited =====
--- 1.2/include/asm-parisc/param.h	Mon Oct 28 02:33:42 2002
+++ edited/include/asm-parisc/param.h	Tue Sep 30 18:32:00 2003
@@ -17,10 +17,6 @@
 
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
+++ edited/include/asm-ppc/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-ppc64/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-s390/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-sh/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-sparc/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-sparc64/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-um/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-v850/param.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/asm-x86_64/param.h	Tue Sep 30 18:32:00 2003
@@ -13,10 +13,6 @@
 
 #define EXEC_PAGESIZE	4096
 
-#ifndef NGROUPS
-#define NGROUPS		32
-#endif
-
 #ifndef NOGROUP
 #define NOGROUP		(-1)
 #endif
===== include/linux/init_task.h 1.27 vs edited =====
--- 1.27/include/linux/init_task.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/init_task.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/linux/limits.h	Tue Sep 30 18:32:00 2003
@@ -3,7 +3,6 @@
 
 #define NR_OPEN	        1024
 
-#define NGROUPS_MAX       32	/* supplemental group IDs are available */
 #define ARG_MAX       131072	/* # bytes of args + environ for exec() */
 #define CHILD_MAX        999    /* no limit :-) */
 #define OPEN_MAX         256	/* # open files a process may have */
===== include/linux/sched.h 1.167 vs edited =====
--- 1.167/include/linux/sched.h	Sun Sep 21 14:50:04 2003
+++ edited/include/linux/sched.h	Wed Oct  1 13:57:23 2003
@@ -328,6 +328,32 @@
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
+#define NGROUPS_SMALL		32
+#define NGROUPS_BLOCK		((int)(EXEC_PAGESIZE / sizeof(gid_t)))
+struct group_info {
+	int ngroups;
+	atomic_t usage;
+	gid_t small_block[NGROUPS_SMALL];
+	int nblocks;
+	gid_t *blocks[0];
+};
+
+#define get_group_info(info) do { \
+	atomic_inc(&(info)->usage); \
+} while (0);
+
+#define put_group_info(info) do { \
+	if (atomic_dec_and_test(&(info)->usage)) \
+		groups_free(info); \
+} while (0)
+
+struct group_info *groups_alloc(int gidsetsize);
+void groups_free(struct group_info *info);
+int set_current_groups(struct group_info *info);
+/* access the groups "array" with this macro */
+#define GROUP_AT(gi, i) ((gi)->blocks[(i)/NGROUPS_BLOCK][(i)%NGROUPS_BLOCK])
+
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -402,8 +428,7 @@
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
+++ edited/include/linux/security.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/linux/sunrpc/auth.h	Tue Sep 30 18:32:00 2003
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
+++ edited/include/linux/sunrpc/svcauth.h	Tue Sep 30 18:32:00 2003
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
===== kernel/fork.c 1.142 vs edited =====
--- 1.142/kernel/fork.c	Mon Sep 22 12:32:04 2003
+++ edited/kernel/fork.c	Wed Oct  1 11:22:59 2003
@@ -85,6 +85,7 @@
 
 	security_task_free(tsk);
 	free_uid(tsk->user);
+	put_group_info(tsk->group_info);
 	free_task(tsk);
 }
 
@@ -817,6 +818,7 @@
 
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
+	get_group_info(p->group_info);
 
 	/*
 	 * If multiple threads are within copy_process(), then this check
@@ -1061,6 +1063,7 @@
 bad_fork_cleanup_put_domain:
 	module_put(p->thread_info->exec_domain->module);
 bad_fork_cleanup_count:
+	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
 bad_fork_free:
===== kernel/sys.c 1.61 vs edited =====
--- 1.61/kernel/sys.c	Mon Sep 22 13:49:26 2003
+++ edited/kernel/sys.c	Wed Oct  1 13:59:35 2003
@@ -1072,9 +1072,160 @@
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
+	struct group_info *info;
+	int nblocks;
+
+	nblocks = (gidsetsize/NGROUPS_BLOCK) + (gidsetsize%NGROUPS_BLOCK?1:0);
+	info = kmalloc(sizeof(*info) + nblocks*sizeof(gid_t *), GFP_USER);
+	if (!info)
+		return NULL;
+	info->ngroups = gidsetsize;
+	info->nblocks = nblocks;
+	atomic_set(&info->usage, 1);
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
 {
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
+{
+	int i;
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
 	int i;
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
+			gid_t tmp = GROUP_AT(info, base + stride);
+			while (left >= 0 && tmp < GROUP_AT(info, left)) {
+				GROUP_AT(info,left)=GROUP_AT(info,left+stride);
+				left -= stride;
+			}
+			GROUP_AT(info, left + stride) = tmp;
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
+		int cmp = grp - GROUP_AT(info, mid);
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
+int set_current_groups(struct group_info *info)
+{
+	int retval;
+	struct group_info *old_info;
+
+	retval = security_task_setgroups(info);
+	if (retval)
+		return retval;
+
+	groups_sort(info);
+	old_info = current->group_info;
+	current->group_info = info;
+	put_group_info(old_info);
+
+	return 0;
+}
+
+asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
+{
+	int i = 0;
 	
 	/*
 	 *	SMP: Nobody else can change our grouplist. Thus we are
@@ -1083,54 +1234,43 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
+		if (groups_to_user(grouplist, current->group_info))
 			return -EFAULT;
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
+
+	new_info = groups_alloc(gidsetsize);
+	if (!new_info)
+		return -ENOMEM;
+	retval = groups_from_user(new_info, grouplist);
+	if (retval) {
+		groups_free(new_info);
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
-}
+	}
 
-static int supplemental_group_member(gid_t grp)
-{
-	int i = current->ngroups;
+	retval = set_current_groups(new_info);
+	if (retval)
+		groups_free(new_info);
 
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
@@ -1140,7 +1280,7 @@
 {
 	int retval = 1;
 	if (grp != current->fsgid)
-		retval = supplemental_group_member(grp);
+		retval = groups_search(current->group_info, grp);
 	return retval;
 }
 
@@ -1148,7 +1288,7 @@
 {
 	int retval = 1;
 	if (grp != current->egid)
-		retval = supplemental_group_member(grp);
+		retval = groups_search(current->group_info, grp);
 	return retval;
 }
 
===== kernel/uid16.c 1.5 vs edited =====
--- 1.5/kernel/uid16.c	Wed Apr  9 20:51:27 2003
+++ edited/kernel/uid16.c	Wed Oct  1 13:59:45 2003
@@ -107,20 +107,57 @@
 	return sys_setfsgid((gid_t)gid);
 }
 
+static int groups16_to_user(old_gid_t __user *grouplist,
+    struct group_info *info)
+{
+	int i;
+	old_gid_t group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		group = (old_gid_t)GROUP_AT(info, i);
+		if (__put_user(group, grouplist+i))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int groups16_from_user(struct group_info *info,
+    old_gid_t __user *grouplist)
+{
+	int i;
+	old_gid_t group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(grouplist, info->ngroups*sizeof(group)))
+		return -EFAULT;
+
+	for (i = 0; i < info->ngroups; i++) {
+		if (__get_user(group, grouplist+i))
+			return  -EFAULT;
+		GROUP_AT(info, i) = (gid_t)group;
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
+	i = current->group_info->ngroups;
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+		if (groups16_to_user(grouplist, current->group_info))
 			return -EFAULT;
 	}
 	return i;
@@ -128,24 +165,25 @@
 
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
+	retval = set_current_groups(new_info);
+	if (retval)
+		groups_free(new_info);
+
+	return retval;
 }
 
 asmlinkage long sys_getuid16(void)
===== net/sunrpc/auth.c 1.12 vs edited =====
--- 1.12/net/sunrpc/auth.c	Wed Jun 11 19:22:40 2003
+++ edited/net/sunrpc/auth.c	Tue Sep 30 18:32:00 2003
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
+++ edited/net/sunrpc/auth_unix.c	Wed Oct  1 13:59:50 2003
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
+++ edited/net/sunrpc/svcauth_unix.c	Tue Sep 30 18:32:00 2003
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
+++ edited/security/dummy.c	Tue Sep 30 18:32:00 2003
@@ -530,7 +530,7 @@
 	return 0;
 }
 
-static int dummy_task_setgroups (int gidsetsize, gid_t * grouplist)
+static int dummy_task_setgroups (struct group_info *group_info)
 {
 	return 0;
 }

--jI8keyz6grp/JLjh--
