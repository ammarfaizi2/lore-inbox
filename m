Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbTAEBSD>; Sat, 4 Jan 2003 20:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTAEBSC>; Sat, 4 Jan 2003 20:18:02 -0500
Received: from ppp-217-133-221-34.dialup.tiscali.it ([217.133.221.34]:45441
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262506AbTAEBR5>; Sat, 4 Jan 2003 20:17:57 -0500
Date: Sun, 5 Jan 2003 02:18:44 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix sysenter iopl
Message-ID: <20030105011844.GA4948@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes the handling of IOPL in 2.5.54 when sysenter is used.

Currently when entering kernel mode, IOPL is not changed and it is not
presserved across context switches: thus, in the kernel, the IOPL
value is random. =20

This is not a problem when using iret, because it restores eflags, but
the sysexit code currently doesn't, which means that that IOPL becomes
random in user mode too which is of course not good.

This patch fixes the problem by saving eflags across context switches
(it could also be fixed by adding a popfl at the end of the sysenter
code).


diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/include/asm-i386/system.h linux-2.5.=
54-ldb/include/asm-i386/system.h
--- linux-2.5.54/include/asm-i386/system.h	2003-01-02 04:20:51.000000000 +0=
100
+++ linux-2.5.54-ldb/include/asm-i386/system.h	2003-01-04 19:06:07.00000000=
0 +0100
@@ -12,7 +12,8 @@ struct task_struct;	/* one of the strang
 extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_str=
uct *next));
=20
 #define switch_to(prev,next,last) do {					\
-	asm volatile("pushl %%esi\n\t"					\
+	asm volatile("pushfl\n\t"					\
+		     "pushl %%esi\n\t"					\
 		     "pushl %%edi\n\t"					\
 		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
@@ -24,6 +25,7 @@ extern void FASTCALL(__switch_to(struct=20
 		     "popl %%ebp\n\t"					\
 		     "popl %%edi\n\t"					\
 		     "popl %%esi\n\t"					\
+		     "popfl\n\t"					\
 		     :"=3Dm" (prev->thread.esp),"=3Dm" (prev->thread.eip)	\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
 		      "a" (prev), "d" (next));				\

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+F4fzdjkty3ft5+cRAkRJAJ0Ty7cyqLw4DZfMTRiP/Hbf2WRKxwCfSeli
V0DBrd8iPPZQpl2qM+hFDdo=
=pUG+
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
