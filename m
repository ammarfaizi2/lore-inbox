Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUHQQAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUHQQAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQQAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:00:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:35306 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268319AbUHQP70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:59:26 -0400
Date: Tue, 17 Aug 2004 17:59:18 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] bio_uncopy_user mem leak
Message-ID: <20040817155918.GA5312@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-20-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

When using bounce buffers for SG_IO commands with unaligned=20
buffers in blk_rq_map_user(), we should free the pages from
blk_rq_unmap_user() which calls bio_uncopy_user() for the=20
non-BIO_USER_MAPPED case. That function failed to free the
pages for write requests.

So we leaked pages and you machine would go OOM. Rebooting=20
helped ;-)

This bug was triggered by writing audio CDs (but not on data=20
CDs), as the audio frames are not aligned well (2352 bytes),
so the user pages don't just get mapped.

Bug was reported by Mathias Homan and debugged by Chris Mason + me.
(Jens is away.)

Signed-off-by: Kurt Garloff <garloff@suse.de>

 bio.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

--- linux-2.6.8.x86/fs/bio.c.orig	2004-08-14 07:37:15.000000000 +0200
+++ linux-2.6.8.x86/fs/bio.c	2004-08-17 17:41:52.022012902 +0200
@@ -388,20 +388,17 @@ int bio_uncopy_user(struct bio *bio)
 	struct bio_vec *bvec;
 	int i, ret =3D 0;
=20
-	if (bio_data_dir(bio) =3D=3D READ) {
-		char *uaddr =3D bio->bi_private;
-
-		__bio_for_each_segment(bvec, bio, i, 0) {
-			char *addr =3D page_address(bvec->bv_page);
-
-			if (!ret && copy_to_user(uaddr, addr, bvec->bv_len))
-				ret =3D -EFAULT;
+	char *uaddr =3D bio->bi_private;
+=09
+	__bio_for_each_segment(bvec, bio, i, 0) {
+		char *addr =3D page_address(bvec->bv_page);
+		if (bio_data_dir(bio) =3D=3D READ && !ret &&=20
+		    copy_to_user(uaddr, addr, bvec->bv_len))
+			ret =3D -EFAULT;
=20
-			__free_page(bvec->bv_page);
-			uaddr +=3D bvec->bv_len;
-		}
+		__free_page(bvec->bv_page);
+		uaddr +=3D bvec->bv_len;
 	}
-
 	bio_put(bio);
 	return ret;
 }

--=20
Kurt Garloff, Director SUSE Labs, Novell

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBIitWxmLh6hyYd04RAj1AAJ0YITtm16Dq2XwIoloqKYD6hWCMhgCghxmn
pn5Aoa49dmvbESDyMPTiZ3c=
=qlWb
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
