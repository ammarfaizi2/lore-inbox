Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289686AbSBERcT>; Tue, 5 Feb 2002 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSBERcE>; Tue, 5 Feb 2002 12:32:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:65285 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289692AbSBERbq>; Tue, 5 Feb 2002 12:31:46 -0500
Date: Tue, 5 Feb 2002 20:31:39 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 9 of 9 09-64bit_bitops_fix-1.diff
Message-ID: <20020205203139.A9942@namesys.com>
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

09-64bit_bitops_fix-1.diff
    Bitopts arguments must be long, not int.


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


--- linux-2.5.3/fs/reiserfs/journal.c.orig	Thu Jan 31 09:25:23 2002
+++ linux-2.5.3/fs/reiserfs/journal.c	Tue Feb  5 16:58:49 2002
@@ -797,7 +797,7 @@
   while(cn) {
     if (cn->blocknr != 0) {
       if (debug) {
-        printk("block %lu, bh is %d, state %d\n", cn->blocknr, cn->bh ? 1: 0, 
+        printk("block %lu, bh is %d, state %ld\n", cn->blocknr, cn->bh ? 1: 0, 
 	        cn->state) ;
       }
       cn->state = 0 ;
--- linux-2.5.3/fs/reiserfs/procfs.c.orig	Thu Jan 31 09:25:23 2002
+++ linux-2.5.3/fs/reiserfs/procfs.c	Tue Feb  5 17:05:15 2002
@@ -465,7 +465,7 @@
  			"jp_journal_max_trans_age: \t%i\n"
 			/* incore fields */
 			"j_1st_reserved_block: \t%i\n"	  
-			"j_state: \t%i\n"			
+			"j_state: \t%li\n"			
 			"j_trans_id: \t%lu\n"
 			"j_mount_id: \t%lu\n"
 			"j_start: \t%lu\n"
--- linux-2.5.3/include/linux/reiserfs_fs_sb.h.orig	Thu Jan 31 09:25:24 2002
+++ linux-2.5.3/include/linux/reiserfs_fs_sb.h	Tue Feb  5 17:03:30 2002
@@ -131,7 +131,7 @@
   struct buffer_head *bh ;		 /* real buffer head */
   struct super_block *sb ;		 /* dev of real buffer head */
   unsigned long blocknr ;		 /* block number of real buffer head, == 0 when buffer on disk */		 
-  int state ;
+  long state ;
   struct reiserfs_journal_list *jlist ;  /* journal list this cnode lives in */
   struct reiserfs_journal_cnode *next ;  /* next in transaction list */
   struct reiserfs_journal_cnode *prev ;  /* prev in transaction list */
@@ -199,7 +199,7 @@
   struct block_device *j_dev_bd;  
   int j_1st_reserved_block;     /* first block on s_dev of reserved area journal */        
 	
-  int j_state ;			
+  long j_state ;			
   unsigned long j_trans_id ;
   unsigned long j_mount_id ;
   unsigned long j_start ;             /* start of current waiting commit (index into j_ap_blocks) */
