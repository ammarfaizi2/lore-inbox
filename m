Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289779AbSBKOap>; Mon, 11 Feb 2002 09:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289809AbSBKOaK>; Mon, 11 Feb 2002 09:30:10 -0500
Received: from angband.namesys.com ([212.16.7.85]:19584 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289795AbSBKOZP>; Mon, 11 Feb 2002 09:25:15 -0500
Date: Mon, 11 Feb 2002 17:25:08 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [6 of 8] 06-kmalloc_cleanup.diff
Message-ID: <20020211172508.F1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Convert all the code to use reiserfs_{kmalloc,kfree}. Remove all extra
   reiserfs_{kmalloc,kfree} overhead if CONFIG_REISERFS_CHECK is not set.


--- linux.orig/fs/reiserfs/dir.c	Mon Feb 11 09:28:48 2002
+++ linux/fs/reiserfs/dir.c	Mon Feb 11 10:18:41 2002
@@ -115,13 +115,13 @@
 		if (d_reclen <= 32) {
 		  local_buf = small_buf ;
 		} else {
-		    local_buf = kmalloc(d_reclen, GFP_NOFS) ;
+		    local_buf = reiserfs_kmalloc(d_reclen, GFP_NOFS, inode->i_sb) ;
 		    if (!local_buf) {
 			pathrelse (&path_to_entry);
 			return -ENOMEM ;
 		    }
 		    if (item_moved (&tmp_ih, &path_to_entry)) {
-			kfree(local_buf) ;
+			reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 			goto research;
 		    }
 		}
@@ -133,12 +133,12 @@
 		if (filldir (dirent, local_buf, d_reclen, d_off, d_ino, 
 		             DT_UNKNOWN) < 0) {
 		    if (local_buf != small_buf) {
-			kfree(local_buf) ;
+			reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 		    }
 		    goto end;
 		}
 		if (local_buf != small_buf) {
-		    kfree(local_buf) ;
+		    reiserfs_kfree(local_buf, d_reclen, inode->i_sb) ;
 		}
 
 		// next entry should be looked for with such offset
--- linux.orig/fs/reiserfs/fix_node.c	Mon Feb 11 09:28:48 2002
+++ linux/fs/reiserfs/fix_node.c	Mon Feb 11 10:18:41 2002
@@ -1979,7 +1979,7 @@
     return CARRY_ON;
 }
 
-
+#ifdef CONFIG_REISERFS_CHECK
 void * reiserfs_kmalloc (size_t size, int flags, struct super_block * s)
 {
     void * vp;
@@ -2007,6 +2007,7 @@
 	reiserfs_warning ("vs-8302: reiserfs_kfree: allocated memory %d\n", s->u.reiserfs_sb.s_kmallocs);
 
 }
+#endif
 
 
 static int get_virtual_node_size (struct super_block * sb, struct buffer_head * bh)
--- linux.orig/fs/reiserfs/journal.c	Mon Feb 11 09:28:48 2002
+++ linux/fs/reiserfs/journal.c	Mon Feb 11 10:18:41 2002
@@ -118,13 +118,13 @@
   struct reiserfs_bitmap_node *bn ;
   static int id = 0 ;
 
-  bn = kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS) ;
+  bn = reiserfs_kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS, p_s_sb) ;
   if (!bn) {
     return NULL ;
   }
-  bn->data = kmalloc(p_s_sb->s_blocksize, GFP_NOFS) ;
+  bn->data = reiserfs_kmalloc(p_s_sb->s_blocksize, GFP_NOFS, p_s_sb) ;
   if (!bn->data) {
-    kfree(bn) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
     return NULL ;
   }
   bn->id = id++ ;
@@ -159,8 +159,8 @@
                                     struct reiserfs_bitmap_node *bn) {
   SB_JOURNAL(p_s_sb)->j_used_bitmap_nodes-- ;
   if (SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes > REISERFS_MAX_BITMAP_NODES) {
-    kfree(bn->data) ;
-    kfree(bn) ;
+    reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
   } else {
     list_add(&bn->list, &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
     SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes++ ;
@@ -228,8 +228,8 @@
   while(next != &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) {
     bn = list_entry(next, struct reiserfs_bitmap_node, list) ;
     list_del(next) ;
-    kfree(bn->data) ;
-    kfree(bn) ;
+    reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
+    reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
     next = SB_JOURNAL(p_s_sb)->j_bitmap_nodes.next ;
     SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes-- ;
   }
@@ -1507,13 +1507,13 @@
   }
   trans_id = le32_to_cpu(desc->j_trans_id) ;
   /* now we know we've got a good transaction, and it was inside the valid time ranges */
-  log_blocks = kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS) ;
-  real_blocks = kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS) ;
+  log_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
+  real_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
   if (!log_blocks  || !real_blocks) {
     brelse(c_bh) ;
     brelse(d_bh) ;
-    kfree(log_blocks) ;
-    kfree(real_blocks) ;
+    reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+    reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
     reiserfs_warning("journal-1169: kmalloc failed, unable to mount FS\n") ;
     return -1 ;
   }
