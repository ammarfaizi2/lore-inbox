Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUEXRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUEXRfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUEXRfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:35:04 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:58367 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264652AbUEXRet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:34:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Date: Mon, 24 May 2004 19:34:05 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com>
In-Reply-To: <20040524073407.GC4736@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_QIjsADeUuf4J0Lv";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405241934.09276.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_QIjsADeUuf4J0Lv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 May 2004 09:34, Jakub Jelinek wrote:
> My personal preference is:
> 1) change s390* entry*.S so that all syscalls can use up to 6 arguments,
> =A0 =A0otherwise we'll have the same problem every now and then
> =A0 =A0(last syscall before this one was fadvise64_64 if I remember well)
> 2) allow sys_futex to have 6 arguments (the 6th on the stack, get_user'ed
> =A0 =A0from an s390 wrapper)
> 3) special structure passed in 5th argument for FUTEX_CMP_REQUEUE
> 4) your solution
> =A0 =A0(you have a special wrapper around futex anyway, so why not to han=
dle
> =A0 =A0it there already and create completely new syscall).

I have talked to Martin about it (he won't be online for one more week),
and he proposed a variant of 2): sys_futex, and possibly further new
syscalls that might get added, pass their sixth argument in %r7,
which is easier to get by than the user stack. Unlike doing it in
the standard system call path, this won't cause any overhead for
the other syscalls, but we need some wrappers.

I haven't tested this, because I'm not too familiar with glibc
changes. Jakub, if you are happy with this approach, can you
add the respective glibc stuff and try if this is any good?

	Arnd <><

[PATCH] Fix FUTEX_CMP_REQUEUE on s390

	From: Arnd Bergmann <arnd@arndb.de>

System calls normally can not have more than five arguments on s390
because of ABI restrictions, but the addition of the FUTEX_CMP_REQUEUE
added a sixth argument to sys_futex. This patch extends the regular
syscall conventions by an extra argument register for sys_futex.

The regular method of passing all arguments on the user stack for six
argument syscalls on s390 does not work here because it would break
the existing usage of futex.

I'm also fixing the sys_futex prototype in <linux/syscalls.h> to make
it possible to call it from s390_futex.

=3D=3D=3D=3D=3D arch/s390/kernel/compat_linux.c 1.21 vs edited =3D=3D=3D=3D=
=3D
=2D-- 1.21/arch/s390/kernel/compat_linux.c	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/compat_linux.c	Mon May 24 18:51:26 2004
@@ -1263,3 +1263,16 @@
=20
 	return ret;
 }
+
+asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+                struct compat_timespec *utime, u32 *uaddr2, int val3);
+
+asmlinkage long
+sys32_futex(u32 __user *uaddr, int op, int val,
+	struct compat_timespec __user *utime, u32 __user *uaddr2)
+{
+	struct pt_regs *regs;
+
+	regs =3D __KSTK_PTREGS(current);
+	return compat_sys_futex(uaddr, op, val, utime, uaddr2, regs->gprs[7]);
+}
=3D=3D=3D=3D=3D arch/s390/kernel/compat_wrapper.S 1.13 vs edited =3D=3D=3D=
=3D=3D
=2D-- 1.13/arch/s390/kernel/compat_wrapper.S	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Mon May 24 19:04:15 2004
@@ -1090,14 +1090,14 @@
 	llgtr	%r3,%r3			# struct stat64 *
 	jg	sys32_fstat64		# branch to system call
=20
=2D	.globl  compat_sys_futex_wrapper=20
=2Dcompat_sys_futex_wrapper:
+	.globl  sys32_futex_wrapper=20
+sys32_futex_wrapper:
 	llgtr	%r2,%r2			# u32 *
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# struct compat_timespec *
 	llgtr	%r6,%r6			# u32 *
=2D	jg	compat_sys_futex	# branch to system call
+	jg	sys32_futex		# branch to system call
=20
 	.globl	sys32_setxattr_wrapper
 sys32_setxattr_wrapper:
=3D=3D=3D=3D=3D arch/s390/kernel/sys_s390.c 1.14 vs edited =3D=3D=3D=3D=3D
=2D-- 1.14/arch/s390/kernel/sys_s390.c	Sat May 22 06:31:44 2004
+++ edited/arch/s390/kernel/sys_s390.c	Mon May 24 18:51:26 2004
@@ -265,3 +265,12 @@
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
=20
+asmlinkage long
+s390_futex(u32 __user *uaddr, int op, int val,
+	struct timespec __user *utime, u32 __user *uaddr2)
+{
+	struct pt_regs *regs;
+
+	regs =3D __KSTK_PTREGS(current);
+	return sys_futex(uaddr, op, val, utime, uaddr2, regs->gprs[7]);
+}
=3D=3D=3D=3D=3D arch/s390/kernel/syscalls.S 1.12 vs edited =3D=3D=3D=3D=3D
=2D-- 1.12/arch/s390/kernel/syscalls.S	Sat May 22 06:34:19 2004
+++ edited/arch/s390/kernel/syscalls.S	Mon May 24 19:03:28 2004
@@ -246,7 +246,7 @@
 SYSCALL(sys_fremovexattr,sys_fremovexattr,sys32_fremovexattr_wrapper)	/* 2=
35 */
 SYSCALL(sys_gettid,sys_gettid,sys_gettid)
 SYSCALL(sys_tkill,sys_tkill,sys_tkill)
=2DSYSCALL(sys_futex,sys_futex,compat_sys_futex_wrapper)
+SYSCALL(s390_futex,s390_futex,sys32_futex_wrapper)
 SYSCALL(sys_sched_setaffinity,sys_sched_setaffinity,sys32_sched_setaffinit=
y_wrapper)
 SYSCALL(sys_sched_getaffinity,sys_sched_getaffinity,sys32_sched_getaffinit=
y_wrapper)	/* 240 */
 SYSCALL(sys_tgkill,sys_tgkill,sys_tgkill)
=3D=3D=3D=3D=3D include/linux/syscalls.h 1.6 vs edited =3D=3D=3D=3D=3D
=2D-- 1.6/include/linux/syscalls.h	Sat May 22 06:31:47 2004
+++ edited/include/linux/syscalls.h	Mon May 24 18:51:26 2004
@@ -165,7 +165,7 @@
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int=
 options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
=2D			struct timespec __user *utime, u32 __user *uaddr2);
+			struct timespec __user *utime, u32 __user *uaddr2, int val3);
=20
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
=3D=3D=3D=3D=3D kernel/fork.c 1.169 vs edited =3D=3D=3D=3D=3D
=2D-- 1.169/kernel/fork.c	Sat May 22 06:32:19 2004
+++ edited/kernel/fork.c	Mon May 24 18:51:26 2004
@@ -516,7 +516,7 @@
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
=2D		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL);
+		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL, 0);
 	}
 }
=20
=3D=3D=3D=3D=3D kernel/futex.c 1.40 vs edited =3D=3D=3D=3D=3D
=2D-- 1.40/kernel/futex.c	Sat May 22 09:03:35 2004
+++ edited/kernel/futex.c	Mon May 24 18:51:26 2004
@@ -38,6 +38,7 @@
 #include <linux/futex.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/syscalls.h>
=20
 #define FUTEX_HASHBITS 8
=20

--Boundary-02=_QIjsADeUuf4J0Lv
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsjIQ5t5GS2LDRf4RAk/bAJ4mvLF2len+Ax+Q+roRWKFYjs10FACgoueN
jLK7TbvHe+GbKp2GVXCfA9w=
=g7mb
-----END PGP SIGNATURE-----

--Boundary-02=_QIjsADeUuf4J0Lv--
