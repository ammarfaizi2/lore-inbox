Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTAOGhf>; Wed, 15 Jan 2003 01:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTAOGhf>; Wed, 15 Jan 2003 01:37:35 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:29109 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265700AbTAOGh1>;
	Wed, 15 Jan 2003 01:37:27 -0500
Date: Wed, 15 Jan 2003 17:46:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_{old_}sigset_t mips64 part
Message-Id: <20030115174602.014aac4d.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the mips64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/mips64/kernel/signal32.c 2.5.58-32bit.5/arch/mips64/kernel/signal32.c
--- 2.5.58-32bit.4/arch/mips64/kernel/signal32.c	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.58-32bit.5/arch/mips64/kernel/signal32.c	2003-01-15 16:12:21.000000000 +1100
@@ -39,20 +39,13 @@
 
 /* 32-bit compatibility types */
 
-#define _NSIG32_BPW	32
-#define _NSIG32_WORDS	(_NSIG / _NSIG32_BPW)
-
-typedef struct {
-	unsigned int sig[_NSIG32_WORDS];
-} sigset32_t;
-
 typedef unsigned int __sighandler32_t;
 typedef void (*vfptr_t)(void);
 
 struct sigaction32 {
 	unsigned int		sa_flags;
 	__sighandler32_t	sa_handler;
-	sigset32_t		sa_mask;
+	compat_sigset_t		sa_mask;
 	unsigned int		sa_restorer;
 	int			sa_resv[1];     /* reserved */
 };
@@ -98,7 +91,7 @@
 extern void __get_sigset_unknown_nsig(void);
 
 static inline int
-put_sigset(const sigset_t *kbuf, sigset32_t *ubuf)
+put_sigset(const sigset_t *kbuf, compat_sigset_t *ubuf)
 {
 	int err = 0;
 
@@ -120,7 +113,7 @@
 }
 
 static inline int
-get_sigset(sigset_t *kbuf, const sigset32_t *ubuf)
+get_sigset(sigset_t *kbuf, const compat_sigset_t *ubuf)
 {
 	int err = 0;
 	unsigned long sig[4];
@@ -150,11 +143,11 @@
 asmlinkage inline int
 sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	compat_sigset_t *uset;
 	sigset_t newset, saveset;
 
 	save_static(&regs);
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (compat_sigset_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -178,17 +171,17 @@
 asmlinkage int
 sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	compat_sigset_t *uset;
 	sigset_t newset, saveset;
         size_t sigsetsize;
 
 	save_static(&regs);
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
-	if (sigsetsize != sizeof(sigset32_t))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (compat_sigset_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -704,8 +697,8 @@
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set,
 						old_sigset_t *oset);
 
-asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, 
-				 old_sigset_t32 *oset)
+asmlinkage int sys32_sigprocmask(int how, compat_old_sigset_t *set, 
+				 compat_old_sigset_t *oset)
 {
 	old_sigset_t s;
 	int ret;
@@ -723,7 +716,7 @@
 
 asmlinkage long sys_sigpending(old_sigset_t *set);
 
-asmlinkage int sys32_sigpending(old_sigset_t32 *set)
+asmlinkage int sys32_sigpending(compat_old_sigset_t *set)
 {
 	old_sigset_t pending;
 	int ret;
@@ -789,7 +782,7 @@
 asmlinkage long sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset,
 				   size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset32_t *set, sigset32_t *oset,
+asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset,
 				    unsigned int sigsetsize)
 {
 	sigset_t old_set, new_set;
@@ -812,7 +805,7 @@
 
 asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset32_t *uset, unsigned int sigsetsize)
+asmlinkage int sys32_rt_sigpending(compat_sigset_t *uset, unsigned int sigsetsize)
 {
 	int ret;
 	sigset_t set;
diff -ruN 2.5.58-32bit.4/include/asm-mips64/compat.h 2.5.58-32bit.5/include/asm-mips64/compat.h
--- 2.5.58-32bit.4/include/asm-mips64/compat.h	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-mips64/compat.h	2003-01-15 16:34:58.000000000 +1100
@@ -80,4 +80,11 @@
 	int		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;
+
+#define _COMPAT_NSIG		128
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.58-32bit.4/include/asm-mips64/signal.h 2.5.58-32bit.5/include/asm-mips64/signal.h
--- 2.5.58-32bit.4/include/asm-mips64/signal.h	2001-09-10 03:43:02.000000000 +1000
+++ 2.5.58-32bit.5/include/asm-mips64/signal.h	2003-01-15 14:59:25.000000000 +1100
@@ -20,7 +20,6 @@
 } sigset_t;
 
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
-typedef unsigned int old_sigset_t32;
 
 #define SIGHUP		 1	/* Hangup (POSIX).  */
 #define SIGINT		 2	/* Interrupt (ANSI).  */
