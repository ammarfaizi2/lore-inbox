Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133116AbRDZFvz>; Thu, 26 Apr 2001 01:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRDZFvp>; Thu, 26 Apr 2001 01:51:45 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:20240
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S133116AbRDZFvf>; Thu, 26 Apr 2001 01:51:35 -0400
Date: Thu, 26 Apr 2001 01:51:11 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: reiserfs-list@namesys.com
Subject: [PATCH] reiserfs highmem bug on tail reads
Message-ID: <79830000.988264271@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, so all the reiserfs tail bugs weren't quite fixed yet, the last
tail fix can cause problems with highmem turned on.  Both bugs are
in fs/reiserfs/inode.c:_get_block_create_0

When reading the tail in, if the buffer was already up to date, 
we skip the disk i/o and return.  But the cleanup code assumes the 
page was kmap'd, which isn't right.

Also, there was a chance to double kmap the page if kmap scheduled a
nd the tree balanced while we slept.  This bug has been there for 
a long time.

Anyway, this was tested with Andrea's HIGHMEM_DEBUG_MERE_MORTALS 
patch to force highmem on my 128MB machine.  It works for me, but 
more testers are always good.

-chris

against 2.4.4-pre6, should work against 2.4.3 or higher.

diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Wed Apr 25 23:15:14 2001
+++ b/fs/reiserfs/inode.c	Wed Apr 25 23:15:14 2001
@@ -374,9 +374,11 @@
     ** sure we need to.  But, this means the item might move if
     ** kmap schedules
     */
-    p = (char *)kmap(bh_result->b_page) ;
-    if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
-        goto research;
+    if (!p) {
+	p = (char *)kmap(bh_result->b_page) ;
+	if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
+	    goto research;
+	}
     }
     p += offset ;
     memset (p, 0, inode->i_sb->s_blocksize);
@@ -420,14 +422,15 @@
 	ih = get_ih (&path);
     } while (1);
 
+    flush_dcache_page(bh_result->b_page) ;
+    kunmap(bh_result->b_page) ;
+
 finished:
     pathrelse (&path);
     bh_result->b_blocknr = 0 ;
     bh_result->b_dev = inode->i_dev;
     mark_buffer_uptodate (bh_result, 1);
     bh_result->b_state |= (1UL << BH_Mapped);
-    flush_dcache_page(bh_result->b_page) ;
-    kunmap(bh_result->b_page) ;
     return 0;
 }
 





