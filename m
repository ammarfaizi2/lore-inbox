Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUA1Dbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUA1Dbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:31:43 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:9647 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S265835AbUA1Daq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:30:46 -0500
Date: Tue, 27 Jan 2004 19:30:30 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, torvalds@osdl.org
Subject: PATCH: uid16 cleanup for 64 bit architectures
Message-ID: <20040128033030.GG9155@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The NGROUPS patch exposed me to a lot of duplicated code in some of the 64
bit architectures (stemming from CONFIG_UID16).

So a few months back, I worked up a solution.  It seems that things have
changed some.  Architectures that used to not define CONFIG_UID16 (sparc64,
s390, x86_64) now do.  But they don't take advantage of the uid16.c code.

This (totally experimental, untestable by me) patch removes the offending
code.  In short:

* pry apart highuid.h and uid16.c
* build uid16.o iff CONFIG_UID16_SYSCALLS
* anywhere that defines CONFIG_UID16 adds CONFIG_UID16_SYSCALLS
* add CONFIG_UID16_SYSCALLS for any arch that wants to use uid16.c without
  converting everywhere else highuid.h is used
* strip out lots of code that was copied from uid16.c

This may all be totally worthless.  That's up to the arch people to decide,
I guess.  I just said I would look into the mess. :)

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uid16-2.6.2rc2-1.diff"

diff -ruN ngroups-2.6/arch/arm/Kconfig uid16-2.6/arch/arm/Kconfig
--- ngroups-2.6/arch/arm/Kconfig	2003-12-19 14:29:51.000000000 -0800
+++ uid16-2.6/arch/arm/Kconfig	2004-01-27 15:38:53.000000000 -0800
@@ -50,6 +50,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/arm26/Kconfig uid16-2.6/arch/arm26/Kconfig
--- ngroups-2.6/arch/arm26/Kconfig	2003-12-19 14:29:54.000000000 -0800
+++ uid16-2.6/arch/arm26/Kconfig	2004-01-27 15:39:00.000000000 -0800
@@ -38,6 +38,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/cris/Kconfig uid16-2.6/arch/cris/Kconfig
--- ngroups-2.6/arch/cris/Kconfig	2003-12-19 14:29:54.000000000 -0800
+++ uid16-2.6/arch/cris/Kconfig	2004-01-27 15:39:07.000000000 -0800
@@ -13,6 +13,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/h8300/Kconfig uid16-2.6/arch/h8300/Kconfig
--- ngroups-2.6/arch/h8300/Kconfig	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/h8300/Kconfig	2004-01-27 15:39:14.000000000 -0800
@@ -25,6 +25,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/i386/Kconfig uid16-2.6/arch/i386/Kconfig
--- ngroups-2.6/arch/i386/Kconfig	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/i386/Kconfig	2004-01-27 15:35:35.000000000 -0800
@@ -25,6 +25,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -ruN ngroups-2.6/arch/ia64/ia32/ia32_entry.S uid16-2.6/arch/ia64/ia32/ia32_entry.S
--- ngroups-2.6/arch/ia64/ia32/ia32_entry.S	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/ia64/ia32/ia32_entry.S	2004-01-27 17:03:18.000000000 -0800
@@ -288,8 +288,8 @@
 	data8 compat_sys_getrusage
 	data8 sys32_gettimeofday
 	data8 sys32_settimeofday
-	data8 sys32_getgroups16	  /* 80 */
-	data8 sys32_setgroups16
+	data8 sys_getgroups16	  /* 80 */
+	data8 sys_setgroups16
 	data8 sys32_old_select
 	data8 sys_symlink
 	data8 sys_ni_syscall
diff -ruN ngroups-2.6/arch/ia64/ia32/sys_ia32.c uid16-2.6/arch/ia64/ia32/sys_ia32.c
--- ngroups-2.6/arch/ia64/ia32/sys_ia32.c	2004-01-27 12:40:02.000000000 -0800
+++ uid16-2.6/arch/ia64/ia32/sys_ia32.c	2004-01-27 17:01:57.000000000 -0800
@@ -2413,87 +2413,6 @@
 	return sys_lseek(fd, offset, whence);
 }
 
