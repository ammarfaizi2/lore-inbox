Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRCMWbb>; Tue, 13 Mar 2001 17:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRCMWbV>; Tue, 13 Mar 2001 17:31:21 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131227AbRCMWbJ>;
	Tue, 13 Mar 2001 17:31:09 -0500
From: Alexander Zarochentcev <zam@namesys.com>
Message-ID: <15022.31730.3768.986769@crimson.namesys.com>
Date: Tue, 13 Mar 2001 22:58:41 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TKMJYcQdPk"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patches for 2.4.3-pre4
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TKMJYcQdPk
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Hello !

The Reiserfs development team resubmits five revised Reiserfs patches
for the version after Linux 2.4.3-pre4.  Their descriptions are:

1. "prealloc.diff" --a fix for possible preallocated blocks leakage
   after a system crash

   Reiserfs blocks preallocation for big files in the same manner as
   ext2.  The preallocation code changes both the bitmap and the free
   blocks count in the superblock.  It is possible after a crash to
   have unattached disk blocks which do not belong to any file
   (i.e. free space leak).  Unlike ext2, reiserfs does not check for
   consistency of a filesystem that was not cleanly unmounted.  There
   is no simple way to recover free space.

   For a given transaction, the fix is to, at the transaction end,
   discard the preallocations for those inodes which have one.

2. "objectid-sharing.diff" -- object id sharing problem fix

   Fix for reiserfs/inode.c:reiserfs_iget () The fix makes sure that
   the reiserfs_iget function really got the inode of the object for
   which it is looking.

3. "namei.diff" -- improvements of reiserfs_add_entry() function
   
   a. Error handling

   There is a place in reiserfs_add_entry() code where fs corruption
   (existence of hidden entries--objects temporarily used in
   renaming), I/O errors, or several other occurrences, can produce an
   error message which has no useful information.

   We have had several bug reports about this vs-7032 message in the
   older 3.5 version. Each time we were unable to reproduce it. We do
   not understand the reason.  This error handling fix will make such
   bug reports much more informative for us if they should occur in
   the newer version.

   b. Unnecessary re-searching is avoided

   In reiserfs_add_entry(), we don't need to scan a whole bit_string
   for non-zero bits to be able to use a smallest generation counter
   to avoid re-searching for the dir entry insertion point.

4. "messages.diff" 
   This adds missed error numbers to reiserfs error
   messages

5. "objectid_map.diff"
   It adds a better debugging message when the oid map is corrupted,
   and (more importantly) fixes a macro in objectid.c to put parens
   around the stuff passed in.

-- 
Thanks,
Alex.


--TKMJYcQdPk
Content-Type: text/x-diff
Content-Disposition: attachment;
	filename="prealloc.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux.old/fs/reiserfs/bitmap.c linux/fs/reiserfs/bitmap.c
--- linux.old/fs/reiserfs/bitmap.c	Tue Jan 16 02:31:19 2001
+++ linux/fs/reiserfs/bitmap.c	Mon Mar  5 13:20:46 2001
@@ -8,6 +8,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/locks.h>
 #include <asm/bitops.h>
+#include <linux/list.h>
 
 #else
 
@@ -580,6 +577,12 @@
   if (p_s_inode->u.reiserfs_i.i_prealloc_count > 0) {
     p_s_inode->u.reiserfs_i.i_prealloc_count--;
     *free_blocknrs = p_s_inode->u.reiserfs_i.i_prealloc_block++;
+
+    /* if no more preallocated blocks, remove inode from list */
+    if (! p_s_inode->u.reiserfs_i.i_prealloc_count) {
+      list_del(&p_s_inode->u.reiserfs_i.i_prealloc_list);
+    }
+    
     return ret;
   }
 
@@ -633,6 +636,11 @@
   *free_blocknrs = p_s_inode->u.reiserfs_i.i_prealloc_block;
   p_s_inode->u.reiserfs_i.i_prealloc_block++;
 
