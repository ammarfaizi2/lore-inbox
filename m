Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWB0WmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWB0WmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWB0WbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:25 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64642 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751772AbWB0WbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:06 -0500
Message-Id: <20060227223349.977521000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, staubach@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/39] [PATCH] fix deadlock in ext2
Content-Disposition: inline; filename=fix-deadlock-in-ext2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix a deadlock possible in the ext2 file system implementation.  This
deadlock occurs when a file is removed from an ext2 file system which was
mounted with the "sync" mount option.

The problem is that ext2_xattr_delete_inode() was invoking the routine,
sync_dirty_buffer(), using a buffer head which was previously locked via
lock_buffer().  The first thing that sync_dirty_buffer() does is to lock
the buffer head that it was passed.  It does this via lock_buffer().  Oops.

The solution is to unlock the buffer head in ext2_xattr_delete_inode()
before invoking sync_dirty_buffer().  This makes the code in
ext2_xattr_delete_inode() obey the same locking rules as all other callers
of sync_dirty_buffer() in the ext2 file system implementation.

Signed-off-by: Peter Staubach <staubach@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/ext2/xattr.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15.4.orig/fs/ext2/xattr.c
+++ linux-2.6.15.4/fs/ext2/xattr.c
@@ -796,18 +796,20 @@ ext2_xattr_delete_inode(struct inode *in
 		ext2_free_blocks(inode, EXT2_I(inode)->i_file_acl, 1);
 		get_bh(bh);
 		bforget(bh);
+		unlock_buffer(bh);
 	} else {
 		HDR(bh)->h_refcount = cpu_to_le32(
 			le32_to_cpu(HDR(bh)->h_refcount) - 1);
 		if (ce)
 			mb_cache_entry_release(ce);
+		ea_bdebug(bh, "refcount now=%d",
+			le32_to_cpu(HDR(bh)->h_refcount));
+		unlock_buffer(bh);
 		mark_buffer_dirty(bh);
 		if (IS_SYNC(inode))
 			sync_dirty_buffer(bh);
 		DQUOT_FREE_BLOCK(inode, 1);
 	}
-	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
-	unlock_buffer(bh);
 	EXT2_I(inode)->i_file_acl = 0;
 
 cleanup:

--
