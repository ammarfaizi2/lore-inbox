Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSJQSon>; Thu, 17 Oct 2002 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261785AbSJQSon>; Thu, 17 Oct 2002 14:44:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:5639 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261744AbSJQSoX>; Thu, 17 Oct 2002 14:44:23 -0400
Date: Thu, 17 Oct 2002 19:50:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove sys_security
Message-ID: <20021017195015.A4747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been auditing the LSM stuff a bit more..

They have registered an implemented a syscall, sys_security
that does nothing but switch into the individual modules
based on the first argument, i.e. it's ioctl() switching
on the security module instead of device node.  Yuck.

Patch below removes it (no intree users), maybe selinux/etc
folks should send their actual syscall for review instead..


--- 1.1/Documentation/DocBook/lsm.tmpl	Tue Oct  8 23:48:29 2002
+++ edited/Documentation/DocBook/lsm.tmpl	Thu Oct 17 20:40:19 2002
@@ -203,29 +203,6 @@
 permission when accessing an inode.
 </para>
 
-<para>
-LSM adds a general <function>security</function> system call that
-simply invokes the <function>sys_security</function> hook.  This
-system call and hook permits security modules to implement new system
-calls for security-aware applications.  The interface is similar to
-socketcall, but also has an <parameter>id</parameter> to help identify
-the security module whose call is being invoked.  
-To eliminate the need for a central registry of ids,
-the recommended convention for creating the hexadecimal id value is:
-<programlisting>
-<![CDATA[
- echo "Name_of_module" | md5sum | cut -c -8
-]]>
-</programlisting>
-C code will need to prefix this result with ``0x''.
-For example, the id for ``SGI Trusted Linux'' could be used in C as:
-<programlisting>
-<![CDATA[
- #define SYS_SECURITY_MODID 0xc4c7be22
-]]>
-</programlisting>
-</para>
-
 </sect1>
 
 <sect1 id="cap"><title>LSM Capabilities Module</title>
--- 1.2/arch/alpha/kernel/systbls.S	Tue Oct 15 15:12:07 2002
+++ edited/arch/alpha/kernel/systbls.S	Thu Oct 17 20:27:19 2002
@@ -398,7 +398,7 @@
 	.quad sys_getdents64
 	.quad sys_gettid
 	.quad sys_readahead
-	.quad sys_ni_syscall			/* 380, sys_security */
+	.quad sys_ni_syscall			/* 380 */
 	.quad sys_tkill
 	.quad sys_setxattr
 	.quad sys_lsetxattr
--- 1.7/arch/arm/kernel/calls.S	Tue Jul 30 00:08:08 2002
+++ edited/arch/arm/kernel/calls.S	Thu Oct 17 20:23:02 2002
@@ -237,7 +237,7 @@
 /* 220 */	.long	sys_madvise
 		.long	sys_fcntl64
 		.long	sys_ni_syscall /* TUX */
-		.long	sys_security
+		.long	sys_ni_syscall
 		.long	sys_gettid
 /* 225 */	.long	sys_readahead
 		.long	sys_setxattr
--- 1.38/arch/i386/kernel/entry.S	Tue Oct 15 23:45:51 2002
+++ edited/arch/i386/kernel/entry.S	Thu Oct 17 20:23:47 2002
@@ -706,7 +706,7 @@
 	.long sys_getdents64	/* 220 */
 	.long sys_fcntl64
 	.long sys_ni_syscall	/* reserved for TUX */
-	.long sys_security	/* reserved for Security */
+	.long sys_ni_syscall
 	.long sys_gettid
 	.long sys_readahead	/* 225 */
 	.long sys_setxattr
--- 1.21/arch/ia64/kernel/entry.S	Wed Sep 18 08:22:09 2002
+++ edited/arch/ia64/kernel/entry.S	Thu Oct 17 20:23:54 2002
@@ -1241,7 +1241,7 @@
 	data8 sys_futex				// 1230
 	data8 sys_sched_setaffinity
 	data8 sys_sched_getaffinity
