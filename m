Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWBBN13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWBBN13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWBBN13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:27:29 -0500
Received: from bataysk.donpac.ru ([80.254.111.21]:45776 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S1751052AbWBBN12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:27:28 -0500
Date: Thu, 2 Feb 2006 16:27:26 +0300
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060202132726.GD24903@pazke>
Mail-Followup-To: Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20060202102644.GC5034@flint.arm.linux.org.uk>
X-Uname: Linux 2.6.16-rc1-pazke i686
User-Agent: Mutt/1.5.11
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

n 033, 02 02, 2006 at 10:26:44AM +0000, Russell King wrote:
> On Tue, Jan 24, 2006 at 09:01:41PM +0000, Russell King wrote:
> > On Tue, Jan 24, 2006 at 11:25:38AM +0300, Andrey Panin wrote:
> > > This patch (against 2.6.16-rc1) adds support for SIIG 8 port serial b=
oards.
> > > Please consider applying.
> >=20
> > Could you supply a sign-off (and a description) for this patch please -
> > see Documentation/SubmittingPatches for more information.
>=20
> Ping?

Pong :) Please see below. Does it look better now ?


BTW I have a question for you. I'm trying to add support for Advantech seri=
al
cards into 8250_pci.c. These cards are based on Oxford Semiconductor 16C950
UARTs and some of then can work in RS485 mode. They use DTR to automatically
control direction of the RS485 transiever buffer and so need to set bits
3 and 4 in the ACR register. Unfortunately there is currently no way to set
different ACR value. Is it okay to use unused[] array in the struct uart_po=
rt
to pass ACR value from 8250_pci.c to 8250.c ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-siig-8port-board.diff"
Content-Transfer-Encoding: quoted-printable


This patch adds support for SIIG 8-port boards. These boards have 4 ports in
separate bars and another 4 ports in the single bar. Because of this strange
port arrangement these cards need special setup function. Fortunately no ot=
her
SIIG cards have more than 4 port, so this setup function could be used for =
them
too.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 drivers/serial/8250_pci.c |   25 ++++++++++++++++++++++++-
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.16-rc1.vanilla/drivers/serial/82=
50_pci.c linux-2.6.16-rc1/drivers/serial/8250_pci.c
--- linux-2.6.16-rc1.vanilla/drivers/serial/8250_pci.c	2006-01-24 10:14:24.=
000000000 +0300
+++ linux-2.6.16-rc1/drivers/serial/8250_pci.c	2006-01-24 10:16:56.00000000=
0 +0300
@@ -439,6 +439,20 @@ static int pci_siig_init(struct pci_dev=20
 	return -ENODEV;
 }
=20
+static int pci_siig_setup(struct serial_private *priv,
+			  struct pciserial_board *board,
+			  struct uart_port *port, int idx)
+{
+	unsigned int bar =3D FL_GET_BASE(board->flags) + idx, offset =3D 0;
+
+	if (idx > 3) {
+		bar =3D 4;
+		offset =3D (idx - 4) * 8;
+	}
+
+	return setup_port(priv, port, bar, offset, 0);
+}
+
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
@@ -748,7 +762,7 @@ static struct pci_serial_quirk pci_seria
 		.subvendor	=3D PCI_ANY_ID,
 		.subdevice	=3D PCI_ANY_ID,
 		.init		=3D pci_siig_init,
-		.setup		=3D pci_default_setup,
+		.setup		=3D pci_siig_setup,
 	},
 	/*
 	 * Titan cards
@@ -2134,6 +2148,15 @@ static struct pci_device_id serial_pci_t
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_4_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_550,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_850,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
=20
 	/*
 	 * Computone devices submitted by Doug McNash dmcnash@computone.com
diff -urdpNX /usr/share/dontdiff linux-2.6.16-rc1.vanilla/include/linux/pci=
_ids.h linux-2.6.16-rc1/include/linux/pci_ids.h
--- linux-2.6.16-rc1.vanilla/include/linux/pci_ids.h	2006-01-24 10:14:51.00=
0000000 +0300
+++ linux-2.6.16-rc1/include/linux/pci_ids.h	2006-01-24 10:16:56.000000000 =
+0300
@@ -1677,6 +1677,9 @@
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_550	0x2060
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650	0x2061
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850	0x2062
+#define PCI_DEVICE_ID_SIIG_8S_20x_550	0x2080
+#define PCI_DEVICE_ID_SIIG_8S_20x_650	0x2081
+#define PCI_DEVICE_ID_SIIG_8S_20x_850	0x2082
 #define PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL	0x2050
=20
 #define PCI_VENDOR_ID_RADISYS		0x1331

--WYTEVAkct0FjGQmd--

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4gi+PjHNUy6paxMRAs3HAKCIVI6dN+ITTXu9ZJK4knOunaRWnACg1u5n
Z2qaF93ckVoaUxJK3fjy55c=
=wCKc
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
