Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbTAFOof>; Mon, 6 Jan 2003 09:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTAFOof>; Mon, 6 Jan 2003 09:44:35 -0500
Received: from ppp-217-133-219-133.dialup.tiscali.it ([217.133.219.133]:41088
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S266763AbTAFOod>; Mon, 6 Jan 2003 09:44:33 -0500
Date: Mon, 6 Jan 2003 15:46:01 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Set TIF_IRET in more places
Message-ID: <20030106144601.GA2447@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds code to set TIF_IRET in sigsuspend and rt_sigsuspend
(since they change registers to invoke signal handlers) and ptrace
setregs.  This prevents clobbering of %ecx and %edx.


diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/ptrace.c linux-2.5.=
54-ldb/arch/i386/kernel/ptrace.c
--- linux-2.5.54/arch/i386/kernel/ptrace.c	2003-01-02 04:21:29.000000000 +0=
100
+++ linux-2.5.54-ldb/arch/i386/kernel/ptrace.c	2003-01-04 19:06:07.00000000=
0 +0100
@@ -74,6 +74,8 @@ static inline int put_stack_long(struct=20
 static int putreg(struct task_struct *child,
 	unsigned long regno, unsigned long value)
 {
+	set_tsk_thread_flag(child, TIF_IRET);
+
 	switch (regno >> 2) {
 		case FS:
 			if (value && (value & 3) !=3D 3)
diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/signal.c linux-2.5.=
54-ldb/arch/i386/kernel/signal.c
--- linux-2.5.54/arch/i386/kernel/signal.c	2003-01-02 04:21:53.000000000 +0=
100
+++ linux-2.5.54-ldb/arch/i386/kernel/signal.c	2003-01-04 19:06:07.00000000=
0 +0100
@@ -44,6 +44,7 @@ sys_sigsuspend(int history0, int history
 	spin_unlock_irq(&current->sig->siglock);
=20
 	regs->eax =3D -EINTR;
+	set_thread_flag(TIF_IRET);
 	while (1) {
 		current->state =3D TASK_INTERRUPTIBLE;
 		schedule();
@@ -73,6 +74,7 @@ sys_rt_sigsuspend(sigset_t *unewset, siz
 	spin_unlock_irq(&current->sig->siglock);
=20
 	regs->eax =3D -EINTR;
+	set_thread_flag(TIF_IRET);=09
 	while (1) {
 		current->state =3D TASK_INTERRUPTIBLE;
 		schedule();

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GZaodjkty3ft5+cRAqsdAKDLzZ+YJbCK44Bk+B17dARR8UIMFQCeJRTv
70Udo+UTLhNMPRpDSDpGFI8=
=BD/T
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