@@ -1532,8 +1532,8 @@
       brelse_array(real_blocks, i) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
   }
@@ -1547,8 +1547,8 @@
       brelse_array(real_blocks, le32_to_cpu(desc->j_len)) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
     memcpy(real_blocks[i]->b_data, log_blocks[i]->b_data, real_blocks[i]->b_size) ;
@@ -1567,8 +1567,8 @@
       brelse_array(real_blocks + i, le32_to_cpu(desc->j_len) - i) ;
       brelse(c_bh) ;
       brelse(d_bh) ;
-      kfree(log_blocks) ;
-      kfree(real_blocks) ;
+      reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+      reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
       return -1 ;
     }
     brelse(real_blocks[i]) ;
@@ -1584,8 +1584,8 @@
   SB_JOURNAL(p_s_sb)->j_trans_id = trans_id + 1;
   brelse(c_bh) ;
   brelse(d_bh) ;
-  kfree(log_blocks) ;
-  kfree(real_blocks) ;
+  reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
+  reiserfs_kfree(real_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), p_s_sb) ;
   return 0 ;
 }
 
@@ -1785,7 +1785,7 @@
       atomic_read(&(jl->j_commit_left)) == 0) {
     kupdate_one_transaction(ct->p_s_sb, jl) ;
   }
-  kfree(ct->self) ;
+  reiserfs_kfree(ct->self, sizeof(struct reiserfs_journal_commit_task), ct->p_s_sb) ;
 }
 
 static void setup_commit_task_arg(struct reiserfs_journal_commit_task *ct,
@@ -1809,7 +1809,7 @@
   /* using GFP_NOFS, GFP_KERNEL could try to flush inodes, which will try
   ** to start/join a transaction, which will deadlock
   */
-  ct = kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS) ;
+  ct = reiserfs_kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS, p_s_sb) ;
   if (ct) {
     setup_commit_task_arg(ct, p_s_sb, jindex) ;
     queue_task(&(ct->task), &reiserfs_commit_thread_tq);
--- linux.orig/fs/reiserfs/namei.c	Mon Feb 11 10:20:07 2002
+++ linux/fs/reiserfs/namei.c	Mon Feb 11 10:18:41 2002
@@ -895,7 +895,7 @@
 	return -ENAMETOOLONG;
     }
   
-    name = kmalloc (item_len, GFP_NOFS);
+    name = reiserfs_kmalloc (item_len, GFP_NOFS, dir->i_sb);
     if (!name) {
 	iput(inode) ;
 	return -ENOMEM;
@@ -908,7 +908,7 @@
 
     inode = reiserfs_new_inode (&th, dir, S_IFLNK | S_IRWXUGO, name, strlen (symname), dentry,
 				inode, &retval);
-    kfree (name);
+    reiserfs_kfree (name, item_len, dir->i_sb);
     if (inode == 0) { /* reiserfs_new_inode iputs for us */
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
--- linux.orig/include/linux/reiserfs_fs.h	Mon Feb 11 10:20:07 2002
+++ linux/include/linux/reiserfs_fs.h	Mon Feb 11 10:18:41 2002
@@ -1927,8 +1927,14 @@
 struct buffer_head * reiserfs_bread (struct super_block *super, int n_block);
 
 /* fix_nodes.c */
+#ifdef CONFIG_REISERFS_CHECK
 void * reiserfs_kmalloc (size_t size, int flags, struct super_block * s);
 void reiserfs_kfree (const void * vp, size_t size, struct super_block * s);
+#else
+#define reiserfs_kmalloc(x, y, z) kmalloc(x, y)
+#define reiserfs_kfree(x, y, z) kfree(x)
+#endif
+
 int fix_nodes (int n_op_mode, struct tree_balance * p_s_tb, 
 	       struct item_head * p_s_ins_ih, const void *);
 void unfix_nodes (struct tree_balance *);
