Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289671AbSBERcB>; Tue, 5 Feb 2002 12:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289679AbSBERby>; Tue, 5 Feb 2002 12:31:54 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:52229 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289677AbSBERbn>; Tue, 5 Feb 2002 12:31:43 -0500
Date: Tue, 5 Feb 2002 20:31:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 4 of 9 04-nfs_stale_inode_access.diff
Message-ID: <20020205203138.A9896@namesys.com>
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

04-nfs_stale_inode_access.diff
    This is to fix a case where stale NFS handles are correctly detected as
    stale, but inodes assotiated with them are still valid and present in cache,    hence there is no way to deal with files, these handles are attached to.
    Bug was found and explained by
    Anne Milicia <milicia@missioncriticallinux.com>


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


--- linux-2.5.3/fs/reiserfs/inode.c.orig	Tue Feb  5 16:15:04 2002
+++ linux-2.5.3/fs/reiserfs/inode.c	Tue Feb  5 16:42:00 2002
@@ -1154,6 +1154,7 @@
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
 	make_bad_inode(inode) ;
+	inode->i_nlink = 0;
 	return;
     }
 
@@ -1186,6 +1187,27 @@
 
 }
 
+/**
+ * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
+ *
+ * @inode:    inode from hash table to check
+ * @inode_no: inode number we are looking for
+ * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
+ *
+ * This function is called by iget4() to distinguish reiserfs inodes
+ * having the same inode numbers. Such inodes can only exist due to some
+ * error condition. One of them should be bad. Inodes with identical
+ * inode numbers (objectids) are distinguished by parent directory ids.
+ *
+ */
+static int reiserfs_find_actor( struct inode *inode, 
+				unsigned long inode_no, void *opaque )
+{
+    struct reiserfs_iget4_args *args;
+
+    args = opaque;
+    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+}
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
 {
@@ -1193,7 +1215,8 @@
     struct reiserfs_iget4_args args ;
 
     args.objectid = key->on_disk_key.k_dir_id ;
-    inode = iget4 (s, key->on_disk_key.k_objectid, 0, (void *)(&args));
+    inode = iget4 (s, key->on_disk_key.k_objectid, 
+		   reiserfs_find_actor, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
 
