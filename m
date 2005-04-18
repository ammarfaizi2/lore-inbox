Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVDRHsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVDRHsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVDRHsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:48:41 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:35975 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261896AbVDRHsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:48:12 -0400
Date: Mon, 18 Apr 2005 17:48:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] consolidate SIGEV_PAD_SIZE
Message-Id: <20050418174805.03ab7546.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__18_Apr_2005_17_48_05_+1000_4SUH10UN1vq4Fzn9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__18_Apr_2005_17_48_05_+1000_4SUH10UN1vq4Fzn9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Discussing with Matthew Wilcox some of his outstanding patches lead me to
this patch (among others).

The preamble in struct sigevent can be expressed independently of the
architecture.

Also use __ARCH_SI_PREAMBLE_SIZE on ia64.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20

 asm-alpha/siginfo.h   |    2 --
 asm-generic/siginfo.h |   13 ++++++++++---
 asm-ia64/siginfo.h    |    4 +---
 asm-mips/siginfo.h    |    2 --
 asm-s390/siginfo.h    |    6 ------
 asm-sparc64/siginfo.h |    2 --
 asm-x86_64/siginfo.h  |    2 --
 7 files changed, 11 insertions(+), 20 deletions(-)

Please apply and send upstream.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/include/asm-alpha/siginfo.h linus-willy.1/include/asm-alpha=
/siginfo.h
--- linus/include/asm-alpha/siginfo.h	2003-08-20 08:58:40.000000000 +1000
+++ linus-willy.1/include/asm-alpha/siginfo.h	2005-03-10 18:39:40.000000000=
 +1100
@@ -4,8 +4,6 @@
 #define __ARCH_SI_PREAMBLE_SIZE		(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
=20
-#define SIGEV_PAD_SIZE			((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-
 #include <asm-generic/siginfo.h>
=20
 #endif
diff -ruN linus/include/asm-generic/siginfo.h linus-willy.1/include/asm-gen=
eric/siginfo.h
--- linus/include/asm-generic/siginfo.h	2005-03-14 13:07:09.000000000 +1100
+++ linus-willy.1/include/asm-generic/siginfo.h	2005-03-14 15:46:09.0000000=
00 +1100
@@ -236,11 +236,18 @@
 #define SIGEV_THREAD	2	/* deliver via thread creation */
 #define SIGEV_THREAD_ID 4	/* deliver to thread */
=20
-#define SIGEV_MAX_SIZE	64
-#ifndef SIGEV_PAD_SIZE
-#define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
+/*
+ * This works because the alignment is ok on all current architectures
+ * but we leave open this being overridden in the future
+ */
+#ifndef __ARCH_SIGEV_PREAMBLE_SIZE
+#define __ARCH_SIGEV_PREAMBLE_SIZE	(sizeof(int) * 2 + sizeof(sigval_t))
 #endif
=20
+#define SIGEV_MAX_SIZE	64
+#define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE - __ARCH_SIGEV_PREAMBLE_SIZE) \
+		/ sizeof(int))
+
 typedef struct sigevent {
 	sigval_t sigev_value;
 	int sigev_signo;
diff -ruN linus/include/asm-ia64/siginfo.h linus-willy.1/include/asm-ia64/s=
iginfo.h
--- linus/include/asm-ia64/siginfo.h	2004-10-09 15:46:34.000000000 +1000
+++ linus-willy.1/include/asm-ia64/siginfo.h	2005-03-10 18:42:36.000000000 =
+1100
@@ -8,9 +8,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
=20
-#define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 4)
-
-#define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
=20
 #define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO
diff -ruN linus/include/asm-mips/siginfo.h linus-willy.1/include/asm-mips/s=
iginfo.h
--- linus/include/asm-mips/siginfo.h	2004-12-02 13:08:10.000000000 +1100
+++ linus-willy.1/include/asm-mips/siginfo.h	2005-03-10 18:44:51.000000000 =
+1100
@@ -11,8 +11,6 @@
=20
 #include <linux/config.h>
=20
-#define SIGEV_HEAD_SIZE	(sizeof(long) + 2*sizeof(int))
-#define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE-SIGEV_HEAD_SIZE) / sizeof(int))
 #undef __ARCH_SI_TRAPNO	/* exception code needs to fill this ...  */
=20
 #define HAVE_ARCH_SIGINFO_T
diff -ruN linus/include/asm-s390/siginfo.h linus-willy.1/include/asm-s390/s=
iginfo.h
--- linus/include/asm-s390/siginfo.h	2004-12-04 04:05:03.000000000 +1100
+++ linus-willy.1/include/asm-s390/siginfo.h	2005-03-10 18:45:29.000000000 =
+1100
@@ -13,12 +13,6 @@
 #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
 #endif
=20
-#ifdef CONFIG_ARCH_S390X
-#define SIGEV_PAD_SIZE ((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-#else
-#define SIGEV_PAD_SIZE ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
-#endif
-
 #include <asm-generic/siginfo.h>
=20
 #endif
diff -ruN linus/include/asm-sparc64/siginfo.h linus-willy.1/include/asm-spa=
rc64/siginfo.h
--- linus/include/asm-sparc64/siginfo.h	2005-03-11 05:08:55.000000000 +1100
+++ linus-willy.1/include/asm-sparc64/siginfo.h	2005-03-11 16:08:17.0000000=
00 +1100
@@ -3,8 +3,6 @@
=20
 #define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
=20
-#define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #define __ARCH_SI_TRAPNO
 #define __ARCH_SI_BAND_T int
diff -ruN linus/include/asm-x86_64/siginfo.h linus-willy.1/include/asm-x86_=
64/siginfo.h
--- linus/include/asm-x86_64/siginfo.h	2004-04-04 16:06:05.000000000 +1000
+++ linus-willy.1/include/asm-x86_64/siginfo.h	2005-03-10 18:46:14.00000000=
0 +1100
@@ -3,8 +3,6 @@
=20
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
=20
-#define SIGEV_PAD_SIZE ((SIGEV_MAX_SIZE/sizeof(int)) - 4)
-
 #include <asm-generic/siginfo.h>
=20
 #endif

--Signature=_Mon__18_Apr_2005_17_48_05_+1000_4SUH10UN1vq4Fzn9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCY2Y64CJfqux9a+8RAtCIAJ4oBbXoNT5cNXsIVsyxSIX4KjW2mgCdGvlW
UUzcMt/2xmE6b9YfJFXaJ94=
=MN72
-----END PGP SIGNATURE-----

--Signature=_Mon__18_Apr_2005_17_48_05_+1000_4SUH10UN1vq4Fzn9--
