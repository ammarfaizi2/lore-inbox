Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423162AbWJYJot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423162AbWJYJot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423161AbWJYJot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:44:49 -0400
Received: from systemlinux.org ([83.151.29.59]:28359 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1423156AbWJYJos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:44:48 -0400
Date: Wed, 25 Oct 2006 11:44:18 +0200
From: Andre Noll <maan@systemlinux.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061025094418.GA22487@skl-net.de>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0786ZyFfTSxuegBe"
Content-Disposition: inline
In-Reply-To: <20061024202716.GX3509@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0786ZyFfTSxuegBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:27, Andreas Dilger wrote:

> > +		j =3D find_next_usable_block(-1, gdp, EXT3_BLOCKS_PER_GROUP(sb));
>=20
> I'm not sure why the "find_next_usable_block()" part is in here?  At this
> point we KNOW that ret_block is not a block we should be allocating, yet
> it is marked free in the bitmap.  So we should just mark the block(s) in-=
use
> in the bitmap and look for a different block(s).

Are you saying that ext3_set_bit() should simply be called with
"ret_block" as its first argument? If yes, that is what the revised
patch below does.

Thanks
Andre

diff --git a/fs/ext3/balloc.c b/fs/ext3/balloc.c
index 063d994..3cca317 100644
--- a/fs/ext3/balloc.c
+++ b/fs/ext3/balloc.c
@@ -359,17 +359,6 @@ do_more:
 	if (!desc)
 		goto error_return;
=20
-	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(desc->bg_inode_table),
-		      sbi->s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
-		      sbi->s_itb_per_group))
-		ext3_error (sb, "ext3_free_blocks",
-			    "Freeing blocks in system zones - "
-			    "Block =3D "E3FSBLK", count =3D %lu",
-			    block, count);
-
 	/*
 	 * We are about to start releasing blocks in the bitmap,
 	 * so we need undo access.
@@ -392,7 +381,17 @@ do_more:
=20
 	jbd_lock_bh_state(bitmap_bh);
=20
-	for (i =3D 0, group_freed =3D 0; i < count; i++) {
+	for (i =3D 0, group_freed =3D 0; i < count; i++, block++) {
+		struct ext3_group_desc *gdp =3D ext3_get_group_desc(sb, i, NULL);
+		if (block =3D=3D le32_to_cpu(gdp->bg_block_bitmap) ||
+			block =3D=3D le32_to_cpu(gdp->bg_inode_bitmap) ||
+			in_range(block, le32_to_cpu(gdp->bg_inode_table),
+				EXT3_SB(sb)->s_itb_per_group)) {
+			ext3_error(sb, __FUNCTION__,
+				"Freeing block in system zone - block =3D %lu",
+				block);
+			continue;
+		}
 		/*
 		 * An HJ special.  This is expensive...
 		 */
@@ -400,7 +399,7 @@ #ifdef CONFIG_JBD_DEBUG
 		jbd_unlock_bh_state(bitmap_bh);
 		{
 			struct buffer_head *debug_bh;
-			debug_bh =3D sb_find_get_block(sb, block + i);
+			debug_bh =3D sb_find_get_block(sb, block);
 			if (debug_bh) {
 				BUFFER_TRACE(debug_bh, "Deleted!");
 				if (!bh2jh(bitmap_bh)->b_committed_data)
@@ -452,7 +451,7 @@ #endif
 			jbd_unlock_bh_state(bitmap_bh);
 			ext3_error(sb, __FUNCTION__,
 				"bit already cleared for block "E3FSBLK,
-				 block + i);
+				block);
 			jbd_lock_bh_state(bitmap_bh);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
@@ -479,7 +478,6 @@ #endif
 	*pdquot_freed_blocks +=3D group_freed;
=20
 	if (overflow && !err) {
-		block +=3D count;
 		count =3D overflow;
 		goto do_more;
 	}
@@ -1260,7 +1258,7 @@ #endif
 		*errp =3D -ENOSPC;
 		goto out;
 	}
-
+repeat:
 	/*
 	 * First, test whether the goal block is free.
 	 */
@@ -1372,12 +1370,21 @@ allocated:
 	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
 		      EXT3_SB(sb)->s_itb_per_group) ||
 	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
-		      EXT3_SB(sb)->s_itb_per_group))
-		ext3_error(sb, "ext3_new_block",
+		      EXT3_SB(sb)->s_itb_per_group)) {
+		ext3_error(sb, __FUNCTION__,
 			    "Allocating block in system zone - "
 			    "blocks from "E3FSBLK", length %lu",
 			     ret_block, num);
-
+		/* Note: This will potentially use up one of the handle's
+		 * buffer credits.  Normally we have way too many credits,
+		 * so that is OK.  In _very_ rare cases it might not be OK.
+		 * We will trigger an assertion if we run out of credits,
+		 * and we will have to do a full fsck of the filesystem -
+		 * better than randomly corrupting filesystem metadata.
+		 */
+		ext3_set_bit(ret_block, gdp_bh->b_data);
+		goto repeat;
+	}
 	performed_allocation =3D 1;
=20
 #ifdef CONFIG_JBD_DEBUG
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--0786ZyFfTSxuegBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFPzHyWto1QDEAkw8RAup1AJ9c89HxQxvLlHdvC34neywKwmymYQCgkoTe
KEK5ol6uJCqR23/mB7ryARo=
=0Ltw
-----END PGP SIGNATURE-----

--0786ZyFfTSxuegBe--
