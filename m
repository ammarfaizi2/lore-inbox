Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSBERcB>; Tue, 5 Feb 2002 12:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289670AbSBERbx>; Tue, 5 Feb 2002 12:31:53 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64261 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289671AbSBERbl>; Tue, 5 Feb 2002 12:31:41 -0500
Date: Tue, 5 Feb 2002 20:31:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 7 of 9 07-remove_nospace_warnings.diff
Message-ID: <20020205203138.A9924@namesys.com>
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

07-remove_nospace_warnings.diff
    Do not print scary warnings in out of free space situations.


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


--- linux-2.5.3/fs/reiserfs/super.c.orig	Thu Jan 31 09:25:24 2002
+++ linux-2.5.3/fs/reiserfs/super.c	Tue Feb  5 16:50:26 2002
@@ -284,7 +284,8 @@
     /* look for its place in the tree */
     retval = search_item (inode->i_sb, &key, &path);
     if (retval != ITEM_NOT_FOUND) {
-	reiserfs_warning ("vs-2100: add_save_link:"
+	if ( retval != -ENOSPC )
+	    reiserfs_warning ("vs-2100: add_save_link:"
 			  "search_by_key (%K) returned %d\n", &key, retval);
 	pathrelse (&path);
 	return;
--- linux-2.5.3/fs/reiserfs/stree.c.orig	Tue Feb  5 16:16:39 2002
+++ linux-2.5.3/fs/reiserfs/stree.c	Tue Feb  5 16:50:42 2002
@@ -1338,8 +1338,10 @@
 	}
 	if (retval != ITEM_FOUND) {
 	    pathrelse (&path);
-	    reiserfs_warning ("vs-5355: reiserfs_delete_solid_item: %k not found",
-			      key);
+	    // No need for a warning, if there is just no free space to insert '..' item into the newly-created subdir
+	    if ( !( (unsigned long long) GET_HASH_VALUE (le_key_k_offset (le_key_version (key), key)) == 0 && \
+		 (unsigned long long) GET_GENERATION_NUMBER (le_key_k_offset (le_key_version (key), key)) == 1 ) )
+		reiserfs_warning ("vs-5355: reiserfs_delete_solid_item: %k not found", key);
 	    break;
 	}
 	if (!tb_init) {
--- linux-2.5.3/fs/reiserfs/inode.c.orig	Tue Feb  5 16:42:00 2002
+++ linux-2.5.3/fs/reiserfs/inode.c	Tue Feb  5 16:50:57 2002
@@ -743,7 +743,8 @@
 
 		retval = convert_tail_for_hole(inode, bh_result, tail_offset) ;
 		if (retval) {
-		    printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
+		    if ( retval != -ENOSPC )
+			printk("clm-6004: convert tail failed inode %lu, error %d\n", inode->i_ino, retval) ;
 		    if (allocated_block_nr)
 			reiserfs_free_block (&th, allocated_block_nr);
 		    goto failure ;
