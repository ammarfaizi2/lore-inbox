Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBDPbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBDPbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:31:52 -0500
Received: from ns.suse.de ([195.135.220.2]:21386 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262328AbUBDPbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:31:46 -0500
Subject: [PATCH] Incorrect increment of i_blocks when keeping the same
	xattr block on ext[23]
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>
Content-Type: multipart/mixed; boundary="=-4GPaLxjzrzcMuqGR/Yp1"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1075908516.2267.126.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 04 Feb 2004 16:28:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4GPaLxjzrzcMuqGR/Yp1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrew,

here is a fix for extended attributes on ext2 and ext3, reported by
Stephen Tweedie <sct@redhat.com>. The description is in the patch. Could
you please apply to mainline?

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-4GPaLxjzrzcMuqGR/Yp1
Content-Disposition: attachment; filename=xattr-keep-block.diff
Content-Type: text/plain; name=xattr-keep-block.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Incorrect increment of i_blocks when keeping the same xattr block on ext[23]

>From Stephen Tweedie <sct@redhat.com>:

When you have an EA block that is shared between multiple inodes; AND
you then change an attribute in that on one inode, AND the new attribute
value is the same as the old, then xattr computes the new EA block,
finds it still in the cache, bumps the reference count on it (and the
i_blocks field on the inode, incidentally), and leaves it incremented
because we haven't changed EA block so there's no need to drop the
refcount on the old block.

So *every* time you have more than one inode sharing an EA block and you
perform an identical write to an EA, you get a leak on both i_blocks and
the EA refcount.

This is a big problem for symlinks, which rely on correct i_blocks
accounting to determine the difference between fast and slow symlinks. 
With the leak, you end up thinking that a fast symlink (ie. one small
enough to be stored in the inode direct blocks) is slow, so you
dereference the ascii contents of the symlink as if they were a disk
block address.  That typically results in EIO all over the place.

Index: linux-2.6.1/fs/ext2/xattr.c
===================================================================
--- linux-2.6.1.orig/fs/ext2/xattr.c
+++ linux-2.6.1/fs/ext2/xattr.c
@@ -741,25 +741,24 @@ ext2_xattr_set2(struct inode *inode, str
 	if (header) {
 		new_bh = ext2_xattr_cache_find(inode, header);
 		if (new_bh) {
-			/*
-			 * We found an identical block in the cache. The
-			 * block returned is locked. The old block will
-			 * be released after updating the inode.
-			 */
-			ea_bdebug(new_bh, "%s block %lu",
-				(old_bh == new_bh) ? "keeping" : "reusing",
-				(unsigned long) new_bh->b_blocknr);
-			
-			error = -EDQUOT;
-			if (DQUOT_ALLOC_BLOCK(inode, 1)) {
-				unlock_buffer(new_bh);
-				goto cleanup;
+			/* We found an identical block in the cache. */
+			if (new_bh == old_bh) {
+				ea_bdebug(new_bh, "keeping this block");
+			} else {
+				/* The old block is released after updating
+				   the inode.  */
+				ea_bdebug(new_bh, "reusing block");
+				
+				error = -EDQUOT;
+				if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+					unlock_buffer(new_bh);
+					goto cleanup;
+				}
+				HDR(new_bh)->h_refcount = cpu_to_le32(1 +
+					le32_to_cpu(HDR(new_bh)->h_refcount));
+				ea_bdebug(new_bh, "refcount now=%d",
+					le32_to_cpu(HDR(new_bh)->h_refcount));
 			}
-			
-			HDR(new_bh)->h_refcount = cpu_to_le32(
-				le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
-			ea_bdebug(new_bh, "refcount now=%d",
-				le32_to_cpu(HDR(new_bh)->h_refcount));
 			unlock_buffer(new_bh);
 		} else if (old_bh && header == HDR(old_bh)) {
 			/* Keep this block. No need to lock the block as we
Index: linux-2.6.1/fs/ext3/xattr.c
===================================================================
--- linux-2.6.1.orig/fs/ext3/xattr.c
+++ linux-2.6.1/fs/ext3/xattr.c
@@ -753,25 +753,26 @@ ext3_xattr_set_handle2(handle_t *handle,
 	if (header) {
 		new_bh = ext3_xattr_cache_find(handle, inode, header, &credits);
 		if (new_bh) {
-			/*
-			 * We found an identical block in the cache. The
-			 * block returned is locked. The old block will
-			 * be released after updating the inode.
-			 */
-			ea_bdebug(new_bh, "%s block %lu",
-				(old_bh == new_bh) ? "keeping" : "reusing",
-				(unsigned long) new_bh->b_blocknr);
-
-			error = -EDQUOT;
-			if (DQUOT_ALLOC_BLOCK(inode, 1)) {
-				unlock_buffer(new_bh);
-				journal_release_buffer(handle, new_bh, credits);
-				goto cleanup;
+			/* We found an identical block in the cache. */
+			if (new_bh == old_bh)
+				ea_bdebug(new_bh, "keeping this block");
+			else {
+				/* The old block is released after updating
+				   the inode. */
+				ea_bdebug(new_bh, "reusing block");
+
+				error = -EDQUOT;
+				if (DQUOT_ALLOC_BLOCK(inode, 1)) {
+					unlock_buffer(new_bh);
+					journal_release_buffer(handle, new_bh,
+							       credits);
+					goto cleanup;
+				}
+				HDR(new_bh)->h_refcount = cpu_to_le32(1 +
+					le32_to_cpu(HDR(new_bh)->h_refcount));
+				ea_bdebug(new_bh, "refcount now=%d",
+					le32_to_cpu(HDR(new_bh)->h_refcount));
 			}
-			HDR(new_bh)->h_refcount = cpu_to_le32(
-				le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
-			ea_bdebug(new_bh, "refcount now=%d",
-				le32_to_cpu(HDR(new_bh)->h_refcount));
 			unlock_buffer(new_bh);
 		} else if (old_bh && header == HDR(old_bh)) {
 			/* Keep this block. No need to lock the block as we

--=-4GPaLxjzrzcMuqGR/Yp1--

