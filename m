Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTBLEUC>; Tue, 11 Feb 2003 23:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBLEUC>; Tue, 11 Feb 2003 23:20:02 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:20411 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266645AbTBLETu>;
	Tue, 11 Feb 2003 23:19:50 -0500
Date: Wed, 12 Feb 2003 15:29:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, matthew@wil.cx
Subject: [PATCH][COMPAT] outstanding compatibility changes 1/4 parisc
Message-Id: <20030212152927.77384c95.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

At Linux Conf AU, Willy asked me to send any further parisc compatibility
changes directly to you, so this is what I have outstanding.  Basically,
it is just the uses of compat_sigset_t that seemed to have been missed in
the previous merges.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60/arch/parisc/kernel/binfmt_elf32.c 2.5.60-32bit.1/arch/parisc/kernel/binfmt_elf32.c
--- 2.5.60/arch/parisc/kernel/binfmt_elf32.c	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.60-32bit.1/arch/parisc/kernel/binfmt_elf32.c	2003-02-11 12:21:29.000000000 +1100
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/elfcore.h>
-#include <linux/compat.h>
+#include <linux/compat.h>		/* struct compat_timeval */
 
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
diff -ruN 2.5.60/arch/parisc/kernel/signal.c 2.5.60-32bit.1/arch/parisc/kernel/signal.c
--- 2.5.60/arch/parisc/kernel/signal.c	2003-02-11 09:39:14.000000000 +1100
+++ 2.5.60-32bit.1/arch/parisc/kernel/signal.c	2003-02-11 12:21:29.000000000 +1100
@@ -25,6 +25,7 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
+#include <linux/compat.h>
 #include <asm/ucontext.h>
 #include <asm/rt_sigframe.h>
 #include <asm/uaccess.h>
@@ -97,13 +98,13 @@
 	sigset_t saveset, newset;
 #ifdef __LP64__
 	/* XXX FIXME -- assumes 32-bit user app! */
-	sigset_t32 newset32;
+	compat_sigset_t newset32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t32))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
-	if (copy_from_user(&newset32, (sigset_t32 *)unewset, sizeof(newset32)))
+	if (copy_from_user(&newset32, (compat_sigset_t *)unewset, sizeof(newset32)))
 		return -EFAULT;
 
 	newset.sig[0] = newset32.sig[0] | ((unsigned long)newset32.sig[1] << 32);
diff -ruN 2.5.60/arch/parisc/kernel/signal32.c 2.5.60-32bit.1/arch/parisc/kernel/signal32.c
--- 2.5.60/arch/parisc/kernel/signal32.c	2003-02-11 09:39:14.000000000 +1100
+++ 2.5.60-32bit.1/arch/parisc/kernel/signal32.c	2003-02-11 12:21:29.000000000 +1100
@@ -18,22 +18,22 @@
 };
 
 static inline void
-sigset_32to64(sigset_t *s64, sigset_t32 *s32)
+sigset_32to64(sigset_t *s64, compat_sigset_t *s32)
 {
 	s64->sig[0] = s32->sig[0] | ((unsigned long)s32->sig[1] << 32);
 }
 
 static inline void
-sigset_64to32(sigset_t32 *s32, sigset_t *s64)
+sigset_64to32(compat_sigset_t *s32, sigset_t *s64)
 {
 	s32->sig[0] = s64->sig[0] & 0xffffffffUL;
 	s32->sig[1] = (s64->sig[0] >> 32) & 0xffffffffUL;
 }
 
 static int
-put_sigset32(sigset_t32 *up, sigset_t *set, size_t sz)
+put_sigset32(compat_sigset_t *up, sigset_t *set, size_t sz)
 {
-	sigset_t32 s;
+	compat_sigset_t s;
 
 	if (sz != sizeof *set) panic("put_sigset32()");
 	sigset_64to32(&s, set);
@@ -42,9 +42,9 @@
 }
 
 static int
-get_sigset32(sigset_t32 *up, sigset_t *set, size_t sz)
+get_sigset32(compat_sigset_t *up, sigset_t *set, size_t sz)
 {
-	sigset_t32 s;
+	compat_sigset_t s;
 	int r;
 
 	if (sz != sizeof *set) panic("put_sigset32()");
@@ -56,7 +56,7 @@
 	return r;
 }
 
-int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset,
+int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset,
 				    unsigned int sigsetsize)
 {
 	extern long sys_rt_sigprocmask(int how,
@@ -78,7 +78,7 @@
 }
 
 
-int sys32_rt_sigpending(sigset_t32 *uset, unsigned int sigsetsize)
+int sys32_rt_sigpending(compat_sigset_t *uset, unsigned int sigsetsize)
 {
 	int ret;
 	sigset_t set;
diff -ruN 2.5.60/arch/parisc/kernel/sys32.h 2.5.60-32bit.1/arch/parisc/kernel/sys32.h
--- 2.5.60/arch/parisc/kernel/sys32.h	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.60-32bit.1/arch/parisc/kernel/sys32.h	2003-02-11 12:21:29.000000000 +1100
@@ -14,15 +14,10 @@
 
 typedef __u32 __sighandler_t32;
 
-#include <linux/signal.h>
-typedef struct {
-	unsigned int sig[_NSIG_WORDS * 2];
-} sigset_t32;
-
 struct sigaction32 {
 	__sighandler_t32 sa_handler;
 	unsigned int sa_flags;
-	sigset_t32 sa_mask;		/* mask last for extensibility */
+	compat_sigset_t sa_mask;		/* mask last for extensibility */
 };
 
 #endif
