Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268047AbTGLQev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbTGLQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:34:51 -0400
Received: from mx02.qsc.de ([213.148.130.14]:35254 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268047AbTGLQeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:34:10 -0400
Date: Sat, 12 Jul 2003 18:48:55 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>, linux-kernel@vger.kernel.org
Subject: Re: hang with pcmcia wlan card
Message-ID: <20030712164855.GB2133@gmx.de>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi> <873chbyasi.fsf@jumper.lonesom.pp.fi> <20030712173039.A17432@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20030712173039.A17432@flint.arm.linux.org.uk>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.75 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

well, at least it is this changeset for me (same problem)

> --- linux-2.5.73-bk1/drivers/pcmcia/ti113x.h  2003-06-22
> 11:32:41.000000000 -0700
> +++ linux-2.5.73-bk2/drivers/pcmcia/ti113x.h  2003-06-24
> 13:06:59.000000000 -0700
> @@ -175,6 +175,27 @@
>       new =3D reg & ~I365_INTR_ENA;
>       if (new !=3D reg)
>               exca_writeb(socket, I365_INTCTL, new);
> +
> +     /*
> +      * If ISA interrupts don't work, then fall back to routing card
> +      * interrupts to the PCI interrupt of the socket.
> +      */
> +     if (!socket->socket.irq_mask) {
> +             int irqmux, devctl;
> +
> +             printk (KERN_INFO "ti113x: Routing card interrupts to
> PCI\n");
> +
> +             devctl =3D config_readb(socket, TI113X_DEVICE_CONTROL);
> +             devctl &=3D ~TI113X_DCR_IMODE_MASK;
> +
> +             irqmux =3D config_readl(socket, TI122X_IRQMUX);
> +             irqmux =3D (irqmux & ~0x0f) | 0x02; /* route INTA */
> +             irqmux =3D (irqmux & ~0xf0) | 0x20; /* route INTB */
> +
> +             config_writel(socket, TI122X_IRQMUX, irqmux);
> +             config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
> +     }
> +
>       socket->socket.ss_entry->init =3D ti_init;
>       return 0;
>  }


On Sat, Jul 12, 2003 at 05:30:39PM +0100, Russell King wrote:
> On Sat, Jul 12, 2003 at 07:22:53PM +0300, Jaakko Niemi wrote:
> >=20
> > > Hi,
> > >
> > >My laptop (thinkpad 570e) hangs hard straight after bringing up
> > >interface with d-link dwl-650 wlan card. 2.5.73-bk1 works and
> > >2.5.73-bk2 to 2.5.75-bk1 hang. If I boot without the card,
> > >everything comes up, but inserting the card results to a hang.
> > >Setting nmi_watchdog=3D2 has no effect.
> >=20
> >  Ok, bit more info: same thing happens with edimax 8139 based
> >  cardbus nic also. I've disabled apm and acpi from kernel=20
> >  and going to start going through the pci changes between=20
> >  2.5.73-bk1 and bk2. Any clues would be much appreciated.
>=20
> Its a hotplug/netdevice interaction, and it happens for many hotpluggable
> network devices, whether they be NE2K cards, wireless cards or whatever.
>=20
> AFAICS, it isn't a PCMCIA nor cardbus problem.
>=20
> --=20
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM L=
inux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards,

Wiktor Wodecki

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/EDv36SNaNRgsl4MRAtoDAJ9BySlvS3S/dp/AbTuuTaGtcpV4wQCgldDR
jHgl9TpZ4sqyaS15+jXqKxs=
=ZCea
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
