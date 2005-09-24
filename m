Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVIXO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVIXO22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVIXO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 10:28:28 -0400
Received: from fuzznuts.plus.net ([212.159.14.133]:28880 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S932175AbVIXO21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 10:28:27 -0400
Date: Sat, 24 Sep 2005 15:28:25 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050924142825.GA5158@sigsegv.plus.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org> <20050924121431.GA5530@sigsegv.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20050924121431.GA5530@sigsegv.plus.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 24, 2005 at 01:14:31PM +0100, Chris Sykes wrote:
> After many compile reboot cycles, git-bisect tells me that the
> offending cset is 10f47e6a1b8b276323b652053945c87a63a5812d:
>     [PATCH] ext2: Enable atomic inode security labeling
>=20
> I'll do some more testing to verify.

Latest kernel from git (2.6.14-rc2-g87e807b6) still causes the problem
for me.  Reversing cset 10f47e6a1b8b276323b652053945c87a63a5812d fixes
it for me.

I'll build a kernel with CONFIG_EXT2_FS_XATTR disabled and see if that
also makes the issue go away.

I have a question though.  When looking at the code in
fs/ext2/ialloc.c for ext2_new_inode().  The failure path for
ext2_init_acl() includes a DQUOT_DROP(), but the failure path for
ext2_init_security() does not. e.g.:

        err =3D ext2_init_acl(inode, dir);
        if (err) {=20
                DQUOT_FREE_INODE(inode);
                DQUOT_DROP(inode);
                goto fail2;
        }
        err =3D ext2_init_security(inode,dir);
        if (err) {=20
                DQUOT_FREE_INODE(inode);
                goto fail2;
        }

Is this right?  Or should we really have the following:

Signed-off-by: Chris Sykes <chris@sigsegv.plus.com>

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -618,6 +618,7 @@ got:
 	err =3D ext2_init_security(inode,dir);
 	if (err) {
 		DQUOT_FREE_INODE(inode);
+		DQUOT_DROP(inode);
 		goto fail2;
 	}
 	mark_inode_dirty(inode);


--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNWKJkElw2FFDgJARAniuAJ4/BlrhiVN+n0+K/CdlDNvvcnDFdwCfUGnB
oWz23rfaxBoT2nY/v59zvus=
=9oQp
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
