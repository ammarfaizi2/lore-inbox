Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWCBVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWCBVJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWCBVJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:09:51 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:18456 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932542AbWCBVJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:09:50 -0500
Date: Thu, 2 Mar 2006 16:09:49 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] reiserfs: reiserfs_file_write will lose error code when a 0-length write occurs w/ O_SYNC
Message-ID: <20060302210947.GA16696@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 When an error occurs in reiserfs_file_write before any data is written, and
 O_SYNC is set, the return code of generic_osync_write will overwrite the
 error code, losing it.

 This patch ensures that generic_osync_inode() doesn't run under an error
 condition, losing the error. This duplicates the logic from
 generic_file_buffered_write().

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/file.c linux-2.6.15.reiserfs/fs/reiserfs/file.c
--- linux-2.6.15/fs/reiserfs/file.c	2006-03-02 12:10:04.000000000 -0500
+++ linux-2.6.15.reiserfs/fs/reiserfs/file.c	2006-03-02 16:08:49.000000000 -0500
@@ -1563,10 +1563,10 @@ static ssize_t reiserfs_file_write(struc
 		}
 	}
 
-	if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
-		res =
-		    generic_osync_inode(inode, file->f_mapping,
-					OSYNC_METADATA | OSYNC_DATA);
+	if (likely(res >= 0) &&
+	    (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))))
+		res = generic_osync_inode(inode, file->f_mapping,
+		                          OSYNC_METADATA | OSYNC_DATA);
 
 	mutex_unlock(&inode->i_mutex);
 	reiserfs_async_progress_wait(inode->i_sb);
-- 
Jeff Mahoney
SuSE Labs
