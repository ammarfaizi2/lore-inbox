Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUFKP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUFKP0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUFKP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:26:20 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:62085 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264054AbUFKPWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:22:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sparse: user annotations for s390 architecture
Date: Fri, 11 Jun 2004 17:21:20 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_x3cyAmX16ApnvYG";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111721.21335.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_x3cyAmX16ApnvYG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Lots of trivial changes to make sparse happy on s390 arch code,
mostly __user annotations.

 arch/s390/kernel/compat_signal.c |   54 ++++++++++++++++++++--------------=
=2D----
 arch/s390/kernel/debug.c         |   24 ++++++++---------
 arch/s390/kernel/process.c       |   13 +++++----
 arch/s390/kernel/profile.c       |    3 +-
 arch/s390/kernel/ptrace.c        |   18 +++++++------
 arch/s390/kernel/signal.c        |   48 +++++++++++++++++++---------------
 arch/s390/kernel/sys_s390.c      |   46 ++++++++++++++++-----------------
 arch/s390/kernel/traps.c         |    4 +-
 arch/s390/mm/ioremap.c           |    2 -
 include/asm-s390/checksum.h      |    4 +-
 include/asm-s390/compat.h        |    8 ++---
 include/asm-s390/debug.h         |   23 +---------------
 include/asm-s390/idals.h         |    8 ++---
 include/asm-s390/ipc.h           |    2 -
 include/asm-s390/spinlock.h      |    8 ++---
 include/asm-s390/uaccess.h       |   46 ++++++++++++++++++++++++---------
 16 files changed, 164 insertions(+), 147 deletions(-)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D arch/s390/kernel/compat_signal.c 1.9 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.9/arch/s390/kernel/compat_signal.c	Sat Apr 17 20:19:30 2004
+++ edited/arch/s390/kernel/compat_signal.c	Sun Jun  6 22:49:58 2004
@@ -53,7 +53,7 @@
=20
 asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
=20
=2Dint copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from)
+int copy_siginfo_to_user32(siginfo_t32 __user *to, siginfo_t *from)
 {
 	int err;
=20
@@ -130,7 +130,8 @@
 }
=20
 asmlinkage int
=2Dsys32_rt_sigsuspend(struct pt_regs * regs,compat_sigset_t *unewset, size=
_t sigsetsize)
+sys32_rt_sigsuspend(struct pt_regs * regs, compat_sigset_t __user *unewset,
+								size_t sigsetsize)
 {
 	sigset_t saveset, newset;
 	compat_sigset_t set32;
@@ -162,11 +163,11 @@
                 if (do_signal(regs, &saveset))
                         return -EINTR;
         }
=2D}                                                        =20
+}
=20
 asmlinkage long
=2Dsys32_sigaction(int sig, const struct old_sigaction32 *act,
=2D		 struct old_sigaction32 *oact)
+sys32_sigaction(int sig, const struct old_sigaction32 __user *act,
+		 struct old_sigaction32 __user *oact)
 {
         struct k_sigaction new_ka, old_ka;
         int ret;
@@ -199,9 +200,9 @@
 int
 do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *o=
act);
=20
=2Dasmlinkage long=20
=2Dsys32_rt_sigaction(int sig, const struct sigaction32 *act,
=2D	   struct sigaction32 *oact,  size_t sigsetsize)
+asmlinkage long
+sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
+	   struct sigaction32 __user *oact,  size_t sigsetsize)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -258,7 +259,8 @@
 }
=20
 asmlinkage long
=2Dsys32_sigaltstack(const stack_t32 *uss, stack_t32 *uoss, struct pt_regs =
*regs)
+sys32_sigaltstack(const stack_t32 __user *uss, stack_t32 __user *uoss,
+							struct pt_regs *regs)
 {
 	stack_t kss, koss;
 	int ret, err =3D 0;
@@ -275,7 +277,9 @@
 	}
=20
 	set_fs (KERNEL_DS);
=2D	ret =3D do_sigaltstack(uss ? &kss : NULL , uoss ? &koss : NULL, regs->g=
prs[15]);
+	ret =3D do_sigaltstack((stack_t __user *) (uss ? &kss : NULL),
+			     (stack_t __user *) (uoss ? &koss : NULL),
+			     regs->gprs[15]);
 	set_fs (old_fs);
=20
 	if (!ret && uoss) {
@@ -290,7 +294,7 @@
 	return ret;
 }
=20
=2Dstatic int save_sigregs32(struct pt_regs *regs,_sigregs32 *sregs)
+static int save_sigregs32(struct pt_regs *regs, _sigregs32 __user *sregs)
 {
 	_s390_regs_common32 regs32;
 	int err, i;
@@ -311,7 +315,7 @@
 			      sizeof(_s390_fp_regs32));
 }
