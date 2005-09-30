Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVI3JeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVI3JeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVI3JeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:34:11 -0400
Received: from joel.tallye.com ([216.99.199.78]:18874 "EHLO hosea.tallye.com")
	by vger.kernel.org with ESMTP id S1751202AbVI3JeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:34:11 -0400
Date: Fri, 30 Sep 2005 02:33:55 -0700
From: "Loren M. Lang" <lorenl@alzatex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Loren M. Lang" <lorenl@alzatex.com>, linux-kernel@vger.kernel.org
Subject: Re: RocketPoint 1520 [hpt366] fails clock stabilization
Message-ID: <20050930093355.GB22233@alzatex.com>
References: <20050929103309.GA12361@alzatex.com> <1128036611.9290.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <1128036611.9290.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
X-GPG-Fingerprint: B3B9 D669 69C9 09EC 1BCD  835A FAF3 7A46 E4A3 280C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2005 at 12:30:11AM +0100, Alan Cox wrote:
> On Iau, 2005-09-29 at 03:33 -0700, Loren M. Lang wrote:
> > Please CC me as I'm not on the list.
> >=20
> > I just purchased a HighPoint Rocket 1520 SATA controller.  There seems
> > to be no libata driver (yet), but there is an ide driver, hpt366.  When
>=20
> Is this 302 or 302N based (what does lspci -vxx say about it ?)

$ lspci -vxx
0000:02:0c.0 RAID bus controller: Triones Technologies, Inc. HPT372A
(rev 02)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
        I/O ports at dfe0 [size=3Dfeaa0000]
        I/O ports at dfac [size=3D4]
        I/O ports at dfa0 [size=3D8]
        I/O ports at dfa8 [size=3D4]
        I/O ports at d400 [size=3D256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: <available only to root>
00: 03 11 05 00 05 01 30 02 02 00 04 01 04 40 00 00
10: e1 df 00 00 ad df 00 00 a1 df 00 00 a9 df 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 aa fe 60 00 00 00 00 00 00 00 0a 01 08 08

I booted FreeBSD 6.0 and it seemed to reconize the card and attached
hard drive ok.  In the dmesg for freebsd, it mentioned 372N, if that
means anything.  There is a patch, I discovered, which disables the
driver from marking a 372A chipset from being detected as a 372N chip.
When I applied the patch, it finally detected the sata driver ok and my
new sata drive as well.  So my current hpt366 driver is as patched
below.  I added a check for a NULL drvdata to prevent the driver from
seg faulting when it failed to detect my chip, and I disabled a check
for the 372N chipset.

--- drivers/ide/pci/hpt366.c.orig       2005-09-29 01:00:12.000000000
-0700
+++ drivers/ide/pci/hpt366.c    2005-09-30 02:28:47.000000000 -0700
@@ -1168,8 +1168,10 @@ static int __devinit init_hpt37x(struct=20
                did =3D inb(dmabase + 0x22);
                rid =3D inb(dmabase + 0x28);
=20
+#if 0
                if((did =3D=3D 4 && rid =3D=3D 6) || (did =3D=3D 5 && rid >=
 1))
                        is_372n =3D 1;
+#endif
        }
=20
        /*
@@ -1310,6 +1312,10 @@ static int __devinit init_hpt37x(struct=20
                                goto init_hpt37X_done;
                        }
                }
+               if (!pci_get_drvdata(dev)) {
+                       printk("No Clock Stabilization!!!");
+                       return -1;
+               }
 pll_recal:
                if (adjust & 1)
                        pll -=3D (adjust >> 1);


--=20
I sense much NT in you.
NT leads to Bluescreen.
Bluescreen leads to downtime.
Downtime leads to suffering.
NT is the path to the darkside.
Powerful Unix is.

Public Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
Fingerprint: CEE1 AAE2 F66C 59B5 34CA  C415 6D35 E847 0118 A3D2
=20

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFDPQaDbTXoRwEYo9IRAsgoAJ9q5YSZ5llsLxEEzWKIZwG2/PwXvgCff9J+
RT8WxEuspqArVE36bt8fIac=
=DthR
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
