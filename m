Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTIIXwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTIIXwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:52:00 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:14721 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265024AbTIIXvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:51:54 -0400
Date: Tue, 9 Sep 2003 16:51:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: tytso@mit.edu, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-serial@vger.kernel.org, gallen@arlut.utexas.edu
Cc: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: [PATCH] Make the Startech UART detection 'more correct'.
Message-ID: <20030909235153.GB4559@ip68-0-152-218.tc.ph.cox.net>
References: <20030908205431.GB3888@ip68-0-152-218.tc.ph.cox.net> <20030909171859.D4216@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20030909171859.D4216@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2003 at 05:18:59PM +0100, Russell King wrote:

> On Mon, Sep 08, 2003 at 01:54:31PM -0700, Tom Rini wrote:
> > Hello.  The following patches (vs 2.4 and 2.6) make the Startech UART
> > detection 'more correct'  The problem is that on with the Motorola
> > MPC82xx line (8245 for example) it has an internal DUART that it claims
> > to be PC16550D compatible, and it has an additional EFR (Enhanced
> > Feature Register) at offset 0x2, like on the Startech UARTS.  However,
> > it is not a Startech, and when it's detected as such, FIFOs don't work.
> > The fix for this is that the Startech UARTs have a 32 byte FIFO [1] and
> > the MPC82xx DUARTs have a 16-byte FIFO [2], to check that the FIFO size
> > is correct for a Startech.
>=20
> size_fifo() is claimed to be unreliable at detecting the FIFO size,
> so I don't feel safe about using it here.
>=20
> I'd suggest something like:
>=20
> 	serial_outp(port, UART_LCR, UART_LCR_DLAB);
> 	efr =3D serial_in(port, UART_EFR);
> 	if ((efr & 0xfc) =3D=3D 0) {
> 		serial_out(port, UART_EFR, 0xac | (efr & 3));
> 		/* if top 6 bits return zero, its motorola */
> 		if (serial_in(port, UART_EFR) =3D=3D (efr & 3)) {
> 			/* motorola port */
> 		} else {
> 			/* ST16C650V1 port */
> 		}
> 		/* restore old value */
> 		serial_outb(port, UART_EFR, efr);
> 	}

Okay, from Kumar Gala (cc'ed) I've got the following patch for 2.4:
=3D=3D=3D=3D=3D drivers/char/serial.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/char/serial.c	Sun Jul  6 22:33:28 2003
+++ edited/drivers/char/serial.c	Tue Sep  9 16:50:22 2003
@@ -3741,7 +3741,10 @@
 		/* Check for Startech UART's */
 		serial_outp(info, UART_LCR, UART_LCR_DLAB);
 		if (serial_in(info, UART_EFR) =3D=3D 0) {
-			state->type =3D PORT_16650;
+			serial_outp(info, UART_EFR, 0xA8);
+			if (serial_in(info, UART_EFR) !=3D 0)
+				state->type =3D PORT_16650;
+			serial_outp(info, UART_EFR, 0);
 		} else {
 			serial_outp(info, UART_LCR, 0xBF);
 			if (serial_in(info, UART_EFR) =3D=3D 0)

And I forward ported this up to 2.6 as:
=3D=3D=3D=3D=3D drivers/serial/8250.c 1.36 vs edited =3D=3D=3D=3D=3D
--- 1.36/drivers/serial/8250.c	Tue Sep  9 07:22:12 2003
+++ edited/drivers/serial/8250.c	Tue Sep  9 16:49:07 2003
@@ -469,8 +469,13 @@
 	 */
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
 	if (serial_in(up, UART_EFR) =3D=3D 0) {
-		DEBUG_AUTOCONF("EFRv1 ");
-		up->port.type =3D PORT_16650;
+		serial_outp(up, UART_EFR, 0xA8);
+		if (serial_in(up, UART_EFR) !=3D 0) {
+			DEBUG_AUTOCONF("EFRv1 ");
+			up->port.type =3D PORT_16650;
+		} else
+			DEBUG_AUTOCONF("Motorola 8xxx DUART ");
+		serial_outp(up, UART_EFR, 0);
 		return;
 	}

Better?

--=20
Tom Rini
http://gate.crashing.org/~trini/

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/XmeZdZngf2G4WwMRAtXrAJ4gUH2JVVZ2c/eLJuEOPBJ6uF8iuQCeKGlx
p0qdZyIVLKdCGoOqGULfCbc=
=Wba5
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
