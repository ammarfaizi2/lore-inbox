Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRARQnU>; Thu, 18 Jan 2001 11:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbRARQnB>; Thu, 18 Jan 2001 11:43:01 -0500
Received: from [62.172.234.2] ([62.172.234.2]:52066 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130392AbRARQmy>; Thu, 18 Jan 2001 11:42:54 -0500
Date: Thu, 18 Jan 2001 16:39:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        bfennema@falcon.csc.calpoly.edu, dave@trylinux.com,
        linux_udf@hootie.lvld.hp.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] udf writepage UnlockPage
In-Reply-To: <Pine.LNX.4.21.0101152017450.1032-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0101181629260.4091-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although fs/udf's args to writepage() were updated in 2.4.0-test12,
its page unlocking was overlooked.  udf_adinicb_writepage() should
now UnlockPage, udf_expand_file_adinicb() should not now UnlockPage
after udf_writepage i.e. block_write_full_page.  Al Viro posted a
patch for the latter, still lurking in Alan's -ac9; the former seems
to have gone unnoticed.  Warning: from source inspection: untested.

Hugh

--- linux-2.4.1-pre8/fs/udf/file.c	Fri Dec 29 22:07:57 2000
+++ linux/fs/udf/file.c	Thu Jan 18 15:42:11 2001
@@ -86,6 +86,7 @@
 	brelse(bh);
 	SetPageUptodate(page);
 	kunmap(page);
+	UnlockPage(page);
 	return 0;
 }
 
--- linux-2.4.1-pre8/fs/udf/inode.c	Tue Dec  5 17:41:51 2000
+++ linux/fs/udf/inode.c	Thu Jan 18 15:43:50 2001
@@ -203,7 +203,6 @@
 	udf_release_data(bh);
 
 	inode->i_data.a_ops->writepage(page);
-	UnlockPage(page);
 	page_cache_release(page);
 
 	mark_inode_dirty(inode);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
