Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTAFCLh>; Sun, 5 Jan 2003 21:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTAFCLh>; Sun, 5 Jan 2003 21:11:37 -0500
Received: from ppp-217-133-216-158.dialup.tiscali.it ([217.133.216.158]:40579
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S265725AbTAFCLf>; Sun, 5 Jan 2003 21:11:35 -0500
Date: Mon, 6 Jan 2003 03:12:50 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Introduce TIF_IRET and use it to disable sysexit
Message-ID: <20030106021250.GB8074@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch introduces a new flag called TIF_IRET and uses it in place
of TIF_SIGPENDING when that flag is used to force return via iret.

This avoids the overhead of calling do_signal and makes the code
easier to understand.


diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/ioport.c linux-2.5.=
54-ldb/arch/i386/kernel/ioport.c
--- linux-2.5.54/arch/i386/kernel/ioport.c	2003-01-02 04:21:56.000000000 +0=
100
+++ linux-2.5.54-ldb/arch/i386/kernel/ioport.c	2003-01-04 19:06:07.00000000=
0 +0100
@@ -124,6 +124,6 @@ asmlinkage int sys_iopl(unsigned long un
 	}
 	regs->eflags =3D (regs->eflags & 0xffffcfff) | (level << 12);
 	/* Make sure we return the long way (not sysenter) */
-	set_thread_flag(TIF_SIGPENDING);
+	set_thread_flag(TIF_IRET);
 	return 0;
 }
diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/process.c linux-2.5=
.54-ldb/arch/i386/kernel/process.c
--- linux-2.5.54/arch/i386/kernel/process.c	2003-01-02 04:20:49.000000000 +=
0100
+++ linux-2.5.54-ldb/arch/i386/kernel/process.c	2003-01-04 19:06:07.0000000=
00 +0100
@@ -561,7 +561,7 @@ asmlinkage int sys_execve(struct pt_regs
 	if (error =3D=3D 0) {
 		current->ptrace &=3D ~PT_DTRACE;
 		/* Make sure we don't return using sysenter.. */
-		set_thread_flag(TIF_SIGPENDING);
+		set_thread_flag(TIF_IRET);
 	}
 	putname(filename);
 out:
diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/arch/i386/kernel/signal.c linux-2.5.=
54-ldb/arch/i386/kernel/signal.c
--- linux-2.5.54/arch/i386/kernel/signal.c	2003-01-02 04:21:53.000000000 +0=
100
+++ linux-2.5.54-ldb/arch/i386/kernel/signal.c	2003-01-04 19:06:07.00000000=
0 +0100
@@ -617,4 +619,6 @@ void do_notify_resume(struct pt_regs *re
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
+=09
+	clear_thread_flag(TIF_IRET);
 }
diff --exclude-from=3D/home/ldb/src/exclude -urNdp --exclude=3D'speedtouch.=
*' --exclude=3D'atmsar.*' linux-2.5.54/include/asm-i386/thread_info.h linux=
-2.5.54-ldb/include/asm-i386/thread_info.h
--- linux-2.5.54/include/asm-i386/thread_info.h	2003-01-02 04:21:09.0000000=
00 +0100
+++ linux-2.5.54-ldb/include/asm-i386/thread_info.h	2003-01-04 19:06:07.000=
000000 +0100
@@ -110,6 +110,7 @@ static inline struct thread_info *curren
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
+#define TIF_IRET		5	/* return with iret */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_R=
ESCHED */
=20
@@ -118,6 +119,7 @@ static inline struct thread_info *curren
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
+#define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
=20

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GOYgdjkty3ft5+cRAowCAJ4puwSNNtToiIe7/jSQmQViAFaUQACg2l/f
QrqVJ4bPWZG1pTD92CCVPG0=
=POjM
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
