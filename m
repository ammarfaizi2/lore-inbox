Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270671AbTHJVDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTHJVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:03:04 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:32130
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S270671AbTHJVDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:03:00 -0400
Date: Sun, 10 Aug 2003 23:03:06 +0200
To: Christophe Saout <christophe@saout.de>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
Message-ID: <20030810210306.GA2235@ghanima.endorphin.org>
References: <20030810023606.GA15356@ghanima.endorphin.org> <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr> <1060525667.14835.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1060525667.14835.4.camel@chtephan.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1061413386.7d8e@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2003 at 04:27:47PM +0200, Christophe Saout wrote:
> Am So, 2003-08-10 um 16.10 schrieb Pascal Brisset:
>=20
> > > In loop_transfer_bio the initial vector has been computed only once. =
For any
> > > situation where more than one bio_vec is present the initial vector w=
ill be
> > > wrong. Here is the trivial but important fix.=20
> >=20
> > Looks good, but:
> > - I doubt this could explain the alteration pattern (1 byte every 512).
> > - Corruption also occured with cipher_null (which ignores the IV).

I could not find a way to explain that strange pattern either. With CBC it
would have to result in total mess if just one bit is flipped. Probably
read/writing is handled with different sized bio_vec.. no idea.

cipher_null does not ignore the IV. The CBC processing takes place no matter
what mapping function (aka electronic codebook) is used. The fact that
cipher_null is an identity mapping does not stop CBC.=20

> I personally think that the only way to get things right is to do
> encryption sector by sector (not bvec by bvec) since every sector can
> have its own iv.

That's done anyway. Per convention the transformation module is allowed to
increase the IV every 512 bytes. The IV parameter is only the initial
initial vector ;).=20

> I've implemented a crypto target for device-mapper that does this and it
> doesn't seem to suffer from these corruption problems:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D105967481007242&w=3D2 =
and a
> slightly updated patch: http://www.saout.de/misc/dm-crypt.diff

Nice! It's definitely a feature worth merging. loop.c used to be the place
where to put this stuff, but why not replace it by newer in-kernel
techniques?

> Should I repost the patch (inline this time) with an additional [PATCH]
> or am I being annoying? Joe Thornber (the dm maintainer) would like to
> see this patch merged.

If you can't get attention for your patch, try to convince someone "more
important". DM maintainer is a good place to start :)

Regards, Clemens

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/NrMKW7sr9DEJLk4RAvFhAJ9hv3LyqHIgwxmpQ68emwshkWejewCeKOru
/GAoHyBvRFjS3dxzYnd2uKc=
=ZNOk
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
