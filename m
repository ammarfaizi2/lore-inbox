Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTBLEbe>; Tue, 11 Feb 2003 23:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbTBLEba>; Tue, 11 Feb 2003 23:31:30 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:52923 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266806AbTBLEbR>;
	Tue, 11 Feb 2003 23:31:17 -0500
Date: Wed, 12 Feb 2003 15:40:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: [PATCH][COMPAT] outstanding compatibility changes 4/4 x86_64
Message-Id: <20030212154046.0fad70af.sfr@canb.auug.org.au>
In-Reply-To: <20030212152927.77384c95.sfr@canb.auug.org.au>
References: <20030212152927.77384c95.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Andi has asked that I send these straight forward compatibility patches to
you and he will fix up any merge problems later.  So here are the
outstanding patches for x86_64 against 2.5.60.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60/arch/x86_64/ia32/ia32_signal.c 2.5.60-32bit.1/arch/x86_64/ia32/ia32_signal.c
--- 2.5.60/arch/x86_64/ia32/ia32_signal.c	2003-02-11 09:39:21.000000000 +1100
+++ 2.5.60-32bit.1/arch/x86_64/ia32/ia32_signal.c	2003-02-11 12:21:29.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
+#include <linux/compat.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -134,7 +135,7 @@
 	int sig;
 	struct sigcontext_ia32 sc;
 	struct _fpstate_ia32 fpstate;
-	unsigned int extramask[_IA32_NSIG_WORDS-1];
+	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
 	char retcode[8];
 };
 
@@ -237,7 +238,7 @@
 	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_IA32_NSIG_WORDS > 1
+	    || (_COMPAT_NSIG_WORDS > 1
 		&& __copy_from_user((((char *) &set.sig) + 4), &frame->extramask,
 				    sizeof(frame->extramask))))
 		goto badframe;
@@ -373,7 +374,7 @@
 }
 
 void ia32_setup_frame(int sig, struct k_sigaction *ka,
-			sigset32_t *set, struct pt_regs * regs)
+			compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct sigframe *frame;
 	int err = 0;
@@ -399,7 +400,7 @@
 	if (err)
 		goto give_sigsegv;
 
-	if (_IA32_NSIG_WORDS > 1) {
+	if (_COMPAT_NSIG_WORDS > 1) {
 		err |= __copy_to_user(frame->extramask, &set->sig[1],
 				      sizeof(frame->extramask));
 	}
@@ -460,7 +461,7 @@
 }
 
 void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset32_t *set, struct pt_regs * regs)
+			   compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe *frame;
 	int err = 0;
diff -ruN 2.5.60/arch/x86_64/ia32/ia32entry.S 2.5.60-32bit.1/arch/x86_64/ia32/ia32entry.S
--- 2.5.60/arch/x86_64/ia32/ia32entry.S	2003-01-17 14:01:02.000000000 +1100
+++ 2.5.60-32bit.1/arch/x86_64/ia32/ia32entry.S	2003-02-11 12:21:29.000000000 +1100
@@ -273,7 +273,7 @@
 	.quad sys_setreuid16	/* 70 */
 	.quad sys_setregid16
 	.quad stub32_sigsuspend
-	.quad sys32_sigpending
+	.quad compat_sys_sigpending
 	.quad sys_sethostname
 	.quad sys32_setrlimit	/* 75 */
 	.quad sys32_old_getrlimit	/* old_getrlimit */
@@ -326,7 +326,7 @@
 	.quad sys32_modify_ldt
 	.quad sys32_adjtimex
 	.quad sys32_mprotect		/* 125 */
-	.quad sys32_sigprocmask
+	.quad compat_sys_sigprocmask
 	.quad sys32_module_warning	/* create_module */
 	.quad sys_init_module
 	.quad sys_delete_module
diff -ruN 2.5.60/arch/x86_64/ia32/ipc32.c 2.5.60-32bit.1/arch/x86_64/ia32/ipc32.c
--- 2.5.60/arch/x86_64/ia32/ipc32.c	2003-01-09 16:23:55.000000000 +1100
+++ 2.5.60-32bit.1/arch/x86_64/ia32/ipc32.c	2003-02-11 12:21:29.000000000 +1100
@@ -626,9 +626,7 @@
 		return -E2BIG;
 	if (!access_ok(VERIFY_READ, sb, nsops * sizeof(struct sembuf)))
 		return -EFAULT; 
