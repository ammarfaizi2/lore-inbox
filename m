Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTAQTRT>; Fri, 17 Jan 2003 14:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTAQTRT>; Fri, 17 Jan 2003 14:17:19 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:37639 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267637AbTAQTQw>;
	Fri, 17 Jan 2003 14:16:52 -0500
Date: Fri, 17 Jan 2003 20:25:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: eepro100 - 802.1q - mtu size
Message-ID: <20030117192542.GA2515@paradigm.rfc822.org>
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20030117162818.GA1074@gtf.org>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2003 at 11:28:18AM -0500, Jeff Garzik wrote:
> Regardless, people still use eepro100, so I would still like to get
> eepro100 doing VLAN.
>=20
> The reason why the patch was not accepted is that it changes one magic
> number to another magic number, and without chipset docs, I had no idea
> what either magic number really meant.

I did the basic decoding of the config block - The result from looking
at the gdb output is the same except the IP ARP Filter basic address
which is now the documentations recommended default value and some
mandatory bits which are filled.

I also set the LONGRCV option which enables to use VLANs.

I tried this patch which is against 2.4.20 with IPv4, IPv6, 802.1q and
DHCP so i'd say full feature test ;). I did not try 82557 which
might need different initialization as some bits are unused but that
problem persists from before this change.



--- drivers/net/eepro100.c-vanilla	Fri Jan 17 20:18:17 2003
+++ drivers/net/eepro100.c	Fri Jan 17 20:19:39 2003
@@ -496,19 +496,66 @@
 #endif
 };
=20
-/* The parameters for a CmdConfigure operation.
-   There are so many options that it would be difficult to document each b=
it.
-   We mostly use the default or recommended settings. */
-static const char i82557_config_cmd[CONFIG_DATA_SIZE] =3D {
-	22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=3DUse MII  0=3DUse AUI */
-	0, 0x2E, 0,  0x60, 0,
-	0xf2, 0x48,   0, 0x40, 0xf2, 0x80, 		/* 0x40=3DForce full-duplex */
-	0x3f, 0x05, };
+#define i55x_CB1_TXFIFO_LIMIT(x)	((x)<<4)
+#define i55x_CB1_RXFIFO_LIMIT(x)	((x)&0xf)
+
+#define i55x_CB3_MWIENABLE		(1<<0)
+
+#define i55x_CB6_EXTSTATCOUNT		(1<<5)
+#define i55x_CB6_MANDBITS		(1<<1)
+
+#define i55x_CB7_DISCARDSHORT		(1<<0)
+#define	i55x_CB7_UNDERRUNRETRY(x)	((x)<<1)
+
+#define i557_CB8_USEMII			(1<<0)
+#define i558_CB8_MANDBITS		i557_CB8_USEMII
+
+#define i55x_CB10_MANDBITS		(3<<1)
+#define i55x_CB10_PREAMBLELEN(x)	((x&3)<<4)
+#define i55x_CB10_NSAI			(1<<3)
+
+#define i55x_CB12_INTERFRAMESPACE(x)	((x)<<4)
+
+#define i558_CB15_MANDBITS		(1<<3|1<<6)
+#define i559_CB16_CRC16			(1<<5)
+
+#define i558_CB18_MANDBITS		(1<<7)
+#define i558_CB18_FCTHRESH(x)		((x&7)<<4)
+#define i558_CB18_LONGRCV		(1<<3)
+#define i55x_CB18_PAD			(1<<1)
+
+#define i558_CB19_TXFC			(1<<2)
+#define i558_CB19_AUTOFDX		(1<<7)
+
+#define i558_CB20_PRIFCLOC		(1<<5)
+#define i558_CB20_MANDBITS		(0x1f)
+
+#define i558_CB21_MANDBITS		(0x05)
+
 static const char i82558_config_cmd[CONFIG_DATA_SIZE] =3D {
-	22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=3DUse MII  0=3DUse AUI */
-	0, 0x2E, 0,  0x60, 0x08, 0x88,
-	0x68, 0, 0x40, 0xf2, 0x84,		/* Disable FC */
-	0x31, 0x05, };
+	CONFIG_DATA_SIZE,			=09
+	i55x_CB1_TXFIFO_LIMIT(0)|i55x_CB1_RXFIFO_LIMIT(8),=09
+	0,	=09
+	i55x_CB3_MWIENABLE,
+	0,		=09
+	0,			=09
+	i55x_CB6_EXTSTATCOUNT|i55x_CB6_MANDBITS,
+	i55x_CB7_UNDERRUNRETRY(1)|i55x_CB7_DISCARDSHORT,
+	i558_CB8_MANDBITS,			=09
+	0,
+	i55x_CB10_MANDBITS|i55x_CB10_NSAI|i55x_CB10_PREAMBLELEN(2),
+	0,
+	i55x_CB12_INTERFRAMESPACE(6),
+	0x00,							/* cb 13 - ARP Filter IP Address Low */
+	0xf2,							/* cb 14 - ARP Filter IP Address High */
+	i558_CB15_MANDBITS|i559_CB16_CRC16,		=09
+	0,							/* cb 16 - FC Delay - LSB */
+	0x40,							/* cb 17 - FC Delay - MSB */
+	i558_CB18_MANDBITS|i558_CB18_FCTHRESH(7)|i558_CB18_LONGRCV|i55x_CB18_PAD,
+	i558_CB19_TXFC|i558_CB19_AUTOFDX,	=09
+	i558_CB20_PRIFCLOC|i558_CB20_MANDBITS,
+	i558_CB21_MANDBITS,
+	};
=20
 /* PHY media interface chips. */
 static const char *phys[] =3D {

--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE+KFi2Uaz2rXW+gJcRAo+SAJ9qjM5WAq9RGxrHVsZALQPqn2H90ACWOIYf
mB/dbT2H7tITukJnCP9R/w==
=Shzu
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
