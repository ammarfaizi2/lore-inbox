Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbULAVQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbULAVQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULAVQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:16:25 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:31229 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261441AbULAVQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:16:13 -0500
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jens Axboe <axboe@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130071638.GC10450@suse.de>
References: <1101763996l.13519l.0l@werewolf.able.es>
	 <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	 <1101765555l.13519l.1l@werewolf.able.es>  <20041130071638.GC10450@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M7PTssM+VTg6OG3tk1o9"
Date: Wed, 01 Dec 2004 23:16:13 +0200
Message-Id: <1101935773.11949.86.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M7PTssM+VTg6OG3tk1o9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-30 at 08:16 +0100, Jens Axboe wrote:
> On Mon, Nov 29 2004, J.A. Magallon wrote:
> > dev=3DATAPI uses ide-scsi interface, through /dev/sgX. And:
> >=20
> > > scsibus: -1 target: -1 lun: -1
> > > Warning: Using ATA Packet interface.
> > > Warning: The related Linux kernel interface code seems to be unmainta=
ined.
> > > Warning: There is absolutely NO DMA, operations thus are slow.
> >=20
> > dev=3DATA uses direct IDE burning. Try that as root. In my box, as root=
:
>=20
> Oh no, not this again... Please check the facts: the ATAPI method uses
> the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> nothing to do with ide-scsi. Period.
>=20
> ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> burning, it's a crippled interface from the CDROM layer that should not
> be used for anything.  scsi-linux-ata.c should be ripped from the
> cdrecord sources, or at least cdrecord should _never_ select that
> transport for 2.6 kernels. For 2.4 you are far better off using
> ide-scsi.
>=20
> > The scan through ATA lasts much less than with ATAPI, and you can burn =
with
> > dev=3DATA:1,0,0 or dev=3D/dev/burner, which is the new recommended way.
>=20
> No! ATAPI is the recommended way.
>=20

Ok, so I am a bit confused here.  We basically have 3 ways to use
cdrecord on linux-2.6 without ide-scsi:

1) cdrecord dev=3D/dev/hdx
2) cdrecord dev=3DATA
3) cdrecord dev=3DATAPI

Now, if I run all three and grep for '^Warning', I get:

-----
 $ cdrecord dev=3D/dev/cdrw -scanbus 2>&1 | grep '^Warning'
Warning: Open by 'devname' is unintentional and not supported.
 $ cdrecord dev=3DATA -scanbus 2>&1 | grep '^Warning'
Warning: Using badly designed ATAPI via /dev/hd* interface.
 $ cdrecord dev=3DATAPI -scanbus 2>&1 | grep '^Warning'
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
 $
-----

Which means:

1) dev=3D/dev/hdx	- Open by 'devname' is unintentional and not supported.
2) dev=3DATA	- Using badly designed ATAPI via /dev/hd* interface.
3) dev=3DATAPI	- Using ATA Packet interface.
                  (And some nice things about it not being maintained and
                   slow)

If I check the source for that, I get:

-----
libscg $ grep "Open by 'devname' is unintentional and not supported." *
scsi-linux-sg.c:                        "Warning: Open by 'devname' is unin=
tentional and not supported.\n");
libscg $ grep 'Using badly designed ATAPI via /dev/hd\* interface.' *
scsi-linux-sg.c:                                "Warning: Using badly desig=
ned ATAPI via /dev/hd* interface.\n");
libscg $ grep 'Using ATA Packet interface.' *
scsi-linux-ata.c:               error("Warning: Using ATA Packet interface.=
\n");
libscg #
-----

Which hopefully (without really checking the source) means each are
implemented in these source files:

1) dev=3D/dev/hdx	- scsi-linux-sg.c
2) dev=3DATA	- scsi-linux-sg.c
3) dev=3DATAPI	- scsi-linux-ata.c

So if I take note of you comment above about scsi-linux-ata.c (or actually
give a fart about Jorg's warning about unmaintained and slow), should ATA
rather than ATAPI not be the recommended way??

Also, how about having the kernel print a warning when the depreciated
interface (ATAPI??) is used ?=20


Thanks,

--=20
Martin Schlemmer


--=-M7PTssM+VTg6OG3tk1o9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBrjSdqburzKaJYLYRAn21AJ9neiUifhUYJ54FSFb+qJ/OV0vdowCgkHTz
fhrEAhpnT//O5Du0W9qwASs=
=OOmu
-----END PGP SIGNATURE-----

--=-M7PTssM+VTg6OG3tk1o9--

