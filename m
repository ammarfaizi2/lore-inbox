Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUAYGhT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 01:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUAYGhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 01:37:19 -0500
Received: from mhub-w5.tc.umn.edu ([160.94.160.35]:27133 "EHLO
	mhub-w5.tc.umn.edu") by vger.kernel.org with ESMTP id S263695AbUAYGhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 01:37:14 -0500
Subject: [PATCH] Enable compilation on MIPS with gcc-3.3
From: Matthew Reppert <repp0017@tc.umn.edu>
To: ralf@gnu.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m+b5o9WFFgCCWNILpxmK"
Message-Id: <1075012630.5829.333.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 00:37:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m+b5o9WFFgCCWNILpxmK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

arch/mips/Makefile uses gcc's -mcpu=3D flag to pass subarchitecture
selection choices to gcc. -mcpu=3D was deprecated in gcc 3.1, and has
been removed as of gcc 3.3. We need to use -march=3D for gcc 3.x (where
x >=3D 3), but some versions of gcc don't understand -march=3D (namely
2.95.x, which some people still use.)

This patch introduces a variable in arch/mips/makefile, gcc-tune-flag,
which is "cpu" if gcc understands -mcpu and "arch" if it doesn't, and
uses it to build the -mcpu=3D/-march=3D bits in CFLAGS for each processor
type.

Matt


diff -puN arch/mips/Makefile~mips-arch arch/mips/Makefile
--- linux-2.6.2-rc1-mm2_mips/arch/mips/Makefile~mips-arch	2004-01-25 00:13:=
03.295170984 -0600
+++ linux-2.6.2-rc1-mm2_mips-arashi/arch/mips/Makefile	2004-01-25 00:23:39.=
594438792 -0600
@@ -38,6 +38,8 @@ ifdef CONFIG_CROSSCOMPILE
 CROSS_COMPILE		:=3D $(tool-prefix)
 endif
=20
+gcc-tune-flag		=3D $(shell if $(CC) -dumpspecs | grep mcpu; then echo cpu;=
 else echo arch; fi)
+
 #
 # GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the ker=
nel
 # code since it only slows down the whole thing.  At some point we might m=
ake
@@ -75,49 +77,49 @@ check_warning =3D $(shell if $(CC) $(1) -c
 #                A kernel built those options will only work on hardware w=
hich
 #                actually supports this ISA.
 #
-cflags-$(CONFIG_CPU_R3000)	+=3D -mcpu=3Dr3000
+cflags-$(CONFIG_CPU_R3000)	+=3D -$(gcc-tune-flag)=3Dr3000
 32bit-isa-$(CONFIG_CPU_R3000)	+=3D -mips1
 64bit-isa-$(CONFIG_CPU_R3000)	+=3D -mboom
-cflags-$(CONFIG_CPU_TX39XX)	+=3D -mcpu=3Dr3000
+cflags-$(CONFIG_CPU_TX39XX)	+=3D -$(gcc-tune-flag)=3Dr3000
 32bit-isa-$(CONFIG_CPU_TX39XX)	+=3D -mips1
 64bit-isa-$(CONFIG_CPU_TX39XX)	+=3D -mboom
-cflags-$(CONFIG_CPU_R6000)	+=3D -mcpu=3Dr6000
+cflags-$(CONFIG_CPU_R6000)	+=3D -$(gcc-tune-flag)=3Dr6000
 32bit-isa-$(CONFIG_CPU_R6000)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R6000)	+=3D -mboom -Wa,--trap
-cflags-$(CONFIG_CPU_R4300)	+=3D -mcpu=3Dr4300
+cflags-$(CONFIG_CPU_R4300)	+=3D -$(gcc-tune-flag)=3Dr4300
 32bit-isa-$(CONFIG_CPU_R4300)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R4300)	+=3D -mips3 -Wa,--trap
-cflags-$(CONFIG_CPU_VR41XX)	+=3D -mcpu=3Dr4600
+cflags-$(CONFIG_CPU_VR41XX)	+=3D -$(gcc-tune-flag)=3Dr4600
 32bit-isa-$(CONFIG_CPU_VR41XX)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_VR41XX)	+=3D -mips3 -Wa,--trap
