Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWDZGcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWDZGcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWDZGcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:32:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48607 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750875AbWDZGck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:32:40 -0400
Date: Wed, 26 Apr 2006 07:32:40 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: [PATCH] protect ext3 ioctl modifying append_only, immutable, etc. with i_mutex
Message-ID: <20060426063240.GJ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	All modifications of ->i_flags in inodes that might be visible to
somebody else must be under ->i_mutex.  That patch fixes ext3 ioctl()
setting S_APPEND and friends.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/ext3/ioctl.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

48ef5cddd158b0bbce7b646a16ba9ce3c599b0f1
diff --git a/fs/ext3/ioctl.c b/fs/ext3/ioctl.c
index aaf1da1..8c22aa9 100644
--- a/fs/ext3/ioctl.c
+++ b/fs/ext3/ioctl.c
@@ -48,6 +48,7 @@ int ext3_ioctl (struct inode * inode, st
 		if (!S_ISDIR(inode->i_mode))
 			flags &= ~EXT3_DIRSYNC_FL;
 
+		mutex_lock(&inode->i_mutex);
 		oldflags = ei->i_flags;
 
 		/* The JOURNAL_DATA flag is modifiable only by root */
@@ -60,8 +61,10 @@ int ext3_ioctl (struct inode * inode, st
 		 * This test looks nicer. Thanks to Pauline Middelink
 		 */
 		if ((flags ^ oldflags) & (EXT3_APPEND_FL | EXT3_IMMUTABLE_FL)) {
-			if (!capable(CAP_LINUX_IMMUTABLE))
+			if (!capable(CAP_LINUX_IMMUTABLE)) {
+				mutex_unlock(&inode->i_mutex);
 				return -EPERM;
+			}
 		}
 
 		/*
@@ -69,14 +72,18 @@ int ext3_ioctl (struct inode * inode, st
 		 * the relevant capability.
 		 */
 		if ((jflag ^ oldflags) & (EXT3_JOURNAL_DATA_FL)) {
-			if (!capable(CAP_SYS_RESOURCE))
+			if (!capable(CAP_SYS_RESOURCE)) {
+				mutex_unlock(&inode->i_mutex);
 				return -EPERM;
+			}
 		}
 
 
 		handle = ext3_journal_start(inode, 1);
-		if (IS_ERR(handle))
+		if (IS_ERR(handle)) {
+			mutex_unlock(&inode->i_mutex);
 			return PTR_ERR(handle);
+		}
 		if (IS_SYNC(inode))
 			handle->h_sync = 1;
 		err = ext3_reserve_inode_write(handle, inode, &iloc);
@@ -93,11 +100,14 @@ int ext3_ioctl (struct inode * inode, st
 		err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
 		ext3_journal_stop(handle);
-		if (err)
+		if (err) {
+			mutex_unlock(&inode->i_mutex);
 			return err;
+		}
 
 		if ((jflag ^ oldflags) & (EXT3_JOURNAL_DATA_FL))
 			err = ext3_change_inode_journal_flag(inode, jflag);
+		mutex_unlock(&inode->i_mutex);
 		return err;
 	}
 	case EXT3_IOC_GETVERSION:
-- 
1.3.0.g0080f