=20
=2Dstatic int restore_sigregs32(struct pt_regs *regs,_sigregs32 *sregs)
+static int restore_sigregs32(struct pt_regs *regs,_sigregs32 __user *sregs)
 {
 	_s390_regs_common32 regs32;
 	int err, i;
@@ -343,7 +347,7 @@
=20
 asmlinkage long sys32_sigreturn(struct pt_regs *regs)
 {
=2D	sigframe32 *frame =3D (sigframe32 *)regs->gprs[15];
+	sigframe32 __user *frame =3D (sigframe32 __user *)regs->gprs[15];
 	sigset_t set;
=20
 	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
@@ -365,11 +369,11 @@
 badframe:
 	force_sig(SIGSEGV, current);
 	return 0;
=2D}=09
+}
=20
 asmlinkage long sys32_rt_sigreturn(struct pt_regs *regs)
 {
=2D	rt_sigframe32 *frame =3D (rt_sigframe32 *)regs->gprs[15];
+	rt_sigframe32 __user *frame =3D (rt_sigframe32 __user *)regs->gprs[15];
 	sigset_t set;
 	stack_t st;
 	__u32 ss_sp;
@@ -399,8 +403,8 @@
=20
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
=2D	set_fs (KERNEL_DS);  =20
=2D	do_sigaltstack(&st, NULL, regs->gprs[15]);
+	set_fs (KERNEL_DS);
+	do_sigaltstack((stack_t __user *)&st, NULL, regs->gprs[15]);
 	set_fs (old_fs);
=20
 	return regs->gprs[2];
@@ -418,7 +422,7 @@
 /*
  * Determine which stack to use..
  */
=2Dstatic inline void *
+static inline void __user *
 get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_s=
ize)
 {
 	unsigned long sp;
@@ -439,7 +443,7 @@
 		sp =3D (unsigned long) ka->sa.sa_restorer;
 	}
=20
=2D	return (void *)((sp - frame_size) & -8ul);
+	return (void __user *)((sp - frame_size) & -8ul);
 }
=20
 static inline int map_signal(int sig)
@@ -455,7 +459,7 @@
 static void setup_frame32(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
=2D	sigframe32 *frame =3D get_sigframe(ka, regs, sizeof(sigframe32));
+	sigframe32 __user *frame =3D get_sigframe(ka, regs, sizeof(sigframe32));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(sigframe32)))
 		goto give_sigsegv;
=20
@@ -474,12 +478,12 @@
 	} else {
 		regs->gprs[14] =3D (__u64) frame->retcode;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
=2D		               (u16 *)(frame->retcode)))
+		               (u16 __user *)(frame->retcode)))
 			goto give_sigsegv;
         }
=20
 	/* Set up backchain. */
=2D	if (__put_user(regs->gprs[15], (unsigned int *) frame))
+	if (__put_user(regs->gprs[15], (unsigned int __user *) frame))
 		goto give_sigsegv;
=20
 	/* Set up registers for signal handler */
@@ -505,7 +509,7 @@
 			   sigset_t *set, struct pt_regs * regs)
 {
 	int err =3D 0;
=2D	rt_sigframe32 *frame =3D get_sigframe(ka, regs, sizeof(rt_sigframe32));
+	rt_sigframe32 __user *frame =3D get_sigframe(ka, regs, sizeof(rt_sigframe=
32));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(rt_sigframe32)))
 		goto give_sigsegv;
=20
@@ -531,11 +535,11 @@
 	} else {
 		regs->gprs[14] =3D (__u64) frame->retcode;
 		err |=3D __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
=2D		                  (u16 *)(frame->retcode));
+		                  (u16 __user *)(frame->retcode));
 	}
=20
 	/* Set up backchain. */
=2D	if (__put_user(regs->gprs[15], (unsigned int *) frame))
+	if (__put_user(regs->gprs[15], (unsigned int __user *) frame))
 		goto give_sigsegv;
=20
 	/* Set up registers for signal handler */
=3D=3D=3D=3D=3D arch/s390/kernel/debug.c 1.15 vs edited =3D=3D=3D=3D=3D
=2D-- 1.15/arch/s390/kernel/debug.c	Mon May 26 21:20:45 2003
+++ edited/arch/s390/kernel/debug.c	Sat Jun  5 13:18:43 2004
@@ -62,9 +62,9 @@
 /* internal function prototyes */
=20
 static int debug_init(void);
=2Dstatic ssize_t debug_output(struct file *file, char *user_buf,
+static ssize_t debug_output(struct file *file, char __user *user_buf,
 			    size_t user_len, loff_t * offset);
=2Dstatic ssize_t debug_input(struct file *file, const char *user_buf,
+static ssize_t debug_input(struct file *file, const char __user *user_buf,
 			   size_t user_len, loff_t * offset);
 static int debug_open(struct inode *inode, struct file *file);
 static int debug_close(struct inode *inode, struct file *file);
@@ -74,10 +74,10 @@
 static int debug_prolog_level_fn(debug_info_t * id,
 				 struct debug_view *view, char *out_buf);
 static int debug_input_level_fn(debug_info_t * id, struct debug_view *view,
=2D				struct file *file, const char *user_buf,
+				struct file *file, const char __user *user_buf,
 				size_t user_buf_size, loff_t * offset);
 static int debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
=2D                                struct file *file, const char *user_buf,
+                                struct file *file, const char __user *user=
_buf,
                                 size_t user_buf_size, loff_t * offset);
 static int debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view =
*view,
                                 char *out_buf, const char *in_buf);
@@ -416,10 +416,10 @@
  * - copies formated debug entries to the user buffer
  */
