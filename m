Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314984AbSESTfp>; Sun, 19 May 2002 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSESTfo>; Sun, 19 May 2002 15:35:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5380 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314984AbSESTfe>;
	Sun, 19 May 2002 15:35:34 -0400
Message-ID: <3CE7FF5A.FEDD69CB@zip.com.au>
Date: Sun, 19 May 2002 12:39:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
Subject: [patch 5/15] reiserfs locking fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



reiserfs is using b_inode_buffers and fsync_buffers_list() for
attaching dependent buffers to its journal.  For writeout prior to
commit.

This worked OK when a global lock was used everywhere, but the locking
is currently incorrect - try_to_free_buffers() is taking a different
lock when detaching buffers from their "foreign" inode.  So list_head
corruption could occur on SMP.

The patch implements a reiserfs_releasepage() which holds the
journal-wide buffer lock while it runs try_to_free_buffers(), so all
those list_heads are protected.  The lock is held across the
try_to_free_buffers() call as well, so nobody will attach one of this
page's buffers to a list while try_to_free_buffers() is running.



=====================================

--- 2.5.16/fs/reiserfs/inode.c~reiserfs_releasepage	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/fs/reiserfs/inode.c	Sun May 19 11:49:47 2002
@@ -2096,9 +2096,47 @@ static int reiserfs_commit_write(struct 
     return ret ;
 }
 
+/*
+ * Returns 1 if the page's buffers were dropped.  The page is locked.
+ *
+ * Takes j_dirty_buffers_lock to protect the b_assoc_buffers list_heads
+ * in the buffers at page_buffers(page).
+ *
+ * FIXME: Chris says the buffer list is not used with `mount -o notail',
+ * so in that case the fs can avoid the extra locking.  Create a second
+ * address_space_operations with a NULL ->releasepage and install that
+ * into new address_spaces.
+ */
+static int reiserfs_releasepage(struct page *page, int unused_gfp_flags)
+{
+    struct inode *inode = page->mapping->host ;
+    struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb) ;
+    struct buffer_head *head ;
+    struct buffer_head *bh ;
+    int ret = 1 ;
+
+    spin_lock(&j->j_dirty_buffers_lock) ;
+    head = page_buffers(page) ;
+    bh = head ;
+    do {
+	if (!buffer_dirty(bh) && !buffer_locked(bh)) {
+		list_del_init(&bh->b_assoc_buffers) ;
+	} else {
+		ret = 0 ;
+		break ;
+	}
+	bh = bh->b_this_page ;
+    } while (bh != head) ;
+    if (ret)
+	ret = try_to_free_buffers(page) ;
+    spin_unlock(&j->j_dirty_buffers_lock) ;
+    return ret ;
+}
+
 struct address_space_operations reiserfs_address_space_operations = {
     writepage: reiserfs_writepage,
     readpage: reiserfs_readpage, 
+    releasepage: reiserfs_releasepage,
     sync_page: block_sync_page,
     prepare_write: reiserfs_prepare_write,
     commit_write: reiserfs_commit_write,
--- 2.5.16/fs/reiserfs/file.c~reiserfs_releasepage	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/fs/reiserfs/file.c	Sun May 19 11:49:47 2002
@@ -72,6 +72,12 @@ static void reiserfs_vfs_truncate_file(s
 }
 
 /* Sync a reiserfs file. */
+
+/*
+ * FIXME: sync_mapping_buffers() never has anything to sync.  Can
+ * be removed...
+ */
+
 static int reiserfs_sync_file(
 			      struct file   * p_s_filp,
 			      struct dentry * p_s_dentry,


-
