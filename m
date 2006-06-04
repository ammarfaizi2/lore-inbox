Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932198AbWFDKNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFDKNj (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWFDKNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:13:39 -0400
Received: from ns3.mountaincable.net ([24.215.0.13]:62375 "EHLO
	ns3.mountaincable.net") by vger.kernel.org with ESMTP
	id S932198AbWFDKNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:13:38 -0400
Subject: pci_restore_state
From: Ryan Lortie <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Ben Collins <bcollins@ubuntu.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lGd9xKqbbEIOhU+JrQFt"
Date: Sun, 04 Jun 2006 06:13:30 -0400
Message-Id: <1149416010.30767.14.camel@moonpix.desrt.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lGd9xKqbbEIOhU+JrQFt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello.

Currently pci_restore_state() (drivers/pci/pci.c) restores the PCI state
by copying in the saved PCI configuration space, a dword at a time,
starting from 0 up to 15.

This causes a crash when my Macbook resumes from sleep (specifically,
when restoring the configuration space of the PCI bridge).

Reading the PCI specification, the register at dword 1 (ie: bytes 4-7)
is split half and half between status and command words.  The command
word effectively controls the way which the PCI device interacts with
the system.  If it is 0, the device is logically disconnected from the
bus (PCI Local Bus Specification Revision 2.2, 6.2.2 "Device
Control"). =20

When a device first powers up, the command register value is normally
zero (and is zero in my specific case).

The problem with the way that the PCI state is currently restored is
that the write to the command register logically reconnects the device
to the bus before the rest of the configuration space has been filled
in.

My Macbook crashes on resume.

If I reverse the for loop to start from 15 and count down to 0, then the
majority of the configuration space is filled in _before_ the command
word is modified.  No crash.

About dword 0 -- this dword contains only the vendor and product ID
codes which will always be set by the device (as far as I know) so it's
not a problem to not have written these before restoring the value of
the command register.  I'm not sure they even ever need to be written.

I am essentially requesting that this piece of code be changed in the
stock kernel as I changed it (described above).  It makes sleep work on
my Macbook and may fix some others too (and/or make more reliable some
which already work).

Cheers

--=-lGd9xKqbbEIOhU+JrQFt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQG5AwUARIKySZ96IjKvqm/2AQIrIQ0cCqP6jIEGUUyBcgj9lL4l5RRfKQUqxatS
a7xpeXQXeSNfrt9O4mm97LkHI/v0PynDWPaSLRZc48uY3gq7JRwz+PtfomrlXPBl
ILQADoB2UhAqdEE/bVPTgcfxPaONXdXYP6Hyo/T3D44Go7Wbh/Nza9OuYKq7ltKA
6D4wgiU1BnUhVUUBRzQBDb5CWjlKqt1Mrs42ipSLKfyQI4WaLG2M90+ho6mdtclP
W6En3SJ84VyuueIbjO/bq+9fOCL1DNZly7NMv4KnkWBBdru85mMnwoKhf0OqE9AP
2pWyxXXFuHerxtIiFIPvALLPz80Uv7t9eXz8ufXNRKBiCxDcfSqf3QAOuY9NWrgz
Gc7mrc3HOhieAr0D0Y4VT9xj2p7sO1P0Ey3gAehQXlBaPOIE0BR7RikNeJJYj9Ee
gmEGZ+YlBMi0ARtdxZNYRzSgE5SCb5mnZb87hwE3eJCdY5k6czvopiXNwx5j/LdF
M9MLWTcmioAAzjEmapzIWJigmGVZsrE8395IjExVzfORTgZcTbNlqIMcPKRTb4Tb
rFXPMgwQ9tkJS9Ks
=lXgV
-----END PGP SIGNATURE-----

--=-lGd9xKqbbEIOhU+JrQFt--