+  /* if inode has preallocated blocks, link him to list */
+  if (p_s_inode->u.reiserfs_i.i_prealloc_count) {
+    list_add(&p_s_inode->u.reiserfs_i.i_prealloc_list,
+	     &SB_JOURNAL(th->t_super)->j_prealloc_list);
+  } 
   /* we did actually manage to get 1 block */
   if (ret != CARRY_ON && allocated[0] > 0) {
     return CARRY_ON ;
@@ -664,16 +672,43 @@
 // a portion of this function, was derived from minix or ext2's
 // analog. You should be able to tell which portion by looking at the
 // ext2 code and comparing. 
+static void __discard_prealloc (struct reiserfs_transaction_handle * th,
+				struct inode * inode)
+{
+  while (inode->u.reiserfs_i.i_prealloc_count > 0) {
+    reiserfs_free_block(th,inode->u.reiserfs_i.i_prealloc_block);
+    inode->u.reiserfs_i.i_prealloc_block++;
+    inode->u.reiserfs_i.i_prealloc_count --;
+  }
+  list_del (&(inode->u.reiserfs_i.i_prealloc_list));
+}
+
 
 void reiserfs_discard_prealloc (struct reiserfs_transaction_handle *th, 
 				struct inode * inode)
 {
-    if (inode->u.reiserfs_i.i_prealloc_count > 0) {
-      while (inode->u.reiserfs_i.i_prealloc_count--) {
-	reiserfs_free_block(th,inode->u.reiserfs_i.i_prealloc_block);
-	inode->u.reiserfs_i.i_prealloc_block++;
-      }
-    }
-    inode->u.reiserfs_i.i_prealloc_count = 0;
+#ifdef CONFIG_REISERFS_CHECK
+  if (inode->u.reiserfs_i.i_prealloc_count < 0)
+     reiserfs_warning("zam-4001:" __FUNCTION__ ": inode has negative prealloc blocks count.\n");
+#endif  
+  if (inode->u.reiserfs_i.i_prealloc_count > 0) {
+    __discard_prealloc(th, inode);
+  }
+}
+
+void reiserfs_discard_all_prealloc (struct reiserfs_transaction_handle *th)
+{
+  struct list_head * plist = &SB_JOURNAL(th->t_super)->j_prealloc_list;
+  struct inode * inode;
+  
+  while (!list_empty(plist)) {
+    inode = list_entry(plist->next, struct inode, u.reiserfs_i.i_prealloc_list);
+#ifdef CONFIG_REISERFS_CHECK
+    if (!inode->u.reiserfs_i.i_prealloc_count) {
+      reiserfs_warning("zam-4001:" __FUNCTION__ ": inode is in prealloc list but has no preallocated blocks.\n");
+    }
+#endif    
+    __discard_prealloc(th, inode);
+  }
 }
 #endif
diff -ur linux.old/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux.old/fs/reiserfs/journal.c	Tue Jan 16 02:31:19 2001
+++ linux/fs/reiserfs/journal.c	Mon Mar  5 13:31:25 2001
@@ -1927,8 +1927,11 @@
     free_journal_ram(p_s_sb) ;
     return 1 ;
   }
-  SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this where it belongs */
+  SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this
+                                         where it belongs */
 
+  INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
+  
   if (reiserfs_dont_log (p_s_sb))
     return 0;
 
@@ -2985,6 +2988,11 @@
     flush = 1 ;
   }
 
+#ifdef REISERFS_PREALLOCATE
+  reiserfs_discard_all_prealloc(th); /* it should not involve new blocks into
+				      * the transaction */
+#endif
+  
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
   d_bh = getblk(p_s_sb->s_dev, reiserfs_get_journal_block(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start, p_s_sb->s_blocksize) ; 
diff -ur linux.old/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux.old/include/linux/reiserfs_fs.h	Thu Feb 22 20:04:00 2001
+++ linux/include/linux/reiserfs_fs.h	Mon Mar  5 13:20:46 2001
@@ -1950,6 +1972,7 @@
 
 void reiserfs_discard_prealloc (struct reiserfs_transaction_handle *th, 
 				struct inode * inode);
+void reiserfs_discard_all_prealloc (struct reiserfs_transaction_handle *th);
 #endif
 
 /* hashes.c */
diff -ur linux.old/include/linux/reiserfs_fs_i.h linux/include/linux/reiserfs_fs_i.h
--- linux.old/include/linux/reiserfs_fs_i.h	Mon Jan 15 23:42:32 2001
+++ linux/include/linux/reiserfs_fs_i.h	Mon Mar  5 13:20:46 2001
@@ -1,6 +1,8 @@
 #ifndef _REISER_FS_I
 #define _REISER_FS_I
 
+#include <linux/list.h>
+
 /* these are used to keep track of the pages that need
 ** flushing before the current transaction can commit
 */
@@ -52,7 +54,8 @@
   //For preallocation
   int i_prealloc_block;
   int i_prealloc_count;
-
+  struct list_head i_prealloc_list;	/* per-transaction list of inodes which
+				 * have preallocated blocks */
 				/* I regret that you think the below
                                    is a comment you should make.... -Hans */
   //nopack-attribute
diff -ur linux.old/include/linux/reiserfs_fs_sb.h linux/include/linux/reiserfs_fs_sb.h
--- linux.old/include/linux/reiserfs_fs_sb.h	Tue Jan 30 10:24:56 2001
+++ linux/include/linux/reiserfs_fs_sb.h	Mon Mar  5 13:20:46 2001
@@ -254,6 +259,7 @@
   struct reiserfs_journal_cnode *j_hash_table[JOURNAL_HASH_SIZE] ; 	    /* hash table for real buffer heads in current trans */ 
   struct reiserfs_journal_cnode *j_list_hash_table[JOURNAL_HASH_SIZE] ; /* hash table for all the real buffer heads in all 
   										the transactions */
+  struct list_head j_prealloc_list;     /* list of inodes which have preallocated blocks */
 };
 
 #define JOURNAL_DESC_MAGIC "ReIsErLB" /* ick.  magic string to find desc blocks in the journal */

