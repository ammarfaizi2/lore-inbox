Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUINJtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUINJtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUINJtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:49:50 -0400
Received: from asplinux.ru ([195.133.213.194]:41222 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269242AbUINJtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:49:46 -0400
Message-ID: <4146C15F.1040605@sw.ru>
Date: Tue, 14 Sep 2004 14:01:03 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mason@suse.com
Subject: [PATCH] Rearrange of inode_lock in writeback_inodes()
Content-Type: multipart/mixed;
 boundary="------------080502030503050208020807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502030503050208020807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch reaaranges inode_lock taking in writeback_inodes().
It narrows down use of inode_lock and removes unneccassary nesting of 
sb_lock and inode_lock.
Instead of holding inode_lock for all the time I moved it around
sync_sb_inodes() as it is in all other places.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------080502030503050208020807
Content-Type: text/plain;
 name="diff-sb-lock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-sb-lock"

--- ./fs/fs-writeback.c.sblock	2004-09-14 11:07:36.000000000 +0400
+++ ./fs/fs-writeback.c	2004-09-14 11:13:23.931085680 +0400
@@ -392,7 +392,6 @@ writeback_inodes(struct writeback_contro
 {
 	struct super_block *sb;
 
-	spin_lock(&inode_lock);
 	spin_lock(&sb_lock);
 restart:
 	sb = sb_entry(super_blocks.prev);
@@ -407,8 +406,11 @@ restart:
 			 * be unmounted by the time it is released.
 			 */
 			if (down_read_trylock(&sb->s_umount)) {
-				if (sb->s_root)
+				if (sb->s_root) {
+					spin_lock(&inode_lock);
 					sync_sb_inodes(sb, wbc);
+					spin_unlock(&inode_lock);
+				}
 				up_read(&sb->s_umount);
 			}
 			spin_lock(&sb_lock);
@@ -425,7 +427,6 @@ restart:
 			break;
 	}
 	spin_unlock(&sb_lock);
-	spin_unlock(&inode_lock);
 }
 
 /*

--------------080502030503050208020807--

