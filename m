Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUFLSp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUFLSp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 14:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUFLSp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 14:45:29 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:57494 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S264897AbUFLSpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 14:45:25 -0400
Date: Sat, 12 Jun 2004 22:45:11 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alexander Nyberg <alexn@telia.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       stian@nixia.no
Subject: Re: timer + fpu stuff locks up computer
Message-ID: <20040612184511.GD3396@sirius.home>
References: <20040612134413.GA3396@sirius.home> <1087050351.707.5.camel@boxen> <20040612151422.GC3396@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20040612151422.GC3396@sirius.home>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 12, 2004 at 07:14:22PM +0400, Sergey Vlasov wrote:
> If the FPU state belong to the userspace process, kernel_fpu_begin()
> is safe even if some exceptions are pending.  However, after
> __clear_fpu() the FPU is "orphaned", and kernel_fpu_begin() does
> nothing with it.
>=20
> Replacing fwait with fnclex instead of removing it completely should
> avoid the fault later.

Yes, it seems to be enough.  Another case where it looks like FPU
might be "orphaned" is exit(); however, it is handled as a normal task
switch, __switch_to() calls __unlazy_fpu(), which clears pending
exceptions.

I'm still not sure what to do about possibly lost FP exceptions.  This
can happen in two cases:

1) Program calls execve() while an FP exception is pending.

   In this case clear_fpu() is called when the original executable is
   already destroyed.  Even if we generate a SIGFPE in this case, it
   would be delivered to the new executable.

2) Program returns from a signal handler while an FP exception is
   pending.

   In this case at clear_fpu() time restore_sigcontext() has already
   wiped out all state of the signal handler, so the SIGFPE would
   appear to be raised from the program code at the point where it was
   interrupted by the handled signal.

Signed-Off-By: Sergey Vlasov <vsu@altlinux.ru>

--- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06 +0400
+++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 22:02:58 +0400
@@ -48,10 +48,17 @@
 		save_init_fpu( tsk ); \
 } while (0)
=20
+/*
+ * There might be some pending exceptions in the FP state at this point.
+ * However, it is too late to report them: this code is called during exec=
ve()
+ * (when the original executable is already gone) and during sigreturn() (=
when
+ * the signal handler context is already lost).  So just clear them to pre=
vent
+ * problems later.
+ */
 #define __clear_fpu( tsk )					\
 do {								\
 	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fwait");				\
+		asm volatile("fnclex");				\
 		(tsk)->thread_info->status &=3D ~TS_USEDFPU;	\
 		stts();						\
 	}							\


--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAy083W82GfkQfsqIRAlxUAJ4jwkUGJfV5pbeL1tqPZQLJUBIA1gCeIImy
a3FnEt0oMaR1fg6zTJ3NScI=
=1+41
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
