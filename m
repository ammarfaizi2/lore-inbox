Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267891AbRGRO0F>; Wed, 18 Jul 2001 10:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbRGROZ4>; Wed, 18 Jul 2001 10:25:56 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:49414
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S267889AbRGROZr>; Wed, 18 Jul 2001 10:25:47 -0400
Date: Wed, 18 Jul 2001 10:25:20 -0400
From: Chris Mason <mason@suse.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs b_count usage
Message-ID: <203060000.995466320@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

This patch changes reiserfs to use get_bh and put_bh everywhere,
instead of mucking around with b_count directly.  In general,
reiserfs uses brelse when doing the final release on a buffer,
and it already has the buffer pinned during i/o because it wants
to wait on the buffer later.  In other words, we should not have
the same races as in fs/buffer.c, but I made this patch to keep
track with the changes there.

One hunk depends on the direct->indirect cleanup patch
I posted last week (linus, I called this flushlist-3.diff in the
batch I just sent you).  I can supply one against pure pre7 if you
would like.

Reiserfs already had a marco called get_bh, which was used
to get a pointer to the last buffer head in a path in the tree.  I've
renamed that to get_last_bh.

Linus, please apply:

diff -Nru a/fs/reiserfs/do_balan.c b/fs/reiserfs/do_balan.c
--- a/fs/reiserfs/do_balan.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/do_balan.c	Thu Jul 12 10:57:27 2001
@@ -1626,7 +1626,7 @@
     for (i = 0; i < sizeof (tb->thrown)/sizeof (tb->thrown[0]); i ++)
 	if (!tb->thrown[i]) {
 	    tb->thrown[i] = bh;
-	    atomic_inc(&bh->b_count) ; /* decremented in free_thrown */
+	    get_bh(bh) ; /* free_thrown puts this */
 	    return;
 	}
     reiserfs_warning ("store_thrown: too many thrown buffers\n");
diff -Nru a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
--- a/fs/reiserfs/fix_node.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/fix_node.c	Thu Jul 12 10:57:27 2001
@@ -1030,7 +1030,7 @@
 		     left, left);
     }
 #endif
-    atomic_dec (&(left->b_count));
+    put_bh(left) ;
     return 1;
   }
 
@@ -1123,7 +1123,7 @@
 	    n_first_last_position = B_NR_ITEMS (p_s_parent);
 	if ( n_position != n_first_last_position ) {
 	    *pp_s_com_father = p_s_parent;
-	    atomic_inc (&((*pp_s_com_father)->b_count));
+	    get_bh(*pp_s_com_father) ;
 	    /*(*pp_s_com_father = p_s_parent)->b_count++;*/
 	    break;
 	}
@@ -1228,8 +1228,8 @@
 	/* Current node is not the first child of its parent. */
 	/*(p_s_curf = p_s_curcf = PATH_OFFSET_PBUFFER(p_s_path, n_path_offset - 1))->b_count += 2;*/
 	p_s_curf = p_s_curcf = PATH_OFFSET_PBUFFER(p_s_path, n_path_offset - 1);
-	atomic_inc (&(p_s_curf->b_count));
-	atomic_inc (&(p_s_curf->b_count));
+	get_bh(p_s_curf) ;
+	get_bh(p_s_curf) ;
 	p_s_tb->lkey[n_h] = n_position - 1;
     }
     else  {
@@ -1267,8 +1267,8 @@
 /* Current node is not the last child of its parent F[n_h]. */
 	/*(p_s_curf = p_s_curcf = PATH_OFFSET_PBUFFER(p_s_path, n_path_offset - 1))->b_count += 2;*/
 	p_s_curf = p_s_curcf = PATH_OFFSET_PBUFFER(p_s_path, n_path_offset - 1);
-	atomic_inc (&(p_s_curf->b_count));
-	atomic_inc (&(p_s_curf->b_count));
+	get_bh(p_s_curf) ;
+	get_bh(p_s_curf) ;
 	p_s_tb->rkey[n_h] = n_position;
     }	
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/inode.c	Thu Jul 12 10:57:27 2001
@@ -274,7 +274,7 @@
     }
     
     //
