Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUECUqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUECUqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUECUqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:46:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:5849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263975AbUECUph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:45:37 -0400
Date: Mon, 3 May 2004 13:42:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>
cc: bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <16534.35355.671554.321611@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org>
 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org>
 <16534.35355.671554.321611@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



How about this patch? Tested on x86 ("make allyesconfig") and the default 
G5 ppc64 config, and likely to work at least on alpha too, since I took 
the silly definitions from there. Others should be trivial to fix up.

Rule: every architecture needs to implement its own kernel "execve()" 
function some way. Everything else is done by the architecture-independent 
<linux/unistd.h> translation layer.

The only change here is that this makes "open()" and friends depend on the
"sys_open()" and friends EXPORT's for modules. Right now it appears that
sys_open/sys_lseek/sys_read are all EXPORT_SYMBOL_GPL's. That sounds
pretty insane anyway (it's not like we can claim that "sys_open()" is some
_internal_ interface), so I'd be inclined to just change them all to
regular EXPORT_SYMBOL's.

(Yes, I realize that we want to _deprecate_ the use of open/read/lseek etc
from modules, but that's different from claiming that they are somehow
GPL-only things. If anything, we should deprecate them from our own 
_internal_ GPL usage _first_ rather than last).

Comments? To me, this is a pretty clear cleanup (and I left the old 
_syscallX() crud alone, even though we could remove it now entirely).

		Linus


------
===== include/asm-alpha/unistd.h 1.27 vs edited =====
--- 1.27/include/asm-alpha/unistd.h	Sat May  1 11:01:54 2004
+++ edited/include/asm-alpha/unistd.h	Mon May  3 13:01:53 2004
@@ -560,70 +560,8 @@
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/signal.h>
-#include <linux/syscalls.h>
-#include <asm/ptrace.h>
-
-static inline long open(const char * name, int mode, int flags)
-{
-	return sys_open(name, mode, flags);
-}
-
-static inline long dup(int fd)
-{
-	return sys_dup(fd);
-}
-
-static inline long close(int fd)
-{
-	return sys_close(fd);
-}
-
-static inline off_t lseek(int fd, off_t off, int whence)
-{
-	return sys_lseek(fd, off, whence);
-}
-
-static inline void _exit(int value)
-{
-	sys_exit(value);
-}
-
-#define exit(x) _exit(x)
-
-static inline long write(int fd, const char * buf, size_t nr)
-{
-	return sys_write(fd, buf, nr);
-}
-
-static inline long read(int fd, char * buf, size_t nr)
-{
-	return sys_read(fd, buf, nr);
-}
-
+/* This needs a small assembly stub */
 extern long execve(char *, char **, char **);
-
-static inline long setsid(void)
-{
-	return sys_setsid();
-}
-
-static inline pid_t waitpid(int pid, int * wait_stat, int flags)
-{
-	return sys_wait4(pid, wait_stat, flags, NULL);
-}
-
-asmlinkage int sys_execve(char *ufilename, char **argv, char **envp,
-			unsigned long a3, unsigned long a4, unsigned long a5,
-			struct pt_regs regs);
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize,
-				void *restorer);
 
 #endif /* __KERNEL_SYSCALLS__ */
 
===== include/asm-i386/unistd.h 1.35 vs edited =====
--- 1.35/include/asm-i386/unistd.h	Mon Apr 12 10:54:15 2004
+++ edited/include/asm-i386/unistd.h	Mon May  3 13:22:49 2004
@@ -382,49 +382,17 @@
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
-
-/*
- * we need this inline - forking from kernel space will result
- * in NO COPY ON WRITE (!!!), until an execve is executed. This
- * is no problem, but for the stack. This is handled by not letting
- * main() use the stack at all after fork(). Thus, no function
- * calls - which means inline code for fork too, as otherwise we
- * would use the stack upon exit from 'fork()'.
- *
- * Actually only pause and fork are needed inline, so that there
- * won't be any messing with the stack from main(), but we define
- * some others too.
- */
-static inline _syscall0(pid_t,setsid)
-static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static inline _syscall1(int,dup,int,fd)
-static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-static inline _syscall1(int,close,int,fd)
-static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount);
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long pgoff);
-asmlinkage int sys_execve(struct pt_regs regs);
-asmlinkage int sys_clone(struct pt_regs regs);
-asmlinkage int sys_fork(struct pt_regs regs);
-asmlinkage int sys_vfork(struct pt_regs regs);
-asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_iopl(unsigned long unused);
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
+static inline int execve(const char *file, char **argv, char **envp)
+{
+	long __res;
+	__asm__ volatile ("int $0x80"
+		: "=a" (__res)
+		: "0" (__NR_execve),
+		  "b" (file),
+		  "c" (argv),
+		  "d" (envp));
+	return __res;
+}
 
 #endif
 
===== include/linux/unistd.h 1.1 vs edited =====
--- 1.1/include/linux/unistd.h	Tue Feb  5 09:39:39 2002
+++ edited/include/linux/unistd.h	Mon May  3 13:20:51 2004
@@ -8,4 +8,32 @@
  */
 #include <asm/unistd.h>
 
+#ifdef __KERNEL_SYSCALLS__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/syscalls.h>
+
+static inline long open(const char * name, int mode, int flags)
+{
+	return sys_open((const char __user *) name, mode, flags);
+}
+
+static inline long close(int fd)
+{
+	return sys_close(fd);
+}
+
+static inline off_t lseek(int fd, off_t off, int whence)
+{
+	return sys_lseek(fd, off, whence);
+}
+
+static inline long read(int fd, char * buf, size_t nr)
+{
+	return sys_read(fd, (char __user *) buf, nr);
+}
+
+#endif /* __KERNEL_SYSCALLS__ */
+
 #endif /* _LINUX_UNISTD_H_ */
