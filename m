Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUETXpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUETXpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUETXpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:45:22 -0400
Received: from palrel11.hp.com ([156.153.255.246]:27870 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264770AbUETXo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:44:27 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16557.17112.488236.662911@napali.hpl.hp.com>
Date: Thu, 20 May 2004 16:44:24 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040520163026.64cc0421.akpm@osdl.org>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
	<20040519234106.52b6db78.davem@redhat.com>
	<16556.65456.624986.552865@napali.hpl.hp.com>
	<20040520120645.3accf048.akpm@osdl.org>
	<16557.1651.307484.282000@napali.hpl.hp.com>
	<20040520203532.A11902@infradead.org>
	<16557.4709.694265.314748@napali.hpl.hp.com>
	<20040520145658.3a7bf7df.akpm@osdl.org>
	<16557.11429.671546.228557@napali.hpl.hp.com>
	<20040520163026.64cc0421.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 20 May 2004 16:30:26 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> ppc64 is happy.

Great.

  Andrew> x86_64 is not happy:

OK, looks like I failed to remove WANT_STAT64.

  Andrew> sparc64 is not happy:

Ah, __sparc__ is defined even for sparc64, makes sense, but I didn't
account for it.

The attached patch should have these fixed.

	--david

Below is a patch that tries to sanitize the dropping of unneeded
system-call stubs in generic code.  In some instances, it would be
possible to move the optional system-call stubs into a library routine
which would avoid the need for #ifdefs, but in many cases, doing so
would require making several functions global (and possibly exporting
additional data-structures in header-files).  Furthermore, it would
inhibit (automatic) inlining in the cases in the cases where the stubs
are needed.  For these reasons, the patch keeps the #ifdef-approach.

This has been tested on ia64 and there were no objections from the
arch-maintainers (and one positive response).  The patch should be
safe but arch-maintainers may want to take a second look to see if
some __ARCH_WANT_foo macros should be removed for their architecture
(I'm quite sure that's the case, but I wanted to play it safe and only
preserved the status-quo in that regard).

===== fs/namespace.c 1.56 vs edited =====
--- 1.56/fs/namespace.c	Fri Apr 16 08:39:38 2004
+++ edited/fs/namespace.c	Thu May 20 14:56:37 2004
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 extern int __init init_rootfs(void);
 
@@ -406,6 +407,8 @@
 	return retval;
 }
 
+#ifdef __ARCH_WANT_SYS_OLDUMOUNT
+
 /*
  *	The 2.0 compatible umount. No flags. 
  */
@@ -414,6 +417,8 @@
 {
 	return sys_umount(name,0);
 }
+
+#endif
 
 static int mount_is_safe(struct nameidata *nd)
 {
===== fs/open.c 1.61 vs edited =====
--- 1.61/fs/open.c	Mon Apr 12 10:54:51 2004
+++ edited/fs/open.c	Thu May 20 14:56:37 2004
@@ -23,6 +23,8 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 
+#include <asm/unistd.h>
+
 int vfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int retval = -ENODEV;
@@ -335,7 +337,7 @@
 }
 #endif
 
