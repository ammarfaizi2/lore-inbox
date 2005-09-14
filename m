Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVINKCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVINKCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVINKCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:02:50 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:24708 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S965131AbVINKCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:02:50 -0400
Date: Wed, 14 Sep 2005 12:02:44 +0200
From: Bernhard Ager <ager@in.tum.de>
To: vojtech@suse.cz
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Joystick on amd64 for 32bit programs
Message-ID: <20050914100244.GC9770@in.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the patch below makes the joystick on amd64 work for 32bit
applications. It was successfully tested by myself with X-Plane [1],
SilentWings [2], Quake 3 [3] and quite some other applications.=20

How it works: as the parameters in 32bit userspace ioctl are
compatible with the 64bit kernel, it is sufficient to declare them
compatible in ia32_ioctl.c. The JSIOCGNAME ioctl causes a problem as
it encodes the length of the return buffer into the ioctl number. This
is solved by mapping all of the JSIOCGNAME ioctls to JSIOCGNAME(0).

Patch is below and works for vanilla kernels at least up to
2.6.13.


  Bernhard

[1] http://www.x-plane.com/
[2] http://www.silentwings.no/
[3] http://www.idsoftware.com/games/quake/quake3-arena/


diff -ru linux-2.6.11/arch/x86_64/ia32/ia32_ioctl.c linux-2.6.11-gentoo-r9-=
joystick/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.6.11/arch/x86_64/ia32/ia32_ioctl.c	2005-03-02 08:38:09.00000000=
0 +0100
+++ linux-2.6.11-gentoo-r9-joystick/arch/x86_64/ia32/ia32_ioctl.c	2005-05-1=
9 11:28:11.000000000 +0200
@@ -174,6 +174,10 @@
 COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't comp=
lain */
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't comp=
lain */
 COMPATIBLE_IOCTL(FIOQSIZE)
+COMPATIBLE_IOCTL(JSIOCGVERSION)
+COMPATIBLE_IOCTL(JSIOCGAXES)
+COMPATIBLE_IOCTL(JSIOCGBUTTONS)
+COMPATIBLE_IOCTL(JSIOCGNAME(0))
=20
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)
diff -ru linux-2.6.11/fs/compat.c linux-2.6.11-gentoo-r9-joystick/fs/compat=
=2Ec
--- linux-2.6.11/fs/compat.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11-gentoo-r9-joystick/fs/compat.c	2005-05-24 15:54:59.0000000=
00 +0200
@@ -49,6 +49,7 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
+#include <linux/joystick.h>
=20
 /*
  * Not all architectures have sys_utime, so implement this in terms
@@ -264,6 +265,8 @@
 /* ioctl32 stuff, used by sparc64, parisc, s390x, ppc64, x86_64, MIPS */
=20
 #define IOCTL_HASHSIZE 256
+#define IOCTL_MASK 0xFFFFFFFF
+
 static struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
 static DECLARE_RWSEM(ioctl32_sem);
=20
@@ -272,6 +275,8 @@
=20
 static inline unsigned long ioctl32_hash(unsigned long cmd)
 {
+	if ((cmd & ~IOCSIZE_MASK & IOCTL_MASK) =3D=3D JSIOCGNAME(0))
+		cmd =3D JSIOCGNAME(0);
 	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
 }
=20
@@ -434,6 +439,7 @@
 	int error =3D -EBADF;
 	struct ioctl_trans *t;
 	int fput_needed;
+	unsigned int scmd;
=20
 	filp =3D fget_light(fd, &fput_needed);
 	if (!filp)
@@ -477,11 +483,14 @@
 		break;
 	}
=20
+	scmd =3D ((cmd & ~IOCSIZE_MASK & IOCTL_MASK) =3D=3D JSIOCGNAME(0)) ?
+		JSIOCGNAME(0) : cmd;
+=09
 	/* When register_ioctl32_conversion is finally gone remove
 	   this lock! -AK */
 	down_read(&ioctl32_sem);
-	for (t =3D ioctl32_hash_table[ioctl32_hash(cmd)]; t; t =3D t->next) {
-		if (t->cmd =3D=3D cmd)
+	for (t =3D ioctl32_hash_table[ioctl32_hash(scmd)]; t; t =3D t->next) {
+		if (t->cmd =3D=3D scmd)
 			goto found_handler;
 	}
 	up_read(&ioctl32_sem);
diff -ru linux-2.6.11/fs/compat_ioctl.c linux-2.6.11-gentoo-r9-joystick/fs/=
compat_ioctl.c
--- linux-2.6.11/fs/compat_ioctl.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.11-gentoo-r9-joystick/fs/compat_ioctl.c	2005-05-19 11:28:11.0=
00000000 +0200
@@ -11,7 +11,8 @@
  */
=20
 #ifdef INCLUDES
+#include <linux/joystick.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>


--=20
Isn't making a smoking section in a restaurant like making a peeing
section in a swimming pool?

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDJ/VEdiM1col/IIARAlzJAJ9d94DncXA3X9Cr0e9oKUydAgOheACgzwEc
GMXCYHgLra/WaSvhb/VTNvA=
=Mcss
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
