Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbTAOG2T>; Wed, 15 Jan 2003 01:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAOG2T>; Wed, 15 Jan 2003 01:28:19 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8117 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265661AbTAOG1p>;
	Wed, 15 Jan 2003 01:27:45 -0500
Date: Wed, 15 Jan 2003 17:36:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_{old_}sigset_t ppc64
Message-Id: <20030115173627.5a5e31a8.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Here is the ppc64 part of the patch
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/ppc64/kernel/signal32.c 2.5.58-32bit.5/arch/ppc64/kernel/signal32.c
--- 2.5.58-32bit.4/arch/ppc64/kernel/signal32.c	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.5/arch/ppc64/kernel/signal32.c	2003-01-15 14:55:15.000000000 +1100
@@ -124,7 +124,7 @@
 		sig = -sig;
 
 	if (act) {
-		old_sigset_t32 mask;
+		compat_old_sigset_t mask;
 
 		if (get_user((long)new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer) ||
@@ -149,7 +149,7 @@
 
 extern long sys_sigpending(old_sigset_t *set);
 
-long sys32_sigpending(old_sigset_t32 *set)
+long sys32_sigpending(compat_old_sigset_t *set)
 {
 	old_sigset_t s;
 	int ret;
@@ -174,8 +174,8 @@
  * of a signed int (msr in 32-bit mode) and the register representation
  * of a signed int (msr in 64-bit mode) is performed.
  */
-long sys32_sigprocmask(u32 how, old_sigset_t32 *set,
-		old_sigset_t32 *oset)
+long sys32_sigprocmask(u32 how, compat_old_sigset_t *set,
+		compat_old_sigset_t *oset)
 {
 	old_sigset_t s;
 	int ret;
@@ -528,16 +528,16 @@
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
-	sigset32_t set32;
+	compat_sigset_t set32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset32_t))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
 	if (act) {
 		ret = get_user((long)new_ka.sa.sa_handler, &act->sa_handler);
 		ret |= __copy_from_user(&set32, &act->sa_mask,
-					sizeof(sigset32_t));
+					sizeof(compat_sigset_t));
 		switch (_NSIG_WORDS) {
 		case 4: new_ka.sa.sa_mask.sig[3] = set32.sig[6]
 				| (((long)set32.sig[7]) << 32);
@@ -571,7 +571,7 @@
 		}
 		ret = put_user((long)old_ka.sa.sa_handler, &oact->sa_handler);
 		ret |= __copy_to_user(&oact->sa_mask, &set32,
-				      sizeof(sigset32_t));
+				      sizeof(compat_sigset_t));
 		ret |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 	}
 	return ret;
@@ -588,16 +588,16 @@
  * of a signed int (msr in 32-bit mode) and the register representation
  * of a signed int (msr in 64-bit mode) is performed.
  */
-long sys32_rt_sigprocmask(u32 how, sigset32_t *set,
-		sigset32_t *oset, size_t sigsetsize)
+long sys32_rt_sigprocmask(u32 how, compat_sigset_t *set,
+		compat_sigset_t *oset, size_t sigsetsize)
 {
 	sigset_t s;
-	sigset32_t s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
 	if (set) {
-		if (copy_from_user (&s32, set, sizeof(sigset32_t)))
+		if (copy_from_user (&s32, set, sizeof(compat_sigset_t)))
 			return -EFAULT;
     
 		switch (_NSIG_WORDS) {
@@ -621,7 +621,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (oset, &s32, sizeof(sigset32_t)))
+		if (copy_to_user (oset, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return 0;
@@ -631,10 +631,10 @@
 extern long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 
-long sys32_rt_sigpending(sigset32_t *set, compat_size_t sigsetsize)
+long sys32_rt_sigpending(compat_sigset_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset32_t s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
@@ -648,7 +648,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (set, &s32, sizeof(sigset32_t)))
+		if (copy_to_user (set, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return ret;
@@ -702,17 +702,17 @@
 		siginfo_t *uinfo, const struct timespec *uts,
 		size_t sigsetsize);
 
-long sys32_rt_sigtimedwait(sigset32_t *uthese, siginfo_t32 *uinfo,
+long sys32_rt_sigtimedwait(compat_sigset_t *uthese, siginfo_t32 *uinfo,
 		struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset32_t s32;
+	compat_sigset_t s32;
 	struct timespec t;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	siginfo_t info;
 
-	if (copy_from_user(&s32, uthese, sizeof(sigset32_t)))
+	if (copy_from_user(&s32, uthese, sizeof(compat_sigset_t)))
 		return -EFAULT;
 	switch (_NSIG_WORDS) {
 	case 4: s.sig[3] = s32.sig[6] | (((long)s32.sig[7]) << 32);
@@ -803,11 +803,11 @@
 
 extern int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
-int sys32_rt_sigsuspend(sigset32_t* unewset, size_t sigsetsize, int p3,
+int sys32_rt_sigsuspend(compat_sigset_t* unewset, size_t sigsetsize, int p3,
 		int p4, int p6, int p7, struct pt_regs *regs)
 {
 	sigset_t saveset, newset;
-	sigset32_t s32;
+	compat_sigset_t s32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
diff -ruN 2.5.58-32bit.4/include/asm-ppc64/compat.h 2.5.58-32bit.5/include/asm-ppc64/compat.h
--- 2.5.58-32bit.4/include/asm-ppc64/compat.h	2003-01-14 09:57:58.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-ppc64/compat.h	2003-01-15 16:36:43.000000000 +1100
@@ -77,4 +77,11 @@
 	int		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.58-32bit.4/include/asm-ppc64/ppc32.h 2.5.58-32bit.5/include/asm-ppc64/ppc32.h
--- 2.5.58-32bit.4/include/asm-ppc64/ppc32.h	2003-01-14 09:57:58.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-ppc64/ppc32.h	2003-01-15 15:05:37.000000000 +1100
@@ -94,32 +94,22 @@
 	} _sifields;
 } siginfo_t32;
 
-#define __old_sigset_t32	old_sigset_t32
 #define __old_sigaction32	old_sigaction32
 
-typedef unsigned int __old_sigset_t32;
 struct __old_sigaction32 {
 	unsigned		sa_handler;
-	__old_sigset_t32  	sa_mask;
+	compat_old_sigset_t  	sa_mask;
 	unsigned int    	sa_flags;
 	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
 };
 
 
 
-#define _PPC32_NSIG	       64
-#define _PPC32_NSIG_BPW	       32
-#define _PPC32_NSIG_WORDS	       (_PPC32_NSIG / _PPC32_NSIG_BPW)
-
-typedef struct {
-       unsigned int sig[_PPC32_NSIG_WORDS];
-} sigset32_t;
-
 struct sigaction32 {
        unsigned int  sa_handler;	/* Really a pointer, but need to deal with 32 bits */
        unsigned int sa_flags;
        unsigned int sa_restorer;	/* Another 32 bit pointer */
-       sigset32_t sa_mask;		/* A 32 bit mask */
+       compat_sigset_t sa_mask;		/* A 32 bit mask */
 };
 
 typedef struct sigaltstack_32 {
