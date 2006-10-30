Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWJ3TjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWJ3TjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWJ3TjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:39:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:5010 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S1161243AbWJ3TjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:39:14 -0500
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3
	and breaks yaird.
From: Christophe Saout <christophe@saout.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org,
       Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
       dm-crypt@saout.de, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
References: <20061030151930.GQ27337@susi>
	 <20061030184331.GY3928@agk.surrey.redhat.com>
	 <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OrTDVc9+b74E8RmmEFWe"
Date: Mon, 30 Oct 2006 20:39:08 +0100
Message-Id: <1162237148.9415.7.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OrTDVc9+b74E8RmmEFWe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 30.10.2006, 11:00 -0800 schrieb Linus Torvalds:
> On Mon, 30 Oct 2006, Alasdair G Kergon wrote:
> > =20
> > It cannot have been intentional as there was no mention of the change t=
o the
> > userspace interface in the git changelog (and the interface version num=
ber
> > was not changed).
> >=20
> > A new patch is needed to revert the part of the patch that changed the
> > userspace interface.
> >=20
> > Please don't forget to copy in the appropriate maintainers when you sen=
d
> > messages like this one:
> >   http://marc.theaimsgroup.com/?l=3Dlinux-netdev&m=3D115547174417490&w=
=3D2
> > so they can provide acks:-)
>=20
> Yeah.
>=20
> Herbert, the breakage _seems_ to be due to the STATUSTYPE_TABLE case=20
> change:
>=20
> -		cipher =3D crypto_tfm_alg_name(cc->tfm);
> +		cipher =3D crypto_blkcipher_name(cc->tfm);
>=20
> which effectively changes "aes" into "cbc(aes)", which is wrong, since we=
=20
> show the chainmode separately.
>=20
> Please, somebody who knows this area, send me a fix,
>=20
> (maybe something like this trivial one? Totally untested, but it would=20
> seem to be the sane approach)

Yes, this works just fine. It can also be cleaned up a little further as
the temporary variables are unnecessary at that point.

----

Fix dm-crypt after the block cipher API changes to correctly return the
backwards compatible cipher-chainmode[-ivmode] format for "dmsetup
table".

Signed-off-by: Christophe Saout <christophe@saout.de>

diff linux-2.6.19-rc3.orig/drivers/md/dm-crypt.c linux-2.6.19-rc3/drivers/m=
d/dm-crypt.c
--- linux-2.6.19-rc3.orig/drivers/md/dm-crypt.c	2006-10-26 13:17:58.0000000=
00 +0200
+++ linux-2.6.19-rc3/drivers/md/dm-crypt.c	2006-10-30 20:26:37.000000000 +0=
100
@@ -915,8 +915,6 @@ static int crypt_status(struct dm_target
 			char *result, unsigned int maxlen)
 {
 	struct crypt_config *cc =3D (struct crypt_config *) ti->private;
-	const char *cipher;
-	const char *chainmode =3D NULL;
 	unsigned int sz =3D 0;
=20
 	switch (type) {
@@ -925,14 +923,11 @@ static int crypt_status(struct dm_target
 		break;
=20
 	case STATUSTYPE_TABLE:
-		cipher =3D crypto_blkcipher_name(cc->tfm);
-
-		chainmode =3D cc->chainmode;
-
 		if (cc->iv_mode)
-			DMEMIT("%s-%s-%s ", cipher, chainmode, cc->iv_mode);
+			DMEMIT("%s-%s-%s ", cc->cipher, cc->chainmode,
+			       cc->iv_mode);
 		else
-			DMEMIT("%s-%s ", cipher, chainmode);
+			DMEMIT("%s-%s ", cc->cipher, cc->chainmode);
=20
 		if (cc->key_size > 0) {
 			if ((maxlen - sz) < ((cc->key_size << 1) + 1))


--=-OrTDVc9+b74E8RmmEFWe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRlTbZCYBcts5dM0RAq1pAJ9sNRVH7s9ecH6WjwpQ9uwUe0ubJQCcDMTk
5bDZUCEQeU7V75FdfpNof/g=
=sejZ
-----END PGP SIGNATURE-----

--=-OrTDVc9+b74E8RmmEFWe--

