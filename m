Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSFQFwn>; Mon, 17 Jun 2002 01:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSFQFwm>; Mon, 17 Jun 2002 01:52:42 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:20477 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316755AbSFQFwk>;
	Mon, 17 Jun 2002 01:52:40 -0400
Date: Mon, 17 Jun 2002 15:51:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] [TRIVIAL] Consolidate sys_pause
Message-Id: <20020617155159.07c9bde8.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

14 of our 17 architectures define sys_pause exactly the same
way.  The other three don't define it at all.  I assume glibc
translates pause() into sigsuspend() or something.

Anyway, this patch consolidates sys_pause.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.22/arch/arm/kernel/sys_arm.c 2.5.22-sfr.1/arch/arm/kernel/sys_arm.c
--- 2.5.22/arch/arm/kernel/sys_arm.c	Sat May 18 22:59:42 2002
+++ 2.5.22-sfr.1/arch/arm/kernel/sys_arm.c	Mon Jun 17 15:10:00 2002
@@ -279,10 +279,3 @@
 out:
 	return error;
 }
-
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/cris/kernel/sys_cris.c 2.5.22-sfr.1/arch/cris/kernel/sys_cris.c
--- 2.5.22/arch/cris/kernel/sys_cris.c	Thu Jan 31 09:59:33 2002
+++ 2.5.22-sfr.1/arch/cris/kernel/sys_cris.c	Mon Jun 17 15:10:58 2002
@@ -167,12 +167,3 @@
 		return -EINVAL;
 	}
 }
-
-/* apparently this is legacy - if we don't need this in Linux/CRIS we can remove it. */
-
-asmlinkage int sys_pause(void)
-{
-        current->state = TASK_INTERRUPTIBLE;
-        schedule();
-        return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/i386/kernel/sys_i386.c 2.5.22-sfr.1/arch/i386/kernel/sys_i386.c
--- 2.5.22/arch/i386/kernel/sys_i386.c	Fri Mar 30 17:23:57 2001
+++ 2.5.22-sfr.1/arch/i386/kernel/sys_i386.c	Mon Jun 17 15:11:46 2002
@@ -246,11 +246,3 @@
 
 	return error;
 }
-
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
diff -ruN 2.5.22/arch/m68k/kernel/sys_m68k.c 2.5.22-sfr.1/arch/m68k/kernel/sys_m68k.c
--- 2.5.22/arch/m68k/kernel/sys_m68k.c	Wed Jul  4 11:15:07 2001
+++ 2.5.22-sfr.1/arch/m68k/kernel/sys_m68k.c	Mon Jun 17 15:12:11 2002
@@ -676,13 +676,3 @@
 {
 	return PAGE_SIZE;
 }
-
-/*
- * Old cruft
- */
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/mips/kernel/sysmips.c 2.5.22-sfr.1/arch/mips/kernel/sysmips.c
--- 2.5.22/arch/mips/kernel/sysmips.c	Wed Jul  4 11:15:08 2001
+++ 2.5.22-sfr.1/arch/mips/kernel/sysmips.c	Mon Jun 17 15:12:46 2002
@@ -156,10 +156,3 @@
 {
 	return -ENOSYS;
 }
-
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/mips64/kernel/syscall.c 2.5.22-sfr.1/arch/mips64/kernel/syscall.c
--- 2.5.22/arch/mips64/kernel/syscall.c	Sat May 18 22:59:43 2002
+++ 2.5.22-sfr.1/arch/mips64/kernel/syscall.c	Mon Jun 17 15:13:58 2002
@@ -273,10 +273,3 @@
 {
 	do_exit(SIGSEGV);
 }
-
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/parisc/kernel/sys_parisc.c 2.5.22-sfr.1/arch/parisc/kernel/sys_parisc.c
--- 2.5.22/arch/parisc/kernel/sys_parisc.c	Fri Mar 30 17:23:58 2001
+++ 2.5.22-sfr.1/arch/parisc/kernel/sys_parisc.c	Mon Jun 17 15:14:26 2002
@@ -37,13 +37,6 @@
 	return error;
 }
 
-int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 int sys_mmap(unsigned long addr, unsigned long len,
 		unsigned long prot, unsigned long flags, unsigned long fd,
 		unsigned long offset)
diff -ruN 2.5.22/arch/ppc/kernel/syscalls.c 2.5.22-sfr.1/arch/ppc/kernel/syscalls.c
--- 2.5.22/arch/ppc/kernel/syscalls.c	Mon Jun  3 12:16:58 2002
+++ 2.5.22-sfr.1/arch/ppc/kernel/syscalls.c	Mon Jun 17 15:14:49 2002
@@ -257,13 +257,6 @@
 	return sys_select(n, inp, outp, exp, tvp);
 }
 
-int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 int sys_uname(struct old_utsname * name)
 {
 	int err = -EFAULT;
diff -ruN 2.5.22/arch/ppc64/kernel/syscalls.c 2.5.22-sfr.1/arch/ppc64/kernel/syscalls.c
--- 2.5.22/arch/ppc64/kernel/syscalls.c	Wed Feb 20 16:36:39 2002
+++ 2.5.22-sfr.1/arch/ppc64/kernel/syscalls.c	Mon Jun 17 15:17:23 2002
@@ -227,17 +227,6 @@
 	return ret;
 }
 
