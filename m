Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSFLC7Q>; Tue, 11 Jun 2002 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317313AbSFLC7P>; Tue, 11 Jun 2002 22:59:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55421 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317312AbSFLC7M>; Tue, 11 Jun 2002 22:59:12 -0400
Date: Wed, 12 Jun 2002 03:58:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs 4/4 swapoff tweaks
In-Reply-To: <Pine.LNX.4.21.0206120348170.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120357010.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several simple speedups to tmpfs swapoff: without patch, swapoff of a
kernel tree in tmpfs might take take 2 minutes, with patch 4 seconds.
Inline search go no further than necessary; only search inode when it
has swapped pages; start next search from same inode; list in order.

--- 2.4.19-pre10/mm/shmem.c	Tue Jun 11 19:02:30 2002
+++ linux/mm/shmem.c	Tue Jun 11 19:02:30 2002
@@ -372,28 +372,30 @@
 	clear_inode(inode);
 }
 
-static int shmem_clear_swp (swp_entry_t entry, swp_entry_t *ptr, int size) {
+static inline int shmem_find_swp(swp_entry_t entry, swp_entry_t *ptr, swp_entry_t *eptr)
+{
 	swp_entry_t *test;
 
-	for (test = ptr; test < ptr + size; test++) {
-		if (test->val == entry.val) {
-			swap_free (entry);
-			*test = (swp_entry_t) {0};
+	for (test = ptr; test < eptr; test++) {
+		if (test->val == entry.val)
 			return test - ptr;
-		}
 	}
 	return -1;
 }
 
-static int shmem_unuse_inode (struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
+static int shmem_unuse_inode(struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
 	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
-	
+
 	idx = 0;
+	ptr = info->i_direct;
 	spin_lock (&info->lock);
-	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
+	offset = info->next_index;
+	if (offset > SHMEM_NR_DIRECT)
+		offset = SHMEM_NR_DIRECT;
+	offset = shmem_find_swp(entry, ptr, ptr + offset);
 	if (offset >= 0)
 		goto found;
 
@@ -402,13 +404,18 @@
 		ptr = shmem_swp_entry(info, idx, 0);
 		if (IS_ERR(ptr))
 			continue;
-		offset = shmem_clear_swp (entry, ptr, ENTRIES_PER_PAGE);
+		offset = info->next_index - idx;
+		if (offset > ENTRIES_PER_PAGE)
+			offset = ENTRIES_PER_PAGE;
+		offset = shmem_find_swp(entry, ptr, ptr + offset);
 		if (offset >= 0)
 			goto found;
 	}
 	spin_unlock (&info->lock);
 	return 0;
 found:
+	swap_free(entry);
+	ptr[offset] = (swp_entry_t) {0};
 	delete_from_swap_cache(page);
 	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
 	SetPageDirty(page);
@@ -419,7 +426,7 @@
 }
 
 /*
- * unuse_shmem() search for an eventually swapped out shmem page.
+ * shmem_unuse() search for an eventually swapped out shmem page.
  */
 void shmem_unuse(swp_entry_t entry, struct page *page)
 {
@@ -430,8 +437,12 @@
 	list_for_each(p, &shmem_inodes) {
 		info = list_entry(p, struct shmem_inode_info, list);
 
-		if (shmem_unuse_inode(info, entry, page))
+		if (info->swapped && shmem_unuse_inode(info, entry, page)) {
+			/* move head to start search for next from here */
+			list_del(&shmem_inodes);
+			list_add_tail(&shmem_inodes, p);
 			break;
+		}
 	}
 	spin_unlock (&shmem_ilock);
 }
@@ -721,7 +732,7 @@
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
 			spin_lock (&shmem_ilock);
-			list_add (&SHMEM_I(inode)->list, &shmem_inodes);
+			list_add_tail(&SHMEM_I(inode)->list, &shmem_inodes);
 			spin_unlock (&shmem_ilock);
 			break;
 		case S_IFDIR:
@@ -1163,7 +1174,7 @@
 		}
 		inode->i_op = &shmem_symlink_inode_operations;
 		spin_lock (&shmem_ilock);
-		list_add (&info->list, &shmem_inodes);
+		list_add_tail(&info->list, &shmem_inodes);
 		spin_unlock (&shmem_ilock);
 		down(&info->sem);
 		page = shmem_getpage_locked(info, inode, 0);

