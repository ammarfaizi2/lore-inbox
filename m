Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWENIPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWENIPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 04:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWENIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 04:15:20 -0400
Received: from mx2.mail.ru ([194.67.23.122]:14894 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751375AbWENIPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 04:15:17 -0400
Date: Sun, 14 May 2006 12:18:23 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] ufs: right block allocation
Message-ID: <20060514081823.GA1588@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solve such problems:
* After block allocation, we map it on the same "address" as 8 others
 blocks
* We nullify block several times: once in ufs/block.c 
and once in block_*write_full_page, and use different "caches" for this.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/balloc.c linux-2.6.17-rc4/fs/ufs/balloc.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/balloc.c	2006-05-14 10:17:38.612965750 +0400
+++ linux-2.6.17-rc4/fs/ufs/balloc.c	2006-05-14 10:05:57.697161250 +0400
@@ -223,18 +223,6 @@ failed:
 }
 
 
-
-#define NULLIFY_FRAGMENTS \
-	for (i = oldcount; i < newcount; i++) { \
-		bh = sb_getblk(sb, result + i); \
-		memset (bh->b_data, 0, sb->s_blocksize); \
-		set_buffer_uptodate(bh); \
-		mark_buffer_dirty (bh); \
-		if (IS_SYNC(inode)) \
-			sync_dirty_buffer(bh); \
-		brelse (bh); \
-	}
-
 unsigned ufs_new_fragments (struct inode * inode, __fs32 * p, unsigned fragment,
 	unsigned goal, unsigned count, int * err )
 {
@@ -312,7 +300,6 @@ unsigned ufs_new_fragments (struct inode
 			*err = 0;
 			inode->i_blocks += count << uspi->s_nspfshift;
 			UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
-			NULLIFY_FRAGMENTS
 		}
 		unlock_super(sb);
 		UFSD(("EXIT, result %u\n", result))
@@ -327,7 +314,6 @@ unsigned ufs_new_fragments (struct inode
 		*err = 0;
 		inode->i_blocks += count << uspi->s_nspfshift;
 		UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
-		NULLIFY_FRAGMENTS
 		unlock_super(sb);
 		UFSD(("EXIT, result %u\n", result))
 		return result;
@@ -379,7 +365,6 @@ unsigned ufs_new_fragments (struct inode
 		*err = 0;
 		inode->i_blocks += count << uspi->s_nspfshift;
 		UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
-		NULLIFY_FRAGMENTS
 		unlock_super(sb);
 		if (newcount < request)
 			ufs_free_fragments (inode, result + newcount, request - newcount);
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/inode.c linux-2.6.17-rc4/fs/ufs/inode.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/inode.c	2006-05-14 10:17:38.980988750 +0400
+++ linux-2.6.17-rc4/fs/ufs/inode.c	2006-05-14 10:05:57.713162250 +0400
@@ -161,6 +161,18 @@ out:
 	return ret;
 }
 
+static inline void ufs_clear_block(struct inode *inode, struct buffer_head *bh)
+{
+	lock_buffer(bh);
+	memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+	set_buffer_uptodate(bh);
+	mark_buffer_dirty(bh);
+	unlock_buffer(bh);
+	if (IS_SYNC(inode))
+		sync_dirty_buffer(bh);
+}
+
+
 static struct buffer_head * ufs_inode_getfrag (struct inode *inode,
 	unsigned int fragment, unsigned int new_fragment,
 	unsigned int required, int *err, int metadata, long *phys, int *new)
@@ -204,7 +216,7 @@ repeat:
 			brelse (result);
 			goto repeat;
 		} else {
-			*phys = tmp;
+			*phys = tmp+blockoff;
 			return NULL;
 		}
 	}
@@ -259,14 +271,11 @@ repeat:
 		return NULL;
 	}
 
-	/* The nullification of framgents done in ufs/balloc.c is
-	 * something I don't have the stomache to move into here right
-	 * now. -DaveM
-	 */
 	if (metadata) {
 		result = sb_getblk(inode->i_sb, tmp + blockoff);
+		ufs_clear_block(inode, result);
 	} else {
-		*phys = tmp;
+		*phys = tmp+blockoff;
 		result = NULL;
 		*err = 0;
 		*new = 1;
@@ -333,7 +342,7 @@ repeat:
 			brelse (result);
 			goto repeat;
 		} else {
-			*phys = tmp;
+			*phys = tmp+blockoff;
 			goto out;
 		}
 	}
@@ -349,14 +358,12 @@ repeat:
 		goto out;
 	}		
 
-	/* The nullification of framgents done in ufs/balloc.c is
-	 * something I don't have the stomache to move into here right
-	 * now. -DaveM
-	 */
+
 	if (metadata) {
 		result = sb_getblk(sb, tmp + blockoff);
+		ufs_clear_block(inode, result);
 	} else {
-		*phys = tmp;
+		*phys = tmp+blockoff;
 		*new = 1;
 	}
 

-- 
/Evgeniy

