Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbTAOGgT>; Wed, 15 Jan 2003 01:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAOGgS>; Wed, 15 Jan 2003 01:36:18 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:26293 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265683AbTAOGgJ>;
	Wed, 15 Jan 2003 01:36:09 -0500
Date: Wed, 15 Jan 2003 17:44:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] compat_{old_}sigset_t s390x part
Message-Id: <20030115174444.60bd4989.sfr@canb.auug.org.au>
In-Reply-To: <20030115173415.33e172c2.sfr@canb.auug.org.au>
References: <20030115173415.33e172c2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

With Martin's continuing approval, here is the s390x part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.4/arch/s390x/kernel/linux32.c 2.5.58-32bit.5/arch/s390x/kernel/linux32.c
--- 2.5.58-32bit.4/arch/s390x/kernel/linux32.c	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.5/arch/s390x/kernel/linux32.c	2003-01-15 14:51:38.000000000 +1100
@@ -1623,7 +1623,7 @@
 
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
 
-asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, old_sigset_t32 *oset)
+asmlinkage int sys32_sigprocmask(int how, compat_old_sigset_t *set, compat_old_sigset_t *oset)
 {
 	old_sigset_t s;
 	int ret;
@@ -1640,15 +1640,15 @@
 
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
@@ -1668,7 +1668,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (oset, &s32, sizeof(sigset_t32)))
+		if (copy_to_user (oset, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return 0;
@@ -1676,7 +1676,7 @@
 
 extern asmlinkage int sys_sigpending(old_sigset_t *set);
 
-asmlinkage int sys32_sigpending(old_sigset_t32 *set)
+asmlinkage int sys32_sigpending(compat_old_sigset_t *set)
 {
 	old_sigset_t s;
 	int ret;
@@ -1691,10 +1691,10 @@
 
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset_t32 *set, compat_size_t sigsetsize)
+asmlinkage int sys32_rt_sigpending(compat_sigset_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
-	sigset_t32 s32;
+	compat_sigset_t s32;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 		
@@ -1708,7 +1708,7 @@
 		case 2: s32.sig[3] = (s.sig[1] >> 32); s32.sig[2] = s.sig[1];
 		case 1: s32.sig[1] = (s.sig[0] >> 32); s32.sig[0] = s.sig[0];
 		}
-		if (copy_to_user (set, &s32, sizeof(sigset_t32)))
+		if (copy_to_user (set, &s32, sizeof(compat_sigset_t)))
 			return -EFAULT;
 	}
 	return ret;
@@ -1718,12 +1718,12 @@
 copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from);
 
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
@@ -1732,7 +1732,7 @@
 	if (sigsetsize != sizeof(sigset_t))
 		return -EINVAL;
 
