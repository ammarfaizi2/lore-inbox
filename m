Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWGJIxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWGJIxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWGJIxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:53:39 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:17358 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751380AbWGJIxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:53:38 -0400
Date: Mon, 10 Jul 2006 10:51:42 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/rfc] s390: get rid of own uid16 compat system calls
Message-ID: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was about to get rid of the compat uid16 system calls we have in s390
arch code and use the common code uid16 ones (see patch below). Since in 64
bit mode we don't have any of the uid16 system calls, these could be used for
the compat layer where we need them.

"Only" thing is that we unfortunately have different sizes for
__kernel_old_[uid|gid]_t (16 bit on s390, 32 on s390x). I was tempted to
change these just to find out that there are other users as well:

include/linux/ncp_fs.h:
 #define NCP_IOC_GETMOUNTUID _IOW('n', 2, __kernel_old_uid_t)
include/linux/smb_fs.h:
 #define SMB_IOC_GETMOUNTUID _IOR('u', 1, __kernel_old_uid_t)

So, this is no option. Would anybody know of something to get this work?
Or is this just a stupid idea?

---

 arch/s390/kernel/compat_linux.c   |  206 --------------------------------------
 arch/s390/kernel/compat_wrapper.S |   98 ++++++++----------
 arch/s390/kernel/syscalls.S       |   38 +++----
 init/Kconfig                      |    2 
 4 files changed, 65 insertions(+), 279 deletions(-)

Index: linux-2.6/arch/s390/kernel/compat_linux.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_linux.c
+++ linux-2.6/arch/s390/kernel/compat_linux.c
@@ -15,7 +15,6 @@
  *
  */
 
-
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/fs.h> 
@@ -69,211 +68,6 @@
 
 #include "compat_linux.h"
 
- 
-/* For this source file, we want overflow handling. */
-
-#undef high2lowuid
-#undef high2lowgid
-#undef low2highuid
-#undef low2highgid
-#undef SET_UID16
-#undef SET_GID16
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#undef SET_OLDSTAT_UID
-#undef SET_OLDSTAT_GID
-#undef SET_STAT_UID
-#undef SET_STAT_GID
-
-#define high2lowuid(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define high2lowgid(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid)
-#define low2highuid(uid) ((uid) == (u16)-1) ? (uid_t)-1 : (uid_t)(uid)
-#define low2highgid(gid) ((gid) == (u16)-1) ? (gid_t)-1 : (gid_t)(gid)
-#define SET_UID16(var, uid)	var = high2lowuid(uid)
-#define SET_GID16(var, gid)	var = high2lowgid(gid)
-#define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
-#define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = high2lowgid(gid)
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
-
-asmlinkage long sys32_chown16(const char __user * filename, u16 user, u16 group)
-{
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-asmlinkage long sys32_lchown16(const char __user * filename, u16 user, u16 group)
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
-asmlinkage long sys32_getresuid16(u16 __user *ruid, u16 __user *euid, u16 __user *suid)
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
-asmlinkage long sys32_getresgid16(u16 __user *rgid, u16 __user *egid, u16 __user *sgid)
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
-static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
-{
-	int i;
-	u16 group;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		group = (u16)GROUP_AT(group_info, i);
-		if (put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *group_info, u16 __user *grouplist)
-{
-	int i;
-	u16 group;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		if (get_user(group, grouplist+i))
-			return  -EFAULT;
-		GROUP_AT(group_info, i) = (gid_t)group;
-	}
-
-	return 0;
-}
-
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 __user *grouplist)
-{
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-
-	get_group_info(current->group_info);
-	i = current->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups16_to_user(grouplist, current->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	put_group_info(current->group_info);
-	return i;
-}
-
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 __user *grouplist)
-{
-	struct group_info *group_info;
-	int retval;
-
-	if (!capable(CAP_SETGID))
-		return -EPERM;
-	if ((unsigned)gidsetsize > NGROUPS_MAX)
-		return -EINVAL;
-
-	group_info = groups_alloc(gidsetsize);
-	if (!group_info)
-		return -ENOMEM;
-	retval = groups16_from_user(group_info, grouplist);
-	if (retval) {
-		put_group_info(group_info);
-		return retval;
-	}
-
-	retval = set_current_groups(group_info);
-	put_group_info(group_info);
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
 
 static inline long get_tv32(struct timeval *o, struct compat_timeval __user *i)
Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -239,7 +239,7 @@ source "usr/Kconfig"
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EMBEDDED
-	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
+	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && (!64BIT || COMPAT)) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
 	default y
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
Index: linux-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_wrapper.S
+++ linux-2.6/arch/s390/kernel/compat_wrapper.S
@@ -78,12 +78,12 @@ sys32_chmod_wrapper:
 	llgfr	%r3,%r3			# mode_t
 	jg	sys_chmod		# branch to system call
 