-static int
-groups16_to_user(short *grouplist, struct group_info *info)
-{
-	int i;
-	short group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		group = (short)GROUP_AT(info, i);
-		if (__put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int
-groups16_from_user(struct group_info *info, short *grouplist)
-{
-	int i;
-	short group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-	if (!access_ok(VERIFY_READ, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		if (__get_user(group, grouplist+i))
-			return  -EFAULT;
-		GROUP_AT(info, i) = (gid_t)group;
-	}
-
-	return 0;
-}
-
-asmlinkage long
-sys32_getgroups16 (int gidsetsize, short *grouplist)
-{
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-	i = current->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		if (groups16_to_user(grouplist, current->group_info))
-			return -EFAULT;
-	}
-	return i;
-}
-
-asmlinkage long
-sys32_setgroups16 (int gidsetsize, short *grouplist)
-{
-	struct group_info *new_info;
-	int retval;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	new_info = groups_alloc(gidsetsize);
-	if (!new_info)
-		return -ENOMEM;
-	retval = groups16_from_user(new_info, grouplist);
-	if (retval) {
-		groups_free(new_info);
-		return retval;
-	}
-
-	retval = set_current_groups(new_info);
-	if (retval)
-		groups_free(new_info);
-
-	return retval;
-}
-
 asmlinkage long
 sys32_truncate64 (unsigned int path, unsigned int len_lo, unsigned int len_hi)
 {
diff -ruN ngroups-2.6/arch/ia64/Kconfig uid16-2.6/arch/ia64/Kconfig
--- ngroups-2.6/arch/ia64/Kconfig	2004-01-27 12:38:53.000000000 -0800
+++ uid16-2.6/arch/ia64/Kconfig	2004-01-27 16:32:17.000000000 -0800
@@ -385,6 +385,11 @@
 	depends on IA32_SUPPORT
 	default y
 
+config UID16_SYSCALLS
+	bool
+	depends on IA32_SUPPORT
+	default y
+
 config PERFMON
 	bool "Performance monitor support"
 	help
diff -ruN ngroups-2.6/arch/m68k/Kconfig uid16-2.6/arch/m68k/Kconfig
--- ngroups-2.6/arch/m68k/Kconfig	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/m68k/Kconfig	2004-01-27 15:39:28.000000000 -0800
@@ -14,6 +14,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/m68knommu/Kconfig uid16-2.6/arch/m68knommu/Kconfig
--- ngroups-2.6/arch/m68knommu/Kconfig	2003-12-19 14:29:57.000000000 -0800
+++ uid16-2.6/arch/m68knommu/Kconfig	2004-01-27 15:39:32.000000000 -0800
@@ -17,6 +17,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/s390/Kconfig uid16-2.6/arch/s390/Kconfig
--- ngroups-2.6/arch/s390/Kconfig	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/s390/Kconfig	2004-01-27 17:38:55.000000000 -0800
@@ -28,6 +28,11 @@
 	default y
 	depends on ARCH_S390X = 'n'
 
+config UID16_SYSCALLS
+	bool
+	default y
+	depends on ARCH_S390X = 'n'
+
 source "init/Kconfig"
 
 menu "Base setup"
diff -ruN ngroups-2.6/arch/s390/kernel/compat_linux.c uid16-2.6/arch/s390/kernel/compat_linux.c
--- ngroups-2.6/arch/s390/kernel/compat_linux.c	2004-01-27 12:40:02.000000000 -0800
+++ uid16-2.6/arch/s390/kernel/compat_linux.c	2004-01-27 17:42:18.000000000 -0800
@@ -71,221 +71,17 @@
 
 #include "compat_linux.h"
 
-extern asmlinkage long sys_chown(const char *, uid_t,gid_t);
-extern asmlinkage long sys_lchown(const char *, uid_t,gid_t);
-extern asmlinkage long sys_fchown(unsigned int, uid_t,gid_t);
-extern asmlinkage long sys_setregid(gid_t, gid_t);
-extern asmlinkage long sys_setgid(gid_t);
-extern asmlinkage long sys_setreuid(uid_t, uid_t);
-extern asmlinkage long sys_setuid(uid_t);
-extern asmlinkage long sys_setresuid(uid_t, uid_t, uid_t);
-extern asmlinkage long sys_setresgid(gid_t, gid_t, gid_t);
-extern asmlinkage long sys_setfsuid(uid_t);
-extern asmlinkage long sys_setfsgid(gid_t);
- 
 /* For this source file, we want overflow handling. */
 
 #undef high2lowuid
 #undef high2lowgid
 #undef low2highuid
 #undef low2highgid
-#undef SET_UID16
-#undef SET_GID16
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#undef SET_OLDSTAT_UID
-#undef SET_OLDSTAT_GID
-#undef SET_STAT_UID
-#undef SET_STAT_GID
 
 #define high2lowuid(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
 #define high2lowgid(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid)
 #define low2highuid(uid) ((uid) == (u16)-1) ? (uid_t)-1 : (uid_t)(uid)
 #define low2highgid(gid) ((gid) == (u16)-1) ? (gid_t)-1 : (gid_t)(gid)
-#define SET_UID16(var, uid)	var = high2lowuid(uid)
-#define SET_GID16(var, gid)	var = high2lowgid(gid)
-#define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
-#define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = high2lowgid(gid)
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
-
-asmlinkage long sys32_chown16(const char * filename, u16 user, u16 group)
-{
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_lchown16(const char * filename, u16 user, u16 group)
-{
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_fchown16(unsigned int fd, u16 user, u16 group)
-{
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_setregid16(u16 rgid, u16 egid)
-{
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
-}
-
-asmlinkage long sys32_setgid16(u16 gid)
-{
-	return sys_setgid((gid_t)gid);
-}
-
-asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
-{
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
-}
-
-asmlinkage long sys32_setuid16(u16 uid)
-{
-	return sys_setuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setresuid16(u16 ruid, u16 euid, u16 suid)
-{
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-		low2highuid(suid));
-}
-
-asmlinkage long sys32_getresuid16(u16 *ruid, u16 *euid, u16 *suid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowuid(current->uid), ruid)) &&
-	    !(retval = put_user(high2lowuid(current->euid), euid)))
-		retval = put_user(high2lowuid(current->suid), suid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setresgid16(u16 rgid, u16 egid, u16 sgid)
-{
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-		low2highgid(sgid));
-}
-
-asmlinkage long sys32_getresgid16(u16 *rgid, u16 *egid, u16 *sgid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowgid(current->gid), rgid)) &&
-	    !(retval = put_user(high2lowgid(current->egid), egid)))
-		retval = put_user(high2lowgid(current->sgid), sgid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setfsuid16(u16 uid)
-{
-	return sys_setfsuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setfsgid16(u16 gid)
-{
-	return sys_setfsgid((gid_t)gid);
-}
-
-static int groups16_to_user(u16 *grouplist, struct group_info *info)
-{
-	int i;
-	u16 group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		group = (u16)GROUP_AT(info, i);
-		if (__put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *info, u16 *grouplist)
-{
-	int i;
-	u16 group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-	if (!access_ok(VERIFY_READ, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		if (__get_user(group, grouplist+i))
-			return  -EFAULT;
-		GROUP_AT(info, i) = (gid_t)group;
-	}
-
-	return 0;
-}
-
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
-{
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-	i = current->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		if (groups16_to_user(grouplist, current->group_info))
-			return -EFAULT;
-	}
-	return i;
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
-{
-	struct group_info *new_info;
-	int retval;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	new_info = groups_alloc(gidsetsize);
-	if (!new_info)
-		return -ENOMEM;
-	retval = groups16_from_user(new_info, grouplist);
-	if (retval) {
-		groups_free(new_info);
-		return retval;
-	}
-
-	retval = set_current_groups(new_info);
-	if (retval)
-		groups_free(new_info);
-
-	return retval;
-}
-
-asmlinkage long sys32_getuid16(void)
-{
-	return high2lowuid(current->uid);
-}
-
-asmlinkage long sys32_geteuid16(void)
-{
-	return high2lowuid(current->euid);
-}
-
-asmlinkage long sys32_getgid16(void)
-{
-	return high2lowgid(current->gid);
-}
-
-asmlinkage long sys32_getegid16(void)
-{
-	return high2lowgid(current->egid);
-}
 
 /* 32-bit timeval and related flotsam.  */
 
diff -ruN ngroups-2.6/arch/s390/kernel/compat_wrapper.S uid16-2.6/arch/s390/kernel/compat_wrapper.S
--- ngroups-2.6/arch/s390/kernel/compat_wrapper.S	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/s390/kernel/compat_wrapper.S	2004-01-27 17:47:40.000000000 -0800
@@ -84,7 +84,7 @@
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t 
-	jg	sys32_lchown16		# branch to system call
+	jg	sys_lchown16		# branch to system call
 
 	.globl  sys32_lseek_wrapper 
 sys32_lseek_wrapper:
@@ -112,7 +112,7 @@
 	.globl  sys32_setuid16_wrapper 
 sys32_setuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
-	jg	sys32_setuid16		# branch to system call
+	jg	sys_setuid16		# branch to system call
 
 #sys32_getuid16_wrapper			# void 
 
@@ -196,7 +196,7 @@
 	.globl  sys32_setgid16_wrapper 
 sys32_setgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
-	jg	sys32_setgid16		# branch to system call
+	jg	sys_setgid16		# branch to system call
 
 #sys32_getgid16_wrapper			# void 
 
@@ -279,13 +279,13 @@
 sys32_setreuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
-	jg	sys32_setreuid16	# branch to system call
+	jg	sys_setreuid16		# branch to system call
 
 	.globl  sys32_setregid16_wrapper 
 sys32_setregid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t 
-	jg	sys32_setregid16	# branch to system call
+	jg	sys_setregid16		# branch to system call
 
 #sys32_sigsuspend_wrapper		# done in sigsuspend_glue 
 
@@ -345,13 +345,13 @@
 sys32_getgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_getgroups16	# branch to system call
+	jg	sys_getgroups16		# branch to system call
 
 	.globl  sys32_setgroups16_wrapper 
 sys32_setgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_setgroups16	# branch to system call
+	jg	sys_setgroups16		# branch to system call
 
 	.globl  sys32_symlink_wrapper 
 sys32_symlink_wrapper:
@@ -426,7 +426,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_fchown16		# branch to system call
+	jg	sys_fchown16		# branch to system call
 
 	.globl  sys32_getpriority_wrapper 
 sys32_getpriority_wrapper:
@@ -615,12 +615,12 @@
 	.globl  sys32_setfsuid16_wrapper 
 sys32_setfsuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
-	jg	sys32_setfsuid16	# branch to system call
+	jg	sys_setfsuid16		# branch to system call
 
 	.globl  sys32_setfsgid16_wrapper 
 sys32_setfsgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
-	jg	sys32_setfsgid16	# branch to system call
+	jg	sys_setfsgid16		# branch to system call
 
 	.globl  sys32_llseek_wrapper 
 sys32_llseek_wrapper:
@@ -767,14 +767,14 @@
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t 
-	jg	sys32_setresuid16	# branch to system call
+	jg	sys_setresuid16		# branch to system call
 
 	.globl  sys32_getresuid16_wrapper 
 sys32_getresuid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_uid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_uid_emu31_t *
-	jg	sys32_getresuid16	# branch to system call
+	jg	sys_getresuid16		# branch to system call
 
 	.globl  sys32_poll_wrapper 
 sys32_poll_wrapper:
@@ -795,14 +795,14 @@
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_setresgid16	# branch to system call
+	jg	sys_setresgid16		# branch to system call
 
 	.globl  sys32_getresgid16_wrapper 
 sys32_getresgid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_gid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_getresgid16	# branch to system call
+	jg	sys_getresgid16		# branch to system call
 
 	.globl  sys32_prctl_wrapper 
 sys32_prctl_wrapper:
@@ -876,7 +876,7 @@
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_chown16		# branch to system call
+	jg	sys_chown16		# branch to system call
 
 	.globl  sys32_getcwd_wrapper 
 sys32_getcwd_wrapper:
diff -ruN ngroups-2.6/arch/s390/kernel/syscalls.S uid16-2.6/arch/s390/kernel/syscalls.S
--- ngroups-2.6/arch/s390/kernel/syscalls.S	2004-01-26 09:19:00.000000000 -0800
+++ uid16-2.6/arch/s390/kernel/syscalls.S	2004-01-27 17:50:21.000000000 -0800
@@ -32,7 +32,7 @@
 SYSCALL(sys_mount,sys_mount,sys32_mount_wrapper)
 SYSCALL(sys_oldumount,sys_oldumount,sys32_oldumount_wrapper)
 SYSCALL(sys_setuid16,sys_ni_syscall,sys32_setuid16_wrapper)	/* old setuid16 syscall*/
-SYSCALL(sys_getuid16,sys_ni_syscall,sys32_getuid16)		/* old getuid16 syscall*/
+SYSCALL(sys_getuid16,sys_ni_syscall,sys_getuid16)		/* old getuid16 syscall*/
 SYSCALL(sys_stime,sys_ni_syscall,sys32_stime_wrapper)		/* 25 old stime syscall */
 SYSCALL(sys_ptrace,sys_ptrace,sys32_ptrace_wrapper)
 SYSCALL(sys_alarm,sys_alarm,sys32_alarm_wrapper)
@@ -54,11 +54,11 @@
 SYSCALL(sys_times,sys_times,compat_sys_times_wrapper)
 NI_SYSCALL							/* old prof syscall */
 SYSCALL(sys_brk,sys_brk,sys32_brk_wrapper)			/* 45 */
-SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16)		/* old setgid16 syscall*/
-SYSCALL(sys_getgid16,sys_ni_syscall,sys32_getgid16)		/* old getgid16 syscall*/
+SYSCALL(sys_setgid16,sys_ni_syscall,sys_setgid16)		/* old setgid16 syscall*/
+SYSCALL(sys_getgid16,sys_ni_syscall,sys_getgid16)		/* old getgid16 syscall*/
 SYSCALL(sys_signal,sys_signal,sys32_signal_wrapper)
-SYSCALL(sys_geteuid16,sys_ni_syscall,sys32_geteuid16)		/* old geteuid16 syscall */
-SYSCALL(sys_getegid16,sys_ni_syscall,sys32_getegid16)		/* 50 old getegid16 syscall */
+SYSCALL(sys_geteuid16,sys_ni_syscall,sys_geteuid16)		/* old geteuid16 syscall */
+SYSCALL(sys_getegid16,sys_ni_syscall,sys_getegid16)		/* 50 old getegid16 syscall */
 SYSCALL(sys_acct,sys_acct,sys32_acct_wrapper)
 SYSCALL(sys_umount,sys_umount,sys32_umount_wrapper)
 NI_SYSCALL							/* old lock syscall */
diff -ruN ngroups-2.6/arch/sh/Kconfig uid16-2.6/arch/sh/Kconfig
--- ngroups-2.6/arch/sh/Kconfig	2004-01-26 09:19:01.000000000 -0800
+++ uid16-2.6/arch/sh/Kconfig	2004-01-27 15:40:15.000000000 -0800
@@ -18,6 +18,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/sparc/Kconfig uid16-2.6/arch/sparc/Kconfig
--- ngroups-2.6/arch/sparc/Kconfig	2004-01-26 09:19:01.000000000 -0800
+++ uid16-2.6/arch/sparc/Kconfig	2004-01-27 15:40:30.000000000 -0800
@@ -13,6 +13,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config HIGHMEM
 	bool
 	default y
diff -ruN ngroups-2.6/arch/sparc64/Kconfig uid16-2.6/arch/sparc64/Kconfig
--- ngroups-2.6/arch/sparc64/Kconfig	2004-01-26 09:19:01.000000000 -0800
+++ uid16-2.6/arch/sparc64/Kconfig	2004-01-27 17:13:53.000000000 -0800
@@ -381,6 +381,11 @@
 	depends on SPARC32_COMPAT
 	default y
 
+config UID16_SYSCALLS
+	bool
+	depends on SPARC32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
diff -ruN ngroups-2.6/arch/sparc64/kernel/entry.S uid16-2.6/arch/sparc64/kernel/entry.S
--- ngroups-2.6/arch/sparc64/kernel/entry.S	2003-12-19 14:30:00.000000000 -0800
+++ uid16-2.6/arch/sparc64/kernel/entry.S	2004-01-27 17:30:23.000000000 -0800
@@ -1475,9 +1475,9 @@
 	/* SunOS getuid() returns uid in %o0 and euid in %o1 */
 	.globl	sunos_getuid
 sunos_getuid:
-	call	sys32_geteuid16
+	call	sys_geteuid16
 	 nop
-	call	sys32_getuid16
+	call	sys_getuid16
 	 stx	%o0, [%sp + PTREGS_OFF + PT_V9_I1]
 	b,pt	%xcc, ret_sys_call
 	 stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
@@ -1485,9 +1485,9 @@
 	/* SunOS getgid() returns gid in %o0 and egid in %o1 */
 	.globl	sunos_getgid
 sunos_getgid:
-	call	sys32_getegid16
+	call	sys_getegid16
 	 nop
-	call	sys32_getgid16
+	call	sys_getgid16
 	 stx	%o0, [%sp + PTREGS_OFF + PT_V9_I1]
 	b,pt	%xcc, ret_sys_call
 	 stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
diff -ruN ngroups-2.6/arch/sparc64/kernel/sys_sparc32.c uid16-2.6/arch/sparc64/kernel/sys_sparc32.c
--- ngroups-2.6/arch/sparc64/kernel/sys_sparc32.c	2004-01-27 12:40:02.000000000 -0800
+++ uid16-2.6/arch/sparc64/kernel/sys_sparc32.c	2004-01-27 17:27:36.000000000 -0800
@@ -88,194 +88,6 @@
 	__ret;				\
 })
 
-extern asmlinkage long sys_chown(const char *, uid_t,gid_t);
-extern asmlinkage long sys_lchown(const char *, uid_t,gid_t);
-extern asmlinkage long sys_fchown(unsigned int, uid_t,gid_t);
-extern asmlinkage long sys_setregid(gid_t, gid_t);
-extern asmlinkage long sys_setgid(gid_t);
-extern asmlinkage long sys_setreuid(uid_t, uid_t);
-extern asmlinkage long sys_setuid(uid_t);
-extern asmlinkage long sys_setresuid(uid_t, uid_t, uid_t);
-extern asmlinkage long sys_setresgid(gid_t, gid_t, gid_t);
-extern asmlinkage long sys_setfsuid(uid_t);
-extern asmlinkage long sys_setfsgid(gid_t);
- 
-asmlinkage long sys32_chown16(const char * filename, u16 user, u16 group)
-{
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_lchown16(const char * filename, u16 user, u16 group)
-{
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_fchown16(unsigned int fd, u16 user, u16 group)
-{
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_setregid16(u16 rgid, u16 egid)
-{
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
-}
-
-asmlinkage long sys32_setgid16(u16 gid)
-{
-	return sys_setgid((gid_t)gid);
-}
-
-asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
-{
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
-}
-
-asmlinkage long sys32_setuid16(u16 uid)
-{
-	return sys_setuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setresuid16(u16 ruid, u16 euid, u16 suid)
-{
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-		low2highuid(suid));
-}
-
-asmlinkage long sys32_getresuid16(u16 *ruid, u16 *euid, u16 *suid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowuid(current->uid), ruid)) &&
-	    !(retval = put_user(high2lowuid(current->euid), euid)))
-		retval = put_user(high2lowuid(current->suid), suid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setresgid16(u16 rgid, u16 egid, u16 sgid)
-{
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-		low2highgid(sgid));
-}
-
-asmlinkage long sys32_getresgid16(u16 *rgid, u16 *egid, u16 *sgid)
-{
-	int retval;
-
-	if (!(retval = put_user(high2lowgid(current->gid), rgid)) &&
-	    !(retval = put_user(high2lowgid(current->egid), egid)))
-		retval = put_user(high2lowgid(current->sgid), sgid);
-
-	return retval;
-}
-
-asmlinkage long sys32_setfsuid16(u16 uid)
-{
-	return sys_setfsuid((uid_t)uid);
-}
-
-asmlinkage long sys32_setfsgid16(u16 gid)
-{
-	return sys_setfsgid((gid_t)gid);
-}
-
-static int groups16_to_user(u16 *grouplist, struct group_info *info)
-{
-	int i;
-	u16 group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-       if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		group = (u16)GROUP_AT(info, i);
-		if (__put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *info, u16 *grouplist)
-{
-	int i;
-	u16 group;
-
-	if (info->ngroups > TASK_SIZE/sizeof(group))
-		return -EFAULT;
-       if (!access_ok(VERIFY_READ, grouplist, info->ngroups * sizeof(group)))
-		return -EFAULT;
-
-	for (i = 0; i < info->ngroups; i++) {
-		if (__get_user(group, grouplist+i))
-			return  -EFAULT;
-		GROUP_AT(info, i) = (gid_t)group;
-	}
-
-	return 0;
-}
-
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
-{
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-	i = current->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize)
-			return -EINVAL;
-		if (groups16_to_user(grouplist, current->group_info))
-			return -EFAULT;
-	}
-	return i;
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
-{
-	struct group_info *new_info;
-	int retval;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	new_info = groups_alloc(gidsetsize);
-	if (!new_info)
-		return -ENOMEM;
-	retval = groups16_from_user(new_info, grouplist);
-	if (retval) {
-		groups_free(new_info);
-		return retval;
-	}
-
-	retval = set_current_groups(new_info);
-	if (retval)
-		groups_free(new_info);
-
-	return retval;
-}
-
-asmlinkage long sys32_getuid16(void)
-{
-	return high2lowuid(current->uid);
-}
-
-asmlinkage long sys32_geteuid16(void)
-{
-	return high2lowuid(current->euid);
-}
-
-asmlinkage long sys32_getgid16(void)
-{
-	return high2lowgid(current->gid);
-}
-
-asmlinkage long sys32_getegid16(void)
-{
-	return high2lowgid(current->egid);
-}
-
 /* 32-bit timeval and related flotsam.  */
 
 static long get_tv32(struct timeval *o, struct compat_timeval *i)
diff -ruN ngroups-2.6/arch/sparc64/kernel/systbls.S uid16-2.6/arch/sparc64/kernel/systbls.S
--- ngroups-2.6/arch/sparc64/kernel/systbls.S	2004-01-26 09:19:01.000000000 -0800
+++ uid16-2.6/arch/sparc64/kernel/systbls.S	2004-01-27 17:35:08.000000000 -0800
@@ -21,21 +21,21 @@
 sys_call_table32:
 /*0*/	.word sys_restart_syscall, sparc_exit, sys_fork, sys_read, sys_write
 /*5*/	.word sparc32_open, sys_close, compat_sys_wait4, sys_creat, sys_link
-/*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys32_chown16, sys32_mknod
-/*15*/	.word sys32_chmod, sys32_lchown16, sparc_brk, sys_perfctr, sys32_lseek
-/*20*/	.word sys_getpid, sys_capget, sys_capset, sys32_setuid16, sys32_getuid16
+/*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys_chown16, sys32_mknod
+/*15*/	.word sys32_chmod, sys_lchown16, sparc_brk, sys_perfctr, sys32_lseek
+/*20*/	.word sys_getpid, sys_capget, sys_capset, sys_setuid16, sys_getuid16
 /*25*/	.word sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
 /*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys_access, sys_nice
 	.word sys_chown, sys_sync, sys_kill, compat_sys_newstat, sys32_sendfile
 /*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
-	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
-/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_sys_ioctl
+	.word sys_umount, sys_setgid16, sys_getgid16, sys_signal, sys_geteuid16
+/*50*/	.word sys_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_sys_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys32_mmap, sys_setreuid, sys_munmap, sys_mprotect
-	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
-/*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
+	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys_getgroups16
+/*80*/	.word sys_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
@@ -43,8 +43,8 @@
 	.word sys32_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
 /*110*/	.word sys_setresgid, sys_getresgid, sys_setregid, sys_nis_syscall, sys_nis_syscall
 	.word sys_getgroups, sys32_gettimeofday, compat_sys_getrusage, sys_nis_syscall, sys_getcwd
-/*120*/	.word sys32_readv, sys32_writev, sys32_settimeofday, sys32_fchown16, sys_fchmod
-	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
+/*120*/	.word sys32_readv, sys32_writev, sys32_settimeofday, sys_fchown16, sys_fchmod
+	.word sys_nis_syscall, sys_setreuid16, sys_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
 /*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, compat_sys_getrlimit
@@ -64,7 +64,7 @@
 /*210*/	.word sys32_fadvise64_64, sys_tgkill, sys_waitpid, sys_swapoff, sys32_sysinfo
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word compat_sys_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
-	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
+	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys_setfsuid16, sys_setfsgid16
 /*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
 	.word compat_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
@@ -149,7 +149,7 @@
 	.word sys_close, sunos_wait4, sys_creat
 	.word sys_link, sys_unlink, sunos_execv
 	.word sys_chdir, sunos_nosys, sys32_mknod
-	.word sys32_chmod, sys32_lchown16, sunos_brk
+	.word sys32_chmod, sys_lchown16, sunos_brk
 	.word sunos_nosys, sys32_lseek, sunos_getpid
 	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sunos_getuid, sunos_nosys, sys_ptrace
@@ -170,8 +170,8 @@
 	.word sunos_nosys, sunos_sbrk, sunos_sstk
 	.word sunos_mmap, sunos_vadvise, sys_munmap
 	.word sys_mprotect, sys_madvise, sys_vhangup
-	.word sunos_nosys, sys_mincore, sys32_getgroups16
-	.word sys32_setgroups16, sys_getpgrp, sunos_setpgrp
+	.word sunos_nosys, sys_mincore, sys_getgroups16
+	.word sys_setgroups16, sys_getpgrp, sunos_setpgrp
 	.word compat_sys_setitimer, sunos_nosys, sys_swapon
 	.word compat_sys_getitimer, sys_gethostname, sys_sethostname
 	.word sunos_getdtablesize, sys_dup2, sunos_nop
@@ -185,9 +185,9 @@
 	.word sys32_sigstack, compat_sys_recvmsg, compat_sys_sendmsg
 	.word sunos_nosys, sys32_gettimeofday, compat_sys_getrusage
 	.word sunos_getsockopt, sunos_nosys, sunos_readv
-	.word sunos_writev, sys32_settimeofday, sys32_fchown16
-	.word sys_fchmod, sys32_recvfrom, sys32_setreuid16
-	.word sys32_setregid16, sys_rename, sys_truncate
+	.word sunos_writev, sys32_settimeofday, sys_fchown16
+	.word sys_fchmod, sys32_recvfrom, sys_setreuid16
+	.word sys_setregid16, sys_rename, sys_truncate
 	.word sys_ftruncate, sys_flock, sunos_nosys
 	.word sys32_sendto, sys_shutdown, sys_socketpair
 	.word sys_mkdir, sys_rmdir, sys32_utimes
diff -ruN ngroups-2.6/arch/um/Kconfig uid16-2.6/arch/um/Kconfig
--- ngroups-2.6/arch/um/Kconfig	2004-01-26 09:19:09.000000000 -0800
+++ uid16-2.6/arch/um/Kconfig	2004-01-27 15:41:22.000000000 -0800
@@ -22,6 +22,10 @@
 	bool
 	default y
 
+config UID16_SYSCALLS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -ruN ngroups-2.6/arch/x86_64/Kconfig uid16-2.6/arch/x86_64/Kconfig
--- ngroups-2.6/arch/x86_64/Kconfig	2004-01-26 09:19:09.000000000 -0800
+++ uid16-2.6/arch/x86_64/Kconfig	2004-01-27 17:10:03.000000000 -0800
@@ -368,6 +368,11 @@
 	depends on IA32_EMULATION
 	default y
 
+config UID16_SYSCALLS
+	bool
+	depends on IA32_EMULATION
+	default y
+
 endmenu
 
 source drivers/Kconfig
diff -ruN ngroups-2.6/kernel/Makefile uid16-2.6/kernel/Makefile
--- ngroups-2.6/kernel/Makefile	2003-12-19 14:30:14.000000000 -0800
+++ uid16-2.6/kernel/Makefile	2004-01-27 14:53:35.000000000 -0800
@@ -11,7 +11,7 @@
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
-obj-$(CONFIG_UID16) += uid16.o
+obj-$(CONFIG_UID16_SYSCALLS) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
diff -ruN ngroups-2.6/kernel/uid16.c uid16-2.6/kernel/uid16.c
--- ngroups-2.6/kernel/uid16.c	2004-01-27 12:40:02.000000000 -0800
+++ uid16-2.6/kernel/uid16.c	2004-01-27 15:07:52.000000000 -0800
@@ -11,11 +11,19 @@
 #include <linux/reboot.h>
 #include <linux/prctl.h>
 #include <linux/init.h>
-#include <linux/highuid.h>
+#include <linux/types.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
 
+/* duplicated from highuid.h, but not exposed */
+extern int overflowuid;
+extern int overflowgid;
+#define high2lowuid(uid) ((uid) > 65535 ? (uid16_t)overflowuid : (uid16_t)(uid)
+#define high2lowgid(gid) ((gid) > 65535 ? (gid16_t)overflowgid : (gid16_t)(gid))
+#define low2highuid(uid) ((uid) == (uid16_t)-1 ? (uid_t)-1 : (uid_t)(uid))
+#define low2highgid(gid) ((gid) == (gid16_t)-1 ? (gid_t)-1 : (gid_t)(gid))
+
 extern asmlinkage long sys_chown(const char *, uid_t,gid_t);
 extern asmlinkage long sys_lchown(const char *, uid_t,gid_t);
 extern asmlinkage long sys_fchown(unsigned int, uid_t,gid_t);
@@ -28,48 +36,48 @@
 extern asmlinkage long sys_setfsuid(uid_t);
 extern asmlinkage long sys_setfsgid(gid_t);
  
-asmlinkage long sys_chown16(const char * filename, old_uid_t user, old_gid_t group)
+asmlinkage long sys_chown16(const char * filename, uid16_t user, gid16_t group)
 {
 	return sys_chown(filename, low2highuid(user), low2highgid(group));
 }
 
-asmlinkage long sys_lchown16(const char * filename, old_uid_t user, old_gid_t group)
+asmlinkage long sys_lchown16(const char * filename, uid16_t user, gid16_t group)
 {
 	return sys_lchown(filename, low2highuid(user), low2highgid(group));
 }
 
-asmlinkage long sys_fchown16(unsigned int fd, old_uid_t user, old_gid_t group)
+asmlinkage long sys_fchown16(unsigned int fd, uid16_t user, gid16_t group)
 {
 	return sys_fchown(fd, low2highuid(user), low2highgid(group));
 }
 
-asmlinkage long sys_setregid16(old_gid_t rgid, old_gid_t egid)
+asmlinkage long sys_setregid16(gid16_t rgid, gid16_t egid)
 {
 	return sys_setregid(low2highgid(rgid), low2highgid(egid));
 }
 
-asmlinkage long sys_setgid16(old_gid_t gid)
+asmlinkage long sys_setgid16(gid16_t gid)
 {
 	return sys_setgid((gid_t)gid);
 }
 
-asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid)
+asmlinkage long sys_setreuid16(uid16_t ruid, uid16_t euid)
 {
 	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
 }
 
-asmlinkage long sys_setuid16(old_uid_t uid)
+asmlinkage long sys_setuid16(uid16_t uid)
 {
 	return sys_setuid((uid_t)uid);
 }
 
-asmlinkage long sys_setresuid16(old_uid_t ruid, old_uid_t euid, old_uid_t suid)
+asmlinkage long sys_setresuid16(uid16_t ruid, uid16_t euid, uid16_t suid)
 {
 	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
 		low2highuid(suid));
 }
 
-asmlinkage long sys_getresuid16(old_uid_t *ruid, old_uid_t *euid, old_uid_t *suid)
+asmlinkage long sys_getresuid16(uid16_t *ruid, uid16_t *euid, uid16_t *suid)
 {
 	int retval;
 
@@ -80,13 +88,13 @@
 	return retval;
 }
 
-asmlinkage long sys_setresgid16(old_gid_t rgid, old_gid_t egid, old_gid_t sgid)
+asmlinkage long sys_setresgid16(gid16_t rgid, gid16_t egid, gid16_t sgid)
 {
 	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
 		low2highgid(sgid));
 }
 
-asmlinkage long sys_getresgid16(old_gid_t *rgid, old_gid_t *egid, old_gid_t *sgid)
+asmlinkage long sys_getresgid16(gid16_t *rgid, gid16_t *egid, gid16_t *sgid)
 {
 	int retval;
 
@@ -97,21 +105,21 @@
 	return retval;
 }
 
-asmlinkage long sys_setfsuid16(old_uid_t uid)
+asmlinkage long sys_setfsuid16(uid16_t uid)
 {
 	return sys_setfsuid((uid_t)uid);
 }
 
-asmlinkage long sys_setfsgid16(old_gid_t gid)
+asmlinkage long sys_setfsgid16(gid16_t gid)
 {
 	return sys_setfsgid((gid_t)gid);
 }
 
-static int groups16_to_user(old_gid_t __user *grouplist,
+static int groups16_to_user(gid16_t __user *grouplist,
     struct group_info *info)
 {
 	int i;
-	old_gid_t group;
+	gid16_t group;
 
 	if (info->ngroups > TASK_SIZE/sizeof(group))
 		return -EFAULT;
@@ -119,7 +127,7 @@
 		return -EFAULT;
 
 	for (i = 0; i < info->ngroups; i++) {
-		group = (old_gid_t)GROUP_AT(info, i);
+		group = (gid16_t)GROUP_AT(info, i);
 		if (__put_user(group, grouplist+i))
 			return -EFAULT;
 	}
@@ -128,10 +136,10 @@
 }
 
 static int groups16_from_user(struct group_info *info,
-    old_gid_t __user *grouplist)
+    gid16_t __user *grouplist)
 {
 	int i;
-	old_gid_t group;
+	gid16_t group;
 
 	if (info->ngroups > TASK_SIZE/sizeof(group))
 		return -EFAULT;
@@ -147,7 +155,7 @@
 	return 0;
 }
 
-asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t __user *grouplist)
+asmlinkage long sys_getgroups16(int gidsetsize, gid16_t __user *grouplist)
 {
 	int i = 0;
 
@@ -163,7 +171,7 @@
 	return i;
 }
 
-asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t __user *grouplist)
+asmlinkage long sys_setgroups16(int gidsetsize, gid16_t __user *grouplist)
 {
 	struct group_info *new_info;
 	int retval;

--tsOsTdHNUZQcU9Ye--