-	if (copy_from_user (&these32, uthese, sizeof(sigset_t32)))
+	if (copy_from_user (&these32, uthese, sizeof(compat_sigset_t)))
 		return -EFAULT;
 
 	switch (_NSIG_WORDS) {
diff -ruN 2.5.58-32bit.4/arch/s390x/kernel/linux32.h 2.5.58-32bit.5/arch/s390x/kernel/linux32.h
--- 2.5.58-32bit.4/arch/s390x/kernel/linux32.h	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.5/arch/s390x/kernel/linux32.h	2003-01-15 16:23:14.000000000 +1100
@@ -25,20 +25,13 @@
 #define F_SETLK64       13
 #define F_SETLKW64      14    
 
-typedef __u32 old_sigset_t32;       /* at least 32 bits */ 
-
 struct old_sigaction32 {
        __u32			sa_handler;	/* Really a pointer, but need to deal with 32 bits */
-       old_sigset_t32		sa_mask;	/* A 32 bit mask */
+       compat_old_sigset_t	sa_mask;	/* A 32 bit mask */
        __u32			sa_flags;
        __u32			sa_restorer;	/* Another 32 bit pointer */
 };
  
-#define _SIGCONTEXT_NSIG_WORDS32    2 
-typedef struct {
-        __u32   sig[_SIGCONTEXT_NSIG_WORDS32];
-} sigset_t32;  
-
 typedef union sigval32 {
         int     sival_int;
         __u32   sival_ptr;
@@ -174,7 +167,7 @@
 
 struct sigcontext32
 {
-	__u32	oldmask[_SIGCONTEXT_NSIG_WORDS32];
+	__u32	oldmask[_COMPAT_NSIG_WORDS];
 	__u32	sregs;				/* pointer */
 };
 
@@ -183,7 +176,7 @@
 	__u32		sa_handler;		/* pointer */
 	__u32		sa_flags;
         __u32		sa_restorer;		/* pointer */
-	sigset_t32	sa_mask;        /* mask last for extensibility */
+	compat_sigset_t	sa_mask;        /* mask last for extensibility */
 };
 
 typedef struct {
@@ -198,7 +191,7 @@
 	__u32			uc_link;	/* pointer */	
 	stack_t32		uc_stack;
 	_sigregs32		uc_mcontext;
-	sigset_t32		uc_sigmask;	/* mask last for extensibility */
+	compat_sigset_t		uc_sigmask;	/* mask last for extensibility */
 };
 
 #endif /* _ASM_S390X_S390_H */
diff -ruN 2.5.58-32bit.4/arch/s390x/kernel/signal32.c 2.5.58-32bit.5/arch/s390x/kernel/signal32.c
--- 2.5.58-32bit.4/arch/s390x/kernel/signal32.c	2002-10-08 12:02:40.000000000 +1000
+++ 2.5.58-32bit.5/arch/s390x/kernel/signal32.c	2003-01-15 14:51:50.000000000 +1100
@@ -12,6 +12,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -127,10 +128,10 @@
 }
 
 asmlinkage int
-sys32_rt_sigsuspend(struct pt_regs * regs,sigset_t32 *unewset, size_t sigsetsize)
+sys32_rt_sigsuspend(struct pt_regs * regs,compat_sigset_t *unewset, size_t sigsetsize)
 {
 	sigset_t saveset, newset;
-	sigset_t32 set32;
+	compat_sigset_t set32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
@@ -169,7 +170,7 @@
         int ret;
 
         if (act) {
-		old_sigset_t32 mask;
+		compat_old_sigset_t mask;
 		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user((unsigned long)new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user((unsigned long)new_ka.sa.sa_restorer, &act->sa_restorer))
@@ -202,16 +203,16 @@
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
-	sigset_t32 set32;
+	compat_sigset_t set32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t32))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
 	if (act) {
 		ret = get_user((unsigned long)new_ka.sa.sa_handler, &act->sa_handler);
 		ret |= __copy_from_user(&set32, &act->sa_mask,
-					sizeof(sigset_t32));
+					sizeof(compat_sigset_t));
 		switch (_NSIG_WORDS) {
 		case 4: new_ka.sa.sa_mask.sig[3] = set32.sig[6]
 				| (((long)set32.sig[7]) << 32);
@@ -247,7 +248,7 @@
 		}
 		ret = put_user((unsigned long)old_ka.sa.sa_handler, &oact->sa_handler);
 		ret |= __copy_to_user(&oact->sa_mask, &set32,
-				      sizeof(sigset_t32));
+				      sizeof(compat_sigset_t));
 		ret |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 	}
 
diff -ruN 2.5.58-32bit.4/include/asm-s390x/compat.h 2.5.58-32bit.5/include/asm-s390x/compat.h
--- 2.5.58-32bit.4/include/asm-s390x/compat.h	2003-01-14 09:57:58.000000000 +1100
+++ 2.5.58-32bit.5/include/asm-s390x/compat.h	2003-01-15 16:37:36.000000000 +1100
@@ -76,8 +76,15 @@
 	s32		f_files;
 	s32		f_ffree;
 	compat_fsid_t	f_fsid;
-	s32		f_namelen;  
+	s32		f_namelen;
 	s32		f_spare[6];
 };
 
+typedef u32		compat_old_sigset_t;	/* at least 32 bits */
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_S390X_COMPAT_H */
