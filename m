Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUE1OPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUE1OPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUE1OPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:15:47 -0400
Received: from mail.donpac.ru ([80.254.111.2]:30346 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263159AbUE1OPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:15:40 -0400
Date: Fri, 28 May 2004 18:15:40 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r - Upgrade to v2.6.6 kernel
Message-ID: <20040528141540.GA12400@pazke>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org
References: <20040528.131611.28785624.takata.hirokazu@renesas.com> <20040528072336.GD7499@pazke> <swfzn7sivxe.wl@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <swfzn7sivxe.wl@renesas.com>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 149, 05 28, 2004 at 09:21:49PM +0900, Hirokazu Takata wrote:
> From: Andrey Panin <pazke@donpac.ru>
> > On 149, 05 28, 2004 at 01:16:11PM +0900, Hirokazu Takata wrote:
> > > I would like to send the latest 2.6.6 kernel patch for=20
> > > the Renesas M32R processor.
> > >=20
> > > Patch information to the stock 2.6.6 kernel is placed as follows:
> > > - m32r architecture dependent portions (arch/m32r, include/asm-m32r)
> > >   http://www.linux-m32r.org/public/linux-2.6.6_m32r_20040528.arch-m32=
r.patch
> >=20
> > Single megapatch (1.5 Mb in size) is not the best way to merge somethin=
g into Linux kernel.
>=20
> Yes, but the m32r port has not been merged into the mainline kernel
> tree yet...  May I send many small patches to LKML?
>=20
>=20
> > Now quick look at the patch itself:
>=20
> Thank you for your quick reply.
>=20
>=20
> > 1)
> > diff -ruN linux-2.6.6.org/arch/m32r/drivers/8390.c linux-2.6.6/arch/m32=
r/drivers/8390.c
>  ...
> > diff -ruN linux-2.6.6.org/arch/m32r/drivers/8390.h linux-2.6.6/arch/m32=
r/drivers/8390.h
>  ...
> > Is this really needed ?
>=20
> These files are required for mappi_ne.c.
> The mappi_ne.c is based on ne.c and modified for an eva board "mappi",
> I think it is highly dependent on the target platform.
>=20
> There are two reasons that we placed some m32r specific drivers in=20
> arch/m32r/drivers/:
> - We think they are highly depends on the target platform, and

So we should merge m32r core first :)

> - We can not merge them to drivers/ because the m32r architecture
>   has not been supported by the mainline linux kernel.

We have many arch specific drivers in drivers/net already.

> > 2) File arch/m32r/drivers/mappi_ne.c contains almost complete copy of d=
rivers/net/ne.c
> > with lots of code probably useless for your systems (old style ISA prob=
ing, ISAPnP=20
> > support etc.)
>=20
> Yes.
>=20
> > Also code like this is definetely unacceptable:
> >=20
> > +#ifdef CONFIG_PLAT_MAPPI
> > +		outb_p(0x4b, ioaddr + EN0_DCFG);
> > +#elif CONFIG_PLAT_OAKS32R
> > +		outb_p(0x48, ioaddr + EN0_DCFG);
> > +#else
> > +		outb_p(0x49, ioaddr + EN0_DCFG);
> > +#endif
> >=20
> > This fragment can be rewritten this way, with all  #ifdef mess hidden i=
n the some header file:
> >=20
> > +		outb_p(MY_MAGIC_OFFSET, ioaddr + EN0_DCFG);
>=20
> Do you mean I should use drivers/net/ne.c instead of mappi_ne.c?
> I'm not sure how can I merge such target-dependent code fragments to ne.c.
> But I will try to merge them.

I didn't mean merging. My point is that general policy for linux kernel
code is to avoid #ifdef cluttered code as much as possible. It's better
to hide such code in header files.
=20
> > 4) Do you really need to reimplement Linux console subsystem in arch/m3=
2r/drivers/video/console.c,
> > arch/m32r/drivers/video/fbmem.c, arch/m32r/drivers/video/fbcon.h ?
>=20
> These are obsolete codes, which were used in m32r 2.4 kernel.
> In 2.6 kernel, a framebuffer device and video console driver=20
> should be reimplement for m32r targets...
>=20
>=20
> > 5) Any specific reason to implement read[bwl]/write[bwl] this way:
> >=20
> > +unsigned char _readb(unsigned long addr)
> > +{
> > +       return *(volatile unsigned char *)addr;
> > +}
> >=20
> > Why not to inline them ?
>=20
> They were used for debugging.=20
> I will rewrite to inline them, thank you.
>=20
>=20
> > 6) Lots of ugly debugging #ifdef's in arch/m32r/kernel/ptrace.c
>=20
> I agree.
>=20
>=20
> > 7) arch/m32r/lib/clib.c contains slightly strange abs() function which
> > isn't used anywhere in the patch.
>=20
> Hmm..  it is really strange.  I will remove it.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAt0mMby9O0+A2ZecRAq+OAKCsuJ6wgy0iZSdMvxiy/DDp8Dv1awCaA3Ue
+r778Pw3JKaTEP84Z05W5j4=
=dy9o
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