-	.globl  sys32_lchown16_wrapper 
-sys32_lchown16_wrapper:
+	.globl	sys_lchown16_wrapper
+sys_lchown16_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t 
-	jg	sys32_lchown16		# branch to system call
+	jg	sys_lchown16		# branch to system call
 
 	.globl  sys32_lseek_wrapper 
 sys32_lseek_wrapper:
@@ -108,12 +108,10 @@ sys32_oldumount_wrapper:
 	llgtr	%r2,%r2			# char *
 	jg	sys_oldumount		# branch to system call
 
-	.globl  sys32_setuid16_wrapper 
-sys32_setuid16_wrapper:
+	.globl	sys_setuid16_wrapper
+sys_setuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
-	jg	sys32_setuid16		# branch to system call
-
-#sys32_getuid16_wrapper			# void 
+	jg	sys_setuid16		# branch to system call
 
 	.globl  sys32_ptrace_wrapper 
 sys32_ptrace_wrapper:
@@ -192,12 +190,10 @@ sys32_brk_wrapper:
 	llgtr	%r2,%r2			# unsigned long
 	jg	sys_brk			# branch to system call
 
-	.globl  sys32_setgid16_wrapper 
-sys32_setgid16_wrapper:
+	.globl	sys_setgid16_wrapper
+sys_setgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
-	jg	sys32_setgid16		# branch to system call
-
-#sys32_getgid16_wrapper			# void 
+	jg	sys_setgid16		# branch to system call
 
 	.globl sys32_signal_wrapper
 sys32_signal_wrapper:
@@ -205,10 +201,6 @@ sys32_signal_wrapper:
 	llgtr	%r3,%r3			# __sighandler_t
 	jg	sys_signal
 
-#sys32_geteuid16_wrapper		# void 
-
-#sys32_getegid16_wrapper		# void 
-
 	.globl  sys32_acct_wrapper 
 sys32_acct_wrapper:
 	llgtr	%r2,%r2			# char *
@@ -275,17 +267,17 @@ sys32_sigaction_wrapper:
 	llgtr	%r4,%r4			# struct old_sigaction32 *
 	jg	sys32_sigaction		# branch to system call
 
-	.globl  sys32_setreuid16_wrapper 
-sys32_setreuid16_wrapper:
+	.globl	sys_setreuid16_wrapper
+sys_setreuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
-	jg	sys32_setreuid16	# branch to system call
+	jg	sys_setreuid16	# branch to system call
 
-	.globl  sys32_setregid16_wrapper 
-sys32_setregid16_wrapper:
+	.globl	sys_setregid16_wrapper
+sys_setregid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t 
-	jg	sys32_setregid16	# branch to system call
+	jg	sys_setregid16		# branch to system call
 
 	.globl sys_sigsuspend_wrapper
 sys_sigsuspend_wrapper:
@@ -346,17 +338,17 @@ sys32_settimeofday_wrapper:
 	llgtr	%r3,%r3			# struct timezone *
 	jg	sys32_settimeofday	# branch to system call
 
-	.globl  sys32_getgroups16_wrapper 
-sys32_getgroups16_wrapper:
+	.globl	sys_getgroups16_wrapper
+sys_getgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_getgroups16	# branch to system call
+	jg	sys_getgroups16		# branch to system call
 
