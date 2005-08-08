Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVHHXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVHHXVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVHHXVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:21:31 -0400
Received: from quickstop.soohrt.org ([81.2.155.147]:44185 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S932356AbVHHXVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:21:30 -0400
Date: Tue, 9 Aug 2005 01:04:01 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.13-rc3-git9] pl2303: pl2303_update_line_status data length fix
Message-ID: <20050808230401.GR20932@quickstop.soohrt.org>
References: <20050728133220.GJ25889@quickstop.soohrt.org> <20050808222423.GA4550@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMM+kVNHGkMezEqK"
Content-Disposition: inline
In-Reply-To: <20050808222423.GA4550@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XMM+kVNHGkMezEqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Aug 2005, Greg KH wrote:
> On Thu, Jul 28, 2005 at 03:32:20PM +0200, Horst Schirmeier wrote:
> > Minimum data length must be UART_STATE + 1, as data[UART_STATE] is being
> > accessed for the new line_state. Although PL-2303 hardware is not
> > expected to send data with exactly UART_STATE length, this keeps it on
> > the safe side.
> >=20
> > Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
> > ---
> >=20
> > --- linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c.orig	2005-07-28 1=
4:42:58.000000000 +0200
> > +++ linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c	2005-07-28 14:43:=
16.000000000 +0200
> > @@ -826,7 +826,7 @@ static void pl2303_update_line_status(st
> >  	struct pl2303_private *priv =3D usb_get_serial_port_data(port);
> >  	unsigned long flags;
> >  	u8 status_idx =3D UART_STATE;
> > -	u8 length =3D UART_STATE;
> > +	u8 length =3D UART_STATE + 1;
>=20
> "safe side" yes, but this will just prevent any line changes from going
> back to the user, right?

IMHO not, no. The PL-2303 interrupt IN endpoint has a 10 bytes FIFO and
(as far as I've observed from the type_1 model) always sends packets
with exactly this size. The UART_STATE is located at offset 0x08,
therefore the minimum packet length we need is 0x09 (UART_STATE + 1).

Here are the two different byte sequences from that endpoint I picked
up; the first with a terminal on the serial end, the second without one
(both times using the patched pl2303 module with debug=3D1):

a1 20 00 00 00 00 02 00 00 00
a1 20 00 00 00 00 02 00 82 00

Note the UART_STATE byte with the DSR and CTS bits set in the second
case.

> Hm, how is this working at all, it looks like we overflow the buffer...

In the unlikely case that some weird hardware sends a packet with
exactly UART_STATE (8) bytes length, yes, we do. Normal PL-2303 hardware
_should_ cause no trouble, as it always sends 10 bytes (at least my
hardware does), therefore my side note "this keeps it on the safe side".

> Have you tested this change?

Yes, I have.

> thanks,
>=20
> greg k-h

Kind regards,
 Horst

--=20
PGP-Key 0xD40E0E7A

--XMM+kVNHGkMezEqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC9+ThB6mkGNQODnoRAiseAJwNjBSJKKcHXh4CUDZXgI/CDx5MDwCg3ciq
ri0TTVstNnoq5YNvXo/fpbE=
=UmHC
-----END PGP SIGNATURE-----

--XMM+kVNHGkMezEqK--
