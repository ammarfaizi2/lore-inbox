Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVIXPrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVIXPrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVIXPrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:47:35 -0400
Received: from fuzznuts.plus.net ([212.159.14.133]:35049 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S932161AbVIXPre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:47:34 -0400
Date: Sat, 24 Sep 2005 16:47:23 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Subject: [PATCH]: Fix ext2_new_inode() failure paths
Message-ID: <20050924154723.GA5396@sigsegv.plus.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org> <20050924121431.GA5530@sigsegv.plus.com> <20050924142825.GA5158@sigsegv.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20050924142825.GA5158@sigsegv.plus.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Fix failure paths in ext2_new_inode() and clean up duplicated code:
 - DQUOT_DROP() is now called in ext2_init_security() failure path.

Signed-off-by: Chris Sykes <chris@sigsegv.plus.com>

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -605,27 +605,28 @@ got:
 	insert_inode_hash(inode);
=20
 	if (DQUOT_ALLOC_INODE(inode)) {
-		DQUOT_DROP(inode);
 		err =3D -ENOSPC;
-		goto fail2;
+		goto fail_drop;
 	}
+
 	err =3D ext2_init_acl(inode, dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		DQUOT_DROP(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail_free_drop;
+
 	err =3D ext2_init_security(inode,dir);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
+	if (err)
+		goto fail_free_drop;
+
 	mark_inode_dirty(inode);
 	ext2_debug("allocating inode %lu\n", inode->i_ino);
 	ext2_preread_inode(inode);
 	return inode;
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

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNXULkElw2FFDgJARAoqDAJsH4XrpovtanNYA7qtOa67a/J1f4gCgyVU8
YHvoG9YWN34n1iOLpe2YmJI=
=LV8b
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
