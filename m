Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKEWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKEWiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKEWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:38:12 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:4763 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261224AbUKEWhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:37:51 -0500
Subject: Re: support of older compilers [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
	 <20041103233029.GA16982@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
	 <20041105014146.GA7397@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
	 <20041105195045.GA16766@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aaYfq9EkTpmoBGh1dRE/"
Date: Sat, 06 Nov 2004 00:37:26 +0200
Message-Id: <1099694246.4450.11.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aaYfq9EkTpmoBGh1dRE/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-05 at 22:59 +0100, Grzegorz Kulewski wrote:
> > The kernel does do more these days than it did in '95. But 6 times more=
? I
> > dunno..
>=20
> Can't we remove ramfs for a good start? Everyone should use tmpfs instead=
=20
> and some stupid distributions (I will not tell their names) try to mount=20
> ramfs on /dev (udev) and that leads to very stupid panic if you will=20
> write for example:
>=20
> dd if=3D/dev/evms/sda5 of=3D/dev/sda17 bs=3D1024
>=20
> instead of "of=3D/dev/evms/sda17".
>=20
> Explanation (if anybody needs one):
> Kernel can't create more partition devices than 15 for SCSI and SATA disk=
s=20
> because of lack of minor numbers. So I am using evms to create these=20
> devices. So I should use /dev/evms/sda* for these partitions. And if I=20
> will not remember to do so then I will get oom panic very shortly because=
=20
> ramfs is not limited (in contrary to tmpfs).
>=20
> And this kind of stupid mistake can happen. It happened to me 3 times in =
a=20
> row before I started to debug what is wrong with this kernel.
>=20
> [BTW. Does somebody know how to tell the kernel that I do not want=20
> /dev/sda[0-9]* files (but I do want /dev/hda files) created =3D=3D I do n=
ot=20
> want kernel partition driver to touch this particular device?]
>=20

So basically /dev/sda* have major of scsi, and /dev/evms/sda* have major
of evms, and you end up using the wrong nodes?  This sounds more like
a udev-ruleset problem (not something that will be easy to get right
with a generic one I imagine), rather than anything remotely to do with
ramfs.  If you changed the scripts to use tmpfs rather, you would have
gotten the same result.

Now I do not know evms, so you are on your own there, but here is my
rules for dm and a similar issue:

---------
nosferatu linux-2.6-bk # cat /etc/udev/rules.d/30-sda.rules
KERNEL=3D"sda[0-9]*", NAME=3D""
nosferatu linux-2.6-bk # cat /etc/udev/rules.d/40-dm.rules
KERNEL=3D"dm-[0-9]*", PROGRAM=3D"/sbin/devmap_name %M %m", NAME=3D"mapper/%=
c", SYMLINK=3D"%c"
nosferatu linux-2.6-bk #

---------

(note that they should be before all the others if you only have one
rule file)

So basically for the real scsi devices (you could add a BUS=3D"scsi" to
make sure I guess) matching 'sda[0-9]*' no node will be created, and I
get my /dev/mapper/* nodes, with a symlink in /dev/ making things
easier.

you could have a rule catching all evms devices, and then add
the /dev/sda* symlinks, perhaps like so:

--------
KERNEL=3D"evms/sda[0-9]*", SYMLINK=3D"sda%n"
--------

Note that I do not know if a rule was needed to get the nodes in
/dev/evms/ in the first place (due to my admitted lack of evms knowledge
above), so you might have to modify an existing rule ...

--=20
Martin Schlemmer


--=-aaYfq9EkTpmoBGh1dRE/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBjACmqburzKaJYLYRAt8oAKCJTxI2E5tEzyysrq9Jx8pFP6gWTgCfSOom
LA7Te1AIJdATUjnYVUSLTsc=
=Pa9z
-----END PGP SIGNATURE-----

--=-aaYfq9EkTpmoBGh1dRE/--

