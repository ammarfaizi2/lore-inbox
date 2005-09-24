Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVIXReA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVIXReA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVIXReA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:34:00 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:59833 "EHLO
	ptb-relay04.plus.net") by vger.kernel.org with ESMTP
	id S932204AbVIXRd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:33:58 -0400
Date: Sat, 24 Sep 2005 18:33:48 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com
Subject: [PATCH]: Fix ext3_new_inode() failure paths
Message-ID: <20050924173348.GA5104@sigsegv.plus.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org> <20050924121431.GA5530@sigsegv.plus.com> <20050924142825.GA5158@sigsegv.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20050924142825.GA5158@sigsegv.plus.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Fix failure paths in ext3_new_inode() and clean up duplicated code:
 - DQUOT_DROP() is now called in ext3_init_security() failure path.

Signed-off-by: Chris Sykes <chris@sigsegv.plus.com>

diff --git a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c
+++ b/fs/ext3/ialloc.c
@@ -597,27 +597,22 @@ got:
=20
 	ret =3D inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
-		DQUOT_DROP(inode);
 		err =3D -EDQUOT;
-		goto fail2;
+		goto fail_drop;
 	}
+
 	err =3D ext3_init_acl(handle, inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
-  	}
+	if (err)
+		goto fail_free_drop;
+
 	err =3D ext3_init_security(handle,inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail_free_drop;
+
 	err =3D ext3_mark_inode_dirty(handle, inode);
 	if (err) {
 		ext3_std_error(sb, err);
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
+		goto fail_free_drop;
 	}
=20
 	ext3_debug("allocating inode %lu\n", inode->i_ino);
@@ -631,7 +626,11 @@ really_out:
 	brelse(bitmap_bh);
 	return ret;
=20
-fail2:
+fail_free_drop:
+	DQUOT_FREE_INODE(inode);
+
+fail_drop:
+	DQUOT_DROP(inode);
 	inode->i_flags |=3D S_NOQUOTA;
 	inode->i_nlink =3D 0;
 	iput(inode);



--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNY38kElw2FFDgJARAo41AJ4kI33rKmw2kGWep9IOMIQJBxh/LgCeNCfG
WcqYvxTfLPjHVyZ14AojSGw=
=VAZ3
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