-    bh = get_bh (&path);
+    bh = get_last_bh (&path);
     ih = get_ih (&path);
     if (is_indirect_le_ih (ih)) {
 	__u32 * ind_item = (__u32 *)B_I_PITEM (bh, ih);
@@ -369,7 +369,7 @@
 	if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND)
 	    // we read something from tail, even if now we got IO_ERROR
 	    break;
-	bh = get_bh (&path);
+	bh = get_last_bh (&path);
 	ih = get_ih (&path);
     } while (1);
 
@@ -577,7 +577,7 @@
 	goto failure;
     }
 	
-    bh = get_bh (&path);
+    bh = get_last_bh (&path);
     ih = get_ih (&path);
     item = get_item (&path);
     pos_in_item = path.pos_in_item;
@@ -823,7 +823,7 @@
 	    pathrelse(&path) ;
 	    goto failure;
 	}
-	bh = get_bh (&path);
+	bh = get_last_bh (&path);
 	ih = get_ih (&path);
 	item = get_item (&path);
 	pos_in_item = path.pos_in_item;
@@ -1050,7 +1050,7 @@
 	** FS might change.  We have to detect that, and loop back to the
 	** search if the stat data item has moved
 	*/
-	bh = get_bh(&path) ;
+	bh = get_last_bh(&path) ;
 	ih = get_ih(&path) ;
 	copy_item_head (&tmp_ih, ih);
 	fs_gen = get_generation (inode->i_sb);
@@ -1679,7 +1679,7 @@
 	goto out ;
     } 
 
-    bh = get_bh(&path) ;
+    bh = get_last_bh(&path) ;
     ih = get_ih(&path) ;
     item = get_item(&path) ;
     pos_in_item = path.pos_in_item ;
@@ -1761,7 +1761,7 @@
     for(i = 0 ; i < nr ; i++) {
         bh = bhp[i] ;
 	lock_buffer(bh) ;
-	atomic_inc(&bh->b_count) ; /* async end_io handler decs this */
+	get_bh(bh) ;		   /* async end_io handler puts this */
 	set_buffer_async_io(bh) ;
 	/* submit_bh doesn't care if the buffer is dirty, but nobody
 	** later on in the call chain will be cleaning it.  So, we
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/journal.c	Thu Jul 12 10:57:27 2001
@@ -707,7 +707,7 @@
       }
       ll_rw_block(WRITE, 1, &tbh) ;
       count++ ;
-      atomic_dec(&(tbh->b_count)) ; /* once for our get_hash */
+      put_bh(tbh) ; /* once for our get_hash */
     } 
   }
 
@@ -722,7 +722,7 @@
       if (!buffer_uptodate(tbh)) {
 	reiserfs_panic(s, "journal-601, buffer write failed\n") ;
       }
-      atomic_dec(&(tbh->b_count)) ; /* once for our get_hash */
+      put_bh(tbh) ; /* once for our get_hash */
       bforget(tbh) ;    /* once due to original getblk in do_journal_end */
       atomic_dec(&(jl->j_commit_left)) ;
     }
@@ -869,9 +869,11 @@
     }
     mark_buffer_uptodate(bh, uptodate) ;
     unlock_buffer(bh) ;
