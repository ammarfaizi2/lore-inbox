Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTIHUyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTIHUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:54:38 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:53451 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263581AbTIHUyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:54:32 -0400
Date: Mon, 8 Sep 2003 13:54:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>, tytso@mit.edu
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-serial@vger.kernel.org, gallen@arlut.utexas.edu
Subject: [PATCH] Make the Startech UART detection 'more correct'.
Message-ID: <20030908205431.GB3888@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.  The following patches (vs 2.4 and 2.6) make the Startech UART
detection 'more correct'  The problem is that on with the Motorola
MPC82xx line (8245 for example) it has an internal DUART that it claims
to be PC16550D compatible, and it has an additional EFR (Enhanced
Feature Register) at offset 0x2, like on the Startech UARTS.  However,
it is not a Startech, and when it's detected as such, FIFOs don't work.
The fix for this is that the Startech UARTs have a 32 byte FIFO [1] and
the MPC82xx DUARTs have a 16-byte FIFO [2], to check that the FIFO size
is correct for a Startech.

2.4:
=3D=3D=3D=3D=3D drivers/char/serial.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/char/serial.c	Sun Jul  6 22:33:28 2003
+++ edited/drivers/char/serial.c	Fri Sep  5 15:44:11 2003
@@ -3740,7 +3740,7 @@
 	if (state->type =3D=3D PORT_16550A) {
 		/* Check for Startech UART's */
 		serial_outp(info, UART_LCR, UART_LCR_DLAB);
-		if (serial_in(info, UART_EFR) =3D=3D 0) {
+		if (serial_in(info, UART_EFR) =3D=3D 0 && size_fifo(info) !=3D 16) {
 			state->type =3D PORT_16650;
 		} else {
 			serial_outp(info, UART_LCR, 0xBF);

2.6:
=3D=3D=3D=3D=3D drivers/serial/8250.c 1.34 vs edited =3D=3D=3D=3D=3D
--- 1.34/drivers/serial/8250.c	Sun Jun 15 02:21:11 2003
+++ edited/drivers/serial/8250.c	Fri Sep  5 15:43:23 2003
@@ -467,7 +467,7 @@
 	 * Only ST16C650V1 UARTs pass this test.
 	 */
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	if (serial_in(up, UART_EFR) =3D=3D 0) {
+	if (serial_in(up, UART_EFR) =3D=3D 0 && size_fifo(up) !=3D 16) {
 		DEBUG_AUTOCONF("EFRv1 ");
 		up->port.type =3D PORT_16650;
 		return;

I must admit however, that after reading both datasheets, I'm not sure
if the correct test is for && size_fifo() =3D=3D 32 or !=3D 16, or if it
matters.  Comments?

This was originally fixed by Greg Allen[3].

[1]: http://www.exar.com/products/uartnote.pdf
[2]: http://e-www.motorola.com/brdata/PDFDB/docs/MPC8245UM_CH12.pdf
[3]: http://www.geocrawler.com/archives/3/8358/2002/3/0/8228902/
--=20
Tom Rini
http://gate.crashing.org/~trini/

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/XOyGdZngf2G4WwMRAtdwAJ9GFMCUdsyhuQyVFlugIDpDgrURsQCeNPFs
JABLFMFYULblMkK1c6H+Ov4=
=QTkT
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
