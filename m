Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbTJBBL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJBBL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:11:56 -0400
Received: from hockin.org ([66.35.79.110]:45060 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263058AbTJBBLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:11:36 -0400
Date: Wed, 1 Oct 2003 18:00:56 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IDEA: arch uid16 cleanup (was 'Many groups patch')
Message-ID: <20031002010056.GA7523@hockin.org>
References: <20031001202910.GA30014@hockin.org> <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 01:46:55PM -0700, Linus Torvalds wrote:
> On Wed, 1 Oct 2003, Tim Hockin wrote:
> > 
> > I'd love to put it in uid16.c, but uid16.c is not used by the 64-bit
> > architectures.
> 
> How about just putting it in "gid16.c" and then adding a CONFIG_GID16
> config variable. Then architectures that want it (pretty much all, no?)  
> can then obviously just do the
> 
> 	config GID16
> 		bool
> 		default y


So I dug deeper into the problem, and I think it can be solved relatively
painlessly.

First a few observations, based on grep:


* uid16_t is only used once: fs/smbfs/ioctl.c
* gid16_t is never used
* every arch defines uid16_t/gid16_t to unsigned short
* some arches define old_uid_t/old_gid_t the same as uid_t/gid_t, some don't
* ncpfs and smbfs use __kernel_old_uid_t
* old_uid_t and old_gid_t are only used in highuid.h and uid16.c
* every arch that defines UID16 defines old_uid_t and old_gid_t to ushort,
  except x86_64 (which I *think* is a bug)

So what I'm thinking is this:

1) convert uid16.c to use uid16_t and gid16_t, and NOT use highuid.h
2) build uid16.o iff CONFIG_UID16_SYSCALLS
3) anywhere that defines CONFIG_UID16 adds CONFIG_UID16_SYSCALLS
4) any 64-bit arch that wants uid16 stuff adds CONFIG_UID16_SYSCALLS

Now, the 16-bit forms of the syscalls are available to all the interested
parties.  Then we go through the arch stuff and remove all the duplicated
uid16 stuff, where ever possible.

This will leave highuid.h unmolested, so all dependants of that will still
work.

Here's the really simple patch, without removing any arch code, yet.  What's
the preferred way in Kconfig to identify the proper arrangement of this
idea?

Thoughts?  Can anyone (64bit arch people?) poke a hole in it?

Tim



===== arch/arm/Kconfig 1.38 vs edited =====
--- 1.38/arch/arm/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/arm/Kconfig	Wed Oct  1 17:47:12 2003
@@ -48,6 +48,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/arm26/Kconfig 1.9 vs edited =====
--- 1.9/arch/arm26/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/arm26/Kconfig	Wed Oct  1 17:47:32 2003
@@ -36,6 +36,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/cris/Kconfig 1.15 vs edited =====
--- 1.15/arch/cris/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/cris/Kconfig	Wed Oct  1 17:47:53 2003
@@ -11,6 +11,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/h8300/Kconfig 1.9 vs edited =====
--- 1.9/arch/h8300/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/h8300/Kconfig	Wed Oct  1 17:47:58 2003
@@ -19,6 +19,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/i386/Kconfig 1.86 vs edited =====
--- 1.86/arch/i386/Kconfig	Tue Sep 30 21:24:32 2003
+++ edited/arch/i386/Kconfig	Wed Oct  1 17:48:06 2003
@@ -23,6 +23,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config GENERIC_ISA_DMA
===== arch/ia64/Kconfig 1.46 vs edited =====
--- 1.46/arch/ia64/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/ia64/Kconfig	Wed Oct  1 17:41:45 2003
@@ -389,6 +389,7 @@
 config COMPAT
 	bool
 	depends on IA32_SUPPORT
+	select UID16_SYSCALLS
 	default y
 
 config PERFMON
===== arch/m68k/Kconfig 1.25 vs edited =====
--- 1.25/arch/m68k/Kconfig	Fri Sep 19 07:11:50 2003
+++ edited/arch/m68k/Kconfig	Wed Oct  1 17:48:17 2003
@@ -12,6 +12,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/m68knommu/Kconfig 1.22 vs edited =====
--- 1.22/arch/m68knommu/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/m68knommu/Kconfig	Wed Oct  1 17:48:21 2003
@@ -15,6 +15,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/s390/Kconfig 1.18 vs edited =====
--- 1.18/arch/s390/Kconfig	Thu Sep 11 20:19:35 2003
+++ edited/arch/s390/Kconfig	Wed Oct  1 17:45:09 2003
@@ -139,6 +139,7 @@
 config COMPAT
 	bool
 	depends on S390_SUPPORT
+	select UID16_SYSCALLS
 	default y
 
 config BINFMT_ELF32
