Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSK0Hgm>; Wed, 27 Nov 2002 02:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSK0Hgm>; Wed, 27 Nov 2002 02:36:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:11405 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261312AbSK0Hge>;
	Wed, 27 Nov 2002 02:36:34 -0500
Date: Wed, 27 Nov 2002 18:42:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: [PATCH] Start of compat32.h (again)
Message-Id: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

How's this one :-)

This patch does:
	introduces CONFIG_COMPAT32
	introduces linux/compat32.h - which contains only struct timespec32
		for now
	creates an architecture independent version of sys32_nanosleep
		in kernel/timer.c

I make the follwing assumptions:
	returning s32 from a 32 bit compatibility system call is the same
		as returning long or int.
	int == s32 on all 64 bit architectures

How does this look?  Should timespec32 be called compat32_timespec?
Should the new do_nanosleep function be inlined?

This patch has not even been compiled.  Please have a look and comment.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.49/arch/ia64/Kconfig 2.5.49-32bit.2/arch/ia64/Kconfig
--- 2.5.49/arch/ia64/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/ia64/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -397,6 +397,11 @@
 	  run IA-32 Linux binaries on an IA-64 Linux system.
 	  If in doubt, say Y.
 
+config COMPAT32
+	bool
+	depends on IA32_SUPPORT
+	default y
+
 config PERFMON
 	bool "Performance monitor support"
 	help
diff -ruN 2.5.49/arch/ia64/ia32/ia32_signal.c 2.5.49-32bit.2/arch/ia64/ia32/ia32_signal.c
--- 2.5.49/arch/ia64/ia32/ia32_signal.c	2002-10-31 14:05:10.000000000 +1100
+++ 2.5.49-32bit.2/arch/ia64/ia32/ia32_signal.c	2002-11-27 18:06:58.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/wait.h>
+#include <linux/compat32.h>
 
 #include <asm/uaccess.h>
 #include <asm/rse.h>
diff -ruN 2.5.49/arch/ia64/ia32/sys_ia32.c 2.5.49-32bit.2/arch/ia64/ia32/sys_ia32.c
--- 2.5.49/arch/ia64/ia32/sys_ia32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/ia64/ia32/sys_ia32.c	2002-11-27 18:06:58.000000000 +1100
@@ -49,6 +49,7 @@
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/ipc.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -1113,27 +1114,6 @@
 			    (struct timeval32 *) A(a.tvp));
 }
 
