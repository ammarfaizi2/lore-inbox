Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTJBCZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTJBCZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:25:54 -0400
Received: from dp.samba.org ([66.70.73.150]:9178 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263171AbTJBCZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:25:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, braam@clusterfs.com,
       Tim Hockin <thockin@hockin.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, schwidefsky@de.ibm.com, davidm@hpl.hp.com
Subject: Re: [PATCH] Many groups patch. 
In-reply-to: Your message of "Wed, 01 Oct 2003 12:22:03 MST."
             <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org> 
Date: Thu, 02 Oct 2003 12:09:19 +1000
Message-Id: <20031002022545.6FB7A2C0EA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org> you write:
> 
> On Wed, 1 Oct 2003, Tim Hockin wrote:
> > 
> > This patch touches all the compat code in the 64-bit architectures.
> > These files have a LOT of duplicated code from uid16.c.  I did not try to
> > reduce duplicated code, and instead followed suit.
> 
> Augh. It also makes code even uglier than it used to be:

Sure.  First step is to put this function in kernel/compat.c where it
belongs.  The identical function is already in kernel/uid16.c, but
defining CONFIG_UID16 does not work for these platforms (which only
want 16-bit uids for the 32-bit syscalls).

I discussed this with DaveM and David Mosberger last week.

Naturally, untested (damn obscure archs!), but ideally this changes
nothing, just makes a groups patch simpler.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Put 16-bit GID code in kernel/compat.c
Author: Rusty Russell
Status: Trivial

D: IA64, S390 and Sparc64 need 16-bit setgroups and getgroups calls,
D: but can't define CONFIG_UID16 since they only want 16-bit gid/uid
D: compatibility for 32-bit system calls.  Centralize their versions
D: of setgroups16 and getgroups16 into kernel/compat.c, under a
D: NEED_COMPAT_GROUPS16 define.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/ia64/ia32/ia32_entry.S .4448-linux-2.6.0-test6-bk3.updated/arch/ia64/ia32/ia32_entry.S
--- .4448-linux-2.6.0-test6-bk3/arch/ia64/ia32/ia32_entry.S	2003-09-22 10:26:21.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/ia64/ia32/ia32_entry.S	2003-10-02 12:00:03.000000000 +1000
@@ -266,8 +266,8 @@ ia32_syscall_table:
 	data8 compat_sys_getrusage
 	data8 sys32_gettimeofday
 	data8 sys32_settimeofday
-	data8 sys32_getgroups16	  /* 80 */
-	data8 sys32_setgroups16
+	data8 compat_getgroups16  /* 80 */
+	data8 compat_setgroups16
 	data8 sys32_old_select
 	data8 sys_symlink
 	data8 sys32_ni_syscall
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/ia64/ia32/sys_ia32.c .4448-linux-2.6.0-test6-bk3.updated/arch/ia64/ia32/sys_ia32.c
--- .4448-linux-2.6.0-test6-bk3/arch/ia64/ia32/sys_ia32.c	2003-09-29 10:25:17.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/ia64/ia32/sys_ia32.c	2003-10-02 11:56:42.000000000 +1000
@@ -2426,46 +2426,6 @@ sys32_lseek (unsigned int fd, int offset
 	return sys_lseek(fd, offset, whence);
 }
 
-extern asmlinkage long sys_getgroups (int gidsetsize, gid_t *grouplist);
-
-asmlinkage long
-sys32_getgroups16 (int gidsetsize, short *grouplist)
-{
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
-
-extern asmlinkage long sys_setgroups (int gidsetsize, gid_t *grouplist);
-
-asmlinkage long
-sys32_setgroups16 (int gidsetsize, short *grouplist)
-{
-	mm_segment_t old_fs = get_fs();
-	gid_t gl[NGROUPS];
-	int ret, i;
-
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	for (i = 0; i < gidsetsize; i++, grouplist++)
-		if (get_user(gl[i], grouplist))
-			return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_setgroups(gidsetsize, gl);
-	set_fs(old_fs);
-	return ret;
-}
-
 asmlinkage long
 sys32_truncate64 (unsigned int path, unsigned int len_lo, unsigned int len_hi)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/s390/kernel/compat_linux.c .4448-linux-2.6.0-test6-bk3.updated/arch/s390/kernel/compat_linux.c
--- .4448-linux-2.6.0-test6-bk3/arch/s390/kernel/compat_linux.c	2003-09-29 10:25:21.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/s390/kernel/compat_linux.c	2003-10-02 12:04:34.000000000 +1000
@@ -189,42 +189,6 @@ asmlinkage long sys32_setfsgid16(u16 gid
 	return sys_setfsgid((gid_t)gid);
 }
 
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
-{
-	u16 groups[NGROUPS];
-	int i,j;
-
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
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
-{
-	u16 groups[NGROUPS];
-	int i;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
-}
-
 asmlinkage long sys32_getuid16(void)
 {
 	return high2lowuid(current->uid);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/s390/kernel/compat_wrapper.S .4448-linux-2.6.0-test6-bk3.updated/arch/s390/kernel/compat_wrapper.S
--- .4448-linux-2.6.0-test6-bk3/arch/s390/kernel/compat_wrapper.S	2003-09-22 10:08:17.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/s390/kernel/compat_wrapper.S	2003-10-02 12:04:48.000000000 +1000
@@ -344,13 +344,13 @@ sys32_settimeofday_wrapper:
 sys32_getgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_getgroups16	# branch to system call
+	jg	compat_getgroups16	# branch to system call
 
 	.globl  sys32_setgroups16_wrapper 
 sys32_setgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_setgroups16	# branch to system call
+	jg	compat_setgroups16	# branch to system call
 
 	.globl  sys32_symlink_wrapper 
 sys32_symlink_wrapper:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/sparc64/kernel/sys_sparc32.c .4448-linux-2.6.0-test6-bk3.updated/arch/sparc64/kernel/sys_sparc32.c
--- .4448-linux-2.6.0-test6-bk3/arch/sparc64/kernel/sys_sparc32.c	2003-09-29 10:25:22.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/sparc64/kernel/sys_sparc32.c	2003-10-02 12:03:54.000000000 +1000
@@ -206,42 +206,6 @@ asmlinkage long sys32_setfsgid16(u16 gid
 	return sys_setfsgid((gid_t)gid);
 }
 
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
-{
-	u16 groups[NGROUPS];
-	int i,j;
-
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
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
-{
-	u16 groups[NGROUPS];
-	int i;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned) gidsetsize > NGROUPS)
-		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
-		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
-}
-
 asmlinkage long sys32_getuid16(void)
 {
 	return high2lowuid(current->uid);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/arch/sparc64/kernel/systbls.S .4448-linux-2.6.0-test6-bk3.updated/arch/sparc64/kernel/systbls.S
--- .4448-linux-2.6.0-test6-bk3/arch/sparc64/kernel/systbls.S	2003-09-22 10:27:56.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/arch/sparc64/kernel/systbls.S	2003-10-02 12:03:40.000000000 +1000
@@ -34,8 +34,8 @@ sys_call_table32:
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys32_mmap, sys_setreuid, sys_munmap, sys_mprotect
-	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
-/*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
+	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, compat_getgroups16
+/*80*/	.word compat_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
@@ -168,8 +168,8 @@ sunos_sys_table:
 	.word sunos_nosys, sunos_sbrk, sunos_sstk
 	.word sunos_mmap, sunos_vadvise, sys_munmap
 	.word sys_mprotect, sys_madvise, sys_vhangup
-	.word sunos_nosys, sys_mincore, sys32_getgroups16
-	.word sys32_setgroups16, sys_getpgrp, sunos_setpgrp
+	.word sunos_nosys, sys_mincore, compat_getgroups16
+	.word compat_setgroups16, sys_getpgrp, sunos_setpgrp
 	.word compat_sys_setitimer, sunos_nosys, sys_swapon
 	.word compat_sys_getitimer, sys_gethostname, sys_sethostname
 	.word sunos_getdtablesize, sys_dup2, sunos_nop
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/include/asm-ia64/compat.h .4448-linux-2.6.0-test6-bk3.updated/include/asm-ia64/compat.h
--- .4448-linux-2.6.0-test6-bk3/include/asm-ia64/compat.h	2003-09-22 10:26:44.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/include/asm-ia64/compat.h	2003-10-02 11:58:13.000000000 +1000
@@ -136,4 +136,6 @@ compat_alloc_user_space (long len)
 	return (void *) (((regs->r12 & 0xffffffff) & -16) - len);
 }
 
+#define NEED_COMPAT_GROUPS16
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/include/asm-s390/compat.h .4448-linux-2.6.0-test6-bk3.updated/include/asm-s390/compat.h
--- .4448-linux-2.6.0-test6-bk3/include/asm-s390/compat.h	2003-09-22 10:22:59.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/include/asm-s390/compat.h	2003-10-02 12:06:26.000000000 +1000
@@ -134,4 +134,6 @@ static inline void *compat_alloc_user_sp
 	return (void *) (stack - len);
 }
 
+#define NEED_COMPAT_GROUPS16
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/include/asm-sparc64/compat.h .4448-linux-2.6.0-test6-bk3.updated/include/asm-sparc64/compat.h
--- .4448-linux-2.6.0-test6-bk3/include/asm-sparc64/compat.h	2003-09-22 10:23:00.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/include/asm-sparc64/compat.h	2003-10-02 12:04:23.000000000 +1000
@@ -132,4 +132,5 @@ static __inline__ void *compat_alloc_use
 	return (void *) (usp - len);
 }
 
+#define NEED_COMPAT_GROUPS16
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/include/linux/compat.h .4448-linux-2.6.0-test6-bk3.updated/include/linux/compat.h
--- .4448-linux-2.6.0-test6-bk3/include/linux/compat.h	2003-09-22 10:27:37.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/include/linux/compat.h	2003-10-02 11:59:39.000000000 +1000
@@ -90,5 +90,10 @@ struct compat_statfs64 {
 	__u32 f_spare[5];
 };
 
+#ifdef NEED_COMPAT_GROUPS16
+asmlinkage long compat_getgroups16(int gidsetsize, short *grouplist);
+asmlinkage long compat_setgroups16(int gidsetsize, short *grouplist);
+#endif /* NEED_COMPAT_GROUPS16 */
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4448-linux-2.6.0-test6-bk3/kernel/compat.c .4448-linux-2.6.0-test6-bk3.updated/kernel/compat.c
--- .4448-linux-2.6.0-test6-bk3/kernel/compat.c	2003-09-22 10:28:13.000000000 +1000
+++ .4448-linux-2.6.0-test6-bk3.updated/kernel/compat.c	2003-10-02 11:58:00.000000000 +1000
@@ -563,3 +563,44 @@ long compat_clock_nanosleep(clockid_t wh
 
 /* timer_create is architecture specific because it needs sigevent conversion */
 
+#ifdef NEED_COMPAT_GROUPS16
+extern asmlinkage long sys_getgroups(int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+compat_getgroups16(int gidsetsize, short *grouplist)
+{
+	mm_segment_t old_fs = get_fs();
+	gid_t gl[NGROUPS];
+	int ret, i;
+
+	set_fs(KERNEL_DS);
+	ret = sys_getgroups(gidsetsize, gl);
+	set_fs(old_fs);
+
+	if (gidsetsize && ret > 0 && ret <= NGROUPS)
+		for (i = 0; i < ret; i++, grouplist++)
+			if (put_user(gl[i], grouplist))
+				return -EFAULT;
+	return ret;
+}
+
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+
+asmlinkage long
+compat_setgroups16(int gidsetsize, short *grouplist)
+{
+	mm_segment_t old_fs = get_fs();
+	gid_t gl[NGROUPS];
+	int ret, i;
+
+	if ((unsigned) gidsetsize > NGROUPS)
+		return -EINVAL;
+	for (i = 0; i < gidsetsize; i++, grouplist++)
+		if (get_user(gl[i], grouplist))
+			return -EFAULT;
+	set_fs(KERNEL_DS);
+	ret = sys_setgroups(gidsetsize, gl);
+	set_fs(old_fs);
+	return ret;
+}
+#endif /* NEED_COMPAT_GROUPS16 */