-	data8 sys_security
+	data8 sys_ni_syscall
 	data8 sys_alloc_hugepages
 	data8 sys_free_hugepages		// 1235
 	data8 sys_exit_group
--- 1.28/arch/ppc/kernel/misc.S	Mon Oct  7 09:26:07 2002
+++ edited/arch/ppc/kernel/misc.S	Thu Oct 17 20:25:12 2002
@@ -1293,7 +1293,7 @@
 	.long sys_futex
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
-	.long sys_security
+	.long sys_ni_syscall
 	.long sys_ni_syscall	/* 225 - reserved for Tux */
 	.long sys_sendfile64
 	.long sys_io_setup
--- 1.28/arch/ppc64/kernel/misc.S	Fri Oct 11 09:09:17 2002
+++ edited/arch/ppc64/kernel/misc.S	Thu Oct 17 20:25:33 2002
@@ -729,7 +729,7 @@
 	.llong .sys_futex
 	.llong .sys32_sched_setaffinity
 	.llong .sys32_sched_getaffinity
-	.llong .sys_security
+	.llong .sys_ni_syscall
 	.llong .sys_ni_syscall		/* 225 - reserved for tux */
 	.llong .sys32_sendfile64
 	.llong .sys_ni_syscall		/* reserved for sys_io_setup */
@@ -972,7 +972,7 @@
 	.llong .sys_futex
 	.llong .sys_sched_setaffinity
 	.llong .sys_sched_getaffinity
-	.llong .sys_security
+	.llong .sys_ni_syscall
 	.llong .sys_ni_syscall		/* 225 - reserved for tux */
 	.llong .sys_ni_syscall		/* 32bit only sendfile64 */
 	.llong .sys_io_setup
--- 1.20/arch/s390/kernel/entry.S	Wed Oct  9 16:01:41 2002
+++ edited/arch/s390/kernel/entry.S	Thu Oct 17 20:24:06 2002
@@ -588,7 +588,7 @@
 	.long  sys_futex
 	.long  sys_sched_setaffinity
 	.long  sys_sched_getaffinity	 /* 240 */
-	.long  sys_security
+	.long  sys_ni_syscall
 	.long  sys_ni_syscall		 /* reserved for TUX */
 	.long  sys_io_setup
 	.long  sys_io_destroy
--- 1.18/arch/s390x/kernel/entry.S	Wed Oct  9 16:01:41 2002
+++ edited/arch/s390x/kernel/entry.S	Thu Oct 17 20:24:13 2002
@@ -617,7 +617,7 @@
 	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
-	.long  SYSCALL(sys_security,sys_ni_syscall)
+	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* reserved for TUX */
 	.long  SYSCALL(sys_io_setup,sys_ni_syscall)
 	.long  SYSCALL(sys_io_destroy,sys_ni_syscall)
--- 1.13/arch/sparc/kernel/systbls.S	Wed Oct 16 11:07:05 2002
+++ edited/arch/sparc/kernel/systbls.S	Thu Oct 17 20:25:50 2002
@@ -49,7 +49,7 @@
 /*140*/	.long sys_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys_getrlimit
 /*145*/	.long sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
 /*150*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
-/*155*/	.long sys_fcntl64, sys_security, sys_statfs, sys_fstatfs, sys_oldumount
+/*155*/	.long sys_fcntl64, sys_ni_syscall, sys_statfs, sys_fstatfs, sys_oldumount
 /*160*/	.long sys_sched_setaffinity, sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 /*165*/	.long sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_setxattr
 /*170*/	.long sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys_getdents
--- 1.18/arch/sparc64/kernel/systbls.S	Wed Oct 16 11:07:05 2002
+++ edited/arch/sparc64/kernel/systbls.S	Thu Oct 17 20:26:12 2002
@@ -50,7 +50,7 @@
 /*140*/	.word sys32_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
-	.word sys32_fcntl64, sys_security, sys32_statfs, sys32_fstatfs, sys_oldumount
+	.word sys32_fcntl64, sys_ni_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
 /*160*/	.word sys32_sched_setaffinity, sys32_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