-extern asmlinkage long sys_nanosleep (struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage long
-sys32_nanosleep (struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (get_user (t.tv_sec, &rqtp->tv_sec) || get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs(old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (put_user(t.tv_sec, &rmtp->tv_sec) || put_user(t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 struct iovec32 { unsigned int iov_base; int iov_len; };
 asmlinkage ssize_t sys_readv (unsigned long,const struct iovec *,unsigned long);
 asmlinkage ssize_t sys_writev (unsigned long,const struct iovec *,unsigned long);
diff -ruN 2.5.49/arch/mips64/Kconfig 2.5.49-32bit.2/arch/mips64/Kconfig
--- 2.5.49/arch/mips64/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/mips64/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -371,6 +371,11 @@
 	  compatibility. Since all software available for Linux/MIPS is
 	  currently 32-bit you should say Y here.
 
+config COMPAT32
+	bool
+	depends on MIPS32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	bool
 	depends on MIPS32_COMPAT
diff -ruN 2.5.49/arch/mips64/kernel/linux32.c 2.5.49-32bit.2/arch/mips64/kernel/linux32.c
--- 2.5.49/arch/mips64/kernel/linux32.c	2002-10-21 01:02:44.000000000 +1000
+++ 2.5.49-32bit.2/arch/mips64/kernel/linux32.c	2002-11-27 18:06:58.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/personality.h>
 #include <linux/timex.h>
 #include <linux/dnotify.h>
+#include <linux/compat32.h>
 #include <net/sock.h>
 
 #include <asm/uaccess.h>
@@ -1205,11 +1206,6 @@
 
 
 
-struct timespec32 {
-	int 	tv_sec;
-	int	tv_nsec;
-};
-
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid,
 						struct timespec *interval);
 
@@ -1230,31 +1226,6 @@
 }
 
 
-extern asmlinkage int sys_nanosleep(struct timespec *rqtp,
-				    struct timespec *rmtp); 
-
-asmlinkage int
-sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (__put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 struct tms32 {
 	int tms_utime;
 	int tms_stime;
diff -ruN 2.5.49/arch/parisc/Kconfig 2.5.49-32bit.2/arch/parisc/Kconfig
--- 2.5.49/arch/parisc/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/parisc/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -107,6 +107,11 @@
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config COMPAT32
+	bool
+	depends PARISC64
+	default y
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
diff -ruN 2.5.49/arch/parisc/kernel/sys_parisc32.c 2.5.49-32bit.2/arch/parisc/kernel/sys_parisc32.c
--- 2.5.49/arch/parisc/kernel/sys_parisc32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/parisc/kernel/sys_parisc32.c	2002-11-27 18:06:58.000000000 +1100
@@ -52,6 +52,7 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -584,11 +585,6 @@
 }
 #endif /* CONFIG_SYSCTL */
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 static int
 put_timespec32(struct timespec32 *u, struct timespec *t)
 {
@@ -598,28 +594,6 @@
 	return copy_to_user(u, &t32, sizeof t32);
 }
 
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	struct timespec32 t32;
-	int ret;
-	extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-	
-	if (copy_from_user(&t32, rqtp, sizeof t32))
-		return -EFAULT;
-	t.tv_sec = t32.tv_sec;
-	t.tv_nsec = t32.tv_nsec;
-
-	DBG(("sys32_nanosleep({%d, %d})\n", t32.tv_sec, t32.tv_nsec));
-
-	KERNEL_SYSCALL(ret, sys_nanosleep, &t, rmtp ? &t : NULL);
-	if (rmtp && ret == -EINTR) {
-		if (put_timespec32(rmtp, &t))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 asmlinkage long sys32_sched_rr_get_interval(pid_t pid,
 	struct timespec32 *interval)
 {
diff -ruN 2.5.49/arch/ppc64/Kconfig 2.5.49-32bit.2/arch/ppc64/Kconfig
--- 2.5.49/arch/ppc64/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.49-32bit.2/arch/ppc64/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -33,6 +33,10 @@
 	bool
 	default y
 
+config COMPAT32
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -ruN 2.5.49/arch/ppc64/kernel/signal32.c 2.5.49-32bit.2/arch/ppc64/kernel/signal32.c
--- 2.5.49/arch/ppc64/kernel/signal32.c	2002-10-21 01:02:45.000000000 +1000
+++ 2.5.49-32bit.2/arch/ppc64/kernel/signal32.c	2002-11-27 18:06:58.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/elf.h>
+#include <linux/compat32.h>
 #include <asm/ppc32.h>
 #include <asm/uaccess.h>
 #include <asm/ppcdebug.h>
@@ -53,11 +54,6 @@
 #define MSR_USERCHANGE	0
 #endif
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-
 struct sigregs32 {
 	/*
 	 * the gp_regs array is 32 bit representation of the pt_regs
diff -ruN 2.5.49/arch/ppc64/kernel/sys_ppc32.c 2.5.49-32bit.2/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.49/arch/ppc64/kernel/sys_ppc32.c	2002-10-21 01:02:45.000000000 +1000
+++ 2.5.49-32bit.2/arch/ppc64/kernel/sys_ppc32.c	2002-11-27 18:06:58.000000000 +1100
@@ -53,6 +53,7 @@
 #include <linux/mman.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -1774,37 +1775,6 @@
 
 
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-
-extern asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage long sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (__put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	
-	return ret;
-}
-
-
-
-
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
 {
diff -ruN 2.5.49/arch/s390x/Kconfig 2.5.49-32bit.2/arch/s390x/Kconfig
--- 2.5.49/arch/s390x/Kconfig	2002-11-11 14:55:28.000000000 +1100
+++ 2.5.49-32bit.2/arch/s390x/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -117,6 +117,11 @@
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
+config COMPAT32
+	bool
+	depends on S390_SUPPORT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 31 bit ELF binaries"
 	depends on S390_SUPPORT
diff -ruN 2.5.49/arch/s390x/kernel/linux32.c 2.5.49-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.49/arch/s390x/kernel/linux32.c	2002-10-21 01:02:45.000000000 +1000
+++ 2.5.49-32bit.2/arch/s390x/kernel/linux32.c	2002-11-27 18:06:58.000000000 +1100
@@ -57,6 +57,7 @@
 #include <linux/icmpv6.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -1774,11 +1775,6 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
 asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
@@ -1796,28 +1792,6 @@
 	return ret;
 }
 
-extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (__put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
 
 asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, old_sigset_t32 *oset)
diff -ruN 2.5.49/arch/s390x/kernel/wrapper32.S 2.5.49-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.49/arch/s390x/kernel/wrapper32.S	2002-10-08 12:02:40.000000000 +1000
+++ 2.5.49-32bit.2/arch/s390x/kernel/wrapper32.S	2002-11-27 18:06:58.000000000 +1100
@@ -759,8 +759,8 @@
 
 	.globl  sys32_nanosleep_wrapper 
 sys32_nanosleep_wrapper:
-	llgtr	%r2,%r2			# struct timespec_emu31 *
-	llgtr	%r3,%r3			# struct timespec_emu31 *
+	llgtr	%r2,%r2			# struct timespec32 *
+	llgtr	%r3,%r3			# struct timespec32 *
 	jg	sys32_nanosleep		# branch to system call
 
 	.globl  sys32_mremap_wrapper 
diff -ruN 2.5.49/arch/sparc64/Kconfig 2.5.49-32bit.2/arch/sparc64/Kconfig
--- 2.5.49/arch/sparc64/Kconfig	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.49-32bit.2/arch/sparc64/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -352,6 +352,11 @@
 	  This allows you to run 32-bit binaries on your Ultra.
 	  Everybody wants this; say Y.
 
+config COMPAT32
+	bool
+	depends on SPARC32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
diff -ruN 2.5.49/arch/sparc64/kernel/sys_sparc32.c 2.5.49-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.49/arch/sparc64/kernel/sys_sparc32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.49-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2002-11-27 18:06:58.000000000 +1100
@@ -51,6 +51,7 @@
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
 #include <linux/dnotify.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -1794,11 +1795,6 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
 asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
@@ -1816,28 +1812,6 @@
 	return ret;
 }
 
-extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (__put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
 
 asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, old_sigset_t32 *oset)
diff -ruN 2.5.49/arch/x86_64/Kconfig 2.5.49-32bit.2/arch/x86_64/Kconfig
--- 2.5.49/arch/x86_64/Kconfig	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.49-32bit.2/arch/x86_64/Kconfig	2002-11-27 18:06:58.000000000 +1100
@@ -425,6 +425,11 @@
 	  turn this on, unless you're 100% sure that you don't have any 32bit programs
 	  left.
 
+config COMPAT32
+	bool
+	depends on IA32_EMULATION
+	default y
+
 endmenu
 
 source "drivers/mtd/Kconfig"
diff -ruN 2.5.49/arch/x86_64/ia32/sys_ia32.c 2.5.49-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.49/arch/x86_64/ia32/sys_ia32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.49-32bit.2/arch/x86_64/ia32/sys_ia32.c	2002-11-27 18:06:58.000000000 +1100
@@ -58,6 +58,7 @@
 #include <linux/binfmts.h>
 #include <linux/init.h>
 #include <linux/aio_abi.h>
+#include <linux/compat32.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -934,36 +935,6 @@
 			    (struct timeval32 *)A(a.tvp));
 }
 
-struct timespec32 {
-	int 	tv_sec;
-	int	tv_nsec;
-};
-
-extern asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp); 
-
-asmlinkage long
-sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (verify_area(VERIFY_READ, rqtp, sizeof(struct timespec32)) ||
-	    __get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (verify_area(VERIFY_WRITE, rmtp, sizeof(struct timespec32)) ||
-		    __put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 asmlinkage ssize_t sys_readv(unsigned long,const struct iovec *,unsigned long);
 asmlinkage ssize_t sys_writev(unsigned long,const struct iovec *,unsigned long);
 
diff -ruN 2.5.49/include/asm-ia64/ia32.h 2.5.49-32bit.2/include/asm-ia64/ia32.h
--- 2.5.49/include/asm-ia64/ia32.h	2002-10-31 14:06:05.000000000 +1100
+++ 2.5.49-32bit.2/include/asm-ia64/ia32.h	2002-11-27 18:06:58.000000000 +1100
@@ -41,11 +41,6 @@
 #define IA32_CLOCKS_PER_SEC	100	/* Cast in stone for IA32 Linux */
 #define IA32_TICK(tick)		((unsigned long long)(tick) * IA32_CLOCKS_PER_SEC / CLOCKS_PER_SEC)
 
-struct timespec32 {
-	int	tv_sec;
-	int	tv_nsec;
-};
-
 /* fcntl.h */
 struct flock32 {
        short l_type;
diff -ruN 2.5.49/include/linux/compat32.h 2.5.49-32bit.2/include/linux/compat32.h
--- 2.5.49/include/linux/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.49-32bit.2/include/linux/compat32.h	2002-11-27 18:06:58.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _LINUX_COMPAT32_H
+#define _LINUX_COMPAT32_H
+/*
+ * These are the type definitions for the 32 compatibility
+ * layer on 64 bit architectures.
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_COMPAT32
+
+struct timespec32 {
+	s32	tv_sec;
+	s32	tv_nsec;
+};
+
+#endif /* CONFIG_COMPAT32 */
+#endif /* _LINUX_COMPAT32_H */
diff -ruN 2.5.49/kernel/timer.c 2.5.49-32bit.2/kernel/timer.c
--- 2.5.49/kernel/timer.c	2002-11-18 15:47:56.000000000 +1100
+++ 2.5.49-32bit.2/kernel/timer.c	2002-11-27 18:06:58.000000000 +1100
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/compat32.h>
 
 #include <asm/uaccess.h>
 
@@ -1024,33 +1025,63 @@
 	return current->pid;
 }
 
-asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+static long do_nanosleep(struct timespec *t)
 {
-	struct timespec t;
 	unsigned long expire;
 
-	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
-		return -EFAULT;
-
-	if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
+	if ((t->tv_nsec >= 1000000000L) || (t->tv_nsec < 0) || (t->tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+	expire = timespec_to_jiffies(t) + (t->tv_sec || t->tv_nsec);
 
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
 	if (expire) {
-		if (rmtp) {
-			jiffies_to_timespec(expire, &t);
-			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
-				return -EFAULT;
-		}
+		jiffies_to_timespec(expire, t);
 		return -EINTR;
 	}
 	return 0;
 }
 
+asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	long ret;
+
+	if (copy_from_user(&t, rqtp, sizeof(t)))
+		return -EFAULT;
+
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		if (copy_to_user(rmtp, &t, sizeof(t)))
+			return -EFAULT;
+	}
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT32
+asmlinkage s32 sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
+{
+	struct timespec t;
+	struct timespec32 t32;
+	long ret;
+
+	if (copy_from_user(&t32, rqtp, sizeof(t32)))
+		return -EFAULT;
+	t.tv_sec = t32.tv_sec;
+	t.tv_nsec = t32.tv_nsec;
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		t32.tv_sec = t.tv_sec;
+		t32.tv_nsec = t.tv_nsec;
+		if (copy_to_user(rmtp, &t32, sizeof(t32)))
+			return -EFAULT;
+	}
+	return ret;
+}
+#endif /* CONFIG_COMPAT32 */
+
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
