Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUKUPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUKUPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUKUPwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:52:36 -0500
Received: from macedonia.mhl.tuc.gr ([147.27.3.60]:23270 "HELO
	macedonia.mhl.tuc.gr") by vger.kernel.org with SMTP id S261737AbUKUPuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:50:01 -0500
Subject: PCI resource allocation problem in 2.6.8
From: Dimitris Lampridis <labis@mhl.tuc.gr>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CchaRRivQh2phM6bSkqs"
Date: Sun, 21 Nov 2004 14:57:27 +0000
Message-Id: <1101049047.3201.18.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CchaRRivQh2phM6bSkqs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
I'm writing a driver for a PCI-based USB controller. The work is almost
done but a few days ago something very ugly happened. I've tried to
pinpoint the problem but everything is so simple and clear to be
wrong... I really hope that someone can help me!

OK, here's the problem:
I'm using kernel 2.6.8 on an i386 arch. I want to allocate region 2 of
my PCI board. Here's the output of lspci:

0000:00:0e.0 Bridge: PLX Technology, Inc.: Unknown device 5406 (rev 0b)
        Subsystem: PLX Technology, Inc.: Unknown device 9054
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at df100000 (32-bit, non-prefetchable)
[size=3D256]
        Region 1: I/O ports at e400 [size=3D256]
        Region 2: I/O ports at e800 [size=3D256]
        Region 3: Memory at df000000 (32-bit, non-prefetchable)
[size=3D1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [48] #06 [0000]
        Capabilities: [4c] Vital Product Data

As you can see, region 2 begins at e800 and extends up to e8ff.

When I try to claim the region, I get wrong start-end-length numbers.
I've written something simple to demonstrate this fact:

for(pci_region=3D0; pci_region < PCI_ROM_RESOURCE; pci_region++){ =20
	resource_start =3D pci_resource_start (dev, pci_region);
	resource_end =3D pci_resource_end (dev,pci_region);
	printk (KERN_DEBUG "region:%d start:%lx, end:%lx -  ", pci_region,
resource_start, resource_end);
	len =3D pci_resource_len (dev, pci_region);
	printk(KERN_DEBUG "length:%lx\n", len);
}

Where "dev" is a pointer to a pci device of course.
So here's what I get by running this code:

Nov 21 16:28:56 naousa kernel: PCI: Found IRQ 9 for device 0000:00:0e.0
Nov 21 16:28:56 naousa kernel: region:0	start:0, end:0 -  <7>length:0
Nov 21 16:28:56 naousa kernel: region:1	start:df1000ff, end:200 -
<7>length:20f00102
Nov 21 16:28:56 naousa kernel: region:2	start:e4ff, end:101 -
<7>length:ffff1c03
Nov 21 16:28:56 naousa kernel: region:3	start:e8ff, end:101 -
<7>length:ffff1803
Nov 21 16:28:56 naousa kernel: region:4	start:df0fffff, end:200 -
<7>length:20f00202
Nov 21 16:28:56 naousa kernel: region:5^Istart:0, end:0 -  <7>length:0

As you can see, what "start" claims to be is in reality the end of each
region, and "end", "length" are nonsense...

Any ideas? Is this something typical???
I would appreciate any help, please CC me personally as I'm not yet
subscribed to the list, or find me at the linux-usb-devel list.

Thanx in advance,
--=20
Dimitris Lampridis <labis@mhl.tuc.gr>

--=-CchaRRivQh2phM6bSkqs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBoKzVgMArLfy6HHMRAucDAKCUS+xJJFmqvW5kc2ae4Dq26EPmaQCeKcaD
2wyBMCPWEB5eB3qbTz8B8Zk=
=v7Kb
-----END PGP SIGNATURE-----

--=-CchaRRivQh2phM6bSkqs--

