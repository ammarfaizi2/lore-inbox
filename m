Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbTGDHmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbTGDHmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:42:25 -0400
Received: from mx02.qsc.de ([213.148.130.14]:2509 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265834AbTGDHmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:42:22 -0400
Date: Fri, 4 Jul 2003 10:00:20 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704080020.GA703@gmx.de>
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk> <20030703151529.B20336@flint.arm.linux.org.uk> <20030703214921.GM4266@gmx.de> <20030703231401.G20336@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20030703231401.G20336@flint.arm.linux.org.uk>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.73-bk7-O1int0307010949 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2003 at 11:14:01PM +0100, Russell King wrote:
> On Thu, Jul 03, 2003 at 11:49:21PM +0200, Wiktor Wodecki wrote:
> > On Thu, Jul 03, 2003 at 03:15:29PM +0100, Russell King wrote:
> > > Ok, Wiktor has tried removing these 6 patches, and his problem persis=
ts.
> > > According to bk revtool, these 6 patches are the only changes which
> > > went in for to pcmcia from .73 to .74.
> > >=20
> > > If anyone else is having similar problems, they need to report them so
> > > we can obtain more data points - I suspect some other change in some =
other
> > > subsystem broke PCMCIA for Wiktor.
> > >=20
> > > Wiktor - short of anyone else responding, you could try reversing each
> > > of the nightly -bk patches from .74 to .73 and work out which set of
> > > changes broke it.
> >=20
> > it broke with the 2.5.73-rc2 patch. I assume it was:
>=20
> Ok, looking at the -bk1-bk2 incremental patch, there's a couple of
> possibilities:
>=20
> - changes to the x86 PCI code
> - changes to yenta_socket.c to add different overrides
> - add burst support to yenta_socket.c for TI bridges
> - add ISA interrupt routing work-around for TI bridges
>=20
> I think the number one suspect is probably the final one.  Could you try
> reversing this patch please?

gotcha, with this one reverted 2.5.73-bk2 boots up fine

>=20
> diff -urN linux-2.5.73-bk1/drivers/pcmcia/ti113x.h linux-2.5.73-bk2/drive=
rs/pcmcia/ti113x.h
> --- linux-2.5.73-bk1/drivers/pcmcia/ti113x.h	2003-06-22 11:32:41.00000000=
0 -0700
> +++ linux-2.5.73-bk2/drivers/pcmcia/ti113x.h	2003-06-24 13:06:59.00000000=
0 -0700
> @@ -175,6 +175,27 @@
>  	new =3D reg & ~I365_INTR_ENA;
>  	if (new !=3D reg)
>  		exca_writeb(socket, I365_INTCTL, new);
> +
> +	/*
> +	 * If ISA interrupts don't work, then fall back to routing card
> +	 * interrupts to the PCI interrupt of the socket.
> +	 */
> +	if (!socket->socket.irq_mask) {
> +		int irqmux, devctl;
> +
> +		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
> +
> +		devctl =3D config_readb(socket, TI113X_DEVICE_CONTROL);
> +		devctl &=3D ~TI113X_DCR_IMODE_MASK;
> +
> +		irqmux =3D config_readl(socket, TI122X_IRQMUX);
> +		irqmux =3D (irqmux & ~0x0f) | 0x02; /* route INTA */
> +		irqmux =3D (irqmux & ~0xf0) | 0x20; /* route INTB */
> +
> +		config_writel(socket, TI122X_IRQMUX, irqmux);
> +		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
> +	}
> +
>  	socket->socket.ss_entry->init =3D ti_init;
>  	return 0;
>  }
>=20
>=20
>=20
> --=20
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM L=
inux
>              http://www.arm.linux.org.uk/personal/aboutme.html

--=20
Regards,

Wiktor Wodecki

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BTQU6SNaNRgsl4MRAhkSAJsEVSBD03mCBm7zJ+MmyRvQISgLUQCffGcm
CSRnCsouI+PApNFItqR0qRo=
=Htqx
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
