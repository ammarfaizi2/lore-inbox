Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129070AbRBCTDI>; Sat, 3 Feb 2001 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129122AbRBCTC6>; Sat, 3 Feb 2001 14:02:58 -0500
Received: from www.wen-online.de ([212.223.88.39]:63759 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129070AbRBCTCt>;
	Sat, 3 Feb 2001 14:02:49 -0500
Date: Sat, 3 Feb 2001 20:02:40 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch?] RAMFS
Message-ID: <Pine.Linu.4.10.10102031945190.396-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the patch below, ramfs will withstand make -j20 (binutils)
even while an iozone is running, and cp /dev/zero zero.  These
fail as is.  The problem seems to be in the way writepage() is
called.. ClearPageDirty(); writepage().  That screws up ramfs's
beancounting and makes it wipe pages and do double accounting.
(df;cp /dev/zero zero;rm zero;df to see accounting woes).

Accounting only from ramfs_prepare_write() seems to be enough for
the page limit to function (whodathunkit;)

	-Mike

--- linux-2.4.1.ac2/fs/ramfs/inode.c.org	Sat Feb  3 10:29:54 2001
+++ linux-2.4.1.ac2/fs/ramfs/inode.c	Sat Feb  3 19:22:08 2001
@@ -173,11 +173,8 @@
 	       (inode->i_data.nrpages <= rsb->max_file_pages) ) ) {
 		inode->i_blocks += IBLOCKS_PER_PAGE;
 		rsb->free_pages--;
-		SetPageDirty(page);
-	} else {
-		ClearPageUptodate(page);
+	} else
 		ret = 0;
-	}
 	
 	unlock_rsb(rsb);
 
@@ -259,13 +256,7 @@
  */
 static int ramfs_writepage(struct page *page)
 {
-	struct inode *inode = (struct inode *)page->mapping->host;
-
-	if (! ramfs_alloc_page(inode, page))
-	{
-		UnlockPage(page);
-		return -ENOSPC;
-	}
+	SetPageDirty(page);
 	UnlockPage(page);
 	return 0;
 }
@@ -275,9 +266,8 @@
 	struct inode *inode = (struct inode *)page->mapping->host;
 	void *addr;
 	
-	if (! ramfs_alloc_page(inode, page)) {
+	if (! ramfs_alloc_page(inode, page))
 		return -ENOSPC;
-	}
 
 	addr = (void *) kmap(page);
 	if (!Page_Uptodate(page)) {
@@ -285,6 +275,7 @@
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
+	SetPageDirty(page);
 	return 0;
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