-	.globl  sys32_setgroups16_wrapper 
-sys32_setgroups16_wrapper:
+	.globl	sys_setgroups16_wrapper
+sys_setgroups16_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
-	jg	sys32_setgroups16	# branch to system call
+	jg	sys_setgroups16		# branch to system call
 
 	.globl  sys32_symlink_wrapper 
 sys32_symlink_wrapper:
@@ -426,12 +418,12 @@ sys32_fchmod_wrapper:
 	llgfr	%r3,%r3			# mode_t
 	jg	sys_fchmod		# branch to system call
 
-	.globl  sys32_fchown16_wrapper 
-sys32_fchown16_wrapper:
+	.globl	sys_fchown16_wrapper
+sys_fchown16_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# compat_uid_t
 	llgfr	%r4,%r4			# compat_uid_t
-	jg	sys32_fchown16		# branch to system call
+	jg	sys_fchown16		# branch to system call
 
 	.globl  sys32_getpriority_wrapper 
 sys32_getpriority_wrapper:
@@ -619,15 +611,15 @@ sys32_personality_wrapper:
 	llgfr	%r2,%r2			# unsigned long
 	jg	s390x_personality	# branch to system call
 
-	.globl  sys32_setfsuid16_wrapper 
-sys32_setfsuid16_wrapper:
+	.globl	sys_setfsuid16_wrapper
+sys_setfsuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
-	jg	sys32_setfsuid16	# branch to system call
+	jg	sys_setfsuid16		# branch to system call
 
-	.globl  sys32_setfsgid16_wrapper 
-sys32_setfsgid16_wrapper:
+	.globl	sys_setfsgid16_wrapper
+sys_setfsgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
-	jg	sys32_setfsgid16	# branch to system call
+	jg	sys_setfsgid16		# branch to system call
 
 	.globl  sys32_llseek_wrapper 
 sys32_llseek_wrapper:
@@ -769,19 +761,19 @@ sys32_mremap_wrapper:
 	llgfr	%r6,%r6			# unsigned long
 	jg	sys_mremap		# branch to system call
 
-	.globl  sys32_setresuid16_wrapper 
-sys32_setresuid16_wrapper:
+	.globl	sys_setresuid16_wrapper
+sys_setresuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t 
-	jg	sys32_setresuid16	# branch to system call
+	jg	sys_setresuid16		# branch to system call
 
-	.globl  sys32_getresuid16_wrapper 
-sys32_getresuid16_wrapper:
+	.globl	sys_getresuid16_wrapper
+sys_getresuid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_uid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_uid_emu31_t *
-	jg	sys32_getresuid16	# branch to system call
+	jg	sys_getresuid16		# branch to system call
 
 	.globl  sys32_poll_wrapper 
 sys32_poll_wrapper:
@@ -797,19 +789,19 @@ compat_sys_nfsservctl_wrapper:
 	llgtr	%r4,%r4			# union compat_nfsctl_res*
 	jg	compat_sys_nfsservctl	# branch to system call
 
-	.globl  sys32_setresgid16_wrapper 
-sys32_setresgid16_wrapper:
+	.globl	sys_setresgid16_wrapper
+sys_setresgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
 	llgfr	%r3,%r3			# __kernel_old_gid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_setresgid16	# branch to system call
+	jg	sys_setresgid16		# branch to system call
 
-	.globl  sys32_getresgid16_wrapper 
-sys32_getresgid16_wrapper:
+	.globl	sys_getresgid16_wrapper
+sys_getresgid16_wrapper:
 	llgtr	%r2,%r2			# __kernel_old_gid_emu31_t *
 	llgtr	%r3,%r3			# __kernel_old_gid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_getresgid16	# branch to system call
+	jg	sys_getresgid16		# branch to system call
 
 	.globl  sys32_prctl_wrapper 
 sys32_prctl_wrapper:
