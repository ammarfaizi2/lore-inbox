Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUFHTWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUFHTWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUFHTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:22:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:27611 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265294AbUFHTWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:22:50 -0400
Subject: [PATCH] writeback_inodes can race with unmount
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086722523.10973.157.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 15:22:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a small window where the filesystem can be unmounted during
writeback_inodes.  The end result is the iput done by sync_sb_inodes
could be done after the FS put_super and and the super has been removed
from all lists.

The fix is to hold the s_umount sem during sync_sb_inodes to make sure
the FS doesn't get unmounted.

Index: linux.t/fs/fs-writeback.c
===================================================================
--- linux.t.orig/fs/fs-writeback.c	2004-06-08 14:45:49.000000000 -0400
+++ linux.t/fs/fs-writeback.c	2004-06-08 14:47:58.000000000 -0400
@@ -360,9 +360,18 @@ restart:
 	sb = sb_entry(super_blocks.prev);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
 		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
+			/* we're making our own get_super here */
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			sync_sb_inodes(sb, wbc);
+			/* if we can't get the readlock, there's no sense in
+			 * waiting around, most of the time the FS is going
+			 * to be unmounted by the time it is released
+			 */
+			if (down_read_trylock(&sb->s_umount)) {
+				if (sb->s_root)
+					sync_sb_inodes(sb, wbc);
+				up_read(&sb->s_umount);
+			}
 			spin_lock(&sb_lock);
 			if (__put_super(sb))
 				goto restart;


