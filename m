Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSEIMBt>; Thu, 9 May 2002 08:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSEIMBs>; Thu, 9 May 2002 08:01:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6125 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290289AbSEIMBs>; Thu, 9 May 2002 08:01:48 -0400
Date: Thu, 9 May 2002 13:03:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, Christoph Rohland <cr@sap.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] double flush_page_to_ram
Message-ID: <Pine.LNX.4.21.0205091252350.1205-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

filemap_nopage and shmem_nopage do flush_page_to_ram before returning
page, but do_no_page also does flush_page_to_ram on any page it slots
into the user address space.  It's memory.c's business, remove it from
shmem and filemap (and cut outdated comment from when filemap copied).

Hugh

--- 2.5.14/mm/filemap.c	Wed May  8 20:42:40 2002
+++ linux/mm/filemap.c	Thu May  9 12:49:10 2002
@@ -1532,12 +1532,7 @@
 		goto page_not_uptodate;
 
 success:
-	/*
-	 * Found the page and have a reference on it, need to check sharing
-	 * and possibly copy it over to another page..
-	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 
 no_cached_page:
--- 2.5.14/mm/shmem.c	Wed May  1 12:22:32 2002
+++ linux/mm/shmem.c	Thu May  9 12:49:25 2002
@@ -638,7 +638,6 @@
 	if (shmem_getpage(inode, idx, &page))
 		return page;
 
-	flush_page_to_ram(page);
 	return(page);
 }
 

