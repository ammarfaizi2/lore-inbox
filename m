Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUD2RiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUD2RiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbUD2RiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:38:07 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:41154 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S263166AbUD2Rh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:37:59 -0400
Date: Thu, 29 Apr 2004 18:37:19 +0100
From: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Message-ID: <20040429173719.GC4442@jsambrook>
Reply-To: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
References: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades> <20040319210720.J14431@flint.arm.linux.org.uk> <20040428195434.GA27783@jsambrook> <200404282310.28403.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <200404282310.28403.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 23:10 on Wed 28/04/04, daniel.ritz@gmx.ch masquerading as 'Daniel Ritz' =
wrote:
> On Wednesday 28 April 2004 21:54, Jonathan Sambrook wrote:
> > At 21:07 on Fri 19/03/04, rmk+lkml@arm.linux.org.uk masquerading as 'Ru=
ssell King' wrote:
> > > On Fri, Mar 19, 2004 at 03:14:54PM -0300, Marcelo Tosatti wrote:
> > > > It seems the problem reported by Silla Rizzoli is still present in =
2.6.x
> > > > and 2.4.25 (both include the voltage interrogation patch by rmk).
> > > >=20
> > > > Daniel Ritz made some efforts to fix it, but did not seem to get it=
 right.=20
> > >=20
> > > And that effort is still going on.  Daniel and Pavel have been trying
> > > to find a good algorithm for detecting and fixing misconfigured TI
> > > interrupt routing, and this effort is still on-going.
> > >=20
> > > What would be useful is if Silla could test some of Daniel's patches
> > > and provide feedback.
> > >=20
> > > The latest 2.6 patch from Daniel is at:
> >=20
> > Any movement on 2.4.x w.r.t this?
> > Even a patch to get back 2.4.23 functionality whihc worked fine here
> > would be good (need > 2.4.25 for XFS).
> >=20
>=20
> well, the 2.4 of the TI interrupt routing that is merged in 2.6 is is her=
e since april 6:
> http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9_v24.patch
> (yes, the 2.6 version is nicer 'cos of the nicer override handling there)
>=20
> the problem silla rizzoli has is different. the patch that solved it:

Hmmn.. my TI1410 is still detecting my Yenta/Orinoco based configuration
as Anonymous Memory, that's with pcmcia-ti-routing-9_v24.patch :( As I
say, was working with 2.4.22.

dmesg says:
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
	PCI: Enabling device 01:06.0 (0000 -> 0002)
	Yenta TI: socket 01:06.0, mfunc 0x00001d92, devctl 0x02
	Yenta TI: socket 01:06.0 probing PCI interrupt failed, trying to fix
	Yenta TI: socket 01:06.0 no PCI interrupts. Fish. Please report.
	Yenta ISA IRQ mask 0x0000, PCI irq 0
	Socket status: 10000011
	cs: IO port probe 0x0c00-0x0cff: excluding 0xcf0-0xcff
	cs: IO port probe 0x0800-0x08ff: clean.
	cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
	cs: IO port probe 0x0a00-0x0aff: clean.
	cs: memory probe 0x40000000-0x40000fff: excluding
	0x40000000-0x40001fff

lspci:
	01:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
	Controller (rev 01)

>=20
> --- snip ---
> the CB_CDETECT1 and CB_CDETECT2 bits both needs to be 0 for the card being
> recognized correctly (and one of the voltage bits need to be set).
>=20
> with the patch we always redo the interrogation as longs as we're not sure
> a card is really there (it would be bad to do so on some bridges). this s=
olves
> hangs of the bridge seen at least on one TI1520.
>=20
> the if-statement was originally added 'cos some bridges misbehave if the
> interrogation is done when a card is already correctly recognised. this is
> still true with the patch.
>=20
> the ti1520 that silla rizzoli has shoots itself in the head (read: hangs)=
 and does not
> regognise card insert/removal event. the card only works there if it was =
inserted on
> boot. redoing the interrogation when there's no card kicks the bridge bac=
k into the
> right state making it work...
>=20
> --- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 11:55:05 2004
> +++ edited/drivers/pcmcia/yenta.c	Fri Feb 20 23:17:54 2004
> @@ -677,10 +677,9 @@
> =20
>  	/* Redo card voltage interrogation */
>  	state =3D cb_readl(socket, CB_SOCKET_STATE);
> -	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
> -			CB_3VCARD | CB_XVCARD | CB_YVCARD)))
> -	=09
> -	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
> +	if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ||
> +	    (state & (CB_CDETECT1 | CB_CDETECT2)))
> +		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
>  }
> =20
>  /* Called at resume and initialization events */
>=20

--=20
                  =20
 Jonathan Sambrook=20
Software  Developer=20
 Designer  Servers

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAkT1PSUOTbbpGXDwRAl/OAKCEHTEx5B42I6lR8QMzmrzoSwBbzwCggELy
58UD0MTjjFm4ZV33cgjp9yM=
=91kw
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
