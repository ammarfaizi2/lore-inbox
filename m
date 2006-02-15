Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945982AbWBOPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945982AbWBOPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945983AbWBOPbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:31:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:912 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945982AbWBOPbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:31:55 -0500
Message-ID: <43F34969.6070603@redhat.com>
Date: Wed, 15 Feb 2006 10:31:53 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] deadlock in ext2
Content-Type: multipart/mixed;
 boundary="------------080908070000080705020906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080908070000080705020906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The attached patch addresses a deadlock possible in the ext2 file system
implementation.  This deadlock occurs when a file is removed from an ext2
file system which was mounted with the "sync" mount option.

The problem is that ext2_xattr_delete_inode() was invoking the routine,
sync_dirty_buffer(), using a buffer head which was previously locked via
lock_buffer().  The first thing that sync_dirty_buffer() does is to lock
the buffer head that it was passed.  It does this via lock_buffer().  Oops.

The solution is to unlock the buffer head in ext2_xattr_delete_inode()
before invoking sync_dirty_buffer().  This makes the code in
ext2_xattr_delete_inode() obey the same locking rules as all other
callers of sync_dirty_buffer() in the ext2 file system implementation.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------080908070000080705020906
Content-Type: text/plain;
 name="devel.today"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devel.today"

--- linux-2.6.15.x86_64/fs/ext2/xattr.c.org
+++ linux-2.6.15.x86_64/fs/ext2/xattr.c
@@ -792,18 +792,20 @@ ext2_xattr_delete_inode(struct inode *in
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

--------------080908070000080705020906--
