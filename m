Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWKOOb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWKOOb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWKOOb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:31:29 -0500
Received: from systemlinux.org ([83.151.29.59]:60650 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1030493AbWKOOb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:31:28 -0500
Date: Wed, 15 Nov 2006 15:30:57 +0100
From: Andre Noll <maan@systemlinux.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061115143056.GI29040@skl-net.de>
References: <20061030095558.GB6446@skl-net.de> <20061115000356.GA14624@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20061115000356.GA14624@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17:03, Andreas Dilger wrote:

> On Oct 30, 2006  10:55 +0100, Andre Noll wrote:
> > Note that the patch does not address the EXT3_FEATURE_INCOMPAT_META_BG
> > case yet. I'll have to look at this in more detail.
>=20
> See more below...  Basically, the patch looks good enough to submit for
> inclusion.  Can you CC it to Andrew on the next iteration.

Andrew added to CC list. Andrew: Please consider the patch below for
inclusion in the mm tree.

> This _should_ probably also include a check for the backup group descript=
ors
> and superblock, but unfortunately the helpers ext3_bg_has_super() and
> ext3_bg_num_gdb() are fairly CPU intensive and not something you want to
> check for each block that is allocated/freed.  In the future (mballoc) wh=
en
> we have per-group data structs we can just store a flag per group whether
> it has a backup or not instead of recomputing the powers of 3, 5, 7 each =
time.
> Maybe a comment for now to indicate that needs to be fixed in the future?

Done, see below.=20

> Also a minor nit - this is actually checking "num" blocks, and it might be
> useful in the future so it would be clearer to call it something like
> ext3_blocks_are_metadata().

Agreed, ext3_blocks_are_metadata() is more appropriate.

> > +	gdblocks =3D ext3_bg_num_gdb(sb, group);
> > +	for (i =3D 0, bit =3D 1; i < gdblocks; i++, bit++)
> > +		/* actually a bit more complex for INCOMPAT_META_BG fs */
> > +		ext3_set_bit(i, gdp_bh->b_data);
>=20
> Actually, in newer kernels ext3_bg_num_gdb() includes INCOMPAT_META_BG
> support, so that may be enough.

OK, comment removed.

Thanks again for your assistance and your patience, Andreas.
Andre
---
=46rom: Andre Noll <maan@systemlinux.org>

This is a port of an old linux-2.4 patch by Andreas Dilger for handling
on-disk corruption.

=46rom the changelog of the 2.4-patch:

	In case of on-disk corruption, the current ext2/3 code will
	happily reallocate or mark free blocks in the system area
	(bitmaps, inode table, etc) instead of ignoring the bad
	alloc/free and leaving the system blocks alone.  This will
	cause further corruption of the filesystem as metadata
	gets overwritten by file data and in turn causes more bad
	alloc/free requests.

Unlike in the original version, the check whether a set of blocks are
metadata is moved to a new function, ext3_blocks_are_metadata(). There
is also another new function, fix_group(), which is called whenever
an on-disk corruption is detected and which performs the actual fixing.


Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 fs/ext3/balloc.c |  102 +++++++++++++++++++++++++++++++++++++++-----------=
---
 1 files changed, 75 insertions(+), 27 deletions(-)

diff --git a/fs/ext3/balloc.c b/fs/ext3/balloc.c
index 063d994..763b7a0 100644
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
@@ -1192,6 +1190,63 @@ int ext3_should_retry_alloc(struct super
 }
=20
 /*
+ * Check if given blocks are metadata blocks.
+ *
+ * We should also check the backup group descriptors and the superblock,
+ * but it is too expensive to do so for each allocated/freed block. So,
+ * let's defer that check until we have per-group data structs.
+ */
+static inline int ext3_blocks_are_metadata(ext3_fsblk_t block,
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
+/*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
  * is allocated.  Otherwise a forward search is made for a free block; wit=
hin=20
@@ -1260,7 +1315,7 @@ ext3_fsblk_t ext3_new_blocks(handle_t *h
 		*errp =3D -ENOSPC;
 		goto out;
 	}
-
+repeat:
 	/*
 	 * First, test whether the goal block is free.
 	 */
@@ -1367,17 +1422,10 @@ allocated:
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
+	if (ext3_blocks_are_metadata(ret_block, num, gdp, sb)) {
+		fix_group(group_no, sb);
+		goto repeat;
+	}
 	performed_allocation =3D 1;
=20
 #ifdef CONFIG_JBD_DEBUG

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFWySgWto1QDEAkw8RApoOAJ9wAPAvOqyXWfhzO/hIC8sYCCiqEgCgjF6n
ktkBksaV6JLdDog/osbqM3U=
=o/tX
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
