Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCLABe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCLABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:01:34 -0500
Received: from dp.samba.org ([66.70.73.150]:46742 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261851AbUCLAB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:01:29 -0500
Date: Fri, 12 Mar 2004 10:56:35 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ppc64 in kernel syscalls
Message-ID: <20040311235635.GF16751@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thanks to some great debugging work by Olaf Hering and Marcus Meissner
it has been noticed that the current ppc64 syscall code is corrupting
4 bytes past errno. Why we even bothered to set errno beats me, its
unusable in the kernel.

Since we had to reinstate the inline syscall code we can go back to
using it for those few syscalls that we call. Especially now with 
Randy's syscall prototype cleanup we should be calling them directly
but we can do that sometime later.

Anton

===== arch/ppc64/kernel/misc.S 1.76 vs edited =====
--- 1.76/arch/ppc64/kernel/misc.S	Mon Mar  1 13:24:56 2004
+++ edited/arch/ppc64/kernel/misc.S	Fri Mar 12 10:08:58 2004
@@ -565,35 +565,6 @@
 	ld	r30,-16(r1)
 	blr
 
-	.section	".toc","aw"
-.SYSCALL_ERRNO:
-	.tc errno[TC],errno
-
-	.section	".text"
-	.align 3
-	
-#define SYSCALL(name) \
-_GLOBAL(name) \
-	li	r0,__NR_##name; \
-	sc; \
-	bnslr; \
-	ld	r4,.SYSCALL_ERRNO@toc(2); \
-	std	r3,0(r4); \
-	li	r3,-1; \
-	blr
-
-#define __NR__exit __NR_exit
-
-SYSCALL(setsid)
-SYSCALL(open)
-SYSCALL(read)
-SYSCALL(write)
-SYSCALL(lseek)
-SYSCALL(close)
-SYSCALL(dup)
-SYSCALL(execve)
-SYSCALL(waitpid)
-
 #ifdef CONFIG_PPC_ISERIES	/* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
 #endif
===== include/asm-ppc64/unistd.h 1.28 vs edited =====
--- 1.28/include/asm-ppc64/unistd.h	Thu Feb 26 16:42:07 2004
+++ edited/include/asm-ppc64/unistd.h	Fri Mar 12 10:20:24 2004
@@ -399,15 +399,19 @@
 /*
  * System call prototypes.
  */
-extern pid_t setsid(void);
-extern int write(int fd, const char *buf, off_t count);
-extern int read(int fd, char *buf, off_t count);
-extern off_t lseek(int fd, off_t offset, int count);
-extern int dup(int fd);
-extern int execve(const char *file, char **argv, char **envp);
-extern int open(const char *file, int flag, int mode);
-extern int close(int fd);
-extern pid_t waitpid(pid_t pid, int *wait_stat, int options);
+static inline _syscall3(int, execve, __const__ char *, file, char **, argv,
+			char **,envp)
+static inline _syscall3(int, open, __const__ char *, file, int, flag, int, mode)
+static inline _syscall1(int, close, int, fd)
+static inline _syscall1(int, dup, int, fd)
+static inline _syscall3(int, read, int, fd, char *, buf , off_t, count)
+static inline _syscall3(int, write, int, fd, __const__ char *, buf, off_t,
+			count)
+static inline _syscall0(pid_t, setsid)
+static inline _syscall3(off_t, lseek, int, fd, off_t, offset, int, count)
+static inline _syscall3(pid_t, waitpid, pid_t, pid, int *, wait_stat, int,
+			options)
+
 #endif /* __KERNEL_SYSCALLS__ */
 
 asmlinkage unsigned long sys_mmap(unsigned long addr, size_t len,
