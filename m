Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137199AbRA1Ov4>; Sun, 28 Jan 2001 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143381AbRA1Ovq>; Sun, 28 Jan 2001 09:51:46 -0500
Received: from [62.172.234.2] ([62.172.234.2]:14209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S137199AbRA1Ovc>; Sun, 28 Jan 2001 09:51:32 -0500
Date: Sun, 28 Jan 2001 14:43:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        bfennema@falcon.csc.calpoly.edu, dave@trylinux.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] udf writepage UnlockPage
In-Reply-To: <Pine.LNX.4.21.0101181629260.4091-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0101281415550.1554-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although fs/udf's args to writepage() were updated in 2.4.0-test12,
its page unlocking was overlooked.  udf_adinicb_writepage() should
now UnlockPage, udf_expand_file_adinicb() should not now UnlockPage
after udf_writepage i.e. block_write_full_page.  Al Viro posted a
patch for the latter, still lurking in Alan's -ac12; the former seems
to have gone unnoticed.  Warning: from source inspection: untested.

(Originally sent ten days ago against 2.4.1-pre8, no comments
received: today seems topical to resend against 2.4.1-pre10.)

Hugh

--- linux-2.4.1-pre10/fs/udf/file.c	Fri Dec 29 22:07:57 2000
+++ linux/fs/udf/file.c	Thu Jan 18 15:42:11 2001
@@ -86,6 +86,7 @@
 	brelse(bh);
 	SetPageUptodate(page);
 	kunmap(page);
+	UnlockPage(page);
 	return 0;
 }
 
--- linux-2.4.1-pre10/fs/udf/inode.c	Tue Dec  5 17:41:51 2000
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
