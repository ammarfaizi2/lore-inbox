Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSHZSPR>; Mon, 26 Aug 2002 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSHZSPR>; Mon, 26 Aug 2002 14:15:17 -0400
Received: from kathmandu.sun.com ([192.18.98.36]:63732 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S318227AbSHZSPJ>;
	Mon, 26 Aug 2002 14:15:09 -0400
Message-ID: <3D6A7125.5050106@sun.com>
Date: Mon, 26 Aug 2002 11:19:17 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] s390x sys32 (remove duplicated code)
Content-Type: multipart/mixed;
 boundary="------------020507020305080604010409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507020305080604010409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am working on a patch that removes the old limit of NGROUPS.

In doing so, I am checking everything that references NGROUPS.  One
such place is in arch/s390x/kernel/linux32.c.

I notice these things:
* s390x defines __kernel_old_gid_t to __kernel_gid_t (unsigned int)
* s390x has a sys32_getgroups16() which looks JUST LIKE uid16.c
sys_getgroups16
* s390x does not define CONFIG_UID16, but seems to need it

It seems to me that if we do:
* s390x defines CONFIG_UID16
* typedef __kernel_old_gid_t to u16
* get rid of all the sys32_*16 stuff and just call the uid16.c function


We could save a bit of duplicated code.  Patches that remove code are
good, right?

Obviouscly, I can't test it.  Please - comments?  Shoot me down if I 
have missed something.  What I know of s390 can fit inside a thimble.

2.4.x patch attached, 2.5.x to follow, if this is ok (whether it goes 
into 2.4.x or not, I did this version first)

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com


--------------020507020305080604010409
Content-Type: text/plain;
 name="bk-rev-1.588-s390-uid16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk-rev-1.588-s390-uid16.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.587   -> 1.588  
#	arch/s390x/defconfig	1.8     -> 1.9    
#	arch/s390x/config.in	1.9     -> 1.10   
#	arch/s390x/kernel/linux32.c	1.10    -> 1.11   
#	arch/s390x/kernel/entry.S	1.13    -> 1.14   
#	arch/s390x/kernel/wrapper32.S	1.4     -> 1.5    
#	include/asm-s390x/posix_types.h	1.1     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	thockin@freakshow.cobalt.com	1.588
# enable UID16 for s390x
# change s390x duplicated code to call UID16 functions
# --------------------------------------------
#
diff -Nru a/arch/s390x/config.in b/arch/s390x/config.in
--- a/arch/s390x/config.in	Mon Aug 26 11:10:46 2002
+++ b/arch/s390x/config.in	Mon Aug 26 11:10:46 2002
@@ -13,6 +13,7 @@
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
 define_bool CONFIG_ARCH_S390X y
+define_bool CONFIG_UID16 y
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -Nru a/arch/s390x/defconfig b/arch/s390x/defconfig
--- a/arch/s390x/defconfig	Mon Aug 26 11:10:46 2002
+++ b/arch/s390x/defconfig	Mon Aug 26 11:10:46 2002
@@ -9,6 +9,7 @@
 # CONFIG_GENERIC_BUST_SPINLOCK is not set
 CONFIG_ARCH_S390=y
 CONFIG_ARCH_S390X=y
+CONFIG_UID16=y
 
 #
 # Code maturity level options
diff -Nru a/arch/s390x/kernel/entry.S b/arch/s390x/kernel/entry.S
--- a/arch/s390x/kernel/entry.S	Mon Aug 26 11:10:46 2002
+++ b/arch/s390x/kernel/entry.S	Mon Aug 26 11:10:46 2002
@@ -391,7 +391,7 @@
         .long  SYSCALL(sys_mount,sys32_mount_wrapper)
         .long  SYSCALL(sys_oldumount,sys32_oldumount_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setuid16_wrapper)   /* old setuid16 syscall*/
-        .long  SYSCALL(sys_ni_syscall,sys32_getuid16)   /* old getuid16 syscall*/
+        .long  SYSCALL(sys_ni_syscall,sys_getuid16)   /* old getuid16 syscall*/
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* 25 old stime syscall */
         .long  SYSCALL(sys_ptrace,sys32_ptrace_wrapper)
         .long  SYSCALL(sys_alarm,sys32_alarm_wrapper)
@@ -413,11 +413,11 @@
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
diff -Nru a/arch/s390x/kernel/linux32.c b/arch/s390x/kernel/linux32.c
--- a/arch/s390x/kernel/linux32.c	Mon Aug 26 11:10:46 2002
+++ b/arch/s390x/kernel/linux32.c	Mon Aug 26 11:10:46 2002
@@ -66,181 +66,6 @@
 
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
diff -Nru a/arch/s390x/kernel/wrapper32.S b/arch/s390x/kernel/wrapper32.S
--- a/arch/s390x/kernel/wrapper32.S	Mon Aug 26 11:10:46 2002
+++ b/arch/s390x/kernel/wrapper32.S	Mon Aug 26 11:10:46 2002
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
 
@@ -338,13 +338,13 @@
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
@@ -419,7 +419,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# __kernel_old_uid_emu31_t *
 	llgtr	%r4,%r4			# __kernel_old_gid_emu31_t *
-	jg	sys32_fchown16		# branch to system call
+	jg	sys_fchown16		# branch to system call
 
 	.globl  sys32_getpriority_wrapper 
 sys32_getpriority_wrapper:
@@ -619,12 +619,12 @@
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
@@ -771,14 +771,14 @@
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
@@ -808,14 +808,14 @@
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
@@ -889,7 +889,7 @@
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# __kernel_old_uid_emu31_t 
 	llgfr	%r4,%r4			# __kernel_old_gid_emu31_t 
-	jg	sys32_chown16		# branch to system call
+	jg	sys_chown16		# branch to system call
 
 	.globl  sys32_getcwd_wrapper 
 sys32_getcwd_wrapper:
diff -Nru a/include/asm-s390x/posix_types.h b/include/asm-s390x/posix_types.h
--- a/include/asm-s390x/posix_types.h	Mon Aug 26 11:10:46 2002
+++ b/include/asm-s390x/posix_types.h	Mon Aug 26 11:10:46 2002
@@ -37,8 +37,8 @@
 typedef unsigned short	__kernel_uid16_t;
 typedef unsigned short	__kernel_gid16_t;
 
-typedef __kernel_uid_t __kernel_old_uid_t;
-typedef __kernel_gid_t __kernel_old_gid_t;
+typedef __kernel_uid16_t __kernel_old_uid_t;
+typedef __kernel_gid16_t __kernel_old_gid_t;
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 

--------------020507020305080604010409--

