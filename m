Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289677AbSBERcB>; Tue, 5 Feb 2002 12:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289694AbSBERbw>; Tue, 5 Feb 2002 12:31:52 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51461 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289667AbSBERbk>; Tue, 5 Feb 2002 12:31:40 -0500
Date: Tue, 5 Feb 2002 20:31:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs patchset, patch 1 of 9 01-pick_correct_key_version.diff
Message-ID: <20020205203138.A9870@namesys.com>
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

01-pick_correct_key_version.diff
    This is to fix certain cases where items may get its keys to be interpreted
    wrong, or to be inserted into the tree in wrong order. This bug was only
    observed live on 2.5.3, though it is present in 2.4, too.


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


--- linux-2.5.3/fs/reiserfs/stree.c.orig	Thu Jan 31 19:24:47 2002
+++ linux-2.5.3/fs/reiserfs/stree.c	Thu Jan 31 19:26:54 2002
@@ -126,19 +126,19 @@
   retval = comp_short_keys (le_key, cpu_key);
   if (retval)
       return retval;
-  if (le_key_k_offset (cpu_key->version, le_key) < cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) < cpu_key_k_offset (cpu_key))
       return -1;
-  if (le_key_k_offset (cpu_key->version, le_key) > cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) > cpu_key_k_offset (cpu_key))
       return 1;
 
   if (cpu_key->key_length == 3)
       return 0;
 
   /* this part is needed only when tail conversion is in progress */
-  if (le_key_k_type (cpu_key->version, le_key) < cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) < cpu_key_k_type (cpu_key))
     return -1;
 
-  if (le_key_k_type (cpu_key->version, le_key) > cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) > cpu_key_k_type (cpu_key))
     return 1;
 
   return 0;