=20
=2Dstatic ssize_t debug_output(struct file *file,	/* file descriptor */
=2D			    char *user_buf,	/* user buffer */
=2D			    size_t  len,	/* length of buffer */
=2D			    loff_t *offset	/* offset in the file */ )
+static ssize_t debug_output(struct file *file,		/* file descriptor */
+			    char __user *user_buf,	/* user buffer */
+			    size_t  len,		/* length of buffer */
+			    loff_t *offset)	      /* offset in the file */
 {
 	size_t count =3D 0;
 	size_t entry_offset, size =3D 0;
@@ -462,7 +462,7 @@
  */
=20
 static ssize_t debug_input(struct file *file,
=2D			   const char *user_buf, size_t length,
+			   const char __user *user_buf, size_t length,
 			   loff_t *offset)
 {
 	int rc =3D 0;
@@ -942,7 +942,7 @@
  */
=20
 static int debug_input_level_fn(debug_info_t * id, struct debug_view *view,
=2D				struct file *file, const char *user_buf,
+				struct file *file, const char __user *user_buf,
 				size_t in_buf_size, loff_t * offset)
 {
 	char input_buf[1];
@@ -1004,9 +1004,9 @@
 /*
  * view function: flushes debug areas=20
  */
=2D=20
+
 static int debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
=2D                                struct file *file, const char *user_buf,
+                                struct file *file, const char __user *user=
_buf,
                                 size_t in_buf_size, loff_t * offset)
 {
         char input_buf[1];
=3D=3D=3D=3D=3D arch/s390/kernel/process.c 1.25 vs edited =3D=3D=3D=3D=3D
=2D-- 1.25/arch/s390/kernel/process.c	Mon May 10 13:25:34 2004
+++ edited/arch/s390/kernel/process.c	Sat Jun  5 13:25:07 2004
@@ -16,6 +16,7 @@
  */
=20
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -292,12 +293,12 @@
 {
         unsigned long clone_flags;
         unsigned long newsp;
=2D	int *parent_tidptr, *child_tidptr;
+	int __user *parent_tidptr, *child_tidptr;
=20
         clone_flags =3D regs.gprs[3];
         newsp =3D regs.orig_gpr2;
=2D	parent_tidptr =3D (int *) regs.gprs[4];
=2D	child_tidptr =3D (int *) regs.gprs[5];
+	parent_tidptr =3D (int __user *) regs.gprs[4];
+	child_tidptr =3D (int __user *) regs.gprs[5];
         if (!newsp)
                 newsp =3D regs.gprs[15];
         return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
@@ -328,12 +329,12 @@
         int error;
         char * filename;
=20
=2D        filename =3D getname((char *) regs.orig_gpr2);
+        filename =3D getname((char __user *) regs.orig_gpr2);
         error =3D PTR_ERR(filename);
         if (IS_ERR(filename))
                 goto out;
=2D        error =3D do_execve(filename, (char **) regs.gprs[3],
=2D			  (char **) regs.gprs[4], &regs);
+        error =3D do_execve(filename, (char __user * __user *) regs.gprs[3=
],
+			  (char __user * __user *) regs.gprs[4], &regs);
 	if (error =3D=3D 0) {
 		current->ptrace &=3D ~PT_DTRACE;
 		current->thread.fp_regs.fpc =3D 0;
=3D=3D=3D=3D=3D arch/s390/kernel/profile.c 1.1 vs edited =3D=3D=3D=3D=3D
=2D-- 1.1/arch/s390/kernel/profile.c	Thu Apr 29 11:41:09 2004
+++ edited/arch/s390/kernel/profile.c	Sat Jun  5 13:19:22 2004
@@ -19,7 +19,8 @@
 	return len;
 }
=20
=2Dstatic int prof_cpu_mask_write_proc (struct file *file, const char *buff=
er,
+static int prof_cpu_mask_write_proc (struct file *file,
+					const char __user *buffer,
 					unsigned long count, void *data)
 {
 	cpumask_t *mask =3D (cpumask_t *)data;
=3D=3D=3D=3D=3D arch/s390/kernel/ptrace.c 1.22 vs edited =3D=3D=3D=3D=3D
=2D-- 1.22/arch/s390/kernel/ptrace.c	Thu Apr 15 03:37:53 2004
+++ edited/arch/s390/kernel/ptrace.c	Sun Jun  6 20:56:40 2004
@@ -176,7 +176,7 @@
 	} else
 		tmp =3D 0;
=20
=2D	return put_user(tmp, (addr_t *) data);
+	return put_user(tmp, (addr_t __user *) data);
 }
=20
 /*
@@ -269,7 +269,7 @@
 		copied =3D access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied !=3D sizeof(tmp))
 			return -EIO;
=2D		return put_user(tmp, (unsigned long *) data);
+		return put_user(tmp, (unsigned long __user *) data);
=20
 	case PTRACE_PEEKUSR:
 		/* read the word at location addr in the USER area. */
@@ -291,7 +291,8 @@
=20
 	case PTRACE_PEEKUSR_AREA:
 	case PTRACE_POKEUSR_AREA:
=2D		if (copy_from_user(&parea, (void *) addr, sizeof(parea)))
+		if (copy_from_user(&parea, (void __user *) addr,
+							sizeof(parea)))
 			return -EFAULT;
 		addr =3D parea.kernel_addr;
 		data =3D parea.process_addr;
@@ -301,7 +302,7 @@
 				ret =3D peek_user(child, addr, data);
 			else {
 				addr_t tmp;
=2D				if (get_user (tmp, (addr_t *) data))
+				if (get_user (tmp, (addr_t __user *) data))
 					return -EFAULT;
 				ret =3D poke_user(child, addr, tmp);
 			}
@@ -402,7 +403,7 @@
 	} else
 		tmp =3D 0;
=20
=2D	return put_user(tmp, (__u32 *) data);
+	return put_user(tmp, (__u32 __user *) data);
 }
=20
 /*
@@ -509,7 +510,7 @@
 		copied =3D access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied !=3D sizeof(tmp))
 			return -EIO;
=2D		return put_user(tmp, (unsigned int *) data);
+		return put_user(tmp, (unsigned int __user *) data);
=20
 	case PTRACE_PEEKUSR:
 		/* read the word at location addr in the USER area. */
@@ -530,7 +531,8 @@
=20
 	case PTRACE_PEEKUSR_AREA:
 	case PTRACE_POKEUSR_AREA:
=2D		if (copy_from_user(&parea, (void *) addr, sizeof(parea)))
+		if (copy_from_user(&parea, (void __user *) addr,
+							sizeof(parea)))
 			return -EFAULT;
 		addr =3D parea.kernel_addr;
 		data =3D parea.process_addr;
@@ -540,7 +542,7 @@
 				ret =3D peek_user_emu31(child, addr, data);
 			else {
 				__u32 tmp;
=2D				if (get_user (tmp, (__u32 *) data))
+				if (get_user (tmp, (__u32 __user *) data))
 					return -EFAULT;
 				ret =3D poke_user_emu31(child, addr, tmp);
 			}
=3D=3D=3D=3D=3D arch/s390/kernel/signal.c 1.25 vs edited =3D=3D=3D=3D=3D
=2D-- 1.25/arch/s390/kernel/signal.c	Sat Mar 27 12:40:46 2004
+++ edited/arch/s390/kernel/signal.c	Sat Jun  5 17:44:23 2004
@@ -77,8 +77,9 @@
 	}
 }
