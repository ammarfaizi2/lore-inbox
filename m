Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSFAImu>; Sat, 1 Jun 2002 04:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSFAImJ>; Sat, 1 Jun 2002 04:42:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52490 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315424AbSFAIkJ>;
	Sat, 1 Jun 2002 04:40:09 -0400
Message-ID: <3CF88933.2EC13C8F@zip.com.au>
Date: Sat, 01 Jun 2002 01:43:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/16] fix race between writeback and unlink
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a race between unlink and writeback: on the sys_sync() and
pdflush paths the caller does not have a reference against the inode.

So run __iget prior to dropping inode_lock.

Oleg Drokin reported this and seems to believe that it fixes the
crashes he was observing.  But I was never able to reproduce them..


=====================================

--- 2.5.19/fs/fs-writeback.c~sync-race	Sat Jun  1 01:18:12 2002
+++ 2.5.19-akpm/fs/fs-writeback.c	Sat Jun  1 01:18:12 2002
@@ -245,17 +245,19 @@ static void sync_sb_inodes(struct super_
 		if ((sync_mode == WB_SYNC_LAST) && (head->prev == head))
 			really_sync = 1;
 
+		BUG_ON(inode->i_state & I_FREEING);
+		__iget(inode);
 		__writeback_single_inode(inode, really_sync, nr_to_write);
-
 		if (sync_mode == WB_SYNC_HOLD) {
 			mapping->dirtied_when = jiffies;
 			list_del(&inode->i_list);
 			list_add(&inode->i_list, &inode->i_sb->s_dirty);
 		}
-
 		if (current_is_pdflush())
 			writeback_release(bdi);
-
+		spin_unlock(&inode_lock);
+		iput(inode);
+		spin_lock(&inode_lock);
 		if (nr_to_write && *nr_to_write <= 0)
 			break;
 	}


-
