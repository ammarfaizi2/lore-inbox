Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270185AbTGUPvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270440AbTGUPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:43:31 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:12809 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270187AbTGUPkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:40:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_access cleanup (6/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:55:10 +0900
Message-ID: <871xwjx4bl.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, this reads ->free_clusters without lock_fat() in fat_statfs().


 fs/fat/inode.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff -puN fs/fat/inode.c~fat_access-cleanup3 fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_access-cleanup3	2003-07-21 02:48:21.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:21.000000000 +0900
@@ -1024,19 +1024,23 @@ out_fail:
 
 int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
-	int free,nr;
+	int free, nr;
        
-	lock_fat(sb);
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		free = MSDOS_SB(sb)->free_clusters;
 	else {
-		free = 0;
-		for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++)
-			if (fat_access(sb, nr, -1) == FAT_ENT_FREE)
-				free++;
-		MSDOS_SB(sb)->free_clusters = free;
+		lock_fat(sb);
+		if (MSDOS_SB(sb)->free_clusters != -1)
+			free = MSDOS_SB(sb)->free_clusters;
+		else {
+			free = 0;
+			for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++)
+				if (fat_access(sb, nr, -1) == FAT_ENT_FREE)
+					free++;
+			MSDOS_SB(sb)->free_clusters = free;
+		}
+		unlock_fat(sb);
 	}
-	unlock_fat(sb);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = 1 << MSDOS_SB(sb)->cluster_bits;

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
