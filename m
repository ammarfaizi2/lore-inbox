Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTAOGds>; Wed, 15 Jan 2003 01:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTAOGds>; Wed, 15 Jan 2003 01:33:48 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:22965 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265754AbTAOGdn>;
	Wed, 15 Jan 2003 01:33:43 -0500
Date: Wed, 15 Jan 2003 17:42:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_{old_}sigset_t ia64 part
Message-Id: <20030115174224.268ba5c8.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/ia64/ia32/ia32_signal.c 2.5.58-32bit.5/arch/ia64/ia32/ia32_signal.c
--- 2.5.58-32bit.4/arch/ia64/ia32/ia32_signal.c	2003-01-13 11:03:51.000000000 +1100
+++ 2.5.58-32bit.5/arch/ia64/ia32/ia32_signal.c	2003-01-15 16:03:42.000000000 +1100
@@ -56,7 +56,7 @@
        int sig;
        struct sigcontext_ia32 sc;
        struct _fpstate_ia32 fpstate;
-       unsigned int extramask[_IA32_NSIG_WORDS-1];
+       unsigned int extramask[_COMPAT_NSIG_WORDS-1];
        char retcode[8];
 };
 
@@ -463,7 +463,7 @@
 }
 
 asmlinkage long
-ia32_rt_sigsuspend (sigset32_t *uset, unsigned int sigsetsize, struct sigscratch *scr)
+ia32_rt_sigsuspend (compat_sigset_t *uset, unsigned int sigsetsize, struct sigscratch *scr)
 {
 	extern long ia64_do_signal (sigset_t *oldset, struct sigscratch *scr, long in_syscall);
 	sigset_t oldset, set;
@@ -504,7 +504,7 @@
 asmlinkage long
 ia32_sigsuspend (unsigned int mask, struct sigscratch *scr)
 {
-	return ia32_rt_sigsuspend((sigset32_t *)&mask, sizeof(mask), scr);
+	return ia32_rt_sigsuspend((compat_sigset_t *)&mask, sizeof(mask), scr);
 }
 
 asmlinkage long
@@ -530,14 +530,14 @@
 	int ret;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset32_t))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
 	if (act) {
 		ret = get_user(handler, &act->sa_handler);
 		ret |= get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		ret |= get_user(restorer, &act->sa_restorer);
-		ret |= copy_from_user(&new_ka.sa.sa_mask, &act->sa_mask, sizeof(sigset32_t));
+		ret |= copy_from_user(&new_ka.sa.sa_mask, &act->sa_mask, sizeof(compat_sigset_t));
 		if (ret)
 			return -EFAULT;
 
@@ -550,7 +550,7 @@
 		ret = put_user(IA32_SA_HANDLER(&old_ka), &oact->sa_handler);
 		ret |= put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 		ret |= put_user(IA32_SA_RESTORER(&old_ka), &oact->sa_restorer);
-		ret |= copy_to_user(&oact->sa_mask, &old_ka.sa.sa_mask, sizeof(sigset32_t));
+		ret |= copy_to_user(&oact->sa_mask, &old_ka.sa.sa_mask, sizeof(compat_sigset_t));
 	}
 	return ret;
 }
@@ -560,7 +560,7 @@
 					   size_t sigsetsize);
 
 asmlinkage long