@@ -883,12 +875,12 @@ sys32_pwrite64_wrapper:
 	llgfr	%r6,%r6			# u32
 	jg	sys32_pwrite64		# branch to system call
 
-	.globl  sys32_chown16_wrapper 
-sys32_chown16_wrapper:
+	.globl	sys_chown16_wrapper
+sys_chown16_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_chown16		# branch to system call
+	jg	sys_chown16		# branch to system call
 
 	.globl  sys32_getcwd_wrapper 
 sys32_getcwd_wrapper:
Index: linux-2.6/arch/s390/kernel/syscalls.S
===================================================================
--- linux-2.6.orig/arch/s390/kernel/syscalls.S
+++ linux-2.6/arch/s390/kernel/syscalls.S
@@ -24,15 +24,15 @@ SYSCALL(sys_chdir,sys_chdir,sys32_chdir_
 SYSCALL(sys_time,sys_ni_syscall,sys32_time_wrapper)		/* old time syscall */
 SYSCALL(sys_mknod,sys_mknod,sys32_mknod_wrapper)
 SYSCALL(sys_chmod,sys_chmod,sys32_chmod_wrapper)		/* 15 */
-SYSCALL(sys_lchown16,sys_ni_syscall,sys32_lchown16_wrapper)	/* old lchown16 syscall*/
+SYSCALL(sys_lchown16,sys_ni_syscall,sys_lchown16_wrapper)	/* old lchown16 syscall*/
 NI_SYSCALL							/* old break syscall holder */
 NI_SYSCALL							/* old stat syscall holder */
 SYSCALL(sys_lseek,sys_lseek,sys32_lseek_wrapper)
 SYSCALL(sys_getpid,sys_getpid,sys_getpid)			/* 20 */
 SYSCALL(sys_mount,sys_mount,sys32_mount_wrapper)
 SYSCALL(sys_oldumount,sys_oldumount,sys32_oldumount_wrapper)
-SYSCALL(sys_setuid16,sys_ni_syscall,sys32_setuid16_wrapper)	/* old setuid16 syscall*/
-SYSCALL(sys_getuid16,sys_ni_syscall,sys32_getuid16)		/* old getuid16 syscall*/
+SYSCALL(sys_setuid16,sys_ni_syscall,sys_setuid16_wrapper)	/* old setuid16 syscall*/
+SYSCALL(sys_getuid16,sys_ni_syscall,sys_getuid16)		/* old getuid16 syscall*/
 SYSCALL(sys_stime,sys_ni_syscall,sys32_stime_wrapper)		/* 25 old stime syscall */
 SYSCALL(sys_ptrace,sys_ptrace,sys32_ptrace_wrapper)
 SYSCALL(sys_alarm,sys_alarm,sys32_alarm_wrapper)
@@ -54,11 +54,11 @@ SYSCALL(sys_pipe,sys_pipe,sys32_pipe_wra
 SYSCALL(sys_times,sys_times,compat_sys_times_wrapper)
 NI_SYSCALL							/* old prof syscall */
 SYSCALL(sys_brk,sys_brk,sys32_brk_wrapper)			/* 45 */
-SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16_wrapper)	/* old setgid16 syscall*/
-SYSCALL(sys_getgid16,sys_ni_syscall,sys32_getgid16)		/* old getgid16 syscall*/
+SYSCALL(sys_setgid16,sys_ni_syscall,sys_setgid16_wrapper)	/* old setgid16 syscall*/
+SYSCALL(sys_getgid16,sys_ni_syscall,sys_getgid16)		/* old getgid16 syscall*/
 SYSCALL(sys_signal,sys_signal,sys32_signal_wrapper)
-SYSCALL(sys_geteuid16,sys_ni_syscall,sys32_geteuid16)		/* old geteuid16 syscall */
-SYSCALL(sys_getegid16,sys_ni_syscall,sys32_getegid16)		/* 50 old getegid16 syscall */
+SYSCALL(sys_geteuid16,sys_ni_syscall,sys_geteuid16)		/* old geteuid16 syscall */
+SYSCALL(sys_getegid16,sys_ni_syscall,sys_getegid16)		/* 50 old getegid16 syscall */
 SYSCALL(sys_acct,sys_acct,sys32_acct_wrapper)
 SYSCALL(sys_umount,sys_umount,sys32_umount_wrapper)
 NI_SYSCALL							/* old lock syscall */
@@ -78,8 +78,8 @@ SYSCALL(sys_setsid,sys_setsid,sys_setsid
 SYSCALL(sys_sigaction,sys_sigaction,sys32_sigaction_wrapper)
 NI_SYSCALL							/* old sgetmask syscall*/
 NI_SYSCALL							/* old ssetmask syscall*/
-SYSCALL(sys_setreuid16,sys_ni_syscall,sys32_setreuid16_wrapper)	/* old setreuid16 syscall */
-SYSCALL(sys_setregid16,sys_ni_syscall,sys32_setregid16_wrapper)	/* old setregid16 syscall */
+SYSCALL(sys_setreuid16,sys_ni_syscall,sys_setreuid16_wrapper)	/* old setreuid16 syscall */
+SYSCALL(sys_setregid16,sys_ni_syscall,sys_setregid16_wrapper)	/* old setregid16 syscall */
 SYSCALL(sys_sigsuspend,sys_sigsuspend,sys_sigsuspend_wrapper)
 SYSCALL(sys_sigpending,sys_sigpending,compat_sys_sigpending_wrapper)
 SYSCALL(sys_sethostname,sys_sethostname,sys32_sethostname_wrapper)
@@ -88,8 +88,8 @@ SYSCALL(sys_old_getrlimit,sys_getrlimit,
 SYSCALL(sys_getrusage,sys_getrusage,compat_sys_getrusage_wrapper)
 SYSCALL(sys_gettimeofday,sys_gettimeofday,sys32_gettimeofday_wrapper)
 SYSCALL(sys_settimeofday,sys_settimeofday,sys32_settimeofday_wrapper)
-SYSCALL(sys_getgroups16,sys_ni_syscall,sys32_getgroups16_wrapper)	/* 80 old getgroups16 syscall */
-SYSCALL(sys_setgroups16,sys_ni_syscall,sys32_setgroups16_wrapper)	/* old setgroups16 syscall */
+SYSCALL(sys_getgroups16,sys_ni_syscall,sys_getgroups16_wrapper)	/* 80 old getgroups16 syscall */
+SYSCALL(sys_setgroups16,sys_ni_syscall,sys_setgroups16_wrapper)	/* old setgroups16 syscall */
 NI_SYSCALL							/* old select syscall */
 SYSCALL(sys_symlink,sys_symlink,sys32_symlink_wrapper)
 NI_SYSCALL							/* old lstat syscall */
@@ -103,7 +103,7 @@ SYSCALL(sys_munmap,sys_munmap,sys32_munm
 SYSCALL(sys_truncate,sys_truncate,sys32_truncate_wrapper)
 SYSCALL(sys_ftruncate,sys_ftruncate,sys32_ftruncate_wrapper)
 SYSCALL(sys_fchmod,sys_fchmod,sys32_fchmod_wrapper)
-SYSCALL(sys_fchown16,sys_ni_syscall,sys32_fchown16_wrapper)	/* 95 old fchown16 syscall*/
+SYSCALL(sys_fchown16,sys_ni_syscall,sys_fchown16_wrapper)	/* 95 old fchown16 syscall*/
 SYSCALL(sys_getpriority,sys_getpriority,sys32_getpriority_wrapper)
 SYSCALL(sys_setpriority,sys_setpriority,sys32_setpriority_wrapper)
 NI_SYSCALL							/* old profil syscall */
@@ -146,8 +146,8 @@ SYSCALL(sys_bdflush,sys_bdflush,sys32_bd
 SYSCALL(sys_sysfs,sys_sysfs,sys32_sysfs_wrapper)		/* 135 */
 SYSCALL(sys_personality,s390x_personality,sys32_personality_wrapper)
 NI_SYSCALL							/* for afs_syscall */
-SYSCALL(sys_setfsuid16,sys_ni_syscall,sys32_setfsuid16_wrapper)	/* old setfsuid16 syscall */
-SYSCALL(sys_setfsgid16,sys_ni_syscall,sys32_setfsgid16_wrapper)	/* old setfsgid16 syscall */
+SYSCALL(sys_setfsuid16,sys_ni_syscall,sys_setfsuid16_wrapper)	/* old setfsuid16 syscall */
+SYSCALL(sys_setfsgid16,sys_ni_syscall,sys_setfsgid16_wrapper)	/* old setfsgid16 syscall */
 SYSCALL(sys_llseek,sys_llseek,sys32_llseek_wrapper)		/* 140 */
 SYSCALL(sys_getdents,sys_getdents,sys32_getdents_wrapper)
 SYSCALL(sys_select,sys_select,compat_sys_select_wrapper)
@@ -172,14 +172,14 @@ SYSCALL(sys_sched_get_priority_min,sys_s
 SYSCALL(sys_sched_rr_get_interval,sys_sched_rr_get_interval,sys32_sched_rr_get_interval_wrapper)
 SYSCALL(sys_nanosleep,sys_nanosleep,compat_sys_nanosleep_wrapper)
 SYSCALL(sys_mremap,sys_mremap,sys32_mremap_wrapper)
-SYSCALL(sys_setresuid16,sys_ni_syscall,sys32_setresuid16_wrapper)	/* old setresuid16 syscall */
-SYSCALL(sys_getresuid16,sys_ni_syscall,sys32_getresuid16_wrapper)	/* 165 old getresuid16 syscall */
+SYSCALL(sys_setresuid16,sys_ni_syscall,sys_setresuid16_wrapper)	/* old setresuid16 syscall */
+SYSCALL(sys_getresuid16,sys_ni_syscall,sys_getresuid16_wrapper)	/* 165 old getresuid16 syscall */
 NI_SYSCALL							/* for vm86 */
 NI_SYSCALL							/* old sys_query_module */
 SYSCALL(sys_poll,sys_poll,sys32_poll_wrapper)
 SYSCALL(sys_nfsservctl,sys_nfsservctl,compat_sys_nfsservctl_wrapper)
-SYSCALL(sys_setresgid16,sys_ni_syscall,sys32_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
-SYSCALL(sys_getresgid16,sys_ni_syscall,sys32_getresgid16_wrapper)	/* old getresgid16 syscall */
+SYSCALL(sys_setresgid16,sys_ni_syscall,sys_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
+SYSCALL(sys_getresgid16,sys_ni_syscall,sys_getresgid16_wrapper)	/* old getresgid16 syscall */
 SYSCALL(sys_prctl,sys_prctl,sys32_prctl_wrapper)
 SYSCALL(sys_rt_sigreturn_glue,sys_rt_sigreturn_glue,sys32_rt_sigreturn_glue)
 SYSCALL(sys_rt_sigaction,sys_rt_sigaction,sys32_rt_sigaction_wrapper)
@@ -190,7 +190,7 @@ SYSCALL(sys_rt_sigqueueinfo,sys_rt_sigqu
 SYSCALL(sys_rt_sigsuspend,sys_rt_sigsuspend,compat_sys_rt_sigsuspend_wrapper)
 SYSCALL(sys_pread64,sys_pread64,sys32_pread64_wrapper)		/* 180 */
 SYSCALL(sys_pwrite64,sys_pwrite64,sys32_pwrite64_wrapper)
-SYSCALL(sys_chown16,sys_ni_syscall,sys32_chown16_wrapper)	/* old chown16 syscall */
+SYSCALL(sys_chown16,sys_ni_syscall,sys_chown16_wrapper)		/* old chown16 syscall */
 SYSCALL(sys_getcwd,sys_getcwd,sys32_getcwd_wrapper)
 SYSCALL(sys_capget,sys_capget,sys32_capget_wrapper)
 SYSCALL(sys_capset,sys_capset,sys32_capset_wrapper)		/* 185 */
