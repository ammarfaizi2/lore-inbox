Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSFAImv>; Sat, 1 Jun 2002 04:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFAImM>; Sat, 1 Jun 2002 04:42:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314433AbSFAIkW>;
	Sat, 1 Jun 2002 04:40:22 -0400
Message-ID: <3CF88940.29CFAE0F@zip.com.au>
Date: Sat, 01 Jun 2002 01:43:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/16] put in-memory filesystem dirty pages on the correct list
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Replaces SetPageDirty() with set_page_dirty() in several places related
to in-memory filesystems.

SetPageDirty() is basically always the wrong thing to do.  Pages should
be moved to the ->dirty_pages list when dirtied so that writeback can
see them.

Without this change, dirty pages against in-memory filesystems would
churn around on the inactive list all the time, rather than getting
pushed away onto the active list.  A minor efficiency thing.


=====================================

--- 2.5.19/mm/shmem.c~shmem	Sat Jun  1 01:18:13 2002
+++ 2.5.19-akpm/mm/shmem.c	Sat Jun  1 01:18:13 2002
@@ -854,7 +854,7 @@ shmem_file_write(struct file *file,const
 
 		flush_dcache_page(page);
 		if (bytes > 0) {
-			SetPageDirty(page);
+			set_page_dirty(page);
 			written += bytes;
 			count -= bytes;
 			pos += bytes;
@@ -1139,7 +1139,7 @@ static int shmem_symlink(struct inode * 
 		kaddr = kmap(page);
 		memcpy(kaddr, symname, len);
 		kunmap(page);
-		SetPageDirty(page);
+		set_page_dirty(page);
 		unlock_page(page);
 		page_cache_release(page);
 		up(&info->sem);
--- 2.5.19/mm/filemap.c~shmem	Sat Jun  1 01:18:13 2002
+++ 2.5.19-akpm/mm/filemap.c	Sat Jun  1 01:18:13 2002
@@ -450,7 +450,7 @@ int fail_writepage(struct page *page)
 	}
 
 	/* Set the page dirty again, unlock */
-	SetPageDirty(page);
+	set_page_dirty(page);
 	unlock_page(page);
 	return 0;
 }

-
