Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJaO3N>; Thu, 31 Oct 2002 09:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSJaO3N>; Thu, 31 Oct 2002 09:29:13 -0500
Received: from ppp-217-133-222-193.dialup.tiscali.it ([217.133.222.193]:3969
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262636AbSJaO3L>; Thu, 31 Oct 2002 09:29:11 -0500
Date: Thu, 31 Oct 2002 15:34:39 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Clear TLS on execve
Message-ID: <20021031143439.GA1697@home.ldb.ods.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This trivial patch causes the TLS to be cleared on execve (code is in flush=
_thread).
This is necessary to avoid ESRCH errors when set_thread_area is asked
to choose a free TLS entry after several nested execve's.

The LDT also has a similar problem, but it is less serious because the
LDT code doesn't scan for free entries. I'll probably send a patch to
fix this too, unless there is something important relying on this behavior.

diff --exclude-from=3D/home/ldb/src/linux-exclude -urNdp linux-2.5.45/arch/=
i386/kernel/process.c linux-2.5.45_ldb/arch/i386/kernel/process.c
--- linux-2.5.45/arch/i386/kernel/process.c	2002-10-12 06:21:02.000000000 +=
0200
+++ linux-2.5.45_ldb/arch/i386/kernel/process.c	2002-10-31 14:23:18.0000000=
00 +0100
@@ -247,6 +247,7 @@ void flush_thread(void)
 	struct task_struct *tsk =3D current;
=20
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
+	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));=09
 	/*
 	 * Forget coprocessor state..
 	 */

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wT9+djkty3ft5+cRAtiOAKCNGWGecmDu1O5KkGp/6CNl3pmvGACglepm
ipp3BOlokVRNwoVBeKxJdU0=
=UHUY
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
