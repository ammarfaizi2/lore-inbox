Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVC3RJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVC3RJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVC3RJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:09:25 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:22147 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261898AbVC3RJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:09:13 -0500
Date: Thu, 31 Mar 2005 01:09:15 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: matt@ucc.asn.au
Subject: ext2 corruption - regression between 2.6.9 and 2.6.10
Message-ID: <20050330170915.GY4300@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Whilst trying to stress test a Promise SX8 card, we stumbled across
some nasty filesystem corruption in ext2. Our tests involved
creating an ext2 partition, mounting, running several concurrent
fsx's over it, umounting, and fsck'ing, all scripted[1]. The fsck
would always return with errors.

This regression was traced back to a change between 2.6.9 and
2.6.10, which moves the functionality of ext2_put_inode into
ext2_clear_inode.  The attached patch reverses this change, and
eliminated the source of corruption.

Whilst stress tesing the same Promise SX8 card on an ext3 partition
(amd64 machine) also with fsx, we encountered a kernel panic who's
backtrace looked like:
  ext3_discard_reservation
  ext3_truncate
  .
  .
  .
  do_truncate
  sys_ftruncate
Could this same change (which was in ext3 also) be responsible for
this?

Bernard.

[1] http://matt.ucc.asn.au/ext2bad/

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext2-fix.diff"

diff linux-2.6.10.orig/fs/ext2/ext2.h linux-2.6.10/fs/ext2/ext2.h
--- linux-2.6.10.orig/fs/ext2/ext2.h	2004-10-19 05:55:29.000000000 +0800
+++ linux-2.6.10/fs/ext2/ext2.h	2004-12-25 05:35:40.000000000 +0800
@@ -116,6 +116,7 @@ extern unsigned long ext2_count_free (st
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
 extern int ext2_write_inode (struct inode *, int);
+extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
diff linux-2.6.10.orig/fs/ext2/inode.c linux-2.6.10/fs/ext2/inode.c
--- linux-2.6.10.orig/fs/ext2/inode.c	2004-10-19 05:53:11.000000000 +0800
+++ linux-2.6.10/fs/ext2/inode.c	2004-12-25 05:33:51.000000000 +0800
@@ -53,6 +53,19 @@ static inline int ext2_inode_is_fast_sym
 }
 
 /*
+ * Called at each iput().
+ *
+ * The inode may be "bad" if ext2_read_inode() saw an error from
+ * ext2_get_inode(), so we need to check that to avoid freeing random disk
+ * blocks.
+ */
+void ext2_put_inode(struct inode *inode)
+{
+	if (!is_bad_inode(inode))
+		ext2_discard_prealloc(inode);
+}
+
+/*
  * Called at the last iput() if i_nlink is zero.
  */
 void ext2_delete_inode (struct inode * inode)
diff linux-2.6.10.orig/fs/ext2/super.c linux-2.6.10/fs/ext2/super.c
--- linux-2.6.10.orig/fs/ext2/super.c	2004-10-19 05:54:38.000000000 +0800
+++ linux-2.6.10/fs/ext2/super.c	2004-12-25 05:35:01.000000000 +0800
@@ -197,17 +199,16 @@ static void ext2_clear_inode(struct inod
 		posix_acl_release(ei->i_default_acl);
 		ei->i_default_acl = EXT2_ACL_NOT_CACHED;
 	}
 #endif
-	if (!is_bad_inode(inode))
-		ext2_discard_prealloc(inode);
 }
 
 
 static struct super_operations ext2_sops = {
 	.alloc_inode	= ext2_alloc_inode,
 	.destroy_inode	= ext2_destroy_inode,
 	.read_inode	= ext2_read_inode,
 	.write_inode	= ext2_write_inode,
+	.put_inode	= ext2_put_inode,
 	.delete_inode	= ext2_delete_inode,
 	.put_super	= ext2_put_super,
 	.write_super	= ext2_write_super,

--CblX+4bnyfN0pR09--
