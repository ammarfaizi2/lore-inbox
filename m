Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLaR3B>; Tue, 31 Dec 2002 12:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSLaR3B>; Tue, 31 Dec 2002 12:29:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19381 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S264610AbSLaR3A>; Tue, 31 Dec 2002 12:29:00 -0500
Date: Tue, 31 Dec 2002 17:38:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Amar Lior <lior@cs.huji.ac.il>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem
In-Reply-To: <Pine.LNX.4.20_heb2.08.0212311818280.29471-100000@mos214.cs.huji.ac.il>
Message-ID: <Pine.LNX.4.44.0212311717400.1688-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002, Amar Lior wrote:
> 
> I found a bug that cause the kernel to lockup.

In 2.4, yes.  Coincidentally, Mikael Starvik reported this just a
couple of weeks ago, though it has been lurking there for a long time.
In 2.5 it was fixed (in ignorance of the problem) a little while ago,
and Marcelo already has fix below in his BK tree towards 2.4.20-pre3.

Anyway, thanks a lot for making sure we know about it.  (The code was
_nearly_ right, the loop should have terminated when nr returned from
file_read_actor becomes 0: but there were _two_ declarations of nr,
and the nr tested to terminate the loop remained 1 throughout).

Hugh

diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Thu Dec 26 22:32:38 2002
+++ b/mm/shmem.c	Thu Dec 26 22:32:38 2002
@@ -919,14 +919,13 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned long index, offset;
-	int nr = 1;
 
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
-	while (nr && desc->count) {
+	for (;;) {
 		struct page *page;
-		unsigned long end_index, nr;
+		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 		if (index > end_index)
@@ -956,12 +955,14 @@
 		 * "pos" here (the actor routine has to update the user buffer
 		 * pointers and the remaining count).
 		 */
-		nr = file_read_actor(desc, page, offset, nr);
-		offset += nr;
+		ret = file_read_actor(desc, page, offset, nr);
+		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 	
 		page_cache_release(page);
+		if (ret != nr || !desc->count)
+			break;
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;

