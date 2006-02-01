Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422922AbWBAUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422922AbWBAUQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWBAUQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 15:16:13 -0500
Received: from mx2.mail.ru ([194.67.23.122]:52741 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1422922AbWBAUQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 15:16:11 -0500
Date: Wed, 1 Feb 2006 23:04:10 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re [2]: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-ID: <20060201200410.GA11747@rain.homenetwork>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 02:46:34AM +0300, Alexey Dobriyan wrote:
> Copying files over several KB will buy you infinite loop in
> __getblk_slow(). Copying files smaller than 1 KB seems to be OK.
> Sometimes files will be filled with zeros. Sometimes incorrectly copied
> file will reappear after next file with truncated size.
The problem as can I see, in very strange code in
balloc.c:ufs_new_fragments. b_blocknr is changed without "restraint".

This patch just "workaround", not a clear solution. But it helps me
copy files more than 4K. Can you try it and say is it really help?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

--- linux-2.6.16-rc1-mm4/fs/ufs/balloc.c.orig	2006-02-01 22:55:28.245272250 +0300
+++ linux-2.6.16-rc1-mm4/fs/ufs/balloc.c	2006-02-01 22:47:33.455599750 +0300
@@ -241,7 +241,7 @@ unsigned ufs_new_fragments (struct inode
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
-	struct buffer_head * bh;
+	struct buffer_head * bh, *bh1;
 	unsigned cgno, oldcount, newcount, tmp, request, i, result;
 	
 	UFSD(("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count))
@@ -359,17 +359,23 @@ unsigned ufs_new_fragments (struct inode
 	if (result) {
 		for (i = 0; i < oldcount; i++) {
 			bh = sb_bread(sb, tmp + i);
-			if(bh)
-			{
-				clear_buffer_dirty(bh);
-				bh->b_blocknr = result + i;
+			bh1 = sb_getblk(sb, result+i);
+			if (bh && bh1)	{
+				memcpy(bh1->b_data, bh->b_data, bh->b_size);
+				
 				mark_buffer_dirty (bh);
-				if (IS_SYNC(inode))
+				mark_buffer_dirty(bh1);
+				if (IS_SYNC(inode)) {
 					sync_dirty_buffer(bh);
+					sync_dirty_buffer(bh1);
+				}
 				brelse (bh);
-			}
-			else
-			{
+				brelse(bh1);
+			} else {
+				if (bh)
+					brelse(bh);
+				if (bh1)
+					brelse(bh1);
 				printk(KERN_ERR "ufs_new_fragments: bread fail\n");
 				unlock_super(sb);
 				return 0;


-- 
/Evgeniy