===== arch/sh/Kconfig 1.20 vs edited =====
--- 1.20/arch/sh/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/sh/Kconfig	Wed Oct  1 17:48:59 2003
@@ -16,6 +16,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/sparc/Kconfig 1.22 vs edited =====
--- 1.22/arch/sparc/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/sparc/Kconfig	Wed Oct  1 17:49:03 2003
@@ -11,6 +11,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config HIGHMEM
===== arch/sparc64/Kconfig 1.36 vs edited =====
--- 1.36/arch/sparc64/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/sparc64/Kconfig	Wed Oct  1 17:45:47 2003
@@ -357,6 +357,7 @@
 config COMPAT
 	bool
 	depends on SPARC32_COMPAT
+	select UID16_SYSCALLS
 	default y
 
 config BINFMT_ELF32
===== arch/um/Kconfig 1.12 vs edited =====
--- 1.12/arch/um/Kconfig	Sun Jun 22 23:17:39 2003
+++ edited/arch/um/Kconfig	Wed Oct  1 17:49:10 2003
@@ -20,6 +20,7 @@
 
 config UID16
 	bool
+	select UID16_SYSCALLS
 	default y
 
 config RWSEM_GENERIC_SPINLOCK
===== arch/x86_64/Kconfig 1.32 vs edited =====
--- 1.32/arch/x86_64/Kconfig	Thu Sep 25 21:04:08 2003
+++ edited/arch/x86_64/Kconfig	Wed Oct  1 17:46:09 2003
@@ -383,6 +383,7 @@
 config UID16
 	bool
 	depends on IA32_EMULATION
+	select UID16_SYSCALLS
 	default y
 
 endmenu
===== include/asm-x86_64/posix_types.h 1.4 vs edited =====
--- 1.4/include/asm-x86_64/posix_types.h	Mon Sep 22 21:16:30 2003
+++ edited/include/asm-x86_64/posix_types.h	Wed Oct  1 17:18:28 2003
@@ -36,8 +36,8 @@
 	int	val[2];
 } __kernel_fsid_t;
 
-typedef __kernel_uid_t __kernel_old_uid_t;
-typedef __kernel_gid_t __kernel_old_gid_t;
+typedef unsigned short __kernel_old_uid_t;
+typedef unsigned short __kernel_old_gid_t;
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
===== kernel/Makefile 1.35 vs edited =====
--- 1.35/kernel/Makefile	Tue Sep  9 23:41:35 2003
+++ edited/kernel/Makefile	Wed Oct  1 16:54:58 2003
@@ -11,7 +11,7 @@
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
-obj-$(CONFIG_UID16) += uid16.o
+obj-$(CONFIG_UID16_SYSCALLS) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
===== kernel/uid16.c 1.5 vs edited =====
--- 1.5/kernel/uid16.c	Wed Apr  9 20:51:27 2003
+++ edited/kernel/uid16.c	Wed Oct  1 16:54:32 2003
@@ -11,11 +11,19 @@
 #include <linux/reboot.h>
 #include <linux/prctl.h>
 #include <linux/init.h>
-#include <linux/highuid.h>
 #include <linux/security.h>
+#include <linux/types.h>
 
 #include <asm/uaccess.h>
 
+/* duplicated from highuid.h, but not exposed */
+extern int overflowuid;
+extern int overflowgid;
+#define high2lowuid(uid) ((uid) > 65535 ? (uid16_t)overflowuid : (uid16_t)(uid))
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
 
@@ -97,19 +105,19 @@
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
 
-asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t __user *grouplist)
+asmlinkage long sys_getgroups16(int gidsetsize, gid16_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
+	gid16_t groups[NGROUPS];
 	int i,j;
 
 	if (gidsetsize < 0)
@@ -120,15 +128,15 @@
 			return -EINVAL;
 		for(j=0;j<i;j++)
 			groups[j] = current->groups[j];
-		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+		if (copy_to_user(grouplist, groups, sizeof(gid16_t)*i))
 			return -EFAULT;
 	}
 	return i;
 }
 
-asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t __user *grouplist)
+asmlinkage long sys_setgroups16(int gidsetsize, gid16_t __user *grouplist)
 {
-	old_gid_t groups[NGROUPS];
+	gid16_t groups[NGROUPS];
 	gid_t new_groups[NGROUPS];
 	int i;
 
@@ -136,7 +144,7 @@
 		return -EPERM;
 	if ((unsigned) gidsetsize > NGROUPS)
 		return -EINVAL;
-	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(old_gid_t)))
+	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(gid16_t)))
 		return -EFAULT;
 	for (i = 0 ; i < gidsetsize ; i++)
 		new_groups[i] = (gid_t)groups[i];

