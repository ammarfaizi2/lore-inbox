Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTGMKrw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270217AbTGMKrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:47:52 -0400
Received: from mx02.qsc.de ([213.148.130.14]:43484 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S270214AbTGMKrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:47:47 -0400
Date: Sun, 13 Jul 2003 13:02:11 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hang with pcmcia wlan card
Message-ID: <20030713110211.GA3504@gmx.de>
Reply-To: Wiktor Wodecki <wodecki@gmx.net>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi> <873chbyasi.fsf@jumper.lonesom.pp.fi> <20030712173039.A17432@flint.arm.linux.org.uk> <20030712164855.GB2133@gmx.de> <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk> <87wuemg3h2.fsf@jumper.lonesom.pp.fi> <20030713110016.A2621@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20030713110016.A2621@flint.arm.linux.org.uk>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.75 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2003 at 11:00:16AM +0100, Russell King wrote:
> On Sun, Jul 13, 2003 at 12:50:33PM +0300, Jaakko Niemi wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > On Sad, 2003-07-12 at 17:48, Wiktor Wodecki wrote:
> > >> > +      * If ISA interrupts don't work, then fall back to routing c=
ard
> > >> > +      * interrupts to the PCI interrupt of the socket.
> > >> > +      */
> > >> > +     if (!socket->socket.irq_mask) {
> > >> > +             int irqmux, devctl;
> > >> > +
> > >
> > > See the fix posted to the list a while ago and apply that and all sho=
uld
> > > be well. The change you refer to breaks for some setups
> >=20
> >  Was the fix against drivers/pcmcia/ti113x.h ? (other than backing off
> >  that patch..). If so, then I'm unable to locate it. Looks like I need
> >  local lkml archive anyway :)
>=20
> The patch never went anywhere near lkml.  It was sent to Pat Mochel
> primerily for testing (since Pat was able to produce the feedback
> last time around to solve the problem.)  However, I haven't heard back
> from Pat.
>=20
> I won't even bother putting this into my bk tree and asking Linus to
> pull; I'm sure someone else will integrate this into the kernel tree
> for me.  (as happened previously, and as a result I need to sort out
> my bk tree.)

oh, I'm sorry, I must have missed this patch. I just applied it on top
of 2.5.75-bk2 and it fixes the problem for me. Please apply it and tell
linus, thinks like that happen - don't be grumpy please :-)

>=20
> --- orig/drivers/pcmcia/ti113x.h	Wed Jul  2 22:44:06 2003
> +++ linux/drivers/pcmcia/ti113x.h	Sun Jul  6 22:52:41 2003
> @@ -179,21 +179,26 @@
>  	/*
>  	 * If ISA interrupts don't work, then fall back to routing card
>  	 * interrupts to the PCI interrupt of the socket.
> +	 *
> +	 * Tweaking this when we are using serial PCI IRQs causes hangs
> +	 *   --rmk
>  	 */
>  	if (!socket->socket.irq_mask) {
> -		int irqmux, devctl;
> -
> -		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
> +		u8 irqmux, devctl;
> =20
>  		devctl =3D config_readb(socket, TI113X_DEVICE_CONTROL);
> -		devctl &=3D ~TI113X_DCR_IMODE_MASK;
> +		if (devctl & TI113X_DCR_IMODE_MASK !=3D TI12XX_DCR_IMODE_ALL_SERIAL) {
> +			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
> +
> +			devctl &=3D ~TI113X_DCR_IMODE_MASK;
> =20
> -		irqmux =3D config_readl(socket, TI122X_IRQMUX);
> -		irqmux =3D (irqmux & ~0x0f) | 0x02; /* route INTA */
> -		irqmux =3D (irqmux & ~0xf0) | 0x20; /* route INTB */
> +			irqmux =3D config_readl(socket, TI122X_IRQMUX);
> +			irqmux =3D (irqmux & ~0x0f) | 0x02; /* route INTA */
> +			irqmux =3D (irqmux & ~0xf0) | 0x20; /* route INTB */
> =20
> -		config_writel(socket, TI122X_IRQMUX, irqmux);
> -		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
> +			config_writel(socket, TI122X_IRQMUX, irqmux);
> +			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
> +		}
>  	}
> =20
>  	socket->socket.ss_entry->init =3D ti_init;
>=20
>=20
> --=20
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM L=
inux
>              http://www.arm.linux.org.uk/personal/aboutme.html

--=20
Regards,

Wiktor Wodecki

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ETwz6SNaNRgsl4MRAqQ6AJ9YueZ5t4HA23clR9FuHRP6C2gtHACgk/p3
qvb6sljWChRY3fktCrYROXc=
=ixB1
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