=20
=2Dasmlinkage int
=2Dsys_rt_sigsuspend(struct pt_regs * regs,sigset_t *unewset, size_t sigset=
size)
+asmlinkage long
+sys_rt_sigsuspend(struct pt_regs *regs, sigset_t __user *unewset,
+						size_t sigsetsize)
 {
 	sigset_t saveset, newset;
=20
@@ -105,9 +106,9 @@
 	}
 }
=20
=2Dasmlinkage int=20
=2Dsys_sigaction(int sig, const struct old_sigaction *act,
=2D	      struct old_sigaction *oact)
+asmlinkage long
+sys_sigaction(int sig, const struct old_sigaction __user *act,
+	      struct old_sigaction __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -137,8 +138,9 @@
 	return ret;
 }
=20
=2Dasmlinkage int
=2Dsys_sigaltstack(const stack_t *uss, stack_t *uoss, struct pt_regs *regs)
+asmlinkage long
+sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
+					struct pt_regs *regs)
 {
 	return do_sigaltstack(uss, uoss, regs->gprs[15]);
 }
@@ -146,7 +148,7 @@
=20
=20
 /* Returns non-zero on fault. */
=2Dstatic int save_sigregs(struct pt_regs *regs, _sigregs *sregs)
+static int save_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
 	unsigned long old_mask =3D regs->psw.mask;
 	int err;
@@ -175,7 +177,7 @@
 }
=20
 /* Returns positive number on error */
=2Dstatic int restore_sigregs(struct pt_regs *regs, _sigregs *sregs)
+static int restore_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
 	unsigned long old_mask =3D regs->psw.mask;
 	int err;
@@ -208,7 +210,7 @@
=20
 asmlinkage long sys_sigreturn(struct pt_regs *regs)
 {
=2D	sigframe *frame =3D (sigframe *)regs->gprs[15];
+	sigframe __user *frame =3D (sigframe __user *)regs->gprs[15];
 	sigset_t set;
=20
 	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
@@ -234,7 +236,7 @@
=20
 asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 {
=2D	rt_sigframe *frame =3D (rt_sigframe *)regs->gprs[15];
+	rt_sigframe __user *frame =3D (rt_sigframe __user *)regs->gprs[15];
 	sigset_t set;
=20
 	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
@@ -269,7 +271,7 @@
 /*
  * Determine which stack to use..
  */
=2Dstatic inline void *
+static inline void __user *
 get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_s=
ize)
 {
 	unsigned long sp;
@@ -290,7 +292,7 @@
 		sp =3D (unsigned long) ka->sa.sa_restorer;
 	}
=20
=2D	return (void *)((sp - frame_size) & -8ul);
+	return (void __user *)((sp - frame_size) & -8ul);
 }
=20
 static inline int map_signal(int sig)
@@ -306,7 +308,9 @@
 static void setup_frame(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
=2D	sigframe *frame =3D get_sigframe(ka, regs, sizeof(sigframe));
+	sigframe __user *frame;
+
+	frame =3D get_sigframe(ka, regs, sizeof(sigframe));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(sigframe)))
 		goto give_sigsegv;
=20
@@ -326,13 +330,13 @@
 	} else {
                 regs->gprs[14] =3D (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
=2D		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,=20
=2D	                       (u16 *)(frame->retcode)))
+		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
+	                       (u16 __user *)(frame->retcode)))
 			goto give_sigsegv;
 	}
=20
 	/* Set up backchain. */
=2D	if (__put_user(regs->gprs[15], (addr_t *) frame))
+	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
 		goto give_sigsegv;
=20
 	/* Set up registers for signal handler */
