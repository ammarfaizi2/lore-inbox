Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVHXVBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHXVBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVHXVBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:01:52 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:22189 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S932213AbVHXVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:01:51 -0400
Date: Wed, 24 Aug 2005 18:03:25 -0300
From: Glauber de Oliveira Costa <gocosta@br.ibm.com>
To: ext2-devel@lists.sourceforge.net, ext2resize-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       adilger@clusterfs.com, sct@redhat.com, akpm@osdl.org
Subject: [PATCH] Ext3 online resizing locking issue
Message-ID: <20050824210325.GK23782@br.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch provides a fix for a locking issue found in the online
resizing code. The problem actually happened while trying to resize the
filesystem trough the resize=xxx option in a remount. 

Signed-off-by: Glauber de Oliveira Costa <gocosta@br.ibm.com>


diff -up linux-2.6.13-rc6-orig/fs/ext3/ioctl.c linux/fs/ext3/ioctl.c
--- linux-2.6.13-rc6-orig/fs/ext3/ioctl.c	2005-08-24 17:48:22.000000000 -0300
+++ linux/fs/ext3/ioctl.c	2005-08-24 15:12:48.000000000 -0300
@@ -206,7 +206,9 @@ flags_err:
 		if (get_user(n_blocks_count, (__u32 __user *)arg))
 			return -EFAULT;
 
+		lock_super(sb);
 		err = ext3_group_extend(sb, EXT3_SB(sb)->s_es, n_blocks_count);
+		unlock_super(sb);
 		journal_lock_updates(EXT3_SB(sb)->s_journal);
 		journal_flush(EXT3_SB(sb)->s_journal);
 		journal_unlock_updates(EXT3_SB(sb)->s_journal);
Only in linux/fs/ext3: patch-mnt_resize
diff -up linux-2.6.13-rc6-orig/fs/ext3/resize.c linux/fs/ext3/resize.c
--- linux-2.6.13-rc6-orig/fs/ext3/resize.c	2005-08-24 17:48:22.000000000 -0300
+++ linux/fs/ext3/resize.c	2005-08-24 15:15:28.000000000 -0300
@@ -884,7 +884,9 @@ exit_put:
 /* Extend the filesystem to the new number of blocks specified.  This entry
  * point is only used to extend the current filesystem to the end of the last
  * existing group.  It can be accessed via ioctl, or by "remount,resize=<size>"
- * for emergencies (because it has no dependencies on reserved blocks).
+ * for emergencies (because it has no dependencies on reserved blocks). 
+ * 
+ * It should be called with sb->s_lock held
  *
  * If we _really_ wanted, we could use default values to call ext3_group_add()
  * allow the "remount" trick to work for arbitrary resizing, assuming enough
@@ -959,7 +961,6 @@ int ext3_group_extend(struct super_block
 		goto exit_put;
 	}
 
-	lock_super(sb);
 	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!\n");
@@ -978,7 +979,6 @@ int ext3_group_extend(struct super_block
 	es->s_blocks_count = cpu_to_le32(o_blocks_count + add);
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
-	unlock_super(sb);
 	ext3_debug("freeing blocks %ld through %ld\n", o_blocks_count,
 		   o_blocks_count + add);
 	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
diff -up linux-2.6.13-rc6-orig/fs/ext3/super.c linux/fs/ext3/super.c
--- linux-2.6.13-rc6-orig/fs/ext3/super.c	2005-08-24 17:48:22.000000000 -0300
+++ linux/fs/ext3/super.c	2005-08-24 15:13:16.000000000 -0300
@@ -639,8 +639,8 @@ static match_table_t tokens = {
 	{Opt_quota, "quota"},
 	{Opt_quota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
+	{Opt_resize, "resize=%u"},
 	{Opt_err, NULL},
-	{Opt_resize, "resize"},
 };
 
 static unsigned long get_sb_block(void **data)
