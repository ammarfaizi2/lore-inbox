Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbQLQVe2>; Sun, 17 Dec 2000 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132219AbQLQVeT>; Sun, 17 Dec 2000 16:34:19 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:25574 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132042AbQLQVeK>; Sun, 17 Dec 2000 16:34:10 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] shm cleanup
In-Reply-To: <Pine.LNX.4.10.10012170933270.25120-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10012170933270.25120-100000@penguin.transmeta.com>
Message-ID: <m34s022251.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 17 Dec 2000 22:06:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> The only comment I have is that as far as I can tell, your shm_writepage()
> has a small bug: if "__get_swap_page()" fails, we can't just drop the
> dirty page in question, so instead of returning -ENOMEM we should really
> return a "1" to tell the VM to keep the page dirty.

Right, here comes the (incremental) patch

        Christoph

diff -uNr c/mm/shmem.c c1/mm/shmem.c
--- c/mm/shmem.c	Sun Dec 17 21:31:46 2000
+++ c1/mm/shmem.c	Sun Dec 17 21:35:08 2000
@@ -210,31 +210,33 @@
 {
 	int error;
 	struct shmem_inode_info *info;
-	swp_entry_t *entry;
+	swp_entry_t *entry, swap;
 
 	info = &((struct inode *)page->mapping->host)->u.shmem_i;
 	if (info->locked)
 		return 1;
+	swap = __get_swap_page(2);
+	if (!swap.val)
+		return 1;
+
 	spin_lock(&info->lock);
 	entry = shmem_swp_entry (info, page->index);
 	if (!entry)	/* this had been allocted on page allocation */
 		BUG();
 	error = -EAGAIN;
-	if (entry->val)
-		goto out;
-
-	error = -ENOMEM;
-	*entry = __get_swap_page(2);
-	if (!entry->val)
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