--TKMJYcQdPk
Content-Type: text/x-diff
Content-Disposition: attachment;
	filename="objectid-sharing.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux.old/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux.old/fs/reiserfs/inode.c	Tue Jan 16 22:14:22 2001
+++ linux/fs/reiserfs/inode.c	Mon Mar  5 13:20:46 2001
@@ -1158,7 +1191,6 @@
     if (!inode) 
       return inode ;
 
-    //    if (comp_short_keys (INODE_PKEY (inode), key)) {
     if (is_bad_inode (inode)) {
 	reiserfs_warning ("vs-13048: reiserfs_iget: "
 			  "bad_inode. Stat data of (%lu %lu) not found\n",
@@ -1166,6 +1198,15 @@
 	iput (inode);
 	inode = 0;
     }
+
+    if (comp_short_keys (INODE_PKEY (inode), key)) {
+	reiserfs_warning ("vs-13049: reiserfs_iget: "
+			  "Looking for (%lu %lu), found inode of (%lu %lu)\n",
+			  key->on_disk_key.k_dir_id, key->on_disk_key.k_objectid,
+			  INODE_PKEY (inode)->k_dir_id, INODE_PKEY (inode)->k_objectid);
+	iput (inode);
+	inode = 0;
+    }
     return inode;
 }

--TKMJYcQdPk
Content-Type: text/x-diff
Content-Disposition: attachment;
	filename="namei.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux.old/fs/reiserfs/namei.c linux/fs/reiserfs/namei.c
--- linux.old/fs/reiserfs/namei.c	Thu Feb 22 20:03:58 2001
+++ linux/fs/reiserfs/namei.c	Mon Mar  5 13:20:46 2001
@@ -466,40 +461,42 @@
     /* find the proper place for the new entry */
     memset (bit_string, 0, sizeof (bit_string));
     de.de_gen_number_bit_string = (char *)bit_string;
-    if (reiserfs_find_entry (dir, name, namelen, &path, &de) == NAME_FOUND) {
+    retval = reiserfs_find_entry (dir, name, namelen, &path, &de);
+    if (retval != NAME_NOT_FOUND) {
 	if (buffer != small_buf)
 	    reiserfs_kfree (buffer, buflen, dir->i_sb);
 	pathrelse (&path);
+	
+	if (retval != NAME_FOUND) {
+	    reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has returned"
+			      " unexpected value (%d)\n", retval);
+	}
+	
 	return -EEXIST;
     }
 
