Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAPOWL>; Tue, 16 Jan 2001 09:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131057AbRAPOWB>; Tue, 16 Jan 2001 09:22:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6582 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129523AbRAPOV5>; Tue, 16 Jan 2001 09:21:57 -0500
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, nkbj@image.dk
Subject: [Patch2] shmem fixes for 2.4.1-pre7
In-Reply-To: <qwwofx7g0a5.fsf@sap.com>
Organisation: SAP LinuxLab
Date: 16 Jan 2001 15:20:44 +0100
In-Reply-To: <qwwofx7g0a5.fsf@sap.com>
Message-ID: <qww4ryzfuir.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2001, Christoph Rohland wrote:
> Here is a patch against 2.4.1-pre7 which
> 
> 1) Adds prototype for shmem_lock to mm.h
> 2) Again brings the fixes for the accounting. I still think it
>    should be applied.

And of course the prototype should be extern...

Greetings
		Christoph

diff -uNr 1-pre7/include/linux/mm.h m1-pre7/include/linux/mm.h
--- 1-pre7/include/linux/mm.h	Tue Jan 16 09:33:02 2001
+++ m1-pre7/include/linux/mm.h	Tue Jan 16 09:34:20 2001
@@ -386,6 +386,7 @@
 
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share);
 struct file *shmem_file_setup(char * name, loff_t size);
+extern void shmem_lock(struct file * file, int lock);
 extern int shmem_zero_setup(struct vm_area_struct *);
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
diff -uNr 1-pre7/mm/shmem.c m1-pre7/mm/shmem.c
--- 1-pre7/mm/shmem.c	Tue Jan 16 09:33:02 2001
+++ m1-pre7/mm/shmem.c	Tue Jan 16 09:33:45 2001
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