-#if !(defined(__alpha__) || defined(__ia64__))
+#ifdef __ARCH_WANT_SYS_UTIME
 
 /*
  * sys_utime() can be implemented in user-level using sys_utimes().
===== fs/read_write.c 1.38 vs edited =====
--- 1.38/fs/read_write.c	Sun Apr 18 10:51:24 2004
+++ edited/fs/read_write.c	Thu May 20 14:56:37 2004
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
@@ -145,7 +146,7 @@
 }
 EXPORT_SYMBOL_GPL(sys_lseek);
 
-#if !defined(__alpha__)
+#ifdef __ARCH_WANT_SYS_LLSEEK
 asmlinkage long sys_llseek(unsigned int fd, unsigned long offset_high,
 			   unsigned long offset_low, loff_t __user * result,
 			   unsigned int origin)
===== fs/readdir.c 1.27 vs edited =====
--- 1.27/fs/readdir.c	Wed Mar 31 11:12:11 2004
+++ edited/fs/readdir.c	Thu May 20 14:56:37 2004
@@ -52,7 +52,7 @@
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
 #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
-#ifndef __ia64__
+#ifdef __ARCH_WANT_OLD_READDIR
 
 struct old_linux_dirent {
 	unsigned long	d_ino;
@@ -115,7 +115,7 @@
 	return error;
 }
 
-#endif /* !__ia64__ */
+#endif /* __ARCH_WANT_OLD_READDIR */
 
 /*
  * New, all-improved, singing, dancing, iBCS2-compliant getdents()
===== fs/stat.c 1.32 vs edited =====
--- 1.32/fs/stat.c	Wed Apr 14 18:37:52 2004
+++ edited/fs/stat.c	Thu May 20 14:56:37 2004
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
@@ -105,10 +106,7 @@
 
 EXPORT_SYMBOL(vfs_fstat);
 
-#if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
-  && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) \
-  && !defined(__arm__) && !defined(CONFIG_V850) && !defined(__powerpc64__) \
-  && !defined(__mips__)
+#ifdef __ARCH_WANT_OLD_STAT
 
 /*
  * For backward compatibility?  Maybe this should be moved
@@ -178,7 +176,7 @@
 	return error;
 }
 
-#endif
+#endif /* __ARCH_WANT_OLD_STAT */
 
 static int cp_new_stat(struct kstat *stat, struct stat __user *statbuf)
 {
@@ -284,7 +282,7 @@
 
 
 /* ---------- LFS-64 ----------- */
-#if !defined(__ia64__) && !defined(__mips64) && !defined(__x86_64__) && !defined(CONFIG_ARCH_S390X)
+#ifdef __ARCH_WANT_STAT64
 
 static long cp_new_stat64(struct kstat *stat, struct stat64 __user *statbuf)
 {
@@ -352,7 +350,7 @@
 	return error;
 }
 
-#endif /* LFS-64 */
+#endif /* __ARCH_WANT_STAT64 */
 
 void inode_add_bytes(struct inode *inode, loff_t bytes)
 {
===== include/asm-alpha/signal.h 1.7 vs edited =====
--- 1.7/include/asm-alpha/signal.h	Sun Sep 21 14:50:25 2003
+++ edited/include/asm-alpha/signal.h	Thu May 20 14:56:37 2004
@@ -187,7 +187,6 @@
 #include <asm/sigcontext.h>
 
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
-#define HAVE_ARCH_SYS_PAUSE
 
 #endif
 
===== include/asm-alpha/unistd.h 1.27 vs edited =====
--- 1.27/include/asm-alpha/unistd.h	Mon May 10 21:27:30 2004
+++ edited/include/asm-alpha/unistd.h	Thu May 20 14:34:36 2004
@@ -558,6 +558,19 @@
 
 #endif /* __LIBRARY__ && __GNUC__ */
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-arm/unistd.h 1.23 vs edited =====
--- 1.23/include/asm-arm/unistd.h	Sat Feb 28 01:40:59 2004
+++ edited/include/asm-arm/unistd.h	Thu May 20 14:34:50 2004
@@ -448,6 +448,25 @@
   __syscall_return(type,__res);						\
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-arm26/unistd.h 1.2 vs edited =====
--- 1.2/include/asm-arm26/unistd.h	Wed Feb 25 02:31:13 2004
+++ edited/include/asm-arm26/unistd.h	Thu May 20 14:35:09 2004
@@ -375,6 +375,30 @@
   __syscall_return(type,__res);								\
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-cris/unistd.h 1.14 vs edited =====
--- 1.14/include/asm-cris/unistd.h	Sat Feb 28 01:40:59 2004
+++ edited/include/asm-cris/unistd.h	Thu May 20 14:35:47 2004
@@ -279,7 +279,29 @@
 #define NR_syscalls 270
 
 
-
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
 
 #ifdef __KERNEL_SYSCALLS__
 
===== include/asm-h8300/unistd.h 1.6 vs edited =====
--- 1.6/include/asm-h8300/unistd.h	Mon Mar 15 22:50:10 2004
+++ edited/include/asm-h8300/unistd.h	Thu May 20 14:36:20 2004
@@ -446,6 +446,30 @@
 }
 		
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-i386/unistd.h 1.35 vs edited =====
--- 1.35/include/asm-i386/unistd.h	Wed Apr 21 14:35:58 2004
+++ edited/include/asm-i386/unistd.h	Thu May 20 14:36:43 2004
@@ -380,6 +380,30 @@
 __syscall_return(type,__res); \
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-ia64/signal.h 1.12 vs edited =====
--- 1.12/include/asm-ia64/signal.h	Fri Jan 23 10:52:25 2004
+++ edited/include/asm-ia64/signal.h	Thu May 20 14:56:52 2004
@@ -176,7 +176,6 @@
 #  include <asm/sigcontext.h>
 
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
-#define HAVE_ARCH_SYS_PAUSE
 
 #endif /* __KERNEL__ */
 
===== include/asm-ia64/unistd.h 1.42 vs edited =====
--- 1.42/include/asm-ia64/unistd.h	Thu May 20 14:05:34 2004
+++ edited/include/asm-ia64/unistd.h	Thu May 20 14:37:10 2004
@@ -261,7 +261,20 @@
 
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #define NR_syscalls			256 /* length of syscall table */
+
+#ifdef CONFIG_IA32_SUPPORT
+# define __ARCH_WANT_SYS_FADVISE64
+# define __ARCH_WANT_SYS_GETPGRP
+# define __ARCH_WANT_SYS_LLSEEK
+# define __ARCH_WANT_SYS_NICE
+# define __ARCH_WANT_SYS_OLD_GETRLIMIT
+# define __ARCH_WANT_SYS_OLDUMOUNT
+# define __ARCH_WANT_SYS_SIGPENDING
+# define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
===== include/asm-m68k/unistd.h 1.13 vs edited =====
--- 1.13/include/asm-m68k/unistd.h	Mon Mar 15 22:50:11 2004
+++ edited/include/asm-m68k/unistd.h	Thu May 20 14:37:34 2004
@@ -337,6 +337,30 @@
 __syscall_return(type,__res); \
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-m68knommu/unistd.h 1.6 vs edited =====
--- 1.6/include/asm-m68knommu/unistd.h	Mon Mar 15 22:50:11 2004
+++ edited/include/asm-m68knommu/unistd.h	Thu May 20 14:37:51 2004
@@ -372,6 +372,29 @@
   return (type)__res;								\
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
 
 #ifdef __KERNEL_SYSCALLS__
 
===== include/asm-mips/unistd.h 1.12 vs edited =====
--- 1.12/include/asm-mips/unistd.h	Wed Apr 21 14:35:59 2004
+++ edited/include/asm-mips/unistd.h	Thu May 20 14:38:30 2004
@@ -1045,6 +1045,30 @@
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+# ifndef __mips64
+#  define __ARCH_WANT_STAT64
+# endif
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-parisc/unistd.h 1.14 vs edited =====
--- 1.14/include/asm-parisc/unistd.h	Mon Mar 15 22:50:11 2004
+++ edited/include/asm-parisc/unistd.h	Thu May 20 14:39:00 2004
@@ -836,6 +836,27 @@
     return K_INLINE_SYSCALL(name, 6, arg1, arg2, arg3, arg4, arg5, arg6);	\
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
 
 #ifdef __KERNEL_SYSCALLS__
 
===== include/asm-ppc/unistd.h 1.31 vs edited =====
--- 1.31/include/asm-ppc/unistd.h	Wed Apr 21 14:35:59 2004
+++ edited/include/asm-ppc/unistd.h	Thu May 20 14:39:31 2004
@@ -380,6 +380,28 @@
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
 
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+
 /*
  * Forking from kernel space will result in the child getting a new,
  * empty kernel stack area.  Thus the child cannot access automatic
===== include/asm-ppc64/unistd.h 1.31 vs edited =====
--- 1.31/include/asm-ppc64/unistd.h	Wed Apr 21 14:35:59 2004
+++ edited/include/asm-ppc64/unistd.h	Thu May 20 14:39:56 2004
@@ -418,6 +418,27 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+
 unsigned long sys_mmap(unsigned long addr, size_t len, unsigned long prot,
 		       unsigned long flags, unsigned long fd, off_t offset);
 struct pt_regs;
===== include/asm-s390/unistd.h 1.26 vs edited =====
--- 1.26/include/asm-s390/unistd.h	Mon May 10 21:27:30 2004
+++ edited/include/asm-s390/unistd.h	Thu May 20 14:40:19 2004
@@ -512,6 +512,29 @@
 	__syscall_return(type,__res);			     \
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+# ifndef CONFIG_ARCH_S390X
+#   define __ARCH_WANT_STAT64
+# endif
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
===== include/asm-sh/unistd.h 1.10 vs edited =====
--- 1.10/include/asm-sh/unistd.h	Sat Feb 28 01:41:01 2004
+++ edited/include/asm-sh/unistd.h	Thu May 20 14:40:44 2004
@@ -400,6 +400,30 @@
 __syscall_return(type,__sc0); \
 }
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-sparc/unistd.h 1.32 vs edited =====
--- 1.32/include/asm-sparc/unistd.h	Wed Apr 21 14:36:00 2004
+++ edited/include/asm-sparc/unistd.h	Thu May 20 14:41:01 2004
@@ -431,6 +431,30 @@
 errno = -__res; \
 return -1; \
 }
+
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-sparc64/signal.h 1.11 vs edited =====
--- 1.11/include/asm-sparc64/signal.h	Thu Feb 26 22:27:45 2004
+++ edited/include/asm-sparc64/signal.h	Thu May 20 14:56:37 2004
@@ -253,8 +253,6 @@
 struct pt_regs;
 extern void ptrace_signal_deliver(struct pt_regs *regs, void *cookie);
 
-#define HAVE_ARCH_SYS_PAUSE
-
 #endif /* !(__KERNEL__) */
 
 #endif /* !(__ASSEMBLY__) */
===== include/asm-sparc64/unistd.h 1.30 vs edited =====
--- 1.30/include/asm-sparc64/unistd.h	Wed Apr 21 14:36:00 2004
+++ edited/include/asm-sparc64/unistd.h	Thu May 20 16:36:29 2004
@@ -474,6 +474,27 @@
 #define   _SC_JOB_CONTROL         6
 #define   _SC_SAVED_IDS           7
 #define   _SC_VERSION             8
+
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
 #endif
 
 /*
===== include/asm-um/unistd.h 1.4 vs edited =====
--- 1.4/include/asm-um/unistd.h	Wed Feb 25 02:31:13 2004
+++ edited/include/asm-um/unistd.h	Thu May 20 14:42:26 2004
@@ -12,6 +12,30 @@
 
 extern int um_execve(const char *file, char *const argv[], char *const env[]);
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-v850/unistd.h 1.9 vs edited =====
--- 1.9/include/asm-v850/unistd.h	Sat Feb 28 01:41:01 2004
+++ edited/include/asm-v850/unistd.h	Thu May 20 14:42:57 2004
@@ -386,6 +386,30 @@
 }
 		
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/compiler.h>
===== include/asm-x86_64/unistd.h 1.24 vs edited =====
--- 1.24/include/asm-x86_64/unistd.h	Wed Apr 21 14:36:00 2004
+++ edited/include/asm-x86_64/unistd.h	Thu May 20 16:35:14 2004
@@ -569,6 +569,29 @@
 	return (type) (res); \
 } while (0)
 
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SGETMASK
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#endif
+
 #ifndef __KERNEL_SYSCALLS__
 
 #define __syscall "syscall"
===== ipc/util.c 1.17 vs edited =====
--- 1.17/ipc/util.c	Mon Apr 12 10:54:15 2004
+++ edited/ipc/util.c	Thu May 20 14:56:37 2004
@@ -25,6 +25,8 @@
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
 
+#include <asm/unistd.h>
+
 #include "util.h"
 
 /**
@@ -507,7 +509,8 @@
 	return 0;
 }
 
-#if !defined(__ia64__) && !defined(__x86_64__) && !defined(__hppa__)
+#ifdef __ARCH_WANT_IPC_PARSE_VERSION
+
 
 /**
  *	ipc_parse_version	-	IPC call version
@@ -528,4 +531,4 @@
 	}
 }
 
-#endif /* __ia64__ */
+#endif /* __ARCH_WANT_IPC_PARSE_VERSION */
===== kernel/exit.c 1.132 vs edited =====
--- 1.132/kernel/exit.c	Tue Apr 13 08:46:49 2004
+++ edited/kernel/exit.c	Thu May 20 14:56:37 2004
@@ -24,6 +24,7 @@
 #include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
@@ -1157,8 +1158,7 @@
 	return retval;
 }
 
