Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289667AbSBERcB>; Tue, 5 Feb 2002 12:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSBERbx>; Tue, 5 Feb 2002 12:31:53 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58629 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289679AbSBERbn>; Tue, 5 Feb 2002 12:31:43 -0500
Date: Tue, 5 Feb 2002 20:31:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 2 of 9 02-prealloc_list_init.diff
Message-ID: <20020205203138.A9878@namesys.com>
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

02-prealloc_list_init.diff
    prealloc list was forgotten to be initialised.


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


--- linux-2.5.3/fs/reiserfs/inode.c.orig	Thu Jan 31 19:28:57 2002
+++ linux-2.5.3/fs/reiserfs/inode.c	Thu Jan 31 19:31:01 2002
@@ -888,6 +888,8 @@
     copy_key (INODE_PKEY (inode), &(ih->ih_key));
     inode->i_blksize = PAGE_SIZE;
 
+    INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
+
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
 	unsigned long blocks;
@@ -1532,6 +1534,7 @@
     REISERFS_I(inode)->i_first_direct_byte = S_ISLNK(mode) ? 1 : 
       U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;
 
+    INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
     REISERFS_I(inode)->i_flags = 0;
     REISERFS_I(inode)->i_prealloc_block = 0;
     REISERFS_I(inode)->i_prealloc_count = 0;
