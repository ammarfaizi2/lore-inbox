Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVAVPuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVAVPuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 10:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAVPuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 10:50:55 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:5339 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262401AbVAVPup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 10:50:45 -0500
Date: Sat, 22 Jan 2005 16:50:44 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.11-rc2/ext3 quota allocation bug on error path ...
Message-ID: <20050122155044.GA4573@mail.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


looking at ext3_xattr_block_set() [fs/ext3/xattr.c] ...
I see that 

                                error = -EDQUOT;
                                if (DQUOT_ALLOC_BLOCK(inode, 1))
                                        goto cleanup;

allocates a quota block, but right after that several
error echecks happen ...

                                if (error)
                                        goto cleanup;

and I don't see any DQUOT_FREE_BLOCK() in the errorpath

cleanup:
        if (ce)
                mb_cache_entry_release(ce);
        brelse(new_bh); 
        if (!(bs->bh && s->base == bs->bh->b_data))
                kfree(s->base);

        return error;

I'd suggest the attached fix (agains 2.6.11-rc2), comments?

best,
Herbert


--- ./fs/ext3/xattr.c.orig	2005-01-22 15:07:50 +0100
+++ ./fs/ext3/xattr.c		2005-01-22 16:45:09 +0100
@@ -773,7 +773,7 @@ inserted:
 				error = ext3_journal_get_write_access(handle,
 								      new_bh);
 				if (error)
-					goto cleanup;
+					goto cleanup_dquot;
 				lock_buffer(new_bh);
 				BHDR(new_bh)->h_refcount = cpu_to_le32(1 +
 					le32_to_cpu(BHDR(new_bh)->h_refcount));
@@ -783,7 +783,7 @@ inserted:
 				error = ext3_journal_dirty_metadata(handle,
 								    new_bh);
 				if (error)
-					goto cleanup;
+					goto cleanup_dquot;
 			}
 			mb_cache_entry_release(ce);
 			ce = NULL;
@@ -844,6 +844,10 @@ cleanup:
 
 	return error;
 
+cleanup_dquot:
+	DQUOT_FREE_BLOCK(inode, 1);
+	goto cleanup;
+
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
 		   "inode %ld: bad block %d", inode->i_ino,

