Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVCUSSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVCUSSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCUSSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:18:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:4102 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261445AbVCUSSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:18:17 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] FAT: set MS_NOATIME to msdos
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Mar 2005 03:17:47 +0900
Message-ID: <87mzsw2790.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches is fixes and improvements for ->adate of msdos.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



MSDOS doesn't have atime, so this sets MS_NOATIME to msdos in order
that we don't get unnecessary writes.

Signed-off-by: Werner Almesberger <werner@almesberger.net>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c   |    3 ++-
 fs/msdos/namei.c |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -puN fs/fat/inode.c~fat_msdos-use-noatime fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~fat_msdos-use-noatime	2005-03-16 11:11:45.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-16 11:13:30.000000000 +0900
@@ -431,7 +431,8 @@ static void __exit fat_destroy_inodecach
 
 static int fat_remount(struct super_block *sb, int *flags, char *data)
 {
-	*flags |= MS_NODIRATIME;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	*flags |= MS_NODIRATIME | (sbi->options.isvfat ? 0 : MS_NOATIME);
 	return 0;
 }
 
diff -puN fs/msdos/namei.c~fat_msdos-use-noatime fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~fat_msdos-use-noatime	2005-03-16 11:12:11.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-16 11:13:38.000000000 +0900
@@ -671,6 +671,7 @@ static int msdos_fill_super(struct super
 	if (res)
 		return res;
 
+	sb->s_flags |= MS_NOATIME;
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
 }
_
