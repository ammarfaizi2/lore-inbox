Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTF0ET2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 00:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTF0ET1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 00:19:27 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:4034 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263637AbTF0ETZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 00:19:25 -0400
Date: Fri, 27 Jun 2003 08:33:20 +0400
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] irq handling code consolidation (common part)
Message-ID: <20030627043320.GW9679@pazke>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030626110247.GT9679@pazke> <20030626121318.A6576@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jfWagoTHmfL/c8Ax"
Content-Disposition: inline
In-Reply-To: <20030626121318.A6576@infradead.org>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.7 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jfWagoTHmfL/c8Ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 177, 06 26, 2003 at 12:13:18PM +0100, Christoph Hellwig wrote:
> > +#ifndef HAVE_ARCH_IRQ_DESC
> > +
> > +/*
> > + * Controller mappings for all interrupt sources:
> > + */
> > +irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =3D {
> > +	[0 ... NR_IRQS - 1] =3D {
> > +		.handler =3D	&no_irq_type,
> > +		.lock =3D		SPIN_LOCK_UNLOCKED,
> > +	}
> > +};
> > +
> > +#endif
>=20
> What about getting rid of that ifdef and having irq_desc always
> in arch code?  Seems a lot cleaner to me.

So it will be duplicated in allmost every architecture ?

> > +#if defined(CONFIG_SMP) && !defined(HAVE_ARCH_SYNCRONIZE_IRQ)
> > +
> > +inline void synchronize_irq(unsigned int irq)
> > +{
> > +	irq_desc_t *desc =3D irq_desc(irq);
> > +
> > +        /* is there anything to synchronize with? */
> > +	if (!desc->action)
> > +		return;
> > +
> > +	while (desc->status & IRQ_INPROGRESS)
> > +		cpu_relax();
> > +}
> > +
> > +#endif
>=20
> Hmm, what arch can't use the generic version and why?  I really
> don't like the HAVE_ARCH_ macros if there's a way around it.

This function implemented differently in allmost every architecture.
I beleive that most of them can use generic version, but I'm still not sure.
v850 and mips define synchronize_irq() as barrier() for example.
=20
> > +#ifndef HAVE_ARCH_IRQ_PROC
> > +void register_irq_proc(unsigned int irq);
> > +#endif
>=20
> Again, what arch can't use the generic code?

IIRC v850 architecture doesn't need it at all.
=20
> > +#ifndef HAVE_ARCH_IRQ_PROBE
> > +
> > +/*
> > + * IRQ autodetection code..
> > + *
> > + * This depends on the fact that any interrupt that
> > + * comes in on to an unassigned handler will get stuck
> > + * with "IRQ_WAITING" cleared and the interrupt
> > + * disabled.
> > + */
>=20
> Which architecture uses it's own version here?  Also we might
> move this to a separate file as it doesn't make a lot of sense
> without CONFIG_ISA

Some architectures provide empty stubs for these functions.
I'm not sure about CONFIG_ISA, IMHO any legacy device driver
can use irq autoprobing.

> Otherwise it looks fine (of course)!  Let's hope we'll get some variant
> of it in before 2.6.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--jfWagoTHmfL/c8Ax
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++8kQby9O0+A2ZecRAhjyAKC9x4plN7vuz5SkcrchutHt/HiIXQCgzN0L
FUdajYjllxsSNAh8c9/TLRc=
=56DJ
-----END PGP SIGNATURE-----

--jfWagoTHmfL/c8Ax--
