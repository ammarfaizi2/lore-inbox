Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUFLPOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUFLPOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUFLPOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:14:42 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:61330 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S264843AbUFLPOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:14:37 -0400
Date: Sat, 12 Jun 2004 19:14:22 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alexander Nyberg <alexn@telia.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       stian@nixia.no
Subject: Re: timer + fpu stuff locks up computer
Message-ID: <20040612151422.GC3396@sirius.home>
References: <20040612134413.GA3396@sirius.home> <1087050351.707.5.camel@boxen>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1087050351.707.5.camel@boxen>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 12, 2004 at 04:25:51PM +0200, Alexander Nyberg wrote:
> > --- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06 +=
0400
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
> Sorry for this extremely informative mail but, doesn't work.
>=20
> Looks like the problem is only being delayed:
>=20
> Pid: 431, comm:                 sshd
> EIP: 0060:[<c0119f98>] CPU: 0
> EIP is at force_sig_info+0x48/0x80
>  EFLAGS: 00000286    Not tainted  (2.6.7-rc3-mm1)
> EAX: 00000000 EBX: de96d7d0 ECX: 00000007 EDX: 00000008
> ESI: 00000008 EDI: 00000286 EBP: de9e3dd4 DS: 007b ES: 007b
> CR0: 8005003b CR2: 080b2664 CR3: 1f48f000 CR4: 000002d0
>  [<c0105560>] do_coprocessor_error+0x0/0x20
>  [<c01054f2>] math_error+0xb2/0x120
>  [<c01d2bb8>] fast_clear_page+0x8/0x50
=2E..

Grrr.  I was testing on a fairly generic kernel configuration which
did not include fast_clear_page()...

If the FPU state belong to the userspace process, kernel_fpu_begin()
is safe even if some exceptions are pending.  However, after
__clear_fpu() the FPU is "orphaned", and kernel_fpu_begin() does
nothing with it.

Replacing fwait with fnclex instead of removing it completely should
avoid the fault later.  However, looks like we really need the proper
fix - teach do_coprocessor_error() to recognize kernel mode faults and
fixup them.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyx3OW82GfkQfsqIRAtTuAKCJ23ahx6cbgJYqYTn5ybgmcbceDwCeM4vP
i9WLKXfO0GUlaJQwukKBJDk=
=WwKH
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
