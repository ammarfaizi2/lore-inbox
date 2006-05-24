Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWEXO1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWEXO1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWEXO1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:27:49 -0400
Received: from 187.red-82-159-197.user.auna.net ([82.159.197.187]:33756 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S932312AbWEXO1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:27:49 -0400
Subject: Re: A couple of oops.
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= <carlos@cmartin.tk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
In-Reply-To: <20060523174030.3b52ca71.akpm@osdl.org>
References: <1148408930.7726.11.camel@kiopa>
	 <20060523174030.3b52ca71.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hGj2IklJB3Waq6Z48u6P"
Date: Wed, 24 May 2006 16:26:38 +0200
Message-Id: <1148480798.4298.7.camel@kiopa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hGj2IklJB3Waq6Z48u6P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-23 at 17:40 -0700, Andrew Morton wrote:
> Carlos Mart=C3=ADn <carlos@cmartin.tk> wrote:
> >
> > Hi,
> >=20
> > I've nailed this down to something that happened in 2.6.17-rc4. The
> > system locks up with either a NULL dereference or an unhandable paging
> > request. The stack trace shows this:
> >=20
> > paging request            NULL dereference
> >=20
> > _raw_spin_trylock+12    _raw_spin_trylock+20
> > __spin_lock+22
> > main_timer_handler+22
> > timer_interrupt+18
> > handle_IRQ_event+41
> > __do_IRQ+156
> > do_IRQ+51
> > default_idle+0
> > _spin_unlock_irq+43
> > thread_return+187
> > generic_unplug_device+0
> > default_idle+45
> > dev_idle+95 (I can't read the func clearly in this handwriting)
> > start_secondary+1129
> >=20
> > I'm guessing this is the same problem only that it once manifests itsel=
f
> > as one and another time as the other. The problem is in the call to
> > write_seqlock(&xtime_lock) from main_timer_handler().
> >=20
> > I've not been able to determine what patch has caused this to happen,
> > but it is between 2.6.17-rc3 and -rc4. I'm bisecting, but if anybody ha=
s
> > a good candidate, it'd probably be faster than doing a complete bisect.
>=20
> hm, so an attempt to access xtime_lock.lock results in a null-pointer der=
ef?

It seems to be xtime_lock.sequence:
main_timer_handler:
        pushq   %r13    #
        movq    %rdi, %r13      # regs, regs
        movq    $xtime_lock+8, %rdi     #,
        pushq   %r12    #
        pushq   %rbp    #
        pushq   %rbx    #
        pushq   %rbp    #
        call    _spin_lock      #
OOPS--> incl    xtime_lock(%rip)        # xtime_lock.sequence
        xorl    %r12d, %r12d    # offset

>=20
> x86_64 does novel things, putting xtime_lock into a linker section all of
> its own.  At a guess I'd say that your compiler/assembler/linker toolchai=
n
> got confused and generated the incorrect address for xtime_lock.  But if
> that was the case you'd get oopses 100% of the time - it wouldn't be
> intermittent, as your description seems to imply (although it's quite
> unclear?).

Once I've seen the NULL dereference, the rest are paging request errors.
Most of the time I'm on X, so I don't actually see output, but the ones
I've seen have been like that.

It starts somewhere between rc3 and rc4.

With the bisect, now I'm left with a bunch of SCSI patches which don't
seem to bear any relationship and which I don't use (except for
usb-storage).

>=20
> You could do:
>=20
> gdb vmlinux
> (gdb) p &xtime_lock
> (gdb) x/40i main_timer_handler
>=20
--=20
Carlos Mart=C3=ADn Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |

--=-hGj2IklJB3Waq6Z48u6P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEdG0eEVXxXOiy6a4RAj50AKCqXakC1teRzV8mMVTfoAU58hjQvACfW0ZG
iYLZzBVpQPRI0MKTK0GgHf4=
=V49b
-----END PGP SIGNATURE-----

--=-hGj2IklJB3Waq6Z48u6P--

