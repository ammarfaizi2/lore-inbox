Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSIOJgA>; Sun, 15 Sep 2002 05:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSIOJgA>; Sun, 15 Sep 2002 05:36:00 -0400
Received: from [143.127.3.88] ([143.127.3.88]:1541 "EHLO mtvmime02.veritas.com")
	by vger.kernel.org with ESMTP id <S318009AbSIOJf7>;
	Sun, 15 Sep 2002 05:35:59 -0400
Date: Sun, 15 Sep 2002 10:41:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 4/5 three trivia
In-Reply-To: <Pine.LNX.4.44.0209151033190.10490-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151040300.10490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs contributes to the AltSysRqM swapcache add and delete
statistics, but not to its find statistics: use lookup_swap_cache
wrapper to find_get_page, to contribute to those statistics too.
Elsewhere, use existing info pointer and NAME_MAX definition.

--- tmpfs3/mm/shmem.c	Sat Sep 14 18:21:23 2002
+++ tmpfs4/mm/shmem.c	Sat Sep 14 18:21:23 2002
@@ -560,7 +560,7 @@
 		unsigned long flags;
 
 		/* Look it up and read it in.. */
-		page = find_get_page(&swapper_space, entry->val);
+		page = lookup_swap_cache(*entry);
 		if (!page) {
 			swp_entry_t swap = *entry;
 			spin_unlock (&info->lock);
@@ -734,7 +734,7 @@
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
 			spin_lock (&shmem_ilock);
-			list_add_tail(&SHMEM_I(inode)->list, &shmem_inodes);
+			list_add_tail(&info->list, &shmem_inodes);
 			spin_unlock (&shmem_ilock);
 			break;
 		case S_IFDIR:
@@ -1004,7 +1004,7 @@
 	buf->f_files = sbinfo->max_inodes;
 	buf->f_ffree = sbinfo->free_inodes;
 	spin_unlock (&sbinfo->stat_lock);
-	buf->f_namelen = 255;
+	buf->f_namelen = NAME_MAX;
 	return 0;
 }
 

