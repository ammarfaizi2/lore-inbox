Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTAOGaw>; Wed, 15 Jan 2003 01:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbTAOGaw>; Wed, 15 Jan 2003 01:30:52 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:12469 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265675AbTAOGan>;
	Wed, 15 Jan 2003 01:30:43 -0500
Date: Wed, 15 Jan 2003 17:39:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_{old_}sigset_t sparc64
Message-Id: <20030115173920.7a62fd0d.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is the sparc64 part of the patch.  After this, we no longer export
sigset_t32 or old_sigset_t32 to user mode from the kernerl headers.  I
assume that is OK.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/sparc64/kernel/signal.c 2.5.58-32bit.5/arch/sparc64/kernel/signal.c
--- 2.5.58-32bit.4/arch/sparc64/kernel/signal.c	2002-12-27 15:15:40.000000000 +1100
+++ 2.5.58-32bit.5/arch/sparc64/kernel/signal.c	2003-01-15 14:53:36.000000000 +1100
@@ -9,6 +9,9 @@
  */
 
 #include <linux/config.h>
+#ifdef CONFIG_SPARC32_COMPAT
+#include <linux/compat.h>	/* for compat_old_sigset_t */
+#endif
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
@@ -247,7 +250,7 @@
 
 #ifdef CONFIG_SPARC32_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-		extern asmlinkage void _sigpause32_common(old_sigset_t32,
+		extern asmlinkage void _sigpause32_common(compat_old_sigset_t,
 							  struct pt_regs *);
 		_sigpause32_common(set, regs);
 		return;
diff -ruN 2.5.58-32bit.4/arch/sparc64/kernel/signal32.c 2.5.58-32bit.5/arch/sparc64/kernel/signal32.c
--- 2.5.58-32bit.4/arch/sparc64/kernel/signal32.c	2002-12-27 15:15:40.000000000 +1100
+++ 2.5.58-32bit.5/arch/sparc64/kernel/signal32.c	2003-01-15 16:28:53.000000000 +1100
@@ -56,7 +56,7 @@
 	/* struct sigcontext32 * */ u32 sig_scptr;
 	int sig_address;
 	struct sigcontext32 sig_context;
-	unsigned extramask[_NSIG_WORDS32 - 1];
+	unsigned extramask[_COMPAT_NSIG_WORDS - 1];
 };
 
 /* 
@@ -80,7 +80,7 @@
 	struct sparc_stackf32	ss;
 	siginfo_t32		info;
 	struct pt_regs32	regs;
-	sigset_t32		mask;
+	compat_sigset_t		mask;
 	/* __siginfo_fpu32_t * */ u32 fpu_save;
 	unsigned int		insns [2];
 	stack_t32		stack;
@@ -139,7 +139,7 @@
  * atomically swap in the new signal mask, and wait for a signal.
  * This is really tricky on the Sparc, watch out...
  */
