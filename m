Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTAOGi4>; Wed, 15 Jan 2003 01:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTAOGiz>; Wed, 15 Jan 2003 01:38:55 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:36789 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265711AbTAOGit>;
	Wed, 15 Jan 2003 01:38:49 -0500
Date: Wed, 15 Jan 2003 17:47:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: torvalds@transmeta.com, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][COMPAT] compat_{old_}sigset_t parisc part
Message-Id: <20030115174733.5b486b56.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part of the patch.

Thanks for catching up with the rest.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/parisc/kernel/signal.c 2.5.58-32bit.5/arch/parisc/kernel/signal.c
--- 2.5.58-32bit.4/arch/parisc/kernel/signal.c	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.58-32bit.5/arch/parisc/kernel/signal.c	2003-01-14 17:14:45.000000000 +1100
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
diff -ruN 2.5.58-32bit.4/arch/parisc/kernel/signal32.c 2.5.58-32bit.5/arch/parisc/kernel/signal32.c
--- 2.5.58-32bit.4/arch/parisc/kernel/signal32.c	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.58-32bit.5/arch/parisc/kernel/signal32.c	2003-01-15 14:49:04.000000000 +1100
@@ -17,19 +17,17 @@
 	struct sigaction32 sa;
 };
 
-typedef unsigned int old_sigset_t32;
-
 static int
-put_old_sigset32(old_sigset_t32 *up, old_sigset_t *set)
+put_old_sigset32(compat_old_sigset_t *up, old_sigset_t *set)
 {
-	old_sigset_t32 set32 = *set;
+	compat_old_sigset_t set32 = *set;
 	return put_user(set32, up);
 }
 
 static int
-get_old_segset32(old_sigset_t32 *up, old_sigset_t *set)
+get_old_segset32(compat_old_sigset_t *up, old_sigset_t *set)
 {
-	old_sigset_t32 set32;
+	compat_old_sigset_t set32;
 	int r;
 
 	if ((r = get_user(set32, up)) == 0)
@@ -39,7 +37,7 @@
 }
 
 long
-sys32_sigpending(old_sigset_t32 *set)
+sys32_sigpending(compat_old_sigset_t *set)
 {
 	extern long sys_sigpending(old_sigset_t *set);
 	old_sigset_t pending;
@@ -54,8 +52,8 @@
 	return ret;
 }
 
-int sys32_sigprocmask(int how, old_sigset_t32 *set, 
-				 old_sigset_t32 *oset)
+int sys32_sigprocmask(int how, compat_old_sigset_t *set, 
+				 compat_old_sigset_t *oset)
 {
 	extern int sys_sigprocmask(int how, old_sigset_t *set, 
 				 old_sigset_t *oset);
@@ -71,22 +69,22 @@
 }
 
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
@@ -95,9 +93,9 @@
 }
 
 static int
-get_sigset32(sigset_t32 *up, sigset_t *set, size_t sz)
+get_sigset32(compat_sigset_t *up, sigset_t *set, size_t sz)
 {
-	sigset_t32 s;
+	compat_sigset_t s;
 	int r;
 
 	if (sz != sizeof *set) panic("put_sigset32()");
@@ -109,7 +107,7 @@
 	return r;
 }
 
-int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset,
+int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset,
 				    unsigned int sigsetsize)
 {
 	extern long sys_rt_sigprocmask(int how,
@@ -131,7 +129,7 @@
 }
 
 
-int sys32_rt_sigpending(sigset_t32 *uset, unsigned int sigsetsize)
+int sys32_rt_sigpending(compat_sigset_t *uset, unsigned int sigsetsize)
 {
 	int ret;
 	sigset_t set;
diff -ruN 2.5.58-32bit.4/arch/parisc/kernel/sys32.h 2.5.58-32bit.5/arch/parisc/kernel/sys32.h
--- 2.5.58-32bit.4/arch/parisc/kernel/sys32.h	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.58-32bit.5/arch/parisc/kernel/sys32.h	2003-01-14 17:19:41.000000000 +1100
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
diff -ruN 2.5.58-32bit.4/include/asm-parisc/compat.h 2.5.58-32bit.5/include/asm-parisc/compat.h
--- 2.5.58-32bit.4/include/asm-parisc/compat.h	2003-01-14 11:46:52.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-parisc/compat.h	2003-01-15 16:36:06.000000000 +1100
@@ -37,7 +37,7 @@
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
 	compat_ino_t		st_ino;	/* 32 bits */
 	compat_mode_t		st_mode;	/* 16 bits */
-	compat_nlink_t  	st_nlink;	/* 16 bits */
+	compat_nlink_t		st_nlink;	/* 16 bits */
 	u16			st_reserved1;	/* old st_uid */
 	u16			st_reserved2;	/* old st_gid */
 	compat_dev_t		st_rdev;
@@ -85,4 +85,11 @@
 	s32		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_PARISC_COMPAT_H */
