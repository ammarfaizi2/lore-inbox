Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTELTbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTELTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:31:24 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:26823 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262590AbTELTa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:30:59 -0400
Message-ID: <3EBFF96A.4040007@namesys.com>
Date: Mon, 12 May 2003 23:43:38 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [2.4] reiserfs: iget4() race fix, resend
Content-Type: multipart/mixed;
 boundary="------------030202050003030807010908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202050003030807010908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I sent this to Marcelo but forgot to cc lkml....

-- 
Hans


--------------030202050003030807010908
Content-Type: message/rfc822;
 name="[2.4] reiserfs: iget4() race fix, resend"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] reiserfs: iget4() race fix, resend"

Return-Path: <green@angband.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 2581 invoked from network); 12 May 2003 14:09:07 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 12 May 2003 14:09:07 -0000
Received: by angband.namesys.com (Postfix, from userid 521)
	id 031A1328AB8; Mon, 12 May 2003 18:09:07 +0400 (MSD)
Date: Mon, 12 May 2003 18:09:06 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] reiserfs: iget4() race fix, resend
Message-ID: <20030512140906.GF4165@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i

Hello!

    This changeset implements a fix for iget4() race possible on reiserfs filesystems.
    This is minimalistic fix that is intended to be replaced with iget5_locked()
    implementation later on. The iget5_locked patch is too much of a change for
    2.4.21-rc2, I afraid. The race itself may lead to pretty much disasters, we've already
    seen it may lead to direntries pointing to nowhere, incorrect nlink counts,
    NFS problems.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-race-fix

Diffstat:
 inode.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1209  -> 1.1210 
#	 fs/reiserfs/inode.c	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	green@angband.namesys.com	1.1210
# reiserfs: iget4() race fix
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon May 12 17:59:42 2003
+++ b/fs/reiserfs/inode.c	Mon May 12 17:59:42 2003
@@ -20,6 +20,10 @@
 static int reiserfs_get_block (struct inode * inode, long block,
 			       struct buffer_head * bh_result, int create);
 
+/* This spinlock guards inode pkey in private part of inode
+   against race between find_actor() vs reiserfs_read_inode2 */
+static spinlock_t keycopy_lock = SPIN_LOCK_UNLOCKED;
+
 void reiserfs_delete_inode (struct inode * inode)
 {
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2; 
@@ -898,8 +902,9 @@
     bh = PATH_PLAST_BUFFER (path);
     ih = PATH_PITEM_HEAD (path);
 
-
+    spin_lock(&keycopy_lock);
     copy_key (INODE_PKEY (inode), &(ih->ih_key));
+    spin_unlock(&keycopy_lock);
     inode->i_blksize = PAGE_SIZE;
 
     INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
@@ -1220,10 +1225,27 @@
 				unsigned long inode_no, void *opaque )
 {
     struct reiserfs_iget4_args *args;
+    int retval;
 
     args = opaque;
+    /* We protect against possible parallel init_inode() on another CPU here. */
+    spin_lock(&keycopy_lock);
     /* args is already in CPU order */
-    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
+    if (le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid)
+	retval = 1;
+    else
+	/* If The key does not match, lets see if we are racing
+	   with another iget4, that already progressed so far
+	   to reiserfs_read_inode2() and was preempted in
+	   call to search_by_key(). The signs of that are:
+	     Inode is locked
+	     dirid and object id are zero (not yet initialized)*/
+	retval = (inode->i_state & I_LOCK) &&
+		 !INODE_PKEY(inode)->k_dir_id &&
+		 !INODE_PKEY(inode)->k_objectid;
+
+    spin_unlock(&keycopy_lock);
+    return retval;
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)



--------------030202050003030807010908--

