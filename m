Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSEZUgF>; Sun, 26 May 2002 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEZUgE>; Sun, 26 May 2002 16:36:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316384AbSEZUfn>;
	Sun, 26 May 2002 16:35:43 -0400
Message-ID: <3CF147DD.B4DB4687@zip.com.au>
Date: Sun, 26 May 2002 13:38:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/18] ext3 set_page_dirty fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The set_page_dirty() in the ext3_writepage() failure path isn't right. 
set_page_dirty() will alter buffer states - it's a "whole page"
dirtying.

__set_page_dirty_buffers() is emitting warnings when it refuses to set
dirty a non-uptodate buffer against a partially-mapped page.

All we want to do in there is to move the page back onto
mapping->dirty_pages, without altering the state of its buffers.

=====================================

--- 2.5.18/fs/ext3/inode.c~ext3-set_page_dirty	Sun May 26 12:37:43 2002
+++ 2.5.18-akpm/fs/ext3/inode.c	Sun May 26 12:37:43 2002
@@ -1327,7 +1327,13 @@ static int ext3_writepage(struct page *p
 out_fail:
 	
 	unlock_kernel();
-	set_page_dirty(page);
+
+	/*
+	 * We have to fail this writepage to avoid cross-fs transactions.
+	 * Put the page back on mapping->dirty_pages, but leave its buffer's
+	 * dirty state as-is.
+	 */
+	__set_page_dirty_nobuffers(page);
 	unlock_page(page);
 	return ret;
 }

-
