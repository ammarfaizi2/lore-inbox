Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317311AbSFLC5i>; Tue, 11 Jun 2002 22:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSFLC5h>; Tue, 11 Jun 2002 22:57:37 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31350 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317311AbSFLC5g>; Tue, 11 Jun 2002 22:57:36 -0400
Date: Wed, 12 Jun 2002 03:56:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs 3/4 partial truncate
In-Reply-To: <Pine.LNX.4.21.0206120348170.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120354290.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_truncate omitted to clear final partial page if that was on swap.
Found by Andrew's fsx testing on 2.5, this fix already went into 2.5.20.

--- 2.4.19-pre10/mm/shmem.c	Tue Jun 11 19:02:30 2002
+++ linux/mm/shmem.c	Tue Jun 11 19:02:30 2002
@@ -49,6 +49,8 @@
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
 
+static struct page *shmem_getpage_locked(struct shmem_inode_info *, struct inode *, unsigned long);
+
 #define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
 
 /*
@@ -313,6 +315,7 @@
 static void shmem_truncate (struct inode * inode)
 {
 	unsigned long index;
+	unsigned long partial;
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
@@ -320,6 +323,28 @@
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	partial = inode->i_size & ~PAGE_CACHE_MASK;
+
+	if (partial) {
+		swp_entry_t *entry = shmem_swp_entry(info, index-1, 0);
+		struct page *page;
+		/*
+		 * This check is racy: it's faintly possible that page
+		 * was assigned to swap during truncate_inode_pages,
+		 * and now assigned to file; but better than nothing.
+		 */
+		if (!IS_ERR(entry) && entry->val) {
+			spin_unlock(&info->lock);
+			page = shmem_getpage_locked(info, inode, index-1);
+			if (!IS_ERR(page)) {
+				memclear_highpage_flush(page, partial,
+					PAGE_CACHE_SIZE - partial);
+				UnlockPage(page);
+				page_cache_release(page);
+			}
+			spin_lock(&info->lock);
+		}
+	}
 
 	while (index < info->next_index) 
 		freed += shmem_truncate_indirect(info, index);