-cflags-$(CONFIG_CPU_R4X00)	+=3D -mcpu=3Dr4600
+cflags-$(CONFIG_CPU_R4X00)	+=3D -$(gcc-tune-flag)=3Dr4600
 32bit-isa-$(CONFIG_CPU_R4X00)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R4X00)	+=3D -mips3 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32)	+=3D $(call check_gcc, -mtune=3Dmips32, -mcpu=
=3Dr4600)
+cflags-$(CONFIG_CPU_MIPS32)	+=3D $(call check_gcc, -mtune=3Dmips32, -$(gcc=
-tune-flag)=3Dr4600)
 32bit-isa-$(CONFIG_CPU_MIPS32)	+=3D $(call check_gcc, -mips32 -mabi=3D32, =
-mips2) -Wa,--trap
 64bit-isa-$(CONFIG_CPU_MIPS32)	+=3D -mboom
 cflags-$(CONFIG_CPU_MIPS64)	+=3D=20
 32bit-isa-$(CONFIG_CPU_MIPS64)	+=3D $(call check_gcc, -mips32, -mips2) -Wa=
,--trap
 64bit-isa-$(CONFIG_CPU_MIPS64)	+=3D $(call check_gcc, -mips64, -mips4) -Wa=
,--trap
-cflags-$(CONFIG_CPU_R5000)	+=3D -mcpu=3Dr8000
+cflags-$(CONFIG_CPU_R5000)	+=3D -$(gcc-tune-flag)=3Dr8000
 32bit-isa-$(CONFIG_CPU_R5000)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R5000)	+=3D -mips4 -Wa,--trap
-cflags-$(CONFIG_CPU_R5432)	+=3D -mcpu=3Dr5000
+cflags-$(CONFIG_CPU_R5432)	+=3D -$(gcc-tune-flag)=3Dr5000
 32bit-isa-$(CONFIG_CPU_R5432)	+=3D -mips1 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R5432)	+=3D -mips3 -Wa,--trap
-cflags-$(CONFIG_CPU_NEVADA)	+=3D -mcpu=3Dr8000 -mmad
+cflags-$(CONFIG_CPU_NEVADA)	+=3D -$(gcc-tune-flag)=3Dr8000 -mmad
 32bit-isa-$(CONFIG_CPU_NEVADA)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_NEVADA)	+=3D -mips3 -Wa,--trap
-cflags-$(CONFIG_CPU_RM7000)	+=3D $(call check_gcc, -mcpu=3Dr7000, -mcpu=3D=
r5000)
+cflags-$(CONFIG_CPU_RM7000)	+=3D $(call check_gcc, -$(gcc-tune-flag)=3Dr70=
00, -$(gcc-tune-flag)=3Dr5000)
 32bit-isa-$(CONFIG_CPU_RM7000)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_RM7000)	+=3D -mips4 -Wa,--trap
-cflags-$(CONFIG_CPU_SB1)	+=3D $(call check_gcc, -mcpu=3Dsb1, -mcpu=3Dr8000=
)
+cflags-$(CONFIG_CPU_SB1)	+=3D $(call check_gcc, -$(gcc-tune-flag)=3Dsb1, -=
$(gcc-tune-flag)=3Dr8000)
 32bit-isa-$(CONFIG_CPU_SB1)	+=3D $(call check_gcc, -mips32, -mips2) -Wa,--=
trap
 64bit-isa-$(CONFIG_CPU_SB1)	+=3D $(call check_gcc, -mips64, -mips4) -Wa,--=
trap
-cflags-$(CONFIG_CPU_R8000)	+=3D -mcpu=3Dr8000
+cflags-$(CONFIG_CPU_R8000)	+=3D -$(gcc-tune-flag)=3Dr8000
 32bit-isa-$(CONFIG_CPU_R8000)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R8000)	+=3D -mips4 -Wa,--trap
-cflags-$(CONFIG_CPU_R10000)	+=3D -mcpu=3Dr8000
+cflags-$(CONFIG_CPU_R10000)	+=3D -$(gcc-tune-flag)=3Dr8000
 32bit-isa-$(CONFIG_CPU_R10000)	+=3D -mips2 -Wa,--trap
 64bit-isa-$(CONFIG_CPU_R10000)	+=3D -mips4 -Wa,--trap
=20

_


--=-m+b5o9WFFgCCWNILpxmK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAE2QWA9ZcCXfrOTMRAh56AKChXZkilrABXcZ66fuoFY85tZ4vBACdE2fp
ezOngSPpxGvEsiRWnYfUzsc=
=dgsN
-----END PGP SIGNATURE-----

--=-m+b5o9WFFgCCWNILpxmK--

