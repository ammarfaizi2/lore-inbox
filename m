Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315348AbSEBSmR>; Thu, 2 May 2002 14:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEBSmQ>; Thu, 2 May 2002 14:42:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:269 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315348AbSEBSlk>;
	Thu, 2 May 2002 14:41:40 -0400
Message-ID: <3CD188D0.772540DD@zip.com.au>
Date: Thu, 02 May 2002 11:43:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] unneeded readpage in block_symlink
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new consistency checks in buffer.c are complaining about
block_symlink's ->readpage against an already uptodate
page.


--- 2.5.12/fs/buffer.c~block_symlink_fix	Thu May  2 10:27:42 2002
+++ 2.5.12-akpm/fs/buffer.c	Thu May  2 10:30:37 2002
@@ -2155,8 +2155,12 @@ int block_symlink(struct inode *inode, c
 	 * ->i_size will be enough for everything) and zero it out.
 	 * OTOH it's obviously correct and should make the page up-to-date.
 	 */
-	err = mapping->a_ops->readpage(NULL, page);
-	wait_on_page_locked(page);
+	if (!PageUptodate(page)) {
+		err = mapping->a_ops->readpage(NULL, page);
+		wait_on_page_locked(page);
+	} else {
+		unlock_page(page);
+	}
 	page_cache_release(page);
 	if (err < 0)
 		goto fail;


I've also received a report of a dirty unmapped buffer outside
i_size with ext3.   But that was against the rd.c driver, which
seems to be bust in 2.5.  This will take some hunting down.


-