-asmlinkage void _sigpause32_common(old_sigset_t32 set, struct pt_regs *regs)
+asmlinkage void _sigpause32_common(compat_old_sigset_t set, struct pt_regs *regs)
 {
 	sigset_t saveset;
 
@@ -179,7 +179,7 @@
 asmlinkage void do_rt_sigsuspend32(u32 uset, size_t sigsetsize, struct pt_regs *regs)
 {
 	sigset_t oldset, set;
-	sigset_t32 set32;
+	compat_sigset_t set32;
         
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (((compat_size_t)sigsetsize) != sizeof(sigset_t)) {
@@ -393,7 +393,7 @@
 	unsigned pc, npc, fpu_save;
 	mm_segment_t old_fs;
 	sigset_t set;
-	sigset_t32 seta;
+	compat_sigset_t seta;
 	stack_t st;
 	int err, i;
 	
@@ -440,7 +440,7 @@
 	err |= __get_user(fpu_save, &sf->fpu_save);
 	if (fpu_save)
 		err |= restore_fpu_state32(regs, &sf->fpu_state);
-	err |= copy_from_user(&seta, &sf->mask, sizeof(sigset_t32));
+	err |= copy_from_user(&seta, &sf->mask, sizeof(compat_sigset_t));
 	err |= __get_user((long)st.ss_sp, &sf->stack.ss_sp);
 	err |= __get_user(st.ss_flags, &sf->stack.ss_flags);
 	err |= __get_user(st.ss_size, &sf->stack.ss_size);
@@ -1098,7 +1098,7 @@
 	int sigframe_size;
 	u32 psr;
 	int i, err;
-	sigset_t32 seta;
+	compat_sigset_t seta;
 
 	/* 1. Make sure everything is clean */
 	synchronize_user_stack();
@@ -1160,7 +1160,7 @@
 	case 1: seta.sig[1] = (oldset->sig[0] >> 32);
 		seta.sig[0] = oldset->sig[0];
 	}
-	err |= __copy_to_user(&sf->mask, &seta, sizeof(sigset_t32));
+	err |= __copy_to_user(&sf->mask, &seta, sizeof(compat_sigset_t));
 
 	err |= copy_in_user((u32 *)sf,
 			    (u32 *)(regs->u_regs[UREG_FP]),
diff -ruN 2.5.58-32bit.4/arch/sparc64/kernel/sys_sparc32.c 2.5.58-32bit.5/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.58-32bit.4/arch/sparc64/kernel/sys_sparc32.c	2003-01-14 09:57:52.000000000 +1100
+++ 2.5.58-32bit.5/arch/sparc64/kernel/sys_sparc32.c	2003-01-15 14:54:34.000000000 +1100
@@ -1681,7 +1681,7 @@
 
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
 
-asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, old_sigset_t32 *oset)
+asmlinkage int sys32_sigprocmask(int how, compat_old_sigset_t *set, compat_old_sigset_t *oset)
 {
 	old_sigset_t s;
 	int ret;
@@ -1698,15 +1698,15 @@
 
 extern asmlinkage int sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, compat_size_t sigsetsize)
+asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset_t32 s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	
 	if (set) {
-		if (copy_from_user (&s32, set, sizeof(sigset_t32)))
+		if (copy_from_user (&s32, set, sizeof(compat_sigset_t)))
 			return -EFAULT;
 		switch (_NSIG_WORDS) {
 		case 4: s.sig[3] = s32.sig[6] | (((long)s32.sig[7]) << 32);
@@ -1726,7 +1726,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (oset, &s32, sizeof(sigset_t32)))
+		if (copy_to_user (oset, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return 0;
@@ -1734,7 +1734,7 @@
 
 extern asmlinkage int sys_sigpending(old_sigset_t *set);
 
-asmlinkage int sys32_sigpending(old_sigset_t32 *set)
+asmlinkage int sys32_sigpending(compat_old_sigset_t *set)
 {
 	old_sigset_t s;
 	int ret;
@@ -1749,10 +1749,10 @@
 
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset_t32 *set, compat_size_t sigsetsize)
+asmlinkage int sys32_rt_sigpending(compat_sigset_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset_t32 s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 		
@@ -1766,19 +1766,19 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (set, &s32, sizeof(sigset_t32)))
+		if (copy_to_user (set, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return ret;
 }
 
 asmlinkage int
-sys32_rt_sigtimedwait(sigset_t32 *uthese, siginfo_t32 *uinfo,
+sys32_rt_sigtimedwait(compat_sigset_t *uthese, siginfo_t32 *uinfo,
 		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	int ret, sig;
 	sigset_t these;
-	sigset_t32 these32;
+	compat_sigset_t these32;
 	struct timespec ts;
 	siginfo_t info;
 	long timeout = 0;
@@ -1787,7 +1787,7 @@
 	if (sigsetsize != sizeof(sigset_t))
 		return -EINVAL;
 
-	if (copy_from_user (&these32, uthese, sizeof(sigset_t32)))
+	if (copy_from_user (&these32, uthese, sizeof(compat_sigset_t)))
 		return -EFAULT;
 
 	switch (_NSIG_WORDS) {
@@ -2701,7 +2701,7 @@
 	}
 
         if (act) {
-		old_sigset_t32 mask;
+		compat_old_sigset_t mask;
 		
 		ret = get_user((long)new_ka.sa.sa_handler, &act->sa_handler);
 		ret |= __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer);
@@ -2731,10 +2731,10 @@
 {
         struct k_sigaction new_ka, old_ka;
         int ret;
-	sigset_t32 set32;
+	compat_sigset_t set32;
 
         /* XXX: Don't preclude handling different sized sigset_t's.  */
-        if (sigsetsize != sizeof(sigset_t32))
+        if (sigsetsize != sizeof(compat_sigset_t))
                 return -EINVAL;
 
 	/* All tasks which use RT signals (effectively) use
@@ -2745,7 +2745,7 @@
         if (act) {
 		new_ka.ka_restorer = restorer;
 		ret = get_user((long)new_ka.sa.sa_handler, &act->sa_handler);
-		ret |= __copy_from_user(&set32, &act->sa_mask, sizeof(sigset_t32));
+		ret |= __copy_from_user(&set32, &act->sa_mask, sizeof(compat_sigset_t));
 		switch (_NSIG_WORDS) {
 		case 4: new_ka.sa.sa_mask.sig[3] = set32.sig[6] | (((long)set32.sig[7]) << 32);
 		case 3: new_ka.sa.sa_mask.sig[2] = set32.sig[4] | (((long)set32.sig[5]) << 32);
@@ -2768,7 +2768,7 @@
 		case 1: set32.sig[1] = (old_ka.sa.sa_mask.sig[0] >> 32); set32.sig[0] = old_ka.sa.sa_mask.sig[0];
 		}
 		ret = put_user((long)old_ka.sa.sa_handler, &oact->sa_handler);
-		ret |= __copy_to_user(&oact->sa_mask, &set32, sizeof(sigset_t32));
+		ret |= __copy_to_user(&oact->sa_mask, &set32, sizeof(compat_sigset_t));
 		ret |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 		ret |= __put_user((long)old_ka.sa.sa_restorer, &oact->sa_restorer);
 		if (ret)
diff -ruN 2.5.58-32bit.4/arch/sparc64/kernel/sys_sunos32.c 2.5.58-32bit.5/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.58-32bit.4/arch/sparc64/kernel/sys_sunos32.c	2003-01-09 16:23:55.000000000 +1100
+++ 2.5.58-32bit.5/arch/sparc64/kernel/sys_sunos32.c	2003-01-15 14:51:58.000000000 +1100
@@ -1297,7 +1297,7 @@
 	int ret;
 
 	if (act) {
-		old_sigset_t32 mask;
+		compat_old_sigset_t mask;
 
 		if (get_user((long)new_ka.sa.sa_handler, &((struct old_sigaction32 *)A(act))->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &((struct old_sigaction32 *)A(act))->sa_flags))
diff -ruN 2.5.58-32bit.4/include/asm-sparc64/compat.h 2.5.58-32bit.5/include/asm-sparc64/compat.h
--- 2.5.58-32bit.4/include/asm-sparc64/compat.h	2003-01-14 09:57:58.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-sparc64/compat.h	2003-01-15 16:38:13.000000000 +1100
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
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.58-32bit.4/include/asm-sparc64/signal.h 2.5.58-32bit.5/include/asm-sparc64/signal.h
--- 2.5.58-32bit.4/include/asm-sparc64/signal.h	2002-12-10 15:10:40.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-sparc64/signal.h	2003-01-15 15:03:43.000000000 +1100
@@ -88,27 +88,21 @@
 #define _NSIG_BPW     	64
 #define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
 
-#define _NSIG_BPW32   	32
-#define _NSIG_WORDS32 	(__NEW_NSIG / _NSIG_BPW32)
-
 #define SIGRTMIN       32
 #define SIGRTMAX       (__NEW_NSIG - 1)
 
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define _NSIG			__NEW_NSIG
 #define __new_sigset_t		sigset_t
-#define __new_sigset_t32	sigset_t32
 #define __new_sigaction		sigaction
 #define __new_sigaction32	sigaction32
 #define __old_sigset_t		old_sigset_t
-#define __old_sigset_t32	old_sigset_t32
 #define __old_sigaction		old_sigaction
 #define __old_sigaction32	old_sigaction32
 #else
 #define _NSIG			__OLD_NSIG
 #define NSIG			_NSIG
 #define __old_sigset_t		sigset_t
-#define __old_sigset_t32	sigset_t32
 #define __old_sigaction		sigaction
 #define __old_sigaction32	sigaction32
 #endif
@@ -116,16 +110,11 @@
 #ifndef __ASSEMBLY__
 
 typedef unsigned long __old_sigset_t;            /* at least 32 bits */
-typedef unsigned int __old_sigset_t32;
 
 typedef struct {
        unsigned long sig[_NSIG_WORDS];
 } __new_sigset_t;
 
-typedef struct {
-       unsigned int sig[_NSIG_WORDS32];
-} __new_sigset_t32;
-
 /* A SunOS sigstack */
 struct sigstack {
 	/* XXX 32-bit pointers pinhead XXX */
@@ -213,14 +202,14 @@
 	__new_sigset_t		sa_mask;
 };
 
+#ifdef __KERNEL__
 struct __new_sigaction32 {
 	unsigned		sa_handler;
 	unsigned int    	sa_flags;
 	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-	__new_sigset_t32 	sa_mask;
+	compat_sigset_t 	sa_mask;
 };
 
-#ifdef __KERNEL__
 struct k_sigaction {
 	struct __new_sigaction 	sa;
 	void			*ka_restorer;
@@ -234,12 +223,14 @@
 	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
 };
 
+#ifdef __KERNEL__
 struct __old_sigaction32 {
 	unsigned		sa_handler;
-	__old_sigset_t32  	sa_mask;
+	compat_old_sigset_t  	sa_mask;
 	unsigned int    	sa_flags;
 	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
 };
+#endif
 
 typedef struct sigaltstack {
 	void			*ss_sp;