-#if !defined(__alpha__) && !defined(__ia64__) && \
-    !defined(__arm__) && !defined(__s390__)
+#ifdef __ARCH_WANT_SYS_WAITPID
 
 /*
  * sys_waitpid() remains for compatibility. waitpid() should be
===== kernel/sched.c 1.218 vs edited =====
--- 1.218/kernel/sched.c	Thu Apr 29 14:00:38 2004
+++ edited/kernel/sched.c	Thu May 20 14:56:37 2004
@@ -40,6 +40,8 @@
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 
+#include <asm/unistd.h>
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -2015,7 +2017,7 @@
 
 EXPORT_SYMBOL(set_user_nice);
 
-#ifndef __alpha__
+#ifdef __ARCH_WANT_SYS_NICE
 
 /*
  * sys_nice - change the priority of the current process.
===== kernel/signal.c 1.108 vs edited =====
--- 1.108/kernel/signal.c	Wed Apr 21 14:36:02 2004
+++ edited/kernel/signal.c	Thu May 20 14:56:37 2004
@@ -23,6 +23,7 @@
 #include <linux/ptrace.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm/siginfo.h>
 
 /*
@@ -2412,14 +2413,19 @@
 	return error;
 }
 
+#ifdef __ARCH_WANT_SYS_SIGPENDING
+
 asmlinkage long
 sys_sigpending(old_sigset_t __user *set)
 {
 	return do_sigpending(set, sizeof(*set));
 }
 
-#if !defined(__alpha__)
-/* Alpha has its own versions with special arguments.  */
+#endif
+
+#ifdef __ARCH_WANT_SYS_SIGPROCMASK
+/* Some platforms have their own version with special arguments others
+   support only sys_rt_sigprocmask.  */
 
 asmlinkage long
 sys_sigprocmask(int how, old_sigset_t __user *set, old_sigset_t __user *oset)