@@ -109,7 +109,7 @@
 /*140*/	.word sys_sendfile64, sys_getpeername, sys_futex, sys_gettid, sys_getrlimit
 	.word sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
 /*150*/	.word sys_getsockname, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
-	.word sys_nis_syscall, sys_security, sys_statfs, sys_fstatfs, sys_oldumount
+	.word sys_nis_syscall, sys_ni_syscall, sys_statfs, sys_fstatfs, sys_oldumount
 /*160*/	.word sys_sched_setaffinity, sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_utrap_install
 	.word sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys_getdents
--- 1.2/arch/um/kernel/sys_call_table.c	Mon Sep 23 18:52:51 2002
+++ edited/arch/um/kernel/sys_call_table.c	Thu Oct 17 20:26:40 2002
@@ -215,7 +215,6 @@
 extern syscall_handler_t sys_madvise;
 extern syscall_handler_t sys_fcntl64;
 extern syscall_handler_t sys_getdents64;
-extern syscall_handler_t sys_security;
 extern syscall_handler_t sys_gettid;
 extern syscall_handler_t sys_readahead;
 extern syscall_handler_t sys_tkill;
@@ -451,7 +450,6 @@
 	[ __NR_fstat64 ] = sys_fstat64,
 	[ __NR_fcntl64 ] = sys_fcntl64,
 	[ __NR_getdents64 ] = sys_getdents64,
-        [ __NR_security ] = sys_security,
 	[ __NR_gettid ] = sys_gettid,
 	[ __NR_readahead ] = sys_readahead,
 	[ __NR_setxattr ] = sys_ni_syscall,
--- 1.12/include/asm-alpha/unistd.h	Wed Oct  9 03:37:43 2002
+++ edited/include/asm-alpha/unistd.h	Thu Oct 17 20:32:16 2002
@@ -317,7 +317,7 @@
 #define __NR_getdents64			377
 #define __NR_gettid			378
 #define __NR_readahead			379
-#define __NR_security			380 /* syscall for security modules */
+/* 380 is unused */
 #define __NR_tkill			381
 #define __NR_setxattr			382
 #define __NR_lsetxattr			383
--- 1.13/include/asm-arm/unistd.h	Fri Oct  4 22:52:32 2002
+++ edited/include/asm-arm/unistd.h	Thu Oct 17 20:29:02 2002
@@ -247,7 +247,7 @@
 #define __NR_madvise			(__NR_SYSCALL_BASE+220)
 #define __NR_fcntl64			(__NR_SYSCALL_BASE+221)
 					/* 222 for tux */
-#define __NR_security			(__NR_SYSCALL_BASE+223)
+					/* 223 is unused */
 #define __NR_gettid			(__NR_SYSCALL_BASE+224)
 #define __NR_readahead			(__NR_SYSCALL_BASE+225)
 #define __NR_setxattr			(__NR_SYSCALL_BASE+226)
--- 1.9/include/asm-cris/unistd.h	Fri Oct  4 23:03:40 2002
+++ edited/include/asm-cris/unistd.h	Thu Oct 17 20:29:09 2002
@@ -227,7 +227,7 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
-#define __NR_security           223     /* syscall for security modules */
+/* 223 is unused */
 #define __NR_gettid             224
 #define __NR_readahead          225
 #define __NR_tkill              226
--- 1.17/include/asm-i386/unistd.h	Tue Oct 15 23:45:52 2002
+++ edited/include/asm-i386/unistd.h	Thu Oct 17 20:29:16 2002
@@ -227,7 +227,7 @@
 #define __NR_madvise1		219	/* delete when C lib stub is removed */
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
-#define __NR_security		223	/* syscall for security modules */
+/* 223 is unused */
 #define __NR_gettid		224
 #define __NR_readahead		225
 #define __NR_setxattr		226
--- 1.15/include/asm-ia64/unistd.h	Fri Oct  4 22:56:14 2002
+++ edited/include/asm-ia64/unistd.h	Thu Oct 17 20:29:34 2002
@@ -222,7 +222,7 @@
 #define __NR_futex			1230
 #define __NR_sched_setaffinity		1231
 #define __NR_sched_getaffinity		1232
