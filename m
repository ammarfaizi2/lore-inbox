Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBLR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBLR5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBLR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:57:44 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:26456 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750773AbWBLR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:57:43 -0500
Date: Sun, 12 Feb 2006 12:57:40 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Bernd Schubert <bernd-schubert@gmx.de>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060212175740.GB8805@locomotive.unixthugs.org>
References: <200602080212.27896.bernd-schubert@gmx.de> <200602081314.59639.bernd-schubert@gmx.de> <20060208205033.GB22771@shell0.pdx.osdl.net> <200602082246.15613.bernd-schubert@gmx.de> <20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20060212005541.107f7011.vsu@altlinux.ru>
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: multipart/mixed; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 12:55:41AM +0300, Sergey Vlasov wrote:
> I have noticed that fs/reiserfs/inode.c:init_inode() does not initialize
> REISERFS_I(inode)->i_attrs and inode->i_flags (as done by
> sd_attrs_to_i_attrs()) in the branch for v1 stat data; maybe this causes
> the problem?

Yes. This would absolutely cause a problem. Thanks for the triage.

The failure to set i_attrs =3D 0 for the sd v1 path means that *any* new ob=
jects
that inherit from a v3.5-created object (-o conv means new objects will be
sd v2, old ones aren't 'updated'), will end up with bogus attributes.

This is essentially code-introduced corruption. The patch to fix it in futu=
re
versions is easy enough, but you'll need to run reiserfsck --clean-attribut=
es
<device> on any affected file systems.

Bernd - If you haven't already run reiserfsck --clean-attributes on the fs,
can you please test the attached patch? It adds a check to make sure the
file system has always been v3.6 before enabling the attributes by default.

-Jeff

--=20
Jeff Mahoney
SuSE Labs

--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiserfs-attrs-test-fix.diff"

diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/inode.c linux-2.6.15-reiserfs/fs/reiserfs/inode.c
--- linux-2.6.15/fs/reiserfs/inode.c	2006-02-06 19:54:10.000000000 -0500
+++ linux-2.6.15-reiserfs/fs/reiserfs/inode.c	2006-02-12 12:43:00.000000000 -0500
@@ -1195,6 +1195,7 @@ static void init_inode(struct inode *ino
 		/* nopack is initially zero for v1 objects. For v2 objects,
 		   nopack is initialised from sd_attrs */
 		REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
+		REISERFS_I(inode)->i_attrs = 0;
 	} else {
 		// new stat data found, but object may have old items
 		// (directories and symlinks)
diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/super.c linux-2.6.15-reiserfs/fs/reiserfs/super.c
--- linux-2.6.15/fs/reiserfs/super.c	2006-02-06 19:54:27.000000000 -0500
+++ linux-2.6.15-reiserfs/fs/reiserfs/super.c	2006-02-12 12:48:41.000000000 -0500
@@ -1121,7 +1121,9 @@ static void handle_attrs(struct super_bl
 					 "reiserfs: cannot support attributes until flag is set in super-block");
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
-	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
+	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared &&
+	           get_inode_item_key_version(s->s_root->d_inode) == KEY_FORMAT_3_6) {
+		/* Enable attrs by default on v3.6-native file systems */
 		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }

--ALfTUftag+2gvp1h--

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD73cSLPWxlyuTD7IRAv2+AJ466axQE1UNomE/U7EUwUiM5OrfwQCfTGGm
MuXvLzm0hXXqnRHORtL64xk=
=4DMZ
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