@@ -2501,8 +2507,8 @@
 #endif /* __sparc__ */
 #endif
 
-#if !defined(__alpha__) && !defined(__ia64__) && \
-    !defined(__arm__) && !defined(__s390__)
+#ifdef __ARCH_WANT_SYS_SGETMASK
+
 /*
  * For backwards compatibility.  Functionality superseded by sigprocmask.
  */
@@ -2528,10 +2534,9 @@
 
 	return old;
 }
-#endif /* !defined(__alpha__) */
+#endif /* __ARCH_WANT_SGETMASK */
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips__) && \
-    !defined(__arm__)
+#ifdef __ARCH_WANT_SYS_SIGNAL
 /*
  * For backwards compatibility.  Functionality superseded by sigaction.
  */
@@ -2548,9 +2553,9 @@
 
 	return ret ? ret : (unsigned long)old_sa.sa.sa_handler;
 }
-#endif /* !alpha && !__ia64__ && !defined(__mips__) && !defined(__arm__) */
+#endif /* __ARCH_WANT_SYS_SIGNAL */
 
-#ifndef HAVE_ARCH_SYS_PAUSE
+#ifdef __ARCH_WANT_SYS_PAUSE
 
 asmlinkage long
 sys_pause(void)
@@ -2560,7 +2565,7 @@
 	return -ERESTARTNOHAND;
 }
 
