Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUGMN1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUGMN1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUGMN1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:27:22 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:7915 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S265137AbUGMN1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:27:03 -0400
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix inode state corruption (2.6.8-rc1-bk1)
Message-Id: <E1BkNI0-0007j5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 Jul 2004 15:25:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch fixes a hard-to-trigger condition, where the inode is on
the inode_in_use list while it's state is dirty.  In this state dirty
pages are not written back in sync() or from kupdate, only from direct
page reclaim.  And this causes a livelock in balance_dirty_pages after
a while.

Please apply!

The actual sequence of events required to get into this state is:

thread   function                             inode state         inode list
----------------------------------------------------------------------------
1 __sync_single_inode (background)            I_DIRTY             sb->s_io
1 do_writepages ...                           I_LOCKED
2 __writeback_single_inode (sync) sleeps      I_LOCKED
1 __sync_single_inode (background) finish     0                   inode_in_use
2 __writeback_single_inode (sync) wakeup      0
2 __sync_single_inode (sync)                  0  
2 do_writepages ...                           I_LOCKED
3 __mark_inode_dirty                          I_LOCKED | I_DIRTY
2 __sync_single_inode (sync) finish           I_DIRTY             left on
                                                                  inode_in_use

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

==============================================================================
--- linux-2.6.8-rc1-bk1/fs/fs-writeback.c.orig	2004-07-13 12:59:58.000000000 +0200
+++ linux-2.6.8-rc1-bk1/fs/fs-writeback.c	2004-07-13 14:31:07.000000000 +0200
@@ -213,8 +213,17 @@ __sync_single_inode(struct inode *inode,
 		} else if (inode->i_state & I_DIRTY) {
 			/*
 			 * Someone redirtied the inode while were writing back
-			 * the pages: nothing to do.
+			 * the pages.
 			 */
+			if (wait) {
+				/*
+				 * It is possible that this function is entered
+				 * with the inode on the in_use list, and it
+				 * is dirtied during being locked, in which
+				 * case it must be moved onto the dirty list.
+				 */
+				list_move(&inode->i_list, &sb->s_dirty);
+			}
 		} else if (atomic_read(&inode->i_count)) {
 			/*
 			 * The inode is clean, inuse
