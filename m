Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316404AbSEZUvh>; Sun, 26 May 2002 16:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316383AbSEZUu0>; Sun, 26 May 2002 16:50:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316424AbSEZUoy>;
	Sun, 26 May 2002 16:44:54 -0400
Message-ID: <3CF14A04.69A00C87@zip.com.au>
Date: Sun, 26 May 2002 13:48:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 18/18] avoid sys_sync livelocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This makes sure that sys_sync() will terminate.  It counts up the
number of dirty pages in the machine and will refuse to write out more
than 1.25 times this number of pages.  This function is called twice
on the sys_sync() path, so the kernel will actually write 2.5x the number
of initially-dirty pages before giving up.


--- 2.5.18/fs/fs-writeback.c~sync_livelock	Sun May 26 12:38:15 2002
+++ 2.5.18-akpm/fs/fs-writeback.c	Sun May 26 12:38:15 2002
@@ -325,11 +325,21 @@ static void __wait_on_locked(struct list
  * writeback and wait upon the filesystem's dirty inodes.  The caller will
  * do this in two passes - one to write, and one to wait.  WB_SYNC_HOLD is
  * used to park the written inodes on sb->s_dirty for the wait pass.
+ *
+ * A finite limit is set on the number of pages which will be written.
+ * To prevent infinite livelock of sys_sync().
  */
 void sync_inodes_sb(struct super_block *sb, int wait)
 {
+	struct page_state ps;
+	int nr_to_write;
+
+	get_page_state(&ps);
+	nr_to_write = ps.nr_dirty + ps.nr_dirty / 4;
+
 	spin_lock(&inode_lock);
-	sync_sb_inodes(sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD, NULL, NULL);
+	sync_sb_inodes(sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
+				&nr_to_write, NULL);
 	if (wait)
 		__wait_on_locked(&sb->s_locked_inodes);
 	spin_unlock(&inode_lock);


-