-#define __NR_security			1233
+/* 1233 currently unused */
 #define __NR_alloc_hugepages		1234
 #define __NR_free_hugepages		1235
 #define __NR_exit_group			1236
--- 1.16/include/asm-ppc/unistd.h	Fri Oct  4 22:53:51 2002
+++ edited/include/asm-ppc/unistd.h	Thu Oct 17 20:29:49 2002
@@ -228,7 +228,7 @@
 #define __NR_futex		221
 #define __NR_sched_setaffinity	222
 #define __NR_sched_getaffinity	223
-#define __NR_security		224
+/* 224 currently unused */
 #define __NR_tuxcall		225
 #define __NR_sendfile64		226
 #define __NR_io_setup		227
--- 1.10/include/asm-ppc64/unistd.h	Fri Oct  4 22:53:45 2002
+++ edited/include/asm-ppc64/unistd.h	Thu Oct 17 20:29:57 2002
@@ -233,7 +233,7 @@
 #define __NR_futex		221
 #define __NR_sched_setaffinity	222     
 #define __NR_sched_getaffinity	223
-#define __NR_security		224
+/* 224 currently unused */
 #define __NR_tuxcall		225
 #define __NR_sendfile64		226
 #define __NR_io_setup		227
--- 1.9/include/asm-s390/unistd.h	Fri Oct  4 22:53:57 2002
+++ edited/include/asm-s390/unistd.h	Thu Oct 17 20:30:21 2002
@@ -231,7 +231,9 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
-#define __NR_security		241	/* syscall for security modules */
+/*
+ * Number 241 is currently unused
+ */
 /*
  * Number 242 is reserved for tux
  */
--- 1.10/include/asm-s390x/unistd.h	Fri Oct  4 22:54:02 2002
+++ edited/include/asm-s390x/unistd.h	Thu Oct 17 20:30:31 2002
@@ -198,7 +198,9 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
-#define __NR_security		241	/* syscall for security modules */
+/*
+ * Number 241 is currently unused
+ */
 /*
  * Number 242 is reserved for tux
  */
--- 1.16/include/asm-sparc/unistd.h	Wed Oct 16 11:07:05 2002
+++ edited/include/asm-sparc/unistd.h	Thu Oct 17 20:31:14 2002
@@ -171,7 +171,7 @@
 #define __NR_poll               153 /* Common                                      */
 #define __NR_getdents64		154 /* Linux specific				   */
 #define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
-#define __NR_security           156 /* getdirentries under SunOS                   */
+/* #define __NR_getdirentires 	156    SunOS Specific                              */
 #define __NR_statfs             157 /* Common                                      */
 #define __NR_fstatfs            158 /* Common                                      */
 #define __NR_umount             159 /* Common                                      */
--- 1.15/include/asm-sparc64/unistd.h	Wed Oct 16 11:07:05 2002
+++ edited/include/asm-sparc64/unistd.h	Thu Oct 17 20:31:44 2002
@@ -171,7 +171,7 @@
 #define __NR_poll               153 /* Common                                      */
 #define __NR_getdents64		154 /* Linux specific				   */
 /* #define __NR_fcntl64         155    Linux sparc32 Specific                      */
-#define __NR_security           156 /* getdirentries under SunOS                   */
+/* #define __NR_getdirentries   156    SunOS Specific                              */
 #define __NR_statfs             157 /* Common                                      */
 #define __NR_fstatfs            158 /* Common                                      */
 #define __NR_umount             159 /* Common                                      */
--- 1.7/include/asm-x86_64/unistd.h	Sat Oct 12 01:52:39 2002
+++ edited/include/asm-x86_64/unistd.h	Thu Oct 17 20:32:12 2002
@@ -426,8 +426,7 @@
 #define __NR_tuxcall      		184 /* reserved for tux */
 __SYSCALL(__NR_tuxcall, sys_ni_syscall)
 
