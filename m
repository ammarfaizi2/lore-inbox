Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289680AbSBERcT>; Tue, 5 Feb 2002 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289679AbSBERcC>; Tue, 5 Feb 2002 12:32:02 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59653 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289680AbSBERbp>; Tue, 5 Feb 2002 12:31:45 -0500
Date: Tue, 5 Feb 2002 20:31:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 3 of 9 03-key_output_fix.diff
Message-ID: <20020205203138.A9887@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


This set of patches of which this is one will update ReiserFS in 2.5.3
with latest bugfixes. Also it cleanups the code a bit and adds more helpful
messages in some places.

03-key_output_fix.diff
    Fix all the places where cpu key is attempted to be printed as ondisk key


The other patches in this set are:

01-pick_correct_key_version.diff
    This is to fix certain cases where items may get its keys to be interpreted
    wrong, or to be inserted into the tree in wrong order. This bug was only
    observed live on 2.5.3, though it is present in 2.4, too.

02-prealloc_list_init.diff
    prealloc list was forgotten to be initialised.

03-key_output_fix.diff
    Fix all the places where cpu key is attempted to be printed as ondisk key

04-nfs_stale_inode_access.diff
    This is to fix a case where stale NFS handles are correctly detected as
    stale, but inodes assotiated with them are still valid and present in cache,    hence there is no way to deal with files, these handles are attached to.
    Bug was found and explained by
    Anne Milicia <milicia@missioncriticallinux.com>

05-kernel-reiserfs_fs_h-offset_v2.diff
    Convert erroneous le64_to_cpu to cpu_to_le64

06-return_braindamage_removal.diff
    Kill stupid code like 'goto label ; return 1;'

07-remove_nospace_warnings.diff
    Do not print scary warnings in out of free space situations.

08-unfinished_rebuildtree_message.diff
    Give a proper explanation if unfinished reiserfsck --rebuild-tree
    run on a fs was detected.

09-64bit_bitops_fix-1.diff
    Bitopts arguments must be long, not int.


diff -uNr linux-2.5.3/fs/reiserfs/dir.c linux-2.5.3-dj7/fs/reiserfs/dir.c
--- linux-2.5.3/fs/reiserfs/dir.c	Thu Jan 31 16:21:17 2002
+++ linux-2.5.3-dj7/fs/reiserfs/dir.c	Wed Jan 30 20:21:20 2002
@@ -76,7 +76,7 @@
 		
 	/* we must have found item, that is item of this directory, */
 	RFALSE( COMP_SHORT_KEYS (&(ih->ih_key), &pos_key),
-		"vs-9000: found item %h does not match to dir we readdir %k",
+		"vs-9000: found item %h does not match to dir we readdir %K",
 		ih, &pos_key);
 	RFALSE( item_num > B_NR_ITEMS (bh) - 1,
 		"vs-9005 item_num == %d, item amount == %d", 
diff -uNr linux-2.5.3/fs/reiserfs/namei.c linux-2.5.3-dj7/fs/reiserfs/namei.c
--- linux-2.5.3/fs/reiserfs/namei.c	Thu Jan 31 16:21:17 2002
+++ linux-2.5.3-dj7/fs/reiserfs/namei.c	Wed Jan 30 20:01:24 2002
@@ -470,7 +470,7 @@
     if (gen_number != 0) {	/* we need to re-search for the insertion point */
       if (search_by_entry_key (dir->i_sb, &entry_key, &path, &de) != NAME_NOT_FOUND) {
             reiserfs_warning ("vs-7032: reiserfs_add_entry: "
-                            "entry with this key (%k) already exists\n", &entry_key);
+                            "entry with this key (%K) already exists\n", &entry_key);
 
 	    if (buffer != small_buf)
 		reiserfs_kfree (buffer, buflen, dir->i_sb);
diff -uNr linux-2.5.3/fs/reiserfs/stree.c linux-2.5.3-dj7/fs/reiserfs/stree.c
--- linux-2.5.3/fs/reiserfs/stree.c	Thu Jan 31 16:21:17 2002
+++ linux-2.5.3-dj7/fs/reiserfs/stree.c	Thu Jan 31 11:14:42 2002
@@ -166,7 +166,7 @@
     if (cpu_key_k_offset (key1) > cpu_key_k_offset (key2))
 	return 1;
 
-    reiserfs_warning ("comp_cpu_keys: type are compared for %k and %k\n",
+    reiserfs_warning ("comp_cpu_keys: type are compared for %K and %K\n",
 		      key1, key2);
 
     if (cpu_key_k_type (key1) < cpu_key_k_type (key2))
@@ -1522,7 +1522,7 @@
 	    set_cpu_key_k_offset (p_s_item_key, n_new_file_size + 1);
 	    if ( search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path) == POSITION_NOT_FOUND ){
 		print_block (PATH_PLAST_BUFFER (p_s_path), 3, PATH_LAST_POSITION (p_s_path) - 1, PATH_LAST_POSITION (p_s_path) + 1);
-		reiserfs_panic(p_s_sb, "PAP-5580: reiserfs_cut_from_item: item to convert does not exist (%k)", p_s_item_key);
+		reiserfs_panic(p_s_sb, "PAP-5580: reiserfs_cut_from_item: item to convert does not exist (%K)", p_s_item_key);
 	    }
 	    continue;
 	}
@@ -1716,7 +1716,7 @@
 	}
 
 	RFALSE( n_deleted > n_file_size,
-		"PAP-5670: reiserfs_truncate_file returns too big number: deleted %d, file_size %lu, item_key %k",
+		"PAP-5670: reiserfs_truncate_file returns too big number: deleted %d, file_size %lu, item_key %K",
 		n_deleted, n_file_size, &s_item_key);
 
 	/* Change key to search the last file item. */
diff -uNr linux-2.5.3/fs/reiserfs/tail_conversion.c linux-2.5.3-dj7/fs/reiserfs/tail_conversion.c
--- linux-2.5.3/fs/reiserfs/tail_conversion.c	Thu Jan 31 16:21:17 2002
+++ linux-2.5.3-dj7/fs/reiserfs/tail_conversion.c	Wed Jan 30 19:39:35 2002
@@ -90,10 +90,10 @@
            last item of the file */
 	if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
 	    reiserfs_panic (sb, "PAP-14050: direct2indirect: "
-			    "direct item (%k) not found", &end_key);
+			    "direct item (%K) not found", &end_key);
 	p_le_ih = PATH_PITEM_HEAD (path);
 	RFALSE( !is_direct_le_ih (p_le_ih),
-	        "vs-14055: direct item expected(%k), found %h",
+	        "vs-14055: direct item expected(%K), found %h",
                 &end_key, p_le_ih);
         tail_size = (le_ih_k_offset (p_le_ih) & (n_blk_size - 1))
             + ih_item_len(p_le_ih) - 1;
@@ -228,7 +228,7 @@
 	/* re-search indirect item */
 	if ( search_for_position_by_key (p_s_sb, p_s_item_key, p_s_path) == POSITION_NOT_FOUND )
 	    reiserfs_panic(p_s_sb, "PAP-5520: indirect2direct: "
-			   "item to be converted %k does not exist", p_s_item_key);
+			   "item to be converted %K does not exist", p_s_item_key);
 	copy_item_head(&s_ih, PATH_PITEM_HEAD(p_s_path));
 #ifdef CONFIG_REISERFS_CHECK
 	pos = le_ih_k_offset (&s_ih) - 1 + 