@@ -358,7 +362,9 @@
 			   sigset_t *set, struct pt_regs * regs)
 {
 	int err =3D 0;
=2D	rt_sigframe *frame =3D get_sigframe(ka, regs, sizeof(rt_sigframe));
+	rt_sigframe __user *frame;
+
+	frame =3D get_sigframe(ka, regs, sizeof(rt_sigframe));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(rt_sigframe)))
 		goto give_sigsegv;
=20
@@ -385,12 +391,12 @@
 	} else {
                 regs->gprs[14] =3D (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
=2D		err |=3D __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,=20
=2D	                          (u16 *)(frame->retcode));
+		err |=3D __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
+	                          (u16 __user *)(frame->retcode));
 	}
=20
 	/* Set up backchain. */
=2D	if (__put_user(regs->gprs[15], (addr_t *) frame))
+	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
 		goto give_sigsegv;
=20
 	/* Set up registers for signal handler */
=3D=3D=3D=3D=3D arch/s390/kernel/sys_s390.c 1.14 vs edited =3D=3D=3D=3D=3D
=2D-- 1.14/arch/s390/kernel/sys_s390.c	Sat May 15 04:00:18 2004
+++ edited/arch/s390/kernel/sys_s390.c	Sun Jun  6 20:55:16 2004
@@ -37,7 +37,7 @@
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
=2Dasmlinkage long sys_pipe(unsigned long * fildes)
+asmlinkage long sys_pipe(unsigned long __user *fildes)
 {
 	int fd[2];
 	int error;
@@ -92,7 +92,7 @@
 	unsigned long offset;
 };
=20
=2Dasmlinkage long sys_mmap2(struct mmap_arg_struct *arg)
+asmlinkage long sys_mmap2(struct mmap_arg_struct __user  *arg)
 {
 	struct mmap_arg_struct a;
 	int error =3D -EFAULT;
@@ -104,7 +104,7 @@
 	return error;
 }
=20
=2Dasmlinkage long old_mmap(struct mmap_arg_struct *arg)
+asmlinkage long old_mmap(struct mmap_arg_struct __user *arg)
 {
 	struct mmap_arg_struct a;
 	long error =3D -EFAULT;
@@ -128,7 +128,7 @@
 	struct timeval *tvp;
 };
