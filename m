Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291152AbSBUJx1>; Thu, 21 Feb 2002 04:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291252AbSBUJxS>; Thu, 21 Feb 2002 04:53:18 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:6669 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S291152AbSBUJw7>;
	Thu, 21 Feb 2002 04:52:59 -0500
Date: Thu, 21 Feb 2002 12:56:51 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oxford Semiconductor's OXCB950 UART not recognized by serial. c
Message-ID: <20020221095651.GB275@pazke.ipt>
Mail-Followup-To: Ed Vance <EdV@macrolink.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76A8@EXCHANGE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76A8@EXCHANGE>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: multipart/mixed; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A1=D1=80=D0=B4, =D0=A4=D0=B5=D0=B2 20, 2002 at 04:05:13 -0800, Ed Va=
nce wrote:
> fabrizio.gennari@philips.com wrote:
> >=20
> > We have 32-bit CardBus cards with OXCB950 CardBus (PCI ID 1415:950b) UA=
RT=20
> > chips on them (OXCB950 is the CardBus version of 16C950) . The module=
=20
> > serial_cb in the pcmcia-cs package recognizes them correctly. But, when=
=20
> > not using serial_cb, the function serial_pci_guess_board in serial.c=20
> > doesn't (kernel 2.4.17 tested). The problem is that the card advertises=
 3=20
> > i/o memory regions and 2 ports. If one replaces the line
> >=20
> > if (num_iomem <=3D 1 && num_port =3D=3D 1) {
> >=20
> > with
> >=20
> > if (num_port >=3D 1) {
> >=20
> > in the function serial_pci_guess_board(), the card is detected and work=
s=20
> > perfectly. Only, when inserting it, the kernel displays the message:
> >=20
> > Redundant entry in serial pci_table.  Please send the output of
> > lspci -vv, this message (1415,950b,1415,0001)
> > and the manufacturer and name of serial board or modem board
> > to serial-pci-info@lists.sourceforge.net. =20
>=20
> The "Redundant entry" message comes out of serial.c when a card is found =
in
> the PCI ID board list, but which function serial_pci_guess_board() also
> detects as a generic single UART card (and overwrites the card's
> board->flags field in the pci_boards[] array).=20
>=20
> Does anybody think this is a feature? Did I misunderstand?
>=20
> I suspect that the thought was to detect and eventually remove pci_boards=
[]
> entries for generic single-port cards that could also be detected by the
> serial_pci_guess_board() function. Can anybody confirm or deny?=20

You are right.

Does the attached patch remove this message ?

Best regards.=20

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial-rentry
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/char/serial.c /linux/driv=
ers/char/serial.c
--- /linux.vanilla/drivers/char/serial.c	Sat Feb  9 19:24:23 2002
+++ /linux/drivers/char/serial.c	Sat Feb  9 20:02:14 2002
@@ -4451,6 +4451,12 @@
 	return 1;
 }
=20
+static inline int serial_is_redundant(const struct pci_board *board)
+{
+	return !((board->num_ports > 1) || (board->base_baud !=3D 115200) ||
+		 (board->init_fn) || (board->first_uart_offset));
+}
+
 static int __devinit serial_init_one(struct pci_dev *dev,
 				     const struct pci_device_id *ent)
 {
@@ -4465,7 +4471,8 @@
 	if (ent->driver_data =3D=3D pbn_default &&
 	    serial_pci_guess_board(dev, board))
 		return -ENODEV;
-	else if (serial_pci_guess_board(dev, &tmp) =3D=3D 0) {
+	else if ((serial_pci_guess_board(dev, &tmp) =3D=3D 0) &&
+		 (serial_is_redundant(board))) {
 		printk(KERN_INFO "Redundant entry in serial pci_table.  "
 		       "Please send the output of\n"
 		       "lspci -vv, this message (%04x,%04x,%04x,%04x)\n"

--BwCQnh7xodEAoBMC--

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dMRjBm4rlNOo3YgRAq+KAJ9LHQZkz9TygSQDvsevKSunFnDF5wCfYBn/
W+MmNvHNnpKpxJWns/lzVtI=
=0KtU
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
