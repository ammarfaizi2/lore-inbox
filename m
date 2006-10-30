Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWJ3J4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWJ3J4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJ3J4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:56:21 -0500
Received: from systemlinux.org ([83.151.29.59]:7078 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1161169AbWJ3J4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:56:20 -0500
Date: Mon, 30 Oct 2006 10:55:58 +0100
From: Andre Noll <maan@systemlinux.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061030095558.GB6446@skl-net.de>
References: <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int> <20061025094418.GA22487@skl-net.de> <20061026093613.GM3509@schatzie.adilger.int> <20061026160241.GB12843@skl-net.de> <20061026180133.GN3509@schatzie.adilger.int> <20061027153414.GA6446@skl-net.de> <20061028142454.GA6182@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20061028142454.GA6182@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22:24, Andreas Dilger wrote:
> Well, it needs to also handle backup superblock, bitmaps, inode table:
>=20
> 	if (ext3_bg_has_super())
> 		ext3_set_bit(0, gdp_bh->b_data);
> 	gdblocks =3D ext3_bg_num_gdb(sb, group);
> 	for (i =3D 0, bit =3D 1; i < gdblocks; i++, bit++)
> 		/* actually a bit more complex for INCOMPAT_META_BG fs */
> 		ext3_set_bit(i, gdp_bh->b_data);
> 	ext3_set_bit(gdp->bg_inode_bitmap % EXT3_BLOCKS_PER_GROUP(sb), ...);
> 	ext3_set_bit(gdp->bg_block_bitmap % EXT3_BLOCKS_PER_GROUP(sb), ...);
> 	for (i =3D 0, bit =3D gdp->bg_inode_table % EXT3_BLOCKS_PER_GROUP(sb);
> 	     i < EXT3_SB(sb)->s_itb_per_group; i++, bit++)
> 		ext3_set_bit(i, gdp_bh->b_data);
> 	=09
> (or something close to this).

OK. So here's a new version of the patch. I moved the check whether a
block needs fixing into an inline function, block_needs_fix(), and
introduced a new function fix_group() that sets the bits in
gdp_bh->b_data. Note that the patch does not address the
EXT3_FEATURE_INCOMPAT_META_BG case yet. I'll have to look at this in
more detail.

BTW: Currently e2fsck is running on the file system which suffered from
the bug this patch tries to fix. It looks like the file system is
completely busted as e2fsck is spitting out zillions of=20

	"Too many illegal blocks"=20
	"Inode xxxxx has compression flag set on filesystem without compression su=
pport."
	"Inode xxxxx has INDEX_FL flag set but is not a directory"

Thanks
Andre


diff --git a/fs/ext3/balloc.c b/fs/ext3/balloc.c
index 063d994..cc29e5b 100644
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
@@ -400,7 +399,7 @@ do_more:
 		jbd_unlock_bh_state(bitmap_bh);
 		{
 			struct buffer_head *debug_bh;
-			debug_bh =3D sb_find_get_block(sb, block + i);
+			debug_bh =3D sb_find_get_block(sb, block);
 			if (debug_bh) {
 				BUFFER_TRACE(debug_bh, "Deleted!");
 				if (!bh2jh(bitmap_bh)->b_committed_data)
@@ -452,7 +451,7 @@ do_more:
 			jbd_unlock_bh_state(bitmap_bh);
 			ext3_error(sb, __FUNCTION__,
 				"bit already cleared for block "E3FSBLK,
-				 block + i);
+				block);
 			jbd_lock_bh_state(bitmap_bh);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
@@ -479,7 +478,6 @@ do_more:
 	*pdquot_freed_blocks +=3D group_freed;
=20
 	if (overflow && !err) {
-		block +=3D count;
 		count =3D overflow;
 		goto do_more;
 	}
@@ -1191,6 +1189,57 @@ int ext3_should_retry_alloc(struct super
 	return journal_force_commit_nested(EXT3_SB(sb)->s_journal);
 }
=20
+static inline int block_needs_fix(ext3_fsblk_t block,
+		unsigned long num,
+		struct ext3_group_desc *gdp,
+		struct super_block *sb)
+{
+	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), block, num))
+		return 1;
+	if (in_range(le32_to_cpu(gdp->bg_inode_bitmap), block, num))
+		return 1;
+	if (in_range(block, le32_to_cpu(gdp->bg_inode_table),
+			EXT3_SB(sb)->s_itb_per_group))
+		return 1;
+	if (in_range(block + num - 1, le32_to_cpu(gdp->bg_inode_table),
+			EXT3_SB(sb)->s_itb_per_group))
+		return 1;
+	return 0;
+}
+
+/*
+ *
+ * set the bits for all of the metadata blocks in the group
+ *
+ * Note: This will potentially use up some of the handle's buffer credits.
+ * Normally we have way too many credits, so that is OK. In _very_ rare ca=
ses it
+ * might not be OK.  We will trigger an assertion if we run out of credits=
, and we
+ * will have to do a full fsck of the filesystem - better than randomly co=
rrupting
+ * filesystem metadata.
+ */
+static void fix_group(int group, struct super_block *sb)
+{
+	int i;
+	ext3_fsblk_t bit;
+	unsigned long gdblocks;
+	struct buffer_head *gdp_bh;
+	struct ext3_group_desc *gdp =3D ext3_get_group_desc(sb, group, &gdp_bh);
+
+	if (ext3_bg_has_super(sb, group))
+		ext3_set_bit(0, gdp_bh->b_data);
+	gdblocks =3D ext3_bg_num_gdb(sb, group);
+	for (i =3D 0, bit =3D 1; i < gdblocks; i++, bit++)
+		/* actually a bit more complex for INCOMPAT_META_BG fs */
+		ext3_set_bit(i, gdp_bh->b_data);
+	ext3_set_bit(gdp->bg_inode_bitmap % EXT3_BLOCKS_PER_GROUP(sb),
+		gdp_bh->b_data);
+	ext3_set_bit(gdp->bg_block_bitmap % EXT3_BLOCKS_PER_GROUP(sb),
+		gdp_bh->b_data);
+	for (i =3D 0, bit =3D gdp->bg_inode_table % EXT3_BLOCKS_PER_GROUP(sb);
+			i < EXT3_SB(sb)->s_itb_per_group; i++, bit++)
+		ext3_set_bit(i, gdp_bh->b_data);
+}
+
 /*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
@@ -1260,7 +1309,7 @@ ext3_fsblk_t ext3_new_blocks(handle_t *h
 		*errp =3D -ENOSPC;
 		goto out;
 	}
-
+repeat:
 	/*
 	 * First, test whether the goal block is free.
 	 */
@@ -1367,17 +1416,10 @@ allocated:
=20
 	ret_block =3D grp_alloc_blk + ext3_group_first_block_no(sb, group_no);
=20
-	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
-	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
-	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
-		      EXT3_SB(sb)->s_itb_per_group) ||
-	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
-		      EXT3_SB(sb)->s_itb_per_group))
-		ext3_error(sb, "ext3_new_block",
-			    "Allocating block in system zone - "
-			    "blocks from "E3FSBLK", length %lu",
-			     ret_block, num);
-
+	if (block_needs_fix(ret_block, num, gdp, sb)) {
+		fix_group(group_no, sb);
+		goto repeat;
+	}
 	performed_allocation =3D 1;
=20
 #ifdef CONFIG_JBD_DEBUG
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFRcwuWto1QDEAkw8RAhzKAJwOe8k81z7jhF+E0ZU9qD7UIbFGxgCffCeB
UKNBX6dHoe1MGlFGn60t6RE=
=iqEe
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
