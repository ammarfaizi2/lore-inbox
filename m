Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSLTSuN>; Fri, 20 Dec 2002 13:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSLTSuN>; Fri, 20 Dec 2002 13:50:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:10508 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264786AbSLTSuL>; Fri, 20 Dec 2002 13:50:11 -0500
Date: Fri, 20 Dec 2002 18:59:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Mikael Starvik <mikael.starvik@axis.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs read hang
Message-ID: <Pine.LNX.4.44.0212201853460.5562-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael <mikael.starvik@axis.com> reports that LTP read02 EFAULT test
hangs uninterruptibly on 2.4 when the testfile is on tmpfs.  I seem to
have fixed this unconsciously in 2.5, when aligning do_shmem_file_read's
loop with do_generic_file_read's loop, so here is that fix.  But the bug
actually came from having two "nr"s, one outside and one inside the loop.

Patch below applies to 2.4.21-pre2, and with offset to 2.4.20-ac2 and
everything back to 2.4.4: please apply.  I would like to prepare more
backports from 2.5 (and -ac) in due course: for example, Alan has long
had tighter large offset checking in shmem_file_write; but this read
hang is bad enough to single out for immediate fix.

Thank you, Mikael!
Hugh

--- 2.4.21-pre2/mm/shmem.c	Thu Nov 28 23:53:15 2002
+++ linux/mm/shmem.c	Fri Dec 20 17:39:41 2002
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

