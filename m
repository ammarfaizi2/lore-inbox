Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132777AbRANSVX>; Sun, 14 Jan 2001 13:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132872AbRANSVO>; Sun, 14 Jan 2001 13:21:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:14048 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132777AbRANSVH>; Sun, 14 Jan 2001 13:21:07 -0500
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: SetPageDirty in shmem_nopage
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3zoguf115.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Jan 2001 19:25:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

While playing with the shmem read/write support I realised that the
accounting for shmem is broken:

Since we do not mark the page dirty at allocation time the vm can drop
it at any time as long as it is not written to. But shmem never
adjusts its accounting to that and will happily increase the use
counter for both the inode and the fs.

The appended patch fixes this by recalculating the inodes size in
nopage and writepage. With this change i_blocks is still an upper
bound of the real usage, but should be near the real value in normal
cases. At least it does not grow any more beyond the inodes size.

Any idea to handle this better? Else I think this should be applied.

Greetings
                Christoph

diff -uNr 2.4.0-nosymlink/mm/shmem.c 2.4.0-nosymlink-calc/mm/shmem.c
--- 2.4.0-nosymlink/mm/shmem.c	Sat Jan 13 14:18:26 2001
+++ 2.4.0-nosymlink-calc/mm/shmem.c	Sun Jan 14 18:42:04 2001
@@ -117,11 +117,43 @@
 	return 0;
 }
 
+/*
+ * shmem_recalc_inode - recalculate the size of an inode
+ *
+ * @inode: inode to recalc
+ *
+ * We have to calculate the free blocks since the mm can drop pages
+ * behind our back
+ *
+ * But we know that normally
+ * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
+ *
+ * So the mm freed 
+ * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
+ *
+ * It has to be called with the spinlock held.
+ */
+
+static void shmem_recalc_inode(struct inode * inode)
+{
+	unsigned long freed;
+
+	freed = inode->i_blocks -
+		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
+	if (freed){
+		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
+		inode->i_blocks -= freed;
+		spin_lock (&info->stat_lock);
+		info->free_blocks += freed;
+		spin_unlock (&info->stat_lock);
+	}
+}
+
 static void shmem_truncate (struct inode * inode)
 {
 	int clear_base;
 	unsigned long start;
-	unsigned long mmfreed, freed = 0;
+	unsigned long freed = 0;
 	swp_entry_t **base, **ptr;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
@@ -154,26 +186,9 @@
 	info->i_indirect = 0;
 
 out:
-
-	/*
-	 * We have to calculate the free blocks since we do not know
-	 * how many pages the mm discarded
-	 *
-	 * But we know that normally
-	 * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
-	 *
-	 * So the mm freed 
-	 * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
-	 */
-
-	mmfreed = inode->i_blocks - (inode->i_mapping->nrpages + info->swapped);
 	info->swapped -= freed;
-	inode->i_blocks -= freed + mmfreed;
+	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
-
-	spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
-	inode->i_sb->u.shmem_sb.free_blocks += freed + mmfreed;
-	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
 }
 
 static void shmem_delete_inode(struct inode * inode)
@@ -208,6 +223,7 @@
 		return 1;
 
 	spin_lock(&info->lock);
+	shmem_recalc_inode(page->mapping->host);
 	entry = shmem_swp_entry (info, page->index);
 	if (!entry)	/* this had been allocted on page allocation */
 		BUG();
@@ -269,6 +285,9 @@
 	entry = shmem_swp_entry (info, idx);
 	if (!entry)
 		goto oom;
+	spin_lock (&info->lock);
+	shmem_recalc_inode(inode);
+	spin_unlock (&info->lock);
 	if (entry->val) {
 		unsigned long flags;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