-asmlinkage int sys_pause(void)
-{
-	
-	PPCDBG(PPCDBG_SYS64X, "sys_pause - entered - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	
-	PPCDBG(PPCDBG_SYS64X, "sys_pause - exited - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-	return -ERESTARTNOHAND;
-}
-
 static int __init set_fakeppc(char *str)
 {
 	if (*str)
diff -ruN 2.5.22/arch/s390/kernel/sys_s390.c 2.5.22-sfr.1/arch/s390/kernel/sys_s390.c
--- 2.5.22/arch/s390/kernel/sys_s390.c	Fri Mar 30 17:23:59 2001
+++ 2.5.22-sfr.1/arch/s390/kernel/sys_s390.c	Mon Jun 17 15:15:08 2002
@@ -241,13 +241,6 @@
 	return error;
 }
 
-asmlinkage int sys_pause(void)
-{
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
 {
   return -ENOSYS;
diff -ruN 2.5.22/arch/s390x/kernel/sys_s390.c 2.5.22-sfr.1/arch/s390x/kernel/sys_s390.c
--- 2.5.22/arch/s390x/kernel/sys_s390.c	Mon Jun 10 23:13:43 2002
+++ 2.5.22-sfr.1/arch/s390x/kernel/sys_s390.c	Mon Jun 17 15:15:50 2002
@@ -197,13 +197,6 @@
 	return err?-EFAULT:0;
 }
 
-asmlinkage int sys_pause(void)
-{
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 extern asmlinkage int sys_newuname(struct new_utsname * name);
 
 asmlinkage int s390x_newuname(struct new_utsname * name)
diff -ruN 2.5.22/arch/sh/kernel/sys_sh.c 2.5.22-sfr.1/arch/sh/kernel/sys_sh.c
--- 2.5.22/arch/sh/kernel/sys_sh.c	Wed Oct 24 16:12:21 2001
+++ 2.5.22-sfr.1/arch/sh/kernel/sys_sh.c	Mon Jun 17 15:16:20 2002
@@ -231,10 +231,3 @@
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
-
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
diff -ruN 2.5.22/arch/sparc/kernel/sys_sparc.c 2.5.22-sfr.1/arch/sparc/kernel/sys_sparc.c
--- 2.5.22/arch/sparc/kernel/sys_sparc.c	Sun Apr 29 06:16:37 2001
+++ 2.5.22-sfr.1/arch/sparc/kernel/sys_sparc.c	Mon Jun 17 15:16:50 2002
@@ -442,14 +442,6 @@
 	return ret;
 }
 
-/* Just in case some old old binary calls this. */
-asmlinkage int sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 asmlinkage int sys_getdomainname(char *name, int len)
 {
  	int nlen;
diff -ruN 2.5.22/arch/x86_64/kernel/sys_x86_64.c 2.5.22-sfr.1/arch/x86_64/kernel/sys_x86_64.c
--- 2.5.22/arch/x86_64/kernel/sys_x86_64.c	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.1/arch/x86_64/kernel/sys_x86_64.c	Mon Jun 17 15:17:51 2002
@@ -105,13 +105,6 @@
 	return err ? -EFAULT : 0;
 }
 
-asmlinkage long sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	return -ERESTARTNOHAND;
-}
-
 asmlinkage long wrap_sys_shmat(int shmid, char *shmaddr, int shmflg)
 {
 	unsigned long raddr;
diff -ruN 2.5.22/include/asm-alpha/signal.h 2.5.22-sfr.1/include/asm-alpha/signal.h
--- 2.5.22/include/asm-alpha/signal.h	Thu May 30 09:44:38 2002
+++ 2.5.22-sfr.1/include/asm-alpha/signal.h	Mon Jun 17 15:20:30 2002
@@ -187,6 +187,7 @@
 #include <asm/sigcontext.h>
 
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+#define HAVE_ARCH_SYS_PAUSE
 
 #endif
 
diff -ruN 2.5.22/include/asm-ia64/signal.h 2.5.22-sfr.1/include/asm-ia64/signal.h
--- 2.5.22/include/asm-ia64/signal.h	Thu May 30 09:44:38 2002
+++ 2.5.22-sfr.1/include/asm-ia64/signal.h	Mon Jun 17 15:21:15 2002
@@ -167,6 +167,7 @@
 #  include <asm/sigcontext.h>
 
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+#define HAVE_ARCH_SYS_PAUSE
 
 #endif /* __KERNEL__ */
 
diff -ruN 2.5.22/include/asm-sparc64/signal.h 2.5.22-sfr.1/include/asm-sparc64/signal.h
--- 2.5.22/include/asm-sparc64/signal.h	Thu May 30 09:44:39 2002
+++ 2.5.22-sfr.1/include/asm-sparc64/signal.h	Mon Jun 17 15:22:14 2002
@@ -254,6 +254,7 @@
 } stack_t32;
 
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+#define HAVE_ARCH_SYS_PAUSE
 
 #endif
 
diff -ruN 2.5.22/kernel/signal.c 2.5.22-sfr.1/kernel/signal.c
--- 2.5.22/kernel/signal.c	Thu May 30 09:44:39 2002
+++ 2.5.22-sfr.1/kernel/signal.c	Mon Jun 17 15:08:52 2002
@@ -1467,3 +1467,15 @@
 	return ret ? ret : (unsigned long)old_sa.sa.sa_handler;
 }
 #endif /* !alpha && !__ia64__ && !defined(__mips__) && !defined(__arm__) */
+
+#ifndef HAVE_ARCH_SYS_PAUSE
+
+asmlinkage int
+sys_pause(void)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	return -ERESTARTNOHAND;
+}
+
+#endif /* HAVE_ARCH_SYS_PAUSE */