+    put_bh(bh) ;
 }
 static void submit_logged_buffer(struct buffer_head *bh) {
     lock_buffer(bh) ;
+    get_bh(bh) ;
     bh->b_end_io = reiserfs_end_buffer_io_sync ;
     mark_buffer_notjournal_new(bh) ;
     clear_bit(BH_Dirty, &bh->b_state) ;
@@ -967,13 +969,13 @@
       /* we do this to make sure nobody releases the buffer while 
       ** we are working with it 
       */
-      atomic_inc(&(saved_bh->b_count)) ;  
+      get_bh(saved_bh) ;
 
       if (buffer_journal_dirty(saved_bh)) {
         was_jwait = 1 ;
 	mark_buffer_notjournal_dirty(saved_bh) ;
-        /* brelse the inc from journal_mark_dirty */
-	atomic_dec(&(saved_bh->b_count)) ; 
+        /* undo the inc from journal_mark_dirty */
+	put_bh(saved_bh) ;
       }
       if (can_dirty(cn)) {
         was_dirty = 1 ;
@@ -1016,7 +1018,7 @@
     } 
     if (was_dirty) { 
       /* we inc again because saved_bh gets decremented at free_cnode */
-      atomic_inc(&(saved_bh->b_count)) ;  
+      get_bh(saved_bh) ;
       set_bit(BLOCK_NEEDS_FLUSH, &cn->state) ;
       submit_logged_buffer(saved_bh) ;
       count++ ;
@@ -1029,7 +1031,7 @@
     cn = cn->next ;
     if (saved_bh) {
       /* we incremented this to keep others from taking the buffer head away */
-      atomic_dec(&(saved_bh->b_count)); 
+      put_bh(saved_bh) ;
       if (atomic_read(&(saved_bh->b_count)) < 0) {
         printk("journal-945: saved_bh->b_count < 0") ;
       }
@@ -2176,7 +2178,7 @@
     cn->jlist = NULL ;
     insert_journal_hash(SB_JOURNAL(p_s_sb)->j_hash_table, cn) ;
     if (!count_already_incd) {
-      atomic_inc(&(bh->b_count)) ;
+      get_bh(bh) ;
     }
   }
   cn->next = NULL ;
@@ -2248,7 +2250,7 @@
 
   if (!already_cleaned) {
     mark_buffer_notjournal_dirty(bh) ; 
-    atomic_dec(&(bh->b_count)) ;
+    put_bh(bh) ;
     if (atomic_read(&(bh->b_count)) < 0) {
       printk("journal-1752: remove from trans, b_count < 0\n") ;
     }
@@ -2580,7 +2582,7 @@
 	    */
 	    mark_buffer_notjournal_dirty(cn->bh) ;
 	    cleaned = 1 ;
-	    atomic_dec(&(cn->bh->b_count)) ;
+	    put_bh(cn->bh) ;
 	    if (atomic_read(&(cn->bh->b_count)) < 0) {
 	      printk("journal-2138: cn->bh->b_count < 0\n") ;
 	    }
@@ -2597,7 +2599,7 @@
 
   if (bh) {
     reiserfs_clean_and_file_buffer(bh) ;
-    atomic_dec(&(bh->b_count)) ; /* get_hash incs this */
+    put_bh(bh) ; /* get_hash grabs the buffer */
     if (atomic_read(&(bh->b_count)) < 0) {
       printk("journal-2165: bh->b_count < 0\n") ;
     }
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/namei.c	Thu Jul 12 10:57:27 2001
@@ -72,7 +72,7 @@
 // comment?  maybe something like set de to point to what the path points to?
 static inline void set_de_item_location (struct reiserfs_dir_entry * de, struct path * path)
 {
-    de->de_bh = get_bh (path);
+    de->de_bh = get_last_bh (path);
     de->de_ih = get_ih (path);
     de->de_deh = B_I_DEH (de->de_bh, de->de_ih);
     de->de_item_num = PATH_LAST_POSITION (path);
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Thu Jul 12 10:57:27 2001
+++ b/fs/reiserfs/stree.c	Thu Jul 12 10:57:27 2001
@@ -436,7 +436,7 @@
             ) { 
   if ( p_s_bh ) {
     if ( atomic_read (&(p_s_bh->b_count)) ) {
-      atomic_dec (&(p_s_bh->b_count));
+      put_bh(p_s_bh) ;
       return;
     }
     reiserfs_panic(NULL, "PAP-5070: decrement_bcount: trying to free free buffer %b", p_s_bh);
@@ -1032,7 +1032,7 @@
     }
     
     /* Cut one record from the directory item. */
-    *cut_size = -(DEH_SIZE + entry_length (get_bh (path), le_ih, pos_in_item (path)));
+    *cut_size = -(DEH_SIZE + entry_length (get_last_bh (path), le_ih, pos_in_item (path)));
     return M_CUT; 
 }
 
@@ -1945,15 +1945,15 @@
     struct item_head * found_ih = get_ih (path);
     
     if (is_direct_le_ih (found_ih)) {
-	if (le_ih_k_offset (found_ih) + op_bytes_number (found_ih, get_bh (path)->b_size) !=
+	if (le_ih_k_offset (found_ih) + op_bytes_number (found_ih, get_last_bh (path)->b_size) !=
 	    cpu_key_k_offset (p_s_key) ||
-	    op_bytes_number (found_ih, get_bh (path)->b_size) != pos_in_item (path))
+	    op_bytes_number (found_ih, get_last_bh (path)->b_size) != pos_in_item (path))
 	    reiserfs_panic (0, "PAP-5720: check_research_for_paste: "
 			    "found direct item %h or position (%d) does not match to key %K",
 			    found_ih, pos_in_item (path), p_s_key);
     }
     if (is_indirect_le_ih (found_ih)) {
-	if (le_ih_k_offset (found_ih) + op_bytes_number (found_ih, get_bh (path)->b_size) != cpu_key_k_offset (p_s_key) || 
+	if (le_ih_k_offset (found_ih) + op_bytes_number (found_ih, get_last_bh (path)->b_size) != cpu_key_k_offset (p_s_key) || 
 	    I_UNFM_NUM (found_ih) != pos_in_item (path) ||
 	    get_ih_free_space (found_ih) != 0)
 	    reiserfs_panic (0, "PAP-5730: check_research_for_paste: "
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu Jul 12 11:01:21 2001
+++ b/fs/buffer.c	Thu Jul 12 11:01:21 2001
@@ -71,17 +71,6 @@
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_inode_buffers)
 
-static inline void get_bh(struct buffer_head * bh)
-{
-	atomic_inc(&(bh)->b_count);
-}
-
-static inline void put_bh(struct buffer_head *bh)
-{
-	smp_mb__before_atomic_dec();
-	atomic_dec(&bh->b_count);
-}
-
 /*
  * Hash table gook..
  */
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Jul 12 11:01:21 2001
+++ b/include/linux/fs.h	Thu Jul 12 11:01:21 2001
@@ -1069,6 +1069,17 @@
 #define BUF_PROTECTED	3	/* Ramdisk persistent storage */
 #define NR_LIST		4
 
+static inline void get_bh(struct buffer_head * bh)
+{
+        atomic_inc(&(bh)->b_count);
+}
+
+static inline void put_bh(struct buffer_head *bh)
+{
+        smp_mb__before_atomic_dec();
+        atomic_dec(&bh->b_count);
+}
+
 /*
  * This is called by bh->b_end_io() handlers when I/O has completed.
  */
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu Jul 12 11:01:21 2001
+++ b/include/linux/reiserfs_fs.h	Thu Jul 12 11:01:21 2001
@@ -1102,7 +1106,7 @@
 
 #define PATH_H_PATH_OFFSET(p_s_path, n_h) ((p_s_path)->path_length - (n_h))
 
-#define get_bh(path) PATH_PLAST_BUFFER(path)
+#define get_last_bh(path) PATH_PLAST_BUFFER(path)
 #define get_ih(path) PATH_PITEM_HEAD(path)
 #define get_item_pos(path) PATH_LAST_POSITION(path)
 #define get_item(path) ((void *)B_N_PITEM(PATH_PLAST_BUFFER(path), PATH_LAST_POSITION (path)))

