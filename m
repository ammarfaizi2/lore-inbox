Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJIMbd>; Wed, 9 Oct 2002 08:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbSJIMbP>; Wed, 9 Oct 2002 08:31:15 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:58271 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261666AbSJIM34> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
Date: Wed, 9 Oct 2002 14:32:15 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091432.15883.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use common code for 16 bit user/groud id system calls on s390x.

diff -urN linux-2.5.41/arch/s390x/config.in linux-2.5.41-s390/arch/s390x/config.in
--- linux-2.5.41/arch/s390x/config.in	Mon Oct  7 20:23:25 2002
+++ linux-2.5.41-s390/arch/s390x/config.in	Wed Oct  9 14:01:53 2002
@@ -22,6 +22,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
+  define_bool CONFIG_UID16_SYSCALLS y
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
 fi
 
diff -urN linux-2.5.41/arch/s390x/defconfig linux-2.5.41-s390/arch/s390x/defconfig
--- linux-2.5.41/arch/s390x/defconfig	Wed Oct  9 14:01:13 2002
+++ linux-2.5.41-s390/arch/s390x/defconfig	Wed Oct  9 14:01:53 2002
@@ -39,6 +39,7 @@
 #
 CONFIG_SMP=y
 CONFIG_S390_SUPPORT=y
+CONFIG_UID16_SYSCALLS=y
 CONFIG_BINFMT_ELF32=y
 
 #
diff -urN linux-2.5.41/arch/s390x/kernel/binfmt_elf32.c linux-2.5.41-s390/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.5.41/arch/s390x/kernel/binfmt_elf32.c	Mon Oct  7 20:25:20 2002
+++ linux-2.5.41-s390/arch/s390x/kernel/binfmt_elf32.c	Wed Oct  9 14:01:53 2002
@@ -96,6 +96,7 @@
 } while (0)
 #endif 
 
+#define __UID16 /* ugly, but no duplicated code */
 #include "linux32.h"
 
 typedef _s390_fp_regs32 elf_fpregset_t;
@@ -160,11 +161,6 @@
 
 #include <linux/highuid.h>
 
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#define NEW_TO_OLD_UID(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define NEW_TO_OLD_GID(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid) 
-
 #define elf_addr_t	u32
 /*
 #define init_elf_binfmt init_elf32_binfmt
diff -urN linux-2.5.41/arch/s390x/kernel/entry.S linux-2.5.41-s390/arch/s390x/kernel/entry.S
--- linux-2.5.41/arch/s390x/kernel/entry.S	Wed Oct  9 14:01:46 2002
+++ linux-2.5.41-s390/arch/s390x/kernel/entry.S	Wed Oct  9 14:01:53 2002
@@ -400,7 +400,7 @@
         .long  SYSCALL(sys_mount,sys32_mount_wrapper)
         .long  SYSCALL(sys_oldumount,sys32_oldumount_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setuid16_wrapper)   /* old setuid16 syscall*/
-        .long  SYSCALL(sys_ni_syscall,sys32_getuid16)   /* old getuid16 syscall*/
+        .long  SYSCALL(sys_ni_syscall,sys_getuid16)   /* old getuid16 syscall*/
         .long  SYSCALL(sys_ni_syscall,sys32_stime_wrapper) /* 25 old stime syscall */
         .long  SYSCALL(sys_ptrace,sys32_ptrace_wrapper)
         .long  SYSCALL(sys_alarm,sys32_alarm_wrapper)
