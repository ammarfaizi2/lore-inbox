Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVG1PZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVG1PZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVG1PXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:23:46 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:45013 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261555AbVG1PNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:13:12 -0400
Date: Fri, 29 Jul 2005 01:13:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] compat_sys_read/write
Message-Id: <20050729011307.01a2d64e.sfr@canb.auug.org.au>
In-Reply-To: <20050728150258.GA22472@infradead.org>
References: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
	<20050728141653.GA22173@infradead.org>
	<20050729004838.116e8361.sfr@canb.auug.org.au>
	<20050728150258.GA22472@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__29_Jul_2005_01_13_07_+1000_yl/UncdB6iF+Z4Sp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__29_Jul_2005_01_13_07_+1000_yl/UncdB6iF+Z4Sp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jul 2005 16:02:58 +0100 Christoph Hellwig <hch@infradead.org> wr=
ote:
>
> > And where were you a week ago when I asked if I should post this patch?=
=20
>=20
> A :-) Can't remember it at all, maybe you forgot that we mere mortals can=
't
> read linux-arch@vger.kernel.org ?

Sorry about that, my omniscience must be slipping :-)

Anyway, here is the alternative I offered that was rejected by some (hi And=
i :-))
and not particularly like by others ... (without the actual evdev.c fix)

Is this any more palatable to the wider community?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/include/asm-ia64/compat.h linus-willy.3/include/asm-ia64/co=
mpat.h
--- linus/include/asm-ia64/compat.h	2005-06-27 16:08:06.000000000 +1000
+++ linus-willy.3/include/asm-ia64/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -4,6 +4,11 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
+
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -196,4 +201,9 @@
 	return (void __user *) (((regs->r12 & 0xffffffff) & -16) - len);
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return IS_IA32_PROCESS(ia64_task_regs(t));
+}
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN linus/include/asm-mips/compat.h linus-willy.3/include/asm-mips/co=
mpat.h
--- linus/include/asm-mips/compat.h	2005-06-27 16:08:07.000000000 +1000
+++ linus-willy.3/include/asm-mips/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -4,7 +4,9 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
 #include <asm/page.h>
+#include <asm/processor.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -142,4 +144,9 @@
 #define __COMPAT_ENDIAN_SWAP__ 	1
 #endif
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return (t->thread.mflags & MF_ABI_MASK) =3D=3D MF_O32;
+}
+
 #endif /* _ASM_COMPAT_H */
diff -ruN linus/include/asm-parisc/compat.h linus-willy.3/include/asm-paris=
c/compat.h
--- linus/include/asm-parisc/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-willy.3/include/asm-parisc/compat.h	2005-06-27 18:06:35.000000000=
 +1000
@@ -142,4 +142,9 @@
 	return (void __user *)regs->gr[30];
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return personality(t->personality) =3D=3D PER_LINUX32;
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN linus/include/asm-ppc64/compat.h linus-willy.3/include/asm-ppc64/=
compat.h
--- linus/include/asm-ppc64/compat.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-willy.3/include/asm-ppc64/compat.h	2005-06-27 18:06:35.000000000 =
+1000
@@ -200,4 +200,9 @@
 	compat_ulong_t __unused6;
 };
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_32BIT);
+}
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN linus/include/asm-s390/compat.h linus-willy.3/include/asm-s390/co=
mpat.h
--- linus/include/asm-s390/compat.h	2005-06-27 16:08:09.000000000 +1000
+++ linus-willy.3/include/asm-s390/compat.h	2005-06-27 18:06:35.000000000 +=
1000
@@ -195,4 +195,10 @@
 	compat_ulong_t __unused1;
 	compat_ulong_t __unused2;
 };
+
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_31BIT);
+}
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN linus/include/asm-sparc64/compat.h linus-willy.3/include/asm-spar=
c64/compat.h
--- linus/include/asm-sparc64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-willy.3/include/asm-sparc64/compat.h	2005-06-27 18:06:35.00000000=
0 +1000
@@ -4,6 +4,7 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
=20
 #define COMPAT_USER_HZ	100
=20
@@ -233,4 +234,9 @@
 	unsigned int	__unused2;
 };
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_32BIT);
+}
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN linus/include/asm-x86_64/compat.h linus-willy.3/include/asm-x86_6=
4/compat.h
--- linus/include/asm-x86_64/compat.h	2005-06-27 16:08:10.000000000 +1000
+++ linus-willy.3/include/asm-x86_64/compat.h	2005-06-27 18:06:35.000000000=
 +1000
@@ -202,4 +202,9 @@
 	return (void __user *)regs->rsp - len;=20
 }
=20
+static inline int is_compat_task(struct task_struct *t)
+{
+	return test_tsk_thread_flag(t, TIF_IA32);
+}
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN linus/include/linux/compat.h linus-willy.3/include/linux/compat.h
--- linus/include/linux/compat.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-willy.3/include/linux/compat.h	2005-06-27 18:06:35.000000000 +1000
@@ -158,5 +158,9 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
=20
+#else /* CONFIG_COMPAT */
+
+#define is_compat_task(x)	0
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */


--Signature=_Fri__29_Jul_2005_01_13_07_+1000_yl/UncdB6iF+Z4Sp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6PYEFdBgD/zoJvwRApXtAJ9Ompf9ftNIRxa8tf5NIHu7jlutAACfQR85
BIhARK47TO9wQthVNY1xBk4=
=y6L8
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Jul_2005_01_13_07_+1000_yl/UncdB6iF+Z4Sp--