=20
=2Dasmlinkage long old_select(struct sel_arg_struct *arg)
+asmlinkage long old_select(struct sel_arg_struct __user *arg)
 {
 	struct sel_arg_struct a;
=20
@@ -145,37 +145,37 @@
  *
  * This is really horribly ugly.
  */
=2Dasmlinkage long sys_ipc (uint call, int first, int second,
=2D				  unsigned long third, void *ptr)
+asmlinkage long sys_ipc(uint call, int first, int second,
+				  unsigned long third, void __user *ptr)
 {
         struct ipc_kludge tmp;
 	int ret;
=20
         switch (call) {
         case SEMOP:
=2D		return sys_semtimedop (first, (struct sembuf *) ptr, second,
+		return sys_semtimedop (first, (struct sembuf __user *) ptr, second,
 				       NULL);
 	case SEMTIMEDOP:
=2D		return sys_semtimedop (first, (struct sembuf *) ptr, second,
=2D				       (const struct timespec *) third);
+		return sys_semtimedop (first, (struct sembuf __user *) ptr, second,
+				       (const struct timespec __user *) third);
         case SEMGET:
                 return sys_semget (first, second, third);
         case SEMCTL: {
                 union semun fourth;
                 if (!ptr)
                         return -EINVAL;
=2D                if (get_user(fourth.__pad, (void **) ptr))
+                if (get_user(fourth.__pad, (void __user * __user *) ptr))
                         return -EFAULT;
                 return sys_semctl (first, second, third, fourth);
=2D        }=20
+        }
         case MSGSND:
=2D		return sys_msgsnd (first, (struct msgbuf *) ptr,=20
+		return sys_msgsnd (first, (struct msgbuf __user *) ptr,
                                    second, third);
 		break;
         case MSGRCV:
                 if (!ptr)
                         return -EINVAL;
=2D                if (copy_from_user (&tmp, (struct ipc_kludge *) ptr,
+                if (copy_from_user (&tmp, (struct ipc_kludge __user *) ptr,
                                     sizeof (struct ipc_kludge)))
                         return -EFAULT;
                 return sys_msgrcv (first, tmp.msgp,
@@ -183,33 +183,33 @@
         case MSGGET:
                 return sys_msgget ((key_t) first, second);
         case MSGCTL:
=2D                return sys_msgctl (first, second, (struct msqid_ds *) pt=
r);
=2D               =20
+                return sys_msgctl (first, second, (struct msqid_ds __user =
*) ptr);
+
 	case SHMAT: {
 		ulong raddr;
=2D		ret =3D do_shmat (first, (char *) ptr, second, &raddr);
+		ret =3D do_shmat (first, (char __user *) ptr, second, &raddr);
 		if (ret)
 			return ret;
=2D		return put_user (raddr, (ulong *) third);
+		return put_user (raddr, (ulong __user *) third);
 		break;
         }
=2D	case SHMDT:=20
=2D		return sys_shmdt ((char *)ptr);
+	case SHMDT:
+		return sys_shmdt ((char __user *)ptr);
 	case SHMGET:
 		return sys_shmget (first, second, third);
 	case SHMCTL:
 		return sys_shmctl (first, second,
=2D                                   (struct shmid_ds *) ptr);
+                                   (struct shmid_ds __user *) ptr);
 	default:
 		return -ENOSYS;
=20
 	}
=2D       =20
+
 	return -EINVAL;
 }
=20
 #ifdef CONFIG_ARCH_S390X
=2Dasmlinkage long s390x_newuname(struct new_utsname * name)
+asmlinkage long s390x_newuname(struct new_utsname __user *name)
 {
 	int ret =3D sys_newuname(name);
=20
@@ -256,7 +256,7 @@
 };
=20
 asmlinkage long
=2Ds390_fadvise64_64(struct fadvise64_64_args *args)
+s390_fadvise64_64(struct fadvise64_64_args __user *args)
 {
 	struct fadvise64_64_args a;
=20
=3D=3D=3D=3D=3D arch/s390/kernel/traps.c 1.29 vs edited =3D=3D=3D=3D=3D
=2D-- 1.29/arch/s390/kernel/traps.c	Tue Apr 27 07:07:43 2004
+++ edited/arch/s390/kernel/traps.c	Sun Jun  6 20:54:27 2004
@@ -188,7 +188,7 @@
 	printk("%s Code: ", mode);
 	for (i =3D 0; i < 20; i++) {
 		unsigned char c;
=2D		if (__get_user(c, (char *)(regs->psw.addr + i))) {
+		if (__get_user(c, (char __user *)(regs->psw.addr + i))) {
 			printk(" Bad PSW.");
 			break;
 		}
@@ -391,7 +391,7 @@
 		local_irq_enable();
=20
 	if (regs->psw.mask & PSW_MASK_PSTATE)
=2D		get_user(*((__u16 *) opcode), location);
+		get_user(*((__u16 *) opcode), (__u16 __user *)location);
 	else
 		*((__u16 *)opcode)=3D*((__u16 *)location);
 	if (*((__u16 *)opcode)=3D=3DS390_BREAKPOINT_U16)
=3D=3D=3D=3D=3D arch/s390/mm/ioremap.c 1.8 vs edited =3D=3D=3D=3D=3D
=2D-- 1.8/arch/s390/mm/ioremap.c	Thu Oct  2 09:11:59 2003
+++ edited/arch/s390/mm/ioremap.c	Sat Jun  5 13:31:28 2004
@@ -134,5 +134,5 @@
 void iounmap(void *addr)
 {
 	if (addr > high_memory)
=2D		return vfree(addr);
+		vfree(addr);
 }
=3D=3D=3D=3D=3D include/asm-s390/checksum.h 1.11 vs edited =3D=3D=3D=3D=3D
=2D-- 1.11/include/asm-s390/checksum.h	Sat Jan 31 09:15:34 2004
+++ edited/include/asm-s390/checksum.h	Sun Jun  6 23:21:09 2004
@@ -93,8 +93,8 @@
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
=2Dstatic inline unsigned int=20
=2Dcsum_partial_copy_from_user (const char *src, char *dst,
+static inline unsigned int
+csum_partial_copy_from_user(const char __user *src, char *dst,
                                           int len, unsigned int sum,
                                           int *err_ptr)
 {
=3D=3D=3D=3D=3D include/asm-s390/compat.h 1.6 vs edited =3D=3D=3D=3D=3D
=2D-- 1.6/include/asm-s390/compat.h	Mon Mar 15 15:22:21 2004
+++ edited/include/asm-s390/compat.h	Sat Jun  5 16:38:46 2004
@@ -123,19 +123,19 @@
  */
 typedef	u32		compat_uptr_t;
=20
=2Dstatic inline void *compat_ptr(compat_uptr_t uptr)
+static inline void __user *compat_ptr(compat_uptr_t uptr)
 {
=2D	return (void *)(unsigned long)(uptr & 0x7fffffffUL);
+	return (void __user *)(unsigned long)(uptr & 0x7fffffffUL);
 }
=20
=2Dstatic inline void *compat_alloc_user_space(long len)
+static inline void __user *compat_alloc_user_space(long len)
 {
 	unsigned long stack;
=20
 	stack =3D KSTK_ESP(current);
 	if (test_thread_flag(TIF_31BIT))
 		stack &=3D 0x7fffffffUL;
=2D	return (void *) (stack - len);
+	return (void __user *) (stack - len);
 }
=20
 struct compat_ipc64_perm {
=3D=3D=3D=3D=3D include/asm-s390/debug.h 1.9 vs edited =3D=3D=3D=3D=3D
=2D-- 1.9/include/asm-s390/debug.h	Thu Feb 26 12:21:51 2004
+++ edited/include/asm-s390/debug.h	Sat Jun  5 13:17:08 2004
@@ -91,7 +91,8 @@
 				   char* out_buf);
 typedef int (debug_input_proc_t) (debug_info_t* id,
 				  struct debug_view* view,
=2D				  struct file* file, const char* user_buf,
+				  struct file* file,
+				  const char __user *user_buf,
 				  size_t in_buf_size, loff_t* offset);
=20
 int debug_dflt_header_fn(debug_info_t* id, struct debug_view* view,
@@ -232,26 +233,6 @@
 #define PRINT_WARN(x...) printk ( KERN_DEBUG PRINTK_HEADER x )
 #define PRINT_ERR(x...) printk ( KERN_DEBUG PRINTK_HEADER x )
 #define PRINT_FATAL(x...) printk ( KERN_DEBUG PRINTK_HEADER x )
=2D#endif				/* DASD_DEBUG */
=2D
=2D#if DASD_DEBUG > 4
=2D#define INTERNAL_ERROR(x...) PRINT_FATAL ( INTERNAL_ERRMSG ( x ) )
=2D#elif DASD_DEBUG > 2
=2D#define INTERNAL_ERROR(x...) PRINT_ERR ( INTERNAL_ERRMSG ( x ) )
=2D#elif DASD_DEBUG > 0
=2D#define INTERNAL_ERROR(x...) PRINT_WARN ( INTERNAL_ERRMSG ( x ) )
=2D#else
=2D#define INTERNAL_ERROR(x...)
=2D#endif				/* DASD_DEBUG */
=2D
=2D#if DASD_DEBUG > 5
=2D#define INTERNAL_CHECK(x...) PRINT_FATAL ( INTERNAL_CHKMSG ( x ) )
=2D#elif DASD_DEBUG > 3
=2D#define INTERNAL_CHECK(x...) PRINT_ERR ( INTERNAL_CHKMSG ( x ) )
=2D#elif DASD_DEBUG > 1
=2D#define INTERNAL_CHECK(x...) PRINT_WARN ( INTERNAL_CHKMSG ( x ) )
=2D#else
=2D#define INTERNAL_CHECK(x...)
 #endif				/* DASD_DEBUG */
=20
 #undef DEBUG_MALLOC
=3D=3D=3D=3D=3D include/asm-s390/idals.h 1.9 vs edited =3D=3D=3D=3D=3D
=2D-- 1.9/include/asm-s390/idals.h	Thu Feb 26 12:21:51 2004
+++ edited/include/asm-s390/idals.h	Sun Jun  6 19:31:40 2004
@@ -218,7 +218,7 @@
  * Copy count bytes from an idal buffer to user memory
  */
 static inline size_t
=2Didal_buffer_to_user(struct idal_buffer *ib, void *to, size_t count)
+idal_buffer_to_user(struct idal_buffer *ib, void __user *to, size_t count)
 {
 	size_t left;
 	int i;
@@ -228,7 +228,7 @@
 		left =3D copy_to_user(to, ib->data[i], IDA_BLOCK_SIZE);
 		if (left)
 			return left + count - IDA_BLOCK_SIZE;
=2D		to =3D (void *) to + IDA_BLOCK_SIZE;
+		to =3D (void __user *) to + IDA_BLOCK_SIZE;
 		count -=3D IDA_BLOCK_SIZE;
 	}
 	return copy_to_user(to, ib->data[i], count);
@@ -238,7 +238,7 @@
  * Copy count bytes from user memory to an idal buffer
  */
 static inline size_t
=2Didal_buffer_from_user(struct idal_buffer *ib, const void *from, size_t c=
ount)
+idal_buffer_from_user(struct idal_buffer *ib, const void __user *from, siz=
e_t count)
 {
 	size_t left;
 	int i;
@@ -248,7 +248,7 @@
 		left =3D copy_from_user(ib->data[i], from, IDA_BLOCK_SIZE);
 		if (left)
 			return left + count - IDA_BLOCK_SIZE;
=2D		from =3D (void *) from + IDA_BLOCK_SIZE;
+		from =3D (void __user *) from + IDA_BLOCK_SIZE;
 		count -=3D IDA_BLOCK_SIZE;
 	}
 	return copy_from_user(ib->data[i], from, count);
=3D=3D=3D=3D=3D include/asm-s390/ipc.h 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/include/asm-s390/ipc.h	Mon Apr 14 21:11:58 2003
+++ edited/include/asm-s390/ipc.h	Sat Jun  5 12:56:51 2004
@@ -15,7 +15,7 @@
  * See arch/s390/kernel/sys_s390.c for ugly details..
  */
 struct ipc_kludge {
=2D	struct msgbuf *msgp;
+	struct msgbuf __user *msgp;
 	long msgtyp;
 };
=20
=3D=3D=3D=3D=3D include/asm-s390/spinlock.h 1.15 vs edited =3D=3D=3D=3D=3D
=2D-- 1.15/include/asm-s390/spinlock.h	Mon May 10 13:25:44 2004
+++ edited/include/asm-s390/spinlock.h	Sat Jun  5 12:42:34 2004
@@ -48,7 +48,7 @@
 {
 #ifndef __s390x__
 	unsigned int reg1, reg2;
=2D        __asm__ __volatile("    bras  %0,1f\n"
+        __asm__ __volatile__("    bras  %0,1f\n"
                            "0:  diag  0,0,68\n"
                            "1:  slr   %1,%1\n"
                            "    cs    %1,%0,0(%3)\n"
@@ -58,7 +58,7 @@
 			   : "cc", "memory" );
 #else /* __s390x__ */
 	unsigned long reg1, reg2;
=2D        __asm__ __volatile("    bras  %1,1f\n"
+        __asm__ __volatile__("    bras  %1,1f\n"
                            "0:  " __DIAG44_INSN " 0,%4\n"
                            "1:  slr   %0,%0\n"
                            "    cs    %0,%1,0(%3)\n"
@@ -74,7 +74,7 @@
 	unsigned long reg;
 	unsigned int result;
=20
=2D	__asm__ __volatile("    basr  %1,0\n"
+	__asm__ __volatile__("    basr  %1,0\n"
 			   "0:  cs    %0,%1,0(%3)"
 			   : "=3Dd" (result), "=3D&d" (reg), "=3Dm" (lp->lock)
 			   : "a" (&lp->lock), "m" (lp->lock), "0" (0)
@@ -86,7 +86,7 @@
 {
 	unsigned int old;
=20
=2D	__asm__ __volatile("cs %0,%3,0(%4)"
+	__asm__ __volatile__("cs %0,%3,0(%4)"
 			   : "=3Dd" (old), "=3Dm" (lp->lock)
 			   : "0" (lp->lock), "d" (0), "a" (lp)
 			   : "cc", "memory" );
=3D=3D=3D=3D=3D include/asm-s390/uaccess.h 1.17 vs edited =3D=3D=3D=3D=3D
=2D-- 1.17/include/asm-s390/uaccess.h	Thu Jun  3 10:46:41 2004
+++ edited/include/asm-s390/uaccess.h	Sun Jun  6 20:38:13 2004
@@ -65,9 +65,10 @@
=20
 #define access_ok(type,addr,size) __access_ok(addr,size)
=20
=2Dextern inline int verify_area(int type, const void * addr, unsigned long=
 size)
+extern inline int verify_area(int type, const void __user *addr,
+						unsigned long size)
 {
=2D        return access_ok(type,addr,size)?0:-EFAULT;
+	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
=20
 /*
@@ -147,6 +148,7 @@
 })
 #endif
=20
+#ifndef __CHECKER__
 #define __put_user(x, ptr) \
 ({								\
 	__typeof__(*(ptr)) __x =3D (x);				\
@@ -164,6 +166,14 @@
 	 }							\
 	__pu_err;						\
 })
+#else
+#define __put_user(x, ptr)			\
+({						\
+	void __user *p;				\
+	p =3D (ptr);				\
+	0;					\
+})
+#endif
=20
 #define put_user(x, ptr)					\
 ({								\
@@ -202,6 +212,7 @@
 })
 #endif
=20
+#ifndef __CHECKER__
 #define __get_user(x, ptr)					\
 ({								\
 	__typeof__(*(ptr)) __x;					\
@@ -221,6 +232,15 @@
 	(x) =3D __x;						\
 	__gu_err;						\
 })
+#else
+#define __get_user(x, ptr)			\
+({						\
+	void __user *p;				\
+	p =3D (ptr);				\
+	0;					\
+})
+#endif
+
=20
 #define get_user(x, ptr)					\
 ({								\
@@ -230,7 +250,7 @@
=20
 extern int __get_user_bad(void);
=20
=2Dextern long __copy_to_user_asm(const void *from, long n, void *to);
+extern long __copy_to_user_asm(const void *from, long n, void __user *to);
=20
 /**
  * __copy_to_user: - Copy a block of data into user space, with less check=
ing.
@@ -274,7 +294,7 @@
 	return n;
 }
=20
=2Dextern long __copy_from_user_asm(void *to, long n, const void *from);
+extern long __copy_from_user_asm(void *to, long n, const void __user *from=
);
=20
 /**
  * __copy_from_user: - Copy a block of data from user space, with less che=
cking.
@@ -326,7 +346,8 @@
 	return n;
 }
=20
=2Dextern unsigned long __copy_in_user_asm(const void *from, long n, void *=
to);
+extern unsigned long __copy_in_user_asm(const void __user *from, long n,
+							void __user *to);
=20
 static inline unsigned long
 __copy_in_user(void __user *to, const void __user *from, unsigned long n)
@@ -346,10 +366,11 @@
 /*
  * Copy a null terminated string from userspace.
  */
=2Dextern long __strncpy_from_user_asm(char *dst, const char *src, long cou=
nt);
+extern long __strncpy_from_user_asm(char *dst, const char __user *src,
+								long count);
=20
 static inline long
=2Dstrncpy_from_user(char *dst, const char *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
         long res =3D -EFAULT;
         might_sleep();
@@ -359,10 +379,10 @@
 }
=20
=20
=2Dextern long __strnlen_user_asm(const char *src, long count);
+extern long __strnlen_user_asm(const char __user *src, long count);
=20
 static inline unsigned long
=2Dstrnlen_user(const char * src, unsigned long n)
+strnlen_user(const char __user * src, unsigned long n)
 {
 	might_sleep();
 	return __strnlen_user_asm(src, n);
@@ -388,16 +408,16 @@
  * Zero Userspace
  */
=20
=2Dextern long __clear_user_asm(void *to, long n);
+extern long __clear_user_asm(void __user *to, long n);
=20
 static inline unsigned long
=2D__clear_user(void *to, unsigned long n)
+__clear_user(void __user *to, unsigned long n)
 {
 	return __clear_user_asm(to, n);
 }
=20
 static inline unsigned long
=2Dclear_user(void *to, unsigned long n)
+clear_user(void __user *to, unsigned long n)
 {
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))

--Boundary-02=_x3cyAmX16ApnvYG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBAyc3x5t5GS2LDRf4RAjNSAJjMF6PkXK8praDu2+5/RDMIkSObAKCgXmjm
q5y4ffxlnHZv1PPMjvqW6A==
=uQJZ
-----END PGP SIGNATURE-----

--Boundary-02=_x3cyAmX16ApnvYG--
