Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUF1RxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUF1RxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUF1RxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:53:13 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:43909 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265100AbUF1RxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:53:07 -0400
Date: Mon, 28 Jun 2004 11:53:05 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Message-ID: <20040628175305.GG15166@schnapps.adilger.int>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1088230193.9825981cgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <1088230193.9825981cgoldwyn_r@myrealbox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 26, 2004  11:39 +0530, Goldwyn Rodrigues wrote:
> I am using i386 architecture.
>=20
> > If we started using larger blocksizes for systems that have larger than
> > 4kB pages (i.e. not i386) this would become an issue.  At some point
> > having giant files w/o extents is pointless (performance is too bad),
> > so we could also put the high blocks count in as part of the extent data
> > (e.g. i_blocks[14]) since the format would be gratuitously incompatible
> > anyways.
>=20
> I din't quite understand this point. Do you mean to say that we keep such
> data elsewhere if required, and then read such data only for large system=
s.
> As in, do another block read?

No, my point was that on i386 systems there is also a limit at 4TB so
your patch will only serve to double the maximum file size on such
systems.  On non-i386 systems this patch makes somewhat more sense,
but even so it is very inefficient to have enormous files allocating
a billion blocks or even more at larger block sizes.

On i386 we are limited to 4kB pages and this means after we fill the
triple indirect block we can't grow any larger (4096 / 4) ^ 3 * 4096 =3D
4TB.  However, on ia64 and other 64-bit platforms that have larger page
sizes we can use larger blocks for the filesystem (up to 64kB) and this
increases the triple indirect limit a lot (65536 / 4) ^ 3 * 65536 =3D 256PB
=3D 58 bits, at the sake of no longer being mountable on i386 machines.

I think that to have "useful" growth in file sizes we need to take a
hard look at the extents code already written by Alex.  Even with that
we need to be able to store a blocks count > 2^32 so this work isn't
incompatible with that, but if it takes 30 minutes to unlink a giant
file with a billion blocks I don't think just removing the i_blocks
limit will have helped us very much by itself.

Yes, the extent code is incompatible with the current layout (as is this
change), but if we add at least read support (write support separately
selectable if there is some objection to the incompatible change) for
extents to 2.6 then it can become a full-fledged member of ext3 in the
2.8 kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA4FsBpIg59Q01vtYRAuj3AJ9Ix+a7XXe87OippQirvn12dFNNUQCfYmQd
xjs48Bl/WIrn8bTcC2ICJgs=
=DNnV
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
