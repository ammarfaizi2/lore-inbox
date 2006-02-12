Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWBLRw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWBLRw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWBLRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:52:59 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:19032 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750755AbWBLRw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:52:58 -0500
Date: Sun, 12 Feb 2006 12:52:56 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
Message-ID: <20060212175256.GA8805@locomotive.unixthugs.org>
References: <200602120156.AA112460246@usfltd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <200602120156.AA112460246@usfltd.com>
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 01:56:52AM -0600, art wrote:
> FROM:   	   =09
> Jeffrey Mahoney <jeffm@suse.com> | Save Address
> DATE: 	  	Sat, 11 Feb 2006 16:58:20 -0500
> TO: 	  	<art@usfltd.com> =20
> SUBJECT: 	  	Re: kernel-2.6.16-rc2-git8 - reiserfs 3.6 - write problem !!!
>   =09
>   	art wrote:
> > kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
> >
> > it started ~from kernel-2.6.16-rc2
> > 2.6.16-rc1-git6 works ok

art -

One more followup question. Was the file system you're using converted from=
 a
v3.5 file system, or has it always been v3.6?

Sergey Vlasov on the reiserfs list noticed that v3.5 objects never had
REISERFS_I(inode)->i_attrs set, which means that even on a converted v3.6
file system, objects created underneath a v3.5-created directory would
inherit random attrs bits.

I have a patch that adds an additional check to see if the file system has
always been v3.6 - just by checking the version of the stat data on the root
directory.

If you haven't already run reiserfsck --clean attributes, can you give the
patch a try? Don't mount with -oattrs, since we already know the attributes
are corrupt. I just want to test and see if the file system you've got is
converted from a v3.5 file system and if it fixes the problem.

Thanks.

-Jeff
--=20
Jeff Mahoney
SuSE Labs

--yrj/dFKFPuw6o+aM
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

--yrj/dFKFPuw6o+aM--

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD73X3LPWxlyuTD7IRAiwvAJ9eAsfD50RDvaJLFop2bajxWMjWzgCdFoGQ
m8xbwtkMwVJbbgndMm+ih3I=
=eCK8
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
