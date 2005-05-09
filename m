Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVEIJYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVEIJYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVEIJYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:24:36 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:11481 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261154AbVEIJYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:24:24 -0400
Date: Mon, 9 May 2005 03:24:17 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>
Cc: sct@redhat.com, akpm@osdl.org, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
Message-ID: <20050509092417.GF25935@schnapps.adilger.int>
Mail-Followup-To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
	sct@redhat.com, akpm@osdl.org, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0505091032000.22820-100000@jms.roxen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0505091032000.22820-100000@jms.roxen.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 09, 2005  10:57 +0200, Henrik Grubbstr=F6m wrote:
> The 2.6.10 ext3_get_parent attempts to use ext3_find_entry to look up the
> entry "..", which fails for dx directories since ".." is not present in
> the directory hash table. The patch below solves this by looking up the
> dotdot entry in the dx_root block.
>=20
> Typical symptoms of the above bug are intermittent claims by nfsd that
> files or directories are missing on exported ext3 filesystems.
>=20
> cf https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D150759
> and https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D144556
>=20
> Signed-off-by: Henrik Grubbstr=F6m <grubba@grubba.org>

ext3_get_parent() is IMHO the wrong place to fix this bug as it introduces
a lot of internals from htree into that function.  Instead, I think this
should be fixed in ext3_find_entry() as in the below patch.  This has the
added advantage that it works for any callers of ext3_find_entry() and not
just ext3_lookup_parent().

I thought I submitted this patch to l-k at one point, but now I can't find
any mention of that in the archives...

Signed-off-by: Andreas Diler <adilger@clusterfs.com>

--- linux-2.6.orig/fs/ext3/namei.c	2005-04-04 05:06:46.000000000 -0600
+++ linux-2.6/fs/ext3/namei.c	2005-04-04 05:09:18.000000000 -0600
@@ -926,8 +926,16 @@
 	struct inode *dir =3D dentry->d_parent->d_inode;
=20
 	sb =3D dir->i_sb;
-	if (!(frame =3D dx_probe(dentry, NULL, &hinfo, frames, err)))
-		return NULL;
+	/* NFS may look up ".." - look at dx_root directory block */
+	if (namelen > 2 || name[0] !=3D '.'||(name[1] !=3D '.' && name[1] !=3D '\=
0')){
+		if (!(frame =3D dx_probe(dentry, NULL, &hinfo, frames, err)))
+			return NULL;
+	} else {
+		frame =3D frames;
+		frame->bh =3D NULL;			/* for dx_release() */
+		frame->at =3D (struct dx_entry *)frames;	/* hack for zero entry*/
+		dx_set_block(frame->at, 0);		/* dx_root block is 0 */
+	}
 	hash =3D hinfo.hash;
 	do {
 		block =3D dx_get_block(frame->at);

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCfyxBpIg59Q01vtYRAnL6AKCHxmloMEqmypKmYYbpqGZZrofZoACcCrqm
fp/+z3zHqUaYqvXZ8YiIVXg=
=IljN
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