-    if (find_first_nonzero_bit (bit_string, MAX_GENERATION_NUMBER + 1) < MAX_GENERATION_NUMBER + 1) {
-	/* there are few names with given hash value */
-	gen_number = find_first_zero_bit (bit_string, MAX_GENERATION_NUMBER + 1);
-	if (gen_number > MAX_GENERATION_NUMBER) {
-	    /* there is no free generation number */
-	    reiserfs_warning ("reiserfs_add_entry: Congratulations! we have got hash function screwed up\n");
-	    if (buffer != small_buf)
-		reiserfs_kfree (buffer, buflen, dir->i_sb);
-	    pathrelse (&path);
-	    return -EBUSY; //HASHCOLLISION;//EBADSLT
-	}
-	/* adjust offset of directory enrty */
-	deh->deh_offset = cpu_to_le32 (SET_GENERATION_NUMBER (deh_offset (deh), gen_number));
-	set_cpu_key_k_offset (&entry_key, le32_to_cpu (deh->deh_offset));
+    gen_number = find_first_zero_bit (bit_string, MAX_GENERATION_NUMBER + 1);
+    if (gen_number > MAX_GENERATION_NUMBER) {
+	/* there is no free generation number */
+	reiserfs_warning ("reiserfs_add_entry: Congratulations! we have got hash function screwed up\n");
+	if (buffer != small_buf)
+	    reiserfs_kfree (buffer, buflen, dir->i_sb);
+	pathrelse (&path);
+	return -EBUSY;
+    }
+    /* adjust offset of directory enrty */
+    deh->deh_offset = cpu_to_le32 (SET_GENERATION_NUMBER (deh_offset (deh), gen_number));
+    set_cpu_key_k_offset (&entry_key, le32_to_cpu (deh->deh_offset));
 
-	/* find place for new entry */
-	if (search_by_entry_key (dir->i_sb, &entry_key, &path, &de) == NAME_FOUND) {
+    if (gen_number != 0) {	/* we need to re-search for the insertion point */
+	if (search_by_entry_key (dir->i_sb, &entry_key, &path, &de) != NAME_NOT_FOUND) {
 	    reiserfs_warning ("vs-7032: reiserfs_add_entry: "
-			      "entry with this key (%k) already exists", &entry_key);
+			      "entry with this key (%k) already exists\n", &entry_key);
 	    if (buffer != small_buf)
 		reiserfs_kfree (buffer, buflen, dir->i_sb);
 	    pathrelse (&path);
 	    return -EBUSY;
 	}
-    } else {
-	deh->deh_offset = cpu_to_le32 (SET_GENERATION_NUMBER (le32_to_cpu (deh->deh_offset), 0));
-	set_cpu_key_k_offset (&entry_key, le32_to_cpu (deh->deh_offset));
     }
   
     /* perform the insertion of the entry that we have prepared */

--TKMJYcQdPk
Content-Type: text/x-diff
Content-Disposition: attachment;
	filename="messages.diff"
Content-Transfer-Encoding: 7bit

diff -ur linux.old/fs/reiserfs/namei.c linux/fs/reiserfs/namei.c
--- linux.old/fs/reiserfs/namei.c	Thu Feb 22 20:03:58 2001
+++ linux/fs/reiserfs/namei.c	Mon Mar  5 13:20:46 2001
@@ -1214,7 +1211,7 @@
     // anybody, but it will panic if will not be able to find the
     // entry. This needs one more clean up
     if (reiserfs_cut_from_item (&th, &old_entry_path, &(old_de.de_entry_key), old_dir, NULL, 0) < 0)
-	reiserfs_warning ("vs-: reiserfs_rename: coudl not cut old name. Fsck later?\n");
+	reiserfs_warning ("vs-7999: reiserfs_rename: could not cut old name. Fsck later?\n");
 
     old_dir->i_size -= DEH_SIZE + old_de.de_entrylen;
     old_dir->i_blocks = ((old_dir->i_size + 511) >> 9);
diff -ur linux.old/fs/reiserfs/stree.c linux/fs/reiserfs/stree.c
--- linux.old/fs/reiserfs/stree.c	Tue Jan 16 02:31:19 2001
+++ linux/fs/reiserfs/stree.c	Mon Mar  5 13:20:46 2001
@@ -1508,13 +1508,13 @@
     while (1) {
 	retval = search_item (th->t_super, &cpu_key, &path);
 	if (retval == IO_ERROR) {
-	    reiserfs_warning ("vs-: reiserfs_delete_solid_item: "
+	    reiserfs_warning ("vs-1522: warning: reiserfs_delete_solid_item: "
 			      "i/o failure occurred trying to delete %K\n", &cpu_key);
 	    break;
 	}
 	if (retval != ITEM_FOUND) {
 	    pathrelse (&path);
-	    reiserfs_warning ("vs-: reiserfs_delete_solid_item: %k not found",
+	    reiserfs_warning ("vs-1528: warning: reiserfs_delete_solid_item: %k not found\n",
 			      key);
 	    break;
 	}

--TKMJYcQdPk
Content-Type: text/x-diff
Content-Disposition: attachment;
	filename="objectid_map.diff"
Content-Transfer-Encoding: 7bit

--- linux.old/fs/reiserfs/objectid.c	Tue Jan 16 02:31:19 2001
+++ linux/fs/reiserfs/objectid.c	Wed Mar  7 14:47:54 2001
@@ -18,8 +18,8 @@
 
 // find where objectid map starts
 #define objectid_map(s,rs) (old_format_only (s) ? \
-                         (__u32 *)((struct reiserfs_super_block_v1 *)rs + 1) :\
-			 (__u32 *)(rs + 1))
+                         (__u32 *)((struct reiserfs_super_block_v1 *)(rs) + 1) :\
+			 (__u32 *)((rs) + 1))
 
 
 #ifdef CONFIG_REISERFS_CHECK
@@ -27,7 +27,8 @@
 static void check_objectid_map (struct super_block * s, __u32 * map)
 {
     if (le32_to_cpu (map[0]) != 1)
-	reiserfs_panic (s, "vs-15010: check_objectid_map: map corrupted");
+	reiserfs_panic (s, "vs-15010: check_objectid_map: map corrupted: %lx",
+			le32_to_cpu (map[0]));
 
     // FIXME: add something else here
 }

--TKMJYcQdPk--