-	if (ts32 && 
-	    (get_user(ts.tv_sec, &ts32->tv_sec)  || 
-	     __get_user(ts.tv_nsec, &ts32->tv_nsec)))
+	if (ts32 && get_compat_timespec(&ts, ts32))
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);  
diff -ruN 2.5.60/arch/x86_64/ia32/sys_ia32.c 2.5.60-32bit.1/arch/x86_64/ia32/sys_ia32.c
--- 2.5.60/arch/x86_64/ia32/sys_ia32.c	2003-01-17 14:01:02.000000000 +1100
+++ 2.5.60-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-02-11 12:21:29.000000000 +1100
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
@@ -1219,55 +1219,18 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (verify_area(VERIFY_WRITE, interval, sizeof(struct compat_timespec)) ||
-	    __put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
 
-extern asmlinkage long sys_sigprocmask(int how, old_sigset_t *set,
-				      old_sigset_t *oset);
-
-asmlinkage long
-sys32_sigprocmask(int how, old_sigset32_t *set, old_sigset32_t *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (set && get_user (s, set)) return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs (old_fs);
-	if (ret) return ret;
-	if (oset && put_user (s, oset)) return -EFAULT;
-	return 0;
-}
-
-extern asmlinkage long sys_sigpending(old_sigset_t *set);
-
-asmlinkage long
-sys32_sigpending(old_sigset32_t *set)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-		
-	set_fs (KERNEL_DS);
-	ret = sys_sigpending(&s);
-	set_fs (old_fs);
-	if (put_user (s, set)) return -EFAULT;
-	return ret;
-}
-
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
 		
@@ -1281,7 +1244,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (set, &s32, sizeof(sigset32_t)))
+		if (copy_to_user (set, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return ret;
@@ -1369,18 +1332,18 @@
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
@@ -1388,14 +1351,11 @@
 	case 2: s.sig[1] = s32.sig[2] | (((long)s32.sig[3]) << 32);
 	case 1: s.sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
 	}
-	if (uts) {
-		if (verify_area(VERIFY_READ, uts, sizeof(struct compat_timespec)) ||
-		    __get_user (t.tv_sec, &uts->tv_sec) ||
-		    __get_user (t.tv_nsec, &uts->tv_nsec))
-			return -EFAULT;
-	}
+	if (uts && get_compat_timespec(&t, uts))
+		return -EFAULT;
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigtimedwait(&s, &info, &t, sigsetsize);
+	ret = sys_rt_sigtimedwait(&s, uinfo ? &info : NULL, uts ? &t : NULL,
+			sigsetsize);
 	set_fs (old_fs);
 	if (ret >= 0 && uinfo) {
 		if (copy_to_user (uinfo, siginfo64to32(&info32, &info),
@@ -2248,20 +2208,13 @@
 	mm_segment_t oldfs = get_fs(); 
 	int err;
 
-	if (utime32) {
-		if (verify_area(VERIFY_READ, utime32, sizeof(*utime32)))
-			return -EFAULT;
-
-		if (__get_user(t.tv_sec, &utime32->tv_sec) ||
-		    __get_user(t.tv_nsec, &utime32->tv_nsec))
-			return -EFAULT;
-		
-	}
+	if (utime32 && get_compat_timespec(&t, utime32))
+		return -EFAULT;
 
 	/* the set_fs is safe because futex doesn't use the seg limit 
 	   for valid page checking of uaddr. */ 
 	set_fs(KERNEL_DS); 
-	err = sys_futex(uaddr, op, val, &t);
+	err = sys_futex(uaddr, op, val, utime32 ? &t : NULL);
 	set_fs(oldfs); 
 	return err; 
 }
@@ -2340,22 +2293,18 @@
 { 	
 	long ret;
 	mm_segment_t oldfs; 
-	struct timespec t32;
+	struct timespec t;
 	/* Harden against bogus ptrace */
 	if (nr >= 0xffffffff || 
 	    !access_ok(VERIFY_WRITE, events, nr * sizeof(struct io_event)))
 		return -EFAULT;
-	if (timeout && 
-	    (get_user(t32.tv_sec, &timeout->tv_sec)  || 
-	     __get_user(t32.tv_nsec, &timeout->tv_nsec)))
+	if (timeout && get_compat_timespec(&t, timeout))
 		return -EFAULT; 
 	oldfs = get_fs();
 	set_fs(KERNEL_DS); 
-	ret = sys_io_getevents(ctx_id,min_nr,nr,events,timeout ? &t32 : NULL); 
+	ret = sys_io_getevents(ctx_id,min_nr,nr,events,timeout ? &t : NULL); 
 	set_fs(oldfs); 
-	if (timeout && 
-	    (__put_user(t32.tv_sec, &timeout->tv_sec) || 
-	     __put_user(t32.tv_nsec, &timeout->tv_nsec)))
+	if (timeout && put_compat_timespec(&t, timeout))
 		return -EFAULT; 		
 	return ret;
 } 
diff -ruN 2.5.60/include/asm-x86_64/ia32.h 2.5.60-32bit.1/include/asm-x86_64/ia32.h
--- 2.5.60/include/asm-x86_64/ia32.h	2003-01-17 14:01:07.000000000 +1100
+++ 2.5.60-32bit.1/include/asm-x86_64/ia32.h	2003-02-11 12:21:29.000000000 +1100
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
