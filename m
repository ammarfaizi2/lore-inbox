Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbTAOGcW>; Wed, 15 Jan 2003 01:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbTAOGcW>; Wed, 15 Jan 2003 01:32:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:15285 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265705AbTAOGcP>;
	Wed, 15 Jan 2003 01:32:15 -0500
Date: Wed, 15 Jan 2003 17:40:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: PATCH][COMPAT] compat_{old_}sigset_t x86_64 part
Message-Id: <20030115174052.320bd4ca.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here is the x86_64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/x86_64/ia32/ia32_signal.c 2.5.58-32bit.5/arch/x86_64/ia32/ia32_signal.c
--- 2.5.58-32bit.4/arch/x86_64/ia32/ia32_signal.c	2002-12-27 15:15:41.000000000 +1100
+++ 2.5.58-32bit.5/arch/x86_64/ia32/ia32_signal.c	2003-01-15 16:04:07.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
+#include <linux/compat.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -133,7 +134,7 @@
 	int sig;
 	struct sigcontext_ia32 sc;
 	struct _fpstate_ia32 fpstate;
-	unsigned int extramask[_IA32_NSIG_WORDS-1];
+	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
 	char retcode[8];
 };
 
@@ -236,7 +237,7 @@
 	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_IA32_NSIG_WORDS > 1
+	    || (_COMPAT_NSIG_WORDS > 1
 		&& __copy_from_user((((char *) &set.sig) + 4), &frame->extramask,
 				    sizeof(frame->extramask))))
 		goto badframe;
@@ -372,7 +373,7 @@
 }
 
 void ia32_setup_frame(int sig, struct k_sigaction *ka,
-			sigset32_t *set, struct pt_regs * regs)
+			compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct sigframe *frame;
 	int err = 0;
@@ -398,7 +399,7 @@
 	if (err)
 		goto give_sigsegv;
 
-	if (_IA32_NSIG_WORDS > 1) {
+	if (_COMPAT_NSIG_WORDS > 1) {
 		err |= __copy_to_user(frame->extramask, &set->sig[1],
 				      sizeof(frame->extramask));
 	}
@@ -447,7 +448,7 @@
 }
 
 void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset32_t *set, struct pt_regs * regs)
+			   compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe *frame;
 	int err = 0;
diff -ruN 2.5.58-32bit.4/arch/x86_64/ia32/sys_ia32.c 2.5.58-32bit.5/arch/x86_64/ia32/sys_ia32.c
--- 2.5.58-32bit.4/arch/x86_64/ia32/sys_ia32.c	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/arch/x86_64/ia32/sys_ia32.c	2003-01-15 16:04:33.000000000 +1100
@@ -276,10 +276,10 @@
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
@@ -287,10 +287,10 @@
 		    __get_user((long)new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
 		    __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer)||
-		    __copy_from_user(&set32, &act->sa_mask, sizeof(sigset32_t)))
+		    __copy_from_user(&set32, &act->sa_mask, sizeof(compat_sigset_t)))
 			return -EFAULT;
 
