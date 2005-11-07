Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVKGRkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVKGRkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVKGRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:40:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:47881 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965229AbVKGRkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:40:08 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat: use sb_find_get_block() instead of sb_getblk()
References: <87hdaotlci.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:36:25 +0900
In-Reply-To: <87hdaotlci.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:32:29 +0900")
Message-ID: <87d5lctl5y.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to allocate buffer for checking the buffer is uptodate.
This use sb_find_get_block() instead, and if it returns NULL it's not
uptodate.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/fat/dir.c~fat_dir_readahead-optimize fs/fat/dir.c
--- linux-2.6.14/fs/fat/dir.c~fat_dir_readahead-optimize	2005-11-07 03:58:44.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/dir.c	2005-11-07 03:58:44.000000000 +0900
@@ -45,8 +45,8 @@ static inline void fat_dir_readahead(str
 	if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
 		return;
 
-	bh = sb_getblk(sb, phys);
-	if (bh && !buffer_uptodate(bh)) {
+	bh = sb_find_get_block(sb, phys);
+	if (bh == NULL || !buffer_uptodate(bh)) {
 		for (sec = 0; sec < sbi->sec_per_clus; sec++)
 			sb_breadahead(sb, phys + sec);
 	}
_