-#define __NR_security			185 /* reserved for LSM/security */
-__SYSCALL(__NR_security, sys_ni_syscall)
+/* 165 currently unused */
 
 #define __NR_gettid		186
 __SYSCALL(__NR_gettid, sys_gettid)
--- 1.4/include/linux/security.h	Tue Oct  8 11:20:18 2002
+++ edited/include/linux/security.h	Thu Oct 17 20:21:00 2002
@@ -671,21 +671,6 @@
  *	@tsk contains the task_struct for the process.
  *	@cap contains the capability <include/linux/capability.h>.
  *	Return 0 if the capability is granted for @tsk.
- * @sys_security:
- *	Security modules may use this hook to implement new system calls for
- *	security-aware applications.  The interface is similar to socketcall,
- *	but with an @id parameter to help identify the security module whose
- *	call is being invoked.  The module is responsible for interpreting the
- *	parameters, and must copy in the @args array from user space if it is
- *	used.
- *	The recommended convention for creating the hexadecimal @id value is
- *	echo "Name_of_module" | md5sum | cut -c -8; by using this convention,
- *	there is no need for a central registry.
- *	@id contains the security module identifier.
- *	@call contains the call value.
- *	@args contains the call arguments (user space pointer).
- *	The module should return -ENOSYS if it does not implement any new
- *	system calls.
  *
  * @register_security:
  * 	allow module stacking.
@@ -713,8 +698,6 @@
 			    kernel_cap_t * permitted);
 	int (*acct) (struct file * file);
 	int (*capable) (struct task_struct * tsk, int cap);
-	int (*sys_security) (unsigned int id, unsigned call,
-			     unsigned long *args);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 
--- 1.6/security/capability.c	Tue Oct  8 11:01:30 2002
+++ edited/security/capability.c	Thu Oct 17 20:21:40 2002
@@ -31,12 +31,6 @@
 		return -EPERM;
 }
 
-static int cap_sys_security (unsigned int id, unsigned int call,
-			     unsigned long *args)
-{
-	return -ENOSYS;
-}
-
 static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -731,7 +725,6 @@
 	.capset_set =			cap_capset_set,
 	.acct =				cap_acct,
 	.capable =			cap_capable,
-	.sys_security =			cap_sys_security,
 	.quotactl =			cap_quotactl,
 	.quota_on =			cap_quota_on,
 
--- 1.7/security/dummy.c	Tue Oct  8 11:01:30 2002
+++ edited/security/dummy.c	Thu Oct 17 20:21:31 2002
@@ -61,12 +61,6 @@
 	return -EPERM;
 }
 
-static int dummy_sys_security (unsigned int id, unsigned int call,
-			       unsigned long *args)
-{
-	return -ENOSYS;
-}
-
 static int dummy_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -546,7 +540,6 @@
 	.capset_set =			dummy_capset_set,
 	.acct =				dummy_acct,
 	.capable =			dummy_capable,
-	.sys_security =			dummy_sys_security,
 	.quotactl =			dummy_quotactl,
 	.quota_on =			dummy_quota_on,
 
--- 1.2/security/security.c	Wed Aug 28 22:52:56 2002
+++ edited/security/security.c	Thu Oct 17 20:21:20 2002
@@ -223,24 +223,6 @@
 	return 1;
 }
 
-/**
- * sys_security - security syscall multiplexor.
- * @id: module id
- * @call: call identifier
- * @args: arg list for call
- *
- * Similar to sys_socketcall.  Can use id to help identify which module user
- * app is talking to.  The recommended convention for creating the
- * hexadecimal id value is:
- * 'echo "Name_of_module" | md5sum | cut -c -8'.
- * By following this convention, there's no need for a central registry.
- */
-asmlinkage long sys_security (unsigned int id, unsigned int call,
-			      unsigned long *args)
-{
-	return security_ops->sys_security (id, call, args);
-}
-
 EXPORT_SYMBOL_GPL(register_security);
 EXPORT_SYMBOL_GPL(unregister_security);
 EXPORT_SYMBOL_GPL(mod_reg_security);