-#endif /* HAVE_ARCH_SYS_PAUSE */
+#endif
 
 void __init signals_init(void)
 {
===== kernel/sys.c 1.59 vs edited =====
--- 1.59/kernel/sys.c	Wed Apr 21 14:36:02 2004
+++ edited/kernel/sys.c	Thu May 20 14:56:37 2004
@@ -1056,12 +1056,16 @@
 	}
 }
 
+#ifdef __ARCH_WANT_SYS_GETPGRP
+
 asmlinkage long sys_getpgrp(void)
 {
 	/* SMP - assuming writes are word atomic this is fine */
 	return process_group(current);
 }
 
+#endif
+
 asmlinkage long sys_getsid(pid_t pid)
 {
 	if (!pid) {
@@ -1402,6 +1406,8 @@
 	return errno;
 }
 
+#ifdef __ARCH_WANT_SYS_GETHOSTNAME
+
 asmlinkage long sys_gethostname(char __user *name, int len)
 {
 	int i, errno;
@@ -1419,6 +1425,8 @@
 	return errno;
 }
 
+#endif
+
 /*
  * Only setdomainname; getdomainname can be implemented by calling
  * uname()
@@ -1453,7 +1461,7 @@
 			? -EFAULT : 0;
 }
 
-#if defined(COMPAT_RLIM_OLD_INFINITY) || !(defined(CONFIG_IA64) || defined(CONFIG_V850))
+#ifdef __ARCH_WANT_SYS_OLD_GETRLIMIT
 
 /*
  *	Back compatibility for getrlimit. Needed for some apps.
===== kernel/time.c 1.20 vs edited =====
--- 1.20/kernel/time.c	Wed Apr 21 14:36:02 2004
+++ edited/kernel/time.c	Thu May 20 14:56:37 2004
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 /* 
  * The timezone where the local system is located.  Used as a default by some
@@ -38,7 +39,7 @@
 
 EXPORT_SYMBOL(sys_tz);
 
-#if !defined(__alpha__) && !defined(__ia64__)
+#ifdef __ARCH_WANT_SYS_TIME
 
 /*
  * sys_time() can be implemented in user-level using
@@ -84,7 +85,7 @@
 	return 0;
 }
 
-#endif
+#endif /* __ARCH_WANT_SYS_TIME */
 
 asmlinkage long sys_gettimeofday(struct timeval __user *tv, struct timezone __user *tz)
 {
===== kernel/timer.c 1.79 vs edited =====
--- 1.79/kernel/timer.c	Thu Apr 29 14:00:38 2004
+++ edited/kernel/timer.c	Thu May 20 14:56:37 2004
@@ -33,6 +33,7 @@
 #include <linux/cpu.h>
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm/div64.h>
 #include <asm/timex.h>
 
@@ -918,7 +919,7 @@
 	update_times();
 }
 
-#if !defined(__alpha__) && !defined(__ia64__)
+#ifdef __ARCH_WANT_SYS_ALARM
 
 /*
  * For backwards compatibility?  This can be done in libc so Alpha
===== mm/fadvise.c 1.13 vs edited =====
--- 1.13/mm/fadvise.c	Fri Apr 30 21:28:49 2004
+++ edited/mm/fadvise.c	Thu May 20 14:56:37 2004
@@ -16,6 +16,8 @@
 #include <linux/pagevec.h>
 #include <linux/fadvise.h>
 
+#include <asm/unistd.h>
+
 /*
  * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
  * deactivate the pages and clear PG_Referenced.
@@ -98,8 +100,11 @@
 	return ret;
 }
 
+#ifdef __ARCH_WANT_SYS_FADVISE64
+
 asmlinkage long sys_fadvise64(int fd, loff_t offset, size_t len, int advice)
 {
 	return sys_fadvise64_64(fd, offset, len, advice);
 }
 
+#endif
===== net/socket.c 1.77 vs edited =====
--- 1.77/net/socket.c	Sat May  8 16:00:54 2004
+++ edited/net/socket.c	Thu May 20 14:56:37 2004
@@ -87,6 +87,8 @@
 #endif	/* CONFIG_NET_RADIO */
 
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
+
 #include <net/compat.h>
 
 #include <net/sock.h>
@@ -1817,6 +1819,8 @@
 	return err;
 }
 
+#ifdef __ARCH_WANT_SYS_SOCKETCALL
+
 /* Argument list sizes for sys_socketcall */
 #define AL(x) ((x) * sizeof(unsigned long))
 static unsigned char nargs[18]={AL(0),AL(3),AL(3),AL(3),AL(2),AL(3),
@@ -1909,6 +1913,8 @@
 	}
 	return err;
 }
+
+#endif /* __ARCH_WANT_SYS_SOCKETCALL */
 
 /*
  *	This function is called by a protocol handler that wants to

