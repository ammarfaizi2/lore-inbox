Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLSU74>; Tue, 19 Dec 2000 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbQLSU7q>; Tue, 19 Dec 2000 15:59:46 -0500
Received: from [200.230.208.16] ([200.230.208.16]:27922 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S129601AbQLSU72>;
	Tue, 19 Dec 2000 15:59:28 -0500
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
Organization: Tech Informatica
To: linux-kernel@vger.kernel.org
Subject: Possible patch for reiserfs-3.6.22 against 2.4.0-test12 w/ new_writepage
Date: Tue, 19 Dec 2000 18:25:39 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00121918343602.00804@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Testers are welcome :-)

diff -Nur --exclude=Documentation linux-vanila/fs/buffer.c linux-reiser/fs/buffer.c
--- linux-vanila/fs/buffer.c	Tue Dec 19 17:59:32 2000
+++ linux-reiser/fs/buffer.c	Tue Dec 19 16:26:55 2000
@@ -827,6 +827,10 @@
 	return;
 }
 
+void set_buffer_async_io(struct buffer_head *bh) {
+	bh->b_end_io = end_buffer_io_async ;
+}
+
 /*
  * Synchronise all the inode's dirty buffers to the disk.
  *
diff -Nur --exclude=Documentation linux-vanila/fs/reiserfs/inode.c linux-reiser/fs/reiserfs/inode.c
--- linux-vanila/fs/reiserfs/inode.c	Tue Dec 19 17:59:32 2000
+++ linux-reiser/fs/reiserfs/inode.c	Tue Dec 19 16:52:51 2000
@@ -356,8 +356,6 @@
 
     // read file tail into part of page
     offset = (cpu_key_k_offset(&key) - 1) & (PAGE_CACHE_SIZE - 1) ;
-    fs_gen = get_generation(inode->i_sb) ;
-    copy_item_head (&tmp_ih, ih);
 
     /* we only want to kmap if we are reading the tail into the page.
     ** this is not the common case, so we don't kmap until we are
@@ -1569,9 +1567,12 @@
     return ;
 }
 
-static int map_and_dirty_block(struct inode *inode, 
+static int map_block_for_writepage(struct inode *inode, 
 			       struct buffer_head *bh_result, 
                                unsigned long block) {
+                               
+                               
+                               
     struct reiserfs_transaction_handle th ;
     int fs_gen ;
     struct item_head tmp_ih ;
@@ -1620,16 +1621,26 @@
 	    goto out ;
 	}
 	set_block_dev_mapped(bh_result, le32_to_cpu(item[pos_in_item]), inode);
-	mark_buffer_dirty(bh_result) ;
     } else if (is_direct_le_ih(ih)) {
         char *p ; 
         p = page_address(bh_result->b_page) ;
         p += (byte_offset -1) & (PAGE_CACHE_SIZE - 1) ;
         copy_size = le16_to_cpu(ih->ih_item_len) - pos_in_item ;
+
+	fs_gen = get_generation(inode->i_sb) ;
+	copy_item_head(&tmp_ih, ih) ;
+	reiserfs_prepare_for_journal(inode->i_sb, bh, 1) ;
+	if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
+	    reiserfs_restore_prepared_buffer(inode->i_sb, bh) ;
+	    goto research;
+	}
+
 	memcpy( B_I_PITEM(bh, ih) + pos_in_item, p + bytes_copied, copy_size) ;
 
 	journal_mark_dirty(&th, inode->i_sb, bh) ;
 	bytes_copied += copy_size ;
+	
+	set_block_dev_mapped(bh_result, 0, inode);
 
 	/* are there still bytes left? */
         if (bytes_copied < bh_result->b_size && 
@@ -1650,15 +1661,14 @@
     allow_flush_page_lock(bh_result->b_page, inode) ;
     unlock_kernel() ;
 
+    /* this is where we fill in holes in the file. */
     if (use_get_block) {
         kmap(bh_result->b_page) ;
 	retval = reiserfs_get_block(inode, block, bh_result, 1) ;
         kunmap(bh_result->b_page) ;
 	if (!retval) {
-	    if (buffer_mapped(bh_result) && bh_result->b_blocknr != 0) {
-		mark_buffer_dirty(bh_result) ;
-	    } else {
-	        /* get_block failed to find a mapped formatted node. */
+	    if (!buffer_mapped(bh_result) || bh_result->b_blocknr == 0) {
+		/* get_block failed to find a mapped unformatted node. */
 		use_get_block = 0 ;
 		goto start_over ;
 	    }
@@ -1667,6 +1677,16 @@
     return retval ;
 }
 
+/* helper func to get a buffer head ready for writepage to send to
+** ll_rw_block
+*/
+static inline void ready_bh_for_writepage(struct buffer_head *bh) {
+    atomic_inc(&bh->b_count) ; /* async end_io handler decs this */
+    set_buffer_async_io(bh) ;
+    set_bit(BH_Dirty, &bh->b_state) ;
+    set_bit(BH_Uptodate, &bh->b_state) ;
+}
+
 static int reiserfs_write_full_page(struct page *page) {
     struct inode *inode = (struct inode *)page->mapping->host ;
     unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT ;
@@ -1676,17 +1696,24 @@
     unsigned cur_offset = 0 ;
     struct buffer_head *head, *bh ;
     int partial = 0 ;
-
+    
+    struct buffer_head *arr[PAGE_CACHE_SIZE/512] ;
+    int nr = 0 ;
+    
     if (!page->buffers) {
         block_prepare_write(page, 0, 0, NULL) ;
 	kunmap(page) ;
     }
-    /* last page in the file */
+
+    /* last page in the file, zero out any contents past the
+    ** last byte in the file
+    */    
     if (page->index >= end_index) {
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    return -EIO ;
+		error =  -EIO ;
+		goto fail ;		
 	}
 	memset((char *)kmap(page)+last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
 	flush_dcache_page(page) ;
@@ -1701,32 +1728,52 @@
 	    if (!buffer_uptodate(bh))
 	        partial = 1 ;
 	} else {
-	    /* this end_io handler is exactly the same as end_buffer_io_sync */
-	    bh->b_end_io = reiserfs_journal_end_io ;
-
-	    /* buffer mapped to an unformatted node */
+	    /* fast path, buffer mapped to an unformatted node */
 	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
-		mark_buffer_dirty(bh) ;
+		ready_bh_for_writepage(bh) ;
+		arr[nr++] = bh ;
 	    } else {
 		/* buffer not mapped yet, or points to a direct item.
 		** search and dirty or log
 		*/
-		if ((error = map_and_dirty_block(inode, bh, block))) {
+		if ((error = map_block_for_writepage(inode, bh, block))) {
 		    goto fail ;
 		}
+		/* map_block_for_writepage either found an unformatted node
+		** and mapped it for us, or it found a direct item
+		** and logged the changes.  
+		*/
+		if (buffer_mapped(bh) && bh->b_blocknr != 0) {
+		    ready_bh_for_writepage(bh) ;
+		    arr[nr++] = bh ;
+		}
 	    }
 	}
         bh = bh->b_this_page ;
 	cur_offset += bh->b_size ;
 	block++ ;
     } while(bh != head) ;
-
+    
+    /* if this page only had a direct item, it is very possible for
+    ** nr == 0 without there being any kind of error.
+    */
+    if (nr) {
+        ll_rw_block(WRITE, nr, arr) ;
+    } else {
+        UnlockPage(page) ;
+    }
     if (!partial)
         SetPageUptodate(page) ;
 
     return 0 ;
 
 fail:
+    if (nr) {
+        ll_rw_block(WRITE, nr, arr) ;
+    } else {
+        UnlockPage(page) ;
+    }
+
     ClearPageUptodate(page) ;
     return error ;
 }
@@ -1739,11 +1786,10 @@
     return block_read_full_page (page, reiserfs_get_block);
 }
 
-
 //
 // modified from ext2_writepage is
 //
-static int reiserfs_writepage (struct file *f, struct page * page)
+static int reiserfs_writepage (struct page * page)
 {
     struct inode *inode = (struct inode *)page->mapping->host ;
     reiserfs_wait_on_write_block(inode->i_sb) ;
diff -Nur --exclude=Documentation linux-vanila/fs/reiserfs/journal.c linux-reiser/fs/reiserfs/journal.c
--- linux-vanila/fs/reiserfs/journal.c	Tue Dec 19 17:59:32 2000
+++ linux-reiser/fs/reiserfs/journal.c	Tue Dec 19 17:32:30 2000
@@ -1762,7 +1762,7 @@
   ct->p_s_sb = p_s_sb ;
   ct->jindex = jindex ;
   ct->task_done = NULL ;
-  ct->task.next = NULL ;
+  INIT_LIST_HEAD(&ct->task.list);
   ct->task.sync = 0 ;
   ct->task.routine = (void *)(void *)reiserfs_journal_commit_task_func ; 
   ct->self = ct ;
@@ -1802,6 +1802,7 @@
   exit_files(current);
   exit_mm(current);
 
+  printk("reiserfs_journal_commit_thread\n");
   spin_lock_irq(&current->sigmask_lock);
   sigfillset(&current->blocked);
   recalc_sigpending(current);
@@ -1812,17 +1813,23 @@
   sprintf(current->comm, "kreiserfsd") ;
   lock_kernel() ;
   while(1) {
-
-    while(reiserfs_commit_thread_tq) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
+    while(!list_empty(&reiserfs_commit_thread_tq)) {
+      printk("while\n");
+      my_run_task_queue(&reiserfs_commit_thread_tq) ;
     }
 
     /* if there aren't any more filesystems left, break */
     if (reiserfs_mounted_fs_count <= 0) {
-      run_task_queue(&reiserfs_commit_thread_tq) ;
+      printk("reiserfs_mounted_fs_count >=0\n");
+      my_run_task_queue(&reiserfs_commit_thread_tq) ;
       break ;
+    } else {
+    	printk("reiserfs_mounted_fs_count < 0 :-)\n");
     }
+        
+    printk("wake_up\n");
     wake_up(&reiserfs_commit_thread_done) ;
+    printk("interruptible_sleep_on_timeout\n");
     interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5) ;
   }
   unlock_kernel() ;
@@ -3202,6 +3209,3 @@
   wake_up(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
   return 0 ;
 }
-
-
-
diff -Nur --exclude=Documentation linux-vanila/fs/reiserfs/namei.c linux-reiser/fs/reiserfs/namei.c
--- linux-vanila/fs/reiserfs/namei.c	Tue Dec 19 17:59:32 2000
+++ linux-reiser/fs/reiserfs/namei.c	Tue Dec 19 17:22:16 2000
@@ -1136,7 +1136,7 @@
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
 #if 0
 	    // FIXME: do we need this? shouldn't we simply continue?
-	    run_task_queue(&tq_disk);
+	    my_run_task_queue(&tq_disk);
 	    current->policy |= SCHED_YIELD;
 	    /*current->counter = 0;*/
 	    schedule();
diff -Nur --exclude=Documentation linux-vanila/fs/reiserfs/stree.c linux-reiser/fs/reiserfs/stree.c
--- linux-vanila/fs/reiserfs/stree.c	Tue Dec 19 17:59:33 2000
+++ linux-reiser/fs/reiserfs/stree.c	Tue Dec 19 17:22:32 2000
@@ -1295,7 +1295,7 @@
 #endif
 
 #ifdef __KERNEL__
-		run_task_queue(&tq_disk);
+		my_run_task_queue(&tq_disk);
 		current->policy |= SCHED_YIELD;
 		schedule();
 #endif
diff -Nur --exclude=Documentation linux-vanila/include/linux/fs.h linux-reiser/include/linux/fs.h
--- linux-vanila/include/linux/fs.h	Tue Dec 19 17:58:45 2000
+++ linux-reiser/include/linux/fs.h	Tue Dec 19 16:29:46 2000
@@ -991,6 +991,9 @@
 extern int try_to_free_buffers(struct page *, int);
 extern void refile_buffer(struct buffer_head * buf);
 
+/* reiserfs_writepage needs this */
+extern void set_buffer_async_io(struct buffer_head *bh) ;
+
 #define BUF_CLEAN	0
 #define BUF_LOCKED	1	/* Buffers scheduled for write */
 #define BUF_DIRTY	2	/* Dirty buffers, not yet scheduled for write */
diff -Nur --exclude=Documentation linux-vanila/include/linux/reiserfs_fs.h linux-reiser/include/linux/reiserfs_fs.h
--- linux-vanila/include/linux/reiserfs_fs.h	Tue Dec 19 17:58:45 2000
+++ linux-reiser/include/linux/reiserfs_fs.h	Tue Dec 19 17:23:49 2000
@@ -2076,4 +2076,30 @@
  			         
 #endif /* _LINUX_REISER_FS_H */
 
+extern inline void my_run_task_queue(task_queue *list)
+{
+		unsigned long flags;
+		struct list_head *next;
+
+		spin_lock_irqsave(&tqueue_lock, flags);
+		next = list->next;
+		if (next != list) {
+			void *arg;
+			void (*f) (void *);
+			struct tq_struct *p;
+
+			list_del(next);
+			p = list_entry(next, struct tq_struct, list);
+			arg = p->data;
+			f = p->routine;
+			p->sync = 0;
+			spin_unlock_irqrestore(&tqueue_lock, flags);
+
+			if (f)
+				f(arg);
+			return;
+		}
+		spin_unlock_irqrestore(&tqueue_lock, flags);
+}
+
 
diff -Nur --exclude=Documentation linux-vanila/kernel/ksyms.c linux-reiser/kernel/ksyms.c
--- linux-vanila/kernel/ksyms.c	Tue Dec 19 17:58:47 2000
+++ linux-reiser/kernel/ksyms.c	Tue Dec 19 16:29:14 2000
@@ -159,6 +159,7 @@
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
+EXPORT_SYMBOL(set_buffer_async_io); /* for reiserfs_writepage */
 EXPORT_SYMBOL(__mark_buffer_dirty);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);



-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
