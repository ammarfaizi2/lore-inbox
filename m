Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUFLO2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUFLO2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUFLO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:28:20 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:61329 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S264819AbUFLO2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:28:16 -0400
Date: Sat, 12 Jun 2004 18:28:02 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: stian@nixia.no
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
Message-ID: <20040612142802.GB3396@sirius.home>
References: <Pine.LNX.4.44.0406112308100.13607-100000@chimarrao.boston.redhat.com> <20040612134413.GA3396@sirius.home> <1469.83.109.11.80.1087048662.squirrel@nepa.nlc.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1469.83.109.11.80.1087048662.squirrel@nepa.nlc.no>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 12, 2004 at 03:57:42PM +0200, stian@nixia.no wrote:
> > --- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06
> > +0400
> > +++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 17:25:56 +0400
> > @@ -51,7 +51,6 @@
> >  #define __clear_fpu( tsk )					\
> >  do {								\
> >  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> > -		asm volatile("fwait");				\
> >  		(tsk)->thread_info->status &=3D ~TS_USEDFPU;	\
> >  		stts();						\
> >  	}							\
>=20
> But what about task-switching and fpu-exceptions that comes in late? I
> know that the kernel does not use FPU in general, and the places it does,
> fsave, fwait and frstor embeddes it all in kernel-space.

Kernel code which uses FPU should call kernel_fpu_begin() before it
and kernel_fpu_end() after.  kernel_fpu_begin() is safe - it uses
fnsave or fxsave, both of which don't raise pending FPU exceptions.
Also fnsave performs implicit fninit, and fxsave is followed by
fnclex, which clears pending exceptions.

However, raid6_before_mmx() [drivers/md/raid6x86.h] seems to be buggy:

static inline void raid6_before_mmx(raid6_mmx_save_t *s)
{
	s->cr0 =3D raid6_get_fpu();
	asm volatile("fsave %0 ; fwait" : "=3Dm" (s->fsave[0]));
}

fsave will raise pending exceptions (unlike fnsave).

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyxLyW82GfkQfsqIRAlYoAJ4yxTx/Uvn0h3bW2FzgcLPgUASaZACfYQWP
5Gnfk8kGotpS7sFy3jeSKbs=
=tYkH
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