-		/* FIXME: here we rely on _IA32_NSIG_WORS to be >= than _NSIG_WORDS << 1 */
+		/* FIXME: here we rely on _COMPAT_NSIG_WORS to be >= than _NSIG_WORDS << 1 */
 		switch (_NSIG_WORDS) {
 		case 4: new_ka.sa.sa_mask.sig[3] = set32.sig[6]
 				| (((long)set32.sig[7]) << 32);
@@ -306,7 +306,7 @@
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		/* FIXME: here we rely on _IA32_NSIG_WORS to be >= than _NSIG_WORDS << 1 */
+		/* FIXME: here we rely on _COMPAT_NSIG_WORS to be >= than _NSIG_WORDS << 1 */
 		switch (_NSIG_WORDS) {
 		case 4:
 			set32.sig[7] = (old_ka.sa.sa_mask.sig[3] >> 32);
@@ -325,7 +325,7 @@
 		    __put_user((long)old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user((long)old_ka.sa.sa_restorer, &oact->sa_restorer) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
-		    __copy_to_user(&oact->sa_mask, &set32, sizeof(sigset32_t)))
+		    __copy_to_user(&oact->sa_mask, &set32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 
@@ -339,7 +339,7 @@
         int ret;
 
         if (act) {
-		old_sigset32_t mask;
+		compat_old_sigset_t mask;
 
 		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user((long)new_ka.sa.sa_handler, &act->sa_handler) ||
@@ -368,16 +368,16 @@
 					  size_t sigsetsize);
 
 asmlinkage long
-sys32_rt_sigprocmask(int how, sigset32_t *set, sigset32_t *oset,
+sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset,
 		     unsigned int sigsetsize)
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
 		case 4: s.sig[3] = s32.sig[6] | (((long)s32.sig[7]) << 32);
@@ -398,7 +398,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (oset, &s32, sizeof(sigset32_t)))
+		if (copy_to_user (oset, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return 0;
@@ -1228,7 +1228,7 @@
 				      old_sigset_t *oset);
 
 asmlinkage long
-sys32_sigprocmask(int how, old_sigset32_t *set, old_sigset32_t *oset)
+sys32_sigprocmask(int how, compat_old_sigset_t *set, compat_old_sigset_t *oset)
 {
 	old_sigset_t s;
 	int ret;
@@ -1246,7 +1246,7 @@
 extern asmlinkage long sys_sigpending(old_sigset_t *set);
 
 asmlinkage long
-sys32_sigpending(old_sigset32_t *set)
+sys32_sigpending(compat_old_sigset_t *set)
 {
 	old_sigset_t s;
 	int ret;
@@ -1262,10 +1262,10 @@
 extern asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 asmlinkage long
-sys32_rt_sigpending(sigset32_t *set, compat_size_t sigsetsize)
+sys32_rt_sigpending(compat_sigset_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset32_t s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 		
@@ -1279,7 +1279,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (set, &s32, sizeof(sigset32_t)))
+		if (copy_to_user (set, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return ret;
@@ -1367,18 +1367,18 @@
 		    const struct timespec *uts, size_t sigsetsize);
 
 asmlinkage long
-sys32_rt_sigtimedwait(sigset32_t *uthese, siginfo_t32 *uinfo,
+sys32_rt_sigtimedwait(compat_sigset_t *uthese, siginfo_t32 *uinfo,
 		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset32_t s32;
+	compat_sigset_t s32;
 	struct timespec t;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	siginfo_t info;
 	siginfo_t32 info32;
 		
-	if (copy_from_user (&s32, uthese, sizeof(sigset32_t)))
+	if (copy_from_user (&s32, uthese, sizeof(compat_sigset_t)))
 		return -EFAULT;
 	switch (_NSIG_WORDS) {
 	case 4: s.sig[3] = s32.sig[6] | (((long)s32.sig[7]) << 32);
diff -ruN 2.5.58-32bit.4/include/asm-x86_64/compat.h 2.5.58-32bit.5/include/asm-x86_64/compat.h
--- 2.5.58-32bit.4/include/asm-x86_64/compat.h	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-x86_64/compat.h	2003-01-15 16:38:52.000000000 +1100
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
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.58-32bit.4/include/asm-x86_64/ia32.h 2.5.58-32bit.5/include/asm-x86_64/ia32.h
--- 2.5.58-32bit.4/include/asm-x86_64/ia32.h	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-x86_64/ia32.h	2003-01-15 15:08:02.000000000 +1100
@@ -26,28 +26,18 @@
 #include <asm/sigcontext32.h>
 
 /* signal.h */
-#define _IA32_NSIG	       64
-#define _IA32_NSIG_BPW	       32
-#define _IA32_NSIG_WORDS	       (_IA32_NSIG / _IA32_NSIG_BPW)
-
-typedef struct {
-       unsigned int sig[_IA32_NSIG_WORDS];
-} sigset32_t;
-
 struct sigaction32 {
        unsigned int  sa_handler;	/* Really a pointer, but need to deal 
 					     with 32 bits */
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
@@ -63,7 +53,7 @@
 	unsigned int 	  uc_link;
 	stack_ia32_t	  uc_stack;
 	struct sigcontext_ia32 uc_mcontext;
-	sigset32_t	  uc_sigmask;	/* mask last for extensibility */
+	compat_sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
 /* This matches struct stat64 in glibc2.2, hence the absolutely
