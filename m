Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLRPFm>; Mon, 18 Dec 2000 10:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbQLRPFc>; Mon, 18 Dec 2000 10:05:32 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:21477 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129325AbQLRPF1>; Mon, 18 Dec 2000 10:05:27 -0500
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3
In-Reply-To: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 18 Dec 2000 15:34:10 +0100
In-Reply-To: Linus Torvalds's message of "Sun, 17 Dec 2000 13:55:09 -0800 (PST)"
Message-ID: <qwwelz5er31.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 17 Dec 2000, Linus Torvalds wrote:
> The shmfs cleanup should be unnoticeable except to users who use SAP
> with huge shared memory segments, where Christoph Rohlands work not
> only makes the code much more readable, it should also make it
> dependable..

 :-)

The appended patch fixes the following:

1) We cannot unlock the page in shmem_writepage on ooswap since
   page_launder will do this later.

2) We should set the inode number of SYSV segments to the (user) shmid
   and not the internal id.

Greetings
		Christoph

diff -uNr 4-13-3/mm/shmem.c c/mm/shmem.c
--- 4-13-3/mm/shmem.c	Mon Dec 18 15:08:32 2000
+++ c/mm/shmem.c	Mon Dec 18 15:13:10 2000
@@ -210,37 +210,39 @@
 {
 	int error;
 	struct shmem_inode_info *info;
-	swp_entry_t *entry;
+	swp_entry_t *entry, swap;
 
 	info = &((struct inode *)page->mapping->host)->u.shmem_i;
 	if (info->locked)
 		return 1;
-	spin_lock(&info->lock);
-	entry = shmem_swp_entry (info, page->index);
-	if (!entry)	/* this had been allocted on page allocation */
-		BUG();
-	error = -EAGAIN;
-	if (entry->val)
-		goto out;
-
 	/*
 	 * 1 means "cannot write out".
 	 * We can't drop dirty pages
 	 * just because we ran out of
 	 * swap.
 	 */
-	error = 1;
-	*entry = __get_swap_page(2);
-	if (!entry->val)
+	swap = __get_swap_page(2);
+	if (!swap.val)
+		return 1;
+
+	spin_lock(&info->lock);
+	entry = shmem_swp_entry (info, page->index);
+	if (!entry)	/* this had been allocted on page allocation */
+		BUG();
+	error = -EAGAIN;
+	if (entry->val) {
+                __swap_free(swap, 2);
 		goto out;
+        }
 
+        *entry = swap;
 	error = 0;
 	/* Remove the from the page cache */
 	lru_cache_del(page);
 	remove_inode_page(page);
 
 	/* Add it to the swap cache */
-	add_to_swap_cache(page,*entry);
+	add_to_swap_cache(page, swap);
 	page_cache_release(page);
 	SetPageDirty(page);
 	info->swapped++;
diff -uNr 4-13-3/ipc/shm.c c/ipc/shm.c
--- 4-13-3/ipc/shm.c	Mon Dec 18 15:08:32 2000
+++ c/ipc/shm.c	Mon Dec 18 15:13:58 2000
@@ -220,7 +220,7 @@
 	shp->shm_segsz = size;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
-	file->f_dentry->d_inode->i_ino = id;
+	file->f_dentry->d_inode->i_ino = shp->id;
 	file->f_op = &shm_file_operations;
 	shm_tot += numpages;
 	shm_unlock (id);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