-sys32_rt_sigprocmask (int how, sigset32_t *set, sigset32_t *oset, unsigned int sigsetsize)
+sys32_rt_sigprocmask (int how, compat_sigset_t *set, compat_sigset_t *oset, unsigned int sigsetsize)
 {
 	mm_segment_t old_fs = get_fs();
 	sigset_t s;
@@ -589,11 +589,11 @@
 asmlinkage long
 sys32_sigprocmask (int how, unsigned int *set, unsigned int *oset)
 {
-	return sys32_rt_sigprocmask(how, (sigset32_t *) set, (sigset32_t *) oset, sizeof(*set));
+	return sys32_rt_sigprocmask(how, (compat_sigset_t *) set, (compat_sigset_t *) oset, sizeof(*set));
 }
 
 asmlinkage long
-sys32_rt_sigtimedwait (sigset32_t *uthese, siginfo_t32 *uinfo,
+sys32_rt_sigtimedwait (compat_sigset_t *uthese, siginfo_t32 *uinfo,
 		struct compat_timespec *uts, unsigned int sigsetsize)
 {
 	extern asmlinkage long sys_rt_sigtimedwait (const sigset_t *, siginfo_t *,
@@ -605,7 +605,7 @@
 	sigset_t s;
 	int ret;
 
-	if (copy_from_user(&s.sig, uthese, sizeof(sigset32_t)))
+	if (copy_from_user(&s.sig, uthese, sizeof(compat_sigset_t)))
 		return -EFAULT;
 	if (uts && get_compat_timespec(&t, uts))
 		return -EFAULT;
@@ -645,7 +645,7 @@
 	int ret;
 
 	if (act) {
-		old_sigset32_t mask;
+		compat_old_sigset_t mask;
 
 		ret = get_user(handler, &act->sa_handler);
 		ret |= get_user(new_ka.sa.sa_flags, &act->sa_flags);
@@ -863,7 +863,7 @@
 
 	err |= setup_sigcontext_ia32(&frame->sc, &frame->fpstate, regs, set->sig[0]);
 
-	if (_IA32_NSIG_WORDS > 1)
+	if (_COMPAT_NSIG_WORDS > 1)
 		err |= __copy_to_user(frame->extramask, (char *) &set->sig + 4,
 				      sizeof(frame->extramask));
 
@@ -1008,7 +1008,7 @@
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_IA32_NSIG_WORDS > 1 && __copy_from_user((char *) &set.sig + 4, &frame->extramask,
+	    || (_COMPAT_NSIG_WORDS > 1 && __copy_from_user((char *) &set.sig + 4, &frame->extramask,
 							 sizeof(frame->extramask))))
 		goto badframe;
 
diff -ruN 2.5.58-32bit.4/include/asm-ia64/compat.h 2.5.58-32bit.5/include/asm-ia64/compat.h
--- 2.5.58-32bit.4/include/asm-ia64/compat.h	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-ia64/compat.h	2003-01-15 16:34:22.000000000 +1100
@@ -81,4 +81,11 @@
 	int		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;	/* at least 32 bits */
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.58-32bit.4/include/asm-ia64/ia32.h 2.5.58-32bit.5/include/asm-ia64/ia32.h
--- 2.5.58-32bit.4/include/asm-ia64/ia32.h	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-ia64/ia32.h	2003-01-15 14:57:33.000000000 +1100
@@ -132,10 +132,6 @@
 };
 
 /* signal.h */
-#define _IA32_NSIG	       64
-#define _IA32_NSIG_BPW	       32
-#define _IA32_NSIG_WORDS	       (_IA32_NSIG / _IA32_NSIG_BPW)
-
 #define IA32_SET_SA_HANDLER(ka,handler,restorer)				\
 				((ka)->sa.sa_handler = (__sighandler_t)		\
 					(((unsigned long)(restorer) << 32)	\
@@ -143,23 +139,17 @@
 #define IA32_SA_HANDLER(ka)	((unsigned long) (ka)->sa.sa_handler & 0xffffffff)
 #define IA32_SA_RESTORER(ka)	((unsigned long) (ka)->sa.sa_handler >> 32)
 
-typedef struct {
-       unsigned int sig[_IA32_NSIG_WORDS];
-} sigset32_t;
-
 struct sigaction32 {
        unsigned int sa_handler;		/* Really a pointer, but need to deal with 32 bits */
        unsigned int sa_flags;
        unsigned int sa_restorer;	/* Another 32 bit pointer */
-       sigset32_t sa_mask;		/* A 32 bit mask */
+       compat_sigset_t sa_mask;		/* A 32 bit mask */
 };
 
-typedef unsigned int old_sigset32_t;	/* at least 32 bits */
-
 struct old_sigaction32 {
        unsigned int  sa_handler;	/* Really a pointer, but need to deal
 					     with 32 bits */
-       old_sigset32_t sa_mask;		/* A 32 bit mask */
+       compat_old_sigset_t sa_mask;		/* A 32 bit mask */
        unsigned int sa_flags;
        unsigned int sa_restorer;	/* Another 32 bit pointer */
 };
