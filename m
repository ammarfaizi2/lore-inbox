Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUEVREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUEVREk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUEVREj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 13:04:39 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:62649 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261672AbUEVREN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 13:04:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Date: Sat, 22 May 2004 18:58:41 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com>
In-Reply-To: <20040521074358.GG30909@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Eb4rACQ0q25iq4f";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405221858.44752.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Eb4rACQ0q25iq4f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 21 May 2004 09:43, Jakub Jelinek wrote:
> Well, for s390/s390x there is a problem that it doesn't allow (yet) 6
> argument syscalls at all, so one possibility for s390* is adding a wrappe=
r around
> sys_futex which will take the 5th and 6th arguments for FUTEX_CMP_REQUEUE
> from a structure pointed to by 5th argument and pass that to sys_futex.

I would really prefer not re-inventing brain-damage like ipc_kludge. I
have tried to do a special s390_futex_cmp_requeue() syscall, which is
still somewhat ugly. At least it has the advantage that it does not break
the de-facto calling conventions for s390 syscalls that either pass
up to five arguments in r2 to r6 or everything in an array pointed to
by r2.

Martin and Jakub, does the patch below look ok to you or should we do
it in yet another way?

	Arnd <><

=3D=3D=3D=3D=3D arch/s390/kernel/compat_linux.c 1.21 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.21/arch/s390/kernel/compat_linux.c	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/compat_linux.c	Sat May 22 17:34:21 2004
@@ -58,6 +58,7 @@
 #include <linux/compat.h>
 #include <linux/vfs.h>
 #include <linux/ptrace.h>
+#include <linux/futex.h>
=20
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -1262,4 +1263,16 @@
 		ret =3D put_user (ktimer_id, timer_id);
=20
 	return ret;
+}
+
+extern asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+                struct compat_timespec *utime, u32 *uaddr2, int val3);
+
+asmlinkage long compat_s390_futex(u32 *uaddr, int op, int val,
+                struct compat_timespec *utime, u32 *uaddr2, int val3)
+{
+	if (op =3D=3D FUTEX_CMP_REQUEUE)
+		return -EINVAL;
+
+	return compat_sys_futex(uaddr, op, val, utime, uaddr2, 0);
 }
=3D=3D=3D=3D=3D arch/s390/kernel/compat_wrapper.S 1.13 vs edited =3D=3D=3D=
=3D=3D
=2D-- 1.13/arch/s390/kernel/compat_wrapper.S	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Sat May 22 18:16:33 2004
@@ -1090,14 +1090,14 @@
 	llgtr	%r3,%r3			# struct stat64 *
 	jg	sys32_fstat64		# branch to system call
=20
=2D	.globl  compat_sys_futex_wrapper=20
=2Dcompat_sys_futex_wrapper:
+	.globl  compat_s390_futex_wrapper
+compat_s390_futex_wrapper:
 	llgtr	%r2,%r2			# u32 *
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# struct compat_timespec *
 	llgtr	%r6,%r6			# u32 *
=2D	jg	compat_sys_futex	# branch to system call
+	jg	compat_s390_futex	# branch to system call
=20
 	.globl	sys32_setxattr_wrapper
 sys32_setxattr_wrapper:
@@ -1404,3 +1404,12 @@
 	llgtr	%r3,%r3			# struct compat_mq_attr *
 	llgtr	%r4,%r4			# struct compat_mq_attr *
 	jg	compat_sys_mq_getsetattr
+
+	.globl	compat_s390_futex_cmp_requeue_wrapper
+compat_s390_futex_cmp_requeue_wrapper:
+	llgtr	%r2,%r2			# u32 *
+	llgtr	%r3,%r3			# u32 *
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	lgfr	%r6,%r6			# int
+	jg	s390_futex_cmp_requeue
=3D=3D=3D=3D=3D arch/s390/kernel/sys_s390.c 1.14 vs edited =3D=3D=3D=3D=3D
=2D-- 1.14/arch/s390/kernel/sys_s390.c	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/sys_s390.c	Sat May 22 17:31:57 2004
@@ -26,9 +26,8 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
=2D#ifdef CONFIG_ARCH_S390X
 #include <linux/personality.h>
