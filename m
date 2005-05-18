Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVERVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVERVOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVERVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:14:18 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:24502 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S262381AbVERVNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:13:21 -0400
Subject: Re: Sync option destroys flash!  Now I'm confused...
From: "Michael H. Warfield" <mhw@wittsend.com>
Reply-To: mhw@wittsend.com
To: linux-os@analogic.com
Cc: linux@horizon.com, lsorense@csclub.uwaterloo.ca,
       Linux kernel <linux-kernel@vger.kernel.org>, mhw@wittsend.com
In-Reply-To: <Pine.LNX.4.61.0505171638560.10811@chaos.analogic.com>
References: <20050517203117.10588.qmail@science.horizon.com>
	 <Pine.LNX.4.61.0505171638560.10811@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XbK8n8MwhgnqJFh7ruA7"
Organization: Thaumaturgy & Speculms Technology
Date: Wed, 18 May 2005 17:08:49 -0400
Message-Id: <1116450529.4384.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XbK8n8MwhgnqJFh7ruA7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

	All right...  Now I'm really confused.

	There are, obviously, some individuals on this list who are a LOT more
knowledgeable about the internal workings of flash, so I'm hoping for a
clear(er) understanding of just WHAT is going on here.

On Tue, 2005-05-17 at 16:43 -0400, Richard B. Johnson wrote:
> On Tue, 17 May 2005 linux@horizon.com wrote:

> >> It can also respond to loosing power during write by getting it's stat=
e
> >> so mixed up the whole card is dead (it identifies but all sectors fail
> >> to read).

> > Gee, that just happened to me!  Well, actually, thanks to Linux's
> > *insistence* on reading the partition table, I haven't managed to
> > get I/O errors on anything bit sectors 0 through 7, but I am quite
> > sure I wasn't writing those sectors when I pulled the plug:

> > hda: read_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: read_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D6, sector=
=3D6
> > hda: read_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: read_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D6, sector=
=3D6
> > hda: read_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: read_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D6, sector=
=3D6
> > hda: read_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: read_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D6, sector=
=3D6
> > ide0: reset: success
> > hda: read_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: read_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D6, sector=
=3D6
> > end_request: I/O error, dev 03:00 (hda), sector 6
> > unable to read partition table
> [SNIPPED...]

> You can "fix" this by writing all sectors. Although the data is lost,
> the flash-RAM isn't. This can (read will) happen if you pull the
> flash-RAM out of its socket with the power ON.

	I'm the original poster and someone in another message remarked about
not having enough details on the damage to the card...  So I just did
some spot checking on the card for some details.

	Block checking with dd bs=3D512 if=3D/dev/sda gave me some indicators...

Blocks 0-7 DOA, hard read errors, 0+0 records in.

Blocks 8-31 would read 8 blocks at a time and then give me an error, but
the next 8 blocks would read fine.  So 24 consecutive blocks SEEMED to
read but strangely.

Blocks 32-39 DOA

Blocks 40-71 would read 8 blocks at a time.

Roughly 1/3 of the blocks seem to be dead in multiples of 8 blocks on 8
block boundries early on.  No real pattern to which ones were dead and
which ones would read 8 and then error.

Once past block 512, huge blocks would be readable but eventually give
me an error.

Dead fields (0 records read) were always multiples of 8 512 byte blocks,
4KBytes falling on an 4K boundry.

Reading with dd bs=3D4096 gave similar results for 4K blocks with skip
count less than 64.  Skip count 64 and greater gave me large swaths that
were readable.  No time did I see a partial record read (indicating a
failure off a 4K boundry).

	Basically, that re-enforced my option that it was block wear-out from
uneven wear leveling when copying that 700 Meg file and beating the
bejesus out of the FAT tables.  Front part of the flash was heavily
damaged with sporatic damage deeper in the flash.

	Now, I saw this message...  Well...  I didn't remove the key when it
was being written to but, what the hell...  The key is dead, I've got
nothing to loose, and it might yield some more information as to the
nature of the failure.  So I copied zeros to the entire key with "dd
if=3D/dev/zero of=3D/dev/sda bs=3D16M".  I'll be a son of a bitch but that =
key
recovered.  I've partitioned it and read the whole damn thing back end
to end and it's perfect.

	Ok...  So, WTF?  It wasn't (AFAICT) due to loss of power or pulling it
while writing.  What was this failure and why did overwriting it fix it?
Did the stick just flaw out all the burned out blocks or did it really
recover the ECC errors?  I'm really baffled now.

	BTW...  I've killed the "sync" option in hal (you just have to create
an XML policy file in the right location to specify that option as false
in all cases) and have been beating the crap out of several other keys
without a single failure.  I'm going to try this key again...

	Thank you very VERY much for this hint to recover the damaged key.
That's a trick I've used for damaged IDE & SCSI hard drives (recover
head drift and soft errors) and I never thought to try it with a flash
key.  I'll be damned if I understand just what has happened at this
point but I really appreciate that trick.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by Dictator Bush.
>                   98.36% of all statistics are fiction.

	Regards,
	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com =20
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--=-XbK8n8MwhgnqJFh7ruA7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQouu4eHJS0bfHdRxAQKlAAP+PdiSt+j8FrXauLTPDhxmSz17S2J9tege
TGDdoSG4hprcVkGmsYhgCpI8THwm9JYd5iUBpDKgrCN6svqQUvvx8LY9oSjDEjcp
pR+r6lll5qU1akhGz8PYNWGQImBsD7q8URV6HsC+hl7uh3Q1UW7ITQYs40JTb4kO
udBn1LqksMY=
=1teB
-----END PGP SIGNATURE-----

--=-XbK8n8MwhgnqJFh7ruA7--