@@ -422,11 +422,11 @@
         .long  SYSCALL(sys_times,sys32_times_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old prof syscall */
         .long  SYSCALL(sys_brk,sys32_brk_wrapper)               /* 45 */
-        .long  SYSCALL(sys_ni_syscall,sys32_setgid16)   /* old setgid16 syscall*/
-        .long  SYSCALL(sys_ni_syscall,sys32_getgid16)   /* old getgid16 syscall*/
+        .long  SYSCALL(sys_ni_syscall,sys_setgid16)   /* old setgid16 syscall*/
+        .long  SYSCALL(sys_ni_syscall,sys_getgid16)   /* old getgid16 syscall*/
         .long  SYSCALL(sys_signal,sys32_signal_wrapper)
-        .long  SYSCALL(sys_ni_syscall,sys32_geteuid16)  /* old geteuid16 syscall */
-        .long  SYSCALL(sys_ni_syscall,sys32_getegid16)  /* old getegid16 syscall */
+        .long  SYSCALL(sys_ni_syscall,sys_geteuid16)  /* old geteuid16 syscall */
+        .long  SYSCALL(sys_ni_syscall,sys_getegid16)  /* old getegid16 syscall */
         .long  SYSCALL(sys_acct,sys32_acct_wrapper)
         .long  SYSCALL(sys_umount,sys32_umount_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old lock syscall */
diff -urN linux-2.5.41/arch/s390x/kernel/linux32.c linux-2.5.41-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.41/arch/s390x/kernel/linux32.c	Wed Oct  9 14:01:13 2002
+++ linux-2.5.41-s390/arch/s390x/kernel/linux32.c	Wed Oct  9 14:01:53 2002
@@ -15,6 +15,7 @@
  */
 
 
+#define __UID16 /* ugly, but no duplicated code */
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -68,181 +69,6 @@
 
 #include "linux32.h"
 
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
 
 struct timeval32
diff -urN linux-2.5.41/arch/s390x/kernel/wrapper32.S linux-2.5.41-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.41/arch/s390x/kernel/wrapper32.S	Mon Oct  7 20:24:12 2002
+++ linux-2.5.41-s390/arch/s390x/kernel/wrapper32.S	Wed Oct  9 14:01:53 2002
@@ -83,7 +83,7 @@
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_uid_emu31_t 
-	jg	sys32_lchown16		# branch to system call
+	jg	sys_lchown16		# branch to system call
 
 	.globl  sys32_lseek_wrapper 
 sys32_lseek_wrapper:
@@ -111,7 +111,7 @@
 	.globl  sys32_setuid16_wrapper 
 sys32_setuid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_uid_emu31_t 
-	jg	sys32_setuid16		# branch to system call
+	jg	sys_setuid16		# branch to system call
 
 #sys32_getuid16_wrapper			# void 
 
@@ -195,7 +195,7 @@
 	.globl  sys32_setgid16_wrapper 
 sys32_setgid16_wrapper:
 	llgfr	%r2,%r2			# __kernel_old_gid_emu31_t 
-	jg	sys32_setgid16		# branch to system call
+	jg	sys_setgid16		# branch to system call
 
 #sys32_getgid16_wrapper			# void 
 
@@ -278,13 +278,13 @@
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
 
@@ -344,13 +344,13 @@
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
@@ -425,7 +425,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_fchown16		# branch to system call
+	jg	sys_fchown16		# branch to system call
 
 	.globl  sys32_getpriority_wrapper 
 sys32_getpriority_wrapper:
@@ -625,12 +625,12 @@
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
@@ -777,14 +777,14 @@
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
 
 	.globl  sys32_query_module_wrapper 
 sys32_query_module_wrapper:
@@ -814,14 +814,14 @@
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
@@ -895,7 +895,7 @@
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_chown16		# branch to system call
+	jg	sys_chown16		# branch to system call
 
 	.globl  sys32_getcwd_wrapper 
 sys32_getcwd_wrapper:
diff -urN linux-2.5.41/include/asm-s390x/posix_types.h linux-2.5.41-s390/include/asm-s390x/posix_types.h
--- linux-2.5.41/include/asm-s390x/posix_types.h	Mon Oct  7 20:25:19 2002
+++ linux-2.5.41-s390/include/asm-s390x/posix_types.h	Wed Oct  9 14:01:53 2002
@@ -37,8 +37,8 @@
 typedef unsigned short	__kernel_uid16_t;
 typedef unsigned short	__kernel_gid16_t;
 
-typedef __kernel_uid_t __kernel_old_uid_t;
-typedef __kernel_gid_t __kernel_old_gid_t;
+typedef __kernel_uid16_t __kernel_old_uid_t;
+typedef __kernel_gid16_t __kernel_old_gid_t;
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
diff -urN linux-2.5.41/include/linux/highuid.h linux-2.5.41-s390/include/linux/highuid.h
--- linux-2.5.41/include/linux/highuid.h	Mon Oct  7 20:24:39 2002
+++ linux-2.5.41-s390/include/linux/highuid.h	Wed Oct  9 14:01:53 2002
@@ -10,6 +10,11 @@
  * CONFIG_UID16 is defined if the given architecture needs to
  * support backwards compatibility for old system calls.
  *
+ * CONFIG_UID16_SYSCALLS is defined if the given architecture wants to call
+ * backwards compatible syscalls, but not alter the general behavior of
+ * other things that may call these translation macros.  For example 64 bit
+ * architectures that have legacy compatibility syscalls.
+ *
  * kernel code should use uid_t and gid_t at all times when dealing with
  * kernel-private data.
  *
@@ -38,7 +43,7 @@
 #define DEFAULT_OVERFLOWUID	65534
 #define DEFAULT_OVERFLOWGID	65534
 
-#ifdef CONFIG_UID16
+#if defined(CONFIG_UID16) || defined(__UID16)
 
 /* prevent uid mod 65536 effect by returning a default value for high UIDs */
 #define high2lowuid(uid) ((uid) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
diff -urN linux-2.5.41/include/linux/types.h linux-2.5.41-s390/include/linux/types.h
--- linux-2.5.41/include/linux/types.h	Mon Oct  7 20:24:02 2002
+++ linux-2.5.41-s390/include/linux/types.h	Wed Oct  9 14:01:53 2002
@@ -30,7 +30,7 @@
 typedef __kernel_uid16_t        uid16_t;
 typedef __kernel_gid16_t        gid16_t;
 
-#ifdef CONFIG_UID16
+#if defined(CONFIG_UID16) || defined(__UID16)
 /* This is defined by include/asm-{arch}/posix_types.h */
 typedef __kernel_old_uid_t	old_uid_t;
 typedef __kernel_old_gid_t	old_gid_t;
diff -urN linux-2.5.41/kernel/Makefile linux-2.5.41-s390/kernel/Makefile
--- linux-2.5.41/kernel/Makefile	Mon Oct  7 20:23:34 2002
+++ linux-2.5.41-s390/kernel/Makefile	Wed Oct  9 14:01:53 2002
@@ -12,7 +12,12 @@
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
+ifeq ($(CONFIG_UID16),y)
 obj-$(CONFIG_UID16) += uid16.o
+else
+obj-$(CONFIG_UID16_SYSCALLS) += uid16.o
+endif
+
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += pm.o
diff -urN linux-2.5.41/kernel/uid16.c linux-2.5.41-s390/kernel/uid16.c
--- linux-2.5.41/kernel/uid16.c	Mon Oct  7 20:24:38 2002
+++ linux-2.5.41-s390/kernel/uid16.c	Wed Oct  9 14:01:53 2002
@@ -3,6 +3,7 @@
  *	together in the faint hope we can take the out in five years time.
  */
 
+#define __UID16 /* ugly, but no duplicated code */
 #include <linux/mm.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>

