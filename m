Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSBKNIg>; Mon, 11 Feb 2002 08:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSBKNIR>; Mon, 11 Feb 2002 08:08:17 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:34821 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S288987AbSBKNH5>;
	Mon, 11 Feb 2002 08:07:57 -0500
Date: Mon, 11 Feb 2002 16:11:53 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Meaningless "Redundant entry in serial pci_table." message
Message-ID: <20020211131153.GB429@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

current serial driver emits annoying message "Redundant entry in=20
serial pci_table." for many unguilty PCI and CardBus cards.

So I made the attached patch, keeping in mind that:
	- cards with more than one port;
	- cards with nonstandard clock speed;
	- cards requiring special initialization;
	- cards with nonzero first_uart_offset.
cannot be properly guessed.

Please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--s9fJI615cBHmzTOP
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

--s9fJI615cBHmzTOP--

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Z8MZBm4rlNOo3YgRAmQTAJ4hFuD9+JRXsee9RJGwmy/fwrC/SgCcCTEi
cQTRAkAzjOpiC6++1Ta71aM=
=D4o+
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
