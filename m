Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJHXHp>; Tue, 8 Oct 2002 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJHXGK>; Tue, 8 Oct 2002 19:06:10 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:45833 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261384AbSJHXFT>;
	Tue, 8 Oct 2002 19:05:19 -0400
Date: Tue, 8 Oct 2002 16:07:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.41
Message-ID: <20021008230714.GD11247@kroah.com>
References: <20021008230506.GA11247@kroah.com> <20021008230553.GB11247@kroah.com> <20021008230644.GC11247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008230644.GC11247@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.706   -> 1.707  
#	          fs/inode.c	1.70    -> 1.71   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	chris@wirex.com	1.707
# [PATCH] LSM: move the inode_alloc_security hook.
# 
# This moves the inode_alloc_security() hook so that we have all of the
# inode information at the moment of the hook.
# --------------------------------------------
#
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Tue Oct  8 15:51:04 2002
+++ b/fs/inode.c	Tue Oct  8 15:51:04 2002
@@ -101,14 +101,6 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
-		inode->i_security = NULL;
-		if (security_ops->inode_alloc_security(inode)) {
-			if (inode->i_sb->s_op->destroy_inode)
-				inode->i_sb->s_op->destroy_inode(inode);
-			else
-				kmem_cache_free(inode_cachep, (inode));
-			return NULL;
-		}
 		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
@@ -127,6 +119,14 @@
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
+		inode->i_security = NULL;
+		if (security_ops->inode_alloc_security(inode)) {
+			if (inode->i_sb->s_op->destroy_inode)
+				inode->i_sb->s_op->destroy_inode(inode);
+			else
+				kmem_cache_free(inode_cachep, (inode));
+			return NULL;
+		}
 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