=2D#endif /* CONFIG_ARCH_S390X */
+#include <linux/futex.h>
=20
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -265,3 +264,20 @@
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
=20
+asmlinkage long
+s390_futex(u32 __user *uaddr, int op, int val,
+             struct timespec __user *utime, u32 __user *uaddr2)
+{
+	if (op =3D=3D FUTEX_CMP_REQUEUE)
+		return -EINVAL;
+
+	return sys_futex(uaddr, op, val, utime, uaddr2, 0);
+}
+
+asmlinkage long
+s390_futex_cmp_requeue(u32 __user *uaddr, u32 __user *uaddr2,
+		int nr_wake, int nr_requeue, int val)
+{
+	return do_futex((unsigned long) uaddr, FUTEX_CMP_REQUEUE,
+			nr_wake, 0, (unsigned long)uaddr2, nr_requeue, val);
+}
=3D=3D=3D=3D=3D arch/s390/kernel/syscalls.S 1.12 vs edited =3D=3D=3D=3D=3D
=2D-- 1.12/arch/s390/kernel/syscalls.S	Sat May 22 06:34:19 2004
+++ edited/arch/s390/kernel/syscalls.S	Sat May 22 18:15:24 2004
@@ -246,7 +246,7 @@
 SYSCALL(sys_fremovexattr,sys_fremovexattr,sys32_fremovexattr_wrapper)	/* 2=
35 */
 SYSCALL(sys_gettid,sys_gettid,sys_gettid)
 SYSCALL(sys_tkill,sys_tkill,sys_tkill)
=2DSYSCALL(sys_futex,sys_futex,compat_sys_futex_wrapper)
+SYSCALL(s390_futex,s390_futex,compat_s390_futex_wrapper)
 SYSCALL(sys_sched_setaffinity,sys_sched_setaffinity,sys32_sched_setaffinit=
y_wrapper)
 SYSCALL(sys_sched_getaffinity,sys_sched_getaffinity,sys32_sched_getaffinit=
y_wrapper)	/* 240 */
 SYSCALL(sys_tgkill,sys_tgkill,sys_tgkill)
@@ -285,3 +285,4 @@
 SYSCALL(sys_mq_timedreceive,sys_mq_timedreceive,compat_sys_mq_timedreceive=
_wrapper)
 SYSCALL(sys_mq_notify,sys_mq_notify,compat_sys_mq_notify_wrapper)
 SYSCALL(sys_mq_getsetattr,sys_mq_getsetattr,compat_sys_mq_getsetattr_wrapp=
er)
+SYSCALL(s390_futex_cmp_requeue,s390_futex_cmp_requeue,compat_s390_futex_cm=
p_requeue_wrapper)
=3D=3D=3D=3D=3D include/asm-s390/unistd.h 1.26 vs edited =3D=3D=3D=3D=3D
=2D-- 1.26/include/asm-s390/unistd.h	Sat May 22 06:34:45 2004
+++ edited/include/asm-s390/unistd.h	Sat May 22 17:08:01 2004
@@ -269,8 +269,9 @@
 #define __NR_mq_timedreceive	274
 #define __NR_mq_notify		275
 #define __NR_mq_getsetattr	276
+#define __NR_futex_cmp_requeue	277
=20
=2D#define NR_syscalls 277
+#define NR_syscalls 278
=20
 /*=20
  * There are some system calls that are not present on 64 bit, some
=3D=3D=3D=3D=3D include/linux/syscalls.h 1.6 vs edited =3D=3D=3D=3D=3D
=2D-- 1.6/include/linux/syscalls.h	Sat May 22 06:31:47 2004
+++ edited/include/linux/syscalls.h	Sat May 22 17:32:58 2004
@@ -165,7 +165,8 @@
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int=
 options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
=2D			struct timespec __user *utime, u32 __user *uaddr2);
+			struct timespec __user *utime, u32 __user *uaddr2,
+			int val3);
=20
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
=3D=3D=3D=3D=3D kernel/fork.c 1.169 vs edited =3D=3D=3D=3D=3D
=2D-- 1.169/kernel/fork.c	Sat May 22 06:32:19 2004
+++ edited/kernel/fork.c	Sat May 22 17:35:46 2004
@@ -516,7 +516,7 @@
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
=2D		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL);
+		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL, 0);
 	}
 }
=20

--Boundary-02=_Eb4rACQ0q25iq4f
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAr4bE5t5GS2LDRf4RAtV3AJ4+c2vWlfEdETM4kSBmiEf/OYwarACfT6Yv
63JplGSrrIKowSBLe63FamM=
=KHxi
-----END PGP SIGNATURE-----

--Boundary-02=_Eb4rACQ0q25iq4f--
